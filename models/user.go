package models

import (
	"crypto/md5"
	"crypto/sha1"
	"encoding/hex"
	"gin-admin/config"
	"github.com/dgrijalva/jwt-go"
	"time"
)

type User struct {
	Base        `json:"base"`
	Name        string `label:"昵称" json:"name" form:"name" validate:"required"`
	Email       string `label:"邮箱" json:"email" form:"email"`
	Mobile      string `label:"手机号码" json:"mobile" form:"mobile"`
	Password    string `label:"密码" json:"-" form:"password"`
	AccessToken string `label:"AccessToken" json:"access_token" form:"access_token"`
	ResetKey    string `label:"ResetKey" json:"reset_key" form:"reset_key"`
}

func (User) TableName() string {
	return "user"
}

func (u *User) GeneratePassword() {
	s := sha1.New()
	s.Write([]byte(u.Password))
	u.Password = hex.EncodeToString(s.Sum([]byte("")))
}

func (u *User) GenerateToken(id int64) (accessToken, resetKey string, err error) {

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"id":  id,
		"exp": time.Now().Add(time.Hour * 72).Unix(),
		"nbf": time.Now().Unix(),
		"iat": time.Now().Unix(),
	})

	accessToken, err = token.SignedString([]byte(config.Setting["jwt"]["secret"]))
	s := md5.New()
	s.Write([]byte(accessToken))
	resetKey = hex.EncodeToString(s.Sum([]byte("")))
	return
}
