package controllers

import (
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/jinzhu/gorm"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Auth struct{}

//Login handles GET /login route
func (_ *Auth) Login(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	c.HTML(http.StatusOK, "auth/login.tpl", gin.H{
		"title": "Gin Blog",
		"flash": flash,
	})
}

//SignIn handles POST /sign-in route
func (_ *Auth) SignIn(c *gin.Context) {
	auth := models.Auth{}
	if err := c.ShouldBind(&auth); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(auth); err != nil {
		c.Redirect(http.StatusFound, "/login")
		return
	}

	admin := models.Admin{}
	auth.Password = (&models.Admin{}).GeneratePassword(auth.Password)
	err := db.Mysql.Model(&models.Admin{}).Where("mobile = ? AND password = ?", auth.Mobile, auth.Password).First(&admin).Error
	if gorm.IsRecordNotFoundError(err) {
		(&helper.Flash{}).SetFlash(c, "账号或密码错误，请重新输入", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	data, err := (&helper.Convert{}).Data2Json(admin)
	if err != nil {
		(&helper.Flash{}).SetFlash(c, "系统错误，请重试", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	// sign-in success
	session := sessions.Default(c)
	session.Set("auth", data)
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	c.Redirect(http.StatusFound, "/admin/dashboard")
}

func (_ *Auth) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("auth")
	session.Clear()
	c.Redirect(http.StatusFound, "/login")
}
