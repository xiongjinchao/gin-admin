package admin

import (
	db "gin-admin/database"
	"gin-admin/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
	"runtime"
	"time"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Dashboard(c *gin.Context) {
	hostName, err := os.Hostname()
	if err != nil {
		hostName = "Unknown"
	}
	memStat := runtime.MemStats{}
	runtime.ReadMemStats(&memStat)

	type System struct {
		Type         string
		Architecture string
		CPU          int
		HostName     string
		MemorySys    uint64
		MemorySelf   uint64
	}
	var system System
	system.Type = runtime.GOOS
	system.Architecture = runtime.GOARCH
	system.CPU = runtime.NumCPU()
	system.HostName = hostName
	system.MemorySys = memStat.Sys / 1024 / 1024
	system.MemorySelf = memStat.Alloc / 1024 / 1024

	type Counts struct {
		UserMonthly     int64
		ArticleWeekly   int64
		Book            int64
		FavoriteMonthly int64
		CommentMonthly  int64
	}
	var counts Counts
	month := time.Now().AddDate(0, -1, 0).Format("2006-01-02 15:04:05")
	week := time.Now().AddDate(0, 0, -7).Format("2006-01-02 15:04:05")

	db.Mysql.Model(&models.User{}).Where("created_at > ?", month).Count(&counts.UserMonthly)
	db.Mysql.Model(&models.Article{}).Where("created_at > ?", week).Count(&counts.ArticleWeekly)
	db.Mysql.Model(&models.Book{}).Count(&counts.Book)
	db.Mysql.Model(&models.ActionLog{}).Where("created_at > ?", month).Count(&counts.FavoriteMonthly)
	db.Mysql.Model(&models.Comment{}).Where("created_at > ?", month).Count(&counts.CommentMonthly)

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title":  "系统面板",
		"system": system,
		"counts": counts,
	})
}
