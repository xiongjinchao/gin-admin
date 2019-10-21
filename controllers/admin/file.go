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

	/* 获取项目根目录的上一级目录
	parent, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  "failure",
			"message": err.Error(),
			"data":    "",
		})
		return
	}
	runes := []rune(parent)
	l := 0 + strings.LastIndex(parent, "/")
	if l > len(runes) {
		l = len(runes)
	}
	parent = string(runes[0:l])
	*/

	path := "uploads/" + category + "/" + time.Now().Format("2006-01-02")
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

	domain := config.Setting["domain"]["image"]
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

	if err := db.Mysql.Where("id = ?", id).Delete(&models.File{}).Error; err != nil {
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

// Upload handles POST /admin/file/editor-upload route
func (f *File) EditorUpload(c *gin.Context) {
	file, header, err := c.Request.FormFile("editormd-image-file")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": 0,
			"message": err.Error(),
			"url":     "",
		})
		return
	}
	id, _ := uuid.NewV4()
	ext := filepath.Ext(header.Filename)
	name := id.String() + ext
	category := c.Query("category")
	if category == "" {
		category = "other"
	}

	path := "uploads/" + category + "/" + time.Now().Format("2006-01-02")
	err = os.MkdirAll(path, os.ModePerm)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": 0,
			"message": err.Error(),
			"url":     "",
		})
		return
	}

	creator, err := os.Create(path + "/" + name)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": 0,
			"message": err.Error(),
			"url":     "",
		})
		return
	}
	_, err = io.Copy(creator, file)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"success": 0,
			"message": err.Error(),
			"url":     "",
		})
		return
	}
	_ = creator.Close()

	domain := config.Setting["domain"]["image"]
	c.JSON(http.StatusCreated, gin.H{
		"success": 1,
		"message": "upload success",
		"url":     domain + "/" + path + "/" + name,
	})
}
