package models

type Tag struct {
	Base    `json:"base"`
	Model   string `json:"model" form:"model"`
	ModelID string `json:"model_id" form:"model_id" gorm:"column:model_id"`
	Tag     string `json:"tag" form:"tag"`
}

func (Tag) TableName() string {
	return "tag"
}
