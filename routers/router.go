package routers

import (
	"fmt"
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
	"strconv"
	"strings"
	"sync"
)

var wg sync.WaitGroup

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(config.Setting["session"]["secret"]))
	// SESSION with redis
	// store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte(config.Setting["session"]["secret"]))
	router.Use(sessions.Sessions(config.Setting["session"]["id"], store))

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
			"Split":           strings.Split,
			"Contains":        strings.Contains,
			"Replace":         strings.Replace,
			"Add": func(x, y int) int {
				return x + y
			},
		},
		DisableCache: true,
	})

	//Goroutines
	router.GET("/goroutines", func(c *gin.Context) {
		count := 10
		ch := make(chan int, count)
		for i := 0; i < count; i++ {
			wg.Add(1)
			j := i + 1
			go func(x, y int, ch *chan int) {
				fmt.Println("do:" + strconv.Itoa(x))
				*ch <- x * y
				wg.Done()
			}(i, j, &ch)
		}

		wg.Wait()
		close(ch)

		for j := 0; j < count; j++ {
			v := <-ch
			fmt.Println(v)
		}
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
