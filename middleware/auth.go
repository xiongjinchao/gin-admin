package middleware

import (
	"encoding/json"
	"github.com/casbin/casbin"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Auth struct{}

func (_ *Auth) CheckPolicy() gin.HandlerFunc {
	return func(c *gin.Context) {

		// check login
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

		// check policy
		user := "user:" + identification["name"].(string)
		permission := c.Request.Method + " " + c.FullPath()
		action := c.Request.Method

		e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")
		allowed, _ := e.Enforce(user, permission, action)
		if allowed == false {
			println("403")
		}

		c.Next()
	}
}
