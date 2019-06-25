package database

import (
	"github.com/go-redis/redis"
)

const (
	RedisHost     = "127.0.0.1"
	RedisPort     = "6379"
	RedisPassword = ""
	RedisDatabase = 0
)

var Redis *redis.Client
