package models

import (
	"errors"
	db "gin-admin/database"
	"regexp"
	"strconv"
	"strings"
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

func (b *Book) GenerateCatalogue() (err error) {

	var catalogue []string
	var bookChapter []BookChapter
	err = db.Mysql.Where("book_id = ?", b.ID).Find(&bookChapter).Error

	if err != nil {
		return err
	}

	if len(bookChapter) <= 0 {
		return errors.New("书籍章节不存在")
	}

	for _, v := range bookChapter {

		catalogue = append(catalogue, "# "+"["+v.Title+"](/book/chapter/"+strconv.FormatInt(v.ID, 10)+")")
		//#[关于本书](https://github.com/pandao/editor.md#1)

		sections := strings.Split(v.Chapter, "\n")
		for _, s := range sections {
			if ok, _ := regexp.MatchString("^\\#\\W+$", s); ok {
				title := strings.Replace(s, "#", "", -1)
				title = strings.TrimSpace(title)
				hash := strings.Repeat("#", strings.Count(s, "#"))
				catalogue = append(catalogue, "#"+hash+"["+title+"](/book/chapter/"+strconv.FormatInt(v.ID, 10)+"#"+title+")")
			}
		}
	}

	b.Catalogue = strings.Join(catalogue, "\n")
	if err := db.Mysql.Model(&b).Omit("BookCategory", "File").Save(&b).Error; err != nil {
		return err
	}

	return nil
}
