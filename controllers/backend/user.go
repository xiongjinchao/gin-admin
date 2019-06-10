package backend

import (
	"fmt"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type User struct{}

// Index handles GET /admin/user route
func (_ *User) Index(c *gin.Context) {

	u := models.User{}
	user, err := u.GetUserList()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "backend/user/index", gin.H{
		"title": "user list",
		"user":  user,
	})
}

// Create handles GET /admin/user/create route
func (_ *User) Create(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "backend/user/create", gin.H{
		"title": "user create",
		"flash": flash,
	})
}

// Store handles POST /admin/user route
func (_ *User) Store(c *gin.Context) {
	u := models.User{
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	id, err := u.CreateUser()
	if err != nil {
		(&Base{}).SetFlash(c, "APP", err)
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}
	//id := (*models.User).CreateUser(&u)
	uid := strconv.FormatInt(id, 10)
	c.Redirect(http.StatusFound, "/admin/user/show/"+uid)
}

func (_ *User) Edit(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "backend/user/edit", gin.H{
		"title": "user edit",
		"flash": flash,
	})
}

func (_ *User) Update(c *gin.Context) {
	uid := c.Param("id")
	id, _ := strconv.ParseInt(uid, 10, 64)

	u := models.User{
		Id:       id,
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	if _, err := u.UpdateUser(); err != nil {
		(&Base{}).SetFlash(c, "APP", err)
		c.Redirect(http.StatusFound, "/admin/user/edit"+uid)
		return
	}
	//id = (*models.User).UpdateUser(&u)
	c.Redirect(http.StatusFound, "/admin/user/show/"+uid)
}

func (_ *User) Show(c *gin.Context) {
	uid := c.Param("id")
	id, _ := strconv.ParseInt(uid, 10, 64)

	u := models.User{}
	user, err := u.GetUser(id)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "backend/user/show", gin.H{
		"title": "user show",
		"user":  user,
	})
}

func (_ *User) Destroy(c *gin.Context) {
	id := c.Param("id")

	u := models.User{}
	if _, err := u.DeleteUser(id); err == nil {
		c.Redirect(301, "/")
	}
}
