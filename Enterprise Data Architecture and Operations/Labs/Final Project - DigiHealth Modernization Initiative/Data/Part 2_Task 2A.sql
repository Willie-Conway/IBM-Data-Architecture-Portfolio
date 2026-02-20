CREATE TABLE scripts
SQL scripts to create table
-- DigiHealth OLAP Schema (Star Schema)
-- Dimension Table: Patients
CREATE TABLE DimPatients (
PatientID SERIAL PRIMARY KEY,
FullName VARCHAR(100),
DOB DATE,
Gender VARCHAR(10),
ContactNumber VARCHAR(15),
Address TEXT
);
-- Dimension Table: Doctors
CREATE TABLE DimDoctors (
DoctorID SERIAL PRIMARY KEY,
FullName VARCHAR(100),
ContactNumber VARCHAR(15),
Email VARCHAR(100)
);
-- Dimension Table: Specializations
CREATE TABLE DimSpecializations (
SpecializationID SERIAL PRIMARY KEY,
SpecializationName VARCHAR(100)
);
-- Dimension Table: Diagnoses
CREATE TABLE DimDiagnoses (
DiagnosisID SERIAL PRIMARY KEY,
DiagnosisName TEXT
);
-- Dimension Table: Billing
CREATE TABLE DimBilling (
BillID SERIAL PRIMARY KEY,
PaymentStatus VARCHAR(20),
BillDate DATE
);
-- Fact Table: Appointments
CREATE TABLE FactAppointments (
AppointmentID SERIAL PRIMARY KEY,
PatientID INT,
DoctorID INT,
SpecializationID INT,
DiagnosisID INT,
BillID INT,
AppointmentDate DATE,
Amount DECIMAL(10,2),
FOREIGN KEY (PatientID) REFERENCES DimPatients(PatientID),
FOREIGN KEY (DoctorID) REFERENCES DimDoctors(DoctorID),
FOREIGN KEY (SpecializationID) REFERENCES DimSpecializations(SpecializationID),
FOREIGN KEY (DiagnosisID) REFERENCES DimDiagnoses(DiagnosisID),
FOREIGN KEY (BillID) REFERENCES DimBilling(BillID)
);
INSERT scripts
-- Insert into DimPatients (Based on OLTP Patients Data)
INSERT INTO DimPatients (FullName, DOB, Gender, ContactNumber, Address) VALUES
('John Doe', '1985-05-20', 'Male', '1234567890', '123 Elm St, Springfield'),
('Jane Smith', '1990-08-15', 'Female', '9876543210', '456 Maple Ave, Springfield');
-- Insert into DimDoctors (Based on OLTP Doctors Data)
INSERT INTO DimDoctors (FullName, ContactNumber, Email) VALUES
('Dr. Alice Johnson', '5551234567', 'alice.johnson@example.com'),
('Dr. Bob Miller', '5557654321', 'bob.miller@example.com');
-- Insert into DimSpecializations (Based on Doctors' Specialization)
INSERT INTO DimSpecializations (SpecializationName) VALUES
('Cardiology'),
('Dermatology');
-- Insert into DimDiagnoses (Based on Medical Records Data)
INSERT INTO DimDiagnoses (DiagnosisName) VALUES
('Hypertension'),
('Acne');
-- Insert into DimBilling (Based on OLTP Billing Data)
INSERT INTO DimBilling (PaymentStatus, BillDate) VALUES
('Paid', '2024-02-15'),
('Pending', '2024-02-16');
-- Insert into FactAppointments (Aligning with OLTP Appointments & Billing Data)
INSERT INTO FactAppointments (PatientID, DoctorID, SpecializationID, DiagnosisID, BillID, AppointmentDate, Amount) VALUES
(1, 1, 1, 1, 1, '2024-02-15', 200.00),
(2, 2, 2, 2, 2, '2024-02-16', 150.00);
