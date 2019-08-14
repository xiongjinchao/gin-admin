package admin

import (
	db "gin/database"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Dashboard(c *gin.Context) {
	println(db.Redis.Get("routers"))
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "系统面板",
	})
}
