-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: 1141029_clinic
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` date NOT NULL COMMENT '''YYYY-MM-DD''',
  `status` enum('已預約','已看診','取消') DEFAULT '已預約',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  KEY `fk001_idx` (`patient_id`),
  KEY `fk002_idx` (`doctor_id`),
  CONSTRAINT `fk001` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `fk002` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `records_id` int NOT NULL,
  `registration_fee` int DEFAULT '200',
  `vaccine_fee` int DEFAULT '0',
  `total` int GENERATED ALWAYS AS ((`registration_fee` + `vaccine_fee`)) STORED,
  `paid` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bill_id`),
  KEY `billing_ibfk_1_idx` (`records_id`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`records_id`) REFERENCES `medical_records` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `specialty` varchar(45) DEFAULT NULL,
  `license_no` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `license_no_UNIQUE` (`license_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medical_records`
--

DROP TABLE IF EXISTS `medical_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL COMMENT '關聯掛號',
  `symptoms` text COMMENT '症狀',
  `vaccine_id` int DEFAULT NULL COMMENT '疫苗名稱',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `record_id_UNIQUE` (`record_id`),
  KEY `fK_appointments` (`appointment_id`),
  KEY `fk_vaccine` (`vaccine_id`),
  CONSTRAINT `fk_appointments` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`),
  CONSTRAINT `fk_vaccine` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines` (`vaccine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `national_id` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `gender` enum('M','F') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `id_number_UNIQUE` (`national_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `report01`
--

DROP TABLE IF EXISTS `report01`;
/*!50001 DROP VIEW IF EXISTS `report01`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report01` AS SELECT 
 1 AS `預約ID`,
 1 AS `病人ID`,
 1 AS `病人`,
 1 AS `醫師`,
 1 AS `預約時間`,
 1 AS `預約狀態`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report02`
--

DROP TABLE IF EXISTS `report02`;
/*!50001 DROP VIEW IF EXISTS `report02`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report02` AS SELECT 
 1 AS `病例編號`,
 1 AS `掛號號碼`,
 1 AS `病人`,
 1 AS `醫生`,
 1 AS `看診日期`,
 1 AS `症狀`,
 1 AS `疫苗`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report04`
--

DROP TABLE IF EXISTS `report04`;
/*!50001 DROP VIEW IF EXISTS `report04`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report04` AS SELECT 
 1 AS `繳費單號`,
 1 AS `病例編號`,
 1 AS `掛號費`,
 1 AS `疫苗名稱`,
 1 AS `疫苗金額`,
 1 AS `總金額`,
 1 AS `付款狀態`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report05`
--

DROP TABLE IF EXISTS `report05`;
/*!50001 DROP VIEW IF EXISTS `report05`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report05` AS SELECT 
 1 AS `bill_id`,
 1 AS `繳費單號`,
 1 AS `病例編號`,
 1 AS `病人`,
 1 AS `身分證`,
 1 AS `掛號費`,
 1 AS `疫苗名稱`,
 1 AS `疫苗金額`,
 1 AS `總金額`,
 1 AS `paid`,
 1 AS `付費狀態`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report06`
--

DROP TABLE IF EXISTS `report06`;
/*!50001 DROP VIEW IF EXISTS `report06`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report06` AS SELECT 
 1 AS `bill_id`,
 1 AS `records_id`,
 1 AS `national_id`,
 1 AS `registration_fee`,
 1 AS `vaccine_name`,
 1 AS `vaccine_fee`,
 1 AS `total`,
 1 AS `paid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report07`
--

DROP TABLE IF EXISTS `report07`;
/*!50001 DROP VIEW IF EXISTS `report07`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report07` AS SELECT 
 1 AS `bill_id`,
 1 AS `records_id`,
 1 AS `national_id`,
 1 AS `registration_fee`,
 1 AS `vaccine_fee`,
 1 AS `total`,
 1 AS `paid`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vaccines`
--

DROP TABLE IF EXISTS `vaccines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines` (
  `vaccine_id` int NOT NULL AUTO_INCREMENT,
  `vaccine_name` varchar(100) NOT NULL,
  `manufacturer` varchar(100) DEFAULT NULL COMMENT '廠商',
  `vaccine_price` int DEFAULT '0' COMMENT '疫苗價格(元)',
  PRIMARY KEY (`vaccine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `report01`
--

/*!50001 DROP VIEW IF EXISTS `report01`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report01` AS select `a`.`appointment_id` AS `預約ID`,`p`.`national_id` AS `病人ID`,`p`.`name` AS `病人`,`d`.`name` AS `醫師`,`a`.`appointment_date` AS `預約時間`,`a`.`status` AS `預約狀態` from ((`appointments` `a` left join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) left join `doctors` `d` on((`a`.`doctor_id` = `d`.`doctor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report02`
--

/*!50001 DROP VIEW IF EXISTS `report02`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report02` AS select `m`.`record_id` AS `病例編號`,`a`.`appointment_id` AS `掛號號碼`,`p`.`name` AS `病人`,`d`.`name` AS `醫生`,`a`.`appointment_date` AS `看診日期`,`m`.`symptoms` AS `症狀`,`v`.`vaccine_name` AS `疫苗` from ((((`medical_records` `m` left join `appointments` `a` on((`m`.`appointment_id` = `a`.`appointment_id`))) left join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) left join `doctors` `d` on((`a`.`doctor_id` = `d`.`doctor_id`))) left join `vaccines` `v` on((`m`.`vaccine_id` = `v`.`vaccine_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report04`
--

/*!50001 DROP VIEW IF EXISTS `report04`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report04` AS select `b`.`bill_id` AS `繳費單號`,`b`.`records_id` AS `病例編號`,`b`.`registration_fee` AS `掛號費`,`v`.`vaccine_name` AS `疫苗名稱`,`b`.`vaccine_fee` AS `疫苗金額`,`b`.`total` AS `總金額`,`b`.`paid` AS `付款狀態` from ((`billing` `b` left join `medical_records` `m` on((`b`.`records_id` = `m`.`record_id`))) left join `vaccines` `v` on((`m`.`vaccine_id` = `v`.`vaccine_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report05`
--

/*!50001 DROP VIEW IF EXISTS `report05`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report05` AS select `b`.`bill_id` AS `bill_id`,`b`.`bill_id` AS `繳費單號`,`b`.`records_id` AS `病例編號`,`p`.`name` AS `病人`,`p`.`national_id` AS `身分證`,`b`.`registration_fee` AS `掛號費`,`v`.`vaccine_name` AS `疫苗名稱`,`b`.`vaccine_fee` AS `疫苗金額`,`b`.`total` AS `總金額`,`b`.`paid` AS `paid`,`b`.`paid` AS `付費狀態` from (((`billing` `b` join `medical_records` `m` on((`b`.`records_id` = `m`.`record_id`))) join `patients` `p` on((`m`.`appointment_id` = `p`.`patient_id`))) left join `vaccines` `v` on((`m`.`vaccine_id` = `v`.`vaccine_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report06`
--

/*!50001 DROP VIEW IF EXISTS `report06`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report06` AS select `b`.`bill_id` AS `bill_id`,`b`.`records_id` AS `records_id`,`p`.`national_id` AS `national_id`,`b`.`registration_fee` AS `registration_fee`,`v`.`vaccine_name` AS `vaccine_name`,`b`.`vaccine_fee` AS `vaccine_fee`,`b`.`total` AS `total`,`b`.`paid` AS `paid` from ((((`billing` `b` left join `medical_records` `m` on((`b`.`records_id` = `m`.`record_id`))) left join `appointments` `a` on((`m`.`appointment_id` = `a`.`appointment_id`))) left join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) left join `vaccines` `v` on((`m`.`vaccine_id` = `v`.`vaccine_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report07`
--

/*!50001 DROP VIEW IF EXISTS `report07`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report07` AS select `b`.`bill_id` AS `bill_id`,`b`.`records_id` AS `records_id`,`p`.`national_id` AS `national_id`,`b`.`registration_fee` AS `registration_fee`,`b`.`vaccine_fee` AS `vaccine_fee`,`b`.`total` AS `total`,`b`.`paid` AS `paid`,`b`.`created_at` AS `created_at`,`b`.`updated_at` AS `updated_at` from (((`billing` `b` left join `medical_records` `m` on((`b`.`records_id` = `m`.`record_id`))) left join `appointments` `a` on((`m`.`appointment_id` = `a`.`appointment_id`))) left join `patients` `p` on((`a`.`patient_id` = `p`.`patient_id`))) */;
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

-- Dump completed on 2026-01-28 14:04:14
