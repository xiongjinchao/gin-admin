package admin

import (
	"fmt"
	"gin-admin/helper"
	md "github.com/JohannesKaufmann/html-to-markdown"
	"github.com/PuerkitoBio/goquery"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

type Collect struct{}

var ArticleSource, BookSource map[int]string

func init() {
	ArticleSource = map[int]string{
		1: "简书",
		2: "CSDN",
	}
	BookSource = map[int]string{
		1: "菜鸟教程",
		2: "LearnKu",
	}
}

// Index handles GET /admin/collect/index route
func (co *Collect) Index(c *gin.Context) {

	flash := helper.GetFlash(c)
	c.HTML(http.StatusOK, "collect/index", gin.H{
		"title":         "采集工具",
		"flash":         flash,
		"articleSource": ArticleSource,
		"bookSource":    BookSource,
	})
}

func (co *Collect) Article(c *gin.Context) {

	url := c.PostForm("url")
	source := c.PostForm("source")
	fmt.Println(source)

	// Request the HTML page.
	res, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		_ = res.Body.Close()
	}()
	if res.StatusCode != 200 {
		log.Fatalf("status code error: %d %s", res.StatusCode, res.Status)
	}

	// Load the HTML document
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	//title := doc.Find("#content h1").Text()
	content, err := doc.Find("#content").Html()
	if err != nil {
		log.Fatal(err)
	}

	converter := md.NewConverter("", true, nil)
	markdown, err := converter.ConvertString(content)

	fmt.Println(markdown)

	c.Redirect(http.StatusFound, "/admin/collect-article")
}

func (co *Collect) Book(c *gin.Context) {

	c.Redirect(http.StatusFound, "/admin/collect-book")

}
