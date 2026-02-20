
![Logo](../Screenshots/DigiHealth.png)


# Final Project: DigiHealth Modernization Initiative

## Project Overview

This project focuses on designing a scalable enterprise data architecture for **DigiHealth**, a Health Management System (HMS). You will first develop an OLTP database using MySQL to manage real-time transactions efficiently. Then, you will implement an OLAP data warehouse in PostgreSQL to enable advanced healthcare analytics. By completing this project, you will gain hands-on experience in data modeling, normalization, and ETL processes for enterprise data management.

---

## Case Study: DigiHealth

**DigiHealth** is an advanced Health Management System (HMS) designed to streamline hospital workflows, manage patient records, and enhance analytics. It handles critical real-time transactions, including patient registrations, billing, doctor appointments, and medical history.

As DigiHealth continues to grow, its expansion has introduced significant challenges related to data scalability, security, and analytics. The increasing volume of patient data, coupled with the need for seamless system performance, has highlighted inefficiencies in its existing data infrastructure. Without a robust enterprise data strategy, DigiHealth risks performance bottlenecks, security vulnerabilities, and compliance issues.

To address these challenges, DigiHealth must implement a modern Enterprise Data Architecture and Operational Strategy. The company is now seeking a skilled Data Architect who can lead the transformation, ensuring scalability, security, and compliance while optimizing data-driven decision-making.

---

## Why DigiHealth Needs an Enterprise Data Architect

As DigiHealth expands, managing vast amounts of patient records, financial transactions, and medical reports becomes increasingly complex. Without a well-structured data strategy, the organization faces significant challenges:

| Challenge                         | Description                                                     | Impact                                      |
| --------------------------------- | --------------------------------------------------------------- | ------------------------------------------- |
| **Data silos**              | Fragmented and inconsistent data across departments             | Incomplete patient views, duplicate records |
| **Performance bottlenecks** | Inefficient queries slowing down transactional processing       | Poor user experience, delayed care          |
| **Compliance risks**        | Need for strict adherence to HIPAA and GDPR regulations         | Legal penalties, reputational damage        |
| **Scalability challenges**  | Difficulty in handling both real-time and batch data processing | Limited growth potential                    |

To address these issues, DigiHealth requires an **Enterprise Data Architect** to lead the development of a robust, scalable, and secure data infrastructure that supports efficient data governance, enhances data quality, and enables seamless analytics.

---

## Key Responsibilities of an Enterprise Data Architect

| Responsibility                                   | Description                                                                                                   |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| **Design Scalable Data Models**            | Develop and optimize OLTP and OLAP systems to support operational and analytical workloads                    |
| **Ensure Data Governance & Compliance**    | Implement policies for data security, integrity, and regulatory compliance (HIPAA, GDPR)                      |
| **Develop ETL Pipelines**                  | Establish efficient Extract, Transform, Load processes to streamline data movement and integration            |
| **Optimize Query Performance**             | Fine-tune SQL queries to enhance the efficiency of real-time transactions and analytical processing           |
| **Implement Data Warehouses & Data Lakes** | Enable advanced analytics and data-driven decision-making by designing scalable storage and retrieval systems |

By bringing in an Enterprise Data Architect, DigiHealth can modernize its data ecosystem, ensuring reliability, security, and scalability while maintaining compliance with industry regulations.

---

## Learning outcomes of the project

Upon completing the project, you will be able to:

- Design a scalable enterprise data architecture by creating ER diagrams, identifying entities, and implementing normalization techniques
- Develop OLTP and OLAP schemas by implementing MySQL-based transactional databases and PostgreSQL-based data warehouses
- Apply ETL processes to transform transactional data into analytical models
- Implement healthcare-specific data models supporting patients, appointments, billing, and medical records

---

## Project Structure

The project is divided into two parts, which are to be submitted sequentially:

| Part             | Focus Area                                | Key Deliverables                                                              |
| ---------------- | ----------------------------------------- | ----------------------------------------------------------------------------- |
| **Part 1** | Implementing Enterprise Data Architecture | ERD design, normalized schema (3NF), entity definitions                       |
| **Part 2** | OLTP to OLAP Transformation               | MySQL OLTP schema, PostgreSQL OLAP schema, ETL scripts, data warehouse report |

---

# Part 1: Implementing Enterprise Data Architecture for data scalability, governance, and optimization

## Objective

Design and develop a structured OLTP database for DigiHealth by creating ER diagrams and identifying key entities and relationships. Apply normalization techniques to optimize data integrity and eliminate redundancy.

---

## Task 1: Identify and Define Key Entities and Relationships

### Step 1: Understand the Healthcare Domain Requirements

DigiHealth needs to manage the following core business processes:

| Process                          | Description                                                  | Data Requirements                                       |
| -------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------- |
| **Patient Registration**   | New patients register with personal and contact information  | Patient demographics, contact details, insurance info   |
| **Employee Management**    | Hospital staff including doctors, nurses, and administrators | Employee details, roles, credentials, department        |
| **Appointment Scheduling** | Patients book appointments with doctors                      | Appointment date/time, status, reason for visit         |
| **Medical Records**        | Document patient diagnoses, treatments, prescriptions        | Medical history, diagnoses, prescriptions, test results |
| **Billing & Payments**     | Process payments for services rendered                       | Invoice details, payment amounts, insurance claims      |
| **Prescriptions**          | Doctors prescribe medications to patients                    | Medication details, dosage, duration                    |

### Step 2: Identify Key Entities

Based on the domain analysis, identify the core entities:

| Entity                   | Description                                     | Key Attributes                                   |
| ------------------------ | ----------------------------------------------- | ------------------------------------------------ |
| **Patients**       | Individuals receiving healthcare services       | Patient ID, name, DOB, contact, insurance        |
| **Employees**      | Hospital staff including doctors, nurses, admin | Employee ID, name, role, specialization, contact |
| **Roles**          | Job roles within the hospital                   | Role ID, role name, description, permissions     |
| **Departments**    | Hospital departments                            | Department ID, name, location, head              |
| **Appointments**   | Scheduled patient visits                        | Appointment ID, date/time, status, reason        |
| **MedicalRecords** | Patient medical history and diagnoses           | Record ID, diagnosis, treatment, date            |
| **Prescriptions**  | Medications prescribed to patients              | Prescription ID, medication, dosage, duration    |
| **Billing**        | Invoices and payment transactions               | Invoice ID, amount, date, status, payment method |
| **Insurance**      | Patient insurance information                   | Insurance ID, provider, policy number, coverage  |
| **Medications**    | Pharmaceutical inventory                        | Medication ID, name, manufacturer, price         |

### Step 3: Define Relationships Between Entities

| Entity 1                 | Relationship | Entity 2       | Cardinality | Description                                       |
| ------------------------ | ------------ | -------------- | ----------- | ------------------------------------------------- |
| **Patients**       | has          | Appointments   | 1 : N       | One patient can have many appointments            |
| **Patients**       | has          | MedicalRecords | 1 : N       | One patient can have many medical records         |
| **Patients**       | has          | Billing        | 1 : N       | One patient can have many billing invoices        |
| **Patients**       | has          | Insurance      | 1 : 1       | One patient has one insurance policy (simplified) |
| **Employees**      | conducts     | Appointments   | 1 : N       | One doctor can conduct many appointments          |
| **Employees**      | belongs to   | Departments    | N : 1       | Many employees belong to one department           |
| **Employees**      | has          | Roles          | N : 1       | Many employees can have the same role             |
| **Appointments**   | generates    | MedicalRecords | 1 : 1       | One appointment generates one medical record      |
| **Appointments**   | generates    | Billing        | 1 : 1       | One appointment generates one billing invoice     |
| **MedicalRecords** | contains     | Prescriptions  | 1 : N       | One medical record can have many prescriptions    |
| **Prescriptions**  | references   | Medications    | N : 1       | Many prescriptions reference one medication       |

### Step 4: Normalize Data to 3NF

#### Unnormalized Form (UNF)

A single table with repeating groups would look like:

```
Patient(ID, Name, DOB, Phone, Doctor1, Doctor2, Appointment1_Date, Appointment2_Date, Diagnosis1, Diagnosis2, Medication1, Medication2)
```

#### First Normal Form (1NF)

Remove repeating groups and create separate rows:

```
Patient(ID, Name, DOB, Phone)
Appointment(PatientID, Doctor, AppointmentDate, Diagnosis)
Prescription(PatientID, AppointmentDate, Medication)
```

#### Second Normal Form (2NF)

Remove partial dependencies (already achieved with separate tables)

#### Third Normal Form (3NF)

Remove transitive dependencies:

```sql
-- 3NF Design
Patients(PatientID, FirstName, LastName, DOB, Phone, Email, Address, InsuranceID)
Insurance(InsuranceID, Provider, PolicyNumber, CoverageType, ExpiryDate)

Employees(EmployeeID, FirstName, LastName, DOB, Phone, Email, RoleID, DepartmentID, HireDate)
Roles(RoleID, RoleName, Description, Permissions)
Departments(DepartmentID, DepartmentName, Location, HeadEmployeeID)

Appointments(AppointmentID, PatientID, EmployeeID, AppointmentDate, AppointmentTime, Status, Reason)
MedicalRecords(RecordID, PatientID, EmployeeID, AppointmentID, Diagnosis, Treatment, RecordDate)
Prescriptions(PrescriptionID, RecordID, MedicationID, Dosage, Frequency, Duration, PrescribedDate)
Medications(MedicationID, MedicationName, Manufacturer, Description, UnitPrice)

Billing(InvoiceID, PatientID, AppointmentID, InvoiceDate, Amount, Status, PaymentMethod, PaymentDate)
```

---

## Task 2: Design an Entity-Relationship Diagram (ERD)

### Complete ERD for DigiHealth OLTP System

```
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│    Insurance    │         │    Patients     │         │   Appointments  │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ PK InsuranceID  │◄────────┤ FK InsuranceID  │         │ PK AppointmentID│
│ Provider        │         │ PK PatientID    │         │ FK PatientID    │
│ PolicyNumber    │         │ FirstName       │─────────┤ FK EmployeeID   │
│ CoverageType    │         │ LastName        │         │ AppointmentDate │
│ ExpiryDate      │         │ DOB             │         │ AppointmentTime │
└─────────────────┘         │ Phone           │         │ Status          │
                            │ Email           │         │ Reason          │
                            │ Address         │         └────────┬────────┘
                            └─────────────────┘                  │
                                    │                            │
                                    │                            │
┌─────────────────┐         ┌───────▼────────┐         ┌────────▼────────┐
│   Departments   │         │  MedicalRecords │         │     Billing     │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ PK DepartmentID │         │ PK RecordID     │         │ PK InvoiceID    │
│ DepartmentName  │         │ FK PatientID    │         │ FK PatientID    │
│ Location        │         │ FK EmployeeID   │         │ FK AppointmentID│
│ HeadEmployeeID  │─────────┤ FK AppointmentID│         │ InvoiceDate     │
└────────┬────────┘         │ Diagnosis       │         │ Amount          │
         │                  │ Treatment       │         │ Status          │
         │                  │ RecordDate      │         │ PaymentMethod   │
         │                  └────────┬────────┘         │ PaymentDate     │
         │                           │                  └─────────────────┘
         │                           │
┌────────▼────────┐         ┌────────▼────────┐         ┌─────────────────┐
│    Employees    │         │  Prescriptions  │         │   Medications   │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ PK EmployeeID   │         │ PK PrescriptionID│        │ PK MedicationID │
│ FK RoleID       │         │ FK RecordID     │─────────┤ MedicationName  │
│ FK DepartmentID │         │ FK MedicationID │         │ Manufacturer    │
│ FirstName       │         │ Dosage          │         │ Description     │
│ LastName        │         │ Frequency       │         │ UnitPrice       │
│ DOB             │         │ Duration        │         └─────────────────┘
│ Phone           │         │ PrescribedDate  │
│ Email           │         └─────────────────┘
│ HireDate        │
└────────┬────────┘
         │
┌────────▼────────┐
│      Roles      │
├─────────────────┤
│ PK RoleID       │
│ RoleName        │
│ Description     │
│ Permissions     │
└─────────────────┘
```

### Text-Based ERD Representation

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
│  │ PolicyNumber │      │ FirstName    │      │FK EmployeeID │      │FK Appointment│ │
│  │ CoverageType │      │ LastName     │      │ApptDate      │      │ Amount       │ │
│  │ ExpiryDate   │      │ DOB          │      │ApptTime      │      │ Status       │ │
│  └──────────────┘      │ Phone        │      │ Status       │      │ PaymentDate  │ │
│                        │ Email        │      │ Reason       │      └──────────────┘ │
│                        │ Address      │      └──────┬───────┘                       │
│                        └───────┬──────┘             │                               │
│                                │                    │                               │
│                                │                    │                               │
│                        ┌───────▼──────┐      ┌──────▼───────┐                       │
│                        │MedicalRecords│      │  Employees   │                       │
│                        ├──────────────┤      ├──────────────┤                       │
│                        │PK RecordID   │      │PK EmployeeID │                       │
│                        │FK PatientID  │      │FK RoleID     │                       │
│                        │FK EmployeeID │──────┤FK DeptID     │                       │
│                        │FK Appointment│      │ FirstName    │                       │
│                        │ Diagnosis    │      │ LastName     │                       │
│                        │ Treatment    │      │ DOB          │                       │
│                        │ RecordDate   │      │ Phone        │                       │
│                        └───────┬──────┘      │ Email        │                       │
│                                │              │ HireDate     │                       │
│                                │              └──────┬───────┘                       │
│                                │                     │                               │
│                                │                     │                               │
│                        ┌───────▼──────┐      ┌──────▼───────┐      ┌──────────────┐ │
│                        │Prescriptions │      │   Roles      │      │ Departments  │ │
│                        ├──────────────┤      ├──────────────┤      ├──────────────┤ │
│                        │PK PrescriptID│      │PK RoleID     │      │PK Department │ │
│                        │FK RecordID   │      │ RoleName     │      │ DeptName     │ │
│                        │FK Medication │──────│ Description  │      │ Location     │ │
│                        │ Dosage       │      │ Permissions  │      │ HeadEmpID    │ │
│                        │ Frequency    │      └──────────────┘      └──────────────┘ │
│                        │ Duration     │              ▲                               │
│                        │ PrescribedDate│             │                               │
│                        └───────┬──────┘              │                               │
│                                │                     │                               │
│                        ┌───────▼──────┐              │                               │
│                        │ Medications  │              │                               │
│                        ├──────────────┤              │                               │
│                        │PK Medication │              │                               │
│                        │ MedicationName│              │                               │
│                        │ Manufacturer │              │                               │
│                        │ Description  │              │                               │
│                        │ UnitPrice    │              │                               │
│                        └──────────────┘              │                               │
│                                                       │                               │
│  ┌───────────────────────────────────────────────────────────────────────────────┐   │
│  │                              RELATIONSHIPS                                     │   │
│  │  ──── = One-to-Many      ──── = One-to-One      ──── = Many-to-One            │   │
│  └───────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                       │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Task 3: Create Normalized Table Definitions (3NF)

```sql
-- Create database
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
    HeadEmployeeID INT, -- Will be set after Employees table
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Roles table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) UNIQUE NOT NULL,
    Description TEXT,
    Permissions JSON, -- Store permissions as JSON
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT,
    RoleID INT NOT NULL,
    DepartmentID INT NOT NULL,
    Specialization VARCHAR(100),
    LicenseNumber VARCHAR(50),
    HireDate DATE NOT NULL,
    Status ENUM('Active', 'OnLeave', 'Terminated') DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Update Departments with HeadEmployeeID foreign key
ALTER TABLE Departments 
ADD CONSTRAINT fk_head_employee 
FOREIGN KEY (HeadEmployeeID) REFERENCES Employees(EmployeeID);

-- 6. Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    EmployeeID INT NOT NULL, -- Doctor
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Duration INT DEFAULT 30, -- minutes
    Status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'Scheduled',
    Reason TEXT,
    Notes TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    INDEX idx_appointment_date (AppointmentDate),
    INDEX idx_status (Status)
);

-- 7. Medications table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY AUTO_INCREMENT,
    MedicationName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Manufacturer VARCHAR(100),
    Description TEXT,
    Strength VARCHAR(50), -- e.g., "500mg", "10mg/ml"
    Form VARCHAR(50), -- e.g., "Tablet", "Capsule", "Syrup"
    UnitPrice DECIMAL(10,2),
    RequiresPrescription BOOLEAN DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_medication_name (MedicationName)
);

-- 8. MedicalRecords table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    EmployeeID INT NOT NULL, -- Doctor who created the record
    AppointmentID INT,
    Diagnosis TEXT NOT NULL,
    Treatment TEXT,
    Notes TEXT,
    RecordDate DATE NOT NULL,
    FollowUpDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    INDEX idx_patient_date (PatientID, RecordDate)
);

-- 9. Prescriptions table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    RecordID INT NOT NULL,
    MedicationID INT NOT NULL,
    Dosage VARCHAR(50) NOT NULL, -- e.g., "1 tablet", "5ml"
    Frequency VARCHAR(100) NOT NULL, -- e.g., "Twice daily", "Every 8 hours"
    Duration INT, -- days
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
    PaymentMethod ENUM('Cash', 'Credit Card', 'Debit Card', 'Insurance', 'Bank Transfer', 'Other'),
    PaymentDate DATE,
    InsuranceClaimID VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    INDEX idx_invoice_date (InvoiceDate),
    INDEX idx_status (Status)
);

-- 11. AuditLog table for compliance (HIPAA)
CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    TableName VARCHAR(50) NOT NULL,
    RecordID INT NOT NULL,
    Action ENUM('INSERT', 'UPDATE', 'DELETE', 'VIEW') NOT NULL,
    UserID INT, -- Employee ID who performed the action
    UserRole VARCHAR(50),
    ActionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    OldValues JSON,
    NewValues JSON,
    IPAddress VARCHAR(45),
    UserAgent TEXT,
    INDEX idx_table_record (TableName, RecordID),
    INDEX idx_action_time (ActionTime)
);
```

---

## Part 1 Summary Checklist

| Task                                                                                                                                               | Completed |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| ✅ Identified key entities (Patients, Employees, Roles, Departments, Appointments, MedicalRecords, Prescriptions, Medications, Billing, Insurance) |           |
| ✅ Defined relationships between entities with cardinality                                                                                         |           |
| ✅ Applied 3NF normalization to eliminate redundancy                                                                                               |           |
| ✅ Designed comprehensive ERD                                                                                                                      |           |
| ✅ Created normalized table definitions with proper constraints                                                                                    |           |
| ✅ Implemented foreign key relationships                                                                                                           |           |
| ✅ Added audit logging for HIPAA compliance                                                                                                        |           |

---

# Part 2: Applying OLTP to OLAP Transformation for Healthcare Analytics and Data-Driven Decision-Making

## Objective

Design and implement a scalable data architecture for DigiHealth by developing a structured OLTP database in MySQL for real-time transactions and transitioning to an OLAP data warehouse in PostgreSQL. Define relational schemas, create Fact and Dimension Tables, and apply data modeling techniques to support advanced healthcare analytics.

---

## Task 1: Designing the OLTP Schema (Transactional Database in MySQL)

### Step 1: Implement the OLTP Schema in MySQL

Based on the ERD from Part 1, implement the complete OLTP schema:

```sql
-- Use the database
USE DigiHealth_OLTP;

-- Insert sample data into Roles
INSERT INTO Roles (RoleName, Description, Permissions) VALUES
('Doctor', 'Medical doctor responsible for patient care', '{"view_patients": true, "create_prescriptions": true, "view_medical_records": true}'),
('Nurse', 'Nursing staff assisting with patient care', '{"view_patients": true, "update_vitals": true, "view_medical_records": true}'),
('Administrator', 'Administrative staff managing operations', '{"manage_appointments": true, "manage_billing": true, "view_reports": true}'),
('Receptionist', 'Front desk staff handling appointments', '{"schedule_appointments": true, "register_patients": true, "view_basic_info": true}'),
('Pharmacist', 'Pharmacy staff dispensing medications', '{"view_prescriptions": true, "dispense_medications": true}');

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
('Michael', 'Lee', '1975-12-03', 'Male', '555-789-0123', 'michael.lee@email.com', '147 Birch St, Othertown, USA', 'Jennifer Lee', '555-321-0987', 1, '2023-07-22'),
('Jennifer', 'Taylor', '1992-04-08', 'Female', '555-890-1234', 'jennifer.t@email.com', '258 Spruce Ave, Newcity, USA', 'Thomas Taylor', '555-210-9876', 2, '2023-08-30');

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address, RoleID, DepartmentID, Specialization, LicenseNumber, HireDate) VALUES
('James', 'Wilson', '1975-03-10', 'Male', '555-111-2222', 'dr.wilson@digihealth.com', '100 Doctor Way, Medical City, USA', 1, 1, 'Interventional Cardiology', 'MD12345', '2018-06-01'),
('Lisa', 'Chen', '1980-07-22', 'Female', '555-222-3333', 'dr.chen@digihealth.com', '200 Physician Blvd, Medical City, USA', 1, 2, 'Pediatric Medicine', 'MD23456', '2019-03-15'),
('Robert', 'Miller', '1972-11-05', 'Male', '555-333-4444', 'dr.miller@digihealth.com', '300 Surgeon St, Medical City, USA', 1, 3, 'Emergency Medicine', 'MD34567', '2017-01-10'),
('Patricia', 'Davis', '1985-09-18', 'Female', '555-444-5555', 'nurse.davis@digihealth.com', '400 Nursing Ave, Medical City, USA', 2, 1, 'Cardiac Nursing', 'RN12345', '2020-02-20'),
('Thomas', 'Anderson', '1978-12-12', 'Male', '555-555-6666', 'nurse.anderson@digihealth.com', '500 Healthcare Dr, Medical City, USA', 2, 3, 'Emergency Nursing', 'RN23456', '2019-08-10'),
('Jennifer', 'Martinez', '1982-04-25', 'Female', '555-666-7777', 'admin.martinez@digihealth.com', '600 Admin Rd, Medical City, USA', 3, 6, 'Healthcare Administration', NULL, '2016-11-05'),
('Christopher', 'Brown', '1990-08-30', 'Male', '555-777-8888', 'reception.brown@digihealth.com', '700 Front Desk Ln, Medical City, USA', 4, 6, 'Patient Services', NULL, '2021-04-12'),
('Amanda', 'Garcia', '1988-02-14', 'Female', '555-888-9999', 'pharmacist.garcia@digihealth.com', '800 Pharmacy St, Medical City, USA', 5, 6, 'Clinical Pharmacy', 'PHARM12345', '2020-09-01');

-- Update Departments with HeadEmployeeID
UPDATE Departments SET HeadEmployeeID = 1 WHERE DepartmentID = 1; -- Cardiology
UPDATE Departments SET HeadEmployeeID = 2 WHERE DepartmentID = 2; -- Pediatrics
UPDATE Departments SET HeadEmployeeID = 3 WHERE DepartmentID = 3; -- Emergency
UPDATE Departments SET HeadEmployeeID = 6 WHERE DepartmentID = 6; -- Administration

-- Insert sample data into Medications
INSERT INTO Medications (MedicationName, GenericName, Manufacturer, Description, Strength, Form, UnitPrice, RequiresPrescription) VALUES
('Lisinopril', 'Lisinopril', 'Pfizer', 'ACE inhibitor for hypertension', '10mg', 'Tablet', 0.50, TRUE),
('Metformin', 'Metformin HCl', 'Merck', 'Antidiabetic medication', '500mg', 'Tablet', 0.30, TRUE),
('Atorvastatin', 'Atorvastatin', 'AstraZeneca', 'Statin for cholesterol', '20mg', 'Tablet', 0.75, TRUE),
('Amoxicillin', 'Amoxicillin', 'GSK', 'Antibiotic', '500mg', 'Capsule', 1.20, TRUE),
('Ibuprofen', 'Ibuprofen', 'Johnson & Johnson', 'NSAID pain reliever', '400mg', 'Tablet', 0.15, FALSE),
('Acetaminophen', 'Acetaminophen', 'Tylenol', 'Pain reliever', '500mg', 'Tablet', 0.10, FALSE),
('Albuterol', 'Albuterol', 'GSK', 'Bronchodilator for asthma', '90mcg', 'Inhaler', 25.00, TRUE),
('Levothyroxine', 'Levothyroxine', 'AbbVie', 'Thyroid hormone', '50mcg', 'Tablet', 0.40, TRUE);

-- Insert sample data into Appointments
INSERT INTO Appointments (PatientID, EmployeeID, AppointmentDate, AppointmentTime, Status, Reason, Notes) VALUES
(1, 1, '2024-01-15', '09:00:00', 'Completed', 'Annual checkup', 'Patient in good health'),
(2, 2, '2024-01-15', '10:30:00', 'Completed', 'Child wellness visit', 'Vaccinations due'),
(3, 3, '2024-01-16', '14:00:00', 'Completed', 'Chest pain', 'EKG ordered'),
(1, 1, '2024-02-15', '09:30:00', 'Scheduled', 'Follow-up', 'Review lab results'),
(4, 1, '2024-02-16', '11:00:00', 'Scheduled', 'Palpitations', 'New patient consult'),
(5, 3, '2024-02-17', '15:30:00', 'Scheduled', 'Injury', 'Sprained ankle'),
(6, 2, '2024-01-20', '09:00:00', 'Completed', 'Fever', 'Upper respiratory infection'),
(7, 1, '2024-01-22', '14:00:00', 'Completed', 'Hypertension follow-up', 'BP well controlled'),
(8, 2, '2024-02-10', '10:00:00', 'Scheduled', 'Annual physical', NULL);

-- Insert sample data into MedicalRecords
INSERT INTO MedicalRecords (PatientID, EmployeeID, AppointmentID, Diagnosis, Treatment, Notes, RecordDate, FollowUpDate) VALUES
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
(5, 3, '1 tablet', 'Once daily', 90, 'Take in evening', '2024-01-22', 3),
(2, 5, '1 tablet', 'As needed', 30, 'For fever or pain', '2024-01-15', 0);

-- Insert sample data into Billing
INSERT INTO Billing (PatientID, AppointmentID, InvoiceNumber, InvoiceDate, DueDate, Subtotal, Tax, TotalAmount, PaidAmount, Status, PaymentMethod, PaymentDate) VALUES
(1, 1, 'INV-2024-001', '2024-01-15', '2024-01-30', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Credit Card', '2024-01-15'),
(2, 2, 'INV-2024-002', '2024-01-15', '2024-01-30', 200.00, 16.00, 216.00, 216.00, 'Paid', 'Insurance', '2024-01-16'),
(3, 3, 'INV-2024-003', '2024-01-16', '2024-01-31', 300.00, 24.00, 324.00, 100.00, 'Partial', 'Cash', '2024-01-16'),
(6, 7, 'INV-2024-004', '2024-01-20', '2024-02-04', 180.00, 14.40, 194.40, 0.00, 'Pending', NULL, NULL),
(7, 8, 'INV-2024-005', '2024-01-22', '2024-02-06', 150.00, 12.00, 162.00, 162.00, 'Paid', 'Debit Card', '2024-01-22');
```

---

## Task 2: Designing the OLAP Schema and Data Warehouse (Analytical Model in PostgreSQL)

### Step 1: Choose Data Warehouse Schema

For healthcare analytics, we'll implement a **Star Schema** with fact and dimension tables optimized for analytical queries.

#### Star Schema Design Principles:

```
┌─────────────────────────────────────────────────────────────────┐
│                        STAR SCHEMA                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│                    ┌─────────────────┐                           │
│                    │   DimPatient    │                           │
│                    ├─────────────────┤                           │
│                    │ PatientKey (PK) │                           │
│                    │ PatientID       │                           │
│                    │ Name            │                           │
│                    │ AgeGroup        │                           │
│                    │ Gender          │                           │
│                    │ InsuranceType   │                           │
│                    └────────┬────────┘                           │
│                             │                                     │
│                             │                                     │
│                    ┌────────▼────────┐                           │
│   ┌────────────────┤  FactAppointment│◄──────────────────┐      │
│   │                ├──────────────────┤                   │      │
│   │                │ AppointmentKey(PK)│                  │      │
│   │                │ DateKey (FK)      │                  │      │
│   │                │ PatientKey (FK)   │                  │      │
│   │                │ DoctorKey (FK)    │                  │      │
│   │                │ DepartmentKey (FK)│                  │      │
│   │                │ Status            │                  │      │
│   │                │ Duration          │                  │      │
│   │                └───────────────────┘                  │      │
│   │                                                         │      │
│   │                 ┌─────────────────┐                    │      │
│   │                 │    DimDate      │                    │      │
│   │                 ├─────────────────┤                    │      │
│   │                 │ DateKey (PK)    │                    │      │
│   │                 │ FullDate        │                    │      │
│   │                 │ Year            │                    │      │
│   │                 │ Quarter         │                    │      │
│   │                 │ Month           │                    │      │
│   │                 │ DayOfWeek       │                    │      │
│   │                 │ IsWeekend       │                    │      │
│   │                 └─────────────────┘                    │      │
│   │                                                         │      │
│   │  ┌─────────────────┐              ┌─────────────────┐  │      │
│   │  │   DimDoctor     │              │   DimDepartment │  │      │
│   │  ├─────────────────┤              ├─────────────────┤  │      │
│   │  │ DoctorKey (PK)  │              │ DeptKey (PK)    │  │      │
│   │  │ EmployeeID      │              │ DepartmentID    │  │      │
│   │  │ Name            │              │ DepartmentName  │  │      │
│   │  │ Specialization  │              │ Location        │  │      │
│   └──┤ Role            │              └─────────────────┘  │      │
│      └─────────────────┘                                    │      │
│                                                             │      │
│                    ┌─────────────────┐                      │      │
│                    │   FactBilling   │                      │      │
│                    ├─────────────────┤                      │      │
│                    │ BillingKey (PK) │                      │      │
│                    │ DateKey (FK)    │                      │      │
│                    │ PatientKey (FK) │◄─────────────────────┘      │
│                    │ AppointmentKeyFK│                             │
│                    │ TotalAmount     │                             │
│                    │ PaidAmount      │                             │
│                    │ PaymentMethod   │                             │
│                    └─────────────────┘                             │
│                                                                     │
│                    ┌─────────────────┐                             │
│                    │ FactPrescription│                             │
│                    ├─────────────────┤                             │
│                    │ PrescKey (PK)   │                             │
│                    │ DateKey (FK)    │                             │
│                    │ PatientKey (FK) │                             │
│                    │ DoctorKey (FK)  │                             │
│                    │ MedicationKey(FK)│                            │
│                    │ Quantity        │                             │
│                    │ Refills         │                             │
│                    └─────────────────┘                             │
│                                                                     │
│                    ┌─────────────────┐                             │
│                    │  DimMedication  │                             │
│                    ├─────────────────┤                             │
│                    │ MedicationKey PK│                             │
│                    │ MedicationName  │                             │
│                    │ Manufacturer    │                             │
│                    │ UnitPrice       │                             │
│                    │ RequiresRx      │                             │
│                    └─────────────────┘                             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Step 2: Create PostgreSQL Data Warehouse

```sql
-- Create database
CREATE DATABASE DigiHealth_OLAP;
\c DigiHealth_OLAP;

-- 1. Create Dimension Tables

-- DimDate - Time dimension
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

-- DimPatient - Patient dimension
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

-- DimDoctor - Doctor dimension
CREATE TABLE DimDoctor (
    DoctorKey SERIAL PRIMARY KEY,
    EmployeeID INT NOT NULL,
    FullName VARCHAR(101) NOT NULL,
    Specialization VARCHAR(100),
    Department VARCHAR(100),
    Role VARCHAR(50),
    HireDate DATE,
    IsActive BOOLEAN
);

-- DimDepartment - Department dimension
CREATE TABLE DimDepartment (
    DepartmentKey SERIAL PRIMARY KEY,
    DepartmentID INT NOT NULL,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    HeadDoctor VARCHAR(101)
);

-- DimMedication - Medication dimension
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

-- 2. Create Fact Tables

-- FactAppointment - Appointment facts
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

-- FactBilling - Billing facts
CREATE TABLE FactBilling (
    BillingKey SERIAL PRIMARY KEY,
    InvoiceID INT NOT NULL,
    DateKey INT NOT NULL,
    PatientKey INT NOT NULL,
    AppointmentKey INT,
    Subtotal DECIMAL(10,2),
    Tax DECIMAL(10,2),
    Discount DECIMAL(10,2),
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaidAmount DECIMAL(10,2),
    OutstandingAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    IsPaid BOOLEAN,
    DaysToPayment INT,
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (PatientKey) REFERENCES DimPatient(PatientKey),
    FOREIGN KEY (AppointmentKey) REFERENCES FactAppointment(AppointmentKey)
);

-- FactPrescription - Prescription facts
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

-- FactDailyAggregates - Pre-aggregated daily metrics
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

### Step 3: Populate Dimension Tables

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
            EXTRACT(DOW FROM v_currentDate) + 1, -- 1=Sunday, 7=Saturday
            TO_CHAR(v_currentDate, 'Day'),
            CASE WHEN EXTRACT(DOW FROM v_currentDate) IN (0, 6) THEN TRUE ELSE FALSE END
        );
        v_currentDate := v_currentDate + INTERVAL '1 day';
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT PopulateDimDate();

-- Populate DimPatient from MySQL (via ETL)
-- In a real scenario, this would be an ETL job
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
INSERT INTO DimDoctor (EmployeeID, FullName, Specialization, Department, Role, HireDate, IsActive)
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName),
    e.Specialization,
    d.DepartmentName,
    r.RoleName,
    e.HireDate,
    CASE WHEN e.Status = 'Active' THEN TRUE ELSE FALSE END
FROM employees e
JOIN roles r ON e.RoleID = r.RoleID
JOIN departments d ON e.DepartmentID = d.DepartmentID
WHERE r.RoleName = 'Doctor';

-- Populate DimDepartment
INSERT INTO DimDepartment (DepartmentID, DepartmentName, Location, HeadDoctor)
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    d.Location,
    CONCAT(e.FirstName, ' ', e.LastName)
FROM departments d
LEFT JOIN employees e ON d.HeadEmployeeID = e.EmployeeID;

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

### Step 4: Populate Fact Tables

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
JOIN dimdoctor dd ON a.EmployeeID = dd.EmployeeID
JOIN dimdepartment dde ON dd.Department = dde.DepartmentName;

-- Populate FactBilling
INSERT INTO FactBilling (
    InvoiceID,
    DateKey,
    PatientKey,
    AppointmentKey,
    Subtotal,
    Tax,
    Discount,
    TotalAmount,
    PaidAmount,
    OutstandingAmount,
    PaymentMethod,
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
    b.Subtotal,
    b.Tax,
    b.Discount,
    b.TotalAmount,
    b.PaidAmount,
    b.TotalAmount - b.PaidAmount,
    b.PaymentMethod,
    CASE WHEN b.Status = 'Paid' THEN TRUE ELSE FALSE END,
    CASE 
        WHEN b.PaymentDate IS NOT NULL 
        THEN (b.PaymentDate - b.InvoiceDate)
        ELSE NULL
    END
FROM billing b
JOIN dimpatient dp ON b.PatientID = dp.PatientID
LEFT JOIN factappointment fa ON b.AppointmentID = fa.AppointmentID;

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
    dm.UnitPrice * 30, -- Total cost
    p.Dispensed
FROM prescriptions p
JOIN medicalrecords mr ON p.RecordID = mr.RecordID
JOIN dimpatient dp ON mr.PatientID = dp.PatientID
JOIN dimdoctor dd ON mr.EmployeeID = dd.EmployeeID
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

**Project:** DigiHealth Healthcare Analytics Data Warehouse
**Platform:** PostgreSQL 13+
**Schema Type:** Star Schema
**Purpose:** Enable advanced healthcare analytics and business intelligence

#### 2. Schema Design

| Component                  | Count | Description                                          |
| -------------------------- | ----- | ---------------------------------------------------- |
| **Dimension Tables** | 5     | Patient, Doctor, Department, Medication, Date        |
| **Fact Tables**      | 4     | Appointment, Billing, Prescription, Daily Aggregates |
| **Total Tables**     | 9     | Optimized for analytical queries                     |

#### 3. ETL Process Summary

| Step        | Source (MySQL)                | Target (PostgreSQL)      | Transformation                                 |
| ----------- | ----------------------------- | ------------------------ | ---------------------------------------------- |
| **1** | Patients, Insurance           | DimPatient               | Age calculation, age grouping, denormalization |
| **2** | Employees, Roles, Departments | DimDoctor, DimDepartment | Role filtering, department mapping             |
| **3** | Medications                   | DimMedication            | Direct mapping                                 |
| **4** | Appointments                  | FactAppointment          | DateKey generation, status flags               |
| **5** | Billing                       | FactBilling              | Outstanding calculation, payment lag           |
| **6** | Prescriptions                 | FactPrescription         | Cost calculation                               |
| **7** | All fact tables               | FactDailyAggregates      | Daily rollup aggregations                      |

#### 4. Key Analytical Queries

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
    AVG(fb.TotalAmount) as AvgRevenuePerPatient
FROM factbilling fb
JOIN dimpatient p ON fb.PatientKey = p.PatientKey
WHERE fb.DateKey BETWEEN 20240101 AND 20241231
GROUP BY p.AgeGroup
ORDER BY TotalRevenue DESC;

-- Query 3: Prescription patterns by doctor specialization
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
LIMIT 20;

-- Query 4: Payment collection efficiency
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

-- Query 5: Patient visit frequency analysis
WITH PatientVisits AS (
    SELECT 
        PatientKey,
        COUNT(*) as VisitCount,
        MIN(AppointmentKey) as FirstVisit,
        MAX(AppointmentKey) as LastVisit
    FROM factappointment
    GROUP BY PatientKey
)
SELECT 
    CASE 
        WHEN VisitCount = 1 THEN 'One-time'
        WHEN VisitCount BETWEEN 2 AND 3 THEN 'Occasional'
        WHEN VisitCount BETWEEN 4 AND 6 THEN 'Regular'
        ELSE 'Frequent'
    END as PatientSegment,
    COUNT(*) as PatientCount,
    AVG(VisitCount) as AvgVisits
FROM PatientVisits
GROUP BY PatientSegment
ORDER BY PatientSegment;
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
    SUM(fb.TotalAmount) as Revenue
FROM factappointment fa
JOIN dimdate d ON fa.DateKey = d.DateKey
JOIN dimdepartment dept ON fa.DepartmentKey = dept.DepartmentKey
LEFT JOIN factbilling fb ON fa.AppointmentKey = fb.AppointmentKey
GROUP BY d.Year, d.Month, dept.DepartmentName;

REFRESH MATERIALIZED VIEW mv_monthly_department_stats;
```

#### 6. Data Quality and Governance

| Check                           | Validation                             | Frequency  |
| ------------------------------- | -------------------------------------- | ---------- |
| **Referential Integrity** | All foreign keys have valid references | Daily      |
| **Date Range**            | No future dates in fact tables         | Daily      |
| **Null Checks**           | Required fields not null               | Daily      |
| **Duplicate Detection**   | No duplicate business keys             | Weekly     |
| **Compliance**            | HIPAA compliance via audit logging     | Continuous |

---

## Final Project Submission Checklist

### Part 1 Deliverables

| Deliverable                                   | Completed |
| --------------------------------------------- | --------- |
| Entity Relationship Diagram (ERD)             | ⬜        |
| List of identified entities with descriptions | ⬜        |
| Documented relationships with cardinality     | ⬜        |
| Normalized table definitions (3NF)            | ⬜        |
| SQL scripts for OLTP schema creation          | ⬜        |

### Part 2 Deliverables

| Deliverable                                        | Completed |
| -------------------------------------------------- | --------- |
| MySQL OLTP schema with sample data                 | ⬜        |
| PostgreSQL OLAP schema (star schema)               | ⬜        |
| Dimension table definitions and population scripts | ⬜        |
| Fact table definitions and population scripts      | ⬜        |
| ETL process documentation                          | ⬜        |
| Data warehouse implementation report               | ⬜        |
| Sample analytical queries with results             | ⬜        |

---

## Conclusion

Congratulations! You have successfully completed the DigiHealth Modernization Initiative project. By completing this project, you have demonstrated the ability to:

1. **Design scalable enterprise data architecture** for healthcare systems
2. **Implement normalized OLTP databases** for efficient transaction processing
3. **Transform OLTP data into OLAP star schemas** for advanced analytics
4. **Create comprehensive ETL processes** to move data between systems
5. **Develop analytical queries** to extract business insights
6. **Ensure regulatory compliance** with HIPAA and GDPR requirements

This end-to-end data architecture provides DigiHealth with:

- **Scalable transactional processing** for daily operations
- **Powerful analytics capabilities** for data-driven decision making
- **Regulatory compliance** through audit trails and data governance
- **Future-ready platform** for machine learning and predictive analytics

---

*Project completed: _________________*
*Data Architect: _________________*
*Reviewer: _________________*
