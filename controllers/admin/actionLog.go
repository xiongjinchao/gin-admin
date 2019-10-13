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

type ActionLog struct{}

// GetActionLogList handles GET /admin/action-log route
func (a *ActionLog) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "action-log/index", gin.H{
		"title": "操作记录",
		"flash": flash,
	})
}

// Datatable
func (a *ActionLog) Data(c *gin.Context) {

	var actionLog []models.ActionLog

	query := db.Mysql.Model(&models.ActionLog{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("actionLog LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	if err := query.Find(&actionLog).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(actionLog),
		"recordsFiltered": total,
		"data":            actionLog,
	})
}

// Create handles GET /admin/action-log/create route
func (a *ActionLog) Create(c *gin.Context) {

	flash := helper.GetFlash(c)

	c.HTML(http.StatusOK, "action-log/create", gin.H{
		"title": "创建操作记录",
		"flash": flash,
	})
}

// Store handles POST /admin/action-log route
func (a *ActionLog) Store(c *gin.Context) {
	actionLog := models.ActionLog{}
	err := c.ShouldBind(&actionLog)
	if old, err := json.Marshal(actionLog); err == nil {
		helper.SetFlash(c, string(old), "old")
	}

	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/create")
		return
	}

	if err := helper.ValidateStruct(actionLog); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/create")
		return
	}

	if err := db.Mysql.Create(&actionLog).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/create")
		return
	}

	helper.SetFlash(c, "创建操作记录成功", "success")
	c.Redirect(http.StatusFound, "/admin/action-log")
}

func (a *ActionLog) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := helper.GetFlash(c)

	actionLog := models.ActionLog{}
	if err := db.Mysql.First(&actionLog, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "action-log/edit", gin.H{
		"title":     "编辑操作记录",
		"flash":     flash,
		"actionLog": actionLog,
	})
}

func (a *ActionLog) Update(c *gin.Context) {

	id := c.Param("id")
	actionLog := models.ActionLog{}
	if err := c.ShouldBind(&actionLog); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/edit/"+id)
		return
	}

	// when ID >0 use save() is for update.
	ID, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/edit/"+id)
		return
	}
	actionLog.ID = ID

	if err := helper.ValidateStruct(actionLog); err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column.
	if err := db.Mysql.Model(&models.ActionLog{}).Save(&actionLog).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/action-log/edit/"+id)
		return
	}

	helper.SetFlash(c, "修改操作记录成功", "success")
	c.Redirect(http.StatusFound, "/admin/action-log")
}

func (a *ActionLog) Show(c *gin.Context) {

	id := c.Param("id")

	actionLog := models.ActionLog{}
	if err := db.Mysql.First(&actionLog, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "action-log/show", gin.H{
		"title":     "查看操作记录",
		"actionLog": actionLog,
	})
}

func (a *ActionLog) Destroy(c *gin.Context) {

	id := c.Param("id")

	actionLog := models.ActionLog{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&actionLog).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
	}

	helper.SetFlash(c, "删除操作记录成功", "success")
	c.Redirect(http.StatusFound, "/admin/action-log")
}
