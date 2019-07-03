package helper

import (
	"fmt"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
)

type Flash struct{}

// set flash data
func (_ *Flash) SetFlash(c *gin.Context, data string) {
	session := sessions.Default(c)
	session.AddFlash(data)
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
}

// get flash data
func (_ *Flash) GetFlash(c *gin.Context) (data []string) {
	session := sessions.Default(c)
	flashes := session.Flashes()
	for _, flash := range flashes {
		data = append(data, flash.(string))
	}
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return data
}
