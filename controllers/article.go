package controllers

import (
	"encoding/json"
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

func (_ *Article) Data(c *gin.Context) {

	var article []models.Article
	db.Mysql.Find(&article)

	type DataTable struct {
		draw            int64
		recordsTotal    int64
		recordsFiltered int64
		data            []models.Article
	}

	result := DataTable{
		draw:            1,
		recordsTotal:    100,
		recordsFiltered: 80,
		data:            article,
	}
	fmt.Println(result)
	data2, err := json.Marshal(result)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	fmt.Println(string(data2))
	c.JSON(http.StatusOK, gin.H{"status": http.StatusOK, "message": "ok", "data": result})
}
