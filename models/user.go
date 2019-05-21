package models

import (
	"fmt"

	db "gin/database"
)

type User struct {
	Id     int    `json:"id" form:"id"`
	Name   string `json:"name" form:"name"`
	Email  string `json:"email" form:"email"`
	Mobile string `json:"mobile" form:"mobile"`
}

func (m *User)GetUserList() (users []User) {
	err := db.Redis.Set("name","xiongjinchao",0).Err()
	if err != nil{
		panic(err)
	}

	fmt.Println(db.Redis.Get("name"))
	rows, err := db.Mysql.Query("SELECT `id`,`name`,`email`,`mobile` FROM `user`")
	defer rows.Close()
	defer db.Mysql.Close()
	if err != nil {
		panic(err)
	}

	for rows.Next() {
		var user User
		if err := rows.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile); err != nil {
			users = append(users, user)
		}
	}
	if err = rows.Err(); err != nil {
		panic(err)
	}
	return
}

func (m *User)GetUser(id string) (user User) {
	row := db.Mysql.QueryRow("SELECT `id`,`name`,`email`,`mobile` FROM `user` WHERE id=?", id)
	defer db.Mysql.Close()
	if err := row.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile); err != nil {
		panic(err)
	}
	return
}
