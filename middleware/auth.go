package middleware

import (
	"gin/helper"
	"gin/models"
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

		identification, err := (&models.Admin{}).ParseAuth(auth.(string))
		if err != nil {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
		}
		if identification.ID < 0 {
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
		if (c.FullPath() == "/admin/policy/upgrade" || c.FullPath() == "/admin/policy/reset") && identification.ID == 1 {
			c.Next()
			return
		}

		admin := "admin:" + strconv.FormatInt(identification.ID, 10)
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
