package models

import (
	"crypto/sha1"
	"encoding/hex"
	"fmt"
	db "gin/database"
	"time"
)

type User struct {
	Id            int64     `json:"id" form:"id"`
	Name          string    `json:"name" form:"name"`
	Email         string    `json:"email" form:"email"`
	Mobile        string    `json:"mobile" form:"mobile"`
	Password      string    `json:"password" form:"password"`
	RememberToken string    `json:"remember_token" form:"remember_token"`
	CreatedAt     time.Time `json:"created_at"`
	UpdateAt      time.Time `json:"updated_at"`
}

func (m *User) GetUserList() (users []User) {
	fmt.Println(db.Redis.Get("name"))
	rows, err := db.Mysql.Query("SELECT `id`,`name`,`email`,`mobile` FROM `user`")
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

func (m *User) GetUser(id int64) (user User) {
	row := db.Mysql.QueryRow("SELECT `id`,`name`,`email`,`mobile`,`password` FROM `user` WHERE id=?", id)
	if err := row.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile, &user.Password); err != nil {
		panic(err)
	}
	return
}

func (m *User) CreateUser() int64 {
	user := *m
	user.Password = m.GeneratePassword(user.Password)
	stmt, _ := db.Mysql.Prepare("INSERT INTO `user` (`name`,`email`,`mobile`,`password`,`remember_token`,`created_at`,`updated_at`)values(?,?,?,?,?,?,?)")
	row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.Password, user.RememberToken, time.Now(), time.Now())
	if err != nil {
		panic(err)
	}
	user.Id, err = row.LastInsertId()
	if err != nil {
		panic(err)
	}
	return user.Id
}

func (m *User) UpdateUser() int64 {
	user := *m
	user.Password = m.GeneratePassword(user.Password)
	stmt, _ := db.Mysql.Prepare("UPDATE `user` (`name`,`email`,`mobile`,`password`,`remember_token`,`updated_at`)values(?,?,?,?,?,?) WHERE `id` = ? ")
	row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.Password, user.RememberToken, time.Now(), user.Id)
	if err != nil {
		panic(err)
	}
	if _, err = row.RowsAffected(); err != nil {
		panic(err)
	}
	return user.Id
}

func (m *User) DeleteUser(id string) (int64, error) {
	stmt, _ := db.Mysql.Prepare("DELETE FROM `user` WHERE `id` = ?")
	rows, err := stmt.Exec(id)
	if err != nil {
		panic(err)
	}
	return rows.RowsAffected()
}

func (m *User) GeneratePassword(password string) string {
	s := sha1.New()
	s.Write([]byte(password))
	password = hex.EncodeToString(s.Sum([]byte("")))
	return password
}
