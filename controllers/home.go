package controllers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (_ *Home) Index(c *gin.Context) {
	fmt.Println("后台")

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "Gin Blog",
	})
}
