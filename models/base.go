package models

import (
	"time"
)

type Base struct {
	ID        uint64     `json:"id" form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `json:"created_at" form:"created_at"`
	UpdatedAt time.Time  `json:"updated_at" form:"updated_at"`
	DeletedAt *time.Time `json:"deleted_at" sql:"index"`
}
