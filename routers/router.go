package routers

import (
	"gin/controllers"
	"github.com/gin-gonic/gin"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	router.Static("/public", "./public")
	router.LoadHTMLGlob("views/**/*")

	router.GET("/login", controllers.GetLogin)
	router.POST("/login", controllers.PostLogin)

	admin := router.Group("admin")
	{
		admin.GET("user", controllers.GetUserList)
		admin.GET("article", controllers.GetArticleList)
	}
	return router
}
