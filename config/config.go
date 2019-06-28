package config

import "github.com/go-ini/ini"

var Setting = make(map[string]map[string]string)

func init() {
	config, err := ini.Load("config/app.ini")
	if err != nil {
		panic(err)
	}

	Setting["app"] = config.Section("app").KeysHash()
	Setting["session"] = config.Section("session").KeysHash()
	Setting["mysql"] = config.Section("mysql").KeysHash()
	Setting["redis"] = config.Section("redis").KeysHash()
}
