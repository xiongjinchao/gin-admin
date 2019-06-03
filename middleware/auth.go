package middleware

import (
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
			c.Redirect(http.StatusMovedPermanently, "/login")
			c.AbortWithStatus(http.StatusUnauthorized)
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
