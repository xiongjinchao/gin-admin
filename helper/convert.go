package helper

import (
	"reflect"
)

type Convert struct{}

func (c *Convert) Interface2Int64(data interface{}) int64 {
	if data == nil {
		return 0
	}
	if reflect.TypeOf(data).String() == "float64" {
		return int64(data.(float64))
	}
	return data.(int64)
}
