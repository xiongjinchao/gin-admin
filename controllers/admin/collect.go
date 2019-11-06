package admin

import (
	"fmt"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	md "github.com/JohannesKaufmann/html-to-markdown"
	"github.com/JohannesKaufmann/html-to-markdown/plugin"
	"github.com/PuerkitoBio/goquery"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Collect struct{}

var ArticleSource map[int]string
var BookSource map[int]string

func init() {
	ArticleSource = map[int]string{
		1: "简书",
		2: "CSDN",
		3: "LearnKu",
	}
	BookSource = map[int]string{
		1: "菜鸟教程",
		2: "LearnKu",
	}
}

// Index handles GET /admin/collect/index route
func (co *Collect) Index(c *gin.Context) {

	flash := helper.GetFlash(c)

	var articleCategories, articleCategory []models.ArticleCategory
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level asc, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &articleCategory)
	(&models.ArticleCategory{}).SetData(&articleCategory)

	var bookCategories, bookCategory []models.BookCategory
	if err := db.Mysql.Model(&models.BookCategory{}).Order("level asc, sort DESC").Find(&bookCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.BookCategory{}).SetSort(&bookCategories, 0, &bookCategory)
	(&models.BookCategory{}).SetData(&bookCategory)

	c.HTML(http.StatusOK, "collect/index", gin.H{
		"title":             "采集工具",
		"flash":             flash,
		"articleSource":     ArticleSource,
		"bookSource":        BookSource,
		"articleCategories": articleCategory,
		"bookCategories":    bookCategory,
	})
}

func (co *Collect) Article(c *gin.Context) {

	url := c.PostForm("source_url")
	source := c.PostForm("source")

	// Request the HTML page.
	res, err := http.Get(url)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}
	defer func() {
		_ = res.Body.Close()
	}()
	if res.StatusCode != 200 {
		helper.SetFlash(c, res.Status, "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}

	// Load the HTML document
	doc, err := goquery.NewDocumentFromReader(res.Body)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}
	var content, title string

	if source == "简书" {
		title = doc.Find("section>h1").Text()
		content, err = doc.Find("article").Html()
		if err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}
	} else if source == "CSDN" {
		title = doc.Find("h1.title-article").Text()
		content, err = doc.Find("#content_views").Html()
		if err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}
	} else if source == "LearnKu" {
		title = doc.Find("h1>div>span").Text()
		content, err = doc.Find(".content-body").Html()
		if err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}
	}

	converter := md.NewConverter("", true, nil)
	converter.Use(plugin.GitHubFlavored())
	content, err = converter.ConvertString(content)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}

	article := models.Article{}
	err = c.ShouldBind(&article)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}
	article.Title = title
	article.Content = content
	article.UserID = int64(1)
	if err := db.Mysql.Omit("ArticleCategory", "User", "File").Create(&article).Error; err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}

	helper.SetFlash(c, "采集文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/collect")
}

func (co *Collect) Book(c *gin.Context) {

	c.Redirect(http.StatusFound, "/admin/collect")

}
