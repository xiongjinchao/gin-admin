package helper

import (
	"encoding/json"
	"reflect"
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
