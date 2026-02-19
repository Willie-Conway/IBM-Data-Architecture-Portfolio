-- =====================================================
-- FIX SCRIPT: Proper Encryption and Decryption of addressLine1
-- =====================================================

-- Step 1: First, let's set the key in your CURRENT session
-- IMPORTANT: Run this in the same session where you're trying to decrypt
SET @key_str = SHA2('My secret passphrase', 512);

-- Step 2: Verify the key is set correctly
SELECT '--- KEY VERIFICATION ---' as '';
SELECT @key_str as hashed_key;
SELECT LENGTH(@key_str) as key_length; -- Should be 128 for SHA2-512

-- Step 3: Check the current state of the customers table
SELECT '--- CURRENT TABLE STATE ---' as '';
SELECT 
    customerNumber,
    customerName,
    addressLine1,
    HEX(addressLine1) as hex_representation,
    LENGTH(addressLine1) as data_length
FROM customers 
LIMIT 10;

-- Step 4: Check if the column is properly set as VARBINARY
SELECT '--- COLUMN DATA TYPE ---' as '';
SELECT 
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'customers' 
AND column_name = 'addressLine1';

-- Step 5: If the column is not VARBINARY, convert it first
-- Check current data type and convert if needed
SELECT '--- CONVERTING COLUMN TO VARBINARY IF NEEDED ---' as '';
ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

-- Step 6: Now, let's properly encrypt the data
-- First, backup original data (create a temporary column to verify)
ALTER TABLE customers ADD COLUMN IF NOT EXISTS addressLine1_original VARCHAR(255);

-- Copy current data to backup (if addressLine1 is still readable)
UPDATE customers SET addressLine1_original = CAST(addressLine1 AS CHAR(255));

-- Now encrypt the data properly
UPDATE customers 
SET addressLine1 = AES_ENCRYPT(addressLine1_original, @key_str)
WHERE addressLine1_original IS NOT NULL;

-- Step 7: Verify encryption worked
SELECT '--- AFTER ENCRYPTION ---' as '';
SELECT 
    customerNumber,
    customerName,
    addressLine1,
    HEX(addressLine1) as hex_value,
    LENGTH(addressLine1) as encrypted_length
FROM customers 
LIMIT 10;

-- Step 8: Test decryption with proper CAST
SELECT '--- TESTING DECRYPTION ---' as '';
SELECT 
    customerNumber,
    customerName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address,
    addressLine1_original as original_address
FROM customers 
LIMIT 10;

-- Step 9: Alternative decryption with CONVERT
SELECT '--- DECRYPTION WITH CONVERT ---' as '';
SELECT 
    customerNumber,
    customerName,
    CONVERT(AES_DECRYPT(addressLine1, @key_str) USING utf8mb4) as decrypted_address
FROM customers 
LIMIT 10;

-- Step 10: Check for NULL results and debug
SELECT '--- DEBUGGING NULL RESULTS ---' as '';
SELECT 
    customerNumber,
    customerName,
    addressLine1 IS NULL as is_null,
    HEX(addressLine1) as hex_value,
    AES_DECRYPT(addressLine1, @key_str) as raw_decrypted,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted
FROM customers 
WHERE CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) IS NULL;

-- =====================================================
-- COMPLETE RE-ENCRYPTION PROCESS (if needed)
-- =====================================================

-- If the above doesn't work, let's do a complete re-encryption:

-- Step R1: Drop and recreate the column (WARNING: This will delete existing data)
-- Only run this if you're sure and have backed up your data
/*
ALTER TABLE customers DROP COLUMN addressLine1;
ALTER TABLE customers ADD COLUMN addressLine1 VARCHAR(255);
ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);
*/

-- Step R2: Update with sample data for testing
UPDATE customers SET addressLine1 = '123 Main Street' WHERE customerNumber = 1;
UPDATE customers SET addressLine1 = '456 Oak Avenue' WHERE customerNumber = 2;
UPDATE customers SET addressLine1 = '789 Pine Road' WHERE customerNumber = 3;
UPDATE customers SET addressLine1 = '321 Elm Street' WHERE customerNumber = 4;
UPDATE customers SET addressLine1 = '654 Maple Drive' WHERE customerNumber = 5;

-- Step R3: Set the key again
SET @key_str = SHA2('My secret passphrase', 512);

-- Step R4: Encrypt the data
UPDATE customers SET addressLine1 = AES_ENCRYPT(addressLine1, @key_str);

-- Step R5: Test decryption
SELECT 
    customerNumber,
    customerName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address
FROM customers 
LIMIT 5;

-- =====================================================
-- FIX FOR PAYMENTS TABLE (Practice Exercise)
-- =====================================================

-- For the payments table cardNumber column:

-- Step P1: Check if cardNumber column exists
SELECT '--- PAYMENTS TABLE STRUCTURE ---' as '';
DESCRIBE payments;

-- Step P2: Add cardNumber column if it doesn't exist
ALTER TABLE payments ADD COLUMN IF NOT EXISTS cardNumber VARCHAR(255);

-- Step P3: Add sample data for testing
UPDATE payments SET cardNumber = '4111111111111111' WHERE customerNumber = 1;
UPDATE payments SET cardNumber = '5500000000000004' WHERE customerNumber = 2;
UPDATE payments SET cardNumber = '340000000000009' WHERE customerNumber = 3;
UPDATE payments SET cardNumber = '6011000000000004' WHERE customerNumber = 4;
UPDATE payments SET cardNumber = '371449635398431' WHERE customerNumber = 5;

-- Step P4: Convert to VARBINARY
ALTER TABLE payments MODIFY COLUMN cardNumber varbinary(255);

-- Step P5: Encrypt with the same key
UPDATE payments SET cardNumber = AES_ENCRYPT(cardNumber, @key_str);

-- Step P6: Verify encryption
SELECT '--- PAYMENTS AFTER ENCRYPTION ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    cardNumber,
    HEX(cardNumber) as encrypted_hex
FROM payments 
LIMIT 10;

-- Step P7: Test decryption
SELECT '--- PAYMENTS DECRYPTED ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(255)) as decrypted_card
FROM payments 
LIMIT 10;

-- =====================================================
-- CREATE HELPER FUNCTIONS FOR EASY DECRYPTION
-- =====================================================

-- Create a function for easy decryption
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS decrypt_address(encrypted_data VARBINARY(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE key_str VARBINARY(128);
    SET key_str = SHA2('My secret passphrase', 512);
    RETURN CAST(AES_DECRYPT(encrypted_data, key_str) AS CHAR(255));
END$$
DELIMITER ;

-- Test the function
SELECT 
    customerNumber,
    customerName,
    decrypt_address(addressLine1) as decrypted_address
FROM customers 
LIMIT 10;

-- =====================================================
-- CREATE VIEW FOR EASY ACCESS
-- =====================================================

-- Create a view that automatically decrypts
CREATE OR REPLACE VIEW vw_customers_decrypted AS
SELECT 
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as addressLine1,
    city,
    country
FROM customers;

-- Test the view
SELECT * FROM vw_customers_decrypted LIMIT 10;

-- =====================================================
-- TROUBLESHOOTING COMMANDS
-- =====================================================

-- Check if key is set correctly in current session
SELECT @key_str IS NOT NULL as key_is_set;

-- Check if data is properly encrypted (should not be readable)
SELECT 
    customerNumber,
    addressLine1
FROM customers 
WHERE addressLine1 REGEXP '[a-zA-Z0-9]' -- This should return 0 rows if properly encrypted
LIMIT 10;

-- Check for any plain text data
SELECT 
    customerNumber,
    CAST(addressLine1 AS CHAR(255)) as plain_text_check
FROM customers 
WHERE CAST(addressLine1 AS CHAR(255)) NOT LIKE '%�%' -- Looking for non-binary data
LIMIT 10;

-- Reset the key variable (run this before any decryption)
SET @key_str = SHA2('My secret passphrase', 512);