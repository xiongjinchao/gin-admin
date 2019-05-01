package controllers

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

//GetLogin handles GET /login route
func GetLogin(c *gin.Context) {
	c.HTML(http.StatusOK, "auth/login.tmpl", gin.H{
		"title": "Main website",
	})
}

//PostLogin handles POST /login route
func PostLogin(c *gin.Context) {
	fmt.Println("post login")
}
