-- Lab: MySQL User Management, Access Control, and Encryption
-- Comprehensive SQL Script

-- =====================================================
-- EXERCISE 1: Manage MySQL user accounts and roles
-- =====================================================

-- Create a new user 'sales_rep' if it doesn't exist
CREATE USER IF NOT EXISTS 'sales_rep'@'localhost' IDENTIFIED BY 'SecurePass123!';

-- Create a role for sales representatives
CREATE ROLE IF NOT EXISTS 'sales_rep_role';

-- Grant basic privileges to the role
GRANT SELECT, INSERT, UPDATE ON customerorders.* TO 'sales_rep_role';

-- Assign the role to the user
GRANT 'sales_rep_role' TO 'sales_rep'@'localhost';

-- Set default role for the user
SET DEFAULT ROLE 'sales_rep_role' TO 'sales_rep'@'localhost';

-- =====================================================
-- EXERCISE 2: Control access to MySQL databases and objects
-- =====================================================

-- Step 1: Remove access to payments table for sales_rep user
-- First, revoke any existing privileges on the payments table
REVOKE ALL PRIVILEGES ON customerorders.payments FROM 'sales_rep'@'localhost';

-- Grant only SELECT privilege on payments (as per the exercise, we're removing UPDATE and INSERT)
-- The lab says to click "None" under all sections, so we'll revoke all privileges
-- Note: REVOKE ALL already handled above, but we can be more specific:

-- Alternatively, revoke specific privileges on payments
REVOKE SELECT, INSERT, UPDATE, DELETE, REFERENCES ON customerorders.payments FROM 'sales_rep'@'localhost';

-- Step 2: Remove access to employees table for sales_rep user (practice exercise)
-- First, revoke any existing privileges on employees table
REVOKE ALL PRIVILEGES ON customerorders.employees FROM 'sales_rep'@'localhost';

-- Remove any database-level privileges that might apply to employees
-- This ensures no implicit access through database-level grants

-- Step 3: Remove access to offices table for sales_rep user (practice exercise)
REVOKE ALL PRIVILEGES ON customerorders.offices FROM 'sales_rep'@'localhost';

-- Step 4: Configure table-specific privileges for customers table
-- Restrict sales_rep from updating all columns except creditLimit

-- First, revoke any existing table-level privileges on customers
REVOKE ALL PRIVILEGES ON customerorders.customers FROM 'sales_rep'@'localhost';

-- Grant SELECT on all columns (implied with table-level SELECT)
-- Grant UPDATE only on creditLimit column
-- Note: MySQL doesn't support column-level GRANT directly in all versions
-- For MySQL 8.0+, we can use column-level privileges:

-- Grant SELECT on all columns of customers table
GRANT SELECT ON customerorders.customers TO 'sales_rep'@'localhost';

-- Grant UPDATE only on creditLimit column
-- This requires column-level privilege syntax
GRANT UPDATE (creditLimit) ON customerorders.customers TO 'sales_rep'@'localhost';

-- Grant INSERT with column restrictions if needed
GRANT INSERT (customerNumber, customerName, creditLimit) ON customerorders.customers TO 'sales_rep'@'localhost';

-- Step 5: Restrict access to update product table "buyPrice" column (practice exercise)
-- First, revoke any existing UPDATE privileges on products table
REVOKE UPDATE ON customerorders.products FROM 'sales_rep'@'localhost';

-- Grant UPDATE only on specific columns except buyPrice
-- For example, allow updating productName, productDescription but not buyPrice
GRANT UPDATE (productCode, productName, productDescription, quantityInStock) 
    ON customerorders.products TO 'sales_rep'@'localhost';

-- Ensure SELECT is still available on all columns
GRANT SELECT ON customerorders.products TO 'sales_rep'@'localhost';

-- =====================================================
-- Verify privileges
-- =====================================================

-- Show grants for sales_rep user
SHOW GRANTS FOR 'sales_rep'@'localhost';

-- Show database-level privileges
SELECT * FROM mysql.db WHERE User = 'sales_rep';

-- Show table-level privileges
SELECT * FROM mysql.tables_priv WHERE User = 'sales_rep';

-- Show column-level privileges
SELECT * FROM mysql.columns_priv WHERE User = 'sales_rep';

-- =====================================================
-- EXERCISE 3: Secure data using encryption
-- =====================================================

-- Option A: Using MySQL Enterprise Encryption (if available)
-- Create a table with encrypted columns using AES

-- Create a table for storing encrypted customer data
CREATE TABLE IF NOT EXISTS customerorders.encrypted_customer_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    sensitive_data VARBINARY(255),
    encryption_key_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customerorders.customers(customerNumber)
);

-- Example of inserting encrypted data using AES_ENCRYPT
-- Note: In production, keys should be stored securely, not hardcoded
INSERT INTO customerorders.encrypted_customer_data (customer_id, sensitive_data, encryption_key_id)
VALUES 
    (103, AES_ENCRYPT('SSN: 123-45-6789', 'encryption_key_123'), 'KEY001'),
    (112, AES_ENCRYPT('SSN: 987-65-4321', 'encryption_key_123'), 'KEY001');

-- Example of retrieving and decrypting data
SELECT 
    customer_id,
    CAST(AES_DECRYPT(sensitive_data, 'encryption_key_123') AS CHAR) as decrypted_data
FROM customerorders.encrypted_customer_data;

-- Option B: Using hashing for password storage
ALTER TABLE customerorders.customers 
ADD COLUMN IF NOT EXISTS password_hash CHAR(60);

-- Example of storing hashed passwords
UPDATE customerorders.customers 
SET password_hash = SHA2('customer_password123', 256) 
WHERE customerNumber = 103;

-- Option C: Using MySQL's built-in encryption functions for data at rest
-- Create a table with SHA2 hashed columns
CREATE TABLE IF NOT EXISTS customerorders.secure_employee_data (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    email_hash CHAR(64), -- SHA-256 produces 64 characters
    salary_encrypted VARBINARY(255),
    FOREIGN KEY (employee_id) REFERENCES customerorders.employees(employeeNumber)
);

-- Insert with hashed and encrypted data
INSERT INTO customerorders.secure_employee_data (employee_id, employee_name, email_hash, salary_encrypted)
VALUES 
    (1002, 'Diane Murphy', SHA2('dmurphy@classicmodelcars.com', 256), AES_ENCRYPT('75000', 'salary_key_2024')),
    (1056, 'Mary Patterson', SHA2('mpatterson@classicmodelcars.com', 256), AES_ENCRYPT('90000', 'salary_key_2024'));

-- Option D: Enable encryption for specific tables (MySQL 8.0+)
-- This requires appropriate file system support
ALTER TABLE customerorders.customers ENCRYPTION='Y';

-- =====================================================
-- Additional security measures
-- =====================================================

-- Create a view that shows limited customer data
CREATE OR REPLACE VIEW customerorders.customer_limited_view AS
SELECT 
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    city,
    country,
    -- Exclude sensitive columns like creditLimit for this view
    'RESTRICTED' as creditLimit_status
FROM customerorders.customers;

-- Grant access to the view instead of the base table
GRANT SELECT ON customerorders.customer_limited_view TO 'sales_rep'@'localhost';

-- =====================================================
-- Clean up and reset (optional - use with caution)
-- =====================================================
/*
-- Uncomment to revoke all privileges and drop user (if needed)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'sales_rep'@'localhost';
DROP USER 'sales_rep'@'localhost';
DROP ROLE 'sales_rep_role';
*/