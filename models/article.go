package models

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"github.com/gin-gonic/gin"
	"strconv"
)

type Article struct {
	Base            `json:"base"`
	Title           string          `json:"title" form:"title"`
	Cover           int64           `json:"cover" form:"cover"`
	CategoryID      int64           `json:"category_id" form:"category_id" gorm:"column:category_id"`
	Summary         string          `json:"summary" form:"summary"`
	Content         string          `json:"content" form:"content"`
	Audit           int64           `json:"audit" form:"audit"`
	Hot             int64           `json:"hot" form:"hot"`
	Recommend       int64           `json:"recommend" form:"recommend"`
	Hit             int64           `json:"hit" form:"hit"`
	Favorite        int64           `json:"favorite" form:"favorite"`
	Comment         int64           `json:"comment" form:"comment"`
	UserID          int64           `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Author          string          `json:"author" form:"author"`
	Source          string          `json:"source" form:"source"`
	SourceUrl       string          `json:"source_url" form:"source_url"`
	Keyword         string          `json:"keyword" form:"keyword"`
	ArticleCategory ArticleCategory `json:"article_category" validate:"-" gorm:"foreignKey:CategoryID;AssociationForeignKey:ID"`
	User            User            `json:"user" validate:"-" gorm:"foreignKey:UserID"`
	File            File            `json:"file" validate:"-" gorm:"foreignKey:Cover;AssociationForeignKey:ID"`
	Tags            []Tag           `json:"tags" form:"-"`
}

func (Article) TableName() string {
	return "article"
}

// set tags data to article
func (a *Article) SetTags(articles *[]Article) {

	for i, v := range *articles {
		if err := db.Mysql.Model(&Tag{}).Select("id,tag").Where("model = ? and model_id = ?", "article", v.ID).Find(&(*articles)[i].Tags).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			v.Tags = nil
		}
	}
}

// get the newest article from cache
func (a *Article) GetNewNote() (articles []Article, err error) {

	data, err := db.Redis.Get("new-note").Result()
	if data == "" || err != nil {
		return a.SetNewNote()
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return a.SetNewNote()
	}

	return
}

// cache the newest article in redis
func (a *Article) SetNewNote() (articles []Article, err error) {

	if err := db.Mysql.Model(Article{}).
		Select("id,title,created_at").
		Where("audit = 1 and category_id in (3,4,5,6,7)").
		Order("id desc").
		Limit(8).
		Find(&articles).Error; err != nil {
		return articles, err
	}

	if len(articles) == 0 {
		return
	}

	article, err := json.Marshal(articles)
	if err != nil {
		return
	}

	db.Redis.Set("new-note", string(article), 600*1000000000)
	return
}

// get the newest article from cache
func (a *Article) GetNewArticle() (articles []Article, err error) {

	data, err := db.Redis.Get("new-article").Result()
	if data == "" || err != nil {
		return a.SetNewArticle()
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return a.SetNewArticle()
	}

	return
}

// cache the newest article in redis
func (a *Article) SetNewArticle() (articles []Article, err error) {

	if err := db.Mysql.Model(Article{}).
		Select("id,title,created_at").
		Where("audit = 1 and category_id in (8,9)").
		Order("id desc").
		Limit(8).
		Find(&articles).Error; err != nil {
		return articles, err
	}

	if len(articles) == 0 {
		return
	}

	article, err := json.Marshal(articles)
	if err != nil {
		return
	}

	db.Redis.Set("new-article", string(article), 600*1000000000)
	return
}

// get the related article from cache
func (a *Article) GetRelatedArticle(ID, categoryID int64) (articles []Article, err error) {
	data, err := db.Redis.Get("related-article" + strconv.FormatInt(categoryID, 10)).Result()
	if data == "" || err != nil {
		return a.SetRelatedArticle(ID, categoryID)
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return a.SetRelatedArticle(ID, categoryID)
	}

	return
}

// cache the related article in redis
func (a *Article) SetRelatedArticle(ID, categoryID int64) (articles []Article, err error) {

	if err := db.Mysql.Model(Article{}).
		Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ? and ID != ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").
		Limit(8).
		Find(&articles).Error; err != nil {
		return articles, err
	}

	if len(articles) == 0 {
		return
	}
	a.SetTags(&articles)

	article, err := json.Marshal(articles)
	if err != nil {
		return
	}

	db.Redis.Set("related-article"+strconv.FormatInt(categoryID, 10), string(article), 600*1000000000)
	return
}
