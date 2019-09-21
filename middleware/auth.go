package middleware

import (
	"encoding/json"
	"gin/helper"
	"github.com/casbin/casbin"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
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

		home := "/admin/dashboard"
		if c.FullPath() == home {
			c.Next()
			return
		}
		if (c.FullPath() == "/admin/policy/upgrade" || c.FullPath() == "/admin/policy/reset") && base["id"].(float64) == 1 {
			c.Next()
			return
		}

		admin := "admin:" + strconv.FormatInt(int64(base["id"].(float64)), 10)
		permission := c.Request.Method + " " + c.FullPath()
		action := c.Request.Method

		e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")
		allowed, _ := e.Enforce(admin, permission, action)
		if allowed == false {
			referer := c.Request.Header.Get("Referer")
			if referer == "" {
				referer = home
			}
			(&helper.Flash{}).SetFlash(c, "你没有权限执行该操作", "error")
			c.Redirect(http.StatusFound, referer)
			c.Abort()
			return
		}

		c.Next()
	}
}
