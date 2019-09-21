package middleware

import (
	"github.com/gin-gonic/gin"
	"gopkg.in/go-playground/validator.v9"
)

type API struct {
	AppKey    string `form:"app_key" validate:"required"`
	Method    string `form:"method" validate:"required"`
	Params    string `form:"params" validate:"required"`
	JWT       string `form:"jwt" validate:"required"`
	Version   string `from:"version" validate:"required"`
	Time      string `form:"time" validate:"required"`
	Signature string `form:"signature" validate:"required"`
	SignType  string `form:"sign_type" validate:"required"`
}

func (a *API) CheckPolicy() gin.HandlerFunc {
	return func(c *gin.Context) {
		api := API{}
		if err := c.Bind(&api); err != nil {
			c.Abort()
			return
		}

		validate := &validator.Validate{}
		validate = validator.New()
		if err := validate.Struct(api); err != nil {
			c.Abort()
			return
		}

		if a.CheckSignature(api) == false {
			c.Abort()
			return
		}

		if api.Method == "article.list" {
			if a.CheckJWT(api.JWT) == false {
				c.Abort()
				return
			}
		}
		c.Next()
	}
}

func (a *API) CheckSignature(api API) bool {
	return true
}

func (a *API) CheckJWT(jwt string) bool {
	return true
}
