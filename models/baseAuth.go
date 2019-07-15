package models

type BaseAuth struct {
	Mobile   string `label:"手机号码" json:"mobile" form:"mobile" validate:"required,numeric,len=11"`
	Password string `label:"密码" json:"password" form:"password" validate:"required,gte=6,lte=18"`
}
