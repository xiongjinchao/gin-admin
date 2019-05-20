package user

import (
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

// Index handles GET /admin/user route
func Index(c *gin.Context) {
	user := models.GetUserList()
	c.HTML(http.StatusOK, "user/index.html", gin.H{
		"title": "user list",
		"user":  user,
	})
}

func Create(c *gin.Context) {
	c.HTML(http.StatusOK, "user/create.html", gin.H{
		"title": "user create",
	})
}

func Store(c *gin.Context) {

}

func Edit(c *gin.Context) {
	c.HTML(http.StatusOK, "user/edit.html", gin.H{
		"title": "user edit",
	})
}

func Update(c *gin.Context) {

}

func Show(c *gin.Context) {
	id := c.Param("id")
	user := models.GetUser(id)
	c.HTML(http.StatusOK, "user/show.html", gin.H{
		"title": "user list",
		"user":  user,
	})
}

func Destroy(c *gin.Context) {

}
