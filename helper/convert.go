package helper

import (
	"encoding/json"
	"reflect"
	"strconv"
)

type Convert struct{}

// Struct to json
func (c *Convert) Str2Json(data interface{}) (string, error) {
	result, err := json.Marshal(data)
	return string(result), err
}

// Struct to map
func (c *Convert) Str2Map(data interface{}) map[string]interface{} {
	typ := reflect.TypeOf(data)
	val := reflect.ValueOf(data)
	result := make(map[string]interface{})
	for i := 0; i < typ.NumField(); i++ {
		result[typ.Field(i).Tag.Get("json")] = val.Field(i).Interface()
	}
	return result
}

// Map to json
func (c *Convert) Map2Json(data map[string]interface{}) (string, error) {
	result, err := json.Marshal(data)
	return string(result), err
}

// Json to map
func (c *Convert) Json2Map(data string) (map[string]interface{}, error) {
	result := make(map[string]interface{})
	err := json.Unmarshal([]byte(data), &result)
	return result, err
}

// String to int
func (c *Convert) Str2Int(str string) int {
	i, err := strconv.Atoi(str)
	if err != nil {
		return 0
	}
	return i
}

// String to int64
func (c *Convert) Str2Int64(str string) int64 {
	i, err := strconv.ParseInt(str, 10, 64)
	if err != nil {
		return 0
	}
	return i
}

// String to uint
func (c *Convert) Str2UInt(str string) uint {
	i, err := strconv.Atoi(str)
	if err != nil {
		return 0
	}
	return uint(i)
}
