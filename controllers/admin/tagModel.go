package admin

import (
	"fmt"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type TagModel struct{}

// GetTagList handles GET /admin/tag-model route
func (t *TagModel) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "tag-model/index", gin.H{
		"title": "标签管理",
		"flash": flash,
	})
}

// Datatable
func (t *TagModel) Data(c *gin.Context) {

	var tagModel []models.TagModel

	query := db.Mysql.Model(&models.TagModel{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Preload("Tag", "name LIKE ?", "%"+search+"%")
	} else {
		query = query.Preload("Tag")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&tagModel).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(tagModel),
		"recordsFiltered": total,
		"data":            tagModel,
	})
}

// Create handles GET /admin/tag-model/create route
func (t *TagModel) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "tag-model/create", gin.H{
		"title": "创建标签",
		"flash": flash,
	})
}

// Store handles POST /admin/tag-model route
func (t *TagModel) Store(c *gin.Context) {

	modelID, err := strconv.ParseInt(c.PostForm("model_id"), 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag-model/create")
		return
	}

	if err := (&models.Tag{}).Upgrade(c.PostForm("name"), c.PostForm("model"), modelID); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag-model/create")
		return
	}

	helper.SetFlash(c, "创建标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag-model")
}

func (t *TagModel) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	tagModel := models.TagModel{}
	if err := db.Mysql.Preload("Tag").First(&tagModel, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "tag-model/edit", gin.H{
		"title":    "编辑标签",
		"flash":    flash,
		"tagModel": tagModel,
	})
}

func (t *TagModel) Update(c *gin.Context) {

	id := c.Param("id")
	modelID, err := strconv.ParseInt(c.PostForm("model_id"), 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag-model/edit/"+id)
		return
	}
	if err := (&models.Tag{}).Upgrade(c.PostForm("name"), c.PostForm("model"), modelID); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/tag-model/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag-model")
}

func (t *TagModel) Show(c *gin.Context) {

	id := c.Param("id")

	tagModel := models.TagModel{}
	if err := db.Mysql.Preload("Tag").First(&tagModel, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "tag-model/show", gin.H{
		"title":    "查看标签",
		"tagModel": tagModel,
	})
}

func (t *TagModel) Destroy(c *gin.Context) {

	id := c.Param("id")
	tagModel := models.TagModel{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&tagModel).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除标签成功", "success")
	c.Redirect(http.StatusFound, "/admin/tag-model")
}
