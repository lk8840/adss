-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: 10.3.240.21    Database: named
-- ------------------------------------------------------
-- Server version	5.5.27-log

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
-- Temporary table structure for view `aaa`
--

DROP TABLE IF EXISTS `aaa`;
/*!50001 DROP VIEW IF EXISTS `aaa`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `aaa` (
  `id` int(10) unsigned,
  `zone` varchar(255),
  `ttl` int(11),
  `type` enum('SOA','NS','MX','A','CNAME','TXT','HINFO','PTR'),
  `host` varchar(255),
  `view` char(20),
  `mx_priority` int(11),
  `data` varchar(255),
  `primary_ns` varchar(255),
  `resp_contact` varchar(255),
  `serial` bigint(20),
  `refresh` int(11),
  `retry` int(11),
  `expire` int(11),
  `minimum` int(11)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dns_records`
--

DROP TABLE IF EXISTS `dns_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_records` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL DEFAULT '',
  `ttl` int(11) NOT NULL DEFAULT '86400',
  `type` enum('SOA','NS','MX','A','CNAME','TXT','HINFO','PTR') NOT NULL DEFAULT 'SOA',
  `host` varchar(255) NOT NULL DEFAULT '@',
  `view` char(20) DEFAULT 'DF',
  `mx_priority` int(11) NOT NULL DEFAULT '0',
  `data` varchar(255) NOT NULL DEFAULT '',
  `primary_ns` varchar(255) NOT NULL DEFAULT '',
  `resp_contact` varchar(255) NOT NULL DEFAULT '',
  `serial` bigint(20) NOT NULL DEFAULT '0',
  `refresh` int(11) NOT NULL DEFAULT '0',
  `retry` int(11) NOT NULL DEFAULT '0',
  `expire` int(11) NOT NULL DEFAULT '0',
  `minimum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `host` (`host`),
  KEY `zone` (`zone`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns_records`
--

LOCK TABLES `dns_records` WRITE;
/*!40000 ALTER TABLE `dns_records` DISABLE KEYS */;
INSERT INTO `dns_records` VALUES (1,'example.com',86400,'SOA','@','DF',0,'','ns1.example.com.','info.example.com.',2011043001,10800,7200,604800,86400),(2,'example.com',86400,'NS','@','DF',0,'ns1.example.com.','','',0,0,0,0,0),(3,'example.com',86400,'MX','@','DF',10,'mail.example.com.','','',0,0,0,0,0),(4,'example.com',86400,'A','@','DF',0,'10.3.240.100','','',0,0,0,0,0),(5,'example.com',86400,'CNAME','www','DF',0,'@','','',0,0,0,0,0),(6,'example.com',86400,'A','ns1','DF',0,'10.3.240.100','','',0,0,0,0,0),(7,'example.com',86400,'A','mail','DF',0,'10.3.240.100','','',0,0,0,0,0),(8,'example.com',86400,'TXT','@','DF',0,'v=spf1 ip:10.3.240.100 ~all','','',0,0,0,0,0);
/*!40000 ALTER TABLE `dns_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `test`
--

DROP TABLE IF EXISTS `test`;
/*!50001 DROP VIEW IF EXISTS `test`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `test` (
  `zone` int(0)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` varchar(30) NOT NULL,
  `passwd` varchar(80) NOT NULL DEFAULT '',
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL DEFAULT '0',
  `homedir` varchar(255) NOT NULL DEFAULT '',
  `shell` varchar(255) NOT NULL DEFAULT '',
  `last_accessed` datetime NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `userid` (`userid`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xfr`
--

DROP TABLE IF EXISTS `xfr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xfr` (
  `zone` varchar(255) NOT NULL,
  `client` varchar(255) NOT NULL,
  `view` char(20) DEFAULT 'DF',
  KEY `zone` (`zone`),
  KEY `client` (`client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xfr`
--

LOCK TABLES `xfr` WRITE;
/*!40000 ALTER TABLE `xfr` DISABLE KEYS */;
/*!40000 ALTER TABLE `xfr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `aaa`
--

/*!50001 DROP TABLE IF EXISTS `aaa`*/;
/*!50001 DROP VIEW IF EXISTS `aaa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`named`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `aaa` AS select `dns_records`.`id` AS `id`,`dns_records`.`zone` AS `zone`,`dns_records`.`ttl` AS `ttl`,`dns_records`.`type` AS `type`,`dns_records`.`host` AS `host`,`dns_records`.`view` AS `view`,`dns_records`.`mx_priority` AS `mx_priority`,`dns_records`.`data` AS `data`,`dns_records`.`primary_ns` AS `primary_ns`,`dns_records`.`resp_contact` AS `resp_contact`,`dns_records`.`serial` AS `serial`,`dns_records`.`refresh` AS `refresh`,`dns_records`.`retry` AS `retry`,`dns_records`.`expire` AS `expire`,`dns_records`.`minimum` AS `minimum` from `dns_records` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `test`
--

/*!50001 DROP TABLE IF EXISTS `test`*/;
/*!50001 DROP VIEW IF EXISTS `test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`named`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `test` AS select (case when (`dns_records`.`zone` = 'example.com') then (`dns_records`.`zone` = 'example.com') else (`dns_records`.`zone` = '1') end) AS `zone` from `dns_records` where (`dns_records`.`zone` = 'example.com') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-14 12:03:13
