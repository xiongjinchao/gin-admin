//+build ignore

package main

import (
	"fmt"
	db "gin-admin/database"
	"gin-admin/models"
	"github.com/JohannesKaufmann/html-to-markdown"
	"github.com/PuerkitoBio/goquery"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"log"
	"net/http"
)

func main() {
	url := "https://www.runoob.com/go/go-tutorial.html"
	fetch(url)
}

func fetch(url string) {

	var err error
	if db.Mysql, err = gorm.Open(
		"mysql",
		"root:root@tcp(127.0.0.1:3306)/gin-blog?charset=utf8&parseTime=true&loc=Local",
	); err != nil {
		log.Fatal(err)
	}
	defer func() {
		_ = db.Mysql.Close()
	}()

	// Request the HTML page.
	res, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()
	if res.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
	}

	// Load the HTML document
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	title := doc.Find("#content h1").Text()
	content, err := doc.Find("#content").Html()
	if err != nil {
		log.Fatal(err)
	}

	converter := md.NewConverter("", true, nil)
	markdown, err := converter.ConvertString(content)
	if err != nil {
		log.Fatal(err)
	}

	article := models.Article{}
	article.Title = title
	article.Content = markdown
	article.SourceUrl = url
	article.CategoryID = 1

	if err := db.Mysql.Omit("ArticleCategory", "User", "File", "Tags").Create(&article).Error; err != nil {
		log.Fatal(err)
	}

	fmt.Println("Done")
}
