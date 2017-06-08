-- MySQL dump 10.13  Distrib 5.7.16, for osx10.12 (x86_64)
--
-- Host: 59.110.13.121    Database: gsp_db
-- ------------------------------------------------------
-- Server version	5.6.34

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
-- Table structure for table `act_evt_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_evt_log`
--

/*!40000 ALTER TABLE `act_evt_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_evt_log` ENABLE KEYS */;

--
-- Table structure for table `act_ge_bytearray`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;

--
-- Table structure for table `act_ge_property`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;

--
-- Table structure for table `act_hi_actinst`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `act_idx_hi_act_inst_end` (`END_TIME_`),
  KEY `act_idx_hi_act_inst_exec` (`EXECUTION_ID_`,`ACT_ID_`),
  KEY `act_idx_hi_act_inst_procinst` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `act_idx_hi_act_inst_start` (`START_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;

--
-- Table structure for table `act_hi_attachment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;

--
-- Table structure for table `act_hi_comment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;

--
-- Table structure for table `act_hi_detail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `act_idx_hi_detail_act_inst` (`ACT_INST_ID_`),
  KEY `act_idx_hi_detail_name` (`NAME_`),
  KEY `act_idx_hi_detail_proc_inst` (`PROC_INST_ID_`),
  KEY `act_idx_hi_detail_task_id` (`TASK_ID_`),
  KEY `act_idx_hi_detail_time` (`TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;

--
-- Table structure for table `act_hi_identitylink`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `act_idx_hi_ident_lnk_procinst` (`PROC_INST_ID_`),
  KEY `act_idx_hi_ident_lnk_task` (`TASK_ID_`),
  KEY `act_idx_hi_ident_lnk_user` (`USER_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;

--
-- Table structure for table `act_hi_procinst`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `act_idx_hi_pro_i_buskey` (`BUSINESS_KEY_`),
  KEY `act_idx_hi_pro_inst_end` (`END_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;

--
-- Table structure for table `act_hi_taskinst`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_TASK_INST_ASSIGNEE` (`ASSIGNEE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;

--
-- Table structure for table `act_hi_varinst`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `act_idx_hi_procvar_name_type` (`NAME_`,`VAR_TYPE_`),
  KEY `act_idx_hi_procvar_proc_inst` (`PROC_INST_ID_`),
  KEY `act_idx_hi_procvar_task_id` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;

--
-- Table structure for table `act_id_group`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;

--
-- Table structure for table `act_id_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;

--
-- Table structure for table `act_id_membership`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;

--
-- Table structure for table `act_id_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;

--
-- Table structure for table `act_procdef_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_procdef_info`
--

/*!40000 ALTER TABLE `act_procdef_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_procdef_info` ENABLE KEYS */;

--
-- Table structure for table `act_re_deployment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;

--
-- Table structure for table `act_re_model`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_model`
--

/*!40000 ALTER TABLE `act_re_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_model` ENABLE KEYS */;

--
-- Table structure for table `act_re_procdef`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(3) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(3) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;

--
-- Table structure for table `act_ru_event_subscr`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  KEY `act_idx_event_subscr_config_` (`CONFIGURATION_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;

--
-- Table structure for table `act_ru_execution`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(3) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(3) DEFAULT NULL,
  `IS_SCOPE_` tinyint(3) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(3) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `act_idx_exec_buskey` (`BUSINESS_KEY_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;

--
-- Table structure for table `act_ru_identitylink`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `act_idx_ident_lnk_group` (`GROUP_ID_`),
  KEY `act_idx_ident_lnk_user` (`USER_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;

--
-- Table structure for table `act_ru_job`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` bit(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;

--
-- Table structure for table `act_ru_task`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `act_idx_task_create` (`CREATE_TIME_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;

--
-- Table structure for table `act_ru_variable`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `act_idx_variable_task_id` (`TASK_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;

--
-- Table structure for table `child`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `child` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证/备案凭证编号',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名字',
  `type_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `child`
--

/*!40000 ALTER TABLE `child` DISABLE KEYS */;
/*!40000 ALTER TABLE `child` ENABLE KEYS */;

--
-- Table structure for table `cms_article`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_article` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `link` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章链接',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章图片',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述、摘要',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `posid` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '推荐位，多选',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_article_category_id` (`category_id`),
  KEY `cms_article_create_by` (`create_by`),
  KEY `cms_article_del_flag` (`del_flag`),
  KEY `cms_article_keywords` (`keywords`),
  KEY `cms_article_title` (`title`),
  KEY `cms_article_update_date` (`update_date`),
  KEY `cms_article_weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_article`
--

/*!40000 ALTER TABLE `cms_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_article` ENABLE KEYS */;

--
-- Table structure for table `cms_article_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_article_data` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `content` text COLLATE utf8_bin COMMENT '文章内容',
  `copyfrom` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章来源',
  `relation` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '相关文章',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_article_data`
--

/*!40000 ALTER TABLE `cms_article_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_article_data` ENABLE KEYS */;

--
-- Table structure for table `cms_category`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_category` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `site_id` varchar(64) COLLATE utf8_bin DEFAULT '1' COMMENT '站点编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `module` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目模块',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '栏目名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在导航中显示',
  `in_list` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在分类页中显示列表',
  `show_modes` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '展现方式',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否需要审核',
  `custom_list_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义列表视图',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_category_del_flag` (`del_flag`),
  KEY `cms_category_module` (`module`),
  KEY `cms_category_name` (`name`),
  KEY `cms_category_office_id` (`office_id`),
  KEY `cms_category_parent_id` (`parent_id`),
  KEY `cms_category_site_id` (`site_id`),
  KEY `cms_category_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_category`
--

/*!40000 ALTER TABLE `cms_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_category` ENABLE KEYS */;

--
-- Table structure for table `cms_comment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_comment` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `content_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目内容的编号',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目内容的标题',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '评论内容',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论姓名',
  `ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论IP',
  `create_date` datetime NOT NULL COMMENT '评论时间',
  `audit_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_comment_category_id` (`category_id`),
  KEY `cms_comment_content_id` (`content_id`),
  KEY `cms_comment_status` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_comment`
--

/*!40000 ALTER TABLE `cms_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_comment` ENABLE KEYS */;

--
-- Table structure for table `cms_guestbook`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_guestbook` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '留言分类',
  `content` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '留言内容',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `phone` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '电话',
  `workunit` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '单位',
  `ip` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '留言时间',
  `re_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '回复人',
  `re_date` datetime DEFAULT NULL COMMENT '回复时间',
  `re_content` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '回复内容',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_guestbook_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_guestbook`
--

/*!40000 ALTER TABLE `cms_guestbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_guestbook` ENABLE KEYS */;

--
-- Table structure for table `cms_link`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_link` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '链接名称',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接地址',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_link_category_id` (`category_id`),
  KEY `cms_link_create_by` (`create_by`),
  KEY `cms_link_del_flag` (`del_flag`),
  KEY `cms_link_title` (`title`),
  KEY `cms_link_update_date` (`update_date`),
  KEY `cms_link_weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_link`
--

/*!40000 ALTER TABLE `cms_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_link` ENABLE KEYS */;

--
-- Table structure for table `cms_site`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_site` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点名称',
  `title` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点标题',
  `logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点Logo',
  `domain` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点域名',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `theme` varchar(255) COLLATE utf8_bin DEFAULT 'default' COMMENT '主题',
  `copyright` text COLLATE utf8_bin COMMENT '版权信息',
  `custom_index_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义站点首页视图',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_site_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_site`
--

/*!40000 ALTER TABLE `cms_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_site` ENABLE KEYS */;

--
-- Table structure for table `gen_scheme`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_scheme` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成表编号',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_scheme`
--

/*!40000 ALTER TABLE `gen_scheme` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_scheme` ENABLE KEYS */;

--
-- Table structure for table `gen_table`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表外键',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_del_flag` (`del_flag`),
  KEY `gen_table_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;

--
-- Table structure for table `gen_table_column`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `group_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '标签名',
  `group_priority` int(11) DEFAULT NULL COMMENT '标签优先级',
  PRIMARY KEY (`id`),
  KEY `gen_table_column_del_flag` (`del_flag`),
  KEY `gen_table_column_name` (`name`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_table_id` (`gen_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

--
-- Table structure for table `gen_template`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_template` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件名',
  `content` text COLLATE utf8_bin COMMENT '内容',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_template_del_falg` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_template`
--

/*!40000 ALTER TABLE `gen_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_template` ENABLE KEYS */;

--
-- Table structure for table `oa_leave`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_leave` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `process_instance_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例编号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `leave_type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '请假类型',
  `reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请假理由',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `reality_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `reality_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_leave_create_by` (`create_by`),
  KEY `oa_leave_del_flag` (`del_flag`),
  KEY `oa_leave_process_instance_id` (`process_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_leave`
--

/*!40000 ALTER TABLE `oa_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_leave` ENABLE KEYS */;

--
-- Table structure for table `oa_notify`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_notify` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `title` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `status` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_notify`
--

/*!40000 ALTER TABLE `oa_notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_notify` ENABLE KEYS */;

--
-- Table structure for table `oa_notify_record`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_notify_record` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `oa_notify_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`),
  KEY `oa_notify_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_notify_record`
--

/*!40000 ALTER TABLE `oa_notify_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_notify_record` ENABLE KEYS */;

--
-- Table structure for table `oa_test_audit`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_test_audit` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `PROC_INS_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `USER_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '变动用户',
  `OFFICE_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `POST` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '岗位',
  `AGE` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `EDU` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '学历',
  `CONTENT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整原因',
  `OLDA` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 薪酬档级',
  `OLDB` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 月工资额',
  `OLDC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 年薪总额',
  `NEWA` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 薪酬档级',
  `NEWB` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 月工资额',
  `NEWC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 年薪总额',
  `ADD_NUM` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '月增资',
  `EXE_DATE` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '执行时间',
  `HR_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '人力资源部门意见',
  `LEAD_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分管领导意见',
  `MAIN_LEAD_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '集团主要领导意见',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_test_audit_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_test_audit`
--

/*!40000 ALTER TABLE `oa_test_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_test_audit` ENABLE KEYS */;

--
-- Table structure for table `people`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `people` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证/备案凭证编号',
  `type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

/*!40000 ALTER TABLE `people` DISABLE KEYS */;
/*!40000 ALTER TABLE `people` ENABLE KEYS */;

--
-- Table structure for table `sys_alarm`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_alarm` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `tbl_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联表',
  `record_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联表_记录id',
  `judg_method` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '判断方式',
  `warn_level` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '预警级别',
  `warn_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '预警内容',
  `warn_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '预警类型',
  `warn_status` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '预警状态',
  `to_time` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_alarm`
--

/*!40000 ALTER TABLE `sys_alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_alarm` ENABLE KEYS */;

--
-- Table structure for table `sys_area`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_area` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_del_flag` (`del_flag`),
  KEY `sys_area_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_area`
--

/*!40000 ALTER TABLE `sys_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_area` ENABLE KEYS */;

--
-- Table structure for table `sys_chan_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_chan_info` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `chan_tbl` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更表',
  `chan_col` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更表_字段',
  `chan_orig_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更表_原记录id',
  `chan_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更表_记录id',
  `chan_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更类型',
  `orgi_value` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '原值',
  `chan_value` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更值',
  `chan_reason` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_chan_info`
--

/*!40000 ALTER TABLE `sys_chan_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_chan_info` ENABLE KEYS */;

--
-- Table structure for table `sys_dict`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) COLLATE utf8_bin DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_del_flag` (`del_flag`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;

--
-- Table structure for table `sys_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `params` text COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text COLLATE utf8_bin COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_create_date` (`create_date`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;

--
-- Table structure for table `sys_mdict`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_mdict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_del_flag` (`del_flag`),
  KEY `sys_mdict_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_mdict`
--

/*!40000 ALTER TABLE `sys_mdict` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_mdict` ENABLE KEYS */;

--
-- Table structure for table `sys_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `is_show` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_del_flag` (`del_flag`),
  KEY `sys_menu_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;

--
-- Table structure for table `sys_office`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_office` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属区域',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构类型',
  `grade` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构等级',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '传真',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_office`
--

/*!40000 ALTER TABLE `sys_office` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_office` ENABLE KEYS */;

--
-- Table structure for table `sys_role`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `enname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '数据范围',
  `is_sys` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `sys_role_enname` (`enname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;

--
-- Table structure for table `sys_role_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;

--
-- Table structure for table `sys_role_office`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_office`
--

/*!40000 ALTER TABLE `sys_role_office` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_office` ENABLE KEYS */;

--
-- Table structure for table `sys_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `company_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `user_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_del_flag` (`del_flag`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_update_date` (`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;

--
-- Table structure for table `sys_user_notice`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_notice` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `notice_title` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '消息标题',
  `notice_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '消息类型',
  `content` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '消息内容',
  `notice_status` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '消息状态',
  `push_user` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '推送对象',
  `attach` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_notice`
--

/*!40000 ALTER TABLE `sys_user_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_notice` ENABLE KEYS */;

--
-- Table structure for table `sys_user_role`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;

--
-- Table structure for table `t01_agreement`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_agreement` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `agre_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '协议编号',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  `spec_model` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '规格型号',
  `regi_cert_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `manu_ente` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产企业',
  `supplier` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者',
  `unit_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单价',
  `amount` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '金额',
  `effe_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生效日期',
  `valid_peri_to` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期至',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_agreement`
--

/*!40000 ALTER TABLE `t01_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_agreement` ENABLE KEYS */;

--
-- Table structure for table `t01_company`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_company` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `comp_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '编号',
  `comp_name_cn` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '企业名称（中文）',
  `comp_name_en` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '企业名称（英文）',
  `abbreviation` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '简称',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `regi_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册号',
  `appr_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '批准日期',
  `valid_peri_to` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期至',
  `busi_scope` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '经营范围',
  `attachment` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_company`
--

/*!40000 ALTER TABLE `t01_company` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_company` ENABLE KEYS */;

--
-- Table structure for table `t01_mate_revi`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_mate_revi` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `comp_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编号',
  `comp_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '企业名称',
  `cert_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '证书编号',
  `cert_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '证书名称',
  `chan_situ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '变更情况',
  `view_qual` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '查看资质',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_mate_revi`
--

/*!40000 ALTER TABLE `t01_mate_revi` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_mate_revi` ENABLE KEYS */;

--
-- Table structure for table `t01_materiel`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_materiel` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料名',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `long_desc` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '长描述',
  `type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `stor_cond` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '储存条件',
  `stor_cond_temp` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '储存条件_温度',
  `stor_cond_humi` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '储存条件_湿度',
  `tran_cond` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件',
  `tran_cond_temp` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件_温度',
  `tran_cond_humi` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件_湿度',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_materiel`
--

/*!40000 ALTER TABLE `t01_materiel` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_materiel` ENABLE KEYS */;

--
-- Table structure for table `t01_prod_cert`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_prod_cert` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(2) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `regi_cert_nbr` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证/备案凭证编号',
  `orig_regi_cert_nbr` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '原注册证/备案凭证编号',
  `risk_class` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '风险分类',
  `tech_cate_cd` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '技术分类代码',
  `appr_date` datetime DEFAULT NULL COMMENT '批准日期',
  `effe_date` datetime DEFAULT NULL COMMENT '生效日期',
  `valid_peri` datetime DEFAULT NULL COMMENT '有效期至',
  `prod_name_cn` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（中文）',
  `prod_name_en` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（英文）',
  `is_import` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '国内/进口',
  `model_spec` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '型号规格',
  `stru_comp` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '结构及组成',
  `main_mnt` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '主要组成成分',
  `expe_usage` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '预期用途',
  `use_scope` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '适用范围',
  `effi_date` int(11) DEFAULT NULL COMMENT '产品有效期（月）',
  `prod_stat` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '产品标准',
  `stor_cond` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '储存条件',
  `tran_cond` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件',
  `regi_pers_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人名称(原文)',
  `regi_pers_name_tran` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人名称(翻译)',
  `regi_pers_addr` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人住所',
  `regi_pers_cont` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人联系方式',
  `produ_addr` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '生产地址',
  `produ_area_cn` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '生产国或地区（中文）',
  `produ_area_en` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '生产国或地区（英文）',
  `produ_fact_cn` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '生产厂商名称（中文）',
  `appr_org` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '审批部门',
  `agent_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人名称',
  `agent_addr` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人住所',
  `agent_cont` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人联系方式',
  `saled_serv_org` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '售后服务机构（进口）',
  `prod_tech_requ` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '产品技术要求',
  `prod_spec` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '产品说明书',
  `others` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '其它内容',
  `cert_type` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '资质类型',
  `cert_stat` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '资质状态',
  `appr_stat` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '审批状态',
  `appr_opin` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '审批意见',
  `explanation` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '说明',
  `attachment` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `regi_cert_nbrs` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号变更历史',
  `isappr` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_prod_cert`
--

/*!40000 ALTER TABLE `t01_prod_cert` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_prod_cert` ENABLE KEYS */;

--
-- Table structure for table `t01_prod_cert_copy`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_prod_cert_copy` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证/备案凭证编号',
  `risk_class` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '风险分类',
  `tech_cate_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '技术分类-名称',
  `date_of_appr` datetime DEFAULT NULL COMMENT '批准日期',
  `valid_peri` datetime DEFAULT NULL COMMENT '有效期至',
  `prod_name_cn` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（中文)',
  `prod_name_orig` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（原文)',
  `model_spec` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '型号规格',
  `stru_and_comp` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '结构及组成',
  `effi_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期',
  `stor_cond` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '储存条件',
  `tran_cond` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件',
  `reg_pers_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人名称',
  `reg_pers_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人住所',
  `reg_pers_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册人/备案人联系方式',
  `prod_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产地址',
  `agent_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人名称',
  `agent_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人住所',
  `agent_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '代理人联系方式',
  `saled_serv_unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '售后服务单位',
  `reg_cert` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证/备案凭证',
  `prod_tech_requ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品技术要求',
  `prod_spec` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品说明书',
  `others` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '其他',
  `qual_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '资质类型',
  `appr_status` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '审批状态',
  `qual_effe` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '资质效力',
  `orig_reg_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '原注册证/备案凭证编号',
  `effe_date` datetime DEFAULT NULL COMMENT '生效日期',
  `appr_opin` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '审批意见',
  `attach` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `regi_cert_nbrs` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `isappr` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_prod_cert_copy`
--

/*!40000 ALTER TABLE `t01_prod_cert_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_prod_cert_copy` ENABLE KEYS */;

--
-- Table structure for table `t01_prod_revi`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t01_prod_revi` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料号',
  `mate_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料名称',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证编号',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t01_prod_revi`
--

/*!40000 ALTER TABLE `t01_prod_revi` DISABLE KEYS */;
/*!40000 ALTER TABLE `t01_prod_revi` ENABLE KEYS */;

--
-- Table structure for table `t02_accept_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_accept_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料编号',
  `prod_name_cn` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称（中文）',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `batch_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产批号',
  `manu_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产日期',
  `disa_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '失效日期',
  `vali_peri` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期',
  `manu_ente` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产企业',
  `supplier` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者',
  `rece_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货数量',
  `acce_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收合格数',
  `check_resu` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收结果',
  `unqu_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不合格数',
  `unqu_hand_meas` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不合格事项及处理措施',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_accept_mate`
--

/*!40000 ALTER TABLE `t02_accept_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_accept_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_acceptance`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_acceptance` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `appr_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收单号',
  `arri_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到货日期',
  `rece_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货单号',
  `veri_temp` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输温度的核实',
  `acce_sign` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收人员签字',
  `acce_pers_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收人员姓名',
  `signature` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '签字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_acceptance`
--

/*!40000 ALTER TABLE `t02_acceptance` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_acceptance` ENABLE KEYS */;

--
-- Table structure for table `t02_check`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_check` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `inventory` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房',
  `time` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '时间',
  `item` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '项目',
  `conclusion` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '结论',
  `hand_meas` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '处理措施',
  `operator` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_check`
--

/*!40000 ALTER TABLE `t02_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_check` ENABLE KEYS */;

--
-- Table structure for table `t02_out_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_out_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `seri_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '序号',
  `mate_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '物料号',
  `describe` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `prod_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `spec_model` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '规格型号',
  `regi_cert_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '注册证号',
  `pro_batch_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '生产批号/序列号',
  `term_of_vali` int(11) DEFAULT NULL COMMENT '有效期',
  `disa_date` date NOT NULL COMMENT '失效日期',
  `out_quan` int(11) NOT NULL COMMENT '出库数量',
  `inventory` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '库房',
  `qual_stat` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '质量状态/区域',
  `location` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '库位',
  `comm_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品编码',
  `comm_bar_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品条码',
  `comm_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品名称',
  `supp_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商编码',
  `unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位',
  `unit_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位含量',
  `count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '数量',
  `batch_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '批次号',
  `no_tax_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税进价',
  `no_tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税金额',
  `comm` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_out_mate`
--

/*!40000 ALTER TABLE `t02_out_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_out_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_purc_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_purc_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料号',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  `spec_model` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '规格型号',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `purc_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购单价',
  `purc_count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购数量',
  `office` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位',
  `amount` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '金额',
  `comm_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品编码',
  `comm_bar_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品条码',
  `conv_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '转换码',
  `supp_comm_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商商品编码',
  `star` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '星级',
  `sell_stock` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '可卖库存',
  `sell_days` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '可卖天数',
  `daily_aver_sales` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '日均销量',
  `quota` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '配额',
  `meas_unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位',
  `unit_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位含量',
  `order_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订货量',
  `purc_surp` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购余量',
  `tran_price_no_tax` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税成交单价',
  `fee` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '扣率',
  `no_tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税金额',
  `tax_tran_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税成交单价',
  `tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税金额',
  `tax_rates` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '税率',
  `tax` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '税额',
  `refe_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '参考进价（单品）',
  `prod_unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单品单位',
  `prod_price_no_tax` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单品不含税单价',
  `stan_box_coef` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '标准箱系数',
  `stan_box_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '标准箱数量',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `outer_box_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '外箱含量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_purc_mate`
--

/*!40000 ALTER TABLE `t02_purc_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_purc_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_purchase`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_purchase` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `purc_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购编号',
  `purc_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购日期',
  `supp_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者名称',
  `supp_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者编号',
  `supp_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者地址',
  `supp_cont_meth` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者联系方式',
  `buyer_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '购货者名称',
  `buyer_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '购货者编号',
  `buyer_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '购货者地址',
  `sugg_vend_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '联系方式',
  `need_by_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到货日期',
  `ship_via_look_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输方式',
  `documents` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单据',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `total_order_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单总价',
  `ware_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '仓库编码',
  `buyer_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购员编码',
  `order_type1_logi` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单类型1-物流',
  `order_type2_comm` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单类型2-商品',
  `order_type3_repl` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单类型3-补货',
  `total_box_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '总箱数',
  `total_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '总支数',
  `bill_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单据日期',
  `arri_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到货日期',
  `fee` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '扣率',
  `tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税金额',
  `rece_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货金额',
  `notification` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '提示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_purchase`
--

/*!40000 ALTER TABLE `t02_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_purchase` ENABLE KEYS */;

--
-- Table structure for table `t02_rece_mart`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_rece_mart` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料号',
  `described` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `order_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订货数量',
  `arri_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到货数量',
  `prod_batch` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产批号',
  `prod_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产日期',
  `disa_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '失效日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_rece_mart`
--

/*!40000 ALTER TABLE `t02_rece_mart` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_rece_mart` ENABLE KEYS */;

--
-- Table structure for table `t02_receipt`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_receipt` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `rece_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货单号',
  `way_bill_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运单号',
  `supp_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供货者编号/代码',
  `rece_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `purc_order_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购单号',
  `arri_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '到货日期',
  `tran_agree` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输条件是否一致',
  `have_peer_list` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有无随货同行单',
  `deli_man` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '送货人',
  `reci_man` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '接收人',
  `peer_list_agree` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '随货同行单是否一致',
  `to_exam` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '审核',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_receipt`
--

/*!40000 ALTER TABLE `t02_receipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_receipt` ENABLE KEYS */;

--
-- Table structure for table `t02_reje_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_reje_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `comm_code` int(11) NOT NULL COMMENT '商品编码',
  `comm_bar_code` int(11) DEFAULT NULL COMMENT '商品条码',
  `comm_name` int(11) NOT NULL COMMENT '商品名称',
  `unit` int(11) NOT NULL COMMENT '单位',
  `unit_cont` int(11) NOT NULL COMMENT '单位含量',
  `orig_coun` int(11) NOT NULL COMMENT '原单数量',
  `count` int(11) NOT NULL COMMENT '数量',
  `pick_batc` int(11) NOT NULL COMMENT '挑批次',
  `sold_pric` int(11) NOT NULL COMMENT '最后售价',
  `tax_tran_pric` int(11) NOT NULL COMMENT '含税成交单价',
  `tax_amou` int(11) NOT NULL COMMENT '含税金额',
  `acti_type` int(11) NOT NULL COMMENT '活动类型',
  `prom_no` int(11) NOT NULL COMMENT '促销活动号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_reje_mate`
--

/*!40000 ALTER TABLE `t02_reje_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_reje_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_rejected`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_rejected` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `sour_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '来源单号',
  `orga_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '组织编码',
  `cust_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '客户号',
  `sale_repr_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '销售代表编码',
  `ware_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '仓库编码',
  `auto_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '自动单号',
  `retu_meth` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '退货方式',
  `retu_reas` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '退货原因',
  `ALF` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ALF',
  `comm` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `bill_date` date DEFAULT NULL COMMENT '开单日期',
  `bill_effe_date` date DEFAULT NULL COMMENT '单据有效日',
  `tax_amou` int(11) DEFAULT NULL COMMENT '含税金额',
  `tota_box_coun` int(11) DEFAULT NULL COMMENT '退货总箱数',
  `tota_bran_coun` int(11) DEFAULT NULL COMMENT '退货总支数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_rejected`
--

/*!40000 ALTER TABLE `t02_rejected` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_rejected` ENABLE KEYS */;

--
-- Table structure for table `t02_sales`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_sales` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `sales_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '销售编号',
  `sales_date` date NOT NULL COMMENT '销售日期',
  `supp_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '供货者名称',
  `supp_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '供货者编号',
  `supp_addr` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '供货者地址',
  `supp_cont` int(11) NOT NULL COMMENT '供货者联系方式',
  `buyer_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '购货者名称',
  `buyer_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '购货者编号',
  `buyer_addr` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '购货者地址',
  `cont_meth` int(11) NOT NULL COMMENT '联系方式',
  `deli_date` date NOT NULL COMMENT '发货日期',
  `tran_meth` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '运输方式',
  `bill` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '单据',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `total_order_price` int(11) NOT NULL COMMENT '订单总价',
  `department` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '部门',
  `customer` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '客户',
  `sales_repr` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '销售代表',
  `deli_ware` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '发货仓库',
  `sett_meth` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '贸易结算方式',
  `deli_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '送货地址',
  `auto_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '自动单号',
  `manu_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '手工单号',
  `ALF` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ALF',
  `issue_addr` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '出单地址',
  `pre_pay_amou` int(11) DEFAULT NULL COMMENT '预付款金额',
  `tax_amou` int(11) DEFAULT NULL COMMENT '含税金额',
  `total_box_numb` int(11) DEFAULT NULL COMMENT '总箱数',
  `total_numb` int(11) DEFAULT NULL COMMENT '总支数',
  `ship_meth` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '付运方式',
  `total_reta_sales` int(11) DEFAULT NULL COMMENT '零售额合计',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_sales`
--

/*!40000 ALTER TABLE `t02_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_sales` ENABLE KEYS */;

--
-- Table structure for table `t02_sales_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_sales_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '物料号',
  `prod_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `spec_model` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '规格型号',
  `regi_cert_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '注册证号',
  `sale_price` int(11) NOT NULL COMMENT '销售单价',
  `sale_count` int(11) NOT NULL COMMENT '销售数量',
  `unit` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '单位',
  `amount` int(11) NOT NULL COMMENT '金额',
  `comm_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '商品编码',
  `comm_bar_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '商品条码',
  `conv_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '转换码',
  `outer_box_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '外箱含量',
  `order_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单数量',
  `supp_comm_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商商品编码',
  `inve_cost` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库存单品成本',
  `price_disc` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '售价扣率',
  `tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税金额',
  `no_tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税金额',
  `acti_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '活动类型',
  `prom_sale_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '促销单号',
  `base_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '基价',
  `reta_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '零售金额',
  `stan_box_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '标准箱数量',
  `sing_prod_cost` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单品成本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_sales_mate`
--

/*!40000 ALTER TABLE `t02_sales_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_sales_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_ship`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_ship` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `Invo_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '发货单号',
  `way_bill_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '运单号',
  `supp_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '供货者编号/代码',
  `NAME` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `purc_order_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '采购单号',
  `arri_date` date NOT NULL COMMENT '到货日期',
  `tran_agree` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '运输条件是是一致',
  `have_peer_list` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '有无随货同行单',
  `deli_man` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '送货人',
  `peer_list_agree` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '上述随货同行单是是一致',
  `reci_man` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '接收人',
  `to_exam` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '审核',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_ship`
--

/*!40000 ALTER TABLE `t02_ship` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_ship` ENABLE KEYS */;

--
-- Table structure for table `t02_ship_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_ship_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `mate_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '物料号',
  `describe` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `prod_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `regi_cert_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '注册证号',
  `order_quan` int(11) NOT NULL COMMENT '订货数量',
  `arri_quan` int(11) NOT NULL COMMENT '到货数量',
  `prod_batch` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '生产批号',
  `prod_date` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '生产日期',
  `disa_date` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '失效日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_ship_mate`
--

/*!40000 ALTER TABLE `t02_ship_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_ship_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_stoc_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_stoc_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `location` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库位',
  `mate_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料号',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  `model_spec` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '规格型号',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位',
  `prod_ente_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产企业名称',
  `seri_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产批号/序列号',
  `vali_peri` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期',
  `disa_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '失效日期',
  `stor_time` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '入库时间',
  `stock_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库存数量',
  `actu_inve_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '实际盘点数量',
  `comm_bar_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品条码',
  `comm_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品名称',
  `supp_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商编码',
  `prod_clas` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '品类',
  `brand` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌',
  `conv_fact` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '转换因子',
  `outer_box_fact` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '外箱因子',
  `reta_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '零售价',
  `which_whole` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '其中整件',
  `which_scat` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '其中零散',
  `whole` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '实盘整件',
  `scattered` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '零散',
  `total` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '总数',
  `variance` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '差异',
  `curr_inve_cost` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '当前库存成本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_stoc_mate`
--

/*!40000 ALTER TABLE `t02_stoc_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_stoc_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_stockin`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_stockin` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `stoc_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '入库单号',
  `check_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '验收单号',
  `stoc_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '入库时间',
  `ware_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房管理员姓名',
  `ware_tran_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房管理员交接时间',
  `ware_sign` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房管理员签字',
  `audit_pers` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `sour_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '来源单号',
  `orga_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '组织编码',
  `ware_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '仓库编码',
  `supp_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商编码',
  `sour_type_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '来源类型',
  `supp_list_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商单号',
  `tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税金额',
  `no_tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税金额',
  `box_count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '箱数',
  `count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单品数量',
  `marg_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '订单余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_stockin`
--

/*!40000 ALTER TABLE `t02_stockin` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_stockin` ENABLE KEYS */;

--
-- Table structure for table `t02_stockin_mate`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_stockin_mate` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `sequence` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '序号',
  `mate_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '物料号',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `prod_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '产品名称',
  `spec_model` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '规格型号',
  `regi_cert_no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '注册证号',
  `seri_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产批号/序列号',
  `term_of_vali` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '有效期',
  `disa_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '失效日期',
  `stor_quan` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '入库数量',
  `inventory` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房',
  `qual_stat` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '质量状态/区域',
  `location` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库位',
  `comm_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品编码',
  `comm_bar_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商品条码',
  `supp_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商编码',
  `unit` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位',
  `unit_cont` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '单位含量',
  `count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '数量',
  `tax_purc_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税进价',
  `purc_marg` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采购余量（支）',
  `batch_prod_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '批次生产日期',
  `batch_peri` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '批次有效期',
  `shelf_life_day` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '保质天数',
  `batch_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '批次号',
  `supp_batch_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商批次号',
  `fee` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '扣率',
  `tax_amou` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '含税金额',
  `tax` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '税额',
  `refe_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '参考进价（单品）',
  `no_tax_price` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '不含税金额',
  `ware_numb` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '仓库管理员编号',
  `ware_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '仓库管理员姓名',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_stockin_mate`
--

/*!40000 ALTER TABLE `t02_stockin_mate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_stockin_mate` ENABLE KEYS */;

--
-- Table structure for table `t02_stockout`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_stockout` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `stoc_numb` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '出库单号',
  `check_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '验收单号',
  `stoc_date` date NOT NULL COMMENT '出库时间',
  `ware_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房管理员姓名',
  `ware_tran_date` date DEFAULT NULL COMMENT '库房管理员交接时间',
  `ware_sign` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房管理员签字',
  `audit_pers` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `sour_no` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '来源单号',
  `orga_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '组织编码',
  `ware_code` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '仓库编码',
  `comments` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '备注',
  `no_tax_amou` int(11) DEFAULT NULL COMMENT '不含税金额',
  `box_count` int(11) DEFAULT NULL COMMENT '箱数',
  `sing_prod_count` int(11) DEFAULT NULL COMMENT '单品数量',
  `deli_date` date DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_stockout`
--

/*!40000 ALTER TABLE `t02_stockout` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_stockout` ENABLE KEYS */;

--
-- Table structure for table `t02_stocktaking`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t02_stocktaking` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `create_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `warehouse` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '库房/地点',
  `qual_stat` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '质量状态/区域',
  `inve_count` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '盘点编号',
  `inve_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '盘点人姓名',
  `orga_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '组织编码',
  `ware_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '仓库编码',
  `inve_date` datetime DEFAULT NULL COMMENT '盘点日期',
  `near_days` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '临期天数',
  `manu_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生产商编码',
  `cate_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '品类编码',
  `brand_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `comments` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `sales_start_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '销售开始日期',
  `sales_end_date` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '销售截止日期',
  `near_good` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '临其商品',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t02_stocktaking`
--

/*!40000 ALTER TABLE `t02_stocktaking` DISABLE KEYS */;
/*!40000 ALTER TABLE `t02_stocktaking` ENABLE KEYS */;

--
-- Table structure for table `test_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_data` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_data`
--

/*!40000 ALTER TABLE `test_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_data` ENABLE KEYS */;

--
-- Table structure for table `test_data_child`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_data_child` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `test_data_main_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '业务主表ID',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_child_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_data_child`
--

/*!40000 ALTER TABLE `test_data_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_data_child` ENABLE KEYS */;

--
-- Table structure for table `test_data_main`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_data_main` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_main_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_data_main`
--

/*!40000 ALTER TABLE `test_data_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_data_main` ENABLE KEYS */;

--
-- Table structure for table `test_tree`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_tree` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_parent_id` (`parent_id`),
  KEY `test_tree_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tree`
--

/*!40000 ALTER TABLE `test_tree` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_tree` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-04 12:17:18
