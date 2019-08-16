package admin

import (
	"fmt"
	db "gin/database"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Dashboard(c *gin.Context) {
	routers, err := db.Redis.Get("routers").Result()
	if err != nil {
		fmt.Println(err)
	}
	_ = routers
	//println(routers)

	routers = c.GetString("routers")
	println(routers + " HERE")

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "系统面板",
	})
}
