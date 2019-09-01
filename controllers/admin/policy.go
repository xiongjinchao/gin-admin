package admin

import (
	"encoding/json"
	"fmt"
	db "gin/database"
	"gin/helper"
	"github.com/casbin/casbin"
	"github.com/gin-gonic/gin"
	"net/http"
	"strings"

	_ "github.com/go-sql-driver/mysql"
)

type Policy struct{}

// Index handles GET /admin/policy route
func (p *Policy) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	roles := e.GetAllRoles()
	policy := make(map[string]map[string][]string, 0)
	for _, v := range roles {
		policy[v] = make(map[string][]string, 0)
		policy[v]["roles"] = make([]string, 0)
		policy[v]["permissions"] = make([]string, 0)
		// role has some roles
		for _, r := range e.GetFilteredGroupingPolicy(0, v) {
			policy[v]["roles"] = append(policy[v]["roles"], r[1])
		}
		// role has some permissions
		for _, p := range e.GetFilteredPolicy(0, v) {
			policy[v]["permissions"] = append(policy[v]["permissions"], p[1])
		}
	}

	c.HTML(http.StatusOK, "policy/index", gin.H{
		"title":  "角色管理",
		"flash":  flash,
		"policy": policy,
	})
}

// Upgrade handles GET /admin/policy/upgrade route
// add new permissions and delete not exist permissions
func (p *Policy) Upgrade(c *gin.Context) {
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	// create a user named admin has the role named admin
	if ok, err := e.AddRoleForUser("user:admin", "role:sys:admin"); ok && err == nil {
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

	permissions := make(map[string]string, 0)
	roles := make(map[string]string, 0)
	roles["role:sys:admin"] = "1"

	for _, v := range routing {
		permissions[v["method"]+" "+v["path"]] = "1"

		// every controller as a ctr:role
		item := strings.Split(v["path"], "/")
		roles["role:ctr:"+item[2]] = "1"
		if ok, err := e.AddPolicy("role:ctr:"+item[2], v["method"]+" "+v["path"], v["method"]); ok && err == nil {
			_ = e.SavePolicy()
		}

		// add all controller role to role:sys:admin
		if ok, err := e.AddGroupingPolicy("role:sys:admin", "role:ctr:"+item[2]); ok && err == nil {
			_ = e.SavePolicy()
		}
	}

	for _, v := range e.GetAllObjects() {
		// delete permission witch is not exist
		if _, exist := permissions[v]; exist == false {
			if ok, _ := e.DeletePermission(v); ok {
				_ = e.SavePolicy()
			}
		}
	}

	for _, v := range e.GetAllRoles() {
		// delete controller roles witch is not exist
		if _, exist := roles[v]; exist == false {
			if ok, _ := e.DeleteRole(v); ok {
				_ = e.SavePolicy()
			}
		}
	}

	for _, v := range e.GetPolicy() {
		// delete customer permission
		if strings.Contains(v[0], "role:") && (!strings.Contains(v[0], ":sys:") && !strings.Contains(v[0], ":ctr:")) {
			if ok, _ := e.RemoveGroupingPolicy(v); ok {
				_ = e.SavePolicy()
			}
		}
	}

	for _, v := range e.GetGroupingPolicy() {
		// delete customer roles
		if strings.Contains(v[0], "role:") && (!strings.Contains(v[0], ":sys:") && !strings.Contains(v[0], ":ctr:")) {
			if ok, _ := e.RemoveGroupingPolicy(v); ok {
				_ = e.SavePolicy()
			}
		}
	}

	(&helper.Flash{}).SetFlash(c, "角色重置成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")
}

// Create handles GET /admin/policy/create route
func (p *Policy) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	roles := e.GetAllRoles()
	policy := make(map[string][]string, 0)
	for _, v := range roles {
		if strings.Contains(v, ":ctr:") {
			policy[v] = make([]string, 0)
			// role has some permissions
			for _, i := range e.GetFilteredPolicy(0, v) {
				policy[v] = append(policy[v], i[1])
			}
		}
	}

	c.HTML(http.StatusOK, "policy/create", gin.H{
		"title":  "创建角色",
		"flash":  flash,
		"policy": policy,
	})
}

// Store handles POST /admin/policy/store route
func (p *Policy) Store(c *gin.Context) {
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	name := c.PostForm("name")
	roles := c.PostFormArray("roles[]")
	permissions := c.PostFormArray("permissions[]")

	// role must assignment to a user
	if ok, err := e.AddRoleForUser("user:"+name, "role:"+name); ok && err == nil {
		_ = e.SavePolicy()
	}

	for _, v := range roles {
		if ok, err := e.AddGroupingPolicy("role:"+name, v); ok && err == nil {
			_ = e.SavePolicy()
		}
	}
	for _, v := range permissions {
		permission := strings.Split(v, " ")
		if ok, err := e.AddPolicy("role:"+name, v, permission[0]); ok && err == nil {
			_ = e.SavePolicy()
		}
	}
	(&helper.Flash{}).SetFlash(c, "创建角色成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")
}

func (p *Policy) Edit(c *gin.Context) {

	role := c.Param("role")
	flash := (&helper.Flash{}).GetFlash(c)
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	roles := e.GetAllRoles()
	policy := make(map[string]map[string][]map[string]string, 0)
	for _, v := range roles {
		if strings.Contains(v, ":ctr:") {

			policy[v] = make(map[string][]map[string]string, 0)
			policy[v]["roles"] = make([]map[string]string, 0)
			policy[v]["permissions"] = make([]map[string]string, 0)

			item := make(map[string]string, 0)
			item["name"] = v
			item["allowed"] = "0"
			if allowed := e.HasGroupingPolicy("role:"+role, v); allowed {
				item["allowed"] = "1"
			}
			policy[v]["roles"] = append(policy[v]["roles"], item)

			// role has some permissions
			for _, p := range e.GetFilteredPolicy(0, v) {
				item := make(map[string]string, 0)
				item["name"] = p[1]
				item["allowed"] = "0"
				action := strings.Split(p[1], " ")
				allowed, _ := e.Enforce("user:"+role, p[1], action[0])
				if allowed {
					item["allowed"] = "1"
				}
				policy[v]["permissions"] = append(policy[v]["permissions"], item)
			}
		}
	}

	c.HTML(http.StatusOK, "policy/edit", gin.H{
		"title":  "编辑角色",
		"flash":  flash,
		"policy": policy,
		"role":   role,
	})
}

func (p *Policy) Update(c *gin.Context) {

	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")

	name := c.PostForm("name")
	old := c.Param("role")
	roles := c.PostFormArray("roles[]")
	permissions := c.PostFormArray("permissions[]")

	if ok, err := e.DeletePermissionsForUser("user:" + old); ok && err == nil {
		_ = e.SavePolicy()
	}

	if ok, err := e.DeletePermissionsForUser("role:" + old); ok && err == nil {
		_ = e.SavePolicy()
	}

	if ok, err := e.DeleteRolesForUser("user:" + old); ok && err == nil {
		_ = e.SavePolicy()
	}
	if ok, err := e.DeleteRolesForUser("role:" + old); ok && err == nil {
		_ = e.SavePolicy()
	}

	if ok, err := e.DeleteUser("user:" + old); ok && err == nil {
		_ = e.SavePolicy()
	}

	// role must assignment to a user

	if ok, err := e.AddRoleForUser("user:"+name, "role:"+name); ok && err == nil {
		_ = e.SavePolicy()
	}

	for _, v := range roles {
		if ok, err := e.AddGroupingPolicy("role:"+name, v); ok && err == nil {
			_ = e.SavePolicy()
		}
	}
	for _, v := range permissions {
		permission := strings.Split(v, " ")
		if ok, err := e.AddPolicy("role:"+name, v, permission[0]); ok && err == nil {
			_ = e.SavePolicy()
		}
	}

	(&helper.Flash{}).SetFlash(c, "修改角色成功", "success")
	c.Redirect(http.StatusFound, "/admin/policy")

}

func (p *Policy) Show(c *gin.Context) {
	role := c.Param("role")
	e, _ := casbin.NewEnforcer("config/rbac_model.conf", "config/rbac_policy.csv")
	_ = e

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
