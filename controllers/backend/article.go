package backend

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Article struct {
	Base
}

// GetArticleList handles GET /admin/article route
func (_ *Article) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "article/index.html", gin.H{
		"title": "article list",
	})
}
