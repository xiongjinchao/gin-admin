//+build ignore

package main

import (
	"database/sql"
	"fmt"
	"github.com/PuerkitoBio/goquery"
	_ "github.com/go-sql-driver/mysql"
	"log"
	"net/http"
	"time"
)

var DB *sql.DB

func main() {
	url := "https://learnku.com/docs/the-little-go-book/getting_started/3295"

	DB, err := sql.Open("mysql", "root:root@tcp(127.0.0.1:3306)/gin-blog?charset=utf8&parseTime=true&loc=Local")
	if err != nil {
		log.Fatalf("Open mysql failed,err:%v\n", err)
	}
	DB.SetConnMaxLifetime(100 * time.Second)
	DB.SetMaxOpenConns(100)
	DB.SetMaxIdleConns(16)

	fetch(url)
}

func fetch(url string) {
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

	var book []struct {
		title   string
		chapter []map[string]string
	}
	title := doc.Find(".sidebar .item.lh-2 a:first-child").Text()

	doc.Find(".sidebar .item.py-2").Each(func(i int, cha *goquery.Selection) {
		item := struct {
			title   string
			chapter []map[string]string
		}{}

		item.title = cha.Find(".header.title").Text()

		cha.Find(".menu.article a").Each(func(i int, sel *goquery.Selection) {
			link, _ := sel.Attr("href")
			item.chapter = append(item.chapter, map[string]string{
				"title": sel.Text(),
				"link":  link,
			})
		})

		book = append(book, item)
	})

	fmt.Println(title)
	for key, value := range book {
		fmt.Printf("%s=>%s\n", key, value)
	}
}
