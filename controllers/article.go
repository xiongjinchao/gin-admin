package controllers

import (
	"fmt"
	db "gin/database"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"reflect"
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

	var article []struct {
		ID         int    `json:"id"`
		Title      string `json:"title"`
		CategoryID int    `json:"category_id"`
		UserID     int    `json:"user_id"`
		CreatedAt  string `json:"created_at"`
		UpdatedAt  string `json:"updated_at"`
	}
	db.Mysql.Table("article").Limit(10).Scan(&article)

	total := 0
	db.Mysql.Model(&models.Article{}).Count(&total)

	result := make(map[string]interface{})
	result["draw"] = 1
	result["recordsTotal"] = total
	result["recordsFiltered"] = len(article)

	data := make([]map[string]interface{}, 0)
	for _, v := range article {
		typ := reflect.TypeOf(v)
		val := reflect.ValueOf(v)
		item := make(map[string]interface{})
		for i := 0; i < typ.NumField(); i++ {
			item[typ.Field(i).Tag.Get("json")] = val.Field(i).Interface()
		}
		data = append(data, item)
	}
	result["data"] = data
	c.JSON(http.StatusOK, result)
}
