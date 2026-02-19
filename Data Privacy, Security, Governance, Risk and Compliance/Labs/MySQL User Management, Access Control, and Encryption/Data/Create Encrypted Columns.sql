-- Connect as admin user (root)
mysql -u root -p

USE customerorders;

-- Add encrypted columns for sensitive customer data
ALTER TABLE customers 
ADD COLUMN creditCard_encrypted VARBINARY(255),
ADD COLUMN taxID_encrypted VARBINARY(255);

-- Create a table for encryption keys (in production, use a key management service)
CREATE TABLE encryption_keys (
    key_id INT PRIMARY KEY AUTO_INCREMENT,
    key_name VARCHAR(50) UNIQUE,
    encryption_key VARBINARY(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE
);

-- Insert an encryption key (in production, store this securely)
INSERT INTO encryption_keys (key_name, encryption_key) 
VALUES ('master_key', AES_ENCRYPT('CustomerDataKey2024', 'key_encryption_key'));