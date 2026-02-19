-- Add card numbers to payments table
UPDATE payments SET cardNumber = '4111111111111111' WHERE customerNumber = 103;
UPDATE payments SET cardNumber = '5500000000000004' WHERE customerNumber = 112;
UPDATE payments SET cardNumber = '340000000000009' WHERE customerNumber = 114;
UPDATE payments SET cardNumber = '6011000000000004' WHERE customerNumber = 119;
UPDATE payments SET cardNumber = '371449635398431' WHERE customerNumber = 121;

-- Update any remaining NULLs
UPDATE payments SET cardNumber = CONCAT('****-****-****-', LPAD(FLOOR(RAND() * 10000), 4, '0')) 
WHERE cardNumber IS NULL;

-- Convert to VARBINARY and encrypt
ALTER TABLE payments MODIFY COLUMN cardNumber varbinary(50);
UPDATE payments SET cardNumber = AES_ENCRYPT(cardNumber, @key_str);

-- Test decryption
SELECT 
    customerNumber,
    checkNumber,
    CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(50)) as decrypted_card
FROM payments 
LIMIT 10;