-- =====================================================
-- EXERCISE 3: Secure data using encryption
-- Based on your actual customerorders database schema
-- =====================================================

-- Step 1: Set the encryption key in your current session
SET @key_str = SHA2('My secret passphrase', 512);

-- Step 2: First, let's see what data we actually have in the customers table
SELECT '--- SAMPLE CUSTOMER DATA BEFORE ENCRYPTION ---' as '';
SELECT 
    customerNumber,
    customerName,
    addressLine1,
    city,
    country
FROM customers 
LIMIT 10;

-- Step 3: Check if addressLine1 actually has data (it's NOT NULL in schema)
SELECT 
    COUNT(*) as total_customers,
    SUM(CASE WHEN addressLine1 IS NULL THEN 1 ELSE 0 END) as null_count,
    SUM(CASE WHEN addressLine1 IS NOT NULL THEN 1 ELSE 0 END) as not_null_count
FROM customers;

-- Step 4: Convert the addressLine1 column to VARBINARY to store encrypted data
-- First, check the current data type
SELECT '--- CURRENT COLUMN DATA TYPE ---' as '';
SELECT 
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'customers' 
AND column_name = 'addressLine1';

-- Now convert to VARBINARY
ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

-- Step 5: Encrypt the addressLine1 column
-- Since addressLine1 has data (NOT NULL constraint), this will encrypt existing data
UPDATE customers 
SET addressLine1 = AES_ENCRYPT(addressLine1, @key_str);

-- Step 6: Verify encryption - data should now look like binary/garbage
SELECT '--- AFTER ENCRYPTION (SHOULD SHOW BINARY DATA) ---' as '';
SELECT 
    customerNumber,
    customerName,
    addressLine1,
    HEX(addressLine1) as hex_representation
FROM customers 
LIMIT 10;

-- Step 7: NOW TRY YOUR ORIGINAL DECRYPTION QUERY - THIS SHOULD WORK
SELECT '--- YOUR ORIGINAL DECRYPTION QUERY - SHOULD WORK NOW ---' as '';
SELECT CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address 
FROM customers 
LIMIT 10;

-- Step 8: More detailed decryption with customer info
SELECT '--- DECRYPTED ADDRESSES WITH CUSTOMER INFO ---' as '';
SELECT 
    customerNumber,
    customerName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address,
    city,
    country
FROM customers 
LIMIT 20;

-- =====================================================
-- PRACTICE EXERCISE: Encrypt cardNumber in payments table
-- =====================================================

-- Step P1: Check if cardNumber column exists in payments table
SELECT '--- PAYMENTS TABLE STRUCTURE ---' as '';
DESCRIBE payments;

-- Step P2: Add cardNumber column if it doesn't exist (as per your schema, it has DEFAULT NULL)
-- Your schema shows: `cardNumber` VARCHAR(50) DEFAULT NULL,
-- So it already exists but might be NULL

-- Step P3: Check current cardNumber data
SELECT '--- CURRENT CARD NUMBER DATA ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    paymentDate,
    amount,
    cardNumber
FROM payments 
LIMIT 20;

-- Step P4: Populate cardNumber with sample data for demonstration
-- Since cardNumber might be NULL, let's add some sample data
UPDATE payments 
SET cardNumber = CONCAT(
    '****-****-****-',
    LPAD(FLOOR(1000 + RAND() * 9000), 4, '0')
)
WHERE cardNumber IS NULL;

-- Add more realistic card numbers for specific records
UPDATE payments SET cardNumber = '4111111111111111' WHERE customerNumber = 103 AND checkNumber = 'HQ336336';
UPDATE payments SET cardNumber = '5500000000000004' WHERE customerNumber = 112 AND checkNumber = 'HQ336336';
UPDATE payments SET cardNumber = '340000000000009' WHERE customerNumber = 114 AND checkNumber = 'HQ336336';
UPDATE payments SET cardNumber = '6011000000000004' WHERE customerNumber = 119 AND checkNumber = 'HQ336336';
UPDATE payments SET cardNumber = '371449635398431' WHERE customerNumber = 121 AND checkNumber = 'HQ336336';

-- Step P5: Verify cardNumber data after population
SELECT '--- CARD NUMBERS AFTER POPULATION ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    cardNumber
FROM payments 
WHERE cardNumber IS NOT NULL
LIMIT 15;

-- Step P6: Convert cardNumber to VARBINARY
ALTER TABLE payments MODIFY COLUMN cardNumber varbinary(50);

-- Step P7: Encrypt cardNumber using the same key
UPDATE payments 
SET cardNumber = AES_ENCRYPT(cardNumber, @key_str)
WHERE cardNumber IS NOT NULL;

-- Step P8: Verify encryption
SELECT '--- CARD NUMBERS AFTER ENCRYPTION ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    cardNumber,
    HEX(cardNumber) as encrypted_hex
FROM payments 
WHERE cardNumber IS NOT NULL
LIMIT 10;

-- Step P9: Test decryption of card numbers
SELECT '--- DECRYPTED CARD NUMBERS ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) as decrypted_card,
    paymentDate,
    amount
FROM payments 
WHERE cardNumber IS NOT NULL
LIMIT 15;

-- =====================================================
-- CREATE HELPER VIEWS FOR EASY ACCESS
-- =====================================================

-- Create view for customers with decrypted addresses
CREATE OR REPLACE VIEW vw_customers_with_address AS
SELECT 
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(50)) as addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    salesRepEmployeeNumber,
    creditLimit
FROM customers;

-- Create view for payments with decrypted card numbers
CREATE OR REPLACE VIEW vw_payments_with_card AS
SELECT 
    p.customerNumber,
    c.customerName,
    p.checkNumber,
    p.paymentDate,
    p.amount,
    CAST(AES_DECRYPT(p.cardNumber, @key_str) AS CHAR(50)) as cardNumber
FROM payments p
LEFT JOIN customers c ON p.customerNumber = c.customerNumber
WHERE p.cardNumber IS NOT NULL;

-- Test the views
SELECT '--- VIEW: Customers with Decrypted Addresses ---' as '';
SELECT * FROM vw_customers_with_address LIMIT 10;

SELECT '--- VIEW: Payments with Decrypted Card Numbers ---' as '';
SELECT * FROM vw_payments_with_card LIMIT 10;

-- =====================================================
-- VERIFY EVERYTHING IS WORKING
-- =====================================================

-- Check that decryption works for all customers
SELECT 
    COUNT(*) as total_customers,
    SUM(CASE WHEN CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(50)) IS NOT NULL 
        THEN 1 ELSE 0 END) as successfully_decrypted
FROM customers;

-- Show sample of decrypted addresses
SELECT 
    customerNumber,
    customerName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(50)) as addressLine1,
    city,
    country
FROM customers 
WHERE CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(50)) IS NOT NULL
LIMIT 15;

-- Check payments decryption
SELECT 
    COUNT(*) as total_payments,
    SUM(CASE WHEN cardNumber IS NOT NULL THEN 1 ELSE 0 END) as has_card_data,
    SUM(CASE WHEN CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) IS NOT NULL 
        THEN 1 ELSE 0 END) as successfully_decrypted
FROM payments;

-- =====================================================
-- FINAL TEST: Your Original Query
-- =====================================================

SELECT '--- YOUR ORIGINAL QUERY - NOW WORKING ---' as '';
SELECT CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) as decrypted_address 
FROM customers;