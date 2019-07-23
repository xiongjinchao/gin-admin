package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type File struct{}

// Upload handles POST /admin/file/upload route
func (_ *File) Upload(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "文件上传",
	})
}

// Delete handles GET /admin/file/delete route
func (_ *File) Delete(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "删除文件",
	})
}
