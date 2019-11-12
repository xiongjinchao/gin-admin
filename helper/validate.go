package helper

import (
	"gopkg.in/go-playground/validator.v9"
)

// Validate struct
func ValidateStruct(data interface{}) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	err = validate.Struct(data)
	return
}

// Validate variable
func ValidateVariable(data interface{}, rule string) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	err = validate.Var(data, rule)
	return
}
