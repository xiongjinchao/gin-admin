-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2019-11-02 17:13:10
-- 服务器版本： 10.2.24-MariaDB-log
-- PHP 版本： 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- 数据库： `gin-blog`
--
CREATE DATABASE IF NOT EXISTS `gin-blog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `gin-blog`;

-- --------------------------------------------------------

--
-- 表的结构 `action_log`
--

DROP TABLE IF EXISTS `action_log`;
CREATE TABLE `action_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT 0 COMMENT '模型ID',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作类型 favorite useful useless',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `action_record`
--

DROP TABLE IF EXISTS `action_record`;
CREATE TABLE `action_record` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT 0 COMMENT '模型ID',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作类型 favorite useful useless',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `remember_token` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'TOKEN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `mobile`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', 'xiongjinchao@hotmail.com', '15911006066', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', '2019-04-01 16:38:07', '2019-07-30 09:33:33', NULL),
(2, 'xiongjinchao', '67218026@qq.com', '15911006062', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', '2019-07-08 14:56:08', '2019-09-21 01:59:59', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(10) NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cover` int(11) DEFAULT 0,
  `category_id` int(4) DEFAULT 0,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit` tinyint(4) DEFAULT 0,
  `hot` tinyint(4) DEFAULT 0,
  `recommend` tinyint(4) DEFAULT 0,
  `hit` int(11) DEFAULT 0 COMMENT '点击总数',
  `useful` int(10) NOT NULL DEFAULT 0 COMMENT '有用',
  `useless` int(10) NOT NULL DEFAULT 0 COMMENT '无用',
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '收藏总数',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT '评论总数',
  `user_id` int(11) DEFAULT 0,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `source` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `article`
--

INSERT INTO `article` (`id`, `title`, `cover`, `category_id`, `summary`, `content`, `audit`, `hot`, `recommend`, `hit`, `useful`, `useless`, `favorite`, `comment`, `user_id`, `author`, `source`, `source_url`, `keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Golang接口断言为指针类型，内存分配问题', 0, 3, '其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。', '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n```go\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main() {\r\n   var a = 34\r\n  var i interface{} = &a\r\n  o := i.(*int)\r\n   fmt.Println(i, o)\r\n}\r\n\r\n// output: 0xc4200160a0 0xc4200160a0\r\n```\r\n\r\n很明显了，就不解释了', 1, 1, 1, 21, 0, 0, 0, 0, 1, '', '', '', '', '2019-08-06 02:03:39', '2019-11-01 02:08:05', NULL),
(2, 'Golang中json自定义序列化的深入解析', 0, 3, '对于使用结构体中嵌套结构体的情况，只有receiver为指针类型，而嵌套结构体为结构体的值语义的时候不能触发自定义Json格式化函数MarshalJSON；其他三种组合均能够触发。', '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n对于使用结构体中嵌套结构体的情况，只有receiver为指针类型，而嵌套结构体为结构体的值语义的时候不能触发自定义Json格式化函数MarshalJSON；其他三种组合均能够触发。\r\n\r\n对于使用结构体中嵌套结构体slice的情况，receiver值语义、指针语义和嵌套结构体slice元素为值语义、指针语义的四种组合均能够触发Json格式化函数MarshalJSON。\r\n\r\n```go\r\npackage main\r\n\r\nimport (\r\n    \"encoding/json\"\r\n    \"fmt\"\r\n)\r\n\r\ntype Profile struct {\r\n    Level string\r\n    Admin bool\r\n}\r\n\r\n// 本质是将Profile指针类型实现Marshaler接口，从而达到自定义json序列化格式的目的。\r\nfunc (p *Profile) MarshalJSON() ([]byte, error) {\r\n    if p.Admin {\r\n        admin := struct {\r\n            Level string\r\n        }{\r\n            Level: \"admin\",\r\n        }\r\n        return json.Marshal(admin)\r\n    }\r\n\r\n    control := struct {\r\n        Level string\r\n        Admin bool\r\n    }{\r\n        Level: \"control\",\r\n        Admin: false,\r\n    }\r\n    return json.Marshal(control)\r\n}\r\n\r\ntype User struct {\r\n    Id      int\r\n    Name    string\r\n    Age     uint8\r\n    Profile *Profile\r\n}\r\n\r\nfunc main() {\r\n    u := User{\r\n        Id:   1,\r\n        Age:  23,\r\n        Name: \"qshuai\",\r\n        Profile: &Profile{\r\n            Level: \"master\",\r\n            Admin: true,\r\n        },\r\n    }\r\n    b, err := json.Marshal(u)\r\n    if err != nil {\r\n        panic(err)\r\n    }\r\n    fmt.Println(string(b))\r\n}\r\n\r\n// -----------------------slice作为Struct成员的情况----------------------\r\npackage main\r\n\r\nimport (\r\n    \"encoding/json\"\r\n    \"fmt\"\r\n)\r\n\r\ntype Profile struct {\r\n    Level string\r\n    Admin bool\r\n}\r\n\r\nfunc (p *Profile) MarshalJSON() ([]byte, error) {\r\n    if p.Admin {\r\n        admin := struct {\r\n            Level string\r\n        }{\r\n            Level: \"admin\",\r\n        }\r\n        return json.Marshal(admin)\r\n    }\r\n\r\n    control := struct {\r\n        Level string\r\n        Admin bool\r\n    }{\r\n        Level: \"control\",\r\n        Admin: false,\r\n    }\r\n    return json.Marshal(control)\r\n}\r\n\r\ntype User struct {\r\n    Id      int\r\n    Name    string\r\n    Age     uint8\r\n    Profile []Profile\r\n}\r\n\r\nfunc main() {\r\n    u := User{\r\n        Id:   1,\r\n        Age:  23,\r\n        Name: \"qshuai\",\r\n        Profile: []Profile{\r\n            {\r\n                Level: \"master\",\r\n                Admin: true,\r\n            },\r\n        },\r\n    }\r\n    b, err := json.Marshal(u)\r\n    if err != nil {\r\n        panic(err)\r\n    }\r\n    fmt.Println(string(b))\r\n}\r\n```', 1, 1, 1, 15, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/f8b0ed37513a', '', '2019-09-28 16:20:21', '2019-11-01 00:47:53', NULL),
(3, 'Golang去除slice中重复的元素，认识空struct', 0, 3, 'golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！', '> golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！\r\n\r\n另外让我们看一下空struct的作用，他之前一直没有被我重视，看来以后要多审视自己的coding了！\r\n\r\n```go\r\nfunc main() {\r\n    s := []string{\"hello\", \"world\", \"hello\", \"golang\", \"hello\", \"ruby\", \"php\", \"java\"}\r\n\r\n    fmt.Println(removeDuplicateElement(s))\r\n}\r\n\r\nfunc removeDuplicateElement(addrs []string) []string {\r\n    result := make([]string, 0, len(addrs))\r\n    temp := map[string]struct{}{}\r\n    for _, item := range addrs {\r\n        if _, ok := temp[item]; !ok {\r\n            temp[item] = struct{}{}\r\n            result = append(result, item)\r\n        }\r\n    }\r\n    return result\r\n}\r\n\r\n//output:\r\n[hello world golang ruby php java]\r\n```\r\n\r\n点评\r\n\r\n- 该函数总共初始化两个变量，一个长度为0的slice，一个空map。由于slice传参是按引用传递，没有创建额外的变量。\r\n\r\n- 只是用了一个for循环，代码更简洁易懂。\r\n\r\n- 利用了map的多返回值特性。\r\n\r\n- 空struct不占内存空间，可谓巧妙。\r\n', 1, 1, 1, 17, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/f8b0ed37513a', '', '2019-09-28 16:30:43', '2019-10-30 02:19:46', NULL),
(4, '摸清Golang接口、方法、指针、自定义类型', 0, 3, 'go语言内部会自动进行值和指针的转换, 代码在编译的时候不会出错；区别在于使用指针定义方法，方法操作的是该数据本身；而使用值定义方法时，方法操作的是该数据的拷贝。', '主要区分一下两个方面的内容：\r\n\r\n- 单纯的方法定义\r\n- 通过接口传递参数\r\n\r\n##### 1、 单纯的方法定义\r\n\r\n> go语言内部会自动进行值和指针的转换, 代码在编译的时候不会出错；区别在于使用指针定义方法，方法操作的是该数据本身；而使用值定义方法时，方法操作的是该数据的拷贝。\r\n\r\n\r\n> 总结:如果使用除接口类型以外的类型作为接收者时，使用值和指针调用方法不会出现编译错误； 如果使用接口类型的变量（实现了该接口）调用方法时，使用值调用指针定义的方法时会出现编译出错。\r\n\r\n1、 使用值定义方法，使用值调用方法的情况\r\n\r\n```go\r\ntype user struct {\r\n    name string\r\n    email string\r\n}\r\n\r\nfunc (u user) notify() {\r\n    //将传入的参数复制一份，赋值给u\r\n    u.name = \"Jack\"\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc main() {\r\n    user := user{\"Andy\", \"1139329@163.com\"}\r\n    user.notify()\r\n    fmt.Println(user)\r\n}\r\n\r\n//输出（名子并不会改变）：\r\nSend email to Jack 1139329@163.com\r\n{Andy 1139329@163.com}\r\n\r\n```\r\n\r\n2、 使用值定义方法，使用指针调用方法的情况\r\n\r\n> 由于定义方法时使用的是值，在编译过程中会对调用者为指针的类型进行解引用，内部实现为 *user.notify()\r\n\r\n```go\r\ntype user struct {\r\n    name string\r\n    email string\r\n}\r\n\r\nfunc (u user) notify() {\r\n    //将传入的参数复制一份，赋值给u\r\n    u.name = \"Jack\"\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc main() {\r\n    user := &user{\"Andy\", \"1139329@163.com\"}\r\n    user.notify()\r\n    fmt.Println(user)\r\n}\r\n\r\n//输出（名子也不会改变）：\r\nSend email to Jack 1139329@163.com\r\n{Andy 1139329@163.com}\r\n```\r\n\r\n3、 使用指针定义方法，使用指针调用方法的情况\r\n\r\n```go\r\ntype user struct {\r\n    name string\r\n    email string\r\n}\r\n\r\nfunc (u *user) notify() {\r\n    u.name = \"Jack\"\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc main() {\r\n    user := user{\"Andy\", \"1139329@163.com\"}\r\n    user.notify()\r\n    fmt.Println(user)\r\n}\r\n\r\n//输出（名子会改变）：\r\nSend email to Jack 1139329@163.com\r\n{Jack 1139329@163.com}\r\n```\r\n\r\n4、 使用指针定义方法，使用值调用方法的情况\r\n\r\n> 内部实现为 *user.notify()\r\n\r\n```go\r\ntype user struct {\r\n    name string\r\n    email string\r\n}\r\n\r\nfunc (u *user) notify() {\r\n    u.name = \"Jack\"\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc main() {\r\n    user := user{\"Andy\", \"1139329@163.com\"}\r\n    user.notify()\r\n    fmt.Println(user)\r\n}\r\n\r\n//输出（名子会改变）：\r\nSend email to Jack 1139329@163.com\r\n{Jack 1139329@163.com}\r\n```\r\n\r\n#####2、 通过接口传递参数\r\n\r\n1、 接受者receiver为值，使用值传递的情况\r\n\r\n```go\r\ntype user struct {\r\n    name  string\r\n    email string\r\n}\r\n\r\ntype notifyInterface interface {\r\n    notify()\r\n}\r\n\r\nfunc (u user) notify() {\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc sendNotification(n notifyInterface) {\r\n    n.notify()\r\n}\r\n\r\nfunc main() {\r\n    user := user{\"Andy\", \"1139329@163.com\"}\r\n    sendNotification(user)\r\n}\r\n\r\n//编译成功\r\n```\r\n\r\n2、 接受者receiver为值，使用指针传递的情况\r\n\r\n```go\r\ntype user struct {\r\n    name  string\r\n    email string\r\n}\r\n\r\ntype notifyInterface interface {\r\n    notify()\r\n}\r\n\r\nfunc (u user) notify() {\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc sendNotification(n notifyInterface) {\r\n    n.notify()\r\n}\r\n\r\nfunc main() {\r\n    user := &user{\"Andy\", \"1139329@163.com\"}\r\n    sendNotification(user)\r\n}\r\n\r\n//编译成功\r\n```\r\n\r\n3、 接受者receiver为指针，使用指针传递的情况\r\n\r\n```go\r\ntype user struct {\r\n    name  string\r\n    email string\r\n}\r\n\r\ntype notifyInterface interface {\r\n    notify()\r\n}\r\n\r\nfunc (u *user) notify() {\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc sendNotification(n notifyInterface) {\r\n    n.notify()\r\n}\r\n\r\nfunc main() {\r\n    user := &user{\"Andy\", \"1139329@163.com\"}\r\n    sendNotification(user)\r\n}\r\n\r\n//编译成功\r\n```\r\n\r\n4、 接受者receiver为指针，使用值传递的情况\r\n\r\n```go\r\ntype user struct {\r\n    name  string\r\n    email string\r\n}\r\n\r\ntype notifyInterface interface {\r\n    notify()\r\n}\r\n\r\nfunc (u *user) notify() {\r\n    fmt.Println(\"Send email to\", u.name, u.email)\r\n}\r\n\r\nfunc sendNotification(n notifyInterface) {\r\n    n.notify()\r\n}\r\n\r\nfunc main() {\r\n    user := user{\"Andy\", \"1139329@163.com\"}\r\n    sendNotification(user)\r\n}\r\n\r\n//编译失败（使用指针接受者来实现一个接口，值类型无法实现对应的接口）\r\ncannot use user (type user) as type notifyInterface in argument to sendNotification:\r\nuser does not implement notifyInterface (notify method has pointer receiver)\r\n```\r\n针对以上情况，《Go语言实战》一书中这样讲到，首先这是Go语言的一种规则，具体如下：如果使用指针接受者来实现一个接口，那么只有指向那个类型的指针才能够实现对应的接口。如果使用值接受者来实现一个接口，那么那个类型的值和指针都能够实现对应的接口。\r\n\r\n为什么会有这样的限制呢：作者解释为go编译器并不总能自动获得一个值得地址！\r\n\r\n', 1, 1, 1, 25, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/883cee8b0264', '', '2019-10-22 01:40:24', '2019-10-31 10:45:53', NULL),
(5, '产品杂谈：定位产品的五个步骤', 0, 8, '对一款合格、优秀的产品来说，产品定位的重要性和难度不言而喻，因此笔者总结了定位产品的五个步骤，希望能给你带来思考与启发。', '> 对一款合格、优秀的产品来说，产品定位的重要性和难度不言而喻，因此笔者总结了定位产品的五个步骤，希望能给你带来思考与启发。\r\n\r\n如果产品的制造比较困难，那么如何更好地定位产品也会成为一个更为突出的问题。\r\n\r\n无论我们制造和销售什么产品，产品的定位都决定了我们的许多工作——我们如何确定工作优先次序？举办什么样的营销活动？实行什么样的销售策略？所有的这些都会根据产品的定位而改变。\r\n\r\n产品的定位如此重要，那我们究竟该怎样更好的定位自己的产品呢？\r\n\r\n下面我将给出我的建议。\r\n\r\n####步骤1：了解客户为何使用我们的产品\r\n\r\n增长黑客之父Sean Ellis曾经给出了一套“产品市场契合度调查模板”，通过此类调查是了解客户的好方法。\r\n\r\n如果我们能够深入研究，就能够发现这不仅仅是一个调查框架，而且通过调查——有多少人喜欢我们的产品？如果没有我们的产品给用户造成的影响？我们的竞争争对手有哪些？客户又从我们的产品收获了什么？等等问题，都可以通过调查获得相关的信息。\r\n\r\n简而言之，我们通过向客户询问以下三个问题，以进一步了解他们。\r\n\r\n- 如果明天没有（我们的产品名称），您会感到非常不开心，有点不开心，或者是非常失望？为什么？\r\n- 您从（我们产品名称）中得到的主要收益是什么？\r\n- 您会使用哪种产品作为（我们的产品名称）的替代品呢？\r\n\r\n尤其是第二个调查问题，它能够将用户收益直接映射到我们的产品功能上，它告诉我们客户从我们的产品中获得的价值，以及产品的哪个方面是吸引他们的关键。\r\n\r\n这意味着我们知道该围绕哪些核心进行产品迭代和优化，并让更多用户发现其带来的价值。\r\n\r\n步骤2：确定产品所在的市场及希望产品承担的角色\r\n\r\n在构建产品时，我们可能已经对所处的市场有所了解。\r\n\r\n例如我们设计的是CRM工具，那么显而易见的，我们的产品将服务于企业的CRM管理流程中。\r\n\r\n但除此之外，我们还需要思考一些问题，例如我们要卖给的人是经理等管理层还是参与日常执行的人？我们打算讲产品卖给技术公司的销售人员还是零售行业的相关部门呢？\r\n\r\n而从步骤1，我们通过调查获得的数据也将帮助我们更好的理解所处的市场——从中我们可以提炼出用户的共性、普遍的需求等，而这些将会为了我们后续的服务产品化提供灵感。\r\n\r\n####步骤3：确定市场的成熟度\r\n\r\n市场的成熟度在产品相关信息的传递中起着非常重要的作用。\r\n\r\n在一个相对较新的市场，我们必须先确定问题，然后再针对问题谈论我们所提供的产品（特别是针对B端市场）。\r\n\r\n而在一个成熟市场中，我们仅仅需要告知客户我们的产品面向的是哪个特定的市场，客户便能对我们的产品功能等信息有一个基本的认识，然后再向客户说明为什么我们会面向这个市场开发一款新的产品，即使功能上没有新的突破，但会在哪方面带来新的好处，从而说服客户购买和使用我们的产品。\r\n\r\n特别是对于CRM等竞争激烈的市场，公司的产品功能和优势往往是通过与竞争对手的产品相比较而凸显出来的。\r\n\r\n当产品和服务难以拉开明显的差距时，差异化变得尤为重要。\r\n\r\n在这方面我最喜欢的一个例子是联合利华旗下个人护理子公司Dove针对沐浴露等日化市场做的差异化。\r\n\r\n当其他的厂商在洗护用品功能上绞尽脑汁做创新，但仍逃脱不了同质化（都是可以帮忙清洁）的时候，Dove却采取了另一种方法：\r\n\r\n不纠结于难以拉开差距的功能本身，而是通过“My Beauty My Say”系列广告，强化其产品赋予女性权利的故事，从而巧妙的将自己的产品与其他产品区分开。\r\n\r\n####步骤4：确定用户的思想状态\r\n\r\n决定某人是否应该使用我们的产品的因素有很多，但大致可以归纳为四种力量：\r\n\r\n- 推力\r\n- 吸引力\r\n- 焦虑\r\n- 习惯\r\n\r\n当人们从当前使用的产品切换到我们的产品时，经常是他们对当前产品所提供的体验不满意（推力）或者被我们的产品所提供的的体验所吸引（吸引力）。\r\n\r\n而在人们做出切换产品的决定之前，我们需要解决他们在使用产品或者切换产品时候的顾虑（焦虑），让他们信任我们；并确保他们在切换到我们的产品时，不需要付出过多的额外学习成本去熟悉我们的产品使用（习惯）。\r\n\r\n在我们设计产品的时候，经常是推拉相结合让用户考虑使用我们的产品，然后再充分考虑用户焦虑和习惯的同时，吸引用户做出改变。\r\n\r\n####步骤5：综合以上步骤结论\r\n\r\n我们通过步骤1到步骤4对用户、市场、产品进行了梳理，并收集了对应的信息和数据。\r\n\r\n在这之后，我们需要针对收集的数据，针对我们能够供给的最有价值的点，细分受众，从而确定我们的核心目标用户及产品的核心价值。\r\n\r\n步骤5将会比我们想象的更加困难。因为我们需要确保这个市场（或者说需求）是已经存在于客户的脑海中，并且能够围绕这个市场达成以下的条件：\r\n\r\n- 确定竞争对手无法做到的事情\r\n- 确定这些功能（产品）的缺失会让用户感到痛苦\r\n- 我们拥有提供这些功能（产品）的能力\r\n- 能够设计合理的功能流程为用户带来收益\r\n\r\n在步骤5，我们围绕着已经存在某一个确切存在的市场，通过差异化因素的构建告知客户为什么需要选择我们的产品（而不仅仅是有功能能满足需求而已）。\r\n\r\n####小结\r\n\r\n寄希望于客户的忠诚度并不是最有效的办法，产品想从市场中脱颖而出并与客户建立联系，不仅要说明功能和优势，更可以着眼于市场及其成熟度，通过产品故事的编制，让自己与众不同。', 1, 1, 1, 14, 0, 0, 0, 0, 1, '', '百家号', 'http://baijiahao.baidu.com/s?id=1647524333027740566&wfr=spider&for=pc', '', '2019-10-22 01:48:39', '2019-11-02 00:57:18', NULL),
(6, '下一代互联网未来已来', 0, 9, '未来，人工智能从你出生那天就认识你，读过你所有的电子邮件，听过你所有电话录音，知道你最爱的电影……', '> 从人与人相连接，到万物互联，互联网技术的演进正在给人类社会带来巨大变革。有专家表示，基于IPv6的下一代互联网，将成为支撑前沿技术和产业快速发展的基石，有力支撑起人工智能、物联网、移动互联网、工业互联网、5G等前沿技术的发展，催生出更多新业态、新应用、新场景，最终惠及每一个网民。比如，IPv6具有很好的溯源性，有助于减少网络谣言和黑客攻击，对于提高我国的网络安全水平有很大帮助。此外，使用IPv6之后，用户可以对数据进行加密，从而保护个人数据安全。\r\n\r\nIPv6是什么？如何解决下一代互联网发展中的问题？它将给产业发展带来哪些新机遇，又会给社会生活带来哪些新图景？《经济参考报》记者对此进行了专题调研。\r\n\r\n####万物互联开启智慧新图景\r\n\r\n未来，人工智能从你出生那天就认识你，读过你所有的电子邮件，听过你所有电话录音，知道你最爱的电影……”以色列作家尤瓦尔·赫拉利在《未来简史》一书中描绘了这样一幅场景：人工智能可能比你自己更了解你。\r\n\r\n人工智能、万物互联、大数据分析……基于互联网产业发展的需要，互联网体系结构的变革再次提上日程。当前全球正在加快布局下一代互联网产业体系，构建高速率、广普及、全覆盖、智能化的新一代互联网体系。下一代互联网体系变革将带来哪些新图景？又有哪些新挑战？\r\n\r\n####社会变革：人工智能引领第四次工业革命\r\n\r\n屏幕中与你对话的可能是“机器人客服”，新闻稿件的作者可能是“机器人记者”，快递包裹的分拣员可能是“智能分拣机器人”。这些场景对我们已经不再陌生，从信息传播效率的提升，到生活方式更加便捷，生产成本更加低廉，基于互联网深度发展的人工智能技术正在全方位改变社会生活，给人类生活带来更多新图景。\r\n\r\n随着“互联网+”等政策的部署和落实，人工智能技术也开始从概念走向实践，在产业经济领域引发变革，不断渗透人类生活的各个角落。业内人士表示，新一代人工智能技术的发展，将重构生产、分配、交换、消费等经济活动各环节，形成全方位覆盖各领域的智能化新需求，促进新技术、新产品和新业态的出现，对经济结构变革产生重大影响。\r\n\r\n“如同工业时代的蒸汽机，人工智能在数字化时代的作用正日益凸显。第四次工业革命很有可能就会是人工智能。”360人工智能研究院副院长谭平曾在中国互联网大会上表示，第一次这样的工业革命的典型代表就是蒸汽机的出现，第二次则是灯泡、电力的广泛使用，第三次工业革命我们有了电脑、互联网，第四次工业革命很有可能是人工智能。\r\n\r\n清华大学公共管理学院院长薛澜近日在人文清华讲坛演讲时谈到，随着人工智能、生命科学、物联网、机器人等新技术的发展，我们的物理空间、生物空间和网络空间正在深度融合，引领着第四次工业革命的到来。“它的技术发展和扩散的速度，它对人类社会影响的深度和广度，都是前三次工业革命远远不能相比的。”薛澜说。\r\n\r\n####万物互联：物联网开启智慧生活新图景\r\n\r\n百度推出自动驾驶计划、阿里探索无人零售、腾讯聚焦人工智能……中国互联网协会理事长、中国工程院院士邬贺铨在今年召开的中国互联网产业年会上谈到，互联网企业瞄准新技术和新场景纷纷做了重大的战略调整，布局未来更大的发展空间。在新技术发展的推动下，我国明确了发展下一代互联网的战略目标和时间表，着力推进网络强国战略，互联网发展进入新时代。\r\n\r\n无人驾驶、无人超市、无现金社会……得益于物联网技术、人脸识别技术和移动互联网的发展，老百姓的“钱袋子”也变了样。不用自己开车，无需雇佣司机，汽车本身也是“驾驶员”。这个曾经出现在科幻电影中的场景，如今已经变成现实。\r\n\r\n“新科技发明让百姓的日子越来越好，开启了更加智慧的生活方式。”邬贺铨谈到，手机购物、移动支付、共享单车等正是在“窄带”物联网标准出来以后，渗透到消费领域的具体应用，引领着智能社会的到来。\r\n\r\n业内专家表示，如果说互联网让人与人的沟通不再受时空限制，那么物联网则让物物相连成为现实，从人与人，到人与物，再到物与物，万物互联时代正在来临。\r\n\r\n####安全之盾：IPv6为网络安全保驾护航\r\n\r\n“第四次工业革命对社会产生的各种影响，包括对就业、伦理、治理方面的影响，其他国家感受到了，我们也同样感受到了。”薛澜谈到，“着眼创新的同时，还要考虑创新可能带来的风险和不利影响。”\r\n\r\n“线上”网络和“线下”生活正在深度融合，虚拟网络世界和现实社会生活相互交织。人们在互联网上变成了“透明人”，个人的一举一动都被互联网“记录在案”，导致人们在网络空间越来越缺乏安全感。——北京大学互联网发展研究中心主任田丽谈到，网络安全和信息安全问题在互联网时代更加凸显，大数据收集和人工智能分析的泛滥，给个人信息保护带来不小的挑战。\r\n\r\n新机遇伴随新挑战，当前我国正在加快布局下一代互联网，如何在互联网高速发展的同时，解决当前存在的安全隐患问题，更好地保护个人信息安全，成为下一代互联网发展中必须解决的问题。\r\n\r\n“IPv6下一代互联网为网络安全问题提供了新平台及新思路。”下一代互联网国家工程中心主任刘东谈到，通过规范IPv6地址分配，能够给网络安全提供支持。如果对IP地址规划和管理得当，就可以更加高效地实现网络流量控制和安全管理，同时也有利于降低安全管理的成本。\r\n\r\n中国工程院院士吴建平介绍，IPv6也具有很好的溯源性，能够找到信息发布的源头，这就有助于减少网络谣言和黑客攻击，对于提高我国网络安全水平有很大帮助。此外，使用IPv6之后，用户可以对数据进行加密，从而保护个人数据安全。“一旦对数据加密，互联网用户就更加安全了。”\r\n\r\n互联网的安全性一直是政府和公众高度关注的话题。“掌握核心技术是解决网络安全问题的重要方式，我国要在下一代互联网布局中争夺主动权，必须要加强基础理论研究，解决核心技术问题。”吴建平表示，建好下一代互联网信息“高速公路”，需要全社会共同努力，抓住互联网体系结构这个核心技术，才能让行驶在互联网“高速公路”上的人行稳致远。\r\n\r\n####IPv6规模部署　全球争抢IP资源\r\n\r\n加快布局基于IPv6的下一代互联网，成为网络强国建设中的重要一步。\r\n\r\n“到2018年末，IPv6活跃用户数达到2亿，在互联网用户中的占比不低于20%”在中办、国办于2017年底印发的《推进互联网协议第六版（IPv6）规模部署行动计划》中，下一代互联网的发展目标明确，今年也成为行动计划的开局之年。\r\n\r\n下一代互联网有何不同？当前IPv6发展状况如何？加快推进IPv6有何现实意义？\r\n\r\n“如果IPv4是一颗鸡蛋　那么IPv6就是整个地球”\r\n\r\n“在偌大的互联网体系中，有了标准格式才能知道信息从哪里来、到哪里去，这就是IP协议。”中国工程院院士、清华大学计算机科学与技术系主任吴建平告诉记者，体系结构作为互联网的核心技术之一，对互联网行业和社会生活影响深远。当前普遍使用的是IPv4协议，而下一代互联网则是以IPv6为基础的互联网发展阶段。\r\n\r\nIPv6协议是IP协议的一个版本，全称“Internet　Protocol　Version6”，即互联网协议第六版，是网际协议标准的制定者IETF设计的用来代替现行版本IPv4的下一代互联网核心协议。当前我国仍处于IPv4协议与IPv6协议并行阶段，下一代互联网时代，IPv6协议将逐渐取代IPv4协议。\r\n\r\n“然而，因为互联网的发展速度太快，目前网络IP地址的数量显得不够用了，这些资源也将分配殆尽。”下一代互联网国家工程中心主任刘东表示，特别是人工智能、物联网、5G技术、量子通讯等技术的快速发展，对IP地址的需求量将呈现爆炸式增长。基于IPv6的下一代互联网将地址空间扩大到2的128次方，被形容为“让地球上每粒沙子都有一个IP地址”。\r\n\r\n实现互联网向IPv6演进升级，则是我国网络强国建设的基础工程。\r\n\r\n“如果IPv4是一颗鸡蛋，那么IPv6就是整个地球。”吴建平谈到，与IPv4相比，IPv6的一个显著特点就是数量巨大。从数字上来看，IPv4能为全球提供约43亿IP地址，IPv6理论上可提供2的128次方个IP地址。“几乎可以连接世界上所有东西。甚至可以给动物分配IP地址了。”吴建平说。\r\n\r\n7亿多网民共享3亿IP地址　IP资源愈加紧缺\r\n\r\nIP协议是一种有限资源，随着万物互联时代加速到来，IP资源紧缺的现象愈发突出。第四届世界互联网大会公布的《世界互联网发展报告2017》表明，截至2017年6月，全球网民总数达到38.9亿，普及率为51.7%。这就意味着，如果每个网民有一台入网设备，目前IPv4协议分配的43亿IP地址很快就会不够用。\r\n\r\n而现实情况是，随着移动互联网的飞速发展，个人便携PC、智能手机以及其它移动电子设备快速普及，人手多台入网设备成为常态，未来也将出现越来越多的物联网应用，甚至电视、冰箱、空调、牙刷都开始入网，这对IP地址的需求量将会几何级增加。“未来的物联网时代，甚至像灯泡这样微小的家居设备都要配备IP地址。这样40多亿个地址是远远不够的。”吴建平说。\r\n\r\n根据《中国互联网发展报告2017》显示，截至2017年6月，中国网民规模已达到7.51亿，而IPv4地址数量仅有3.38亿。相当于平均每两个人共用一个IP地址。而在美国，平均一个人拥有5个IP地址。而我国在过去并没有获得大量的IPv4地址，面对迅速增长的入网设备和网民数量，争取更多的IP资源成为迫切需求。\r\n\r\n“IPv6可以在解决IPv4地址短缺的同时，还有可能解决多种设备连接互联网的障碍，为万物互联奠定网络基础。”刘东表示，基于IPv6的下一代互联网拥有海量地址，将成为支撑前沿技术及产业快速发展的重要基石。在当前新一轮科技革命和产业变革的关键时期，下一代互联网规模部署将成为我国由网络大国迈向网络强国的迫切要求。\r\n\r\n发展IPv6成为全球公认的下一代互联网解决方案，全球你追我赶普及IPv6的竞争态势正在形成。\r\n\r\n“互联网体系结构在互联网技术发展中扮演着重要角色，推进IPv6是互联网发展的必然。”吴建平认为，如果不加快向IPv6升级，就会成为制约互联网经济发展的一个瓶颈。\r\n\r\n全球争抢IP资源　全面部署IPv6正当其时\r\n\r\n当前，IPv6部署在国际已取得了突破性进展，主要发达国家IPv6部署率大幅提高。面对全球抢占IPv6资源的态势，我国将全面推进部署IPv6作为发展下一代互联网的重要任务。\r\n\r\n“实现IPv6大规模商业应用、IPv6用户规模世界前列、形成全球领先产业技术体系……”《推进互联网协议第六版（IPv6）规模部署行动计划》明确了下一代互联网发展的目标和任务，并为之制定了具体的时间表和路线图，为下一代互联网规模部署和未来发展指明了方向。\r\n\r\n业内专家评价，这项行动计划对我国互联网基础设施建设、网络安全提升、应用水平提高等方面影响显著，将成为推进下一代互联网部署的行动指南，对经济社会发展乃至国家安全产生深远影响。\r\n\r\n中国工程院院士、中国互联网协会理事长邬贺铨也曾在公开场合表示，IP资源全球分配，发展IPv6就要关注全球下一代互联网的研究、实验、技术、产业应用情况，做到发展共同推进、安全共同维护、治理共同参与、成果共同分享。我们不仅不能关起门来搞建设，还要向世界贡献中国力量。\r\n\r\n专家解读下一代互联网创新模式\r\n\r\n下一代互联网全面建成还有哪些现实困境？如何解决发展中面临的现实困境，让下一代互联网真正落地生根？如何促进下一代互联网与社会治理同步推进？\r\n\r\n记者就此专访了IPv6推动者、中国工程院院士吴建平，下一代互联网国家工程中心主任刘东，北大互联网发展研究中心主任田丽三位专家，请他们畅谈下一代互联网发展的昨天、今天和明天。\r\n\r\n“起个大早，赶个晚集”\r\n\r\n当前全球互联网格局正在从互联网协议第四版（IPv4）走向互联网协议第六版（IPv6）。我国正在着力推进IPv6规模部署，构建高速率、广普及、全覆盖、智能化的下一代互联网。\r\n\r\n曾获得国际互联网界最高荣誉“乔纳森·波斯塔尔奖”的吴建平，作为中国互联网发展进程的重要贡献者，他在科研之路上见证了IPv6的发展历程。吴建平告诉记者，中国很早就参与到下一代互联网建设中。1997年IPv6正式提出，美国开始发起下一代互联网项目，几乎与此同时，中国也着手立项研究下一代互联网。\r\n\r\n在研究下一代互联网基础理论和实践应用方面，中国曾走在前列。2000年底，“中国高速互联研究实验网络”项目成功研制了中国第一个地区性下一代互联网试验网络；2003年前后，清华大学等单位承担了“973”计划项目“新一代互联网体系结构理论研究”；2008年底，国家组织实施下一代互联网示范工程CNGI试商用项目，上百所高校和科研机构、全国性电信运营商、几十个互联网企业加入其中，建成了大规模下一代互联网示范网络……\r\n\r\n“起了个大早，赶了个晚集”，吴建平坦言，尽管我国较早开展了IPv6试验，但目前我国IPv6普及率并不高。从互联网产业实际发展来看，重实践应用轻基础理论的现象仍然存在，对互联网技术的认识流于表面，在运用互联网时显得比较粗犷。“一些企业对互联网的本质缺乏了解，对核心技术不求甚解，依然用落后的方式使用先进的技术。”吴建平说。\r\n\r\n致力于下一代互联网关键技术测试和研究的下一代互联网国家工程中心主任刘东也谈到，我国是世界上较早开展下一代互联网试验和应用的国家，在技术研发、网络建设、应用创新方面取得了重要阶段性成果。“但遗憾的是，后期推进过程却明显乏力，其核心原因在于产业认识不足，很多机构既没有认识到部署下一代互联网的必要性，又没有认识到紧迫性。”刘东说。\r\n\r\n####产业助推是动力　核心技术是根本\r\n\r\n“用5到10年时间，形成下一代互联网自主技术体系和产业生态，建成全球最大规模的IPv6商业应用网络。”当前，推进全面部署IPv6已经上升到战略层面，受到国家层面的大力支持，但仍需避免重蹈覆辙。业内人士表示，对于下一代互联网要避免盲目乐观，当前我国IPv6发展与发达国家仍存在不小的差距。实现IPv6大规模商用，还需相关产业的带动以及核心技术的创新。\r\n\r\n从下一代互联网发展历程来看，IPv6完全取代IPv4仍存在许多现实阻力，相关产业动力不足是发展缓慢的一个原因。通过对行业的长期观察，吴建平发现，短期看来，从IPv4转换到IPv6，一方面会给互联网企业增加成本，另一方面会给电信网络等行业带来冲击。吴建平透露，互联网内容的提供者缺乏使用新技术的动力，用户使用了IPv6也看不到什么内容；运营商对互联网存在抵触情绪，对研发4G、5G的热情度远远高于IPv6。\r\n\r\n“政策层面的支持，只是下一代互联网规模部署的催化剂，而IPv6大规模商用则要依靠市场需求推动。”刘东谈到，下一代互联网的部署是关乎各个“环节”的系统工程，既需要国家政策推动，更需要产业与市场驱动。只有运营商、设备商、互联网公司等产业链各个环节都“动”起来，在基础设施升级改造、垂直行业应用部署、前沿技术研发、人才培养等等方面展开综合推进，才有可能实现快速部署。刘东表示，“当前最重要的是激发产业主动性。”\r\n\r\n记者调查了解到，短期来看从IPv4转向基于IPv6的下一代互联网，可能会给相关企业带来成本的增加，但从长远来看，只有从互联网体系结构上做出根本调整，才能给互联网相关产业提供更多内生动力。因此，核心技术的创新尤其不能忽视。\r\n\r\n“互联网的核心技术是互联网的体系结构，像计算机系统中的CPU和计算机软件中的操作系统一样关键，一旦核心技术出问题，会对行业产生重大影响。”吴建平指出，尽管互联网应用搞得风生水起，但互联网核心技术创新比较薄弱。\r\n\r\n####应有与下一代互联网匹配的治理模式\r\n\r\n“基于IPv6的下一代互联网，将大大提升网络的容量和速度，信息传播效率将更高，同时将带来更多的技术创新成果。但技术的使用如果超过一定限度，就可能给现实社会带来风险。”北京大学互联网发展研究中心主任田丽表达了她对下一代互联网的隐忧。\r\n\r\n“过去，互联网是一个工具，帮助人们连接外部世界。现在，互联网本身就是社会，已经深深嵌套在生活中。”田丽认为，“互联网时代的颠覆性不仅是个人看得见的行为和看不见的思想，还有整个社会的结构和秩序，因此互联网创新不仅包括技术创新，还应包含治理创新。”\r\n\r\n网络空间正在塑造新的社会关系，网络正在将一个个分散的个体连接起来，人们的前途和命运都置于共同体之中。而当前的互联网治理模式并没有很好地将社会因素纳入其中，存在着治理思维简单、治理模式单一的问题，布局下一代互联网还应重视治理模式的创新。\r\n\r\n田丽认为，一般而言互联网治理至少应包括四个维度：一是互联网资源如何分配，二是互联网基础设施如何布局，三是互联网如何有序发挥作用，最后是互联网如何管理好。“然而，当前我们的互联网治理往往停留在最后这一点，即对互联网的规制和监管。”田丽谈到，当前互联网的监管手段相对单一，对于互联网行为的规制不明晰、底线不明确，管理存在滞后性。\r\n\r\n“下一代互联网时代，应该有一套与之匹配的治理模式。”田丽表示，未来互联网与传统社会深度交融是大趋势，互联网治理不应仅仅停留在对技术的管理上，而应是全方位的社会治理。\r\n\r\n田丽表示，治理与发展并重，在下一代互联网发展新阶段，只有深入分析研判，提前预测风险，在发展的同时解决好安全问题，才能让下一代互联网持续健康发展，才能让全球网民共享下一代互联网发展成果，在网络空间中有更多获得感、幸福感、安全感。', 1, 1, 1, 13, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/38920df2816b', '', '2019-10-22 01:55:17', '2019-11-01 21:17:34', NULL),
(7, '挣钱不容易，华为不容易', 0, 8, '两个同事被优化掉了，都是工作七年多的老员工，不过赔偿给的是n加4，也不错了。', '两个同事被优化掉了，都是工作七年多的老员工，不过赔偿给的是n加4，也不错了。这里的“n”指代的是工作年限，也就是说，这两名被裁员的华为老员工，每个人获得了11个月的工资赔偿，整整比法定赔偿多了三个月。除此之外，华为赔偿是按照员工工资基数计算，而非当地平均工资，可想而知，华为员工的工资本来就高，这样的良心赔偿方案着实让不少企业员工羡慕。\r\n\r\n如果是自己的工资不是平均三倍的话还是很良心了，我在的外企都做不到。华为的n不是平均三倍，是自己的薪资，N+4，对比好多公司裁员，赔偿一分不给；我猜都是研究生，这么一算年纪也差不多33了，看样子35岁危机并非空穴来风。', 1, 1, 1, 8, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/7884252a690b', '', '2019-10-22 02:00:50', '2019-10-24 05:38:46', NULL),
(8, '为什么越优秀的人越勤奋？', 0, 8, '人的知识就像一个圆，圆圈外是未知的，圆圈内是已知的，你知道的越多，你的圆圈就会越大。圆的周长也就越大，于是，你与未知接触的空间也就越多。', '> 前天和前同事聊天，那时候我们都是小编，月薪6K，现在我创业，成了小老板，而他还是小编。他说：当初我要是和你一样拼，我也可以，但不想，太累了。\r\n\r\n我应付了一下，找借口走了。这种人挺可怜的，看到以前和自己水平差不多的人，突然混得这么好，有落差，嫉妒，但出于礼貌，得憋着，克制自己，还得伪心地夸两句。\r\n\r\n最后，为了让自己好受些，只能自己骗自己：只要我努力，也可以做到，甚至比他做得更好，只不过我不想努力罢了。这种心里防御机制，从学生时代，到步入社会，存在了20几年，挺可悲的。\r\n\r\n看表面，我确实很拼，当然拼也是我一个成事的条件，但更重要的其实是认知。或者说，因为我有这个认知，才会去拼。\r\n\r\n####第一，对做事的认知\r\n\r\n几年前，看别人文章时，我总会自我感觉良好，看每一篇文章，我都会认为，我写的话，肯定比他写得好。\r\n\r\n直到自己写，才知道，一点都不简单，从阅读到输出，从选题到标题，从开头到结尾，都很磨人，不拼根本写不出来！世界就是这样，从外面看某件事，会觉得很简单，可真正去做，却问题很多，很难。\r\n\r\n从那以后，我再也不敢轻视每一篇文章，每一个作者，我也很尊重每一个为了自己目标踏踏实实去干的人。而那些，在别人做事不顺利时，嘲笑他人的人，多半自己就是个一事无成的二货。\r\n\r\n####第二，对自我的认知\r\n\r\n很多人听过刻意练习，说的是一个人只要在一个领域，经过大量重复训练，就能成为这个领域的高手。这个理论目前已被广泛接受，但我并不认为它是成为高手最好的路径。\r\n\r\n美国一所大学做过一个为期3年的研究：研究人员对1000多名读者的阅读速度和理解能力进行测试。\r\n\r\n首先，他们让读者按平常的习惯进行阅读，发现，一般读者是每分钟90字，有些厉害的读者，每分钟350字。\r\n\r\n他们将一般读者和速度教快的读者分为两组。接着教两组人相同的阅读方法，结果竟然是这样：在教授阅读方法之后，一般读者增加到150个字，2倍，但另一组增加了10倍，2900个字。这个结果让研究者大吃一惊，一开始大家都认为，水平较差的读者进步会更大。\r\n\r\n事实上，在有天赋的领域的投入回报率，才是最大的。这个观念其实是与我们学生时代相反的。\r\n\r\n上学时，想提高总分，往往提高最弱的那科最有效，偏科的同学更是如此。因此，短板理论在学校盛行。（短板理论：一个桶能装多少水，取决于最短的那块板。）但，工作中，情况恰好相反，我们需要长板理论。长板理论鼓励人们专精某一领域，将时间精力投入长处，而不是短处。\r\n\r\n首先，短板理论最初提出来，其实是针对企业的，并不是针对个人。其次，在互联网时代，分工是非常精细的，大家分工合作，发挥长处，效率更高。另一个投资回报率高的，就是风口，或者红利期。\r\n\r\n但很多风口根本不属于你，属于那些有资本，有能力的人。比如，公众号红利，那些传统媒体的写字人，就抓得住。比如，抖音红利，那些原本在别的平台做视频的，就抓得住。\r\n\r\n我真正内容创业时，是18年4月份，很多人都说红利早过了，劝我不要干，我没听，踏踏实实干，也干起来了。\r\n\r\n红利的投资回报率高，但你没能力最好别追，找一条赛道，专注下去，也能有不小成就。别指望靠风口一夜暴富。\r\n\r\n####第三，对知识的认知\r\n\r\n人的认知状态有四种：\r\n\r\n- 不知道自己不知道；\r\n- 知道自己不知道；\r\n- 知道自己知道；\r\n- 不知道自己知道。\r\n\r\n90%的人都处于第一状态，以为自己什么都知道，他们有这样一个逻辑：我什么都知道，所以我不用学习。\r\n\r\n因为他们不学习，所以不知道，但因为他们不知道自己不知道，所以不学习，但他们不学习，又不可能知道，真的是无解。\r\n\r\n他们像井底之蛙一样，以为看到的天就是全部。相反，优秀的人知道自己不知道，而且往往，他们知道得越多，越觉得自己无知。\r\n\r\n人的知识就像一个圆，圆圈外是未知的，圆圈内是已知的，你知道的越多，你的圆圈就会越大。圆的周长也就越大，于是，你与未知接触的空间也就越多。因此，虽然知道东西多，不知道东西也更多。\r\n\r\n他们永远觉得自己学得不够。不要天真的以为，勤奋是他们自带的，其实是靠认知撑起来的。', 1, 1, 1, 15, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/54413202e38e', '', '2019-10-22 02:05:18', '2019-11-02 12:19:04', NULL),
(9, '浏览器A标签点击事件触发方案', 0, 5, '最近在写一个需求，点击下载按钮触发下载事件，并自动下载事先准备好的wav文件。', '最近在写一个需求，点击下载按钮触发下载事件，并自动下载事先准备好的wav文件。\r\n于是我大笔一挥，写出了下面的代码：\r\n\r\n```javascript\r\nlet downloadDOM = document.createElement(\'a\')\r\ndownloadDOM.download = \'test.wav\'\r\ndownloadDOM.href = \'./a.wav\'\r\ndownloadDOM.click()\r\n```\r\n\r\n惊喜的是，谷歌浏览器一次OK，实现了下载。\r\n无语的是，火狐浏览器点击执行没有反应。\r\n\r\n在翻阅资料后，把代码修改如下:\r\n\r\n```javascript\r\nlet downloadDOM = document.createElement(\'a\')\r\ndownloadDOM.download = \'test.wav\';\r\ndownloadDOM.href = \'./a.wav\'\r\nvar evt = document.createEvent(\"MouseEvents\");\r\nevt.initEvent(\"click\",true,true);\r\ndownloadDOM.dispatchEvent(evt);\r\n```\r\n\r\n完美兼容了火狐浏览器和谷歌浏览器。', 1, 0, 0, 16, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/5112f1801f2d', '', '2019-10-22 12:12:49', '2019-10-30 17:01:28', NULL),
(10, '斤斤计较的员工要不要辞退？', 0, 8, '今天，我们就一起来聊聊，假如你是老板，碰到这样的员工该怎么办？由于有用的细节太少，我们可以适当的进行假设。', '> 昨天看到一个提问很有意思，一位企业老板发帖求助说，因为给员工少发了300块钱工资，员工就闹着要辞职。这位老板觉得员工太斤斤计较了，不就是300块钱有啥好计较的，甚至还要辞职。这位老板提出的问题就是，这样的员工要不要把他辞退了。昨天看到一个提问很有意思，一位企业老板发帖求助说，因为给员工少发了300块钱工资，员工就闹着要辞职。这位老板觉得员工太斤斤计较了，不就是300块钱有啥好计较的，甚至还要辞职。这位老板提出的问题就是，这样的员工要不要把他辞退了。\r\n\r\n这个问题本身描述的很模糊，没有说为啥少发了300块钱，这300块钱是工资还是额外的奖金。还有这名员工平时工作态度和能力怎么样？这些细节都不是很清楚，咱也不好意思问。这个问题却是很典型，员工和老板关于钱的理解是有偏差的。\r\n\r\n![](http://image.susan.org.cn/uploads/article-content/2019-10-28/f41e5f41-ffaf-42cb-ab44-1daef03df5e9.jpg)\r\n\r\n今天，我们就一起来聊聊，假如你是老板，碰到这样的员工该怎么办？由于有用的细节太少，我们可以适当的进行假设。\r\n\r\n从报酬公平性角度来说，企业按员工工作价值的大小支付给员工相应的报酬，这个是理所当然的。而不能因为少发300块钱，就觉得员工很会斤斤计较，殊不知这是员工通过自己的辛勤努力获得的，这个钱是他应得的。\r\n\r\n一个企业如果不能做到报酬公平的话，自然就没办法充分调动大多数员工的积极性，甚至还会无端增加不必要的劳务纠纷。这里的300块钱对于老板来说可能是小钱，但是对于员工来说，可能是他辛苦工作一天的收入，他会做出这种举动也是可以理解的。\r\n\r\n换位思考下如果老板是员工，通过加班加点赚到的工资，结果却少发了300块钱，这心里能舒服吗？员工之所以不满要离职，他计较的不是这300块钱，而是这300块钱折射出来，公司报酬体系公平性缺失的问题，是一种长期积累下来的表现。\r\n\r\n与其在纠结要不要辞退这名员工，还不如认真反思下为什么会出现这种情况。这件事说明了，公司在薪酬制度和发放流程上是存在问题的，如果不完善的话，后续还会有更多类似的员工出现的。当然，要是真碰到那种平时不努力干活，却想着多拿点工资，拿不到又各种计较的员工，那是就是后话了。\r\n\r\n大部分员工来公司上班的动机就是赚钱，公司给予的报酬能否让他满意，不仅受其所得的绝对报酬的影响，而且还受相对报酬的影响。两者只要有一个没处理好，员工都容易出现不满情绪的，甚至闹着要离职。\r\n\r\n####公平的绝对报酬，是员工能努力为公司工作的内在动力\r\n员工来公司上班，关心的是自己的努力付出是否能得到应有的报酬，如果公司内部出现创造效益少的人拿的报酬，却比创造效益高的人多，那员工肯定是会觉得不公平的，自然会不满。不满情绪积累到一定程度，就会爆发出来。\r\n\r\n在考虑要不要辞退这类员工前，先审视下公司的报酬制度是否出现不公平的现象，如果出现就得先完善。反之，在公平性原则下，这类员工还斤斤计较的话，并且屡教不改还态度消极的话，那就没必要留了。\r\n\r\n另外，之所以会出现少发300块钱的现象，就说明工作报酬发放制度上面是有问题的，这个也是需要完善的。\r\n\r\n王小山刚毕业没多久就进入了现在的公司，原本也是满怀激情的想在公司干一番事业出来的，每天非常拼命工作，业绩也非常突出。经过大半年的努力，原本以为能有一番回报的他，被现实抽了一个大耳光。\r\n\r\n跟他一起进来的另外一名员工，平日做事不积极，有好处倒是挺积极的。工作业绩也很一般，没想半年后被提拔的速度比王小山还快，现在已经是他的主管了，自然工资福利也随之提升了。\r\n\r\n王小山一开始以为这员工有什么特别强的能力是他不知道的，后面打听才知道，原来是老板亲戚介绍过来的。得之真相后，王小山的工作状态发生了180度大转变，工作已经没有了积极性。\r\n\r\n一个企业如果没办法做到绝对报酬的公平，那想叫员工为企业拼命，就是一开始员工会蒙在鼓里，没多久也会醒悟过来的。所以，想让员工自发的为公司努力工作，那就请让公司的绝对报酬尽量的公平化。\r\n\r\n####公平的相对报酬，是员工能把公司当成家的外在因素\r\n所谓相对报酬，是指员工的工作收入相对于同类型岗位的收入，包括其他公司的同类型岗位。为啥公司在员工心中会有好坏之分，不就是因为同样的岗位，同样的付出得到的报酬却是相差非常多的吗？\r\n\r\n如果公司平时的福利待遇并不比其他公司的差，那就是偶尔的少发个300块钱，员工也会理解的。就是因为前期积累下来的情绪，在碰到一条导火索的时候就被引爆了。想让员工把公司当成家，那相对报酬也要有公平性可言。\r\n\r\n只有公司的工资福利比外面高，员工有自豪感，自然就肯为公司努力工作，当成家来对待。那种天天画大饼的老板，要明白这届员工已经不吃这套了。\r\n\r\n有些老板会说，经常会有核心老员工被竞争对手高薪挖走，说他们没良心之类的话。殊不知，从员工的角度出发，感恩是一回事，自己能力价值在经济上的充分体现也是非常重要的。\r\n\r\n马云都说过，员工离职要嘛是委屈，要嘛就是钱给不到位。任正非也说过，建议给员工高工资，钱给多了，不是人才也是人才。\r\n\r\n现在的市场竞争，不单纯是产品的竞争，也还有人才的竞争，好的人才自然就会有人出高价。如果不懂这点，还是一味地用画饼技术来留住人才的话，那肯定是不行的。', 1, 0, 0, 40, 0, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/e3fa9cc7b2d7', '', '2019-10-22 12:16:27', '2019-11-01 21:10:52', NULL),
(11, 'Golang之template常用方法详解', 1, 3, '在写动态页面的网站的时候，我们常常将不变的部分提出成为模板，可变部分通过后端程序的渲染来生成动态网页，golang提供了html/template包来支持模板渲染。', '####Go template包下面有两个函数可以创建模板实例\r\n\r\n```go\r\nfunc New(name string) *Template \r\nfunc ParseFiles(filenames ...string) (*Template, error)\r\n```\r\n\r\n两个的不同点在于：\r\n\r\n- 1、使用 New() 在创建时就为其添加一个模板名称，并且执行 t.Execute() 会默认去寻找该名称进行数据融合；\r\n- 2、使用 ParseFiles() 创建模板可以一次指定多个文件加载多个模板进来，但是就不可以使用 t.Execute() 来执行数据融合；\r\n\r\n```go\r\nfunc (*Template) Execute\r\n\r\nfunc (t *Template) Execute(wr io.Writer, data interface{}) error\r\n\r\n```\r\nExecute方法将解析好的模板应用到data上，并将输出写入wr。如果执行时出现错误，会停止执行，但有可能已经写入wr部分数据。模板可以安全的并发执行。但是 ParseFiles() 可以通过\r\n\r\n```go\r\nfunc (t *Template) ExecuteTemplate(wr io.Writer, name string, data interface{}) error\r\n```\r\n\r\n来进行数据融合，因为该函数可以指定模板名，因此，实例模板就可以知道要去加载自己内部的哪一个模板进行数据融合。\r\n\r\n```go\r\nfunc (*Template) ExecuteTemplate\r\n\r\nfunc (t *Template) ExecuteTemplate(wr io.Writer, name string, data interface{}) error\r\n```\r\nExecuteTemplate方法类似Execute，但是使用名为name的t关联的模板产生输出。因为使用 t.Execute() 无法找到要使用哪个加载过的模板进行数据融合，而只有New()创建时才会指定一个 t.Execute() 执行时默认\r\n加载的模板。\r\n\r\n当然无论使用 New() 还是 ParseFiles() 创建模板，都是可以使用 ExecuteTemplate() 来进行数据融合，\r\n\r\n但是对于 Execute() 一般与 New() 创建的模板进行配合使用。**html/template 和 text/template** html下的template结构体 实际上是继承了 text 下面的 template结构体\r\n\r\ntemplate包下面还有一个 ParseGlob() 方法用于批量解析文件比如在当前目录下有以h开头的模板10个，使用 template.ParseGlob(“h*”) 即可页将10个模板文件一起解析出来。\r\n\r\n####注意事项\r\n\r\n下面这段代码的输出一定为空\r\n\r\n```go\r\nt := template.New(\"haha\")\r\nt, err := t.ParseFiles(\"header.tmpl\")\r\nfmt.Println(err)\r\nt.Execute(os.Stdout, nil)\r\n```\r\n原因是为什么呢…首先先记住一个原则 template.New() 和 ParseFiles() 最好不要一起使用，如果非要一起使用，那么要记住，New(“TName”) 中的 TName 必须要和 header.tmpl 中定义的{{define name}}中的 name 同名。\r\n\r\n但是正常的做法应该是这样的，同样的 ExecuteTemplate() 中输入的 name 也必须和模板中 {{define name}} 相同。\r\n\r\n```go\r\nt, _ := template.ParseFiles(\"header.tmpl\")\r\nt.ExecuteTemplate(os.Stdout, \"header\", nil)\r\n```\r\n\r\n这里要注意下，在这种情况下如果使用 t.Execute() 也是不会输出任何结果的，因为他并不知道你要使用哪个模板。另外一点要注意的就是，如果模板中没有与填充数据对应的模板语言，那么很有可能panic。\r\n\r\n模板中 {{}} 花括号表达式，自动实现了对js代码的过滤，如何不过滤js代码呢，只需要使用 text/template 包下的template，因为html/template包下的模板实现一些针对html的安全操作包括过滤js代码。\r\n\r\nGolang 当中支持 Pipeline，一样是使用 |，Go允许在模板中自定义变量，自定义模板函数。\r\n\r\n函数定义必须遵循如下格式：\r\n```go\r\nfunc FuncName(args ...interface{}) string\r\n```\r\n\r\n通过 template.FuncMap() 强制类型转换为 FuncMap 类型，然后再通过 template实例的 Func(FuncMap) 添加在模板实例中，这样该模板内部在解析时就可以使用该函数。\r\n\r\n####模板内置函数\r\n\r\n```go\r\nvar builtins = FuncMap{\r\n    \"and\":      and,\r\n    \"call\":     call,\r\n    \"html\":     HTMLEscaper,\r\n    \"index\":    index,\r\n    \"js\":       JSEscaper,\r\n    \"len\":      length,\r\n    \"not\":      not,\r\n    \"or\":       or,\r\n    \"print\":    fmt.Sprint,\r\n    \"printf\":   fmt.Sprintf,\r\n    \"println\":  fmt.Sprintln,\r\n    \"urlquery\": URLQueryEscaper,\r\n	\r\n    // Comparisons\r\n    \"eq\": eq, // ==\r\n    \"ge\": ge, // >=\r\n    \"gt\": gt, // >\r\n    \"le\": le, // <=\r\n    \"lt\": lt, // <\r\n    \"ne\": ne, // !=\r\n}\r\n```', 1, 1, 0, 112, 0, 0, 0, 0, 1, '', 'CSDN', 'https://blog.csdn.net/BigData_Mining/article/details/90030760', '', '2019-10-23 02:54:40', '2019-11-02 16:47:34', NULL),
(12, '双十一狂欢！天猫卖房特价、京东5折', 0, 9, '双十一是我国现在最大的电商狂欢节，“买买买”已成常态，不少网友面对马云与刘强东如此的大手笔都在好奇：难道马云说的“房价如葱”要成真了？', '随着时代的发展，人们的生活条件越来越好，可生活压力也越来越大。房价、车价、上还有老，下又有小，不少网友天天盼着涨工资那一天的到来。\r\n\r\n在这些压力中，最大的可以说就是房价了。不少网友都说：如果能回到20年前，我要做的第一件事就是把所有积蓄拿出来买房子！但阿里巴巴创始人马云却在退休前却说：未来会“房价如葱”，房子车子都不再值钱。并且在即将到来的双十一，天猫将特价拍卖上万套房源，京东也将5折售房。\r\n\r\n都知道双十一是我国现在最大的电商狂欢节，“买买买”已成常态，不少网友面对马云与刘强东如此的大手笔都在好奇：难道马云说的“房价如葱”要成真了？其实双十一狂欢，真正吸引人的不止房子的售卖，就像有人说的：本来1000万，5折后成了500万，你就买得起了？不过现在我国房子市场已经饱满，据媒体统计，现在除去自建房，拆迁房，公寓房，光商品房就可以住下34亿人。对于刘强东的突然宣布！马云没有骗我们？双十一京东淘宝放出的“重磅炸弹”，你怎么看？\r\n\r\n但根据媒体消息，京东为了双十一已经砸下100亿补贴，虽然房子上花了3亿，但还有97亿可以给用户“媷羊毛”。而天猫更是推出预售清单，并且双十一活动已经开始。所以房子买不买得起还没那么重要，需要秒杀抢购的东西能不能抢到才是重点，并且淘宝红包活动已经开始，据传因为微信出新规，很多链接都不准发了，所以淘宝的活动也跟去年不一样了。你有参与吗？\r\n\r\n对此，你有什么想说的？又有什么独到的见解呢？欢迎留言与大家一起讨论！', 1, 0, 0, 15, 0, 0, 0, 0, 1, '', '百家号', 'http://baijiahao.baidu.com/s?id=1648109404859654596', '', '2019-10-23 03:04:05', '2019-10-31 13:28:49', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `article_category`
--

DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `article_category`
--

INSERT INTO `article_category` (`id`, `name`, `tag`, `summary`, `parent`, `level`, `audit`, `sort`, `keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '笔记', 'note', '', 0, 1, 0, 0, '', '2019-10-15 23:57:43', '2019-10-15 23:57:43', NULL),
(2, '资讯', 'article', '', 0, 1, 0, 0, '', '2019-10-15 23:58:09', '2019-10-15 23:58:09', NULL),
(3, 'Golang', 'golang', '', 1, 2, 0, 0, '', '2019-10-15 23:59:07', '2019-10-15 23:59:07', NULL),
(4, 'PHP', 'php', '', 1, 2, 0, 0, '', '2019-10-15 23:59:31', '2019-10-15 23:59:31', NULL),
(5, 'JavaScript', 'javascript', '', 1, 2, 0, 0, '', '2019-10-16 00:00:01', '2019-10-24 15:17:11', NULL),
(6, '数据库', 'database', '', 1, 2, 0, 0, '', '2019-10-16 00:00:45', '2019-10-16 00:00:45', NULL),
(7, 'Linux', 'linux', '', 1, 2, 0, 0, '', '2019-10-16 00:01:07', '2019-10-16 00:01:07', NULL),
(8, '杂谈', 'talk-about', '', 2, 2, 0, 0, '', '2019-10-16 00:01:36', '2019-10-16 00:01:36', NULL),
(9, '互联网', 'Internet', '', 2, 2, 0, 0, '', '2019-10-16 00:02:34', '2019-10-16 00:02:34', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` int(11) NOT NULL DEFAULT 0,
  `category_id` int(4) DEFAULT 0,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogue` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit` tinyint(4) DEFAULT 0,
  `hit` int(11) NOT NULL DEFAULT 0 COMMENT '点击总数',
  `userful` int(10) NOT NULL DEFAULT 0 COMMENT '有用',
  `useless` int(10) NOT NULL DEFAULT 0 COMMENT '无用',
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '收藏总数',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT '评论总数',
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `book_category`
--

DROP TABLE IF EXISTS `book_category`;
CREATE TABLE `book_category` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `book_category`
--

INSERT INTO `book_category` (`id`, `name`, `summary`, `parent`, `level`, `audit`, `sort`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '手册', '', 0, 1, 1, 0, '2019-10-16 00:07:12', '2019-10-17 23:50:22', NULL),
(2, '教程', '', 0, 1, 1, 0, '2019-10-16 00:07:34', '2019-10-17 23:50:26', NULL),
(3, 'Golang', '', 1, 2, 1, 0, '2019-10-16 00:07:12', '2019-10-17 23:50:22', NULL),
(4, 'PHP', '', 1, 2, 1, 0, '2019-10-16 00:07:34', '2019-10-17 23:50:26', NULL),
(5, 'JavaScript', '', 1, 2, 1, 0, '2019-10-16 00:23:33', '2019-10-17 23:50:30', NULL),
(6, '数据库', '', 1, 2, 1, 0, '2019-10-16 00:23:51', '2019-10-17 23:50:34', NULL),
(7, 'Golang', '', 2, 2, 1, 0, '2019-10-16 00:07:12', '2019-10-17 23:50:22', NULL),
(8, 'PHP', '', 2, 2, 1, 0, '2019-10-16 00:07:34', '2019-10-17 23:50:26', NULL),
(9, 'JavaScript', '', 2, 2, 1, 0, '2019-10-16 00:23:33', '2019-10-17 23:50:30', NULL),
(10, '数据库', '', 2, 2, 1, 0, '2019-10-16 00:23:51', '2019-10-17 23:50:34', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `book_chapter`
--

DROP TABLE IF EXISTS `book_chapter`;
CREATE TABLE `book_chapter` (
  `id` int(10) NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '章节标题',
  `book_id` int(11) DEFAULT 0 COMMENT '所属书籍',
  `chapter` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '章节内容',
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序值',
  `hit` int(11) NOT NULL DEFAULT 0 COMMENT '点击总数',
  `useful` int(10) NOT NULL DEFAULT 0 COMMENT '有用',
  `useless` int(10) NOT NULL DEFAULT 0 COMMENT '无用',
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '收藏总数',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT '评论总数',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT 0 COMMENT '模型ID',
  `root` int(11) NOT NULL DEFAULT 0 COMMENT '主评论ID',
  `parent` int(11) NOT NULL DEFAULT 0 COMMENT '回复评论ID',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `useful` int(10) NOT NULL DEFAULT 0 COMMENT '有用',
  `useless` int(10) NOT NULL DEFAULT 0 COMMENT '无用',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `file`
--

DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件名称',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件分类',
  `path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` int(11) NOT NULL DEFAULT 0 COMMENT '图片宽度',
  `height` int(11) NOT NULL DEFAULT 0 COMMENT '图片高度',
  `ratio` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '图片高度比例',
  `size` int(11) NOT NULL DEFAULT 0 COMMENT '文件大小',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '上传用户',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `file`
--

INSERT INTO `file` (`id`, `name`, `category`, `path`, `width`, `height`, `ratio`, `size`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'e62e2cf8-84b5-4994-b26e-a90eff471097.jpg', 'article', '/uploads/article/2019-10-23/e62e2cf8-84b5-4994-b26e-a90eff471097.jpg', 250, 150, '1.67', 22866, 1, '2019-10-23 18:33:45', '2019-10-23 18:33:45', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `friend_link`
--

DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE `friend_link` (
  `id` int(10) NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` int(11) DEFAULT 0,
  `category_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属分类',
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `friend_link_category`
--

DROP TABLE IF EXISTS `friend_link_category`;
CREATE TABLE `friend_link_category` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '概要',
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `menu`
--

INSERT INTO `menu` (`id`, `name`, `tag`, `icon`, `summary`, `parent`, `level`, `audit`, `sort`, `keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '首页', '/', 'fal fa-home', '', 0, 1, 1, 0, '', '2019-10-15 23:11:22', '2019-11-01 02:02:10', NULL),
(2, '笔记', '#', 'fal fa-book-spells', '', 0, 1, 1, 0, '', '2019-10-15 23:12:16', '2019-11-01 02:02:59', NULL),
(3, '资讯', '#', 'fal fa-newspaper', '', 0, 1, 1, 0, '', '2019-10-15 23:13:47', '2019-11-01 02:05:24', NULL),
(4, '技术手册', '/book', 'fal fa-atlas', '', 0, 1, 1, 0, '', '2019-10-15 23:14:12', '2019-11-01 02:06:44', NULL),
(5, '教程', '/course', 'fal fa-chalkboard-teacher', '', 0, 1, 1, 0, '', '2019-10-15 23:15:43', '2019-11-01 02:06:58', NULL),
(6, '链接分享', '/link-share', 'fal fa-external-link', '', 0, 1, 1, 0, '', '2019-10-15 23:24:02', '2019-11-01 02:07:14', NULL),
(7, 'Golang', '/article/category/golang', 'fal fa-star-of-david', '', 2, 2, 1, 0, '', '2019-10-15 23:29:50', '2019-11-01 02:03:15', NULL),
(8, 'PHP', '/article/category/php', 'fab fa-php', '', 2, 2, 1, 0, '', '2019-10-15 23:30:42', '2019-11-01 02:03:39', NULL),
(9, 'JavaScript', '/article/category/javascript', 'fab fa-js-square', '', 2, 2, 1, 0, '', '2019-10-15 23:31:59', '2019-11-01 02:03:57', NULL),
(10, '数据库', '/article/category/database', 'fal fa-database', '', 2, 2, 1, 0, '', '2019-10-15 23:32:52', '2019-11-01 02:04:25', NULL),
(11, 'Linux', '/article/category/linux', 'fab fa-linux', '', 2, 2, 1, 0, '', '2019-10-15 23:36:53', '2019-11-01 02:05:09', NULL),
(12, '杂谈', '/article/category/talk-about', 'fal fa-newspaper', '', 3, 2, 1, 0, '', '2019-10-15 23:45:26', '2019-11-01 02:06:04', NULL),
(13, '互联网', '/article/category/Internet', 'fal fa-spider-web', '', 3, 2, 1, 0, '', '2019-10-15 23:45:49', '2019-11-01 02:06:20', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT 0 COMMENT '模型ID',
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='标签表';

--
-- 转存表中的数据 `tag`
--

INSERT INTO `tag` (`id`, `model`, `model_id`, `tag`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'article', 4, '接口', '2019-10-22 01:40:24', '2019-10-22 01:40:24', NULL),
(2, 'article', 4, '方法', '2019-10-22 01:40:24', '2019-10-22 01:40:24', NULL),
(3, 'article', 4, '指针', '2019-10-22 01:40:24', '2019-10-22 01:40:24', NULL),
(4, 'article', 9, 'javascript', '2019-10-22 12:12:49', '2019-10-22 12:12:49', NULL),
(5, 'article', 10, '辞退', '2019-10-23 00:20:40', '2019-10-23 00:20:40', NULL),
(6, 'article', 5, '产品', '2019-10-23 00:22:15', '2019-10-23 00:22:15', NULL),
(7, 'article', 7, '华为', '2019-10-23 00:22:29', '2019-10-23 00:22:29', NULL),
(8, 'article', 3, 'slice', '2019-10-23 00:22:57', '2019-10-23 00:22:57', NULL),
(9, 'article', 3, '去重', '2019-10-23 00:22:57', '2019-10-23 00:22:57', NULL),
(10, 'article', 2, '自定义', '2019-10-23 00:23:16', '2019-10-23 00:23:16', NULL),
(11, 'article', 2, 'json', '2019-10-23 00:23:16', '2019-10-23 00:23:16', NULL),
(12, 'article', 2, '解析', '2019-10-23 00:23:31', '2019-10-23 00:23:31', NULL),
(13, 'article', 1, '接口', '2019-10-23 00:24:06', '2019-10-23 00:24:06', NULL),
(14, 'article', 1, '指针', '2019-10-23 00:24:06', '2019-10-23 00:24:06', NULL),
(15, 'article', 1, '内存分配', '2019-10-23 00:24:06', '2019-10-23 00:24:06', NULL),
(16, 'article', 11, 'golang', '2019-10-23 02:54:40', '2019-10-23 02:54:40', NULL),
(17, 'article', 11, 'template', '2019-10-23 02:54:40', '2019-10-23 02:54:40', NULL),
(18, 'article', 12, '双十一', '2019-10-23 03:04:05', '2019-10-23 03:04:05', NULL),
(19, 'article', 12, '天猫', '2019-10-23 03:04:05', '2019-10-23 03:04:05', NULL),
(20, 'article', 12, '京东', '2019-10-23 03:04:05', '2019-10-23 03:04:05', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'TOKEN',
  `reset_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `mobile`, `password`, `access_token`, `reset_key`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Teddy', 'xiongjinchao@hotmail.com', '15911006066', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU2NTgsImlhdCI6MTU2MzI5NjQ1OCwiaWQiOjEsIm5iZiI6MTU2MzI5NjQ1OH0.Y3hXmAuRUPE5--pH24yO9yECwTXBNH9STtOdFKKchgQ', '0822480c4e4aedbca43cc65ff6831b50', '2019-04-02 00:38:07', '2019-08-31 03:53:41', NULL),
(2, 'Ted', 'xiongjinchao@gmail.com', '', '', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzI4NzM0NTQsImlhdCI6MTU3MjYxNDI1NCwiaWQiOjIsIm5iZiI6MTU3MjYxNDI1NH0.Pl-NMsTCutkDapfPGEpvJlZYpyPWVHuepysrXqA_kqE', '8d3a2f135d7b450ed1d08bdbd8e47dec', '2019-10-24 19:08:53', '2019-11-01 13:17:34', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权类型',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'access_token',
  `expires_in` int(11) DEFAULT 0 COMMENT 'access_token有效期',
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'refresh_token',
  `openid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'openid',
  `nickname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` smallint(4) DEFAULT 0 COMMENT '状态 0:未知,1:男,2:女',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `privilege` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户特权信息',
  `unionid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '联合ID',
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '国家',
  `province` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '省份',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '城市',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `user_auth`
--

INSERT INTO `user_auth` (`id`, `user_id`, `type`, `access_token`, `expires_in`, `refresh_token`, `openid`, `nickname`, `sex`, `avatar`, `privilege`, `unionid`, `country`, `province`, `city`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 'github', '9df8939985dbbfc1f402af8af4bf19d3491beacb', 0, '', '10016730', 'Ted', 0, 'https://avatars3.githubusercontent.com/u/10016730?v=4', '', '', '', '', '', '2019-10-25 03:08:53', '2019-11-01 21:17:34', NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `action_log`
--
ALTER TABLE `action_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `action_record`
--
ALTER TABLE `action_record`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  ADD UNIQUE KEY `email_UNIQUE` (`email`) USING BTREE;

--
-- 表的索引 `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `article_category`
--
ALTER TABLE `article_category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `book_category`
--
ALTER TABLE `book_category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `book_chapter`
--
ALTER TABLE `book_chapter`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `file`
--
ALTER TABLE `file`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `friend_link`
--
ALTER TABLE `friend_link`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `friend_link_category`
--
ALTER TABLE `friend_link_category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `email` (`email`) USING BTREE,
  ADD KEY `name` (`name`),
  ADD KEY `mobile` (`mobile`);

--
-- 表的索引 `user_auth`
--
ALTER TABLE `user_auth`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `action_log`
--
ALTER TABLE `action_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `action_record`
--
ALTER TABLE `action_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `article_category`
--
ALTER TABLE `article_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `book_category`
--
ALTER TABLE `book_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `book_chapter`
--
ALTER TABLE `book_chapter`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `file`
--
ALTER TABLE `file`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `friend_link`
--
ALTER TABLE `friend_link`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `friend_link_category`
--
ALTER TABLE `friend_link_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `user_auth`
--
ALTER TABLE `user_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;
