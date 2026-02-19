# Customer Orders Database Entity-Relationship Diagram (ERD)

Based on the provided table structures, here is the complete Entity-Relationship Diagram for the customer orders database:

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                              CUSTOMER ORDERS DATABASE                                │
│                                    ERD Diagram                                        │
└─────────────────────────────────────────────────────────────────────────────────────┘

┌───────────────────┐         ┌───────────────────┐         ┌───────────────────┐
│     offices       │         │    employees      │         │    customers      │
├───────────────────┤         ├───────────────────┤         ├───────────────────┤
│ PK officeCode     │◄────┐   │ PK employeeNumber │──┐      │ PK customerNumber │
│ city              │     └───┤ FK officeCode     │  │      │ customerName      │
│ phone             │         │ lastName          │  │      │ contactFirstName  │
│ addressLine1      │         │ firstName         │  │      │ contactLastName   │
│ addressLine2      │         │ extension         │  │      │ phone             │
│ state             │         │ email             │  │      │ addressLine1      │
│ country           │         │ FK reportsTo      │──┘      │ addressLine2      │
│ postalCode        │         │ jobTitle          │         │ city              │
│ territory         │         └───────────────────┘         │ state             │
└───────────────────┘                                       │ postalCode        │
                                                             │ country           │
                                                             │ FK salesRepEmployee│
                                                             │ creditLimit       │
                                                             └─────────┬─────────┘
                                                                       │
                                                                       │
┌───────────────────┐         ┌───────────────────┐         ┌─────────┴─────────┐
│    products       │         │     orders        │         │    payments       │
├───────────────────┤         ├───────────────────┤         ├───────────────────┤
│ PK productCode    │         │ PK orderNumber    │         │ FK customerNumber │
│ productName       │         │ orderDate         │         │ checkNumber       │
│ productLine       │◄───┐    │ requiredDate      │         │ paymentDate       │
│ productScale      │    │    │ shippedDate       │         │ amount            │
│ productVendor     │    │    │ status            │         └───────────────────┘
│ productDescription│    │    │ comments          │
│ quantityInStock   │    │    │ FK customerNumber │◄────────┘
│ buyPrice          │    │    └─────────┬─────────┘
│ MSRP              │    │              │
└─────────┬─────────┘    │              │
          │              │              │
          │              │              │
┌─────────┴─────────┐    │   ┌──────────▼──────────┐
│   orderdetails    │    │   │   productlines       │
├───────────────────┤    │   ├──────────────────────┤
│ FK orderNumber    │◄───┘   │ PK productLine       │
│ FK productCode    │◄───────┤ textDescription      │
│ quantityOrdered   │        │ htmlDescription      │
│ priceEach         │        │ image                │
│ orderLineNumber   │        └──────────────────────┘
└───────────────────┘
```

---

## Alternative Mermaid.js ERD

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    CUSTOMERS ||--o{ PAYMENTS : makes
    CUSTOMERS }o--|| EMPLOYEES : "has sales representative"
  
    EMPLOYEES ||--o{ EMPLOYEES : "reports to"
    EMPLOYEES }o--|| OFFICES : "assigned to"
  
    ORDERS ||--|{ ORDERDETAILS : contains
    PRODUCTS ||--o{ ORDERDETAILS : "included in"
  
    PRODUCTLINES ||--o{ PRODUCTS : "categorized as"
  
    CUSTOMERS {
        INT customerNumber PK
        VARCHAR(50) customerName
        VARCHAR(50) contactFirstName
        VARCHAR(50) contactLastName
        VARCHAR(50) phone
        VARCHAR(50) addressLine1
        VARCHAR(50) addressLine2
        VARCHAR(50) city
        VARCHAR(50) state
        VARCHAR(15) postalCode
        VARCHAR(50) country
        INT salesRepEmployeeNumber FK
        DECIMAL(10,2) creditLimit
    }
  
    EMPLOYEES {
        INT employeeNumber PK
        VARCHAR(50) lastName
        VARCHAR(50) firstName
        VARCHAR(10) extension
        VARCHAR(100) email
        VARCHAR(10) officeCode FK
        INT reportsTo FK
        VARCHAR(50) jobTitle
    }
  
    OFFICES {
        VARCHAR(10) officeCode PK
        VARCHAR(50) city
        VARCHAR(50) phone
        VARCHAR(50) addressLine1
        VARCHAR(50) addressLine2
        VARCHAR(50) state
        VARCHAR(50) country
        VARCHAR(15) postalCode
        VARCHAR(10) territory
    }
  
    ORDERS {
        INT orderNumber PK
        DATE orderDate
        DATE requiredDate
        DATE shippedDate
        VARCHAR(15) status
        TEXT comments
        INT customerNumber FK
    }
  
    ORDERDETAILS {
        INT orderNumber FK
        VARCHAR(15) productCode FK
        INT quantityOrdered
        DECIMAL(10,2) priceEach
        SMALLINT orderLineNumber
    }
  
    PRODUCTS {
        VARCHAR(15) productCode PK
        VARCHAR(70) productName
        VARCHAR(50) productLine FK
        VARCHAR(10) productScale
        VARCHAR(50) productVendor
        TEXT productDescription
        SMALLINT quantityInStock
        DECIMAL(10,2) buyPrice
        DECIMAL(10,2) MSRP
    }
  
    PRODUCTLINES {
        VARCHAR(50) productLine PK
        VARCHAR(4000) textDescription
        MEDIUMTEXT htmlDescription
        MEDIUMBLOB image
    }
  
    PAYMENTS {
        INT customerNumber FK
        VARCHAR(50) checkNumber
        DATE paymentDate
        DECIMAL(10,2) amount
    }
```

---

## Table Relationships Summary

### Primary Keys

| Table                  | Primary Key                                  |
| ---------------------- | -------------------------------------------- |
| **offices**      | officeCode                                   |
| **employees**    | employeeNumber                               |
| **customers**    | customerNumber                               |
| **orders**       | orderNumber                                  |
| **products**     | productCode                                  |
| **productlines** | productLine                                  |
| **orderdetails** | (orderNumber, productCode) - Composite PK    |
| **payments**     | (customerNumber, checkNumber) - Composite PK |

### Foreign Key Relationships

| Foreign Key                                                            | Referenced Table | Relationship Type |
| ---------------------------------------------------------------------- | ---------------- | ----------------- |
| **employees.officeCode** → offices.officeCode                   | offices          | Many-to-One       |
| **employees.reportsTo** → employees.employeeNumber              | employees        | Self-referential  |
| **customers.salesRepEmployeeNumber** → employees.employeeNumber | employees        | Many-to-One       |
| **orders.customerNumber** → customers.customerNumber            | customers        | Many-to-One       |
| **orderdetails.orderNumber** → orders.orderNumber               | orders           | Many-to-One       |
| **orderdetails.productCode** → products.productCode             | products         | Many-to-One       |
| **products.productLine** → productlines.productLine             | productlines     | Many-to-One       |
| **payments.customerNumber** → customers.customerNumber          | customers        | Many-to-One       |

---

## Relationship Cardinalities

| Relationship                      | Cardinality | Description                                                      |
| --------------------------------- | ----------- | ---------------------------------------------------------------- |
| **offices : employees**     | 1 : N       | One office can have many employees                               |
| **employees : employees**   | 1 : N       | One employee (manager) can have many employees reporting to them |
| **employees : customers**   | 1 : N       | One employee (sales rep) can serve many customers                |
| **customers : orders**      | 1 : N       | One customer can place many orders                               |
| **customers : payments**    | 1 : N       | One customer can make many payments                              |
| **orders : orderdetails**   | 1 : N       | One order can contain many order details (line items)            |
| **products : orderdetails** | 1 : N       | One product can appear in many order details                     |
| **productlines : products** | 1 : N       | One product line can contain many products                       |

---

## Table Descriptions

### 1. **offices**

Stores company office locations information including contact details and address.

### 2. **employees**

Contains employee information including personal details, job title, and reporting relationships.

### 3. **customers**

Stores customer information including contact details, address, credit limit, and assigned sales representative.

### 4. **orders**

Tracks customer orders including order dates, required/shipped dates, and order status.

### 5. **orderdetails**

Line items for each order, showing which products were ordered, quantities, and prices.

### 6. **products**

Catalog of products available for sale with descriptions, pricing, and inventory information.

### 7. **productlines**

Categories or product lines that group similar products together, with descriptions and images.

### 8. **payments**

Records of payments made by customers, including check numbers, dates, and amounts.

---

## Sample SQL for Creating Tables with Relationships

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
```
