package frontend

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Home struct{}

//GetLogin handles GET /login route
func (_ *Home) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index.html", gin.H{
		"title": "Golang Blog",
	})
}
