package models

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"github.com/gin-gonic/gin"
	"strconv"
	"strings"
)

type FriendLinkCategory struct {
	Base     `json:"base"`
	Name     string     `json:"name" form:"name"`
	Summary  string     `json:"summary" form:"summary"`
	Parent   int64      `json:"parent" form:"parent"`
	Level    int64      `json:"level" form:"-"`
	Audit    int64      `json:"audit" form:"audit"`
	Sort     int64      `json:"sort" form:"sort"`
	Father   Category   `json:"father" form:"-"`
	Parents  []Category `json:"parents" validate:"-"`
	Space    string     `json:"space" validate:"-"`
	Children []Category `json:"children" form:"-"`
}

func (FriendLinkCategory) TableName() string {
	return "friend_link_category"
}

func (f *FriendLinkCategory) SetSort(data *[]FriendLinkCategory, parent int64, result *[]FriendLinkCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			f.SetSort(data, v.ID, result)
		}
	}
}

func (f *FriendLinkCategory) SetData(data *[]FriendLinkCategory) {

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
			f.SetFather(data, v.Parent, &((*data)[i].Father))
			// set all parents
			f.SetParents(data, v.Parent, &((*data)[i].Parents))
		}
		// set all children
		f.SetChildren(data, v.ID, &((*data)[i].Children))
	}
	return
}

func (f *FriendLinkCategory) SetFather(data *[]FriendLinkCategory, parent int64, father *Category) {
	for _, v := range *data {
		if v.ID == parent {
			*father = Category{v.ID, v.Name, ""}
			break
		}
	}
}

func (f *FriendLinkCategory) SetParents(data *[]FriendLinkCategory, parent int64, parents *[]Category) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, Category{v.ID, v.Name, ""})
			f.SetParents(data, v.Parent, parents)
		}
	}
}

func (f *FriendLinkCategory) SetChildren(data *[]FriendLinkCategory, id int64, children *[]Category) {
	for _, v := range *data {
		if v.Parent == id {
			*children = append(*children, Category{v.ID, v.Name, ""})
			f.SetChildren(data, v.ID, children)
		}
	}
}

func (f *FriendLinkCategory) UpdateChildrenLevel(data *[]FriendLinkCategory, parent FriendLinkCategory) {
	for _, v := range *data {
		if v.Parent == parent.ID {
			v.Level = parent.Level + 1
			db.Mysql.Model(FriendLinkCategory{}).Omit("Parents", "Space").Save(&v)

			f.UpdateChildrenLevel(data, v)
		}
	}
}

func (f *FriendLinkCategory) UpdateChildren(parent FriendLinkCategory) {

	var articleCategories []FriendLinkCategory
	if err := db.Mysql.Model(FriendLinkCategory{}).Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	f.UpdateChildrenLevel(&articleCategories, parent)
}

// cache friend-link-category data in redis
func (f *FriendLinkCategory) SetCache() error {

	var friendLinkCategories, data []FriendLinkCategory
	if err := db.Mysql.Model(FriendLinkCategory{}).Where("status = 1").Find(&friendLinkCategories).Error; err != nil {
		return err
	}
	if len(friendLinkCategories) == 0 {
		return nil
	}

	f.SetSort(&friendLinkCategories, 0, &data)
	f.SetData(&data)

	friendLinkCategory, err := json.Marshal(data)
	if err != nil {
		return err
	}

	db.Redis.Set("friend-link-category", string(friendLinkCategory), 0)

	return nil
}

// get friend-link-category data from cache
func (f *FriendLinkCategory) GetCache() (friendLinkCategory []FriendLinkCategory, err error) {

	data, err := db.Redis.Get("friend-link-category").Result()
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal([]byte(data), &friendLinkCategory); err != nil {
		return nil, err
	}

	return
}
