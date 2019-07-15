package models

import (
	"crypto/md5"
	"crypto/sha1"
	"encoding/hex"
	"gin/config"
	"github.com/dgrijalva/jwt-go"
	"time"
)

type User struct {
	Base
	Name        string `json:"name" form:"name" validate:"required" gorm:"unique_index"`
	Email       string `json:"email" form:"email" validate:"email" gorm:"unique_index"`
	Mobile      string `json:"mobile" form:"mobile" validate:"required,numeric,len=11" gorm:"unique_index"`
	Password    string `json:"-" form:"password"`
	AccessToken string `json:"access_token" form:"access_token"`
	RestKey     string `json:"reset_key" form:"reset_key"`
}

func (User) TableName() string {
	return "user"
}

func (m *User) GeneratePassword(password string) string {
	s := sha1.New()
	s.Write([]byte(password))
	return hex.EncodeToString(s.Sum([]byte("")))
}

func (m *User) GenerateToken(id int64) (accessToken, restKey string, err error) {
	d, _ := time.ParseDuration("10d")
	expire := time.Now().Add(d).Unix()

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"id":  id,
		"nbf": expire,
	})

	accessToken, err = token.SignedString(config.Setting["jwt"]["secret"])
	s := md5.New()
	s.Write([]byte(accessToken))
	restKey = hex.EncodeToString(s.Sum([]byte("")))
	return
}
