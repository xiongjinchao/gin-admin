package main

import (
	"gin/routers"
)

func main() {
	// Log
	/*
		gin.DisableConsoleColor()

		log, err := os.Create("logs/gin.log")
		if err != nil {
			panic(err)
		}

		gin.DefaultWriter = io.MultiWriter(log)
	*/

	router := routers.Router()

	if err := router.Run(":8080"); err != nil {
		panic(err)
	}
}
