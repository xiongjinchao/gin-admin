package database

import (
	"github.com/go-redis/redis"
)

const (
	REDIS_HOST     = "127.0.0.1"
	REDIS_PORT     = "6379"
	REDIS_PASSWORD = ""
	REDIS_DATABASE = 0
)

var Redis *redis.Client

func init() {
	Redis = redis.NewClient(&redis.Options{
		Addr:     REDIS_HOST + ":" + REDIS_PORT,
		Password: REDIS_PASSWORD, // no password set
		DB:       REDIS_DATABASE, // use default DB
	})
}
