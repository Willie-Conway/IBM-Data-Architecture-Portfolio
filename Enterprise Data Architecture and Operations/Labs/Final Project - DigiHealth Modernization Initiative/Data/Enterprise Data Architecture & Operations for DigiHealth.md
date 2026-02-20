
![Logo](../Screenshots/DigiHealth.png)


# Final Project: Enterprise Data Architecture & Operations for DigiHealth

## Estimated time: 1.5 hours

---

## Introduction

**DigiHealth** is a sophisticated Health Management System (HMS) that automates hospital operations, improves patient record management, and offers robust analytics. The system effectively manages real-time transactions, such as patient registration, billing, doctor appointments, and medical history, to facilitate smooth operations in healthcare institutions.

As it grows, DigiHealth is increasingly confronted with data scalability, security, and sophisticated analytics challenges.

To meet these complexities, DigiHealth needs a robust **Enterprise Data Architecture** and a clearly defined **Operational Strategy**.

The enterprise data architect role will be instrumental in streamlining system performance, maintaining data integrity, and facilitating the platform's sustained growth.

---

## Primary Responsibilities of an Enterprise Data Architect

| Responsibility                                                 | Description                                                                                                                                                                                 |
| -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Design and implementation of scalable data models** | Develop and maintain OLTP systems for real-time data handling. Design OLAP systems to support business intelligence and analytics.                                                          |
| **2. Data governance and security**                      | Establish and enforce data security protocols, ensuring compliance with regulatory standards. Define policies for data integrity, access control, and compliance with industry regulations. |
| **3. Development of ETL pipeline**                       | Design and implement Extract, Transform, Load (ETL) processes to facilitate efficient data integration and movement across systems.                                                         |
| **4. Query performance optimization**                    | Fine-tune SQL queries and database performance to enhance the efficiency of both real-time and analytical workloads.                                                                        |
| **5. Implementation of data warehouses and data lakes**  | Architect and manage data warehouses and lakes to enable scalable, data-driven decision-making.                                                                                             |

---

## Learning Objectives

- Design a scalable Enterprise Data Architecture by creating ER diagrams, identifying entities, and implementing normalization techniques
- Develop OLTP and OLAP schemas by implementing MySQL-based transactional databases and Postgres-based OLAP schema

---

## Project Structure

The project is divided into two parts, which are to be submitted sequentially:

| Part             | Focus Area                                                                                    |
| ---------------- | --------------------------------------------------------------------------------------------- |
| **Part 1** | Implementing Enterprise Data Architecture for data scalability, governance, and optimization  |
| **Part 2** | Applying OLTP to OLAP transformation for healthcare analytics and data-driven decision-making |

---

# Part 1: Implementing Enterprise Data Architecture for data scalability, governance, and optimization

## Objective

Design and develop a structured OLTP database for DigiHealth by creating ER diagrams and identifying key entities and relationships. Apply normalization techniques to optimize data integrity and eliminate redundancy.

---

## Task 1: Design an Entity-Relationship (ER) Diagram for DigiHealth's OLTP System

### Step 1: Determine the Core Entities

Based on the healthcare system requirements, identify the core entities:

| Entity                    | Description                                   | Key Attributes                                                            |
| ------------------------- | --------------------------------------------- | ------------------------------------------------------------------------- |
| **Patients**        | Individuals receiving healthcare services     | Patient ID, Name, DOB, Gender, Contact Info, Address, Insurance Details   |
| **Doctors**         | Medical professionals providing care          | Doctor ID, Name, Specialization, Department, Contact Info, License Number |
| **Appointments**    | Scheduled visits between patients and doctors | Appointment ID, Date, Time, Status, Reason, Notes                         |
| **Medical Records** | Clinical documentation of patient encounters  | Record ID, Diagnosis, Treatment, Prescriptions, Test Results, Date        |
| **Billing**         | Financial transactions for services rendered  | Invoice ID, Amount, Date, Payment Status, Payment Method, Insurance Claim |
| **Departments**     | Hospital organizational units                 | Department ID, Name, Location, Head of Department                         |
| **Prescriptions**   | Medications prescribed to patients            | Prescription ID, Medication, Dosage, Frequency, Duration                  |
| **Medications**     | Pharmaceutical inventory                      | Medication ID, Name, Manufacturer, Strength, Form, Price                  |
| **Insurance**       | Patient insurance information                 | Insurance ID, Provider, Policy Number, Coverage Type, Expiry Date         |
| **Employees**       | Hospital staff (nurses, admin, etc.)          | Employee ID, Name, Role, Department, Contact Info                         |

### Step 2: Establish Relationships Between Entities

| Entity 1                  | Relationship | Entity 2        | Cardinality | Description                                    |
| ------------------------- | ------------ | --------------- | ----------- | ---------------------------------------------- |
| **Patients**        | books        | Appointments    | 1 : N       | One patient can book many appointments         |
| **Doctors**         | conducts     | Appointments    | 1 : N       | One doctor can conduct many appointments       |
| **Appointments**    | generates    | Medical Records | 1 : 1       | One appointment generates one medical record   |
| **Patients**        | has          | Medical Records | 1 : N       | One patient can have many medical records      |
| **Medical Records** | contains     | Prescriptions   | 1 : N       | One medical record can have many prescriptions |
| **Prescriptions**   | references   | Medications     | N : 1       | Many prescriptions reference one medication    |
| **Appointments**    | generates    | Billing         | 1 : 1       | One appointment generates one billing invoice  |
| **Patients**        | has          | Billing         | 1 : N       | One patient can have many billing invoices     |
| **Patients**        | has          | Insurance       | 1 : 1       | One patient has one insurance policy           |
| **Doctors**         | belongs to   | Departments     | N : 1       | Many doctors belong to one department          |
| **Departments**     | has          | Employees       | 1 : N       | One department has many employees              |

### Step 3: Define Attributes for Each Entity

#### Patients Table

| Attribute             | Data Type    | Description                  |
| --------------------- | ------------ | ---------------------------- |
| PatientID             | INT (PK)     | Unique patient identifier    |
| FirstName             | VARCHAR(50)  | Patient's first name         |
| LastName              | VARCHAR(50)  | Patient's last name          |
| DateOfBirth           | DATE         | Patient's birth date         |
| Gender                | ENUM         | Male, Female, Other          |
| Phone                 | VARCHAR(20)  | Contact number               |
| Email                 | VARCHAR(100) | Email address                |
| Address               | TEXT         | Physical address             |
| EmergencyContactName  | VARCHAR(100) | Emergency contact person     |
| EmergencyContactPhone | VARCHAR(20)  | Emergency contact number     |
| InsuranceID           | INT (FK)     | Reference to Insurance table |
| RegistrationDate      | DATE         | Date of registration         |
| Status                | ENUM         | Active, Inactive, Deceased   |

#### Doctors Table

| Attribute      | Data Type    | Description                  |
| -------------- | ------------ | ---------------------------- |
| DoctorID       | INT (PK)     | Unique doctor identifier     |
| FirstName      | VARCHAR(50)  | Doctor's first name          |
| LastName       | VARCHAR(50)  | Doctor's last name           |
| Specialization | VARCHAR(100) | Medical specialty            |
| DepartmentID   | INT (FK)     | Reference to Department      |
| Phone          | VARCHAR(20)  | Contact number               |
| Email          | VARCHAR(100) | Email address                |
| LicenseNumber  | VARCHAR(50)  | Medical license number       |
| HireDate       | DATE         | Date hired                   |
| Status         | ENUM         | Active, On Leave, Terminated |

#### Appointments Table

| Attribute       | Data Type | Description                              |
| --------------- | --------- | ---------------------------------------- |
| AppointmentID   | INT (PK)  | Unique appointment identifier            |
| PatientID       | INT (FK)  | Reference to Patient                     |
| DoctorID        | INT (FK)  | Reference to Doctor                      |
| AppointmentDate | DATE      | Date of appointment                      |
| AppointmentTime | TIME      | Time of appointment                      |
| Duration        | INT       | Duration in minutes                      |
| Status          | ENUM      | Scheduled, Completed, Cancelled, No-Show |
| Reason          | TEXT      | Reason for visit                         |
| Notes           | TEXT      | Additional notes                         |

#### Medical Records Table

| Attribute     | Data Type | Description                |
| ------------- | --------- | -------------------------- |
| RecordID      | INT (PK)  | Unique record identifier   |
| PatientID     | INT (FK)  | Reference to Patient       |
| DoctorID      | INT (FK)  | Reference to Doctor        |
| AppointmentID | INT (FK)  | Reference to Appointment   |
| Diagnosis     | TEXT      | Medical diagnosis          |
| Treatment     | TEXT      | Treatment provided         |
| Notes         | TEXT      | Clinical notes             |
| RecordDate    | DATE      | Date of record             |
| FollowUpDate  | DATE      | Recommended follow-up date |

#### Prescriptions Table

| Attribute      | Data Type    | Description                    |
| -------------- | ------------ | ------------------------------ |
| PrescriptionID | INT (PK)     | Unique prescription identifier |
| RecordID       | INT (FK)     | Reference to Medical Record    |
| MedicationID   | INT (FK)     | Reference to Medication        |
| Dosage         | VARCHAR(50)  | Dosage instructions            |
| Frequency      | VARCHAR(100) | How often to take              |
| Duration       | INT          | Duration in days               |
| Instructions   | TEXT         | Special instructions           |
| PrescribedDate | DATE         | Date prescribed                |
| Refills        | INT          | Number of refills allowed      |

#### Medications Table

| Attribute            | Data Type     | Description                   |
| -------------------- | ------------- | ----------------------------- |
| MedicationID         | INT (PK)      | Unique medication identifier  |
| MedicationName       | VARCHAR(100)  | Brand name                    |
| GenericName          | VARCHAR(100)  | Generic name                  |
| Manufacturer         | VARCHAR(100)  | Manufacturer                  |
| Strength             | VARCHAR(50)   | Dosage strength               |
| Form                 | VARCHAR(50)   | Tablet, capsule, liquid       |
| UnitPrice            | DECIMAL(10,2) | Price per unit                |
| RequiresPrescription | BOOLEAN       | Whether prescription required |

#### Billing Table

| Attribute     | Data Type     | Description                          |
| ------------- | ------------- | ------------------------------------ |
| InvoiceID     | INT (PK)      | Unique invoice identifier            |
| PatientID     | INT (FK)      | Reference to Patient                 |
| AppointmentID | INT (FK)      | Reference to Appointment             |
| InvoiceNumber | VARCHAR(50)   | Invoice number                       |
| InvoiceDate   | DATE          | Date of invoice                      |
| DueDate       | DATE          | Payment due date                     |
| Subtotal      | DECIMAL(10,2) | Amount before tax                    |
| Tax           | DECIMAL(10,2) | Tax amount                           |
| Discount      | DECIMAL(10,2) | Discount amount                      |
| TotalAmount   | DECIMAL(10,2) | Total amount due                     |
| PaidAmount    | DECIMAL(10,2) | Amount paid                          |
| Status        | ENUM          | Pending, Partial, Paid, Overdue      |
| PaymentMethod | ENUM          | Cash, Card, Insurance, Bank Transfer |
| PaymentDate   | DATE          | Date of payment                      |

#### Departments Table

| Attribute      | Data Type    | Description                  |
| -------------- | ------------ | ---------------------------- |
| DepartmentID   | INT (PK)     | Unique department identifier |
| DepartmentName | VARCHAR(100) | Department name              |
| Location       | VARCHAR(100) | Physical location            |
| HeadDoctorID   | INT (FK)     | Reference to Doctor (Head)   |

#### Insurance Table

| Attribute       | Data Type    | Description                 |
| --------------- | ------------ | --------------------------- |
| InsuranceID     | INT (PK)     | Unique insurance identifier |
| Provider        | VARCHAR(100) | Insurance provider name     |
| PolicyNumber    | VARCHAR(50)  | Policy number               |
| CoverageType    | VARCHAR(50)  | Type of coverage            |
| CoverageDetails | TEXT         | Details of coverage         |
| ExpiryDate      | DATE         | Policy expiry date          |

#### Employees Table (Non-Doctor Staff)

| Attribute    | Data Type    | Description                      |
| ------------ | ------------ | -------------------------------- |
| EmployeeID   | INT (PK)     | Unique employee identifier       |
| FirstName    | VARCHAR(50)  | Employee first name              |
| LastName     | VARCHAR(50)  | Employee last name               |
| Role         | VARCHAR(50)  | Nurse, Admin, Receptionist, etc. |
| DepartmentID | INT (FK)     | Reference to Department          |
| Phone        | VARCHAR(20)  | Contact number                   |
| Email        | VARCHAR(100) | Email address                    |
| HireDate     | DATE         | Date hired                       |
| Status       | ENUM         | Active, On Leave, Terminated     |

### Step 4: Apply Normalization Techniques

#### First Normal Form (1NF)

- All tables have a primary key
- All attributes contain atomic (indivisible) values
- No repeating groups

**Example Check:**

- ✅ Patient table has PatientID as PK, no repeating groups
- ✅ Phone numbers stored as single values, not lists
- ✅ Address stored as single text field (could be further normalized)

#### Second Normal Form (2NF)

- Already in 1NF
- All non-key attributes fully dependent on the entire primary key
- No partial dependencies (relevant for tables with composite keys)

**Example Check:**

- Prescriptions table: PrescriptionID is PK, all attributes depend on PrescriptionID
- MedicalRecords table: RecordID is PK, all attributes depend on RecordID

#### Third Normal Form (3NF)

- Already in 2NF
- No transitive dependencies (non-key attributes not dependent on other non-key attributes)

**Example Check:**

- ✅ Patients table: InsuranceID is FK, not storing insurance details in Patients
- ✅ Appointments table: Stores only appointment-specific data, patient details in Patients table

### Step 5: Create Visual ERD

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                      DIGIHEALTH OLTP DATABASE - ENTITY RELATIONSHIP DIAGRAM          │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                       │
│  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      ┌──────────────┐ │
│  │  Insurance   │      │   Patients   │      │ Appointments  │      │   Billing    │ │
│  ├──────────────┤      ├──────────────┤      ├──────────────┤      ├──────────────┤ │
│  │PK InsuranceID│◄─────┤FK InsuranceID│      │PK Appointment│      │PK InvoiceID  │ │
│  │ Provider     │      │PK PatientID  │──────│FK PatientID  │◄─────┤FK PatientID  │ │
│  │ PolicyNumber │      │ FirstName    │      │FK DoctorID   │      │FK Appointment│ │
│  │ CoverageType │      │ LastName     │      │ApptDate      │      │ TotalAmount  │ │
│  │ ExpiryDate   │      │ DOB          │      │ApptTime      │      │ Status       │ │
│  └──────────────┘      │ Gender       │      │ Status       │      │ PaymentDate  │ │
│                        │ Phone        │      │ Reason       │      └──────────────┘ │
│                        │ Email        │      └──────┬───────┘                       │
│                        │ Address      │             │                               │
│                        └───────┬──────┘             │                               │
│                                │                    │                               │
│                                │                    │                               │
│                        ┌───────▼──────┐      ┌──────▼───────┐      ┌──────────────┐ │
│                        │MedicalRecords│      │   Doctors    │      │ Departments  │ │
│                        ├──────────────┤      ├──────────────┤      ├──────────────┤ │
│                        │PK RecordID   │      │PK DoctorID   │──────│PK Department │ │
│                        │FK PatientID  │──────┤ FirstName    │      │ DeptName     │ │
│                        │FK DoctorID   │      │ LastName     │      │ Location     │ │
│                        │FK Appointment│      │ Specialization│      │ HeadDoctorID │ │
│                        │ Diagnosis    │      │ DepartmentID │──────┘               │ │
│                        │ Treatment    │      │ LicenseNumber│      ┌──────────────┐ │
│                        │ RecordDate   │      │ HireDate     │      │  Employees   │ │
│                        └───────┬──────┘      │ Status       │      ├──────────────┤ │
│                                │              └──────────────┘      │PK EmployeeID │ │
│                                │                                    │ FirstName    │ │
│                        ┌───────▼──────┐      ┌──────────────┐      │ LastName     │ │
│                        │Prescriptions │      │ Medications  │      │ Role         │ │
│                        ├──────────────┤      ├──────────────┤      │ DepartmentID │──┘
│                        │PK PrescriptID│      │PK Medication │      │ HireDate     │ │
│                        │FK RecordID   │──────│ MedicationName│      │ Status       │ │
│                        │FK Medication │      │ Manufacturer │      └──────────────┘ │
│                        │ Dosage       │      │ Strength     │                        │
│                        │ Frequency    │      │ UnitPrice    │                        │
│                        │ Duration     │      │ RequiresRx   │                        │
│                        │ PrescribedDate│     └──────────────┘                        │
│                        └──────────────┘                                              │
│                                                                                       │
│  ┌───────────────────────────────────────────────────────────────────────────────┐   │
│  │                              LEGEND                                             │   │
│  │  ──── = One-to-Many      ──── = One-to-One      PK = Primary Key              │   │
│  │  FK = Foreign Key        ──── = Many-to-One                                    │   │
│  └───────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                       │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

### Step 6: Create Normalized Table Definitions (3NF)

```sql
-- Create DigiHealth OLTP Database
CREATE DATABASE IF NOT EXISTS DigiHealth_OLTP;
USE DigiHealth_OLTP;

-- 1. Insurance table
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    Provider VARCHAR(100) NOT NULL,
    PolicyNumber VARCHAR(50) UNIQUE NOT NULL,
    CoverageType VARCHAR(50),
    CoverageDetails TEXT,
    ExpiryDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Address TEXT,
    EmergencyContactName VARCHAR(100),
    EmergencyContactPhone VARCHAR(20),
    InsuranceID INT,
    RegistrationDate DATE NOT NULL,
    Status ENUM('Active', 'Inactive', 'Deceased') DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID)
);

-- 3. Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) UNIQUE NOT NULL,
    Location VARCHAR(100),
    HeadDoctorID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Doctors table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    DepartmentID INT,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE,
    HireDate DATE NOT NULL,
    Status ENUM('Active', 'On Leave', 'Terminated') DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Update Departments with HeadDoctorID foreign key
ALTER TABLE Departments 
ADD CONSTRAINT fk_head_doctor 
FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID);

-- 5. Employees table (non-doctor staff)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL,
    Status ENUM('Active', 'On Leave', 'Terminated') DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 6. Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Duration INT DEFAULT 30,
    Status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'Scheduled',
    Reason TEXT,
    Notes TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    INDEX idx_appointment_date (AppointmentDate),
    INDEX idx_status (Status)
);

-- 7. Medications table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    Strength VARCHAR(50),
    Form VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    RequiresPrescription BOOLEAN DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_medication_name (MedicationName)
);

-- 8. MedicalRecords table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentID INT,
    Diagnosis TEXT NOT NULL,
    Treatment TEXT,
    Notes TEXT,
    RecordDate DATE NOT NULL,
    FollowUpDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    INDEX idx_patient_date (PatientID, RecordDate)
);

-- 9. Prescriptions table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    RecordID INT NOT NULL,
    MedicationID INT NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Frequency VARCHAR(100) NOT NULL,
    Duration INT,
    Instructions TEXT,
    PrescribedDate DATE NOT NULL,
    Refills INT DEFAULT 0,
    Dispensed BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RecordID) REFERENCES MedicalRecords(RecordID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID),
    INDEX idx_prescribed_date (PrescribedDate)
);

-- 10. Billing table
CREATE TABLE Billing (
    InvoiceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    AppointmentID INT,
    InvoiceNumber VARCHAR(50) UNIQUE NOT NULL,
    InvoiceDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Tax DECIMAL(10,2) DEFAULT 0,
    Discount DECIMAL(10,2) DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaidAmount DECIMAL(10,2) DEFAULT 0,
    Status ENUM('Pending', 'Partial', 'Paid', 'Overdue', 'Cancelled') DEFAULT 'Pending',
    PaymentMethod ENUM('Cash', 'Credit Card', 'Debit Card', 'Insurance', 'Bank Transfer'),
    PaymentDate DATE,
    InsuranceClaimID VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    INDEX idx_invoice_date (InvoiceDate),
    INDEX idx_status (Status)
);
```

---

# Part 2: Applying OLTP to OLAP Transformation for Healthcare Analytics and Data-Driven Decision-Making

## Objective

Design and implement a scalable data architecture for DigiHealth by developing a structured OLTP database in MySQL for real-time transactions and transitioning to an OLAP data warehouse in PostgreSQL. Define relational schemas, create Fact and Dimension Tables, and apply data modeling techniques to support advanced healthcare analytics.

---

## Task 1: Designing the OLTP Schema (Transactional Database in MySQL)

### Step 1: Develop INSERT Scripts for OLTP Database

```sql
-- Use the database
USE DigiHealth_OLTP;

-- Insert sample data into Departments
INSERT INTO Departments (DepartmentName, Location) VALUES
('Cardiology', 'Building A, Floor 2'),
('Pediatrics', 'Building B, Floor 1'),
('Emergency', 'Building A, Floor 1'),
('Radiology', 'Building C, Floor 3'),
('Oncology', 'Building B, Floor 4'),
('Administration', 'Building A, Floor 5');

-- Insert sample data into Insurance
INSERT INTO Insurance (Provider, PolicyNumber, CoverageType, CoverageDetails, ExpiryDate) VALUES
('Blue Cross', 'BC-12345-USA', 'Comprehensive', 'Covers hospitalization, prescriptions, and preventive care', '2025-12-31'),
('Aetna', 'AE-78901-USA', 'Basic', 'Covers hospitalization only', '2024-06-30'),
('Cigna', 'CG-45678-USA', 'Premium', 'Full coverage including dental and vision', '2025-03-15'),
('UnitedHealth', 'UH-98765-USA', 'Family', 'Family coverage for employee and dependents', '2024-09-30'),
('Medicare', 'MD-54321-USA', 'Senior', 'Coverage for patients over 65', '2025-01-01');

-- Insert sample data into Patients
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address, EmergencyContactName, EmergencyContactPhone, InsuranceID, RegistrationDate) VALUES
('John', 'Smith', '1985-05-15', 'Male', '555-123-4567', 'john.smith@email.com', '123 Main St, Anytown, USA', 'Jane Smith', '555-987-6543', 1, '2023-01-10'),
('Maria', 'Garcia', '1990-08-22', 'Female', '555-234-5678', 'maria.g@email.com', '456 Oak Ave, Somewhere, USA', 'Carlos Garcia', '555-876-5432', 2, '2023-02-15'),
('Robert', 'Johnson', '1978-11-30', 'Male', '555-345-6789', 'robert.j@email.com', '789 Pine Rd, Elsewhere, USA', 'Susan Johnson', '555-765-4321', 3, '2023-03-20'),
('Emily', 'Brown', '1995-03-12', 'Female', '555-456-7890', 'emily.b@email.com', '321 Elm St, Nowhere, USA', 'Michael Brown', '555-654-3210', 4, '2023-04-05'),
('David', 'Wilson', '1982-07-19', 'Male', '555-567-8901', 'david.w@email.com', '654 Maple Dr, Anywhere, USA', 'Sarah Wilson', '555-543-2109', 5, '2023-05-12'),
('Sarah', 'Martinez', '1988-09-25', 'Female', '555-678-9012', 'sarah.m@email.com', '987 Cedar Ln, Someplace, USA', 'James Martinez', '555-432-1098', NULL, '2023-06-18'),
('Michael', 'Lee', '1975-12-03', 'Male', '555-789-0123', 'michael.lee@email.com', '147 Birch St, Othertown, USA', 'Jennifer Lee', '555-321-0987', 1, '2023-07-22');

-- Insert sample data into Doctors
INSERT INTO Doctors (FirstName, LastName, Specialization, DepartmentID, Phone, Email, LicenseNumber, HireDate) VALUES
('James', 'Wilson', 'Interventional Cardiology', 1, '555-111-2222', 'dr.wilson@digihealth.com', 'MD12345', '2018-06-01'),
('Lisa', 'Chen', 'Pediatric Medicine', 2, '555-222-3333', 'dr.chen@digihealth.com', 'MD23456', '2019-03-15'),
('Robert', 'Miller', 'Emergency Medicine', 3, '555-333-4444', 'dr.miller@digihealth.com', 'MD34567', '2017-01-10'),
('Patricia', 'Davis', 'Cardiology', 1, '555-444-5555', 'dr.davis@digihealth.com', 'MD45678', '2020-02-20'),
('Thomas', 'Anderson', 'Radiology', 4, '555-555-6666', 'dr.anderson@digihealth.com', 'MD56789', '2019-08-10');

-- Update Departments with HeadDoctorID
UPDATE Departments SET HeadDoctorID = 1 WHERE DepartmentID = 1; -- Cardiology
UPDATE Departments SET HeadDoctorID = 2 WHERE DepartmentID = 2; -- Pediatrics
UPDATE Departments SET HeadDoctorID = 3 WHERE DepartmentID = 3; -- Emergency

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, Role, DepartmentID, Phone, Email, HireDate) VALUES
('Jennifer', 'Martinez', 'Administrator', 6, '555-666-7777', 'admin.martinez@digihealth.com', '2016-11-05'),
('Christopher', 'Brown', 'Receptionist', 6, '555-777-8888', 'reception.brown@digihealth.com', '2021-04-12'),
('Amanda', 'Garcia', 'Nurse', 1, '555-888-9999', 'nurse.garcia@digihealth.com', '2020-09-01'),
('Kevin', 'Jones', 'Nurse', 3, '555-999-0000', 'nurse.jones@digihealth.com', '2021-01-15');

-- Insert sample data into Medications
INSERT INTO Medications (MedicationName, GenericName, Manufacturer, Strength, Form, UnitPrice, RequiresPrescription) VALUES
('Lisinopril', 'Lisinopril', 'Pfizer', '10mg', 'Tablet', 0.50, TRUE),
('Metformin', 'Metformin HCl', 'Merck', '500mg', 'Tablet', 0.30, TRUE),
('Atorvastatin', 'Atorvastatin', 'AstraZeneca', '20mg', 'Tablet', 0.75, TRUE),
('Amoxicillin', 'Amoxicillin', 'GSK', '500mg', 'Capsule', 1.20, TRUE),
('Ibuprofen', 'Ibuprofen', 'Johnson & Johnson', '400mg', 'Tablet', 0.15, FALSE),
('Acetaminophen', 'Acetaminophen', 'Tylenol', '500mg', 'Tablet', 0.10, FALSE),
('Albuterol', 'Albuterol', 'GSK', '90mcg', 'Inhaler', 25.00, TRUE);

-- Insert sample data into Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status, Reason, Notes) VALUES
(1, 1, '2024-01-15', '09:00:00', 'Completed', 'Annual checkup', 'Patient in good health'),
(2, 2, '2024-01-15', '10:30:00', 'Completed', 'Child wellness visit', 'Vaccinations due'),
(3, 3, '2024-01-16', '14:00:00', 'Completed', 'Chest pain', 'EKG ordered'),
(1, 1, '2024-02-15', '09:30:00', 'Scheduled', 'Follow-up', 'Review lab results'),
(4, 1, '2024-02-16', '11:00:00', 'Scheduled', 'Palpitations', 'New patient consult'),
(5, 3, '2024-02-17', '15:30:00', 'Scheduled', 'Injury', 'Sprained ankle'),
(6, 2, '2024-01-20', '09:00:00', 'Completed', 'Fever', 'Upper respiratory infection'),
(7, 1, '2024-01-22', '14:00:00', 'Completed', 'Hypertension follow-up', 'BP well controlled');

-- Insert sample data into MedicalRecords
INSERT INTO MedicalRecords (PatientID, DoctorID, AppointmentID, Diagnosis, Treatment, Notes, RecordDate, FollowUpDate) VALUES
(1, 1, 1, 'Essential hypertension', 'Continue Lisinopril 10mg daily', 'BP 128/82, stable', '2024-01-15', '2024-07-15'),
(2, 2, 2, 'Well child visit', 'Routine vaccinations administered', 'Growth appropriate for age', '2024-01-15', '2025-01-15'),
(3, 3, 3, 'Gastroesophageal reflux', 'Prescribed Omeprazole 20mg daily', 'Symptoms improving', '2024-01-16', '2024-04-16'),
(6, 2, 7, 'Acute bronchitis', 'Prescribed Amoxicillin 500mg TID for 10 days', 'Chest congestion, productive cough', '2024-01-20', '2024-01-30'),
(7, 1, 8, 'Hyperlipidemia', 'Continue Atorvastatin 20mg', 'Cholesterol improving', '2024-01-22', '2024-07-22');

-- Insert sample data into Prescriptions
INSERT INTO Prescriptions (RecordID, MedicationID, Dosage, Frequency, Duration, Instructions, PrescribedDate, Refills) VALUES
(1, 1, '1 tablet', 'Once daily', 90, 'Take with food', '2024-01-15', 3),
(3, 5, '1 tablet', 'As needed', 30, 'Take for chest pain', '2024-01-16', 0),
(4, 4, '1 capsule', 'Three times daily', 10, 'Take with food, complete full course', '2024-01-20', 0),
(5, 3, '1 tablet', 'Once daily', 90, 'Take in evening', '2024-01-22', 3);

-- Insert sample data into Billing
INSERT INTO Billing (PatientID, AppointmentID, InvoiceNumber, InvoiceDate, DueDate, Subtotal, Tax, TotalAmount, PaidAmount, Status, PaymentMethod, PaymentDate) VALUES
(1, 1, 'INV-2024-001', '2024-01-15', '2024-01-30', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Credit Card', '2024-01-15'),
(2, 2, 'INV-2024-002', '2024-01-15', '2024-01-30', 200.00, 16.00, 216.00, 216.00, 'Paid', 'Insurance', '2024-01-16'),
(3, 3, 'INV-2024-003', '2024-01-16', '2024-01-31', 300.00, 24.00, 324.00, 100.00, 'Partial', 'Cash', '2024-01-16'),
(6, 7, 'INV-2024-004', '2024-01-20', '2024-02-04', 180.00, 14.40, 194.40, 0.00, 'Pending', NULL, NULL),
(7, 8, 'INV-2024-005', '2024-01-22', '2024-02-06', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Debit Card', '2024-01-22');
```

---

## Task 2: Designing the OLAP Schema & Data Warehouse (Analytical Model in PostgreSQL)

### Step 1: Choose and Implement Data Warehouse Schema

For DigiHealth, we'll implement a **Star Schema** which offers:

- Simpler structure with fewer joins
- Faster query performance for analytics
- Easier understanding for business users

### Step 2: Create Dimension Tables

```sql
-- Create PostgreSQL Data Warehouse
CREATE DATABASE DigiHealth_OLAP;
\c DigiHealth_OLAP;

-- 1. DimDate - Time dimension
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

-- 2. DimPatient - Patient dimension
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
    IsActive BOOLEAN
);

-- 3. DimDoctor - Doctor dimension
CREATE TABLE DimDoctor (
    DoctorKey SERIAL PRIMARY KEY,
    DoctorID INT NOT NULL,
    FullName VARCHAR(101) NOT NULL,
    Specialization VARCHAR(100),
    Department VARCHAR(100),
    HireDate DATE,
    IsActive BOOLEAN
);

-- 4. DimDepartment - Department dimension
CREATE TABLE DimDepartment (
    DepartmentKey SERIAL PRIMARY KEY,
    DepartmentID INT NOT NULL,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    HeadDoctor VARCHAR(101)
);

-- 5. DimMedication - Medication dimension
CREATE TABLE DimMedication (
    MedicationKey SERIAL PRIMARY KEY,
    MedicationID INT NOT NULL,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    Strength VARCHAR(50),
    Form VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    RequiresPrescription BOOLEAN
);

-- 6. DimPaymentMethod - Payment method dimension
CREATE TABLE DimPaymentMethod (
    PaymentMethodKey SERIAL PRIMARY KEY,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentCategory VARCHAR(50)
);
```

### Step 3: Create Fact Tables

```sql
-- 7. FactAppointment - Appointment facts
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
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (DoctorKey) REFERENCES DimDoctor(DoctorKey),
    FOREIGN KEY (DepartmentKey) REFERENCES DimDepartment(DepartmentKey)
);

-- 8. FactBilling - Billing facts
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
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (AppointmentKey) REFERENCES FactAppointment(AppointmentKey),
    FOREIGN KEY (PaymentMethodKey) REFERENCES DimPaymentMethod(PaymentMethodKey)
);

-- 9. FactPrescription - Prescription facts
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
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (DoctorKey) REFERENCES DimDoctor(DoctorKey),
    FOREIGN KEY (MedicationKey) REFERENCES DimMedication(MedicationKey)
);

-- 10. FactDailyAggregates - Pre-aggregated daily metrics
CREATE TABLE FactDailyAggregates (
    AggregateKey SERIAL PRIMARY KEY,
    DateKey INT NOT NULL,
    TotalAppointments INT,
    CompletedAppointments INT,
    CancelledAppointments INT,
    TotalBillingAmount DECIMAL(15,2),
    TotalPayments DECIMAL(15,2),
    OutstandingAmount DECIMAL(15,2),
    TotalPrescriptions INT,
    UniquePatients INT,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);
```

### Step 4: Populate Dimension Tables (INSERT Scripts)

```sql
-- Populate DimDate (2020-2025)
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

-- Populate DimPaymentMethod
INSERT INTO DimPaymentMethod (PaymentMethod, PaymentCategory) VALUES
('Cash', 'Physical'),
('Credit Card', 'Card'),
('Debit Card', 'Card'),
('Insurance', 'Insurance'),
('Bank Transfer', 'Digital');

-- Populate DimPatient (ETL from MySQL)
INSERT INTO DimPatient (PatientID, FullName, Age, AgeGroup, Gender, InsuranceProvider, InsuranceType, RegistrationDate, IsActive)
SELECT 
    p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName),
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.DateOfBirth)),
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.DateOfBirth)) < 18 THEN 'Child'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.DateOfBirth)) BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.DateOfBirth)) BETWEEN 36 AND 50 THEN 'Middle Age'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.DateOfBirth)) BETWEEN 51 AND 65 THEN 'Senior'
        ELSE 'Elderly'
    END,
    p.Gender,
    i.Provider,
    i.CoverageType,
    p.RegistrationDate,
    CASE WHEN p.Status = 'Active' THEN TRUE ELSE FALSE END
FROM patients p
LEFT JOIN insurance i ON p.InsuranceID = i.InsuranceID;

-- Populate DimDoctor
INSERT INTO DimDoctor (DoctorID, FullName, Specialization, Department, HireDate, IsActive)
SELECT 
    d.DoctorID,
    CONCAT(d.FirstName, ' ', d.LastName),
    d.Specialization,
    dept.DepartmentName,
    d.HireDate,
    CASE WHEN d.Status = 'Active' THEN TRUE ELSE FALSE END
FROM doctors d
JOIN departments dept ON d.DepartmentID = dept.DepartmentID;

-- Populate DimDepartment
INSERT INTO DimDepartment (DepartmentID, DepartmentName, Location, HeadDoctor)
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    d.Location,
    CONCAT(doc.FirstName, ' ', doc.LastName)
FROM departments d
LEFT JOIN doctors doc ON d.HeadDoctorID = doc.DoctorID;

-- Populate DimMedication
INSERT INTO DimMedication (MedicationID, MedicationName, GenericName, Manufacturer, Strength, Form, UnitPrice, RequiresPrescription)
SELECT 
    MedicationID,
    MedicationName,
    GenericName,
    Manufacturer,
    Strength,
    Form,
    UnitPrice,
    RequiresPrescription
FROM medications;
```

### Step 5: Populate Fact Tables (INSERT Scripts)

```sql
-- Populate FactAppointment
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
    IsCancelled
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
    CASE WHEN a.Status = 'Cancelled' THEN TRUE ELSE FALSE END
FROM appointments a
JOIN dimpatient dp ON a.PatientID = dp.PatientID
JOIN dimdoctor dd ON a.DoctorID = dd.DoctorID
JOIN dimdepartment dde ON dd.Department = dde.DepartmentName;

-- Populate FactBilling
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
FROM billing b
JOIN dimpatient dp ON b.PatientID = dp.PatientID
LEFT JOIN factappointment fa ON b.AppointmentID = fa.AppointmentID
LEFT JOIN dimpaymentmethod pm ON b.PaymentMethod = pm.PaymentMethod;

-- Populate FactPrescription
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
FROM prescriptions p
JOIN medicalrecords mr ON p.RecordID = mr.RecordID
JOIN dimpatient dp ON mr.PatientID = dp.PatientID
JOIN dimdoctor dd ON mr.DoctorID = dd.DoctorID
JOIN dimmedication dm ON p.MedicationID = dm.MedicationID;

-- Populate FactDailyAggregates
INSERT INTO FactDailyAggregates (
    DateKey,
    TotalAppointments,
    CompletedAppointments,
    CancelledAppointments,
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
    SUM(fb.TotalAmount) as TotalBillingAmount,
    SUM(fb.PaidAmount) as TotalPayments,
    SUM(fb.OutstandingAmount) as OutstandingAmount,
    COUNT(DISTINCT fp.PrescriptionKey) as TotalPrescriptions,
    COUNT(DISTINCT fa.PatientKey) as UniquePatients
FROM factappointment fa
LEFT JOIN factbilling fb ON fa.DateKey = fb.DateKey AND fa.PatientKey = fb.PatientKey
LEFT JOIN factprescription fp ON fa.DateKey = fp.DateKey AND fa.PatientKey = fp.PatientKey
GROUP BY fa.DateKey;
```

---

## Task 3: Data Warehouse Implementation Report

### Data Warehouse Implementation Report

#### 1. Overview

| Project                | DigiHealth Healthcare Analytics Data Warehouse                 |
| ---------------------- | -------------------------------------------------------------- |
| **Platform**     | PostgreSQL 13+                                                 |
| **Schema Type**  | Star Schema                                                    |
| **Purpose**      | Enable advanced healthcare analytics and business intelligence |
| **ETL Strategy** | Batch ETL (daily) with initial historical load                 |

#### 2. Dimensional Model Summary

| Dimension Type                     | Table Name       | Description                            | Rows  |
| ---------------------------------- | ---------------- | -------------------------------------- | ----- |
| **Time Dimension**           | DimDate          | Date hierarchy for time-based analysis | 2,191 |
| **Patient Dimension**        | DimPatient       | Patient demographics and attributes    | 7     |
| **Doctor Dimension**         | DimDoctor        | Doctor profiles and specialties        | 5     |
| **Department Dimension**     | DimDepartment    | Department information                 | 6     |
| **Medication Dimension**     | DimMedication    | Medication catalog                     | 7     |
| **Payment Method Dimension** | DimPaymentMethod | Payment types                          | 5     |

| Fact Table                    | Description              | Measures          | Rows   |
| ----------------------------- | ------------------------ | ----------------- | ------ |
| **FactAppointment**     | Appointment transactions | Count, duration   | 8      |
| **FactBilling**         | Financial transactions   | Amount, tax, paid | 5      |
| **FactPrescription**    | Prescription facts       | Quantity, cost    | 4      |
| **FactDailyAggregates** | Daily summary metrics    | All measures      | Varies |

#### 3. ETL Pipeline Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         ETL PIPELINE: OLTP → OLAP                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│  ┌─────────────────┐                                                             │
│  │   MySQL OLTP    │                                                             │
│  │   DigiHealth    │                                                             │
│  └────────┬────────┘                                                             │
│           │                                                                       │
│           ▼                                                                       │
│  ┌─────────────────┐    ┌─────────────────────────────────────────────────────┐ │
│  │  Extract Data   │    │  Transformations:                                    │ │
│  │  • Patients     │───►│  • Age calculation                                   │ │
│  │  • Doctors      │    │  • Age group categorization                          │ │
│  │  • Appointments │    │  • Date key generation                               │ │
│  │  • Billing      │    │  • Status flags (IsCompleted, IsPaid)               │ │
│  │  • Prescriptions│    │  • Denormalization                                   │ │
│  └─────────────────┘    │  • Aggregate calculations                            │ │
│           │             └─────────────────────────────────────────────────────┘ │
│           ▼                                                                       │
│  ┌─────────────────┐                                                             │
│  │   Load to       │                                                             │
│  │   PostgreSQL    │                                                             │
│  │   Data Warehouse│                                                             │
│  └────────┬────────┘                                                             │
│           │                                                                       │
│           ▼                                                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                     Data Warehouse Layers                                 │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │   │
│  │  │ Dimension    │  │ Dimension    │  │   Fact       │  │ Aggregated    │  │   │
│  │  │ Tables       │──│ Tables       │──│   Tables     │──│ Tables        │  │   │
│  │  │ (Static)     │  │ (Static)     │  │ (Growing)    │  │ (Pre-summarized)│  │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         BI & Analytics Layer                               │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │   │
│  │  │ Power BI     │  │ Tableau      │  │ Custom SQL   │  │ Python       │  │   │
│  │  │ Dashboards   │  │ Reports      │  │ Queries      │  │ Analytics    │  │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

#### 4. Sample Analytical Queries

```sql
-- Query 1: Monthly appointment trends by department
SELECT 
    d.Year,
    d.MonthName,
    dept.DepartmentName,
    COUNT(*) as AppointmentCount,
    AVG(fa.Duration) as AvgDuration
FROM factappointment fa
JOIN dimdate d ON fa.DateKey = d.DateKey
JOIN dimdepartment dept ON fa.DepartmentKey = dept.DepartmentKey
GROUP BY d.Year, d.MonthName, dept.DepartmentName
ORDER BY d.Year, d.Month, AppointmentCount DESC;

-- Query 2: Revenue analysis by patient age group
SELECT 
    p.AgeGroup,
    COUNT(DISTINCT fb.PatientKey) as PatientCount,
    SUM(fb.TotalAmount) as TotalRevenue,
    AVG(fb.TotalAmount) as AvgRevenuePerPatient,
    SUM(fb.OutstandingAmount) as TotalOutstanding
FROM factbilling fb
JOIN dimpatient p ON fb.PatientKey = p.PatientKey
WHERE fb.DateKey BETWEEN 20240101 AND 20241231
GROUP BY p.AgeGroup
ORDER BY TotalRevenue DESC;

-- Query 3: Top prescribed medications by doctor specialty
SELECT 
    d.Specialization,
    m.MedicationName,
    COUNT(*) as PrescriptionCount,
    SUM(fp.TotalCost) as TotalCost
FROM factprescription fp
JOIN dimdoctor d ON fp.DoctorKey = d.DoctorKey
JOIN dimmedication m ON fp.MedicationKey = m.MedicationKey
GROUP BY d.Specialization, m.MedicationName
ORDER BY PrescriptionCount DESC
LIMIT 10;

-- Query 4: Payment collection efficiency over time
SELECT 
    d.Year,
    d.Quarter,
    SUM(fb.TotalAmount) as BilledAmount,
    SUM(fb.PaidAmount) as CollectedAmount,
    (SUM(fb.PaidAmount) / NULLIF(SUM(fb.TotalAmount), 0)) * 100 as CollectionRate,
    AVG(fb.DaysToPayment) as AvgDaysToPayment
FROM factbilling fb
JOIN dimdate d ON fb.DateKey = d.DateKey
GROUP BY d.Year, d.Quarter
ORDER BY d.Year, d.Quarter;

-- Query 5: Doctor workload analysis
SELECT 
    d.FullName as DoctorName,
    d.Specialization,
    COUNT(fa.AppointmentKey) as TotalAppointments,
    SUM(CASE WHEN fa.IsCompleted THEN 1 ELSE 0 END) as CompletedAppointments,
    AVG(fa.Duration) as AvgAppointmentDuration
FROM factappointment fa
JOIN dimdoctor d ON fa.DoctorKey = d.DoctorKey
WHERE fa.DateKey BETWEEN 20240101 AND 20241231
GROUP BY d.FullName, d.Specialization
ORDER BY TotalAppointments DESC;
```

#### 5. Performance Optimization

```sql
-- Create indexes for query performance
CREATE INDEX idx_factappointment_date ON factappointment(DateKey);
CREATE INDEX idx_factappointment_patient ON factappointment(PatientKey);
CREATE INDEX idx_factappointment_doctor ON factappointment(DoctorKey);
CREATE INDEX idx_factbilling_date ON factbilling(DateKey);
CREATE INDEX idx_factbilling_patient ON factbilling(PatientKey);
CREATE INDEX idx_factprescription_date ON factprescription(DateKey);
CREATE INDEX idx_factprescription_doctor ON factprescription(DoctorKey);
CREATE INDEX idx_factprescription_medication ON factprescription(MedicationKey);

-- Create materialized views for common aggregations
CREATE MATERIALIZED VIEW mv_monthly_department_stats AS
SELECT 
    d.Year,
    d.Month,
    dept.DepartmentName,
    COUNT(*) as Appointments,
    SUM(fb.TotalAmount) as Revenue,
    AVG(fa.Duration) as AvgDuration
FROM factappointment fa
JOIN dimdate d ON fa.DateKey = d.DateKey
JOIN dimdepartment dept ON fa.DepartmentKey = dept.DepartmentKey
LEFT JOIN factbilling fb ON fa.AppointmentKey = fb.AppointmentKey
GROUP BY d.Year, d.Month, dept.DepartmentName;

-- Refresh materialized view (scheduled job)
REFRESH MATERIALIZED VIEW mv_monthly_department_stats;
```

---

## Final Deliverables Summary

| Deliverable                                   | Description                            | File Name                   |
| --------------------------------------------- | -------------------------------------- | --------------------------- |
| **Part 1: ERD**                         | Entity Relationship Diagram screenshot | DigiHealth_ERD.png          |
| **Part 1: OLTP Schema**                 | MySQL CREATE TABLE statements          | DigiHealth_OLTP_Schema.sql  |
| **Part 1: Normalization Documentation** | 1NF, 2NF, 3NF verification             | Normalization_Report.md     |
| **Part 2: OLTP INSERT Scripts**         | MySQL sample data                      | DigiHealth_OLTP_Data.sql    |
| **Part 2: OLAP Schema**                 | PostgreSQL CREATE statements           | DigiHealth_OLAP_Schema.sql  |
| **Part 2: OLAP INSERT Scripts**         | PostgreSQL dimension/fact data         | DigiHealth_OLAP_Data.sql    |
| **Part 2: Data Warehouse Report**       | Implementation documentation           | DW_Implementation_Report.md |
| **Part 2: ETL Diagram**                 | Pipeline visualization                 | ETL_Pipeline.png            |

---

## Conclusion

Congratulations! You have successfully completed the DigiHealth Enterprise Data Architecture & Operations project. This end-to-end implementation demonstrates:

1. **Scalable OLTP Design**: Normalized schema optimized for transactional efficiency
2. **Robust Data Governance**: Referential integrity, constraints, and audit readiness
3. **Analytical OLAP Model**: Star schema enabling complex healthcare analytics
4. **ETL Pipeline**: Systematic transformation from operational to analytical data
5. **Business Intelligence Ready**: Pre-aggregated facts and dimensions for rapid querying

This architecture positions DigiHealth for:

- **Operational Excellence**: Efficient handling of patient registrations, appointments, and billing
- **Data-Driven Decisions**: Analytics on patient demographics, doctor performance, and revenue trends
- **Regulatory Compliance**: HIPAA-ready with proper data segmentation and audit trails
- **Future Scalability**: Foundation for machine learning and predictive analytics

---

*Project completed: _________________*
*Data Architect: _________________*
*Reviewer: _________________*
*Date: _________________*
