/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: c1IH_PA
-- ------------------------------------------------------
-- Server version	10.11.18-MariaDB-0+deb12u1

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
-- Temporary table structure for view `AnaLevel`
--

DROP TABLE IF EXISTS `AnaLevel`;
/*!50001 DROP VIEW IF EXISTS `AnaLevel`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `AnaLevel` AS SELECT
 NULL AS `ID`,
 NULL AS `prev level`,
 NULL AS `codice`,
 NULL AS `level`,
 NULL AS `cefr`,
 NULL AS `cid` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Anagrafica`
--

DROP TABLE IF EXISTS `Anagrafica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Anagrafica` (
  `AWelcome` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `AutoBookStatus` int(1) unsigned NOT NULL DEFAULT 1,
  `sendC` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `YLAddendum` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `YLZoomok` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `EndOfYearSent` int(1) unsigned NOT NULL DEFAULT 0,
  `hashref` mediumtext DEFAULT NULL,
  `passwd` mediumtext DEFAULT NULL,
  `tmppwd` mediumtext DEFAULT NULL,
  `DataNa` date DEFAULT NULL,
  `Citta` mediumtext DEFAULT NULL,
  `Cap` mediumtext DEFAULT NULL,
  `Prov` mediumtext DEFAULT NULL,
  `country` mediumtext DEFAULT NULL,
  `CodFisc` mediumtext DEFAULT NULL,
  `Datafirst` date DEFAULT NULL,
  `Datalast` date DEFAULT NULL,
  `LuogoNa` mediumtext DEFAULT NULL,
  `Cognome` mediumtext DEFAULT NULL,
  `Nome` mediumtext DEFAULT NULL,
  `tel1` mediumtext DEFAULT NULL,
  `tel2` mediumtext DEFAULT NULL,
  `Indirizzo` mediumtext DEFAULT NULL,
  `Genitore` mediumtext DEFAULT NULL,
  `email` mediumtext DEFAULT NULL,
  `email2` mediumtext DEFAULT NULL,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Note` text DEFAULT NULL,
  `Tipo` tinyint(4) unsigned NOT NULL DEFAULT 1,
  `foto` varchar(512) NOT NULL DEFAULT ' https://ihcoin.ihportal.org/student/images/Pupino.png',
  `psp_credit` int(2) unsigned NOT NULL DEFAULT 0,
  `card_point` int(3) unsigned NOT NULL DEFAULT 0,
  `card_dateL` date DEFAULT NULL,
  `card_NF` int(1) unsigned NOT NULL DEFAULT 0,
  `card_CT` int(1) unsigned NOT NULL DEFAULT 0,
  `card_double` int(1) unsigned NOT NULL DEFAULT 0,
  `status` int(2) unsigned NOT NULL DEFAULT 1,
  `level` varchar(10) DEFAULT NULL,
  `id_school` varchar(1024) NOT NULL DEFAULT '|0|',
  `customer` mediumtext DEFAULT NULL,
  `token` mediumtext DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`c1ih_pa`@`localhost`*/ /*!50003 TRIGGER anagrafica_bi_set_datafirst
BEFORE INSERT ON Anagrafica
FOR EACH ROW
BEGIN
  IF NEW.Datafirst IS NULL THEN
    SET NEW.Datafirst = NOW();
  END IF;
END 
*/;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Anagrafica_datifatturazione`
--

DROP TABLE IF EXISTS `Anagrafica_datifatturazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Anagrafica_datifatturazione` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_corsista` int(5) NOT NULL,
  `denominazione` varchar(100) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `citta` varchar(100) NOT NULL,
  `cap` varchar(100) DEFAULT NULL,
  `codfis` varchar(100) DEFAULT NULL,
  `piva` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Anagrafica_tipo`
--

DROP TABLE IF EXISTS `Anagrafica_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Anagrafica_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` mediumtext DEFAULT NULL,
  `sconto` int(3) NOT NULL DEFAULT 0,
  `sovraprezzo` float(5,2) NOT NULL DEFAULT 0.00,
  `id_school` varchar(1024) NOT NULL DEFAULT '|0|',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Answers`
--

DROP TABLE IF EXISTS `Answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` varchar(200) NOT NULL,
  `id_Teacher` varchar(200) DEFAULT NULL,
  `ih_Level` varchar(200) DEFAULT NULL,
  `ih_Date` varchar(200) DEFAULT NULL,
  `ih_Grade` varchar(200) DEFAULT NULL,
  `ihvar1` varchar(200) DEFAULT NULL,
  `ihvar2` varchar(200) DEFAULT NULL,
  `ihvar3` varchar(200) DEFAULT NULL,
  `ihvar4` varchar(200) DEFAULT NULL,
  `ihvar5` varchar(200) DEFAULT NULL,
  `ihvar6` varchar(200) DEFAULT NULL,
  `ihvar7` varchar(200) DEFAULT NULL,
  `ihvar8` varchar(200) DEFAULT NULL,
  `ihvar9` varchar(200) DEFAULT NULL,
  `ihvar10` varchar(200) DEFAULT NULL,
  `ihvar11` varchar(200) DEFAULT NULL,
  `ihvar12` varchar(200) DEFAULT NULL,
  `ihvar13` varchar(200) DEFAULT NULL,
  `ihvar14` varchar(200) DEFAULT NULL,
  `ihvar15` varchar(200) DEFAULT NULL,
  `ihvar16` varchar(200) DEFAULT NULL,
  `ihvar17` varchar(200) DEFAULT NULL,
  `ihvar18` varchar(200) DEFAULT NULL,
  `ihvar19` varchar(200) DEFAULT NULL,
  `ihvar20` varchar(200) DEFAULT NULL,
  `ihvar21` varchar(200) DEFAULT NULL,
  `ihvar22` varchar(200) DEFAULT NULL,
  `ihvar23` varchar(200) DEFAULT NULL,
  `ihvar24` varchar(200) DEFAULT NULL,
  `ihvar25` varchar(200) DEFAULT NULL,
  `ihvar26` varchar(200) DEFAULT NULL,
  `ihvar27` varchar(200) DEFAULT NULL,
  `ihvar28` varchar(200) DEFAULT NULL,
  `ihvar29` varchar(200) DEFAULT NULL,
  `ihvar30` varchar(200) DEFAULT NULL,
  `ihvar31` varchar(200) DEFAULT NULL,
  `ihvar32` varchar(200) DEFAULT NULL,
  `ihvar33` varchar(200) DEFAULT NULL,
  `ihvar34` varchar(200) DEFAULT NULL,
  `ihvar35` varchar(200) DEFAULT NULL,
  `ihvar36` varchar(200) DEFAULT NULL,
  `ihvar37` varchar(200) DEFAULT NULL,
  `ihvar38` varchar(200) DEFAULT NULL,
  `ihvar39` varchar(200) DEFAULT NULL,
  `ihvar40` varchar(200) DEFAULT NULL,
  `ihvar41` varchar(200) DEFAULT NULL,
  `ihvar42` varchar(200) DEFAULT NULL,
  `ihvar43` varchar(200) DEFAULT NULL,
  `ihvar44` varchar(200) DEFAULT NULL,
  `ihvar45` varchar(200) DEFAULT NULL,
  `ihvar46` varchar(200) DEFAULT NULL,
  `ihvar47` longtext DEFAULT NULL,
  `ihvar48` longtext DEFAULT NULL,
  `ihvar49` longtext DEFAULT NULL,
  `ihvar50` longtext DEFAULT NULL,
  `ihvar51` longtext DEFAULT NULL,
  `ihvar52` longtext DEFAULT NULL,
  `ihvar53` longtext DEFAULT NULL,
  `ihvar54` longtext DEFAULT NULL,
  `ihvar55` longtext DEFAULT NULL,
  `ihvar56` longtext DEFAULT NULL,
  `ihvar57` longtext DEFAULT NULL,
  `ihvar58` longtext DEFAULT NULL,
  `ihvar59` longtext DEFAULT NULL,
  `ihvar60` longtext DEFAULT NULL,
  `ihvar61` longtext DEFAULT NULL,
  `ihvar62` longtext DEFAULT NULL,
  `ihvar63` longtext DEFAULT NULL,
  `ihvar64` longtext DEFAULT NULL,
  `ihvar65` longtext DEFAULT NULL,
  `ihvar66` longtext DEFAULT NULL,
  `ihvar67` longtext DEFAULT NULL,
  `ihvar68` longtext DEFAULT NULL,
  `ihvar69` longtext DEFAULT NULL,
  `ihvar70` longtext DEFAULT NULL,
  `ihvar71` longtext DEFAULT NULL,
  `ihvar72` longtext DEFAULT NULL,
  `ih_Ans1ok` text DEFAULT NULL,
  `ih_Ans2ok` text DEFAULT NULL,
  `ih_Ans3ok` text DEFAULT NULL,
  `ih_Ans4ok` text DEFAULT NULL,
  `ih_Ans5ok` text DEFAULT NULL,
  `ih_Ans6ok` text DEFAULT NULL,
  `ih_Ans7ok` text DEFAULT NULL,
  `ih_Ans8ok` text DEFAULT NULL,
  `ih_Ans9ok` text DEFAULT NULL,
  `ih_Ans10ok` text DEFAULT NULL,
  `ih_Remarks` longtext DEFAULT NULL,
  `ih_Extra_Points` varchar(45) DEFAULT NULL,
  `id_corso` varchar(45) NOT NULL,
  `book` varchar(45) NOT NULL,
  `1` varchar(45) DEFAULT NULL,
  `2` varchar(45) DEFAULT NULL,
  `3` varchar(45) DEFAULT NULL,
  `4` varchar(45) DEFAULT NULL,
  `5` varchar(45) DEFAULT NULL,
  `6` varchar(45) DEFAULT NULL,
  `7` varchar(45) DEFAULT NULL,
  `8` varchar(45) DEFAULT NULL,
  `9` varchar(45) DEFAULT NULL,
  `10` varchar(45) DEFAULT NULL,
  `ex4_total` varchar(100) DEFAULT NULL,
  `ihvar73` varchar(200) DEFAULT NULL,
  `ihvar75` varchar(200) DEFAULT NULL,
  `ihvar76` varchar(200) DEFAULT NULL,
  `ihvar77` varchar(200) DEFAULT NULL,
  `ihvar78` varchar(200) DEFAULT NULL,
  `ihvar79` varchar(299) DEFAULT NULL,
  `ihvar80` varchar(200) DEFAULT NULL,
  `ihvar74` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Answers2`
--

DROP TABLE IF EXISTS `Answers2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answers2` (
  `hashref` varchar(40) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` varchar(200) NOT NULL,
  `id_Teacher` varchar(200) DEFAULT NULL,
  `ih_Level` varchar(200) DEFAULT NULL,
  `ih_Date` varchar(200) DEFAULT NULL,
  `ih_Grade` varchar(200) DEFAULT NULL,
  `blob` longtext DEFAULT NULL,
  `blob2` longtext DEFAULT NULL,
  `blob3` longtext DEFAULT NULL,
  `writing` longtext DEFAULT NULL,
  `id_corso` varchar(45) NOT NULL,
  `finaltest` int(1) NOT NULL DEFAULT 0,
  `ih_listeningGrade` varchar(200) DEFAULT NULL,
  `ih_writingGrade` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5526 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pagamenti`
--

DROP TABLE IF EXISTS `Pagamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pagamenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_iscrizione` int(11) NOT NULL,
  `importo` decimal(10,2) DEFAULT NULL,
  `data_scadenza` date DEFAULT NULL,
  `data_pagamento` datetime DEFAULT '0000-00-00 00:00:00',
  `pagato` tinyint(1) DEFAULT 0,
  `tipo_pagamento` varchar(25) DEFAULT NULL,
  `annullato` int(1) unsigned NOT NULL DEFAULT 0,
  `bonifico` int(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51908 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SAPspe`
--

DROP TABLE IF EXISTS `SAPspe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SAPspe` (
  `ih_ID` text DEFAULT NULL,
  `ih_Result` text DEFAULT NULL,
  `ih_Time` text DEFAULT NULL,
  `ih_Term` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `ih_Days` text DEFAULT NULL,
  `ih_pro_percent` text DEFAULT NULL,
  `ih_Y_Pro_Pos` text DEFAULT NULL,
  `ih_acc_percent` text DEFAULT NULL,
  `ih_Y_Acc_Pos` text DEFAULT NULL,
  `ih_ran_percent` text DEFAULT NULL,
  `ih_Y_Ran_Pos` text DEFAULT NULL,
  `ih_com_percent` text DEFAULT NULL,
  `ih_Y_Com_Pos` text DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `cod_course` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2929 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SAPspe_copy`
--

DROP TABLE IF EXISTS `SAPspe_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SAPspe_copy` (
  `ih_ID` text DEFAULT NULL,
  `ih_Result` text DEFAULT NULL,
  `ih_Time` text DEFAULT NULL,
  `ih_Term` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `ih_Days` text DEFAULT NULL,
  `ih_pro_percent` text DEFAULT NULL,
  `ih_Y_Pro_Pos` text DEFAULT NULL,
  `ih_acc_percent` text DEFAULT NULL,
  `ih_Y_Acc_Pos` text DEFAULT NULL,
  `ih_ran_percent` text DEFAULT NULL,
  `ih_Y_Ran_Pos` text DEFAULT NULL,
  `ih_com_percent` text DEFAULT NULL,
  `ih_Y_Com_Pos` text DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `cod_course` varchar(45) NOT NULL,
  `data_stored` date NOT NULL DEFAULT '1970-01-01',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2921 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_exam_candidates`
--

DROP TABLE IF EXISTS `cambridge_exam_candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_exam_candidates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school` text DEFAULT NULL,
  `n_candidates` int(4) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `id_cambridge` int(10) unsigned NOT NULL DEFAULT 0,
  `oral_date_session` text DEFAULT NULL,
  `oral_time` varchar(5) DEFAULT NULL,
  `oral_minutes` int(3) unsigned DEFAULT NULL,
  `status` int(1) unsigned NOT NULL DEFAULT 0,
  `school_letter_date` date NOT NULL,
  `id_oral` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_exam_chart`
--

DROP TABLE IF EXISTS `cambridge_exam_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_exam_chart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `written_time` varchar(11) DEFAULT NULL,
  `written_venue` text DEFAULT NULL,
  `cambridge_deadline` date NOT NULL,
  `public_deadline` date NOT NULL,
  `notes_exam` text DEFAULT NULL,
  `stato` int(3) unsigned NOT NULL DEFAULT 0,
  `title` text DEFAULT NULL,
  `e_supervisor` text DEFAULT NULL,
  `e_invigilators` text DEFAULT NULL,
  `oral_window` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=898 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_exam_checkList`
--

DROP TABLE IF EXISTS `cambridge_exam_checkList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_exam_checkList` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_exam` int(10) unsigned NOT NULL DEFAULT 0,
  `type` text NOT NULL,
  `title` text NOT NULL,
  `task` text NOT NULL,
  `when` date NOT NULL,
  `who` text NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_exam_oral`
--

DROP TABLE IF EXISTS `cambridge_exam_oral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_exam_oral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` text DEFAULT NULL,
  `id_exam` int(10) unsigned NOT NULL DEFAULT 0,
  `oral_date` date DEFAULT NULL,
  `oral_venue` text DEFAULT NULL,
  `oral_invigilators` text DEFAULT NULL,
  `oral_supervisor` text DEFAULT NULL,
  `oral_se` text DEFAULT NULL,
  `session` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_preparation_centres`
--

DROP TABLE IF EXISTS `cambridge_preparation_centres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_preparation_centres` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `short_name` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `address` text NOT NULL,
  `note` text NOT NULL,
  `city` text NOT NULL,
  `country` text NOT NULL,
  `post_area_code` int(5) unsigned NOT NULL,
  `fax` varchar(10) NOT NULL,
  `country_code` varchar(6) NOT NULL,
  `area_code` varchar(6) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `Email` text NOT NULL,
  `type_of_funding` text NOT NULL,
  `preparation_centre_type` text NOT NULL,
  `unique_Id` varchar(11) NOT NULL,
  `venue` int(1) unsigned NOT NULL DEFAULT 1,
  `piva` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_preparation_teachers`
--

DROP TABLE IF EXISTS `cambridge_preparation_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_preparation_teachers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_teacher` int(10) NOT NULL DEFAULT 0,
  `passport_number` text DEFAULT NULL,
  `overseas_telephone` text DEFAULT NULL,
  `overseas_address` text DEFAULT NULL,
  `ucles_id` varchar(10) DEFAULT NULL,
  `status` int(1) unsigned NOT NULL DEFAULT 0,
  `invigilator` int(1) unsigned NOT NULL DEFAULT 0,
  `supervisor` int(1) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `yle` int(1) unsigned DEFAULT 0,
  `ket` int(1) unsigned DEFAULT 0,
  `pet` int(1) unsigned DEFAULT 0,
  `fce` int(1) unsigned DEFAULT 0,
  `cae` int(1) unsigned DEFAULT 0,
  `cpe` int(1) unsigned DEFAULT 0,
  `bec` int(1) unsigned DEFAULT 0,
  `ilec` int(1) unsigned DEFAULT 0,
  `icfe` int(1) unsigned DEFAULT 0,
  `ielts` int(1) unsigned DEFAULT 0,
  `starters` int(1) unsigned DEFAULT 0,
  `movers` int(1) unsigned DEFAULT 0,
  `flyers` int(1) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cambridge_teacher_exam`
--

DROP TABLE IF EXISTS `cambridge_teacher_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cambridge_teacher_exam` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam` text NOT NULL DEFAULT 'TBA',
  `id_teacher` int(10) unsigned NOT NULL DEFAULT 0,
  `standardization` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `coordination` date DEFAULT NULL,
  `observation` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_registration`
--

DROP TABLE IF EXISTS `card_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `card_registration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_teacher` int(10) unsigned DEFAULT 0,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `dateEnd` date NOT NULL DEFAULT '0000-00-00',
  `time` varchar(5) NOT NULL DEFAULT '00.00',
  `type` varchar(1024) NOT NULL DEFAULT 'not set',
  `descr` mediumtext DEFAULT NULL,
  `limits` int(2) unsigned NOT NULL DEFAULT 9,
  `onlinelink` mediumtext DEFAULT NULL,
  `link_des` mediumtext DEFAULT NULL,
  `link_gen` mediumtext DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `file_path` mediumtext DEFAULT NULL,
  `shared` varchar(3) NOT NULL DEFAULT 'off',
  `id_school` varchar(1024) NOT NULL DEFAULT '|0|',
  `img_url` mediumtext NOT NULL,
  `ihCoinCost` int(3) unsigned NOT NULL DEFAULT 0,
  `flag_AdultYL` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6623 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_registration_booking`
--

DROP TABLE IF EXISTS `card_registration_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `card_registration_booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `id_card` int(10) unsigned NOT NULL DEFAULT 0,
  `slot` int(3) unsigned NOT NULL DEFAULT 0,
  `cancel` int(1) unsigned NOT NULL DEFAULT 0,
  `note` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ana_psp` (`id_ana`,`id_card`)
) ENGINE=InnoDB AUTO_INCREMENT=22128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_books`
--

DROP TABLE IF EXISTS `corsi_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_books` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `codice_corso` varchar(20) DEFAULT NULL,
  `titolo` varchar(100) NOT NULL,
  `id_corso` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_discipline`
--

DROP TABLE IF EXISTS `corsi_discipline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_discipline` (
  `abbreviazione` varchar(3) NOT NULL,
  `disciplina` varchar(40) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_elenco`
--

DROP TABLE IF EXISTS `corsi_elenco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_elenco` (
  `codice` text NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date NOT NULL,
  `aula` varchar(25) NOT NULL,
  `id_livello` int(2) NOT NULL,
  `abbreviazione_disciplina` varchar(3) NOT NULL,
  `id_insegnante` int(5) NOT NULL,
  `descrizione_orario` varchar(256) NOT NULL,
  `ore_totali` int(4) NOT NULL DEFAULT 0,
  `giorni` varchar(6) NOT NULL DEFAULT 'xoxoxo',
  `lessons` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1,
  `costo` float(8,2) DEFAULT 0.00,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `esame` enum('corso','esame') NOT NULL DEFAULT 'corso',
  `id_cambridge` int(10) unsigned DEFAULT 0,
  `note` text DEFAULT NULL,
  `descrizione_livello` text DEFAULT NULL,
  `noProfile` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `codice` (`codice`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=4328 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_iscrizioni`
--

DROP TABLE IF EXISTS `corsi_iscrizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_iscrizioni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `situazione` enum('green','yellow','red','purple','yellow-red','yellow-purple','red-purple','yellow-red-purple','pink','yellow-pink','pink-red','pink-purple','yellow-pink-purple','blue','yellow-blue','pink-blue','red-blue','yellow-red-blue','yellow-pink-blue','purple-blue') NOT NULL DEFAULT 'green',
  `id_corsista` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` text DEFAULT '',
  `costo` float(8,2) DEFAULT 0.00,
  `id_corso` int(11) unsigned NOT NULL DEFAULT 0,
  `id_rel` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `nota` text DEFAULT NULL,
  `n_course` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `color_row_fd` enum('default','white','yellow','orange','red','green','lightblue','blue','violet','purple') NOT NULL DEFAULT 'default',
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `extra_psp` int(1) NOT NULL DEFAULT 0,
  `extra_job` int(1) NOT NULL DEFAULT 0,
  `extra_cp` int(1) NOT NULL DEFAULT 0,
  `extra_exam` int(1) NOT NULL DEFAULT 0,
  `extra_psps` int(1) NOT NULL DEFAULT 0,
  `urgent` int(1) NOT NULL DEFAULT 0,
  `insolvente` int(1) NOT NULL DEFAULT 0,
  `SEN` int(1) NOT NULL DEFAULT 0,
  `inps` int(1) NOT NULL DEFAULT 0,
  `tasks` int(1) unsigned NOT NULL DEFAULT 0,
  `contract` text DEFAULT NULL,
  `email_stripe` int(1) unsigned NOT NULL DEFAULT 0,
  `email_iban` int(1) unsigned NOT NULL DEFAULT 0,
  `sollecitoYL` int(1) unsigned NOT NULL DEFAULT 0,
  `sollecitoA` int(1) unsigned NOT NULL DEFAULT 0,
  `clickliPT` int(1) NOT NULL DEFAULT 0,
  `clicklaPT` int(1) NOT NULL DEFAULT 0,
  `clickliFT` int(1) NOT NULL DEFAULT 0,
  `clicklaFT` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iscrizione` (`id_corsista`,`id_corso`,`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27286 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_livelli`
--

DROP TABLE IF EXISTS `corsi_livelli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_livelli` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) DEFAULT ' ',
  `desc_ext` varchar(100) DEFAULT ' ',
  `tipologia` varchar(40) DEFAULT ' ',
  `ordine` int(2) NOT NULL DEFAULT 0,
  `cefr` varchar(100) NOT NULL DEFAULT '',
  `enabled` int(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_note`
--

DROP TABLE IF EXISTS `corsi_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_note` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `codice_corso` varchar(20) NOT NULL,
  `data` date NOT NULL,
  `testo` text NOT NULL,
  `id_corso` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_orari`
--

DROP TABLE IF EXISTS `corsi_orari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_orari` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(40) NOT NULL,
  `fascia` varchar(5) NOT NULL DEFAULT 'YL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corsi_tipologie`
--

DROP TABLE IF EXISTS `corsi_tipologie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsi_tipologie` (
  `tipologia` varchar(40) NOT NULL,
  PRIMARY KEY (`tipologia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `count_click`
--

DROP TABLE IF EXISTS `count_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `count_click` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ana` int(11) NOT NULL,
  `date_ins` datetime NOT NULL,
  `type` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_assessment_progress`
--

DROP TABLE IF EXISTS `course_register_assessment_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_assessment_progress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_course` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `type` text NOT NULL,
  `num` int(1) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_homework`
--

DROP TABLE IF EXISTS `course_register_homework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_homework` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_course` int(11) NOT NULL,
  `date` date NOT NULL,
  `homework` text NOT NULL,
  `urlPDF` varchar(512) DEFAULT NULL,
  `status` int(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_note`
--

DROP TABLE IF EXISTS `course_register_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_course` int(11) NOT NULL,
  `date` date NOT NULL,
  `note` text NOT NULL,
  `urlPDF` varchar(512) DEFAULT NULL,
  `status` int(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29375 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_student`
--

DROP TABLE IF EXISTS `course_register_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `id_course` int(11) NOT NULL,
  `date` date NOT NULL,
  `id_student` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_course_id_student_date` (`id_course`,`id_student`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=270759 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_student_note`
--

DROP TABLE IF EXISTS `course_register_student_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_student_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_course` int(11) NOT NULL,
  `id_student` int(11) NOT NULL,
  `date` date NOT NULL,
  `note` text NOT NULL,
  `status` int(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1043 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_register_student_progress`
--

DROP TABLE IF EXISTS `course_register_student_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_register_student_progress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_student` int(11) unsigned NOT NULL,
  `id_course` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `type` text NOT NULL,
  `mark` int(2) unsigned NOT NULL,
  `num` int(1) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  `result` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_registration`
--

DROP TABLE IF EXISTS `course_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_registration` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_level` int(10) unsigned NOT NULL DEFAULT 0,
  `id_teacher` int(10) unsigned NOT NULL DEFAULT 12813,
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `date_end_ext` date NOT NULL DEFAULT '0000-00-00',
  `day` varchar(6) NOT NULL DEFAULT 'oooooo',
  `time` text DEFAULT NULL,
  `limit` int(2) NOT NULL DEFAULT 12,
  `code` text DEFAULT NULL,
  `programmed` tinyint(1) NOT NULL DEFAULT 0,
  `note` text DEFAULT NULL,
  `id_corso` int(10) unsigned NOT NULL DEFAULT 0,
  `staff` text DEFAULT NULL,
  `priority` tinyint(1) unsigned NOT NULL DEFAULT 2,
  `book` text DEFAULT NULL,
  `bookurl` text DEFAULT NULL,
  `venue` tinytext DEFAULT NULL,
  `onlinelink` tinytext DEFAULT NULL,
  `enpg` int(1) unsigned NOT NULL DEFAULT 0,
  `ptend` date DEFAULT NULL,
  `link2ListeningPT` text DEFAULT NULL,
  `audio2ListeningPT` text DEFAULT NULL,
  `link2LanguagePT` text DEFAULT NULL,
  `enft` int(1) unsigned NOT NULL DEFAULT 0,
  `ftend` date DEFAULT NULL,
  `link2ListeningFT` text DEFAULT NULL,
  `audio2ListeningFT` text DEFAULT NULL,
  `link2LanguageFT` text DEFAULT NULL,
  `startCourseA` int(1) unsigned NOT NULL DEFAULT 0,
  `startCourseYL` int(1) unsigned NOT NULL DEFAULT 0,
  `startCourseSA` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `course_registration_booking`
--

DROP TABLE IF EXISTS `course_registration_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_registration_booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_course` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` text DEFAULT 'Insert Name',
  `Surname` text DEFAULT NULL,
  `Note` text DEFAULT NULL,
  `Status` enum('confirmed','pending','deleted') NOT NULL DEFAULT 'pending',
  `inserted_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `edited_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tel` text NOT NULL DEFAULT 'not set',
  `ptch` text DEFAULT NULL,
  `pref_datetime` text DEFAULT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT 1,
  `expiration_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id_iscrizione` int(10) unsigned NOT NULL DEFAULT 0,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `age` tinytext DEFAULT NULL,
  `class` tinytext DEFAULT NULL,
  `email` text DEFAULT NULL,
  `client_preference` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35362 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` text NOT NULL,
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ih_Name` text DEFAULT NULL,
  `ih_Surname` text DEFAULT NULL,
  `ih_Date` text DEFAULT NULL,
  `ih_Grade` text DEFAULT NULL,
  `finlev` tinytext DEFAULT NULL,
  `ihvar1` text DEFAULT NULL,
  `ihvar2` text DEFAULT NULL,
  `ihvar3` text DEFAULT NULL,
  `ihvar4` text DEFAULT NULL,
  `ihvar5` text DEFAULT NULL,
  `ihvar6` text DEFAULT NULL,
  `ihvar7` text DEFAULT NULL,
  `ihvar8` text DEFAULT NULL,
  `ihvar9` text DEFAULT NULL,
  `ihvar10` text DEFAULT NULL,
  `ihvar11` text DEFAULT NULL,
  `ihvar12` text DEFAULT NULL,
  `ihvar13` text DEFAULT NULL,
  `ihvar14` text DEFAULT NULL,
  `ihvar15` text DEFAULT NULL,
  `ihvar16` text DEFAULT NULL,
  `ihvar17` text DEFAULT NULL,
  `ihvar18` text DEFAULT NULL,
  `ihvar19` text DEFAULT NULL,
  `ihvar20` text DEFAULT NULL,
  `ihvar21` text DEFAULT NULL,
  `ihvar22` text DEFAULT NULL,
  `ihvar23` text DEFAULT NULL,
  `ihvar24` text DEFAULT NULL,
  `ihvar25` text DEFAULT NULL,
  `ihvar26` text DEFAULT NULL,
  `ihvar27` text DEFAULT NULL,
  `ihvar28` text DEFAULT NULL,
  `ihvar29` text DEFAULT NULL,
  `ihvar30` text DEFAULT NULL,
  `ihvar31` text DEFAULT NULL,
  `ihvar32` text DEFAULT NULL,
  `ihvar33` text DEFAULT NULL,
  `ihvar34` text DEFAULT NULL,
  `ihvar35` text DEFAULT NULL,
  `ihvar36` text DEFAULT NULL,
  `ihvar37` text DEFAULT NULL,
  `ihvar38` text DEFAULT NULL,
  `ihvar39` text DEFAULT NULL,
  `ihvar40` text DEFAULT NULL,
  `ihvar41` text DEFAULT NULL,
  `ihvar42` text DEFAULT NULL,
  `ihvar43` text DEFAULT NULL,
  `ihvar44` text DEFAULT NULL,
  `ihvar45` text DEFAULT NULL,
  `ihvar46` text DEFAULT NULL,
  `ihvar47` text DEFAULT NULL,
  `ihvar48` text DEFAULT NULL,
  `ihvar49` text DEFAULT NULL,
  `ihvar50` text DEFAULT NULL,
  `ihvar51` text DEFAULT NULL,
  `ihvar52` text DEFAULT NULL,
  `ihvar53` text DEFAULT NULL,
  `ihvar54` text DEFAULT NULL,
  `ihvar55` text DEFAULT NULL,
  `ihvar56` text DEFAULT NULL,
  `ihvar57` text DEFAULT NULL,
  `ihvar58` text DEFAULT NULL,
  `ihvar59` text DEFAULT NULL,
  `ihvar60` text DEFAULT NULL,
  `ihvar61` text DEFAULT NULL,
  `ihvar62` text DEFAULT NULL,
  `ihvar63` text DEFAULT NULL,
  `ihvar64` text DEFAULT NULL,
  `ihvar65` text DEFAULT NULL,
  `ihvar66` text DEFAULT NULL,
  `ihvar67` text DEFAULT NULL,
  `ih_q6_Remarks` longtext DEFAULT NULL,
  `ih_Extra_Points` text DEFAULT NULL,
  `ih_usermail` varchar(60) DEFAULT NULL,
  `ih_Remarks` longtext DEFAULT NULL,
  `Telefono` varchar(45) DEFAULT NULL,
  `Privacy` varchar(45) DEFAULT NULL,
  `uso` varchar(45) DEFAULT NULL,
  `bisogno1` varchar(45) DEFAULT NULL,
  `bisogno2` varchar(45) DEFAULT NULL,
  `bisogno3` varchar(45) DEFAULT NULL,
  `QCER` varchar(45) DEFAULT NULL,
  `school` varchar(60) DEFAULT NULL,
  `class` text DEFAULT NULL,
  `altro` char(150) DEFAULT NULL,
  `occu` text DEFAULT NULL,
  `count` text DEFAULT NULL,
  `study` text DEFAULT NULL,
  `inter` text DEFAULT NULL,
  `lev` text DEFAULT NULL,
  `com` text DEFAULT NULL,
  `gram` text DEFAULT NULL,
  `flu` text DEFAULT NULL,
  `comm` text DEFAULT NULL,
  `pro` text DEFAULT NULL,
  `accu` text DEFAULT NULL,
  `age` varchar(20) DEFAULT NULL,
  `voc` varchar(10) DEFAULT NULL,
  `not_eligible` text DEFAULT NULL,
  `test` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `ih_ID` (`ih_ID`(768))
) ENGINE=InnoDB AUTO_INCREMENT=34088 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entry_test_booking`
--

DROP TABLE IF EXISTS `entry_test_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_test_booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinytext DEFAULT NULL,
  `Surname` tinytext DEFAULT NULL,
  `dob` tinytext DEFAULT NULL,
  `spkw` text DEFAULT NULL,
  `myIEx` text DEFAULT NULL,
  `exinfo` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `email` tinytext DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT 0,
  `type` tinytext DEFAULT NULL,
  `c1` int(2) unsigned NOT NULL DEFAULT 0,
  `c2` int(2) unsigned NOT NULL DEFAULT 0,
  `c3` int(2) unsigned NOT NULL DEFAULT 0,
  `ids` int(10) unsigned NOT NULL DEFAULT 0,
  `idp` int(10) unsigned NOT NULL DEFAULT 0,
  `hash` text DEFAULT NULL,
  `result` int(2) unsigned NOT NULL DEFAULT 0,
  `level` tinytext DEFAULT NULL,
  `teacherInfo` text DEFAULT NULL,
  `extraInfo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8316 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entry_test_placement`
--

DROP TABLE IF EXISTS `entry_test_placement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_test_placement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `test` int(1) unsigned NOT NULL DEFAULT 0,
  `template` tinytext DEFAULT NULL,
  `grade` int(3) unsigned NOT NULL DEFAULT 0,
  `num` int(3) unsigned NOT NULL DEFAULT 0,
  `per` int(3) unsigned NOT NULL DEFAULT 0,
  `idref` text DEFAULT NULL,
  `form` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entry_test_session`
--

DROP TABLE IF EXISTS `entry_test_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_test_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Time` varchar(5) NOT NULL DEFAULT '00.00',
  `Slimit` int(2) NOT NULL DEFAULT 1,
  `status` int(2) NOT NULL DEFAULT 1,
  `onlinelink` tinytext DEFAULT NULL,
  `password` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fattura`
--

DROP TABLE IF EXISTS `fattura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fattura` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` text DEFAULT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` tinytext DEFAULT NULL,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  `pagato` int(1) unsigned DEFAULT 1,
  `valuta` int(10) unsigned DEFAULT 1,
  `desc_gen` text DEFAULT NULL,
  `nota_addebito` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fattura_old`
--

DROP TABLE IF EXISTS `fattura_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fattura_old` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` varchar(256) NOT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` int(11) NOT NULL,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fattura_proforma`
--

DROP TABLE IF EXISTS `fattura_proforma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fattura_proforma` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` varchar(256) NOT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` int(11) NOT NULL,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feb_YL_report`
--

DROP TABLE IF EXISTS `feb_YL_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `feb_YL_report` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `aural` varchar(45) DEFAULT NULL,
  `speaking` varchar(45) DEFAULT NULL,
  `reading` varchar(45) DEFAULT NULL,
  `writing` varchar(45) DEFAULT NULL,
  `homework` varchar(45) DEFAULT NULL,
  `attitude` varchar(45) DEFAULT NULL,
  `absences` varchar(45) NOT NULL DEFAULT '0',
  `exam` varchar(45) DEFAULT NULL,
  `grade` varchar(45) DEFAULT NULL,
  `comment` text NOT NULL,
  `next_course` varchar(45) DEFAULT NULL,
  `approved` varchar(45) DEFAULT NULL,
  `ih_id` varchar(45) DEFAULT NULL,
  `cod_course` varchar(45) DEFAULT NULL,
  `grammar` varchar(45) DEFAULT NULL,
  `vocabulary` varchar(45) DEFAULT NULL,
  `behaviour` varchar(45) DEFAULT NULL,
  `EmailSent` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5682 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ih_Admin`
--

DROP TABLE IF EXISTS `ih_Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ih_Admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `iusername` text DEFAULT NULL,
  `ipassword` text DEFAULT NULL,
  `iauth` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ih_coin_voucher`
--

DROP TABLE IF EXISTS `ih_coin_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ih_coin_voucher` (
  `id` int(11) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `coins` int(3) unsigned DEFAULT 0,
  `active` int(1) NOT NULL DEFAULT 1,
  `studentID` int(10) unsigned DEFAULT 0,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `istat_comuni`
--

DROP TABLE IF EXISTS `istat_comuni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `istat_comuni` (
  `codice_istat` char(6) NOT NULL,
  `denominazione` varchar(150) NOT NULL,
  `codice_istat_provincia` char(3) DEFAULT NULL,
  PRIMARY KEY (`codice_istat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `istat_province`
--

DROP TABLE IF EXISTS `istat_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `istat_province` (
  `codice_istat` char(3) NOT NULL,
  `sigla` varchar(4) NOT NULL,
  `denominazione` varchar(150) NOT NULL,
  `regione` varchar(30) NOT NULL,
  PRIMARY KEY (`codice_istat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `may_YL_report`
--

DROP TABLE IF EXISTS `may_YL_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `may_YL_report` (
  `EmailSent` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `aural` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `speaking` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `reading` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `writing` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `homework` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `attitude` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `absences` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `exam` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `grade` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `comment` text NOT NULL,
  `approved` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL DEFAULT '0',
  `ih_ID` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `cod_course` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `grammar` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `vocabulary` varchar(45) CHARACTER SET latin2 COLLATE latin2_general_ci NOT NULL,
  `next_course` varchar(45) DEFAULT NULL,
  `behaviour` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5393 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` tinytext DEFAULT NULL,
  `descr` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `date_required` int(1) unsigned NOT NULL DEFAULT 0,
  `link` text DEFAULT NULL,
  `link_name` tinytext DEFAULT NULL,
  `shared` varchar(3) NOT NULL DEFAULT 'off',
  `id_school` varchar(1024) NOT NULL DEFAULT '|0|',
  `type` int(2) unsigned NOT NULL DEFAULT 1,
  `images` text NOT NULL DEFAULT 'news.gif',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nota_credito`
--

DROP TABLE IF EXISTS `nota_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_credito` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` text DEFAULT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) DEFAULT NULL,
  `rif_doc` text DEFAULT NULL,
  `id_user` int(10) unsigned NOT NULL DEFAULT 0,
  `pagato` int(1) unsigned DEFAULT 1,
  `valuta` int(10) unsigned DEFAULT 1,
  `desc_gen` text DEFAULT NULL,
  `id_pag` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nota_credito_old`
--

DROP TABLE IF EXISTS `nota_credito_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_credito_old` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` varchar(256) NOT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `rif_doc` varchar(20) NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note_incontri`
--

DROP TABLE IF EXISTS `note_incontri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_incontri` (
  `emailDate` date DEFAULT NULL,
  `emailTo` mediumtext DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_iscrizione` int(11) DEFAULT NULL,
  `motivo` varchar(256) DEFAULT NULL,
  `problema` mediumtext DEFAULT NULL,
  `data` date DEFAULT NULL,
  `incontro` tinyint(1) NOT NULL DEFAULT 0,
  `orario` varchar(256) DEFAULT NULL,
  `provvedimento` text DEFAULT NULL,
  `riunione` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28791 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prova`
--

DROP TABLE IF EXISTS `prova`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `prova` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` varchar(200) NOT NULL,
  `id_Teacher` varchar(200) DEFAULT NULL,
  `ih_Level` varchar(200) DEFAULT NULL,
  `ih_Date` varchar(200) DEFAULT NULL,
  `ih_Grade` varchar(200) DEFAULT NULL,
  `ihvar1` varchar(200) DEFAULT NULL,
  `ihvar2` varchar(200) DEFAULT NULL,
  `ihvar3` varchar(200) DEFAULT NULL,
  `ihvar4` varchar(200) DEFAULT NULL,
  `ihvar5` varchar(200) DEFAULT NULL,
  `ihvar6` varchar(200) DEFAULT NULL,
  `ihvar7` varchar(200) DEFAULT NULL,
  `ihvar8` varchar(200) DEFAULT NULL,
  `ihvar9` varchar(200) DEFAULT NULL,
  `ihvar10` varchar(200) DEFAULT NULL,
  `ihvar11` varchar(200) DEFAULT NULL,
  `ihvar12` varchar(200) DEFAULT NULL,
  `ihvar13` varchar(200) DEFAULT NULL,
  `ihvar14` varchar(200) DEFAULT NULL,
  `ihvar15` varchar(200) DEFAULT NULL,
  `ihvar16` varchar(200) DEFAULT NULL,
  `ihvar17` varchar(200) DEFAULT NULL,
  `ihvar18` varchar(200) DEFAULT NULL,
  `ihvar19` varchar(200) DEFAULT NULL,
  `ihvar20` varchar(200) DEFAULT NULL,
  `ihvar21` varchar(200) DEFAULT NULL,
  `ihvar22` varchar(200) DEFAULT NULL,
  `ihvar23` varchar(200) DEFAULT NULL,
  `ihvar24` varchar(200) DEFAULT NULL,
  `ihvar25` varchar(200) DEFAULT NULL,
  `ihvar26` varchar(200) DEFAULT NULL,
  `ihvar27` varchar(200) DEFAULT NULL,
  `ihvar28` varchar(200) DEFAULT NULL,
  `ihvar29` varchar(200) DEFAULT NULL,
  `ihvar30` varchar(200) DEFAULT NULL,
  `ihvar31` varchar(200) DEFAULT NULL,
  `ihvar32` varchar(200) DEFAULT NULL,
  `ihvar33` varchar(200) DEFAULT NULL,
  `ihvar34` varchar(200) DEFAULT NULL,
  `ihvar35` varchar(200) DEFAULT NULL,
  `ihvar36` varchar(200) DEFAULT NULL,
  `ihvar37` varchar(200) DEFAULT NULL,
  `ihvar38` varchar(200) DEFAULT NULL,
  `ihvar39` varchar(200) DEFAULT NULL,
  `ihvar40` varchar(200) DEFAULT NULL,
  `ihvar41` varchar(200) DEFAULT NULL,
  `ihvar42` varchar(200) DEFAULT NULL,
  `ihvar43` varchar(200) DEFAULT NULL,
  `ihvar44` varchar(200) DEFAULT NULL,
  `ihvar45` varchar(200) DEFAULT NULL,
  `ihvar46` varchar(200) DEFAULT NULL,
  `ihvar47` longtext DEFAULT NULL,
  `ihvar48` longtext DEFAULT NULL,
  `ihvar49` longtext DEFAULT NULL,
  `ihvar50` longtext DEFAULT NULL,
  `ihvar51` longtext DEFAULT NULL,
  `ihvar52` longtext DEFAULT NULL,
  `ihvar53` longtext DEFAULT NULL,
  `ihvar54` longtext DEFAULT NULL,
  `ihvar55` longtext DEFAULT NULL,
  `ihvar56` longtext DEFAULT NULL,
  `ihvar57` longtext DEFAULT NULL,
  `ihvar58` longtext DEFAULT NULL,
  `ihvar59` longtext DEFAULT NULL,
  `ihvar60` longtext DEFAULT NULL,
  `ihvar61` longtext DEFAULT NULL,
  `ihvar62` longtext DEFAULT NULL,
  `ihvar63` longtext DEFAULT NULL,
  `ihvar64` longtext DEFAULT NULL,
  `ihvar65` longtext DEFAULT NULL,
  `ihvar66` longtext DEFAULT NULL,
  `ihvar67` longtext DEFAULT NULL,
  `ihvar68` longtext DEFAULT NULL,
  `ihvar69` longtext DEFAULT NULL,
  `ihvar70` longtext DEFAULT NULL,
  `ihvar71` longtext DEFAULT NULL,
  `ihvar72` longtext DEFAULT NULL,
  `ih_Ans1ok` text DEFAULT NULL,
  `ih_Ans2ok` text DEFAULT NULL,
  `ih_Ans3ok` text DEFAULT NULL,
  `ih_Ans4ok` text DEFAULT NULL,
  `ih_Ans5ok` text DEFAULT NULL,
  `ih_Ans6ok` text DEFAULT NULL,
  `ih_Ans7ok` text DEFAULT NULL,
  `ih_Ans8ok` text DEFAULT NULL,
  `ih_Ans9ok` text DEFAULT NULL,
  `ih_Ans10ok` text DEFAULT NULL,
  `ih_Remarks` longtext DEFAULT NULL,
  `ih_Extra_Points` varchar(45) DEFAULT NULL,
  `id_corso` varchar(45) NOT NULL,
  `book` varchar(45) NOT NULL,
  `1` varchar(45) DEFAULT NULL,
  `2` varchar(45) DEFAULT NULL,
  `3` varchar(45) DEFAULT NULL,
  `4` varchar(45) DEFAULT NULL,
  `5` varchar(45) DEFAULT NULL,
  `6` varchar(45) DEFAULT NULL,
  `7` varchar(45) DEFAULT NULL,
  `8` varchar(45) DEFAULT NULL,
  `9` varchar(45) DEFAULT NULL,
  `10` varchar(45) DEFAULT NULL,
  `ex4_total` varchar(100) DEFAULT NULL,
  `ihvar73` varchar(200) DEFAULT NULL,
  `ihvar75` varchar(200) DEFAULT NULL,
  `ihvar76` varchar(200) DEFAULT NULL,
  `ihvar77` varchar(200) DEFAULT NULL,
  `ihvar78` varchar(200) DEFAULT NULL,
  `ihvar79` varchar(299) DEFAULT NULL,
  `ihvar80` varchar(200) DEFAULT NULL,
  `ihvar74` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `psp_registration`
--

DROP TABLE IF EXISTS `psp_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `psp_registration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` varchar(15) NOT NULL,
  `limit` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1981 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `psp_registration_booking`
--

DROP TABLE IF EXISTS `psp_registration_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `psp_registration_booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `id_psp` int(10) unsigned NOT NULL DEFAULT 0,
  `name` text NOT NULL,
  `surname` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ana_psp` (`id_ana`,`id_psp`)
) ENGINE=InnoDB AUTO_INCREMENT=13499 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ricevuta`
--

DROP TABLE IF EXISTS `ricevuta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ricevuta` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` text DEFAULT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` tinytext DEFAULT NULL,
  `id_ana` int(10) unsigned NOT NULL DEFAULT 0,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  `pagato` int(1) unsigned DEFAULT 1,
  `valuta` int(10) unsigned NOT NULL DEFAULT 1,
  `desc_gen` text DEFAULT NULL,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ricevuta_contanti`
--

DROP TABLE IF EXISTS `ricevuta_contanti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ricevuta_contanti` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` text DEFAULT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` int(11) NOT NULL,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  `pagato` int(1) unsigned DEFAULT 1,
  `valuta` int(10) unsigned NOT NULL DEFAULT 1,
  `desc_gen` text DEFAULT NULL,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ricevuta_old`
--

DROP TABLE IF EXISTS `ricevuta_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ricevuta_old` (
  `num_doc` varchar(10) NOT NULL,
  `int_doc` varchar(256) NOT NULL,
  `data_doc` datetime NOT NULL,
  `pag_doc` varchar(100) NOT NULL,
  `art_desc` text NOT NULL,
  `note_doc` text NOT NULL,
  `imponibile` float(10,2) NOT NULL,
  `iva` float(7,2) NOT NULL,
  `bolli` float(5,2) NOT NULL,
  `totale` float(10,2) NOT NULL,
  `id_pag` int(11) NOT NULL,
  `datifatt` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sap`
--

DROP TABLE IF EXISTS `sap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sap` (
  `ih_ID` text DEFAULT NULL,
  `ih_FinalResult` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `hom_percent` text DEFAULT NULL,
  `ih_Y_hom_pos` text DEFAULT NULL,
  `voc_percent` text DEFAULT NULL,
  `ih_Y_voc_pos` text DEFAULT NULL,
  `lis_percent` text DEFAULT NULL,
  `ih_Y_lis_pos` text DEFAULT NULL,
  `wri_percent` text DEFAULT NULL,
  `ih_Y_wri_pos` text DEFAULT NULL,
  `gui_percent` text DEFAULT NULL,
  `ih_Y_gui_pos` text DEFAULT NULL,
  `spe_percent` text DEFAULT NULL,
  `ih_Y_spe_pos` text DEFAULT NULL,
  `gra_percent` text DEFAULT NULL,
  `ih_Y_gra_pos` text DEFAULT NULL,
  `fin_percent` text DEFAULT NULL,
  `ih_Y_fin_pos` text DEFAULT NULL,
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cod_course` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2536 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sapfin`
--

DROP TABLE IF EXISTS `sapfin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sapfin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` text DEFAULT NULL,
  `ih_overall` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `hom` text DEFAULT NULL,
  `voc` text DEFAULT NULL,
  `lis` text DEFAULT NULL,
  `wri` text DEFAULT NULL,
  `gui` text DEFAULT NULL,
  `spe` text DEFAULT NULL,
  `gra` text DEFAULT NULL,
  `fin` text DEFAULT NULL,
  `cod_course` varchar(45) NOT NULL,
  `ih_pro` varchar(45) DEFAULT NULL,
  `ih_acc` varchar(45) DEFAULT NULL,
  `ih_ran` varchar(45) DEFAULT NULL,
  `ih_com` varchar(45) DEFAULT NULL,
  `attendance` varchar(45) DEFAULT NULL,
  `rea` varchar(45) DEFAULT NULL,
  `lstG` varchar(3) DEFAULT NULL,
  `approved` int(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7411 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saporal`
--

DROP TABLE IF EXISTS `saporal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `saporal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ih_id` text DEFAULT NULL,
  `ih_FinalResult` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `ih_pro` text DEFAULT NULL,
  `ih_acc` text DEFAULT NULL,
  `ih_ran` text DEFAULT NULL,
  `ih_com` text DEFAULT NULL,
  `overall` text DEFAULT NULL,
  `ih_att` text DEFAULT NULL,
  `test_result` text DEFAULT NULL,
  `cod_course` varchar(45) NOT NULL,
  `gui` varchar(45) DEFAULT NULL,
  `home` varchar(45) DEFAULT NULL,
  `lstG` varchar(3) DEFAULT NULL,
  `approved` int(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6582 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext DEFAULT NULL,
  `school_name` tinytext DEFAULT NULL,
  `logo_url` mediumtext DEFAULT NULL,
  `timezone` text DEFAULT 'IT',
  `countrycode` varchar(3) DEFAULT NULL,
  `owner` tinytext DEFAULT NULL,
  `phone` tinytext DEFAULT NULL,
  `email` tinytext DEFAULT NULL,
  `website` mediumtext DEFAULT NULL,
  `default_ihcoin` int(3) NOT NULL DEFAULT 0,
  `status` int(2) unsigned NOT NULL DEFAULT 0,
  `cambridgeAffilate` int(2) unsigned NOT NULL DEFAULT 0,
  `deleted` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school_note`
--

DROP TABLE IF EXISTS `school_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idS` int(10) unsigned DEFAULT NULL,
  `emailDate` date DEFAULT NULL,
  `emailTo` mediumtext DEFAULT NULL,
  `motivo` varchar(256) DEFAULT NULL,
  `problema` mediumtext DEFAULT NULL,
  `data` date DEFAULT NULL,
  `incontro` tinyint(1) NOT NULL DEFAULT 0,
  `orario` varchar(256) DEFAULT NULL,
  `provvedimento` mediumtext DEFAULT NULL,
  `riunione` varchar(256) DEFAULT NULL,
  `status` varchar(256) DEFAULT NULL,
  `task` varchar(256) DEFAULT NULL,
  `link_name` varchar(256) DEFAULT NULL,
  `link` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `idtest` int(11) NOT NULL AUTO_INCREMENT,
  `ihvar1` varchar(45) DEFAULT NULL,
  `ihvar2` varchar(45) DEFAULT NULL,
  `ihvar3` varchar(45) DEFAULT NULL,
  `ihvar4` varchar(45) DEFAULT NULL,
  `ihvar13` varchar(45) DEFAULT NULL,
  `ihvar14` varchar(45) DEFAULT NULL,
  `ihvar15` varchar(45) DEFAULT NULL,
  `ihvar16` varchar(45) DEFAULT NULL,
  `ihvar17` varchar(45) DEFAULT NULL,
  `ihvar20` varchar(45) DEFAULT NULL,
  `ihvar25` varchar(45) DEFAULT NULL,
  `ihvar28` varchar(45) DEFAULT NULL,
  `ihvar32` varchar(45) DEFAULT NULL,
  `ihvar36` varchar(45) DEFAULT NULL,
  `ihvar40` varchar(45) DEFAULT NULL,
  `ihvar42` varchar(45) DEFAULT NULL,
  `ihvar45` varchar(45) DEFAULT NULL,
  `ihvar50` varchar(45) DEFAULT NULL,
  `ihvar53` varchar(45) DEFAULT NULL,
  `ihvar57` varchar(45) DEFAULT NULL,
  `ihvar60` varchar(45) DEFAULT NULL,
  `ihvar63` varchar(45) DEFAULT NULL,
  `ihvar66` varchar(45) DEFAULT NULL,
  `ihvar5` varchar(45) DEFAULT NULL,
  `ihvar6` varchar(45) DEFAULT NULL,
  `ihvar7` varchar(45) DEFAULT NULL,
  `ihvar8` varchar(45) DEFAULT NULL,
  `ihvar9` varchar(45) DEFAULT NULL,
  `ihvar10` varchar(45) DEFAULT NULL,
  `ihvar11` varchar(45) DEFAULT NULL,
  `ihvar12` varchar(45) DEFAULT NULL,
  `ih_Date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtest`)
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `user` text NOT NULL,
  `pass` text NOT NULL,
  `grant` int(10) unsigned NOT NULL,
  `id_ana` int(11) unsigned NOT NULL DEFAULT 0,
  `credit` int(2) unsigned NOT NULL DEFAULT 0,
  `uid` int(10) unsigned NOT NULL,
  `id_school` int(10) unsigned NOT NULL DEFAULT 0,
  `passR` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text DEFAULT NULL,
  `password` varchar(40) NOT NULL,
  `uid` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valuta`
--

DROP TABLE IF EXISTS `valuta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `valuta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) DEFAULT NULL,
  `sigla` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ylfce`
--

DROP TABLE IF EXISTS `ylfce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ylfce` (
  `ih_ID` text DEFAULT NULL,
  `ih_FinalResult` text DEFAULT NULL,
  `ih_Notes` text DEFAULT NULL,
  `hom_percent` text DEFAULT NULL,
  `ih_Y_hom_pos` text DEFAULT NULL,
  `use_percent` text DEFAULT NULL,
  `ih_Y_use_pos` text DEFAULT NULL,
  `lis_percent` text DEFAULT NULL,
  `ih_Y_lis_pos` text DEFAULT NULL,
  `wri_percent` text DEFAULT NULL,
  `ih_Y_wri_pos` text DEFAULT NULL,
  `self_percent` text DEFAULT NULL,
  `ih_Y_self_pos` text DEFAULT NULL,
  `spe_percent` text DEFAULT NULL,
  `ih_Y_spe_pos` text DEFAULT NULL,
  `rea_percent` text DEFAULT NULL,
  `ih_Y_rea_pos` text DEFAULT NULL,
  `atti_percent` text DEFAULT NULL,
  `ih_Y_atti_pos` text DEFAULT NULL,
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cod_course` varchar(45) NOT NULL,
  `atte_percent` varchar(45) DEFAULT NULL,
  `ih_Y_atte_pos` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ylmentry`
--

DROP TABLE IF EXISTS `ylmentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ylmentry` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ih_ID` tinytext NOT NULL,
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ih_Date` varchar(200) DEFAULT NULL,
  `ih_Grade` varchar(200) DEFAULT NULL,
  `blob` longtext DEFAULT NULL,
  `nome` text DEFAULT NULL,
  `cognome` text DEFAULT NULL,
  `email` text NOT NULL,
  `school` text NOT NULL,
  `ylcode` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `AnaLevel`
--

/*!50001 DROP VIEW IF EXISTS `AnaLevel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`c1ih_pa`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AnaLevel` AS select distinct `a`.`ID` AS `ID`,`a`.`level` AS `prev level`,`ce`.`codice` AS `codice`,`cl`.`descrizione` AS `level`,`cl`.`cefr` AS `cefr`,`ce`.`id` AS `cid` from (((`Anagrafica` `a` join `corsi_iscrizioni` `ci`) join `corsi_elenco` `ce`) join `corsi_livelli` `cl`) where `a`.`ID` = `ci`.`id_corsista` and `ce`.`id` = `ci`.`id_corso` and `ce`.`esame` = 'corso' and `ce`.`id_livello` = `cl`.`id` and `cl`.`tipologia` = 'Adults' and `cl`.`descrizione` <> 'Extra' and `cl`.`descrizione` <> 'StudySupport' and `cl`.`descrizione` <> 'EnglishAnyTime' and `cl`.`descrizione` <> 'Morning' and `cl`.`descrizione` <> 'Other Languages' and `cl`.`descrizione` <> 'CELTA-GP' and `cl`.`descrizione` <> 'CELTA-TT' and `cl`.`descrizione` <> 'IELTS' and `cl`.`descrizione` <> '0-Beg' and `cl`.`descrizione` <> '1-to-1' and `cl`.`descrizione` <> 'Guinea Pig' and `cl`.`descrizione` <> 'TSA' and `cl`.`descrizione` <> 'BMAT' and `cl`.`descrizione` <> 'NSAA' and `cl`.`descrizione` <> 'Test' and `cl`.`descrizione` <> 'STEP' and `cl`.`descrizione` <> 'CPE' and `cl`.`descrizione` <> 'ILEC' and `cl`.`descrizione` <> 'ConInt' and `cl`.`descrizione` <> 'Saturday' order by `a`.`ID`,`ce`.`id` desc */;
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

-- Dump completed on 2026-10-07  2:18:30
