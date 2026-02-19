-- Implementing Data Privacy, Security, Encryption, and Role-Based Access using MySQL

-- Step 1: Create the SecureHealth Database
CREATE DATABASE SecureHealthDB;

-- Step 2: Use the Database
USE SecureHealthDB;

-- Step 3: Create a Table for Employees
CREATE TABLE employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  role_id INT, -- Links to roles table for role-based access
  email VARCHAR(100) NOT NULL,
  password VARBINARY(255) -- Encrypted password for secure login
);

-- Step 4: Create a Table for Patient Information (Sensitive Data)
CREATE TABLE patients (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  dob DATE, -- Date of Birth
  medical_record VARBINARY(255), -- Encrypted field for medical history
  insurance_number VARBINARY(255) -- Encrypted field for insurance details
);

-- Step 5: Create a Roles Table for Role-Based Access Control
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(50) NOT NULL
);
-- Step 6: Create a Table to Assign Roles to Employees
CREATE TABLE employee_roles (
  employee_id INT,
  role_id INT,
  FOREIGN KEY (employee_id) REFERENCES employees(id),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);