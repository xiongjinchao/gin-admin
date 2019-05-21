package models

import (
	"fmt"
	db "gin/database"
	"time"
)

type User struct {
	Id     int64  `json:"id" form:"id"`
	Name   string `json:"name" form:"name"`
	Email  string `json:"email" form:"email"`
	Mobile string `json:"mobile" form:"mobile"`
	RememberToken string `json:"remember_token" form:"remember_token"`
	CreatedAt time.Time  `json:"created_at"`
	UpdateAt time.Time   `json:"updated_at"`
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

func (m *User)CreateUser(user User) {
	stmt, _ := db.Mysql.Prepare("INSERT INTO `user` (`name`,`email`,`mobile`,`remember_token`,`created_at`,`updated_at`)values(?,?,?,?,?,?)")
	defer stmt.Close()
	row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.RememberToken, time.Now(), time.Now())
	if err != nil {
		panic(err)
	}
	user.Id, err = row.LastInsertId()
	if err != nil {
		panic(err)
	}
	return
}

func (m *User)UpdateUser(user User) {
	stmt, _ := db.Mysql.Prepare("UPDATE `user` (`name`,`email`,`mobile`,`remember_token`,`created_at`,`updated_at`)values(?,?,?,?,?,?) WHERE `id` = ? ")
	defer stmt.Close()
	row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.RememberToken, time.Now(), time.Now(),user.Id)
	if err != nil {
		panic(err)
	}
	if _, err = row.RowsAffected(); err != nil {
		panic(err)
	}
	return
}

func (m *User)DeleteUser(id string) (int64, error) {
	stmt, _ := db.Mysql.Prepare("DELETE FROM `user` WHERE `id` = ?")
	defer stmt.Close()
	rows, err := stmt.Exec(id)
	if err!=nil{
		panic(err)
	}
	return rows.RowsAffected()
}
