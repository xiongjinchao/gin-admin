package models

type Comment struct {
	Base    `json:"base"`
	UserID  int64  `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Model   string `json:"model" form:"model"`
	ModelID string `json:"model_id" form:"model_id" gorm:"column:model_id"`
	Root    int64  `json:"root" form:"root"`
	Parent  int64  `json:"parent" form:"parent"`
	Content string `json:"content" form:"content"`
}

func (Comment) TableName() string {
	return "comment"
}
