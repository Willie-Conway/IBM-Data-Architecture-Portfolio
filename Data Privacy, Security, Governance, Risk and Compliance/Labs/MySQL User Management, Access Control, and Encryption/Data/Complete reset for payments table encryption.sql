-- =====================================================
-- COMPLETE RESET FOR PAYMENTS TABLE ENCRYPTION
-- =====================================================

USE customerorders;
SET @key_str = SHA2('My secret passphrase', 512);

-- Step 1: Check current state
SELECT '--- CURRENT STATE ---' as '';
SELECT 
    COUNT(*) as total_rows,
    SUM(CASE WHEN cardNumber IS NULL THEN 1 ELSE 0 END) as null_count,
    SUM(CASE WHEN cardNumber IS NOT NULL THEN 1 ELSE 0 END) as has_data_count
FROM payments;

-- Step 2: Drop and recreate the column (clean slate)
ALTER TABLE payments DROP COLUMN cardNumber;
ALTER TABLE payments ADD COLUMN cardNumber VARCHAR(50);

-- Step 3: Populate with sample data for ALL rows
UPDATE payments SET cardNumber = 
    CASE 
        WHEN customerNumber = 103 THEN '4111111111111111'
        WHEN customerNumber = 112 THEN '5500000000000004'
        WHEN customerNumber = 114 THEN '340000000000009'
        WHEN customerNumber = 119 THEN '6011000000000004'
        WHEN customerNumber = 121 THEN '371449635398431'
        WHEN customerNumber = 124 THEN '4532015112890367'
        WHEN customerNumber = 125 THEN '4916835098761432'
        WHEN customerNumber = 128 THEN '4485275842396721'
        WHEN customerNumber = 129 THEN '4556723489012345'
        WHEN customerNumber = 131 THEN '5401234567890123'
        ELSE CONCAT(
            ELT(1 + FLOOR(RAND() * 4), '4', '5', '3', '6'),
            LPAD(FLOOR(RAND() * 1000000000000000), 15, '0')
        )
    END;

-- Step 4: Verify data is populated
SELECT '--- DATA AFTER POPULATION ---' as '';
SELECT customerNumber, checkNumber, cardNumber 
FROM payments 
LIMIT 20;

-- Step 5: Convert to varbinary for encryption
ALTER TABLE payments MODIFY COLUMN cardNumber varbinary(255);

-- Step 6: Encrypt with current key
UPDATE payments SET cardNumber = AES_ENCRYPT(cardNumber, @key_str);
SELECT CONCAT(ROW_COUNT(), ' rows encrypted') as status;

-- Step 7: Verify encryption (should show binary data)
SELECT '--- AFTER ENCRYPTION ---' as '';
SELECT 
    customerNumber, 
    checkNumber, 
    LEFT(HEX(cardNumber), 40) as hex_preview,
    LENGTH(cardNumber) as enc_length
FROM payments 
LIMIT 15;

-- Step 8: TEST DECRYPTION - THIS WILL NOW WORK
SELECT '--- DECRYPTED CARD NUMBERS ---' as '';
SELECT 
    customerNumber,
    checkNumber,
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) as decrypted_card
FROM payments 
LIMIT 20;

-- Step 9: Check success rate
SELECT '--- SUCCESS RATE ---' as '';
SELECT 
    COUNT(*) as total_rows,
    SUM(CASE 
        WHEN CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) IS NOT NULL 
        THEN 1 ELSE 0 
    END) as successfully_decrypted,
    CONCAT(
        ROUND(
            SUM(CASE 
                WHEN CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) IS NOT NULL 
                THEN 1 ELSE 0 
            END) * 100.0 / COUNT(*), 2
        ), '%'
    ) as success_rate
FROM payments;

-- Step 10: Create decrypt function
DROP FUNCTION IF EXISTS decrypt_card;
DELIMITER $$
CREATE FUNCTION decrypt_card(encrypted_data VARBINARY(255)) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE key_str VARBINARY(128);
    SET key_str = SHA2('My secret passphrase', 512);
    RETURN CAST(AES_DECRYPT(encrypted_data, key_str) AS CHAR(50));
END$$
DELIMITER ;

-- Step 11: Create view
CREATE OR REPLACE VIEW vw_payments_secure AS
SELECT 
    p.customerNumber,
    c.customerName,
    p.checkNumber,
    p.paymentDate,
    p.amount,
    decrypt_card(p.cardNumber) as cardNumber
FROM payments p
LEFT JOIN customers c ON p.customerNumber = c.customerNumber;

-- Step 12: Test the view
SELECT '--- VIEW WITH DECRYPTED CARDS ---' as '';
SELECT * FROM vw_payments_secure LIMIT 20;