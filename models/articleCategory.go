package models

import (
	"strconv"
	"strings"
)

type ArticleCategory struct {
	Base           `json:"base"`
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

func (a *ArticleCategory) Sortable(data *[]ArticleCategory, parent int64, result *[]ArticleCategory) {
	for _, v := range *data {
		if v.Parent == parent {
			*result = append(*result, v)
			a.Sortable(data, v.ID, result)
		}
	}
}

func (a *ArticleCategory) SetSpace(data []ArticleCategory) (result []map[string]interface{}) {

	for i, v := range data {
		item := a.Convert2Map(v)
		space := ""
		if i == 0 {
			space += "┣ "
		} else {
			if v.Level > 1 {
				space += "┃ "
			}
			if v.Level > 2 {
				r, _ := strconv.Atoi(strconv.FormatInt(v.Level-2, 10))
				space += strings.Repeat(" ━ ", r)
			}

			if i < len(data)-1 && v.Level == data[i+1].Level {
				space += "┣ "
			} else {
				space += "┗ "
			}
		}
		item["space"] = space

		// set all parent
		var parents []map[string]interface{}
		a.SetParents(&data, v.Parent, &parents)
		item["parents"] = parents

		result = append(result, item)
	}
	return
}

func (a *ArticleCategory) SetParents(data *[]ArticleCategory, parent int64, parents *[]map[string]interface{}) {
	for _, v := range *data {
		item := a.Convert2Map(v)
		if v.ID == parent {
			*parents = append(*parents, item)
			a.SetParents(data, v.Parent, parents)
		}
	}
}
