package controllers

import (
	"fmt"
	db "gin/database"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type ArticleCategory struct{}

// GetArticleCategoryList handles GET /admin/article-category route
func (_ *ArticleCategory) Index(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var ArticleCategory []models.ArticleCategory
	db.Mysql.Find(&ArticleCategory)

	c.HTML(http.StatusOK, "article-category/index", gin.H{
		"title":           "文章分类",
		"articleCategory": ArticleCategory,
		"flash":           flash,
	})
}
