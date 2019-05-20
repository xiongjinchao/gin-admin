package models

import (
	db "gin/database"
	"log"
)

type User struct {
	Id     int    `json:"id" form:"id"`
	Name   string `json:"name" form:"name"`
	Email  string `json:"email" form:"email"`
	Mobile string `json:"mobile" form:"mobile"`
}

func GetUserList() []User {
	rows, err := db.Mysql.Query("SELECT `id`,`name`,`email`,`mobile` FROM `user`")
	if err != nil {
		log.Fatalln(err)
	}

	users := make([]User, 0)
	for rows.Next() {
		var user User
		_ = rows.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile)
		users = append(users, user)
	}
	if err = rows.Err(); err != nil {
		log.Fatalln(err)
	}
	return users
}

func GetUser(id string) User {
	var user User
	_ = db.Mysql.QueryRow("SELECT `id`,`name`,`email`,`mobile` FROM `user` WHERE id=?", id).Scan(&user.Id, &user.Name, &user.Email, &user.Mobile)
	return user
}
