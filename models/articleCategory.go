package models

import (
	"gin/helper"
	"strings"
)

type ArticleCategory struct {
	Base
	Name           string `json:"name" form:"name"`
	Tag            string `json:"tag" form:"tag"`
	Parent         int64  `json:"parent" form:"parent"`
	Level          int64  `json:"level" form:"-"`
	Audit          int64  `json:"audit" form:"audit"`
	Sort           int64  `json:"sort" form:"sort"`
	SeoTitle       string `json:"seo_title" form:"seo_title"`
	SeoDescription string `json:"seo_description" form:"seo_description"`
	SeoKeyword     string `json:"seo_keyword" form:"seo_keyword"`
}

func (ArticleCategory) TableName() string {
	return "article_category"
}

func (m *ArticleCategory) Sortable(data *[]ArticleCategory, parent int64, result *[]ArticleCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			m.Sortable(data, v.ID, result)
		}
	}
}

func (m *ArticleCategory) SetSpace(data []ArticleCategory) (result []map[string]interface{}) {

	for i, v := range data {
		item := (&helper.Convert{}).Str2Map(v)
		space := ""
		if i == 0 {
			space += "┣ "
		} else {
			space += strings.Repeat("┃ ", (&helper.Convert{}).Int642Int(v.Level-1))
			if i < len(data)-1 && v.Level == data[i+1].Level {
				space += "┣ "
			} else {
				space += "┗ "
			}
		}
		item["space"] = space

		// set all parent
		var parents []map[string]interface{}
		m.SetParents(&data, v.Parent, &parents)
		item["parents"] = parents

		result = append(result, item)
	}
	return
}

func (m *ArticleCategory) SetParents(data *[]ArticleCategory, parent int64, parents *[]map[string]interface{}) {
	for _, v := range *data {
		item := (&helper.Convert{}).Str2Map(v)
		if v.ID == parent {
			*parents = append(*parents, item)
			m.SetParents(data, v.Parent, parents)
		}
	}
}
