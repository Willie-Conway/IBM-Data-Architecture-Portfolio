import subprocess
import sys

# Ensure mysql-connector-python is installed
try:
    import mysql.connector
except ImportError:
    print("mysql-connector-python not found. Installing...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "mysql-connector-python"])
    import mysql.connector

import getpass

sql_text="""
-- Create the database
CREATE DATABASE IF NOT EXISTS product_catalog;

-- Use the created database
USE product_catalog;

-- Categories Table
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES Categories(category_id)
);

-- Brands Table
CREATE TABLE IF NOT EXISTS Brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand_id INT,
    category_id INT,
    gender ENUM('Men', 'Women', 'Unisex', 'Kids'),
    material VARCHAR(100),
    season ENUM('Spring', 'Summer', 'Fall', 'Winter', 'All'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Product Variants Table
CREATE TABLE IF NOT EXISTS ProductVariants (
    variant_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(100) NOT NULL UNIQUE,
    color VARCHAR(50),
    size VARCHAR(20),
    price DECIMAL(10, 2) NOT NULL,
    discounted_price DECIMAL(10, 2),
    stock_quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Product Images Table
CREATE TABLE IF NOT EXISTS ProductImages (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    variant_id INT,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);

-- Attributes Table
CREATE TABLE IF NOT EXISTS Attributes (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Product Attributes Table
CREATE TABLE IF NOT EXISTS ProductAttributes (
    product_id INT,
    attribute_id INT,
    value VARCHAR(100),
    PRIMARY KEY (product_id, attribute_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (attribute_id) REFERENCES Attributes(attribute_id)
);


-- Insert Categories
INSERT INTO Categories (name, parent_id) VALUES
('Men', NULL), ('Women', NULL), ('Kids', NULL),
('T-Shirts', 1), ('Jeans', 1), ('Jackets', 1),
('Dresses', 2), ('Tops', 2), ('Skirts', 2),
('Shoes', 1), ('Shoes', 2), ('Shoes', 3);

-- Insert Brands
INSERT INTO Brands (name) VALUES 
('Nike'), ('Adidas'), ('Puma'), ('Levis'), ('H&M'), ('Zara');

-- Insert Products
INSERT INTO Products (name, description, brand_id, category_id, gender, material, season) VALUES
('Nike Sports T-Shirt', 'Breathable fabric for sports', 1, 4, 'Men', 'Polyester', 'All'),
('Adidas Running Shoes', 'Comfortable running shoes', 2, 10, 'Men', 'Mesh', 'All'),
('Puma Slim Fit Jeans', 'Stylish slim fit jeans', 3, 5, 'Men', 'Denim', 'All'),
('Levis Denim Jacket', 'Classic denim jacket', 4, 6, 'Men', 'Denim', 'Fall'),
('H&M Casual Dress', 'Elegant evening wear', 5, 7, 'Women', 'Cotton', 'Summer'),
('Zara Leather Jacket', 'Premium leather jacket', 6, 6, 'Men', 'Leather', 'Winter'),
('Nike Air Sneakers', 'Trendy sneakers', 1, 10, 'Men', 'Leather', 'All'),
('Adidas Hoodie', 'Comfortable winter wear', 2, 6, 'Men', 'Cotton', 'Winter'),
('Puma Polo Shirt', 'Classic polo style', 3, 4, 'Men', 'Cotton', 'Summer'),
('Levis Straight Jeans', 'Regular fit denim', 4, 5, 'Men', 'Denim', 'All'),
('H&M Summer Dress', 'Floral printed dress', 5, 7, 'Women', 'Cotton', 'Summer'),
('Zara Party Dress', 'Stylish evening wear', 6, 7, 'Women', 'Silk', 'Spring'),
('Nike Running Shorts', 'Lightweight sports shorts', 1, 4, 'Men', 'Polyester', 'Summer'),
('Adidas Sports Bra', 'Supportive fit', 2, 8, 'Women', 'Polyester', 'All'),
('Puma Track Pants', 'Athletic fit pants', 3, 5, 'Men', 'Polyester', 'All'),
('Levis Skinny Jeans', 'Trendy fit jeans', 4, 5, 'Women', 'Denim', 'All'),
('H&M Casual T-Shirt', 'Soft fabric casual wear', 5, 4, 'Men', 'Cotton', 'All'),
('Zara Office Blazer', 'Formal office wear', 6, 6, 'Women', 'Wool', 'Winter'),
('Nike Basketball Shoes', 'High-performance shoes', 1, 10, 'Men', 'Synthetic', 'All'),
('Adidas Joggers', 'Comfortable casual wear', 2, 10, 'Women', 'Mesh', 'All'),
('Puma Sports Cap', 'Trendy sports cap', 3, 4, 'Men', 'Cotton', 'Summer'),
('Levis Cargo Pants', 'Durable outdoor wear', 4, 5, 'Men', 'Cotton', 'All'),
('H&M Denim Skirt', 'Classic skirt', 5, 9, 'Women', 'Denim', 'All'),
('Zara Silk Blouse', 'Elegant office wear', 6, 8, 'Women', 'Silk', 'All'),
('Nike Sweatpants', 'Comfortable sweatpants', 1, 5, 'Men', 'Cotton', 'Winter');

-- Insert Product Variants (Size, Color, Price, Stock)
INSERT INTO ProductVariants (product_id, sku, color, size, price, discounted_price, stock_quantity) VALUES
(1, 'SKU001', 'Black', 'M', 29.99, 24.99, 50),
(1, 'SKU002', 'Blue', 'L', 29.99, NULL, 30),
(2, 'SKU003', 'White', '10', 89.99, 79.99, 20),
(3, 'SKU004', 'Dark Blue', '32', 49.99, 44.99, 40),
(4, 'SKU005', 'Light Blue', 'M', 79.99, NULL, 25),
(5, 'SKU006', 'Red', 'S', 39.99, 34.99, 50),
(6, 'SKU007', 'Brown', 'L', 129.99, 119.99, 15),
(7, 'SKU008', 'Black', '9', 99.99, NULL, 10),
(8, 'SKU009', 'Grey', 'XL', 59.99, 54.99, 35),
(9, 'SKU010', 'Navy', 'M', 34.99, 29.99, 45),
(10, 'SKU011', 'Black', '34', 59.99, NULL, 30),
(11, 'SKU012', 'Pink', 'S', 49.99, 39.99, 25),
(12, 'SKU013', 'Gold', 'M', 89.99, 79.99, 20),
(13, 'SKU014', 'White', 'L', 19.99, 14.99, 60),
(14, 'SKU015', 'Purple', 'M', 29.99, 24.99, 40),
(15, 'SKU016', 'Grey', 'L', 39.99, 34.99, 35),
(16, 'SKU017', 'Black', '32', 69.99, NULL, 20),
(17, 'SKU018', 'Yellow', 'M', 22.99, 19.99, 50),
(18, 'SKU019', 'Blue', 'S', 119.99, NULL, 10),
(19, 'SKU020', 'Red', '10', 139.99, 129.99, 5),
(20, 'SKU021', 'Olive', 'M', 89.99, 79.99, 20),
(21, 'SKU022', 'Black', 'One Size', 14.99, NULL, 100),
(22, 'SKU023', 'Brown', '34', 59.99, 49.99, 25),
(23, 'SKU024', 'Denim Blue', 'M', 44.99, 39.99, 30),
(24, 'SKU025', 'White', 'L', 69.99, 59.99, 20),
(25, 'SKU026', 'Grey', 'M', 49.99, 44.99, 30);

"""

# Remove comments and split by semicolon to get individual statements
def parse_sql_statements(sql_text):
    import re
    # Remove single-line and multi-line comments
    sql_text = re.sub(r'--.*?$', '', sql_text, flags=re.MULTILINE)
    sql_text = re.sub(r'/\*.*?\*/', '', sql_text, flags=re.DOTALL)
    
    # Split by semicolon followed by newline or end of file
    statements = [stmt.strip() for stmt in sql_text.strip().split(';') if stmt.strip()]
    return statements

sql_commands = parse_sql_statements(sql_text)

# Get MySQL credentials and file path
host = input("Enter MySQL host: ")
user = input("Enter MySQL username: ")
password = getpass.getpass("Enter MySQL password: ")


# Connect to MySQL and execute commands
try:
    conn = mysql.connector.connect(
        host=host,
        user=user,
        password=password
    )
    cursor = conn.cursor()


    
    # Split and run commands one by one (handle multiple statements)
    for command in sql_commands:
        if command:
            cursor.execute(command)

    conn.commit()
    print("Your mysql server is now initialized. You can get started with the lab.")
except mysql.connector.Error as err:
    print("MySQL error:", err)
finally:
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()
