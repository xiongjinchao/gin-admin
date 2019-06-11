package frontend

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Home struct{}

//GetLogin handles GET /login route
func (_ *Home) Index(c *gin.Context) {

	c.HTML(http.StatusOK, "frontend/home/index", gin.H{
		"title": "Gin Blog",
	})
}
