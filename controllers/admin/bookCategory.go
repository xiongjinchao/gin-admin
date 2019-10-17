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

type BookCategory struct{}

// GetBookCategoryList handles GET /admin/book-category route
func (b *BookCategory) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "book-category/index", gin.H{
		"title": "书籍分类",
		"flash": flash,
	})
}

// Datatable
func (b *BookCategory) Data(c *gin.Context) {

	var bookCategory, data []models.BookCategory

	query := db.Mysql.Model(&models.BookCategory{}).Order("level asc, sort DESC")

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&bookCategory).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	(&models.BookCategory{}).SetSort(&bookCategory, 0, &data)
	(&models.BookCategory{}).SetData(&data)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(bookCategory),
		"recordsFiltered": total,
		"data":            data,
	})
}

// Create handles GET /admin/book-category/create route
func (b *BookCategory) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var bookCategories, data []models.BookCategory
	if err := db.Mysql.Model(&models.BookCategory{}).Order("level asc, sort DESC").Find(&bookCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.BookCategory{}).SetSort(&bookCategories, 0, &data)
	(&models.BookCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "book-category/create", gin.H{
		"title":          "创建书籍分类",
		"flash":          flash,
		"bookCategories": data,
	})
}

// Store handles POST /admin/book-category route
func (b *BookCategory) Store(c *gin.Context) {
	bookCategory := models.BookCategory{}
	err := c.ShouldBind(&bookCategory)
	if old, err := json.Marshal(bookCategory); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/create")
		return
	}

	if err := helper.ValidateStruct(bookCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/create")
		return
	}

	bookCategory.Level = 1
	if bookCategory.Parent > 0 {
		parent := models.BookCategory{}
		db.Mysql.First(&parent, bookCategory.Parent)
		bookCategory.Level = parent.Level + 1
	}

	if err := db.Mysql.Omit("Parents", "Space").Create(&bookCategory).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/create")
		return
	}

	helper.SetFlash(c, "创建书籍分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-category")
}

func (b *BookCategory) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	bookCategory := models.BookCategory{}
	if err := db.Mysql.First(&bookCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var bookCategories, data []models.BookCategory
	if err := db.Mysql.Model(&models.BookCategory{}).Order("level asc, sort DESC").Find(&bookCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.BookCategory{}).SetSort(&bookCategories, 0, &data)
	(&models.BookCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "book-category/edit", gin.H{
		"title":          "编辑书籍分类",
		"flash":          flash,
		"bookCategory":   bookCategory,
		"bookCategories": data,
	})
}

func (b *BookCategory) Update(c *gin.Context) {

	id := c.Param("id")
	bookCategory := models.BookCategory{}
	if err := c.ShouldBind(&bookCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/edit/"+id)
		return
	}
	bookCategory.ID = ID

	if err := helper.ValidateStruct(bookCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/edit/"+id)
		return
	}

	bookCategory.Level = 1
	if bookCategory.Parent > 0 {
		parent := models.BookCategory{}
		db.Mysql.First(&parent, bookCategory.Parent)
		bookCategory.Level = parent.Level + 1
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.BookCategory{}).Omit("Parents", "Space").Save(&bookCategory).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-category/edit/"+id)
		return
	}
	(&models.BookCategory{}).UpdateChildren(bookCategory)

	helper.SetFlash(c, "修改书籍分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-category")
}

func (b *BookCategory) Show(c *gin.Context) {

	id := c.Param("id")

	bookCategory := models.BookCategory{}
	if err := db.Mysql.First(&bookCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book-category/show", gin.H{
		"title":        "查看书籍",
		"bookCategory": bookCategory,
	})
}

func (b *BookCategory) Destroy(c *gin.Context) {

	id := c.Param("id")

	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&models.BookCategory{}).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除书籍分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-category")
}
