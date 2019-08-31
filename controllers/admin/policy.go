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
	allRoles := e.GetAllRoles()
	for _, v := range allRoles {
		fmt.Println(v)
	}
	fmt.Println("所有角色和角色：")
	roles := e.GetAllSubjects()
	for _, v := range roles {
		fmt.Println(v)
	}
	fmt.Println("熊雅萱的角色：")
	roles, _ = e.GetRolesForUser("user:xiongyaxuan")
	for _, v := range roles {
		fmt.Println(v)
	}
	fmt.Println("所有权限：")
	permissions := e.GetAllObjects()
	for _, v := range permissions {
		fmt.Println(v)
	}

	fmt.Println("所有角色对应的角色：")
	ur := e.GetGroupingPolicy()
	for _, v := range ur {
		fmt.Println(v)
	}

	fmt.Println("权限关系列表：")
	up := e.GetPolicy()
	for _, v := range up {
		fmt.Println(v)
	}

	fmt.Println("熊雅萱的权限：")
	pp := e.GetPermissionsForUser("user:xiongyaxuan")
	for _, v := range pp {
		fmt.Println(v)
	}
	pp = e.GetPermissionsForUser("user:editor")
	for _, v := range pp {
		fmt.Println(v)
	}
	fmt.Println("熊雅萱所有权限：")
	pp, _ = e.GetImplicitPermissionsForUser("user:xiongyaxuan")
	for _, v := range pp {
		fmt.Println(v)
	}

	//if ok,err := e.AddRoleForUser("user:xiongjinchao","role:editor"); ok && err == nil{
	//	_  = e.SavePolicy()
	//}
	//if ok,err := e.AddPolicy("user:xiongjinchao", "/admin/article/:id", "POST"); ok && err == nil{
	//	_  = e.SavePolicy()
	//}
	/*
		allowed :=e.HasPermissionForUser("xiongyaxuan", "/admin/article", "GET")
		if allowed == true{
			println("xiongyaxuan can GET /admin/article")
		}
	*/

	// e.Enforce("alice", "data1", "read")

	// e.AddPolicy(...)
	// e.RemovePolicy(...)

	// e.SavePolicy()

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
