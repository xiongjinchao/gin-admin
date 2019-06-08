package frontend

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Article struct{}

// GetArticleList handles GET /article route
func (_ *Article) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "/frontend/article/index", gin.H{
		"title": "article list",
	})
}
