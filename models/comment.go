package models

type Comment struct {
	Base     `json:"base"`
	UserID   int64  `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Model    string `json:"model" form:"model"`
	ModelID  string `json:"model_id" form:"model_id" gorm:"column:model_id"`
	RootID   int64  `json:"root_id" form:"root_id" gorm:"column:root_id"`
	ParentID int64  `json:"parent_id" form:"parent_id" gorm:"column:parent_id"`
	Content  string `json:"content" form:"content"`
}

func (Comment) TableName() string {
	return "comment"
}
