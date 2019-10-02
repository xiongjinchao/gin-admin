package admin

import (
	"gin-admin/config"
	db "gin-admin/database"
	"gin-admin/models"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	uuid "github.com/satori/go.uuid"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"math"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

type File struct{}

// Upload handles POST /admin/file/upload route
func (f *File) Upload(c *gin.Context) {
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

	creator, err := os.Create(path + "/" + name)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	_, err = io.Copy(creator, file)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	_ = creator.Close()

	opener, err := os.Open(path + "/" + name)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	defer func() {
		_ = opener.Close()
	}()
	picture, _, err := image.DecodeConfig(opener)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	session := sessions.Default(c)
	auth := session.Get("auth")

	identification, err := (&models.Admin{}).ParseAuth(auth.(string))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	ratio := float64(picture.Width) / float64(picture.Height)
	model := &models.File{}
	model.Name = name
	model.Category = category
	model.Path = "/" + path + "/" + name
	model.Width = picture.Width
	model.Height = picture.Height
	model.Size = header.Size
	model.Ratio = math.Trunc(ratio*1e2+0.5) * 1e-2
	model.UserID = identification.ID

	if err := db.Mysql.Model(&models.File{}).Save(&model).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}

	domain := config.Setting["app"]["domain"]
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
func (f *File) Delete(c *gin.Context) {
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
