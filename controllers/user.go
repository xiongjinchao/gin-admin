package controllers

import (
	"fmt"
	db "gin/database"
	"gin/helper"
	"gin/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type User struct{}

// Index handles GET /admin/user route
func (_ *User) Index(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)
	c.HTML(http.StatusOK, "user/index", gin.H{
		"title": "用户管理",
		"flash": flash,
	})
}

func (_ *User) Data(c *gin.Context) {

	var user []models.User

	query := db.Mysql.Model(&models.User{})

	search := c.Query("search[value]")
	if search != "" {
		query = query.Where("id = ?", search).
			Or("name LIKE ?", "%"+search+"%").
			Or("email LIKE ?", "%"+search+"%").
			Or("mobile LIKE ?", "%"+search+"%")
	}
	total := 0
	query.Count(&total)

	order := c.Query("order[0][column]")
	sort := c.Query("order[0][dir]")
	query = query.Offset(c.Query("start")).Limit(c.Query("length"))

	switch order {
	case "1":
		query = query.Order("name " + sort)
	case "2":
		query = query.Order("email " + sort)
	case "3":
		query = query.Order("mobile " + sort)
	case "4":
		query = query.Order("created_at " + sort)
	case "5":
		query = query.Order("updated_at " + sort)
	default:
		query = query.Order("id " + sort)
	}

	err := query.Scan(&user).Error
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.JSON(http.StatusOK, gin.H{
		"draw":            c.Query("draw"),
		"recordsTotal":    len(user),
		"recordsFiltered": total,
		"data":            user,
	})
}

// Create handles GET /admin/user/create route
func (_ *User) Create(c *gin.Context) {

	flash := (&helper.Flash{}).GetFlash(c)

	c.HTML(http.StatusOK, "user/create", gin.H{
		"title": "创建用户",
		"flash": flash,
	})
}

// Store handles POST /admin/user/store route
func (_ *User) Store(c *gin.Context) {

	user := models.User{}
	if err := c.ShouldBind(&user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := (&helper.Validate{}).ValidateStr(user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}

	if err := (&helper.Validate{}).ValidateVar(user.Password, "gte=6,lte=18"); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}
	user.Password = user.GeneratePassword(user.Password)

	err := db.Mysql.Model(&models.User{}).Create(&user).Error
	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/create")
		return
	}
	(&helper.Flash{}).SetFlash(c, "添加成功", "success")
	c.Redirect(http.StatusFound, "/admin/user")
}

func (_ *User) Edit(c *gin.Context) {

	id := c.Param("id")
	flash := (&helper.Flash{}).GetFlash(c)

	user := models.User{}
	if err := db.Mysql.First(&user, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/edit", gin.H{
		"title": "编辑用户",
		"user":  user,
		"flash": flash,
	})
}

func (_ *User) Update(c *gin.Context) {

	id := c.Param("id")
	user := models.User{}
	if err := c.ShouldBind(&user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}
	if user.Password != "" {
		if err := (&helper.Validate{}).ValidateVar(user.Password, "gte=6,lte=18"); err != nil {
			(&helper.Flash{}).SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
			return
		}
		user.Password = user.GeneratePassword(user.Password)
	}
	if err := (&helper.Validate{}).ValidateStr(user); err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}
	err := db.Mysql.Model(&models.User{}).Where("id = ?", id).Updates(user).Error
	if err != nil {
		(&helper.Flash{}).SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/user/edit/"+id)
		return
	}
	(&helper.Flash{}).SetFlash(c, "修改成功", "success")
	c.Redirect(http.StatusFound, "/admin/user")

}

func (_ *User) Show(c *gin.Context) {
	id := c.Param("id")

	user := models.User{}
	if err := db.Mysql.First(&user, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	c.HTML(http.StatusOK, "user/show", gin.H{
		"title": "查看用户",
		"user":  user,
	})
}

func (_ *User) Destroy(c *gin.Context) {
	id := c.Param("id")
	user := models.User{}
	err := db.Mysql.Where("id = ?", id).Delete(&user).Error
	if err == nil {
		c.Redirect(301, "/admin/user")
	}
}
