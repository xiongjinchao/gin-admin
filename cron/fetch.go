//+build ignore

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
	"sync"
	"time"
)

func init() {
	defer func() {
		if err := recover(); err != nil {
			fmt.Print("error:%s", err)
		}
	}()
}

var waitgroup sync.WaitGroup

func main() {
	var url string = "http://www.nowamagic.net/librarys/veda/all/"
	for i := 1; i <= 135; i++ {
		waitgroup.Add(1) //计数器+1 可以认为是队列+1
		go reslove(url, i)

	}
	waitgroup.Wait() //进行阻塞等待 如果 队列不跑完 一直不终止
}
func reslove(url string, page int) {
	p := strconv.Itoa(page)
	url += p
	defer waitgroup.Done() //如果跑完就进行 队列-1
	log.Println("start " + url)
	h, err := http.Get(url)
	if err != nil {
		panic(err)
		return
	}
	if h.StatusCode != http.StatusOK { //如果获取状态不为 200,输出状态程序结束
		panic(err)
		return
	}
	defer h.Body.Close()
	buf := make([]byte, 1024) //创建一个字节数组 长度为 1024
	file_open, err := os.OpenFile("./html/"+p+".html", os.O_RDWR|os.O_CREATE|os.O_APPEND, os.ModePerm)
	if err != nil {
		panic(err)
		return
	}
	defer func() {
		time.Sleep(time.Duration(1 * 1e9))
		file_open.Sync()
		file_open.Close()
	}()
	for { //无限循环,读取网页数据
		num, _ := h.Body.Read(buf)
		//如果获取数量为0，说明已经取到头了
		if num == 0 {
			break
		}
		file_open.WriteString(string(buf[:num]))
	}
	log.Println("end  " + url)
}
