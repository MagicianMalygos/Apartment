-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: WenHuiApartment
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `T_ANSWER_RECORD`
--

DROP TABLE IF EXISTS `T_ANSWER_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_ANSWER_RECORD` (
  `pk_answer_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '答题记录表编号',
  `answer_record_answer` longtext CHARACTER SET utf8 NOT NULL COMMENT '答案',
  `answer_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `answer_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_answer_record_user_id` int(11) NOT NULL COMMENT '答题人',
  `fk_answer_record_question_id` int(11) NOT NULL COMMENT '题目id',
  PRIMARY KEY (`pk_answer_record_id`),
  KEY `fk_T_ANSWER_RECORD_T_USER1_idx` (`fk_answer_record_user_id`),
  KEY `fk_T_ANSWER_RECORD_T_QUESTION1_idx` (`fk_answer_record_question_id`),
  CONSTRAINT `fk_T_ANSER_RECORD_T_QUESTION1` FOREIGN KEY (`fk_answer_record_question_id`) REFERENCES `T_QUESTION` (`pk_question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ANSER_RECORD_T_USER1` FOREIGN KEY (`fk_answer_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_ANSWER_RECORD`
--

LOCK TABLES `T_ANSWER_RECORD` WRITE;
/*!40000 ALTER TABLE `T_ANSWER_RECORD` DISABLE KEYS */;
INSERT INTO `T_ANSWER_RECORD` VALUES (123,'3','2016-04-12 11:38:31',1,1,1),(124,'4','2016-04-12 11:38:31',1,1,2),(125,'4','2016-04-12 11:38:31',1,1,3),(126,'4','2016-04-12 11:38:31',1,1,4),(127,'4','2016-04-12 11:38:31',1,1,5);
/*!40000 ALTER TABLE `T_ANSWER_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_ARGUMENT`
--

DROP TABLE IF EXISTS `T_ARGUMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_ARGUMENT` (
  `pk_argument_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '论据表编号',
  `argument_content` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '论据内容',
  `argument_support` int(11) NOT NULL DEFAULT '0' COMMENT '点赞量',
  `argument_belong` int(11) NOT NULL COMMENT '所属正反方',
  `argument_time` datetime NOT NULL COMMENT '记录添加时间',
  `argument_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_argument_thesis_id` int(11) NOT NULL COMMENT '辩题编号',
  `fk_argument_user_id` int(11) NOT NULL COMMENT '辩论人编号',
  `fk_argument_state_id` int(11) NOT NULL DEFAULT '10' COMMENT '匿名状态',
  PRIMARY KEY (`pk_argument_id`),
  KEY `fk_T_ARGUEMENT_T_THESIS1_idx` (`fk_argument_thesis_id`),
  KEY `fk_T_ARGUEMENT_T_USER1_idx` (`fk_argument_user_id`),
  KEY `fk_T_ARGUEMENT_T_STATE1_idx` (`fk_argument_state_id`),
  CONSTRAINT `fk_T_ARGUEMENT_T_STATE1` FOREIGN KEY (`fk_argument_state_id`) REFERENCES `T_STATE` (`pk_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ARGUEMENT_T_THESIS1` FOREIGN KEY (`fk_argument_thesis_id`) REFERENCES `T_THESIS` (`pk_thesis_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ARGUEMENT_T_USER1` FOREIGN KEY (`fk_argument_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_ARGUMENT`
--

LOCK TABLES `T_ARGUMENT` WRITE;
/*!40000 ALTER TABLE `T_ARGUMENT` DISABLE KEYS */;
INSERT INTO `T_ARGUMENT` VALUES (1,'人本是善良的',20,0,'2015-10-10 10:00:10',1,1,1,9),(2,'人本是邪恶的',20,1,'2015-10-10 10:00:11',1,1,2,9),(3,'人本是善良的',0,0,'2015-10-10 10:00:12',1,2,3,10),(4,'人本是邪恶的',0,1,'2015-10-10 10:10:13',1,2,4,10),(5,'人本是善良的',44,0,'2015-10-10 10:10:14',1,3,5,10),(6,'人本是邪恶的',20,1,'2015-10-10 10:10:15',1,3,6,10),(7,'人本是善良的',20,0,'2015-10-10 10:10:16',1,4,7,10),(8,'人本是邪恶的',10,1,'2015-10-10 10:10:17',1,4,8,10),(9,'人本是善良的',10,0,'2015-10-10 10:10:18',1,5,9,10),(10,'人本是邪恶的',10,1,'2015-10-10 10:10:19',1,5,10,9),(20,'123',0,0,'2016-02-18 16:11:19',1,1,1,9),(21,'1',0,1,'2016-02-18 16:21:29',1,1,1,10),(22,'Aa',0,0,'2016-02-18 16:27:26',1,1,1,10),(23,'Asdasd',0,0,'2016-02-18 16:27:41',1,1,1,10),(24,'A',6,1,'2016-02-18 16:30:30',1,1,1,10),(25,'Sd',1,0,'2016-02-18 16:30:39',1,1,1,10),(26,'11111',0,1,'2016-02-18 18:58:44',1,1,1,10),(27,'222222',0,1,'2016-02-18 18:58:47',1,1,1,10),(28,'333333',0,1,'2016-02-18 18:58:51',1,1,1,10),(29,'44444',0,1,'2016-02-18 18:58:54',1,1,1,10),(30,'55555',0,1,'2016-02-18 18:58:59',1,1,1,10),(31,'66666',1,1,'2016-02-18 18:59:24',1,1,1,10),(32,'777777',1,1,'2016-02-18 18:59:27',1,1,1,10),(33,'888888',1,1,'2016-02-18 18:59:32',1,1,1,10),(34,'F',1,0,'2016-02-24 13:04:36',1,1,1,9),(35,'Adfadsfadf',0,1,'2016-03-16 18:07:41',1,1,1,10),(36,'Zcp',0,1,'2016-03-18 15:25:57',1,1,1,10),(37,'Zcpdgr',0,1,'2016-04-06 14:13:41',1,1,1,10),(38,'Zcp',0,1,'2016-04-06 14:13:53',1,1,1,9);
/*!40000 ALTER TABLE `T_ARGUMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_ARGUMENT_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_ARGUMENT_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_ARGUMENT_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '论据点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_argument_sup_record_argument_id` int(11) NOT NULL COMMENT '论据编号',
  `fk_argument_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_ARGUMENT_SUPPORT_T_ARGUMENT1_idx` (`fk_argument_sup_record_argument_id`),
  KEY `fk_T_ARGUMENT_SUPPORT_T_USER1_idx` (`fk_argument_sup_record_user_id`),
  CONSTRAINT `fk_T_ARGUMENT_SUPPORT_T_ARGUMENT1` FOREIGN KEY (`fk_argument_sup_record_argument_id`) REFERENCES `T_ARGUMENT` (`pk_argument_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_ARGUMENT_SUPPORT_T_USER1` FOREIGN KEY (`fk_argument_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_ARGUMENT_SUP_RECORD`
--

LOCK TABLES `T_ARGUMENT_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_ARGUMENT_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_ARGUMENT_SUP_RECORD` VALUES (1,'2015-11-01 10:10:00',1,1,1),(2,'2015-11-01 10:10:01',1,2,2),(3,'2015-11-01 10:10:02',1,3,3),(4,'2015-11-01 10:10:03',1,4,4),(5,'2015-11-01 10:10:04',1,5,5),(6,'2015-11-01 10:10:05',1,6,6),(7,'2015-11-01 10:10:06',1,7,7),(8,'2015-11-01 10:10:07',1,8,8),(9,'2015-11-01 10:10:08',1,9,9),(10,'2015-11-01 10:10:09',1,10,10),(11,'2016-02-18 17:07:04',1,24,1),(12,'2016-02-18 17:22:25',1,25,1),(13,'2016-02-18 18:59:51',1,33,1),(14,'2016-03-16 17:38:55',1,34,1),(15,'2016-03-16 17:49:48',1,32,1),(16,'2016-03-16 17:49:57',1,31,1),(17,'2016-03-18 15:19:57',0,35,1),(18,'2016-03-18 15:52:41',0,36,1);
/*!40000 ALTER TABLE `T_ARGUMENT_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOK`
--

DROP TABLE IF EXISTS `T_BOOK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOK` (
  `pk_book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书表编号',
  `book_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '图书名称',
  `book_author` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图书作者',
  `book_publish_time` datetime DEFAULT NULL COMMENT '图书出版时间',
  `book_cover_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图书封面',
  `book_publisher` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图书出版社',
  `book_summary` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '图书简介',
  `book_comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '图书评论数量',
  `book_collect_number` int(11) NOT NULL DEFAULT '0' COMMENT '收藏图书人数',
  `book_time` datetime NOT NULL COMMENT '记录添加时间',
  `book_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_book_field_id` int(11) NOT NULL COMMENT '图书所在领域',
  `fk_book_user_id` int(11) NOT NULL COMMENT '图书贡献者',
  `fk_book_state_id` int(11) NOT NULL DEFAULT '11' COMMENT '图书状态',
  PRIMARY KEY (`pk_book_id`),
  KEY `fk_T_BOOK_T_FIELD1_idx` (`fk_book_field_id`),
  KEY `fk_T_BOOK_T_USER1_idx` (`fk_book_user_id`),
  KEY `fk_T_BOOK_T_STATE1_idx` (`fk_book_state_id`),
  CONSTRAINT `fk_T_BOOK_T_FIELD1` FOREIGN KEY (`fk_book_field_id`) REFERENCES `T_FIELD` (`pk_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOK_T_STATE1` FOREIGN KEY (`fk_book_state_id`) REFERENCES `T_STATE` (`pk_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOK_T_USER1` FOREIGN KEY (`fk_book_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOK`
--

LOCK TABLES `T_BOOK` WRITE;
/*!40000 ALTER TABLE `T_BOOK` DISABLE KEYS */;
INSERT INTO `T_BOOK` VALUES (1,'火影忍者','岸本齐史','2016-02-01 00:00:00','cover_1.png','连环画出版社','好书',5,6,'2015-10-10 10:00:00',1,1,1,12),(2,'文化苦旅','余秋雨','2016-02-02 00:00:00','cover_2.png','东方出版中心','这个真的好',2,3,'2015-10-10 10:00:01',1,1,1,12),(3,'围城','钱钟书','2016-02-03 00:00:00','cover_3.png','晨光出版社','名著',9,7,'2015-10-10 10:00:02',1,1,1,12),(4,'书剑恩仇录','金庸','2016-02-04 00:00:00','cover_4.png','广州出版社','武侠小说的经典',23,32,'2015-10-10 10:00:03',1,1,1,12),(5,'碧血剑','金庸','2016-02-05 00:00:00','cover_5.png','广州出版社','武侠小说的经典',115,15,'2015-10-10 10:00:04',1,2,1,12),(6,'射雕英雄传','金庸','2016-02-06 00:00:00','cover_6.png','广州出版社','武侠小说的经典',11,27,'2015-10-10 10:00:05',1,2,1,12),(7,'飞狐外传','金庸','2016-02-07 00:00:00','cover_7.png','广州出版社','武侠小说的经典',12,29,'2015-10-10 10:00:06',1,3,1,12),(8,'倚天屠龙记','金庸','2016-02-08 00:00:00','cover_8.png','广州出版社','武侠小说的经典',1,49,'2015-10-10 10:00:07',1,3,1,12),(9,'天龙八部','金庸','2016-02-09 00:00:00','cover_9.png','广州出版社','武侠小说的经典',0,12,'2015-10-10 10:00:08',1,4,1,12),(10,'笑傲江湖','金庸','2016-02-10 00:00:00','cover_10.png','广州出版社','武侠小说的经典拉伸肯德基发牢骚；的会计法律是贷款纠纷阿斯兰的空间发生了贷款就发上来的空间法律是可敬的富利卡世纪东方拉伸的减肥论据',128,9,'2015-10-10 10:00:09',1,4,1,12),(43,'1','2','2016-03-23 00:00:00','201603231702551955.jpeg','3','123',4,1,'2016-03-23 17:02:55',1,1,1,12),(44,'Malala','Zcp','2016-04-06 00:00:00','201604061437422075.jpeg','Zcp cbs','Jj',0,0,'2016-04-06 14:37:42',1,1,1,11),(45,'2','2','2016-04-06 00:00:00','201604061439364328.jpeg','2','2	2	2	2',0,0,'2016-04-06 14:39:37',1,1,1,11);
/*!40000 ALTER TABLE `T_BOOK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST`
--

DROP TABLE IF EXISTS `T_BOOKPOST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST` (
  `pk_bookpost_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书帖表编号',
  `bookpost_title` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '帖子标题',
  `bookpost_content` longtext COLLATE utf8_unicode_ci COMMENT '帖子内容',
  `bookpost_book_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '帖子关联图书',
  `bookpost_position` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '发帖人定位位置',
  `bookpost_reply_number` int(11) NOT NULL DEFAULT '0' COMMENT '帖子回复人数',
  `bookpost_collect_number` int(11) NOT NULL DEFAULT '0' COMMENT '收藏帖子人数',
  `bookpost_support` int(11) NOT NULL DEFAULT '0' COMMENT '帖子点赞量',
  `bookpost_time` datetime NOT NULL COMMENT '发帖时间',
  `bookpost_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bp_user_id` int(11) NOT NULL COMMENT '发帖人',
  `fk_bp_field_id` int(11) NOT NULL COMMENT '帖子所属领域',
  `fk_bp_book_id` int(11) DEFAULT NULL COMMENT '帖子所关联书籍(弃用)',
  PRIMARY KEY (`pk_bookpost_id`),
  KEY `fk_T_BOOKPOSTS_T_USER1_idx` (`fk_bp_user_id`),
  KEY `fk_T_BOOKPOSTS_T_FIELD1_idx` (`fk_bp_field_id`),
  KEY `fk_T_BOOKPOSTS_T_BOOK1_idx` (`fk_bp_book_id`),
  CONSTRAINT `fk_T_BOOKPOSTS_T_BOOK1` FOREIGN KEY (`fk_bp_book_id`) REFERENCES `T_BOOK` (`pk_book_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOSTS_T_FIELD1` FOREIGN KEY (`fk_bp_field_id`) REFERENCES `T_FIELD` (`pk_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOSTS_T_USER1` FOREIGN KEY (`fk_bp_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST`
--

LOCK TABLES `T_BOOKPOST` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST` VALUES (1,'唐砖作者是谁？','这本书看着感觉还是比较不错的，比较类似于回到明朝当王爷的架空历史类的，有知道这个书的作者是谁的么？','葵花宝典','江苏省苏州市',0,0,6,'2015-10-11 11:00:00',1,1,1,1),(2,'云烨是哪本书的主角？','前面一段时间看过的一本书，感觉这个主角的人物性格，还是比较符合自己的审美的。','葵花宝典','江苏省苏州市',0,0,2,'2015-10-11 11:00:01',1,2,2,2),(3,'火影忍者就这么就完了？','伴随了N年的成长历程了……就这么就结束了？','葵花宝典','江苏省苏州市',0,0,20,'2015-10-11 11:00:02',1,3,3,3),(4,'说话之道都有谁写过？','蔡康永写了本书叫说话知道，前几天貌似在书店看见了还有一本也叫说话之道的书，一样的书名有多少本啊？','葵花宝典','江苏省苏州市',0,0,32,'2015-10-11 11:00:03',1,4,4,4),(5,'金无足赤，人无完人的出处是哪里？','突然想问一下……','葵花宝典','江苏省苏州市',0,0,21,'2015-10-11 11:00:04',1,5,5,5),(6,'IOS相关的书适合初学者读的都有啥？','发现好多基础的相关的书……哪一本比较好？','葵花宝典','江苏省苏州市',0,0,9,'2015-10-11 11:00:05',1,6,6,6),(7,'孤独不是一种脾性','孤独不是一种脾性，而是一种无奈怎么理解？','葵花宝典','江苏省苏州市',0,0,25,'2015-10-11 11:00:06',1,7,7,7),(8,'记得当时年纪小，你爱谈天我爱笑','不知怎么睡着了，梦里花落知多少，同喜欢三毛了请进。','葵花宝典','江苏省苏州市',0,0,15,'2015-10-11 11:00:07',1,8,8,8),(9,'蔡澜今年多少岁了？','就是那个写美食的。','葵花宝典','江苏省苏州市',0,0,5,'2015-10-11 11:00:08',1,9,9,9),(10,'小撒有出过书么？','如果有出过书，应该会比较好看吧。','葵花宝典','江苏省苏州市',0,0,28,'2015-10-11 11:00:09',1,10,10,10),(16,'11','22','33',NULL,0,0,0,'2016-03-24 17:22:23',1,1,1,NULL),(17,'1','1','1',NULL,4,1,1,'2016-03-24 18:18:10',1,1,1,NULL),(18,'Aaaaaaaa','Bbbbbbbb','Xcccccc',NULL,1,0,0,'2016-04-05 20:57:03',1,1,1,NULL),(19,'Title','Content','Book',NULL,1,1,1,'2016-04-06 10:33:56',1,1,2,NULL);
/*!40000 ALTER TABLE `T_BOOKPOST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST_COMMENT`
--

DROP TABLE IF EXISTS `T_BOOKPOST_COMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST_COMMENT` (
  `pk_bookpost_comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书贴评论表编号',
  `comment_content` longtext COLLATE utf8_unicode_ci COMMENT '评论内容',
  `comment_position` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '评论人定位位置',
  `comment_reply_number` int(11) NOT NULL DEFAULT '0' COMMENT '评论回复人数',
  `comment_support` int(11) NOT NULL DEFAULT '0' COMMENT '评论点赞量',
  `comment_time` datetime NOT NULL COMMENT '评论时间',
  `comment_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bpc_user_id` int(11) NOT NULL COMMENT '评论人',
  `fk_bpc_bp_id` int(11) NOT NULL COMMENT '评论帖子编号',
  PRIMARY KEY (`pk_bookpost_comment_id`),
  KEY `fk_T_BOOKPOST_COMMENT_T_USER1_idx` (`fk_bpc_user_id`),
  KEY `fk_T_BOOKPOST_COMMENT_T_BOOKPOSTS1_idx` (`fk_bpc_bp_id`),
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_T_BOOKPOSTS1` FOREIGN KEY (`fk_bpc_bp_id`) REFERENCES `T_BOOKPOST` (`pk_bookpost_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_T_USER1` FOREIGN KEY (`fk_bpc_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST_COMMENT`
--

LOCK TABLES `T_BOOKPOST_COMMENT` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST_COMMENT` VALUES (1,'支持LZ','江苏省无锡市',0,2,'2015-10-12 13:00:00',1,1,1),(2,'666','江苏省苏州市',0,1,'2015-10-12 13:00:01',1,2,2),(3,'哎呦我去…… ','河南省郑州市',0,1,'2015-10-12 13:00:02',1,3,3),(4,'我是这么认为的……','河北省石家庄',0,3,'2015-10-12 13:00:03',1,5,6),(5,'顶','山东省济宁市',0,5,'2015-10-12 13:00:04',1,4,5),(6,'赞同','河南省商丘市',0,5,'2015-10-12 13:00:05',1,6,5),(7,'666','河南省新乡市',0,3,'2015-10-12 13:00:06',1,7,6),(8,'666','江苏省苏州市',0,4,'2015-10-12 13:00:07',1,5,6),(9,'9494……','江苏省苏州市',0,5,'2015-10-12 13:00:08',1,5,6),(10,'恩，关于这个问题……就这样吧','江苏省苏州市',0,8,'2015-10-12 13:00:09',1,6,6),(11,'qwer',NULL,0,0,'2016-04-04 15:10:58',1,1,1),(12,'error',NULL,0,0,'2016-04-04 16:51:33',1,1,1),(13,'Yy',NULL,0,0,'2016-04-04 16:51:55',1,1,1),(14,'Asdfsadfasdfasdfadsfasdfasdfasdf',NULL,0,0,'2016-04-04 16:52:04',1,1,1),(15,'Asdasd',NULL,0,0,'2016-04-04 16:56:00',1,1,17),(16,'Asdfsadfasdfasdfadsfasdfasdfasdf',NULL,0,0,'2016-04-04 16:59:53',1,1,17),(17,'Lasjdlfkasdlkfj;dfkadlkasdjflak;dfwelmgao;sdflaskdjf;laksjdlaksdj;Lasjdlfkasdlkfj;sdflaskdjf;aksdjfl;kasdfkasdjlfkasdjflkasdjf',NULL,9,1001,'2016-04-04 17:08:23',1,1,17),(18,'Skdfjalskdfj;dfkadlkasdjflak',NULL,0,0,'2016-04-04 17:18:26',1,1,17),(19,'A',NULL,0,0,'2016-04-05 15:25:59',1,1,17),(20,'Asd',NULL,0,0,'2016-04-05 20:32:14',1,1,17),(21,'Asdf',NULL,0,0,'2016-04-05 20:33:03',1,1,17),(22,'Asdasd',NULL,0,0,'2016-04-05 20:45:11',1,1,17),(23,'Asdf',NULL,0,1,'2016-04-05 20:47:14',1,1,17),(24,'Asdf',NULL,2,1,'2016-04-05 20:57:14',1,1,18),(25,'Reply',NULL,6,1,'2016-04-06 10:34:35',1,1,19);
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST_COMMENT_REPLY`
--

DROP TABLE IF EXISTS `T_BOOKPOST_COMMENT_REPLY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST_COMMENT_REPLY` (
  `pk_reply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书评论回复表编号',
  `reply_content` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '回复内容',
  `reply_support` int(11) NOT NULL COMMENT '回复点赞量',
  `reply_isreply_author` int(11) NOT NULL DEFAULT '1' COMMENT '是否是直接对作者的内容进行回复',
  `reply_time` datetime NOT NULL COMMENT '回复时间',
  `reply_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bpcr_user_id` int(11) NOT NULL COMMENT '回复人',
  `fk_bpcr_user_id_receiver` int(11) NOT NULL COMMENT '回复接收人（为回复此条评论的任意一人，不仅只是评论作者）',
  `fk_bpcr_bpc_id` int(11) NOT NULL COMMENT '评论编号',
  PRIMARY KEY (`pk_reply_id`),
  KEY `fk_T_COMMENT_REPLY_T_USER1_idx` (`fk_bpcr_user_id`),
  KEY `fk_T_COMMENT_REPLY_T_USER2_idx` (`fk_bpcr_user_id_receiver`),
  KEY `fk_T_COMMENT_REPLY_T_BOOKPOST_COMMENT1_idx` (`fk_bpcr_bpc_id`),
  CONSTRAINT `fk_T_COMMENT_REPLY_T_BOOKPOST_COMMENT1` FOREIGN KEY (`fk_bpcr_bpc_id`) REFERENCES `T_BOOKPOST_COMMENT` (`pk_bookpost_comment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_COMMENT_REPLY_T_USER1` FOREIGN KEY (`fk_bpcr_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_COMMENT_REPLY_T_USER2` FOREIGN KEY (`fk_bpcr_user_id_receiver`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST_COMMENT_REPLY`
--

LOCK TABLES `T_BOOKPOST_COMMENT_REPLY` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_REPLY` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST_COMMENT_REPLY` VALUES (1,NULL,2,1,'2015-10-12 14:00:01',1,1,2,1),(2,NULL,2,1,'2015-10-12 14:00:02',1,2,5,1),(3,NULL,2,1,'2015-10-12 14:00:03',1,3,3,2),(4,NULL,2,1,'2015-10-12 14:00:04',1,4,4,2),(5,NULL,2,1,'2015-10-12 14:00:05',1,5,4,2),(6,NULL,2,1,'2015-10-12 14:00:06',1,6,8,3),(7,NULL,3,1,'2015-10-12 14:00:07',1,7,7,4),(8,NULL,4,1,'2015-10-12 14:00:08',1,8,7,6),(9,NULL,4,1,'2015-10-12 14:00:09',1,9,5,4),(10,NULL,6,1,'2015-10-12 14:00:10',1,10,5,5),(11,'qwerwsad',0,1,'2016-04-04 15:11:55',1,1,2,1),(12,'Asdasd',0,1,'2016-04-05 16:26:22',1,1,2,17),(13,'Asdfsadfasdfasdfadsfasdfasdfasdf',0,1,'2016-04-05 16:40:47',1,1,3,17),(14,'Asdfsdf',0,1,'2016-04-05 16:40:56',1,3,4,17),(15,'Asdfsadf',0,1,'2016-04-05 16:56:02',1,2,1,17),(16,'A;lsflaskdfalskdfj;laksjdlaksdj;lklkaflakflakdfj;Lskdjflaskdjflaskdjflsakdjflaksdjflaksdjflkajsdlfkajsdlfkajsdlfa;skdfjalskdfj;laksfasdjflas;dfksdj a;lsflaskdfalskdfj;flkasdjflkj',1,1,'2016-04-05 16:59:23',1,5,1,17),(17,'Asdfsadfasdfasdfadsfasdfasdfasdf',0,1,'2016-04-05 16:59:49',1,7,1,17),(18,'Asdfsadfasdfasdfadsfasdfasdfasdf',1,1,'2016-04-05 17:00:41',1,1,7,17),(19,'Aaaaa',1,1,'2016-04-05 20:30:17',1,1,1,17),(20,'Asfasdf',0,1,'2016-04-05 20:47:50',1,1,1,17),(21,'Asdfasdf',0,1,'2016-04-05 20:57:23',1,1,1,24),(22,'Asdf',0,1,'2016-04-05 20:58:39',1,1,1,24),(23,'Reply comment.',1,1,'2016-04-06 10:35:12',1,3,1,25),(26,'asd',1,1,'2016-04-06 11:39:38',1,1,1,25),(28,'Asdf',0,1,'2016-04-06 11:45:59',1,1,1,25),(29,'Asd',0,0,'2016-04-06 11:48:13',1,1,3,25),(30,'Asd',0,0,'2016-04-06 11:48:19',1,1,1,25),(31,'Asd',0,1,'2016-04-06 11:48:25',1,1,1,25);
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_REPLY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书贴评论回复点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bpcr_sup_record_bpcr_id` int(11) NOT NULL COMMENT '回复编号',
  `fk_bpcr_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_BOOKPOST_COMMENT_REPLY_SUP_RECORD_T_BOOKPOST_COMMENT_R_idx` (`fk_bpcr_sup_record_bpcr_id`),
  KEY `fk_T_BOOKPOST_COMMENT_REPLY_SUP_RECORD_T_USER1_idx` (`fk_bpcr_sup_record_user_id`),
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_REPLY_SUP_RECORD_T_BOOKPOST_COMMENT_REP1` FOREIGN KEY (`fk_bpcr_sup_record_bpcr_id`) REFERENCES `T_BOOKPOST_COMMENT_REPLY` (`pk_reply_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_REPLY_SUP_RECORD_T_USER1` FOREIGN KEY (`fk_bpcr_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD`
--

LOCK TABLES `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD` VALUES (1,'2015-10-12 14:20:00',1,1,1),(2,'2015-10-12 14:20:01',1,2,2),(3,'2015-10-12 14:20:02',1,3,3),(4,'2015-10-12 14:20:03',1,4,4),(5,'2015-10-12 14:20:04',1,5,5),(6,'2015-10-12 14:20:05',1,6,6),(7,'2015-10-12 14:20:06',1,7,7),(8,'2015-10-12 14:20:07',1,8,8),(9,'2015-10-12 14:20:08',1,9,9),(10,'2015-10-12 14:20:09',1,10,10),(11,'2016-04-05 20:24:33',1,18,1),(12,'2016-04-05 20:24:43',0,17,1),(13,'2016-04-05 20:30:04',1,16,1),(14,'2016-04-05 20:30:21',1,19,1),(15,'2016-04-06 10:35:20',1,23,1),(16,'2016-04-06 11:48:30',1,26,1);
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_REPLY_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST_COMMENT_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_BOOKPOST_COMMENT_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST_COMMENT_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bpc_sup_record_bpc_id` int(11) NOT NULL COMMENT '评论编号',
  `fk_bpc_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_BOOKPOST_COMMENT_SUPPORT_T_BOOKPOST_COMMENT1_idx` (`fk_bpc_sup_record_bpc_id`),
  KEY `fk_T_BOOKPOST_COMMENT_SUPPORT_T_USER1_idx` (`fk_bpc_sup_record_user_id`),
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_SUPPORT_T_BOOKPOST_COMMENT1` FOREIGN KEY (`fk_bpc_sup_record_bpc_id`) REFERENCES `T_BOOKPOST_COMMENT` (`pk_bookpost_comment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOST_COMMENT_SUPPORT_T_USER1` FOREIGN KEY (`fk_bpc_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST_COMMENT_SUP_RECORD`
--

LOCK TABLES `T_BOOKPOST_COMMENT_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST_COMMENT_SUP_RECORD` VALUES (1,'2015-10-12 13:10:00',1,1,1),(2,'2015-10-12 13:10:01',1,2,2),(3,'2015-10-12 13:10:02',1,3,3),(4,'2015-10-12 13:10:03',1,4,4),(5,'2015-10-12 13:10:04',1,5,5),(6,'2015-10-12 13:10:05',1,6,6),(7,'2015-10-12 13:10:06',1,7,7),(8,'2015-10-12 13:10:07',1,8,8),(9,'2015-10-12 13:10:08',1,9,9),(10,'2015-10-12 13:10:09',1,10,10),(11,'2016-04-05 20:02:12',1,17,1),(12,'2016-04-05 20:47:26',1,23,1),(13,'2016-04-05 20:57:18',1,24,1),(14,'2016-04-06 10:34:50',1,25,1);
/*!40000 ALTER TABLE `T_BOOKPOST_COMMENT_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOKPOST_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_BOOKPOST_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOKPOST_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书贴点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_bp_sup_record_bp_id` int(11) NOT NULL COMMENT '图书贴编号',
  `fk_bp_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_BOOKPOST_SUP_RECORD_T_BOOKPOST1_idx` (`fk_bp_sup_record_bp_id`),
  KEY `fk_T_BOOKPOST_SUP_RECORD_T_USER1_idx` (`fk_bp_sup_record_user_id`),
  CONSTRAINT `fk_T_BOOKPOST_SUP_RECORD_T_BOOKPOST1` FOREIGN KEY (`fk_bp_sup_record_bp_id`) REFERENCES `T_BOOKPOST` (`pk_bookpost_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOKPOST_SUP_RECORD_T_USER1` FOREIGN KEY (`fk_bp_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOKPOST_SUP_RECORD`
--

LOCK TABLES `T_BOOKPOST_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_BOOKPOST_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_BOOKPOST_SUP_RECORD` VALUES (1,'2015-10-12 12:00:00',1,1,1),(2,'2015-10-10 12:00:01',1,2,2),(3,'2015-10-10 12:00:02',1,3,3),(4,'2015-10-10 12:00:03',1,4,4),(5,'2015-10-10 12:00:04',1,3,5),(6,'2015-10-10 12:00:05',1,6,6),(7,'2015-10-10 12:00:06',1,8,7),(8,'2015-10-10 12:00:07',1,6,8),(9,'2015-10-10 12:00:08',1,1,9),(10,'2015-10-10 12:00:09',1,8,10),(11,'2016-04-05 18:55:55',0,17,1),(12,'2016-04-06 10:34:14',1,19,1);
/*!40000 ALTER TABLE `T_BOOKPOST_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOK_REPLY`
--

DROP TABLE IF EXISTS `T_BOOK_REPLY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOK_REPLY` (
  `pk_book_reply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书评论表编号',
  `book_reply_content` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '评论内容',
  `book_reply_support` int(11) NOT NULL DEFAULT '0' COMMENT '评论点赞量',
  `book_reply_time` datetime NOT NULL COMMENT '评论时间',
  `book_reply_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_br_user_id` int(11) NOT NULL COMMENT '评论人',
  `fk_br_book_id` int(11) NOT NULL COMMENT '图书编号',
  PRIMARY KEY (`pk_book_reply_id`),
  KEY `fk_T_BOOK_REPLY_T_USER1_idx` (`fk_br_user_id`),
  KEY `fk_T_BOOK_REPLY_T_BOOK1_idx` (`fk_br_book_id`),
  CONSTRAINT `fk_T_BOOK_REPLY_T_BOOK1` FOREIGN KEY (`fk_br_book_id`) REFERENCES `T_BOOK` (`pk_book_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOK_REPLY_T_USER1` FOREIGN KEY (`fk_br_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOK_REPLY`
--

LOCK TABLES `T_BOOK_REPLY` WRITE;
/*!40000 ALTER TABLE `T_BOOK_REPLY` DISABLE KEYS */;
INSERT INTO `T_BOOK_REPLY` VALUES (1,'好书',0,'2015-10-11 10:00:00',1,1,1),(2,'好书',0,'2015-10-11 10:00:01',1,2,2),(3,'好书',0,'2015-10-11 10:00:02',1,3,3),(4,'好书',0,'2015-10-11 10:00:03',1,4,4),(5,'好书',0,'2015-10-11 10:00:04',1,5,5),(6,'好书',0,'2015-10-11 10:00:05',1,6,6),(7,'好书',0,'2015-10-11 10:00:06',1,7,7),(8,'好书',0,'2015-10-11 10:00:07',1,8,8),(9,'好书',0,'2015-10-11 10:00:08',1,9,9),(10,'好书',1,'2015-10-11 10:00:09',1,10,10),(11,'123123',0,'2016-03-18 15:48:17',1,1,10),(12,'yay',1,'2016-03-21 15:56:06',1,1,10),(13,'As adds',1,'2016-03-24 18:20:08',1,1,43),(14,'Asd',1,'2016-04-06 14:56:23',1,1,43),(15,'try',0,'2016-04-06 14:59:55',1,1,43),(16,'Ava',0,'2016-04-06 15:01:27',1,1,43);
/*!40000 ALTER TABLE `T_BOOK_REPLY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_BOOK_REPLY_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_BOOK_REPLY_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_BOOK_REPLY_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书评论点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_br_sup_record_br_id` int(11) NOT NULL COMMENT '图书评论编号',
  `fk_br_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_BOOK_REPLY_SUP_RECORD_T_BOOK_REPLY1_idx` (`fk_br_sup_record_br_id`),
  KEY `fk_T_BOOK_REPLY_SUP_RECORD_T_USER1_idx` (`fk_br_sup_record_user_id`),
  CONSTRAINT `fk_T_BOOK_REPLY_SUP_RECORD_T_BOOK_REPLY1` FOREIGN KEY (`fk_br_sup_record_br_id`) REFERENCES `T_BOOK_REPLY` (`pk_book_reply_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_BOOK_REPLY_SUP_RECORD_T_USER1` FOREIGN KEY (`fk_br_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_BOOK_REPLY_SUP_RECORD`
--

LOCK TABLES `T_BOOK_REPLY_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_BOOK_REPLY_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_BOOK_REPLY_SUP_RECORD` VALUES (1,'2015-10-12 10:00:00',1,1,1),(2,'2015-10-12 10:00:01',1,2,2),(3,'2015-10-12 10:00:02',1,3,3),(4,'2015-10-12 10:00:03',1,4,4),(5,'2015-10-12 10:00:04',1,5,5),(6,'2015-10-12 10:00:05',1,6,6),(7,'2015-10-12 10:00:06',1,7,7),(8,'2015-10-12 10:00:07',1,8,8),(9,'2015-10-12 10:00:08',1,9,9),(10,'2015-10-12 10:00:09',1,10,10),(12,'2016-03-18 15:16:36',1,10,1),(13,'2016-03-18 15:48:23',0,11,1),(14,'2016-03-18 16:20:23',0,8,1),(15,'2016-03-21 15:56:14',1,12,1),(16,'2016-03-24 18:20:12',1,13,1),(17,'2016-04-06 15:00:12',0,15,1),(18,'2016-04-06 15:01:43',0,16,1),(19,'2016-04-06 15:01:51',1,14,1);
/*!40000 ALTER TABLE `T_BOOK_REPLY_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_CONCER_PERSON`
--

DROP TABLE IF EXISTS `T_CONCER_PERSON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_CONCER_PERSON` (
  `pk_concer_person_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关注人表编号',
  `concer_person_time` datetime NOT NULL COMMENT '记录添加时间',
  `concer_person_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_concer_person_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_concer_person_user_id_concered` int(11) NOT NULL COMMENT '被关注人编号',
  PRIMARY KEY (`pk_concer_person_id`),
  KEY `fk_T_CONCER_PERSON_T_USER1_idx` (`fk_concer_person_user_id`),
  KEY `fk_T_CONCER_PERSON_T_USER2_idx` (`fk_concer_person_user_id_concered`),
  CONSTRAINT `fk_T_CONCER_PERSON_T_USER1` FOREIGN KEY (`fk_concer_person_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_CONCER_PERSON_T_USER2` FOREIGN KEY (`fk_concer_person_user_id_concered`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_CONCER_PERSON`
--

LOCK TABLES `T_CONCER_PERSON` WRITE;
/*!40000 ALTER TABLE `T_CONCER_PERSON` DISABLE KEYS */;
INSERT INTO `T_CONCER_PERSON` VALUES (1,'2015-10-10 12:00:00',1,1,2),(2,'2015-10-10 12:00:01',1,1,3),(3,'2015-10-10 12:00:02',1,3,4),(4,'2015-10-10 12:00:03',1,4,5),(5,'2015-10-10 12:00:04',1,5,6),(6,'2015-10-10 12:00:05',1,6,7),(7,'2015-10-10 12:00:06',1,7,8),(8,'2015-10-10 12:00:07',1,8,9),(9,'2015-10-10 12:00:08',1,9,10),(10,'2015-10-10 12:00:09',1,10,1);
/*!40000 ALTER TABLE `T_CONCER_PERSON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_COUPLET`
--

DROP TABLE IF EXISTS `T_COUPLET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_COUPLET` (
  `pk_couplet_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '对联表编号',
  `couplet_content` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '对联内容',
  `couplet_support` int(11) NOT NULL DEFAULT '0' COMMENT '对联点赞量',
  `couplet_reply_number` int(11) NOT NULL DEFAULT '0' COMMENT '对联回复人数',
  `couplet_collect_number` int(11) NOT NULL DEFAULT '0' COMMENT '收藏对联人数',
  `couplet_time` datetime NOT NULL COMMENT '出对时间',
  `couplet_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_couplet_user_id` int(11) NOT NULL COMMENT '出对人',
  PRIMARY KEY (`pk_couplet_id`),
  KEY `fk_T_COUPLET_T_USER1_idx` (`fk_couplet_user_id`),
  CONSTRAINT `fk_T_COUPLET_T_USER1` FOREIGN KEY (`fk_couplet_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_COUPLET`
--

LOCK TABLES `T_COUPLET` WRITE;
/*!40000 ALTER TABLE `T_COUPLET` DISABLE KEYS */;
INSERT INTO `T_COUPLET` VALUES (1,'飞雪连天射白鹿',0,0,0,'2014-05-21 12:00:05',1,1),(2,'白日依山尽',0,0,0,'2014-09-21 09:00:05',1,2),(3,'举头望明月',0,0,0,'2014-11-30 08:02:05',1,3),(4,'人生若只如初见，何事秋风悲画扇。',0,0,0,'2014-12-01 08:02:05',1,1),(5,'曾经沧海难为水，除却巫山不是云。',0,0,0,'2014-12-02 08:02:05',1,1),(6,'明月几时有？把酒问青天。',0,0,0,'2014-12-03 08:02:05',1,2),(7,'恰同学少年，风华正茂。',0,0,0,'2014-12-04 08:02:05',1,1),(8,'夜来风雨声，花落知多少。',0,0,0,'2014-12-05 08:02:05',1,2),(9,'鸳鸯湖畔草粘天，二月春深好放船。',0,0,0,'2014-12-06 08:02:05',1,1),(10,'堂前扑枣任西邻，无食无儿一妇人。',0,0,0,'2014-12-06 08:02:07',1,3),(11,'孤山寺北贾亭西，水面初平云脚低。',0,0,0,'2014-12-06 09:02:05',1,3),(12,'清晨入古寺，初日照高林。',0,0,0,'2014-12-06 11:02:05',1,2),(13,'胜日寻芳泗水滨，无边光景一时新。',0,0,0,'2014-12-07 08:02:05',1,1),(14,'京口瓜洲一水间，钟山只隔数重山。',0,0,0,'2014-12-08 08:02:05',1,2),(15,'人闲桂花落，夜静春山空。',0,0,0,'2014-12-09 08:02:05',1,1),(16,'北风卷地白草折，胡天八月即飞雪。',0,0,0,'2014-12-10 08:02:05',1,2),(17,'千山鸟飞绝，万径人踪灭。',0,0,0,'2014-12-11 08:02:05',1,4),(18,'纷纷暮雪下辕门，风掣红旗冻不翻。',0,0,0,'2014-12-12 08:02:05',1,1),(19,'日暮苍山远，天寒白屋贫。',0,0,0,'2014-12-13 08:02:05',1,2),(20,'有梅无雪不精神，有雪无诗俗了人。',0,0,0,'2014-12-14 08:02:05',1,2),(21,'风劲角弓鸣，将军猎渭城。',0,0,0,'2014-12-15 08:02:05',1,1),(22,'君自故乡来，应知故乡事。',0,0,0,'2014-12-16 08:02:05',1,2),(23,'一树寒梅白玉条，迥临村路傍溪桥。',0,0,0,'2014-12-17 08:02:05',1,3),(24,'数萼初含雪，孤标画本难。',1,0,0,'2014-12-18 08:02:05',1,4),(25,'定定住天涯，依依向物华。',0,3,0,'2014-12-19 08:02:05',1,1),(26,'万木冻欲折，孤根暖独回。',2,16,1,'2014-12-20 08:02:05',1,2),(27,'Asd',0,2,0,'2016-02-18 09:51:28',1,1),(28,'Tt',0,1,1,'2016-02-24 13:04:24',1,1),(29,'Aa',0,0,0,'2016-03-16 17:26:48',1,1),(30,'Sasdfasdf',1,3,1,'2016-03-16 18:07:32',1,1),(31,'123123',1,2,1,'2016-03-18 15:30:36',1,1),(32,'2',0,0,0,'2016-03-24 19:43:06',1,1),(33,'Asdf',0,1,0,'2016-04-05 20:59:21',1,1),(34,'ZXc',1,1,1,'2016-04-06 14:08:14',1,1);
/*!40000 ALTER TABLE `T_COUPLET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_COUPLET_REPLY`
--

DROP TABLE IF EXISTS `T_COUPLET_REPLY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_COUPLET_REPLY` (
  `pk_couplet_reply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '对联回复表编号',
  `reply_content` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '回复内容',
  `reply_support` int(11) NOT NULL COMMENT '回复点赞量',
  `reply_time` datetime NOT NULL COMMENT '回复时间',
  `reply_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_cr_couplet_id` int(11) NOT NULL COMMENT '对联编号',
  `fk_cr_user_id` int(11) NOT NULL COMMENT '回复人',
  PRIMARY KEY (`pk_couplet_reply_id`),
  KEY `fk_T_COUPLET_REPLYS_T_COUPLET1_idx` (`fk_cr_couplet_id`),
  KEY `fk_T_COUPLET_REPLY_T_USER1_idx` (`fk_cr_user_id`),
  CONSTRAINT `fk_T_COUPLET_REPLYS_T_COUPLET1` FOREIGN KEY (`fk_cr_couplet_id`) REFERENCES `T_COUPLET` (`pk_couplet_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_COUPLET_REPLY_T_USER1` FOREIGN KEY (`fk_cr_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_COUPLET_REPLY`
--

LOCK TABLES `T_COUPLET_REPLY` WRITE;
/*!40000 ALTER TABLE `T_COUPLET_REPLY` DISABLE KEYS */;
INSERT INTO `T_COUPLET_REPLY` VALUES (1,'笑书神侠倚碧鸳',1,'2015-10-10 10:01:00',1,1,2),(2,'黄河入海流',1,'2015-10-10 10:01:01',1,2,3),(3,'低头思故乡',1,'2015-10-10 10:01:02',1,3,4),(4,'春江潮水连海平',1,'2015-10-10 10:01:03',1,4,5),(5,'海上明月共潮生',1,'2015-10-10 10:01:04',1,5,6),(6,'滟滟随波千万里',1,'2015-10-10 10:01:05',1,6,7),(7,'何处春江无月明',1,'2015-10-10 10:01:06',1,7,8),(8,'江流宛转绕芳甸',1,'2015-10-10 10:01:07',1,8,9),(9,'何处春江无月明',1,'2015-10-10 10:01:08',1,9,10),(10,'空里流霜不觉飞',1,'2015-10-10 10:01:09',1,10,5),(16,'asdasd',0,'2016-02-17 15:21:47',1,26,1),(17,'Hugh',0,'2016-02-17 15:23:39',1,26,1),(18,'Ggg',0,'2016-02-17 15:27:53',1,26,1),(19,'Ggg',0,'2016-02-17 15:30:36',1,26,1),(20,'Ggg',0,'2016-02-17 15:31:20',1,26,1),(21,'G the ',0,'2016-02-17 15:31:35',1,26,1),(22,'Ggg',0,'2016-02-17 16:15:54',1,25,1),(23,'Ggg',0,'2016-02-17 16:16:02',1,25,1),(24,'T',0,'2016-02-17 16:17:39',1,26,1),(25,'Gggh',0,'2016-02-17 17:20:55',1,25,1),(26,'Aadb',1,'2016-02-17 17:36:38',1,26,1),(27,'Abcasdasxasx',1,'2016-02-17 17:37:05',1,26,1),(28,'Sssss',1,'2016-02-17 17:37:10',1,26,1),(29,'Maxim numb',1,'2016-02-17 17:37:17',1,26,1),(30,'T',0,'2016-02-22 10:12:50',1,27,1),(31,'B',0,'2016-02-22 10:12:59',1,27,1),(32,'T',0,'2016-03-16 17:06:41',1,28,1),(33,'Asdasd',1,'2016-03-17 17:30:28',1,30,1),(34,'Asdasd',1,'2016-03-17 17:30:34',1,30,1),(35,'Ffffff',1,'2016-03-17 17:30:38',1,30,1),(36,'123123',1,'2016-03-18 15:30:49',1,31,1),(37,'Asd',1,'2016-03-24 18:20:36',1,31,1),(38,'Asdasd',0,'2016-04-05 20:59:29',1,33,1),(39,'Asd',1,'2016-04-06 14:08:46',1,34,1);
/*!40000 ALTER TABLE `T_COUPLET_REPLY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_COUPLET_REPLY_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_COUPLET_REPLY_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_COUPLET_REPLY_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '对联回复点赞记录编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_cr_sup_record_cr_id` int(11) NOT NULL COMMENT '对联回复编号',
  `fk_cr_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_COUPLET_REPLY_SUPPORT_T_COUPLET_REPLY1_idx` (`fk_cr_sup_record_cr_id`),
  KEY `fk_T_COUPLET_REPLY_SUPPORT_T_USER1_idx` (`fk_cr_sup_record_user_id`),
  CONSTRAINT `fk_T_COUPLET_REPLY_SUPPORT_T_COUPLET_REPLY1` FOREIGN KEY (`fk_cr_sup_record_cr_id`) REFERENCES `T_COUPLET_REPLY` (`pk_couplet_reply_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_COUPLET_REPLY_SUPPORT_T_USER1` FOREIGN KEY (`fk_cr_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_COUPLET_REPLY_SUP_RECORD`
--

LOCK TABLES `T_COUPLET_REPLY_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_COUPLET_REPLY_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_COUPLET_REPLY_SUP_RECORD` VALUES (1,'2015-10-12 13:00:00',1,1,1),(2,'2015-10-12 13:00:01',1,1,1),(3,'2015-10-12 13:00:02',1,1,1),(4,'2015-10-12 13:00:03',1,1,1),(5,'2015-10-12 13:00:04',1,1,1),(6,'2015-10-12 13:00:05',1,1,1),(7,'2015-10-12 13:00:06',1,1,1),(8,'2015-10-12 13:00:07',1,1,1),(9,'2015-10-12 13:00:08',1,1,1),(10,'2015-10-12 13:00:09',1,1,1),(11,'2016-02-18 09:48:36',1,29,1),(12,'2016-02-18 09:48:39',1,28,1),(13,'2016-02-18 09:48:49',0,20,1),(14,'2016-02-18 09:49:35',1,27,1),(15,'2016-02-18 09:49:44',1,26,1),(16,'2016-03-16 17:14:46',0,31,1),(17,'2016-03-16 17:21:31',0,30,1),(18,'2016-03-18 10:27:44',1,35,1),(19,'2016-03-18 16:17:55',1,34,1),(20,'2016-03-18 16:20:04',1,33,1),(21,'2016-03-23 15:57:49',1,36,1),(22,'2016-03-24 18:20:41',1,37,1),(23,'2016-04-05 21:02:49',0,38,1),(24,'2016-04-06 14:08:53',1,39,1);
/*!40000 ALTER TABLE `T_COUPLET_REPLY_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_COUPLET_SUP_RECORD`
--

DROP TABLE IF EXISTS `T_COUPLET_SUP_RECORD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_COUPLET_SUP_RECORD` (
  `pk_support_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '对联点赞记录表编号',
  `support_record_time` datetime NOT NULL COMMENT '记录添加时间',
  `support_record_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_couplet_sup_record_couplet_id` int(11) NOT NULL COMMENT '对联编号',
  `fk_couplet_sup_record_user_id` int(11) NOT NULL COMMENT '点赞人编号',
  PRIMARY KEY (`pk_support_record_id`),
  KEY `fk_T_COUPLET_SUP_RECORD_T_USER1_idx` (`fk_couplet_sup_record_user_id`),
  KEY `fk_T_COUPLET_SUP_RECORD_T_COUPLET1_idx` (`fk_couplet_sup_record_couplet_id`),
  CONSTRAINT `fk_T_COUPLET_SUP_RECORD_T_COUPLET1` FOREIGN KEY (`fk_couplet_sup_record_couplet_id`) REFERENCES `T_COUPLET` (`pk_couplet_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_COUPLET_SUP_RECORD_T_USER1` FOREIGN KEY (`fk_couplet_sup_record_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_COUPLET_SUP_RECORD`
--

LOCK TABLES `T_COUPLET_SUP_RECORD` WRITE;
/*!40000 ALTER TABLE `T_COUPLET_SUP_RECORD` DISABLE KEYS */;
INSERT INTO `T_COUPLET_SUP_RECORD` VALUES (1,'2015-10-10 10:00:00',1,1,1),(2,'2015-10-10 10:00:01',1,2,1),(3,'2015-10-10 10:00:02',1,3,1),(4,'2015-10-10 10:00:03',1,4,1),(5,'2015-10-10 10:00:04',1,5,1),(6,'2015-10-10 10:00:05',1,6,1),(7,'2015-10-10 10:00:06',1,7,1),(8,'2015-10-10 10:00:07',1,8,1),(9,'2015-10-10 10:00:08',1,9,1),(10,'2015-10-10 10:00:09',1,10,1),(11,'2016-02-17 18:12:06',1,26,1),(12,'2016-02-18 09:49:57',0,25,1),(13,'2016-02-18 09:51:14',1,24,1),(14,'2016-02-18 19:06:24',0,27,1),(15,'2016-02-24 13:16:39',0,28,1),(16,'2016-03-17 17:30:54',1,30,1),(17,'2016-03-24 18:20:33',1,31,1),(18,'2016-04-06 14:08:35',1,34,1);
/*!40000 ALTER TABLE `T_COUPLET_SUP_RECORD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_FIELD`
--

DROP TABLE IF EXISTS `T_FIELD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_FIELD` (
  `pk_field_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '领域表编号',
  `field_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '领域名称',
  `field_time` datetime NOT NULL COMMENT '记录添加时间',
  `field_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`pk_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_FIELD`
--

LOCK TABLES `T_FIELD` WRITE;
/*!40000 ALTER TABLE `T_FIELD` DISABLE KEYS */;
INSERT INTO `T_FIELD` VALUES (1,'散文','2015-08-28 00:00:00',1),(2,'军事','2015-09-01 00:00:00',1),(3,'传记','2015-09-09 00:00:01',1),(4,'科技','2015-09-09 00:00:02',1),(5,'生活','2015-09-09 00:00:03',1),(6,'动漫','2015-09-09 00:00:04',1),(7,'历史','2015-09-09 00:00:05',1),(8,'原创','2015-09-09 00:00:06',1),(9,'网络','2015-09-09 00:00:07',1),(10,'名著','2015-09-09 00:00:08',1);
/*!40000 ALTER TABLE `T_FIELD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_LEVELS`
--

DROP TABLE IF EXISTS `T_LEVELS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_LEVELS` (
  `pk_level_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '等级表编号',
  `level_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '等级称谓',
  `level_min_exp` int(11) NOT NULL COMMENT '等级下限经验值',
  `level_max_exp` int(11) NOT NULL COMMENT '等级上限经验值',
  `level_time` datetime NOT NULL COMMENT '记录添加时间',
  `level_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`pk_level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_LEVELS`
--

LOCK TABLES `T_LEVELS` WRITE;
/*!40000 ALTER TABLE `T_LEVELS` DISABLE KEYS */;
INSERT INTO `T_LEVELS` VALUES (1,'白衣文士',0,1000,'2015-10-10 21:00:00',1),(2,'楚楚不凡',1000,3000,'2015-10-10 21:00:01',1),(3,'满腹经纶',3000,6000,'2015-10-10 21:00:05',1),(4,'博古通今',6000,12000,'2015-10-10 21:00:08',1),(5,'通天晓地',12000,24000,'2015-10-10 21:00:09',1);
/*!40000 ALTER TABLE `T_LEVELS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_QUESTION`
--

DROP TABLE IF EXISTS `T_QUESTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_QUESTION` (
  `pk_question_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '题目表编号',
  `question_content` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '题目内容',
  `question_option_one` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '选项一',
  `question_option_two` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '选项二',
  `question_option_three` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '选项三',
  `question_answer` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '正确答案',
  `question_collect_number` int(11) NOT NULL DEFAULT '0' COMMENT '收藏题目人数',
  `question_show_order` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT '1234' COMMENT '选项展示顺序',
  `question_time` datetime NOT NULL COMMENT '记录添加时间',
  `question_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_question_user_id` int(11) NOT NULL COMMENT '出题人',
  `fk_question_state_id` int(11) NOT NULL DEFAULT '5' COMMENT '题目状态',
  PRIMARY KEY (`pk_question_id`),
  KEY `fk_T_QUESTION_T_USER1_idx` (`fk_question_user_id`),
  KEY `fk_T_QUESTION_T_STATE1_idx` (`fk_question_state_id`),
  CONSTRAINT `fk_T_QUESTION_T_STATE1` FOREIGN KEY (`fk_question_state_id`) REFERENCES `T_STATE` (`pk_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_QUESTION_T_USER1` FOREIGN KEY (`fk_question_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_QUESTION`
--

LOCK TABLES `T_QUESTION` WRITE;
/*!40000 ALTER TABLE `T_QUESTION` DISABLE KEYS */;
INSERT INTO `T_QUESTION` VALUES (1,'火影忍者中冷君指的是谁？','自来也','纲手','森之千手','大蛇丸',1,'1234','2015-10-10 10:00:00',1,1,7),(2,'唐砖中皇帝被称为？','黄二','黄三','李三','李二',1,'1234','2015-10-10 10:00:01',1,2,7),(3,'文化苦旅的作者是谁？','余春雨','余夏雨','余东宇','余秋雨',0,'1234','2015-10-10 10:00:02',1,3,7),(4,'寒蝉凄切的词牌名是啥？','念奴娇','木兰花','清平乐','雨霖铃',1,'1234','2015-10-10 10:00:03',1,4,7),(5,'苏轼是哪个朝代的？','唐','五代十国','明','宋',1,'1234','2015-10-10 10:00:04',1,5,7),(6,'李清照号什么？','清岚居士','青莲居士','宜章居士','易安居士',0,'1234','2015-10-10 10:00:05',1,6,6),(7,'李清照是哪个朝代的？','唐','魏晋','三国','宋',0,'1234','2015-10-10 10:00:06',1,7,6),(8,'下面哪一部不是倪匡的著作','钻石花','地底奇人','妖火','侠客行',0,'1234','2015-10-10 10:00:07',1,8,6),(9,'下面哪一部是倪匡的著作','海尔兄弟','三体','狂蟒之灾','蜂云',0,'1234','2015-10-10 10:00:08',1,9,6),(10,'香港四大才子谁年龄最大','倪匡','黄沾','蔡澜','金庸',0,'1234','2015-10-10 10:00:09',1,10,6),(21,'11111','22222','3333','4444','5555',0,'2413','2016-04-12 16:29:13',1,1,5);
/*!40000 ALTER TABLE `T_QUESTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_SECURITY_QUESTION`
--

DROP TABLE IF EXISTS `T_SECURITY_QUESTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_SECURITY_QUESTION` (
  `pk_security_question_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '密保问题表',
  `security_question_one` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保问题一',
  `security_question_two` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保问题二',
  `security_question_three` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保问题三',
  `security_question_answer_one` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保答案一',
  `security_question_answer_two` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保答案二',
  `security_question_answer_three` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '密保答案三',
  `security_time` datetime NOT NULL COMMENT '记录添加时间',
  `security_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_security_question_user_id` int(11) NOT NULL COMMENT '用户编号',
  PRIMARY KEY (`pk_security_question_id`),
  KEY `fk_T_SECURITY_QUESTION_T_USER1_idx` (`fk_security_question_user_id`),
  CONSTRAINT `fk_T_SECURITY_QUESTION_T_USER1` FOREIGN KEY (`fk_security_question_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_SECURITY_QUESTION`
--

LOCK TABLES `T_SECURITY_QUESTION` WRITE;
/*!40000 ALTER TABLE `T_SECURITY_QUESTION` DISABLE KEYS */;
INSERT INTO `T_SECURITY_QUESTION` VALUES (1,'天王盖地虎','爸爸的名字','自己的外号','宝塔镇河妖','长瑞兄','大宝','2015-10-10 11:00:00',1,1),(2,'天王盖地虎','爸爸的名字','自己的外号','下山能擒虎','长瑞兄','二宝','2015-10-10 11:00:01',1,2),(3,'天王盖地虎','爸爸的名字','自己的外号','下河能抓妖','长如兄','三宝','2015-10-10 11:00:02',1,3),(4,'天王盖地虎','爸爸的名字','自己的外号','上山能擒龙','长瑞兄','四宝','2015-10-10 11:00:03',1,4),(5,'天王盖地虎','爸爸的名字','自己的外号','煎饼果子来一套','长瑞兄','五宝','2015-10-10 11:00:04',1,5),(6,'天王盖地虎','爸爸的名字','自己的外号','呦呦切克闹','长瑞兄','六宝','2015-10-10 11:00:05',1,6),(7,'天王盖地虎','爸爸的名字','自己的外号','莫哈莫哈','长瑞兄','七宝','2015-10-10 11:00:06',1,7),(8,'天王盖地虎','爸爸的名字','自己的外号','正晌午时说话','长瑞兄','八宝','2015-10-10 11:00:07',1,8),(9,'天王盖地虎','爸爸的名字','自己的外号','谁也没有家','长瑞兄','九宝','2015-10-10 11:00:08',1,9),(10,'天王盖地虎','爸爸的名字','自己的外号','脸怎么黄了','长瑞兄','小宝','2015-10-10 11:00:09',1,10);
/*!40000 ALTER TABLE `T_SECURITY_QUESTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_STATE`
--

DROP TABLE IF EXISTS `T_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_STATE` (
  `pk_state_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '状态表编号',
  `state_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '状态名称',
  `state_value` int(11) NOT NULL COMMENT '状态值',
  `state_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '状态类型(标识所属哪个表)',
  `state_time` datetime NOT NULL COMMENT '记录添加时间',
  `state_usable` int(11) DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`pk_state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_STATE`
--

LOCK TABLES `T_STATE` WRITE;
/*!40000 ALTER TABLE `T_STATE` DISABLE KEYS */;
INSERT INTO `T_STATE` VALUES (1,'待审核',0,'Thesis','2015-10-10 01:00:01',1),(2,'未使用',1,'Thesis','2015-10-10 01:00:02',1),(3,'正在使用',2,'Thesis','2015-10-10 01:00:03',1),(4,'已使用',3,'Thesis','2015-10-10 01:00:04',1),(5,'待审核',0,'Question','2015-10-10 01:00:05',1),(6,'未使用',1,'Question','2015-10-10 01:00:06',1),(7,'正在使用',2,'Question','2015-10-10 01:00:07',1),(8,'已使用',3,'Question','2015-10-10 01:00:08',1),(9,'匿名',0,'Argument','2015-10-10 01:00:09',1),(10,'不匿名',1,'Argument','2015-10-10 01:00:10',1),(11,'待审核',0,'Book','2015-10-10 01:00:11',1),(12,'已审核',1,'Book','2015-10-10 01:00:12',1);
/*!40000 ALTER TABLE `T_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_THESIS`
--

DROP TABLE IF EXISTS `T_THESIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_THESIS` (
  `pk_thesis_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '辩题表编号',
  `thesis_content` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '辩题内容',
  `thesis_pros` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '正方论点',
  `thesis_pros_count` int(11) NOT NULL DEFAULT '0' COMMENT '正方支持人数',
  `thesis_pros_reply_number` int(11) NOT NULL DEFAULT '0' COMMENT '正方回复人数',
  `thesis_cons` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '反方论点',
  `thesis_cons_count` int(11) NOT NULL DEFAULT '0' COMMENT '反方支持人数',
  `thesis_cons_reply_number` int(11) NOT NULL DEFAULT '0' COMMENT '反方回复人数',
  `thesis_collect_number` int(11) NOT NULL DEFAULT '0' COMMENT '收藏辩题人数',
  `thesis_start_time` datetime NOT NULL COMMENT '辩题开始时间',
  `thesis_end_time` datetime NOT NULL COMMENT '辩题结束时间',
  `thesis_time` datetime NOT NULL COMMENT '记录添加时间',
  `thesis_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `thesis_add_reson` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '添加辩题原因',
  `fk_thesis_state_id` int(11) NOT NULL DEFAULT '0' COMMENT '辩题状态',
  `fk_thesis_user_id` int(11) NOT NULL COMMENT '贡献辩题人',
  PRIMARY KEY (`pk_thesis_id`),
  KEY `fk_T_THESIS_T_STATES1_idx` (`fk_thesis_state_id`),
  KEY `fk_T_THESIS_T_USER1_idx` (`fk_thesis_user_id`),
  CONSTRAINT `fk_T_THESIS_T_STATES1` FOREIGN KEY (`fk_thesis_state_id`) REFERENCES `T_STATE` (`pk_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_THESIS_T_USER1` FOREIGN KEY (`fk_thesis_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_THESIS`
--

LOCK TABLES `T_THESIS` WRITE;
/*!40000 ALTER TABLE `T_THESIS` DISABLE KEYS */;
INSERT INTO `T_THESIS` VALUES (1,'人性本善还是本恶','人性本善',20,21,'人性本恶',22,7,9997,'2015-09-27 01:00:00','2015-10-01 01:00:00','2015-11-01 10:00:00',1,NULL,3,1),(2,'金钱是不是万恶之源','金钱是万恶之源',30,0,'金钱不是万恶之源',22,0,0,'2015-10-01 01:00:01','2015-10-05 01:00:00','2015-11-01 10:00:01',1,NULL,2,1),(3,'大学应不应该封校','大学应该封校',12,0,'大学不应该封校',22,0,0,'2015-10-05 01:00:01','2015-10-09 01:00:00','2015-11-01 10:00:02',1,NULL,1,1),(4,'个人的命运是由个人掌握还是社会掌握','个人命运是由个人掌握',111,0,'个人命运是由社会掌握',22,0,0,'2015-10-09 01:00:01','2015-10-13 01:00:00','2015-11-01 10:00:03',1,NULL,1,1),(5,'便利器具便不便利','便利器具便利',54,0,'便利器具不便利',22,0,0,'2015-10-13 01:00:01','2015-10-17 01:00:00','2015-11-01 10:00:04',1,NULL,1,1),(6,'个性需不需要刻意追求','个性需要刻意追求',23,0,'个性不需要刻意追求',22,0,0,'2015-10-17 01:00:01','2015-10-21 01:00:00','2015-11-01 10:00:05',1,NULL,1,1),(7,'相处和相爱哪个难','相处容易相爱难',68,0,'相爱容易相处难',22,0,0,'2015-10-21 01:00:01','2015-10-25 01:00:00','2015-11-01 10:00:06',1,NULL,1,1),(8,'成大事者拘不拘小节','成大事者不拘小节',56,0,'成大事者也拘小节',22,0,0,'2015-10-25 01:00:01','2015-10-29 01:00:00','2015-11-01 10:00:07',1,NULL,1,1),(9,'环境保护应该以人为本还是以自然为本','环境保护应该以人为本',44,0,'环境保护应该以自然为本',22,0,0,'2015-10-29 01:00:01','2015-11-01 01:00:00','2015-11-01 10:00:08',1,NULL,1,1),(10,'劳心者和劳力者哪个对社会贡献大','劳心者比劳力者对社会更有贡献',11,0,'劳力者比劳心者对社会更有贡献',22,0,0,'2015-11-01 01:00:01','2015-11-05 01:00:00','2015-11-01 10:00:09',1,NULL,1,1),(11,'天灾和人祸哪个更可怕','天灾比人祸更可怕',200,0,'人祸比天灾更可怕',22,0,0,'2015-11-05 01:00:01','2015-11-09 01:00:00','2015-11-01 10:00:10',1,NULL,1,1),(12,'Add','As',0,0,'Was',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-03-16 18:07:54',1,'Ads',1,1),(13,'11111','22222',0,0,'33333',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-03-18 15:30:00',1,'44444',1,1),(14,'1','1',0,0,'1',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-04-06 14:28:27',1,'',1,1),(15,'Lasjdlfkasdlkfj','Skdfjalskdfj',0,0,'Aaaaaa',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-04-09 13:49:18',1,'',1,1),(16,'123','1',0,0,'2',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-04-09 13:52:12',1,'3',2,1),(17,'','111',0,0,'222',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-04-09 13:53:28',1,'33',1,1),(18,'123123','112',0,0,'113',0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','2016-04-09 13:53:58',1,'',1,1);
/*!40000 ALTER TABLE `T_THESIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER`
--

DROP TABLE IF EXISTS `T_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER` (
  `pk_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户表编号',
  `user_account` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户账号',
  `user_password` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户密码',
  `user_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户昵称',
  `user_age` int(11) DEFAULT '0' COMMENT '用户年龄',
  `user_face_url` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'images/default.png' COMMENT '用户头像url',
  `user_score` int(11) NOT NULL DEFAULT '0' COMMENT '用户答题得分值',
  `user_exp` int(11) NOT NULL DEFAULT '0' COMMENT '用户经验值',
  `user_register_time` datetime NOT NULL COMMENT '用户注册时间',
  `user_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  PRIMARY KEY (`pk_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER`
--

LOCK TABLES `T_USER` WRITE;
/*!40000 ALTER TABLE `T_USER` DISABLE KEYS */;
INSERT INTO `T_USER` VALUES (1,'1001','123456','zcp',10,'201604081829069861.jpeg',4,543,'2015-10-01 11:00:00',1),(2,'1002','123','大灰狼',18,'zcp',80,125,'2015-10-01 16:00:00',1),(3,'1003','123','小红帽',12,'zcp',12,225,'2015-10-02 17:00:00',1),(4,'1004','123','熊猫人',20,'zcp',9,1050,'2015-10-03 13:00:00',1),(5,'1005','123','飞雪连天射白鹿',40,'zcp',89,3200,'2015-10-03 14:00:00',1),(6,'1006','123','么么哒',22,'zcp',92,12000,'2015-10-03 15:00:00',1),(7,'1007','123','大宝牌',21,'zcp',88,12253,'2015-10-04 11:00:00',1),(8,'1008','123','伟大的长瑞兄',20,'zcp',100,22332,'2015-10-05 11:00:00',1),(9,'1009','123','少帅',20,'zcp',98,6050,'2015-10-06 11:00:00',1),(10,'1010','123','潇洒',22,'zcp',60,3000,'2015-10-10 21:06:00',1);
/*!40000 ALTER TABLE `T_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_BOOK`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_BOOK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_BOOK` (
  `pk_user_collect_book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收藏图书表编号',
  `collect_time` datetime NOT NULL COMMENT '记录添加时间',
  `collect_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_ucb_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_ucb_book_id` int(11) NOT NULL COMMENT '图书编号',
  PRIMARY KEY (`pk_user_collect_book_id`),
  KEY `fk_T_USER_COLLECT_BOOK_T_USER1_idx` (`fk_ucb_user_id`),
  KEY `fk_T_USER_COLLECT_BOOK_T_BOOK1_idx` (`fk_ucb_book_id`),
  CONSTRAINT `fk_T_USER_COLLECT_BOOK_T_BOOK1` FOREIGN KEY (`fk_ucb_book_id`) REFERENCES `T_BOOK` (`pk_book_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_BOOK_T_USER1` FOREIGN KEY (`fk_ucb_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_BOOK`
--

LOCK TABLES `T_USER_COLLECT_BOOK` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_BOOK` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_BOOK` VALUES (9,'2016-03-17 18:06:14',1,1,10),(10,'2016-03-23 17:10:03',1,1,43);
/*!40000 ALTER TABLE `T_USER_COLLECT_BOOK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_BOOKPOST`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_BOOKPOST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_BOOKPOST` (
  `pk_user_collect_bookpost_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收藏图书贴表编号',
  `collect_time` datetime NOT NULL COMMENT '记录添加时间',
  `collect_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_ucbp_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_ucbp_bookpost_id` int(11) NOT NULL COMMENT '图书帖编号',
  PRIMARY KEY (`pk_user_collect_bookpost_id`),
  KEY `fk_T_USER_COLLECT_BOOKPOST_T_USER1_idx` (`fk_ucbp_user_id`),
  KEY `fk_T_USER_COLLECT_BOOKPOST_T_BOOKPOST1_idx` (`fk_ucbp_bookpost_id`),
  CONSTRAINT `fk_T_USER_COLLECT_BOOKPOST_T_BOOKPOST1` FOREIGN KEY (`fk_ucbp_bookpost_id`) REFERENCES `T_BOOKPOST` (`pk_bookpost_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_BOOKPOST_T_USER1` FOREIGN KEY (`fk_ucbp_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_BOOKPOST`
--

LOCK TABLES `T_USER_COLLECT_BOOKPOST` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_BOOKPOST` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_BOOKPOST` VALUES (1,'2015-09-08 12:00:01',1,1,1),(2,'2015-09-08 12:00:02',0,1,2),(3,'2015-09-08 12:00:03',1,1,3),(4,'2015-09-08 12:00:04',1,2,5),(5,'2015-09-08 12:00:05',1,4,5),(6,'2016-04-05 18:49:35',1,1,17),(7,'2016-04-06 10:34:13',1,1,19);
/*!40000 ALTER TABLE `T_USER_COLLECT_BOOKPOST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_COUPLET`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_COUPLET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_COUPLET` (
  `pk_user_collect_couplet_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收藏对联表编号',
  `collect_time` datetime NOT NULL COMMENT '记录添加时间',
  `collect_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_ucc_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_ucc_couplet_id` int(11) NOT NULL COMMENT '对联编号',
  PRIMARY KEY (`pk_user_collect_couplet_id`),
  KEY `fk_T_USER_COLLECT_COUPLET_T_USER1_idx` (`fk_ucc_user_id`),
  KEY `fk_T_USER_COLLECT_COUPLET_T_COUPLET1_idx` (`fk_ucc_couplet_id`),
  CONSTRAINT `fk_T_USER_COLLECT_COUPLET_T_COUPLET1` FOREIGN KEY (`fk_ucc_couplet_id`) REFERENCES `T_COUPLET` (`pk_couplet_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_COUPLET_T_USER1` FOREIGN KEY (`fk_ucc_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_COUPLET`
--

LOCK TABLES `T_USER_COLLECT_COUPLET` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_COUPLET` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_COUPLET` VALUES (1,'2016-02-17 18:00:56',1,1,26),(2,'2016-02-18 19:06:21',0,1,27),(3,'2016-02-24 13:16:38',1,1,28),(4,'2016-03-18 10:26:33',1,1,30),(5,'2016-03-24 18:20:31',1,1,31),(6,'2016-04-06 14:08:34',1,1,34);
/*!40000 ALTER TABLE `T_USER_COLLECT_COUPLET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_QUESTION`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_QUESTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_QUESTION` (
  `pk_user_collect_question_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收藏问题表编号',
  `collect_time` datetime NOT NULL COMMENT '记录添加时间',
  `collect_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_ucq_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_ucq_question_id` int(11) NOT NULL COMMENT '问题编号',
  PRIMARY KEY (`pk_user_collect_question_id`),
  KEY `fk_T_USER_COLLECT_QUESTION_T_USER1_idx` (`fk_ucq_user_id`),
  KEY `fk_T_USER_COLLECT_QUESTION_T_QUESTION1_idx` (`fk_ucq_question_id`),
  CONSTRAINT `fk_T_USER_COLLECT_QUESTION_T_QUESTION1` FOREIGN KEY (`fk_ucq_question_id`) REFERENCES `T_QUESTION` (`pk_question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_QUESTION_T_USER1` FOREIGN KEY (`fk_ucq_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_QUESTION`
--

LOCK TABLES `T_USER_COLLECT_QUESTION` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_QUESTION` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_QUESTION` VALUES (1,'2015-09-08 12:00:01',1,1,1),(2,'2015-09-08 12:00:02',1,1,2),(3,'2015-09-08 12:00:03',1,1,3),(4,'2015-09-08 12:00:04',1,2,5),(5,'2015-09-08 12:00:05',1,1,5),(6,'2016-04-12 11:04:24',1,1,4);
/*!40000 ALTER TABLE `T_USER_COLLECT_QUESTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_THESIS`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_THESIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_THESIS` (
  `pk_user_collect_thesis_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收藏辩题表编号',
  `collect_time` datetime NOT NULL COMMENT '记录添加时间',
  `collect_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_uct_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_uct_thesis_id` int(11) NOT NULL COMMENT '辩题编号',
  PRIMARY KEY (`pk_user_collect_thesis_id`),
  KEY `fk_T_USER_COLLECT_THESIS_T_USER1_idx` (`fk_uct_user_id`),
  KEY `fk_T_USER_COLLECT_THESIS_T_THESIS1_idx` (`fk_uct_thesis_id`),
  CONSTRAINT `fk_T_USER_COLLECT_THESIS_T_THESIS1` FOREIGN KEY (`fk_uct_thesis_id`) REFERENCES `T_THESIS` (`pk_thesis_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_THESIS_T_USER1` FOREIGN KEY (`fk_uct_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_THESIS`
--

LOCK TABLES `T_USER_COLLECT_THESIS` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_THESIS` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_THESIS` VALUES (1,'2015-09-08 12:00:01',0,1,1),(2,'2015-09-08 12:00:02',1,1,2),(3,'2015-09-08 12:00:03',1,1,3),(4,'2015-09-08 12:00:04',1,2,5),(5,'2015-09-08 12:00:05',1,3,5);
/*!40000 ALTER TABLE `T_USER_COLLECT_THESIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_COLLECT_USER`
--

DROP TABLE IF EXISTS `T_USER_COLLECT_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_COLLECT_USER` (
  `pk_user_collect_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `collect_time` datetime NOT NULL,
  `collect_usable` int(11) NOT NULL DEFAULT '1',
  `fk_ucu_user_id` int(11) NOT NULL,
  `fk_ucu_user_id_collected` int(11) NOT NULL,
  PRIMARY KEY (`pk_user_collect_user_id`),
  KEY `fk_T_USER_COLLECT_USER_idx` (`fk_ucu_user_id`),
  KEY `fk_T_USER_COLLECT_USER_idx1` (`fk_ucu_user_id_collected`),
  CONSTRAINT `fk_T_USER_COLLECT_USER_T_USER1` FOREIGN KEY (`fk_ucu_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_COLLECT_USER_T_USER2` FOREIGN KEY (`fk_ucu_user_id_collected`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_COLLECT_USER`
--

LOCK TABLES `T_USER_COLLECT_USER` WRITE;
/*!40000 ALTER TABLE `T_USER_COLLECT_USER` DISABLE KEYS */;
INSERT INTO `T_USER_COLLECT_USER` VALUES (1,'2016-04-08 13:51:20',1,1,2),(2,'2016-04-08 13:55:27',1,1,3),(3,'2016-04-08 13:56:40',0,1,4),(4,'2016-04-08 00:00:00',1,3,1),(5,'2016-04-08 00:00:00',1,3,2);
/*!40000 ALTER TABLE `T_USER_COLLECT_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `T_USER_FOCUS_FIELD`
--

DROP TABLE IF EXISTS `T_USER_FOCUS_FIELD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `T_USER_FOCUS_FIELD` (
  `pk_user_focus_field_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户关注领域表编号',
  `user_focus_field_time` datetime NOT NULL COMMENT '记录添加时间',
  `user_focus_field_usable` int(11) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `fk_user_focus_field_user_id` int(11) NOT NULL COMMENT '用户编号',
  `fk_user_focus_field_field_id` int(11) NOT NULL COMMENT '领域编号',
  PRIMARY KEY (`pk_user_focus_field_id`),
  KEY `fk_T_USER_FIELDS_T_USERS_idx` (`fk_user_focus_field_user_id`),
  KEY `fk_T_USER_FIELDS_T_FIELDS1_idx` (`fk_user_focus_field_field_id`),
  CONSTRAINT `fk_T_USER_FIELDS_T_FIELDS1` FOREIGN KEY (`fk_user_focus_field_field_id`) REFERENCES `T_FIELD` (`pk_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_T_USER_FIELDS_T_USERS` FOREIGN KEY (`fk_user_focus_field_user_id`) REFERENCES `T_USER` (`pk_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `T_USER_FOCUS_FIELD`
--

LOCK TABLES `T_USER_FOCUS_FIELD` WRITE;
/*!40000 ALTER TABLE `T_USER_FOCUS_FIELD` DISABLE KEYS */;
INSERT INTO `T_USER_FOCUS_FIELD` VALUES (1,'2015-10-01 11:00:00',1,1,2),(2,'2015-10-01 12:00:00',1,1,3),(3,'2015-10-02 12:01:00',1,1,1),(4,'2015-10-03 11:00:03',1,2,1),(5,'2015-10-04 11:00:05',1,2,2),(6,'2015-10-06 12:00:06',1,2,3),(7,'2015-10-06 12:00:07',1,3,1),(8,'2015-10-07 11:00:00',1,3,5),(9,'2015-10-08 11:01:01',1,3,3),(10,'2015-10-10 11:01:01',1,4,1),(11,'2016-04-08 00:00:00',1,4,2),(12,'2016-04-08 00:00:00',1,4,7);
/*!40000 ALTER TABLE `T_USER_FOCUS_FIELD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'WenHuiApartment'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_ArgumentByBelong_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_ArgumentByBelong_Select`(IN `belong` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
BEGIN

DECLARE curr_thesis_id int;
DECLARE working_state_id int;
SET working_state_id = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE T_STATE.state_usable = 1 AND T_STATE.state_type = 'Thesis' AND T_STATE.state_value = 2
);
SET curr_thesis_id = (
    SELECT T_THESIS.pk_thesis_id
    FROM T_THESIS
    WHERE T_THESIS.thesis_usable = 1 AND T_THESIS.fk_thesis_state_id = working_state_id
);

SELECT *
FROM T_ARGUMENT
LEFT JOIN T_USER ON T_ARGUMENT.fk_argument_user_id = T_USER.pk_user_id
LEFT JOIN T_STATE ON T_ARGUMENT.fk_argument_state_id = T_STATE.pk_state_id
WHERE T_ARGUMENT.argument_usable = 1 AND T_ARGUMENT.fk_argument_thesis_id = curr_thesis_id AND T_ARGUMENT.argument_belong = belong
ORDER BY T_ARGUMENT.argument_time DESC
LIMIT page_index, page_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Argument_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Argument_Insert`(IN `state_value` INT, IN `content` VARCHAR(100) CHARSET utf8, IN `belong` INT, IN `thesis_id` INT, IN `user_id` INT)
    NO SQL
BEGIN
DECLARE anonymous_state_id int;
DECLARE working_state_id int;

SET anonymous_state_id = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE T_STATE.state_usable = 1 AND T_STATE.state_type='Argument' AND T_STATE.state_value=state_value
);

INSERT INTO T_ARGUMENT (argument_content, argument_belong, argument_time, fk_argument_thesis_id, fk_argument_user_id, fk_argument_state_id) VALUES(content, belong, CURRENT_TIMESTAMP, thesis_id, user_id, anonymous_state_id);

IF belong=1 THEN
	UPDATE T_THESIS SET T_THESIS.thesis_pros_reply_number = T_THESIS.thesis_pros_reply_number+1 
    WHERE T_THESIS.thesis_usable=1 AND T_THESIS.pk_thesis_id=thesis_id;
    UPDATE T_USER SET user_exp = user_exp+1 WHERE pk_user_id=user_id;
ELSEIF belong=0 THEN
	UPDATE T_THESIS SET T_THESIS.thesis_cons_reply_number = T_THESIS.thesis_cons_reply_number + 1
    WHERE T_THESIS.thesis_usable=1 AND T_THESIS.pk_thesis_id = thesis_id;
    UPDATE T_USER SET user_exp = user_exp+1 WHERE pk_user_id=user_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BookReplyByBookID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BookReplyByBookID_Select`(IN `book_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
SELECT *
FROM (
    SELECT *
    FROM T_BOOK_REPLY
    WHERE T_BOOK_REPLY.book_reply_usable = 1 AND T_BOOK_REPLY.fk_br_book_id = book_id
    ORDER BY T_BOOK_REPLY.book_reply_support DESC,  T_BOOK_REPLY.book_reply_time DESC
    LIMIT page_index, page_count
) br
LEFT JOIN (
    SELECT *
    FROM T_USER
    WHERE T_USER.user_usable = 1
) u
ON u.pk_user_id = br.fk_br_user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BookReply_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BookReply_Insert`(IN `content` VARCHAR(40), IN `book_id` INT, IN `user_id` INT)
    NO SQL
BEGIN
INSERT INTO T_BOOK_REPLY(book_reply_content,book_reply_time,fk_br_book_id,fk_br_user_id) 
VALUES(content, CURRENT_TIMESTAMP, book_id, user_id);
UPDATE T_BOOK SET book_comment_count = book_comment_count + 1 WHERE pk_book_id = book_id;
UPDATE T_USER SET user_exp = user_exp+1 WHERE pk_user_id=user_id;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Book_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Book_Insert`(IN `name` VARCHAR(100) CHARSET utf8, IN `author` VARCHAR(100) CHARSET utf8, IN `publish_time` VARCHAR(100) CHARSET utf8, IN `cover_url` VARCHAR(100) CHARSET utf8, IN `publisher` VARCHAR(100) CHARSET utf8, IN `summary` TEXT CHARSET utf8, IN `field_id` INT, IN `user_id` INT, IN `statevalue` INT)
    NO SQL
BEGIN
DECLARE state_id int DEFAULT 1;
set state_id = (
    SELECT pk_state_id
    FROM T_STATE
    WHERE state_type = 'Book' AND state_value = statevalue
);
INSERT INTO T_BOOK(book_name,book_author,book_publish_time,book_cover_url,book_publisher,book_summary,book_time,fk_book_field_id,fk_book_user_id,fk_book_state_id)
VALUES(name, author, publish_time, cover_url, publisher, summary, CURRENT_TIMESTAMP, field_id, user_id, state_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;

SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Book_SelectByMultiCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Book_SelectByMultiCondition`(IN `search_text` VARCHAR(40), IN `sort_method` INT, IN `field_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
BEGIN
CREATE TEMPORARY TABLE temp_table (
  SELECT * FROM (
    SELECT * FROM T_BOOK
    WHERE T_BOOK.book_usable = 1 AND T_BOOK.fk_book_state_id = 12 AND (T_BOOK.book_name LIKE search_text OR T_BOOK.book_author LIKE search_text OR T_BOOK.book_publisher LIKE search_text)
  ) b
  LEFT JOIN (SELECT * FROM T_USER WHERE T_USER.user_usable = 1) u ON b.fk_book_user_id = u.pk_user_id
  LEFT JOIN (SELECT * FROM T_FIELD WHERE T_FIELD.field_usable = 1) f ON b.fk_book_field_id = f.pk_field_id
);

IF sort_method = 0 THEN
  IF field_id = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.book_time DESC
    LIMIT page_index, page_count;
  ELSE
    SELECT * FROM temp_table
    WHERE temp_table.fk_book_field_id = field_id
    ORDER BY temp_table.book_time DESC
    LIMIT page_index, page_count;
  END IF;
ELSEIF sort_method = 1 THEN
  IF field_id = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.book_collect_number DESC 
    LIMIT page_index, page_count;
  ELSE
    SELECT * FROM temp_table
    WHERE temp_table.fk_book_field_id = field_id
    ORDER BY temp_table.book_collect_number DESC 
    LIMIT page_index, page_count;
  END IF;
ELSEIF sort_method = 2 THEN
  IF field_id = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.book_comment_count DESC
    LIMIT page_index, page_count;
  ELSE
    SELECT * FROM temp_table
    WHERE temp_table.fk_book_field_id = field_id
    ORDER BY temp_table.book_comment_count DESC
    LIMIT page_index, page_count;
  END IF;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BpCommentByBookpostID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BpCommentByBookpostID_Select`(IN `bookpost_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
SELECT *
FROM (
    SELECT *
    FROM T_BOOKPOST_COMMENT
    WHERE T_BOOKPOST_COMMENT.comment_usable = 1 AND T_BOOKPOST_COMMENT.fk_bpc_bp_id = bookpost_id
    ORDER BY T_BOOKPOST_COMMENT.comment_support DESC,  T_BOOKPOST_COMMENT.comment_time DESC
    LIMIT page_index, page_count
) bpc
LEFT JOIN (
    SELECT *
    FROM T_USER
    WHERE T_USER.user_usable = 1
) u
ON u.pk_user_id = bpc.fk_bpc_user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BpCommentReplyByCommentID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BpCommentReplyByCommentID_Select`(IN `comment_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
SELECT *
FROM (
    SELECT *
    FROM T_BOOKPOST_COMMENT_REPLY
    WHERE T_BOOKPOST_COMMENT_REPLY.reply_usable = 1 AND T_BOOKPOST_COMMENT_REPLY.fk_bpcr_bpc_id = comment_id
    ORDER BY T_BOOKPOST_COMMENT_REPLY.reply_time DESC
    LIMIT page_index, page_count
) bpcr
LEFT JOIN (
    SELECT *
    FROM T_USER
    WHERE T_USER.user_usable = 1
) u
ON u.pk_user_id = bpcr.fk_bpcr_user_id
LEFT JOIN (
    SELECT pk_user_id pk_user_id_receiver, user_name user_name_receiver
    FROM T_USER
    WHERE T_USER.user_usable = 1
) receiver
ON receiver.pk_user_id_receiver = bpcr.fk_bpcr_user_id_receiver ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BpCommentReply_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BpCommentReply_Insert`(IN `content` VARCHAR(1000), IN `is_reply_author` INT, IN `comment_id` INT, IN `user_id` INT, IN `receiver_id` INT)
    NO SQL
BEGIN
INSERT INTO T_BOOKPOST_COMMENT_REPLY(reply_content, reply_time, reply_isreply_author, fk_bpcr_user_id, fk_bpcr_user_id_receiver, fk_bpcr_bpc_id)
VALUES(content, CURRENT_TIMESTAMP, is_reply_author, user_id, receiver_id, comment_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;
UPDATE T_BOOKPOST_COMMENT SET comment_reply_number = comment_reply_number + 1 WHERE pk_bookpost_comment_id = comment_id;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_BpComment_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_BpComment_Insert`(IN `content` VARCHAR(2000), IN `bookpost_id` INT, IN `user_id` INT)
    NO SQL
BEGIN
INSERT INTO T_BOOKPOST_COMMENT(comment_content, comment_time, fk_bpc_user_id, fk_bpc_bp_id)
VALUES(content, CURRENT_TIMESTAMP,user_id, bookpost_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;
UPDATE T_BOOKPOST SET bookpost_reply_number = bookpost_reply_number + 1 WHERE pk_bookpost_id = bookpost_id;

SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Bp_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Bp_Insert`(IN `title` VARCHAR(100), IN `content` VARCHAR(1000), IN `book_name` VARCHAR(100), IN `user_id` INT, IN `field_id` INT)
    NO SQL
BEGIN
INSERT INTO T_BOOKPOST (bookpost_title, bookpost_content, bookpost_book_name, bookpost_time, fk_bp_user_id, fk_bp_field_id) VALUES(title, content, book_name, CURRENT_TIMESTAMP, user_id, field_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Bp_SelectByMultiCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Bp_SelectByMultiCondition`(IN `search_text` VARCHAR(40), IN `sort_method` INT, IN `field_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
BEGIN
CREATE TEMPORARY TABLE temp_table (
  SELECT * FROM (
    SELECT * FROM (
      SELECT * FROM T_BOOKPOST
      WHERE T_BOOKPOST.bookpost_usable = 1
    ) bpt
    LEFT JOIN (SELECT * FROM T_USER WHERE T_USER.user_usable = 1) u ON bpt.fk_bp_user_id = u.pk_user_id
    LEFT JOIN (SELECT * FROM T_FIELD WHERE T_FIELD.field_usable = 1) f ON bpt.fk_bp_field_id = f.pk_field_id
  ) bp
  WHERE bp.bookpost_book_name LIKE search_text OR bp.bookpost_title LIKE search_text OR bp.bookpost_content LIKE search_text
);

IF sort_method = 0 THEN
  IF field_id = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.bookpost_time DESC
    LIMIT page_index, page_count;
  ELSE
    SELECT * FROM temp_table
    WHERE temp_table.fk_bp_field_id = field_id
    ORDER BY temp_table.bookpost_time DESC
    LIMIT page_index, page_count;
  END IF;
ELSEIF sort_method = 1 THEN
  IF field_id = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.bookpost_support DESC
    LIMIT page_index, page_count;
  ELSE
    SELECT * FROM temp_table
    WHERE temp_table.fk_bp_field_id = field_id
    ORDER BY temp_table.bookpost_support DESC
    LIMIT page_index, page_count;
  END IF;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_CoupletReplyByCoupletID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CoupletReplyByCoupletID_Select`(IN `couplet_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
SELECT *
FROM (
    SELECT *
    FROM T_COUPLET_REPLY
    WHERE T_COUPLET_REPLY.reply_usable = 1 AND T_COUPLET_REPLY.fk_cr_couplet_id = couplet_id
    ORDER BY T_COUPLET_REPLY.reply_support DESC,  T_COUPLET_REPLY.reply_time DESC

    LIMIT page_index, page_count
) cr
LEFT JOIN (
    SELECT *
    FROM T_USER
    WHERE T_USER.user_usable = 1
) u
ON u.pk_user_id = cr.fk_cr_user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_CoupletReply_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CoupletReply_Insert`(IN `content` VARCHAR(200) CHARSET utf8, IN `couplet_id` INT, IN `user_id` INT)
    NO SQL
BEGIN
INSERT INTO T_COUPLET_REPLY(reply_content,reply_time,fk_cr_couplet_id,fk_cr_user_id) 
VALUES(content, CURRENT_TIMESTAMP, couplet_id, user_id);
UPDATE T_COUPLET SET couplet_reply_number = couplet_reply_number + 1 WHERE pk_couplet_id = couplet_id;
UPDATE T_USER SET user_exp = user_exp+1 WHERE pk_user_id=user_id;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Couplet_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Couplet_Insert`(IN `content` VARCHAR(100) CHARSET utf8, IN `user_id` INT)
    NO SQL
BEGIN
INSERT 
INTO T_COUPLET (couplet_content, couplet_support, couplet_reply_number, couplet_time, fk_couplet_user_id) 

VALUES (content, '0', '0', CURRENT_TIMESTAMP, user_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;

SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Couplet_SelectByMultiCondition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Couplet_SelectByMultiCondition`(IN `sort_method` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
BEGIN
CREATE TEMPORARY TABLE temp_table (
  SELECT * FROM (
    SELECT * FROM T_COUPLET
    WHERE T_COUPLET.couplet_usable = 1
  ) c
  LEFT JOIN (SELECT * FROM T_USER WHERE T_USER.user_usable = 1) u ON c.fk_couplet_user_id = u.pk_user_id
);

IF sort_method = 0 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.couplet_time DESC
    LIMIT page_index, page_count;
ELSEIF sort_method = 1 THEN
    SELECT * FROM temp_table
    ORDER BY temp_table.couplet_support DESC
    LIMIT page_index, page_count;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_QuestionByQuestionState_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_QuestionByQuestionState_Select`(IN `state_value` INT, IN `page_count` INT)
    NO SQL
BEGIN

DECLARE state_id INT;
DECLARE question_count INT DEFAULT 0;
SET state_id = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Question' AND T_STATE.state_value=state_value
);

SET question_count = (
    SELECT COUNT(*)
    FROM T_QUESTION
    LEFT JOIN T_USER ON T_USER.pk_user_id = T_QUESTION.fk_question_user_id
    WHERE T_QUESTION.question_usable=1 AND T_QUESTION.fk_question_state_id=state_id
    ORDER BY T_QUESTION.question_time ASC
    LIMIT 0,page_count
);

IF question_count>=page_count THEN
SELECT *
FROM T_QUESTION
LEFT JOIN T_USER ON T_USER.pk_user_id = T_QUESTION.fk_question_user_id
WHERE T_QUESTION.question_usable=1 AND T_QUESTION.fk_question_state_id=state_id
ORDER BY T_QUESTION.question_time ASC
LIMIT 0,page_count;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Question_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Question_Insert`(IN `content` LONGTEXT CHARSET utf8, IN `option_one` LONGTEXT CHARSET utf8, IN `option_two` LONGTEXT CHARSET utf8, IN `option_three` LONGTEXT CHARSET utf8, IN `answer` LONGTEXT CHARSET utf8, IN `show_order` LONGTEXT CHARSET utf8, IN `user_id` INT)
    NO SQL
BEGIN
DECLARE state_id int;
SET state_id = (
    SELECT pk_state_id
    FROM T_STATE
    WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Question' AND T_STATE.state_value=0
);

INSERT INTO T_QUESTION(question_content, question_option_one, question_option_two, question_option_three, question_answer, question_show_order, question_time, fk_question_user_id, fk_question_state_id)
VALUES(content, option_one, option_two, option_three, answer, show_order, CURRENT_TIMESTAMP, user_id, state_id);

UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;

SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_ThesisByThesisState_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_ThesisByThesisState_Select`()
    NO SQL
BEGIN
DECLARE workingStateId int;
SET workingStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE T_STATE.state_usable = 1 AND T_STATE.state_type = 'Thesis' AND T_STATE.state_value = 2
);
SELECT *
FROM (
    SELECT *
    FROM T_THESIS
    WHERE T_THESIS.thesis_usable = 1 AND T_THESIS.fk_thesis_state_id = workingStateId
)t
LEFT JOIN T_STATE
ON T_STATE.pk_state_id = t.fk_thesis_state_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Thesis_Insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Thesis_Insert`(IN `content` VARCHAR(100) CHARSET utf8, IN `pros` VARCHAR(100) CHARSET utf8, IN `cons` VARCHAR(100) CHARSET utf8, IN `add_reson` VARCHAR(100) CHARSET utf8, IN `statevalue` INT, IN `user_id` INT)
    NO SQL
BEGIN
DECLARE state_id int DEFAULT 1;
set state_id = (
    SELECT pk_state_id
    FROM T_STATE
    WHERE state_type = 'Thesis' AND state_value = statevalue
);
INSERT INTO T_THESIS(thesis_content,thesis_pros,thesis_cons,thesis_time,thesis_add_reson,fk_thesis_state_id, fk_thesis_user_id)
VALUES(content, pros, cons, CURRENT_TIMESTAMP, add_reson,state_id, user_id);
UPDATE T_USER SET user_exp = user_exp+5 WHERE pk_user_id=user_id;

SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserByAccount_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserByAccount_Select`(IN `account` INT)
    NO SQL
BEGIN
SELECT * FROM (
    SELECT * FROM T_USER
	WHERE T_USER.user_account = account
) u
LEFT JOIN T_LEVELS
ON u.user_exp BETWEEN T_LEVELS.level_min_exp AND T_LEVELS.level_max_exp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserByHeadURL_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserByHeadURL_Update`(IN `head_url` VARCHAR(50), IN `user_id` INT)
    NO SQL
BEGIN
UPDATE T_USER
SET user_face_url = head_url
WHERE pk_user_id=user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserByUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserByUserID_Select`(IN `user_id` INT)
    NO SQL
BEGIN
SELECT * FROM (
    SELECT * FROM T_USER
	WHERE T_USER.pk_user_id = user_id
) u
LEFT JOIN T_LEVELS
ON u.user_exp BETWEEN T_LEVELS.level_min_exp AND T_LEVELS.level_max_exp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectBookByBookIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectBookByBookIDUserID_InsertOrDelete`(IN `user_id` INT, IN `book_id` INT, IN `curr_collected` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_BOOK ucb
    WHERE ucb.fk_ucb_user_id = user_id AND ucb.fk_ucb_book_id = book_id
);
IF is_exist=0 THEN
    INSERT INTO T_USER_COLLECT_BOOK(collect_time, collect_usable, fk_ucb_user_id, fk_ucb_book_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, book_id);
    UPDATE T_BOOK SET book_collect_number = book_collect_number + 1 WHERE pk_book_id=book_id;
END IF;
IF is_exist=1 AND curr_collected=0 THEN
  UPDATE T_USER_COLLECT_BOOK SET collect_usable=1 WHERE fk_ucb_user_id = user_id AND fk_ucb_book_id = book_id;
    UPDATE T_BOOK SET book_collect_number = book_collect_number + 1 WHERE pk_book_id=book_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
    UPDATE T_USER_COLLECT_BOOK SET collect_usable=0  WHERE fk_ucb_user_id = user_id AND fk_ucb_book_id = book_id;
    UPDATE T_BOOK SET book_collect_number = book_collect_number - 1 WHERE pk_book_id=book_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectBookByBookIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectBookByBookIDUserID_Select`(IN `book_id` INT, IN `user_id` INT)
    NO SQL
    COMMENT '检查是否收藏'
SELECT *
FROM T_USER_COLLECT_BOOK
WHERE T_USER_COLLECT_BOOK.fk_ucb_user_id = user_id AND T_USER_COLLECT_BOOK.fk_ucb_book_id = book_id AND T_USER_COLLECT_BOOK.collect_usable = 1 ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectBpByBookpostIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectBpByBookpostIDUserID_InsertOrDelete`(IN `bookpost_id` INT, IN `user_id` INT, IN `curr_collected` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_BOOKPOST ucbp
    WHERE ucbp.fk_ucbp_user_id = user_id AND ucbp.fk_ucbp_bookpost_id = bookpost_id
);

IF is_exist=0 THEN
    INSERT INTO T_USER_COLLECT_BOOKPOST(collect_time, collect_usable, fk_ucbp_user_id, fk_ucbp_bookpost_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, bookpost_id);
    UPDATE T_BOOKPOST SET bookpost_collect_number = bookpost_collect_number + 1 WHERE pk_bookpost_id=bookpost_id;
END IF;
IF is_exist=1 AND curr_collected=0 THEN
  UPDATE T_USER_COLLECT_BOOKPOST SET collect_usable=1 WHERE fk_ucbp_user_id = user_id AND fk_ucbp_bookpost_id = bookpost_id;
    UPDATE T_BOOKPOST SET bookpost_collect_number = bookpost_collect_number + 1 WHERE pk_bookpost_id=bookpost_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
    UPDATE T_USER_COLLECT_BOOKPOST SET collect_usable=0  WHERE fk_ucbp_user_id = user_id AND fk_ucbp_bookpost_id = bookpost_id;
    UPDATE T_BOOKPOST SET bookpost_collect_number = bookpost_collect_number - 1 WHERE pk_bookpost_id=bookpost_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectBpByBookpostIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectBpByBookpostIDUserID_Select`(IN `bookpost_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_USER_COLLECT_BOOKPOST
WHERE T_USER_COLLECT_BOOKPOST.fk_ucbp_user_id = user_id AND
T_USER_COLLECT_BOOKPOST.fk_ucbp_bookpost_id = bookpost_id AND T_USER_COLLECT_BOOKPOST.collect_usable = 1 ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectCoupletByCoupletIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectCoupletByCoupletIDUserID_InsertOrDelete`(IN `couplet_id` INT, IN `user_id` INT, IN `curr_collected` INT)
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_COUPLET ucc
    WHERE ucc.fk_ucc_user_id = user_id AND ucc.fk_ucc_couplet_id = couplet_id
);

IF is_exist=0 THEN
    INSERT INTO T_USER_COLLECT_COUPLET(collect_time, collect_usable, fk_ucc_user_id, fk_ucc_couplet_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, couplet_id);
    UPDATE T_COUPLET SET couplet_collect_number = couplet_collect_number + 1 WHERE pk_couplet_id=couplet_id;
END IF;
IF is_exist=1 AND curr_collected=0 THEN
	UPDATE T_USER_COLLECT_COUPLET SET collect_usable=1 WHERE fk_ucc_user_id = user_id AND fk_ucc_couplet_id = couplet_id;
    UPDATE T_COUPLET SET couplet_collect_number = couplet_collect_number + 1 WHERE pk_couplet_id=couplet_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
    UPDATE T_USER_COLLECT_COUPLET SET collect_usable=0  WHERE fk_ucc_user_id = user_id AND fk_ucc_couplet_id = couplet_id;
    UPDATE T_COUPLET SET couplet_collect_number = couplet_collect_number - 1 WHERE pk_couplet_id=couplet_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectCoupletByCoupletIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectCoupletByCoupletIDUserID_Select`(IN `couplet_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_USER_COLLECT_COUPLET ucc
WHERE ucc.collect_usable = 1 AND ucc.fk_ucc_couplet_id = couplet_id AND ucc.fk_ucc_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectQuestionByQuestionIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectQuestionByQuestionIDUserID_InsertOrDelete`(IN `question_id` INT, IN `user_id` INT, IN `curr_collected` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_QUESTION
    WHERE fk_ucq_user_id = user_id AND fk_ucq_question_id = question_id
);

IF is_exist=0 THEN
	INSERT INTO T_USER_COLLECT_QUESTION(collect_time, collect_usable, fk_ucq_user_id, fk_ucq_question_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, question_id);
    UPDATE T_QUESTION SET question_collect_number = question_collect_number + 1 WHERE pk_question_id = question_id;
END IF;
IF is_exist=1 AND curr_collected=0 THEN
	UPDATE T_USER_COLLECT_QUESTION SET collect_usable = 1 WHERE fk_ucq_user_id = user_id AND fk_ucq_question_id = question_id;
	UPDATE T_QUESTION SET question_collect_number = question_collect_number + 1 WHERE pk_question_id = question_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
	UPDATE T_USER_COLLECT_QUESTION SET collect_usable = 0 WHERE fk_ucq_user_id = user_id AND fk_ucq_question_id = question_id;
	UPDATE T_QUESTION SET question_collect_number = question_collect_number - 1 WHERE pk_question_id = question_id;
END IF;
SELECT 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectQuestionByQuestionIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectQuestionByQuestionIDUserID_Select`(IN `question_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_USER_COLLECT_QUESTION ucq
WHERE ucq.collect_usable = 1 AND ucq.fk_ucq_question_id = question_id AND ucq.fk_ucq_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectThesisByThesisIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectThesisByThesisIDUserID_InsertOrDelete`(IN `thesis_id` INT, IN `user_id` INT, IN `curr_collected` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_THESIS
    WHERE fk_uct_user_id = user_id AND fk_uct_thesis_id = thesis_id
);

IF is_exist=0 THEN
	INSERT INTO T_USER_COLLECT_THESIS(collect_time, collect_usable, fk_uct_user_id, fk_uct_thesis_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, thesis_id);
    UPDATE T_THESIS SET thesis_collect_number = thesis_collect_number + 1 WHERE pk_thesis_id = thesis_id;
END IF;
IF is_exist=1 AND curr_collected=0 THEN
	UPDATE T_USER_COLLECT_THESIS SET collect_usable = 1 WHERE fk_uct_thesis_id = thesis_id AND fk_uct_user_id = user_id;
	UPDATE T_THESIS SET thesis_collect_number = thesis_collect_number + 1 WHERE pk_thesis_id = thesis_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
	UPDATE T_USER_COLLECT_THESIS SET collect_usable = 0 WHERE fk_uct_thesis_id = thesis_id AND fk_uct_user_id = user_id;
	UPDATE T_THESIS SET thesis_collect_number = thesis_collect_number - 1 WHERE pk_thesis_id = thesis_id;
END IF;
SELECT 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectThesisBythesisIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectThesisBythesisIDUserID_Select`(IN `thesis_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_USER_COLLECT_THESIS uct
WHERE uct.collect_usable = 1 AND uct.fk_uct_thesis_id = thesis_id AND uct.fk_uct_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectUserByUserIDCollectedUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectUserByUserIDCollectedUserID_InsertOrDelete`(IN `collected_user_id` INT, IN `user_id` INT, IN `curr_collected` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_USER_COLLECT_USER
    WHERE T_USER_COLLECT_USER.fk_ucu_user_id = user_id AND T_USER_COLLECT_USER.fk_ucu_user_id_collected = collected_user_id
);

IF is_exist=0 THEN
	INSERT INTO T_USER_COLLECT_USER(collect_time , fk_ucu_user_id , fk_ucu_user_id_collected )
VALUES (CURRENT_TIMESTAMP, user_id, collected_user_id);
END IF;
IF is_exist=1 AND curr_collected=0 THEN
	UPDATE T_USER_COLLECT_USER SET collect_usable  = 1 WHERE fk_ucu_user_id = user_id AND fk_ucu_user_id_collected = collected_user_id;
END IF;
IF is_exist=1 AND curr_collected=1 THEN
	UPDATE T_USER_COLLECT_USER SET collect_usable  = 0 WHERE fk_ucu_user_id = user_id AND fk_ucu_user_id_collected = collected_user_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserCollectUser_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserCollectUser_Select`(IN `user_id` INT, IN `page_index` INT, IN `page_count` INT)
    NO SQL
SELECT *
FROM (
    SELECT * 
    FROM (
        SELECT fk_ucu_user_id_collected
        FROM T_USER_COLLECT_USER
        WHERE fk_ucu_user_id = user_id AND collect_usable = 1
        ORDER BY collect_time DESC
        LIMIT page_index, page_count
    ) ucu
    LEFT JOIN T_USER
    ON T_USER.pk_user_id = ucu.fk_ucu_user_id_collected
)ucu
LEFT JOIN T_LEVELS
ON ucu.user_exp BETWEEN T_LEVELS.level_min_exp AND T_LEVELS.level_max_exp ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserFocusFieldByUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserFocusFieldByUserID_Select`(IN `user_id` INT)
    NO SQL
BEGIN

SELECT * FROM (
    SELECT * FROM T_USER_FOCUS_FIELD
	WHERE fk_user_focus_field_user_id = user_id
) uff
LEFT JOIN T_FIELD 
ON T_FIELD.pk_field_id = uff.fk_user_focus_field_field_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportArgumentByArgumentIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportArgumentByArgumentIDUserID_InsertOrDelete`(IN `argument_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_ARGUMENT_SUP_RECORD
    WHERE fk_argument_sup_record_argument_id = argument_id AND fk_argument_sup_record_user_id = user_id
);

IF is_exist=0 THEN
	INSERT INTO T_ARGUMENT_SUP_RECORD(support_record_time, fk_argument_sup_record_argument_id, fk_argument_sup_record_user_id)
VALUES (CURRENT_TIMESTAMP, argument_id, user_id);
	UPDATE T_ARGUMENT SET T_ARGUMENT.argument_support = argument_support + 1 WHERE pk_argument_id = argument_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
	UPDATE T_ARGUMENT_SUP_RECORD SET support_record_usable = 1 WHERE fk_argument_sup_record_argument_id = argument_id AND fk_argument_sup_record_user_id = user_id;
	UPDATE T_ARGUMENT SET argument_support = argument_support + 1 WHERE pk_argument_id = argument_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
	UPDATE T_ARGUMENT_SUP_RECORD SET support_record_usable = 0 WHERE fk_argument_sup_record_argument_id = argument_id AND fk_argument_sup_record_user_id = user_id;
	UPDATE T_ARGUMENT SET T_ARGUMENT.argument_support = argument_support - 1 WHERE pk_argument_id = argument_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportArgumentByArgumentIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportArgumentByArgumentIDUserID_Select`(IN `argument_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_ARGUMENT_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_argument_sup_record_argument_id = argument_id AND t.fk_argument_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBookReplyByReplyIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBookReplyByReplyIDUserID_InsertOrDelete`(IN `reply_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_BOOK_REPLY_SUP_RECORD
    WHERE T_BOOK_REPLY_SUP_RECORD.fk_br_sup_record_br_id = reply_id AND T_BOOK_REPLY_SUP_RECORD.fk_br_sup_record_user_id = user_id
);

IF is_exist=0 THEN
	INSERT INTO T_BOOK_REPLY_SUP_RECORD(support_record_time, fk_br_sup_record_br_id, fk_br_sup_record_user_id)
VALUES (CURRENT_TIMESTAMP, reply_id, user_id);
	UPDATE T_BOOK_REPLY SET book_reply_support = book_reply_support + 1 WHERE pk_book_reply_id = reply_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
	UPDATE T_BOOK_REPLY_SUP_RECORD SET support_record_usable = 1 WHERE fk_br_sup_record_br_id = reply_id AND fk_br_sup_record_user_id = user_id;
	UPDATE T_BOOK_REPLY SET book_reply_support = book_reply_support + 1 WHERE pk_book_reply_id = reply_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
	UPDATE T_BOOK_REPLY_SUP_RECORD SET support_record_usable = 0 WHERE fk_br_sup_record_br_id = reply_id AND fk_br_sup_record_user_id = user_id;
	UPDATE T_BOOK_REPLY SET book_reply_support = book_reply_support - 1 WHERE pk_book_reply_id = reply_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBookReplyByReplyIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBookReplyByReplyIDUserID_Select`(IN `reply_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_BOOK_REPLY_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_br_sup_record_br_id = reply_id AND t.fk_br_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpByBookpostIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpByBookpostIDUserID_InsertOrDelete`(IN `bookpost_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_BOOKPOST_SUP_RECORD
    WHERE T_BOOKPOST_SUP_RECORD.fk_bp_sup_record_bp_id = bookpost_id AND T_BOOKPOST_SUP_RECORD.fk_bp_sup_record_user_id = user_id
);

IF is_exist=0 THEN
	INSERT INTO T_BOOKPOST_SUP_RECORD(support_record_time, fk_bp_sup_record_bp_id, fk_bp_sup_record_user_id)
VALUES (CURRENT_TIMESTAMP, bookpost_id, user_id);
	UPDATE T_BOOKPOST SET bookpost_support = bookpost_support + 1 WHERE pk_bookpost_id = bookpost_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
	UPDATE T_BOOKPOST_SUP_RECORD SET support_record_usable = 1 WHERE fk_bp_sup_record_bp_id = bookpost_id AND fk_bp_sup_record_user_id = user_id;
	UPDATE T_BOOKPOST SET bookpost_support = bookpost_support + 1 WHERE pk_bookpost_id = bookpost_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
	UPDATE T_BOOKPOST_SUP_RECORD SET support_record_usable = 0 WHERE fk_bp_sup_record_bp_id = bookpost_id AND fk_bp_sup_record_user_id = user_id;
	UPDATE T_BOOKPOST SET bookpost_support = bookpost_support - 1 WHERE pk_bookpost_id = bookpost_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpByBookpostIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpByBookpostIDUserID_Select`(IN `bookpost_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_BOOKPOST_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_bp_sup_record_bp_id = bookpost_id AND t.fk_bp_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpCommentByCommentIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpCommentByCommentIDUserID_InsertOrDelete`(IN `comment_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_BOOKPOST_COMMENT_SUP_RECORD
    WHERE fk_bpc_sup_record_user_id = user_id AND fk_bpc_sup_record_bpc_id = comment_id
);

IF is_exist=0 THEN
    INSERT INTO T_BOOKPOST_COMMENT_SUP_RECORD(support_record_time , support_record_usable , fk_bpc_sup_record_user_id , fk_bpc_sup_record_bpc_id ) VALUES (CURRENT_TIMESTAMP, '1', user_id, comment_id);
    UPDATE T_BOOKPOST_COMMENT SET comment_support = comment_support + 1 WHERE pk_bookpost_comment_id=comment_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
  UPDATE T_BOOKPOST_COMMENT_SUP_RECORD SET support_record_usable=1 WHERE fk_bpc_sup_record_user_id = user_id AND fk_bpc_sup_record_bpc_id = comment_id;
    UPDATE T_BOOKPOST_COMMENT SET comment_support = comment_support + 1 WHERE pk_bookpost_comment_id=comment_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
    UPDATE T_BOOKPOST_COMMENT_SUP_RECORD SET support_record_usable=0  WHERE fk_bpc_sup_record_user_id = user_id AND fk_bpc_sup_record_bpc_id = comment_id;
    UPDATE T_BOOKPOST_COMMENT SET comment_support = comment_support - 1 WHERE pk_bookpost_comment_id=comment_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpCommentByCommentIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpCommentByCommentIDUserID_Select`(IN `comment_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_BOOKPOST_COMMENT_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_bpc_sup_record_bpc_id = comment_id AND t.fk_bpc_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpCommentReplyByReplyIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpCommentReplyByReplyIDUserID_InsertOrDelete`(IN `reply_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_BOOKPOST_COMMENT_REPLY_SUP_RECORD
    WHERE T_BOOKPOST_COMMENT_REPLY_SUP_RECORD.fk_bpcr_sup_record_user_id = user_id AND T_BOOKPOST_COMMENT_REPLY_SUP_RECORD.fk_bpcr_sup_record_bpcr_id = reply_id
);

IF is_exist=0 THEN
    INSERT INTO T_BOOKPOST_COMMENT_REPLY_SUP_RECORD(support_record_time , support_record_usable , fk_bpcr_sup_record_user_id , fk_bpcr_sup_record_bpcr_id) VALUES (CURRENT_TIMESTAMP, '1', user_id, reply_id);
    UPDATE T_BOOKPOST_COMMENT_REPLY SET reply_support = reply_support + 1 WHERE pk_reply_id=reply_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
  UPDATE T_BOOKPOST_COMMENT_REPLY_SUP_RECORD SET support_record_usable=1 WHERE fk_bpcr_sup_record_user_id = user_id AND fk_bpcr_sup_record_bpcr_id = reply_id;
    UPDATE T_BOOKPOST_COMMENT_REPLY SET reply_support = reply_support + 1 WHERE pk_reply_id=reply_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
    UPDATE T_BOOKPOST_COMMENT_REPLY_SUP_RECORD SET support_record_usable=0 WHERE fk_bpcr_sup_record_user_id = user_id AND fk_bpcr_sup_record_bpcr_id = reply_id;
    UPDATE T_BOOKPOST_COMMENT_REPLY SET reply_support = reply_support - 1 WHERE pk_reply_id=reply_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportBpCommentReplyByReplyIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportBpCommentReplyByReplyIDUserID_Select`(IN `reply_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_BOOKPOST_COMMENT_REPLY_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_bpcr_sup_record_bpcr_id = reply_id AND t.fk_bpcr_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportCoupletByCoupletIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportCoupletByCoupletIDUserID_InsertOrDelete`(IN `couplet_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_COUPLET_SUP_RECORD csr
    WHERE csr.fk_couplet_sup_record_couplet_id = couplet_id AND csr.fk_couplet_sup_record_user_id = user_id
);

IF is_exist = 0 THEN
	INSERT INTO T_COUPLET_SUP_RECORD(support_record_time, fk_couplet_sup_record_couplet_id, fk_couplet_sup_record_user_id)
	VALUES (CURRENT_TIMESTAMP, couplet_id, user_id);
    UPDATE T_COUPLET SET T_COUPLET.couplet_support = T_COUPLET.couplet_support + 1 WHERE T_COUPLET.pk_couplet_id = couplet_id;
END IF;
IF is_exist = 1 AND curr_supported=0 THEN
	UPDATE T_COUPLET_SUP_RECORD csr SET csr.support_record_usable = 1 WHERE csr.fk_couplet_sup_record_couplet_id = couplet_id AND csr.fk_couplet_sup_record_user_id = user_id;
    UPDATE T_COUPLET SET T_COUPLET.couplet_support = T_COUPLET.couplet_support + 1 WHERE T_COUPLET.pk_couplet_id = couplet_id;
END IF;
IF is_exist = 1 AND curr_supported = 1 THEN
	UPDATE T_COUPLET_SUP_RECORD csr SET csr.support_record_usable = 0 WHERE  csr.fk_couplet_sup_record_couplet_id=couplet_id AND csr.fk_couplet_sup_record_user_id = user_id;
    UPDATE T_COUPLET SET T_COUPLET.couplet_support = T_COUPLET.couplet_support - 1 WHERE T_COUPLET.pk_couplet_id = couplet_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportCoupletByCoupletIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportCoupletByCoupletIDUserID_Select`(IN `couplet_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_COUPLET_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_couplet_sup_record_couplet_id = couplet_id AND t.fk_couplet_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportCoupletReplyByReplyIDUserID_InsertOrDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportCoupletReplyByReplyIDUserID_InsertOrDelete`(IN `reply_id` INT, IN `user_id` INT, IN `curr_supported` INT)
    NO SQL
BEGIN
DECLARE is_exist INT DEFAULT 0;
SET is_exist = (
    SELECT COUNT(*)
    FROM T_COUPLET_REPLY_SUP_RECORD
    WHERE fk_cr_sup_record_cr_id=reply_id AND fk_cr_sup_record_user_id=user_id
);

IF is_exist=0 THEN
	INSERT INTO T_COUPLET_REPLY_SUP_RECORD(support_record_time, fk_cr_sup_record_cr_id, fk_cr_sup_record_user_id) VALUES (CURRENT_TIMESTAMP, reply_id, user_id);
    UPDATE T_COUPLET_REPLY SET reply_support = reply_support + 1 WHERE pk_couplet_reply_id = reply_id;
END IF;
IF is_exist=1 AND curr_supported=0 THEN
	UPDATE T_COUPLET_REPLY_SUP_RECORD SET support_record_usable=1 WHERE fk_cr_sup_record_cr_id = reply_id AND fk_cr_sup_record_user_id = user_id;
	UPDATE T_COUPLET_REPLY SET reply_support = reply_support + 1 WHERE pk_couplet_reply_id = reply_id;
END IF;
IF is_exist=1 AND curr_supported=1 THEN
	UPDATE T_COUPLET_REPLY_SUP_RECORD SET support_record_usable=0 WHERE fk_cr_sup_record_cr_id = reply_id AND fk_cr_sup_record_user_id = user_id;
	UPDATE T_COUPLET_REPLY SET reply_support = reply_support - 1 WHERE pk_couplet_reply_id = reply_id;
END IF;
SELECT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_UserSupportCoupletReplyByReplyIDUserID_Select` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_UserSupportCoupletReplyByReplyIDUserID_Select`(IN `reply_id` INT, IN `user_id` INT)
    NO SQL
SELECT *
FROM T_COUPLET_REPLY_SUP_RECORD t
WHERE t.support_record_usable = 1 AND t.fk_cr_sup_record_cr_id = reply_id AND t.fk_cr_sup_record_user_id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Z_QuestionReplaceNew_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Z_QuestionReplaceNew_Update`(IN `pageCount` INT)
    NO SQL
BEGIN
DECLARE readyStateId INT;
DECLARE workingStateId INT;
DECLARE endStateId INT;
DECLARE readyCount INT DEFAULT 0;

SET readyStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=1
    LIMIT 0,1
);
SET workingStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=2
    LIMIT 0,1
);
SET endStateId = (
    SELECT T_STATE.pk_state_id
    FROM T_STATE
    WHERE state_type='Question' AND state_value=3
    LIMIT 0,1
);
SET readyCount = (
    SELECT COUNT(*)
    FROM T_QUESTION
    WHERE question_usable=1 AND fk_question_state_id=readyStateId
);

IF readyCount >= pageCount THEN
UPDATE T_QUESTION SET fk_question_state_id=endStateId WHERE fk_question_state_id=workingStateId;

UPDATE T_QUESTION q, (
    SELECT *
    FROM T_QUESTION
    WHERE question_usable=1 AND fk_question_state_id=readyStateId
   	ORDER BY question_time DESC
    LIMIT 0,pageCount
)temp SET q.fk_question_state_id=workingStateId WHERE q.pk_question_id=temp.pk_question_id;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_Z_ThesisReplaceNew_Update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_Z_ThesisReplaceNew_Update`()
    NO SQL
BEGIN

DECLARE currThesisId int;
DECLARE nextThesisId int;
DECLARE readyStateId int;
DECLARE workingStateId int;
DECLARE endStateId int;

SET readyStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=1
);
SET workingStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=2
);
SET endStateId = (
	SELECT T_STATE.pk_state_id
	FROM T_STATE
	WHERE T_STATE.state_usable=1 AND T_STATE.state_type='Thesis' AND T_STATE.state_value=3
);

SET currThesisId = (
    SELECT T_THESIS.pk_thesis_id
    FROM T_THESIS
	WHERE T_THESIS.thesis_usable=1 AND T_THESIS.fk_thesis_state_id = workingStateId
    LIMIT 0,1
);
SET nextThesisId =(
    SELECT T_THESIS.pk_thesis_id
    FROM T_THESIS
	WHERE T_THESIS.pk_thesis_id > currThesisId AND T_THESIS.fk_thesis_state_id = readyStateId
    ORDER BY T_THESIS.thesis_time ASC
    LIMIT 0,1
);

UPDATE T_THESIS 
SET fk_thesis_state_id=endStateId, thesis_end_time=CURRENT_TIMESTAMP
WHERE pk_thesis_id=currThesisId;

UPDATE T_THESIS 
SET fk_thesis_state_id=workingStateId, thesis_start_time=CURRENT_TIMESTAMP
WHERE pk_thesis_id=nextThesisId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-12 17:54:42
