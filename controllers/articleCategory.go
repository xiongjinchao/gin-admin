package controllers

import (
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type ArticleCategory struct{}

// GetArticleCategoryList handles GET /admin/article-category route
func (_ *ArticleCategory) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "article-category/index", gin.H{
		"title": "文章分类",
		"flash": flash,
	})
}

// Datatable
func (_ *ArticleCategory) Data(c *gin.Context) {

	var articleCategory, result []models.ArticleCategory

	query := db.Mysql.Model(&models.ArticleCategory{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&articleCategory).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	(&models.ArticleCategory{}).Sortable(&articleCategory, 0, &result)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(articleCategory),
		"recordsFiltered": total,
		"data":            result,
	})
}
