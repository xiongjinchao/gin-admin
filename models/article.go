package models

type Article struct {
	Base            `json:"base"`
	Title           string          `json:"title" form:"title"`
	Cover           int64           `json:"cover" form:"cover"`
	CategoryID      int64           `json:"category_id" form:"category_id" gorm:"column:category_id"`
	Content         string          `json:"content" form:"content"`
	Audit           int64           `json:"audit" form:"audit"`
	Hot             int64           `json:"hot" form:"hot"`
	Recommend       int64           `json:"recommend" form:"recommend"`
	Hit             int64           `json:"hit" form:"hit"`
	UserID          int64           `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Author          string          `json:"author" form:"author"`
	Source          string          `json:"source" form:"source"`
	SourceUrl       string          `json:"source_url" form:"source_url"`
	SeoTitle        string          `json:"seo_title" form:"seo_title"`
	SeoDescription  string          `json:"seo_description" form:"seo_description"`
	SeoKeyword      string          `json:"seo_keyword" form:"seo_keyword"`
	ArticleCategory ArticleCategory `json:"article_category" validate:"-" gorm:"foreignKey:CategoryID;AssociationForeignKey:ID"`
	User            User            `json:"user" validate:"-" gorm:"foreignKey:UserID"`
	File            File            `json:"file" validate:"-" gorm:"foreignKey:Cover;AssociationForeignKey:ID"`
}

func (Article) TableName() string {
	return "article"
}
