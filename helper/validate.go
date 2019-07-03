package helper

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

type Validate struct{}

// Validate struct
func (_ *Validate) ValidateStruct(c *gin.Context, data interface{}) bool {

	validate := &validator.Validate{}
	validate = validator.New()
	err := validate.Struct(data)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		return false
	}
	return true
}

// Validate variable
func (_ *Validate) ValidateVariable(data string, rule string) bool {
	validate := &validator.Validate{}
	validate = validator.New()

	//errs := validate.Var(myEmail, "required,email")
	errs := validate.Var(data, rule)

	if errs != nil {
		fmt.Println(errs) // output: Key: "" Error:Field validation for "" failed on the "email" tag
		return false
	}

	return true
}

// Validate struct and translate
func (_ *Validate) ValidateStructAndTranslate(c *gin.Context, data interface{}) bool {
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
