package controllers

import (
	"fmt"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type User struct {}

// Index handles GET /admin/user route
func (_ *User)Index(c *gin.Context) {

	u := models.User{}
	user := u.GetUserList()

	c.HTML(http.StatusOK, "user/index.html", gin.H{
		"title": "user list",
		"user":  user,
	})
}

func (_ *User)Create(c *gin.Context) {
	c.HTML(http.StatusOK, "user/create.html", gin.H{
		"title": "user create",
	})
}

func (_ *User)Store(c *gin.Context) {

}

func (_ *User)Edit(c *gin.Context) {
	c.HTML(http.StatusOK, "user/edit.html", gin.H{
		"title": "user edit",
	})
}

func (_ *User)Update(c *gin.Context) {

}

func (_ *User)Show(c *gin.Context) {
	id := c.Param("id")

	u := models.User{}
	user := u.GetUser(id)
	fmt.Println(user.Email)

	c.HTML(http.StatusOK, "user/show.html", gin.H{
		"title": "user list",
		"user":  user,
	})
}

func (_ *User)Destroy(c *gin.Context) {

}
