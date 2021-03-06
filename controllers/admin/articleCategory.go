package admin

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type ArticleCategory struct{}

// GetArticleCategoryList handles GET /admin/article-category route
func (a *ArticleCategory) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "article-category/index", gin.H{
		"title": "文章分类",
		"flash": flash,
	})
}

// Datatable
func (a *ArticleCategory) Data(c *gin.Context) {

	var articleCategory, data []models.ArticleCategory

	query := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC")

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

	(&models.ArticleCategory{}).SetSort(&articleCategory, 0, &data)
	(&models.ArticleCategory{}).SetData(&data)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(articleCategory),
		"recordsFiltered": total,
		"data":            data,
	})
}

// Create handles GET /admin/article-category/create route
func (a *ArticleCategory) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &data)
	(&models.ArticleCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "article-category/create", gin.H{
		"title":             "创建文章分类",
		"flash":             flash,
		"articleCategories": data,
	})
}

// Store handles POST /admin/article-category route
func (a *ArticleCategory) Store(c *gin.Context) {
	articleCategory := models.ArticleCategory{}
	err := c.ShouldBind(&articleCategory)
	if old, err := json.Marshal(articleCategory); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	if err := helper.ValidateStruct(articleCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
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
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	if err := (&models.ArticleCategory{}).SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/create")
		return
	}

	helper.SetFlash(c, "创建文章分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/article-category")
}

func (a *ArticleCategory) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	articleCategory := models.ArticleCategory{}
	if err := db.Mysql.First(&articleCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var articleCategories, data []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &data)
	(&models.ArticleCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "article-category/edit", gin.H{
		"title":             "编辑文章分类",
		"flash":             flash,
		"articleCategory":   articleCategory,
		"articleCategories": data,
	})
}

func (a *ArticleCategory) Update(c *gin.Context) {

	id := c.Param("id")
	articleCategory := models.ArticleCategory{}
	if err := c.ShouldBind(&articleCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}
	articleCategory.ID = ID

	if err := helper.ValidateStruct(articleCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
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
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	if err := articleCategory.UpdateChildren(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	if err := articleCategory.SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改文章分类成功", "success")
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

	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&models.ArticleCategory{}).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	if err := (&models.ArticleCategory{}).SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/article-category")
		return
	}

	helper.SetFlash(c, "删除文章分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/article-category")
}
