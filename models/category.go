package models

type Category struct {
	ID   int64  `json:"id" form:"id"`
	Name string `json:"name" form:"name"`
	Tag  string `json:"tag" form:"tag"`
	Icon string `json:"icon" form:"icon"`
}
