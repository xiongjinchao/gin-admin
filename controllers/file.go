package controllers

import (
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	uuid "github.com/satori/go.uuid"
	db "github.com/xiongjinchao/gin/database"
	"github.com/xiongjinchao/gin/helper"
	"github.com/xiongjinchao/gin/models"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

type File struct{}

// Upload handles POST /admin/file/upload route
func (_ *File) Upload(c *gin.Context) {
	file, header, err := c.Request.FormFile("file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	id, _ := uuid.NewV4()
	ext := filepath.Ext(header.Filename)
	name := id.String() + ext
	category := c.PostForm("category")
	if category == "" {
		category = "other"
	}

	path := "public/uploads/" + category + "/" + time.Now().Format("2006-01-02")
	err = os.MkdirAll(path, os.ModePerm)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	out, err := os.Create(path + "/" + name)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	defer func() {
		_ = out.Close()
	}()
	_, err = io.Copy(out, file)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	session := sessions.Default(c)
	auth := session.Get("base-auth")
	user, err := (&helper.Convert{}).Json2Map(auth.(string))

	model := &models.File{}
	model.Name = name
	model.Category = category
	model.Path = "/" + path + "/" + name
	model.Width = 100
	model.Height = 100
	model.Size = header.Size
	model.Ratio = 1
	model.UserID = int64(user["id"].(float64))

	if err := db.Mysql.Model(&models.File{}).Save(&model).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	domain := "http://localhost:8080"
	c.JSON(http.StatusCreated, gin.H{
		"status":  "success",
		"message": "upload success",
		"data": gin.H{
			"url":  domain + model.Path,
			"name": model.Name,
			"path": model.Path,
			"size": model.Size,
			"key":  model.ID,
		},
	})
}

// Delete handles POST /admin/file/delete route
func (_ *File) Delete(c *gin.Context) {
	id := c.PostForm("key")

	file := models.File{}
	if err := db.Mysql.Where("id = ?", id).Delete(&file).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"status":  "success",
		"message": "delete success",
		"data":    "",
	})
}
