package models

type ActionRecord struct {
	Base    `json:"base"`
	UserID  int64  `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Model   string `json:"model" form:"model"`
	ModelID string `json:"model_id" form:"model_id" gorm:"column:model_id"`
	Action  string `json:"action" form:"action"`
}

func (ActionRecord) TableName() string {
	return "action_record"
}
