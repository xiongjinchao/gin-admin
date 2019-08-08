package admin

import (
	"encoding/json"
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Admin struct{}

// Index handles GET /admin/admin route
func (a *Admin) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	c.HTML(http.StatusOK, "admin/index", gin.H{
		"title": "管理员管理",
		"flash": flash,
	})
}

func (a *Admin) Data(c *gin.Context) {

	var admin []models.Admin

	query := db.Mysql.Model(&models.Admin{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("email LIKE ?", "%"+search+"%").
			Or("mobile LIKE ?", "%"+search+"%")
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
		query = query.Order("email " + sort)
	case "3":
		query = query.Order("mobile " + sort)
	case "4":
		query = query.Order("created_at " + sort)
	case "5":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	// find() will return data sorted by column name, but scan() return data with struct column order. scan() doesn't support Preload
	err := query.Find(&admin).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(admin),
		"recordsFiltered": total,
		"data":            admin,
	})
}

// Create handles GET /admin/admin/create route
func (a *Admin) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "admin/create", gin.H{
		"title": "创建管理员",
		"flash": flash,
	})
}

// Store handles POST /admin/admin/store route
func (a *Admin) Store(c *gin.Context) {

	admin := models.Admin{}
	err := c.ShouldBind(&admin)
	if old, err := json.Marshal(admin); err == nil {
		(&helper.Flash{}).SetFlash(c, string(old), "old")
	}

	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(admin); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	if err := (&helper.Validate{}).ValidateVar(admin.Password, "gte=6,lte=18"); err != nil {
		(&helper.Flash{}).SetFlash(c, "密码长度为6-18个字符", "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}
	admin.Password = admin.GeneratePassword(admin.Password)

	existed := 0
	db.Mysql.Model(&models.Admin{}).Where("name = ?", admin.Name).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "姓名已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	db.Mysql.Model(&models.Admin{}).Where("mobile = ?", admin.Mobile).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "手机号码已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	db.Mysql.Model(&models.Admin{}).Where("email = ?", admin.Email).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "邮箱已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	if err := db.Mysql.Create(&admin).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/create")
		return
	}

	(&helper.Flash{}).SetFlash(c, "创建管理员成功", "success")
	c.Redirect(http.StatusFound, "/admin/admin")
}

func (a *Admin) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&helper.Flash{}).GetFlash(c)

	admin := models.Admin{}
	if err := db.Mysql.First(&admin, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "admin/edit", gin.H{
		"title": "编辑管理员",
		"admin": admin,
		"flash": flash,
	})
}

func (a *Admin) Update(c *gin.Context) {

	id := c.Param("id")
	admin := models.Admin{}
	err := c.ShouldBind(&admin)
	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	if err := (&helper.Validate{}).ValidateStr(admin); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	if admin.Password != "" {
		if err := (&helper.Validate{}).ValidateVar(admin.Password, "gte=6,lte=18"); err != nil {
			(&helper.Flash{}).SetFlash(c, "密码长度为6-18个字符", "error")
			c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
			return
		}
		admin.Password = admin.GeneratePassword(admin.Password)
	}

	existed := 0
	db.Mysql.Model(&models.Admin{}).Where("id <> ?", id).Where("name = ?", admin.Name).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "姓名已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	db.Mysql.Model(&models.Admin{}).Where("id <> ?", id).Where("mobile = ?", admin.Mobile).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "手机号码已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	db.Mysql.Model(&models.Admin{}).Where("id <> ?", id).Where("email = ?", admin.Email).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "邮箱已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column, but updates cant. so use updates()
	if err := db.Mysql.Model(&models.Admin{}).Where("id = ?", id).Updates(admin).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/admin/edit/"+id)
		return
	}

	(&helper.Flash{}).SetFlash(c, "修改管理员成功", "success")
	c.Redirect(http.StatusFound, "/admin/admin")

}

func (a *Admin) Show(c *gin.Context) {
	id := c.Param("id")

	admin := models.Admin{}
	if err := db.Mysql.First(&admin, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "admin/show", gin.H{
		"title": "查看管理员",
		"admin": admin,
	})
}

func (a *Admin) Destroy(c *gin.Context) {
	id := c.Param("id")

	admin := models.Admin{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&admin).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
	}

	(&helper.Flash{}).SetFlash(c, "删除管理员成功", "success")
	c.Redirect(http.StatusFound, "/admin/admin")
}
