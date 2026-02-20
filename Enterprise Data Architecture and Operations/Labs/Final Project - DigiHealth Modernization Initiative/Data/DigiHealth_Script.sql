
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: DigiHealth_OLTP
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
-- PART 1: DIGIHEALTH OLTP DATABASE (MySQL)
-- Transactional System for Real-Time Operations
-- ===================================================================

--
-- Create database
--

DROP DATABASE IF EXISTS DigiHealth_OLTP;
CREATE DATABASE DigiHealth_OLTP;
USE DigiHealth_OLTP;

--
-- Table structure for table `Insurance`
--

DROP TABLE IF EXISTS `Insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Insurance` (
  `InsuranceID` int NOT NULL AUTO_INCREMENT,
  `Provider` varchar(100) NOT NULL,
  `PolicyNumber` varchar(50) NOT NULL,
  `CoverageType` varchar(50) DEFAULT NULL,
  `CoverageDetails` text,
  `ExpiryDate` date DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`InsuranceID`),
  UNIQUE KEY `PolicyNumber_UNIQUE` (`PolicyNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Patients`
--

DROP TABLE IF EXISTS `Patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patients` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `Gender` enum('Male','Female','Other') NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` text,
  `EmergencyContactName` varchar(100) DEFAULT NULL,
  `EmergencyContactPhone` varchar(20) DEFAULT NULL,
  `InsuranceID` int DEFAULT NULL,
  `RegistrationDate` date NOT NULL,
  `Status` enum('Active','Inactive','Deceased') DEFAULT 'Active',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PatientID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `InsuranceID_idx` (`InsuranceID`),
  CONSTRAINT `fk_patient_insurance` FOREIGN KEY (`InsuranceID`) REFERENCES `Insurance` (`InsuranceID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departments` (
  `DepartmentID` int NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(100) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `HeadDoctorID` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DepartmentID`),
  UNIQUE KEY `DepartmentName_UNIQUE` (`DepartmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Doctors`
--

DROP TABLE IF EXISTS `Doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctors` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Specialization` varchar(100) DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `LicenseNumber` varchar(50) DEFAULT NULL,
  `HireDate` date NOT NULL,
  `Status` enum('Active','On Leave','Terminated') DEFAULT 'Active',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DoctorID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `LicenseNumber_UNIQUE` (`LicenseNumber`),
  KEY `DepartmentID_idx` (`DepartmentID`),
  CONSTRAINT `fk_doctor_department` FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add foreign key for HeadDoctorID in Departments table
--

ALTER TABLE `Departments` 
  ADD CONSTRAINT `fk_department_head` FOREIGN KEY (`HeadDoctorID`) REFERENCES `Doctors` (`DoctorID`) ON DELETE SET NULL;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Role` varchar(50) NOT NULL,
  `DepartmentID` int DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `HireDate` date NOT NULL,
  `Status` enum('Active','On Leave','Terminated') DEFAULT 'Active',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `DepartmentID_idx` (`DepartmentID`),
  CONSTRAINT `fk_employee_department` FOREIGN KEY (`DepartmentID`) REFERENCES `Departments` (`DepartmentID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Medications`
--

DROP TABLE IF EXISTS `Medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medications` (
  `MedicationID` int NOT NULL AUTO_INCREMENT,
  `MedicationName` varchar(100) NOT NULL,
  `GenericName` varchar(100) DEFAULT NULL,
  `Manufacturer` varchar(100) DEFAULT NULL,
  `Strength` varchar(50) DEFAULT NULL,
  `Form` varchar(50) DEFAULT NULL,
  `UnitPrice` decimal(10,2) DEFAULT NULL,
  `RequiresPrescription` tinyint(1) DEFAULT '1',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MedicationID`),
  KEY `idx_medication_name` (`MedicationName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Appointments`
--

DROP TABLE IF EXISTS `Appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointments` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int NOT NULL,
  `DoctorID` int NOT NULL,
  `AppointmentDate` date NOT NULL,
  `AppointmentTime` time NOT NULL,
  `Duration` int DEFAULT '30',
  `Status` enum('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'Scheduled',
  `Reason` text,
  `Notes` text,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AppointmentID`),
  KEY `PatientID_idx` (`PatientID`),
  KEY `DoctorID_idx` (`DoctorID`),
  KEY `idx_appointment_date` (`AppointmentDate`),
  KEY `idx_status` (`Status`),
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `fk_appointment_doctor` FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MedicalRecords`
--

DROP TABLE IF EXISTS `MedicalRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicalRecords` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int NOT NULL,
  `DoctorID` int NOT NULL,
  `AppointmentID` int DEFAULT NULL,
  `Diagnosis` text NOT NULL,
  `Treatment` text,
  `Notes` text,
  `RecordDate` date NOT NULL,
  `FollowUpDate` date DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecordID`),
  KEY `PatientID_idx` (`PatientID`),
  KEY `DoctorID_idx` (`DoctorID`),
  KEY `AppointmentID_idx` (`AppointmentID`),
  KEY `idx_patient_date` (`PatientID`,`RecordDate`),
  CONSTRAINT `fk_record_patient` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `fk_record_doctor` FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`),
  CONSTRAINT `fk_record_appointment` FOREIGN KEY (`AppointmentID`) REFERENCES `Appointments` (`AppointmentID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Prescriptions`
--

DROP TABLE IF EXISTS `Prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prescriptions` (
  `PrescriptionID` int NOT NULL AUTO_INCREMENT,
  `RecordID` int NOT NULL,
  `MedicationID` int NOT NULL,
  `Dosage` varchar(50) NOT NULL,
  `Frequency` varchar(100) NOT NULL,
  `Duration` int DEFAULT NULL,
  `Instructions` text,
  `PrescribedDate` date NOT NULL,
  `Refills` int DEFAULT '0',
  `Dispensed` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PrescriptionID`),
  KEY `RecordID_idx` (`RecordID`),
  KEY `MedicationID_idx` (`MedicationID`),
  KEY `idx_prescribed_date` (`PrescribedDate`),
  CONSTRAINT `fk_prescription_record` FOREIGN KEY (`RecordID`) REFERENCES `MedicalRecords` (`RecordID`) ON DELETE CASCADE,
  CONSTRAINT `fk_prescription_medication` FOREIGN KEY (`MedicationID`) REFERENCES `Medications` (`MedicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Billing`
--

DROP TABLE IF EXISTS `Billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Billing` (
  `InvoiceID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int NOT NULL,
  `AppointmentID` int DEFAULT NULL,
  `InvoiceNumber` varchar(50) NOT NULL,
  `InvoiceDate` date NOT NULL,
  `DueDate` date NOT NULL,
  `Subtotal` decimal(10,2) NOT NULL,
  `Tax` decimal(10,2) DEFAULT '0.00',
  `Discount` decimal(10,2) DEFAULT '0.00',
  `TotalAmount` decimal(10,2) NOT NULL,
  `PaidAmount` decimal(10,2) DEFAULT '0.00',
  `Status` enum('Pending','Partial','Paid','Overdue','Cancelled') DEFAULT 'Pending',
  `PaymentMethod` enum('Cash','Credit Card','Debit Card','Insurance','Bank Transfer') DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `InsuranceClaimID` varchar(50) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`InvoiceID`),
  UNIQUE KEY `InvoiceNumber_UNIQUE` (`InvoiceNumber`),
  KEY `PatientID_idx` (`PatientID`),
  KEY `AppointmentID_idx` (`AppointmentID`),
  KEY `idx_invoice_date` (`InvoiceDate`),
  KEY `idx_status` (`Status`),
  CONSTRAINT `fk_billing_patient` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `fk_billing_appointment` FOREIGN KEY (`AppointmentID`) REFERENCES `Appointments` (`AppointmentID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- ===================================================================
-- SAMPLE DATA INSERTION (PART 2)
-- ===================================================================

--
-- Insert sample data into Departments
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` (DepartmentName, Location) VALUES
('Cardiology', 'Building A, Floor 2'),
('Pediatrics', 'Building B, Floor 1'),
('Emergency', 'Building A, Floor 1'),
('Radiology', 'Building C, Floor 3'),
('Oncology', 'Building B, Floor 4'),
('Administration', 'Building A, Floor 5');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Insurance
--

LOCK TABLES `Insurance` WRITE;
/*!40000 ALTER TABLE `Insurance` DISABLE KEYS */;
INSERT INTO `Insurance` (Provider, PolicyNumber, CoverageType, CoverageDetails, ExpiryDate) VALUES
('Blue Cross', 'BC-12345-USA', 'Comprehensive', 'Covers hospitalization, prescriptions, and preventive care', '2025-12-31'),
('Aetna', 'AE-78901-USA', 'Basic', 'Covers hospitalization only', '2024-06-30'),
('Cigna', 'CG-45678-USA', 'Premium', 'Full coverage including dental and vision', '2025-03-15'),
('UnitedHealth', 'UH-98765-USA', 'Family', 'Family coverage for employee and dependents', '2024-09-30'),
('Medicare', 'MD-54321-USA', 'Senior', 'Coverage for patients over 65', '2025-01-01'),
('Kaiser Permanente', 'KP-11223-USA', 'Comprehensive', 'HMO plan with integrated care', '2024-12-31'),
('Humana', 'HM-44556-USA', 'Basic', 'Medicare Advantage plan', '2024-11-30');
/*!40000 ALTER TABLE `Insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Patients
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` (FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address, EmergencyContactName, EmergencyContactPhone, InsuranceID, RegistrationDate, Status) VALUES
('John', 'Smith', '1985-05-15', 'Male', '555-123-4567', 'john.smith@email.com', '123 Main St, Anytown, USA', 'Jane Smith', '555-987-6543', 1, '2023-01-10', 'Active'),
('Maria', 'Garcia', '1990-08-22', 'Female', '555-234-5678', 'maria.garcia@email.com', '456 Oak Ave, Somewhere, USA', 'Carlos Garcia', '555-876-5432', 2, '2023-02-15', 'Active'),
('Robert', 'Johnson', '1978-11-30', 'Male', '555-345-6789', 'robert.johnson@email.com', '789 Pine Rd, Elsewhere, USA', 'Susan Johnson', '555-765-4321', 3, '2023-03-20', 'Active'),
('Emily', 'Brown', '1995-03-12', 'Female', '555-456-7890', 'emily.brown@email.com', '321 Elm St, Nowhere, USA', 'Michael Brown', '555-654-3210', 4, '2023-04-05', 'Active'),
('David', 'Wilson', '1982-07-19', 'Male', '555-567-8901', 'david.wilson@email.com', '654 Maple Dr, Anywhere, USA', 'Sarah Wilson', '555-543-2109', 5, '2023-05-12', 'Active'),
('Sarah', 'Martinez', '1988-09-25', 'Female', '555-678-9012', 'sarah.martinez@email.com', '987 Cedar Ln, Someplace, USA', 'James Martinez', '555-432-1098', NULL, '2023-06-18', 'Active'),
('Michael', 'Lee', '1975-12-03', 'Male', '555-789-0123', 'michael.lee@email.com', '147 Birch St, Othertown, USA', 'Jennifer Lee', '555-321-0987', 1, '2023-07-22', 'Active'),
('Linda', 'Taylor', '1965-04-18', 'Female', '555-890-1234', 'linda.taylor@email.com', '258 Spruce Ave, Anytown, USA', 'Thomas Taylor', '555-210-9876', 6, '2023-08-30', 'Active'),
('William', 'Anderson', '1950-11-08', 'Male', '555-901-2345', 'william.anderson@email.com', '369 Willow Dr, Somewhere, USA', 'Patricia Anderson', '555-109-8765', 7, '2023-09-14', 'Active'),
('Jennifer', 'Thomas', '1992-02-28', 'Female', '555-012-3456', 'jennifer.thomas@email.com', '741 Ash St, Elsewhere, USA', 'Charles Thomas', '555-098-7654', 2, '2023-10-05', 'Active');
/*!40000 ALTER TABLE `Patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Doctors
--

LOCK TABLES `Doctors` WRITE;
/*!40000 ALTER TABLE `Doctors` DISABLE KEYS */;
INSERT INTO `Doctors` (FirstName, LastName, Specialization, DepartmentID, Phone, Email, LicenseNumber, HireDate, Status) VALUES
('James', 'Wilson', 'Interventional Cardiology', 1, '555-111-2222', 'dr.wilson@digihealth.com', 'MD12345', '2018-06-01', 'Active'),
('Lisa', 'Chen', 'Pediatric Medicine', 2, '555-222-3333', 'dr.chen@digihealth.com', 'MD23456', '2019-03-15', 'Active'),
('Robert', 'Miller', 'Emergency Medicine', 3, '555-333-4444', 'dr.miller@digihealth.com', 'MD34567', '2017-01-10', 'Active'),
('Patricia', 'Davis', 'Cardiology', 1, '555-444-5555', 'dr.davis@digihealth.com', 'MD45678', '2020-02-20', 'Active'),
('Thomas', 'Anderson', 'Radiology', 4, '555-555-6666', 'dr.anderson@digihealth.com', 'MD56789', '2019-08-10', 'Active'),
('Susan', 'Martinez', 'Oncology', 5, '555-666-7777', 'dr.martinez@digihealth.com', 'MD67890', '2021-01-15', 'Active'),
('David', 'Brown', 'General Surgery', 3, '555-777-8888', 'dr.brown@digihealth.com', 'MD78901', '2020-09-22', 'Active'),
('Maria', 'Rodriguez', 'Pediatric Cardiology', 2, '555-888-9999', 'dr.rodriguez@digihealth.com', 'MD89012', '2022-04-11', 'Active');
/*!40000 ALTER TABLE `Doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Update Departments with HeadDoctorID
--

UPDATE `Departments` SET HeadDoctorID = 1 WHERE DepartmentID = 1; -- Cardiology
UPDATE `Departments` SET HeadDoctorID = 2 WHERE DepartmentID = 2; -- Pediatrics
UPDATE `Departments` SET HeadDoctorID = 3 WHERE DepartmentID = 3; -- Emergency
UPDATE `Departments` SET HeadDoctorID = 5 WHERE DepartmentID = 4; -- Radiology
UPDATE `Departments` SET HeadDoctorID = 6 WHERE DepartmentID = 5; -- Oncology

--
-- Insert sample data into Employees
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` (FirstName, LastName, Role, DepartmentID, Phone, Email, HireDate, Status) VALUES
('Jennifer', 'Martinez', 'Administrator', 6, '555-666-7777', 'admin.martinez@digihealth.com', '2016-11-05', 'Active'),
('Christopher', 'Brown', 'Receptionist', 6, '555-777-8888', 'reception.brown@digihealth.com', '2021-04-12', 'Active'),
('Amanda', 'Garcia', 'Nurse', 1, '555-888-9999', 'nurse.garcia@digihealth.com', '2020-09-01', 'Active'),
('Kevin', 'Jones', 'Nurse', 3, '555-999-0000', 'nurse.jones@digihealth.com', '2021-01-15', 'Active'),
('Michelle', 'Williams', 'Lab Technician', 4, '555-123-1111', 'lab.williams@digihealth.com', '2019-11-20', 'Active'),
('Daniel', 'Miller', 'Pharmacist', 6, '555-123-2222', 'pharm.miller@digihealth.com', '2022-02-10', 'Active'),
('Laura', 'Davis', 'Receptionist', 2, '555-123-3333', 'reception.davis@digihealth.com', '2023-01-05', 'Active'),
('Jason', 'Rodriguez', 'Nurse', 5, '555-123-4444', 'nurse.rodriguez@digihealth.com', '2022-08-22', 'Active');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Medications
--

LOCK TABLES `Medications` WRITE;
/*!40000 ALTER TABLE `Medications` DISABLE KEYS */;
INSERT INTO `Medications` (MedicationName, GenericName, Manufacturer, Strength, Form, UnitPrice, RequiresPrescription) VALUES
('Lisinopril', 'Lisinopril', 'Pfizer', '10mg', 'Tablet', 0.50, TRUE),
('Metformin', 'Metformin HCl', 'Merck', '500mg', 'Tablet', 0.30, TRUE),
('Atorvastatin', 'Atorvastatin', 'AstraZeneca', '20mg', 'Tablet', 0.75, TRUE),
('Amoxicillin', 'Amoxicillin', 'GSK', '500mg', 'Capsule', 1.20, TRUE),
('Ibuprofen', 'Ibuprofen', 'Johnson & Johnson', '400mg', 'Tablet', 0.15, FALSE),
('Acetaminophen', 'Acetaminophen', 'Tylenol', '500mg', 'Tablet', 0.10, FALSE),
('Albuterol', 'Albuterol', 'GSK', '90mcg', 'Inhaler', 25.00, TRUE),
('Levothyroxine', 'Levothyroxine Sodium', 'AbbVie', '50mcg', 'Tablet', 0.40, TRUE),
('Amlodipine', 'Amlodipine Besylate', 'Pfizer', '5mg', 'Tablet', 0.35, TRUE),
('Omeprazole', 'Omeprazole', 'AstraZeneca', '20mg', 'Capsule', 0.60, FALSE),
('Metoprolol', 'Metoprolol Tartrate', 'Novartis', '50mg', 'Tablet', 0.45, TRUE),
('Hydrochlorothiazide', 'Hydrochlorothiazide', 'Sanofi', '25mg', 'Tablet', 0.20, TRUE);
/*!40000 ALTER TABLE `Medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Appointments
--

LOCK TABLES `Appointments` WRITE;
/*!40000 ALTER TABLE `Appointments` DISABLE KEYS */;
INSERT INTO `Appointments` (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status, Reason, Notes) VALUES
(1, 1, '2024-01-15', '09:00:00', 'Completed', 'Annual checkup', 'Patient in good health'),
(2, 2, '2024-01-15', '10:30:00', 'Completed', 'Child wellness visit', 'Vaccinations due'),
(3, 3, '2024-01-16', '14:00:00', 'Completed', 'Chest pain', 'EKG ordered'),
(1, 1, '2024-02-15', '09:30:00', 'Scheduled', 'Follow-up', 'Review lab results'),
(4, 1, '2024-02-16', '11:00:00', 'Scheduled', 'Palpitations', 'New patient consult'),
(5, 3, '2024-02-17', '15:30:00', 'Scheduled', 'Injury', 'Sprained ankle'),
(6, 2, '2024-01-20', '09:00:00', 'Completed', 'Fever', 'Upper respiratory infection'),
(7, 1, '2024-01-22', '14:00:00', 'Completed', 'Hypertension follow-up', 'BP well controlled'),
(8, 5, '2024-01-25', '13:00:00', 'Completed', 'Annual mammogram', 'Results normal'),
(9, 6, '2024-01-28', '11:30:00', 'Completed', 'Chemotherapy consultation', 'Treatment plan discussed'),
(10, 2, '2024-02-01', '09:15:00', 'Scheduled', 'Cough', 'Persistent for 2 weeks'),
(3, 1, '2024-02-05', '10:00:00', 'Scheduled', 'Chest pain follow-up', 'Repeat EKG'),
(2, 8, '2024-02-08', '15:45:00', 'Scheduled', 'Heart murmur evaluation', 'Pediatric cardiology consult'),
(4, 4, '2024-02-10', '14:30:00', 'Cancelled', 'Stress test', 'Patient cancelled'),
(5, 1, '2024-01-10', '08:30:00', 'Completed', 'Initial consultation', 'Started on Lisinopril');
/*!40000 ALTER TABLE `Appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into MedicalRecords
--

LOCK TABLES `MedicalRecords` WRITE;
/*!40000 ALTER TABLE `MedicalRecords` DISABLE KEYS */;
INSERT INTO `MedicalRecords` (PatientID, DoctorID, AppointmentID, Diagnosis, Treatment, Notes, RecordDate, FollowUpDate) VALUES
(1, 1, 1, 'Essential hypertension', 'Continue Lisinopril 10mg daily', 'BP 128/82, stable', '2024-01-15', '2024-07-15'),
(2, 2, 2, 'Well child visit', 'Routine vaccinations administered', 'Growth appropriate for age', '2024-01-15', '2025-01-15'),
(3, 3, 3, 'Gastroesophageal reflux', 'Prescribed Omeprazole 20mg daily', 'Symptoms improving', '2024-01-16', '2024-04-16'),
(6, 2, 7, 'Acute bronchitis', 'Prescribed Amoxicillin 500mg TID for 10 days', 'Chest congestion, productive cough', '2024-01-20', '2024-01-30'),
(7, 1, 8, 'Hyperlipidemia', 'Continue Atorvastatin 20mg', 'Cholesterol improving', '2024-01-22', '2024-07-22'),
(8, 5, 12, 'Routine screening', 'Mammogram completed', 'No abnormalities detected', '2024-01-25', '2025-01-25'),
(9, 6, 13, 'Breast cancer, stage II', 'Chemotherapy regimen initiated', 'Patient tolerating treatment well', '2024-01-28', '2024-02-28'),
(5, 1, 15, 'Mild hypertension', 'Started on Lisinopril 5mg', 'Initial treatment', '2024-01-10', '2024-04-10');
/*!40000 ALTER TABLE `MedicalRecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Prescriptions
--

LOCK TABLES `Prescriptions` WRITE;
/*!40000 ALTER TABLE `Prescriptions` DISABLE KEYS */;
INSERT INTO `Prescriptions` (RecordID, MedicationID, Dosage, Frequency, Duration, Instructions, PrescribedDate, Refills, Dispensed) VALUES
(1, 1, '1 tablet', 'Once daily', 90, 'Take with food', '2024-01-15', 3, 1),
(3, 10, '1 capsule', 'Once daily', 30, 'Take before meals', '2024-01-16', 0, 1),
(4, 4, '1 capsule', 'Three times daily', 10, 'Take with food, complete full course', '2024-01-20', 0, 1),
(5, 3, '1 tablet', 'Once daily', 90, 'Take in evening', '2024-01-22', 3, 1),
(7, 11, '1 tablet', 'Twice daily', 180, 'Take with food', '2024-01-28', 5, 1),
(8, 1, '1 tablet', 'Once daily', 30, 'Take with food', '2024-01-10', 1, 1);
/*!40000 ALTER TABLE `Prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert sample data into Billing
--

LOCK TABLES `Billing` WRITE;
/*!40000 ALTER TABLE `Billing` DISABLE KEYS */;
INSERT INTO `Billing` (PatientID, AppointmentID, InvoiceNumber, InvoiceDate, DueDate, Subtotal, Tax, TotalAmount, PaidAmount, Status, PaymentMethod, PaymentDate, InsuranceClaimID) VALUES
(1, 1, 'INV-2024-001', '2024-01-15', '2024-01-30', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Credit Card', '2024-01-15', NULL),
(2, 2, 'INV-2024-002', '2024-01-15', '2024-01-30', 200.00, 16.00, 216.00, 216.00, 'Paid', 'Insurance', '2024-01-16', 'CLM-2024-001'),
(3, 3, 'INV-2024-003', '2024-01-16', '2024-01-31', 300.00, 24.00, 324.00, 100.00, 'Partial', 'Cash', '2024-01-16', NULL),
(6, 7, 'INV-2024-004', '2024-01-20', '2024-02-04', 180.00, 14.40, 194.40, 0.00, 'Pending', NULL, NULL, NULL),
(7, 8, 'INV-2024-005', '2024-01-22', '2024-02-06', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Debit Card', '2024-01-22', NULL),
(8, 12, 'INV-2024-006', '2024-01-25', '2024-02-09', 350.00, 28.00, 378.00, 378.00, 'Paid', 'Insurance', '2024-01-26', 'CLM-2024-002'),
(9, 13, 'INV-2024-007', '2024-01-28', '2024-02-12', 500.00, 40.00, 540.00, 540.00, 'Paid', 'Insurance', '2024-01-29', 'CLM-2024-003'),
(10, 14, 'INV-2024-008', '2024-02-01', '2024-02-16', 120.00, 9.60, 129.60, 0.00, 'Pending', NULL, NULL, NULL),
(3, 13, 'INV-2024-009', '2024-02-05', '2024-02-20', 180.00, 14.40, 194.40, 0.00, 'Pending', NULL, NULL, NULL),
(5, 15, 'INV-2024-010', '2024-01-10', '2024-01-25', 120.00, 9.60, 129.60, 129.60, 'Paid', 'Credit Card', '2024-01-10', NULL);
/*!40000 ALTER TABLE `Billing` ENABLE KEYS */;
UNLOCK TABLES;

-- ===================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ===================================================================

CREATE INDEX idx_patients_insurance ON Patients(InsuranceID);
CREATE INDEX idx_patients_status ON Patients(Status);
CREATE INDEX idx_doctors_department ON Doctors(DepartmentID);
CREATE INDEX idx_doctors_status ON Doctors(Status);
CREATE INDEX idx_employees_department ON Employees(DepartmentID);
CREATE INDEX idx_employees_status ON Employees(Status);
CREATE INDEX idx_appointments_patient ON Appointments(PatientID);
CREATE INDEX idx_appointments_doctor ON Appointments(DoctorID);
CREATE INDEX idx_appointments_status ON Appointments(Status);
CREATE INDEX idx_medicalrecords_patient ON MedicalRecords(PatientID);
CREATE INDEX idx_medicalrecords_doctor ON MedicalRecords(DoctorID);
CREATE INDEX idx_medicalrecords_date ON MedicalRecords(RecordDate);
CREATE INDEX idx_prescriptions_record ON Prescriptions(RecordID);
CREATE INDEX idx_prescriptions_medication ON Prescriptions(MedicationID);
CREATE INDEX idx_billing_patient ON Billing(PatientID);
CREATE INDEX idx_billing_status ON Billing(Status);
CREATE INDEX idx_billing_date ON Billing(InvoiceDate);

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 15:00:00



-- PostgreSQL dump 14.5
--
-- Host: localhost    Database: DigiHealth_OLAP
-- ------------------------------------------------------
-- Server version	14.5

-- ===================================================================
-- PART 2: DIGIHEALTH OLAP DATA WAREHOUSE (PostgreSQL)
-- Star Schema for Healthcare Analytics
-- ===================================================================

--
-- Create database
--

DROP DATABASE IF EXISTS DigiHealth_OLAP;
CREATE DATABASE DigiHealth_OLAP;
\c DigiHealth_OLAP;

-- ===================================================================
-- DIMENSION TABLES
-- ===================================================================

--
-- Table structure for table DimDate
--

DROP TABLE IF EXISTS DimDate;
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    Week INT NOT NULL,
    DayOfMonth INT NOT NULL,
    DayOfWeek INT NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    IsWeekend BOOLEAN NOT NULL,
    IsHoliday BOOLEAN DEFAULT FALSE
);

--
-- Table structure for table DimPatient
--

DROP TABLE IF EXISTS DimPatient;
CREATE TABLE DimPatient (
    PatientKey SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    FullName VARCHAR(101) NOT NULL,
    Age INT,
    AgeGroup VARCHAR(20),
    Gender VARCHAR(10),
    InsuranceProvider VARCHAR(100),
    InsuranceType VARCHAR(50),
    RegistrationDate DATE,
    IsActive BOOLEAN,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table DimDoctor
--

DROP TABLE IF EXISTS DimDoctor;
CREATE TABLE DimDoctor (
    DoctorKey SERIAL PRIMARY KEY,
    DoctorID INT NOT NULL,
    FullName VARCHAR(101) NOT NULL,
    Specialization VARCHAR(100),
    Department VARCHAR(100),
    HireDate DATE,
    IsActive BOOLEAN,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table DimDepartment
--

DROP TABLE IF EXISTS DimDepartment;
CREATE TABLE DimDepartment (
    DepartmentKey SERIAL PRIMARY KEY,
    DepartmentID INT NOT NULL,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    HeadDoctor VARCHAR(101),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table DimMedication
--

DROP TABLE IF EXISTS DimMedication;
CREATE TABLE DimMedication (
    MedicationKey SERIAL PRIMARY KEY,
    MedicationID INT NOT NULL,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    Strength VARCHAR(50),
    Form VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    RequiresPrescription BOOLEAN,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--
-- Table structure for table DimPaymentMethod
--

DROP TABLE IF EXISTS DimPaymentMethod;
CREATE TABLE DimPaymentMethod (
    PaymentMethodKey SERIAL PRIMARY KEY,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentCategory VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===================================================================
-- FACT TABLES
-- ===================================================================

--
-- Table structure for table FactAppointment
--

DROP TABLE IF EXISTS FactAppointment;
CREATE TABLE FactAppointment (
    AppointmentKey SERIAL PRIMARY KEY,
    AppointmentID INT NOT NULL,
    DateKey INT NOT NULL,
    PatientKey INT NOT NULL,
    DoctorKey INT NOT NULL,
    DepartmentKey INT NOT NULL,
    AppointmentTime TIME,
    Duration INT,
    Status VARCHAR(20),
    IsCompleted BOOLEAN,
    IsCancelled BOOLEAN,
    IsNoShow BOOLEAN,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (DoctorKey) REFERENCES DimDoctor(DoctorKey),
    FOREIGN KEY (DepartmentKey) REFERENCES DimDepartment(DepartmentKey)
);

--
-- Table structure for table FactBilling
--

DROP TABLE IF EXISTS FactBilling;
CREATE TABLE FactBilling (
    BillingKey SERIAL PRIMARY KEY,
    InvoiceID INT NOT NULL,
    DateKey INT NOT NULL,
    PatientKey INT NOT NULL,
    AppointmentKey INT,
    PaymentMethodKey INT,
    Subtotal DECIMAL(10,2),
    Tax DECIMAL(10,2),
    Discount DECIMAL(10,2),
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaidAmount DECIMAL(10,2),
    OutstandingAmount DECIMAL(10,2),
    IsPaid BOOLEAN,
    DaysToPayment INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (AppointmentKey) REFERENCES FactAppointment(AppointmentKey),
    FOREIGN KEY (PaymentMethodKey) REFERENCES DimPaymentMethod(PaymentMethodKey)
);

--
-- Table structure for table FactPrescription
--

DROP TABLE IF EXISTS FactPrescription;
CREATE TABLE FactPrescription (
    PrescriptionKey SERIAL PRIMARY KEY,
    PrescriptionID INT NOT NULL,
    DateKey INT NOT NULL,
    PatientKey INT NOT NULL,
    DoctorKey INT NOT NULL,
    MedicationKey INT NOT NULL,
    Quantity INT,
    Refills INT,
    TotalCost DECIMAL(10,2),
    IsDispensed BOOLEAN,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (DoctorKey) REFERENCES DimDoctor(DoctorKey),
    FOREIGN KEY (MedicationKey) REFERENCES DimMedication(MedicationKey)
);

--
-- Table structure for table FactDailyAggregates
--

DROP TABLE IF EXISTS FactDailyAggregates;
CREATE TABLE FactDailyAggregates (
    AggregateKey SERIAL PRIMARY KEY,
    DateKey INT NOT NULL,
    TotalAppointments INT,
    CompletedAppointments INT,
    CancelledAppointments INT,
    NoShowAppointments INT,
    TotalBillingAmount DECIMAL(15,2),
    TotalPayments DECIMAL(15,2),
    OutstandingAmount DECIMAL(15,2),
    TotalPrescriptions INT,
    UniquePatients INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);

-- ===================================================================
-- POPULATE DIMENSION TABLES
-- ===================================================================

--
-- Populate DimDate (2020-2025)
--

CREATE OR REPLACE FUNCTION PopulateDimDate() RETURNS VOID AS $$
DECLARE
    v_startDate DATE := '2020-01-01';
    v_endDate DATE := '2025-12-31';
    v_currentDate DATE;
BEGIN
    v_currentDate := v_startDate;
    WHILE v_currentDate <= v_endDate LOOP
        INSERT INTO DimDate (
            DateKey,
            FullDate,
            Year,
            Quarter,
            Month,
            MonthName,
            Week,
            DayOfMonth,
            DayOfWeek,
            DayName,
            IsWeekend
        ) VALUES (
            EXTRACT(YEAR FROM v_currentDate) * 10000 
                + EXTRACT(MONTH FROM v_currentDate) * 100 
                + EXTRACT(DAY FROM v_currentDate),
            v_currentDate,
            EXTRACT(YEAR FROM v_currentDate),
            EXTRACT(QUARTER FROM v_currentDate),
            EXTRACT(MONTH FROM v_currentDate),
            TO_CHAR(v_currentDate, 'Month'),
            EXTRACT(WEEK FROM v_currentDate),
            EXTRACT(DAY FROM v_currentDate),
            EXTRACT(DOW FROM v_currentDate) + 1,
            TO_CHAR(v_currentDate, 'Day'),
            CASE WHEN EXTRACT(DOW FROM v_currentDate) IN (0, 6) THEN TRUE ELSE FALSE END
        );
        v_currentDate := v_currentDate + INTERVAL '1 day';
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT PopulateDimDate();

--
-- Populate DimPaymentMethod
--

INSERT INTO DimPaymentMethod (PaymentMethod, PaymentCategory) VALUES
('Cash', 'Physical'),
('Credit Card', 'Card'),
('Debit Card', 'Card'),
('Insurance', 'Insurance'),
('Bank Transfer', 'Digital');

--
-- Populate DimPatient (ETL from MySQL - run after connecting to MySQL source)
-- Note: In production, this would be an ETL job. Here we simulate with INSERT statements.
--

INSERT INTO DimPatient (PatientID, FullName, Age, AgeGroup, Gender, InsuranceProvider, InsuranceType, RegistrationDate, IsActive) VALUES
(1, 'John Smith', 39, 'Middle Age', 'Male', 'Blue Cross', 'Comprehensive', '2023-01-10', TRUE),
(2, 'Maria Garcia', 34, 'Young Adult', 'Female', 'Aetna', 'Basic', '2023-02-15', TRUE),
(3, 'Robert Johnson', 45, 'Middle Age', 'Male', 'Cigna', 'Premium', '2023-03-20', TRUE),
(4, 'Emily Brown', 29, 'Young Adult', 'Female', 'UnitedHealth', 'Family', '2023-04-05', TRUE),
(5, 'David Wilson', 42, 'Middle Age', 'Male', 'Medicare', 'Senior', '2023-05-12', TRUE),
(6, 'Sarah Martinez', 36, 'Middle Age', 'Female', NULL, NULL, '2023-06-18', TRUE),
(7, 'Michael Lee', 48, 'Middle Age', 'Male', 'Blue Cross', 'Comprehensive', '2023-07-22', TRUE),
(8, 'Linda Taylor', 59, 'Senior', 'Female', 'Kaiser Permanente', 'Comprehensive', '2023-08-30', TRUE),
(9, 'William Anderson', 73, 'Elderly', 'Male', 'Humana', 'Basic', '2023-09-14', TRUE),
(10, 'Jennifer Thomas', 32, 'Young Adult', 'Female', 'Aetna', 'Basic', '2023-10-05', TRUE);

--
-- Populate DimDoctor
--

INSERT INTO DimDoctor (DoctorID, FullName, Specialization, Department, HireDate, IsActive) VALUES
(1, 'James Wilson', 'Interventional Cardiology', 'Cardiology', '2018-06-01', TRUE),
(2, 'Lisa Chen', 'Pediatric Medicine', 'Pediatrics', '2019-03-15', TRUE),
(3, 'Robert Miller', 'Emergency Medicine', 'Emergency', '2017-01-10', TRUE),
(4, 'Patricia Davis', 'Cardiology', 'Cardiology', '2020-02-20', TRUE),
(5, 'Thomas Anderson', 'Radiology', 'Radiology', '2019-08-10', TRUE),
(6, 'Susan Martinez', 'Oncology', 'Oncology', '2021-01-15', TRUE),
(7, 'David Brown', 'General Surgery', 'Emergency', '2020-09-22', TRUE),
(8, 'Maria Rodriguez', 'Pediatric Cardiology', 'Pediatrics', '2022-04-11', TRUE);

--
-- Populate DimDepartment
--

INSERT INTO DimDepartment (DepartmentID, DepartmentName, Location, HeadDoctor) VALUES
(1, 'Cardiology', 'Building A, Floor 2', 'James Wilson'),
(2, 'Pediatrics', 'Building B, Floor 1', 'Lisa Chen'),
(3, 'Emergency', 'Building A, Floor 1', 'Robert Miller'),
(4, 'Radiology', 'Building C, Floor 3', 'Thomas Anderson'),
(5, 'Oncology', 'Building B, Floor 4', 'Susan Martinez'),
(6, 'Administration', 'Building A, Floor 5', NULL);

--
-- Populate DimMedication
--

INSERT INTO DimMedication (MedicationID, MedicationName, GenericName, Manufacturer, Strength, Form, UnitPrice, RequiresPrescription) VALUES
(1, 'Lisinopril', 'Lisinopril', 'Pfizer', '10mg', 'Tablet', 0.50, TRUE),
(2, 'Metformin', 'Metformin HCl', 'Merck', '500mg', 'Tablet', 0.30, TRUE),
(3, 'Atorvastatin', 'Atorvastatin', 'AstraZeneca', '20mg', 'Tablet', 0.75, TRUE),
(4, 'Amoxicillin', 'Amoxicillin', 'GSK', '500mg', 'Capsule', 1.20, TRUE),
(5, 'Ibuprofen', 'Ibuprofen', 'Johnson & Johnson', '400mg', 'Tablet', 0.15, FALSE),
(6, 'Acetaminophen', 'Acetaminophen', 'Tylenol', '500mg', 'Tablet', 0.10, FALSE),
(7, 'Albuterol', 'Albuterol', 'GSK', '90mcg', 'Inhaler', 25.00, TRUE),
(8, 'Levothyroxine', 'Levothyroxine Sodium', 'AbbVie', '50mcg', 'Tablet', 0.40, TRUE),
(9, 'Amlodipine', 'Amlodipine Besylate', 'Pfizer', '5mg', 'Tablet', 0.35, TRUE),
(10, 'Omeprazole', 'Omeprazole', 'AstraZeneca', '20mg', 'Capsule', 0.60, FALSE),
(11, 'Metoprolol', 'Metoprolol Tartrate', 'Novartis', '50mg', 'Tablet', 0.45, TRUE),
(12, 'Hydrochlorothiazide', 'Hydrochlorothiazide', 'Sanofi', '25mg', 'Tablet', 0.20, TRUE);

-- ===================================================================
-- POPULATE FACT TABLES
-- ===================================================================

--
-- Populate FactAppointment
--

INSERT INTO FactAppointment (
    AppointmentID,
    DateKey,
    PatientKey,
    DoctorKey,
    DepartmentKey,
    AppointmentTime,
    Duration,
    Status,
    IsCompleted,
    IsCancelled,
    IsNoShow
)
SELECT 
    a.AppointmentID,
    EXTRACT(YEAR FROM a.AppointmentDate) * 10000 
        + EXTRACT(MONTH FROM a.AppointmentDate) * 100 
        + EXTRACT(DAY FROM a.AppointmentDate),
    dp.PatientKey,
    dd.DoctorKey,
    dde.DepartmentKey,
    a.AppointmentTime,
    a.Duration,
    a.Status,
    CASE WHEN a.Status = 'Completed' THEN TRUE ELSE FALSE END,
    CASE WHEN a.Status = 'Cancelled' THEN TRUE ELSE FALSE END,
    CASE WHEN a.Status = 'NoShow' THEN TRUE ELSE FALSE END
FROM (
    VALUES 
    (1, 1, 1, '2024-01-15', '09:00:00', 30, 'Completed'),
    (2, 2, 2, '2024-01-15', '10:30:00', 30, 'Completed'),
    (3, 3, 3, '2024-01-16', '14:00:00', 30, 'Completed'),
    (4, 1, 1, '2024-02-15', '09:30:00', 30, 'Scheduled'),
    (5, 4, 1, '2024-02-16', '11:00:00', 45, 'Scheduled'),
    (6, 5, 3, '2024-02-17', '15:30:00', 30, 'Scheduled'),
    (7, 6, 2, '2024-01-20', '09:00:00', 30, 'Completed'),
    (8, 7, 1, '2024-01-22', '14:00:00', 30, 'Completed'),
    (9, 8, 5, '2024-01-25', '13:00:00', 45, 'Completed'),
    (10, 9, 6, '2024-01-28', '11:30:00', 60, 'Completed'),
    (11, 10, 2, '2024-02-01', '09:15:00', 30, 'Scheduled'),
    (12, 3, 1, '2024-02-05', '10:00:00', 30, 'Scheduled'),
    (13, 2, 8, '2024-02-08', '15:45:00', 45, 'Scheduled'),
    (14, 4, 4, '2024-02-10', '14:30:00', 45, 'Cancelled'),
    (15, 5, 1, '2024-01-10', '08:30:00', 30, 'Completed')
) AS a(AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, Duration, Status)
JOIN DimPatient dp ON a.PatientID = dp.PatientID
JOIN DimDoctor dd ON a.DoctorID = dd.DoctorID
JOIN DimDepartment dde ON dd.Department = dde.DepartmentName;

--
-- Populate FactBilling
--

INSERT INTO FactBilling (
    InvoiceID,
    DateKey,
    PatientKey,
    AppointmentKey,
    PaymentMethodKey,
    Subtotal,
    Tax,
    Discount,
    TotalAmount,
    PaidAmount,
    OutstandingAmount,
    IsPaid,
    DaysToPayment
)
SELECT 
    b.InvoiceID,
    EXTRACT(YEAR FROM b.InvoiceDate) * 10000 
        + EXTRACT(MONTH FROM b.InvoiceDate) * 100 
        + EXTRACT(DAY FROM b.InvoiceDate),
    dp.PatientKey,
    fa.AppointmentKey,
    pm.PaymentMethodKey,
    b.Subtotal,
    b.Tax,
    b.Discount,
    b.TotalAmount,
    b.PaidAmount,
    b.TotalAmount - b.PaidAmount,
    CASE WHEN b.Status = 'Paid' THEN TRUE ELSE FALSE END,
    CASE 
        WHEN b.PaymentDate IS NOT NULL 
        THEN (b.PaymentDate - b.InvoiceDate)
        ELSE NULL
    END
FROM (
    VALUES 
    (1, 1, 1, 'INV-2024-001', '2024-01-15', '2024-01-30', 150.00, 12.00, 0.00, 162.00, 162.00, 'Paid', 'Credit Card', '2024-01-15'),
    (2, 2, 2, 'INV-2024-002', '2024-01-15', '2024-01-30', 200.00, 16.00, 0.00, 216.00, 216.00, 'Paid', 'Insurance', '2024-01-16'),
    (3, 3, 3, 'INV-2024-003', '2024-01-16', '2024-01-31', 300.00, 24.00, 0.00, 324.00, 100.00, 'Partial', 'Cash', '2024-01-16'),
    (4, 6, 7, 'INV-2024-004', '2024-01-20', '2024-02-04', 180.00, 14.40, 0.00, 194.40, 0.00, 'Pending', NULL, NULL),
    (5, 7, 8, 'INV-2024-005', '2024-01-22', '2024-02-06', 150.00, 12.00, 0.00, 162.00, 162.00, 'Paid', 'Debit Card', '2024-01-22'),
    (6, 8, 12, 'INV-2024-006', '2024-01-25', '2024-02-09', 350.00, 28.00, 0.00, 378.00, 378.00, 'Paid', 'Insurance', '2024-01-26'),
    (7, 9, 13, 'INV-2024-007', '2024-01-28', '2024-02-12', 500.00, 40.00, 0.00, 540.00, 540.00, 'Paid', 'Insurance', '2024-01-29'),
    (8, 10, 14, 'INV-2024-008', '2024-02-01', '2024-02-16', 120.00, 9.60, 0.00, 129.60, 0.00, 'Pending', NULL, NULL),
    (9, 3, 13, 'INV-2024-009', '2024-02-05', '2024-02-20', 180.00, 14.40, 0.00, 194.40, 0.00, 'Pending', NULL, NULL),
    (10, 5, 15, 'INV-2024-010', '2024-01-10', '2024-01-25', 120.00, 9.60, 0.00, 129.60, 129.60, 'Paid', 'Credit Card', '2024-01-10')
) AS b(InvoiceID, PatientID, AppointmentID, InvoiceNumber, InvoiceDate, DueDate, Subtotal, Tax, Discount, TotalAmount, PaidAmount, Status, PaymentMethod, PaymentDate)
JOIN DimPatient dp ON b.PatientID = dp.PatientID
LEFT JOIN FactAppointment fa ON b.AppointmentID = fa.AppointmentID
LEFT JOIN DimPaymentMethod pm ON b.PaymentMethod = pm.PaymentMethod;

--
-- Populate FactPrescription
--

INSERT INTO FactPrescription (
    PrescriptionID,
    DateKey,
    PatientKey,
    DoctorKey,
    MedicationKey,
    Quantity,
    Refills,
    TotalCost,
    IsDispensed
)
SELECT 
    p.PrescriptionID,
    EXTRACT(YEAR FROM p.PrescribedDate) * 10000 
        + EXTRACT(MONTH FROM p.PrescribedDate) * 100 
        + EXTRACT(DAY FROM p.PrescribedDate),
    dp.PatientKey,
    dd.DoctorKey,
    dm.MedicationKey,
    30, -- Assuming 30-day supply
    p.Refills,
    dm.UnitPrice * 30,
    p.Dispensed
FROM (
    VALUES 
    (1, 1, 1, '2024-01-15', 1, 3, TRUE),
    (2, 3, 3, '2024-01-16', 10, 0, TRUE),
    (3, 4, 6, '2024-01-20', 4, 0, TRUE),
    (4, 5, 7, '2024-01-22', 3, 3, TRUE),
    (5, 7, 9, '2024-01-28', 11, 5, TRUE),
    (6, 8, 5, '2024-01-10', 1, 1, TRUE)
) AS p(PrescriptionID, RecordID, PatientID, PrescribedDate, MedicationID, Refills, Dispensed)
JOIN DimPatient dp ON p.PatientID = dp.PatientID
JOIN DimMedication dm ON p.MedicationID = dm.MedicationID
JOIN (
    SELECT RecordID, DoctorID FROM (
        VALUES 
        (1, 1), (2, 3), (3, 6), (4, 7), (5, 9), (6, 5)
    ) AS r(RecordID, PatientID)
) AS mr ON p.RecordID = mr.RecordID
JOIN DimDoctor dd ON mr.PatientID = dd.DoctorID; -- Simplified for sample

--
-- Populate FactDailyAggregates
--

INSERT INTO FactDailyAggregates (
    DateKey,
    TotalAppointments,
    CompletedAppointments,
    CancelledAppointments,
    NoShowAppointments,
    TotalBillingAmount,
    TotalPayments,
    OutstandingAmount,
    TotalPrescriptions,
    UniquePatients
)
SELECT 
    fa.DateKey,
    COUNT(DISTINCT fa.AppointmentKey) as TotalAppointments,
    SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) as CompletedAppointments,
    SUM(CASE WHEN fa.IsCancelled THEN 1 ELSE 0 END) as CancelledAppointments,
    SUM(CASE WHEN fa.IsNoShow THEN 1 ELSE 0 END) as NoShowAppointments,
    COALESCE(SUM(fb.TotalAmount), 0) as TotalBillingAmount,
    COALESCE(SUM(fb.PaidAmount), 0) as TotalPayments,
    COALESCE(SUM(fb.OutstandingAmount), 0) as OutstandingAmount,
    COUNT(DISTINCT fp.PrescriptionKey) as TotalPrescriptions,
    COUNT(DISTINCT fa.PatientKey) as UniquePatients
FROM FactAppointment fa
LEFT JOIN FactBilling fb ON fa.DateKey = fb.DateKey AND fa.PatientKey = fb.PatientKey
LEFT JOIN FactPrescription fp ON fa.DateKey = fp.DateKey AND fa.PatientKey = fp.PatientKey
GROUP BY fa.DateKey;

-- ===================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ===================================================================

CREATE INDEX idx_factappointment_date ON FactAppointment(DateKey);
CREATE INDEX idx_factappointment_patient ON FactAppointment(PatientKey);
CREATE INDEX idx_factappointment_doctor ON FactAppointment(DoctorKey);
CREATE INDEX idx_factappointment_department ON FactAppointment(DepartmentKey);
CREATE INDEX idx_factbilling_date ON FactBilling(DateKey);
CREATE INDEX idx_factbilling_patient ON FactBilling(PatientKey);
CREATE INDEX idx_factbilling_appointment ON FactBilling(AppointmentKey);
CREATE INDEX idx_factprescription_date ON FactPrescription(DateKey);
CREATE INDEX idx_factprescription_patient ON FactPrescription(PatientKey);
CREATE INDEX idx_factprescription_doctor ON FactPrescription(DoctorKey);
CREATE INDEX idx_factprescription_medication ON FactPrescription(MedicationKey);
CREATE INDEX idx_dailyaggregates_date ON FactDailyAggregates(DateKey);

-- ===================================================================
-- CREATE MATERIALIZED VIEWS FOR COMMON AGGREGATIONS
-- ===================================================================

-- Monthly department statistics
CREATE MATERIALIZED VIEW mv_monthly_department_stats AS
SELECT 
    d.Year,
    d.Month,
    d.MonthName,
    dept.DepartmentName,
    COUNT(*) as AppointmentCount,
    SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) as CompletedCount,
    AVG(fa.Duration) as AvgDuration,
    COALESCE(SUM(fb.TotalAmount), 0) as TotalRevenue,
    COALESCE(AVG(fb.TotalAmount), 0) as AvgRevenuePerAppointment
FROM FactAppointment fa
JOIN DimDate d ON fa.DateKey = d.DateKey
JOIN DimDepartment dept ON fa.DepartmentKey = dept.DepartmentKey
LEFT JOIN FactBilling fb ON fa.AppointmentKey = fb.AppointmentKey
GROUP BY d.Year, d.Month, d.MonthName, dept.DepartmentName
ORDER BY d.Year, d.Month, dept.DepartmentName;

-- Patient demographics analysis
CREATE MATERIALIZED VIEW mv_patient_demographics AS
SELECT 
    p.AgeGroup,
    p.Gender,
    COUNT(DISTINCT p.PatientKey) as PatientCount,
    COUNT(DISTINCT fa.AppointmentKey) as AppointmentCount,
    SUM(fb.TotalAmount) as TotalRevenue,
    AVG(fb.TotalAmount) as AvgRevenuePerPatient,
    COUNT(DISTINCT fp.PrescriptionKey) as PrescriptionCount
FROM DimPatient p
LEFT JOIN FactAppointment fa ON p.PatientKey = fa.PatientKey
LEFT JOIN FactBilling fb ON p.PatientKey = fb.PatientKey
LEFT JOIN FactPrescription fp ON p.PatientKey = fp.PatientKey
GROUP BY p.AgeGroup, p.Gender
ORDER BY p.AgeGroup, p.Gender;

-- Doctor performance metrics
CREATE MATERIALIZED VIEW mv_doctor_performance AS
SELECT 
    d.DoctorKey,
    d.FullName as DoctorName,
    d.Specialization,
    dept.DepartmentName,
    COUNT(fa.AppointmentKey) as TotalAppointments,
    SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) as CompletedAppointments,
    ROUND(100.0 * SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) / NULLIF(COUNT(fa.AppointmentKey), 0), 2) as CompletionRate,
    AVG(fa.Duration) as AvgAppointmentDuration,
    SUM(fb.TotalAmount) as RevenueGenerated,
    COUNT(DISTINCT fp.PrescriptionKey) as PrescriptionsWritten
FROM DimDoctor d
JOIN DimDepartment dept ON d.Department = dept.DepartmentName
LEFT JOIN FactAppointment fa ON d.DoctorKey = fa.DoctorKey
LEFT JOIN FactBilling fb ON fa.AppointmentKey = fb.AppointmentKey
LEFT JOIN FactPrescription fp ON d.DoctorKey = fp.DoctorKey
GROUP BY d.DoctorKey, d.FullName, d.Specialization, dept.DepartmentName;

-- ===================================================================
-- ANALYTICAL QUERIES
-- ===================================================================

-- Query 1: Monthly appointment trends by department
SELECT 
    d.Year,
    d.MonthName,
    dept.DepartmentName,
    COUNT(*) as AppointmentCount,
    AVG(fa.Duration) as AvgDuration
FROM FactAppointment fa
JOIN DimDate d ON fa.DateKey = d.DateKey
JOIN DimDepartment dept ON fa.DepartmentKey = dept.DepartmentKey
GROUP BY d.Year, d.MonthName, dept.DepartmentName
ORDER BY d.Year, d.Month, AppointmentCount DESC;

-- Query 2: Revenue analysis by patient age group
SELECT 
    p.AgeGroup,
    COUNT(DISTINCT fb.PatientKey) as PatientCount,
    SUM(fb.TotalAmount) as TotalRevenue,
    AVG(fb.TotalAmount) as AvgRevenuePerPatient,
    SUM(fb.OutstandingAmount) as TotalOutstanding
FROM FactBilling fb
JOIN DimPatient p ON fb.PatientKey = p.PatientKey
WHERE fb.DateKey BETWEEN 20240101 AND 20241231
GROUP BY p.AgeGroup
ORDER BY TotalRevenue DESC;

-- Query 3: Top prescribed medications by doctor specialty
SELECT 
    d.Specialization,
    m.MedicationName,
    COUNT(*) as PrescriptionCount,
    SUM(fp.TotalCost) as TotalCost
FROM FactPrescription fp
JOIN DimDoctor d ON fp.DoctorKey = d.DoctorKey
JOIN DimMedication m ON fp.MedicationKey = m.MedicationKey
GROUP BY d.Specialization, m.MedicationName
ORDER BY PrescriptionCount DESC
LIMIT 10;

-- Query 4: Payment collection efficiency over time
SELECT 
    d.Year,
    d.Quarter,
    SUM(fb.TotalAmount) as BilledAmount,
    SUM(fb.PaidAmount) as CollectedAmount,
    ROUND(100.0 * SUM(fb.PaidAmount) / NULLIF(SUM(fb.TotalAmount), 0), 2) as CollectionRate,
    AVG(fb.DaysToPayment) as AvgDaysToPayment
FROM FactBilling fb
JOIN DimDate d ON fb.DateKey = d.DateKey
GROUP BY d.Year, d.Quarter
ORDER BY d.Year, d.Quarter;

-- Query 5: Doctor workload analysis
SELECT 
    d.FullName as DoctorName,
    d.Specialization,
    COUNT(fa.AppointmentKey) as TotalAppointments,
    SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) as CompletedAppointments,
    AVG(fa.Duration) as AvgAppointmentDuration
FROM FactAppointment fa
JOIN DimDoctor d ON fa.DoctorKey = d.DoctorKey
WHERE fa.DateKey BETWEEN 20240101 AND 20241231
GROUP BY d.FullName, d.Specialization
ORDER BY TotalAppointments DESC;

-- Query 6: Insurance provider revenue analysis
SELECT 
    p.InsuranceProvider,
    COUNT(DISTINCT p.PatientKey) as PatientCount,
    SUM(fb.TotalAmount) as TotalRevenue,
    AVG(fb.TotalAmount) as AvgRevenuePerPatient,
    SUM(CASE WHEN fb.IsPaid THEN fb.TotalAmount ELSE 0 END) as PaidRevenue,
    ROUND(100.0 * SUM(CASE WHEN fb.IsPaid THEN 1 ELSE 0 END) / COUNT(*), 2) as PaymentRate
FROM FactBilling fb
JOIN DimPatient p ON fb.PatientKey = p.PatientKey
WHERE p.InsuranceProvider IS NOT NULL
GROUP BY p.InsuranceProvider
ORDER BY TotalRevenue DESC;

-- Query 7: Appointment status distribution
SELECT 
    fa.Status,
    COUNT(*) as AppointmentCount,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as Percentage
FROM FactAppointment fa
GROUP BY fa.Status
ORDER BY AppointmentCount DESC;

-- Query 8: Monthly revenue trend
SELECT 
    d.Year,
    d.MonthName,
    SUM(fb.TotalAmount) as MonthlyRevenue,
    LAG(SUM(fb.TotalAmount)) OVER (ORDER BY d.Year, d.Month) as PreviousMonthRevenue,
    ROUND(100.0 * (SUM(fb.TotalAmount) - LAG(SUM(fb.TotalAmount)) OVER (ORDER BY d.Year, d.Month)) / 
          NULLIF(LAG(SUM(fb.TotalAmount)) OVER (ORDER BY d.Year, d.Month), 0), 2) as GrowthRate
FROM FactBilling fb
JOIN DimDate d ON fb.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

-- Query 9: Most common diagnoses by department
SELECT 
    dept.DepartmentName,
    mr.Diagnosis,
    COUNT(*) as DiagnosisCount
FROM MedicalRecords mr
JOIN DimDepartment dept ON mr.DepartmentID = dept.DepartmentID
GROUP BY dept.DepartmentName, mr.Diagnosis
ORDER BY DiagnosisCount DESC
LIMIT 20;

-- Query 10: Patient visit frequency analysis
SELECT 
    VisitCount,
    COUNT(*) as PatientCount,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as Percentage
FROM (
    SELECT 
        p.PatientKey,
        COUNT(fa.AppointmentKey) as VisitCount
    FROM DimPatient p
    LEFT JOIN FactAppointment fa ON p.PatientKey = fa.PatientKey
    GROUP BY p.PatientKey
) t
GROUP BY VisitCount
ORDER BY VisitCount;

-- Query 11: Doctor performance by patient satisfaction
SELECT
    d.DoctorName,
    dept.DepartmentName,
    COUNT(fa.AppointmentKey) as TotalAppointments,
    AVG(ps.SatisfactionScore) as AvgSatisfaction,
    COUNT(CASE WHEN ps.SatisfactionScore >= 4 THEN 1 END) as HighSatisfactionCount
FROM DimDoctor d
JOIN DimDepartment dept ON d.DepartmentID = dept.DepartmentID
JOIN FactAppointment fa ON d.DoctorKey = fa.DoctorKey
LEFT JOIN PatientSatisfaction ps ON fa.AppointmentKey = ps.AppointmentKey
GROUP BY d.DoctorName, dept.DepartmentName
ORDER BY AvgSatisfaction DESC
LIMIT 15;

-- Query 12: Revenue by patient age group
SELECT
    p.AgeGroup,
    COUNT(DISTINCT p.PatientKey) as PatientCount,
    SUM(fb.TotalAmount) as TotalRevenue,
    AVG(fb.TotalAmount) as AvgRevenuePerPatient
FROM FactBilling fb
JOIN DimPatient p ON fb.PatientKey = p.PatientKey
GROUP BY p.AgeGroup
ORDER BY TotalRevenue DESC;
