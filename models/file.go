package models

type File struct {
	Base
	Name         string `json:"name" form:"name"`
	FileCategory string `json:"file_category" form:"file_category"`
	Type         string `json:"type" form:"type"`
	Path         string `json:"path" form:"path"`
	Width        string `json:"width" form:"width"`
	Height       string `json:"height" form:"height"`
	Ratio        string `json:"ratio" form:"ratio"`
	Size         string `json:"size" form:"size"`
	Status       string `json:"status" form:"status"`
	UserID       string `json:"user_id" form:"user_id"`
}

func (File) TableName() string {
	return "file"
}
