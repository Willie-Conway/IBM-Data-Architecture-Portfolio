-- Should work: Can insert new customers
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, city, country)
VALUES (999, 'Test Company', 'Test', 'User', '555-1234', 'Test City', 'USA');

-- Should FAIL: Cannot insert into orders (no INSERT permission)
INSERT INTO orders (orderNumber, orderDate, customerNumber) 
VALUES (99999, CURDATE(), 999);
-- Expected error: INSERT command denied