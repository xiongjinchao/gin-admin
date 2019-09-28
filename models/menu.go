package models

import (
	"fmt"
	db "gin-blog/database"
	"github.com/gin-gonic/gin"
	"strconv"
	"strings"
)

type Menu struct {
	Base           `json:"base"`
	Name           string   `json:"name" form:"name"`
	Tag            string   `json:"tag" form:"tag"`
	Parent         int64    `json:"parent" form:"parent"`
	Level          int64    `json:"level" form:"-"`
	Audit          int64    `json:"audit" form:"audit"`
	Sort           int64    `json:"sort" form:"sort"`
	SeoTitle       string   `json:"seo_title" form:"seo_title"`
	SeoDescription string   `json:"seo_description" form:"seo_description"`
	SeoKeyword     string   `json:"seo_keyword" form:"seo_keyword"`
	Parents        []string `json:"parents" validate:"-"`
	Space          string   `json:"space" validate:"-"`
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

func (m *Menu) SetSpace(data *[]Menu) {

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

		// set all parent
		m.SetParents(data, v.Parent, &((*data)[i].Parents))
	}
	return
}

func (m *Menu) SetParents(data *[]Menu, parent int64, parents *[]string) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, v.Name)
			m.SetParents(data, v.Parent, parents)
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
