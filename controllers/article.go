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

	flash := (&Base{}).GetFlash(c)

	c.HTML(http.StatusOK, "article/index", gin.H{
		"title": "文章管理",
		"flash": flash,
	})
}

// Datatable
func (_ *Article) Data(c *gin.Context) {

	var article []models.Article

	query := db.Mysql.Model(&models.Article{})

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
		query = query.Order("category_id " + sort)
	case "3":
		query = query.Order("article_id " + sort)
	case "4":
		query = query.Order("created_at " + sort)
	case "5":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	err := query.Scan(&article).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	for i, _ := range article {
		db.Mysql.Model(article[i]).Related(&article[i].ArticleCategory, "CategoryID")
		db.Mysql.Model(article[i]).Related(&article[i].User, "UserID")
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(article),
		"recordsFiltered": total,
		"data":            article,
	})
}

// Create handles GET /admin/article/create route
func (_ *Article) Create(c *gin.Context) {

	flash := (&Base{}).GetFlash(c)

	c.HTML(http.StatusOK, "article/create", gin.H{
		"title": "创建文章",
		"flash": flash,
	})
}

// Store handles POST /admin/article route
func (_ *Article) Store(c *gin.Context) {
	/*
		article := models.Article{
			Name:     c.PostForm("name"),
			Email:    c.PostForm("email"),
			Mobile:   c.PostForm("mobile"),
			Password: c.PostForm("password"),
		}
		article.Password = article.GeneratePassword(article.Password)

		if ok := (&Base{}).Validate(c, article); ok == false {
			c.Redirect(http.StatusFound, "//admin/article/create")
			return
		}

		err := db.Mysql.Create(&article).Error
		if err != nil {
			(&Base{}).SetFlash(c, "APP", err)
			c.Redirect(http.StatusFound, "/admin/article/create")
			return
		}
		id := string(article.ID)
		c.Redirect(http.StatusFound, "/admin/article/show/"+id)
	*/
}

func (_ *Article) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&Base{}).GetFlash(c)

	article := models.Article{}
	if err := db.Mysql.First(&article, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/edit", gin.H{
		"title":   "编辑文章",
		"article": article,
		"flash":   flash,
	})
}

func (_ *Article) Update(c *gin.Context) {

	/*
		id := c.Param("id")
		article := models.Article{
			Name:     c.PostForm("name"),
			Email:    c.PostForm("email"),
			Mobile:   c.PostForm("mobile"),
			Password: c.PostForm("password"),
		}
		err := db.Mysql.Where("id = ?", id).Updates(article).Error
		if err != nil {
			(&Base{}).SetFlash(c, "APP", err)
			c.Redirect(http.StatusFound, "/admin/article/edit"+id)
			return
		}
		c.Redirect(http.StatusFound, "/admin/article/show/"+id)
	*/

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
	err := db.Mysql.Where("id = ?", id).Delete(&article).Error
	if err == nil {
		c.Redirect(301, "/admin/article")
	}
}
