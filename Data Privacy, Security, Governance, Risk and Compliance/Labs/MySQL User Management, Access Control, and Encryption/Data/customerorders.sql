-- Create offices table
   CREATE TABLE offices (
       officeCode VARCHAR(10) PRIMARY KEY,
       city VARCHAR(50) NOT NULL,
       phone VARCHAR(50) NOT NULL,
       addressLine1 VARCHAR(50) NOT NULL,
       addressLine2 VARCHAR(50),
       state VARCHAR(50),
       country VARCHAR(50) NOT NULL,
       postalCode VARCHAR(15) NOT NULL,
       territory VARCHAR(10) NOT NULL
   );

   -- Create employees table
   CREATE TABLE employees (
       employeeNumber INT PRIMARY KEY,
       lastName VARCHAR(50) NOT NULL,
       firstName VARCHAR(50) NOT NULL,
       extension VARCHAR(10) NOT NULL,
       email VARCHAR(100) NOT NULL,
       officeCode VARCHAR(10) NOT NULL,
       reportsTo INT,
       jobTitle VARCHAR(50) NOT NULL,
       FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
       FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
   );

   -- Create customers table
   CREATE TABLE customers (
       customerNumber INT PRIMARY KEY,
       customerName VARCHAR(50) NOT NULL,
       contactFirstName VARCHAR(50) NOT NULL,
       contactLastName VARCHAR(50) NOT NULL,
       phone VARCHAR(50) NOT NULL,
       addressLine1 VARCHAR(50) NOT NULL,
       addressLine2 VARCHAR(50),
       city VARCHAR(50) NOT NULL,
       state VARCHAR(50),
       postalCode VARCHAR(15),
       country VARCHAR(50) NOT NULL,
       salesRepEmployeeNumber INT,
       creditLimit DECIMAL(10,2),
       FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
   );

   -- Create productlines table
   CREATE TABLE productlines (
       productLine VARCHAR(50) PRIMARY KEY,
       textDescription VARCHAR(4000),
       htmlDescription MEDIUMTEXT,
       image MEDIUMBLOB
   );

   -- Create products table
   CREATE TABLE products (
       productCode VARCHAR(15) PRIMARY KEY,
       productName VARCHAR(70) NOT NULL,
       productLine VARCHAR(50) NOT NULL,
       productScale VARCHAR(10) NOT NULL,
       productVendor VARCHAR(50) NOT NULL,
       productDescription TEXT NOT NULL,
       quantityInStock SMALLINT NOT NULL,
       buyPrice DECIMAL(10,2) NOT NULL,
       MSRP DECIMAL(10,2) NOT NULL,
       FOREIGN KEY (productLine) REFERENCES productlines(productLine)
   );

   -- Create orders table
   CREATE TABLE orders (
       orderNumber INT PRIMARY KEY,
       orderDate DATE NOT NULL,
       requiredDate DATE NOT NULL,
       shippedDate DATE,
       status VARCHAR(15) NOT NULL,
       comments TEXT,
       customerNumber INT NOT NULL,
       FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
   );

   -- Create orderdetails table
   CREATE TABLE orderdetails (
       orderNumber INT,
       productCode VARCHAR(15),
       quantityOrdered INT NOT NULL,
       priceEach DECIMAL(10,2) NOT NULL,
       orderLineNumber SMALLINT NOT NULL,
       PRIMARY KEY (orderNumber, productCode),
       FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
       FOREIGN KEY (productCode) REFERENCES products(productCode)
   );

   -- Create payments table
   CREATE TABLE payments (
       customerNumber INT,
       checkNumber VARCHAR(50) NOT NULL,
       paymentDate DATE NOT NULL,
       amount DECIMAL(10,2) NOT NULL,
       PRIMARY KEY (customerNumber, checkNumber),
       FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
   );

   -- Insert sample data
   INSERT INTO offices VALUES 
   ('1', 'San Francisco', '+1 650 219 4782', '100 Market Street', 'Suite 300', 'CA', 'USA', '94105', 'NA'),
   ('2', 'Boston', '+1 215 837 0825', '1550 Court Place', 'Suite 102', 'MA', 'USA', '02107', 'NA'),
   ('3', 'Paris', '+33 14 723 4404', '25 Rue Louvre', 'Apt 2', NULL, 'France', '75001', 'EMEA');

   INSERT INTO employees VALUES
   (1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', NULL, 'President'),
   (1056, 'Patterson', 'Mary', 'x4611', 'mpatterso@classicmodelcars.com', '1', 1002, 'VP Sales'),
   (1076, 'Firrelli', 'Jeff', 'x9273', 'jfirrelli@classicmodelcars.com', '1', 1002, 'VP Marketing');

   INSERT INTO customers VALUES
   (103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France', 1056, 21000.00),
   (112, 'Signal Gift Stores', 'King', 'Jean', '7025551838', '8489 Strong St.', NULL, 'Las Vegas', 'NV', '83030', 'USA', 1056, 71800.00);

   INSERT INTO productlines VALUES
   ('Motorcycles', 'Classic motorcycles', '<p>Classic motorcycles</p>', NULL),
   ('Cars', 'Classic cars', '<p>Classic cars</p>', NULL);

   INSERT INTO products VALUES
   ('S10_1678', '1969 Harley Davidson Eagle Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'Features authentic detail', 100, 48.81, 95.70),
   ('S10_1949', '1952 Alpine Renault 1300', 'Cars', '1:10', 'Classic Metal Creations', 'Turnable front wheels', 120, 98.58, 214.30);

   INSERT INTO orders VALUES
   (10100, '2023-01-06', '2023-01-13', '2023-01-10', 'Shipped', NULL, 103),
   (10101, '2023-01-09', '2023-01-18', '2023-01-11', 'Shipped', 'Check on availability', 112);

   INSERT INTO orderdetails VALUES
   (10100, 'S10_1678', 30, 95.70, 1),
   (10100, 'S10_1949', 50, 214.30, 2),
   (10101, 'S10_1678', 25, 95.70, 1);

   INSERT INTO payments VALUES
   (103, 'HQ336336', '2023-10-19', 6066.78),
   (103, 'JM555205', '2023-11-15', 14571.44);