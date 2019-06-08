package models

type Auth struct {
	Mobile     string `json:"mobile" form:"mobile" validate:"required,numeric,len=11"`
	Password   string `json:"password" form:"password" validate:"required,numeric,gte=6,lte=18"`
	RememberMe int64  `json:"remember_me" form:"remember_me"`
}
