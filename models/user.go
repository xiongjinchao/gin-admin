package models

import (
	"crypto/sha1"
	"encoding/hex"
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
	UpdatedAt     time.Time `json:"updated_at"`
}

func (m *User) GetUserList() (users []User, err error) {
	if rows, err := db.Mysql.Query("SELECT `id`,`name`,`email`,`mobile`,`created_at`,`updated_at` FROM `user`"); err == nil {
		for rows.Next() {
			var user User
			if err = rows.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile, &user.CreatedAt, &user.UpdatedAt); err == nil {
				users = append(users, user)
			}
		}
	}
	return
}

func (m *User) GetUser(id int64) (user User, err error) {
	row := db.Mysql.QueryRow("SELECT `id`,`name`,`email`,`mobile`,`created_at`,`updated_at` FROM `user` WHERE id=?", id)
	err = row.Scan(&user.Id, &user.Name, &user.Email, &user.Mobile, &user.CreatedAt, &user.UpdatedAt)
	return
}

func (m *User) CreateUser() (id int64, err error) {
	user := *m
	user.Password = m.GeneratePassword(user.Password)
	stmt, _ := db.Mysql.Prepare("INSERT INTO `user` (`name`,`email`,`mobile`,`password`,`remember_token`,`created_at`,`updated_at`)values(?,?,?,?,?,?,?)")
	if row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.Password, user.RememberToken, time.Now(), time.Now()); err == nil {
		id, err = row.LastInsertId()
	}
	return
}

func (m *User) UpdateUser() (count int64, err error) {
	user := *m
	user.Password = m.GeneratePassword(user.Password)
	stmt, _ := db.Mysql.Prepare("UPDATE `user` (`name`,`email`,`mobile`,`password`,`remember_token`,`updated_at`)values(?,?,?,?,?,?) WHERE `id` = ? ")
	if row, err := stmt.Exec(user.Name, user.Email, user.Mobile, user.Password, user.RememberToken, time.Now(), user.Id); err == nil {
		count, err = row.RowsAffected()
	}
	return
}

func (m *User) DeleteUser(id string) (count int64, err error) {
	stmt, _ := db.Mysql.Prepare("DELETE FROM `user` WHERE `id` = ?")
	if rows, err := stmt.Exec(id); err == nil {
		count, err = rows.RowsAffected()
	}
	return
}

func (m *User) GeneratePassword(password string) string {
	s := sha1.New()
	s.Write([]byte(password))
	password = hex.EncodeToString(s.Sum([]byte("")))
	return password
}
