package controllers

import (
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Article struct{}

// GetArticleList handles GET /admin/article route
func (_ *Article) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "article/index", gin.H{
		"title": "文章管理",
		"flash": flash,
	})
}

// Datatable
func (_ *Article) Data(c *gin.Context) {
	var article []models.Article

	query := db.Mysql.Model(&models.Article{}).Preload("ArticleCategory").Preload("User")

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("title LIKE ?", "%"+search+"%").
			Or("content LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)

	order := c.Query("order[0][column]")
	sort := c.Query("order[0][dir]")
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	switch order {
	case "1":
		query = query.Order("title " + sort)
	case "2":
		query = query.Order("article_category_id " + sort)
	case "3":
		query = query.Order("user_id " + sort)
	case "4":
		query = query.Order("created_at " + sort)
	case "5":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	// find() will return data sorted by column name, but scan() return data with struct column order. scan() doesn't support Preload
	err := query.Find(&article).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	/*
		for i, _ := range article {
			db.Mysql.Model(article[i]).Related(&article[i].ArticleCategory)
			db.Mysql.Model(article[i]).Related(&article[i].User)
		}
	*/

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(article),
		"recordsFiltered": total,
		"data":            article,
	})
}

// Create handles GET /admin/article/create route
func (_ *Article) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	var articleCategory []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Find(&articleCategory).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var user []models.User
	if err := db.Mysql.Model(&models.User{}).Find(&user).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/create", gin.H{
		"title":           "创建文章",
		"flash":           flash,
		"articleCategory": articleCategory,
		"user":            user,
	})
}

// Store handles POST /admin/article route
func (_ *Article) Store(c *gin.Context) {

	article := models.Article{}
	err := c.ShouldBind(&article)
	if old, err := (&helper.Convert{}).Str2Json(article); err == nil {
		(&helper.Flash{}).SetFlash(c, old, "old")
	}

	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(article); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	if err := db.Mysql.Create(&article).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	(&helper.Flash{}).SetFlash(c, "创建文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}

func (_ *Article) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&helper.Flash{}).GetFlash(c)

	article := models.Article{}
	if err := db.Mysql.First(&article, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var articleCategory []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Find(&articleCategory).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var user []models.User
	if err := db.Mysql.Model(&models.User{}).Find(&user).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/edit", gin.H{
		"title":           "编辑文章",
		"flash":           flash,
		"article":         article,
		"articleCategory": articleCategory,
		"user":            user,
	})
}

func (_ *Article) Update(c *gin.Context) {

	id := c.Param("id")
	article := models.Article{}
	if err := c.ShouldBind(&article); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}
	fmt.Println(article)

	if err := (&helper.Validate{}).ValidateStr(article); err != nil {
		fmt.Println("validate error")
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}

	if err := db.Mysql.Model(&models.Article{}).Where("id = ?", id).Updates(article).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}
	(&helper.Flash{}).SetFlash(c, "修改文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}

func (_ *Article) Show(c *gin.Context) {
	id := c.Param("id")

	article := models.Article{}
	if err := db.Mysql.First(&article, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/show", gin.H{
		"title":   "查看文章",
		"article": article,
	})
}

func (_ *Article) Destroy(c *gin.Context) {
	id := c.Param("id")

	article := models.Article{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&article).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
	}

	(&helper.Flash{}).SetFlash(c, "删除文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}
