-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2019-10-12 16:04:54
-- 服务器版本： 10.2.24-MariaDB-log
-- PHP 版本： 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `gin-blog`
--
CREATE DATABASE IF NOT EXISTS `gin-blog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `gin-blog`;

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
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit` tinyint(4) DEFAULT 0,
  `hot` tinyint(4) DEFAULT 0,
  `recommend` tinyint(4) DEFAULT 0,
  `hit` int(11) DEFAULT 0 COMMENT '点击总数',
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '喜欢总数',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT '评论总数',
  `user_id` int(11) DEFAULT 0,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `source` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `article`
--

INSERT INTO `article` (`id`, `title`, `cover`, `category_id`, `content`, `audit`, `hot`, `recommend`, `hit`, `favorite`, `comment`, `user_id`, `author`, `source`, `source_url`, `seo_title`, `seo_description`, `seo_keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '【Golang】接口断言为指针类型，内存分配问题', 0, 0, '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n```go\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main() {\r\n   var a = 34\r\n  var i interface{} = &a\r\n  o := i.(*int)\r\n   fmt.Println(i, o)\r\n}\r\n\r\n// output: 0xc4200160a0 0xc4200160a0\r\n```\r\n\r\n很明显了，就不解释了', 1, 1, 1, 0, 0, 0, 1, '', '', '', '', '', '', '2019-08-06 02:03:39', '2019-09-30 01:31:33', NULL),
(2, '【Golang】去除slice中重复的元素，认识空struct', 0, 3, '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n1. 删除slice中的一个或多个元素\r\n\r\n`s = append(s[:i], s[i+1:]...)`\r\n\r\n> 我第一次看到这种结构时感觉很迷茫，其实可以分开来看。首先s[:i]相当于slice截取，也就是说s[:i]本身就是一个slice。然后s[i+1:]...相当于变长参数。append()函数内部，通过循环append()递归操作即可。s本身的长度会发生改变，因为append()参数的是一个新的slice，然后赋值给s。但是s的容量不会变化。\r\n\r\n2. slice共享问题\r\n\r\n- 首先，slice之间赋值，是共享了内存地址的，如果修改其中一个，另外一个也会修改。就像函数传递slice参数的效果。\r\n\r\n- 如果两个slice之间共享，如果其中一个slice的长度发生了改变，另一个slice的长度是不会发生改变的，改变的是内存中的数据。\r\n\r\n```go\r\na1 := []int{1, 2, 3, 4, 5}\r\na2 := a1\r\n\r\na1 = append(a1[:1], a1[2:]...)\r\n\r\nfmt.Println(a2)\r\nfmt.Println(a1)\r\n\r\n//output:\r\n[1 3 4 5 5]\r\n[1 3 4 5]\r\n```', 1, 1, 1, 0, 0, 0, 1, '', '', '', '', '', '', '2019-09-28 16:20:21', '2019-09-28 16:27:50', NULL),
(3, '【Golang】json自定义序列化的深入解析', 0, 0, '> golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！\r\n\r\n另外让我们看一下空struct的作用，他之前一直没有被我重视，看来以后要多审视自己的coding了！\r\n\r\n```go\r\nfunc main() {\r\n    s := []string{\"hello\", \"world\", \"hello\", \"golang\", \"hello\", \"ruby\", \"php\", \"java\"}\r\n\r\n    fmt.Println(removeDuplicateElement(s))\r\n}\r\n\r\nfunc removeDuplicateElement(addrs []string) []string {\r\n    result := make([]string, 0, len(addrs))\r\n    temp := map[string]struct{}{}\r\n    for _, item := range addrs {\r\n        if _, ok := temp[item]; !ok {\r\n            temp[item] = struct{}{}\r\n            result = append(result, item)\r\n        }\r\n    }\r\n    return result\r\n}\r\n\r\n//output:\r\n[hello world golang ruby php java]\r\n```\r\n\r\n点评\r\n\r\n- 该函数总共初始化两个变量，一个长度为0的slice，一个空map。由于slice传参是按引用传递，没有创建额外的变量。\r\n\r\n- 只是用了一个for循环，代码更简洁易懂。\r\n\r\n- 利用了map的多返回值特性。\r\n\r\n- 空struct不占内存空间，可谓巧妙。\r\n', 1, 1, 1, 0, 0, 0, 1, '', '简书', 'https://www.jianshu.com/p/f8b0ed37513a', '', '', '', '2019-09-28 16:30:43', '2019-09-30 01:31:47', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `article_category`
--

DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(10) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogue` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audit` tinyint(4) DEFAULT 0,
  `hit` int(11) NOT NULL DEFAULT 0 COMMENT '点击总数',
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '喜欢总数',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT '评论总数',
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `book`
--

INSERT INTO `book` (`id`, `name`, `tag`, `catalogue`, `audit`, `hit`, `favorite`, `comment`, `seo_title`, `seo_description`, `seo_keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Gin框架中文手册', 'gin web framework', '```go\r\nfunction main(){\r\n	fmt.Println(\"Hello world!\")\r\n}\r\n```', 1, 0, 0, 0, '', '', '', '2019-08-07 23:43:36', '2019-09-30 17:42:10', NULL);

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
  `favorite` int(11) NOT NULL DEFAULT 0 COMMENT '喜欢总数',
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
  `root_id` int(11) NOT NULL DEFAULT 0 COMMENT '主评论ID',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '回复评论ID',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '评论内容',
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
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) DEFAULT 1,
  `audit` tinyint(4) DEFAULT 0,
  `sort` int(4) DEFAULT 0,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `menu`
--

INSERT INTO `menu` (`id`, `name`, `tag`, `parent`, `level`, `audit`, `sort`, `seo_title`, `seo_description`, `seo_keyword`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '首页', '/', 0, 1, 1, 1, '', '', '', '2019-08-06 22:35:17', '2019-09-22 23:49:31', NULL),
(2, '资讯', 'article', 0, 1, 1, 0, '', '', '', '2019-08-06 22:35:47', '2019-08-06 22:35:47', NULL),
(3, '朋友圈', 'friend', 0, 1, 1, 0, '', '', '', '2019-08-06 22:36:09', '2019-08-06 22:36:09', NULL),
(4, '名人名言', 'star', 2, 2, 1, 0, '', '', '', '2019-08-06 22:36:40', '2019-09-23 00:08:28', NULL),
(5, '名人故事', 'story', 9, 4, 1, 0, '', '', '', '2019-08-06 22:43:37', '2019-09-30 20:02:02', NULL),
(6, '匠人故事', 'story', 8, 2, 1, 0, '', '', '', '2019-08-06 22:44:32', '2019-09-23 01:41:31', NULL),
(7, '星座', 'star', 6, 3, 1, 0, '', '', '', '2019-08-06 22:44:46', '2019-09-23 01:41:31', NULL),
(8, '关于我', 'about-me', 0, 1, 1, 0, '', '', '', '2019-08-06 22:58:25', '2019-09-23 01:38:28', NULL),
(9, '运营', 'star', 6, 3, 0, 0, '', '', '', '2019-09-22 23:50:16', '2019-09-30 20:02:02', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
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
(1, 'Teddy', 'xiongjinchao@hotmail.com', '15911006066', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU2NTgsImlhdCI6MTU2MzI5NjQ1OCwiaWQiOjEsIm5iZiI6MTU2MzI5NjQ1OH0.Y3hXmAuRUPE5--pH24yO9yECwTXBNH9STtOdFKKchgQ', '0822480c4e4aedbca43cc65ff6831b50', '2019-04-02 00:38:07', '2019-08-31 03:53:41', NULL);

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
  `expires_in` int(11) NOT NULL DEFAULT 0 COMMENT 'access_token有效期',
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'refresh_token',
  `openid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'openid',
  `nickname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` smallint(4) NOT NULL DEFAULT 0 COMMENT '状态 0:未知,1:男,2:女',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `privilege` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户特权信息',
  `unionid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '联合ID',
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '城市',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转储表的索引
--

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
  ADD UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  ADD UNIQUE KEY `email_UNIQUE` (`email`) USING BTREE;

--
-- 表的索引 `user_auth`
--
ALTER TABLE `user_auth`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `article_category`
--
ALTER TABLE `article_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `user_auth`
--
ALTER TABLE `user_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
