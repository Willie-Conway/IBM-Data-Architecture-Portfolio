-- Lab: MySQL User Management, Access Control, and Encryption
-- EXERCISE 3: Secure data using encryption
-- Comprehensive SQL Script with Practice Exercise

-- =====================================================
-- PART A: Encrypting addressLine1 column in customers table
-- =====================================================

-- Step 1: Hash the passphrase using SHA2 with 512-bit length
-- Store the hashed key in a variable for later use
SET @key_str = SHA2('My secret passphrase', 512);

-- Step 2: Connect to the customerorders database
USE customerorders;

-- Step 3: View the customers table before encryption
-- This shows the plain text data in addressLine1
SELECT '--- BEFORE ENCRYPTION ---' as '';
SELECT customerNumber, customerName, addressLine1, city, country 
FROM customers 
LIMIT 5;

-- Step 4: Modify the addressLine1 column to store binary data
-- Convert from VARCHAR to VARBINARY to store encrypted binary data
ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

-- Step 5: Encrypt the addressLine1 column using AES_ENCRYPT
-- This uses the hashed passphrase stored in @key_str
UPDATE customers 
SET addressLine1 = AES_ENCRYPT(addressLine1, @key_str);

-- Step 6: Verify the encryption
-- The addressLine1 column should now show binary/garbled data
SELECT '--- AFTER ENCRYPTION ---' as '';
SELECT customerNumber, customerName, addressLine1, city, country 
FROM customers 
LIMIT 5;

-- Step 7: Decrypt the data to access it when needed
-- Use AES_DECRYPT with the same key and convert back to readable format
SELECT '--- DECRYPTED DATA ---' as '';
SELECT 
    customerNumber, 
    customerName, 
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address,
    city, 
    country
FROM customers 
LIMIT 5;

-- =====================================================
-- PART B: Practice Exercise - Encrypt cardNumber column in payments table
-- =====================================================

-- First, let's examine the payments table structure and data
SELECT '--- PAYMENTS TABLE BEFORE ENCRYPTION ---' as '';
DESCRIBE payments;

SELECT '--- SAMPLE PAYMENT DATA (BEFORE ENCRYPTION) ---' as '';
SELECT customerNumber, checkNumber, paymentDate, amount, cardNumber
FROM payments 
LIMIT 10;

-- Note: The payments table might not have a cardNumber column initially
-- If it doesn't exist, we need to add it first
-- Check if cardNumber column exists, if not, add it
SELECT COUNT(*) INTO @column_exists
FROM information_schema.columns 
WHERE table_schema = 'customerorders' 
AND table_name = 'payments' 
AND column_name = 'cardNumber';

-- Add cardNumber column if it doesn't exist (for demonstration purposes)
SET @add_column = IF(@column_exists = 0, 
    'ALTER TABLE payments ADD COLUMN cardNumber VARCHAR(255)', 
    'SELECT "cardNumber column already exists" as "Status"');

PREPARE stmt FROM @add_column;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- If the column was just added, let's populate it with sample data for demonstration
-- This is just for practice - in reality, you would have real data
SELECT COUNT(*) INTO @data_exists
FROM payments 
WHERE cardNumber IS NOT NULL 
LIMIT 1;

SET @populate_data = IF(@data_exists = 0 AND @column_exists = 0,
    'UPDATE payments SET cardNumber = CONCAT("****-****-****-", LPAD(FLOOR(RAND() * 10000), 4, "0")) WHERE cardNumber IS NULL',
    'SELECT "Data already exists or column existed before" as "Status"');

PREPARE stmt_pop FROM @populate_data;
EXECUTE stmt_pop;
DEALLOCATE PREPARE stmt_pop;

-- Now let's encrypt the cardNumber column following the same pattern as addressLine1

-- Step P1: Verify current data before encryption
SELECT '--- CARD NUMBER DATA BEFORE ENCRYPTION ---' as '';
SELECT customerNumber, checkNumber, cardNumber, amount 
FROM payments 
LIMIT 10;

-- Step P2: Modify the cardNumber column to store binary data
ALTER TABLE payments MODIFY COLUMN cardNumber varbinary(255);

-- Step P3: Encrypt the cardNumber column using AES_ENCRYPT with the same key
-- Note: In production, you might want to use a different key for different columns
UPDATE payments 
SET cardNumber = AES_ENCRYPT(cardNumber, @key_str);

-- Step P4: Verify the encryption
-- The cardNumber column should now show binary/garbled data
SELECT '--- CARD NUMBER DATA AFTER ENCRYPTION ---' as '';
SELECT customerNumber, checkNumber, cardNumber, amount 
FROM payments 
LIMIT 10;

-- Step P5: Decrypt the cardNumber data when needed
SELECT '--- DECRYPTED CARD NUMBER DATA ---' as '';
SELECT 
    customerNumber, 
    checkNumber, 
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(255)) as decrypted_card_number,
    paymentDate,
    amount
FROM payments 
LIMIT 10;

-- =====================================================
-- PART C: Additional Encryption Examples and Best Practices
-- =====================================================

-- Example 1: Using a different key for the payments table
SET @payment_key = SHA2('Payment secret key 2024', 512);

-- You could encrypt with a different key
-- UPDATE payments SET cardNumber = AES_ENCRYPT(cardNumber, @payment_key);

-- Example 2: Creating a view that automatically decrypts data for authorized users
CREATE OR REPLACE VIEW customerorders.vw_customers_with_address AS
SELECT 
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as addressLine1,
    city,
    country
FROM customers;

-- Example 3: Creating a view for payments with decrypted card numbers
CREATE OR REPLACE VIEW customerorders.vw_payments_with_card AS
SELECT 
    customerNumber,
    checkNumber,
    paymentDate,
    amount,
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(255)) as cardNumber
FROM payments;

-- Test the views
SELECT '--- VIEW WITH DECRYPTED CUSTOMER ADDRESS ---' as '';
SELECT * FROM customerorders.vw_customers_with_address LIMIT 5;

SELECT '--- VIEW WITH DECRYPTED PAYMENT CARD NUMBERS ---' as '';
SELECT * FROM customerorders.vw_payments_with_card LIMIT 5;

-- Example 4: Function to encrypt data (for reuse)
DELIMITER $$
CREATE FUNCTION encrypt_data(plain_text VARCHAR(255), encryption_key VARCHAR(512))
RETURNS VARBINARY(255)
DETERMINISTIC
BEGIN
    RETURN AES_ENCRYPT(plain_text, encryption_key);
END$$
DELIMITER ;

-- Example 5: Function to decrypt data (for reuse)
DELIMITER $$
CREATE FUNCTION decrypt_data(encrypted_data VARBINARY(255), encryption_key VARCHAR(512))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN CAST(AES_DECRYPT(encrypted_data, encryption_key) AS CHAR(255));
END$$
DELIMITER ;

-- Test the functions
SELECT 
    customerNumber,
    decrypt_data(addressLine1, @key_str) as decrypted_address
FROM customers 
LIMIT 5;

-- =====================================================
-- PART D: Security Considerations and Verification
-- =====================================================

-- Check which columns are encrypted
SELECT '--- ENCRYPTED COLUMNS IN DATABASE ---' as '';
SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns 
WHERE table_schema = 'customerorders' 
AND data_type IN ('varbinary', 'blob')
AND column_name IN ('addressLine1', 'cardNumber');

-- Verify that the data is indeed encrypted (not readable as plain text)
SELECT '--- VERIFYING ENCRYPTION (SHOULD SHOW BINARY DATA) ---' as '';
SELECT 
    customerNumber,
    LENGTH(addressLine1) as encrypted_length,
    HEX(addressLine1) as hex_representation
FROM customers 
LIMIT 3;

-- Verify that we can still decrypt when needed
SELECT '--- VERIFYING DECRYPTION WORKS ---' as '';
SELECT 
    c.customerNumber,
    c.customerName,
    decrypt_data(c.addressLine1, @key_str) as decrypted_address,
    p.checkNumber,
    decrypt_data(p.cardNumber, @key_str) as decrypted_card
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
LIMIT 5;

-- =====================================================
-- PART E: Clean Up (Optional - Use with caution)
-- =====================================================
/*
-- Uncomment to revert changes if needed

-- Drop the views
DROP VIEW IF EXISTS vw_customers_with_address;
DROP VIEW IF EXISTS vw_payments_with_card;

-- Drop functions
DROP FUNCTION IF EXISTS encrypt_data;
DROP FUNCTION IF EXISTS decrypt_data;

-- Decrypt the data first if you want to revert to plain text
UPDATE customers 
SET addressLine1 = AES_DECRYPT(addressLine1, @key_str);

UPDATE payments 
SET cardNumber = AES_DECRYPT(cardNumber, @key_str);

-- Convert back to VARCHAR
ALTER TABLE customers MODIFY COLUMN addressLine1 varchar(255);
ALTER TABLE payments MODIFY COLUMN cardNumber varchar(255);

-- Remove the cardNumber column if you want (for cleanup)
-- ALTER TABLE payments DROP COLUMN cardNumber;
*/