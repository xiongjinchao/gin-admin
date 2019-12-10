package admin

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
	"runtime"
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

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "系统面板",
		"system": gin.H{
			"type":         runtime.GOOS,
			"architecture": runtime.GOARCH,
			"CUP":          runtime.GOMAXPROCS(0),
			"hostName":     hostName,
			"memoryTotal":  memStat.TotalAlloc / 1024 / 1024,
			"memorySys":    memStat.Sys / 1024 / 1024,
			"memorySelf":   memStat.Alloc / 1024 / 1024,
		},
	})
}
