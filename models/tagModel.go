package models

type TagModel struct {
	Base    `json:"base"`
	TagID   int64  `json:"tag_id" form:"tag_id"`
	Model   string `json:"model" form:"model"`
	ModelID int64  `json:"model_id" form:"model_id"`
	Tag     Tag    `json:"tag" validate:"-" gorm:"foreignKey:TagID;AssociationForeignKey:ID"`
}

func (TagModel) TableName() string {
	return "tag_model"
}
