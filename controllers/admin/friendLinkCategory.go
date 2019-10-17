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

type FriendLinkCategory struct{}

// GetFriendLinkCategoryList handles GET /admin/friend-link-category route
func (f *FriendLinkCategory) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "friend-link-category/index", gin.H{
		"title": "链接分类",
		"flash": flash,
	})
}

// Datatable
func (f *FriendLinkCategory) Data(c *gin.Context) {

	var friendLinkCategory, data []models.FriendLinkCategory

	query := db.Mysql.Model(&models.FriendLinkCategory{}).Order("level asc, sort DESC")

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&friendLinkCategory).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	(&models.FriendLinkCategory{}).SetSort(&friendLinkCategory, 0, &data)
	(&models.FriendLinkCategory{}).SetData(&data)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(friendLinkCategory),
		"recordsFiltered": total,
		"data":            data,
	})
}

// Create handles GET /admin/friend-link-category/create route
func (f *FriendLinkCategory) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var friendLinkCategories, data []models.FriendLinkCategory
	if err := db.Mysql.Model(&models.FriendLinkCategory{}).Order("level asc, sort DESC").Find(&friendLinkCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.FriendLinkCategory{}).SetSort(&friendLinkCategories, 0, &data)
	(&models.FriendLinkCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "friend-link-category/create", gin.H{
		"title":                "创建链接分类",
		"flash":                flash,
		"friendLinkCategories": data,
	})
}

// Store handles POST /admin/friend-link-category route
func (f *FriendLinkCategory) Store(c *gin.Context) {
	friendLinkCategory := models.FriendLinkCategory{}
	err := c.ShouldBind(&friendLinkCategory)
	if old, err := json.Marshal(friendLinkCategory); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/create")
		return
	}

	if err := helper.ValidateStruct(friendLinkCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/create")
		return
	}

	friendLinkCategory.Level = 1
	if friendLinkCategory.Parent > 0 {
		parent := models.FriendLinkCategory{}
		db.Mysql.First(&parent, friendLinkCategory.Parent)
		friendLinkCategory.Level = parent.Level + 1
	}

	if err := db.Mysql.Omit("Parents", "Space").Create(&friendLinkCategory).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/create")
		return
	}

	if err := (&models.FriendLinkCategory{}).SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/create")
		return
	}

	helper.SetFlash(c, "创建链接分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/friend-link-category")
}

func (f *FriendLinkCategory) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	friendLinkCategory := models.FriendLinkCategory{}
	if err := db.Mysql.First(&friendLinkCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var friendLinkCategories, data []models.FriendLinkCategory
	if err := db.Mysql.Model(&models.FriendLinkCategory{}).Order("level asc, sort DESC").Find(&friendLinkCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.FriendLinkCategory{}).SetSort(&friendLinkCategories, 0, &data)
	(&models.FriendLinkCategory{}).SetData(&data)

	c.HTML(http.StatusOK, "friend-link-category/edit", gin.H{
		"title":                "编辑链接分类",
		"flash":                flash,
		"friendLinkCategory":   friendLinkCategory,
		"friendLinkCategories": data,
	})
}

func (f *FriendLinkCategory) Update(c *gin.Context) {

	id := c.Param("id")
	friendLinkCategory := models.FriendLinkCategory{}
	if err := c.ShouldBind(&friendLinkCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/edit/"+id)
		return
	}
	friendLinkCategory.ID = ID

	if err := helper.ValidateStruct(friendLinkCategory); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/edit/"+id)
		return
	}

	friendLinkCategory.Level = 1
	if friendLinkCategory.Parent > 0 {
		parent := models.FriendLinkCategory{}
		db.Mysql.First(&parent, friendLinkCategory.Parent)
		friendLinkCategory.Level = parent.Level + 1
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.FriendLinkCategory{}).Omit("Parents", "Space").Save(&friendLinkCategory).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/edit/"+id)
		return
	}
	(&models.FriendLinkCategory{}).UpdateChildren(friendLinkCategory)

	if err := (&models.FriendLinkCategory{}).SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改链接分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/friend-link-category")
}

func (f *FriendLinkCategory) Show(c *gin.Context) {

	id := c.Param("id")

	friendLinkCategory := models.FriendLinkCategory{}
	if err := db.Mysql.First(&friendLinkCategory, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "friend-link-category/show", gin.H{
		"title":              "查看链接",
		"friendLinkCategory": friendLinkCategory,
	})
}

func (f *FriendLinkCategory) Destroy(c *gin.Context) {

	id := c.Param("id")

	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&models.FriendLinkCategory{}).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	if err := (&models.FriendLinkCategory{}).SetCache(); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/friend-link-category")
		return
	}

	helper.SetFlash(c, "删除链接分类成功", "success")
	c.Redirect(http.StatusFound, "/admin/friend-link-category")
}
