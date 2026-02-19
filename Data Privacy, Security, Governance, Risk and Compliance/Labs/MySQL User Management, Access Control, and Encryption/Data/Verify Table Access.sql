-- Should work: Can select from customers
USE customerorders;
SELECT customerNumber, customerName, creditLimit FROM customers LIMIT 5;

-- Should work: Can update creditLimit
UPDATE customers SET creditLimit = 150000 WHERE customerNumber = 103;

-- Should FAIL: Cannot update other columns
UPDATE customers SET customerName = 'New Name' WHERE customerNumber = 103;
-- Expected error: UPDATE command denied

-- Should FAIL: Cannot access payments table
SELECT * FROM payments;
-- Expected error: SELECT command denied