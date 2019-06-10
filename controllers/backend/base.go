package backend

import (
	"fmt"
	"strings"

	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/go-playground/locales/zh"
	ut "github.com/go-playground/universal-translator"
	"gopkg.in/go-playground/validator.v9"
	translations "gopkg.in/go-playground/validator.v9/translations/zh"
)

type Base struct{}

// set flash data
func (_ *Base) SetFlash(c *gin.Context, k string, err error) {
	_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	session := sessions.Default(c)
	session.AddFlash(k + "::" + err.Error())
	err = session.Save()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
}

// get flash data
func (_ *Base) GetFlash(c *gin.Context) (map[string]string, error) {
	session := sessions.Default(c)
	flashes := session.Flashes()
	data := map[string]string{}
	for _, flash := range flashes {
		if flash.(string) != "" {
			item := strings.Split(flash.(string), "::")
			k, v := item[0], item[1]
			data[k] = v
		}
	}
	err := session.Save()
	return data, err
}

// validate error message for chinese
func (_ *Base) Validate(c *gin.Context, data interface{}) bool {
	session := sessions.Default(c)
	uni := &ut.UniversalTranslator{}
	validate := &validator.Validate{}

	ZH := zh.New()
	uni = ut.New(ZH)
	trans, _ := uni.GetTranslator("zh")
	validate = validator.New()
	if err := translations.RegisterDefaultTranslations(validate, trans); err != nil {
		panic(err)
	}

	err := validate.Struct(data)
	if err != nil {
		// log
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())

		// translate data
		errs := err.(validator.ValidationErrors)
		message := errs.Translate(trans)

		// flash data
		for k, v := range message {
			session.AddFlash(k + "::" + v)
		}
		if err := session.Save(); err != nil {
			panic(err)
		}
		return false
	}
	return true
}
