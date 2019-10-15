package models

import (
	db "gin-admin/database"
	"strings"
)

type Tag struct {
	Base    `json:"base"`
	Model   string `json:"model" form:"model"`
	ModelID int64  `json:"model_id" form:"model_id" gorm:"column:model_id"`
	Tag     string `json:"tag" form:"tag"`
}

func (Tag) TableName() string {
	return "tag"
}

// Update tags
func (t *Tag) Upgrade(value, model string, id int64) (err error) {
	if value != "" {
		var tag []Tag
		var tags []string
		if err := db.Mysql.Model(&Tag{}).Where("model =? and model_id = ?", model, id).Find(&tag).Error; err != nil {
			return err
		}

		for _, v := range tag {
			if !strings.Contains(value, v.Tag) {
				db.Mysql.Where("model = ? and model_id = ? and tag = ?", model, id, v.Tag).Delete(&Tag{})
			}
		}

		if err := db.Mysql.Model(&Tag{}).Where("model = ? and model_id  = ?", model, id).Find(&tag).Pluck("tag", &tags).Error; err != nil {
			return err
		}

		for _, v := range strings.Split(value, ",") {
			if strings.Contains(strings.Join(tags, ","), v) {
				continue
			}
			tag := Tag{}
			tag.Model = model
			tag.ModelID = id
			tag.Tag = v
			db.Mysql.Model(&Tag{}).Save(&tag)
		}

	} else {
		db.Mysql.Where("model = ? and model_id = ?", model, id).Delete(&Tag{})
	}
	return nil
}

// Get tags
func (t *Tag) GetTags(model string, id int64) (tags []string, err error) {
	var tag []Tag
	err = db.Mysql.Model(&Tag{}).Where("model = ? and model_id = ?", model, id).Find(&tag).Pluck("tag", &tags).Error
	return
}
