package models

import (
	"fmt"
	db "gin-admin/database"
	"github.com/gin-gonic/gin"
	"strconv"
	"strings"
)

type FriendLinkCategory struct {
	Base    `json:"base"`
	Name    string   `json:"name" form:"name"`
	Tag     string   `json:"tag" form:"tag"`
	Parent  int64    `json:"parent" form:"parent"`
	Level   int64    `json:"level" form:"-"`
	Audit   int64    `json:"audit" form:"audit"`
	Sort    int64    `json:"sort" form:"sort"`
	Parents []string `json:"parents" validate:"-"`
	Space   string   `json:"space" validate:"-"`
}

func (FriendLinkCategory) TableName() string {
	return "friend_link_category"
}

func (a *FriendLinkCategory) SetSort(data *[]FriendLinkCategory, parent int64, result *[]FriendLinkCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			a.SetSort(data, v.ID, result)
		}
	}
}

func (a *FriendLinkCategory) SetSpace(data *[]FriendLinkCategory) {

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
		a.SetParents(data, v.Parent, &((*data)[i].Parents))
	}
	return
}

func (a *FriendLinkCategory) SetParents(data *[]FriendLinkCategory, parent int64, parents *[]string) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, v.Name)
			a.SetParents(data, v.Parent, parents)
		}
	}
}

func (a *FriendLinkCategory) UpdateChildrenLevel(data *[]FriendLinkCategory, parent FriendLinkCategory) {
	for _, v := range *data {
		if v.Parent == parent.ID {
			v.Level = parent.Level + 1
			db.Mysql.Model(FriendLinkCategory{}).Omit("Parents", "Space").Save(&v)

			a.UpdateChildrenLevel(data, v)
		}
	}
}

func (a *FriendLinkCategory) UpdateChildren(parent FriendLinkCategory) {

	var articleCategories []FriendLinkCategory
	if err := db.Mysql.Model(FriendLinkCategory{}).Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	a.UpdateChildrenLevel(&articleCategories, parent)
}
