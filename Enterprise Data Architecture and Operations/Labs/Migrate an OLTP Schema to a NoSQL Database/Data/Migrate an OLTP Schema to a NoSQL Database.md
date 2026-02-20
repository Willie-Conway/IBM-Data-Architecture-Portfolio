
![Logo](<../../Redesign a schema designed for OLTP and modify it to suit OLAP/Screenshots/FinHub bank.png>)


# Lab: Migrate an OLTP Schema to a NoSQL Database

## Estimated time: 30 minutes

---

## Learning objectives

After completing this lab, you will be able to:

- Apply database design principles to create a well-structured OLTP schema
- Implement data loading techniques to populate the OLTP database efficiently
- Migrate a relational MySQL schema to a NoSQL document database (MongoDB)
- Understand the differences between relational and document-based data modeling

---

## Welcome to the lab on migrating an OLTP schema to a NoSQL Database!

---

## About SN Labs and Cloud IDE

**Skills Network (SN) Labs** offer a fully functional environment - **Cloud IDE** - for course and project-related labs. It runs on **Theia**, an open-source integrated development environment (IDE) compatible with desktop and cloud platforms.

With this Cloud IDE, you can access Theia and MySQL, both running in a Docker container. It has all the essential tools needed to complete your lab efficiently.

### Tools or software used

- MySQL 8.0.22
- phpMyAdmin 5.0.4
- MongoDB (via Docker container or cloud connection)
- MongoDB Compass (optional, for GUI interaction)

### Consideration to work in the lab environment

> **This lab environment does not save your session data.** Each time you connect, a new environment is created. Any data saved during a previous session will be lost.
>
> To prevent data loss, plan to complete the lab in a single session.

---

## Scenario overview

As a data engineer at **FinHub Bank**, you are responsible for migrating the bank's data platform to a NoSQL environment using MongoDB. This transition will replace MySQL with MongoDB as the primary OLTP (Online Transaction Processing) database, providing a more flexible and scalable solution for storing transactional data.

In this lab, you will work with the **FinHub Bank database** in a NoSQL setup. The MongoDB collections provided in the lab instructions are strongly recommended for successful completion.

### Why Migrate from MySQL to MongoDB?

| Aspect                               | MySQL (Relational)               | MongoDB (NoSQL)                  | Benefit of Migration     |
| ------------------------------------ | -------------------------------- | -------------------------------- | ------------------------ |
| **Schema**                     | Rigid, predefined schema         | Flexible, dynamic schema         | Easier to add new fields |
| **Scalability**                | Vertical scaling (scale up)      | Horizontal scaling (scale out)   | Better for growth        |
| **Data Model**                 | Normalized tables with JOINs     | Embedded documents or references | Faster reads, no JOINs   |
| **Development Speed**          | Slayer for evolving requirements | Faster for agile development     | Quicker feature delivery |
| **Handling Unstructured Data** | Difficult                        | Native support                   | Better for diverse data  |

---

## FinHub Bank Database Schema (MySQL OLTP)

Below is the Entity Relationship Diagram (ERD) for the FinHub database, representing its schema:

```
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│  account_type   │         │   branches      │         │   countries     │
├─────────────────┤         ├─────────────────┤         ├─────────────────┤
│ ID              │         │ BranchCode (PK) │         │ CountryID       │
│ AccountType (PK)│         │ BranchName      │         │ CountryName (PK)│
└─────────────────┘         └─────────────────┘         │ CountryCode     │
        │                            │                   │ Continent       │
        │                            │                   └─────────────────┘
        │                            │                            │
        │                            │                            │
        ↓                            ↓                            ↓
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              customer_data                                        │
├─────────────────────────────────────────────────────────────────────────────────┤
│ CustomerID                                                                       │
│ CustomerName                                                                     │
│ Email                                                                            │
│ DateOfBirth                                                                      │
│ AccountId (PK)                                                                   │
│ AccountType (FK) ───────────────────────────────────────────────────────────────┘
│ BranchCode (FK) ─────────────────────────────────────────────────────────────────┘
│ Country (FK) ────────────────────────────────────────────────────────────────────┘
│ DateJoined                                                                       │
│ Balance                                                                          │
└─────────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │
                                    ↓
┌─────────────────────────────────────────────────────────────────────────────────┐
│                            transaction_data                                       │
├─────────────────────────────────────────────────────────────────────────────────┤
│ TransactionID                                                                    │
│ AccountId (FK) ─────────────────────────────────────────────────────────────────┘
│ TransactionDate                                                                  │
│ TransactionType                                                                  │
│ TransactionAmount                                                                │
│ TransactionLocation (FK) ──────────────────────────────────────────────────────┐
└─────────────────────────────────────────────────────────────────────────────────┘
                                                                                  │
                                                                                  ↓
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                us_cities                                          │
├─────────────────────────────────────────────────────────────────────────────────┤
│ Id                                                                               │
│ CityCode                                                                         │
│ CityName (PK)                                                                    │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Understanding Relational vs Document Data Modeling

### Relational Model (MySQL)

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│   customers     │      │    accounts     │      │  transactions   │
├─────────────────┤      ├─────────────────┤      ├─────────────────┤
│ customer_id PK  │◄─────┤ customer_id FK  │      │ transaction_id  │
│ name            │      │ account_id PK   │◄─────┤ account_id FK   │
│ email           │      │ account_type    │      │ amount          │
│ date_joined     │      │ balance         │      │ date            │
└─────────────────┘      └─────────────────┘      └─────────────────┘
         │                       │                          │
         │                       │                          │
         ▼                       ▼                          ▼
    Lookup Tables          Lookup Tables              Lookup Tables
    ┌─────────────┐        ┌─────────────┐            ┌─────────────┐
    │ countries   │        │ branches    │            │ us_cities   │
    └─────────────┘        └─────────────┘            └─────────────┘
```

### Document Model (MongoDB)

```
┌─────────────────────────────────────────────────────────────────┐
│                      CUSTOMER DOCUMENT                           │
├─────────────────────────────────────────────────────────────────┤
│ {                                                                 │
│   _id: ObjectId,                                                 │
│   customer_id: 101,                                              │
│   name: "Alice Johnson",                                         │
│   email: "alice.j@example.com",                                  │
│   date_joined: "2020-01-15",                                     │
│   country: {                                                      │
│     name: "United States",                                       │
│     code: "US",                                                   │
│     continent: "North America"                                    │
│   },                                                              │
│   accounts: [                                                     │
│     {                                                            │
│       account_id: "ACCT-10002345",                               │
│       type: "Savings",                                            │
│       balance: 12000,                                             │
│       branch: {                                                   │
│         code: "BR001",                                            │
│         name: "Downtown Branch"                                   │
│       },                                                          │
│       transactions: [                                             │
│         {                                                        │
│           transaction_id: 201,                                    │
│           date: "2022-01-05",                                     │
│           type: "Deposit",                                        │
│           amount: 500,                                            │
│           location: {                                             │
│             city: "New York",                                     │
│             state: "NY"                                           │
│           }                                                       │
│         },                                                        │
│         ... more transactions ...                                 │
│       ]                                                           │
│     },                                                            │
│     ... more accounts ...                                         │
│   ]                                                               │
│ }                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Exercise 1: Setting up the OLTP Database (MySQL)

In this exercise, you will set up the MySQL database that will serve as the source for migration.

### Task 1.1: Access the MySQL Database

**Step 1:** Tap the **DATABASES** tab, and from the dropdown menu, select **MySQL** to open the MySQL service session tab.

**Step 2:** Click the **Create** button and wait until the MySQL service session gets launched.

**Step 3:** Click the **phpMyAdmin** button to access the phpMyAdmin interface.

### Task 1.2: Create the FinHub Database

**Step 1:** In phpMyAdmin, click **New** to create a new database.

**Step 2:** Enter **finhub** as the database name and click **Create**.

```
Database name: finhub
```

### Task 1.3: Create the MySQL OLTP Schema

Run the following SQL to create the OLTP schema:

```sql
-- Create account_type table
CREATE TABLE account_type (
    ID int DEFAULT NULL,
    AccountType varchar(100) DEFAULT NULL,
    UNIQUE KEY AccountType_UNIQUE (AccountType)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create branches table
CREATE TABLE branches (
    BranchCode varchar(100) DEFAULT NULL,
    BranchName text,
    UNIQUE KEY BranchCode_UNIQUE (BranchCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create countries table
CREATE TABLE countries (
    CountryID int DEFAULT NULL,
    CountryName varchar(100) DEFAULT NULL,
    CountryCode text,
    Continent text,
    UNIQUE KEY CountryName_UNIQUE (CountryName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create us_cities table
CREATE TABLE us_cities (
    Id int DEFAULT NULL,
    CityCode text,
    CityName varchar(100) DEFAULT NULL,
    UNIQUE KEY CityName_UNIQUE (CityName),
    KEY idx (CityName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create customer_data table
CREATE TABLE customer_data (
    CustomerID int DEFAULT NULL,
    CustomerName text,
    Email text,
    DateOfBirth text,
    AccountId varchar(100) DEFAULT NULL,
    AccountType varchar(100) DEFAULT NULL,
    BranchCode varchar(100) DEFAULT NULL,
    Country varchar(100) DEFAULT NULL,
    DateJoined text,
    Balance int DEFAULT NULL,
    UNIQUE KEY AccountId_UNIQUE (AccountId),
    KEY actype_idx (AccountType),
    KEY bcode_idx (BranchCode),
    KEY ctry_idx (Country),
    CONSTRAINT actype FOREIGN KEY (AccountType) REFERENCES account_type (AccountType),
    CONSTRAINT bcode FOREIGN KEY (BranchCode) REFERENCES branches (BranchCode),
    CONSTRAINT ctry FOREIGN KEY (Country) REFERENCES countries (CountryName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create transaction_data table
CREATE TABLE transaction_data (
    TransactionID int DEFAULT NULL,
    AccountId varchar(100) DEFAULT NULL,
    TransactionDate text,
    TransactionType text,
    TransactionAmount int DEFAULT NULL,
    TransactionLocation varchar(100) DEFAULT NULL,
    KEY LOC_idx (TransactionLocation),
    KEY acct_idx (AccountId),
    CONSTRAINT acct FOREIGN KEY (AccountId) REFERENCES customer_data (AccountId),
    CONSTRAINT LOC FOREIGN KEY (TransactionLocation) REFERENCES us_cities (CityName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

### Task 1.4: Load Data into MySQL

```sql
-- Load account_type data
INSERT INTO account_type (ID, AccountType) VALUES
(1,'Savings'), (2,'Current'), (3,'Overdraft'), (4,'Checking'),
(5,'Recurring deposit account'), (6,'Salary account'), (7,'Fixed deposit account');

-- Load branches data
INSERT INTO branches (BranchCode, BranchName) VALUES
('BR001','Downtown Branch'), ('BR002','Midtown Branch'), ('BR003','Riverside Branch'),
('BR004','Central Branch'), ('BR005','Westside Branch'), ('BR006','East End Branch'),
('BR007','Northside Branch'), ('BR008','Southside Branch'), ('BR009','Uptown Branch'),
('BR010','Greenfield Branch');

-- Load countries data (abbreviated)
INSERT INTO countries (CountryID, CountryName, CountryCode, Continent) VALUES
(183,'United States','US','North America'),
(32,'Canada','CA','North America'),
(182,'United Kingdom','GB','Europe'),
(9,'Australia','AU','Oceania'),
(123,'New Zealand','NZ','Oceania');

-- Load us_cities data
INSERT INTO us_cities (Id, CityCode, CityName) VALUES
(83,'NY','New York'), (59,'LA','Los Angeles'), (28,'DAL','Dallas'),
(108,'SF','San Francisco'), (22,'CIN','Cincinnati'), (122,'TX','Texas');

-- Load customer_data
INSERT INTO customer_data (CustomerID, CustomerName, Email, DateOfBirth, AccountId, AccountType, BranchCode, Country, DateJoined, Balance) VALUES
(101,'Alice Johnson','alice.j@example.com','1990-05-21','ACCT-10002345','Savings','BR001','United States','2020-01-15',12000),
(102,'Bob Smith','bob.smith@xyz.com','1985-08-15','ACCT-10005678','Checking','BR002','United States','2019-11-30',3000),
(103,'Cathy Davis','cathy.davis@example.com','1992-11-03','ACCT-10007891','Savings','BR003','United States','2021-06-01',8500),
(104,'David Lee','david.l@xyz.com','1978-02-28','ACCT-10001234','Savings','BR004','United States','2021-03-20',5000),
(105,'Eva Turner','','1989-04-07','ACCT-10003456','Checking','BR005','United States','2020-07-19',-1000),
(106,'Frank Zhang','frank.zhang@xyz.com','1975-12-13','ACCT-10004567','Savings','BR006','United States','2018-09-11',7500),
(107,'Gina King','gina.k@example.com','1993-03-20','ACCT-10008901','Savings','BR007','Canada','2022-01-09',20000),
(108,'Harry Brown','harry.b@xyz.com','1987-09-15','ACCT-10006789','Checking','BR008','United States','2020-08-21',3500),
(109,'Ivy Scott','ivy.scott@example.com','','ACCT-10009876','Savings','BR009','Canada','2021-11-14',8000),
(110,'John Doe','','1990-01-01','ACCT-10005432','Savings','BR010','United States','2022-03-29',0);

-- Load transaction_data
INSERT INTO transaction_data (TransactionID, AccountId, TransactionDate, TransactionType, TransactionAmount, TransactionLocation) VALUES
(201,'ACCT-10002345','2022-01-05','Deposit',500,'New York'),
(202,'ACCT-10005678','2022-02-15','Withdrawal',200,'New York'),
(203,'ACCT-10007891','2022-03-15','Deposit',300,'Los Angeles'),
(204,'ACCT-10001234','2022-04-10','Withdrawal',400,'Cincinnati'),
(205,'ACCT-10003456','2022-04-30','Deposit',450,'San Francisco'),
(206,'ACCT-10004567','2022-05-20','Withdrawal',100,'Texas'),
(207,'ACCT-10008901','2022-06-25','Deposit',750,'Dallas'),
(208,'ACCT-10006789','2022-07-05','Withdrawal',200,'Dallas'),
(209,'ACCT-10009876','2022-08-15','Deposit',600,'New York'),
(210,'ACCT-10005432','2022-09-01','Withdrawal',0,'New York');
```

---

## Exercise 2: Setting up MongoDB

### Task 2.1: Install and Start MongoDB

If MongoDB is not already available in your environment, you can install it using the following commands:

```bash
# Download and install MongoDB (if needed)
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Start MongoDB service
sudo systemctl start mongod
sudo systemctl enable mongod

# Check MongoDB status
sudo systemctl status mongod
```

### Task 2.2: Access MongoDB Shell

```bash
# Open MongoDB shell
mongo

# Or use mongosh (newer versions)
mongosh
```

### Task 2.3: Create FinHub Database in MongoDB

```javascript
// Switch to finhub database (creates it if it doesn't exist)
use finhub

// Verify current database
db
```

---

## Exercise 3: Designing the MongoDB Document Model

### Task 3.1: Analyze Data Relationships

Before migrating, analyze the relationships in the MySQL schema:

| Relationship Type     | MySQL Tables            | MongoDB Approach                             |
| --------------------- | ----------------------- | -------------------------------------------- |
| **One-to-Many** | Customer → Accounts    | Embed accounts array in customer document    |
| **One-to-Many** | Account → Transactions | Embed transactions array in account document |
| **Many-to-One** | Account → Branch       | Embed branch details (denormalize)           |
| **Many-to-One** | Customer → Country     | Embed country details (denormalize)          |
| **Lookup**      | Transaction → City     | Embed location details (denormalize)         |

### Task 3.2: Design the Document Structure

We'll use an **embedded document model** for optimal read performance:

```javascript
// Customer Document (with embedded accounts and transactions)
{
  "_id": ObjectId,
  "customerId": 101,
  "name": "Alice Johnson",
  "email": "alice.j@example.com",
  "dateOfBirth": "1990-05-21",
  "dateJoined": "2020-01-15",
  "country": {
    "name": "United States",
    "code": "US",
    "continent": "North America"
  },
  "accounts": [
    {
      "accountId": "ACCT-10002345",
      "type": "Savings",
      "balance": 12000,
      "branch": {
        "code": "BR001",
        "name": "Downtown Branch"
      },
      "transactions": [
        {
          "transactionId": 201,
          "date": "2022-01-05",
          "type": "Deposit",
          "amount": 500,
          "location": {
            "city": "New York",
            "state": "NY"
          }
        }
        // more transactions...
      ]
    }
    // more accounts...
  ]
}
```

---

## Exercise 4: Migrating Data from MySQL to MongoDB

### Task 4.1: Export MySQL Data to JSON

First, export the MySQL data to JSON format that can be imported into MongoDB:

```bash
# Export countries
mysql -u root -p finhub -e "SELECT * FROM countries" --batch --raw > countries.csv

# Better approach: Use mysqldump with JSON output
mysqldump -u root -p finhub --tab=/tmp --fields-terminated-by=',' --fields-enclosed-by='"' --lines-terminated-by='\n'
```

For this lab, we'll create JSON files manually from the MySQL data:

```javascript
// Create a script to export MySQL data to JSON
// Save this as export_to_json.js and run with: node export_to_json.js

const mysql = require('mysql2');
const fs = require('fs');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'your_password',
  database: 'finhub'
});

connection.connect();

// Export countries
connection.query('SELECT * FROM countries', (err, results) => {
  if (err) throw err;
  fs.writeFileSync('countries.json', JSON.stringify(results, null, 2));
  console.log('Countries exported');
});

// Export branches
connection.query('SELECT * FROM branches', (err, results) => {
  if (err) throw err;
  fs.writeFileSync('branches.json', JSON.stringify(results, null, 2));
  console.log('Branches exported');
});

// Export us_cities
connection.query('SELECT * FROM us_cities', (err, results) => {
  if (err) throw err;
  fs.writeFileSync('us_cities.json', JSON.stringify(results, null, 2));
  console.log('Cities exported');
});

// Export customers with their accounts
connection.query(`
  SELECT 
    c.*,
    a.AccountType,
    a.BranchCode,
    a.Balance,
    a.DateJoined,
    a.AccountId
  FROM customer_data c
  LEFT JOIN account_type a ON c.AccountType = a.AccountType
`, (err, results) => {
  if (err) throw err;
  fs.writeFileSync('customers.json', JSON.stringify(results, null, 2));
  console.log('Customers exported');
});

// Export transactions
connection.query('SELECT * FROM transaction_data', (err, results) => {
  if (err) throw err;
  fs.writeFileSync('transactions.json', JSON.stringify(results, null, 2));
  console.log('Transactions exported');
});

connection.end();
```

### Task 4.2: Manual Migration Using MongoDB Shell

For this lab, we'll perform the migration directly in the MongoDB shell:

```javascript
// Switch to finhub database
use finhub

// 1. Create reference collections (optional - for lookup data)
db.countries.insertMany([
  { countryId: 183, name: "United States", code: "US", continent: "North America" },
  { countryId: 32, name: "Canada", code: "CA", continent: "North America" },
  { countryId: 182, name: "United Kingdom", code: "GB", continent: "Europe" },
  { countryId: 9, name: "Australia", code: "AU", continent: "Oceania" },
  { countryId: 123, name: "New Zealand", code: "NZ", continent: "Oceania" }
]);

db.branches.insertMany([
  { branchCode: "BR001", name: "Downtown Branch" },
  { branchCode: "BR002", name: "Midtown Branch" },
  { branchCode: "BR003", name: "Riverside Branch" },
  { branchCode: "BR004", name: "Central Branch" },
  { branchCode: "BR005", name: "Westside Branch" },
  { branchCode: "BR006", name: "East End Branch" },
  { branchCode: "BR007", name: "Northside Branch" },
  { branchCode: "BR008", name: "Southside Branch" },
  { branchCode: "BR009", name: "Uptown Branch" },
  { branchCode: "BR010", name: "Greenfield Branch" }
]);

db.cities.insertMany([
  { cityId: 83, cityCode: "NY", name: "New York", state: "NY" },
  { cityId: 59, cityCode: "LA", name: "Los Angeles", state: "CA" },
  { cityId: 28, cityCode: "DAL", name: "Dallas", state: "TX" },
  { cityId: 108, cityCode: "SF", name: "San Francisco", state: "CA" },
  { cityId: 22, cityCode: "CIN", name: "Cincinnati", state: "OH" },
  { cityId: 122, cityCode: "TX", name: "Texas", state: "TX" }
]);

// 2. Create a map of cities for quick lookup
var cityMap = {};
db.cities.find().forEach(function(city) {
  cityMap[city.name] = city;
});

// 3. Create a map of branches
var branchMap = {};
db.branches.find().forEach(function(branch) {
  branchMap[branch.branchCode] = branch;
});

// 4. Create a map of countries
var countryMap = {};
db.countries.find().forEach(function(country) {
  countryMap[country.name] = country;
});

// 5. Build customer documents with embedded accounts and transactions
// First, group transactions by account
var accountTransactions = {};
db.transactions = db.getSiblingDB('finhub_oltp').getCollection('transaction_data');

// For this lab, we'll create a transactions array manually
var transactions = [
  { transactionId: 201, accountId: "ACCT-10002345", date: "2022-01-05", type: "Deposit", amount: 500, location: "New York" },
  { transactionId: 202, accountId: "ACCT-10005678", date: "2022-02-15", type: "Withdrawal", amount: 200, location: "New York" },
  { transactionId: 203, accountId: "ACCT-10007891", date: "2022-03-15", type: "Deposit", amount: 300, location: "Los Angeles" },
  { transactionId: 204, accountId: "ACCT-10001234", date: "2022-04-10", type: "Withdrawal", amount: 400, location: "Cincinnati" },
  { transactionId: 205, accountId: "ACCT-10003456", date: "2022-04-30", type: "Deposit", amount: 450, location: "San Francisco" },
  { transactionId: 206, accountId: "ACCT-10004567", date: "2022-05-20", type: "Withdrawal", amount: 100, location: "Texas" },
  { transactionId: 207, accountId: "ACCT-10008901", date: "2022-06-25", type: "Deposit", amount: 750, location: "Dallas" },
  { transactionId: 208, accountId: "ACCT-10006789", date: "2022-07-05", type: "Withdrawal", amount: 200, location: "Dallas" },
  { transactionId: 209, accountId: "ACCT-10009876", date: "2022-08-15", type: "Deposit", amount: 600, location: "New York" },
  { transactionId: 210, accountId: "ACCT-10005432", date: "2022-09-01", type: "Withdrawal", amount: 0, location: "New York" }
];

// Group transactions by account
var txByAccount = {};
transactions.forEach(function(tx) {
  if (!txByAccount[tx.accountId]) {
    txByAccount[tx.accountId] = [];
  }
  txByAccount[tx.accountId].push({
    transactionId: tx.transactionId,
    date: tx.date,
    type: tx.type,
    amount: tx.amount,
    location: cityMap[tx.location] || { name: tx.location, state: "Unknown" }
  });
});

// 6. Create customer documents
var customers = [
  { customerId: 101, name: "Alice Johnson", email: "alice.j@example.com", dateOfBirth: "1990-05-21", dateJoined: "2020-01-15", country: "United States", accountId: "ACCT-10002345", accountType: "Savings", branchCode: "BR001", balance: 12000 },
  { customerId: 102, name: "Bob Smith", email: "bob.smith@xyz.com", dateOfBirth: "1985-08-15", dateJoined: "2019-11-30", country: "United States", accountId: "ACCT-10005678", accountType: "Checking", branchCode: "BR002", balance: 3000 },
  { customerId: 103, name: "Cathy Davis", email: "cathy.davis@example.com", dateOfBirth: "1992-11-03", dateJoined: "2021-06-01", country: "United States", accountId: "ACCT-10007891", accountType: "Savings", branchCode: "BR003", balance: 8500 },
  { customerId: 104, name: "David Lee", email: "david.l@xyz.com", dateOfBirth: "1978-02-28", dateJoined: "2021-03-20", country: "United States", accountId: "ACCT-10001234", accountType: "Savings", branchCode: "BR004", balance: 5000 },
  { customerId: 105, name: "Eva Turner", email: "", dateOfBirth: "1989-04-07", dateJoined: "2020-07-19", country: "United States", accountId: "ACCT-10003456", accountType: "Checking", branchCode: "BR005", balance: -1000 },
  { customerId: 106, name: "Frank Zhang", email: "frank.zhang@xyz.com", dateOfBirth: "1975-12-13", dateJoined: "2018-09-11", country: "United States", accountId: "ACCT-10004567", accountType: "Savings", branchCode: "BR006", balance: 7500 },
  { customerId: 107, name: "Gina King", email: "gina.k@example.com", dateOfBirth: "1993-03-20", dateJoined: "2022-01-09", country: "Canada", accountId: "ACCT-10008901", accountType: "Savings", branchCode: "BR007", balance: 20000 },
  { customerId: 108, name: "Harry Brown", email: "harry.b@xyz.com", dateOfBirth: "1987-09-15", dateJoined: "2020-08-21", country: "United States", accountId: "ACCT-10006789", accountType: "Checking", branchCode: "BR008", balance: 3500 },
  { customerId: 109, name: "Ivy Scott", email: "ivy.scott@example.com", dateOfBirth: "", dateJoined: "2021-11-14", country: "Canada", accountId: "ACCT-10009876", accountType: "Savings", branchCode: "BR009", balance: 8000 },
  { customerId: 110, name: "John Doe", email: "", dateOfBirth: "1990-01-01", dateJoined: "2022-03-29", country: "United States", accountId: "ACCT-10005432", accountType: "Savings", branchCode: "BR010", balance: 0 }
];

// Transform customers into document model with embedded accounts
var customerDocs = [];
var customerMap = {};

customers.forEach(function(c) {
  if (!customerMap[c.customerId]) {
    customerMap[c.customerId] = {
      customerId: c.customerId,
      name: c.name,
      email: c.email !== "" ? c.email : null,
      dateOfBirth: c.dateOfBirth !== "" ? c.dateOfBirth : null,
      dateJoined: c.dateJoined,
      country: countryMap[c.country] || { name: c.country },
      accounts: []
    };
  }
  
  // Add account to customer
  customerMap[c.customerId].accounts.push({
    accountId: c.accountId,
    type: c.accountType,
    balance: c.balance,
    branch: branchMap[c.branchCode] || { branchCode: c.branchCode, name: "Unknown" },
    transactions: txByAccount[c.accountId] || []
  });
});

// Convert map to array
for (var id in customerMap) {
  customerDocs.push(customerMap[id]);
}

// Insert into MongoDB
db.customers.insertMany(customerDocs);

print("Migration complete! Inserted " + customerDocs.length + " customer documents.");
```

---

## Exercise 5: Querying the MongoDB Document Model

### Task 5.1: Basic Queries

```javascript
// Switch to finhub database
use finhub

// Find all customers
db.customers.find().pretty()

// Find customers by country
db.customers.find({ "country.name": "United States" }).pretty()

// Find customers with high balance (> 10000)
db.customers.find({ "accounts.balance": { $gt: 10000 } }).pretty()

// Find customers with specific account type
db.customers.find({ "accounts.type": "Savings" }).pretty()

// Find customers who joined after 2020
db.customers.find({ dateJoined: { $gt: "2020-12-31" } }).pretty()
```

### Task 5.2: Advanced Queries with Projection

```javascript
// Return only customer name and email
db.customers.find({}, { name: 1, email: 1, _id: 0 })

// Return customers with their account balances only
db.customers.find({}, { 
  name: 1, 
  "accounts.accountId": 1, 
  "accounts.balance": 1,
  _id: 0 
}).pretty()

// Find customers with transactions over $500
db.customers.find({ 
  "accounts.transactions.amount": { $gt: 500 } 
}).pretty()

// Return only the matching transactions
db.customers.find(
  { "accounts.transactions.amount": { $gt: 500 } },
  { 
    name: 1,
    "accounts.$": 1  // $ operator returns only first matching array element
  }
).pretty()
```

### Task 5.3: Aggregation Pipeline Queries

```javascript
// Total balance by country
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $group: {
    _id: "$country.name",
    totalBalance: { $sum: "$accounts.balance" },
    avgBalance: { $avg: "$accounts.balance" },
    accountCount: { $sum: 1 },
    customerCount: { $addToSet: "$customerId" }
  }},
  { $project: {
    country: "$_id",
    totalBalance: 1,
    avgBalance: 1,
    accountCount: 1,
    customerCount: { $size: "$customerCount" }
  }},
  { $sort: { totalBalance: -1 } }
])

// Transaction volume by location
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $unwind: "$accounts.transactions" },
  { $group: {
    _id: "$accounts.transactions.location.name",
    totalAmount: { $sum: "$accounts.transactions.amount" },
    transactionCount: { $sum: 1 },
    avgAmount: { $avg: "$accounts.transactions.amount" }
  }},
  { $sort: { totalAmount: -1 } }
])

// Monthly transaction summary
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $unwind: "$accounts.transactions" },
  { $group: {
    _id: {
      year: { $substr: ["$accounts.transactions.date", 0, 4] },
      month: { $substr: ["$accounts.transactions.date", 5, 2] },
      type: "$accounts.transactions.type"
    },
    totalAmount: { $sum: "$accounts.transactions.amount" },
    count: { $sum: 1 }
  }},
  { $sort: { "_id.year": 1, "_id.month": 1 } }
])

// Customers with negative balance (overdrawn)
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $match: { "accounts.balance": { $lt: 0 } } },
  { $group: {
    _id: "$customerId",
    name: { $first: "$name" },
    overdrawnAccounts: { $push: {
      accountId: "$accounts.accountId",
      balance: "$accounts.balance"
    }},
    totalNegativeBalance: { $sum: "$accounts.balance" }
  }},
  { $sort: { totalNegativeBalance: 1 } }
])

// Branch performance analysis
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $group: {
    _id: "$accounts.branch.branchCode",
    branchName: { $first: "$accounts.branch.name" },
    totalBalance: { $sum: "$accounts.balance" },
    accountCount: { $sum: 1 },
    avgBalance: { $avg: "$accounts.balance" },
    customers: { $addToSet: "$customerId" }
  }},
  { $project: {
    branchCode: "$_id",
    branchName: 1,
    totalBalance: 1,
    accountCount: 1,
    avgBalance: 1,
    customerCount: { $size: "$customers" }
  }},
  { $sort: { totalBalance: -1 } }
])
```

---

## Exercise 6: Comparing MySQL and MongoDB Queries

### Task 6.1: Query Comparison Table

| Query Purpose                                         | MySQL (SQL)                                                       | MongoDB (JavaScript)                                                                     |
| ----------------------------------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| **Find customer by ID**                         | `SELECT * FROM customer_data WHERE CustomerID = 101;`           | `db.customers.findOne({ customerId: 101 })`                                            |
| **Find all accounts for a customer**            | `SELECT * FROM account WHERE CustomerID = 101;` (requires JOIN) | `db.customers.findOne({ customerId: 101 }, { accounts: 1 })`                           |
| **Find all transactions for an account**        | `SELECT * FROM transaction WHERE AccountId = 'ACCT-10002345';`  | `db.customers.findOne({ "accounts.accountId": "ACCT-10002345" }, { "accounts.$": 1 })` |
| **Calculate total balance by country**          | Complex query with GROUP BY and JOINs                             | Simple aggregation pipeline                                                              |
| **Find customers with high-value transactions** | Multi-table JOIN with subquery                                    | Single collection query with array navigation                                            |

### Task 6.2: Performance Considerations

| Aspect                       | MySQL                      | MongoDB                                 | Winner  |
| ---------------------------- | -------------------------- | --------------------------------------- | ------- |
| **JOINs**              | Required for related data  | Embedded documents eliminate JOINs      | MongoDB |
| **Indexing**           | Indexes on columns         | Indexes on fields and embedded fields   | Tie     |
| **Read Speed**         | Slower with complex JOINs  | Faster with denormalized data           | MongoDB |
| **Write Speed**        | Fast for normalized data   | Slightly slower due to document updates | MySQL   |
| **Data Consistency**   | ACID compliant             | Eventually consistent (configurable)    | MySQL   |
| **Schema Flexibility** | Rigid, requires migrations | Flexible, no migrations                 | MongoDB |

---

## Exercise 7: Testing the Migration

### Task 7.1: Verify Data Integrity

```javascript
// Check total customer count
db.customers.count()

// Verify data for a specific customer
db.customers.findOne({ customerId: 101 })

// Check that all accounts have transactions embedded
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $group: {
    _id: null,
    totalAccounts: { $sum: 1 },
    accountsWithTransactions: { 
      $sum: { $cond: [{ $gt: [{ $size: "$accounts.transactions" }, 0] }, 1, 0] }
    }
  }}
])

// Verify balances sum matches original data
db.customers.aggregate([
  { $unwind: "$accounts" },
  { $group: {
    _id: null,
    totalBalance: { $sum: "$accounts.balance" }
  }}
])
```

### Task 7.2: Create Indexes for Performance

```javascript
// Create indexes for common query patterns
db.customers.createIndex({ customerId: 1 })
db.customers.createIndex({ "country.name": 1 })
db.customers.createIndex({ "accounts.accountId": 1 })
db.customers.createIndex({ "accounts.type": 1 })
db.customers.createIndex({ "accounts.balance": 1 })
db.customers.createIndex({ "accounts.transactions.date": 1 })
db.customers.createIndex({ "accounts.transactions.amount": 1 })

// View all indexes
db.customers.getIndexes()
```

---

## Summary

In this lab, you successfully migrated an OLTP schema from MySQL to MongoDB:

### What you accomplished:

| Exercise             | Task                                          | Completed |
| -------------------- | --------------------------------------------- | --------- |
| **Exercise 1** | Set up MySQL OLTP database with FinHub schema | ⬜        |
|                      | Loaded sample data into MySQL tables          | ⬜        |
| **Exercise 2** | Set up MongoDB environment                    | ⬜        |
| **Exercise 3** | Designed MongoDB document model (embedded)    | ⬜        |
| **Exercise 4** | Migrated data from MySQL to MongoDB           | ⬜        |
|                      | Transformed relational data to document model | ⬜        |
| **Exercise 5** | Queried MongoDB document model                | ⬜        |
|                      | Used aggregation pipeline for analytics       | ⬜        |
| **Exercise 6** | Compared MySQL and MongoDB query approaches   | ⬜        |
| **Exercise 7** | Verified data integrity and created indexes   | ⬜        |

### Key Migration Transformations

| MySQL (Relational)                                   | MongoDB (Document)                          | Benefit                           |
| ---------------------------------------------------- | ------------------------------------------- | --------------------------------- |
| Multiple tables with foreign keys                    | Single collection with embedded documents   | No JOINs required                 |
| Separate lookup tables (countries, branches, cities) | Embedded reference data in parent documents | Faster reads, denormalized        |
| Transactions separate from accounts                  | Transactions embedded in account documents  | One query to get all account data |
| Rigid schema with defined columns                    | Flexible schema with nested objects         | Easy to add new fields            |
| SQL queries with JOINs                               | Document queries with dot notation          | More intuitive for developers     |

### MongoDB Document Model Advantages

1. **Performance**: Single query retrieves all customer data including accounts and transactions
2. **Scalability**: Horizontal scaling with sharding
3. **Flexibility**: Easy to add new fields (e.g., customer preferences, risk score)
4. **Developer Productivity**: Object mapping matches application data structures
5. **Aggregation Pipeline**: Powerful built-in analytics

### When to Use This Approach

✅ **Good fit for MongoDB:**

- Hierarchical data structures (customer → accounts → transactions)
- Read-heavy workloads
- Rapidly evolving schema
- Need for horizontal scaling

❌ **May still need MySQL for:**

- Complex transactions requiring ACID across multiple documents
- Highly normalized data with many relationships
- Reporting requiring complex JOINs across unrelated entities

---

## Final MongoDB Schema Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                          MONGODB DOCUMENT MODEL                                   │
│                                FinHub Bank                                        │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────────┐ │
│  │                           CUSTOMER DOCUMENT                                   │ │
│  │  ┌─────────────────────────────────────────────────────────────────────┐    │ │
│  │  │  customerId: 101                                                     │    │ │
│  │  │  name: "Alice Johnson"                                               │    │ │
│  │  │  email: "alice.j@example.com"                                        │    │ │
│  │  │  dateOfBirth: "1990-05-21"                                           │    │ │
│  │  │  dateJoined: "2020-01-15"                                            │    │ │
│  │  │  country: { name: "United States", code: "US", continent: "NA" }    │    │ │
│  │  │  accounts: [                                                         │    │ │
│  │  │    ┌─────────────────────────────────────────────────────────────┐   │    │ │
│  │  │    │  accountId: "ACCT-10002345"                                  │   │    │ │
│  │  │    │  type: "Savings"                                             │   │    │ │
│  │  │    │  balance: 12000                                              │   │    │ │
│  │  │    │  branch: { code: "BR001", name: "Downtown Branch" }         │   │    │ │
│  │  │    │  transactions: [                                             │   │    │ │
│  │  │    │    ┌─────────────────────────────────────────────────────┐  │   │    │ │
│  │  │    │    │  transactionId: 201                                   │  │   │    │ │
│  │  │    │    │  date: "2022-01-05"                                   │  │   │    │ │
│  │  │    │    │  type: "Deposit"                                      │  │   │    │ │
│  │  │    │    │  amount: 500                                          │  │   │    │ │
│  │  │    │    │  location: { city: "New York", state: "NY" }         │  │   │    │ │
│  │  │    │    └─────────────────────────────────────────────────────┘  │   │    │ │
│  │  │    │    ... more transactions ...                                 │   │    │ │
│  │  │    └─────────────────────────────────────────────────────────────┘   │    │ │
│  │  │    ... more accounts ...                                             │    │ │
│  │  │  ]                                                                   │    │ │
│  │  └─────────────────────────────────────────────────────────────────────┘    │ │
│  └─────────────────────────────────────────────────────────────────────────────┘ │
│                                                                                   │
│                      ┌─────────────────────────────────────┐                     │
│                      │       SUPPORTING COLLECTIONS         │                     │
│                      ├─────────────────────────────────────┤                     │
│                      │ • countries (reference data)        │                     │
│                      │ • branches (reference data)         │                     │
│                      │ • cities (reference data)           │                     │
│                      └─────────────────────────────────────┘                     │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Conclusion

Congratulations! You have successfully migrated an OLTP schema from MySQL to MongoDB. This migration enables FinHub Bank to:

- **Improve read performance** by eliminating JOINs
- **Scale horizontally** as data grows
- **Adapt quickly** to changing business requirements
- **Simplify development** with document-oriented data modeling
- **Enable faster feature delivery** with schema flexibility

The document model provides a more natural representation of the banking domain, where customers naturally have multiple accounts, and accounts naturally have multiple transactions.

---

## Additional Resources

- [MongoDB Documentation](https://docs.mongodb.com/)
- [MongoDB University - Free Courses](https://university.mongodb.com/)
- [MySQL to MongoDB Migration Guide](https://www.mongodb.com/docs/manual/reference/sql-comparison/)
- [MongoDB Aggregation Pipeline](https://www.mongodb.com/docs/manual/core/aggregation-pipeline/)

---

*Lab completed: _________________*
*Instructor signature: _________________*
