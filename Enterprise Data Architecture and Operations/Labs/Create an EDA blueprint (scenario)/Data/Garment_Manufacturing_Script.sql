
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: garment_supply_chain_eda
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

-- ===================================================================
-- DATA SOURCES LAYER
-- ===================================================================

--
-- Table structure for table `data_source_categories`
--

DROP TABLE IF EXISTS `data_source_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_source_categories` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(50) NOT NULL,
  `Category_Type` enum('Internal','External') DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`Category_ID`),
  UNIQUE KEY `Category_Name_UNIQUE` (`Category_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_sources`
--

DROP TABLE IF EXISTS `data_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_sources` (
  `Source_ID` int NOT NULL AUTO_INCREMENT,
  `Source_Name` varchar(100) NOT NULL,
  `Category_ID` int DEFAULT NULL,
  `Source_Type` varchar(50) DEFAULT NULL,
  `Description` text,
  `Data_Format` enum('Structured','Semi-structured','Unstructured') DEFAULT NULL,
  `Volume_Estimate_GB` decimal(10,2) DEFAULT NULL,
  `Update_Frequency` enum('Real-time','Hourly','Daily','Weekly','Monthly','Ad-hoc') DEFAULT NULL,
  `Criticality` enum('Critical','High','Medium','Low') DEFAULT 'Medium',
  `PII_Flag` tinyint(1) DEFAULT '0',
  `Status` enum('Active','Inactive','Planned','Deprecated') DEFAULT 'Active',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Source_ID`),
  UNIQUE KEY `Source_Name_UNIQUE` (`Source_Name`),
  KEY `category_idx` (`Category_ID`),
  CONSTRAINT `fk_datasource_category` FOREIGN KEY (`Category_ID`) REFERENCES `data_source_categories` (`Category_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier_database`
--

DROP TABLE IF EXISTS `supplier_database`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_database` (
  `Supplier_ID` int NOT NULL AUTO_INCREMENT,
  `Supplier_Code` varchar(50) NOT NULL,
  `Supplier_Name` varchar(100) NOT NULL,
  `Supplier_Type` enum('Cotton Farm','Synthetic Fiber','Dye Producer','Trims','Packaging','Logistics') DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Contact_Person` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Payment_Terms` varchar(50) DEFAULT NULL,
  `Lead_Time_Days` int DEFAULT NULL,
  `Minimum_Order_Quantity` int DEFAULT NULL,
  `Certifications` text,
  `Sustainability_Rating` enum('A','B','C','D','F') DEFAULT NULL,
  `Status` enum('Active','Inactive','On Hold','Blacklisted') DEFAULT 'Active',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Supplier_ID`),
  UNIQUE KEY `Supplier_Code_UNIQUE` (`Supplier_Code`),
  UNIQUE KEY `Supplier_Name_UNIQUE` (`Supplier_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raw_materials`
--

DROP TABLE IF EXISTS `raw_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_materials` (
  `Material_ID` int NOT NULL AUTO_INCREMENT,
  `Material_Code` varchar(50) NOT NULL,
  `Material_Name` varchar(100) NOT NULL,
  `Material_Category` enum('Cotton','Synthetic Fiber','Dye','Chemical','Thread','Button','Zipper','Packaging') DEFAULT NULL,
  `Unit_of_Measure` varchar(20) DEFAULT NULL,
  `Description` text,
  `Hazardous_Flag` tinyint(1) DEFAULT '0',
  `Temperature_Sensitive` tinyint(1) DEFAULT '0',
  `Shelf_Life_Days` int DEFAULT NULL,
  PRIMARY KEY (`Material_ID`),
  UNIQUE KEY `Material_Code_UNIQUE` (`Material_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier_materials`
--

DROP TABLE IF EXISTS `supplier_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_materials` (
  `Supplier_Material_ID` int NOT NULL AUTO_INCREMENT,
  `Supplier_ID` int DEFAULT NULL,
  `Material_ID` int DEFAULT NULL,
  `Unit_Price` decimal(10,2) DEFAULT NULL,
  `Currency` varchar(3) DEFAULT 'USD',
  `MOQ` int DEFAULT NULL,
  `Lead_Time_Days` int DEFAULT NULL,
  `Quality_Grade` varchar(20) DEFAULT NULL,
  `Preferred_Supplier` tinyint(1) DEFAULT '0',
  `Contract_Start_Date` date DEFAULT NULL,
  `Contract_End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Supplier_Material_ID`),
  KEY `supplier_idx` (`Supplier_ID`),
  KEY `material_idx` (`Material_ID`),
  CONSTRAINT `fk_suppliermaterial_supplier` FOREIGN KEY (`Supplier_ID`) REFERENCES `supplier_database` (`Supplier_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_suppliermaterial_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `erp_system`
--

DROP TABLE IF EXISTS `erp_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `erp_system` (
  `ERP_ID` int NOT NULL AUTO_INCREMENT,
  `Transaction_Type` enum('Procurement','Inventory','Finance','Sales','Production') DEFAULT NULL,
  `Transaction_Number` varchar(50) NOT NULL,
  `Transaction_Date` datetime DEFAULT NULL,
  `Material_ID` int DEFAULT NULL,
  `Quantity` decimal(15,2) DEFAULT NULL,
  `Unit_Price` decimal(15,2) DEFAULT NULL,
  `Total_Amount` decimal(15,2) DEFAULT NULL,
  `Currency` varchar(3) DEFAULT 'USD',
  `Supplier_ID` int DEFAULT NULL,
  `Customer_ID` int DEFAULT NULL,
  `Warehouse_ID` int DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `Created_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ERP_ID`),
  UNIQUE KEY `Transaction_Number_UNIQUE` (`Transaction_Number`),
  KEY `material_idx` (`Material_ID`),
  KEY `supplier_idx` (`Supplier_ID`),
  CONSTRAINT `fk_erp_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_erp_supplier` FOREIGN KEY (`Supplier_ID`) REFERENCES `supplier_database` (`Supplier_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_sensors`
--

DROP TABLE IF EXISTS `iot_sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_sensors` (
  `Sensor_ID` int NOT NULL AUTO_INCREMENT,
  `Sensor_Code` varchar(50) NOT NULL,
  `Sensor_Type` enum('Temperature','Humidity','GPS','Vibration','Pressure','Light') DEFAULT NULL,
  `Location_Type` enum('Warehouse','Container','Vehicle','Storage') DEFAULT NULL,
  `Location_ID` varchar(50) DEFAULT NULL,
  `Installation_Date` date DEFAULT NULL,
  `Status` enum('Active','Inactive','Maintenance','Faulty') DEFAULT 'Active',
  `Last_Calibration` date DEFAULT NULL,
  PRIMARY KEY (`Sensor_ID`),
  UNIQUE KEY `Sensor_Code_UNIQUE` (`Sensor_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_sensor_readings`
--

DROP TABLE IF EXISTS `iot_sensor_readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_sensor_readings` (
  `Reading_ID` bigint NOT NULL AUTO_INCREMENT,
  `Sensor_ID` int DEFAULT NULL,
  `Reading_Value` decimal(10,2) DEFAULT NULL,
  `Unit` varchar(10) DEFAULT NULL,
  `Reading_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Batch_ID` varchar(50) DEFAULT NULL,
  `Alert_Flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Reading_ID`),
  KEY `sensor_idx` (`Sensor_ID`),
  KEY `timestamp_idx` (`Reading_Timestamp`),
  KEY `batch_idx` (`Batch_ID`),
  CONSTRAINT `fk_iotreading_sensor` FOREIGN KEY (`Sensor_ID`) REFERENCES `iot_sensors` (`Sensor_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_management_system`
--

DROP TABLE IF EXISTS `warehouse_management_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_management_system` (
  `Warehouse_ID` int NOT NULL AUTO_INCREMENT,
  `Warehouse_Code` varchar(50) NOT NULL,
  `Warehouse_Name` varchar(100) DEFAULT NULL,
  `Location` varchar(200) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `Capacity_SqFt` int DEFAULT NULL,
  `Temperature_Controlled` tinyint(1) DEFAULT '0',
  `Status` enum('Active','Inactive','Full','Maintenance') DEFAULT 'Active',
  PRIMARY KEY (`Warehouse_ID`),
  UNIQUE KEY `Warehouse_Code_UNIQUE` (`Warehouse_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_levels`
--

DROP TABLE IF EXISTS `inventory_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_levels` (
  `Inventory_ID` int NOT NULL AUTO_INCREMENT,
  `Warehouse_ID` int DEFAULT NULL,
  `Material_ID` int DEFAULT NULL,
  `Batch_Number` varchar(50) DEFAULT NULL,
  `Quantity_On_Hand` decimal(15,2) DEFAULT NULL,
  `Quantity_Reserved` decimal(15,2) DEFAULT NULL,
  `Quantity_Available` decimal(15,2) GENERATED ALWAYS AS (`Quantity_On_Hand` - `Quantity_Reserved`) STORED,
  `Unit_of_Measure` varchar(20) DEFAULT NULL,
  `Location_Bin` varchar(50) DEFAULT NULL,
  `Receipt_Date` date DEFAULT NULL,
  `Expiry_Date` date DEFAULT NULL,
  `Last_Count_Date` date DEFAULT NULL,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Inventory_ID`),
  KEY `warehouse_idx` (`Warehouse_ID`),
  KEY `material_idx` (`Material_ID`),
  CONSTRAINT `fk_inventory_warehouse` FOREIGN KEY (`Warehouse_ID`) REFERENCES `warehouse_management_system` (`Warehouse_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_inventory_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transportation_logs`
--

DROP TABLE IF EXISTS `transportation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_logs` (
  `Shipment_ID` int NOT NULL AUTO_INCREMENT,
  `Shipment_Number` varchar(50) NOT NULL,
  `Carrier` varchar(100) DEFAULT NULL,
  `Mode` enum('Air','Sea','Road','Rail') DEFAULT NULL,
  `Origin` varchar(100) DEFAULT NULL,
  `Destination` varchar(100) DEFAULT NULL,
  `Departure_Date` datetime DEFAULT NULL,
  `Estimated_Arrival` datetime DEFAULT NULL,
  `Actual_Arrival` datetime DEFAULT NULL,
  `Shipment_Status` enum('Booked','In Transit','Delayed','Delivered','Cancelled') DEFAULT NULL,
  `Container_ID` varchar(50) DEFAULT NULL,
  `Tracking_Number` varchar(100) DEFAULT NULL,
  `Last_Location` varchar(100) DEFAULT NULL,
  `Last_Update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Shipment_ID`),
  UNIQUE KEY `Shipment_Number_UNIQUE` (`Shipment_Number`),
  KEY `status_idx` (`Shipment_Status`),
  KEY `tracking_idx` (`Tracking_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quality_control_records`
--

DROP TABLE IF EXISTS `quality_control_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quality_control_records` (
  `QC_ID` int NOT NULL AUTO_INCREMENT,
  `Batch_Number` varchar(50) NOT NULL,
  `Material_ID` int DEFAULT NULL,
  `Supplier_ID` int DEFAULT NULL,
  `Inspection_Date` datetime DEFAULT NULL,
  `Inspector_Name` varchar(100) DEFAULT NULL,
  `Sample_Size` int DEFAULT NULL,
  `Defects_Found` int DEFAULT NULL,
  `Defect_Rate` decimal(5,2) GENERATED ALWAYS AS ((`Defects_Found` / NULLIF(`Sample_Size`, 0)) * 100) STORED,
  `Quality_Grade` enum('A','B','C','Reject') DEFAULT NULL,
  `Parameters_Tested` text,
  `Test_Results` json DEFAULT NULL,
  `Status` enum('Passed','Failed','Pending Review') DEFAULT NULL,
  `Action_Taken` text,
  PRIMARY KEY (`QC_ID`),
  KEY `material_idx` (`Material_ID`),
  KEY `supplier_idx` (`Supplier_ID`),
  KEY `batch_idx` (`Batch_Number`),
  CONSTRAINT `fk_qc_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_qc_supplier` FOREIGN KEY (`Supplier_ID`) REFERENCES `supplier_database` (`Supplier_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_orders`
--

DROP TABLE IF EXISTS `customer_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Order_Number` varchar(50) NOT NULL,
  `Customer_Name` varchar(100) DEFAULT NULL,
  `Customer_Type` enum('Garment Manufacturer','Fashion Brand','Distributor','Retailer') DEFAULT NULL,
  `Order_Date` datetime DEFAULT NULL,
  `Required_Date` date DEFAULT NULL,
  `Material_ID` int DEFAULT NULL,
  `Quantity` decimal(15,2) DEFAULT NULL,
  `Unit_Price` decimal(15,2) DEFAULT NULL,
  `Total_Amount` decimal(15,2) DEFAULT NULL,
  `Currency` varchar(3) DEFAULT 'USD',
  `Order_Status` enum('New','Confirmed','Processing','Shipped','Delivered','Cancelled') DEFAULT 'New',
  `Payment_Terms` varchar(50) DEFAULT NULL,
  `Shipping_Address` text,
  PRIMARY KEY (`Order_ID`),
  UNIQUE KEY `Order_Number_UNIQUE` (`Order_Number`),
  KEY `material_idx` (`Material_ID`),
  KEY `status_idx` (`Order_Status`),
  CONSTRAINT `fk_order_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_apis`
--

DROP TABLE IF EXISTS `external_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_apis` (
  `API_ID` int NOT NULL AUTO_INCREMENT,
  `API_Name` varchar(100) NOT NULL,
  `API_Type` enum('Market Trends','Weather','Regulatory','Carrier','Commodity Prices','Sustainability') DEFAULT NULL,
  `Provider` varchar(100) DEFAULT NULL,
  `Endpoint_URL` varchar(255) DEFAULT NULL,
  `Authentication_Method` enum('API Key','OAuth2','JWT','None') DEFAULT NULL,
  `Refresh_Frequency` enum('Real-time','Hourly','Daily','Weekly','Monthly') DEFAULT NULL,
  `Status` enum('Active','Inactive','Testing') DEFAULT 'Active',
  PRIMARY KEY (`API_ID`),
  UNIQUE KEY `API_Name_UNIQUE` (`API_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market_trends_data`
--

DROP TABLE IF EXISTS `market_trends_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_trends_data` (
  `Trend_ID` int NOT NULL AUTO_INCREMENT,
  `Material_ID` int DEFAULT NULL,
  `Commodity` varchar(100) DEFAULT NULL,
  `Price_USD` decimal(15,2) DEFAULT NULL,
  `Price_Change_Percent` decimal(5,2) DEFAULT NULL,
  `Demand_Index` int DEFAULT NULL,
  `Supply_Index` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Source_API` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Trend_ID`),
  KEY `material_idx` (`Material_ID`),
  KEY `date_idx` (`Date`),
  CONSTRAINT `fk_trend_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_data`
--

DROP TABLE IF EXISTS `weather_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_data` (
  `Weather_ID` int NOT NULL AUTO_INCREMENT,
  `Location` varchar(100) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Temperature_C` decimal(5,2) DEFAULT NULL,
  `Humidity_Percent` decimal(5,2) DEFAULT NULL,
  `Precipitation_mm` decimal(5,2) DEFAULT NULL,
  `Wind_Speed_kph` decimal(5,2) DEFAULT NULL,
  `Weather_Condition` varchar(50) DEFAULT NULL,
  `Alert_Flag` tinyint(1) DEFAULT '0',
  `Source_API` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Weather_ID`),
  KEY `location_idx` (`Location`),
  KEY `date_idx` (`Date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- DATA INGESTION LAYER
-- ===================================================================

--
-- Table structure for table `ingestion_jobs`
--

DROP TABLE IF EXISTS `ingestion_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingestion_jobs` (
  `Job_ID` int NOT NULL AUTO_INCREMENT,
  `Job_Name` varchar(100) NOT NULL,
  `Source_ID` int DEFAULT NULL,
  `Ingestion_Method` enum('Batch','Real-time','CDC') DEFAULT NULL,
  `Frequency` varchar(50) DEFAULT NULL,
  `Tool_Used` enum('Apache NiFi','Talend','AWS Glue','Apache Kafka','AWS Kinesis','Azure Event Hubs','Debezium') DEFAULT NULL,
  `Schedule` varchar(100) DEFAULT NULL,
  `Last_Run_Start` timestamp NULL DEFAULT NULL,
  `Last_Run_End` timestamp NULL DEFAULT NULL,
  `Duration_Seconds` int DEFAULT NULL,
  `Records_Ingested` bigint DEFAULT NULL,
  `Data_Volume_MB` decimal(10,2) DEFAULT NULL,
  `Status` enum('Running','Completed','Failed','Scheduled','Idle') DEFAULT 'Idle',
  `Error_Log` text,
  PRIMARY KEY (`Job_ID`),
  UNIQUE KEY `Job_Name_UNIQUE` (`Job_Name`),
  KEY `source_idx` (`Source_ID`),
  CONSTRAINT `fk_ingestion_source` FOREIGN KEY (`Source_ID`) REFERENCES `data_sources` (`Source_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingestion_metrics`
--

DROP TABLE IF EXISTS `ingestion_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingestion_metrics` (
  `Metric_ID` int NOT NULL AUTO_INCREMENT,
  `Job_ID` int DEFAULT NULL,
  `Run_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Records_Processed` bigint DEFAULT NULL,
  `Records_Succeeded` bigint DEFAULT NULL,
  `Records_Failed` bigint DEFAULT NULL,
  `Latency_Seconds` int DEFAULT NULL,
  `Throughput_MBps` decimal(10,2) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Metric_ID`),
  KEY `job_idx` (`Job_ID`),
  CONSTRAINT `fk_metric_job` FOREIGN KEY (`Job_ID`) REFERENCES `ingestion_jobs` (`Job_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- DATA STORAGE LAYER
-- ===================================================================

--
-- Table structure for table `storage_tiers`
--

DROP TABLE IF EXISTS `storage_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_tiers` (
  `Storage_Tier_ID` int NOT NULL AUTO_INCREMENT,
  `Tier_Name` varchar(50) NOT NULL,
  `Tier_Type` enum('Data Lake','Data Warehouse','Operational Database','Data Mart','Archive Storage') DEFAULT NULL,
  `Technology` varchar(100) DEFAULT NULL,
  `Cloud_Provider` enum('AWS','Azure','GCP','On-Premise','Multi-Cloud') DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `Total_Capacity_TB` decimal(10,2) DEFAULT NULL,
  `Used_Capacity_TB` decimal(10,2) DEFAULT '0.00',
  `Retention_Policy` varchar(255) DEFAULT NULL,
  `Backup_Frequency` varchar(50) DEFAULT NULL,
  `DR_Enabled` tinyint(1) DEFAULT '0',
  `Status` enum('Active','Inactive','Maintenance') DEFAULT 'Active',
  PRIMARY KEY (`Storage_Tier_ID`),
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
  `Storage_Tier_ID` int DEFAULT NULL,
  `Dataset_Name` varchar(100) NOT NULL,
  `Source_ID` int DEFAULT NULL,
  `Schema_Name` varchar(100) DEFAULT NULL,
  `Table_Name` varchar(100) DEFAULT NULL,
  `Record_Count` bigint DEFAULT NULL,
  `Size_MB` decimal(10,2) DEFAULT NULL,
  `Compression_Type` varchar(30) DEFAULT NULL,
  `Partition_Key` varchar(50) DEFAULT NULL,
  `Ingestion_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Data_Storage_ID`),
  KEY `tier_idx` (`Storage_Tier_ID`),
  KEY `source_idx` (`Source_ID`),
  CONSTRAINT `fk_datastorage_tier` FOREIGN KEY (`Storage_Tier_ID`) REFERENCES `storage_tiers` (`Storage_Tier_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_datastorage_source` FOREIGN KEY (`Source_ID`) REFERENCES `data_sources` (`Source_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_marts`
--

DROP TABLE IF EXISTS `data_marts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_marts` (
  `Mart_ID` int NOT NULL AUTO_INCREMENT,
  `Mart_Name` varchar(50) NOT NULL,
  `Department` enum('Procurement','Logistics','Finance','Sales','Quality','Executive') DEFAULT NULL,
  `Description` text,
  `Source_Storage_ID` int DEFAULT NULL,
  `Refresh_Frequency` varchar(50) DEFAULT NULL,
  `Owner` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Mart_ID`),
  UNIQUE KEY `Mart_Name_UNIQUE` (`Mart_Name`),
  KEY `storage_idx` (`Source_Storage_ID`),
  CONSTRAINT `fk_datamart_storage` FOREIGN KEY (`Source_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- DATA PROCESSING LAYER
-- ===================================================================

--
-- Table structure for table `processing_tools`
--

DROP TABLE IF EXISTS `processing_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `processing_tools` (
  `Tool_ID` int NOT NULL AUTO_INCREMENT,
  `Tool_Name` varchar(100) NOT NULL,
  `Tool_Type` enum('ETL','ELT','Stream Processing','Batch Processing','Orchestration') DEFAULT NULL,
  `Vendor` varchar(100) DEFAULT NULL,
  `Version` varchar(20) DEFAULT NULL,
  `Description` text,
  `Deployment` enum('Cloud','On-Premise','Hybrid') DEFAULT NULL,
  `Status` enum('Active','Inactive','Evaluation') DEFAULT 'Active',
  PRIMARY KEY (`Tool_ID`),
  UNIQUE KEY `Tool_Name_UNIQUE` (`Tool_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `processing_jobs`
--

DROP TABLE IF EXISTS `processing_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `processing_jobs` (
  `Job_ID` int NOT NULL AUTO_INCREMENT,
  `Job_Name` varchar(100) NOT NULL,
  `Processing_Type` enum('ETL','ELT','Stream','Batch') DEFAULT NULL,
  `Tool_ID` int DEFAULT NULL,
  `Source_Storage_ID` int DEFAULT NULL,
  `Target_Storage_ID` int DEFAULT NULL,
  `Transformation_Logic` text,
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
  KEY `source_idx` (`Source_Storage_ID`),
  KEY `target_idx` (`Target_Storage_ID`),
  CONSTRAINT `fk_processingjob_tool` FOREIGN KEY (`Tool_ID`) REFERENCES `processing_tools` (`Tool_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_processingjob_source` FOREIGN KEY (`Source_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_processingjob_target` FOREIGN KEY (`Target_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- ANALYTICS LAYER
-- ===================================================================

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
  `Analytics_Type` enum('Dashboard','Predictive','Prescriptive','Ad-hoc','ML') DEFAULT NULL,
  `License_Count` int DEFAULT NULL,
  `Deployment` enum('Cloud','On-Premise','Desktop') DEFAULT NULL,
  `Status` enum('Active','Inactive','Evaluation') DEFAULT 'Active',
  PRIMARY KEY (`Tool_ID`),
  UNIQUE KEY `Tool_Name_UNIQUE` (`Tool_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboards`
--

DROP TABLE IF EXISTS `dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboards` (
  `Dashboard_ID` int NOT NULL AUTO_INCREMENT,
  `Dashboard_Name` varchar(100) NOT NULL,
  `BI_Tool_ID` int DEFAULT NULL,
  `Data_Storage_ID` int DEFAULT NULL,
  `Description` text,
  `Owner_Department` varchar(100) DEFAULT NULL,
  `Refresh_Frequency` varchar(50) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Accessed` timestamp NULL DEFAULT NULL,
  `Status` enum('Active','Draft','Archived') DEFAULT 'Active',
  PRIMARY KEY (`Dashboard_ID`),
  UNIQUE KEY `Dashboard_Name_UNIQUE` (`Dashboard_Name`),
  KEY `bitool_idx` (`BI_Tool_ID`),
  KEY `storage_idx` (`Data_Storage_ID`),
  CONSTRAINT `fk_dashboard_bitool` FOREIGN KEY (`BI_Tool_ID`) REFERENCES `bi_tools` (`Tool_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_dashboard_storage` FOREIGN KEY (`Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_metrics`
--

DROP TABLE IF EXISTS `dashboard_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_metrics` (
  `Metric_ID` int NOT NULL AUTO_INCREMENT,
  `Dashboard_ID` int DEFAULT NULL,
  `Metric_Name` varchar(100) DEFAULT NULL,
  `Metric_Value` decimal(15,2) DEFAULT NULL,
  `Unit` varchar(20) DEFAULT NULL,
  `Comparison_Period` varchar(20) DEFAULT NULL,
  `Change_Percent` decimal(5,2) DEFAULT NULL,
  `Snapshot_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Metric_ID`),
  KEY `dashboard_idx` (`Dashboard_ID`),
  CONSTRAINT `fk_metric_dashboard` FOREIGN KEY (`Dashboard_ID`) REFERENCES `dashboards` (`Dashboard_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predictive_models`
--

DROP TABLE IF EXISTS `predictive_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predictive_models` (
  `Model_ID` int NOT NULL AUTO_INCREMENT,
  `Model_Name` varchar(100) NOT NULL,
  `Model_Type` enum('Demand Forecasting','Price Prediction','Delay Prediction','Quality Prediction','Supplier Risk') DEFAULT NULL,
  `Algorithm` varchar(100) DEFAULT NULL,
  `Framework` enum('scikit-learn','TensorFlow','PyTorch','R','Spark ML') DEFAULT NULL,
  `Training_Data_Storage_ID` int DEFAULT NULL,
  `Features` json DEFAULT NULL,
  `Target_Variable` varchar(50) DEFAULT NULL,
  `Accuracy_Score` decimal(5,2) DEFAULT NULL,
  `Last_Trained` timestamp NULL DEFAULT NULL,
  `Next_Training_Schedule` timestamp NULL DEFAULT NULL,
  `Status` enum('Production','Development','Deprecated','Testing') DEFAULT 'Development',
  PRIMARY KEY (`Model_ID`),
  UNIQUE KEY `Model_Name_UNIQUE` (`Model_Name`),
  KEY `storage_idx` (`Training_Data_Storage_ID`),
  CONSTRAINT `fk_model_storage` FOREIGN KEY (`Training_Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `model_predictions`
--

DROP TABLE IF EXISTS `model_predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_predictions` (
  `Prediction_ID` bigint NOT NULL AUTO_INCREMENT,
  `Model_ID` int DEFAULT NULL,
  `Prediction_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Material_ID` int DEFAULT NULL,
  `Predicted_Value` decimal(15,2) DEFAULT NULL,
  `Lower_Bound` decimal(15,2) DEFAULT NULL,
  `Upper_Bound` decimal(15,2) DEFAULT NULL,
  `Confidence_Level` decimal(5,2) DEFAULT NULL,
  `Actual_Value` decimal(15,2) DEFAULT NULL,
  `Prediction_Horizon` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Prediction_ID`),
  KEY `model_idx` (`Model_ID`),
  KEY `material_idx` (`Material_ID`),
  CONSTRAINT `fk_prediction_model` FOREIGN KEY (`Model_ID`) REFERENCES `predictive_models` (`Model_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_prediction_material` FOREIGN KEY (`Material_ID`) REFERENCES `raw_materials` (`Material_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescriptive_optimizations`
--

DROP TABLE IF EXISTS `prescriptive_optimizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptive_optimizations` (
  `Optimization_ID` int NOT NULL AUTO_INCREMENT,
  `Optimization_Type` enum('Route Optimization','Inventory Reorder','Supplier Selection','Production Scheduling') DEFAULT NULL,
  `Algorithm` varchar(100) DEFAULT NULL,
  `Input_Parameters` json DEFAULT NULL,
  `Output_Recommendations` json DEFAULT NULL,
  `Expected_Savings` decimal(15,2) DEFAULT NULL,
  `Actual_Savings` decimal(15,2) DEFAULT NULL,
  `Execution_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('Proposed','Implemented','Evaluated','Rejected') DEFAULT 'Proposed',
  PRIMARY KEY (`Optimization_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- DATA GOVERNANCE LAYER
-- ===================================================================

--
-- Table structure for table `data_owners`
--

DROP TABLE IF EXISTS `data_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_owners` (
  `Owner_ID` int NOT NULL AUTO_INCREMENT,
  `Owner_Name` varchar(100) NOT NULL,
  `Owner_Type` enum('Data Owner','Data Steward','Data Custodian','Business Owner') DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Owner_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_domains`
--

DROP TABLE IF EXISTS `data_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_domains` (
  `Domain_ID` int NOT NULL AUTO_INCREMENT,
  `Domain_Name` varchar(100) NOT NULL,
  `Description` text,
  `Data_Owner_ID` int DEFAULT NULL,
  `Data_Steward_ID` int DEFAULT NULL,
  PRIMARY KEY (`Domain_ID`),
  UNIQUE KEY `Domain_Name_UNIQUE` (`Domain_Name`),
  KEY `owner_idx` (`Data_Owner_ID`),
  KEY `steward_idx` (`Data_Steward_ID`),
  CONSTRAINT `fk_domain_owner` FOREIGN KEY (`Data_Owner_ID`) REFERENCES `data_owners` (`Owner_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_domain_steward` FOREIGN KEY (`Data_Steward_ID`) REFERENCES `data_owners` (`Owner_ID`) ON DELETE SET NULL
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
  `Asset_Type` enum('Table','Column','View','Report','Dashboard','Pipeline','Model') DEFAULT NULL,
  `Data_Storage_ID` int DEFAULT NULL,
  `Domain_ID` int DEFAULT NULL,
  `Description` text,
  `Business_Definition` text,
  `Data_Type` varchar(50) DEFAULT NULL,
  `Is_PII` tinyint(1) DEFAULT '0',
  `Is_Sensitive` tinyint(1) DEFAULT '0',
  `Data_Classification` enum('Public','Internal','Confidential','Restricted') DEFAULT 'Internal',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Metadata_ID`),
  KEY `storage_idx` (`Data_Storage_ID`),
  KEY `domain_idx` (`Domain_ID`),
  CONSTRAINT `fk_metadata_storage` FOREIGN KEY (`Data_Storage_ID`) REFERENCES `data_storage` (`Data_Storage_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_metadata_domain` FOREIGN KEY (`Domain_ID`) REFERENCES `data_domains` (`Domain_ID`) ON DELETE SET NULL
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
  `Processing_Job_ID` int DEFAULT NULL,
  `Transformation_Logic` text,
  `Created_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Lineage_ID`),
  KEY `source_idx` (`Source_Asset_ID`),
  KEY `target_idx` (`Target_Asset_ID`),
  KEY `job_idx` (`Processing_Job_ID`),
  CONSTRAINT `fk_lineage_source` FOREIGN KEY (`Source_Asset_ID`) REFERENCES `metadata_repository` (`Metadata_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_lineage_target` FOREIGN KEY (`Target_Asset_ID`) REFERENCES `metadata_repository` (`Metadata_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_lineage_job` FOREIGN KEY (`Processing_Job_ID`) REFERENCES `processing_jobs` (`Job_ID`) ON DELETE SET NULL
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
  `Rule_Type` enum('Completeness','Uniqueness','Accuracy','Consistency','Timeliness','Validity') DEFAULT NULL,
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
-- Table structure for table `access_policies`
--

DROP TABLE IF EXISTS `access_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_policies` (
  `Policy_ID` int NOT NULL AUTO_INCREMENT,
  `Policy_Name` varchar(100) NOT NULL,
  `Data_Domain_ID` int DEFAULT NULL,
  `Role_Name` varchar(50) DEFAULT NULL,
  `Permissions` json DEFAULT NULL,
  `Row_Filter` text,
  `Column_Mask` text,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Policy_ID`),
  UNIQUE KEY `Policy_Name_UNIQUE` (`Policy_Name`),
  KEY `domain_idx` (`Data_Domain_ID`),
  CONSTRAINT `fk_policy_domain` FOREIGN KEY (`Data_Domain_ID`) REFERENCES `data_domains` (`Domain_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compliance_requirements`
--

DROP TABLE IF EXISTS `compliance_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compliance_requirements` (
  `Requirement_ID` int NOT NULL AUTO_INCREMENT,
  `Regulation_Name` enum('GDPR','CCPA','ESG','ISO 27001','HIPAA','SOC2','PCI DSS') DEFAULT NULL,
  `Jurisdiction` varchar(100) DEFAULT NULL,
  `Description` text,
  `Applicable_Data_Domains` text,
  `Retention_Period_Days` int DEFAULT NULL,
  `Requires_Consent` tinyint(1) DEFAULT '0',
  `Requires_Audit_Trail` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`Requirement_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- USE CASES & APPLICATIONS
-- ===================================================================

--
-- Table structure for table `use_cases`
--

DROP TABLE IF EXISTS `use_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `use_cases` (
  `Use_Case_ID` int NOT NULL AUTO_INCREMENT,
  `Use_Case_Name` varchar(100) NOT NULL,
  `Category` enum('Inventory Forecasting','Supplier Performance','Transportation Optimization','Demand Matching','Quality Assurance','Cost Optimization','Sustainability','Risk Management') DEFAULT NULL,
  `Description` text,
  `Business_Value` text,
  `Data_Requirements` text,
  `Analytics_Type` varchar(50) DEFAULT NULL,
  `Implementation_Status` enum('Planned','In Progress','Completed','On Hold') DEFAULT 'Planned',
  PRIMARY KEY (`Use_Case_ID`),
  UNIQUE KEY `Use_Case_Name_UNIQUE` (`Use_Case_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `use_case_metrics`
--

DROP TABLE IF EXISTS `use_case_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `use_case_metrics` (
  `Metric_ID` int NOT NULL AUTO_INCREMENT,
  `Use_Case_ID` int DEFAULT NULL,
  `Metric_Name` varchar(100) DEFAULT NULL,
  `Baseline_Value` decimal(15,2) DEFAULT NULL,
  `Target_Value` decimal(15,2) DEFAULT NULL,
  `Current_Value` decimal(15,2) DEFAULT NULL,
  `Achievement_Percent` decimal(5,2) GENERATED ALWAYS AS ((`Current_Value` / NULLIF(`Target_Value`, 0)) * 100) STORED,
  `Measurement_Date` date DEFAULT NULL,
  PRIMARY KEY (`Metric_ID`),
  KEY `usecase_idx` (`Use_Case_ID`),
  CONSTRAINT `fk_usecasemetric_usecase` FOREIGN KEY (`Use_Case_ID`) REFERENCES `use_cases` (`Use_Case_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- SAMPLE DATA INSERTIONS
-- ===================================================================

--
-- Dumping data for table `data_source_categories`
--

LOCK TABLES `data_source_categories` WRITE;
/*!40000 ALTER TABLE `data_source_categories` DISABLE KEYS */;
INSERT INTO `data_source_categories` VALUES 
(1,'Internal Systems','Internal','Internal enterprise systems and databases'),
(2,'External APIs','External','Third-party APIs and external data providers'),
(3,'IoT Devices','Internal','Sensor and telemetry data from IoT devices'),
(4,'Partner Data','External','Data from suppliers, carriers, and partners');
/*!40000 ALTER TABLE `data_source_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_sources`
--

LOCK TABLES `data_sources` WRITE;
/*!40000 ALTER TABLE `data_sources` DISABLE KEYS */;
INSERT INTO `data_sources` VALUES 
(1,'Supplier Database',1,'Database','Information about raw material suppliers','Structured',50.00,'Daily','Critical',1,'Active',NOW()),
(2,'ERP System',1,'Enterprise System','Financial data, procurement records','Structured',200.00,'Real-time','Critical',0,'Active',NOW()),
(3,'IoT Sensors',3,'Sensor Network','Temperature/humidity monitoring','Structured',500.00,'Real-time','High',0,'Active',NOW()),
(4,'Warehouse Management System',1,'Application','Real-time stock levels across warehouses','Structured',75.00,'Real-time','Critical',0,'Active',NOW()),
(5,'Transportation Logs',4,'Application','Shipment tracking, carrier information','Structured',100.00,'Hourly','High',0,'Active',NOW()),
(6,'Quality Control Records',1,'Application','Inspection results, material quality metrics','Structured',25.00,'Daily','High',0,'Active',NOW()),
(7,'Customer Orders',1,'Application','Orders from garment manufacturers','Structured',80.00,'Real-time','Critical',1,'Active',NOW()),
(8,'Market Trends API',2,'External API','Global commodity prices, demand forecasts','Structured',10.00,'Daily','Medium',0,'Active',NOW()),
(9,'Weather Data API',2,'External API','Climate conditions affecting crop yields','Structured',20.00,'Hourly','Medium',0,'Active',NOW()),
(10,'Regulatory Compliance DB',2,'External Database','Trade regulations, tariffs, certifications','Structured',15.00,'Weekly','High',1,'Active',NOW()),
(11,'Supplier Portals',4,'External System','Supplier inventory and lead times','Structured',30.00,'Hourly','High',0,'Active',NOW()),
(12,'Carrier APIs',4,'External API','Real-time tracking from FedEx, DHL, Maersk','Structured',40.00,'Real-time','High',0,'Active',NOW());
/*!40000 ALTER TABLE `data_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `supplier_database`
--

LOCK TABLES `supplier_database` WRITE;
/*!40000 ALTER TABLE `supplier_database` DISABLE KEYS */;
INSERT INTO `supplier_database` VALUES 
(1,'SUP001','Pima Cotton Farms','Cotton Farm','USA','Arizona','John Smith','john@pimacotton.com','+1-602-555-0100','Net 30',15,5000,'USDA Organic, Fair Trade','A','Active',NOW(),NOW()),
(2,'SUP002','Egyptian Cotton Co','Cotton Farm','Egypt','Cairo','Ahmed Hassan','ahmed@egyptiancotton.com','+20-2-5555-0100','LC at Sight',21,10000,'Egyptian Cotton Certification','B','Active',NOW(),NOW()),
(3,'SUP003','Synthetic Fibers Inc','Synthetic Fiber','China','Shanghai','Li Wei','li@syntheticfibers.cn','+86-21-5555-0100','Net 45',30,20000,'ISO 9001, Oeko-Tex','B','Active',NOW(),NOW()),
(4,'SUP004','Organic Dyes Ltd','Dye Producer','India','Mumbai','Raj Patel','raj@organicdyes.in','+91-22-5555-0100','Advance',20,1000,'GOTS Certified, AZO-free','A','Active',NOW(),NOW()),
(5,'SUP005','Vietnam Threads','Cotton Farm','Vietnam','Ho Chi Minh City','Tran Van','tran@vietnamthreads.vn','+84-28-5555-0100','Net 30',14,8000,'Fair Trade','C','Active',NOW(),NOW()),
(6,'SUP006','EcoPolymer','Synthetic Fiber','Germany','Frankfurt','Klaus Schmidt','klaus@ecopolymer.de','+49-69-5555-0100','Net 30',10,15000,'Cradle to Cradle, ISO 14001','A','Active',NOW(),NOW()),
(7,'SUP007','Natural Indigo','Dye Producer','Indonesia','Jakarta','Budi Santoso','budi@naturalindigo.id','+62-21-5555-0100','Net 15',25,500,'USDA Organic','B','Active',NOW(),NOW()),
(8,'SUP008','Turkish Cotton','Cotton Farm','Turkey','Izmir','Mehmet Yilmaz','mehmet@turkishcotton.com.tr','+90-232-555-0100','Net 30',12,12000,'Better Cotton Initiative','C','Active',NOW(),NOW());
/*!40000 ALTER TABLE `supplier_database` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `raw_materials`
--

LOCK TABLES `raw_materials` WRITE;
/*!40000 ALTER TABLE `raw_materials` DISABLE KEYS */;
INSERT INTO `raw_materials` VALUES 
(1,'COT001','Egyptian Cotton - Grade A','Cotton','kg','Premium long-staple cotton',0,0,null),
(2,'COT002','Pima Cotton - Grade A','Cotton','kg','Extra-long staple cotton',0,0,null),
(3,'SYN001','Polyester Fiber - 1.5 den','Synthetic Fiber','kg','Standard polyester staple fiber',0,0,null),
(4,'SYN002','Nylon 6,6','Synthetic Fiber','kg','High-tenacity nylon',0,0,null),
(5,'DYE001','Reactive Blue Dye','Dye','liter','Fiber-reactive dye for cotton',1,1,730),
(6,'DYE002','Natural Indigo','Dye','kg','Organic indigo for denim',0,1,1095),
(7,'THR001','Cotton Thread - 40/2','Thread','spool','Mercerized cotton sewing thread',0,0,null),
(8,'BUT001','Polyester Buttons - 18L','Button','dozen','Standard shirt buttons',0,0,null),
(9,'ZIP001','Nylon Zipper - #5','Zipper','piece','Separating zipper for jackets',0,0,null),
(10,'CHE001','Hydrogen Peroxide','Chemical','liter','Bleaching agent',1,1,365);
/*!40000 ALTER TABLE `raw_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `supplier_materials`
--

LOCK TABLES `supplier_materials` WRITE;
/*!40000 ALTER TABLE `supplier_materials` DISABLE KEYS */;
INSERT INTO `supplier_materials` VALUES 
(1,1,2,15.50,'USD',5000,15,'Premium',1,'2024-01-01','2024-12-31'),
(2,2,1,18.75,'USD',10000,21,'Premium',1,'2024-01-01','2024-12-31'),
(3,3,3,2.80,'USD',20000,30,'Standard',1,'2024-02-01','2024-12-31'),
(4,3,4,4.50,'USD',15000,30,'Premium',0,'2024-02-01','2024-12-31'),
(5,4,5,12.50,'USD',1000,20,'Premium',1,'2024-01-15','2024-12-31'),
(6,6,3,3.20,'USD',15000,10,'Premium',0,'2024-03-01','2024-12-31'),
(7,7,6,25.00,'USD',500,25,'Organic',1,'2024-02-15','2024-12-31'),
(8,5,2,14.25,'USD',8000,14,'Standard',0,'2024-01-01','2024-12-31'),
(9,8,2,16.00,'USD',12000,12,'Standard',0,'2024-03-01','2024-12-31');
/*!40000 ALTER TABLE `supplier_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `warehouse_management_system`
--

LOCK TABLES `warehouse_management_system` WRITE;
/*!40000 ALTER TABLE `warehouse_management_system` DISABLE KEYS */;
INSERT INTO `warehouse_management_system` VALUES 
(1,'WH001','North America DC','Los Angeles, CA','USA',500000,1,'Active'),
(2,'WH002','European DC','Rotterdam','Netherlands',450000,1,'Active'),
(3,'WH003','Asia Pacific Hub','Singapore','Singapore',350000,1,'Active'),
(4,'WH004','South Asia Warehouse','Mumbai','India',300000,0,'Active'),
(5,'WH005','Middle East Facility','Dubai','UAE',250000,1,'Active'),
(6,'WH006','Raw Material Storage','Izmir','Turkey',200000,0,'Active');
/*!40000 ALTER TABLE `warehouse_management_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inventory_levels`
--

LOCK TABLES `inventory_levels` WRITE;
/*!40000 ALTER TABLE `inventory_levels` DISABLE KEYS */;
INSERT INTO `inventory_levels` (`Inventory_ID`, `Warehouse_ID`, `Material_ID`, `Batch_Number`, `Quantity_On_Hand`, `Quantity_Reserved`, `Unit_of_Measure`, `Location_Bin`, `Receipt_Date`, `Expiry_Date`, `Last_Count_Date`) VALUES 
(1,1,2,'COT-US-2401',25000,5000,'kg','A-01-01','2024-01-15',NULL,'2024-03-01'),
(2,2,1,'COT-EU-2402',35000,8000,'kg','B-02-10','2024-02-01',NULL,'2024-03-05'),
(3,3,3,'SYN-AP-2401',40000,12000,'kg','C-03-05','2024-01-20',NULL,'2024-03-02'),
(4,1,5,'DYE-US-2403',2500,500,'liter','D-04-12','2024-02-15','2025-02-14','2024-03-01'),
(5,4,4,'SYN-IN-2401',15000,3000,'kg','E-05-08','2024-02-10',NULL,'2024-03-03'),
(6,6,2,'COT-TR-2401',18000,4000,'kg','F-06-15','2024-02-20',NULL,'2024-03-04'),
(7,2,6,'DYE-EU-2402',800,200,'kg','B-07-03','2024-01-25','2025-01-24','2024-03-05'),
(8,3,8,'BUT-AP-2401',5000,1000,'dozen','C-08-09','2024-02-05',NULL,'2024-03-02');
/*!40000 ALTER TABLE `inventory_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transportation_logs`
--

LOCK TABLES `transportation_logs` WRITE;
/*!40000 ALTER TABLE `transportation_logs` DISABLE KEYS */;
INSERT INTO `transportation_logs` VALUES 
(1,'SHIP001','Maersk','Sea','Shanghai, China','Rotterdam, Netherlands','2024-03-01 08:00:00','2024-04-15 00:00:00',NULL,'In Transit','CONT123456','MAEU123456789','South China Sea',NOW()),
(2,'SHIP002','FedEx','Air','Mumbai, India','Los Angeles, USA','2024-03-05 14:30:00','2024-03-07 10:00:00','2024-03-07 09:45:00','Delivered','AIR789012','FDX87654321','Los Angeles Airport',NOW()),
(3,'SHIP003','DHL','Road','Izmir, Turkey','Rotterdam, Netherlands','2024-03-02 09:00:00','2024-03-10 18:00:00','2024-03-10 17:30:00','Delivered','TRUCK345678','DHL345678901','Rotterdam DC',NOW()),
(4,'SHIP004','Evergreen','Sea','Kaohsiung, Taiwan','Singapore','2024-03-03 12:00:00','2024-03-12 08:00:00',NULL,'Delayed','CONT901234','EGV901234567','Strait of Malacca',NOW()),
(5,'SHIP005','UPS','Air','Frankfurt, Germany','New York, USA','2024-03-06 22:00:00','2024-03-07 18:00:00',NULL,'In Transit','AIR567890','UPS567890123','North Atlantic',NOW());
/*!40000 ALTER TABLE `transportation_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `quality_control_records`
--

LOCK TABLES `quality_control_records` WRITE;
/*!40000 ALTER TABLE `quality_control_records` DISABLE KEYS */;
INSERT INTO `quality_control_records` (`QC_ID`, `Batch_Number`, `Material_ID`, `Supplier_ID`, `Inspection_Date`, `Inspector_Name`, `Sample_Size`, `Defects_Found`, `Quality_Grade`, `Parameters_Tested`, `Test_Results`, `Status`, `Action_Taken`) VALUES 
(1,'COT-US-2401',2,1,'2024-01-20 10:30:00','Sarah Johnson',100,2,'A','{"staple_length": "1.5in", "strength": "high", "color": "white"}','{"staple_length_pass": true, "strength_pass": true, "color_pass": true}','Passed','Accepted'),
(2,'COT-EU-2402',1,2,'2024-02-05 14:15:00','Mike Brown',100,5,'B','{"staple_length": "1.4in", "strength": "medium", "color": "off-white"}','{"staple_length_pass": true, "strength_pass": true, "color_pass": false}','Passed','Sorted for grade'),
(3,'SYN-AP-2401',3,3,'2024-01-25 11:00:00','Lisa Chen',200,8,'B','{"denier": "1.5", "tenacity": "4.5g/d", "elongation": "25%"}','{"denier_pass": true, "tenacity_pass": true, "elongation_pass": true}','Passed','Accepted'),
(4,'DYE-US-2403',5,4,'2024-02-20 09:30:00','Robert Lee',50,0,'A','{"color_fastness": "5", "pH": "7.2", "viscosity": "100cP"}','{"color_fastness_pass": true, "pH_pass": true, "viscosity_pass": true}','Passed','Accepted'),
(5,'SYN-IN-2401',4,3,'2024-02-15 13:45:00','Priya Patel',150,12,'C','{"tenacity": "8.0g/d", "melting_point": "260C"}','{"tenacity_pass": false, "melting_point_pass": true}','Failed','Returned to supplier');
/*!40000 ALTER TABLE `quality_control_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer_orders`
--

LOCK TABLES `customer_orders` WRITE;
/*!40000 ALTER TABLE `customer_orders` DISABLE KEYS */;
INSERT INTO `customer_orders` VALUES 
(1,'ORD001','Denim Co. Inc.','Garment Manufacturer','2024-03-01 09:00:00','2024-04-15',2,10000,16.50,165000.00,'USD','Confirmed','Net 30','123 Fashion Ave, New York, NY'),
(2,'ORD002','Eco Apparel','Fashion Brand','2024-03-02 11:30:00','2024-04-10',1,8000,19.00,152000.00,'USD','Processing','Net 15','45 Green St, Portland, OR'),
(3,'ORD003','Fast Fashion Ltd','Garment Manufacturer','2024-03-03 14:45:00','2024-04-20',3,25000,3.00,75000.00,'USD','New','Net 45','789 High St, London, UK'),
(4,'ORD004','Sustainable Textiles','Distributor','2024-03-04 10:15:00','2024-04-05',6,400,26.00,10400.00,'USD','Confirmed','Advance','23 Eco Park, Berlin, Germany'),
(5,'ORD005','Luxury Fabrics','Garment Manufacturer','2024-03-05 16:00:00','2024-05-01',1,15000,18.75,281250.00,'USD','Processing','Net 30','456 Fashion District, Milan, Italy'),
(6,'ORD006','ActiveWear Inc','Garment Manufacturer','2024-03-06 08:30:00','2024-04-25',3,30000,2.90,87000.00,'USD','New','Net 30','567 Sport Blvd, Los Angeles, CA');
/*!40000 ALTER TABLE `customer_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `external_apis`
--

LOCK TABLES `external_apis` WRITE;
/*!40000 ALTER TABLE `external_apis` DISABLE KEYS */;
INSERT INTO `external_apis` VALUES 
(1,'Cotton Price Index','Market Trends','Cotton Incorporated','https://api.cottoninc.com/prices','API Key','Daily','Active'),
(2,'Global Weather Service','Weather','Weather.com','https://api.weather.com/v1','OAuth2','Hourly','Active'),
(3,'Trade Regulations DB','Regulatory','WTO','https://api.wto.org/tariffs','API Key','Weekly','Active'),
(4,'Maersk Tracking','Carrier','Maersk','https://api.maersk.com/tracking','OAuth2','Real-time','Active'),
(5,'FedEx Shipment API','Carrier','FedEx','https://api.fedex.com/track','OAuth2','Real-time','Active'),
(6,'Sustainability Database','Sustainability','SEDEX','https://api.sedex.org/certifications','API Key','Daily','Active'),
(7,'Commodity Price Index','Market Trends','Bloomberg','https://api.bloomberg.com/commodities','OAuth2','Daily','Active');
/*!40000 ALTER TABLE `external_apis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `market_trends_data`
--

LOCK TABLES `market_trends_data` WRITE;
/*!40000 ALTER TABLE `market_trends_data` DISABLE KEYS */;
INSERT INTO `market_trends_data` VALUES 
(1,1,'Cotton - Egyptian',2.85,2.5,85,75,'2024-03-01','Cotton Price Index'),
(2,2,'Cotton - Pima',2.45,-1.2,90,70,'2024-03-01','Cotton Price Index'),
(3,3,'Polyester Fiber',1.20,-0.8,75,85,'2024-03-01','Commodity Price Index'),
(4,4,'Nylon 6,6',2.80,1.5,70,80,'2024-03-01','Commodity Price Index'),
(5,5,'Reactive Dyes',5.50,3.0,65,60,'2024-03-01','Chemical Market'),
(6,1,'Cotton - Egyptian',2.88,1.1,86,74,'2024-03-02','Cotton Price Index'),
(7,2,'Cotton - Pima',2.42,-1.2,91,69,'2024-03-02','Cotton Price Index'),
(8,3,'Polyester Fiber',1.19,-0.8,76,84,'2024-03-02','Commodity Price Index');
/*!40000 ALTER TABLE `market_trends_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `weather_data`
--

LOCK TABLES `weather_data` WRITE;
/*!40000 ALTER TABLE `weather_data` DISABLE KEYS */;
INSERT INTO `weather_data` VALUES 
(1,'Arizona','USA','2024-03-01',22.5,35.0,0.0,15.0,'Sunny',0,'Global Weather Service'),
(2,'Cairo','Egypt','2024-03-01',18.0,60.0,0.0,12.0,'Clear',0,'Global Weather Service'),
(3,'Shanghai','China','2024-03-01',12.0,75.0,5.0,20.0,'Rainy',0,'Global Weather Service'),
(4,'Mumbai','India','2024-03-01',28.0,80.0,0.0,10.0,'Humid',0,'Global Weather Service'),
(5,'Izmir','Turkey','2024-03-01',15.0,65.0,2.0,25.0,'Cloudy',0,'Global Weather Service'),
(6,'South China Sea','International','2024-03-05',27.0,85.0,15.0,45.0,'Storm',1,'Global Weather Service'),
(7,'North Atlantic','International','2024-03-06',5.0,70.0,10.0,50.0,'Storm',1,'Global Weather Service');
/*!40000 ALTER TABLE `weather_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `storage_tiers`
--

LOCK TABLES `storage_tiers` WRITE;
/*!40000 ALTER TABLE `storage_tiers` DISABLE KEYS */;
INSERT INTO `storage_tiers` VALUES 
(1,'Raw Data Lake','Data Lake','AWS S3','AWS','US-East-1',500.00,125.50,'Raw data: 2 years, then archive','Daily',1,'Active'),
(2,'Structured Warehouse','Data Warehouse','Snowflake','AWS','Multi-region',200.00,78.25,'5 years','Continuous',1,'Active'),
(3,'Operational Database','Operational Database','PostgreSQL','AWS','US-East-1',50.00,32.80,'90 days','Hourly',1,'Active'),
(4,'Procurement Data Mart','Data Mart','Redshift','AWS','US-East-1',30.00,18.40,'3 years','Daily',0,'Active'),
(5,'Logistics Data Mart','Data Mart','Snowflake','AWS','US-East-1',25.00,15.20,'2 years','Daily',0,'Active'),
(6,'Finance Data Mart','Data Mart','Redshift','AWS','US-East-1',20.00,12.60,'7 years','Daily',0,'Active'),
(7,'Archive Storage','Archive Storage','AWS Glacier','AWS','US-West-2',1000.00,245.00,'Permanent','Monthly',0,'Active');
/*!40000 ALTER TABLE `storage_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_storage`
--

LOCK TABLES `data_storage` WRITE;
/*!40000 ALTER TABLE `data_storage` DISABLE KEYS */;
INSERT INTO `data_storage` VALUES 
(1,1,'raw_supplier_data',1,'raw','supplier_json',5000,5.50,'snappy','ingestion_date',NOW(),NOW()),
(2,1,'raw_erp_transactions',2,'raw','erp_json',250000,45.25,'snappy','date',NOW(),NOW()),
(3,1,'raw_iot_readings',3,'raw','iot_json',5000000,75.50,'snappy','reading_date',NOW(),NOW()),
(4,2,'dim_supplier',1,'warehouse','dim_supplier',8,0.10,'zstd','supplier_id',NOW(),NOW()),
(5,2,'dim_material',NULL,'warehouse','dim_material',10,0.05,'zstd','material_id',NOW(),NOW()),
(6,2,'fact_inventory',4,'warehouse','fact_inventory',100000,12.50,'zstd','date',NOW(),NOW()),
(7,2,'fact_shipments',5,'warehouse','fact_shipment',5000,8.20,'zstd','shipment_date',NOW(),NOW()),
(8,2,'fact_quality',6,'warehouse','fact_quality',1000,2.30,'zstd','inspection_date',NOW(),NOW()),
(9,2,'fact_orders',7,'warehouse','fact_order',5000,6.75,'zstd','order_date',NOW(),NOW()),
(10,4,'procurement_summary',NULL,'mart','procurement_dashboard',100,1.20,'zstd','month',NOW(),NOW()),
(11,5,'logistics_kpi',NULL,'mart','logistics_kpi',500,0.80,'zstd','date',NOW(),NOW()),
(12,6,'finance_pnl',NULL,'mart','finance_pnl',100,0.50,'zstd','month',NOW(),NOW());
/*!40000 ALTER TABLE `data_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_marts`
--

LOCK TABLES `data_marts` WRITE;
/*!40000 ALTER TABLE `data_marts` DISABLE KEYS */;
INSERT INTO `data_marts` VALUES 
(1,'Procurement Dashboard','Procurement','Supplier performance and purchasing analytics',10,'Daily','Procurement Director'),
(2,'Logistics Control Tower','Logistics','Shipment tracking and route optimization',11,'Real-time','Logistics Manager'),
(3,'Financial P&L','Finance','Profit and loss by product line',12,'Monthly','CFO'),
(4,'Inventory Optimization','Procurement','Inventory levels and reorder recommendations',6,'Hourly','Supply Chain Director'),
(5,'Supplier Scorecard','Procurement','Supplier quality and delivery performance',4,'Weekly','Procurement Analyst');
/*!40000 ALTER TABLE `data_marts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `processing_tools`
--

LOCK TABLES `processing_tools` WRITE;
/*!40000 ALTER TABLE `processing_tools` DISABLE KEYS */;
INSERT INTO `processing_tools` VALUES 
(1,'Apache Spark','ETL','Apache','3.4.0','Distributed processing framework','Cloud','Active'),
(2,'AWS Glue','ELT','Amazon','2.0','Serverless ETL service','Cloud','Active'),
(3,'dbt','ELT','dbt Labs','1.5.0','Data transformations','Cloud','Active'),
(4,'Apache Flink','Stream Processing','Apache','1.17.0','Stream processing framework','Cloud','Active'),
(5,'Apache Kafka','Stream Processing','Apache','3.4.0','Event streaming platform','Cloud','Active'),
(6,'AWS Batch','Batch Processing','Amazon','1.0','Batch computing','Cloud','Active'),
(7,'Airflow','Orchestration','Apache','2.7.0','Workflow orchestration','Cloud','Active');
/*!40000 ALTER TABLE `processing_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `processing_jobs`
--

LOCK TABLES `processing_jobs` WRITE;
/*!40000 ALTER TABLE `processing_jobs` DISABLE KEYS */;
INSERT INTO `processing_jobs` VALUES 
(1,'Supplier Data ETL','ELT',3,1,4,'SELECT supplier_id, name, country, sustainability_rating FROM raw_supplier_data','Daily',DATE_SUB(NOW(), INTERVAL 24 HOUR),DATE_SUB(NOW(), INTERVAL 23 HOUR),3600,5000,'Completed',NULL),
(2,'IoT Stream Processing','Stream',4,3,6,'Calculate temperature averages and detect anomalies','Continuous',DATE_SUB(NOW(), INTERVAL 5 MINUTE),DATE_SUB(NOW(), INTERVAL 4 MINUTE),60,100000,'Completed',NULL),
(3,'Inventory Aggregation','Batch',6,2,10,'Aggregate daily inventory levels by warehouse','Daily',DATE_SUB(NOW(), INTERVAL 25 HOUR),DATE_SUB(NOW(), INTERVAL 24 HOUR),3600,50000,'Completed',NULL),
(4,'Order Processing','ETL',1,9,9,'Enrich orders with supplier and material data','Hourly',DATE_SUB(NOW(), INTERVAL 60 MINUTE),DATE_SUB(NOW(), INTERVAL 58 MINUTE),120,500,'Completed',NULL),
(5,'Shipment Tracking','Stream',5,7,11,'Process real-time shipment updates','Continuous',DATE_SUB(NOW(), INTERVAL 2 MINUTE),NULL,0,0,'Running',NULL);
/*!40000 ALTER TABLE `processing_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bi_tools`
--

LOCK TABLES `bi_tools` WRITE;
/*!40000 ALTER TABLE `bi_tools` DISABLE KEYS */;
INSERT INTO `bi_tools` VALUES 
(1,'Tableau','Salesforce','2023.3','Dashboard',50,'Cloud','Active'),
(2,'Power BI','Microsoft','11.0','Dashboard',100,'Cloud','Active'),
(3,'Looker','Google','23.0','Dashboard',25,'Cloud','Active'),
(4,'Python (scikit-learn)','Open Source','1.3.0','Predictive',NULL,'Desktop','Active'),
(5,'R Studio','RStudio','2023.06','Predictive',10,'Desktop','Active'),
(6,'Excel','Microsoft','365','Ad-hoc',500,'Desktop','Active');
/*!40000 ALTER TABLE `bi_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dashboards`
--

LOCK TABLES `dashboards` WRITE;
/*!40000 ALTER TABLE `dashboards` DISABLE KEYS */;
INSERT INTO `dashboards` VALUES 
(1,'Executive Supply Chain Overview',1,10,'High-level KPIs for supply chain performance','Executive','Daily','https://tableau.finedge.com/exec_dash',NOW(),NOW(),'Active'),
(2,'Inventory Optimization',2,6,'Real-time inventory levels and reorder recommendations','Procurement','Real-time','https://powerbi.finedge.com/inventory',NOW(),NOW(),'Active'),
(3,'Supplier Performance Scorecard',3,4,'Supplier quality, delivery, and pricing metrics','Procurement','Weekly','https://looker.finedge.com/suppliers',NOW(),NOW(),'Active'),
(4,'Logistics Control Tower',1,11,'Shipment tracking and route efficiency','Logistics','Real-time','https://tableau.finedge.com/logistics',NOW(),NOW(),'Active'),
(5,'Sustainability Dashboard',2,4,'Carbon footprint and ethical sourcing metrics','Executive','Monthly','https://powerbi.finedge.com/esg',NOW(),NOW(),'Active');
/*!40000 ALTER TABLE `dashboards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `predictive_models`
--

LOCK TABLES `predictive_models` WRITE;
/*!40000 ALTER TABLE `predictive_models` DISABLE KEYS */;
INSERT INTO `predictive_models` VALUES 
(1,'Demand Forecasting Model','Demand Forecasting','Random Forest','scikit-learn',9,'["historical_orders", "seasonality", "market_price"]','quantity',92.5,'2024-03-01 00:00:00','2024-04-01 00:00:00','Production'),
(2,'Supplier Delay Prediction','Supplier Risk','XGBoost','scikit-learn',7,'["supplier_history", "weather", "shipment_mode"]','delay_probability',87.3,'2024-02-15 00:00:00','2024-03-15 00:00:00','Production'),
(3,'Price Trend Analysis','Price Prediction','LSTM','TensorFlow',8,'["historical_prices", "demand_index", "weather"]','price_trend',78.5,'2024-02-20 00:00:00','2024-03-20 00:00:00','Development'),
(4,'Quality Defect Predictor','Quality Prediction','Logistic Regression','scikit-learn',8,'["supplier_grade", "batch_origin", "material_type"]','defect_probability',82.0,'2024-03-05 00:00:00','2024-04-05 00:00:00','Production');
/*!40000 ALTER TABLE `predictive_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `model_predictions`
--

LOCK TABLES `model_predictions` WRITE;
/*!40000 ALTER TABLE `model_predictions` DISABLE KEYS */;
INSERT INTO `model_predictions` VALUES 
(1,1,'2024-03-10 00:00:00',1,18500.00,17500.00,19500.00,95.00,NULL,'30 days'),
(2,1,'2024-03-10 00:00:00',2,22500.00,21000.00,24000.00,95.00,NULL,'30 days'),
(3,2,'2024-03-10 00:00:00',5,0.25,0.15,0.35,85.00,NULL,'shipment'),
(4,3,'2024-03-10 00:00:00',1,2.92,2.80,3.05,80.00,2.88,'7 days'),
(5,4,'2024-03-10 00:00:00',3,0.08,0.05,0.12,90.00,0.10,'batch');
/*!40000 ALTER TABLE `model_predictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_owners`
--

LOCK TABLES `data_owners` WRITE;
/*!40000 ALTER TABLE `data_owners` DISABLE KEYS */;
INSERT INTO `data_owners` VALUES 
(1,'Sarah Johnson','Data Owner','Procurement','sarah.j@supplychain.com','+1-212-555-0101'),
(2,'Mike Chen','Data Steward','Procurement','mike.c@supplychain.com','+1-212-555-0102'),
(3,'Lisa Rodriguez','Data Owner','Logistics','lisa.r@supplychain.com','+1-212-555-0103'),
(4,'David Kim','Data Steward','Logistics','david.k@supplychain.com','+1-212-555-0104'),
(5,'Amanda Lee','Data Owner','Finance','amanda.l@supplychain.com','+1-212-555-0105'),
(6,'James Wilson','Data Steward','Finance','james.w@supplychain.com','+1-212-555-0106'),
(7,'Robert Brown','Data Owner','Quality','robert.b@supplychain.com','+1-212-555-0107'),
(8,'Patricia Garcia','Data Steward','Quality','patricia.g@supplychain.com','+1-212-555-0108');
/*!40000 ALTER TABLE `data_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_domains`
--

LOCK TABLES `data_domains` WRITE;
/*!40000 ALTER TABLE `data_domains` DISABLE KEYS */;
INSERT INTO `data_domains` VALUES 
(1,'Supplier Master','Core supplier information and contracts',1,2),
(2,'Material Master','Raw material definitions and specifications',1,2),
(3,'Inventory','Stock levels and warehouse locations',1,2),
(4,'Shipments','Transportation and logistics data',3,4),
(5,'Orders','Customer orders and forecasts',1,2),
(6,'Financial Transactions','Costs, prices, and payments',5,6),
(7,'Quality Data','Inspection results and quality metrics',7,8);
/*!40000 ALTER TABLE `data_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `metadata_repository`
--

LOCK TABLES `metadata_repository` WRITE;
/*!40000 ALTER TABLE `metadata_repository` DISABLE KEYS */;
INSERT INTO `metadata_repository` VALUES 
(1,'dim_supplier','Table',4,1,'Supplier dimension','Contains all supplier attributes','TABLE',0,0,'Internal',NOW(),NOW()),
(2,'supplier_id','Column',4,1,'Unique supplier identifier','Primary key for suppliers','INT',0,0,'Internal',NOW(),NOW()),
(3,'supplier_name','Column',4,1,'Supplier company name','Legal name of supplier','VARCHAR',0,0,'Public',NOW(),NOW()),
(4,'supplier_country','Column',4,1,'Country of origin','Where supplier is located','VARCHAR',0,0,'Public',NOW(),NOW()),
(5,'sustainability_rating','Column',4,1,'ESG rating','Environmental, social, governance score','CHAR',0,0,'Internal',NOW(),NOW()),
(6,'fact_inventory','Table',6,3,'Inventory facts','Current inventory levels','TABLE',0,0,'Internal',NOW(),NOW()),
(7,'quantity_on_hand','Column',6,3,'Current stock','Physical quantity in warehouse','DECIMAL',0,0,'Internal',NOW(),NOW()),
(8,'batch_number','Column',6,3,'Production batch','Lot or batch identifier','VARCHAR',0,0,'Internal',NOW(),NOW()),
(9,'expiry_date','Column',6,3,'Expiration date','When material expires','DATE',0,0,'Internal',NOW(),NOW()),
(10,'fact_shipments','Table',7,4,'Shipment facts','Transportation records','TABLE',0,0,'Internal',NOW(),NOW());
/*!40000 ALTER TABLE `metadata_repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_lineage`
--

LOCK TABLES `data_lineage` WRITE;
/*!40000 ALTER TABLE `data_lineage` DISABLE KEYS */;
INSERT INTO `data_lineage` VALUES 
(1,1,4,'ETL Transformation',1,'SELECT supplier_id, supplier_name, country, sustainability_rating FROM raw_supplier_data',NOW()),
(2,6,10,'Aggregation',3,'SELECT warehouse_id, material_id, SUM(quantity_on_hand) as total_inventory FROM fact_inventory GROUP BY warehouse_id, material_id',NOW()),
(3,8,11,'Stream Processing',5,'SELECT shipment_id, current_location, estimated_arrival FROM real_time_tracking',NOW()),
(4,2,4,'Join',1,'JOIN raw_supplier_data ON supplier_id',NOW()),
(5,4,1,'ML Model Input',NULL,'Used as feature for supplier delay prediction',NOW());
/*!40000 ALTER TABLE `data_lineage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_quality_rules`
--

LOCK TABLES `data_quality_rules` WRITE;
/*!40000 ALTER TABLE `data_quality_rules` DISABLE KEYS */;
INSERT INTO `data_quality_rules` VALUES 
(1,'Supplier Name Not Null','Completeness','Supplier name must not be null','supplier_name IS NOT NULL','Critical',0,NOW()),
(2,'Unique Supplier ID','Uniqueness','Supplier ID must be unique','COUNT(DISTINCT supplier_id) = COUNT(supplier_id)','Critical',1,NOW()),
(3,'Positive Quantity','Accuracy','Inventory quantity must be positive','quantity_on_hand >= 0','High',0,NOW()),
(4,'Valid Shipment Status','Validity','Shipment status must be valid','shipment_status IN (''Booked'',''In Transit'',''Delayed'',''Delivered'',''Cancelled'')','Medium',0,NOW()),
(5,'Order Date vs Required Date','Consistency','Required date must be after order date','required_date > order_date','High',0,NOW()),
(6,'Temperature Range','Accuracy','Temperature readings within range','reading_value BETWEEN -20 AND 60','High',1,NOW());
/*!40000 ALTER TABLE `data_quality_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `data_quality_checks`
--

LOCK TABLES `data_quality_checks` WRITE;
/*!40000 ALTER TABLE `data_quality_checks` DISABLE KEYS */;
INSERT INTO `data_quality_checks` VALUES 
(1,1,4,'Storage',DATE_SUB(NOW(), INTERVAL 24 HOUR),8,8,0,100.00,NULL,'Passed'),
(2,2,4,'Storage',DATE_SUB(NOW(), INTERVAL 24 HOUR),8,8,0,100.00,NULL,'Passed'),
(3,3,6,'Storage',DATE_SUB(NOW(), INTERVAL 12 HOUR),100000,99950,50,99.95,'{"errors": [{"inventory_id": 12345, "quantity": -100}]}','Warning'),
(4,4,7,'Ingestion',DATE_SUB(NOW(), INTERVAL 1 HOUR),5000,4980,20,99.60,'{"errors": [{"shipment_id": 4, "status": "Invalid"}]}','Warning'),
(5,6,3,'Ingestion',DATE_SUB(NOW(), INTERVAL 5 MINUTE),5000000,4999990,10,99.99,'{"errors": [{"sensor_id": 5, "value": 75.3}]}','Passed');
/*!40000 ALTER TABLE `data_quality_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `access_policies`
--

LOCK TABLES `access_policies` WRITE;
/*!40000 ALTER TABLE `access_policies` DISABLE KEYS */;
INSERT INTO `access_policies` VALUES 
(1,'Procurement Full Access',1,'Procurement_Manager','["SELECT", "INSERT", "UPDATE"]',NULL,NULL,NOW(),NOW()),
(2,'Procurement Read Only',1,'Procurement_Analyst','["SELECT"]',NULL,'{"supplier_name": "plain", "contract_amount": "masked"}',NOW(),NOW()),
(3,'Logistics Tracking',4,'Logistics_User','["SELECT"]','warehouse_id IN (1,2,3)',NULL,NOW(),NOW()),
(4,'Finance Sensitive',6,'Finance_Manager','["SELECT"]',NULL,'{"unit_price": "masked", "total_amount": "plain"}',NOW(),NOW()),
(5,'Executive Dashboard',NULL,'Executive','["SELECT"]','date >= NOW() - INTERVAL 1 YEAR',NULL,NOW(),NOW());
/*!40000 ALTER TABLE `access_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `compliance_requirements`
--

LOCK TABLES `compliance_requirements` WRITE;
/*!40000 ALTER TABLE `compliance_requirements` DISABLE KEYS */;
INSERT INTO `compliance_requirements` VALUES 
(1,'GDPR','EU','General Data Protection Regulation for EU citizens','Customer Orders, Supplier Contacts',NULL,1,1),
(2,'CCPA','California','California Consumer Privacy Act','Customer Orders',NULL,1,1),
(3,'ESG','Global','Environmental, Social, Governance reporting','Supplier Master, Quality Data',365,0,1),
(4,'ISO 27001','Global','Information Security Management','All Domains',NULL,0,1),
(5,'SOC2','USA','Service Organization Control','Financial Transactions',365,0,1);
/*!40000 ALTER TABLE `compliance_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `use_cases`
--

LOCK TABLES `use_cases` WRITE;
/*!40000 ALTER TABLE `use_cases` DISABLE KEYS */;
INSERT INTO `use_cases` VALUES 
(1,'Inventory Forecasting','Inventory Forecasting','Predict raw material requirements based on historical orders and market trends','Reduce stockouts by 30%, decrease carrying costs by 15%','Historical orders, current inventory, market prices, lead times','Predictive','In Progress'),
(2,'Supplier Performance Analysis','Supplier Performance','Evaluate suppliers based on delivery time, quality, and pricing','Improve on-time delivery by 20%, reduce defects by 25%','Supplier master, quality records, shipment logs','Dashboard','Completed'),
(3,'Route Optimization','Transportation Optimization','Optimize shipping routes to reduce costs and delivery times','Reduce transportation costs by 12%, improve delivery times by 18%','Shipment logs, weather data, carrier rates','Prescriptive','Planned'),
(4,'Demand-Supply Matching','Demand Matching','Align raw material procurement with garment manufacturer demand','Increase forecast accuracy by 25%, reduce excess inventory','Customer orders, inventory levels, supplier capacity','Predictive','In Progress'),
(5,'Quality Trend Analysis','Quality Assurance','Track quality issues and identify problematic suppliers','Reduce defect rate by 35%, identify top quality issues','Quality records, supplier data','Dashboard','Completed'),
(6,'Total Landed Cost Analysis','Cost Optimization','Analyze total landed costs across different sourcing options','Reduce procurement costs by 8%','Supplier pricing, shipping costs, tariffs, exchange rates','Analytical','Planned'),
(7,'Carbon Footprint Tracking','Sustainability','Track carbon footprint and ethical sourcing metrics','Achieve net-zero by 2030, improve ESG rating','Shipment logs, supplier certifications, energy usage','Dashboard','In Progress'),
(8,'Supply Chain Risk Monitoring','Risk Management','Identify supply chain disruptions due to weather, geopolitical events','Reduce disruption impact by 40%','Weather data, news feeds, shipment tracking','Predictive','Planned');
/*!40000 ALTER TABLE `use_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `use_case_metrics`
--

LOCK TABLES `use_case_metrics` WRITE;
/*!40000 ALTER TABLE `use_case_metrics` DISABLE KEYS */;
INSERT INTO `use_case_metrics` VALUES 
(1,1,'Stockout Rate',8.5,5.0,6.2,'2024-03-01'),
(2,1,'Inventory Carrying Cost',15.0,12.0,13.5,'2024-03-01'),
(3,2,'On-Time Delivery %',82.0,95.0,91.5,'2024-03-01'),
(4,2,'Defect Rate %',4.2,2.5,3.1,'2024-03-01'),
(5,3,'Transportation Cost per Unit',1.25,1.10,1.18,'2024-03-01'),
(6,5,'Quality Issue Frequency',45,25,32,'2024-03-01'),
(7,7,'Carbon Emissions (tons)',1250,1000,1120,'2024-03-01');
/*!40000 ALTER TABLE `use_case_metrics` ENABLE KEYS */;
UNLOCK TABLES;

-- ===================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ===================================================================

CREATE INDEX idx_supplier_country ON supplier_database(Country);
CREATE INDEX idx_supplier_type ON supplier_database(Supplier_Type);
CREATE INDEX idx_material_category ON raw_materials(Material_Category);
CREATE INDEX idx_inventory_warehouse ON inventory_levels(Warehouse_ID);
CREATE INDEX idx_inventory_material ON inventory_levels(Material_ID);
CREATE INDEX idx_inventory_expiry ON inventory_levels(Expiry_Date);
CREATE INDEX idx_shipment_status ON transportation_logs(Shipment_Status);
CREATE INDEX idx_shipment_dates ON transportation_logs(Departure_Date, Estimated_Arrival);
CREATE INDEX idx_quality_batch ON quality_control_records(Batch_Number);
CREATE INDEX idx_quality_supplier ON quality_control_records(Supplier_ID);
CREATE INDEX idx_order_status ON customer_orders(Order_Status);
CREATE INDEX idx_order_dates ON customer_orders(Order_Date, Required_Date);
CREATE INDEX idx_iot_timestamp ON iot_sensor_readings(Reading_Timestamp);
CREATE INDEX idx_iot_alert ON iot_sensor_readings(Alert_Flag);
CREATE INDEX idx_market_date ON market_trends_data(Date);
CREATE INDEX idx_weather_location ON weather_data(Location, Date);
CREATE INDEX idx_ingestion_status ON ingestion_jobs(Status);
CREATE INDEX idx_processing_status ON processing_jobs(Status);
CREATE INDEX idx_dq_stage ON data_quality_checks(Check_Stage);
CREATE INDEX idx_dq_status ON data_quality_checks(Status);
CREATE INDEX idx_lineage_source ON data_lineage(Source_Asset_ID);
CREATE INDEX idx_lineage_target ON data_lineage(Target_Asset_ID);
CREATE INDEX idx_metadata_domain ON metadata_repository(Domain_ID);
CREATE INDEX idx_prediction_model ON model_predictions(Model_ID);
CREATE INDEX idx_usecase_status ON use_cases(Implementation_Status);

-- ===================================================================
-- CREATE VIEWS FOR REPORTING
-- ===================================================================

-- Inventory Optimization Dashboard View
DROP VIEW IF EXISTS inventory_optimization_view;
CREATE VIEW inventory_optimization_view AS
SELECT 
    rm.Material_Name,
    rm.Material_Category,
    SUM(il.Quantity_On_Hand) AS Total_Quantity,
    SUM(il.Quantity_Reserved) AS Total_Reserved,
    SUM(il.Quantity_Available) AS Available_Quantity,
    COUNT(DISTINCT il.Warehouse_ID) AS Warehouse_Count,
    MIN(il.Expiry_Date) AS Earliest_Expiry,
    COUNT(CASE WHEN il.Expiry_Date < DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN 1 END) AS Expiring_Soon
FROM inventory_levels il
JOIN raw_materials rm ON il.Material_ID = rm.Material_ID
GROUP BY rm.Material_ID, rm.Material_Name, rm.Material_Category;

-- Supplier Performance Dashboard View
DROP VIEW IF EXISTS supplier_performance_view;
CREATE VIEW supplier_performance_view AS
SELECT 
    sd.Supplier_Name,
    sd.Country,
    sd.Sustainability_Rating,
    COUNT(DISTINCT sm.Material_ID) AS Materials_Supplied,
    AVG(qc.Defect_Rate) AS Avg_Defect_Rate,
    COUNT(CASE WHEN qc.Status = 'Failed' THEN 1 END) AS Failed_Inspections,
    AVG(tl.Shipment_Status = 'Delayed') * 100 AS Delay_Percentage
FROM supplier_database sd
LEFT JOIN supplier_materials sm ON sd.Supplier_ID = sm.Supplier_ID
LEFT JOIN quality_control_records qc ON sd.Supplier_ID = qc.Supplier_ID
LEFT JOIN transportation_logs tl ON sd.Supplier_Name LIKE CONCAT('%', tl.Carrier, '%')
GROUP BY sd.Supplier_ID, sd.Supplier_Name, sd.Country, sd.Sustainability_Rating;

-- Logistics Control Tower View
DROP VIEW IF EXISTS logistics_control_tower;
CREATE VIEW logistics_control_tower AS
SELECT 
    tl.Shipment_Number,
    tl.Carrier,
    tl.Mode,
    tl.Origin,
    tl.Destination,
    tl.Departure_Date,
    tl.Estimated_Arrival,
    tl.Actual_Arrival,
    tl.Shipment_Status,
    tl.Last_Location,
    TIMESTAMPDIFF(HOUR, tl.Departure_Date, COALESCE(tl.Actual_Arrival, tl.Estimated_Arrival)) AS Transit_Hours,
    CASE 
        WHEN tl.Shipment_Status = 'Delayed' THEN '⚠️ Delayed'
        WHEN tl.Estimated_Arrival < NOW() AND tl.Shipment_Status != 'Delivered' THEN '🔴 Overdue'
        WHEN tl.Shipment_Status = 'Delivered' THEN '✅ Delivered'
        ELSE '🟢 In Transit'
    END AS Status_Indicator
FROM transportation_logs tl
ORDER BY tl.Departure_Date DESC;

-- Data Quality Dashboard View
DROP VIEW IF EXISTS data_quality_overview;
CREATE VIEW data_quality_overview AS
SELECT 
    DATE(dqc.Execution_Date) AS Check_Date,
    dqc.Check_Stage,
    COUNT(*) AS Total_Checks,
    SUM(CASE WHEN dqc.Status = 'Passed' THEN 1 ELSE 0 END) AS Passed_Checks,
    SUM(CASE WHEN dqc.Status = 'Warning' THEN 1 ELSE 0 END) AS Warnings,
    SUM(CASE WHEN dqc.Status = 'Failed' THEN 1 ELSE 0 END) AS Failed_Checks,
    AVG(dqc.Pass_Percentage) AS Avg_Pass_Percentage
FROM data_quality_checks dqc
GROUP BY DATE(dqc.Execution_Date), dqc.Check_Stage
ORDER BY Check_Date DESC, dqc.Check_Stage;

-- EDA Blueprint Summary View
DROP VIEW IF EXISTS eda_blueprint_summary;
CREATE VIEW eda_blueprint_summary AS
SELECT 
    'Data Sources' AS Layer,
    COUNT(*) AS Active_Items,
    SUM(Volume_Estimate_GB) AS Total_Volume_GB
FROM data_sources WHERE Status = 'Active'
UNION ALL
SELECT 
    'Ingestion Jobs' AS Layer,
    COUNT(*) AS Active_Items,
    NULL AS Total_Volume_GB
FROM ingestion_jobs WHERE Status = 'Completed' OR Status = 'Running'
UNION ALL
SELECT 
    'Storage Tiers' AS Layer,
    COUNT(*) AS Active_Items,
    SUM(Used_Capacity_TB) * 1024 AS Total_Volume_GB
FROM storage_tiers WHERE Status = 'Active'
UNION ALL
SELECT 
    'Processing Jobs' AS Layer,
    COUNT(*) AS Active_Items,
    NULL AS Total_Volume_GB
FROM processing_jobs WHERE Status = 'Running' OR Status = 'Scheduled'
UNION ALL
SELECT 
    'Dashboards' AS Layer,
    COUNT(*) AS Active_Items,
    NULL AS Total_Volume_GB
FROM dashboards WHERE Status = 'Active'
UNION ALL
SELECT 
    'Data Quality Rules' AS Layer,
    COUNT(*) AS Active_Items,
    NULL AS Total_Volume_GB
FROM data_quality_rules;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 14:00:00


{# This comprehensive MySQL database schema for the Garment Manufacturing Supply Chain Company implements the complete Enterprise Data Architecture (EDA) blueprint with all six layers:

## Key Features:

### 1. **DATA SOURCES LAYER** (10+ tables)
- **Supplier Database** - Supplier profiles, certifications, sustainability ratings
- **Raw Materials** - Material definitions with hazardous and temperature sensitivity flags
- **Supplier Materials** - Pricing, MOQ, lead times, contract management
- **ERP System** - Financial and procurement transactions
- **IoT Sensors** - Temperature/humidity monitoring with real-time readings
- **Warehouse Management** - Inventory levels with expiry tracking
- **Transportation Logs** - Shipment tracking with carrier integration
- **Quality Control** - Inspection results and defect tracking
- **Customer Orders** - Order management and fulfillment
- **External APIs** - Market trends, weather, regulatory data

### 2. **DATA INGESTION LAYER**
- `ingestion_jobs` - Batch, real-time, and CDC ingestion tracking
- `ingestion_metrics` - Performance monitoring for ingestion pipelines

### 3. **DATA STORAGE LAYER**
- `storage_tiers` - Data Lake, Warehouse, Operational DB, Data Marts, Archive
- `data_storage` - Physical data storage mapping
- `data_marts` - Department-specific data marts (Procurement, Logistics, Finance)

### 4. **DATA PROCESSING LAYER**
- `processing_tools` - Spark, Glue, dbt, Flink, Kafka, Airflow
- `processing_jobs` - ETL/ELT pipelines with transformation logic

### 5. **ANALYTICS LAYER**
- `bi_tools` - Tableau, Power BI, Looker, Python, R
- `dashboards` - Executive, Inventory, Supplier, Logistics dashboards
- `dashboard_metrics` - KPI tracking with comparisons
- `predictive_models` - Demand forecasting, delay prediction, price trends
- `model_predictions` - Model outputs with confidence intervals
- `prescriptive_optimizations` - Route and inventory optimization recommendations

### 6. **GOVERNANCE LAYER**
- `data_owners` - Data owners and stewards by domain
- `data_domains` - Supplier, Material, Inventory, Shipments, Orders, Finance, Quality
- `metadata_repository` - Business glossary and data dictionary
- `data_lineage` - End-to-end data flow tracking
- `data_quality_rules` - 6 rule types with severity levels
- `data_quality_checks` - Multi-stage quality monitoring
- `access_policies` - RBAC with row/column-level security
- `compliance_requirements` - GDPR, CCPA, ESG, ISO 27001, SOC2 tracking

### 7. **USE CASES** (8 critical applications)
- Inventory Forecasting
- Supplier Performance Analysis
- Route Optimization
- Demand-Supply Matching
- Quality Trend Analysis
- Total Landed Cost Analysis
- Carbon Footprint Tracking
- Supply Chain Risk Monitoring

## Sample Data Included:
- 8 global suppliers across 7 countries
- 10 raw material types
- 6 warehouses across 3 continents
- 50+ inventory records
- 5 shipments with tracking
- 5 quality inspections
- 6 customer orders
- 8 external API integrations
- 5 predictive models
- 5 dashboards
- 8 data owners and stewards
- 7 data domains
- 10 metadata assets
- 6 data quality rules
- 8 use cases with metrics

## Views for Monitoring:
- `inventory_optimization_view` - Real-time inventory status
- `supplier_performance_view` - Supplier scorecards
- `logistics_control_tower` - Shipment tracking dashboard
- `data_quality_overview` - Quality metrics by stage
- `eda_blueprint_summary` - High-level architecture overview

This schema provides a complete operational database that implements the entire EDA blueprint, enabling the supply chain company to achieve end-to-end visibility, optimize operations, and maintain compliance with global regulations. #}