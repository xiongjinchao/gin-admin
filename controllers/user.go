package controllers

import (
	"fmt"
	db "gin/database"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type User struct{}

// Index handles GET /admin/user route
func (_ *User) Index(c *gin.Context) {
	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var user []models.User
	db.Mysql.Find(&user)

	c.HTML(http.StatusOK, "user/index", gin.H{
		"title": "用户管理",
		"user":  user,
		"flash": flash,
	})
}

// Create handles GET /admin/user/create route
func (_ *User) Create(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/create", gin.H{
		"title": "创建用户",
		"flash": flash,
	})
}

// Store handles POST /admin/user route
func (_ *User) Store(c *gin.Context) {

	user := models.User{
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	user.Password = user.GeneratePassword(user.Password)

	if ok := (&Base{}).Validate(c, user); ok == false {
		c.Redirect(http.StatusFound, "//admin/user/create")
		return
	}

	err := db.Mysql.Create(&user).Error
	if err != nil {
		(&Base{}).SetFlash(c, "APP", err)
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}
	uid := string(user.ID)
	c.Redirect(http.StatusFound, "/admin/user/show/"+uid)
}

func (_ *User) Edit(c *gin.Context) {

	uid := c.Param("id")
	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	user := models.User{}
	if err := db.Mysql.First(&user, uid).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/edit", gin.H{
		"title": "编辑用户",
		"user":  user,
		"flash": flash,
	})
}

func (_ *User) Update(c *gin.Context) {

	uid := c.Param("id")
	user := models.User{
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	err := db.Mysql.Where("id = ?", uid).Updates(user).Error
	if err != nil {
		(&Base{}).SetFlash(c, "APP", err)
		c.Redirect(http.StatusFound, "/admin/user/edit"+uid)
		return
	}
	c.Redirect(http.StatusFound, "/admin/user/show/"+uid)

}

func (_ *User) Show(c *gin.Context) {
	uid := c.Param("id")
	//id, _ := strconv.ParseInt(uid, 10, 64)

	user := models.User{}
	if err := db.Mysql.First(&user, uid).Error; err != nil {
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
	err := db.Mysql.Where("id = ?", id).Delete(&user).Error
	if err == nil {
		c.Redirect(301, "/")
	}
}
