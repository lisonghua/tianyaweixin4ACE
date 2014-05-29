-- MySQL dump 10.10
--
-- Host: 58.2.219.34    Database: genpact
-- ------------------------------------------------------
-- Server version	5.0.67-log

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
-- Table structure for table `t_common_dic`
--

DROP TABLE IF EXISTS `t_common_dic`;
CREATE TABLE `t_common_dic` (
  `ID` int(11) NOT NULL,
  `CODE` varchar(20) default NULL,
  `VALUE` varchar(100) default NULL,
  `PARENT_ID` int(11) default NULL,
  `REMARK` varchar(200) default NULL,
  `STATUS` varchar(2) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_common_seq`
--

DROP TABLE IF EXISTS `t_common_seq`;
CREATE TABLE `t_common_seq` (
  `id` bigint(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT 'sequence名称',
  `max` bigint(11) NOT NULL default '1' COMMENT '最大id',
  `length` int(2) NOT NULL default '1' COMMENT '生成序列后的长度,以0补全',
  `next` int(2) NOT NULL default '1' COMMENT '增长的长度',
  `rules` varchar(255) default NULL COMMENT '规则以###max_id###做为替换',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `fk_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_field`
--

DROP TABLE IF EXISTS `t_pm_field`;
CREATE TABLE `t_pm_field` (
  `FIELD_ID` int(11) NOT NULL,
  `MODULE_ID` int(11) default NULL,
  `DOM_ID` varchar(50) default NULL,
  `NAME` varchar(50) default NULL,
  `FIELD_TYPE` varchar(2) default NULL,
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`FIELD_ID`),
  KEY `t_pm_field_ibfk_1` (`MODULE_ID`),
  CONSTRAINT `t_pm_field_ibfk_1` FOREIGN KEY (`MODULE_ID`) REFERENCES `t_pm_module` (`MODULE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_function`
--

DROP TABLE IF EXISTS `t_pm_function`;
CREATE TABLE `t_pm_function` (
  `FUNCTION_ID` int(11) NOT NULL,
  `MODULE_ID` int(11) default NULL,
  `FIELD_ID` int(11) default NULL,
  `OPERATION_ID` int(11) default NULL,
  `PRIVILEGE_ID` int(11) default NULL,
  PRIMARY KEY  (`FUNCTION_ID`),
  KEY `MODULE_ID` (`MODULE_ID`),
  KEY `FIELD_ID` (`FIELD_ID`),
  KEY `OPERATION_ID` (`OPERATION_ID`),
  KEY `PRIVILEGE_ID` (`PRIVILEGE_ID`),
  CONSTRAINT `FIELD_ID` FOREIGN KEY (`FIELD_ID`) REFERENCES `t_pm_field` (`FIELD_ID`),
  CONSTRAINT `MODULE_ID` FOREIGN KEY (`MODULE_ID`) REFERENCES `t_pm_module` (`MODULE_ID`),
  CONSTRAINT `OPERATION_ID` FOREIGN KEY (`OPERATION_ID`) REFERENCES `t_pm_operation` (`OPERATION_ID`),
  CONSTRAINT `PRIVILEGE_ID` FOREIGN KEY (`PRIVILEGE_ID`) REFERENCES `t_pm_privilege` (`PRIVILEGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_group`
--

DROP TABLE IF EXISTS `t_pm_group`;
CREATE TABLE `t_pm_group` (
  `GROUP_ID` int(11) NOT NULL,
  `NAME` varchar(50) default NULL,
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_grouprole`
--

DROP TABLE IF EXISTS `t_pm_grouprole`;
CREATE TABLE `t_pm_grouprole` (
  `ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  KEY `GROUP_ID` (`GROUP_ID`),
  CONSTRAINT `t_pm_grouprole_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `t_pm_role` (`ROLE_ID`),
  CONSTRAINT `t_pm_grouprole_ibfk_2` FOREIGN KEY (`GROUP_ID`) REFERENCES `t_pm_group` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_module`
--

DROP TABLE IF EXISTS `t_pm_module`;
CREATE TABLE `t_pm_module` (
  `MODULE_ID` int(11) NOT NULL,
  `NAME` varchar(50) default NULL,
  `PARENT_ID` int(11) default NULL,
  `PATH` varchar(200) default NULL,
  `SYS_MODULE` varchar(2) default NULL,
  `PRIVILEGE_MODULE` varchar(2) default NULL,
  `INDEX_PAGE` varchar(200) default NULL,
  `ORDER_NUM` int(11) default NULL,
  `MODULE_STATUS` varchar(2) default NULL,
  `IS_LEAF` varchar(2) default NULL,
  `REMARK` varchar(500) default NULL,
  PRIMARY KEY  (`MODULE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_operation`
--

DROP TABLE IF EXISTS `t_pm_operation`;
CREATE TABLE `t_pm_operation` (
  `OPERATION_ID` int(11) NOT NULL,
  `NAME` varchar(50) default NULL,
  `SIGN` int(11) default NULL,
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`OPERATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_organization`
--

DROP TABLE IF EXISTS `t_pm_organization`;
CREATE TABLE `t_pm_organization` (
  `ORG_ID` int(11) NOT NULL,
  `NAME` varchar(100) default NULL,
  `ORG_CODE` varchar(50) default NULL,
  `PARENT_ID` int(11) default NULL,
  `ORG_TYPE` varchar(2) default NULL,
  `ORG_STATUS` varchar(2) default NULL,
  `REMARK` varchar(200) default NULL,
  `IS_LEAF` varchar(2) default NULL,
  PRIMARY KEY  (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_privilege`
--

DROP TABLE IF EXISTS `t_pm_privilege`;
CREATE TABLE `t_pm_privilege` (
  `PRIVILEGE_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) default NULL,
  `USER_ID` int(11) default NULL,
  `TYPE` varchar(2) default NULL,
  PRIMARY KEY  (`PRIVILEGE_ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `ROLE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `t_pm_role` (`ROLE_ID`),
  CONSTRAINT `t_pm_privilege_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `t_pm_user` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_role`
--

DROP TABLE IF EXISTS `t_pm_role`;
CREATE TABLE `t_pm_role` (
  `ROLE_ID` int(11) NOT NULL,
  `NAME` varchar(50) default NULL,
  `ROLE_STATUS` varchar(2) default NULL,
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_user`
--

DROP TABLE IF EXISTS `t_pm_user`;
CREATE TABLE `t_pm_user` (
  `USER_ID` int(11) NOT NULL,
  `ORG_ID` int(11) default NULL,
  `SSO` varchar(20) default NULL,
  `NAME` varchar(50) default NULL,
  `AGE` varchar(2) default NULL,
  `GENDER` varchar(2) default NULL,
  `NATIONALITY` varchar(20) default NULL,
  `PROVINCE` varchar(20) default NULL,
  `CITY` varchar(20) default NULL,
  `FOLK` varchar(20) default NULL,
  `TELEPHONE` varchar(20) default NULL,
  `CELLPHONE` varchar(20) default NULL,
  `FAX` varchar(20) default NULL,
  `EMAIL` varchar(100) default NULL,
  `ADDRESS` varchar(100) default NULL,
  `MSN` varchar(50) default NULL,
  `QQ` varchar(20) default NULL,
  `PW` varchar(200) default NULL COMMENT 'password',
  `USER_STATUS` varchar(2) default '1',
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`USER_ID`),
  KEY `t_pm_user_ibfk_1` (`ORG_ID`),
  CONSTRAINT `t_pm_user_ibfk_1` FOREIGN KEY (`ORG_ID`) REFERENCES `t_pm_organization` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_usergroup`
--

DROP TABLE IF EXISTS `t_pm_usergroup`;
CREATE TABLE `t_pm_usergroup` (
  `ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `GROUP_ID` (`GROUP_ID`),
  CONSTRAINT `t_pm_usergroup_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `t_pm_user` (`USER_ID`),
  CONSTRAINT `t_pm_usergroup_ibfk_2` FOREIGN KEY (`GROUP_ID`) REFERENCES `t_pm_group` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_pm_userrole`
--

DROP TABLE IF EXISTS `t_pm_userrole`;
CREATE TABLE `t_pm_userrole` (
  `ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  CONSTRAINT `t_pm_userrole_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `t_pm_user` (`USER_ID`),
  CONSTRAINT `t_pm_userrole_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `t_pm_role` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_sm_connectionpool`
--

DROP TABLE IF EXISTS `t_sm_connectionpool`;
CREATE TABLE `t_sm_connectionpool` (
  `CONNECTIONPOOL_ID` int(11) NOT NULL,
  `NAME` varchar(50) default NULL,
  `JNDI_NAME` varchar(50) NOT NULL,
  `SERVICE_NAME` varchar(100) default NULL,
  `REMARK` varchar(200) default NULL,
  `SERVER_ID` int(11) NOT NULL,
  PRIMARY KEY  (`CONNECTIONPOOL_ID`),
  KEY `SERVER_ID` (`SERVER_ID`),
  CONSTRAINT `t_sm_connectionpool_ibfk_1` FOREIGN KEY (`SERVER_ID`) REFERENCES `t_sm_server` (`SERVER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_sm_datasource`
--

DROP TABLE IF EXISTS `t_sm_datasource`;
CREATE TABLE `t_sm_datasource` (
  `DS_ID` int(11) NOT NULL,
  `URL` varchar(500) NOT NULL,
  `DRIVER_CLASS` varchar(200) NOT NULL,
  `USER_NAME` varchar(20) NOT NULL,
  `PASSWORD` varchar(20) NOT NULL,
  `INITIAL_SIZE` varchar(10) default NULL,
  `MAX_SIZE` varchar(10) default NULL,
  `MINI_SIZE` varchar(10) default NULL,
  PRIMARY KEY  (`DS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_sm_log`
--

DROP TABLE IF EXISTS `t_sm_log`;
CREATE TABLE `t_sm_log` (
  `APP_NAME` varchar(100) default NULL,
  `SESSION_ID` varchar(100) default NULL,
  `IP` varchar(100) default NULL,
  `PORT` varchar(20) default NULL,
  `TIME_STAMP` varchar(50) default NULL,
  `OPERATION` varchar(100) default NULL,
  `CLASS` varchar(200) default NULL,
  `METHOD` varchar(100) default NULL,
  `LOG_LEVEL` varchar(20) default NULL,
  `MESSAGE` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `t_sm_server`
--

DROP TABLE IF EXISTS `t_sm_server`;
CREATE TABLE `t_sm_server` (
  `SERVER_ID` int(11) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `IP` varchar(20) NOT NULL,
  `PORT` varchar(20) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  `VERSION` varchar(20) default NULL,
  `REMARK` varchar(200) default NULL,
  PRIMARY KEY  (`SERVER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-04  2:24:51
