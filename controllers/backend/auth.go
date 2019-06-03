package backend

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Auth struct{}

//GetLogin handles GET /login route
func (_ *Auth) Login(c *gin.Context) {
	session := sessions.Default(c)
	session.Set("auth", `{id:"1",name:"admin"}`)
	if err := session.Save(); err != nil {
		panic(err)
	}
	c.HTML(http.StatusOK, "auth/login.html", gin.H{
		"title": "Golang Blog",
	})
}

//PostLogin handles POST /login route
func (_ *Auth) Auth(c *gin.Context) {
	fmt.Println("Golang Blog")
}
