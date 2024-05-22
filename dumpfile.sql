-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5559 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(6,'hongildong','hello@naver2.com',NULL,NULL,23,NULL,'user','2024-05-17',NULL,2),
(9,'홍길동','ddc@naver.com',NULL,NULL,20,NULL,'user','2024-05-17',NULL,0),
(10,'홍길동','dde@naver.com',NULL,NULL,19,NULL,'user','2024-05-17',NULL,0),
(11,'홍길동','ffff@naver.com',NULL,NULL,18,NULL,'user','2024-05-17',NULL,0),
(12,NULL,'dddgq@naver.com',NULL,NULL,21,NULL,'user','2024-05-17',NULL,0),
(14,'test14','test@test.com',NULL,NULL,22,NULL,'user','2024-05-17',NULL,0),
(15,'test15','test15@test.com',NULL,NULL,23,NULL,'admin','2024-05-17',NULL,0),
(16,'test16','test16@test.com',NULL,NULL,24,NULL,'admin','2024-05-17',NULL,0),
(17,NULL,'hello@va.cm',NULL,NULL,25,NULL,'user','1999-04-21',NULL,0),
(18,NULL,'hello11@dd.com',NULL,NULL,26,NULL,'user',NULL,'2000-12-01 12:00:00',0),
(5555,'hongildong','hello@naver.com',NULL,NULL,25,NULL,'user','2024-05-17',NULL,0),
(5558,'kim','kim@naver.com',NULL,NULL,24,NULL,'user',NULL,NULL,0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'제목1','내용1',5555,1000.000,NULL,'56bfd64d-141f-11ef-a28f-50eb7160449b'),
(2,'hello','내용3',5555,1000.000,NULL,'56bfd7e1-141f-11ef-a28f-50eb7160449b'),
(5,'hello java',NULL,5555,1234.100,NULL,'56bfd93a-141f-11ef-a28f-50eb7160449b'),
(6,'제목',NULL,NULL,2000.000,'2023-05-17 12:00:00','56bfd97a-141f-11ef-a28f-50eb7160449b'),
(8,'제목8',NULL,NULL,3000.000,'2022-05-17 12:33:30','56bfd9dc-141f-11ef-a28f-50eb7160449b'),
(9,'제목143','내용4324',NULL,4000.000,'2024-05-17 16:15:33','56bfda09-141f-11ef-a28f-50eb7160449b'),
(10,'hello world java',NULL,6,3000.000,'2024-05-20 12:37:11','42c34869-165a-11ef-bc77-50eb7160449b'),
(11,'ERAWE','2231',5555,2000.000,'2024-05-20 14:27:51','b87c807d-1669-11ef-bc77-50eb7160449b'),
(13,'hello world java',NULL,5555,0.000,'2024-05-20 14:36:25','eaf3ac73-166a-11ef-bc77-50eb7160449b');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:24:17
