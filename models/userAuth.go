package models

type UserAuth struct {
	Base         `json:"base"`
	UserID       int64  `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Type         string `json:"type" form:"type"`
	AccessToken  string `json:"access_token" form:"access_token"`
	ExpiresIn    int64  `json:"expires_in" form:"expires_in"`
	RefreshToken string `json:"refresh_token" form:"refresh_token"`
	OpenID       string `json:"openid" form:"openid" gorm:"column:openid"`
	Nickname     string `json:"nickname" form:"nickname"`
	Sex          int64  `json:"sex" form:"sex"`
	Avatar       string `json:"avatar" form:"avatar"`
	Privilege    string `json:"privilege" form:"privilege"`
	UnionID      string `json:"unionid" form:"unionid" gorm:"column:unionid"`
	Country      string `json:"country" form:"country"`
	Province     string `json:"province" form:"province"`
	City         string `json:"city" form:"city"`
}

func (UserAuth) TableName() string {
	return "user_auth"
}
