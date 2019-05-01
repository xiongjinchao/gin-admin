package main

import (
	"gin/routers"
)

func main() {
	router := routers.Router()

	router.Run(":8080")
}
