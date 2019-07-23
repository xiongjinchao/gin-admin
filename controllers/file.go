package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type File struct{}

// Upload handles GET /admin/file/upload route
func (_ *Home) Upload(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "文件上传",
	})
}

// Delete handles GET /admin/file/delete route
func (_ *Home) Delete(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "删除文件",
	})
}
