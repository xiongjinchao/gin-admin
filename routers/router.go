package routers

import (
	"gin/config"
	"gin/controllers"
	"gin/middleware"
	"github.com/foolin/gin-template"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"html/template"
	"time"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(config.Setting["session"]["id"]))
	// SESSION with redis
	// store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte("secret"))
	router.Use(sessions.Sessions(config.Setting["session"]["key"], store))

	router.Static("/public", "./public")
	router.StaticFile("/favicon.ico", "./public/image/favicon.ico")

	//router.LoadHTMLGlob("views/**/*")
	router.HTMLRender = gintemplate.New(gintemplate.TemplateConfig{
		Root:      "views",
		Extension: ".tpl",
		Master:    "layouts/main",
		Partials:  []string{"layouts/header", "layouts/sidebar", "layouts/footer"},
		Funcs: template.FuncMap{
			"sub": func(a, b int) int {
				return a - b
			},
			"copy": func() string {
				return time.Now().Format("2006")
			},
		},
		DisableCache: true,
	})

	// Login

	router.GET("/login", (&controllers.BaseAuth{}).Login)
	router.POST("/sign-in", (&controllers.BaseAuth{}).SignIn)

	// Register
	router.GET("/register", (&controllers.BaseAuth{}).Register)
	router.POST("/sign-up", (&controllers.BaseAuth{}).SignUp)

	//Logout
	router.GET("/logout", (&controllers.BaseAuth{}).Logout)

	admin := router.Group("admin")
	admin.Use((&middleware.BaseAuth{}).CheckLogin())
	{
		//Admin Dashboard
		admin.GET("dashboard", (&controllers.Home{}).Dashboard)

		//User
		admin.GET("user", (&controllers.User{}).Index)
		admin.GET("user/data", (&controllers.User{}).Data)
		admin.GET("user/create", (&controllers.User{}).Create)
		admin.POST("user", (&controllers.User{}).Store)
		admin.GET("user/edit/:id", (&controllers.User{}).Edit)
		admin.PUT("user/update/:id", (&controllers.User{}).Update)
		admin.GET("user/show/:id", (&controllers.User{}).Show)
		admin.DELETE("user/delete/:id", (&controllers.User{}).Destroy)

		//Article
		admin.GET("article", (&controllers.Article{}).Index)
		admin.GET("article/data", (&controllers.Article{}).Data)
		admin.GET("article/create", (&controllers.Article{}).Create)
		admin.POST("article", (&controllers.Article{}).Store)
		admin.GET("article/edit/:id", (&controllers.Article{}).Edit)
		admin.PUT("article/update/:id", (&controllers.Article{}).Update)
		admin.GET("article/show/:id", (&controllers.Article{}).Show)
		admin.DELETE("article/delete/:id", (&controllers.Article{}).Destroy)

		//Article Category
		admin.GET("article-category", (&controllers.ArticleCategory{}).Index)
		admin.GET("article-category/data", (&controllers.ArticleCategory{}).Data)

		//Goroutines
		admin.GET("goroutines", func(c *gin.Context) {
			//go func() {
			//	time.Sleep(10 * time.Second)
			//	log.Println("Done2! in path " + c.Request.URL.Path)
			//}()
		})
	}

	return router
}
