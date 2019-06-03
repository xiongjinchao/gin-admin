package frontend

import (
	"github.com/gin-gonic/contrib/sessions"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Home struct{}

//GetLogin handles GET /login route
func (_ *Home) Index(c *gin.Context) {
	// flash data
	session := sessions.Default(c)
	session.AddFlash("用户已经存在")
	if err := session.Save(); err != nil {
		panic(err)
	}

	c.HTML(http.StatusOK, "home/index.html", gin.H{
		"title": "Golang Blog",
	})
}
