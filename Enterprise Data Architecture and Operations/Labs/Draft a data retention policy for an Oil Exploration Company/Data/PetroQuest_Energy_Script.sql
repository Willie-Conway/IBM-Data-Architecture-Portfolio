
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: petroquest_energy
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
-- Table structure for table `data_categories`
--

DROP TABLE IF EXISTS `data_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  `CategoryDescription` text,
  `SensitivityLevel` enum('Level 1: Public','Level 2: Internal','Level 3: Confidential','Level 4: Restricted') DEFAULT NULL,
  `Criticality` enum('Low','Medium','High') DEFAULT NULL,
  `RegulatoryImpact` enum('Low','Medium','High') DEFAULT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `CategoryName_UNIQUE` (`CategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_types` (
  `DataTypeID` int NOT NULL AUTO_INCREMENT,
  `DataTypeName` varchar(100) NOT NULL,
  `CategoryID` int DEFAULT NULL,
  `Examples` text,
  `RetentionPeriod` varchar(50) DEFAULT NULL,
  `RetentionReason` text,
  `StorageFormat` enum('Digital','Physical','Digital/Physical') DEFAULT NULL,
  `StorageClass` enum('Active','Cold Storage','Archive','Deep Archive','Restricted') DEFAULT NULL,
  `AccessLevel` enum('Public','Internal','Confidential','Restricted') DEFAULT NULL,
  `DisposalMethod` text,
  PRIMARY KEY (`DataTypeID`),
  UNIQUE KEY `DataTypeName_UNIQUE` (`DataTypeName`),
  KEY `category_idx` (`CategoryID`),
  CONSTRAINT `fk_datatype_category` FOREIGN KEY (`CategoryID`) REFERENCES `data_categories` (`CategoryID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regulatory_bodies`
--

DROP TABLE IF EXISTS `regulatory_bodies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regulatory_bodies` (
  `RegBodyID` int NOT NULL AUTO_INCREMENT,
  `RegBodyName` varchar(100) NOT NULL,
  `Jurisdiction` varchar(100) DEFAULT NULL,
  `Sector` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RegBodyID`),
  UNIQUE KEY `RegBodyName_UNIQUE` (`RegBodyName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regulations`
--

DROP TABLE IF EXISTS `regulations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regulations` (
  `RegulationID` int NOT NULL AUTO_INCREMENT,
  `RegulationName` varchar(100) NOT NULL,
  `RegBodyID` int DEFAULT NULL,
  `Jurisdiction` varchar(100) DEFAULT NULL,
  `ApplicableRequirements` text,
  `TypicalRetentionPeriod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`RegulationID`),
  UNIQUE KEY `RegulationName_UNIQUE` (`RegulationName`),
  KEY `regbody_idx` (`RegBodyID`),
  CONSTRAINT `fk_regulation_regbody` FOREIGN KEY (`RegBodyID`) REFERENCES `regulatory_bodies` (`RegBodyID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_privacy_regulations`
--

DROP TABLE IF EXISTS `global_privacy_regulations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_privacy_regulations` (
  `PrivacyRegID` int NOT NULL AUTO_INCREMENT,
  `RegulationName` varchar(100) NOT NULL,
  `Jurisdiction` varchar(100) DEFAULT NULL,
  `Applicability` text,
  `KeyRequirements` text,
  PRIMARY KEY (`PrivacyRegID`),
  UNIQUE KEY `RegulationName_UNIQUE` (`RegulationName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `industry_standards`
--

DROP TABLE IF EXISTS `industry_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `industry_standards` (
  `StandardID` int NOT NULL AUTO_INCREMENT,
  `StandardName` varchar(100) NOT NULL,
  `Organization` varchar(100) DEFAULT NULL,
  `FocusArea` varchar(100) DEFAULT NULL,
  `RetentionImplications` text,
  PRIMARY KEY (`StandardID`),
  UNIQUE KEY `StandardName_UNIQUE` (`StandardName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stakeholders`
--

DROP TABLE IF EXISTS `stakeholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stakeholders` (
  `StakeholderID` int NOT NULL AUTO_INCREMENT,
  `StakeholderGroup` varchar(100) NOT NULL,
  `PurposeOfConsultation` text,
  `KeyInsights` text,
  PRIMARY KEY (`StakeholderID`),
  UNIQUE KEY `StakeholderGroup_UNIQUE` (`StakeholderGroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_classification_matrix`
--

DROP TABLE IF EXISTS `data_classification_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_classification_matrix` (
  `ClassificationID` int NOT NULL AUTO_INCREMENT,
  `DataTypeID` int DEFAULT NULL,
  `SensitivityLevel` enum('Level 1: Public','Level 2: Internal','Level 3: Confidential','Level 4: Restricted') DEFAULT NULL,
  `Criticality` enum('Low','Medium','High') DEFAULT NULL,
  `RegulatoryImpact` enum('Low','Medium','High') DEFAULT NULL,
  PRIMARY KEY (`ClassificationID`),
  KEY `datatype_idx` (`DataTypeID`),
  CONSTRAINT `fk_classification_datatype` FOREIGN KEY (`DataTypeID`) REFERENCES `data_types` (`DataTypeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retention_schedule`
--

DROP TABLE IF EXISTS `retention_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retention_schedule` (
  `ScheduleID` int NOT NULL AUTO_INCREMENT,
  `DataTypeID` int DEFAULT NULL,
  `RetentionPeriod` varchar(50) NOT NULL,
  `RetentionReason` text,
  `DisposalMethod` text,
  PRIMARY KEY (`ScheduleID`),
  KEY `datatype_idx` (`DataTypeID`),
  CONSTRAINT `fk_schedule_datatype` FOREIGN KEY (`DataTypeID`) REFERENCES `data_types` (`DataTypeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retention_period_rationale`
--

DROP TABLE IF EXISTS `retention_period_rationale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retention_period_rationale` (
  `RationaleID` int NOT NULL AUTO_INCREMENT,
  `RetentionPeriod` varchar(20) NOT NULL,
  `Rationale` text,
  `Examples` text,
  PRIMARY KEY (`RationaleID`),
  UNIQUE KEY `RetentionPeriod_UNIQUE` (`RetentionPeriod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archive_storage_tiers`
--

DROP TABLE IF EXISTS `archive_storage_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archive_storage_tiers` (
  `TierID` int NOT NULL AUTO_INCREMENT,
  `TierName` varchar(50) NOT NULL,
  `Description` text,
  `StorageType` varchar(100) DEFAULT NULL,
  `AccessTime` varchar(50) DEFAULT NULL,
  `Cost` enum('Very Low','Low','Medium','High') DEFAULT NULL,
  PRIMARY KEY (`TierID`),
  UNIQUE KEY `TierName_UNIQUE` (`TierName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disposal_methods`
--

DROP TABLE IF EXISTS `disposal_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disposal_methods` (
  `MethodID` int NOT NULL AUTO_INCREMENT,
  `Format` varchar(50) NOT NULL,
  `DisposalMethod` text NOT NULL,
  `Standard` varchar(100) DEFAULT NULL,
  `Verification` text,
  PRIMARY KEY (`MethodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disposal_certificates`
--

DROP TABLE IF EXISTS `disposal_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disposal_certificates` (
  `CertificateID` varchar(50) NOT NULL,
  `DataDescription` text,
  `DataCategory` varchar(50) DEFAULT NULL,
  `RetentionPeriodExpired` date DEFAULT NULL,
  `VolumeOfData` varchar(50) DEFAULT NULL,
  `DisposalMethodID` int DEFAULT NULL,
  `DisposalDate` date DEFAULT NULL,
  `DisposalTime` time DEFAULT NULL,
  `AuthorizedByName` varchar(100) DEFAULT NULL,
  `AuthorizedByTitle` varchar(100) DEFAULT NULL,
  `ExecutedByName` varchar(100) DEFAULT NULL,
  `ExecutedByTitle` varchar(100) DEFAULT NULL,
  `WitnessName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CertificateID`),
  KEY `disposalmethod_idx` (`DisposalMethodID`),
  CONSTRAINT `fk_certificate_method` FOREIGN KEY (`DisposalMethodID`) REFERENCES `disposal_methods` (`MethodID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `legal_holds`
--

DROP TABLE IF EXISTS `legal_holds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_holds` (
  `LegalHoldID` varchar(50) NOT NULL,
  `MatterName` varchar(200) DEFAULT NULL,
  `CaseNumber` varchar(100) DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `IssuedBy` varchar(100) DEFAULT NULL,
  `ScopeDescription` text,
  `ProjectScope` varchar(200) DEFAULT NULL,
  `DateRangeFrom` date DEFAULT NULL,
  `DateRangeTo` date DEFAULT NULL,
  `Status` enum('Active','Released','Expired') DEFAULT 'Active',
  `ReleaseDate` date DEFAULT NULL,
  `ReleasedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`LegalHoldID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `legal_hold_custodians`
--

DROP TABLE IF EXISTS `legal_hold_custodians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_hold_custodians` (
  `CustodianID` int NOT NULL AUTO_INCREMENT,
  `LegalHoldID` varchar(50) DEFAULT NULL,
  `CustodianName` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `AcknowledgedDate` date DEFAULT NULL,
  PRIMARY KEY (`CustodianID`),
  KEY `legalhold_idx` (`LegalHoldID`),
  CONSTRAINT `fk_custodian_legalhold` FOREIGN KEY (`LegalHoldID`) REFERENCES `legal_holds` (`LegalHoldID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `legal_hold_data`
--

DROP TABLE IF EXISTS `legal_hold_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_hold_data` (
  `HoldDataID` int NOT NULL AUTO_INCREMENT,
  `LegalHoldID` varchar(50) DEFAULT NULL,
  `DataTypeID` int DEFAULT NULL,
  `PreservationLocation` text,
  PRIMARY KEY (`HoldDataID`),
  KEY `legalhold_idx` (`LegalHoldID`),
  KEY `datatype_idx` (`DataTypeID`),
  CONSTRAINT `fk_holddata_legalhold` FOREIGN KEY (`LegalHoldID`) REFERENCES `legal_holds` (`LegalHoldID`) ON DELETE CASCADE,
  CONSTRAINT `fk_holddata_datatype` FOREIGN KEY (`DataTypeID`) REFERENCES `data_types` (`DataTypeID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles_responsibilities`
--

DROP TABLE IF EXISTS `roles_responsibilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_responsibilities` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(100) NOT NULL,
  `Responsibilities` text,
  PRIMARY KEY (`RoleID`),
  UNIQUE KEY `RoleName_UNIQUE` (`RoleName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_documents`
--

DROP TABLE IF EXISTS `policy_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_documents` (
  `PolicyID` int NOT NULL AUTO_INCREMENT,
  `PolicyTitle` varchar(200) NOT NULL,
  `Version` varchar(10) DEFAULT NULL,
  `EffectiveDate` date DEFAULT NULL,
  `NextReviewDate` date DEFAULT NULL,
  `PolicyOwner` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Classification` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PolicyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_approvals`
--

DROP TABLE IF EXISTS `policy_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_approvals` (
  `ApprovalID` int NOT NULL AUTO_INCREMENT,
  `PolicyID` int DEFAULT NULL,
  `Role` varchar(100) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `ApprovalDate` date DEFAULT NULL,
  PRIMARY KEY (`ApprovalID`),
  KEY `policy_idx` (`PolicyID`),
  CONSTRAINT `fk_approval_policy` FOREIGN KEY (`PolicyID`) REFERENCES `policy_documents` (`PolicyID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compliance_monitoring`
--

DROP TABLE IF EXISTS `compliance_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compliance_monitoring` (
  `MonitoringID` int NOT NULL AUTO_INCREMENT,
  `MonitoringActivity` varchar(200) DEFAULT NULL,
  `Frequency` varchar(50) DEFAULT NULL,
  `ResponsibleParty` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MonitoringID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `non_compliance_consequences`
--

DROP TABLE IF EXISTS `non_compliance_consequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_compliance_consequences` (
  `ConsequenceID` int NOT NULL AUTO_INCREMENT,
  `Violation` text,
  `Consequence` text,
  `ReportingTo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ConsequenceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regulatory_reference`
--

DROP TABLE IF EXISTS `regulatory_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regulatory_reference` (
  `ReferenceID` int NOT NULL AUTO_INCREMENT,
  `RegulationName` varchar(100) DEFAULT NULL,
  `Jurisdiction` varchar(100) DEFAULT NULL,
  `Requirements` text,
  `RetentionPeriod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ReferenceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_categories`
--

LOCK TABLES `data_categories` WRITE;
/*!40000 ALTER TABLE `data_categories` DISABLE KEYS */;
INSERT INTO `data_categories` VALUES 
(1,'Critical Operational Data','Data essential for current and future exploration and production activities','Level 4: Restricted','High','Medium'),
(2,'Compliance Data','Data required to demonstrate regulatory compliance','Level 3: Confidential','High','High'),
(3,'Financial and Legal Data','Data related to financial transactions and legal obligations','Level 3: Confidential','High','High'),
(4,'Health and Safety Data','Data related to employee and public safety','Level 3: Confidential','Medium','High'),
(5,'Administrative and Support Data','Data supporting business operations but not critical','Level 2: Internal','Low','Low'),
(6,'Archived Data','Data no longer actively used but retained for historical or legal reasons','Level 3: Confidential','Medium','Medium');
/*!40000 ALTER TABLE `data_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES 
(1,'Seismic Data',1,'2D/3D seismic surveys, processed seismic volumes, interpretation data','20+ years','Future exploration, field development','Digital','Deep Archive','Restricted','N/A (permanent archive)'),
(2,'Well Logs',1,'Drilling reports, well logs, completion reports','Life of well + 10 years','Reservoir management, well interventions','Digital','Archive','Confidential','Secure deletion after well abandonment'),
(3,'Reservoir Models',1,'Reservoir models, simulation results','25 years','Field development planning','Digital','Deep Archive','Restricted','Secure deletion'),
(4,'Production Data',1,'Production data, well performance','Life of field + 7 years','Reserve reporting, forecasting','Digital','Active','Confidential','Secure deletion'),
(5,'Environmental Impact Assessments',2,'Impact assessments, EIS documents','10 years','Regulatory audits, future permitting','Digital/Physical','Archive','Internal','Secure deletion'),
(6,'Emission Monitoring',2,'Emission monitoring records, air quality data','7 years','EPA compliance, trend analysis','Digital','Active','Internal','Secure deletion'),
(7,'Permit Documentation',2,'Permits, licenses, regulatory correspondence','Life of operation + 5 years','Regulatory verification','Digital','Active','Confidential','Secure deletion'),
(8,'Contracts and Agreements',3,'Contracts, agreements, MOUs','Contract term + 7 years','Legal protection, dispute resolution','Digital','Confidential','Confidential','Secure deletion'),
(9,'Lease Agreements',3,'Land rights documents, lease agreements','Lease term + 7 years','Land rights verification','Digital','Confidential','Restricted','Secure deletion'),
(10,'Royalty Records',3,'Royalty payment records, calculation sheets','7 years','Payment verification, audits','Digital','Confidential','Confidential','Secure deletion'),
(11,'Tax Records',3,'Tax returns, supporting documentation','7 years','IRS/SEC requirements','Digital','Confidential','Confidential','Secure deletion'),
(12,'SOX Compliance Records',3,'SOX compliance records, audit documentation','7 years','Financial audits','Digital','Confidential','Confidential','Secure deletion'),
(13,'Medical Surveillance Records',4,'Employee medical records, health monitoring','Employment + 30 years','Long-term health monitoring','Digital/Physical','Restricted','Restricted','Physical shredding/secure wipe'),
(14,'Incident Reports',4,'Safety incident reports, investigations','10 years','Insurance, safety analysis','Digital','Active','Confidential','Secure deletion'),
(15,'Exposure Monitoring',4,'Exposure monitoring data, sampling results','30 years','Occupational health tracking','Digital','Restricted','Restricted','Secure deletion'),
(16,'Safety Training Records',4,'Training records, certifications','5 years','Training verification','Digital','Internal','Internal','Secure deletion'),
(17,'Internal Emails',5,'Internal communications, emails','3 years','Business reference','Digital','Internal','Internal','Secure deletion'),
(18,'Meeting Minutes',5,'Meeting minutes, decision records','5 years','Decision documentation','Digital','Internal','Internal','Secure deletion'),
(19,'Travel Reports',5,'Travel and expense reports','3 years','Expense verification','Digital','Internal','Internal','Secure deletion'),
(20,'Legacy System Data',6,'Data from decommissioned systems','10 years after system decommission','Historical reference, legal holds','Digital','Deep Archive','Restricted','Secure deletion after hold release'),
(21,'Closed Project Records',6,'Closed project documentation','7 years after project closure','Lessons learned, future reference','Digital','Archive','Internal','Secure deletion');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `regulatory_bodies`
--

LOCK TABLES `regulatory_bodies` WRITE;
/*!40000 ALTER TABLE `regulatory_bodies` DISABLE KEYS */;
INSERT INTO `regulatory_bodies` VALUES 
(1,'EPA (Environmental Protection Agency)','USA','Environmental'),
(2,'SEC (Securities and Exchange Commission)','USA','Financial'),
(3,'OSHA (Occupational Safety and Health Administration)','USA','Health & Safety'),
(4,'BOEM (Bureau of Ocean Energy Management)','USA','Drilling Operations'),
(5,'BLM (Bureau of Land Management)','USA','Land Management'),
(6,'Various International','Global','International Operations');
/*!40000 ALTER TABLE `regulatory_bodies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `regulations`
--

LOCK TABLES `regulations` WRITE;
/*!40000 ALTER TABLE `regulations` DISABLE KEYS */;
INSERT INTO `regulations` VALUES 
(1,'Clean Water Act',1,'USA','Clean Water Act records, Spill Prevention Control records','5-10 years'),
(2,'SOX Compliance',2,'USA','SOX compliance records, Financial statements, Audit records','7 years'),
(3,'OSHA 29 CFR 1910',3,'USA','Incident reports, Exposure records, Safety training records, Medical surveillance data','5-30 years'),
(4,'BOEM 30 CFR 250',4,'USA','Drilling permits, Well completion reports, Production reports, Reservoir data','Life of well + 5 years'),
(5,'BLM Onshore Orders',5,'USA','Lease agreements, Land rights documents, Royalty payment records','Duration of lease + 7 years'),
(6,'GDPR',6,'European Union','Personal data protection, right to erasure','Varies'),
(7,'CCPA',6,'California, USA','Consumer privacy rights, right to delete','Varies'),
(8,'PIPEDA',6,'Canada','Consent, retention limits, safeguards','Varies'),
(9,'LGPD',6,'Brazil','Data retention, disposal, rights','Varies');
/*!40000 ALTER TABLE `regulations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `global_privacy_regulations`
--

LOCK TABLES `global_privacy_regulations` WRITE;
/*!40000 ALTER TABLE `global_privacy_regulations` DISABLE KEYS */;
INSERT INTO `global_privacy_regulations` VALUES 
(1,'GDPR','European Union','If PetroQuest operates in or handles data from EU citizens','Right to erasure, data minimization, retention limitation'),
(2,'CCPA','California, USA','If handling data of California residents','Right to delete, right to access, opt-out rights'),
(3,'PIPEDA','Canada','For Canadian operations','Consent, retention limits, safeguards'),
(4,'LGPD','Brazil','For Brazilian operations','Data retention, disposal, rights');
/*!40000 ALTER TABLE `global_privacy_regulations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `industry_standards`
--

LOCK TABLES `industry_standards` WRITE;
/*!40000 ALTER TABLE `industry_standards` DISABLE KEYS */;
INSERT INTO `industry_standards` VALUES 
(1,'API RP 1175','American Petroleum Institute','Pipeline safety management','Records for pipeline operations and maintenance'),
(2,'ISO 14001','International Organization for Standardization','Environmental management','Environmental records and audits'),
(3,'ISO 45001','International Organization for Standardization','Occupational health and safety','Safety records and incident documentation');
/*!40000 ALTER TABLE `industry_standards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stakeholders`
--

LOCK TABLES `stakeholders` WRITE;
/*!40000 ALTER TABLE `stakeholders` DISABLE KEYS */;
INSERT INTO `stakeholders` VALUES 
(1,'IT and Data Management Teams','Understand current storage capabilities, Identify system limitations, Assess backup and archiving processes, Determine technical feasibility','Current storage capacity: 500 TB, Backup frequency: Daily incremental/weekly full, Archive system nearing end-of-life, Need for automated retention enforcement'),
(2,'Legal and Compliance Teams','Identify legal hold requirements, Understand litigation risks, Document regulatory obligations, Define compliance reporting needs','Ongoing litigation requires data preservation, Multiple jurisdictions with conflicting requirements, Need for legal hold process, Audit response time requirements'),
(3,'Geology and Exploration Teams','Capture operational data needs, Understand data reuse patterns, Identify critical historical data, Document data value over time','Seismic data valuable for decades, Reservoir models used for field development, Historical well data critical for new drilling, Need for long-term preservation'),
(4,'Health, Safety, and Environment (HSE) Teams','Document safety record requirements, Understand environmental monitoring needs, Identify incident reporting obligations','Employee exposure records needed for 30+ years, Incident reports required for insurance claims, Environmental monitoring data for trend analysis'),
(5,'Finance and Accounting Teams','Identify financial record requirements, Understand audit retention needs, Document tax record obligations','SOX compliance requires 7-year retention, Tax records needed for audit defense, Royalty payment records for landowner disputes');
/*!40000 ALTER TABLE `stakeholders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `retention_period_rationale`
--

LOCK TABLES `retention_period_rationale` WRITE;
/*!40000 ALTER TABLE `retention_period_rationale` DISABLE KEYS */;
INSERT INTO `retention_period_rationale` VALUES 
(1,'30+ years','Long-term health monitoring requirements, permanent operational value','Medical records, seismic data'),
(2,'20-25 years','Extended operational value, field life cycles','Reservoir models, exploration data'),
(3,'10 years','Regulatory requirements, environmental impact assessments','EPA records, well data'),
(4,'7 years','Financial audit requirements, statute of limitations','SOX records, contracts, tax docs'),
(5,'5 years','Business reference, training verification','Meeting minutes, training records'),
(6,'3 years','Short-term operational value','Internal emails, travel reports');
/*!40000 ALTER TABLE `retention_period_rationale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `archive_storage_tiers`
--

LOCK TABLES `archive_storage_tiers` WRITE;
/*!40000 ALTER TABLE `archive_storage_tiers` DISABLE KEYS */;
INSERT INTO `archive_storage_tiers` VALUES 
(1,'Active Storage','Frequently accessed data','SSD, High-performance NAS','Milliseconds','High'),
(2,'Cold Storage','Infrequently accessed data','HDD, Standard cloud storage','Seconds','Medium'),
(3,'Archive Storage','Rarely accessed data','Tape, Glacier, Deep Archive','Hours to days','Low'),
(4,'Deep Archive','Permanent preservation','WORM media, Offline tape','Days to weeks','Very Low');
/*!40000 ALTER TABLE `archive_storage_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `disposal_methods`
--

LOCK TABLES `disposal_methods` WRITE;
/*!40000 ALTER TABLE `disposal_methods` DISABLE KEYS */;
INSERT INTO `disposal_methods` VALUES 
(1,'Digital Files','Secure deletion with overwrite','DoD 5220.22-M (3 passes)','Certificate of deletion'),
(2,'Databases','Cryptographic erasure','AES-256 key destruction','Key destruction certificate'),
(3,'Hard Drives','Degaussing or physical destruction','NIST SP 800-88','Certificate of destruction'),
(4,'SSDs','Secure erase command + encryption','ATA Secure Erase','Verification log'),
(5,'Cloud Storage','API-based deletion + verification','Cloud provider certification','Deletion confirmation'),
(6,'Paper Records','Cross-cut shredding','DIN 66399 (P-5 level)','Certificate of shredding'),
(7,'Microfilm/Microfiche','Incineration','Witnessed destruction','Destruction certificate'),
(8,'Backup Tapes','Degaussing or physical destruction','Vendor certification','Chain of custody');
/*!40000 ALTER TABLE `disposal_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles_responsibilities`
--

LOCK TABLES `roles_responsibilities` WRITE;
/*!40000 ALTER TABLE `roles_responsibilities` DISABLE KEYS */;
INSERT INTO `roles_responsibilities` VALUES 
(1,'Data Governance Committee','Approve retention schedules, Review policy annually, Resolve disputes, Ensure cross-departmental alignment'),
(2,'Data Owners','Define retention requirements for their data domains, Approve deviations from standard retention, Ensure compliance within their areas'),
(3,'Data Stewards','Monitor compliance with retention schedules, Coordinate with IT for implementation, Identify data quality issues, Escalate non-compliance'),
(4,'IT and Data Management Teams','Implement technical controls for retention, Manage backup and archive systems, Execute secure data disposal, Maintain storage infrastructure, Provide access to retained data'),
(5,'Legal and Compliance Teams','Identify regulatory requirements, Manage legal holds, Approve retention timelines, Ensure compliance with laws, Respond to regulatory requests'),
(6,'Internal Audit','Verify compliance with policy, Test disposal procedures, Report findings to governance committee'),
(7,'All Employees','Follow policy requirements, Classify data appropriately, Report data management issues');
/*!40000 ALTER TABLE `roles_responsibilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `policy_documents`
--

LOCK TABLES `policy_documents` WRITE;
/*!40000 ALTER TABLE `policy_documents` DISABLE KEYS */;
INSERT INTO `policy_documents` VALUES 
(1,'Data Retention Policy','1.0','2025-01-01','2026-01-01','Chief Data Officer','Data Governance','Internal - Confidential');
/*!40000 ALTER TABLE `policy_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `policy_approvals`
--

LOCK TABLES `policy_approvals` WRITE;
/*!40000 ALTER TABLE `policy_approvals` DISABLE KEYS */;
INSERT INTO `policy_approvals` VALUES 
(1,1,'Chief Data Officer',NULL,NULL),
(2,1,'General Counsel',NULL,NULL),
(3,1,'VP of Exploration',NULL,NULL),
(4,1,'HSE Director',NULL,NULL),
(5,1,'CFO',NULL,NULL),
(6,1,'CEO',NULL,NULL);
/*!40000 ALTER TABLE `policy_approvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `compliance_monitoring`
--

LOCK TABLES `compliance_monitoring` WRITE;
/*!40000 ALTER TABLE `compliance_monitoring` DISABLE KEYS */;
INSERT INTO `compliance_monitoring` VALUES 
(1,'Retention Schedule Compliance','Quarterly','Data Stewards'),
(2,'Disposal Verification','Per disposal','IT/Data Management'),
(3,'Legal Hold Compliance','Per hold','Legal Team'),
(4,'Storage Cost Analysis','Monthly','IT Finance'),
(5,'Data Classification Accuracy','Quarterly','Data Stewards'),
(6,'Policy Review','Annually','Data Governance Committee');
/*!40000 ALTER TABLE `compliance_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `non_compliance_consequences`
--

LOCK TABLES `non_compliance_consequences` WRITE;
/*!40000 ALTER TABLE `non_compliance_consequences` DISABLE KEYS */;
INSERT INTO `non_compliance_consequences` VALUES 
(1,'Accidental retention beyond period','Warning, process review','Data Steward'),
(2,'Failure to dispose of expired data','Written warning, retraining','HR Record'),
(3,'Unauthorized data destruction','Formal investigation, possible termination','HR/Legal'),
(4,'Bypassing legal hold','Immediate escalation, legal action','Legal Team'),
(5,'Misclassification of data','Retraining, performance review','Data Steward');
/*!40000 ALTER TABLE `non_compliance_consequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `regulatory_reference`
--

LOCK TABLES `regulatory_reference` WRITE;
/*!40000 ALTER TABLE `regulatory_reference` DISABLE KEYS */;
INSERT INTO `regulatory_reference` VALUES 
(1,'SOX','USA','Financial records retention','7 years'),
(2,'EPA Clean Water Act','USA','Discharge monitoring reports','5 years'),
(3,'OSHA 29 CFR 1910','USA','Medical records','Employment + 30 years'),
(4,'OSHA 29 CFR 1904','USA','Incident reports','5 years'),
(5,'GDPR','EU','Personal data','As needed + 3 years'),
(6,'BLM Onshore Orders','USA','Drilling permits','Life of well + 6 years'),
(7,'BOEM 30 CFR 250','USA','Offshore operations','Life of well + 5 years');
/*!40000 ALTER TABLE `regulatory_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_classification_matrix`
--

LOCK TABLES `data_classification_matrix` WRITE;
/*!40000 ALTER TABLE `data_classification_matrix` DISABLE KEYS */;
INSERT INTO `data_classification_matrix` VALUES 
(1,1,'Level 4: Restricted','High','Medium'),
(2,2,'Level 3: Confidential','High','Medium'),
(3,13,'Level 4: Restricted','Medium','High'),
(4,8,'Level 3: Confidential','High','High'),
(5,5,'Level 2: Internal','Medium','High'),
(6,14,'Level 3: Confidential','High','High'),
(7,9,'Level 4: Restricted','High','High'),
(8,17,'Level 2: Internal','Low','Low');
/*!40000 ALTER TABLE `data_classification_matrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `retention_schedule`
--

LOCK TABLES `retention_schedule` WRITE;
/*!40000 ALTER TABLE `retention_schedule` DISABLE KEYS */;
INSERT INTO `retention_schedule` VALUES 
(1,1,'20+ years','Future exploration, field development','N/A (permanent archive)'),
(2,2,'Life of well + 10 years','Reservoir management, well interventions','Secure deletion after well abandonment'),
(3,3,'25 years','Field development planning','Secure deletion'),
(4,4,'Life of field + 7 years','Reserve reporting, forecasting','Secure deletion'),
(5,5,'10 years','Regulatory audits, future permitting','Secure deletion'),
(6,6,'7 years','EPA compliance, trend analysis','Secure deletion'),
(7,7,'Life of operation + 5 years','Regulatory verification','Secure deletion'),
(8,8,'Contract term + 7 years','Legal protection, dispute resolution','Secure deletion'),
(9,9,'Lease term + 7 years','Land rights verification','Secure deletion'),
(10,10,'7 years','Payment verification, audits','Secure deletion'),
(11,11,'7 years','IRS/SEC requirements','Secure deletion'),
(12,12,'7 years','Financial audits','Secure deletion'),
(13,13,'Employment + 30 years','Long-term health monitoring','Physical shredding/secure wipe'),
(14,14,'10 years','Insurance, safety analysis','Secure deletion'),
(15,15,'30 years','Occupational health tracking','Secure deletion'),
(16,16,'5 years','Training verification','Secure deletion'),
(17,17,'3 years','Business reference','Secure deletion'),
(18,18,'5 years','Decision documentation','Secure deletion'),
(19,19,'3 years','Expense verification','Secure deletion'),
(20,20,'10 years after system decommission','Historical reference, legal holds','Secure deletion after hold release'),
(21,21,'7 years after project closure','Lessons learned, future reference','Secure deletion');
/*!40000 ALTER TABLE `retention_schedule` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 12:00:00


{# # This database schema captures all the key elements from the PetroQuest Energy data retention policy:

1. **Data Categories** - The six main categories (Critical Operational, Compliance, Financial/Legal, HSE, Administrative, Archived)
2. **Data Types** - All 21 specific data types with their retention periods, storage formats, and access levels
3. **Regulatory Framework** - Regulatory bodies, specific regulations, global privacy laws, and industry standards
4. **Stakeholders** - Consultation records with key teams
5. **Classification Matrix** - Sensitivity levels, criticality, and regulatory impact for each data type
6. **Retention Schedule** - Detailed retention periods with reasons and disposal methods
7. **Archive Storage Tiers** - Four tiers with their characteristics
8. **Disposal Methods** - Eight disposal methods with standards and verification requirements
9. **Legal Hold System** - Complete legal hold tracking with custodians and affected data
10. **Roles & Responsibilities** - Seven key roles with their duties
11. **Compliance Monitoring** - Six monitoring activities with frequencies
12. **Non-Compliance Consequences** - Five violation types with consequences
 #} #}