package admin

import (
	"encoding/json"
	"fmt"
	"gin-admin/config"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

type Article struct{}

// GetArticleList handles GET /admin/article route
func (a *Article) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "article/index", gin.H{
		"title": "文章管理",
		"flash": flash,
		"image": config.Setting["domain"]["image"],
	})
}

// Datatable
func (a *Article) Data(c *gin.Context) {
	var article []models.Article

	query := db.Mysql.Model(&models.Article{}).Preload("ArticleCategory").Preload("User").Preload("File")

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
		query = query.Order("cover " + sort)
	case "2":
		query = query.Order("title " + sort)
	case "3":
		query = query.Order("category_id " + sort)
	case "4":
		query = query.Order("user_id " + sort)
	case "5":
		query = query.Order("audit " + sort)
	default:
		query = query.Order("id " + sort)
	}

	// find() will return data sorted by column name, but scan() return data with struct column order. scan() doesn't support Preload
	err := query.Find(&article).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(article),
		"recordsFiltered": total,
		"data":            article,
	})
}

// Create handles GET /admin/article/create route
func (a *Article) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &data)
	(&models.ArticleCategory{}).SetData(&data)

	var user []models.User
	if err := db.Mysql.Model(&models.User{}).Find(&user).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/create", gin.H{
		"title":             "创建文章",
		"flash":             flash,
		"articleCategories": data,
		"user":              user,
	})
}

// Store handles POST /admin/article route
func (a *Article) Store(c *gin.Context) {

	article := models.Article{}
	err := c.ShouldBind(&article)
	if old, err := json.Marshal(article); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	if err := helper.ValidateStruct(article); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	if err := db.Mysql.Omit("ArticleCategory", "User", "File").Create(&article).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	// update() article tag
	if err := (&models.Tag{}).Upgrade(c.PostForm("tags"), article.TableName(), article.ID); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/create")
		return
	}

	helper.SetFlash(c, "创建文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}

func (a *Article) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	article := models.Article{}
	if err := db.Mysql.Preload("File").First(&article, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var previewConfig []map[string]interface{}
	var preview []string
	var initialPreview, initialPreviewConfig []byte
	var err error

	if article.Cover > 0 {
		image := config.Setting["domain"]["image"]
		preview = append(preview, image+article.File.Path)

		item := make(map[string]interface{})
		item["caption"] = article.File.Name
		item["size"] = article.File.Size
		item["url"] = "/admin/file/delete"
		item["key"] = article.File.ID
		previewConfig = append(previewConfig, item)

		initialPreview, err = json.Marshal(preview)
		if err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}

		initialPreviewConfig, err = json.Marshal(previewConfig)
		if err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
	}

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &data)
	(&models.ArticleCategory{}).SetData(&data)

	var user []models.User
	if err := db.Mysql.Model(&models.User{}).Find(&user).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	tags, err := (&models.Tag{}).GetTags(article.TableName(), article.ID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article/edit", gin.H{
		"title":                "编辑文章",
		"flash":                flash,
		"article":              article,
		"articleCategories":    data,
		"user":                 user,
		"initialPreview":       string(initialPreview),
		"initialPreviewConfig": string(initialPreviewConfig),
		"tags":                 strings.Join(tags, ","),
	})
}

func (a *Article) Update(c *gin.Context) {

	id := c.Param("id")
	article := models.Article{}
	if err := c.ShouldBind(&article); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}
	article.ID = ID

	if err := helper.ValidateStruct(article); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.Article{}).Omit("ArticleCategory", "User", "File").Save(&article).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}

	// update() article tag
	if err := (&models.Tag{}).Upgrade(c.PostForm("tags"), article.TableName(), article.ID); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}

func (a *Article) Show(c *gin.Context) {
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

func (a *Article) Destroy(c *gin.Context) {
	id := c.Param("id")

	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&models.Article{}).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/article")
}
