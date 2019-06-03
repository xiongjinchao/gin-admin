package backend

import (
	"fmt"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type User struct {
	Base
}

// Index handles GET /admin/user route
func (this *User) Index(c *gin.Context) {

	u := models.User{}
	user := u.GetUserList()

	c.HTML(http.StatusOK, "user/index.html", gin.H{
		"title":  "user list",
		"user":   user,
		"errors": this.errors,
	})
}

// Create handles GET /admin/user/create route
func (_ *User) Create(c *gin.Context) {
	c.HTML(http.StatusOK, "user/create.html", gin.H{
		"title": "user create",
	})
}

// Store handles POST /admin/user route
func (_ *User) Store(c *gin.Context) {

	defer func() {
		if r := recover(); r != nil {
			fmt.Println(r)
			c.Redirect(http.StatusMovedPermanently, "/admin/user/create")
			return
		}
	}()

	u := models.User{
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	id := u.CreateUser()
	//id := (*models.User).CreateUser(&u)
	uid := strconv.FormatInt(id, 10)
	c.Redirect(http.StatusMovedPermanently, "/admin/user/show/"+uid)
}

func (_ *User) Edit(c *gin.Context) {
	c.HTML(http.StatusOK, "user/edit.html", gin.H{
		"title": "user edit",
	})
}

func (_ *User) Update(c *gin.Context) {
	uid := c.Param("id")
	id, _ := strconv.ParseInt(uid, 10, 64)

	defer func() {
		if r := recover(); r != nil {
			c.Redirect(http.StatusMovedPermanently, "/admin/user/edit"+uid)
			return
		}
	}()

	u := models.User{
		Id:       id,
		Name:     c.PostForm("name"),
		Email:    c.PostForm("email"),
		Mobile:   c.PostForm("mobile"),
		Password: c.PostForm("password"),
	}
	id = u.UpdateUser()
	//id = (*models.User).UpdateUser(&u)
	c.Redirect(http.StatusMovedPermanently, "/admin/user/show/"+uid)
}

func (_ *User) Show(c *gin.Context) {
	uid := c.Param("id")
	id, _ := strconv.ParseInt(uid, 10, 64)

	u := models.User{}
	user := u.GetUser(id)

	c.HTML(http.StatusOK, "user/show.html", gin.H{
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
