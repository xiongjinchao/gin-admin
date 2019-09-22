package models

import "time"

type FriendLink struct {
	Base    `json:"base"`
	Title   string    `json:"title" form:"title"`
	Link    string    `json:"link" form:"link"`
	Image   int64     `json:"image" form:"image"`
	Sort    int64     `json:"sort" form:"sort"`
	Audit   int64     `json:"audit" form:"audit"`
	StartAt time.Time `json:"start_at" form:"start_at"`
	EndAt   time.Time `json:"end_at" form:"end_at"`
	File    File      `json:"file" validate:"-" gorm:"foreignKey:Image;AssociationForeignKey:ID"`
}

func (FriendLink) TableName() string {
	return "friend_link"
}
