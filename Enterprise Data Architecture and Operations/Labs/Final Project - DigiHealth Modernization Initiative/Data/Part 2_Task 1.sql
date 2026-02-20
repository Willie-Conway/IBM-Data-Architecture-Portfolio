CREATE TABLE scripts
SQL Scripts to create table
-- Patients Table
CREATE TABLE Patients (
PatientID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DOB DATE,
Gender VARCHAR(10),
ContactNumber VARCHAR(15),
Email VARCHAR(100),
Address TEXT
);
-- Doctors Table
CREATE TABLE Doctors (
DoctorID INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Specialization VARCHAR(100),
ContactNumber VARCHAR(15),
Email VARCHAR(100)
);
-- Appointments Table
CREATE TABLE Appointments (
AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
PatientID INT,
DoctorID INT,
AppointmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Status VARCHAR(20) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE
);
-- Medical Records Table
CREATE TABLE MedicalRecords (
RecordID INT AUTO_INCREMENT PRIMARY KEY,
PatientID INT,
DoctorID INT,
Diagnosis TEXT,
Prescription TEXT,
VisitDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE
);
-- Billing Table
CREATE TABLE Billing (
BillID INT AUTO_INCREMENT PRIMARY KEY,
PatientID INT,
Amount DECIMAL(10,2),
PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Pending', 'Overdue')),
BillDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);
INSERT scripts
-- Insert into Patients
INSERT INTO Patients (FirstName, LastName, DOB, Gender, ContactNumber, Email, Address) VALUES
('John', 'Doe', '1985-05-20', 'Male', '1234567890', 'john.doe@example.com', '123 Elm St, Springfield'),
('Jane', 'Smith', '1990-08-15', 'Female', '9876543210', 'jane.smith@example.com', '456 Maple Ave, Springfield');
-- Insert into Doctors
INSERT INTO Doctors (FirstName, LastName, Specialization, ContactNumber, Email) VALUES
('Dr. Alice', 'Johnson', 'Cardiology', '5551234567', 'alice.johnson@example.com'),
('Dr. Bob', 'Miller', 'Dermatology', '5557654321', 'bob.miller@example.com');
-- Insert into Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) VALUES
(1, 1, '2024-02-15 10:00:00', 'Scheduled'),
(2, 2, '2024-02-16 14:30:00', 'Completed');
-- Insert into MedicalRecords
INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, Prescription, VisitDate) VALUES
(1, 1, 'Hypertension', 'Lisinopril 10mg daily', '2024-02-15 10:30:00'),
(2, 2, 'Acne', 'Topical Clindamycin', '2024-02-16 15:00:00');
-- Insert into Billing
INSERT INTO Billing (PatientID, Amount, PaymentStatus, BillDate) VALUES
(1, 200.00, 'Paid', '2024-02-15 11:00:00'),
(2, 150.00, 'Pending', '2024-02-16 16:00:00');
