package middleware

import (
	"encoding/json"
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
			c.Abort()
			return
		}

		identification := make(map[string]interface{})
		if err := json.Unmarshal([]byte(auth.(string)), &identification); err != nil {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
		}

		base := identification["base"].(map[string]interface{})
		if int64(base["id"].(float64)) <= 0 {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
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
