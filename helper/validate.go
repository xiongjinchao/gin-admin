package helper

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/locales/en"
	ut "github.com/go-playground/universal-translator"
	"gopkg.in/go-playground/validator.v9"
	translations "gopkg.in/go-playground/validator.v9/translations/zh"
	"reflect"
	"strings"
)

// Validate struct
func ValidateStruct(data interface{}) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	err = validate.Struct(data)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return
}

// Validate variable
func ValidateVariable(data interface{}, rule string) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	err = validate.Var(data, rule)

	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return
}

// Validate struct and translate
func ValidateStructTranslate(data interface{}) (message string, err error) {

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

	err = validate.Struct(data)
	if err != nil {
		// log
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())

		// translate data
		errs := err.(validator.ValidationErrors)
		messages := errs.Translate(transZh)

		for _, message = range messages {
			_, _ = fmt.Fprintln(gin.DefaultWriter, message)
		}
	}
	return
}
