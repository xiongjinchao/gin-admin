package database

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

var Mysql *sql.DB

func init() {
	var err error
	Mysql, err = sql.Open("mysql", "root:root@tcp(127.0.0.1:3306)/go?charset=utf8")
	if err != nil {
		panic(err)
	}

	//Mysql.SetMaxIdleConns(20)
	//Mysql.SetMaxOpenConns(20)
	if err = Mysql.Ping(); err != nil {
		panic(err)
	}
}
