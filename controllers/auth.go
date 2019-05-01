package controllers

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func GetLogin(c *gin.Context) {
	fmt.Println("get login")
}

func PostLogin(c *gin.Context) {
	fmt.Println("post login")
}
