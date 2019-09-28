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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) NOT NULL DEFAULT '' COMMENT '密码',
  `remember_token` varchar(128) DEFAULT '' COMMENT 'TOKEN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','xiongjinchao@hotmail.com','15911006066','7c4a8d09ca3762af61e59520943dc26494f8941b','','2019-04-02 00:38:07','2019-07-30 17:33:33',NULL),(2,'xiongjinchao','67218026@qq.com','15911006062','7c4a8d09ca3762af61e59520943dc26494f8941b','','2019-07-08 22:56:08','2019-09-21 09:59:59',NULL);
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
  `title` varchar(200) NOT NULL DEFAULT '',
  `cover` int(11) DEFAULT '0',
  `category_id` int(4) DEFAULT '0',
  `content` text,
  `audit` tinyint(4) DEFAULT '0',
  `hot` tinyint(4) DEFAULT '0',
  `recommend` tinyint(4) DEFAULT '0',
  `hit` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `author` varchar(255) NOT NULL DEFAULT '',
  `source` varchar(100) DEFAULT NULL,
  `source_url` varchar(150) DEFAULT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (256,'Gin介绍',11,3,'# 介绍\r\n\r\nGin 是一个用 Go (Golang) 编写的 web 框架。 它是一个类似于 [martini](https://github.com/go-martini/martini) 但拥有更好性能的 API 框架, 由于 [httprouter](https://github.com/julienschmidt/httprouter)，速度提高了近 40 倍。 如果你是性能和高效的追求者, 你会爱上 Gin.\r\n\r\n在本节中，我们将介绍 Gin 是什么，它解决了哪些问题，以及它如何帮助你的项目。\r\n\r\n或者, 如果你已经准备在项目中使用 Gin，请访问[快速入门](https://gin-gonic.com/zh-cn/docs/quickstart/).\r\n\r\n## 特性\r\n\r\n### 快速\r\n\r\n基于 Radix 树的路由，小内存占用。没有反射。可预测的 API 性能。\r\n\r\n### 支持中间件\r\n\r\n传入的 HTTP 请求可以由一系列中间件和最终操作来处理。\r\n例如：Logger，Authorization，GZIP，最终操作 DB。\r\n\r\n### Crash 处理\r\n\r\nGin 可以 catch 一个发生在 HTTP 请求中的 panic 并 recover 它。这样，你的服务器将始终可用。例如，你可以向 Sentry 报告这个 panic！\r\n\r\n### JSON 验证\r\n\r\nGin 可以解析并验证请求的 JSON，例如检查所需值的存在。\r\n\r\n### 路由组\r\n\r\n更好地组织路由。是否需要授权，不同的 API 版本…… 此外，这些组可以无限制地嵌套而不会降低性能。\r\n\r\n### 错误管理\r\n\r\nGin 提供了一种方便的方法来收集 HTTP 请求期间发生的所有错误。最终，中间件可以将它们写入日志文件，数据库并通过网络发送。\r\n\r\n### 内置渲染\r\n\r\nGin 为 JSON，XML 和 HTML 渲染提供了易于使用的 API。\r\n\r\n### 可扩展性\r\n\r\n新建一个中间件非常简单，去查看[示例代码](https://gin-gonic.com/zh-cn/docs/examples/using-middleware/)吧。',1,1,1,0,1,'','','','','','','2019-08-06 02:03:39','2019-09-21 17:35:21',NULL);
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
  `name` varchar(100) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_category`
--

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
INSERT INTO `article_category` VALUES (1,'名人名言','famous_persons',0,1,0,0,'','','','2019-06-01 08:00:00','2019-08-09 03:08:16',NULL),(2,'创业故事','entrepreneurial_story',0,1,1,0,'','','','2019-06-01 08:00:00','2019-06-01 08:00:00',NULL),(3,'名人语录','',1,2,1,0,'','','','2019-06-01 08:00:00','2019-06-01 08:00:00',NULL),(4,'名人故事','',1,2,1,0,'','','','2019-06-01 08:00:00','2019-06-01 08:00:00',NULL),(5,'匠人故事',NULL,4,3,0,0,NULL,NULL,NULL,'2019-06-01 08:00:00','2019-06-01 08:00:00',NULL),(18,'星座','star',4,3,1,1,'test','test','test','2019-07-31 22:51:00','2019-07-31 23:22:01',NULL),(19,'起名','name',2,2,1,1,'','','','2019-07-31 23:26:38','2019-07-31 23:26:38',NULL),(20,'金牛座','cow',18,4,1,1,'','','','2019-07-31 23:27:42','2019-07-31 23:27:42',NULL);
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
  `name` varchar(100) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `catalogue` text,
  `audit` tinyint(4) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Gin框架中文手册','gin web framework','',1,'','','','2019-08-07 23:43:36','2019-08-07 23:44:42',NULL);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '文件名称',
  `category` varchar(50) NOT NULL DEFAULT '' COMMENT '文件分类',
  `path` varchar(512) NOT NULL,
  `width` int(11) NOT NULL DEFAULT '0' COMMENT '图片宽度',
  `height` int(11) NOT NULL DEFAULT '0' COMMENT '图片高度',
  `ratio` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '图片高度比例',
  `size` int(11) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '上传用户',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (3,'633a794f-0add-4341-af31-da6d2310a3d3.jpg','article','/public/uploads/article/2019-07-29/633a794f-0add-4341-af31-da6d2310a3d3.jpg',100,100,1.00,18587,1,'2019-07-29 23:40:02','2019-07-29 23:40:02',NULL),(5,'65a1686c-7d90-4be4-8bee-d2f56815d618.jpg','article','/public/uploads/article/2019-07-30/65a1686c-7d90-4be4-8bee-d2f56815d618.jpg',100,100,1.00,18587,1,'2019-07-30 00:53:46','2019-07-30 00:53:46','2019-07-30 00:53:54'),(6,'9eef868d-9045-44c8-902c-ec8a57100b20.jpg','article','/public/uploads/article/2019-07-30/9eef868d-9045-44c8-902c-ec8a57100b20.jpg',100,100,1.00,18587,1,'2019-07-30 00:54:04','2019-07-30 00:54:04',NULL),(7,'dab3e3b8-b960-4b4e-945e-b685c139d8b4.jpg','article','/public/uploads/article/2019-07-30/dab3e3b8-b960-4b4e-945e-b685c139d8b4.jpg',100,100,1.00,18587,1,'2019-07-30 00:54:33','2019-07-30 00:54:33',NULL),(8,'174a70d5-572e-4f7c-b995-c4a26521db62.jpg','article','/public/uploads/article/2019-07-30/174a70d5-572e-4f7c-b995-c4a26521db62.jpg',100,100,1.00,18587,1,'2019-07-30 22:15:42','2019-07-30 22:15:42',NULL),(9,'7f79c7bd-41ff-4d6c-a79b-3feece07c3a5.jpg','article','/public/uploads/article/2019-07-30/7f79c7bd-41ff-4d6c-a79b-3feece07c3a5.jpg',100,100,1.00,17642,1,'2019-07-30 22:27:11','2019-07-30 22:27:11','2019-07-30 22:58:33'),(10,'8e28a348-3023-4ee6-84ea-98342d76f502.jpg','article','/public/uploads/article/2019-08-06/8e28a348-3023-4ee6-84ea-98342d76f502.jpg',100,100,1.00,18587,1,'2019-08-06 02:24:57','2019-08-06 02:24:57','2019-09-21 16:51:41'),(11,'c31a1ba3-5851-41bd-9565-5658cdf8867d.jpg','article','/public/uploads/article/2019-09-21/c31a1ba3-5851-41bd-9565-5658cdf8867d.jpg',480,302,1.59,17642,1,'2019-09-21 17:35:13','2019-09-21 17:35:13',NULL),(12,'f22157d8-7688-4333-b279-2bc552ab6b64.jpg','article','/public/uploads/article/2019-09-21/f22157d8-7688-4333-b279-2bc552ab6b64.jpg',480,302,1.59,17642,1,'2019-09-21 17:41:28','2019-09-21 17:41:28','2019-09-21 17:41:39'),(13,'1028f0b3-196d-4f08-96a6-bc9523763d86.jpg','article','/public/uploads/article/2019-09-21/1028f0b3-196d-4f08-96a6-bc9523763d86.jpg',600,600,1.00,18587,1,'2019-09-21 17:41:52','2019-09-21 17:41:52',NULL),(14,'1b1561f8-6e47-4e09-b7e6-8acb13c7368a.jpg','friend_link','/public/uploads/friend_link/2019-09-22/1b1561f8-6e47-4e09-b7e6-8acb13c7368a.jpg',600,600,1.00,18587,1,'2019-09-22 15:20:46','2019-09-22 15:20:46',NULL),(15,'8b9617ba-5027-4e84-a1bd-9b4d41968894.jpg','friend_link','/public/uploads/friend_link/2019-09-22/8b9617ba-5027-4e84-a1bd-9b4d41968894.jpg',600,600,1.00,18587,1,'2019-09-22 17:27:11','2019-09-22 17:27:11',NULL);
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
  `title` varchar(100) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `image` int(11) DEFAULT '0',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_link`
--

LOCK TABLES `friend_link` WRITE;
/*!40000 ALTER TABLE `friend_link` DISABLE KEYS */;
INSERT INTO `friend_link` VALUES (1,'百度','http://www.baicheng.com',15,1,1,'2019-07-29 23:40:02','2019-09-01 00:00:00','2019-09-22 14:59:36','2019-09-22 17:48:50',NULL),(2,'谷歌','http://www.google.com',0,0,1,'2019-07-29 23:40:02','0000-00-00 00:00:00','2019-09-22 15:10:17','2019-09-22 18:58:16',NULL);
/*!40000 ALTER TABLE `friend_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT '0',
  `level` int(10) DEFAULT '1',
  `audit` tinyint(4) DEFAULT '0',
  `sort` int(4) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'首页','/',0,1,1,1,'','','','2019-08-06 22:35:17','2019-08-09 03:08:26',NULL),(2,'资讯','article',0,1,1,0,'','','','2019-08-06 22:35:47','2019-08-06 22:35:47',NULL),(3,'朋友圈','friend',0,1,1,0,'','','','2019-08-06 22:36:09','2019-08-06 22:36:09',NULL),(4,'名人名言','star',2,2,1,0,'','','','2019-08-06 22:36:40','2019-08-06 22:36:40',NULL),(5,'名人故事','story',2,2,1,0,'','','','2019-08-06 22:43:37','2019-08-06 22:43:37',NULL),(6,'匠人故事','story',5,3,1,0,'','','','2019-08-06 22:44:32','2019-08-06 22:44:32',NULL),(7,'星座','star',6,4,1,0,'','','','2019-08-06 22:44:46','2019-08-06 22:44:46',NULL),(8,'关于我','about-me',0,0,1,0,'','','','2019-08-06 22:58:25','2019-08-06 22:58:25',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) NOT NULL DEFAULT '' COMMENT '密码',
  `access_token` varchar(255) DEFAULT '' COMMENT 'TOKEN',
  `reset_key` varchar(255) DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Teddy','xiongjinchao@hotmail.com','15911006066','7c4a8d09ca3762af61e59520943dc26494f8941b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU2NTgsImlhdCI6MTU2MzI5NjQ1OCwiaWQiOjEsIm5iZiI6MTU2MzI5NjQ1OH0.Y3hXmAuRUPE5--pH24yO9yECwTXBNH9STtOdFKKchgQ','0822480c4e4aedbca43cc65ff6831b50','2019-04-02 08:38:07','2019-08-31 11:53:41',NULL),(51,'Bar','67218027@qq.com','15911006062','7c4a8d09ca3762af61e59520943dc26494f8941b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU5OTEsImlhdCI6MTU2MzI5Njc5MSwiaWQiOjUxLCJuYmYiOjE1NjMyOTY3OTF9.E-MfgP0Ax9TEUFGSzE5go74gjZiDrHITbDbccOzl_ok','3ea354c5ad30eb832a05562bde0fb345','2019-07-09 15:15:12','2019-07-31 18:15:12',NULL),(52,'Foo','67218021@qq.com','15911006063','7c4a8d09ca3762af61e59520943dc26494f8941b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTYyNjksImlhdCI6MTU2MzI5NzA2OSwiaWQiOjUyLCJuYmYiOjE1NjMyOTcwNjl9.wkXHvUMkBAfATt0bU3Ymmwqir0xo6t-uoBSMX4ZgDLc','34c5830bb9d0a186d960e5d186bd2a38','2019-07-16 17:11:10','2019-07-31 18:15:00',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-22 19:06:13
