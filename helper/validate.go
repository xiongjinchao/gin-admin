package helper

import (
	"gopkg.in/go-playground/validator.v9"
)

// Validate struct
func ValidateStruct(data interface{}) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	return validate.Struct(data)
}

// Validate variable
func ValidateVariable(data interface{}, rule string) (err error) {

	validate := &validator.Validate{}
	validate = validator.New()
	return validate.Var(data, rule)
}
