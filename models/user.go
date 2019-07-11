package models

import (
	"crypto/sha1"
	"encoding/hex"
	_ "time"
)

type User struct {
	Base
	Name          string `json:"name" form:"name" validate:"required" gorm:"unique_index"`
	Email         string `json:"email" form:"email" validate:"email" gorm:"unique_index"`
	Mobile        string `json:"mobile" form:"mobile" validate:"required,numeric,len=11" gorm:"unique_index"`
	Password      string `json:"-" form:"password"`
	RememberToken string `json:"-" form:"remember_token"`
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
