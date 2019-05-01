package routers

import (
	"gin/controllers"

	"github.com/gin-gonic/gin"
)

// Comment
func Router() *gin.Engine {
	router := gin.Default()

	router.GET("/login", controllers.GetLogin)
	router.POST("/login", controllers.PostLogin)

	admin := router.Group("admin")
	{
		admin.GET("user", controllers.GetUserList)
	}
	return router
}
