package helper

import (
	"fmt"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Flash struct{}

// set flash data
func (_ *Flash) SetFlash(c *gin.Context, data interface{}, key string) {
	session := sessions.Default(c)
	session.AddFlash(data, key)
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
}

// get flash data
func (_ *Flash) GetFlash(c *gin.Context) (data map[string][]interface{}) {
	session := sessions.Default(c)

	data = make(map[string][]interface{})
	data["success"] = make([]interface{}, 0)
	data["error"] = make([]interface{}, 0)
	data["old"] = make([]interface{}, 0)

	for _, flash := range session.Flashes("success") {
		data["success"] = append(data["success"], flash.(string))
	}
	for _, flash := range session.Flashes("error") {
		data["error"] = append(data["error"], flash.(string))
	}

	data["old"] = session.Flashes("old")

	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return data
}
