package models

import (
	"encoding/json"
	db "gin-admin/database"
	"strconv"
	"strings"
)

type BookCategory struct {
	Base     `json:"base"`
	Name     string     `json:"name" form:"name"`
	Summary  string     `json:"summary" form:"summary"`
	Parent   int64      `json:"parent" form:"parent"`
	Level    int64      `json:"level" form:"-"`
	Audit    int64      `json:"audit" form:"audit"`
	Sort     int64      `json:"sort" form:"sort"`
	Father   Category   `json:"father" form:"-" gorm:"-"`
	Parents  []Category `json:"parents" validate:"-" gorm:"-"`
	Space    string     `json:"space" validate:"-" gorm:"-"`
	Children []Category `json:"children" form:"-" gorm:"-"`
}

func (BookCategory) TableName() string {
	return "book_category"
}

func (b *BookCategory) SetSort(data *[]BookCategory, parent int64, result *[]BookCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			b.SetSort(data, v.ID, result)
		}
	}
}

func (b *BookCategory) SetData(data *[]BookCategory) {

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
			b.SetFather(data, v.Parent, &((*data)[i].Father))
			// set all parents
			b.SetParents(data, v.Parent, &((*data)[i].Parents))
		}
		// set all children
		b.SetChildren(data, v.ID, &((*data)[i].Children))
	}
	return
}

func (b *BookCategory) SetFather(data *[]BookCategory, parent int64, father *Category) {
	for _, v := range *data {
		if v.ID == parent {
			*father = Category{v.ID, v.Name, "", ""}
			break
		}
	}
}

func (b *BookCategory) SetParents(data *[]BookCategory, parent int64, parents *[]Category) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, Category{v.ID, v.Name, "", ""})
			b.SetParents(data, v.Parent, parents)
		}
	}
}

func (b *BookCategory) SetChildren(data *[]BookCategory, id int64, children *[]Category) {
	for _, v := range *data {
		if v.Parent == id {
			*children = append(*children, Category{v.ID, v.Name, "", ""})
			b.SetChildren(data, v.ID, children)
		}
	}
}

func (b *BookCategory) UpdateChildrenLevel(data *[]BookCategory, parent BookCategory) {
	for _, v := range *data {
		if v.Parent == parent.ID {
			v.Level = parent.Level + 1
			db.Mysql.Model(BookCategory{}).Save(&v)

			b.UpdateChildrenLevel(data, v)
		}
	}
}

func (b *BookCategory) UpdateChildren() (err error) {

	var bookCategories []BookCategory
	err = db.Mysql.Model(BookCategory{}).Find(&bookCategories).Error
	if err != nil {
		return
	}
	b.UpdateChildrenLevel(&bookCategories, *b)
	return
}

// cache book-category data in redis
func (b *BookCategory) SetCache() error {

	var bookCategories, data []BookCategory
	if err := db.Mysql.Model(BookCategory{}).Where("audit = 1").Find(&bookCategories).Error; err != nil {
		return err
	}
	if len(bookCategories) == 0 {
		return nil
	}

	b.SetSort(&bookCategories, 0, &data)
	b.SetData(&data)

	bookCategory, err := json.Marshal(data)
	if err != nil {
		return err
	}

	db.Redis.Set("book-category", string(bookCategory), 0)

	return nil
}

// get book-category data from cache
func (b *BookCategory) GetCache() (bookCategory []BookCategory, err error) {

	data, err := db.Redis.Get("book-category").Result()
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal([]byte(data), &bookCategory); err != nil {
		return nil, err
	}

	return
}
