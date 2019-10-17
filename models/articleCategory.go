package models

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"github.com/gin-gonic/gin"
	"strconv"
	"strings"
)

type ArticleCategory struct {
	Base     `json:"base"`
	Name     string     `json:"name" form:"name"`
	Tag      string     `json:"tag" form:"tag"`
	Summary  string     `json:"summary" form:"summary"`
	Parent   int64      `json:"parent" form:"parent"`
	Level    int64      `json:"level" form:"-"`
	Audit    int64      `json:"audit" form:"audit"`
	Sort     int64      `json:"sort" form:"sort"`
	Keyword  string     `json:"keyword" form:"keyword"`
	Father   Category   `json:"father" form:"-"`
	Parents  []Category `json:"parents" validate:"-"`
	Space    string     `json:"space" validate:"-"`
	Children []Category `json:"children" form:"-"`
}

func (ArticleCategory) TableName() string {
	return "article_category"
}

func (a *ArticleCategory) SetSort(data *[]ArticleCategory, parent int64, result *[]ArticleCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			a.SetSort(data, v.ID, result)
		}
	}
}

func (a *ArticleCategory) SetData(data *[]ArticleCategory) {

	for i, v := range *data {
		if i == 0 {
			(*data)[i].Space += "┣ "
		} else {
			if v.Level > 1 {
				(*data)[i].Space += "┃ "
			}
			if v.Level > 2 {
				r, _ := strconv.Atoi(strconv.FormatInt(v.Level-2, 10))
				(*data)[i].Space += strings.Repeat(" ━ ", r)
			}

			if i < len(*data)-1 && v.Level == (*data)[i+1].Level {
				(*data)[i].Space += "┣ "
			} else {
				(*data)[i].Space += "┗ "
			}
		}

		if v.Parent > 0 {
			// set father
			a.SetFather(data, v.Parent, &((*data)[i].Father))
			// set all parents
			a.SetParents(data, v.Parent, &((*data)[i].Parents))
		}
		// set all children
		a.SetChildren(data, v.ID, &((*data)[i].Children))
	}
	return
}

func (a *ArticleCategory) SetFather(data *[]ArticleCategory, parent int64, father *Category) {
	for _, v := range *data {
		if v.ID == parent {
			*father = Category{v.ID, v.Name, ""}
			break
		}
	}
}

func (a *ArticleCategory) SetParents(data *[]ArticleCategory, parent int64, parents *[]Category) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, Category{v.ID, v.Name, ""})
			a.SetParents(data, v.Parent, parents)
		}
	}
}

func (a *ArticleCategory) SetChildren(data *[]ArticleCategory, id int64, children *[]Category) {
	for _, v := range *data {
		if v.Parent == id {
			*children = append(*children, Category{v.ID, v.Name, ""})
			a.SetChildren(data, v.ID, children)
		}
	}
}

func (a *ArticleCategory) UpdateChildrenLevel(data *[]ArticleCategory, parent ArticleCategory) {
	for _, v := range *data {
		if v.Parent == parent.ID {
			v.Level = parent.Level + 1
			db.Mysql.Model(ArticleCategory{}).Omit("Parents", "Space").Save(&v)

			a.UpdateChildrenLevel(data, v)
		}
	}
}

func (a *ArticleCategory) UpdateChildren(parent ArticleCategory) {

	var articleCategories []ArticleCategory
	if err := db.Mysql.Model(ArticleCategory{}).Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	a.UpdateChildrenLevel(&articleCategories, parent)
}

// cache article-category data in redis
func (a *ArticleCategory) SetCache() error {

	var articleCategories, data []ArticleCategory
	if err := db.Mysql.Model(ArticleCategory{}).Where("audit = 1").Find(&articleCategories).Error; err != nil {
		return err
	}
	if len(articleCategories) == 0 {
		return nil
	}

	a.SetSort(&articleCategories, 0, &data)
	a.SetData(&data)

	articleCategory, err := json.Marshal(data)
	if err != nil {
		return err
	}

	db.Redis.Set("article-category", string(articleCategory), 0)

	return nil
}

// get article-category data from cache
func (a *ArticleCategory) GetCache() (articleCategory []ArticleCategory, err error) {

	data, err := db.Redis.Get("article-category").Result()
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal([]byte(data), &articleCategory); err != nil {
		return nil, err
	}

	return
}
