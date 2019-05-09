package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// GetUserList handles GET /admin/article route
func GetArticleList(c *gin.Context) {
	c.HTML(http.StatusOK,"index.html",gin.H{
		"title": "article list",
	})
}
