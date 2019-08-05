package routers

import (
	"gin/config"
	"gin/controllers"
	"gin/helper"
	"gin/middleware"
	"github.com/foolin/gin-template"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"reflect"
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
			//"Int642Int": (&helper.Convert{}).Int642Int,
			"Interface2Int64": (&helper.Convert{}).Interface2Int64,
			"TypeOf":          reflect.TypeOf,
		},
		DisableCache: true,
	})

	router.GET("/", func(c *gin.Context) {
		c.Redirect(http.StatusFound, "/admin/dashboard")
	})

	// Login
	router.GET("/login", (&controllers.Auth{}).Login)
	router.POST("/sign-in", (&controllers.Auth{}).SignIn)

	//Logout
	router.GET("/logout", (&controllers.Auth{}).Logout)

	admin := router.Group("admin")
	admin.Use((&middleware.Auth{}).CheckLogin())
	{
		//Admin Dashboard
		admin.GET("dashboard", (&controllers.Home{}).Dashboard)

		//Admin
		administrator := &controllers.Admin{}
		admin.GET("admin", administrator.Index)
		admin.GET("admin/data", administrator.Data)
		admin.GET("admin/create", administrator.Create)
		admin.POST("admin", administrator.Store)
		admin.GET("admin/edit/:id", administrator.Edit)
		admin.POST("admin/update/:id", administrator.Update)
		admin.GET("admin/show/:id", administrator.Show)
		admin.GET("admin/delete/:id", administrator.Destroy)

		//User
		user := &controllers.User{}
		admin.GET("user", user.Index)
		admin.GET("user/data", user.Data)
		admin.GET("user/create", user.Create)
		admin.POST("user", user.Store)
		admin.GET("user/edit/:id", user.Edit)
		admin.POST("user/update/:id", user.Update)
		admin.GET("user/show/:id", user.Show)
		admin.GET("user/delete/:id", user.Destroy)

		//Article
		article := &controllers.Article{}
		admin.GET("article", article.Index)
		admin.GET("article/data", article.Data)
		admin.GET("article/create", article.Create)
		admin.POST("article", article.Store)
		admin.GET("article/edit/:id", article.Edit)
		admin.POST("article/update/:id", article.Update)
		admin.GET("article/show/:id", article.Show)
		admin.GET("article/delete/:id", article.Destroy)

		//Article Category
		articleCategory := &controllers.ArticleCategory{}
		admin.GET("article-category", articleCategory.Index)
		admin.GET("article-category/data", articleCategory.Data)
		admin.GET("article-category/create", articleCategory.Create)
		admin.POST("article-category", articleCategory.Store)
		admin.GET("article-category/edit/:id", articleCategory.Edit)
		admin.POST("article-category/update/:id", articleCategory.Update)
		admin.GET("article-category/show/:id", articleCategory.Show)
		admin.GET("article-category/delete/:id", articleCategory.Destroy)

		//File
		file := &controllers.File{}
		admin.POST("file/upload", file.Upload)
		admin.POST("file/delete", file.Delete)

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
