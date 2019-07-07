package controllers

import (
	"encoding/json"
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/jinzhu/gorm"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type BaseAuth struct{}

//Login handles GET /login route
func (_ *BaseAuth) Login(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	c.HTML(http.StatusOK, "base-auth/login.tpl", gin.H{
		"title": "Gin Blog",
		"flash": flash,
	})
}

//SignIn handles POST /sign-in route
func (_ *BaseAuth) SignIn(c *gin.Context) {
	auth := models.BaseAuth{}
	if err := c.ShouldBind(&auth); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(auth); err != nil {
		c.Redirect(http.StatusFound, "/login")
		return
	}

	user := models.User{}
	auth.Password = (&models.User{}).GeneratePassword(auth.Password)
	err := db.Mysql.Model(&models.User{}).Where("mobile = ? AND password = ?", auth.Mobile, auth.Password).First(&user).Error
	if gorm.IsRecordNotFoundError(err) {
		(&helper.Flash{}).SetFlash(c, "账号或密码错误，请重新输入", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	data, err := json.Marshal(user)
	if err != nil {
		(&helper.Flash{}).SetFlash(c, "系统错误，请重试", "error")
		c.Redirect(http.StatusFound, "/login")
		return
	}

	// sign-in success
	session := sessions.Default(c)
	session.Set("base-auth", string(data))
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	c.Redirect(http.StatusFound, "/admin/dashboard")
}

//Register handles GET /register route
func (_ *BaseAuth) Register(c *gin.Context) {
	c.HTML(http.StatusOK, "base-auth/register.tpl", gin.H{
		"title": "Gin Blog",
	})
}

//SignUp handles POST /sign-up route
func (_ *BaseAuth) SignUp(c *gin.Context) {
	fmt.Println("Gin Blog")
}

func (_ *BaseAuth) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("base-auth")
	session.Clear()
	c.Redirect(http.StatusFound, "/login")
}
