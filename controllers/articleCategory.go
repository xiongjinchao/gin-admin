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

	flash := (&Base{}).GetFlash(c)

	var ArticleCategory []models.ArticleCategory
	db.Mysql.Order("depth asc, sort asc").Find(&ArticleCategory)

	c.HTML(http.StatusOK, "article-category/index", gin.H{
		"title":           "文章分类",
		"articleCategory": ArticleCategory,
		"flash":           flash,
	})
}

// Datatable
func (_ *ArticleCategory) Data(c *gin.Context) {

	var articleCategory []models.ArticleCategory

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

	err := query.Scan(&articleCategory).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(articleCategory),
		"recordsFiltered": total,
		"data":            articleCategory,
	})
}
