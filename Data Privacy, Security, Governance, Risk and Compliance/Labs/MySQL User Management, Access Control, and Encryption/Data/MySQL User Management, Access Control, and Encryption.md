
![Logo](<../Screenshots/MySQL User Management, Access Control, and Encryption.png>)

# MySQL User Management, Access Control, and Encryption

## Estimated time needed: 30 minutes

---

## Objectives

After completing this lab, you will be able to:

- Manage MySQL user accounts and roles using the phpMyAdmin graphical user interface (GUI) tool
- Control access to MySQL databases and their objects
- Secure your data by adding an extra layer of security using data encryption

---

## Prerequisites

### Database

In this lab, you will use a **customer orders database**. The following ERD diagram shows the complete schema of the customer orders database with all tables and their relationships:

![ERD](<../Screenshots/ERD.png>)


### Table Structures

#### offices

| Column       | Type        | Description        |
| ------------ | ----------- | ------------------ |
| officeCode   | VARCHAR(10) | Primary Key        |
| city         | VARCHAR(50) | Office city        |
| phone        | VARCHAR(50) | Contact phone      |
| addressLine1 | VARCHAR(50) | Street address     |
| addressLine2 | VARCHAR(50) | Additional address |
| state        | VARCHAR(50) | State/Province     |
| country      | VARCHAR(50) | Country            |
| postalCode   | VARCHAR(15) | ZIP/Postal code    |
| territory    | VARCHAR(10) | Sales territory    |

#### employees

| Column         | Type         | Description              |
| -------------- | ------------ | ------------------------ |
| employeeNumber | INT          | Primary Key              |
| lastName       | VARCHAR(50)  | Last name                |
| firstName      | VARCHAR(50)  | First name               |
| extension      | VARCHAR(10)  | Phone extension          |
| email          | VARCHAR(100) | Email address            |
| officeCode     | VARCHAR(10)  | Foreign Key → offices   |
| reportsTo      | INT          | Foreign Key → employees |
| jobTitle       | VARCHAR(50)  | Job position             |

#### customers

| Column                 | Type          | Description              |
| ---------------------- | ------------- | ------------------------ |
| customerNumber         | INT           | Primary Key              |
| customerName           | VARCHAR(50)   | Company name             |
| contactFirstName       | VARCHAR(50)   | Contact first name       |
| contactLastName        | VARCHAR(50)   | Contact last name        |
| phone                  | VARCHAR(50)   | Contact phone            |
| addressLine1           | VARCHAR(50)   | Street address           |
| addressLine2           | VARCHAR(50)   | Additional address       |
| city                   | VARCHAR(50)   | City                     |
| state                  | VARCHAR(50)   | State/Province           |
| postalCode             | VARCHAR(15)   | ZIP/Postal code          |
| country                | VARCHAR(50)   | Country                  |
| salesRepEmployeeNumber | INT           | Foreign Key → employees |
| creditLimit            | DECIMAL(10,2) | Credit limit             |

#### productlines

| Column          | Type          | Description                |
| --------------- | ------------- | -------------------------- |
| productLine     | VARCHAR(50)   | Primary Key                |
| textDescription | VARCHAR(4000) | Description                |
| htmlDescription | MEDIUMTEXT    | HTML formatted description |
| image           | MEDIUMBLOB    | Product line image         |

#### products

| Column             | Type          | Description                 |
| ------------------ | ------------- | --------------------------- |
| productCode        | VARCHAR(15)   | Primary Key                 |
| productName        | VARCHAR(70)   | Product name                |
| productLine        | VARCHAR(50)   | Foreign Key → productlines |
| productScale       | VARCHAR(10)   | Scale model size            |
| productVendor      | VARCHAR(50)   | Supplier                    |
| productDescription | TEXT          | Full description            |
| quantityInStock    | SMALLINT      | Available inventory         |
| buyPrice           | DECIMAL(10,2) | Cost price                  |
| MSRP               | DECIMAL(10,2) | Suggested retail price      |

#### orders

| Column         | Type        | Description              |
| -------------- | ----------- | ------------------------ |
| orderNumber    | INT         | Primary Key              |
| orderDate      | DATE        | Date ordered             |
| requiredDate   | DATE        | Delivery deadline        |
| shippedDate    | DATE        | Actual ship date         |
| status         | VARCHAR(15) | Order status             |
| comments       | TEXT        | Special instructions     |
| customerNumber | INT         | Foreign Key → customers |

#### orderdetails

| Column          | Type          | Description                                    |
| --------------- | ------------- | ---------------------------------------------- |
| orderNumber     | INT           | Foreign Key → orders (Part of Composite PK)   |
| productCode     | VARCHAR(15)   | Foreign Key → products (Part of Composite PK) |
| quantityOrdered | INT           | Quantity ordered                               |
| priceEach       | DECIMAL(10,2) | Price per unit                                 |
| orderLineNumber | SMALLINT      | Line item number                               |

#### payments

| Column         | Type          | Description                                     |
| -------------- | ------------- | ----------------------------------------------- |
| customerNumber | INT           | Foreign Key → customers (Part of Composite PK) |
| checkNumber    | VARCHAR(50)   | Check reference (Part of Composite PK)          |
| paymentDate    | DATE          | Payment date                                    |
| amount         | DECIMAL(10,2) | Payment amount                                  |

---

## Exercise 1: Manage MySQL user accounts and roles

In this exercise, you will learn how to manage MySQL user accounts and roles using phpMyAdmin.

**User management** is the process of controlling which users are allowed to connect to the MySQL server and what permissions they have on each database. phpMyAdmin does not handle user management; rather, it passes the username and password on to MySQL, which then determines whether a user is permitted to perform a particular action. Within phpMyAdmin, administrators have full control over creating users, viewing and editing privileges for existing users, and removing users.

---

### Task 1.1: Access MySQL via Skills Network Toolbox

1. Go to **Skills Network Toolbox** by clicking the following icon from the side-by-side launched Cloud IDE:

   
![Logo](<../Screenshots/Skills network Icon.png>)


2. From the **Databases** drop-down menu, click **MySQL** to open the MySQL service session tab.
3. Click the **Create** button and wait until the MySQL service session gets launched.

   > The MySQL server will take a few moments to start. Once it is ready, you will see the green "Active" label at the top of the window.
   >
4. Whenever you are required to enter your MySQL service session password from the MySQL service session tab at any step of the lab:

   - Copy the password by clicking on the small copy button on the right of the password block
   - Paste the password into the terminal using **Ctrl + V** (Mac: **⌘ + V**)
   - Press **Enter** on the keyboard

   > **Note:** For security reasons, you will not see the password as it is entered on the terminal.
   >

---

### Task 1.2: Access phpMyAdmin and Create Database

1. Click the **phpMyAdmin** button from the MySQL service session tab. You will see the phpMyAdmin GUI tool.
2. In the tree view, click **New** to create a new empty database. Then, enter **customerorders** as the name of the database and click **Create**.

   ```
   Database name: customerorders
   ```
3. Go to the **Import** tab. Download the database creation script using the following SQL:

   ```sql
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
   ```

   Save this script as `customerorders.sql` on your local computer. Then click **Choose File**, select the script, and click **Import**. You will be notified when the import is successfully finished. Click the **Home** icon.

---

### Task 1.3: Create a User Account with Custom Role

Now, you will create a user account with the custom role **"sales_rep"**. The sales_rep role will have access to limited tables.

1. Go to the **User accounts** tab and click **Add user account**.
2. Fill in the Login Information as shown in the following:

   | Field               | Value                                    |
   | ------------------- | ---------------------------------------- |
   | **User name** | `sales_rep`                            |
   | **Host name** | `localhost`                            |
   | **Password**  | `SalesRep2024!` (or your own password) |
   | **Re-type**   | `SalesRep2024!`                        |
3. Under **Global privileges**, select the following options under **Data**:

   - ✅ **SELECT**
   - ✅ **INSERT**
   - ✅ **UPDATE**
4. Scroll down and click **Go**.
5. You have successfully created a user account with appropriate privileges.

   **Verification:**

   ```sql
   -- You should see the new user in the user accounts list
   -- User: sales_rep@localhost
   -- Global privileges: SELECT, INSERT, UPDATE
   ```

---

## Exercise 2: Control access to MySQL databases and their objects

In this exercise, you will learn how to control access to MySQL databases and their objects by modifying user privileges.

### Task 2.1: Modify User Privileges

Making an exception to the user definition of the sales_rep role you created earlier, you will modify the privileges of this user. You will:

1. **Remove access to payments table** for sales_rep user
2. **Restrict sales_rep from updating all columns** except the column `creditLimit` of the table `customers` in the database `customerorders`

#### Step 1: Access User Privileges

1. Go to **Home** > **User accounts** tab.
2. Click the **Edit privileges** option for the `sales_rep` user name.

#### Step 2: Grant Database-Specific Privileges

1. Under the **Database** sub-tab, select the **customerorders** database from the dropdown menu and click **Go**.
2. Under **Database-specific privileges**, select the following options:

   - ✅ **SELECT**
   - ✅ **INSERT**
   - ✅ **UPDATE**
3. Click **Go** at the bottom to apply these privileges.

#### Step 3: Remove Access to Payments Table

1. Switch to the **Table** sub-tab.
2. Select the table **payments** from the drop-down menu and click **Go**.
3. You will see the current privileges for this table. To remove access:

   - **Uncheck** all privilege options (SELECT, INSERT, UPDATE, etc.)
   - This effectively revokes all privileges on the payments table
4. Click **Go** to apply the changes.

#### Step 4: Restrict Column-Level Updates

Now, you will restrict the sales_rep user to only update the `creditLimit` column in the `customers` table.

1. Still in the **Table** sub-tab, select the table **customers** from the drop-down menu and click **Go**.
2. Click **Add privileges on the following columns** (or edit existing privileges).
3. You will see a list of all columns in the customers table. To grant UPDATE privilege only on `creditLimit`:

   - For **UPDATE**, check only the box next to **creditLimit**
   - Leave all other columns unchecked for UPDATE
   - Ensure **SELECT** is checked for all columns the user needs to view

   ```
   Columns with UPDATE privilege:
   ✓ creditLimit

   Columns with SELECT privilege (for viewing):
   ✓ customerNumber
   ✓ customerName
   ✓ contactLastName
   ✓ contactFirstName
   ✓ phone
   ✓ addressLine1
   ✓ addressLine2
   ✓ city
   ✓ state
   ✓ postalCode
   ✓ country
   ✓ salesRepEmployeeNumber
   ✓ creditLimit
   ```
4. Click **Go** to apply the column-level privileges.

---

### Task 2.2: Verify Access Controls

#### Test 1: Login as sales_rep

```bash
# From MySQL command line or new phpMyAdmin window
# Login with sales_rep credentials
mysql -u sales_rep -p -h localhost
# Enter password: SalesRep2024!
```

#### Test 2: Verify Table Access

```sql
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
```

#### Test 3: Verify INSERT Permission

```sql
-- Should work: Can insert new customers
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, city, country)
VALUES (999, 'Test Company', 'Test', 'User', '555-1234', 'Test City', 'USA');

-- Should FAIL: Cannot insert into orders (no INSERT permission)
INSERT INTO orders (orderNumber, orderDate, customerNumber) 
VALUES (99999, CURDATE(), 999);
-- Expected error: INSERT command denied
```

---

## Exercise 3: Secure Data with Encryption

In this exercise, you will learn how to add an extra layer of security using data encryption for sensitive information.

### Task 3.1: Create Encrypted Columns

```sql
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
```

### Task 3.2: Implement Data Encryption

```sql
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
```

### Task 3.3: Create Views for Secure Data Access

```sql
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
```

### Task 3.4: Create Stored Procedures for Secure Data Access

```sql
DELIMITER //

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
```

### Task 3.5: Test Encryption

```sql
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
```

---

## Lab Summary

In this lab, you have successfully:

| Exercise             | Task                                                   | Completed |
| -------------------- | ------------------------------------------------------ | --------- |
| **Exercise 1** | Created MySQL user accounts using phpMyAdmin           | ⬜        |
|                      | Assigned global privileges (SELECT, INSERT, UPDATE)    | ⬜        |
| **Exercise 2** | Modified database-specific privileges                  | ⬜        |
|                      | Revoked access to specific tables (payments)           | ⬜        |
|                      | Implemented column-level privileges (creditLimit only) | ⬜        |
|                      | Tested access controls with various scenarios          | ⬜        |
| **Exercise 3** | Added encrypted columns for sensitive data             | ⬜        |
|                      | Implemented AES encryption for sensitive fields        | ⬜        |
|                      | Created secure views for role-based access             | ⬜        |
|                      | Created stored procedures for decrypted access         | ⬜        |
|                      | Tested encryption implementation                       | ⬜        |

---

## Key Takeaways

1. **User Management**: phpMyAdmin provides a GUI for creating and managing MySQL users with specific privileges.
2. **Access Control**: Privileges can be granted at multiple levels:

   - Global level (all databases)
   - Database level (specific database)
   - Table level (specific tables)
   - Column level (specific columns)
3. **Principle of Least Privilege**: Users should only have the minimum privileges necessary to perform their jobs.
4. **Data Encryption**:

   - Use `AES_ENCRYPT()` and `AES_DECRYPT()` functions
   - Store encrypted data in `VARBINARY` columns
   - Create views to mask sensitive data
   - Use stored procedures for controlled decrypted access
5. **Security Best Practices**:

   - Never store encryption keys in the database
   - Use strong passwords and MFA where possible
   - Regular audit of user privileges
   - Implement column-level restrictions for sensitive operations

---

## Troubleshooting Tips

| Issue                                  | Solution                                                      |
| -------------------------------------- | ------------------------------------------------------------- |
| **Cannot login as new user**     | Verify hostname is correct (usually 'localhost')              |
| **Privileges not taking effect** | Run `FLUSH PRIVILEGES;`                                     |
| **Encryption key errors**        | Ensure key length matches AES requirements (128/192/256 bits) |
| **Access denied after changes**  | Check if REVOKE commands removed necessary privileges         |
| **View not showing data**        | Verify SELECT privilege on underlying tables                  |

---

## Additional Resources

- [MySQL User Account Management Documentation](https://dev.mysql.com/doc/refman/8.0/en/user-account-management.html)
- [MySQL Encryption Functions](https://dev.mysql.com/doc/refman/8.0/en/encryption-functions.html)
- [phpMyAdmin User Management Guide](https://docs.phpmyadmin.net/en/latest/privileges.html)
