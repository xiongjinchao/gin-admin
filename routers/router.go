package routers

import (
	"gin/controllers/article"
	"gin/controllers/auth"
	"gin/controllers/user"
	"github.com/gin-gonic/gin"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	router.Static("/public", "./public")
	router.LoadHTMLGlob("views/**/*")

	router.GET("/login", auth.GetLogin)
	router.POST("/login", auth.PostLogin)

	admin := router.Group("admin")
	admin.Use()
	{
		admin.GET("user", user.Index)
		admin.GET("user/create", user.Create)
		admin.POST("user", user.Store)
		admin.GET("user/edit/:id", user.Edit)
		admin.PUT("user/update/:id", user.Update)
		admin.GET("user/show/:id", user.Show)
		admin.DELETE("user/delete/:id", user.Destroy)

		admin.GET("article", article.Index)
	}
	return router
}
