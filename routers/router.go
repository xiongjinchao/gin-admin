package routers

import (
	"gin/controllers/backend"
	"gin/controllers/frontend"
	"gin/middleware"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

const (
	SESSION_ID = "GOSESSID"
	SECRET_KEY = "e63e42954d32a1d73568659fea764f4ad71ef534"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(SECRET_KEY))
	// SESSION with redis
	//store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte("secret"))
	router.Use(sessions.Sessions(SESSION_ID, store))

	router.Static("/public", "./public")
	router.StaticFile("/favicon.ico", "./public/image/favicon.ico")

	router.LoadHTMLGlob("views/***/**/*")

	// Home Page
	router.GET("/", (&frontend.Home{}).Index)

	// Login
	router.GET("/login", (&backend.Auth{}).Login)
	router.POST("/sign-in", (&backend.Auth{}).SignIn)

	// Register
	router.GET("/register", (&backend.Auth{}).Register)
	router.POST("/sign-up", (&backend.Auth{}).SignUp)

	//Logout
	router.GET("/logout", (&backend.Auth{}).Logout)

	admin := router.Group("admin")
	admin.Use((&middleware.Auth{}).CheckLogin())
	{
		//Admin
		admin.GET("/", (&backend.Home{}).Index)

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
