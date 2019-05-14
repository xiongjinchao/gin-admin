package controllers

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

//GetLogin handles GET /login route
func GetLogin(c *gin.Context) {
	c.HTML(http.StatusOK, "auth/login.html", gin.H{
		"title": "Golang Blog",
	})
}

//PostLogin handles POST /login route
func PostLogin(c *gin.Context) {
	fmt.Println("Golang Blog")
}
