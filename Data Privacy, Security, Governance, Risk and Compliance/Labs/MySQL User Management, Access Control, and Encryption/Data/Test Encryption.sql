-- Test 1: View as sales_rep (should see encrypted data as 'ENCRYPTED')
-- Login as sales_rep
mysql -u sales_rep -p

USE customerorders;
SELECT * FROM customers_sales_rep_view WHERE customerNumber = 103;
-- Expected: creditCard_status and taxID_status show as 'ENCRYPTED'

-- Test 2: Try to access encrypted data directly (should fail)
SELECT creditCard_encrypted FROM customers;
-- Expected error: SELECT command denied

-- Test 3: View as admin (should see decrypted data)
-- Login as root
mysql -u root -p

USE customerorders;
CALL GetCustomerFullData(103);
-- Expected: Shows actual credit card number and tax ID

-- Test 4: Verify encryption
SELECT 
    customerNumber,
    customerName,
    HEX(creditCard_encrypted) as encrypted_cc_hex,
    LENGTH(creditCard_encrypted) as encrypted_length
FROM customers
WHERE customerNumber = 103;
-- Expected: Shows hex representation of encrypted data