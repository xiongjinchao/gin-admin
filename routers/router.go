package routers

import (
	"gin/controllers"

	"github.com/gin-gonic/gin"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()
	router.LoadHTMLGlob("views/**/*")

	router.GET("/login", controllers.GetLogin)
	router.POST("/login", controllers.PostLogin)

	admin := router.Group("admin")
	{
		admin.GET("user", controllers.GetUserList)
	}
	return router
}
