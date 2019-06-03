package routers

import (
	"gin/controllers/backend"
	"gin/controllers/frontend"
	"gin/middleware"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

const (
	SESSIONID = "GOSESSID"
	SECRETKEY = "e63e42954d32a1d73568659fea764f4ad71ef534"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION
	store := sessions.NewCookieStore([]byte(SECRETKEY))
	router.Use(sessions.Sessions(SESSIONID, store))

	router.Static("/public", "./public")
	router.LoadHTMLGlob("views/**/*")

	// Home Page
	router.GET("/", (&frontend.Home{}).Index)

	// Login
	router.GET("/login", (&backend.Auth{}).Login)
	router.POST("/login", (&backend.Auth{}).Auth)

	admin := router.Group("admin")
	admin.Use((&middleware.Auth{}).CheckLogin())
	{
		//User
		admin.GET("user", (&backend.User{}).Index)
		admin.GET("user/create", (&backend.User{}).Create)
		admin.POST("user", (&backend.User{}).Store)
		admin.GET("user/edit/:id", (&backend.User{}).Edit)
		admin.PUT("user/update/:id", (&backend.User{}).Update)
		admin.GET("user/show/:id", (&backend.User{}).Show)
		admin.DELETE("user/delete/:id", (&backend.User{}).Destroy)

		//Article
		admin.GET("article", (&backend.Article{}).Index)
	}
	return router
}
