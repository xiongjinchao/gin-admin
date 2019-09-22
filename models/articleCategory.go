package models

import (
	"strconv"
	"strings"
)

type ArticleCategory struct {
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

func (a *ArticleCategory) SetSpace(data *[]ArticleCategory) {

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

func (a *ArticleCategory) SetParents(data *[]ArticleCategory, parent int64, parents *[]string) {
	for _, v := range *data {
		if v.ID == parent {
			*parents = append(*parents, v.Name)
			a.SetParents(data, v.Parent, parents)
		}
	}
}
