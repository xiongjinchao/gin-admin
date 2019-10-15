-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2019-10-15 23:02:17
-- 服务器版本： 10.2.24-MariaDB-log
-- PHP 版本： 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- 数据库： `gin-blog`
--

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

--
-- 转储表的索引
--

--
-- 表的索引 `action_log`
--
ALTER TABLE `action_log`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `action_log`
--
ALTER TABLE `action_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
