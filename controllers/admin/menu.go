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

type Menu struct{}

// GetMenuList handles GET /admin/menu route
func (m *Menu) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "menu/index", gin.H{
		"title": "菜单管理",
		"flash": flash,
	})
}

// Datatable
func (m *Menu) Data(c *gin.Context) {

	var menu, data []models.Menu

	query := db.Mysql.Model(&models.Menu{}).Order("level asc, sort DESC")

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("tag LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&menu).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	(&models.Menu{}).SetSort(&menu, 0, &data)
	(&models.Menu{}).SetSpace(&data)

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(menu),
		"recordsFiltered": total,
		"data":            data,
	})
}

// Create handles GET /admin/menu/create route
func (m *Menu) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	var menus, data []models.Menu
	if err := db.Mysql.Model(&models.Menu{}).Order("level asc, sort DESC").Find(&menus).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.Menu{}).SetSort(&menus, 0, &data)
	(&models.Menu{}).SetSpace(&data)

	c.HTML(http.StatusOK, "menu/create", gin.H{
		"title": "创建菜单",
		"flash": flash,
		"menus": data,
	})
}

// Store handles POST /admin/menu route
func (m *Menu) Store(c *gin.Context) {
	menu := models.Menu{}
	err := c.ShouldBind(&menu)
	if old, err := json.Marshal(menu); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/create")
		return
	}

	if err := helper.ValidateStruct(menu); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/create")
		return
	}

	menu.Level = 1
	if menu.Parent > 0 {
		parent := models.Menu{}
		db.Mysql.First(&parent, menu.Parent)
		menu.Level = parent.Level + 1
	}

	if err := db.Mysql.Omit("Parents", "Space").Create(&menu).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/create")
		return
	}

	helper.SetFlash(c, "创建菜单成功", "success")
	c.Redirect(http.StatusFound, "/admin/menu")
}

func (m *Menu) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	menu := models.Menu{}
	if err := db.Mysql.First(&menu, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var menus, data []models.Menu
	if err := db.Mysql.Model(&models.Menu{}).Order("level asc, sort DESC").Find(&menus).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.Menu{}).SetSort(&menus, 0, &data)
	(&models.Menu{}).SetSpace(&data)

	c.HTML(http.StatusOK, "menu/edit", gin.H{
		"title": "编辑菜单",
		"flash": flash,
		"menu":  menu,
		"menus": data,
	})
}

func (m *Menu) Update(c *gin.Context) {

	id := c.Param("id")
	menu := models.Menu{}
	if err := c.ShouldBind(&menu); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/edit/"+id)
		return
	}
	menu.ID = ID

	if err := helper.ValidateStruct(menu); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/edit/"+id)
		return
	}

	menu.Level = 1
	if menu.Parent > 0 {
		parent := models.Menu{}
		db.Mysql.First(&parent, menu.Parent)
		menu.Level = parent.Level + 1
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.Menu{}).Omit("Parents", "Space").Save(&menu).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/menu/edit/"+id)
		return
	}

	(&models.Menu{}).UpdateChildren(menu)

	helper.SetFlash(c, "修改菜单成功", "success")
	c.Redirect(http.StatusFound, "/admin/menu")
}

func (m *Menu) Show(c *gin.Context) {

	id := c.Param("id")

	menu := models.Menu{}
	if err := db.Mysql.First(&menu, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "menu/show", gin.H{
		"title": "查看文章",
		"menu":  menu,
	})
}

func (m *Menu) Destroy(c *gin.Context) {

	id := c.Param("id")

	menu := models.Menu{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&menu).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除菜单成功", "success")
	c.Redirect(http.StatusFound, "/admin/menu")
}
