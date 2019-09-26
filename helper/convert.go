package helper

import (
	"strconv"
)

type Helper struct{}

func Interface2Int64(data interface{}) (result int64) {
	var err error
	if data == nil {
		return 0
	}

	switch data.(type) {
	case string:
		result, err = strconv.ParseInt(data.(string), 10, 64)
		break
	case int:
		result = int64(data.(int))
		break
	case float64:
		result = int64(data.(float64))
		break
	}

	if err != nil {
		return 0
	}
	return
}
