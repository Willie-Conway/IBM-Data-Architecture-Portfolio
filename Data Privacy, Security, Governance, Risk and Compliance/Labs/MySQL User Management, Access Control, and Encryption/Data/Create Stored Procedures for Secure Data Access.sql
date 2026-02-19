-- Procedure for admin to view decrypted data
CREATE PROCEDURE GetCustomerFullData(IN p_customerNumber INT)
BEGIN
    DECLARE v_encryption_key VARCHAR(255);
  
    -- Get encryption key (in production, this would be more secure)
    SELECT CAST(AES_DECRYPT(encryption_key, 'key_encryption_key') AS CHAR)
    INTO v_encryption_key
    FROM encryption_keys
    WHERE key_name = 'master_key' AND active = TRUE;
  
    -- Return decrypted data
    SELECT 
        customerNumber,
        customerName,
        contactLastName,
        contactFirstName,
        phone,
        city,
        country,
        creditLimit,
        CAST(AES_DECRYPT(creditCard_encrypted, v_encryption_key) AS CHAR) as creditCard,
        CAST(AES_DECRYPT(taxID_encrypted, v_encryption_key) AS CHAR) as taxID
    FROM customers
    WHERE customerNumber = p_customerNumber;
END//

DELIMITER ;

-- Grant execute permission to admin only
GRANT EXECUTE ON PROCEDURE customerorders.GetCustomerFullData TO 'root'@'localhost';