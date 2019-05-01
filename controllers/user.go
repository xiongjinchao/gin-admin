package controllers

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

// GetUserList handles GET /admin/login route
func GetUserList(c *gin.Context) {
	fmt.Println("get user list")
}
