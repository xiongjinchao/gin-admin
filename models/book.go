package models

type Book struct {
	Base           `json:"base"`
	Name           string `json:"name" form:"name"`
	Catalogue      string `json:"catalogue" form:"catalogue"`
	Tag            string `json:"tag" form:"tag"`
	Audit          int64  `json:"audit" form:"audit"`
	Hit            int64  `json:"hit" form:"hit"`
	Favorite       int64  `json:"favorite" form:"favorite"`
	Comment        int64  `json:"comment" form:"comment"`
	SeoTitle       string `json:"seo_title" form:"seo_title"`
	SeoDescription string `json:"seo_description" form:"seo_description"`
	SeoKeyword     string `json:"seo_keyword" form:"seo_keyword"`
}

func (Book) TableName() string {
	return "book"
}
