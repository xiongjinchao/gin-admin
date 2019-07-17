package models

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
