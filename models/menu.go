package models

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"github.com/gin-gonic/gin"
	"strconv"
	"strings"
)

type Menu struct {
	Base     `json:"base"`
	Name     string     `json:"name" form:"name"`
	Tag      string     `json:"tag" form:"tag"`
	Icon     string     `json:"icon" form:"icon"`
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

func (Menu) TableName() string {
	return "menu"
}

func (m *Menu) SetSort(data *[]Menu, parent int64, result *[]Menu) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			m.SetSort(data, v.ID, result)
		}
	}
}

func (m *Menu) SetData(data *[]Menu) {

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
			m.SetFather(data, v.Parent, &((*data)[i].Father))
			// set all parents
			m.SetParents(data, v.Parent, &((*data)[i].Parents))
		}
		// set all children
		m.SetChildren(data, v.ID, &((*data)[i].Children))
	}
	return
}

func (m *Menu) SetFather(data *[]Menu, parent int64, father *Category) {
	for _, v := range *data {
		if v.ID == parent {
			*father = Category{v.ID, v.Name, v.Tag, v.Icon}
			break
		}
	}
}

func (m *Menu) SetParents(data *[]Menu, parent int64, parents *[]Category) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, Category{v.ID, v.Name, v.Tag, v.Icon})
			m.SetParents(data, v.Parent, parents)
		}
	}
}

func (m *Menu) SetChildren(data *[]Menu, id int64, children *[]Category) {
	for _, v := range *data {
		if v.Parent == id {
			*children = append(*children, Category{v.ID, v.Name, v.Tag, v.Icon})
			m.SetChildren(data, v.ID, children)
		}
	}
}

func (m *Menu) UpdateChildrenLevel(data *[]Menu, parent Menu) {
	for _, v := range *data {
		if v.Parent == parent.ID {
			v.Level = parent.Level + 1
			db.Mysql.Model(Menu{}).Omit("Parents", "Space").Save(&v)

			m.UpdateChildrenLevel(data, v)
		}
	}
}

func (m *Menu) UpdateChildren(parent Menu) {

	var menus []Menu
	if err := db.Mysql.Model(Menu{}).Find(&menus).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	m.UpdateChildrenLevel(&menus, parent)
}

// cache menu data in redis
func (m *Menu) SetCache() error {

	var menus, data []Menu
	if err := db.Mysql.Model(Menu{}).Where("audit = 1").Find(&menus).Error; err != nil {
		return err
	}
	if len(menus) == 0 {
		return nil
	}

	m.SetSort(&menus, 0, &data)
	m.SetData(&data)

	menu, err := json.Marshal(data)
	if err != nil {
		return err
	}

	db.Redis.Set("menu", string(menu), 0)

	return nil
}

// get menu data from cache
func (m *Menu) GetCache() (menu []Menu, err error) {

	data, err := db.Redis.Get("menu").Result()
	if err != nil {
		return nil, err
	}

	if err := json.Unmarshal([]byte(data), &menu); err != nil {
		return nil, err
	}

	return
}
