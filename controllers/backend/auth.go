package backend

import (
	"encoding/json"
	"errors"
	"fmt"
	db "gin/database"
	"gin/models"
	"net/http"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Auth struct{}

//Login handles GET /login route
func (_ *Auth) Login(c *gin.Context) {

	flash, err := (&Base{}).GetFlash(c)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	c.HTML(http.StatusOK, "backend/auth/login", gin.H{
		"title": "Golang Blog",
		"flash": flash,
	})
}

//SignIn handles POST /sign-in route
func (_ *Auth) SignIn(c *gin.Context) {
	auth := models.Auth{}
	if err := c.ShouldBind(&auth); err != nil {
		(&Base{}).SetFlash(c, "APP", err)
		c.Redirect(http.StatusFound, "/login")
		return
	}

	if ok := (&Base{}).Validate(c, auth); ok == false {
		c.Redirect(http.StatusFound, "/login")
		return
	}

	user := models.User{}
	password := (&models.User{}).GeneratePassword(auth.Password)
	row := db.Mysql.QueryRow("SELECT `id`,`name`,`email`,`mobile`,`created_at`,`updated_at` FROM `user` WHERE mobile=? AND password=?", auth.Mobile, password)
	err := row.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile, &user.CreatedAt, &user.UpdatedAt)
	if err != nil {
		(&Base{}).SetFlash(c, "APP", errors.New("账号或密码错误，请重新输入"))
		c.Redirect(http.StatusFound, "/login")
		return
	}

	data, err := json.Marshal(user)
	if err != nil {
		(&Base{}).SetFlash(c, "APP", errors.New("系统错误，请联系管理员"))
		c.Redirect(http.StatusFound, "/login")
		return
	}

	// sign-in success
	session := sessions.Default(c)
	session.Set("auth", string(data))
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	c.Redirect(http.StatusFound, "/admin")
}

//Register handles GET /register route
func (_ *Auth) Register(c *gin.Context) {
	c.HTML(http.StatusOK, "backend/auth/register", gin.H{
		"title": "Golang Blog",
	})
}

//SignUp handles POST /sign-up route
func (_ *Auth) SignUp(c *gin.Context) {
	fmt.Println("Golang Blog")
}

func (_ *Auth) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("auth")
	session.Clear()
	c.Redirect(http.StatusFound, "/login")
}
