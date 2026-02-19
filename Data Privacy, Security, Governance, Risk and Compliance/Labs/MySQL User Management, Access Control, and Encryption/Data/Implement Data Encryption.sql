-- Set session variable for encryption key
SET @encryption_key = 'CustomerDataKey2024';

-- Encrypt existing data (if any)
UPDATE customers 
SET creditCard_encrypted = AES_ENCRYPT('4111-1111-1111-1111', @encryption_key)
WHERE customerNumber = 103;

UPDATE customers 
SET taxID_encrypted = AES_ENCRYPT('12-3456789', @encryption_key)
WHERE customerNumber = 103;

-- Insert new customer with encrypted data
INSERT INTO customers (
    customerNumber, 
    customerName, 
    contactLastName, 
    contactFirstName, 
    phone, 
    city, 
    country,
    creditCard_encrypted,
    taxID_encrypted
) VALUES (
    998, 
    'Secure Corp', 
    'Johnson', 
    'Robert', 
    '555-9999', 
    'New York', 
    'USA',
    AES_ENCRYPT('5555-5555-5555-5555', @encryption_key),
    AES_ENCRYPT('98-7654321', @encryption_key)
);