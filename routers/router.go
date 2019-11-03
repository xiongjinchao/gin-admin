package routers

import (
	"gin-admin/config"
	"gin-admin/controllers"
	"gin-admin/controllers/admin"
	"gin-admin/helper"
	"gin-admin/middleware"
	"github.com/foolin/gin-template"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"html/template"
	"net/http"
	"reflect"
	"strings"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(config.Setting["session"]["secret"]))
	// SESSION with redis
	// store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte(config.Setting["session"]["secret"]))
	router.Use(sessions.Sessions(config.Setting["session"]["id"], store))

	router.Static("/public", "./public")
	router.Static("/uploads", "./uploads")
	router.StaticFile("/favicon.ico", "./public/image/favicon.ico")

	//router.LoadHTMLGlob("views/**/*")
	router.HTMLRender = gintemplate.New(gintemplate.TemplateConfig{
		Root:      "views",
		Extension: ".tpl",
		Master:    "layouts/main",
		Partials:  []string{"layouts/header", "layouts/sidebar", "layouts/footer"},
		Funcs: template.FuncMap{
			"Interface2Int64": helper.Interface2Int64,
			"TypeOf":          reflect.TypeOf,
			"Split":           strings.Split,
			"Contains":        strings.Contains,
			"Replace":         strings.Replace,
			"Add": func(x, y int) int {
				return x + y
			},
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

	authorized := router.Group("admin")
	authorized.Use((&middleware.Auth{}).CheckPolicy())
	{
		//Admin Dashboard
		authorized.GET("dashboard", (&admin.Home{}).Dashboard)

		//Admin
		administrator := &admin.Admin{}
		authorized.GET("admin", administrator.Index)
		authorized.GET("admin/data", administrator.Data)
		authorized.GET("admin/create", administrator.Create)
		authorized.POST("admin", administrator.Store)
		authorized.GET("admin/edit/:id", administrator.Edit)
		authorized.POST("admin/update/:id", administrator.Update)
		authorized.GET("admin/show/:id", administrator.Show)
		authorized.GET("admin/delete/:id", administrator.Destroy)
		authorized.GET("admin/roles/:id", administrator.Roles)
		authorized.POST("admin/roles/:id", administrator.Policy)

		//User
		user := &admin.User{}
		authorized.GET("user", user.Index)
		authorized.GET("user/data", user.Data)
		authorized.GET("user/create", user.Create)
		authorized.POST("user", user.Store)
		authorized.GET("user/edit/:id", user.Edit)
		authorized.POST("user/update/:id", user.Update)
		authorized.GET("user/show/:id", user.Show)
		authorized.GET("user/delete/:id", user.Destroy)

		//Menu
		menu := &admin.Menu{}
		authorized.GET("menu", menu.Index)
		authorized.GET("menu/data", menu.Data)
		authorized.GET("menu/create", menu.Create)
		authorized.POST("menu", menu.Store)
		authorized.GET("menu/edit/:id", menu.Edit)
		authorized.POST("menu/update/:id", menu.Update)
		authorized.GET("menu/show/:id", menu.Show)
		authorized.GET("menu/delete/:id", menu.Destroy)

		//Book
		book := &admin.Book{}
		authorized.GET("book", book.Index)
		authorized.GET("book/data", book.Data)
		authorized.GET("book/create", book.Create)
		authorized.POST("book", book.Store)
		authorized.GET("book/edit/:id", book.Edit)
		authorized.POST("book/update/:id", book.Update)
		authorized.GET("book/show/:id", book.Show)
		authorized.GET("book/delete/:id", book.Destroy)
		authorized.GET("book/test", book.Test)

		//BookChapter
		bookChapter := &admin.BookChapter{}
		authorized.GET("book-chapter", bookChapter.Index)
		authorized.GET("book-chapter/data", bookChapter.Data)
		authorized.GET("book-chapter/create", bookChapter.Create)
		authorized.POST("book-chapter", bookChapter.Store)
		authorized.GET("book-chapter/edit/:id", bookChapter.Edit)
		authorized.POST("book-chapter/update/:id", bookChapter.Update)
		authorized.GET("book-chapter/show/:id", bookChapter.Show)
		authorized.GET("book-chapter/delete/:id", bookChapter.Destroy)

		//Book Category
		bookCategory := &admin.BookCategory{}
		authorized.GET("book-category", bookCategory.Index)
		authorized.GET("book-category/data", bookCategory.Data)
		authorized.GET("book-category/create", bookCategory.Create)
		authorized.POST("book-category", bookCategory.Store)
		authorized.GET("book-category/edit/:id", bookCategory.Edit)
		authorized.POST("book-category/update/:id", bookCategory.Update)
		authorized.GET("book-category/show/:id", bookCategory.Show)
		authorized.GET("book-category/delete/:id", bookCategory.Destroy)

		//Article
		article := &admin.Article{}
		authorized.GET("article", article.Index)
		authorized.GET("article/data", article.Data)
		authorized.GET("article/create", article.Create)
		authorized.POST("article", article.Store)
		authorized.GET("article/edit/:id", article.Edit)
		authorized.POST("article/update/:id", article.Update)
		authorized.GET("article/show/:id", article.Show)
		authorized.GET("article/delete/:id", article.Destroy)

		//Article Category
		articleCategory := &admin.ArticleCategory{}
		authorized.GET("article-category", articleCategory.Index)
		authorized.GET("article-category/data", articleCategory.Data)
		authorized.GET("article-category/create", articleCategory.Create)
		authorized.POST("article-category", articleCategory.Store)
		authorized.GET("article-category/edit/:id", articleCategory.Edit)
		authorized.POST("article-category/update/:id", articleCategory.Update)
		authorized.GET("article-category/show/:id", articleCategory.Show)
		authorized.GET("article-category/delete/:id", articleCategory.Destroy)

		//File
		file := &admin.File{}
		authorized.POST("file/upload", file.Upload)
		authorized.POST("file/delete", file.Delete)
		authorized.POST("file/editor-upload", file.EditorUpload)

		//Tag
		tag := &admin.Tag{}
		authorized.GET("tag", tag.Index)
		authorized.GET("tag/data", tag.Data)
		authorized.GET("tag/create", tag.Create)
		authorized.POST("tag", tag.Store)
		authorized.GET("tag/edit/:id", tag.Edit)
		authorized.POST("tag/update/:id", tag.Update)
		authorized.GET("tag/show/:id", tag.Show)
		authorized.GET("tag/delete/:id", tag.Destroy)

		//Comment
		comment := &admin.Comment{}
		authorized.GET("comment", comment.Index)
		authorized.GET("comment/data", comment.Data)
		authorized.GET("comment/create", comment.Create)
		authorized.POST("comment", comment.Store)
		authorized.GET("comment/edit/:id", comment.Edit)
		authorized.POST("comment/update/:id", comment.Update)
		authorized.GET("comment/show/:id", comment.Show)
		authorized.GET("comment/delete/:id", comment.Destroy)

		//ActionLog
		actionLog := &admin.ActionLog{}
		authorized.GET("action-log", actionLog.Index)
		authorized.GET("action-log/data", actionLog.Data)
		authorized.GET("action-log/create", actionLog.Create)
		authorized.POST("action-log", actionLog.Store)
		authorized.GET("action-log/edit/:id", actionLog.Edit)
		authorized.POST("action-log/update/:id", actionLog.Update)
		authorized.GET("action-log/show/:id", actionLog.Show)
		authorized.GET("action-log/delete/:id", actionLog.Destroy)

		//Friend Link
		friendLink := &admin.FriendLink{}
		authorized.GET("friend-link", friendLink.Index)
		authorized.GET("friend-link/data", friendLink.Data)
		authorized.GET("friend-link/create", friendLink.Create)
		authorized.POST("friend-link", friendLink.Store)
		authorized.GET("friend-link/edit/:id", friendLink.Edit)
		authorized.POST("friend-link/update/:id", friendLink.Update)
		authorized.GET("friend-link/show/:id", friendLink.Show)
		authorized.GET("friend-link/delete/:id", friendLink.Destroy)

		//Friend Link Category
		friendLinkCategory := &admin.FriendLinkCategory{}
		authorized.GET("friend-link-category", friendLinkCategory.Index)
		authorized.GET("friend-link-category/data", friendLinkCategory.Data)
		authorized.GET("friend-link-category/create", friendLinkCategory.Create)
		authorized.POST("friend-link-category", friendLinkCategory.Store)
		authorized.GET("friend-link-category/edit/:id", friendLinkCategory.Edit)
		authorized.POST("friend-link-category/update/:id", friendLinkCategory.Update)
		authorized.GET("friend-link-category/show/:id", friendLinkCategory.Show)
		authorized.GET("friend-link-category/delete/:id", friendLinkCategory.Destroy)

		//Policy
		policy := &admin.Policy{}
		authorized.GET("policy", policy.Index)
		authorized.GET("policy/reset", policy.Reset)
		authorized.GET("policy/upgrade", policy.Upgrade)
		authorized.GET("policy/create", policy.Create)
		authorized.POST("policy", policy.Store)
		authorized.GET("policy/edit/:role", policy.Edit)
		authorized.POST("policy/update/:role", policy.Update)
		authorized.GET("policy/show/:role", policy.Show)
		authorized.GET("policy/delete/:role", policy.Destroy)

	}

	return router
}
