package main

import (
	"gin/routers"
)

func main() {
	router := routers.Router()

	if err := router.Run(":8080"); err != nil{
		panic(err)
	}
}
