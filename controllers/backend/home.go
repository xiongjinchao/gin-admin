package backend

import (
	"fmt"
	"github.com/gin-gonic/gin"
)

type Home struct{}

// Index handles GET /admin route
func (_ *Home) Index(c *gin.Context) {
	fmt.Println("后台")
}
