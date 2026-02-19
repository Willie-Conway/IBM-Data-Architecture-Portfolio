-- Create a view for sales_rep that hides encrypted data
CREATE VIEW customers_sales_rep_view AS
SELECT 
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    city,
    country,
    creditLimit,
    'ENCRYPTED' as creditCard_status,
    'ENCRYPTED' as taxID_status
FROM customers;

-- Grant access to the view instead of the base table
GRANT SELECT ON customerorders.customers_sales_rep_view TO 'sales_rep'@'localhost';
REVOKE SELECT ON customerorders.customers FROM 'sales_rep'@'localhost';