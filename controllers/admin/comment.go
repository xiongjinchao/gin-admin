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

type Comment struct{}

// GetCommentList handles GET /admin/comment route
func (co *Comment) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "comment/index", gin.H{
		"title": "评论管理",
		"flash": flash,
	})
}

// Datatable
func (co *Comment) Data(c *gin.Context) {

	var comment []models.Comment

	query := db.Mysql.Model(&models.Comment{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&comment).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(comment),
		"recordsFiltered": total,
		"data":            comment,
	})
}

// Create handles GET /admin/comment/create route
func (co *Comment) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "comment/create", gin.H{
		"title": "创建评论",
		"flash": flash,
	})
}

// Store handles POST /admin/comment route
func (co *Comment) Store(c *gin.Context) {
	comment := models.Comment{}
	err := c.ShouldBind(&comment)
	if old, err := json.Marshal(comment); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/create")
		return
	}

	if err := helper.ValidateStruct(comment); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/create")
		return
	}

	if err := db.Mysql.Create(&comment).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/create")
		return
	}

	helper.SetFlash(c, "创建评论成功", "success")
	c.Redirect(http.StatusFound, "/admin/comment")
}

func (co *Comment) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	comment := models.Comment{}
	if err := db.Mysql.First(&comment, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "comment/edit", gin.H{
		"title":   "编辑评论",
		"flash":   flash,
		"comment": comment,
	})
}

func (co *Comment) Update(c *gin.Context) {

	id := c.Param("id")
	comment := models.Comment{}
	if err := c.ShouldBind(&comment); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/edit/"+id)
		return
	}
	comment.ID = ID

	if err := helper.ValidateStruct(comment); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.Comment{}).Save(&comment).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/comment/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改评论成功", "success")
	c.Redirect(http.StatusFound, "/admin/comment")
}

func (co *Comment) Show(c *gin.Context) {

	id := c.Param("id")

	comment := models.Comment{}
	if err := db.Mysql.First(&comment, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "comment/show", gin.H{
		"title":   "查看评论",
		"comment": comment,
	})
}

func (co *Comment) Destroy(c *gin.Context) {

	id := c.Param("id")

	comment := models.Comment{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&comment).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除评论成功", "success")
	c.Redirect(http.StatusFound, "/admin/comment")
}
