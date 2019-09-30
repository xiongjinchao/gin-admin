/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : gin-blog

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 29/09/2019 11:24:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `remember_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'TOKEN',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE,
  UNIQUE INDEX `email_UNIQUE`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'xiongjinchao@hotmail.com', '15911006066', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', '2019-04-02 00:38:07', '2019-07-30 17:33:33', NULL);
INSERT INTO `admin` VALUES (2, 'xiongjinchao', '67218026@qq.com', '15911006062', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', '2019-07-08 22:56:08', '2019-09-21 09:59:59', NULL);

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cover` int(11) NULL DEFAULT 0,
  `category_id` int(4) NULL DEFAULT 0,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `audit` tinyint(4) NULL DEFAULT 0,
  `hot` tinyint(4) NULL DEFAULT 0,
  `recommend` tinyint(4) NULL DEFAULT 0,
  `hit` int(11) NULL DEFAULT 0,
  `user_id` int(11) NULL DEFAULT 0,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `source_url` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '【Golang】接口断言为指针类型，内存分配问题', 16, 3, '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n```go\r\npackage main\r\n\r\nimport \"fmt\"\r\n\r\nfunc main() {\r\n   var a = 34\r\n  var i interface{} = &a\r\n  o := i.(*int)\r\n   fmt.Println(i, o)\r\n}\r\n\r\n// output: 0xc4200160a0 0xc4200160a0\r\n```\r\n\r\n很明显了，就不解释了', 1, 1, 1, 0, 1, '', '', '', '', '', '', '2019-08-06 02:03:39', '2019-09-29 03:10:47', NULL);
INSERT INTO `article` VALUES (2, '【Golang】去除slice中重复的元素，认识空struct', 0, 3, '> 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。\r\n\r\n1. 删除slice中的一个或多个元素\r\n\r\n`s = append(s[:i], s[i+1:]...)`\r\n\r\n> 我第一次看到这种结构时感觉很迷茫，其实可以分开来看。首先s[:i]相当于slice截取，也就是说s[:i]本身就是一个slice。然后s[i+1:]...相当于变长参数。append()函数内部，通过循环append()递归操作即可。s本身的长度会发生改变，因为append()参数的是一个新的slice，然后赋值给s。但是s的容量不会变化。\r\n\r\n2. slice共享问题\r\n\r\n- 首先，slice之间赋值，是共享了内存地址的，如果修改其中一个，另外一个也会修改。就像函数传递slice参数的效果。\r\n\r\n- 如果两个slice之间共享，如果其中一个slice的长度发生了改变，另一个slice的长度是不会发生改变的，改变的是内存中的数据。\r\n\r\n```go\r\na1 := []int{1, 2, 3, 4, 5}\r\na2 := a1\r\n\r\na1 = append(a1[:1], a1[2:]...)\r\n\r\nfmt.Println(a2)\r\nfmt.Println(a1)\r\n\r\n//output:\r\n[1 3 4 5 5]\r\n[1 3 4 5]\r\n```', 1, 1, 1, 0, 1, '', '', '', '', '', '', '2019-09-28 16:20:21', '2019-09-28 16:27:50', NULL);
INSERT INTO `article` VALUES (3, '【Golang】json自定义序列化的深入解析', 0, 0, '> golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！\r\n\r\n另外让我们看一下空struct的作用，他之前一直没有被我重视，看来以后要多审视自己的coding了！\r\n\r\n```go\r\nfunc main() {\r\n    s := []string{\"hello\", \"world\", \"hello\", \"golang\", \"hello\", \"ruby\", \"php\", \"java\"}\r\n\r\n    fmt.Println(removeDuplicateElement(s))\r\n}\r\n\r\nfunc removeDuplicateElement(addrs []string) []string {\r\n    result := make([]string, 0, len(addrs))\r\n    temp := map[string]struct{}{}\r\n    for _, item := range addrs {\r\n        if _, ok := temp[item]; !ok {\r\n            temp[item] = struct{}{}\r\n            result = append(result, item)\r\n        }\r\n    }\r\n    return result\r\n}\r\n\r\n//output:\r\n[hello world golang ruby php java]\r\n```\r\n\r\n点评\r\n\r\n- 该函数总共初始化两个变量，一个长度为0的slice，一个空map。由于slice传参是按引用传递，没有创建额外的变量。\r\n\r\n- 只是用了一个for循环，代码更简洁易懂。\r\n\r\n- 利用了map的多返回值特性。\r\n\r\n- 空struct不占内存空间，可谓巧妙。\r\n', 1, 1, 1, 0, 0, '', '简书', 'https://www.jianshu.com/p/f8b0ed37513a', '', '', '', '2019-09-28 16:30:43', '2019-09-28 16:37:06', NULL);

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) NULL DEFAULT 1,
  `audit` tinyint(4) NULL DEFAULT 0,
  `sort` int(4) NULL DEFAULT 0,
  `seo_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `catalogue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `audit` tinyint(4) NULL DEFAULT 0,
  `seo_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, 'Gin框架中文手册', 'gin web framework', '', 1, '', '', '', '2019-08-07 23:43:36', '2019-08-07 23:44:42', NULL);

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件分类',
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `width` int(11) NOT NULL DEFAULT 0 COMMENT '图片宽度',
  `height` int(11) NOT NULL DEFAULT 0 COMMENT '图片高度',
  `ratio` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '图片高度比例',
  `size` int(11) NOT NULL DEFAULT 0 COMMENT '文件大小',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '上传用户',
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for friend_link
-- ----------------------------
DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE `friend_link`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` int(11) NULL DEFAULT 0,
  `audit` tinyint(4) NULL DEFAULT 0,
  `sort` int(4) NULL DEFAULT 0,
  `start_at` datetime(0) NULL DEFAULT NULL,
  `end_at` datetime(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent` int(10) NOT NULL DEFAULT 0,
  `level` int(10) NULL DEFAULT 1,
  `audit` tinyint(4) NULL DEFAULT 0,
  `sort` int(4) NULL DEFAULT 0,
  `seo_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seo_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '首页', '/', 0, 1, 1, 1, '', '', '', '2019-08-06 22:35:17', '2019-09-22 23:49:31', NULL);
INSERT INTO `menu` VALUES (2, '资讯', 'article', 0, 1, 1, 0, '', '', '', '2019-08-06 22:35:47', '2019-08-06 22:35:47', NULL);
INSERT INTO `menu` VALUES (3, '朋友圈', 'friend', 0, 1, 1, 0, '', '', '', '2019-08-06 22:36:09', '2019-08-06 22:36:09', NULL);
INSERT INTO `menu` VALUES (4, '名人名言', 'star', 2, 2, 1, 0, '', '', '', '2019-08-06 22:36:40', '2019-09-23 00:08:28', NULL);
INSERT INTO `menu` VALUES (5, '名人故事', 'story', 9, 3, 1, 0, '', '', '', '2019-08-06 22:43:37', '2019-09-23 01:41:08', NULL);
INSERT INTO `menu` VALUES (6, '匠人故事', 'story', 8, 2, 1, 0, '', '', '', '2019-08-06 22:44:32', '2019-09-23 01:41:31', NULL);
INSERT INTO `menu` VALUES (7, '星座', 'star', 6, 3, 1, 0, '', '', '', '2019-08-06 22:44:46', '2019-09-23 01:41:31', NULL);
INSERT INTO `menu` VALUES (8, '关于我', 'about-me', 0, 1, 1, 0, '', '', '', '2019-08-06 22:58:25', '2019-09-23 01:38:28', NULL);
INSERT INTO `menu` VALUES (9, '运营', 'star', 8, 2, 0, 0, '', '', '', '2019-09-22 23:50:16', '2019-09-23 01:41:08', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'TOKEN',
  `reset_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE,
  UNIQUE INDEX `email_UNIQUE`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Teddy', 'xiongjinchao@hotmail.com', '15911006066', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NjM1NTU2NTgsImlhdCI6MTU2MzI5NjQ1OCwiaWQiOjEsIm5iZiI6MTU2MzI5NjQ1OH0.Y3hXmAuRUPE5--pH24yO9yECwTXBNH9STtOdFKKchgQ', '0822480c4e4aedbca43cc65ff6831b50', '2019-04-02 08:38:07', '2019-08-31 11:53:41', NULL);

SET FOREIGN_KEY_CHECKS = 1;