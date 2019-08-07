package models

import (
	"reflect"
	"time"
)

type Base struct {
	ID        int64      `json:"id" form:"id" gorm:"primary_key"`
	CreatedAt time.Time  `json:"created_at" form:"created_at"`
	UpdatedAt time.Time  `json:"updated_at" form:"updated_at"`
	DeletedAt *time.Time `json:"deleted_at" sql:"index"`
}

func (m *Base) Convert2Map(data interface{}) map[string]interface{} {
	typ := reflect.TypeOf(data)
	val := reflect.ValueOf(data)
	result := make(map[string]interface{})
	for i := 0; i < typ.NumField(); i++ {
		key := typ.Field(i).Tag.Get("json")
		if key == "" {
			key = typ.Field(i).Name
		}
		if val.Field(i).Type() == reflect.TypeOf(*m) {
			result[key] = m.Convert2Map(val.Field(i).Interface())
		} else {
			result[key] = val.Field(i).Interface()
		}
	}
	return result
}
