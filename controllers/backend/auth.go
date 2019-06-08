package backend

import (
	"fmt"
	"gin/models"
	"gopkg.in/go-playground/validator.v9"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Auth struct{}

//Login handles GET /login route
func (_ *Auth) Login(c *gin.Context) {
	session := sessions.Default(c)
	flash := session.Flashes()
	if err := session.Save(); err != nil {
		panic(err)
	}
	fmt.Println(flash)
	c.HTML(http.StatusOK, "backend/auth/login", gin.H{
		"title": "Golang Blog",
		"flash": flash,
	})
}

//SignIn handles POST /sign-in route
func (_ *Auth) SignIn(c *gin.Context) {
	auth := models.Auth{}
	session := sessions.Default(c)
	if err := c.ShouldBind(&auth); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())

		session.AddFlash("参数错误")
		if err := session.Save(); err != nil {
			panic(err)
		}

		c.Redirect(http.StatusFound, "/login")
		return
	}

	validate := validator.New()
	err := validate.Struct(&auth)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())

		session.AddFlash("账号或密码错误")
		if err := session.Save(); err != nil {
			panic(err)
		}

		c.Redirect(http.StatusFound, "/login")
		return
	}

	// sign-in success
	/*
		session.Set("auth", `{id:"1",name:"admin"}`)
		if err := session.Save(); err != nil {
			panic(err)
		}
		c.Redirect(http.StatusFound, "/admin")
	*/
}

//Register handles GET /register route
func (_ *Auth) Register(c *gin.Context) {
	c.HTML(http.StatusOK, "backend/auth/register", gin.H{
		"title": "Golang Blog",
	})
}

//SignUp handles POST /sign-up route
func (_ *Auth) SignUp(c *gin.Context) {
	fmt.Println("Golang Blog")
}
