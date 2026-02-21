


![FutureMart](../Screenshots/FutureMart.png)


# Lab: Migrate the Data to the New Data Architecture

## Estimated time: 30 minutes

---

## Learning objectives

- Apply data migration techniques to transfer data to the new architecture
- Design appropriate schemas and migration strategies that align with the EDA standards during the transition

---

## About SN Labs and Cloud IDE

Skills Network (SN) Labs offer a fully functional environment - **Cloud IDE** - for course and project-related labs. It runs on **Theia**, an open-source integrated development environment (IDE) compatible with desktop and cloud platforms.

With this Cloud IDE, you can access Theia and MySQL, both running in a Docker container. It has all the essential tools needed to complete your lab efficiently.

---

## Consideration to work in the lab environment

> **This lab environment does not save your session data.** Each time you connect, a new environment is created. To prevent data loss, plan to complete the lab in a single session.

---

## Introduction

In this lab, you will execute data migration activities per the Enterprise Data Architecture (EDA) blueprint developed in the project's earlier phases. The goal is to mimic real-world like data integration scenarios by operating in a staging environment. This enables secure testing and experimentation before implementing changes in the production environment.

You will execute the following migrations:

| Migration            | Direction      | Description                                         |
| -------------------- | -------------- | --------------------------------------------------- |
| **Exercise 1** | RDBMS → NoSQL | Transfer product catalog data from MySQL to MongoDB |
| **Exercise 2** | NoSQL → RDBMS | Transfer product returns data from MongoDB to MySQL |

These exercises will allow you to appreciate the intricacies of working across different database technologies and ensure your data migration strategies align with the architectural standards you've established.

**Let's get started!**

---

## Exercise 1: Migrating data from RDBMS to NoSQL database

TrendyThreads initially stored all product catalog information in a traditional Relational Database Management System (RDBMS). However, due to the flexibility and scalability offered by schemaless databases, a NoSQL database has been chosen as the new platform for managing product catalog data. In this exercise, you will migrate data from the MySQL database to the MongoDB database.

> **Note:** This [mongoimport command reference file](https://docs.mongodb.com/database-tools/mongoimport/) will be helpful in finishing this exercise.

---

### Step 0: Initialize the source RDBMS database

#### 1. Start the MySQL server

Ensure the MySQL service is up and running on your system.

```bash
# Check MySQL status
sudo systemctl status mysql

# If not running, start MySQL
sudo systemctl start mysql
```

#### 2. Download the database initialization script

Run the command below to download the database initializer script.

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/zAjsXWY5_32IwexYkhzrAw/initialize-mysqldb.py
```

**Expected Output:**

```
--2026-02-21 03:15:30--  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/zAjsXWY5_32IwexYkhzrAw/initialize-mysqldb.py
Resolving cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud...
Connecting to cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud|...|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 4250 (4.2K) [text/x-python]
Saving to: 'initialize-mysqldb.py'

initialize-mysqldb.py     100%[=====================================>]   4.15K  --.-KB/s    in 0s
```

#### 3. Initialize the MySQL database

Run the commands below to initialize the MySQL server.

```bash
# Install required Python packages
python3 -m pip install mysql-connector-python pymongo

# Run the initialization script
python3 initialize-mysqldb.py
```

**Expected Output:**

```
✅ MySQL connector installed
✅ PyMongo installed
🔄 Connecting to MySQL...
✅ Connected to MySQL successfully
🔄 Creating database 'product_catalog'...
✅ Database 'product_catalog' created/verified
🔄 Creating tables...
✅ Tables created successfully
🔄 Inserting sample data...
✅ Inserted 25 sample products
✅ Inserted 5 sample categories
✅ Inserted 3 sample suppliers
✅ MySQL initialization complete!
```

**MySQL Schema Created:**

The initialization script creates the following schema:

```sql
-- Categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Suppliers table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    description TEXT,
    category_id INT,
    supplier_id INT,
    size VARCHAR(20),
    color VARCHAR(50),
    material VARCHAR(100),
    unit_price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
```

---

### Step 1: Perform the data migration

Migrate the contents of the `product_catalog` database from the MySQL server to the `product_catalog` database in MongoDB.

#### Method 1: Using Python Script

Create a migration script `migrate_mysql_to_mongo.py`:

```python
#!/usr/bin/env python3
"""
Migration Script: MySQL to MongoDB
Migrates product catalog data from MySQL to MongoDB
"""

import mysql.connector
import pymongo
import json
from datetime import datetime

# MySQL Connection Configuration
mysql_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',  # Add password if required
    'database': 'product_catalog'
}

# MongoDB Connection Configuration
mongo_client = pymongo.MongoClient('mongodb://localhost:27017/')
mongo_db = mongo_client['product_catalog']

def migrate_categories():
    """Migrate categories from MySQL to MongoDB"""
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor(dictionary=True)
  
    cursor.execute("SELECT * FROM categories")
    categories = cursor.fetchall()
  
    if categories:
        # Add migration metadata
        for cat in categories:
            cat['migrated_at'] = datetime.now()
      
        mongo_db.categories.insert_many(categories)
        print(f"✅ Migrated {len(categories)} categories")
  
    cursor.close()
    conn.close()
    return len(categories)

def migrate_suppliers():
    """Migrate suppliers from MySQL to MongoDB"""
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor(dictionary=True)
  
    cursor.execute("SELECT * FROM suppliers")
    suppliers = cursor.fetchall()
  
    if suppliers:
        for sup in suppliers:
            sup['migrated_at'] = datetime.now()
      
        mongo_db.suppliers.insert_many(suppliers)
        print(f"✅ Migrated {len(suppliers)} suppliers")
  
    cursor.close()
    conn.close()
    return len(suppliers)

def migrate_products():
    """Migrate products from MySQL to MongoDB with embedded relations"""
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor(dictionary=True)
  
    cursor.execute("""
        SELECT 
            p.*,
            c.category_name,
            c.parent_category_id,
            s.supplier_name,
            s.contact_name as supplier_contact,
            s.city as supplier_city,
            s.country as supplier_country
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.category_id
        LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
    """)
  
    products = cursor.fetchall()
  
    if products:
        mongo_products = []
        for prod in products:
            # Create denormalized document
            mongo_prod = {
                'product_id': prod['product_id'],
                'sku': prod['sku'],
                'product_name': prod['product_name'],
                'description': prod['description'],
                'size': prod['size'],
                'color': prod['color'],
                'material': prod['material'],
                'unit_price': float(prod['unit_price']),
                'cost': float(prod['cost']),
                'stock_quantity': prod['stock_quantity'],
                'is_active': bool(prod['is_active']),
                'created_at': prod['created_at'].isoformat() if prod['created_at'] else None,
                'updated_at': prod['updated_at'].isoformat() if prod['updated_at'] else None,
                'category': {
                    'category_id': prod['category_id'],
                    'category_name': prod['category_name'],
                    'parent_category_id': prod['parent_category_id']
                } if prod['category_id'] else None,
                'supplier': {
                    'supplier_id': prod['supplier_id'],
                    'supplier_name': prod['supplier_name'],
                    'contact_name': prod['supplier_contact'],
                    'city': prod['supplier_city'],
                    'country': prod['supplier_country']
                } if prod['supplier_id'] else None,
                'migrated_at': datetime.now().isoformat()
            }
            mongo_products.append(mongo_prod)
      
        mongo_db.products.insert_many(mongo_products)
        print(f"✅ Migrated {len(mongo_products)} products")
  
    cursor.close()
    conn.close()
    return len(products)

def main():
    print("="*50)
    print("MYSQL TO MONGODB MIGRATION")
    print("="*50)
  
    total = 0
    total += migrate_categories()
    total += migrate_suppliers()
    total += migrate_products()
  
    print(f"\n✅ Total records migrated: {total}")
    print("="*50)

if __name__ == "__main__":
    main()
```

Run the migration script:

```bash
python3 migrate_mysql_to_mongo.py
```

**Expected Output:**

```
==================================================
MYSQL TO MONGODB MIGRATION
==================================================
✅ Migrated 5 categories
✅ Migrated 3 suppliers
✅ Migrated 25 products

✅ Total records migrated: 33
==================================================
```

#### Method 2: Using mongoimport (Alternative)

If you prefer to use command-line tools, first export MySQL data to JSON:

```bash
# Export categories
mysql -u root -p product_catalog -e "SELECT * FROM categories" --batch --raw > categories.csv

# Convert to JSON and import
mongoimport --db product_catalog --collection categories --file categories.json --jsonArray
```

---

### Step 2: Run the post migration validation script

#### 1. Download the validation script

Run the command below to download the lab check script.

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/CS4WZfaShihm74lUk4JYeg/mysql2mongo-lab-check.py
```

**Expected Output:**

```
--2026-02-21 03:20:15--  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/CS4WZfaShihm74lUk4JYeg/mysql2mongo-lab-check.py
Resolving cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud...
Connecting... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3850 (3.8K) [text/x-python]
Saving to: 'mysql2mongo-lab-check.py'

mysql2mongo-lab-check.py  100%[=====================================>]   3.76K  --.-KB/s    in 0s
```

#### 2. Execute the validation script to capture the migration status

Run the command below to generate the migration report.

```bash
python3 mysql2mongo-lab-check.py
```

**Expected Output:**

```
==================================================
MYSQL TO MONGODB MIGRATION VALIDATION
==================================================

🔍 Checking MySQL source database...
✅ MySQL connection successful
📊 MySQL record counts:
   - Categories: 5
   - Suppliers: 3
   - Products: 25

🔍 Checking MongoDB target database...
✅ MongoDB connection successful
📊 MongoDB record counts:
   - Categories: 5
   - Suppliers: 3
   - Products: 25

🔍 Validating data integrity...
✅ Category records match: 5/5
✅ Supplier records match: 3/3
✅ Product records match: 25/25

🔍 Sample document validation:
   Sample product: "Classic Black T-Shirt" (SKU: TS-MEN-BLK-L)
   - Category embedded: Yes
   - Supplier embedded: Yes
   - Price preserved: $24.99

📝 Generating validation report...

✅ Migration VALIDATION PASSED!
📄 Report saved to: rdbms2nosql.txt
==================================================
```

#### 3. Save the generated output file

The above script will generate a text file named `rdbms2nosql.txt`.

```bash
# View the validation report
cat rdbms2nosql.txt
```

**Expected Output (rdbms2nosql.txt):**

```
MYSQL TO MONGODB MIGRATION VALIDATION REPORT
=============================================
Date: 2026-02-21 03:21:45
Status: PASSED

SOURCE DATABASE (MySQL): product_catalog
----------------------------------------
Categories: 5 records
Suppliers: 3 records
Products: 25 records

TARGET DATABASE (MongoDB): product_catalog
-------------------------------------------
Categories: 5 records
Suppliers: 3 records
Products: 25 records

VALIDATION RESULTS
------------------
✓ Categories count matches: 5 = 5
✓ Suppliers count matches: 3 = 3
✓ Products count matches: 25 = 25
✓ Data integrity check passed

SAMPLE MIGRATED DOCUMENT
------------------------
{
  "_id": ObjectId("..."),
  "product_id": 1001,
  "sku": "TS-MEN-BLK-L",
  "product_name": "Classic Black T-Shirt",
  "category": {
    "category_id": 4,
    "category_name": "T-Shirts"
  },
  "supplier": {
    "supplier_name": "Cotton Industries"
  }
}

MIGRATION SUMMARY
-----------------
Total records migrated: 33
Migration timestamp: 2026-02-21 03:21:45
Validation timestamp: 2026-02-21 03:21:50

✅ MIGRATION VALIDATION PASSED
```

Download and save this file to your local machine. **This file is required for final project submission.**

---

## Exercise 2: Migrating data from NoSQL to RDBMS

FashionMart originally stored structured product returns data in a schemaless NoSQL database. However, to better manage structured and relational data, the organization has decided to migrate this information to a Relational Database Management System (RDBMS).

In this exercise, you will migrate product returns data from a MongoDB database to a MySQL database while designing the appropriate schema for structured storage.

---

### Step 0: Initialize the source MongoDB database

#### 1. Start the MongoDB server

Make sure the MongoDB service is running.

```bash
# Check MongoDB status
sudo systemctl status mongod

# If not running, start MongoDB
sudo systemctl start mongod
```

#### 2. Download the database initialization script

Run the command below to download the database initializer script.

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/sEYK9WTXN6K6Ho3aKhCmpw/initialize-mongodb.py
```

**Expected Output:**

```
--2026-02-21 03:25:30--  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/sEYK9WTXN6K6Ho3aKhCmpw/initialize-mongodb.py
Resolving cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud...
Connecting... connected.
HTTP request sent, awaiting response... 200 OK
Length: 4100 (4.1K) [text/x-python]
Saving to: 'initialize-mongodb.py'

initialize-mongodb.py     100%[=====================================>]   4.10K  --.-KB/s    in 0s
```

#### 3. Initialize the MongoDB database

Run the commands below to initialize the MongoDB database.

```bash
# Install required Python packages (if not already installed)
python3 -m pip install mysql-connector-python pymongo

# Run the initialization script
python3 initialize-mongodb.py
```

**Expected Output:**

```
✅ Required packages installed
🔄 Connecting to MongoDB...
✅ Connected to MongoDB successfully
🔄 Creating database 'product_returns'...
✅ Database 'product_returns' created
🔄 Creating collections...
✅ Collections created
🔄 Inserting sample data...
✅ Inserted 15 return records
✅ Inserted 10 return reasons
✅ Inserted 8 resolution types
✅ MongoDB initialization complete!
```

**MongoDB Data Structure:**

The initialization script creates the following document structure:

```javascript
// Returns collection sample document
{
  "_id": ObjectId("..."),
  "return_id": "R1001",
  "order_id": "O5001",
  "product_id": 1001,
  "customer_id": 2001,
  "return_date": ISODate("2026-01-15T10:30:00Z"),
  "quantity": 1,
  "return_reason": {
    "code": "DAMAGED",
    "description": "Product arrived damaged"
  },
  "condition": "Damaged",
  "refund_amount": 24.99,
  "refund_method": "Original Payment",
  "resolution": {
    "type": "REFUND",
    "description": "Full refund issued",
    "processed_by": "agent123",
    "processed_date": ISODate("2026-01-16T09:15:00Z")
  },
  "status": "Completed",
  "notes": "Customer provided photos of damage",
  "created_at": ISODate("2026-01-15T10:30:00Z")
}

// Return reasons collection sample
{
  "_id": ObjectId("..."),
  "reason_code": "DAMAGED",
  "reason_description": "Product arrived damaged",
  "category": "Shipping Damage",
  "requires_photo": true
}

// Resolution types collection sample
{
  "_id": ObjectId("..."),
  "resolution_code": "REFUND",
  "resolution_description": "Full refund to original payment method",
  "processing_time_days": 3
}
```

---

### Step 1: Perform the data migration

Migrate the data from the `product_returns` database on the MongoDB server to tables in the `product_returns` database on the MySQL server. Ensure the data is correctly transformed and mapped during the migration process.

Create a migration script `migrate_mongo_to_mysql.py`:

```python
#!/usr/bin/env python3
"""
Migration Script: MongoDB to MySQL
Migrates product returns data from MongoDB to MySQL
"""

import mysql.connector
import pymongo
from datetime import datetime

# MongoDB Connection
mongo_client = pymongo.MongoClient('mongodb://localhost:27017/')
mongo_db = mongo_client['product_returns']

# MySQL Connection Configuration
mysql_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',  # Add password if required
    'database': 'product_returns'
}

def create_mysql_tables():
    """Create target tables in MySQL"""
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor()
  
    # Create return_reasons table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS return_reasons (
            reason_id INT PRIMARY KEY AUTO_INCREMENT,
            reason_code VARCHAR(50) UNIQUE NOT NULL,
            reason_description TEXT,
            category VARCHAR(100),
            requires_photo BOOLEAN DEFAULT FALSE,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
  
    # Create resolution_types table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS resolution_types (
            resolution_id INT PRIMARY KEY AUTO_INCREMENT,
            resolution_code VARCHAR(50) UNIQUE NOT NULL,
            resolution_description TEXT,
            processing_time_days INT DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
  
    # Create returns table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS returns (
            return_id VARCHAR(20) PRIMARY KEY,
            order_id VARCHAR(20) NOT NULL,
            product_id INT NOT NULL,
            customer_id INT NOT NULL,
            return_date DATETIME NOT NULL,
            quantity INT NOT NULL,
            reason_code VARCHAR(50),
            condition VARCHAR(50),
            refund_amount DECIMAL(10,2),
            refund_method VARCHAR(50),
            resolution_code VARCHAR(50),
            status VARCHAR(50),
            notes TEXT,
            processed_by VARCHAR(50),
            processed_date DATETIME,
            created_at DATETIME,
            migrated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (reason_code) REFERENCES return_reasons(reason_code),
            FOREIGN KEY (resolution_code) REFERENCES resolution_types(resolution_code)
        )
    """)
  
    conn.commit()
    cursor.close()
    conn.close()
    print("✅ MySQL tables created/verified")

def migrate_return_reasons():
    """Migrate return reasons from MongoDB to MySQL"""
    reasons = list(mongo_db.return_reasons.find())
  
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor()
  
    count = 0
    for reason in reasons:
        cursor.execute("""
            INSERT INTO return_reasons 
            (reason_code, reason_description, category, requires_photo)
            VALUES (%s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
            reason_description = VALUES(reason_description),
            category = VALUES(category),
            requires_photo = VALUES(requires_photo)
        `, (
            reason.get('reason_code'),
            reason.get('reason_description'),
            reason.get('category'),
            reason.get('requires_photo', False)
        ))
        count += cursor.rowcount
  
    conn.commit()
    cursor.close()
    conn.close()
    print(f"✅ Migrated {count} return reasons")
    return count

def migrate_resolution_types():
    """Migrate resolution types from MongoDB to MySQL"""
    resolutions = list(mongo_db.resolution_types.find())
  
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor()
  
    count = 0
    for res in resolutions:
        cursor.execute("""
            INSERT INTO resolution_types 
            (resolution_code, resolution_description, processing_time_days)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE
            resolution_description = VALUES(resolution_description),
            processing_time_days = VALUES(processing_time_days)
        `, (
            res.get('resolution_code'),
            res.get('resolution_description'),
            res.get('processing_time_days', 0)
        ))
        count += cursor.rowcount
  
    conn.commit()
    cursor.close()
    conn.close()
    print(f"✅ Migrated {count} resolution types")
    return count

def migrate_returns():
    """Migrate returns from MongoDB to MySQL"""
    returns = list(mongo_db.returns.find())
  
    conn = mysql.connector.connect(**mysql_config)
    cursor = conn.cursor()
  
    count = 0
    for ret in returns:
        # Extract nested fields
        reason = ret.get('return_reason', {})
        resolution = ret.get('resolution', {})
      
        cursor.execute("""
            INSERT INTO returns 
            (return_id, order_id, product_id, customer_id, return_date,
             quantity, reason_code, condition, refund_amount, refund_method,
             resolution_code, status, notes, processed_by, processed_date, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
            status = VALUES(status),
            notes = VALUES(notes),
            processed_by = VALUES(processed_by),
            processed_date = VALUES(processed_date)
        `, (
            ret.get('return_id'),
            ret.get('order_id'),
            ret.get('product_id'),
            ret.get('customer_id'),
            ret.get('return_date'),
            ret.get('quantity', 1),
            reason.get('code'),
            ret.get('condition'),
            ret.get('refund_amount'),
            ret.get('refund_method'),
            resolution.get('type'),
            ret.get('status'),
            ret.get('notes'),
            resolution.get('processed_by'),
            resolution.get('processed_date'),
            ret.get('created_at')
        ))
        count += cursor.rowcount
  
    conn.commit()
    cursor.close()
    conn.close()
    print(f"✅ Migrated {count} return records")
    return count

def main():
    print("="*50)
    print("MONGODB TO MYSQL MIGRATION")
    print("="*50)
  
    # Create target tables
    create_mysql_tables()
  
    # Perform migration
    total = 0
    total += migrate_return_reasons()
    total += migrate_resolution_types()
    total += migrate_returns()
  
    print(f"\n✅ Total records migrated: {total}")
    print("="*50)

if __name__ == "__main__":
    main()
```

Run the migration script:

```bash
python3 migrate_mongo_to_mysql.py
```

**Expected Output:**

```
==================================================
MONGODB TO MYSQL MIGRATION
==================================================
✅ MySQL tables created/verified
✅ Migrated 10 return reasons
✅ Migrated 8 resolution types
✅ Migrated 15 return records

✅ Total records migrated: 33
==================================================
```

---

### Step 2: Run the post migration validation script

#### 1. Download the validation script

Run the command below to download the lab check script.

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/WpwvD4SopTBr3K7yIEWDWA/mongo2mysql-lab-check.py
```

**Expected Output:**

```
--2026-02-21 03:30:45--  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/WpwvD4SopTBr3K7yIEWDWA/mongo2mysql-lab-check.py
Resolving cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud...
Connecting... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3950 (3.9K) [text/x-python]
Saving to: 'mongo2mysql-lab-check.py'

mongo2mysql-lab-check.py  100%[=====================================>]   3.86K  --.-KB/s    in 0s
```

#### 2. Execute the validation script to capture the migration status

Run the command below to generate the migration report.

```bash
python3 mongo2mysql-lab-check.py
```

**Expected Output:**

```
==================================================
MONGODB TO MYSQL MIGRATION VALIDATION
==================================================

🔍 Checking MongoDB source database...
✅ MongoDB connection successful
📊 MongoDB record counts:
   - return_reasons: 10
   - resolution_types: 8
   - returns: 15

🔍 Checking MySQL target database...
✅ MySQL connection successful
📊 MySQL record counts:
   - return_reasons: 10
   - resolution_types: 8
   - returns: 15

🔍 Validating data integrity...
✅ Return reasons match: 10/10
✅ Resolution types match: 8/8
✅ Returns match: 15/15

🔍 Checking referential integrity...
✅ All returns reference valid reason codes
✅ All returns reference valid resolution codes

🔍 Sample record validation:
   Sample return: "R1001"
   - Order ID: O5001
   - Product ID: 1001
   - Reason: DAMAGED (valid)
   - Resolution: REFUND (valid)
   - Refund amount: $24.99

📝 Generating validation report...

✅ Migration VALIDATION PASSED!
📄 Report saved to: nosql2rdbms.txt
==================================================
```

#### 3. Save the generated output file

The above script will generate a text file named `nosql2rdbms.txt`.

```bash
# View the validation report
cat nosql2rdbms.txt
```

**Expected Output (nosql2rdbms.txt):**

```
MONGODB TO MYSQL MIGRATION VALIDATION REPORT
==============================================
Date: 2026-02-21 03:32:15
Status: PASSED

SOURCE DATABASE (MongoDB): product_returns
------------------------------------------
return_reasons: 10 records
resolution_types: 8 records
returns: 15 records

TARGET DATABASE (MySQL): product_returns
----------------------------------------
return_reasons: 10 records
resolution_types: 8 records
returns: 15 records

VALIDATION RESULTS
------------------
✓ Return reasons count matches: 10 = 10
✓ Resolution types count matches: 8 = 8
✓ Returns count matches: 15 = 15
✓ Referential integrity check passed

SAMPLE MIGRATED RECORD
-----------------------
Return ID: R1001
Order ID: O5001
Product ID: 1001
Return Date: 2026-01-15 10:30:00
Reason Code: DAMAGED (Product arrived damaged)
Resolution Code: REFUND (Full refund)
Refund Amount: 24.99
Status: Completed

MIGRATION SUMMARY
-----------------
Total records migrated: 33
Migration timestamp: 2026-02-21 03:31:30
Validation timestamp: 2026-02-21 03:32:15

✅ MIGRATION VALIDATION PASSED
```

Download and save this file to your local machine. **This file is required for final project submission.**

---

## Summary

Congratulations on completing this **Lab: Migrate the Data to the New Data Architecture**. In this lab, you executed a critical part of FutureMart's data transformation by implementing the migration strategy defined in your EDA blueprint.

| Exercise             | Migration                          | Records | Status |
| -------------------- | ---------------------------------- | ------- | ------ |
| **Exercise 1** | MySQL → MongoDB (Product Catalog) | 33      | ✅     |
| **Exercise 2** | MongoDB → MySQL (Product Returns) | 33      | ✅     |

### Key Learnings

| Aspect                   | Description                                                                                                             |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| **RDBMS → NoSQL** | Denormalization strategy: embedding related data (categories, suppliers) within product documents for flexible querying |
| **NoSQL → RDBMS** | Normalization strategy: extracting embedded documents into separate related tables with foreign key constraints         |
| **Data Integrity** | Preserved referential integrity through proper schema design and validation                                             |
| **Validation**     | Automated validation scripts ensure complete and accurate migration                                                     |

### Deliverables

| File                | Description                                  | Status |
| ------------------- | -------------------------------------------- | ------ |
| `rdbms2nosql.txt` | MySQL → MongoDB migration validation report | ⬜     |
| `nosql2rdbms.txt` | MongoDB → MySQL migration validation report | ⬜     |

These migration exercises demonstrate the bidirectional data flow capabilities required for FutureMart's hybrid architecture, enabling seamless integration of both companies' data assets into the new unified platform.

---

## Author(s)

**Ramesh Sannareddy**

---

*Lab completed: _________________*
*Data Migration Engineer: _________________*
*Date: _________________*
