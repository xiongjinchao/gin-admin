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
		key := typ.Field(i).Tag.Get("json")
		if key == "" {
			key = typ.Field(i).Name
		}
		if reflect.TypeOf(val.Field(i).Interface()).String() == "models.Base" {
			result[key] = c.Str2Map(val.Field(i).Interface())
		} else {
			result[key] = val.Field(i).Interface()
		}
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

// int64 to String
func (c *Convert) Int642Str(i int64) string {
	return strconv.FormatInt(i, 10)
}

// int64 to int
func (c *Convert) Int642Int(i int64) int {
	str := c.Int642Str(i)
	return c.Str2Int(str)
}

// String to uint
func (c *Convert) Str2UInt(str string) uint {
	i, err := strconv.Atoi(str)
	if err != nil {
		return 0
	}
	return uint(i)
}
