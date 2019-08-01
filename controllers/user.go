package controllers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	db "github.com/xiongjinchao/gin/database"
	"github.com/xiongjinchao/gin/helper"
	"github.com/xiongjinchao/gin/models"
	"net/http"
)

type User struct{}

// Index handles GET /admin/user route
func (_ *User) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	c.HTML(http.StatusOK, "user/index", gin.H{
		"title": "用户管理",
		"flash": flash,
	})
}

func (_ *User) Data(c *gin.Context) {

	var user []models.User

	query := db.Mysql.Model(&models.User{})

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
	err := query.Find(&user).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(user),
		"recordsFiltered": total,
		"data":            user,
	})
}

// Create handles GET /admin/user/create route
func (_ *User) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "user/create", gin.H{
		"title": "创建用户",
		"flash": flash,
	})
}

// Store handles POST /admin/user/store route
func (_ *User) Store(c *gin.Context) {

	user := models.User{}
	err := c.ShouldBind(&user)
	if old, err := (&helper.Convert{}).Data2Json(user); err == nil {
		(&helper.Flash{}).SetFlash(c, old, "old")
	}

	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := (&helper.Validate{}).ValidateVar(user.Password, "gte=6,lte=18"); err != nil {
		(&helper.Flash{}).SetFlash(c, "密码长度为6-18个字符", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}
	user.Password = user.GeneratePassword(user.Password)

	existed := 0
	db.Mysql.Model(&models.User{}).Where("name = ?", user.Name).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "姓名已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	db.Mysql.Model(&models.User{}).Where("mobile = ?", user.Mobile).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "手机号码已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	db.Mysql.Model(&models.User{}).Where("email = ?", user.Email).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "邮箱已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := db.Mysql.Create(&user).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if user.AccessToken, user.ResetKey, err = user.GenerateToken(user.ID); err != nil {
		(&helper.Flash{}).SetFlash(c, "用户令牌生成失败", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := db.Mysql.Save(&user).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, "用户令牌保存失败", "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	(&helper.Flash{}).SetFlash(c, "创建用户成功", "success")
	c.Redirect(http.StatusFound, "/admin/user")
}

func (_ *User) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&helper.Flash{}).GetFlash(c)

	user := models.User{}
	if err := db.Mysql.First(&user, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/edit", gin.H{
		"title": "编辑用户",
		"user":  user,
		"flash": flash,
	})
}

func (_ *User) Update(c *gin.Context) {

	id := c.Param("id")
	user := models.User{}
	err := c.ShouldBind(&user)
	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	if err := (&helper.Validate{}).ValidateStr(user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	if user.Password != "" {
		if err := (&helper.Validate{}).ValidateVar(user.Password, "gte=6,lte=18"); err != nil {
			(&helper.Flash{}).SetFlash(c, "密码长度为6-18个字符", "error")
			c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
			return
		}
		user.Password = user.GeneratePassword(user.Password)
	}

	existed := 0
	db.Mysql.Model(&models.User{}).Where("id <> ?", id).Where("name = ?", user.Name).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "姓名已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	db.Mysql.Model(&models.User{}).Where("id <> ?", id).Where("mobile = ?", user.Mobile).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "手机号码已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	db.Mysql.Model(&models.User{}).Where("id <> ?", id).Where("email = ?", user.Email).Count(&existed)
	if existed > 0 {
		(&helper.Flash{}).SetFlash(c, "邮箱已经存在", "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	// save() function can update empty,zero,bool column, but updates cant. so use updates()
	if err := db.Mysql.Model(&models.User{}).Where("id = ?", id).Updates(user).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}

	(&helper.Flash{}).SetFlash(c, "修改用户成功", "success")
	c.Redirect(http.StatusFound, "/admin/user")

}

func (_ *User) Show(c *gin.Context) {
	id := c.Param("id")

	user := models.User{}
	if err := db.Mysql.First(&user, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/show", gin.H{
		"title": "查看用户",
		"user":  user,
	})
}

func (_ *User) Destroy(c *gin.Context) {
	id := c.Param("id")

	user := models.User{}
	if err := db.Mysql.Unscoped().Where("id = ?", id).Delete(&user).Error; err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
	}

	(&helper.Flash{}).SetFlash(c, "删除用户成功", "success")
	c.Redirect(http.StatusFound, "/admin/user")
}
