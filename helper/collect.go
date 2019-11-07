package helper

import (
	"github.com/PuerkitoBio/goquery"
	"net/http"
)

func GetDoc(url string) (doc *goquery.Document, err error) {
	res, err := http.Get(url)
	if err != nil {
		return
	}

	defer func() {
		_ = res.Body.Close()
	}()

	if res.StatusCode != 200 {
		return
	}
	return goquery.NewDocumentFromReader(res.Body)
}
