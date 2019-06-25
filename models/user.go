package models

import (
	"crypto/sha1"
	"encoding/hex"
	"github.com/jinzhu/gorm"
	_ "time"
)

type User struct {
	gorm.Model
	Name          string `json:"name" form:"name" validate:"required"`
	Email         string `json:"email" form:"email" validate:"email"`
	Mobile        string `json:"mobile" form:"mobile" validate:"required,numeric,len=11"`
	Password      string `json:"password" form:"password" validate:"required,gte=6,lte=18"`
	RememberToken string `json:"remember_token" form:"remember_token"`
}

func (User) TableName() string {
	return "user"
}

func (m *User) GeneratePassword(password string) string {
	s := sha1.New()
	s.Write([]byte(password))
	password = hex.EncodeToString(s.Sum([]byte("")))
	return password
}
