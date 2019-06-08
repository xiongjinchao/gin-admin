package backend

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Article struct{}

// GetArticleList handles GET /admin/article route
func (_ *Article) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "backend/article/index", gin.H{
		"title": "article list",
	})
}
