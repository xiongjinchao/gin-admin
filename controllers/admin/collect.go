package admin

import (
	"fmt"
	db "gin-admin/database"
	"gin-admin/helper"
	"gin-admin/models"
	"github.com/PuerkitoBio/goquery"
	"github.com/gin-gonic/gin"
	md "github.com/xiongjinchao/html-to-markdown"
	"github.com/xiongjinchao/html-to-markdown/plugin"
	"net/http"
	"strings"
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
	if err := db.Mysql.Model(&models.ArticleCategory{}).Order("level ASC, sort DESC").Find(&articleCategories).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.ArticleCategory{}).SetSort(&articleCategories, 0, &articleCategory)
	(&models.ArticleCategory{}).SetData(&articleCategory)

	var bookCategories, bookCategory []models.BookCategory
	if err := db.Mysql.Model(&models.BookCategory{}).Order("level ASC, sort DESC").Find(&bookCategories).Error; err != nil {
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

	urls := c.PostForm("source_url")
	source := c.PostForm("source")

	for _, url := range strings.Split(urls, "\n") {
		url = strings.TrimSpace(url)

		// Load the HTML document
		doc, err := helper.GetDoc(url)
		if err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}
		var html, title string

		if source == "简书" {
			title = doc.Find("section>h1").Text()
			html, err = doc.Find("article").Html()
			if err != nil {
				helper.SetFlash(c, err.Error(), "error")
				c.Redirect(http.StatusFound, "/admin/collect")
				return
			}
		} else if source == "CSDN" {
			title = doc.Find("h1.title-article").Text()
			html, err = doc.Find("#content_views").Html()
			if err != nil {
				helper.SetFlash(c, err.Error(), "error")
				c.Redirect(http.StatusFound, "/admin/collect")
				return
			}
		} else if source == "LearnKu" {
			title = doc.Find("h1>div>span").Text()
			html, err = doc.Find(".content-body").Html()
			if err != nil {
				helper.SetFlash(c, err.Error(), "error")
				c.Redirect(http.StatusFound, "/admin/collect")
				return
			}
		}

		converter := md.NewConverter("", true, nil)
		converter.Use(plugin.GitHubFlavored())
		markdown, err := converter.ConvertString(html)
		if source == "LearnKu" {
			markdown, err = converter.Remove("div").ConvertString(html)
		}
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
		article.Content = markdown
		article.UserID = int64(1)
		if err := db.Mysql.Omit("ArticleCategory", "User", "File").Create(&article).Error; err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}
	}

	helper.SetFlash(c, "采集文章成功", "success")
	c.Redirect(http.StatusFound, "/admin/collect")
}

func (co *Collect) Book(c *gin.Context) {
	// get book struct
	url := c.PostForm("source_url")
	source := c.PostForm("source")

	// Load the HTML document
	doc, err := helper.GetDoc(url)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}

	book := models.Book{}
	err = c.ShouldBind(&book)
	if err != nil {
		helper.SetFlash(c, err.Error(), "error")
		c.Redirect(http.StatusFound, "/admin/collect")
		return
	}

	if source == "LearnKu" {

		type Page struct {
			title string
			link  string
		}
		type Chapter struct {
			title string
			page  []Page
		}
		type LearnKu struct {
			title   string
			chapter []Chapter
		}

		var learnKu LearnKu
		learnKu.title = strings.TrimSpace(doc.Find(".sidebar .item.lh-2 a:first-child").Text())

		doc.Find(".sidebar .item.py-2").Each(func(i int, cha *goquery.Selection) {
			var chapter Chapter
			chapter.title = strings.TrimSpace(cha.Find(".header.title").Text())

			cha.Find(".menu.article a").Each(func(i int, sel *goquery.Selection) {
				link, _ := sel.Attr("href")
				chapter.page = append(chapter.page, Page{
					title: strings.TrimSpace(sel.Text()),
					link:  link,
				})
			})

			learnKu.chapter = append(learnKu.chapter, chapter)
		})

		// save book
		book.Name = learnKu.title
		if err := db.Mysql.Omit("BookCategory", "File").Create(&book).Error; err != nil {
			helper.SetFlash(c, err.Error(), "error")
			c.Redirect(http.StatusFound, "/admin/collect")
			return
		}

		// save chapter
		for _, v := range learnKu.chapter {
			for _, p := range v.page {

				bookChapter := models.BookChapter{}
				bookChapter.BookID = book.ID
				bookChapter.Title = p.title

				// Load the HTML document
				doc, err := helper.GetDoc(p.link)
				if err != nil {
					helper.SetFlash(c, err.Error(), "error")
					c.Redirect(http.StatusFound, "/admin/collect")
					return
				}
				html, err := doc.Find(".content-body").Html()
				if err != nil {
					helper.SetFlash(c, err.Error(), "error")
					c.Redirect(http.StatusFound, "/admin/collect")
					return
				}

				converter := md.NewConverter("", true, nil)
				converter.Use(plugin.GitHubFlavored())
				content, err := converter.Remove("div").ConvertString(html)
				if err != nil {
					helper.SetFlash(c, err.Error(), "error")
					c.Redirect(http.StatusFound, "/admin/collect")
					return
				}
				if content == "" {
					continue
				}
				bookChapter.Chapter = content

				if err := db.Mysql.Omit("Book").Create(&bookChapter).Error; err != nil {
					helper.SetFlash(c, err.Error(), "error")
					c.Redirect(http.StatusFound, "/admin/collect")
					return
				}
			}
		}
	}

	helper.SetFlash(c, "采集书籍成功", "success")

	c.Redirect(http.StatusFound, "/admin/collect")

}
