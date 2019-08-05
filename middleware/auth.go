package middleware

import (
	"gin/helper"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Auth struct{}

func (_ *Auth) CheckLogin() gin.HandlerFunc {
	return func(c *gin.Context) {
		session := sessions.Default(c)
		auth := session.Get("auth")
		if auth == nil {
			c.Redirect(http.StatusFound, "/login")
		}

		if auth, err := (&helper.Convert{}).Json2Map(auth.(string)); err != nil || (&helper.Convert{}).Interface2Int64(auth["id"]) <= 0 {
			c.Redirect(http.StatusFound, "/login")
		}
		c.Next()
	}
}

func (_ *Auth) CheckJwt() gin.HandlerFunc {
	return func(c *gin.Context) {
		//TODO JWT
		c.Next()
	}
}
