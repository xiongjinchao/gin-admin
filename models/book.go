package models

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
