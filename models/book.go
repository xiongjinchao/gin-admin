package models

import (
	"fmt"
	db "gin-blog/database"
	"github.com/gin-gonic/gin"
)

type Book struct {
	Base         `json:"base"`
	Name         string       `json:"name" form:"name"`
	Cover        int64        `json:"cover" form:"cover"`
	CategoryID   int64        `json:"category_id" form:"category_id" gorm:"column:category_id"`
	Summary      string       `json:"summary" form:"summary"`
	Catalogue    string       `json:"catalogue" form:"catalogue"`
	Tag          string       `json:"tag" form:"tag"`
	Audit        int64        `json:"audit" form:"audit"`
	Hit          int64        `json:"hit" form:"hit"`
	Useful       int64        `json:"useful" form:"useful"`
	Useless      int64        `json:"useless" form:"useless"`
	Favorite     int64        `json:"favorite" form:"favorite"`
	Comment      int64        `json:"comment" form:"comment"`
	Keyword      string       `json:"keyword" form:"keyword"`
	BookCategory BookCategory `json:"book_category" validate:"-" gorm:"foreignKey:CategoryID;AssociationForeignKey:ID"`
	File         File         `json:"file" validate:"-" gorm:"foreignKey:Cover;AssociationForeignKey:ID"`
	Tags         []Tag        `json:"tags" form:"-"`
}

func (Book) TableName() string {
	return "book"
}

// set tags data to book
func (b *Book) SetTags(books *[]Book) {

	for i, v := range *books {
		var tagModel []TagModel
		if err := db.Mysql.Model(&TagModel{}).Preload("Tag").Where("model = ? and model_id = ?", "article", v.ID).Find(&tagModel).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			v.Tags = nil
		}
		for _, t := range tagModel {
			(*books)[i].Tags = append((*books)[i].Tags, t.Tag)
		}
	}
}
