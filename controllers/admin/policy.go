package admin

import (
	"encoding/json"
	"fmt"
	db "gin/database"
	"gin/helper"
	"github.com/casbin/casbin"
	"github.com/gin-gonic/gin"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
)

type Policy struct{}

// Index handles GET /admin/policy route
func (p *Policy) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	fmt.Println("所有角色：")
	roles := e.GetAllRoles()
	for _, v := range roles {
		fmt.Println(v)
	}

	fmt.Println("所有权限：")
	permissions := e.GetAllObjects()
	for _, v := range permissions {
		fmt.Println(v)
	}

	c.HTML(http.StatusOK, "policy/index", gin.H{
		"title": "角色管理",
		"flash": flash,
	})
}

// Upgrade handles GET /admin/policy/upgrade route
// add new permissions and delete not exist permissions
func (p *Policy) Upgrade(c *gin.Context) {
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	// create a user named admin has the role named admin
	if ok, err := e.AddRoleForUser("user:admin", "role:admin"); ok && err == nil {
		_ = e.SavePolicy()
	}

	routers, err := db.Redis.Get("routers").Result()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	routing := make([]map[string]string, 0)

	if err := json.Unmarshal([]byte(routers), &routing); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	path := make(map[string]string, 0)

	for _, v := range routing {
		path[v["method"]+" "+v["path"]] = "1"
		// add all permissions to role:admin
		if ok, err := e.AddPolicy("role:admin", v["method"]+" "+v["path"], v["method"]); ok && err == nil {
			_ = e.SavePolicy()
		}
	}

	permissions := e.GetAllObjects()
	for _, v := range permissions {
		// delete permission not exist
		if _, exist := path[v]; exist == false {
			if ok, _ := e.DeletePermission(v); ok {
				_ = e.SavePolicy()
			}
		}
	}
}

// Create handles GET /admin/policy/create route
func (p *Policy) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "policy/create", gin.H{
		"title": "创建角色",
		"flash": flash,
	})
}

// Store handles POST /admin/policy/store route
func (p *Policy) Store(c *gin.Context) {

	(&helper.Flash{}).SetFlash(c, "创建角色成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")
}

func (p *Policy) Edit(c *gin.Context) {

	role := c.Param("role")
	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "policy/edit", gin.H{
		"title": "编辑角色",
		"role":  role,
		"flash": flash,
	})
}

func (p *Policy) Update(c *gin.Context) {

	_ = c.Param("role")

	(&helper.Flash{}).SetFlash(c, "修改角色成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")

}

func (p *Policy) Show(c *gin.Context) {
	role := c.Param("role")

	c.HTML(http.StatusOK, "policy/show", gin.H{
		"title": "查看角色",
		"role":  role,
	})
}

func (p *Policy) Destroy(c *gin.Context) {
	_ = c.Param("role")

	(&helper.Flash{}).SetFlash(c, "删除角色成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")
}
