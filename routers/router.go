package routers

import (
	"gin/config"
	"gin/controllers"
	"gin/controllers/admin"
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

	authorization := router.Group("admin")
	authorization.Use((&middleware.Auth{}).CheckLogin())
	{
		//Admin Dashboard
		authorization.GET("dashboard", (&admin.Home{}).Dashboard)

		//Admin
		administrator := &admin.Admin{}
		authorization.GET("admin", administrator.Index)
		authorization.GET("admin/data", administrator.Data)
		authorization.GET("admin/create", administrator.Create)
		authorization.POST("admin", administrator.Store)
		authorization.GET("admin/edit/:id", administrator.Edit)
		authorization.POST("admin/update/:id", administrator.Update)
		authorization.GET("admin/show/:id", administrator.Show)
		authorization.GET("admin/delete/:id", administrator.Destroy)

		//User
		user := &admin.User{}
		authorization.GET("user", user.Index)
		authorization.GET("user/data", user.Data)
		authorization.GET("user/create", user.Create)
		authorization.POST("user", user.Store)
		authorization.GET("user/edit/:id", user.Edit)
		authorization.POST("user/update/:id", user.Update)
		authorization.GET("user/show/:id", user.Show)
		authorization.GET("user/delete/:id", user.Destroy)

		//Menu
		menu := &admin.Menu{}
		authorization.GET("menu", menu.Index)
		authorization.GET("menu/data", menu.Data)
		authorization.GET("menu/create", menu.Create)
		authorization.POST("menu", menu.Store)
		authorization.GET("menu/edit/:id", menu.Edit)
		authorization.POST("menu/update/:id", menu.Update)
		authorization.GET("menu/show/:id", menu.Show)
		authorization.GET("menu/delete/:id", menu.Destroy)

		//Book
		book := &admin.Book{}
		authorization.GET("book", book.Index)
		authorization.GET("book/data", book.Data)
		authorization.GET("book/create", book.Create)
		authorization.POST("book", book.Store)
		authorization.GET("book/edit/:id", book.Edit)
		authorization.POST("book/update/:id", book.Update)
		authorization.GET("book/show/:id", book.Show)
		authorization.GET("book/delete/:id", book.Destroy)

		//Article
		article := &admin.Article{}
		authorization.GET("article", article.Index)
		authorization.GET("article/data", article.Data)
		authorization.GET("article/create", article.Create)
		authorization.POST("article", article.Store)
		authorization.GET("article/edit/:id", article.Edit)
		authorization.POST("article/update/:id", article.Update)
		authorization.GET("article/show/:id", article.Show)
		authorization.GET("article/delete/:id", article.Destroy)

		//Article Category
		articleCategory := &admin.ArticleCategory{}
		authorization.GET("article-category", articleCategory.Index)
		authorization.GET("article-category/data", articleCategory.Data)
		authorization.GET("article-category/create", articleCategory.Create)
		authorization.POST("article-category", articleCategory.Store)
		authorization.GET("article-category/edit/:id", articleCategory.Edit)
		authorization.POST("article-category/update/:id", articleCategory.Update)
		authorization.GET("article-category/show/:id", articleCategory.Show)
		authorization.GET("article-category/delete/:id", articleCategory.Destroy)

		//File
		file := &admin.File{}
		authorization.POST("file/upload", file.Upload)
		authorization.POST("file/delete", file.Delete)

		//Goroutines
		authorization.GET("goroutines", func(c *gin.Context) {
			//go func() {
			//	time.Sleep(10 * time.Second)
			//	log.Println("Done2! in path " + c.Request.URL.Path)
			//}()
		})
	}

	return router
}
