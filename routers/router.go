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

	auth := controllers.Auth{}
	router.GET("/login", auth.GetLogin)
	router.POST("/login", auth.PostLogin)

	admin := router.Group("admin")
	//admin.Use()
	{
		user := controllers.User{}
		admin.GET("user", user.Index)
		admin.GET("user/create", user.Create)
		admin.POST("user", user.Store)
		admin.GET("user/edit/:id", user.Edit)
		admin.PUT("user/update/:id", user.Update)
		admin.GET("user/show/:id", user.Show)
		admin.DELETE("user/delete/:id", user.Destroy)

		article := controllers.Article{}
		admin.GET("article", article.Index)
	}
	return router
}
