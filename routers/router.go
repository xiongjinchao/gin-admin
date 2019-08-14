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

	authority := router.Group("admin")
	authority.Use((&middleware.Auth{}).CheckLogin())
	{
		//Admin Dashboard
		authority.GET("dashboard", (&admin.Home{}).Dashboard)

		//Admin
		administrator := &admin.Admin{}
		authority.GET("admin", administrator.Index)
		authority.GET("admin/data", administrator.Data)
		authority.GET("admin/create", administrator.Create)
		authority.POST("admin", administrator.Store)
		authority.GET("admin/edit/:id", administrator.Edit)
		authority.POST("admin/update/:id", administrator.Update)
		authority.GET("admin/show/:id", administrator.Show)
		authority.GET("admin/delete/:id", administrator.Destroy)

		//User
		user := &admin.User{}
		authority.GET("user", user.Index)
		authority.GET("user/data", user.Data)
		authority.GET("user/create", user.Create)
		authority.POST("user", user.Store)
		authority.GET("user/edit/:id", user.Edit)
		authority.POST("user/update/:id", user.Update)
		authority.GET("user/show/:id", user.Show)
		authority.GET("user/delete/:id", user.Destroy)

		//Menu
		menu := &admin.Menu{}
		authority.GET("menu", menu.Index)
		authority.GET("menu/data", menu.Data)
		authority.GET("menu/create", menu.Create)
		authority.POST("menu", menu.Store)
		authority.GET("menu/edit/:id", menu.Edit)
		authority.POST("menu/update/:id", menu.Update)
		authority.GET("menu/show/:id", menu.Show)
		authority.GET("menu/delete/:id", menu.Destroy)

		//Book
		book := &admin.Book{}
		authority.GET("book", book.Index)
		authority.GET("book/data", book.Data)
		authority.GET("book/create", book.Create)
		authority.POST("book", book.Store)
		authority.GET("book/edit/:id", book.Edit)
		authority.POST("book/update/:id", book.Update)
		authority.GET("book/show/:id", book.Show)
		authority.GET("book/delete/:id", book.Destroy)

		//Article
		article := &admin.Article{}
		authority.GET("article", article.Index)
		authority.GET("article/data", article.Data)
		authority.GET("article/create", article.Create)
		authority.POST("article", article.Store)
		authority.GET("article/edit/:id", article.Edit)
		authority.POST("article/update/:id", article.Update)
		authority.GET("article/show/:id", article.Show)
		authority.GET("article/delete/:id", article.Destroy)

		//Article Category
		articleCategory := &admin.ArticleCategory{}
		authority.GET("article-category", articleCategory.Index)
		authority.GET("article-category/data", articleCategory.Data)
		authority.GET("article-category/create", articleCategory.Create)
		authority.POST("article-category", articleCategory.Store)
		authority.GET("article-category/edit/:id", articleCategory.Edit)
		authority.POST("article-category/update/:id", articleCategory.Update)
		authority.GET("article-category/show/:id", articleCategory.Show)
		authority.GET("article-category/delete/:id", articleCategory.Destroy)

		//File
		file := &admin.File{}
		authority.POST("file/upload", file.Upload)
		authority.POST("file/delete", file.Delete)

		//Goroutines
		authority.GET("goroutines", func(c *gin.Context) {
			//go func() {
			//	time.Sleep(10 * time.Second)
			//	log.Println("Done2! in path " + c.Request.URL.Path)
			//}()
		})
	}

	return router
}
