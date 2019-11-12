package helper

import (
	"encoding/json"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

// set flash data
func SetFlash(c *gin.Context, data interface{}, key string) {
	session := sessions.Default(c)
	session.AddFlash(data, key)
	_ = session.Save()
}

// get flash data
func GetFlash(c *gin.Context) (data map[string]interface{}) {
	session := sessions.Default(c)

	data = make(map[string]interface{})
	success := make([]interface{}, 0)
	errors := make([]interface{}, 0)
	old := make(map[string]interface{})

	for _, flash := range session.Flashes("success") {
		success = append(success, flash.(string))
	}

	for _, flash := range session.Flashes("error") {
		errors = append(errors, flash.(string))
	}

	for _, flash := range session.Flashes("old") {

		item := make(map[string]interface{})
		if err := json.Unmarshal([]byte(flash.(string)), &item); err == nil {
			for k, v := range item {
				old[k] = v
			}
		}
	}
	data["success"] = success
	data["error"] = errors
	data["old"] = old

	_ = session.Save()
	return data
}
