package database

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

const (
	MYSQLUSERNAME = "root"
	MYSQLPASSWORD = "root"
	MYSQLHOST     = "127.0.0.1"
	MYSQLPORT     = "3306"
	MYSQLDATABASE = "go"
)

var Mysql *sql.DB

// 这里没有用ORM *gorm.DB 用的是原生 *sql.DB
func init() {
	var err error
	Mysql, err = sql.Open("mysql", MYSQLUSERNAME+":"+MYSQLPASSWORD+"@tcp("+MYSQLHOST+":"+MYSQLPORT+")/"+MYSQLDATABASE+"?charset=utf8")
	if err != nil {
		panic(err)
	}

	Mysql.SetMaxIdleConns(20)
	Mysql.SetMaxOpenConns(20)

	if err = Mysql.Ping(); err != nil {
		panic(err)
	}
}
