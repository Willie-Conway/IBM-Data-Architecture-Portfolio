

![FutureMart](../Screenshots/FutureMart.png)


# Assignment Overview: Data Migration to New Architecture

## Estimated time: 4 minutes

---

## Learning objectives

- Apply data migration techniques to transfer data to the new architecture
- Design appropriate schemas and migration strategies that align with the EDA standards during the transition

---

## Introduction

In **Phase 1**, you thoroughly assessed the existing data architectures of FashionMart and TrendyThreads. This involved examining their data storage systems, integration mechanisms, data quality processes, security protocols, compliance standards, and governance frameworks. You documented the current architectures, identified silos, inefficiencies, and bottlenecks, and proposed opportunities for improvement based on best practices.

In **Phase 2**, you applied the insights gained from the assessment to design the future data architecture for the merged organization, **FutureMart**. You created architectural diagrams for the new databases, developed ER diagrams and table designs, and built initial schemas. Your design addressed previously identified gaps and inefficiencies, setting the foundation for a scalable and efficient data infrastructure.

In this module, you will work on the tasks of **Phase 3**.

---

## Phase 3: Develop and Implement Data Migration Strategy

In this phase, you will focus on building and executing a comprehensive data migration strategy for FutureMart. You'll plan data migration between TrendyThreads' digital-first systems and FashionMart's traditional infrastructure. This includes transferring data across relational RDBMS and NoSQL databases, ensuring data integrity, compatibility, and consistency. The goal is to seamlessly transition to the newly designed architecture without disrupting ongoing business operations.

### Migration Strategy Overview

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                      FUTUREMART DATA MIGRATION STRATEGY                          │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│  ┌─────────────────────┐                 ┌─────────────────────┐                 │
│  │   FASHIONMART       │                 │   TRENDYTHREADS     │                 │
│  │   (Source Systems)  │                 │   (Source Systems)  │                 │
│  ├─────────────────────┤                 ├─────────────────────┤                 │
│  │ • MySQL RDBMS       │                 │ • MongoDB NoSQL     │                 │
│  │ • PostgreSQL        │                 │ • Real-time stores  │                 │
│  │ • Legacy systems    │                 │ • Cloud storage     │                 │
│  └──────────┬──────────┘                 └──────────┬──────────┘                 │
│             │                                       │                            │
│             └───────────────┬───────────────────────┘                            │
│                             ▼                                                    │
│        ┌─────────────────────────────────────────┐                              │
│        │         EXTRACTION & TRANSFORMATION      │                              │
│        │         ────────────────────────         │                              │
│        │  • Data cleansing                        │                              │
│        │  • Schema mapping                         │                              │
│        │  • Data validation                         │                              │
│        │  • Format conversion                       │                              │
│        └───────────────────┬─────────────────────┘                              │
│                            │                                                      │
│           ┌────────────────┼────────────────┐                                     │
│           │                │                │                                     │
│           ▼                ▼                ▼                                     │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐                   │
│  │  Exercise 1     │  │  Exercise 2     │  │  Future Phases  │                   │
│  │  RDBMS → NoSQL  │  │  NoSQL → RDBMS  │  │  • Legacy data  │                   │
│  │  Product Catalog│  │  Product Catalog│  │  • Customer data│                   │
│  │  MySQL → MongoDB│  │  MongoDB → MySQL│  │  • Order history│                   │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘                   │
│           │                    │                    │                            │
│           └────────────────────┼────────────────────┘                            │
│                                ▼                                                 │
│        ┌─────────────────────────────────────────┐                              │
│        │           FUTUREMART TARGET              │                              │
│        │           ─────────────────               │                              │
│        │  • Data Warehouse (Snowflake/BigQuery)   │                              │
│        │  • Operational DB (PostgreSQL)           │                              │
│        │  • Real-time Store (Redis/DynamoDB)      │                              │
│        │  • Data Lake (S3/GCS)                    │                              │
│        └─────────────────────────────────────────┘                              │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## Tasks

### Exercise 1: Migrate Product Catalog Data from RDBMS to NoSQL

In this exercise, you will migrate product catalog data from a MySQL relational database to a MongoDB NoSQL database. This migration represents moving FashionMart's structured product data to TrendyThreads' modern NoSQL architecture.

#### Step 1: Initialize the Source RDBMS Database

Set up the source MySQL database environment with sample product catalog data.

**MySQL Source Schema:**

```sql
-- Create source database
CREATE DATABASE IF NOT EXISTS fashionmart_products;
USE fashionmart_products;

-- Create product categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

-- Create suppliers table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create products table
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

-- Insert sample categories
INSERT INTO categories (category_id, category_name, parent_category_id, description) VALUES
(1, 'Apparel', NULL, 'All clothing items'),
(2, 'Men\'s Apparel', 1, 'Clothing for men'),
(3, 'Women\'s Apparel', 1, 'Clothing for women'),
(4, 'T-Shirts', 2, 'Casual t-shirts for men'),
(5, 'Jeans', 2, 'Denim jeans for men'),
(6, 'Dresses', 3, 'Women\'s dresses'),
(7, 'Accessories', NULL, 'Fashion accessories');

-- Insert sample suppliers
INSERT INTO suppliers (supplier_id, supplier_name, contact_name, contact_email, city, country) VALUES
(101, 'Cotton Industries', 'James Wilson', 'james@cottonind.com', 'Mumbai', 'India'),
(102, 'Denim Co.', 'Sarah Chen', 'sarah@denimco.com', 'Shanghai', 'China'),
(103, 'Fashion Fabrics', 'Maria Garcia', 'maria@fashionfabrics.com', 'Mexico City', 'Mexico');

-- Insert sample products
INSERT INTO products (product_id, sku, product_name, category_id, supplier_id, size, color, material, unit_price, cost, stock_quantity) VALUES
(1001, 'TS-MEN-BLK-L', 'Classic Black T-Shirt', 4, 101, 'L', 'Black', 'Cotton', 24.99, 12.50, 150),
(1002, 'TS-MEN-BLK-M', 'Classic Black T-Shirt', 4, 101, 'M', 'Black', 'Cotton', 24.99, 12.50, 75),
(1003, 'TS-MEN-BLK-S', 'Classic Black T-Shirt', 4, 101, 'S', 'Black', 'Cotton', 24.99, 12.50, 50),
(1004, 'TS-MEN-WHT-L', 'Classic White T-Shirt', 4, 101, 'L', 'White', 'Cotton', 24.99, 12.50, 120),
(1005, 'JN-MEN-BLU-32', 'Slim Fit Blue Jeans', 5, 102, '32', 'Blue', 'Denim', 79.99, 35.00, 50),
(1006, 'JN-MEN-BLU-34', 'Slim Fit Blue Jeans', 5, 102, '34', 'Blue', 'Denim', 79.99, 35.00, 45),
(1007, 'JN-MEN-BLK-32', 'Slim Fit Black Jeans', 5, 102, '32', 'Black', 'Denim', 79.99, 35.00, 30),
(1008, 'DR-WMN-RED-S', 'Summer Red Dress', 6, 103, 'S', 'Red', 'Polyester', 89.99, 42.00, 25),
(1009, 'DR-WMN-RED-M', 'Summer Red Dress', 6, 103, 'M', 'Red', 'Polyester', 89.99, 42.00, 30),
(1010, 'DR-WMN-BLU-S', 'Summer Blue Dress', 6, 103, 'S', 'Blue', 'Polyester', 89.99, 42.00, 20);
```

#### Step 2: Perform Data Migration (RDBMS → NoSQL)

Create a migration script to transfer data from MySQL to MongoDB.

**Python Migration Script (save as `migrate_rdbms_to_nosql.py`):**

```python
#!/usr/bin/env python3
"""
Migration Script: MySQL to MongoDB
Migrates product catalog data from FashionMart MySQL to FutureMart MongoDB
"""

import pymysql
import pymongo
import json
from datetime import datetime

# MySQL Connection Configuration
mysql_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'fashionmart_products',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

# MongoDB Connection Configuration
mongo_config = {
    'host': 'localhost',
    'port': 27017,
    'database': 'futuremart'
}

def connect_mysql():
    """Establish MySQL connection"""
    try:
        connection = pymysql.connect(**mysql_config)
        print("✅ Connected to MySQL successfully")
        return connection
    except Exception as e:
        print(f"❌ MySQL connection failed: {e}")
        return None

def connect_mongodb():
    """Establish MongoDB connection"""
    try:
        client = pymongo.MongoClient(host=mongo_config['host'], port=mongo_config['port'])
        db = client[mongo_config['database']]
        print("✅ Connected to MongoDB successfully")
        return db
    except Exception as e:
        print(f"❌ MongoDB connection failed: {e}")
        return None

def migrate_categories(mysql_conn, mongo_db):
    """Migrate categories from MySQL to MongoDB"""
    with mysql_conn.cursor() as cursor:
        cursor.execute("SELECT * FROM categories")
        categories = cursor.fetchall()
      
        if categories:
            # Convert to MongoDB document format
            for cat in categories:
                cat['_id'] = cat.pop('category_id')
                cat['migrated_at'] = datetime.now()
          
            result = mongo_db.categories.insert_many(categories)
            print(f"✅ Migrated {len(result.inserted_ids)} categories")
        else:
            print("ℹ️ No categories found to migrate")

def migrate_suppliers(mysql_conn, mongo_db):
    """Migrate suppliers from MySQL to MongoDB"""
    with mysql_conn.cursor() as cursor:
        cursor.execute("SELECT * FROM suppliers")
        suppliers = cursor.fetchall()
      
        if suppliers:
            # Convert to MongoDB document format
            for sup in suppliers:
                sup['_id'] = sup.pop('supplier_id')
                sup['migrated_at'] = datetime.now()
          
            result = mongo_db.suppliers.insert_many(suppliers)
            print(f"✅ Migrated {len(result.inserted_ids)} suppliers")
        else:
            print("ℹ️ No suppliers found to migrate")

def migrate_products(mysql_conn, mongo_db):
    """Migrate products from MySQL to MongoDB with embedded category and supplier info"""
    with mysql_conn.cursor() as cursor:
        # Get all products with joined category and supplier data
        cursor.execute("""
            SELECT 
                p.*,
                c.category_name,
                c.parent_category_id,
                s.supplier_name,
                s.contact_name as supplier_contact,
                s.contact_email as supplier_email,
                s.city as supplier_city,
                s.country as supplier_country
            FROM products p
            LEFT JOIN categories c ON p.category_id = c.category_id
            LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
        """)
        products = cursor.fetchall()
      
        if products:
            # Transform to denormalized document structure for MongoDB
            mongo_products = []
            for prod in products:
                mongo_prod = {
                    '_id': prod.pop('product_id'),
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
                    'created_at': prod['created_at'],
                    'updated_at': prod['updated_at'],
                    'category': {
                        'category_id': prod['category_id'],
                        'category_name': prod['category_name'],
                        'parent_category_id': prod['parent_category_id']
                    } if prod['category_id'] else None,
                    'supplier': {
                        'supplier_id': prod['supplier_id'],
                        'supplier_name': prod['supplier_name'],
                        'contact_name': prod['supplier_contact'],
                        'contact_email': prod['supplier_email'],
                        'location': {
                            'city': prod['supplier_city'],
                            'country': prod['supplier_country']
                        }
                    } if prod['supplier_id'] else None,
                    'migrated_at': datetime.now()
                }
                mongo_products.append(mongo_prod)
          
            result = mongo_db.products.insert_many(mongo_products)
            print(f"✅ Migrated {len(result.inserted_ids)} products")
        else:
            print("ℹ️ No products found to migrate")

def validate_migration(mongo_db):
    """Validate the migration by counting documents"""
    print("\n" + "="*50)
    print("MIGRATION VALIDATION RESULTS")
    print("="*50)
  
    categories_count = mongo_db.categories.count_documents({})
    suppliers_count = mongo_db.suppliers.count_documents({})
    products_count = mongo_db.products.count_documents({})
  
    print(f"📊 Categories in MongoDB: {categories_count}")
    print(f"📊 Suppliers in MongoDB: {suppliers_count}")
    print(f"📊 Products in MongoDB: {products_count}")
  
    # Sample validation queries
    print("\n🔍 Sample product with embedded category and supplier:")
    sample_product = mongo_db.products.find_one({}, {'_id': 1, 'sku': 1, 'product_name': 1, 'category': 1, 'supplier.supplier_name': 1})
    print(json.dumps(sample_product, indent=2, default=str))
  
    return categories_count > 0 and suppliers_count > 0 and products_count > 0

def main():
    print("="*50)
    print("MYSQL TO MONGODB MIGRATION")
    print("="*50)
  
    # Connect to databases
    mysql_conn = connect_mysql()
    if not mysql_conn:
        return
  
    mongo_db = connect_mongodb()
    if not mongo_db:
        mysql_conn.close()
        return
  
    try:
        # Perform migration
        print("\n📦 Migrating categories...")
        migrate_categories(mysql_conn, mongo_db)
      
        print("\n📦 Migrating suppliers...")
        migrate_suppliers(mysql_conn, mongo_db)
      
        print("\n📦 Migrating products...")
        migrate_products(mysql_conn, mongo_db)
      
        # Validate migration
        success = validate_migration(mongo_db)
      
        if success:
            print("\n✅ Migration completed successfully!")
        else:
            print("\n❌ Migration validation failed!")
          
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
  
    finally:
        mysql_conn.close()
        print("\n🔌 MySQL connection closed")

if __name__ == "__main__":
    main()
```

#### Step 3: Validate the Migration

Run the migration script and verify results.

**Terminal Commands:**

```bash
# Install required Python packages
pip install pymysql pymongo

# Run migration script
python migrate_rdbms_to_nosql.py
```

**Expected Output:**

```
==================================================
MYSQL TO MONGODB MIGRATION
==================================================
✅ Connected to MySQL successfully
✅ Connected to MongoDB successfully

📦 Migrating categories...
✅ Migrated 7 categories

📦 Migrating suppliers...
✅ Migrated 3 suppliers

📦 Migrating products...
✅ Migrated 10 products

==================================================
MIGRATION VALIDATION RESULTS
==================================================
📊 Categories in MongoDB: 7
📊 Suppliers in MongoDB: 3
📊 Products in MongoDB: 10

🔍 Sample product with embedded category and supplier:
{
  "_id": 1001,
  "sku": "TS-MEN-BLK-L",
  "product_name": "Classic Black T-Shirt",
  "category": {
    "category_id": 4,
    "category_name": "T-Shirts",
    "parent_category_id": 2
  },
  "supplier": {
    "supplier_name": "Cotton Industries"
  }
}

✅ Migration completed successfully!

🔌 MySQL connection closed
```

**MongoDB Verification Commands:**

```bash
# Connect to MongoDB
mongosh

# Switch to futuremart database
use futuremart

# Verify collections
show collections

# Count documents
db.categories.count()
db.suppliers.count()
db.products.count()

# View sample document
db.products.findOne({sku: "TS-MEN-BLK-L"})
```

**Expected MongoDB Output:**

```
test> use futuremart
switched to db futuremart

futuremart> show collections
categories
products
suppliers

futuremart> db.categories.count()
7

futuremart> db.products.count()
10

futuremart> db.products.findOne({sku: "TS-MEN-BLK-L"})
{
  _id: 1001,
  sku: "TS-MEN-BLK-L",
  product_name: "Classic Black T-Shirt",
  description: null,
  size: "L",
  color: "Black",
  material: "Cotton",
  unit_price: 24.99,
  cost: 12.5,
  stock_quantity: 150,
  is_active: true,
  created_at: ISODate("2024-01-15T10:30:00Z"),
  updated_at: ISODate("2024-01-15T10:30:00Z"),
  category: {
    category_id: 4,
    category_name: "T-Shirts",
    parent_category_id: 2
  },
  supplier: {
    supplier_id: 101,
    supplier_name: "Cotton Industries",
    contact_name: "James Wilson",
    contact_email: "james@cottonind.com",
    location: {
      city: "Mumbai",
      country: "India"
    }
  },
  migrated_at: ISODate("2024-02-21T15:45:23Z")
}
```

**Screenshot:** Take a screenshot showing the successful MongoDB migration results. Save as `RDBMS_to_NoSQL.jpg`.

---

### Exercise 2: Migrate Product Catalog Data from NoSQL to RDBMS

In this exercise, you will migrate structured product catalog data from MongoDB to MySQL. This represents moving TrendyThreads' NoSQL product data to FutureMart's relational data warehouse.

#### Step 1: Initialize the Source NoSQL Database

Set up the MongoDB environment with sample product catalog data.

**MongoDB Sample Data (save as `trendythreads_products.json`):**

```json
{
  "categories": [
    { "_id": 1, "name": "Apparel", "parent_id": null, "description": "All clothing items" },
    { "_id": 2, "name": "Men's Apparel", "parent_id": 1, "description": "Clothing for men" },
    { "_id": 3, "name": "Women's Apparel", "parent_id": 1, "description": "Clothing for women" },
    { "_id": 4, "name": "T-Shirts", "parent_id": 2, "description": "Casual t-shirts for men" },
    { "_id": 5, "name": "Jeans", "parent_id": 2, "description": "Denim jeans for men" },
    { "_id": 6, "name": "Dresses", "parent_id": 3, "description": "Women's dresses" }
  ],
  "suppliers": [
    {
      "_id": 201,
      "name": "Textile World",
      "contact": {
        "name": "Robert Chen",
        "email": "robert@textileworld.com",
        "phone": "+86 123 4567 890"
      },
      "address": {
        "street": "123 Fabric Road",
        "city": "Shanghai",
        "country": "China"
      },
      "rating": 4.7,
      "active": true
    },
    {
      "_id": 202,
      "name": "Eco Fabrics",
      "contact": {
        "name": "Maria Santos",
        "email": "maria@ecofabrics.com",
        "phone": "+52 55 1234 5678"
      },
      "address": {
        "street": "456 Sustainable Ave",
        "city": "Mexico City",
        "country": "Mexico"
      },
      "rating": 4.9,
      "active": true
    }
  ],
  "products": [
    {
      "_id": 1001,
      "sku": "TS-MEN-BLK-L",
      "name": "Classic Black T-Shirt",
      "description": "Premium cotton t-shirt",
      "category_id": 4,
      "supplier_id": 201,
      "attributes": {
        "size": "L",
        "color": "Black",
        "material": "100% Cotton"
      },
      "pricing": {
        "unit_price": 29.99,
        "cost": 14.50
      },
      "inventory": {
        "quantity": 200,
        "reorder_level": 50
      },
      "tags": ["basic", "essential", "men"],
      "reviews": [
        {
          "user": "customer123",
          "rating": 5,
          "comment": "Great quality!"
        }
      ],
      "active": true,
      "created_at": "2024-01-15T10:30:00Z"
    },
    {
      "_id": 1002,
      "sku": "JN-MEN-BLU-32",
      "name": "Slim Fit Blue Jeans",
      "description": "Classic blue denim jeans",
      "category_id": 5,
      "supplier_id": 202,
      "attributes": {
        "size": "32",
        "color": "Blue",
        "material": "Denim",
        "fit": "Slim"
      },
      "pricing": {
        "unit_price": 89.99,
        "cost": 42.00
      },
      "inventory": {
        "quantity": 75,
        "reorder_level": 20
      },
      "tags": ["denim", "jeans", "men"],
      "reviews": [],
      "active": true,
      "created_at": "2024-01-15T11:45:00Z"
    },
    {
      "_id": 1003,
      "sku": "DR-WMN-RED-S",
      "name": "Summer Red Dress",
      "description": "Elegant summer dress",
      "category_id": 6,
      "supplier_id": 201,
      "attributes": {
        "size": "S",
        "color": "Red",
        "material": "Polyester",
        "length": "Knee-length"
      },
      "pricing": {
        "unit_price": 79.99,
        "cost": 38.00
      },
      "inventory": {
        "quantity": 45,
        "reorder_level": 15
      },
      "tags": ["dress", "summer", "women"],
      "reviews": [],
      "active": true,
      "created_at": "2024-01-16T09:15:00Z"
    }
  ]
}
```

**Load data into MongoDB:**

```bash
# Import data into MongoDB
mongoimport --db trendythreads --collection categories --file trendythreads_categories.json --jsonArray
mongoimport --db trendythreads --collection suppliers --file trendythreads_suppliers.json --jsonArray
mongoimport --db trendythreads --collection products --file trendythreads_products.json --jsonArray
```

#### Step 2: Perform Data Migration (NoSQL → RDBMS)

Create a migration script to transfer data from MongoDB to MySQL.

**Python Migration Script (save as `migrate_nosql_to_rdbms.py`):**

```python
#!/usr/bin/env python3
"""
Migration Script: MongoDB to MySQL
Migrates product catalog data from TrendyThreads MongoDB to FutureMart MySQL
"""

import pymysql
import pymongo
from datetime import datetime

# MongoDB Connection Configuration
mongo_config = {
    'host': 'localhost',
    'port': 27017,
    'database': 'trendythreads'
}

# MySQL Connection Configuration
mysql_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'futuremart_products',
    'charset': 'utf8mb4'
}

def connect_mongodb():
    """Establish MongoDB connection"""
    try:
        client = pymongo.MongoClient(host=mongo_config['host'], port=mongo_config['port'])
        db = client[mongo_config['database']]
        print("✅ Connected to MongoDB successfully")
        return db
    except Exception as e:
        print(f"❌ MongoDB connection failed: {e}")
        return None

def connect_mysql():
    """Establish MySQL connection"""
    try:
        connection = pymysql.connect(**mysql_config)
        print("✅ Connected to MySQL successfully")
        return connection
    except Exception as e:
        print(f"❌ MySQL connection failed: {e}")
        return None

def create_mysql_tables(mysql_conn):
    """Create target tables in MySQL"""
    with mysql_conn.cursor() as cursor:
        # Create categories table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS categories (
                category_id INT PRIMARY KEY,
                category_name VARCHAR(100) NOT NULL,
                parent_category_id INT,
                description TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                migrated_at TIMESTAMP,
                FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
            )
        """)
      
        # Create suppliers table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS suppliers (
                supplier_id INT PRIMARY KEY,
                supplier_name VARCHAR(100) NOT NULL,
                contact_name VARCHAR(100),
                contact_email VARCHAR(100),
                contact_phone VARCHAR(50),
                address TEXT,
                city VARCHAR(100),
                country VARCHAR(100),
                rating DECIMAL(3,2),
                is_active BOOLEAN,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                migrated_at TIMESTAMP
            )
        """)
      
        # Create products table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS products (
                product_id INT PRIMARY KEY,
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
                reorder_level INT DEFAULT 0,
                is_active BOOLEAN DEFAULT TRUE,
                tags TEXT,
                created_at TIMESTAMP,
                updated_at TIMESTAMP,
                migrated_at TIMESTAMP,
                FOREIGN KEY (category_id) REFERENCES categories(category_id),
                FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
            )
        `,)
      
        mysql_conn.commit()
        print("✅ MySQL tables created/verified")

def migrate_categories(mongo_db, mysql_conn):
    """Migrate categories from MongoDB to MySQL"""
    categories = list(mongo_db.categories.find())
  
    if not categories:
        print("ℹ️ No categories found to migrate")
        return 0
  
    with mysql_conn.cursor() as cursor:
        for cat in categories:
            cursor.execute("""
                INSERT INTO categories 
                (category_id, category_name, parent_category_id, description, migrated_at)
                VALUES (%s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                category_name = VALUES(category_name),
                parent_category_id = VALUES(parent_category_id),
                description = VALUES(description),
                migrated_at = VALUES(migrated_at)
            `, (
                cat['_id'],
                cat['name'],
                cat.get('parent_id'),
                cat.get('description'),
                datetime.now()
            ))
      
        mysql_conn.commit()
        print(f"✅ Migrated {len(categories)} categories")
        return len(categories)

def migrate_suppliers(mongo_db, mysql_conn):
    """Migrate suppliers from MongoDB to MySQL"""
    suppliers = list(mongo_db.suppliers.find())
  
    if not suppliers:
        print("ℹ️ No suppliers found to migrate")
        return 0
  
    with mysql_conn.cursor() as cursor:
        for sup in suppliers:
            # Extract address components
            address = sup.get('address', {})
            full_address = f"{address.get('street', '')}"
            city = address.get('city', '')
            country = address.get('country', '')
          
            cursor.execute("""
                INSERT INTO suppliers 
                (supplier_id, supplier_name, contact_name, contact_email, contact_phone,
                 address, city, country, rating, is_active, migrated_at)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                supplier_name = VALUES(supplier_name),
                contact_name = VALUES(contact_name),
                contact_email = VALUES(contact_email),
                contact_phone = VALUES(contact_phone),
                address = VALUES(address),
                city = VALUES(city),
                country = VALUES(country),
                rating = VALUES(rating),
                is_active = VALUES(is_active),
                migrated_at = VALUES(migrated_at)
            `, (
                sup['_id'],
                sup['name'],
                sup.get('contact', {}).get('name'),
                sup.get('contact', {}).get('email'),
                sup.get('contact', {}).get('phone'),
                full_address,
                city,
                country,
                sup.get('rating'),
                sup.get('active', True),
                datetime.now()
            ))
      
        mysql_conn.commit()
        print(f"✅ Migrated {len(suppliers)} suppliers")
        return len(suppliers)

def migrate_products(mongo_db, mysql_conn):
    """Migrate products from MongoDB to MySQL"""
    products = list(mongo_db.products.find())
  
    if not products:
        print("ℹ️ No products found to migrate")
        return 0
  
    with mysql_conn.cursor() as cursor:
        for prod in products:
            # Extract attributes
            attributes = prod.get('attributes', {})
            pricing = prod.get('pricing', {})
            inventory = prod.get('inventory', {})
          
            # Convert tags list to comma-separated string
            tags = ','.join(prod.get('tags', [])) if prod.get('tags') else None
          
            cursor.execute("""
                INSERT INTO products 
                (product_id, sku, product_name, description, category_id, supplier_id,
                 size, color, material, unit_price, cost, stock_quantity, reorder_level,
                 is_active, tags, created_at, updated_at, migrated_at)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                product_name = VALUES(product_name),
                description = VALUES(description),
                category_id = VALUES(category_id),
                supplier_id = VALUES(supplier_id),
                size = VALUES(size),
                color = VALUES(color),
                material = VALUES(material),
                unit_price = VALUES(unit_price),
                cost = VALUES(cost),
                stock_quantity = VALUES(stock_quantity),
                reorder_level = VALUES(reorder_level),
                is_active = VALUES(is_active),
                tags = VALUES(tags),
                updated_at = VALUES(updated_at),
                migrated_at = VALUES(migrated_at)
            `, (
                prod['_id'],
                prod['sku'],
                prod['name'],
                prod.get('description'),
                prod.get('category_id'),
                prod.get('supplier_id'),
                attributes.get('size'),
                attributes.get('color'),
                attributes.get('material'),
                pricing.get('unit_price'),
                pricing.get('cost'),
                inventory.get('quantity', 0),
                inventory.get('reorder_level', 0),
                prod.get('active', True),
                tags,
                prod.get('created_at'),
                prod.get('updated_at'),
                datetime.now()
            ))
      
        mysql_conn.commit()
        print(f"✅ Migrated {len(products)} products")
        return len(products)

def validate_migration(mysql_conn):
    """Validate the migration by counting records"""
    print("\n" + "="*50)
    print("MIGRATION VALIDATION RESULTS")
    print("="*50)
  
    with mysql_conn.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) FROM categories")
        categories_count = cursor.fetchone()[0]
      
        cursor.execute("SELECT COUNT(*) FROM suppliers")
        suppliers_count = cursor.fetchone()[0]
      
        cursor.execute("SELECT COUNT(*) FROM products")
        products_count = cursor.fetchone()[0]
      
        print(f"📊 Categories in MySQL: {categories_count}")
        print(f"📊 Suppliers in MySQL: {suppliers_count}")
        print(f"📊 Products in MySQL: {products_count}")
      
        # Sample validation query
        cursor.execute("""
            SELECT p.product_id, p.sku, p.product_name, 
                   c.category_name, s.supplier_name
            FROM products p
            LEFT JOIN categories c ON p.category_id = c.category_id
            LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
            LIMIT 1
        """)
        sample = cursor.fetchone()
      
        if sample:
            print("\n🔍 Sample product with joins:")
            print(f"   Product ID: {sample[0]}")
            print(f"   SKU: {sample[1]}")
            print(f"   Name: {sample[2]}")
            print(f"   Category: {sample[3]}")
            print(f"   Supplier: {sample[4]}")
  
    return categories_count > 0 and suppliers_count > 0 and products_count > 0

def main():
    print("="*50)
    print("MONGODB TO MYSQL MIGRATION")
    print("="*50)
  
    # Connect to databases
    mongo_db = connect_mongodb()
    if not mongo_db:
        return
  
    mysql_conn = connect_mysql()
    if not mysql_conn:
        mongo_db.client.close()
        return
  
    try:
        # Create target tables
        create_mysql_tables(mysql_conn)
      
        # Perform migration
        print("\n📦 Migrating categories...")
        cat_count = migrate_categories(mongo_db, mysql_conn)
      
        print("\n📦 Migrating suppliers...")
        sup_count = migrate_suppliers(mongo_db, mysql_conn)
      
        print("\n📦 Migrating products...")
        prod_count = migrate_products(mongo_db, mysql_conn)
      
        # Validate migration
        success = validate_migration(mysql_conn)
      
        if success:
            print(f"\n✅ Migration completed successfully!")
            print(f"   Total records migrated: {cat_count + sup_count + prod_count}")
        else:
            print("\n❌ Migration validation failed!")
          
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        mysql_conn.rollback()
  
    finally:
        mysql_conn.close()
        mongo_db.client.close()
        print("\n🔌 Database connections closed")

if __name__ == "__main__":
    main()
```

#### Step 3: Validate the Migration

Run the migration script and verify results.

**Terminal Commands:**

```bash
# Run migration script
python migrate_nosql_to_rdbms.py
```

**Expected Output:**

```
==================================================
MONGODB TO MYSQL MIGRATION
==================================================
✅ Connected to MongoDB successfully
✅ Connected to MySQL successfully
✅ MySQL tables created/verified

📦 Migrating categories...
✅ Migrated 6 categories

📦 Migrating suppliers...
✅ Migrated 2 suppliers

📦 Migrating products...
✅ Migrated 3 products

==================================================
MIGRATION VALIDATION RESULTS
==================================================
📊 Categories in MySQL: 6
📊 Suppliers in MySQL: 2
📊 Products in MySQL: 3

🔍 Sample product with joins:
   Product ID: 1001
   SKU: TS-MEN-BLK-L
   Name: Classic Black T-Shirt
   Category: T-Shirts
   Supplier: Textile World

✅ Migration completed successfully!
   Total records migrated: 11

🔌 Database connections closed
```

**MySQL Verification Commands:**

```bash
# Connect to MySQL
mysql -u root -p

# Use futuremart database
USE futuremart_products;

# Verify tables
SHOW TABLES;

# Count records
SELECT COUNT(*) FROM categories;
SELECT COUNT(*) FROM suppliers;
SELECT COUNT(*) FROM products;

# View sample with joins
SELECT 
    p.product_id,
    p.sku,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.unit_price,
    p.stock_quantity
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
LIMIT 5;
```

**Expected MySQL Output:**

```
mysql> SHOW TABLES;
+-------------------------------+
| Tables_in_futuremart_products |
+-------------------------------+
| categories                    |
| products                      |
| suppliers                     |
+-------------------------------+
3 rows in set (0.00 sec)

mysql> SELECT COUNT(*) FROM categories;
+----------+
| COUNT(*) |
+----------+
|        6 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM products;
+----------+
| COUNT(*) |
+----------+
|        3 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT 
    ->     p.product_id,
    ->     p.sku,
    ->     p.product_name,
    ->     c.category_name,
    ->     s.supplier_name,
    ->     p.unit_price,
    ->     p.stock_quantity
    -> FROM products p
    -> LEFT JOIN categories c ON p.category_id = c.category_id
    -> LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id;
+------------+----------------+-----------------------+---------------+----------------+------------+----------------+
| product_id | sku            | product_name          | category_name | supplier_name  | unit_price | stock_quantity |
+------------+----------------+-----------------------+---------------+----------------+------------+----------------+
|       1001 | TS-MEN-BLK-L   | Classic Black T-Shirt | T-Shirts      | Textile World  |      29.99 |            200 |
|       1002 | JN-MEN-BLU-32  | Slim Fit Blue Jeans   | Jeans         | Eco Fabrics    |      89.99 |             75 |
|       1003 | DR-WMN-RED-S   | Summer Red Dress      | Dresses       | Textile World  |      79.99 |             45 |
+------------+----------------+-----------------------+---------------+----------------+------------+----------------+
3 rows in set (0.00 sec)
```

**Screenshot:** Take a screenshot showing the successful MySQL migration results. Save as `NoSQL_to_RDBMS.jpg`.

---

## Migration Summary

| Migration  | Source                  | Target               | Records | Status |
| ---------- | ----------------------- | -------------------- | ------- | ------ |
| Exercise 1 | MySQL (FashionMart)     | MongoDB (FutureMart) | 20      | ✅     |
| Exercise 2 | MongoDB (TrendyThreads) | MySQL (FutureMart)   | 11      | ✅     |

### Key Migration Patterns Demonstrated

| Pattern                         | Description                                                          | Use Case               |
| ------------------------------- | -------------------------------------------------------------------- | ---------------------- |
| **Denormalization**       | Embedding related data (category, supplier) within product documents | RDBMS → NoSQL         |
| **Normalization**         | Extracting embedded data into separate related tables                | NoSQL → RDBMS         |
| **Schema Mapping**        | Transforming document structures to relational schemas               | Cross-system migration |
| **Data Type Conversion**  | Converting JSON types to SQL types                                   | Format compatibility   |
| **Referential Integrity** | Preserving relationships during migration                            | Data consistency       |

---

## Deliverables

By the end of Module 3, you will have completed the following deliverables:

| Deliverable          | Description                                             | Filename               |
| -------------------- | ------------------------------------------------------- | ---------------------- |
| **Exercise 1** | Screenshot showing successful data migration to MongoDB | `RDBMS_to_NoSQL.jpg` |
| **Exercise 2** | Screenshot showing successful data migration to MySQL   | `NoSQL_to_RDBMS.jpg` |

### Screenshot Checklist

| Screenshot             | Content to Capture                                                                                                                    | Status |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `RDBMS_to_NoSQL.jpg` | MongoDB shell showing: connected database, collections list, document counts, sample product document with embedded category/supplier | ⬜     |
| `NoSQL_to_RDBMS.jpg` | MySQL command line showing: tables list, record counts, sample join query results                                                     | ⬜     |

---

## Conclusion

In this phase, you have successfully:

| Task                   | Accomplishment                                                                                                       |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------- |
| ✓**Exercise 1** | Migrated product catalog data from MySQL RDBMS to MongoDB NoSQL, demonstrating denormalization and document modeling |
| ✓**Exercise 2** | Migrated product catalog data from MongoDB NoSQL to MySQL RDBMS, demonstrating normalization and relational modeling |
| ✓**Validation** | Verified data integrity and completeness in both migration directions                                                |

These migration exercises demonstrate the bidirectional data flow capabilities required for FutureMart's hybrid architecture, enabling seamless integration of both companies' data assets into the new unified platform.

---

*Assignment completed: _________________*
*Data Migration Engineer: _________________*
*Date: _________________*
