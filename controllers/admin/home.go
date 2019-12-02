package admin

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Dashboard(c *gin.Context) {
	fmt.Print(c.MustGet("test"))
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "系统面板",
	})
}
