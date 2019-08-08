package admin

import (
	"encoding/json"
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type ArticleCategory struct{}

// GetArticleCategoryList handles GET /admin/article-category route
func (a *ArticleCategory) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "article-category/index", gin.H{
		"title": "文章分类",
		"flash": flash,
	})
}

// Datatable
func (a *ArticleCategory) Data(c *gin.Context) {

	var articleCategory, data []models.ArticleCategory

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

	(&models.ArticleCategory{}).Sortable(&articleCategory, 0, &data)
	categories := (&models.ArticleCategory{}).SetSpace(data)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(articleCategory),
		"recordsFiltered": total,
		"data":            categories,
	})
}

// Create handles GET /admin/article-category/create route
func (a *ArticleCategory) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).Sortable(&articleCategories, 0, &data)
	categories := (&models.ArticleCategory{}).SetSpace(data)

	c.HTML(http.StatusOK, "article-category/create", gin.H{
		"title":             "创建文章分类",
		"flash":             flash,
		"articleCategories": categories,
	})
}

// Store handles POST /admin/article-category route
func (a *ArticleCategory) Store(c *gin.Context) {
	articleCategory := models.ArticleCategory{}
	err := c.ShouldBind(&articleCategory)
	if old, err := json.Marshal(articleCategory); err == nil {
		(&helper.Flash{}).SetFlash(c, string(old), "old")
	}

	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(articleCategory); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	articleCategory.Level = 1
	if articleCategory.Parent > 0 {
		parent := models.ArticleCategory{}
		db.Mysql.First(&parent, articleCategory.Parent)
		articleCategory.Level = parent.Level + 1
	}

	if err := db.Mysql.Create(&articleCategory).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	(&helper.Flash{}).SetFlash(c, "创建文章分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/article-category")
}

func (a *ArticleCategory) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&helper.Flash{}).GetFlash(c)

	articleCategory := models.ArticleCategory{}
	if err := db.Mysql.First(&articleCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).Sortable(&articleCategories, 0, &data)
	categories := (&models.ArticleCategory{}).SetSpace(data)

	c.HTML(http.StatusOK, "article-category/edit", gin.H{
		"title":             "编辑文章分类",
		"flash":             flash,
		"articleCategory":   articleCategory,
		"articleCategories": categories,
	})
}

func (a *ArticleCategory) Update(c *gin.Context) {

	id := c.Param("id")
	articleCategory := models.ArticleCategory{}
	if err := c.ShouldBind(&articleCategory); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}
	articleCategory.ID = ID

	if err := (&helper.Validate{}).ValidateStr(articleCategory); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	articleCategory.Level = 1
	if articleCategory.Parent > 0 {
		parent := models.ArticleCategory{}
		db.Mysql.First(&parent, articleCategory.Parent)
		articleCategory.Level = parent.Level + 1
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.ArticleCategory{}).Save(&articleCategory).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}
	(&helper.Flash{}).SetFlash(c, "修改文章分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/article-category")
}

func (a *ArticleCategory) Show(c *gin.Context) {

	id := c.Param("id")

	articleCategory := models.ArticleCategory{}
	if err := db.Mysql.First(&articleCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "article-category/show", gin.H{
		"title":           "查看文章",
		"articleCategory": articleCategory,
	})
}

func (a *ArticleCategory) Destroy(c *gin.Context) {

	id := c.Param("id")

	articleCategory := models.ArticleCategory{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&articleCategory).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
	}

	(&helper.Flash{}).SetFlash(c, "删除文章分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/article-category")
}
