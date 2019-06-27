package main

import (
	db "gin/database"
	"gin/routers"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis"
	"github.com/jinzhu/gorm"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

func main() {
	// Debug Mode
	gin.SetMode(gin.DebugMode)

	// Mysql
	var err error
	if db.Mysql, err = gorm.Open("mysql", db.MysqlUsername+":"+db.MysqlPassword+"@tcp("+db.MysqlHost+":"+db.MysqlPort+")/"+db.MysqlDatabase+"?charset=utf8&parseTime=true&loc=Local"); err != nil {
		panic(err)
	}
	defer func() {
		_ = db.Mysql.Close()
	}()

	// Redis
	db.Redis = redis.NewClient(&redis.Options{
		Addr:     db.RedisHost + ":" + db.RedisPort,
		Password: db.RedisPassword,
		DB:       db.RedisDatabase,
	})

	// Log
	gin.ForceConsoleColor()
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
