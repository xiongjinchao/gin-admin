package models

import (
	db "gin-admin/database"
	"strings"
)

type Tag struct {
	Base `json:"base"`
	Name string `json:"name" form:"name"`
}

func (Tag) TableName() string {
	return "tag"
}

// Update tags
func (t *Tag) Upgrade(value, model string, id int64) (err error) {
	if value != "" {
		var tagModels []TagModel
		if err = db.Mysql.Model(&Tag{}).Preload("Tag").Where("model = ? and model_id = ?", model, id).Find(&tagModels).Error; err != nil {
			return
		}
		for _, v := range tagModels {
			if !strings.Contains(value, v.Tag.Name) {
				db.Mysql.Where("model = ? and model_id = ? and tag_id = ?", model, id, v.TagID).Delete(&TagModel{})
			}
		}

		for _, v := range strings.Split(value, ",") {
			tag := Tag{}
			db.Mysql.Where("name = ?", v).First(&tag)
			if tag.ID <= 0 {
				tag.Name = v
				db.Mysql.Model(&Tag{}).Create(&tag)
			}

			tagModel := TagModel{}
			db.Mysql.Where("tag_id = ?", tag.ID).First(&tagModel)
			if tagModel.ID <= 0 {
				tagModel.TagID = tag.ID
				tagModel.Model = model
				tagModel.ModelID = id
				db.Mysql.Model(&TagModel{}).Omit("Tag").Create(&tagModel)
			}
		}

	} else {
		db.Mysql.Where("model = ? and model_id = ?", model, id).Delete(&TagModel{})
	}
	return nil
}

// Get tags
func (t *Tag) GetTags(model string, id int64) (tags []string, err error) {
	var tagModels []TagModel
	if err = db.Mysql.Model(&Tag{}).Preload("Tag").Where("model = ? and model_id = ?", model, id).Find(&tagModels).Error; err != nil {
		return
	}
	for _, v := range tagModels {
		tags = append(tags, v.Tag.Name)
	}
	return
}
