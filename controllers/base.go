package controllers

import (
	"fmt"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/locales/en"
	ut "github.com/go-playground/universal-translator"
	"gopkg.in/go-playground/validator.v9"
	translations "gopkg.in/go-playground/validator.v9/translations/zh"
	"reflect"
	"strings"
)

type Base struct{}

// set flash data
func (_ *Base) SetFlash(c *gin.Context, data string) {
	session := sessions.Default(c)
	session.AddFlash(data)
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
}

// get flash data
func (_ *Base) GetFlash(c *gin.Context) (data []string) {
	session := sessions.Default(c)
	flashes := session.Flashes()
	for _, flash := range flashes {
		data = append(data, flash.(string))
	}
	if err := session.Save(); err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return data
}

// validate error message for chinese
func (_ *Base) Validate(c *gin.Context, data interface{}) bool {
	session := sessions.Default(c)
	uni := &ut.UniversalTranslator{}
	validate := &validator.Validate{}

	zh := en.New()
	uni = ut.New(zh)
	transZh, _ := uni.GetTranslator("zh")

	validate = validator.New()
	validate.RegisterTagNameFunc(func(fld reflect.StructField) string {
		name := strings.SplitN(fld.Tag.Get("label"), ",", 2)[0]
		if name == "-" {
			return ""
		}
		return name
	})

	if err := translations.RegisterDefaultTranslations(validate, transZh); err != nil {
		panic(err)
	}

	err := validate.Struct(data)
	if err != nil {
		// log
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())

		// translate data
		errs := err.(validator.ValidationErrors)
		message := errs.Translate(transZh)

		// flash data
		for _, v := range message {
			fmt.Println(v)
			session.AddFlash(v)
		}
		if err := session.Save(); err != nil {
			panic(err)
		}
		return false
	}
	return true
}
