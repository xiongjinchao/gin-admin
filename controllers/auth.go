package controllers

import (
	"encoding/json"
	"fmt"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	"github.com/jinzhu/gorm"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Auth struct{}

//Login handles GET /login route
func (_ *Auth) Login(c *gin.Context) {

	flash := helper.GetFlash(c)
	c.HTML(http.StatusOK, "auth/login.tpl", gin.H{
		"title": "Gin Blog",
		"flash": flash,
	})
}

//SignIn handles POST /sign-in route
func (_ *Auth) SignIn(c *gin.Context) {
	admin := models.Admin{}
	admin.Mobile = c.PostForm("mobile")
	admin.Password = c.PostForm("password")
	admin.GeneratePassword()
	err := db.Mysql.Model(&models.Admin{}).Where("mobile = ? AND password = ?", admin.Mobile, admin.Password).First(&admin).Error
	if gorm.IsRecordNotFoundError(err) {
		helper.SetFlash(c, "账号或密码错误，请重新输入", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	data, err := json.Marshal(admin)
	if err != nil {
		helper.SetFlash(c, "系统错误，请重试", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	// sign-in success
	session := sessions.Default(c)
	session.Set("auth", string(data))
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	c.Redirect(http.StatusFound, "/admin/dashboard")
}

func (_ *Auth) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("auth")
	session.Clear()
	_ = session.Save()
	c.Redirect(http.StatusFound, "/login")
}
