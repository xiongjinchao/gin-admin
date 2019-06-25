package database

import (
	"github.com/jinzhu/gorm"
)

const (
	MysqlUsername = "root"
	MysqlPassword = "root"
	MysqlHost     = "127.0.0.1"
	MysqlPort     = "3306"
	MysqlDatabase = "go"
)

var Mysql *gorm.DB
