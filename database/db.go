package database

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

var Db *sql.DB

func init() {
	var err error
	Db, err = sql.Open("mysql", "root:root@tcp(127.0.0.1:3306)/go?charset=utf8")
	if err != nil {
		panic(err)
	}

	Db.SetMaxIdleConns(20)
	Db.SetMaxOpenConns(20)
	if err = Db.Ping(); err != nil {
		panic(err)
	}
}
