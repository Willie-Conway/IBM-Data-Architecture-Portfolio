
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: alliance_bank
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
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `Currency_Code` varchar(3) NOT NULL,
  `Currency_Name` varchar(50) NOT NULL,
  `Symbol` varchar(5) DEFAULT NULL,
  `Exchange_Rate_To_Base` decimal(10,6) DEFAULT NULL,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Is_Base_Currency` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Currency_Code`),
  UNIQUE KEY `Currency_Name_UNIQUE` (`Currency_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounttype`
--

DROP TABLE IF EXISTS `accounttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounttype` (
  `Account_Type_ID` int NOT NULL AUTO_INCREMENT,
  `Type_Name` varchar(30) NOT NULL,
  `Category` varchar(20) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Minimum_Balance` decimal(15,2) DEFAULT NULL,
  `Interest_Rate` decimal(5,2) DEFAULT NULL,
  `Monthly_Fee` decimal(10,2) DEFAULT NULL,
  `Transaction_Limits` varchar(255) DEFAULT NULL,
  `Features` text,
  PRIMARY KEY (`Account_Type_ID`),
  UNIQUE KEY `Type_Name_UNIQUE` (`Type_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `Branch_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_Code` varchar(20) NOT NULL,
  `Branch_Name` varchar(100) NOT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Postal_Code` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Manager_ID` int DEFAULT NULL,
  `Opening_Date` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`Branch_ID`),
  UNIQUE KEY `Branch_Code_UNIQUE` (`Branch_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Employee_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Employee_Number` varchar(30) NOT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Hire_Date` date DEFAULT NULL,
  `Supervisor_ID` int DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `Employee_Number_UNIQUE` (`Employee_Number`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `branch_idx` (`Branch_ID`),
  KEY `supervisor_idx` (`Supervisor_ID`),
  CONSTRAINT `fk_employee_branch` FOREIGN KEY (`Branch_ID`) REFERENCES `branch` (`Branch_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_employee_supervisor` FOREIGN KEY (`Supervisor_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address_Line1` varchar(100) DEFAULT NULL,
  `Address_Line2` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Postal_Code` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `ID_Type` varchar(30) DEFAULT NULL,
  `ID_Number` varchar(50) DEFAULT NULL,
  `Registration_Date` date DEFAULT NULL,
  `Customer_Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `ID_Number_UNIQUE` (`ID_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `Account_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int NOT NULL,
  `Account_Type_ID` int NOT NULL,
  `Branch_ID` int DEFAULT NULL,
  `Currency_Code` varchar(3) DEFAULT 'USD',
  `Account_Number` varchar(30) NOT NULL,
  `Balance` decimal(15,2) DEFAULT '0.00',
  `Available_Balance` decimal(15,2) DEFAULT '0.00',
  `Interest_Rate` decimal(5,2) DEFAULT NULL,
  `Opening_Date` date NOT NULL,
  `Closing_Date` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  `Monthly_Maintenance_Fee` decimal(10,2) DEFAULT '0.00',
  `Overdraft_Limit` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`Account_ID`),
  UNIQUE KEY `Account_Number_UNIQUE` (`Account_Number`),
  KEY `customer_idx` (`Customer_ID`),
  KEY `accounttype_idx` (`Account_Type_ID`),
  KEY `branch_idx` (`Branch_ID`),
  KEY `currency_idx` (`Currency_Code`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_account_accounttype` FOREIGN KEY (`Account_Type_ID`) REFERENCES `accounttype` (`Account_Type_ID`),
  CONSTRAINT `fk_account_branch` FOREIGN KEY (`Branch_ID`) REFERENCES `branch` (`Branch_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_account_currency` FOREIGN KEY (`Currency_Code`) REFERENCES `currency` (`Currency_Code`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `Transaction_ID` int NOT NULL AUTO_INCREMENT,
  `Account_ID` int NOT NULL,
  `Transaction_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Transaction_Type` varchar(30) NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `Currency_Code` varchar(3) DEFAULT 'USD',
  `Exchange_Rate` decimal(10,6) DEFAULT '1.000000',
  `Description` varchar(255) DEFAULT NULL,
  `Reference_Number` varchar(50) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Completed',
  `Related_Transaction_ID` int DEFAULT NULL,
  `Destination_Account_ID` int DEFAULT NULL,
  `Fraud_Flag` tinyint(1) DEFAULT '0',
  `Approval_Status` varchar(20) DEFAULT 'Approved',
  `Approved_By` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `account_idx` (`Account_ID`),
  KEY `destination_account_idx` (`Destination_Account_ID`),
  KEY `related_transaction_idx` (`Related_Transaction_ID`),
  KEY `approved_by_idx` (`Approved_By`),
  KEY `currency_idx` (`Currency_Code`),
  CONSTRAINT `fk_transaction_account` FOREIGN KEY (`Account_ID`) REFERENCES `account` (`Account_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_transaction_dest_account` FOREIGN KEY (`Destination_Account_ID`) REFERENCES `account` (`Account_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_transaction_related` FOREIGN KEY (`Related_Transaction_ID`) REFERENCES `transaction` (`Transaction_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_transaction_employee` FOREIGN KEY (`Approved_By`) REFERENCES `employee` (`Employee_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_transaction_currency` FOREIGN KEY (`Currency_Code`) REFERENCES `currency` (`Currency_Code`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixeddeposit`
--

DROP TABLE IF EXISTS `fixeddeposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixeddeposit` (
  `FD_ID` int NOT NULL AUTO_INCREMENT,
  `Account_ID` int NOT NULL,
  `FD_Number` varchar(30) NOT NULL,
  `Principal_Amount` decimal(15,2) NOT NULL,
  `Interest_Rate` decimal(5,2) NOT NULL,
  `Term_Months` int NOT NULL,
  `Start_Date` date NOT NULL,
  `Maturity_Date` date NOT NULL,
  `Maturity_Amount` decimal(15,2) GENERATED ALWAYS AS (Principal_Amount * POWER(1 + Interest_Rate/100/4, Term_Months/3)) STORED,
  `Interest_Payout_Option` varchar(30) DEFAULT 'Maturity',
  `Nominee_Name` varchar(100) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`FD_ID`),
  UNIQUE KEY `FD_Number_UNIQUE` (`FD_Number`),
  KEY `account_idx` (`Account_ID`),
  CONSTRAINT `fk_fixeddeposit_account` FOREIGN KEY (`Account_ID`) REFERENCES `account` (`Account_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurringdeposit`
--

DROP TABLE IF EXISTS `recurringdeposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurringdeposit` (
  `RD_ID` int NOT NULL AUTO_INCREMENT,
  `Account_ID` int NOT NULL,
  `RD_Number` varchar(30) NOT NULL,
  `Monthly_Installment` decimal(15,2) NOT NULL,
  `Interest_Rate` decimal(5,2) NOT NULL,
  `Term_Months` int NOT NULL,
  `Start_Date` date NOT NULL,
  `Maturity_Date` date NOT NULL,
  `Total_Deposited` decimal(15,2) DEFAULT '0.00',
  `Maturity_Amount` decimal(15,2) GENERATED ALWAYS AS (Monthly_Installment * (((POWER(1 + Interest_Rate/100/12, Term_Months) - 1) / (Interest_Rate/100/12)) * (1 + Interest_Rate/100/12))) STORED,
  `Installment_Due_Day` int DEFAULT '1',
  `Next_Installment_Date` date DEFAULT NULL,
  `Installments_Paid` int DEFAULT '0',
  `Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`RD_ID`),
  UNIQUE KEY `RD_Number_UNIQUE` (`RD_Number`),
  KEY `account_idx` (`Account_ID`),
  CONSTRAINT `fk_recurringdeposit_account` FOREIGN KEY (`Account_ID`) REFERENCES `account` (`Account_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `Loan_ID` int NOT NULL AUTO_INCREMENT,
  `Customer_ID` int NOT NULL,
  `Account_ID` int DEFAULT NULL,
  `Loan_Type` varchar(30) NOT NULL,
  `Loan_Number` varchar(30) NOT NULL,
  `Principal_Amount` decimal(15,2) NOT NULL,
  `Outstanding_Amount` decimal(15,2) NOT NULL,
  `Interest_Rate` decimal(5,2) NOT NULL,
  `Interest_Type` varchar(20) DEFAULT 'Fixed',
  `Term_Months` int NOT NULL,
  `EMI_Amount` decimal(15,2) NOT NULL,
  `EMI_Due_Day` int DEFAULT '1',
  `Disbursement_Date` date NOT NULL,
  `First_Payment_Date` date DEFAULT NULL,
  `Maturity_Date` date NOT NULL,
  `Collateral` varchar(255) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`Loan_ID`),
  UNIQUE KEY `Loan_Number_UNIQUE` (`Loan_Number`),
  KEY `customer_idx` (`Customer_ID`),
  KEY `account_idx` (`Account_ID`),
  CONSTRAINT `fk_loan_customer` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_loan_account` FOREIGN KEY (`Account_ID`) REFERENCES `account` (`Account_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add foreign key for branch manager after employee table is created
--

ALTER TABLE `branch`
  ADD CONSTRAINT `fk_branch_manager` FOREIGN KEY (`Manager_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE SET NULL;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES 
('USD', 'US Dollar', '$', 1.000000, NOW(), 1),
('EUR', 'Euro', '€', 1.180000, NOW(), 0),
('GBP', 'British Pound', '£', 1.380000, NOW(), 0),
('JPY', 'Japanese Yen', '¥', 0.009100, NOW(), 0),
('CAD', 'Canadian Dollar', 'C$', 0.790000, NOW(), 0),
('AUD', 'Australian Dollar', 'A$', 0.720000, NOW(), 0),
('CHF', 'Swiss Franc', 'Fr', 1.100000, NOW(), 0),
('CNY', 'Chinese Yuan', '¥', 0.150000, NOW(), 0),
('INR', 'Indian Rupee', '₹', 0.013000, NOW(), 0),
('SGD', 'Singapore Dollar', 'S$', 0.740000, NOW(), 0);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `accounttype`
--

LOCK TABLES `accounttype` WRITE;
/*!40000 ALTER TABLE `accounttype` DISABLE KEYS */;
INSERT INTO `accounttype` VALUES 
(1, 'Savings', 'Deposit', 'Standard savings account with interest', 500.00, 1.50, 0.00, 'Daily: $1000, Monthly: $10000', 'Online banking, Checkbook, Debit card'),
(2, 'Checking', 'Deposit', 'Everyday checking account for transactions', 100.00, 0.10, 5.00, 'Unlimited', 'Online banking, Checkbook, Debit card, Overdraft protection'),
(3, 'Fixed Deposit', 'Investment', 'Term deposit with fixed interest rate', 1000.00, 3.50, 0.00, 'No withdrawals until maturity', 'Higher interest rates, Loan against FD'),
(4, 'Recurring Deposit', 'Investment', 'Monthly savings plan with fixed interest', 100.00, 3.00, 0.00, 'Monthly deposits required', 'Systematic savings, Loan against RD'),
(5, 'Personal Loan', 'Loan', 'Unsecured personal loan for individuals', 0.00, 10.50, 0.00, 'N/A', 'Quick disbursal, Flexible tenure'),
(6, 'Home Loan', 'Loan', 'Mortgage loan for property purchase', 0.00, 6.50, 0.00, 'N/A', 'Long tenure, Tax benefits'),
(7, 'Auto Loan', 'Loan', 'Vehicle financing', 0.00, 7.50, 0.00, 'N/A', 'Quick approval, Competitive rates'),
(8, 'Business Loan', 'Loan', 'Working capital and business expansion', 0.00, 9.00, 0.00, 'N/A', 'Flexible repayment, No collateral for small amounts');
/*!40000 ALTER TABLE `accounttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES 
(1, 'BR001', 'Downtown Branch', '100 Main Street', 'New York', 'NY', '10001', 'USA', '+1-212-555-0100', 'downtown@alliancebank.com', NULL, '2010-01-15', 'Active'),
(2, 'BR002', 'Midtown Branch', '500 5th Avenue', 'New York', 'NY', '10018', 'USA', '+1-212-555-0200', 'midtown@alliancebank.com', NULL, '2011-03-20', 'Active'),
(3, 'BR003', 'Financial District', '1 Wall Street', 'New York', 'NY', '10005', 'USA', '+1-212-555-0300', 'financial@alliancebank.com', NULL, '2012-06-10', 'Active'),
(4, 'BR004', 'Westside Branch', '2000 Santa Monica Blvd', 'Los Angeles', 'CA', '90404', 'USA', '+1-310-555-0400', 'westside@alliancebank.com', NULL, '2013-09-05', 'Active'),
(5, 'BR005', 'Downtown LA', '555 S Flower St', 'Los Angeles', 'CA', '90071', 'USA', '+1-213-555-0500', 'dtla@alliancebank.com', NULL, '2014-11-12', 'Active'),
(6, 'BR006', 'Michigan Avenue', '100 N Michigan Ave', 'Chicago', 'IL', '60601', 'USA', '+1-312-555-0600', 'michigan@alliancebank.com', NULL, '2015-02-18', 'Active'),
(7, 'BR007', 'Loop Branch', '200 W Adams St', 'Chicago', 'IL', '60606', 'USA', '+1-312-555-0700', 'loop@alliancebank.com', NULL, '2016-04-22', 'Active'),
(8, 'BR008', 'Uptown Branch', '3000 N Clark St', 'Chicago', 'IL', '60657', 'USA', '+1-312-555-0800', 'uptown@alliancebank.com', NULL, '2017-07-30', 'Active'),
(9, 'BR009', 'Downtown Houston', '1000 Main St', 'Houston', 'TX', '77002', 'USA', '+1-713-555-0900', 'houston@alliancebank.com', NULL, '2018-09-14', 'Active'),
(10, 'BR010', 'International Branch', '1 Bayfront Avenue', 'Singapore', '', '018971', 'Singapore', '+65-6555-1000', 'international@alliancebank.com', NULL, '2019-01-25', 'Active');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES 
(1, 1, 'John', 'Smith', 'EMP001', 'Branch Manager', 'Retail Banking', 'john.smith@alliancebank.com', '+1-212-555-1001', '2010-01-15', NULL, 'Active'),
(2, 1, 'Sarah', 'Johnson', 'EMP002', 'Teller Supervisor', 'Operations', 'sarah.j@alliancebank.com', '+1-212-555-1002', '2011-03-20', 1, 'Active'),
(3, 1, 'Michael', 'Williams', 'EMP003', 'Senior Teller', 'Operations', 'michael.w@alliancebank.com', '+1-212-555-1003', '2012-06-10', 2, 'Active'),
(4, 1, 'Emily', 'Brown', 'EMP004', 'Teller', 'Operations', 'emily.b@alliancebank.com', '+1-212-555-1004', '2014-09-05', 2, 'Active'),
(5, 1, 'David', 'Jones', 'EMP005', 'Loan Officer', 'Lending', 'david.j@alliancebank.com', '+1-212-555-1005', '2015-11-12', 1, 'Active'),
(6, 2, 'Jennifer', 'Davis', 'EMP006', 'Branch Manager', 'Retail Banking', 'jennifer.d@alliancebank.com', '+1-212-555-2001', '2011-03-20', NULL, 'Active'),
(7, 2, 'Robert', 'Miller', 'EMP007', 'Teller Supervisor', 'Operations', 'robert.m@alliancebank.com', '+1-212-555-2002', '2012-08-15', 6, 'Active'),
(8, 2, 'Lisa', 'Wilson', 'EMP008', 'Senior Teller', 'Operations', 'lisa.w@alliancebank.com', '+1-212-555-2003', '2013-10-22', 7, 'Active'),
(9, 3, 'James', 'Taylor', 'EMP009', 'Branch Manager', 'Retail Banking', 'james.t@alliancebank.com', '+1-212-555-3001', '2012-06-10', NULL, 'Active'),
(10, 3, 'Patricia', 'Anderson', 'EMP010', 'Wealth Manager', 'Wealth Management', 'patricia.a@alliancebank.com', '+1-212-555-3002', '2014-01-18', 9, 'Active'),
(11, 4, 'Charles', 'Thomas', 'EMP011', 'Branch Manager', 'Retail Banking', 'charles.t@alliancebank.com', '+1-310-555-4001', '2013-09-05', NULL, 'Active'),
(12, 5, 'Susan', 'Jackson', 'EMP012', 'Branch Manager', 'Retail Banking', 'susan.j@alliancebank.com', '+1-213-555-5001', '2014-11-12', NULL, 'Active'),
(13, 6, 'Joseph', 'White', 'EMP013', 'Branch Manager', 'Retail Banking', 'joseph.w@alliancebank.com', '+1-312-555-6001', '2015-02-18', NULL, 'Active'),
(14, 7, 'Margaret', 'Harris', 'EMP014', 'Branch Manager', 'Retail Banking', 'margaret.h@alliancebank.com', '+1-312-555-7001', '2016-04-22', NULL, 'Active'),
(15, 8, 'Thomas', 'Martin', 'EMP015', 'Branch Manager', 'Retail Banking', 'thomas.m@alliancebank.com', '+1-312-555-8001', '2017-07-30', NULL, 'Active'),
(16, 9, 'Nancy', 'Thompson', 'EMP016', 'Branch Manager', 'Retail Banking', 'nancy.t@alliancebank.com', '+1-713-555-9001', '2018-09-14', NULL, 'Active'),
(17, 10, 'Christopher', 'Garcia', 'EMP017', 'Branch Manager', 'International Banking', 'chris.g@alliancebank.com', '+65-6555-1001', '2019-01-25', NULL, 'Active');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Update branch table with manager IDs
--

UPDATE `branch` SET `Manager_ID` = 1 WHERE `Branch_ID` = 1;
UPDATE `branch` SET `Manager_ID` = 6 WHERE `Branch_ID` = 2;
UPDATE `branch` SET `Manager_ID` = 9 WHERE `Branch_ID` = 3;
UPDATE `branch` SET `Manager_ID` = 11 WHERE `Branch_ID` = 4;
UPDATE `branch` SET `Manager_ID` = 12 WHERE `Branch_ID` = 5;
UPDATE `branch` SET `Manager_ID` = 13 WHERE `Branch_ID` = 6;
UPDATE `branch` SET `Manager_ID` = 14 WHERE `Branch_ID` = 7;
UPDATE `branch` SET `Manager_ID` = 15 WHERE `Branch_ID` = 8;
UPDATE `branch` SET `Manager_ID` = 16 WHERE `Branch_ID` = 9;
UPDATE `branch` SET `Manager_ID` = 17 WHERE `Branch_ID` = 10;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES 
(1, 'Alice', 'Johnson', '1990-05-21', 'alice.johnson@email.com', '+1-212-555-1001', '123 Park Avenue', 'Apt 4B', 'New York', 'NY', '10022', 'USA', 'Driver License', 'NY123456', '2020-01-15', 'Active'),
(2, 'Bob', 'Smith', '1985-08-15', 'bob.smith@email.com', '+1-212-555-1002', '456 Madison Avenue', NULL, 'New York', 'NY', '10022', 'USA', 'Passport', 'US987654', '2019-11-30', 'Active'),
(3, 'Carol', 'Davis', '1992-11-03', 'carol.davis@email.com', '+1-312-555-2001', '789 Lake Shore Drive', 'Unit 12', 'Chicago', 'IL', '60611', 'USA', 'Driver License', 'IL456789', '2021-06-01', 'Active'),
(4, 'David', 'Lee', '1978-02-28', 'david.lee@email.com', '+1-213-555-3001', '321 Hollywood Blvd', NULL, 'Los Angeles', 'CA', '90028', 'USA', 'Driver License', 'CA789123', '2021-03-20', 'Active'),
(5, 'Eva', 'Martinez', '1989-04-07', 'eva.martinez@email.com', '+1-713-555-4001', '555 Texas Street', 'Suite 100', 'Houston', 'TX', '77002', 'USA', 'Driver License', 'TX456123', '2020-07-19', 'Active'),
(6, 'Frank', 'Zhang', '1975-12-13', 'frank.zhang@email.com', '+1-415-555-5001', '888 Market Street', NULL, 'San Francisco', 'CA', '94103', 'USA', 'Passport', 'CN123456', '2018-09-11', 'Active'),
(7, 'Grace', 'Kim', '1993-03-20', 'grace.kim@email.com', '+1-206-555-6001', '777 Pine Street', 'Apt 301', 'Seattle', 'WA', '98101', 'USA', 'Driver License', 'WA789456', '2022-01-09', 'Active'),
(8, 'Henry', 'Brown', '1987-09-15', 'henry.brown@email.com', '+1-617-555-7001', '444 Beacon Street', NULL, 'Boston', 'MA', '02115', 'USA', 'Driver License', 'MA123789', '2020-08-21', 'Active'),
(9, 'Ivy', 'Chen', '1991-06-18', 'ivy.chen@email.com', '+65-9111-2222', '12 Orchard Road', '#05-12', 'Singapore', '', '238801', 'Singapore', 'Passport', 'SG123456', '2021-11-14', 'Active'),
(10, 'Jack', 'Wilson', '1983-12-01', 'jack.wilson@email.com', '+44-20-7946-0123', '221B Baker Street', NULL, 'London', '', 'NW1 6XE', 'UK', 'Passport', 'UK789123', '2019-05-22', 'Active'),
(11, 'Karen', 'Green', '1984-11-11', 'karen.green@email.com', '+1-305-555-8001', '123 Ocean Drive', NULL, 'Miami', 'FL', '33139', 'USA', 'Driver License', 'FL456789', '2021-12-05', 'Active'),
(12, 'Liam', 'Miller', '1991-02-22', 'liam.miller@email.com', '+1-702-555-9001', '456 Las Vegas Blvd', 'Suite 200', 'Las Vegas', 'NV', '89109', 'USA', 'Driver License', 'NV123789', '2019-05-25', 'Active');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES 
(1, 1, 1, 1, 'USD', 'ACC100001', 12500.00, 12500.00, 1.50, '2020-01-15', NULL, 'Active', 0.00, 0.00),
(2, 1, 2, 1, 'USD', 'ACC100002', 3500.00, 3500.00, 0.10, '2020-01-15', NULL, 'Active', 5.00, 500.00),
(3, 2, 1, 2, 'USD', 'ACC100003', 8750.50, 8750.50, 1.50, '2019-11-30', NULL, 'Active', 0.00, 0.00),
(4, 2, 2, 2, 'USD', 'ACC100004', 2500.00, 2500.00, 0.10, '2019-11-30', NULL, 'Active', 5.00, 1000.00),
(5, 3, 1, 6, 'USD', 'ACC100005', 15200.75, 15200.75, 1.50, '2021-06-01', NULL, 'Active', 0.00, 0.00),
(6, 3, 3, 6, 'USD', 'FD100001', 10000.00, 10000.00, 3.50, '2021-06-01', '2024-06-01', 'Active', 0.00, 0.00),
(7, 4, 2, 4, 'USD', 'ACC100006', 5200.00, 5200.00, 0.10, '2021-03-20', NULL, 'Active', 5.00, 500.00),
(8, 4, 4, 4, 'USD', 'RD100001', 5000.00, 5000.00, 3.00, '2021-03-20', '2024-03-20', 'Active', 0.00, 0.00),
(9, 5, 1, 9, 'USD', 'ACC100007', 8200.25, 8200.25, 1.50, '2020-07-19', NULL, 'Active', 0.00, 0.00),
(10, 6, 1, 5, 'USD', 'ACC100008', 15000.00, 15000.00, 1.50, '2018-09-11', NULL, 'Active', 0.00, 0.00),
(11, 6, 3, 5, 'USD', 'FD100002', 25000.00, 25000.00, 3.75, '2022-01-15', '2025-01-15', 'Active', 0.00, 0.00),
(12, 7, 1, 3, 'USD', 'ACC100009', 9500.00, 9500.00, 1.50, '2022-01-09', NULL, 'Active', 0.00, 0.00),
(13, 7, 2, 3, 'USD', 'ACC100010', 2100.00, 2100.00, 0.10, '2022-01-09', NULL, 'Active', 5.00, 750.00),
(14, 8, 1, 1, 'USD', 'ACC100011', 6300.00, 6300.00, 1.50, '2020-08-21', NULL, 'Active', 0.00, 0.00),
(15, 9, 1, 10, 'SGD', 'ACC100012', 15000.00, 15000.00, 1.00, '2021-11-14', NULL, 'Active', 0.00, 0.00),
(16, 9, 2, 10, 'SGD', 'ACC100013', 5000.00, 5000.00, 0.05, '2021-11-14', NULL, 'Active', 2.00, 1000.00),
(17, 10, 1, 2, 'GBP', 'ACC100014', 8500.00, 8500.00, 1.25, '2019-05-22', NULL, 'Active', 0.00, 0.00),
(18, 11, 1, 1, 'USD', 'ACC100015', 7200.00, 7200.00, 1.50, '2021-12-05', NULL, 'Active', 0.00, 0.00),
(19, 12, 1, 7, 'USD', 'ACC100016', 5600.00, 5600.00, 1.50, '2019-05-25', NULL, 'Active', 0.00, 0.00),
(20, 12, 5, 7, 'USD', 'LN100001', 25000.00, 25000.00, 10.50, '2019-05-25', '2019-06-25', 'Active', 0.00, 0.00);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `fixeddeposit`
--

LOCK TABLES `fixeddeposit` WRITE;
/*!40000 ALTER TABLE `fixeddeposit` DISABLE KEYS */;
INSERT INTO `fixeddeposit` (FD_ID, Account_ID, FD_Number, Principal_Amount, Interest_Rate, Term_Months, Start_Date, Maturity_Date, Interest_Payout_Option, Nominee_Name, Status) VALUES
(1, 6, 'FD202106001', 10000.00, 3.50, 36, '2021-06-01', '2024-06-01', 'Maturity', 'Carol Davis', 'Active'),
(2, 11, 'FD202201002', 25000.00, 3.75, 36, '2022-01-15', '2025-01-15', 'Quarterly', 'Susan Zhang', 'Active'),
(3, 1, 'FD202301003', 15000.00, 4.00, 12, '2023-01-10', '2024-01-10', 'Maturity', 'Alice Johnson', 'Active'),
(4, 5, 'FD202302004', 20000.00, 3.85, 24, '2023-02-20', '2025-02-20', 'Monthly', 'Bob Smith', 'Active'),
(5, 10, 'FD202303005', 30000.00, 4.25, 48, '2023-03-05', '2027-03-05', 'Maturity', 'Frank Zhang', 'Active');
/*!40000 ALTER TABLE `fixeddeposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `recurringdeposit`
--

LOCK TABLES `recurringdeposit` WRITE;
/*!40000 ALTER TABLE `recurringdeposit` DISABLE KEYS */;
INSERT INTO `recurringdeposit` (RD_ID, Account_ID, RD_Number, Monthly_Installment, Interest_Rate, Term_Months, Start_Date, Maturity_Date, Total_Deposited, Installment_Due_Day, Next_Installment_Date, Installments_Paid, Status) VALUES
(1, 8, 'RD202103001', 500.00, 3.00, 36, '2021-03-20', '2024-03-20', 17000.00, 5, '2024-04-05', 34, 'Active'),
(2, 3, 'RD202207002', 1000.00, 3.25, 24, '2022-07-10', '2024-07-10', 20000.00, 10, '2024-04-10', 20, 'Active'),
(3, 14, 'RD202211003', 750.00, 3.10, 36, '2022-11-15', '2025-11-15', 12000.00, 15, '2024-04-15', 16, 'Active'),
(4, 18, 'RD202301004', 600.00, 3.00, 48, '2023-01-05', '2027-01-05', 8400.00, 5, '2024-04-05', 14, 'Active'),
(5, 9, 'RD202302005', 800.00, 3.15, 36, '2023-02-01', '2026-02-01', 9600.00, 1, '2024-04-01', 12, 'Active');
/*!40000 ALTER TABLE `recurringdeposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES 
(1, 2, 3, 'Personal Loan', 'LN202001001', 15000.00, 8500.00, 10.50, 'Fixed', 36, 487.00, 15, '2020-02-01', '2020-03-15', '2023-02-01', NULL, 'Active'),
(2, 3, 5, 'Home Loan', 'LN202106002', 250000.00, 235000.00, 6.50, 'Fixed', 240, 1865.00, 1, '2021-06-15', '2021-08-01', '2041-06-15', '123 Lake Shore Drive, Chicago', 'Active'),
(3, 4, 7, 'Auto Loan', 'LN202103003', 35000.00, 22000.00, 7.50, 'Fixed', 60, 702.00, 20, '2021-03-25', '2021-05-20', '2026-03-25', '2022 Toyota Camry', 'Active'),
(4, 5, 9, 'Business Loan', 'LN202007004', 50000.00, 30000.00, 9.00, 'Variable', 84, 825.00, 5, '2020-07-30', '2020-09-05', '2027-07-30', 'Business assets', 'Active'),
(5, 6, 10, 'Home Loan', 'LN201809005', 450000.00, 380000.00, 6.25, 'Fixed', 360, 2770.00, 10, '2018-09-20', '2018-11-15', '2048-09-20', '888 Market Street, SF', 'Active'),
(6, 12, 20, 'Personal Loan', 'LN201906006', 25000.00, 25000.00, 10.50, 'Fixed', 36, 812.00, 25, '2019-05-25', '2019-06-25', '2022-05-25', NULL, 'Active');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES 
(1, 1, '2024-03-01 10:15:00', 'Deposit', 500.00, 'USD', 1.000000, 'Salary deposit', 'TRX001', 'Completed', NULL, NULL, 0, 'Approved', 3),
(2, 1, '2024-03-05 14:30:00', 'Withdrawal', 200.00, 'USD', 1.000000, 'ATM withdrawal', 'TRX002', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(3, 3, '2024-03-02 09:45:00', 'Deposit', 1200.00, 'USD', 1.000000, 'Check deposit', 'TRX003', 'Completed', NULL, NULL, 0, 'Approved', 2),
(4, 3, '2024-03-06 16:20:00', 'Transfer', 300.00, 'USD', 1.000000, 'Transfer to savings', 'TRX004', 'Completed', 5, 1, 0, 'Approved', NULL),
(5, 1, '2024-03-06 16:20:00', 'Transfer', 300.00, 'USD', 1.000000, 'Transfer from checking', 'TRX005', 'Completed', 4, 3, 0, 'Approved', NULL),
(6, 5, '2024-03-03 11:10:00', 'Deposit', 800.00, 'USD', 1.000000, 'Cash deposit', 'TRX006', 'Completed', NULL, NULL, 0, 'Approved', 7),
(7, 5, '2024-03-07 13:45:00', 'Withdrawal', 150.00, 'USD', 1.000000, 'ATM withdrawal', 'TRX007', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(8, 9, '2024-03-04 10:30:00', 'Deposit', 1000.00, 'USD', 1.000000, 'Salary deposit', 'TRX008', 'Completed', NULL, NULL, 0, 'Approved', 4),
(9, 9, '2024-03-08 15:15:00', 'Withdrawal', 400.00, 'USD', 1.000000, 'Check withdrawal', 'TRX009', 'Completed', NULL, NULL, 0, 'Approved', 3),
(10, 12, '2024-03-09 12:00:00', 'Deposit', 750.00, 'USD', 1.000000, 'Cash deposit', 'TRX010', 'Completed', NULL, NULL, 0, 'Approved', 8),
(11, 15, '2024-03-10 09:30:00', 'Deposit', 2000.00, 'SGD', 0.740000, 'Salary deposit', 'TRX011', 'Completed', NULL, NULL, 0, 'Approved', 17),
(12, 15, '2024-03-11 14:45:00', 'Withdrawal', 500.00, 'SGD', 0.740000, 'ATM withdrawal', 'TRX012', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(13, 17, '2024-03-12 11:20:00', 'Deposit', 1000.00, 'GBP', 1.380000, 'Salary deposit', 'TRX013', 'Completed', NULL, NULL, 0, 'Approved', 5),
(14, 17, '2024-03-13 16:30:00', 'Transfer', 200.00, 'GBP', 1.380000, 'Transfer to savings', 'TRX014', 'Completed', 15, NULL, 0, 'Approved', NULL),
(15, 2, '2024-03-14 10:15:00', 'Fee', 5.00, 'USD', 1.000000, 'Monthly maintenance fee', 'TRX015', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(16, 4, '2024-03-14 10:16:00', 'Fee', 5.00, 'USD', 1.000000, 'Monthly maintenance fee', 'TRX016', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(17, 7, '2024-03-14 10:17:00', 'Fee', 5.00, 'USD', 1.000000, 'Monthly maintenance fee', 'TRX017', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(18, 13, '2024-03-14 10:18:00', 'Fee', 5.00, 'USD', 1.000000, 'Monthly maintenance fee', 'TRX018', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(19, 16, '2024-03-14 10:19:00', 'Fee', 2.00, 'SGD', 0.740000, 'Monthly maintenance fee', 'TRX019', 'Completed', NULL, NULL, 0, 'Approved', NULL),
(20, 18, '2024-03-15 09:00:00', 'Interest', 9.00, 'USD', 1.000000, 'Monthly interest credit', 'TRX020', 'Completed', NULL, NULL, 0, 'Approved', NULL);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Create indexes for performance optimization
--

CREATE INDEX idx_customer_email ON customer(Email);
CREATE INDEX idx_customer_status ON customer(Customer_Status);
CREATE INDEX idx_account_customer ON account(Customer_ID);
CREATE INDEX idx_account_type ON account(Account_Type_ID);
CREATE INDEX idx_account_branch ON account(Branch_ID);
CREATE INDEX idx_account_status ON account(Status);
CREATE INDEX idx_account_balance ON account(Balance);
CREATE INDEX idx_transaction_account ON transaction(Account_ID);
CREATE INDEX idx_transaction_date ON transaction(Transaction_Date);
CREATE INDEX idx_transaction_type ON transaction(Transaction_Type);
CREATE INDEX idx_transaction_status ON transaction(Status);
CREATE INDEX idx_transaction_fraud ON transaction(Fraud_Flag);
CREATE INDEX idx_loan_customer ON loan(Customer_ID);
CREATE INDEX idx_loan_status ON loan(Status);
CREATE INDEX idx_fd_account ON fixeddeposit(Account_ID);
CREATE INDEX idx_fd_status ON fixeddeposit(Status);
CREATE INDEX idx_rd_account ON recurringdeposit(Account_ID);
CREATE INDEX idx_rd_status ON recurringdeposit(Status);
CREATE INDEX idx_employee_branch ON employee(Branch_ID);
CREATE INDEX idx_employee_role ON employee(Role);

--
-- Create view for customer account summary
--

DROP VIEW IF EXISTS customer_account_summary;
CREATE VIEW customer_account_summary AS
SELECT 
    c.Customer_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
    c.Email,
    c.Phone,
    COUNT(a.Account_ID) AS Total_Accounts,
    SUM(CASE WHEN a.Status = 'Active' THEN 1 ELSE 0 END) AS Active_Accounts,
    SUM(a.Balance) AS Total_Balance,
    MAX(a.Balance) AS Largest_Balance,
    MIN(a.Opening_Date) AS Earliest_Account_Date
FROM customer c
LEFT JOIN account a ON c.Customer_ID = a.Customer_ID
GROUP BY c.Customer_ID, c.First_Name, c.Last_Name, c.Email, c.Phone;

--
-- Create view for branch performance
--

DROP VIEW IF EXISTS branch_performance;
CREATE VIEW branch_performance AS
SELECT 
    b.Branch_ID,
    b.Branch_Name,
    b.City,
    b.Country,
    COUNT(DISTINCT a.Account_ID) AS Total_Accounts,
    SUM(a.Balance) AS Total_Deposits,
    AVG(a.Balance) AS Avg_Account_Balance,
    COUNT(DISTINCT l.Loan_ID) AS Total_Loans,
    SUM(l.Outstanding_Amount) AS Total_Loans_Outstanding,
    COUNT(DISTINCT e.Employee_ID) AS Total_Employees
FROM branch b
LEFT JOIN account a ON b.Branch_ID = a.Branch_ID
LEFT JOIN loan l ON a.Customer_ID = l.Customer_ID
LEFT JOIN employee e ON b.Branch_ID = e.Branch_ID
GROUP BY b.Branch_ID, b.Branch_Name, b.City, b.Country;

--
-- Create view for transaction activity
--

DROP VIEW IF EXISTS transaction_activity;
CREATE VIEW transaction_activity AS
SELECT 
    DATE(t.Transaction_Date) AS Transaction_Date,
    t.Transaction_Type,
    COUNT(*) AS Transaction_Count,
    SUM(t.Amount) AS Total_Amount,
    AVG(t.Amount) AS Avg_Amount,
    SUM(CASE WHEN t.Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud_Count
FROM transaction t
WHERE t.Status = 'Completed'
GROUP BY DATE(t.Transaction_Date), t.Transaction_Type
ORDER BY Transaction_Date DESC, Transaction_Type;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 12:30:00


{# This comprehensive MySQL database schema for Alliance Bank includes:

## Key Features:

1. **10 Core Tables**:
   - `customer` - Personal information and identification
   - `account` - Bank accounts linked to customers
   - `accounttype` - Definitions for savings, checking, loans, etc.
   - `transaction` - All financial transactions with audit trail
   - `fixeddeposit` - Fixed deposit investments
   - `recurringdeposit` - Recurring deposit accounts
   - `loan` - Loan accounts with repayment tracking
   - `branch` - Physical bank locations
   - `employee` - Bank staff with role-based access
   - `currency` - Multi-currency support with exchange rates

2. **Proper Relationships**:
   - All foreign key constraints with appropriate ON DELETE actions
   - Self-referential relationship for employee supervision
   - Transaction linking for transfers (Related_Transaction_ID)

3. **Sample Data**:
   - 10 currencies with exchange rates
   - 8 account types with features
   - 10 branches across multiple locations
   - 17 employees with hierarchical structure
   - 12 customers with 20 accounts
   - 5 FDs, 5 RDs, 6 loans
   - 20 sample transactions with various types

4. **Advanced Features**:
   - Generated columns for maturity amounts (FD, RD)
   - Comprehensive indexes for performance
   - Views for reporting (customer summary, branch performance, transaction activity)
   - Multi-currency support with exchange rates
   - Fraud flag and approval tracking

5. **ACID Compliance Ready**:
   - Proper data types with appropriate precision
   - Constraints to maintain data integrity
   - Transaction logging with audit capabilities

This schema provides a robust foundation for a retail bank's transaction processing system that can handle deposits, withdrawals, transfers, loan repayments, and specialized products like Fixed Deposits and Recurring Deposits with full multi-currency support. #}