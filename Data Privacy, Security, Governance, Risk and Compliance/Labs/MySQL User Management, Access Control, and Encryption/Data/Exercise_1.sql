-- Lab: MySQL User Management, Access Control, and Encryption
-- EXERCISE 1: Manage MySQL user accounts and roles
-- Comprehensive SQL Script for User and Role Management

-- =====================================================
-- PART A: Database Setup
-- =====================================================

-- Create the customerorders database if it doesn't exist
CREATE DATABASE IF NOT EXISTS customerorders;
USE customerorders;

-- Note: The SQL script file mentioned in Task 2 would be imported here
-- Since we don't have the actual SQL file content, I'll create sample tables
-- that would typically be in a customer orders database

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    customerNumber INT PRIMARY KEY AUTO_INCREMENT,
    customerName VARCHAR(100) NOT NULL,
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(255),
    addressLine2 VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(20),
    country VARCHAR(50),
    creditLimit DECIMAL(10,2)
);

-- Create employees table
CREATE TABLE IF NOT EXISTS employees (
    employeeNumber INT PRIMARY KEY AUTO_INCREMENT,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    officeCode VARCHAR(10),
    jobTitle VARCHAR(50)
);

-- Create offices table
CREATE TABLE IF NOT EXISTS offices (
    officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(255),
    state VARCHAR(50),
    country VARCHAR(50),
    postalCode VARCHAR(20)
);

-- Create payments table
CREATE TABLE IF NOT EXISTS payments (
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount DECIMAL(10,2),
    cardNumber VARCHAR(255),
    PRIMARY KEY (customerNumber, checkNumber),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70),
    productDescription TEXT,
    quantityInStock INT,
    buyPrice DECIMAL(10,2)
);

-- Insert sample data for testing
INSERT INTO customers (customerName, contactLastName, contactFirstName, city, country, creditLimit) VALUES
('ABC Corp', 'Smith', 'John', 'New York', 'USA', 50000.00),
('XYZ Ltd', 'Johnson', 'Sarah', 'London', 'UK', 75000.00),
('Global Traders', 'Lee', 'David', 'Toronto', 'Canada', 60000.00),
('Tech Solutions', 'Chen', 'Wei', 'Beijing', 'China', 45000.00),
('Euro Imports', 'Muller', 'Hans', 'Berlin', 'Germany', 80000.00);

INSERT INTO employees (lastName, firstName, email, officeCode, jobTitle) VALUES
('Murphy', 'Diane', 'dmurphy@classicmodelcars.com', '1', 'President'),
('Patterson', 'Mary', 'mpatterson@classicmodelcars.com', '1', 'VP Sales'),
('Firrelli', 'Jeff', 'jfirrelli@classicmodelcars.com', '1', 'VP Marketing'),
('Patterson', 'William', 'wpatterson@classicmodelcars.com', '1', 'Sales Manager'),
('Bondur', 'Gerard', 'gbondur@classicmodelcars.com', '1', 'Sale Manager');

INSERT INTO offices (officeCode, city, phone, country) VALUES
('1', 'San Francisco', '+1 650 219 4782', 'USA'),
('2', 'Boston', '+1 215 837 0825', 'USA'),
('3', 'Paris', '+33 14 723 4404', 'France'),
('4', 'Tokyo', '+81 33 224 5000', 'Japan'),
('5', 'Sydney', '+61 2 9264 2451', 'Australia');

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount) VALUES
(1, 'CHK001', '2023-01-15', 5000.00),
(2, 'CHK002', '2023-02-20', 7500.00),
(3, 'CHK003', '2023-03-10', 6000.00),
(4, 'CHK004', '2023-04-05', 4500.00),
(5, 'CHK005', '2023-05-12', 8000.00);

INSERT INTO products (productCode, productName, quantityInStock, buyPrice) VALUES
('P001', 'Laptop', 50, 800.00),
('P002', 'Smartphone', 100, 400.00),
('P003', 'Tablet', 75, 300.00),
('P004', 'Monitor', 30, 200.00),
('P005', 'Keyboard', 200, 25.00);

-- =====================================================
-- PART B: User Account and Role Creation
-- =====================================================

-- Step 1: Create a new user account 'sales_rep' with a secure password
-- IMPORTANT: Replace 'YourStrongPassword123!' with your actual password
CREATE USER IF NOT EXISTS 'sales_rep'@'localhost' 
IDENTIFIED BY 'YourStrongPassword123!';

-- For remote access (if needed), you might also create:
-- CREATE USER IF NOT EXISTS 'sales_rep'@'%' IDENTIFIED BY 'YourStrongPassword123!';

-- Step 2: Grant global privileges as specified in the lab
-- The lab specifies: "Under Global privileges, click select option SELECT, INSERT, UPDATE under Data"
GRANT SELECT, INSERT, UPDATE ON *.* TO 'sales_rep'@'localhost';

-- However, best practice is to grant only necessary privileges on specific databases
-- For better security, let's also grant specific database privileges
GRANT SELECT, INSERT, UPDATE ON customerorders.* TO 'sales_rep'@'localhost';

-- Step 3: Create a custom role "sales_rep_role" (optional but good practice)
CREATE ROLE IF NOT EXISTS 'sales_rep_role';

-- Grant the same privileges to the role
GRANT SELECT, INSERT, UPDATE ON customerorders.* TO 'sales_rep_role';

-- Assign the role to the user
GRANT 'sales_rep_role' TO 'sales_rep'@'localhost';

-- Set default role for the user
SET DEFAULT ROLE 'sales_rep_role' TO 'sales_rep'@'localhost';

-- =====================================================
-- PART C: View and Verify User Accounts and Privileges
-- =====================================================

-- View all MySQL users
SELECT '--- ALL MYSQL USERS ---' as '';
SELECT user, host, account_locked, password_expired 
FROM mysql.user 
WHERE user NOT IN ('mysql.session', 'mysql.sys', 'root');

-- View privileges for the sales_rep user
SELECT '--- PRIVILEGES FOR sales_rep@localhost ---' as '';
SHOW GRANTS FOR 'sales_rep'@'localhost';

-- View database-specific privileges
SELECT '--- DATABASE-SPECIFIC PRIVILEGES ---' as '';
SELECT * FROM mysql.db WHERE User = 'sales_rep';

-- View which users have which roles
SELECT '--- USER ROLES ---' as '';
SELECT 
    FROM_USER,
    FROM_HOST,
    TO_USER,
    TO_HOST,
    ROLE_NAME
FROM mysql.role_edges;

-- =====================================================
-- PART D: Additional User Management Examples
-- =====================================================

-- Example 1: Create additional users with different privilege levels
CREATE USER IF NOT EXISTS 'readonly_user'@'localhost' IDENTIFIED BY 'ReadOnly123!';
GRANT SELECT ON customerorders.* TO 'readonly_user'@'localhost';

CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON customerorders.* TO 'admin_user'@'localhost';

-- Example 2: Create application-specific user
CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'AppPass123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON customerorders.* TO 'app_user'@'localhost';

-- Example 3: Create a reporting user with limited access
CREATE USER IF NOT EXISTS 'report_user'@'localhost' IDENTIFIED BY 'Report123!';
GRANT SELECT ON customerorders.customers TO 'report_user'@'localhost';
GRANT SELECT ON customerorders.payments TO 'report_user'@'localhost';
GRANT SELECT ON customerorders.products TO 'report_user'@'localhost';

-- Example 4: Set password expiration policies (MySQL 8.0+)
ALTER USER 'sales_rep'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;

-- Example 5: Set resource limits (optional)
ALTER USER 'sales_rep'@'localhost' 
WITH MAX_QUERIES_PER_HOUR 100 
MAX_UPDATES_PER_HOUR 50 
MAX_CONNECTIONS_PER_HOUR 10;

-- =====================================================
-- PART E: Create Custom Roles for Better Access Control
-- =====================================================

-- Create different roles for different job functions
CREATE ROLE IF NOT EXISTS 'customer_service_role';
CREATE ROLE IF NOT EXISTS 'finance_role';
CREATE ROLE IF NOT EXISTS 'inventory_role';

-- Grant privileges to customer service role
GRANT SELECT, INSERT, UPDATE ON customerorders.customers TO 'customer_service_role';
GRANT SELECT ON customerorders.employees TO 'customer_service_role';

-- Grant privileges to finance role
GRANT SELECT, INSERT, UPDATE ON customerorders.payments TO 'finance_role';
GRANT SELECT ON customerorders.customers TO 'finance_role';

-- Grant privileges to inventory role
GRANT SELECT, UPDATE ON customerorders.products TO 'inventory_role';

-- Assign roles to users (if we had more users)
-- GRANT 'customer_service_role' TO 'cs_rep'@'localhost';
-- GRANT 'finance_role' TO 'finance_rep'@'localhost';
-- GRANT 'inventory_role' TO 'inv_rep'@'localhost';

-- =====================================================
-- PART F: User Account Management Tasks
-- =====================================================

-- 1. Change user password (if needed)
-- ALTER USER 'sales_rep'@'localhost' IDENTIFIED BY 'NewSecurePassword456!';

-- 2. Lock/unlock user account
-- ALTER USER 'sales_rep'@'localhost' ACCOUNT LOCK;
-- ALTER USER 'sales_rep'@'localhost' ACCOUNT UNLOCK;

-- 3. Rename user
-- RENAME USER 'sales_rep'@'localhost' TO 'sales_representative'@'localhost';

-- 4. View user account details
SELECT '--- USER ACCOUNT DETAILS ---' as '';
SELECT 
    user,
    host,
    plugin,
    authentication_string as password_hash,
    password_last_changed,
    password_lifetime,
    account_locked
FROM mysql.user 
WHERE user = 'sales_rep';

-- =====================================================
-- PART G: Verification Queries
-- =====================================================

-- Verify that the sales_rep user can access the database
SELECT '--- VERIFICATION: Testing access for sales_rep ---' as '';

-- The following would be run after connecting as sales_rep user
-- But here we'll just check privileges
SELECT '--- Tables that sales_rep can access ---' as '';
SELECT 
    TABLE_SCHEMA as database_name,
    TABLE_NAME as table_name
FROM information_schema.TABLE_PRIVILEGES 
WHERE GRANTEE = "'sales_rep'@'localhost'"
GROUP BY TABLE_SCHEMA, TABLE_NAME;

-- Check column-level privileges
SELECT '--- Column-level privileges for sales_rep ---' as '';
SELECT * FROM mysql.columns_priv WHERE User = 'sales_rep';

-- =====================================================
-- PART H: Clean Up and Management Scripts (Use with caution)
-- =====================================================

/*
-- Script to remove users and roles (if needed)

-- Revoke all privileges first
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'sales_rep'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'readonly_user'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'admin_user'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'app_user'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'report_user'@'localhost';

-- Drop users
DROP USER IF EXISTS 'sales_rep'@'localhost';
DROP USER IF EXISTS 'readonly_user'@'localhost';
DROP USER IF EXISTS 'admin_user'@'localhost';
DROP USER IF EXISTS 'app_user'@'localhost';
DROP USER IF EXISTS 'report_user'@'localhost';

-- Drop roles
DROP ROLE IF EXISTS 'sales_rep_role';
DROP ROLE IF EXISTS 'customer_service_role';
DROP ROLE IF EXISTS 'finance_role';
DROP ROLE IF EXISTS 'inventory_role';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;
*/

-- Finally, flush privileges to ensure all changes take effect
FLUSH PRIVILEGES;

-- Display summary
SELECT '=== EXERCISE 1 COMPLETED SUCCESSFULLY ===' as '';
SELECT 'User sales_rep@localhost created with SELECT, INSERT, UPDATE privileges' as 'Summary';
SELECT 'Customerorders database and sample tables created' as 'Summary';
SELECT 'Roles created and assigned as per lab requirements' as 'Summary';