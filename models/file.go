package models

type File struct {
	Base     `json:"base"`
	Name     string  `json:"name" form:"name"`
	Category string  `json:"category" form:"category"`
	Path     string  `json:"path" form:"path"`
	Width    int     `json:"width" form:"width"`
	Height   int     `json:"height" form:"height"`
	Ratio    float32 `json:"ratio" form:"ratio"`
	Size     int64   `json:"size" form:"size"`
	UserID   int64   `json:"user_id" form:"user_id"`
}

func (File) TableName() string {
	return "file"
}
