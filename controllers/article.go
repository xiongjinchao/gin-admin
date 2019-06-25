package controllers

import (
	"fmt"
	db "gin/database"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Article struct{}

// GetArticleList handles GET /admin/article route
func (_ *Article) Index(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var article []models.Article
	db.Mysql.Find(&article)

	c.HTML(http.StatusOK, "article/index", gin.H{
		"title":   "文章管理",
		"article": article,
		"flash":   flash,
	})
}
