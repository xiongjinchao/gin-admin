package main

import (
	"gin/routers"
	"github.com/gin-gonic/gin"
	"io"
	"os"
)

func main() {
	// Disable Console Color, you don't need console color when writing the logs to file.
	gin.DisableConsoleColor()

	// Logging to a file.
	log, err := os.Create("logs/gin.log")
	if err != nil {
		panic(err)
	}

	gin.DefaultWriter = io.MultiWriter(log)

	router := routers.Router()

	if err := router.Run(":8080"); err != nil {
		panic(err)
	}
}
