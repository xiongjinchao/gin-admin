-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: gin-blog
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action_log`
--

DROP TABLE IF EXISTS `action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作类型 favorite useful useless',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_log`
--

LOCK TABLES `action_log` WRITE;
/*!40000 ALTER TABLE `action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_record`
--

DROP TABLE IF EXISTS `action_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作类型 favorite useful useless',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_record`
--

LOCK TABLES `action_record` WRITE;
/*!40000 ALTER TABLE `action_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `remember_token` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'TOKEN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  UNIQUE KEY `email_UNIQUE` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','xiongjinchao@hotmail.com','15911006066','7c4a8d09ca3762af61e59520943dc26494f8941b','','2019-04-01 16:38:07','2019-07-30 09:33:33',NULL),(2,'xiongjinchao','67218026@qq.com','15911006062','7c4a8d09ca3762af61e59520943dc26494f8941b','','2019-07-08 14:56:08','2019-09-21 01:59:59',NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cover` int(11) DEFAULT '0',
  `category_id` int(4) DEFAULT '0',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `audit` tinyint(4) DEFAULT '0',
  `hot` tinyint(4) DEFAULT '0',
  `recommend` tinyint(4) DEFAULT '0',
  `hit` int(11) DEFAULT '0' COMMENT '点击总数',
  `favorite` int(11) NOT NULL DEFAULT '0' COMMENT '喜欢总数',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT '评论总数',
  `user_id` int(11) DEFAULT '0',
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `source` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'【Golang】接口断言为指针类型，内存分配问题',0,3,'','> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n```go\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main() {\r\n   var a = 34\r\n  var i interface{} = &a\r\n  o := i.(*int)\r\n   fmt.Println(i, o)\r\n}\r\n\r\n// output: 0xc4200160a0 0xc4200160a0\r\n```\r\n\r\n很明显了，就不解释了',1,1,1,0,0,0,1,'','','','','2019-08-06 02:03:39','2019-10-16 00:27:39',NULL),(2,'【Golang】去除slice中重复的元素，认识空struct',0,3,'','> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n1. 删除slice中的一个或多个元素\r\n\r\n`s = append(s[:i], s[i+1:]...)`\r\n\r\n> 我第一次看到这种结构时感觉很迷茫，其实可以分开来看。首先s[:i]相当于slice截取，也就是说s[:i]本身就是一个slice。然后s[i+1:]...相当于变长参数。append()函数内部，通过循环append()递归操作即可。s本身的长度会发生改变，因为append()参数的是一个新的slice，然后赋值给s。但是s的容量不会变化。\r\n\r\n2. slice共享问题\r\n\r\n- 首先，slice之间赋值，是共享了内存地址的，如果修改其中一个，另外一个也会修改。就像函数传递slice参数的效果。\r\n\r\n- 如果两个slice之间共享，如果其中一个slice的长度发生了改变，另一个slice的长度是不会发生改变的，改变的是内存中的数据。\r\n\r\n```go\r\na1 := []int{1, 2, 3, 4, 5}\r\na2 := a1\r\n\r\na1 = append(a1[:1], a1[2:]...)\r\n\r\nfmt.Println(a2)\r\nfmt.Println(a1)\r\n\r\n//output:\r\n[1 3 4 5 5]\r\n[1 3 4 5]\r\n```',1,1,1,0,0,0,1,'','','','','2019-09-28 16:20:21','2019-09-28 16:27:50',NULL),(3,'【Golang】json自定义序列化的深入解析',0,3,'','> golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！\r\n\r\n另外让我们看一下空struct的作用，他之前一直没有被我重视，看来以后要多审视自己的coding了！\r\n\r\n```go\r\nfunc main() {\r\n    s := []string{\"hello\", \"world\", \"hello\", \"golang\", \"hello\", \"ruby\", \"php\", \"java\"}\r\n\r\n    fmt.Println(removeDuplicateElement(s))\r\n}\r\n\r\nfunc removeDuplicateElement(addrs []string) []string {\r\n    result := make([]string, 0, len(addrs))\r\n    temp := map[string]struct{}{}\r\n    for _, item := range addrs {\r\n        if _, ok := temp[item]; !ok {\r\n            temp[item] = struct{}{}\r\n            result = append(result, item)\r\n        }\r\n    }\r\n    return result\r\n}\r\n\r\n//output:\r\n[hello world golang ruby php java]\r\n```\r\n\r\n点评\r\n\r\n- 该函数总共初始化两个变量，一个长度为0的slice，一个空map。由于slice传参是按引用传递，没有创建额外的变量。\r\n\r\n- 只是用了一个for循环，代码更简洁易懂。\r\n\r\n- 利用了map的多返回值特性。\r\n\r\n- 空struct不占内存空间，可谓巧妙。\r\n',1,1,1,0,0,0,1,'','简书','https://www.jianshu.com/p/f8b0ed37513a','','2019-09-28 16:30:43','2019-10-16 03:36:21',NULL);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_category`
--

DROP TABLE IF EXISTS `article_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_category`
--

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
INSERT INTO `article_category` VALUES (1,'笔记','note','',0,1,0,0,'','2019-10-15 23:57:43','2019-10-15 23:57:43',NULL),(2,'资讯','article','',0,1,0,0,'','2019-10-15 23:58:09','2019-10-15 23:58:09',NULL),(3,'Golang','golang','',1,2,0,0,'','2019-10-15 23:59:07','2019-10-15 23:59:07',NULL),(4,'PHP','php','',1,2,0,0,'','2019-10-15 23:59:31','2019-10-15 23:59:31',NULL),(5,'JavaScript','javaScript','',1,2,0,0,'','2019-10-16 00:00:01','2019-10-16 00:00:01',NULL),(6,'数据库','database','',1,2,0,0,'','2019-10-16 00:00:45','2019-10-16 00:00:45',NULL),(7,'Linux','linux','',1,2,0,0,'','2019-10-16 00:01:07','2019-10-16 00:01:07',NULL),(8,'杂谈','talk-about','',2,2,0,0,'','2019-10-16 00:01:36','2019-10-16 00:01:36',NULL),(9,'互联网','Internet','',2,2,0,0,'','2019-10-16 00:02:34','2019-10-16 00:02:34',NULL);
/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` int(11) NOT NULL DEFAULT '0',
  `category_id` int(4) DEFAULT '0',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogue` text COLLATE utf8mb4_unicode_ci,
  `audit` tinyint(4) DEFAULT '0',
  `hit` int(11) NOT NULL DEFAULT '0' COMMENT '点击总数',
  `favorite` int(11) NOT NULL DEFAULT '0' COMMENT '喜欢总数',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT '评论总数',
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_category`
--

DROP TABLE IF EXISTS `book_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_category`
--

LOCK TABLES `book_category` WRITE;
/*!40000 ALTER TABLE `book_category` DISABLE KEYS */;
INSERT INTO `book_category` VALUES (1,'Golang','',0,1,0,0,'2019-10-16 00:07:12','2019-10-16 00:07:12',NULL),(2,'PHP','',0,1,0,0,'2019-10-16 00:07:34','2019-10-16 00:07:34',NULL),(3,'JavaScript','',0,1,0,0,'2019-10-16 00:23:33','2019-10-16 00:24:34',NULL),(4,'数据库','',0,1,0,0,'2019-10-16 00:23:51','2019-10-16 00:24:02',NULL);
/*!40000 ALTER TABLE `book_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_chapter`
--

DROP TABLE IF EXISTS `book_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_chapter` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '章节标题',
  `book_id` int(11) DEFAULT '0' COMMENT '所属书籍',
  `chapter` text COLLATE utf8mb4_unicode_ci COMMENT '章节内容',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序值',
  `hit` int(11) NOT NULL DEFAULT '0' COMMENT '点击总数',
  `favorite` int(11) NOT NULL DEFAULT '0' COMMENT '喜欢总数',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT '评论总数',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_chapter`
--

LOCK TABLES `book_chapter` WRITE;
/*!40000 ALTER TABLE `book_chapter` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `root` int(11) NOT NULL DEFAULT '0' COMMENT '主评论ID',
  `parent` int(11) NOT NULL DEFAULT '0' COMMENT '回复评论ID',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件名称',
  `category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件分类',
  `path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` int(11) NOT NULL DEFAULT '0' COMMENT '图片宽度',
  `height` int(11) NOT NULL DEFAULT '0' COMMENT '图片高度',
  `ratio` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '图片高度比例',
  `size` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '上传用户',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_link`
--

DROP TABLE IF EXISTS `friend_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_link` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` int(11) DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属分类',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_link`
--

LOCK TABLES `friend_link` WRITE;
/*!40000 ALTER TABLE `friend_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_link_category`
--

DROP TABLE IF EXISTS `friend_link_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_link_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '概要',
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_link_category`
--

LOCK TABLES `friend_link_category` WRITE;
/*!40000 ALTER TABLE `friend_link_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_link_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'首页','/','',0,1,1,0,'','2019-10-15 23:11:22','2019-10-15 23:11:22',NULL),(2,'笔记','#','',0,1,1,0,'','2019-10-15 23:12:16','2019-10-16 00:26:06',NULL),(3,'资讯','#','',0,1,1,0,'','2019-10-15 23:13:47','2019-10-16 00:26:14',NULL),(4,'技术手册','/book','',0,1,1,0,'','2019-10-15 23:14:12','2019-10-15 23:14:28',NULL),(5,'教程','/course','',0,1,0,0,'','2019-10-15 23:15:43','2019-10-15 23:47:49',NULL),(6,'链接分享','/link-share','',0,1,1,0,'','2019-10-15 23:24:02','2019-10-15 23:24:10',NULL),(7,'Golang','/article/golang','',2,2,1,0,'','2019-10-15 23:29:50','2019-10-16 00:26:31',NULL),(8,'PHP','/article/php','',2,2,1,0,'','2019-10-15 23:30:42','2019-10-16 00:26:38',NULL),(9,'JavaScript','/article/javascript','',2,2,1,0,'','2019-10-15 23:31:59','2019-10-16 00:26:44',NULL),(10,'数据库','/article/database','',2,2,1,0,'','2019-10-15 23:32:52','2019-10-16 00:26:51',NULL),(11,'Linux','/article/linux','',2,2,1,0,'','2019-10-15 23:36:53','2019-10-16 00:26:58',NULL),(12,'杂谈','/article/talk-about','',3,2,1,0,'','2019-10-15 23:45:26','2019-10-16 00:26:14',NULL),(13,'互联网','/article/Internet','',3,2,1,0,'','2019-10-15 23:45:49','2019-10-16 00:26:14',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '所属模型',
  `model_id` int(11) NOT NULL DEFAULT '0' COMMENT '模型ID',
  `tag` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='标签表';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'TOKEN',
  `reset_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  UNIQUE KEY `email_UNIQUE` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Teddy','xiongjinchao@hotmail.com','15911006066','7c4a8d09ca3762af61e59520943dc26494f8941b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU2NTgsImlhdCI6MTU2MzI5NjQ1OCwiaWQiOjEsIm5iZiI6MTU2MzI5NjQ1OH0.Y3hXmAuRUPE5--pH24yO9yECwTXBNH9STtOdFKKchgQ','0822480c4e4aedbca43cc65ff6831b50','2019-04-02 00:38:07','2019-08-31 03:53:41',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '授权类型',
  `access_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'access_token',
  `expires_in` int(11) NOT NULL DEFAULT '0' COMMENT 'access_token有效期',
  `refresh_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'refresh_token',
  `openid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'openid',
  `nickname` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` smallint(4) NOT NULL DEFAULT '0' COMMENT '状态 0:未知,1:男,2:女',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `privilege` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户特权信息',
  `unionid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '联合ID',
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '城市',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

LOCK TABLES `user_auth` WRITE;
/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_auth` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-16  3:46:08
