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
)

type BookChapter struct{}

// GetBookChapterList handles GET /admin/book-chapter route
func (bc *BookChapter) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "book-chapter/index", gin.H{
		"title": "书籍章节",
		"flash": flash,
		"image": config.Setting["domain"]["image"],
	})
}

// Datatable
func (bc *BookChapter) Data(c *gin.Context) {
	var bookChapter []models.BookChapter

	query := db.Mysql.Model(&models.BookChapter{}).Preload("Book")

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
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
		query = query.Order("book_id " + sort)
	case "3":
		query = query.Order("audit " + sort)
	case "4":
		query = query.Order("hit " + sort)
	case "5":
		query = query.Order("favorite " + sort)
	case "6":
		query = query.Order("comment " + sort)
	case "7":
		query = query.Order("sort " + sort)
	case "8":
		query = query.Order("created_at " + sort)
	case "9":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	// find() will return data sorted by column name, but scan() return data with struct column order. scan() doesn't support Preload
	err := query.Find(&bookChapter).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(bookChapter),
		"recordsFiltered": total,
		"data":            bookChapter,
	})
}

// Create handles GET /admin/book-chapter/create route
func (bc *BookChapter) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var book []models.Book
	if err := db.Mysql.Model(&models.Book{}).Find(&book).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book-chapter/create", gin.H{
		"title": "创建书籍章节",
		"flash": flash,
		"book":  book,
	})
}

// Store handles POST /admin/book-chapter route
func (bc *BookChapter) Store(c *gin.Context) {

	bookChapter := models.BookChapter{}
	err := c.ShouldBind(&bookChapter)
	if old, err := json.Marshal(bookChapter); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/create")
		return
	}

	if err := helper.ValidateStruct(bookChapter); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/create")
		return
	}

	if err := db.Mysql.Omit("Book").Create(&bookChapter).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/create")
		return
	}

	helper.SetFlash(c, "创建书籍章节成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-chapter")
}

func (bc *BookChapter) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	bookChapter := models.BookChapter{}
	if err := db.Mysql.First(&bookChapter, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var book []models.Book
	if err := db.Mysql.Model(&models.Book{}).Find(&book).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book-chapter/edit", gin.H{
		"title":       "编辑书籍章节",
		"flash":       flash,
		"bookChapter": bookChapter,
		"book":        book,
	})
}

func (bc *BookChapter) Update(c *gin.Context) {

	id := c.Param("id")
	bookChapter := models.BookChapter{}
	if err := c.ShouldBind(&bookChapter); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/edit/"+id)
		return
	}
	bookChapter.ID = ID

	if err := helper.ValidateStruct(bookChapter); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.BookChapter{}).Omit("Book").Save(&bookChapter).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/book-chapter/edit/"+id)
		return
	}
	helper.SetFlash(c, "修改书籍章节成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-chapter")
}

func (bc *BookChapter) Show(c *gin.Context) {
	id := c.Param("id")

	bookChapter := models.BookChapter{}
	if err := db.Mysql.First(&bookChapter, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "book-chapter/show", gin.H{
		"title":       "查看书籍章节",
		"bookChapter": bookChapter,
	})
}

func (bc *BookChapter) Destroy(c *gin.Context) {
	id := c.Param("id")

	bookChapter := models.BookChapter{}
	if err := db.Mysql.Where("id = ?", id).Delete(&bookChapter).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除书籍章节成功", "success")
	c.Redirect(http.StatusFound, "/admin/book-chapter")
}
