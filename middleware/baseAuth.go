package middleware

import (
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/xiongjinchao/gin/helper"
	"net/http"
)

type BaseAuth struct{}

func (_ *BaseAuth) CheckLogin() gin.HandlerFunc {
	return func(c *gin.Context) {
		session := sessions.Default(c)
		auth := session.Get("base-auth")
		if auth == nil {
			c.Redirect(http.StatusFound, "/login")
		}

		baseAuth, err := (&helper.Convert{}).Json2Map(auth.(string))
		if err != nil || (&helper.Convert{}).Interface2Int64(baseAuth["id"]) <= 0 {
			c.Redirect(http.StatusFound, "/login")
		}
		c.Next()
	}
}

func (_ *BaseAuth) CheckJwt() gin.HandlerFunc {
	return func(c *gin.Context) {
		//TODO JWT
		c.Next()
	}
}
