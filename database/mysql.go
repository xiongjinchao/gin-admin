package database

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

const (
	MYSQL_USERNAME = "root"
	MYSQL_PASSWORD = "root"
	MYSQL_HOST     = "127.0.0.1"
	MYSQL_PORT     = "3306"
	MYSQL_DATABASE = "go"
)

var Mysql *sql.DB

// 这里没有用ORM *gorm.DB 用的是原生 *sql.DB
func init() {
	var err error
	Mysql, err = sql.Open("mysql", MYSQL_USERNAME+":"+MYSQL_PASSWORD+"@tcp("+MYSQL_HOST+":"+MYSQL_PORT+")/"+MYSQL_DATABASE+"?charset=utf8")
	if err != nil {
		panic(err)
	}

	Mysql.SetMaxIdleConns(20)
	Mysql.SetMaxOpenConns(20)

	if err = Mysql.Ping(); err != nil {
		panic(err)
	}
}
