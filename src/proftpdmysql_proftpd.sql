-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: 10.3.240.21    Database: proftpd
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
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupname` varchar(30) NOT NULL,
  `gid` int(11) NOT NULL,
  `members` varchar(255) DEFAULT NULL,
  KEY `groups_gid_idx` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES ('basegroup',2001,'pub');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_history`
--

DROP TABLE IF EXISTS `login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_history` (
  `userid` varchar(30) NOT NULL,
  `client_ip` varchar(15) NOT NULL,
  `server_ip` varchar(15) NOT NULL,
  `protocol` varchar(30) NOT NULL,
  `login_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_history`
--

LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotalimits`
--

DROP TABLE IF EXISTS `quotalimits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotalimits` (
  `name` varchar(30) DEFAULT NULL,
  `quota_type` enum('user','group','class','all') NOT NULL,
  `per_session` enum('false','true') NOT NULL,
  `limit_type` enum('soft','hard') NOT NULL,
  `bytes_in_avail` float NOT NULL,
  `bytes_out_avail` float NOT NULL,
  `bytes_xfer_avail` float NOT NULL,
  `files_in_avail` int(10) unsigned NOT NULL,
  `files_out_avail` int(10) unsigned NOT NULL,
  `files_xfer_avail` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotalimits`
--

LOCK TABLES `quotalimits` WRITE;
/*!40000 ALTER TABLE `quotalimits` DISABLE KEYS */;
INSERT INTO `quotalimits` VALUES ('pub','user','false','hard',20000000,20000000,0,0,0,0);
/*!40000 ALTER TABLE `quotalimits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotatallies`
--

DROP TABLE IF EXISTS `quotatallies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotatallies` (
  `name` varchar(30) NOT NULL,
  `quota_type` enum('user','group','class','all') NOT NULL,
  `bytes_in_used` float NOT NULL,
  `bytes_out_used` float NOT NULL,
  `bytes_xfer_used` float NOT NULL,
  `files_in_used` int(10) unsigned NOT NULL,
  `files_out_used` int(10) unsigned NOT NULL,
  `files_xfer_used` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotatallies`
--

LOCK TABLES `quotatallies` WRITE;
/*!40000 ALTER TABLE `quotatallies` DISABLE KEYS */;
INSERT INTO `quotatallies` VALUES ('pub','user',0,0,0,0,0,0);
/*!40000 ALTER TABLE `quotatallies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` varchar(30) NOT NULL,
  `passwd` varchar(80) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `homedir` varchar(255) DEFAULT NULL,
  `shell` varchar(255) DEFAULT NULL,
  `last_accessed` datetime DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`),
  UNIQUE KEY `uid` (`uid`),
  KEY `users_userid_idx` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('pub','pub',2001,2001,'/opt/ftp/pub','/sbin/nologin',NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-14 12:02:17
