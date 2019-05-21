package controllers

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Auth struct {}

//GetLogin handles GET /login route
func (_ *Auth)GetLogin(c *gin.Context) {
	c.HTML(http.StatusOK, "auth/login.html", gin.H{
		"title": "Golang Blog",
	})
}

//PostLogin handles POST /login route
func (_ *Auth)PostLogin(c *gin.Context) {
	fmt.Println("Golang Blog")
}
