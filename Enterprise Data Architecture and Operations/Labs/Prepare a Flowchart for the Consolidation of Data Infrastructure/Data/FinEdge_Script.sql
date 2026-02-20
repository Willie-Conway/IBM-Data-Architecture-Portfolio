
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: finedge_consolidation
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `data_sources`
--

DROP TABLE IF EXISTS `data_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_sources` (
  `Source_ID` int NOT NULL AUTO_INCREMENT,
  `Source_Name` varchar(100) NOT NULL,
  `Source_Type` varchar(50) DEFAULT NULL,
  `Description` text,
  `Data_Format` varchar(50) DEFAULT NULL,
  `Volume_Estimate_GB` decimal(10,2) DEFAULT NULL,
  `Update_Frequency` varchar(50) DEFAULT NULL,
  `Criticality` enum('Low','Medium','High','Critical') DEFAULT 'Medium',
  `PII_Flag` tinyint(1) DEFAULT '0',
  `Status` enum('Active','Inactive','Legacy','Deprecated') DEFAULT 'Active',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Source_ID`),
  UNIQUE KEY `Source_Name_UNIQUE` (`Source_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_ingestion`
--

DROP TABLE IF EXISTS `data_ingestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_ingestion` (
  `Ingestion_ID` int NOT NULL AUTO_INCREMENT,
  `Source_ID` int DEFAULT NULL,
  `Ingestion_Method` enum('Batch','Streaming','Real-time','Micro-batch') DEFAULT NULL,
  `Frequency` varchar(50) DEFAULT NULL,
  `Pipeline_Name` varchar(100) DEFAULT NULL,
  `Tool_Used` varchar(100) DEFAULT NULL,
  `Validation_Status` enum('Pending','Passed','Failed','Warning') DEFAULT 'Pending',
  `Last_Run_Date` timestamp NULL DEFAULT NULL,
  `Next_Scheduled_Run` timestamp NULL DEFAULT NULL,
  `Records_Processed` bigint DEFAULT NULL,
  `Data_Volume_MB` decimal(10,2) DEFAULT NULL,
  `Error_Count` int DEFAULT '0',
  PRIMARY KEY (`Ingestion_ID`),
  KEY `source_idx` (`Source_ID`),
  CONSTRAINT `fk_ingestion_source` FOREIGN KEY (`Source_ID`) REFERENCES `data_sources` (`Source_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validation_checks`
--

DROP TABLE IF EXISTS `validation_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validation_checks` (
  `Check_ID` int NOT NULL AUTO_INCREMENT,
  `Ingestion_ID` int DEFAULT NULL,
  `Check_Type` enum('Format','Completeness','Schema','Uniqueness','Accuracy','Timeliness') DEFAULT NULL,
  `Check_Name` varchar(100) DEFAULT NULL,
  `Validation_Rule` text,
  `Result` enum('Pass','Fail','Warning','Not Run') DEFAULT 'Not Run',
  `Error_Message` text,
  `Records_Validated` int DEFAULT NULL,
  `Records_Failed` int DEFAULT NULL,
  `Check_Timestamp` timestamp NULL DEFAULT NULL,
  `Checked_By` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Check_ID`),
  KEY `ingestion_idx` (`Ingestion_ID`),
  CONSTRAINT `fk_validation_ingestion` FOREIGN KEY (`Ingestion_ID`) REFERENCES `data_ingestion` (`Ingestion_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_tiers`
--

DROP TABLE IF EXISTS `storage_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_tiers` (
  `Storage_ID` int NOT NULL AUTO_INCREMENT,
  `Tier_Name` varchar(50) NOT NULL,
  `Storage_Type` enum('Data Lake','Data Warehouse','Data Mart','Operational Store') DEFAULT NULL,
  `Description` text,
  `Technology` varchar(100) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `Total_Capacity_TB` decimal(10,2) DEFAULT NULL,
  `Used_Capacity_TB` decimal(10,2) DEFAULT '0.00',
  `Retention_Policy` varchar(255) DEFAULT NULL,
  `Backup_Frequency` varchar(50) DEFAULT NULL,
  `DR_Enabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Storage_ID`),
  UNIQUE KEY `Tier_Name_UNIQUE` (`Tier_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_storage`
--

DROP TABLE IF EXISTS `data_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_storage` (
  `Data_Storage_ID` int NOT NULL AUTO_INCREMENT,
  `Source_ID` int DEFAULT NULL,
  `Storage_ID` int DEFAULT NULL,
  `Dataset_Name` varchar(100) NOT NULL,
  `Schema_Name` varchar(100) DEFAULT NULL,
  `Table_Name` varchar(100) DEFAULT NULL,
  `Record_Count` bigint DEFAULT NULL,
  `Size_MB` decimal(10,2) DEFAULT NULL,
  `Partition_Key` varchar(50) DEFAULT NULL,
  `Compression_Type` varchar(30) DEFAULT NULL,
  `Ingestion_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Data_Storage_ID`),
  KEY `source_idx` (`Source_ID`),
  KEY `storage_idx` (`Storage_ID`),
  CONSTRAINT `fk_datastorage_source` FOREIGN KEY (`Source_ID`) REFERENCES `data_sources` (`Source_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_datastorage_tier` FOREIGN KEY (`Storage_ID`) REFERENCES `storage_tiers` (`Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_tools`
--

DROP TABLE IF EXISTS `etl_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_tools` (
  `Tool_ID` int NOT NULL AUTO_INCREMENT,
  `Tool_Name` varchar(100) NOT NULL,
  `Tool_Type` enum('ETL','ELT','Data Pipeline','Orchestration') DEFAULT NULL,
  `Vendor` varchar(100) DEFAULT NULL,
  `Version` varchar(20) DEFAULT NULL,
  `Description` text,
  `License_Type` varchar(50) DEFAULT NULL,
  `Deployment` enum('On-Premise','Cloud','Hybrid') DEFAULT NULL,
  `Status` enum('Active','Inactive','Evaluation') DEFAULT 'Active',
  PRIMARY KEY (`Tool_ID`),
  UNIQUE KEY `Tool_Name_UNIQUE` (`Tool_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_jobs`
--

DROP TABLE IF EXISTS `etl_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_jobs` (
  `Job_ID` int NOT NULL AUTO_INCREMENT,
  `Job_Name` varchar(100) NOT NULL,
  `Tool_ID` int DEFAULT NULL,
  `Source_Storage_ID` int DEFAULT NULL,
  `Target_Storage_ID` int DEFAULT NULL,
  `Job_Type` enum('Extract','Transform','Load','Full ETL') DEFAULT NULL,
  `Schedule` varchar(100) DEFAULT NULL,
  `Last_Run_Start` timestamp NULL DEFAULT NULL,
  `Last_Run_End` timestamp NULL DEFAULT NULL,
  `Duration_Seconds` int DEFAULT NULL,
  `Records_Processed` bigint DEFAULT NULL,
  `Status` enum('Running','Completed','Failed','Scheduled','Idle') DEFAULT 'Idle',
  `Error_Log` text,
  PRIMARY KEY (`Job_ID`),
  UNIQUE KEY `Job_Name_UNIQUE` (`Job_Name`),
  KEY `tool_idx` (`Tool_ID`),
  KEY `source_storage_idx` (`Source_Storage_ID`),
  KEY `target_storage_idx` (`Target_Storage_ID`),
  CONSTRAINT `fk_etljob_tool` FOREIGN KEY (`Tool_ID`) REFERENCES `etl_tools` (`Tool_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_etljob_source` FOREIGN KEY (`Source_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_etljob_target` FOREIGN KEY (`Target_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integration_apis`
--

DROP TABLE IF EXISTS `integration_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integration_apis` (
  `API_ID` int NOT NULL AUTO_INCREMENT,
  `API_Name` varchar(100) NOT NULL,
  `API_Type` enum('REST','GraphQL','SOAP','gRPC') DEFAULT NULL,
  `Endpoint_URL` varchar(255) DEFAULT NULL,
  `Version` varchar(10) DEFAULT NULL,
  `Authentication_Method` enum('OAuth2','API Key','JWT','Basic Auth','mTLS') DEFAULT NULL,
  `Rate_Limit` int DEFAULT NULL,
  `Description` text,
  `Owner_Department` varchar(100) DEFAULT NULL,
  `Status` enum('Active','Deprecated','Development','Testing') DEFAULT 'Active',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`API_ID`),
  UNIQUE KEY `API_Name_UNIQUE` (`API_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_consumers`
--

DROP TABLE IF EXISTS `api_consumers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_consumers` (
  `Consumer_ID` int NOT NULL AUTO_INCREMENT,
  `API_ID` int DEFAULT NULL,
  `Consumer_Name` varchar(100) DEFAULT NULL,
  `Consumer_Type` enum('Application','Department','External Partner') DEFAULT NULL,
  `Client_ID` varchar(100) DEFAULT NULL,
  `Access_Token` text,
  `Daily_Quota` int DEFAULT NULL,
  `Calls_Made_Today` int DEFAULT '0',
  `Last_Access` timestamp NULL DEFAULT NULL,
  `Status` enum('Active','Suspended','Revoked') DEFAULT 'Active',
  PRIMARY KEY (`Consumer_ID`),
  KEY `api_idx` (`API_ID`),
  CONSTRAINT `fk_apiconsumer_api` FOREIGN KEY (`API_ID`) REFERENCES `integration_apis` (`API_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encryption_keys`
--

DROP TABLE IF EXISTS `encryption_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encryption_keys` (
  `Key_ID` int NOT NULL AUTO_INCREMENT,
  `Key_Name` varchar(100) NOT NULL,
  `Key_Type` enum('Symmetric','Asymmetric','Hash') DEFAULT NULL,
  `Algorithm` varchar(50) DEFAULT NULL,
  `Key_Length` int DEFAULT NULL,
  `Key_Purpose` enum('At Rest','In Transit','Tokenization','Masking') DEFAULT NULL,
  `Creation_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Expiry_Date` date DEFAULT NULL,
  `Rotation_Frequency_Days` int DEFAULT NULL,
  `Last_Rotated` date DEFAULT NULL,
  `Status` enum('Active','Expired','Revoked','Pending') DEFAULT 'Active',
  `HSM_Protected` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Key_ID`),
  UNIQUE KEY `Key_Name_UNIQUE` (`Key_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encryption_policies`
--

DROP TABLE IF EXISTS `encryption_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encryption_policies` (
  `Policy_ID` int NOT NULL AUTO_INCREMENT,
  `Storage_ID` int DEFAULT NULL,
  `Key_ID` int DEFAULT NULL,
  `Encryption_Scope` enum('Full Database','Table','Column','File') DEFAULT NULL,
  `Target_Name` varchar(100) DEFAULT NULL,
  `Enabled` tinyint(1) DEFAULT '1',
  `Applied_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Policy_ID`),
  KEY `storage_idx` (`Storage_ID`),
  KEY `key_idx` (`Key_ID`),
  CONSTRAINT `fk_encrypt_storage` FOREIGN KEY (`Storage_ID`) REFERENCES `storage_tiers` (`Storage_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_encrypt_key` FOREIGN KEY (`Key_ID`) REFERENCES `encryption_keys` (`Key_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_controls`
--

DROP TABLE IF EXISTS `access_controls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_controls` (
  `Access_ID` int NOT NULL AUTO_INCREMENT,
  `Control_Name` varchar(100) NOT NULL,
  `Control_Type` enum('RBAC','ABAC','MAC','DAC') DEFAULT NULL,
  `Description` text,
  `Authentication_Method` enum('Password','MFA','SSO','Biometric','Certificate') DEFAULT NULL,
  `MFA_Required` tinyint(1) DEFAULT '0',
  `Session_Timeout_Minutes` int DEFAULT '30',
  `Max_Login_Attempts` int DEFAULT '5',
  PRIMARY KEY (`Access_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `Role_ID` int NOT NULL AUTO_INCREMENT,
  `Role_Name` varchar(50) NOT NULL,
  `Description` text,
  `Access_ID` int DEFAULT NULL,
  `Row_Level_Security` tinyint(1) DEFAULT '0',
  `Column_Level_Security` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Role_ID`),
  UNIQUE KEY `Role_Name_UNIQUE` (`Role_Name`),
  KEY `access_idx` (`Access_ID`),
  CONSTRAINT `fk_role_access` FOREIGN KEY (`Access_ID`) REFERENCES `access_controls` (`Access_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Role_ID` int DEFAULT NULL,
  `MFA_Enabled` tinyint(1) DEFAULT '0',
  `Last_Login` timestamp NULL DEFAULT NULL,
  `Account_Expiry` date DEFAULT NULL,
  `Password_Last_Changed` date DEFAULT NULL,
  `Status` enum('Active','Inactive','Locked','Expired') DEFAULT 'Active',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `role_idx` (`Role_ID`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`Role_ID`) REFERENCES `user_roles` (`Role_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadata_repository`
--

DROP TABLE IF EXISTS `metadata_repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadata_repository` (
  `Metadata_ID` int NOT NULL AUTO_INCREMENT,
  `Asset_Name` varchar(100) NOT NULL,
  `Asset_Type` enum('Table','Column','View','Report','Dashboard','Pipeline') DEFAULT NULL,
  `Data_Storage_ID` int DEFAULT NULL,
  `Description` text,
  `Business_Definition` text,
  `Data_Type` varchar(50) DEFAULT NULL,
  `Is_PII` tinyint(1) DEFAULT '0',
  `Is_Sensitive` tinyint(1) DEFAULT '0',
  `Data_Owner` varchar(100) DEFAULT NULL,
  `Data_Steward` varchar(100) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Metadata_ID`),
  KEY `storage_idx` (`Data_Storage_ID`),
  CONSTRAINT `fk_metadata_storage` FOREIGN KEY (`Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_lineage`
--

DROP TABLE IF EXISTS `data_lineage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_lineage` (
  `Lineage_ID` int NOT NULL AUTO_INCREMENT,
  `Source_Asset_ID` int DEFAULT NULL,
  `Target_Asset_ID` int DEFAULT NULL,
  `Transformation_Type` varchar(100) DEFAULT NULL,
  `ETL_Job_ID` int DEFAULT NULL,
  `Transformation_Logic` text,
  `Created_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Lineage_ID`),
  KEY `source_idx` (`Source_Asset_ID`),
  KEY `target_idx` (`Target_Asset_ID`),
  KEY `job_idx` (`ETL_Job_ID`),
  CONSTRAINT `fk_lineage_source` FOREIGN KEY (`Source_Asset_ID`) REFERENCES `metadata_repository` (`Metadata_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_lineage_target` FOREIGN KEY (`Target_Asset_ID`) REFERENCES `metadata_repository` (`Metadata_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_lineage_job` FOREIGN KEY (`ETL_Job_ID`) REFERENCES `etl_jobs` (`Job_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_quality_rules`
--

DROP TABLE IF EXISTS `data_quality_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_quality_rules` (
  `Rule_ID` int NOT NULL AUTO_INCREMENT,
  `Rule_Name` varchar(100) NOT NULL,
  `Rule_Type` enum('Format','Completeness','Uniqueness','Accuracy','Consistency','Timeliness') DEFAULT NULL,
  `Description` text,
  `Rule_Definition` text,
  `Severity` enum('Critical','High','Medium','Low') DEFAULT 'Medium',
  `Auto_Remediate` tinyint(1) DEFAULT '0',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Rule_ID`),
  UNIQUE KEY `Rule_Name_UNIQUE` (`Rule_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_quality_checks`
--

DROP TABLE IF EXISTS `data_quality_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_quality_checks` (
  `Check_ID` int NOT NULL AUTO_INCREMENT,
  `Rule_ID` int DEFAULT NULL,
  `Data_Storage_ID` int DEFAULT NULL,
  `Check_Stage` enum('Ingestion','Storage','Pre-Reporting','Post-ETL') DEFAULT NULL,
  `Execution_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Records_Checked` bigint DEFAULT NULL,
  `Records_Passed` bigint DEFAULT NULL,
  `Records_Failed` bigint DEFAULT NULL,
  `Pass_Percentage` decimal(5,2) GENERATED ALWAYS AS ((`Records_Passed` / NULLIF(`Records_Checked`, 0)) * 100) STORED,
  `Error_Details` json DEFAULT NULL,
  `Status` enum('Passed','Failed','Warning','Running') DEFAULT 'Running',
  PRIMARY KEY (`Check_ID`),
  KEY `rule_idx` (`Rule_ID`),
  KEY `storage_idx` (`Data_Storage_ID`),
  CONSTRAINT `fk_dqcheck_rule` FOREIGN KEY (`Rule_ID`) REFERENCES `data_quality_rules` (`Rule_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_dqcheck_storage` FOREIGN KEY (`Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_quality_dashboard`
--

DROP TABLE IF EXISTS `data_quality_dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_quality_dashboard` (
  `Dashboard_ID` int NOT NULL AUTO_INCREMENT,
  `Report_Date` date NOT NULL,
  `Total_Checks_Run` int DEFAULT NULL,
  `Checks_Passed` int DEFAULT NULL,
  `Checks_Failed` int DEFAULT NULL,
  `Overall_Score` decimal(5,2) DEFAULT NULL,
  `Critical_Issues` int DEFAULT '0',
  `High_Issues` int DEFAULT '0',
  `Medium_Issues` int DEFAULT '0',
  `Low_Issues` int DEFAULT '0',
  `Top_Issues` json DEFAULT NULL,
  `Created_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Dashboard_ID`),
  UNIQUE KEY `Report_Date_UNIQUE` (`Report_Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bi_tools`
--

DROP TABLE IF EXISTS `bi_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bi_tools` (
  `Tool_ID` int NOT NULL AUTO_INCREMENT,
  `Tool_Name` varchar(100) NOT NULL,
  `Vendor` varchar(100) DEFAULT NULL,
  `Version` varchar(20) DEFAULT NULL,
  `License_Count` int DEFAULT NULL,
  `Features` text,
  `Deployment` enum('Cloud','On-Premise','Hybrid') DEFAULT NULL,
  `Status` enum('Active','Inactive','Evaluation') DEFAULT 'Active',
  PRIMARY KEY (`Tool_ID`),
  UNIQUE KEY `Tool_Name_UNIQUE` (`Tool_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `Report_ID` int NOT NULL AUTO_INCREMENT,
  `Report_Name` varchar(100) NOT NULL,
  `Report_Type` enum('Operational','Regulatory','Executive','Analytical') DEFAULT NULL,
  `BI_Tool_ID` int DEFAULT NULL,
  `Data_Storage_ID` int DEFAULT NULL,
  `Description` text,
  `Frequency` varchar(50) DEFAULT NULL,
  `Owner_Department` varchar(100) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Refresh` timestamp NULL DEFAULT NULL,
  `Status` enum('Active','Draft','Archived') DEFAULT 'Active',
  PRIMARY KEY (`Report_ID`),
  UNIQUE KEY `Report_Name_UNIQUE` (`Report_Name`),
  KEY `bitool_idx` (`BI_Tool_ID`),
  KEY `storage_idx` (`Data_Storage_ID`),
  CONSTRAINT `fk_report_bitool` FOREIGN KEY (`BI_Tool_ID`) REFERENCES `bi_tools` (`Tool_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_report_storage` FOREIGN KEY (`Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regulatory_reports`
--

DROP TABLE IF EXISTS `regulatory_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regulatory_reports` (
  `Reg_Report_ID` int NOT NULL AUTO_INCREMENT,
  `Report_Name` varchar(100) NOT NULL,
  `Regulation` varchar(100) DEFAULT NULL,
  `Jurisdiction` varchar(50) DEFAULT NULL,
  `Filing_Frequency` varchar(50) DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  `Last_Filed_Date` date DEFAULT NULL,
  `Next_Filing_Date` date DEFAULT NULL,
  `Filing_Status` enum('Pending','Filed','Late','Not Required') DEFAULT 'Pending',
  `Data_Sources` text,
  `Responsible_Party` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Reg_Report_ID`),
  UNIQUE KEY `Report_Name_UNIQUE` (`Report_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consolidation_projects`
--

DROP TABLE IF EXISTS `consolidation_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consolidation_projects` (
  `Project_ID` int NOT NULL AUTO_INCREMENT,
  `Project_Name` varchar(100) NOT NULL,
  `Description` text,
  `Start_Date` date DEFAULT NULL,
  `Target_Completion` date DEFAULT NULL,
  `Actual_Completion` date DEFAULT NULL,
  `Status` enum('Planning','In Progress','Completed','On Hold','Cancelled') DEFAULT 'Planning',
  `Progress_Percentage` int DEFAULT '0',
  `Budget_USD` decimal(15,2) DEFAULT NULL,
  `Actual_Cost_USD` decimal(15,2) DEFAULT NULL,
  `Project_Manager` varchar(100) DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`Project_ID`),
  UNIQUE KEY `Project_Name_UNIQUE` (`Project_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_milestones`
--

DROP TABLE IF EXISTS `project_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_milestones` (
  `Milestone_ID` int NOT NULL AUTO_INCREMENT,
  `Project_ID` int DEFAULT NULL,
  `Milestone_Name` varchar(100) NOT NULL,
  `Milestone_Order` int DEFAULT NULL,
  `Description` text,
  `Due_Date` date DEFAULT NULL,
  `Completion_Date` date DEFAULT NULL,
  `Status` enum('Not Started','In Progress','Completed','Delayed') DEFAULT 'Not Started',
  `Dependencies` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Milestone_ID`),
  KEY `project_idx` (`Project_ID`),
  CONSTRAINT `fk_milestone_project` FOREIGN KEY (`Project_ID`) REFERENCES `consolidation_projects` (`Project_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_sources`
--

LOCK TABLES `data_sources` WRITE;
/*!40000 ALTER TABLE `data_sources` DISABLE KEYS */;
INSERT INTO `data_sources` VALUES 
(1,'Customer Database','Transactional','Personal information, KYC data, contact details','Structured',250.00,'Real-time','Critical',1,'Active',NOW()),
(2,'Payment Gateway Data','Transactional','Transaction records, payment history','Structured',500.00,'Real-time','Critical',1,'Active',NOW()),
(3,'Loan Applications','Operational','Loan requests, credit scores, approval status','Semi-structured',150.00,'Hourly','High',1,'Active',NOW()),
(4,'Account Balances','Transactional','Current and savings account balances','Structured',100.00,'Real-time','Critical',0,'Active',NOW()),
(5,'Mobile App Logs','Log Data','User behavior, app usage analytics','Unstructured',750.00,'Streaming','Medium',0,'Active',NOW()),
(6,'Regulatory Reports','Compliance','Compliance filings, audit trails','Structured',50.00,'Daily','High',1,'Active',NOW()),
(7,'CRM System','Operational','Customer interactions, support tickets','Structured',200.00,'Hourly','High',1,'Active',NOW()),
(8,'Marketing Database','Analytical','Campaign data, customer segments','Structured',80.00,'Daily','Medium',1,'Active',NOW()),
(9,'Fraud Detection System','Security','Fraud alerts, suspicious activities','Structured',120.00,'Real-time','Critical',0,'Active',NOW()),
(10,'Legacy Core Banking','Transactional','Mainframe banking data','Structured',400.00,'Batch','Critical',1,'Legacy',NOW());
/*!40000 ALTER TABLE `data_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `storage_tiers`
--

LOCK TABLES `storage_tiers` WRITE;
/*!40000 ALTER TABLE `storage_tiers` DISABLE KEYS */;
INSERT INTO `storage_tiers` VALUES 
(1,'Raw Data Lake','Data Lake','Stores raw, unprocessed data from all sources','AWS S3','US-East-1',500.00,125.50,'7 years raw, then archive','Daily',1),
(2,'Structured Warehouse','Data Warehouse','Processed, structured data for analytics','Snowflake','Multi-region',200.00,78.25,'10 years','Continuous',1),
(3,'Operational Data Store','Operational Store','Real-time operational data','PostgreSQL','Primary DC',50.00,32.80,'90 days','Hourly',1),
(4,'Data Mart - Finance','Data Mart','Financial reporting data mart','Redshift','US-East-1',30.00,18.40,'7 years','Daily',1),
(5,'Data Mart - Customer 360','Data Mart','Unified customer view','Snowflake','Multi-region',40.00,22.60,'10 years','Daily',1),
(6,'Archive Storage','Data Lake','Long-term archival storage','AWS Glacier','US-West-2',1000.00,245.00,'Permanent','Monthly',0);
/*!40000 ALTER TABLE `storage_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_storage`
--

LOCK TABLES `data_storage` WRITE;
/*!40000 ALTER TABLE `data_storage` DISABLE KEYS */;
INSERT INTO `data_storage` VALUES 
(1,1,1,'raw_customer_data','raw','customer_json',2500000,125.50,'ingestion_date','snappy',NOW(),NOW()),
(2,2,1,'raw_payment_data','raw','payments_json',15000000,350.75,'date','snappy',NOW(),NOW()),
(3,3,1,'raw_loan_apps','raw','applications_json',500000,45.20,'application_date','snappy',NOW(),NOW()),
(4,1,2,'dim_customer','warehouse','dim_customer',2500000,28.50,'customer_id','zstd',NOW(),NOW()),
(5,2,2,'fact_transactions','warehouse','fact_transaction',15000000,175.25,'transaction_date','zstd',NOW(),NOW()),
(6,3,2,'fact_loans','warehouse','fact_loan',500000,15.80,'disbursement_date','zstd',NOW(),NOW()),
(7,4,3,'account_balances','operational','accounts',1500000,12.40,'account_id','lz4',NOW(),NOW()),
(8,5,1,'raw_app_logs','raw','logs_json',50000000,425.00,'log_date','snappy',NOW(),NOW()),
(9,9,2,'fact_fraud_alerts','warehouse','fact_fraud',25000,2.50,'alert_date','zstd',NOW(),NOW()),
(10,10,6,'legacy_archive','archive','legacy_data',10000000,245.00,'archive_date','zstd',NOW(),NOW());
/*!40000 ALTER TABLE `data_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `etl_tools`
--

LOCK TABLES `etl_tools` WRITE;
/*!40000 ALTER TABLE `etl_tools` DISABLE KEYS */;
INSERT INTO `etl_tools` VALUES 
(1,'Apache Spark','ETL','Apache','3.4.0','Distributed processing framework','Open Source','Hybrid','Active'),
(2,'AWS Glue','ELT','Amazon','2.0','Serverless ETL service','Commercial','Cloud','Active'),
(3,'dbt','ELT','dbt Labs','1.5.0','Data build tool for transformations','Open Source','Cloud','Active'),
(4,'Apache Airflow','Orchestration','Apache','2.7.0','Workflow orchestration','Open Source','Hybrid','Active'),
(5,'Talend','ETL','Talend','8.0','Enterprise data integration','Commercial','On-Premise','Active'),
(6,'Fivetran','ELT','Fivetran','1.0','Automated data integration','Commercial','Cloud','Active'),
(7,'Informatica PowerCenter','ETL','Informatica','10.5','Enterprise data integration','Commercial','On-Premise','Legacy');
/*!40000 ALTER TABLE `etl_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `etl_jobs`
--

LOCK TABLES `etl_jobs` WRITE;
/*!40000 ALTER TABLE `etl_jobs` DISABLE KEYS */;
INSERT INTO `etl_jobs` VALUES 
(1,'Customer Data Ingestion',2,1,4,'Full ETL','Every 15 minutes',DATE_SUB(NOW(), INTERVAL 15 MINUTE),NOW(),900,25000,'Completed',NULL),
(2,'Payment Data Processing',1,2,5,'Transform','Hourly',DATE_SUB(NOW(), INTERVAL 60 MINUTE),DATE_SUB(NOW(), INTERVAL 58 MINUTE),120,150000,'Completed',NULL),
(3,'Loan Application ETL',3,3,6,'Full ETL','Hourly',DATE_SUB(NOW(), INTERVAL 120 MINUTE),DATE_SUB(NOW(), INTERVAL 118 MINUTE),120,5000,'Completed',NULL),
(4,'Account Balance Sync',5,7,7,'Load','Real-time',DATE_SUB(NOW(), INTERVAL 5 MINUTE),DATE_SUB(NOW(), INTERVAL 4 MINUTE),60,15000,'Completed',NULL),
(5,'Log Processing Pipeline',1,8,1,'Transform','Streaming',NOW(),NULL,0,0,'Running',NULL),
(6,'Fraud Data Integration',2,9,9,'Full ETL','Every 5 minutes',DATE_SUB(NOW(), INTERVAL 10 MINUTE),DATE_SUB(NOW(), INTERVAL 8 MINUTE),120,500,'Completed',NULL),
(7,'Legacy Data Migration',7,10,6,'Full ETL','Daily',DATE_SUB(NOW(), INTERVAL 24 HOUR),DATE_SUB(NOW(), INTERVAL 23 HOUR),3600,100000,'Completed',NULL);
/*!40000 ALTER TABLE `etl_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `integration_apis`
--

LOCK TABLES `integration_apis` WRITE;
/*!40000 ALTER TABLE `integration_apis` DISABLE KEYS */;
INSERT INTO `integration_apis` VALUES 
(1,'Customer API','REST','https://api.finedge.com/v1/customers','1.0','OAuth2',1000,'Customer data access','Retail Banking','Active',NOW()),
(2,'Payment API','GraphQL','https://api.finedge.com/graphql','2.0','JWT',5000,'Payment processing','Payments','Active',NOW()),
(3,'Account API','REST','https://api.finedge.com/v1/accounts','1.5','OAuth2',2000,'Account information','Core Banking','Active',NOW()),
(4,'Loan API','REST','https://api.finedge.com/v1/loans','1.0','OAuth2',500,'Loan management','Lending','Active',NOW()),
(5,'Reporting API','REST','https://api.finedge.com/v1/reports','1.0','API Key',100,'Report generation','Analytics','Active',NOW()),
(6,'Fraud Detection API','gRPC','fraud.finedge.com:50051','1.0','mTLS',10000,'Real-time fraud checking','Security','Active',NOW());
/*!40000 ALTER TABLE `integration_apis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `api_consumers`
--

LOCK TABLES `api_consumers` WRITE;
/*!40000 ALTER TABLE `api_consumers` DISABLE KEYS */;
INSERT INTO `api_consumers` VALUES 
(1,1,'Mobile Banking App','Application','mobile_app_client','encrypted_token',10000,4520,NOW(),'Active'),
(2,1,'Web Portal','Application','web_client','encrypted_token',8000,3150,NOW(),'Active'),
(3,2,'Payment Processor','External Partner','partner_pay','encrypted_token',50000,12450,NOW(),'Active'),
(4,3,'Finance Department','Department','finance_dept','encrypted_token',2000,850,NOW(),'Active'),
(5,6,'Risk Management','Department','risk_dept','encrypted_token',5000,1230,NOW(),'Active');
/*!40000 ALTER TABLE `api_consumers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `encryption_keys`
--

LOCK TABLES `encryption_keys` WRITE;
/*!40000 ALTER TABLE `encryption_keys` DISABLE KEYS */;
INSERT INTO `encryption_keys` VALUES 
(1,'Data Lake Master Key','Symmetric','AES-256-GCM',256,'At Rest',NOW(),'2026-01-01',365,'2025-01-01','Active',1),
(2,'Warehouse Encryption Key','Symmetric','AES-256',256,'At Rest',NOW(),'2025-06-01',180,'2024-12-01','Active',1),
(3,'PII Column Key','Symmetric','AES-256',256,'Tokenization',NOW(),'2025-03-01',90,'2024-12-01','Active',0),
(4,'TLS Certificate','Asymmetric','RSA',4096,'In Transit',NOW(),'2025-02-01',365,'2024-02-01','Active',1),
(5,'Archive Key','Symmetric','AES-256',256,'At Rest',NOW(),'2027-01-01',730,'2025-01-01','Active',0);
/*!40000 ALTER TABLE `encryption_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `encryption_policies`
--

LOCK TABLES `encryption_policies` WRITE;
/*!40000 ALTER TABLE `encryption_policies` DISABLE KEYS */;
INSERT INTO `encryption_policies` VALUES 
(1,1,1,'Full Database','all',1,NOW()),
(2,2,2,'Full Database','all',1,NOW()),
(3,4,3,'Column','ssn',1,NOW()),
(4,4,3,'Column','email',1,NOW()),
(5,5,3,'Column','account_number',1,NOW()),
(6,6,5,'Full Database','all',1,NOW()),
(7,3,4,'Full Database','all',1,NOW());
/*!40000 ALTER TABLE `encryption_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `access_controls`
--

LOCK TABLES `access_controls` WRITE;
/*!40000 ALTER TABLE `access_controls` DISABLE KEYS */;
INSERT INTO `access_controls` VALUES 
(1,'Standard RBAC','RBAC','Role-based access control for all users','MFA',1,30,5),
(2,'Data Steward Access','RBAC','Enhanced access for data stewards','MFA',1,60,5),
(3,'Admin Access','RBAC','Administrative access with full privileges','MFA',1,120,3),
(4,'Read-Only Access','RBAC','Read-only access for reporting','Password',0,60,5),
(5,'API Service Account','ABAC','Attribute-based access for services','Certificate',0,0,0);
/*!40000 ALTER TABLE `access_controls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES 
(1,'Data Analyst','Can view and analyze data',4,1,1),
(2,'Data Engineer','Can build and maintain pipelines',1,1,0),
(3,'Data Scientist','Can access ML datasets',4,1,1),
(4,'Data Steward','Manages data quality and governance',2,1,1),
(5,'Compliance Officer','Can access regulatory data',4,1,1),
(6,'System Admin','Full system access',3,0,0);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES 
(1,'john.doe','john.doe@finedge.com','Data Engineering',2,1,NOW(),'2025-12-31','2024-12-15','Active',NOW()),
(2,'jane.smith','jane.smith@finedge.com','Analytics',1,1,NOW(),'2025-12-31','2024-11-20','Active',NOW()),
(3,'bob.johnson','bob.johnson@finedge.com','Data Science',3,1,NOW(),'2025-12-31','2024-10-10','Active',NOW()),
(4,'alice.williams','alice.williams@finedge.com','Data Governance',4,1,NOW(),'2025-12-31','2024-09-05','Active',NOW()),
(5,'charlie.brown','charlie.brown@finedge.com','Compliance',5,1,NOW(),'2025-12-31','2024-08-15','Active',NOW()),
(6,'admin.user','admin@finedge.com','IT',6,1,NOW(),'2025-12-31','2024-07-01','Active',NOW());
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `metadata_repository`
--

LOCK TABLES `metadata_repository` WRITE;
/*!40000 ALTER TABLE `metadata_repository` DISABLE KEYS */;
INSERT INTO `metadata_repository` VALUES 
(1,'dim_customer','Table',4,'Customer dimension table','Contains all customer attributes','TABLE',1,0,'Data Owner: Retail','Data Steward: Data Governance',NOW(),NOW()),
(2,'customer_id','Column',4,'Unique customer identifier','Surrogate key for customers','INT',0,0,'Data Owner: Retail','Data Steward: Data Governance',NOW(),NOW()),
(3,'ssn','Column',4,'Social Security Number','US tax identifier','VARCHAR',1,1,'Data Owner: Retail','Data Steward: Data Governance',NOW(),NOW()),
(4,'email','Column',4,'Email address','Customer email contact','VARCHAR',1,0,'Data Owner: Retail','Data Steward: Data Governance',NOW(),NOW()),
(5,'fact_transactions','Table',5,'Transaction fact table','All customer transactions','TABLE',1,0,'Data Owner: Payments','Data Steward: Data Governance',NOW(),NOW()),
(6,'account_number','Column',5,'Bank account number','Account identifier','VARCHAR',1,1,'Data Owner: Payments','Data Steward: Data Governance',NOW(),NOW()),
(7,'amount','Column',5,'Transaction amount','Monetary value of transaction','DECIMAL',0,0,'Data Owner: Payments','Data Steward: Data Governance',NOW(),NOW()),
(8,'customer_monthly_report','Report',NULL,'Monthly customer activity','Executive dashboard','REPORT',1,0,'Data Owner: Analytics','Data Steward: Data Governance',NOW(),NOW());
/*!40000 ALTER TABLE `metadata_repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_lineage`
--

LOCK TABLES `data_lineage` WRITE;
/*!40000 ALTER TABLE `data_lineage` DISABLE KEYS */;
INSERT INTO `data_lineage` VALUES 
(1,1,4,'ETL Transformation',1,'SELECT DISTINCT customer_id, name, email FROM raw_customer_data',NOW()),
(2,2,5,'ETL Aggregation',2,'SELECT account_id, SUM(amount) as total FROM raw_payment_data GROUP BY account_id',NOW()),
(3,3,6,'ETL Filter',3,'SELECT * FROM raw_loan_apps WHERE status = ''approved''',NOW()),
(4,4,5,'Join Operation',2,'JOIN dim_customer ON fact_transactions.customer_id',NOW()),
(5,5,8,'Report Generation',NULL,'Aggregate transactions for monthly report',NOW());
/*!40000 ALTER TABLE `data_lineage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_quality_rules`
--

LOCK TABLES `data_quality_rules` WRITE;
/*!40000 ALTER TABLE `data_quality_rules` DISABLE KEYS */;
INSERT INTO `data_quality_rules` VALUES 
(1,'Email Format Check','Format','Ensure email addresses are valid','email ~ ''^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$''','High',0,NOW()),
(2,'Required Fields Completeness','Completeness','Check for NULL in required fields','customer_id IS NOT NULL AND name IS NOT NULL','Critical',0,NOW()),
(3,'Unique Customer ID','Uniqueness','Customer IDs must be unique','COUNT(DISTINCT customer_id) = COUNT(customer_id)','Critical',1,NOW()),
(4,'Positive Transaction Amount','Accuracy','Transaction amounts must be positive','amount > 0','High',1,NOW()),
(5,'Account Balance Consistency','Consistency','Balance should match transaction history','SUM(transactions) = account_balance','Critical',0,NOW()),
(6,'Data Freshness','Timeliness','Data should be no older than 24 hours','MAX(ingestion_date) > NOW() - INTERVAL 24 HOUR','Medium',0,NOW());
/*!40000 ALTER TABLE `data_quality_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_quality_checks`
--

LOCK TABLES `data_quality_checks` WRITE;
/*!40000 ALTER TABLE `data_quality_checks` DISABLE KEYS */;
INSERT INTO `data_quality_checks` VALUES 
(1,1,4,'Storage',DATE_SUB(NOW(), INTERVAL 1 HOUR),2500000,2485000,15000,99.40,'{"errors": [{"row_id": 12345, "email": "invalid@email"}]}','Passed'),
(2,2,4,'Storage',DATE_SUB(NOW(), INTERVAL 1 HOUR),2500000,2500000,0,100.00,NULL,'Passed'),
(3,3,4,'Storage',DATE_SUB(NOW(), INTERVAL 2 HOUR),2500000,2499990,10,99.99,'{"errors": [{"row_id": 67890, "duplicate": "customer_id 12345"}]}','Warning'),
(4,4,5,'Ingestion',DATE_SUB(NOW(), INTERVAL 30 MINUTE),15000000,14999950,50,99.99,'{"errors": [{"row_id": 98765, "amount": -50.00}]}','Warning'),
(5,6,5,'Storage',NOW(),5,5,0,100.00,NULL,'Passed');
/*!40000 ALTER TABLE `data_quality_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_quality_dashboard`
--

LOCK TABLES `data_quality_dashboard` WRITE;
/*!40000 ALTER TABLE `data_quality_dashboard` DISABLE KEYS */;
INSERT INTO `data_quality_dashboard` VALUES 
(1,CURDATE(),25,22,3,88.00,0,1,2,0,'{"top_issues": ["Duplicate customer records", "Invalid email formats"]}',NOW()),
(2,DATE_SUB(CURDATE(), INTERVAL 1 DAY),24,20,4,83.33,1,2,1,0,'{"top_issues": ["Negative transaction amounts", "Missing required fields"]}',NOW()),
(3,DATE_SUB(CURDATE(), INTERVAL 2 DAY),24,21,3,87.50,0,1,2,0,'{"top_issues": ["Data freshness lag", "Balance inconsistency"]}',NOW());
/*!40000 ALTER TABLE `data_quality_dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bi_tools`
--

LOCK TABLES `bi_tools` WRITE;
/*!40000 ALTER TABLE `bi_tools` DISABLE KEYS */;
INSERT INTO `bi_tools` VALUES 
(1,'Tableau','Salesforce','2023.3',50,'Interactive dashboards, data visualization','Cloud','Active'),
(2,'Power BI','Microsoft','11.0',100,'Business analytics, reporting','Cloud','Active'),
(3,'Looker','Google','23.0',25,'Embedded analytics, data exploration','Cloud','Active'),
(4,'ThoughtSpot','ThoughtSpot','8.0',10,'Search-driven analytics','Cloud','Evaluation');
/*!40000 ALTER TABLE `bi_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES 
(1,'Daily Transaction Summary','Operational',1,5,'Summary of all daily transactions','Daily','Operations',NOW(),DATE_SUB(NOW(), INTERVAL 12 HOUR),'Active'),
(2,'Executive Dashboard','Executive',2,4,'Key metrics for executives','Real-time','Executive',NOW(),DATE_SUB(NOW(), INTERVAL 5 MINUTE),'Active'),
(3,'Customer 360 View','Analytical',3,5,'Complete customer view across products','Hourly','Analytics',NOW(),DATE_SUB(NOW(), INTERVAL 30 MINUTE),'Active'),
(4,'Fraud Detection Report','Regulatory',1,9,'Suspicious activity report','Daily','Risk',NOW(),DATE_SUB(NOW(), INTERVAL 2 HOUR),'Active'),
(5,'Monthly Financial Statements','Regulatory',2,4,'Financial reporting for month-end','Monthly','Finance',NOW(),DATE_SUB(NOW(), INTERVAL 5 DAY),'Active');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `regulatory_reports`
--

LOCK TABLES `regulatory_reports` WRITE;
/*!40000 ALTER TABLE `regulatory_reports` DISABLE KEYS */;
INSERT INTO `regulatory_reports` VALUES 
(1,'Basel III Capital Report','Basel III','International','Monthly','2025-04-15','2025-03-15','2025-04-15','Filed','Data Warehouse','Finance'),
(2,'SOX Compliance Report','SOX','USA','Quarterly','2025-04-30','2025-01-30','2025-04-30','Pending','Data Warehouse, Finance Mart','Compliance'),
(3,'AML Suspicious Activity','AML','USA','Daily','2025-03-20','2025-03-19','2025-03-20','Filed','Fraud Detection System','Risk'),
(4,'GDPR Data Audit','GDPR','EU','Monthly','2025-03-25','2025-02-25','2025-03-25','Pending','Customer Database','Privacy'),
(5,'CCPA Compliance Report','CCPA','California','Annual','2025-12-31','2024-12-31','2025-12-31','Not Required','Customer Database','Privacy');
/*!40000 ALTER TABLE `regulatory_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `consolidation_projects`
--

LOCK TABLES `consolidation_projects` WRITE;
/*!40000 ALTER TABLE `consolidation_projects` DISABLE KEYS */;
INSERT INTO `consolidation_projects` VALUES 
(1,'Data Lake Implementation','Build centralized data lake on AWS','2024-01-15','2024-06-30',NULL,'In Progress',75,500000.00,375000.00,'John Smith','On track for Q2 completion'),
(2,'Legacy System Migration','Migrate data from legacy core banking','2024-02-01','2024-08-31',NULL,'In Progress',40,750000.00,300000.00,'Sarah Johnson','Data mapping in progress'),
(3,'Data Governance Framework','Implement data governance policies','2024-01-01','2024-04-30','2024-04-15','Completed',100,200000.00,185000.00,'Mike Brown','Completed ahead of schedule'),
(4,'Real-time Analytics Platform','Build streaming analytics platform','2024-03-01','2024-09-30',NULL,'In Progress',25,800000.00,200000.00,'Emily Davis','Initial architecture complete'),
(5,'Regulatory Reporting Automation','Automate regulatory report generation','2024-04-01','2024-07-31',NULL,'Planning',10,300000.00,30000.00,'David Wilson','Requirements gathering');
/*!40000 ALTER TABLE `consolidation_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_milestones`
--

LOCK TABLES `project_milestones` WRITE;
/*!40000 ALTER TABLE `project_milestones` DISABLE KEYS */;
INSERT INTO `project_milestones` VALUES 
(1,1,'Requirements Gathering',1,'Document all data sources and requirements','2024-02-01','2024-02-15','Completed',NULL),
(2,1,'Infrastructure Setup',2,'Provision AWS accounts and services','2024-03-01','2024-03-20','Completed','Milestone 1'),
(3,1,'Data Ingestion Pipeline',3,'Build initial data ingestion from 5 sources','2024-04-01',NULL,'In Progress','Milestone 2'),
(4,1,'Data Transformation',4,'Implement ETL jobs for data warehouse','2024-05-01',NULL,'Not Started','Milestone 3'),
(5,1,'User Acceptance Testing',5,'Complete UAT with business users','2024-06-01',NULL,'Not Started','Milestone 4'),
(6,2,'Data Discovery',1,'Inventory legacy system data','2024-02-15','2024-03-01','Completed',NULL),
(7,2,'Data Mapping',2,'Map legacy fields to new schema','2024-03-15',NULL,'In Progress','Milestone 6'),
(8,3,'Policy Development',1,'Create data governance policies','2024-01-15','2024-02-15','Completed',NULL),
(9,3,'Role Definition',2,'Define data stewardship roles','2024-02-15','2024-03-01','Completed','Milestone 8'),
(10,3,'Tool Implementation',3,'Deploy data catalog and lineage tools','2024-03-01','2024-04-01','Completed','Milestone 9');
/*!40000 ALTER TABLE `project_milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Create indexes for performance optimization
--

CREATE INDEX idx_data_sources_type ON data_sources(Source_Type);
CREATE INDEX idx_data_sources_status ON data_sources(Status);
CREATE INDEX idx_ingestion_source ON data_ingestion(Source_ID);
CREATE INDEX idx_ingestion_status ON data_ingestion(Validation_Status);
CREATE INDEX idx_storage_tier ON data_storage(Storage_ID);
CREATE INDEX idx_storage_source ON data_storage(Source_ID);
CREATE INDEX idx_etl_status ON etl_jobs(Status);
CREATE INDEX idx_api_status ON integration_apis(Status);
CREATE INDEX idx_metadata_owner ON metadata_repository(Data_Owner);
CREATE INDEX idx_dq_checks_date ON data_quality_checks(Execution_Date);
CREATE INDEX idx_dq_checks_stage ON data_quality_checks(Check_Stage);
CREATE INDEX idx_dq_checks_status ON data_quality_checks(Status);
CREATE INDEX idx_lineage_source ON data_lineage(Source_Asset_ID);
CREATE INDEX idx_lineage_target ON data_lineage(Target_Asset_ID);
CREATE INDEX idx_project_status ON consolidation_projects(Status);
CREATE INDEX idx_milestone_project ON project_milestones(Project_ID);
CREATE INDEX idx_milestone_status ON project_milestones(Status);

--
-- Create view for consolidation progress dashboard
--

DROP VIEW IF EXISTS consolidation_dashboard;
CREATE VIEW consolidation_dashboard AS
SELECT 
    cp.Project_ID,
    cp.Project_Name,
    cp.Status,
    cp.Progress_Percentage,
    cp.Budget_USD,
    cp.Actual_Cost_USD,
    (cp.Actual_Cost_USD / cp.Budget_USD * 100) AS Budget_Used_Percentage,
    COUNT(pm.Milestone_ID) AS Total_Milestones,
    SUM(CASE WHEN pm.Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Milestones,
    SUM(CASE WHEN pm.Status = 'In Progress' THEN 1 ELSE 0 END) AS In_Progress_Milestones,
    SUM(CASE WHEN pm.Status = 'Delayed' THEN 1 ELSE 0 END) AS Delayed_Milestones,
    cp.Target_Completion,
    DATEDIFF(cp.Target_Completion, CURDATE()) AS Days_Remaining
FROM consolidation_projects cp
LEFT JOIN project_milestones pm ON cp.Project_ID = pm.Project_ID
GROUP BY cp.Project_ID, cp.Project_Name, cp.Status, cp.Progress_Percentage, 
         cp.Budget_USD, cp.Actual_Cost_USD, cp.Target_Completion;

--
-- Create view for data quality overview
--

DROP VIEW IF EXISTS data_quality_overview;
CREATE VIEW data_quality_overview AS
SELECT 
    dqd.Report_Date,
    dqd.Overall_Score,
    dqd.Checks_Passed,
    dqd.Checks_Failed,
    dqd.Total_Checks_Run,
    dqd.Critical_Issues,
    dqd.High_Issues,
    dqd.Medium_Issues,
    dqd.Low_Issues,
    dqd.Top_Issues
FROM data_quality_dashboard dqd
ORDER BY dqd.Report_Date DESC;

--
-- Create view for data lineage summary
--

DROP VIEW IF EXISTS data_lineage_summary;
CREATE VIEW data_lineage_summary AS
SELECT 
    dl.Lineage_ID,
    src.Asset_Name AS Source_Asset,
    tgt.Asset_Name AS Target_Asset,
    dl.Transformation_Type,
    ej.Job_Name AS ETL_Job,
    dl.Created_Timestamp
FROM data_lineage dl
JOIN metadata_repository src ON dl.Source_Asset_ID = src.Metadata_ID
JOIN metadata_repository tgt ON dl.Target_Asset_ID = tgt.Metadata_ID
LEFT JOIN etl_jobs ej ON dl.ETL_Job_ID = ej.Job_ID
ORDER BY dl.Created_Timestamp DESC;

--
-- Create view for security compliance status
--

DROP VIEW IF EXISTS security_compliance_status;
CREATE VIEW security_compliance_status AS
SELECT 
    'Encryption Keys' AS Category,
    COUNT(*) AS Total,
    SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS Active,
    SUM(CASE WHEN Status = 'Expired' THEN 1 ELSE 0 END) AS Expired,
    MIN(Expiry_Date) AS Earliest_Expiry
FROM encryption_keys
UNION ALL
SELECT 
    'Users' AS Category,
    COUNT(*) AS Total,
    SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS Active,
    SUM(CASE WHEN Status = 'Inactive' THEN 1 ELSE 0 END) AS Inactive,
    NULL AS Earliest_Expiry
FROM users
UNION ALL
SELECT 
    'MFA Enabled' AS Category,
    COUNT(*) AS Total,
    SUM(CASE WHEN MFA_Enabled = 1 THEN 1 ELSE 0 END) AS Active,
    SUM(CASE WHEN MFA_Enabled = 0 THEN 1 ELSE 0 END) AS Inactive,
    NULL AS Earliest_Expiry
FROM users;

--
-- Create view for data source inventory
--

DROP VIEW IF EXISTS data_source_inventory;
CREATE VIEW data_source_inventory AS
SELECT 
    ds.Source_Name,
    ds.Source_Type,
    ds.Volume_Estimate_GB,
    ds.Update_Frequency,
    ds.Criticality,
    ds.PII_Flag,
    ds.Status,
    di.Ingestion_Method,
    di.Validation_Status AS Last_Validation_Status,
    di.Last_Run_Date,
    di.Records_Processed
FROM data_sources ds
LEFT JOIN data_ingestion di ON ds.Source_ID = di.Source_ID
ORDER BY ds.Criticality DESC, ds.Volume_Estimate_GB DESC;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 13:00:00


{# This comprehensive MySQL database schema for FinEdge Bank's data consolidation project includes:

## Key Features:

### 1. **Data Source Management** (`data_sources`, `data_ingestion`, `validation_checks`)
- Tracks all 10 identified data silos (Customer DB, Payment Gateway, Loan Apps, etc.)
- Manages ingestion methods (Batch/Streaming) and validation status
- Stores volume estimates and criticality ratings

### 2. **Storage Architecture** (`storage_tiers`, `data_storage`)
- Implements the 6 storage tiers from the flowchart (Data Lake, Data Warehouse, etc.)
- Tracks raw and processed data across different storage systems
- Manages capacity and retention policies

### 3. **Integration Layer** (`etl_tools`, `etl_jobs`, `integration_apis`, `api_consumers`)
- Tracks ETL/ELT tools (Spark, Glue, dbt, Airflow)
- Manages API integrations (REST, GraphQL, gRPC)
- Monitors API consumption and quotas

### 4. **Security Controls** (`encryption_keys`, `encryption_policies`, `access_controls`, `user_roles`, `users`)
- Implements encryption at rest and in transit (AES-256, TLS 1.3)
- Role-based access control with MFA
- Row and column-level security for sensitive data

### 5. **Metadata Management** (`metadata_repository`, `data_lineage`)
- Tracks data lineage for regulatory compliance
- Manages business glossary and data dictionary
- Identifies PII and sensitive data elements

### 6. **Data Quality Framework** (`data_quality_rules`, `data_quality_checks`, `data_quality_dashboard`)
- Multi-stage quality checks (Ingestion and Storage)
- Automated validation with pass/fail tracking
- Dashboard with overall quality scores

### 7. **Reporting & Analytics** (`bi_tools`, `reports`, `regulatory_reports`)
- Tracks BI tools (Tableau, Power BI, Looker)
- Manages operational, executive, and regulatory reports
- Monitors compliance filing deadlines

### 8. **Project Management** (`consolidation_projects`, `project_milestones`)
- Tracks consolidation project progress
- Manages milestones and dependencies
- Budget vs. actual cost tracking

### 9. **Views for Monitoring**
- `consolidation_dashboard` - Project progress overview
- `data_quality_overview` - Quality metrics trend
- `data_lineage_summary` - End-to-end data flow
- `security_compliance_status` - Encryption and user stats
- `data_source_inventory` - Complete source system catalog

This schema provides a complete operational database to track and manage the entire data consolidation process, from initial source identification through to final reporting and analytics, with comprehensive governance and security controls at every layer. #}