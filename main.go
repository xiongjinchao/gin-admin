package main

import (
	"encoding/json"
	"gin/config"
	db "gin/database"
	"gin/routers"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"strconv"
	"strings"
)

func main() {
	// Debug Mode
	gin.SetMode(config.Setting["app"]["model"])

	// Mysql
	var err error
	var setting = config.Setting
	if db.Mysql, err = gorm.Open(
		"mysql",
		setting["mysql"]["username"]+":"+setting["mysql"]["password"]+"@tcp("+setting["mysql"]["host"]+":"+setting["mysql"]["port"]+")/"+setting["mysql"]["database"]+"?charset=utf8&parseTime=true&loc=Local",
	); err != nil {
		panic(err)
	}
	defer func() {
		_ = db.Mysql.Close()
	}()

	// Redis
	redisDB, _ := strconv.Atoi(setting["redis"]["database"])
	db.Redis = redis.NewClient(&redis.Options{
		Addr:     setting["redis"]["host"] + ":" + setting["redis"]["port"],
		Password: setting["redis"]["password"],
		DB:       redisDB,
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

	// write all routes in redis
	routing := make([]map[string]string, 0)
	for _, v := range router.Routes() {
		if strings.Contains(v.Path, "admin") {
			item := make(map[string]string, 0)
			item["method"] = v.Method
			end := strings.Index(v.Path, "/:")
			if end > 0 {
				item["path"] = v.Path[0:end]
			} else {
				item["path"] = v.Path
			}
			routing = append(routing, item)
		}
	}
	data, err := json.Marshal(routing)
	if err != nil {
		panic(err)
	}

	(&gin.Context{}).Set("routers", string(data))
	db.Redis.Set("routers", string(data), 0)

	if err := router.Run(":8080"); err != nil {
		panic(err)
	}
}
