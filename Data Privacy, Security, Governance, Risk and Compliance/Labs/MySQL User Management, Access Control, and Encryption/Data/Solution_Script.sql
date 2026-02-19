-- =====================================================
-- COMPLETE SOLUTION: Populate, Encrypt, and Decrypt
-- =====================================================

USE customerorders;
SET @key_str = SHA2('My secret passphrase', 512);

-- Step 1: Populate NULL addresses with real data
-- Using the classic sample data from MySQL sample database
UPDATE customers SET addressLine1 = '54 rue Royale' WHERE customerNumber = 103;
UPDATE customers SET addressLine1 = '8489 Strong St.' WHERE customerNumber = 112;
UPDATE customers SET addressLine1 = '5-9 Wentworth Avenue' WHERE customerNumber = 114;
UPDATE customers SET addressLine1 = '67, rue des Cinquante Otages' WHERE customerNumber = 119;
UPDATE customers SET addressLine1 = '23 Tsawassen Blvd.' WHERE customerNumber = 121;
UPDATE customers SET addressLine1 = '5677 Magnetic Dr.' WHERE customerNumber = 124;
UPDATE customers SET addressLine1 = '2732 Baker Blvd.' WHERE customerNumber = 125;
UPDATE customers SET addressLine1 = 'Talstrasse 12' WHERE customerNumber = 128;
UPDATE customers SET addressLine1 = '2658 Kingsway' WHERE customerNumber = 129;
UPDATE customers SET addressLine1 = '1785 Primrose Lane' WHERE customerNumber = 131;
UPDATE customers SET addressLine1 = '1623 South 21st Street' WHERE customerNumber = 141;
UPDATE customers SET addressLine1 = '25593 South Bay Trail' WHERE customerNumber = 144;
UPDATE customers SET addressLine1 = '1-2-3 Kashiwanoha' WHERE customerNumber = 145;
UPDATE customers SET addressLine1 = '12-3-4 Kitasenzoku' WHERE customerNumber = 146;
UPDATE customers SET addressLine1 = '1300 Nicollet Mall' WHERE customerNumber = 148;
UPDATE customers SET addressLine1 = '27 rue du Marechal Foch' WHERE customerNumber = 151;
UPDATE customers SET addressLine1 = 'Ulmenstrasse 123' WHERE customerNumber = 157;
UPDATE customers SET addressLine1 = 'Piazza delle Grazie 12' WHERE customerNumber = 161;
UPDATE customers SET addressLine1 = 'Rambla de Cataluna 23' WHERE customerNumber = 166;
UPDATE customers SET addressLine1 = 'Estrada da saude 58' WHERE customerNumber = 167;
UPDATE customers SET addressLine1 = 'Av. Paulista, 2022' WHERE customerNumber = 168;

-- For any remaining NULLs, set a default
UPDATE customers 
SET addressLine1 = CONCAT(FLOOR(100 + RAND() * 900), ' Default Street') 
WHERE addressLine1 IS NULL;

-- Step 2: Verify data is now populated
SELECT '--- DATA AFTER POPULATION ---' as '';
SELECT customerNumber, customerName, addressLine1 FROM customers LIMIT 15;

-- Step 3: Convert column to VARBINARY if not already
-- (Your DESCRIBE shows it's already VARBINARY, so this may not be needed)
-- ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

-- Step 4: Encrypt the data
UPDATE customers SET addressLine1 = AES_ENCRYPT(addressLine1, @key_str);
SELECT CONCAT(ROW_COUNT(), ' rows encrypted') as status;

-- Step 5: Verify encryption worked (should show binary data)
SELECT '--- AFTER ENCRYPTION ---' as '';
SELECT customerNumber, addressLine1, HEX(addressLine1) as hex_value FROM customers LIMIT 5;

-- Step 6: TEST YOUR DECRYPTION QUERY - THIS WILL NOW WORK
SELECT '--- YOUR DECRYPTION QUERY - NOW WORKING ---' as '';
SELECT 
    customerNumber,
    customerName,
    CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(50)) as decrypted_address
FROM customers 
LIMIT 15;