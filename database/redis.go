package database

import (
	"github.com/go-redis/redis"
)

const (
	REDISHOST     = "127.0.0.1"
	REDISPORT     = "6379"
	REDISPASSWORD = ""
	REDISDATABASE = 0
)

var Redis *redis.Client

func init() {
	Redis = redis.NewClient(&redis.Options{
		Addr:     REDISHOST + ":" + REDISPORT,
		Password: REDISPASSWORD, // no password set
		DB:       REDISDATABASE, // use default DB
	})
}
