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

type Book struct{}

// GetBookList handles GET /admin/book route
func (b *Book) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "book/index", gin.H{
		"title": "书籍管理",
		"flash": flash,
	})
}

// Datatable
func (b *Book) Data(c *gin.Context) {
	var book []models.Book

	query := db.Mysql.Model(&models.Book{})

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
		query = query.Order("name " + sort)
	case "2":
		query = query.Order("tag " + sort)
	case "3":
		query = query.Order("audit " + sort)
	case "4":
		query = query.Order("created_at " + sort)
	case "5":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	// find() will return data sorted by column name, but scan() return data with struct column order. scan() doesn't support Preload
	err := query.Find(&book).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(book),
		"recordsFiltered": total,
		"data":            book,
	})
}

// Create handles GET /admin/book/create route
func (b *Book) Create(c *gin.Context) {

	flash := helper.GetFlash(c)
	c.HTML(http.StatusOK, "book/create", gin.H{
		"title": "创建书籍",
		"flash": flash,
	})
}

// Store handles POST /admin/book route
func (b *Book) Store(c *gin.Context) {

	book := models.Book{}
	err := c.ShouldBind(&book)
	if old, err := json.Marshal(book); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/create")
		return
	}

	if err := helper.ValidateStruct(book); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/create")
		return
	}

	if err := db.Mysql.Create(&book).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/create")
		return
	}

	helper.SetFlash(c, "创建书籍成功", "success")
	c.Redirect(http.StatusFound, "/admin/book")
}

func (b *Book) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	book := models.Book{}
	if err := db.Mysql.First(&book, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book/edit", gin.H{
		"title": "编辑书籍",
		"flash": flash,
		"book":  book,
	})
}

func (b *Book) Update(c *gin.Context) {

	id := c.Param("id")
	book := models.Book{}
	if err := c.ShouldBind(&book); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/edit/"+id)
		return
	}
	book.ID = ID

	if err := helper.ValidateStruct(book); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.Book{}).Save(&book).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book/edit/"+id)
		return
	}
	helper.SetFlash(c, "修改书籍成功", "success")
	c.Redirect(http.StatusFound, "/admin/book")
}

func (b *Book) Show(c *gin.Context) {
	id := c.Param("id")

	book := models.Book{}
	if err := db.Mysql.First(&book, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book/show", gin.H{
		"title": "查看书籍",
		"book":  book,
	})
}

func (b *Book) Destroy(c *gin.Context) {
	id := c.Param("id")

	book := models.Book{}
	if err := db.Mysql.Where("id = ?", id).Delete(&book).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除书籍成功", "success")
	c.Redirect(http.StatusFound, "/admin/book")
}
