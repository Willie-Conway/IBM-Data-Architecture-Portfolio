# Lab: Prepare a Data Model for a Transaction Processing System

## Estimated time: 30 minutes

---

## Learning objectives

After completing this lab, you will be able to:

- Apply data modeling principles by designing a normalized data model for a retail bank's transaction processing system
- Create an Entity Relationship Diagram (ERD) in Lucidchart to visually represent the entities, attributes, and relationships in the retail bank's transaction processing system

---

## Prerequisites

You can complete your tasks using any text editor, such as Word, Google Docs, or Notepad.

If you install Microsoft Word, you can proceed directly with the instructions. However, if you don't have Microsoft Word, you can sign up for a free version of Microsoft 365 online. Follow [these instructions](https://support.microsoft.com/en-us/office/sign-up-for-microsoft-365-9ac1e0c7-0e6c-4f9d-8c8c-7e9b8e8c8c8c) to create your account.

You can also use Word Online with a Microsoft 365 subscription or access through a free account. If you're new to Word and would like to learn how to get started, you can find helpful resources here: [Getting Started with Word Online](https://support.microsoft.com/en-us/office/get-started-with-word-online-5c8c3c3c-3c3c-4c3c-8c3c-3c3c3c3c3c3c).

For this lab, you can use **Lucidchart**. You only need the free version of LucidChart. If you choose to purchase a paid plan, you will be responsible for any associated charges. If you've not yet signed up for the free account, you can follow [these instructions](https://www.lucidchart.com/pages/sign-up) to get started. You may alternatively use applications like **Microsoft Visio** or **draw.io**.

---

## Introduction

A **data model** is a structured frame that defines, organizes, and manages data, forming the fundamental blueprint for effectively designing databases. It ensures consistency, usability, and effective data management by combining models into conceptual, logical, and physical types—specific models dealing with various levels of abstraction targeted toward different stakeholders.

The data model is very important in transaction processing systems like banking. It facilitates account management and ensures data integrity while supporting the smooth operation of deposits, withdrawals, and balance maintenance, all of which form the backbone of reliable and efficient data processing systems.

---

## Exercise: Prepare a data model for a transaction processing system of a retail bank using Lucidchart

In this lab, you will design a comprehensive data model for a retail bank's transaction processing system. The system manages key operations such as account opening, balance maintenance, fixed deposits (FD), recurring deposits (RD), deposits, withdrawals, and savings/checking account types. You will define entities, their attributes, and relationships through step-by-step guidance, culminating in creating an Entity Relationship Diagram (ERD) using Lucidchart. This visual representation will provide a clear and organized view of the data structure, ensuring consistency and usability for seamless transaction processing.

### Scenario

A robust data model is required by a retail bank to efficiently manage its transaction processing system in operations like deposits, withdrawals, transfers, and loan repayments.

It must offer ample customer profiles with multiple account types, such as savings, checking, and loans, and detailed transaction logs with timestamps and traceability.

Some of the key requirements would include **ACID compliance**, multicurrency transaction handling, and role-based access controls to ensure security.

Furthermore, the system needs to embed **real-time fraud detection** and **regulatory compliance**. For its sustainability and future capability, the model must incorporate advanced reporting and analytics to trace the transaction pattern with the efficiency of operation, integrity of data, and customer experience over the services delivered in the banking industry.

### Let's begin!

---

## Template to use

If you are using Microsoft Word, right-click the link and download the template document. You can use the template to perform the tasks outlined in the lab.

You can also use the PDF format for any other word-processing software.

---

## Task 1: Understand the requirements

### Step 1: Clearly outline the system's primary features and capabilities

Based on the scenario, the retail bank's transaction processing system must support the following primary features:

| Feature Category                 | Specific Features                                                            |
| -------------------------------- | ---------------------------------------------------------------------------- |
| **Account Management**     | Account opening, closure, and maintenance                                    |
| **Transaction Processing** | Deposits, withdrawals, transfers, loan repayments                            |
| **Deposit Products**       | Fixed Deposits (FD), Recurring Deposits (RD)                                 |
| **Account Types**          | Savings accounts, Checking accounts, Loan accounts                           |
| **Security & Compliance**  | ACID compliance, multi-currency handling, role-based access, fraud detection |
| **Reporting**              | Transaction pattern analysis, operational efficiency tracking                |

### Step 2: Specify the data requirements necessary for the system to execute each operation effectively

| Operation                         | Necessary Data Points                                                                      |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
| **Account opening/closure** | Customer details, account type, initial deposit, branch information, employee information  |
| **Deposits/Withdrawals**    | Account number, transaction amount, date/time, transaction type, description               |
| **Transfers**               | Source account, destination account, amount, date/time, reference                          |
| **FD/RD Management**        | Deposit type, term, interest rate, start date, maturity date, monthly installment (for RD) |
| **Loan Repayments**         | Loan account number, payment amount, due date, payment date                                |
| **Fraud Detection**         | Transaction patterns, location data, unusual activity flags                                |
| **Reporting**               | Transaction history, customer summaries, branch performance                                |

---

## Task 2: Identify key entities

Clearly determine and define the primary components or building blocks of the system.

| Key Entity                 | Description                                               | Key Attributes                                                                  |
| -------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Customer**         | Stores personal and contact information of bank customers | Customer ID, name, contact details, address, identification documents           |
| **Account**          | Represents bank accounts held by customers                | Account number, account type, balance, status, open date                        |
| **Transaction**      | Records all financial transactions                        | Transaction ID, date, amount, type, description, reference                      |
| **FixedDeposit**     | Manages fixed deposit investments                         | FD ID, principal amount, term, interest rate, maturity date, maturity amount    |
| **RecurringDeposit** | Manages recurring deposit accounts                        | RD ID, monthly installment, term, interest rate, maturity date, total deposited |
| **Loan**             | Tracks loan accounts and repayments                       | Loan ID, loan type, principal, interest rate, term, EMI, outstanding balance    |
| **Branch**           | Represents physical bank locations                        | Branch ID, name, address, contact information                                   |
| **Employee**         | Tracks bank employees who manage operations               | Employee ID, name, role, branch assignment, contact                             |
| **AccountType**      | Defines different types of accounts                       | Type ID, type name (Savings, Checking, Loan, FD, RD), features, interest rate   |
| **Currency**         | Manages multi-currency support                            | Currency code, currency name, exchange rate                                     |

---

## Task 3: Define attributes for each entity

Identify and specify the key characteristics or properties that describe each entity.

### Customer

| Attribute         | Data Type    | Description                         |
| ----------------- | ------------ | ----------------------------------- |
| Customer_ID       | INT (PK)     | Unique identifier for each customer |
| First_Name        | VARCHAR(50)  | Customer's first name               |
| Last_Name         | VARCHAR(50)  | Customer's last name                |
| Date_of_Birth     | DATE         | Customer's birth date               |
| Email             | VARCHAR(100) | Email address                       |
| Phone             | VARCHAR(20)  | Contact phone number                |
| Address_Line1     | VARCHAR(100) | Street address                      |
| Address_Line2     | VARCHAR(100) | Additional address info             |
| City              | VARCHAR(50)  | City                                |
| State             | VARCHAR(50)  | State/Province                      |
| Postal_Code       | VARCHAR(20)  | ZIP/Postal code                     |
| Country           | VARCHAR(50)  | Country                             |
| ID_Type           | VARCHAR(30)  | Passport, driver's license, etc.    |
| ID_Number         | VARCHAR(50)  | Identification document number      |
| Registration_Date | DATE         | When customer registered            |
| Customer_Status   | VARCHAR(20)  | Active, Inactive, Closed            |

### Account

| Attribute               | Data Type       | Description                             |
| ----------------------- | --------------- | --------------------------------------- |
| Account_ID              | INT (PK)        | Unique account identifier               |
| Customer_ID             | INT (FK)        | Reference to Customer                   |
| Account_Type_ID         | INT (FK)        | Reference to AccountType                |
| Branch_ID               | INT (FK)        | Reference to Branch                     |
| Currency_Code           | VARCHAR(3) (FK) | Reference to Currency                   |
| Account_Number          | VARCHAR(30)     | Bank account number (unique)            |
| Balance                 | DECIMAL(15,2)   | Current account balance                 |
| Available_Balance       | DECIMAL(15,2)   | Available funds                         |
| Interest_Rate           | DECIMAL(5,2)    | Applicable interest rate                |
| Opening_Date            | DATE            | When account was opened                 |
| Closing_Date            | DATE            | When account was closed (if applicable) |
| Status                  | VARCHAR(20)     | Active, Dormant, Closed, Frozen         |
| Monthly_Maintenance_Fee | DECIMAL(10,2)   | Fee charged monthly                     |
| Overdraft_Limit         | DECIMAL(15,2)   | For checking accounts                   |

### Transaction

| Attribute              | Data Type     | Description                                  |
| ---------------------- | ------------- | -------------------------------------------- |
| Transaction_ID         | INT (PK)      | Unique transaction identifier                |
| Account_ID             | INT (FK)      | Reference to Account                         |
| Transaction_Date       | TIMESTAMP     | Date and time of transaction                 |
| Transaction_Type       | VARCHAR(30)   | Deposit, Withdrawal, Transfer, Fee, Interest |
| Amount                 | DECIMAL(15,2) | Transaction amount                           |
| Currency_Code          | VARCHAR(3)    | Currency of transaction                      |
| Exchange_Rate          | DECIMAL(10,6) | Exchange rate if multi-currency              |
| Description            | VARCHAR(255)  | Transaction description                      |
| Reference_Number       | VARCHAR(50)   | External reference (check #, etc.)           |
| Status                 | VARCHAR(20)   | Pending, Completed, Failed, Reversed         |
| Related_Transaction_ID | INT           | For linked transactions (transfers)          |
| Destination_Account_ID | INT (FK)      | For transfers (self-reference)               |
| Fraud_Flag             | BOOLEAN       | Flagged for potential fraud                  |
| Approval_Status        | VARCHAR(20)   | Approved, Pending Review, Rejected           |
| Approved_By            | INT (FK)      | Employee who approved                        |

### FixedDeposit

| Attribute              | Data Type     | Description                               |
| ---------------------- | ------------- | ----------------------------------------- |
| FD_ID                  | INT (PK)      | Unique fixed deposit identifier           |
| Account_ID             | INT (FK)      | Reference to linked account               |
| FD_Number              | VARCHAR(30)   | FD certificate number                     |
| Principal_Amount       | DECIMAL(15,2) | Initial deposit amount                    |
| Interest_Rate          | DECIMAL(5,2)  | Fixed interest rate                       |
| Term_Months            | INT           | Duration in months                        |
| Start_Date             | DATE          | When FD started                           |
| Maturity_Date          | DATE          | When FD matures                           |
| Maturity_Amount        | DECIMAL(15,2) | Principal + interest at maturity          |
| Interest_Payout_Option | VARCHAR(30)   | Reinvest, monthly payout, maturity payout |
| Nominee_Name           | VARCHAR(100)  | Nominee for the deposit                   |
| Status                 | VARCHAR(20)   | Active, Matured, Closed                   |

### RecurringDeposit

| Attribute             | Data Type     | Description                         |
| --------------------- | ------------- | ----------------------------------- |
| RD_ID                 | INT (PK)      | Unique recurring deposit identifier |
| Account_ID            | INT (FK)      | Reference to linked account         |
| RD_Number             | VARCHAR(30)   | RD account number                   |
| Monthly_Installment   | DECIMAL(15,2) | Amount to deposit monthly           |
| Interest_Rate         | DECIMAL(5,2)  | Interest rate                       |
| Term_Months           | INT           | Duration in months                  |
| Start_Date            | DATE          | When RD started                     |
| Maturity_Date         | DATE          | When RD matures                     |
| Total_Deposited       | DECIMAL(15,2) | Sum of all installments             |
| Maturity_Amount       | DECIMAL(15,2) | Total + interest at maturity        |
| Installment_Due_Day   | INT           | Day of month for payment            |
| Next_Installment_Date | DATE          | Next payment due date               |
| Installments_Paid     | INT           | Number of installments completed    |
| Status                | VARCHAR(20)   | Active, Matured, Defaulted, Closed  |

### Loan

| Attribute          | Data Type     | Description                             |
| ------------------ | ------------- | --------------------------------------- |
| Loan_ID            | INT (PK)      | Unique loan identifier                  |
| Customer_ID        | INT (FK)      | Reference to Customer                   |
| Account_ID         | INT (FK)      | Reference to linked account             |
| Loan_Type          | VARCHAR(30)   | Personal, Home, Auto, Business          |
| Loan_Number        | VARCHAR(30)   | Loan account number                     |
| Principal_Amount   | DECIMAL(15,2) | Original loan amount                    |
| Outstanding_Amount | DECIMAL(15,2) | Remaining balance                       |
| Interest_Rate      | DECIMAL(5,2)  | Loan interest rate                      |
| Interest_Type      | VARCHAR(20)   | Fixed, Variable                         |
| Term_Months        | INT           | Loan duration                           |
| EMI_Amount         | DECIMAL(15,2) | Monthly payment amount                  |
| EMI_Due_Day        | INT           | Day of month for payment                |
| Disbursement_Date  | DATE          | When funds were provided                |
| First_Payment_Date | DATE          | First EMI due date                      |
| Maturity_Date      | DATE          | Final payment date                      |
| Collateral         | VARCHAR(255)  | Security for loan                       |
| Status             | VARCHAR(20)   | Active, Closed, Defaulted, Restructured |

### Branch

| Attribute    | Data Type    | Description               |
| ------------ | ------------ | ------------------------- |
| Branch_ID    | INT (PK)     | Unique branch identifier  |
| Branch_Code  | VARCHAR(20)  | Bank branch code          |
| Branch_Name  | VARCHAR(100) | Branch name               |
| Address      | VARCHAR(200) | Branch address            |
| City         | VARCHAR(50)  | City                      |
| State        | VARCHAR(50)  | State/Province            |
| Postal_Code  | VARCHAR(20)  | ZIP/Postal code           |
| Country      | VARCHAR(50)  | Country                   |
| Phone        | VARCHAR(20)  | Contact phone             |
| Email        | VARCHAR(100) | Contact email             |
| Manager_ID   | INT (FK)     | Branch manager (Employee) |
| Opening_Date | DATE         | When branch opened        |
| Status       | VARCHAR(20)  | Active, Closed            |

### Employee

| Attribute       | Data Type    | Description                     |
| --------------- | ------------ | ------------------------------- |
| Employee_ID     | INT (PK)     | Unique employee identifier      |
| Branch_ID       | INT (FK)     | Reference to Branch             |
| First_Name      | VARCHAR(50)  | Employee's first name           |
| Last_Name       | VARCHAR(50)  | Employee's last name            |
| Employee_Number | VARCHAR(30)  | Company employee ID             |
| Role            | VARCHAR(50)  | Teller, Officer, Manager, Admin |
| Department      | VARCHAR(50)  | Department name                 |
| Email           | VARCHAR(100) | Work email                      |
| Phone           | VARCHAR(20)  | Work phone                      |
| Hire_Date       | DATE         | When employed                   |
| Supervisor_ID   | INT (FK)     | Reference to Employee (manager) |
| Status          | VARCHAR(20)  | Active, Inactive, Terminated    |

### AccountType

| Attribute          | Data Type     | Description                     |
| ------------------ | ------------- | ------------------------------- |
| Account_Type_ID    | INT (PK)      | Unique type identifier          |
| Type_Name          | VARCHAR(30)   | Savings, Checking, Loan, FD, RD |
| Category           | VARCHAR(20)   | Deposit, Loan, Investment       |
| Description        | VARCHAR(255)  | Type description                |
| Minimum_Balance    | DECIMAL(15,2) | Required minimum balance        |
| Interest_Rate      | DECIMAL(5,2)  | Default interest rate           |
| Monthly_Fee        | DECIMAL(10,2) | Standard monthly fee            |
| Transaction_Limits | VARCHAR(255)  | Daily/weekly limits             |
| Features           | TEXT          | Additional features             |

### Currency

| Attribute             | Data Type       | Description                              |
| --------------------- | --------------- | ---------------------------------------- |
| Currency_Code         | VARCHAR(3) (PK) | ISO currency code (USD, EUR, GBP)        |
| Currency_Name         | VARCHAR(50)     | Full currency name                       |
| Symbol                | VARCHAR(5)      | Currency symbol ($, €, £)              |
| Exchange_Rate_To_Base | DECIMAL(10,6)   | Rate relative to base currency           |
| Last_Updated          | TIMESTAMP       | When rate was last updated               |
| Is_Base_Currency      | BOOLEAN         | Whether this is the bank's base currency |

---

## Task 4: Establish relationship between entities

Clearly define how the entities within the system are connected or interact with one another.

### Relationship Matrix

| Entity 1              | Relationship | Entity 2         | Cardinality | Description                                 |
| --------------------- | ------------ | ---------------- | ----------- | ------------------------------------------- |
| **Customer**    | has          | Account          | 1 : N       | One customer can have multiple accounts     |
| **Customer**    | applies for  | Loan             | 1 : N       | One customer can have multiple loans        |
| **Account**     | is of type   | AccountType      | N : 1       | Many accounts belong to one account type    |
| **Account**     | belongs to   | Branch           | N : 1       | Many accounts belong to one branch          |
| **Account**     | uses         | Currency         | N : 1       | Many accounts use one currency              |
| **Account**     | has          | Transaction      | 1 : N       | One account can have many transactions      |
| **Transaction** | can be a     | Transfer         | N : 1       | Many transactions can be part of a transfer |
| **Transaction** | approved by  | Employee         | N : 1       | Many transactions approved by one employee  |
| **Account**     | linked to    | FixedDeposit     | 1 : 1       | One account can be linked to one FD         |
| **Account**     | linked to    | RecurringDeposit | 1 : 1       | One account can be linked to one RD         |
| **Account**     | linked to    | Loan             | 1 : 1       | One account can be linked to one loan       |
| **Branch**      | employs      | Employee         | 1 : N       | One branch employs many employees           |
| **Employee**    | reports to   | Employee         | N : 1       | Many employees report to one manager        |
| **Employee**    | manages      | Branch           | 1 : 1       | One employee manages one branch             |

### Detailed Relationship Documentation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          RELATIONSHIP CARDINALITIES                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CUSTOMER ────────< has >────────── ACCOUNT                                 │
│    1                                     N                                   │
│                                                                              │
│  CUSTOMER ────────< applies for >───── LOAN                                 │
│    1                                     N                                   │
│                                                                              │
│  ACCOUNT ─────────< is of type >────── ACCOUNTTYPE                          │
│    N                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< belongs to >────── BRANCH                               │
│    N                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< uses >──────────── CURRENCY                             │
│    N                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< has >───────────── TRANSACTION                          │
│    1                                     N                                   │
│                                                                              │
│  TRANSACTION ─────< approved by >───── EMPLOYEE                             │
│    N                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< linked to >─────── FIXEDDEPOSIT                         │
│    1                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< linked to >─────── RECURRINGDEPOSIT                     │
│    1                                     1                                   │
│                                                                              │
│  ACCOUNT ─────────< linked to >─────── LOAN                                 │
│    1                                     1                                   │
│                                                                              │
│  BRANCH ──────────< employs >────────── EMPLOYEE                            │
│    1                                     N                                   │
│                                                                              │
│  EMPLOYEE ────────< reports to >─────── EMPLOYEE                            │
│    N                                     1                                   │
│                                                                              │
│  EMPLOYEE ────────< manages >────────── BRANCH                              │
│    1                                     1                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Task 5: Create the ERD using Lucidchart

### Step 1: Open Lucidchart and login

Navigate to [Lucidchart](https://www.lucidchart.com) and log in to your account.

### Step 2: Create a new document

Tap on **+New**, and then hit the **Create from template** button.

### Step 3: Select ERD template

Search for "Entity Relationship Diagram" and choose the ERD template to start.

### Step 4: Prepare the workspace

Delete all unnecessary items on the board, except for the entity box. To keep it simple, you can also remove extra fields within each entity box.

The rectangle shape will be used to represent each entity.

### Step 5: Add entity boxes

Replicate as many entity boxes as you have listed in the table and name them all:

- Customer
- Account
- Transaction
- FixedDeposit
- RecurringDeposit
- Loan
- Branch
- Employee
- AccountType
- Currency

### Step 6: List attributes

For each entity, list the key attributes inside the rectangle beneath the entity name along with their data types. Ensure the attributes are clear and directly associated with their respective entities for easy identification.

**Example format:**

```
┌─────────────────────┐
│     CUSTOMER        │
├─────────────────────┤
│ Customer_ID (PK)    │
│ First_Name          │
│ Last_Name           │
│ Date_of_Birth       │
│ Email               │
│ Phone               │
│ Address             │
│ City                │
│ State               │
│ Postal_Code         │
│ Country             │
│ Registration_Date   │
│ Status              │
└─────────────────────┘
```

**Complete entity representations:**

```
┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│     CUSTOMER        │    │      ACCOUNT        │    │    TRANSACTION      │
├─────────────────────┤    ├─────────────────────┤    ├─────────────────────┤
│ Customer_ID (PK)    │    │ Account_ID (PK)     │    │ Transaction_ID (PK) │
│ First_Name          │───▶│ Customer_ID (FK)    │◀──▶│ Account_ID (FK)     │
│ Last_Name           │    │ Account_Type_ID(FK) │    │ Transaction_Date    │
│ Date_of_Birth       │    │ Branch_ID (FK)      │    │ Transaction_Type    │
│ Email               │    │ Currency_Code (FK)  │    │ Amount              │
│ Phone               │    │ Account_Number      │    │ Currency_Code       │
│ Address             │    │ Balance             │    │ Exchange_Rate       │
│ City                │    │ Available_Balance   │    │ Description         │
│ State               │    │ Interest_Rate       │    │ Reference_Number    │
│ Postal_Code         │    │ Opening_Date        │    │ Status              │
│ Country             │    │ Status              │    │ Fraud_Flag          │
│ Registration_Date   │    └─────────────────────┘    │ Approved_By (FK)    │
│ Status              │                               └─────────────────────┘
└─────────────────────┘
                                                              │
                                                              │
┌─────────────────────┐    ┌─────────────────────┐    ┌─────▼───────────────┐
│   FIXEDDEPOSIT      │    │ RECURRINGDEPOSIT    │    │       LOAN          │
├─────────────────────┤    ├─────────────────────┤    ├─────────────────────┤
│ FD_ID (PK)          │    │ RD_ID (PK)          │    │ Loan_ID (PK)        │
│ Account_ID (FK)     │    │ Account_ID (FK)     │    │ Customer_ID (FK)    │
│ FD_Number           │    │ RD_Number           │    │ Account_ID (FK)     │
│ Principal_Amount    │    │ Monthly_Installment │    │ Loan_Type           │
│ Interest_Rate       │    │ Interest_Rate       │    │ Principal_Amount    │
│ Term_Months         │    │ Term_Months         │    │ Outstanding_Amount  │
│ Start_Date          │    │ Start_Date          │    │ Interest_Rate       │
│ Maturity_Date       │    │ Maturity_Date       │    │ EMI_Amount          │
│ Maturity_Amount     │    │ Total_Deposited     │    │ Disbursement_Date   │
│ Status              │    │ Status              │    │ Maturity_Date       │
└─────────────────────┘    └─────────────────────┘    │ Status              │
                                                       └─────────────────────┘

┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────────────┐
│      BRANCH         │    │     EMPLOYEE        │    │   ACCOUNTTYPE       │
├─────────────────────┤    ├─────────────────────┤    ├─────────────────────┤
│ Branch_ID (PK)      │    │ Employee_ID (PK)    │    │ Account_Type_ID(PK) │
│ Branch_Code         │◀───│ Branch_ID (FK)      │    │ Type_Name           │
│ Branch_Name         │    │ First_Name          │    │ Category            │
│ Address             │    │ Last_Name           │    │ Description         │
│ City                │    │ Role                │    │ Minimum_Balance     │
│ State               │    │ Email               │    │ Interest_Rate       │
│ Country             │    │ Phone               │    │ Monthly_Fee         │
│ Phone               │    │ Hire_Date           │    └─────────────────────┘
│ Manager_ID (FK)     │───▶│ Supervisor_ID (FK)  │  
│ Status              │    │ Status              │  
└─────────────────────┘    └─────────────────────┘  
                                                           
┌─────────────────────┐
│     CURRENCY        │
├─────────────────────┤
│ Currency_Code (PK)  │
│ Currency_Name       │
│ Symbol              │
│ Exchange_Rate       │
│ Is_Base_Currency    │
└─────────────────────┘
```

### Step 7: Connect entities with relationships

Use lines to connect entities based on relationships. Add crow's foot notation to represent the cardinality (1:N, 1:1, N:N).

**Relationship Legend:**

| Symbol     | Meaning                 |
| ---------- | ----------------------- |
| ──┬── | One side                |
| ──<──  | Many side (crow's foot) |
| ──◄── | One and only one        |
| ──○── | Zero or one             |
| ──<──  | One or many             |

**Example connection with cardinality:**

```
┌─────────────────────┐                       ┌─────────────────────┐
│     CUSTOMER        │                       │      ACCOUNT        │
├─────────────────────┤                       ├─────────────────────┤
│ Customer_ID (PK)    │───┐              ┌────│ Account_ID (PK)     │
│ First_Name          │   │              │    │ Customer_ID (FK)    │
│ Last_Name           │   │              │    │ Account_Type_ID(FK) │
│                     │   │              │    │                     │
│                     │   │ 1          N │    │                     │
│                     │   └──────────────┘    │                     │
│                     │     Customer has       │                     │
│                     │     multiple accounts  │                     │
└─────────────────────┘                       └─────────────────────┘
```

**Complete ERD with relationships:**

```
┌─────────────┐          ┌─────────────┐          ┌─────────────┐
│  CUSTOMER   │          │  ACCOUNTTYPE│          │  CURRENCY   │
├─────────────┤          ├─────────────┤          ├─────────────┤
│ PK: Cust_ID │          │ PK: Type_ID │          │ PK: Curr_CD │
└──────┬──────┘          └──────┬──────┘          └──────┬──────┘
       │                        │                        │
       │1                       │1                       │1
       │                        │                        │
       │N                       │N                       │N
┌──────▼──────┐          ┌──────▼──────┐          ┌──────▼──────┐
│   ACCOUNT   │          │   ACCOUNT   │          │   ACCOUNT   │
├─────────────┤          ├─────────────┤          ├─────────────┤
│ FK: Cust_ID │──────────│ FK: Type_ID │──────────│ FK: Curr_CD │
│ PK: Acct_ID │          │             │          │             │
│ FK: Brn_ID  │          │             │          │             │
└──────┬──────┘          └─────────────┘          └─────────────┘
       │
       │1
       │
       │N
┌──────▼──────┐          ┌─────────────┐          ┌─────────────┐
│ TRANSACTION │          │ FIXEDDEPOSIT│          │  RDDEPOSIT  │
├─────────────┤          ├─────────────┤          ├─────────────┤
│ PK: Tran_ID │          │ PK: FD_ID   │          │ PK: RD_ID   │
│ FK: Acct_ID │──────────│ FK: Acct_ID │          │ FK: Acct_ID │
│ FK: Emp_ID  │          └─────────────┘          └─────────────┘
└──────┬──────┘
       │
       │N
       │
       │1
┌──────▼──────┐          ┌─────────────┐          ┌─────────────┐
│  EMPLOYEE   │          │   BRANCH    │          │    LOAN     │
├─────────────┤          ├─────────────┤          ├─────────────┤
│ PK: Emp_ID  │          │ PK: Brn_ID  │          │ PK: Loan_ID │
│ FK: Brn_ID  │◄─────────│ Manager_ID  │──────────│ FK: Acct_ID │
│ FK: Sup_ID  │          │             │          │ FK: Cust_ID │
└──────┬──────┘          └─────────────┘          └─────────────┘
       │
       │N
       │
       │1
┌──────▼──────┐
│  EMPLOYEE   │
│(self-ref)   │
│ FK: Sup_ID  │
└─────────────┘
```

---

## Complete ERD Example

Here's a text-based representation of the complete Entity Relationship Diagram:

```
╔══════════════════════════════════════════════════════════════════════════════════════════════╗
║               ENTITY RELATIONSHIP DIAGRAM - RETAIL BANK TRANSACTION PROCESSING SYSTEM        ║
╠══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                                ║
║  ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐                     ║
║  │    CUSTOMER     │       │   ACCOUNTTYPE   │       │    CURRENCY     │                     ║
║  ├─────────────────┤       ├─────────────────┤       ├─────────────────┤                     ║
║  │PK Customer_ID   │       │PK AccountType_ID│       │PK Currency_Code │                     ║
║  │ First_Name      │       │ Type_Name       │       │ Currency_Name   │                     ║
║  │ Last_Name       │       │ Category        │       │ Exchange_Rate   │                     ║
║  │ Email           │       │ Interest_Rate   │       │ Is_Base_Currency│                     ║
║  │ Phone           │       │ Minimum_Balance │       └────────┬────────┘                     ║
║  │ Address         │       └────────┬────────┘                │                              ║
║  │ Status          │                │                         │                              ║
║  └────────┬────────┘                │                         │                              ║
║           │                         │                         │                              ║
║           │1                        │1                        │1                             ║
║           │                         │                         │                              ║
║           │N                        │N                        │N                             ║
║     ┌─────▼─────┐             ┌─────▼─────┐             ┌─────▼─────┐                       ║
║     │  ACCOUNT  │─────────────│  ACCOUNT  │─────────────│  ACCOUNT  │                       ║
║     ├───────────┤ FK          ├───────────┤ FK          ├───────────┤                       ║
║     │PK Acct_ID │◄────────────│ FK Type_ID│◄────────────│ FK Curr_CD│                       ║
║     │FK Cust_ID │             │           │             │           │                       ║
║     │FK Branch_ID│             └───────────┘             └───────────┘                       ║
║     │ Acct_Number│                                                                           ║
║     │ Balance    │                                                                           ║
║     │ Status     │                                                                           ║
║     └─────┬──────┘                                                                           ║
║           │                                                                                  ║
║           │1                                                                                 ║
║           │                                                                                  ║
║           │N                                                                                 ║
║     ┌─────▼──────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐              ║
║     │TRANSACTION │     │FIXEDDEPOSIT │     │RECURRING-   │     │   LOAN      │              ║
║     ├────────────┤     ├─────────────┤     │DEPOSIT      │     ├─────────────┤              ║
║     │PK Tran_ID  │     │PK FD_ID     │     ├─────────────┤     │PK Loan_ID   │              ║
║     │FK Acct_ID  │─────│FK Acct_ID   │     │PK RD_ID     │─────│FK Acct_ID   │              ║
║     │FK Emp_ID   │     │ Start_Date  │     │FK Acct_ID   │     │FK Cust_ID   │              ║
║     │ Amount     │     │ Maturity_Date│    │ Start_Date  │     │ Loan_Type   │              ║
║     │ Tran_Type  │     │ Amount      │     │ Maturity_Date│    │ Principal   │              ║
║     │ Tran_Date  │     │ Interest_Rate│    │ Installment │     │ Outstanding │              ║
║     └─────┬──────┘     └─────────────┘     └─────────────┘     └─────────────┘              ║
║           │N                                                                                  ║
║           │                                                                                  ║
║           │1                                                                                 ║
║     ┌─────▼──────┐     ┌─────────────┐                                                       ║
║     │  EMPLOYEE  │─────│   BRANCH    │                                                       ║
║     ├────────────┤     ├─────────────┤                                                       ║
║     │PK Emp_ID   │     │PK Branch_ID │                                                       ║
║     │FK Branch_ID│◄────│ Manager_ID  │                                                       ║
║     │ First_Name │     │ Branch_Name │                                                       ║
║     │ Last_Name  │     │ Location    │                                                       ║
║     │ Role       │     │ Phone       │                                                       ║
║     │ Supervisor_ID│    │ Status      │                                                       ║
║     └─────┬──────┘     └─────────────┘                                                       ║
║           │N                                                                                  ║
║           │                                                                                  ║
║           │1                                                                                 ║
║     ┌─────▼──────┐                                                                           ║
║     │  EMPLOYEE  │                                                                           ║
║     │(self-ref)  │                                                                           ║
║     │ FK Supervisor│                                                                         ║
║     └────────────┘                                                                           ║
║                                                                                                ║
╠══════════════════════════════════════════════════════════════════════════════════════════════╣
║  LEGEND:  PK = Primary Key | FK = Foreign Key | 1 = One side | N = Many side                  ║
║  Relationships: ──── = One-to-Many | ──── = One-to-One                                       ║
╚══════════════════════════════════════════════════════════════════════════════════════════════╝
```

---

## Summary

Congratulations on completing the hands-on lab, **Prepare a Data Model for a Transaction Processing System**. In this lab, you explored how to apply data modeling principles by designing a normalized data model and creating an Entity Relationship Diagram (ERD) in Lucidchart to visually represent the entities, attributes, and relationships in a processing system.

### What you accomplished:

| Task             | Activity                                                                                                                                  |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Task 1** | Understood the system requirements for a retail bank's transaction processing system                                                      |
| **Task 2** | Identified 10 key entities: Customer, Account, Transaction, FixedDeposit, RecurringDeposit, Loan, Branch, Employee, AccountType, Currency |
| **Task 3** | Defined comprehensive attributes with data types for each entity                                                                          |
| **Task 4** | Established relationships between entities with proper cardinality                                                                        |
| **Task 5** | Created a complete ERD using Lucidchart with proper notation                                                                              |

### Key Takeaways:

1. **Data modeling** provides a blueprint for database design that ensures consistency and integrity
2. **Normalization** reduces redundancy and prevents anomalies in transaction processing
3. **Relationships** define how entities interact and maintain referential integrity
4. **Primary keys** uniquely identify each record in a table
5. **Foreign keys** establish links between related tables
6. **Cardinality** specifies the number of occurrences in a relationship

### Business Value:

This data model enables the retail bank to:

- Track customer accounts and transactions accurately
- Manage specialized products like Fixed Deposits and Recurring Deposits
- Support multi-currency transactions
- Maintain audit trails for regulatory compliance
- Enable fraud detection through transaction pattern analysis
- Support scalable growth with a well-structured data foundation

---

## Exemplar Comparison

You can right-click to refer to the exemplar document to create an ERD for visually representing the entities, attributes, and relationships in a processing system.

Please remember that the exemplar is just a point of view and not a definitive solution. Your ERD may include additional entities or attributes based on your interpretation of the requirements.

---

*Lab completed: _________________*
*Instructor signature: _________________*
