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

type Tag struct{}

// GetTagList handles GET /admin/tag route
func (t *Tag) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "tag/index", gin.H{
		"title": "标签管理",
		"flash": flash,
	})
}

// Datatable
func (t *Tag) Data(c *gin.Context) {

	var tag []models.Tag

	query := db.Mysql.Model(&models.Tag{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&tag).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(tag),
		"recordsFiltered": total,
		"data":            tag,
	})
}

// Create handles GET /admin/tag/create route
func (t *Tag) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "tag/create", gin.H{
		"title": "创建标签",
		"flash": flash,
	})
}

// Store handles POST /admin/tag route
func (t *Tag) Store(c *gin.Context) {
	tag := models.Tag{}
	err := c.ShouldBind(&tag)
	if old, err := json.Marshal(tag); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/create")
		return
	}

	if err := helper.ValidateStruct(tag); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/create")
		return
	}

	if err := db.Mysql.Create(&tag).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/create")
		return
	}

	helper.SetFlash(c, "创建标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag")
}

func (t *Tag) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	tag := models.Tag{}
	if err := db.Mysql.First(&tag, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "tag/edit", gin.H{
		"title": "编辑标签",
		"flash": flash,
		"tag":   tag,
	})
}

func (t *Tag) Update(c *gin.Context) {

	id := c.Param("id")
	tag := models.Tag{}
	if err := c.ShouldBind(&tag); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/edit/"+id)
		return
	}
	tag.ID = ID

	if err := helper.ValidateStruct(tag); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.Tag{}).Save(&tag).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag")
}

func (t *Tag) Show(c *gin.Context) {

	id := c.Param("id")

	tag := models.Tag{}
	if err := db.Mysql.First(&tag, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "tag/show", gin.H{
		"title": "查看标签",
		"tag":   tag,
	})
}

func (t *Tag) Destroy(c *gin.Context) {

	id := c.Param("id")

	tag := models.Tag{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&tag).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag")
}
