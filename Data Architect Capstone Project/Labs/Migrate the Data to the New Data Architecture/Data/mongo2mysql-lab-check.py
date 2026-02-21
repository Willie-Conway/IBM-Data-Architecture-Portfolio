#!/usr/bin/env python3
"""
MongoDB to MySQL Data Migration and MySQL Validation Script.
This script performs a migration from a MongoDB collection (assumed 'returns')
to a MySQL database ('product_returns' table 'details'), and then validates
the structure and content of the resulting MySQL database.
"""

import subprocess
import sys
from datetime import datetime
import getpass
import json
import logging

# Ensure necessary libraries are installed and imported
try:
    import mysql.connector
except ImportError:
    print("mysql-connector-python not found. Installing...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "mysql-connector-python"])
    import mysql.connector

try:
    import pymongo
    from pymongo.errors import ConnectionFailure
except ImportError:
    print("pymongo not found. Installing...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "pymongo"])
    import pymongo
    from pymongo.errors import ConnectionFailure

# Set up logging for better visibility
logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

# --- Global Connection Parameters ---
MYSQL_CONFIG = {}
MONGO_CONNECTION_STRING = ""

# --- MySQL Utility Functions  ---

def connect_to_mysql(database=None):
    """Connect to MySQL server with optional database"""
    config = MYSQL_CONFIG.copy()
    if database:
        config['database'] = database
    
    try:
        connection = mysql.connector.connect(**config)
        return connection
    except mysql.connector.Error as err:
        logging.error(f"Error connecting to MySQL: {err}")
        sys.exit(1)

def check_database_exists(cursor, db_name):
    """Check if a database exists"""
    cursor.execute("SHOW DATABASES")
    databases = [x[0] for x in cursor.fetchall()]
    return db_name in databases

def check_table_exists(cursor, table_name):
    """Check if a table exists in the current database"""
    cursor.execute("SHOW TABLES")
    tables = [x[0] for x in cursor.fetchall()]
    return table_name in tables

def describe_table(cursor, table_name):
    """Describe the structure of a table"""
    cursor.execute(f"DESCRIBE {table_name}")
    return cursor.fetchall()

def count_rows(cursor, table_name):
    """Count the number of rows in a table"""
    cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
    return cursor.fetchone()[0]

def select_all_rows(cursor, table_name):
    """Select all rows from a table"""
    cursor.execute(f"SELECT * FROM {table_name}")
    return cursor.fetchall(), cursor.column_names

# --- Migration Function: MongoDB to MySQL ---

def migrate_mongo_to_mysql(mongo_uri, mysql_db_name, mysql_table_name):
    """
    Connects to MongoDB, extracts data from the 'details' collection in 'product_returns' DB,
    creates the target MySQL schema, and loads the data.
    """
    logging.info("\n--- Starting MongoDB to MySQL Migration ---")
    
    mongo_client = None
    mysql_conn = None
    
    try:
        # 1. Connect to MongoDB
        mongo_client = pymongo.MongoClient(mongo_uri)
        mongo_client.admin.command('ping')
        
        # Source DB: product_returns 
        # Source Collection: details
        mongo_db = mongo_client[mysql_db_name]
        mongo_collection = mongo_db[mysql_table_name] 
        
        mongo_documents = list(mongo_collection.find())
        if not mongo_documents:
            logging.warning(f"No documents found in the '{mysql_db_name}.{mysql_table_name}' collection. Skipping migration.")
            return False

        # 2. Prepare MySQL Schema
        mysql_conn = connect_to_mysql()
        mysql_cursor = mysql_conn.cursor()
        
        # Drop and create database
        mysql_cursor.execute(f"DROP DATABASE IF EXISTS {mysql_db_name}")
        mysql_cursor.execute(f"CREATE DATABASE {mysql_db_name}")
        mysql_cursor.execute(f"USE {mysql_db_name}")
        
        # Create the target table for return details
        
        create_table_sql = f"""
        CREATE TABLE IF NOT EXISTS {mysql_table_name} (
            return_detail_id INT AUTO_INCREMENT PRIMARY KEY,
            mongo_id VARCHAR(24) NOT NULL UNIQUE,
            product_id INT,
            variant_sku VARCHAR(100),
            reason TEXT,
            return_date DATE
        )
        """
        mysql_cursor.execute(create_table_sql)
        logging.info(f"Created table '{mysql_db_name}.{mysql_table_name}'.")

        # 3. Transform and Insert Data
        insert_count = 0
        insert_sql = f"""
        INSERT INTO {mysql_table_name} 
        (mongo_id, product_id, variant_sku, reason, return_date) 
        VALUES (%s, %s, %s, %s, %s)
        """

        for doc in mongo_documents:
            try:
                # Retrieve the return date. It is stored as a string "YYYY-MM-DD" in Mongo.
                # We use it directly as a string for the MySQL DATE field.
                return_date_val = doc.get('return_date')
                
                # If the date is a string, use it. Otherwise (if missing), use today's date formatted as a string.
                if isinstance(return_date_val, str):
                    formatted_date = return_date_val
                else:
                    formatted_date = datetime.now().strftime('%Y-%m-%d')
                # -------------------------

                # Basic transformation: Extract fields from the MongoDB document
                
                data_to_insert = (
                    str(doc['_id']),
                    doc.get('order_id', None), # Using 'order_id' as the value for target 'product_id'
                    doc.get('sku', 'N/A'),
                    doc.get('return_reason', 'Other'),
                    formatted_date, # Use the corrected date string
                )
                mysql_cursor.execute(insert_sql, data_to_insert)
                insert_count += 1
            except Exception as e:
                # This log now correctly shows the error for the document's ID
                logging.error(f"Error processing document {doc.get('_id')}: {e}")
                
        mysql_conn.commit()
        logging.info(f"Successfully migrated {insert_count} documents to MySQL table '{mysql_table_name}'.")
        return True
        
    except ConnectionFailure:
        logging.error("MIGRATION FAILED: Could not connect to MongoDB.")
        return False
    except mysql.connector.Error as err:
        logging.error(f"MIGRATION FAILED: MySQL Error during migration: {err}")
        return False
    except Exception as e:
        logging.error(f"MIGRATION FAILED: An unexpected error occurred: {e}")
        return False
    finally:
        if mongo_client:
            mongo_client.close()
        if mysql_conn and mysql_conn.is_connected():
            mysql_conn.close()

# --- Main Logic  ---

def main():
    global MYSQL_CONFIG, MONGO_CONNECTION_STRING
    
    # --- Input Collection ---
    
    print("\n--- MongoDB Connection (Source) ---")
    mongo_user = input("Enter mongodb username: ")
    mongo_password = getpass.getpass("Enter mongodb password: ")
    mongo_hostname = input("Enter mongodb hostname: ")
    MONGO_CONNECTION_STRING = f"mongodb://{mongo_user}:{mongo_password}@{mongo_hostname}:27017"

    print("\n--- MySQL Connection (Target) ---")
    mysql_host = input("Enter MySQL host: ")
    mysql_user = input("Enter MySQL username: ")
    mysql_password = getpass.getpass("Enter MySQL password: ")
    
    MYSQL_CONFIG = {
        'host': mysql_host,
        'user': mysql_user,
        'password': mysql_password,
        'port': 3306
    }
    
    # Define validation parameters
    db_name = "product_returns"
    table_name = "details"
    output_file = "nosql2rdbms.txt"
    
    # --- 1. Perform Migration ---
 
    migrate_mongo_to_mysql(MONGO_CONNECTION_STRING, db_name, table_name)
    
    # --- 2. Perform Validation ---
    
    # Timestamp for the report
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Connect to MySQL server (without specifying database)
    connection = connect_to_mysql()
    cursor = connection.cursor()
    
    # Open file for writing results
    with open(output_file, 'w') as f:
        # Write header
        f.write(f"MySQL Database Validation Report\n")
        f.write(f"Generated on: {timestamp}\n")
        f.write("=" * 80 + "\n\n")
        
        # 1. Check if database exists
        f.write("1. DATABASE EXISTENCE CHECK\n")
        f.write("-" * 80 + "\n")
        db_exists = check_database_exists(cursor, db_name)
        f.write(f"Database '{db_name}' exists: {db_exists}\n\n")
        
        if not db_exists:
            f.write("Database does not exist. Validation cannot continue.\n")
            connection.close()
            return
        
        # Connect to the database for further checks
        connection.close()
        connection = connect_to_mysql(db_name)
        cursor = connection.cursor()
        
        # 2. Check if table exists
        f.write("2. TABLE EXISTENCE CHECK\n")
        f.write("-" * 80 + "\n")
        table_exists = check_table_exists(cursor, table_name)
        f.write(f"Table '{table_name}' exists: {table_exists}\n\n")
        
        if not table_exists:
            f.write("Table does not exist. Validation cannot continue.\n")
            connection.close()
            return
        
        # 3. Describe table
        f.write("3. TABLE STRUCTURE\n")
        f.write("-" * 80 + "\n")
        table_structure = describe_table(cursor, table_name)
        
        # Format the table structure 
        column_width = 20
        header = (
            f"{'Field':{column_width}} "
            f"{'Type':{column_width}} "
            f"{'Null':{column_width}} "
            f"{'Key':{column_width}} "
            f"{'Default':{column_width}} "
            f"{'Extra':{column_width}}"
        )
        f.write(header + "\n")
        f.write("-" * (column_width * 6) + "\n")
        
        for column in table_structure:
            # Format each column data with fixed width
            row = (
                f"{str(column[0]):{column_width}} "
                f"{str(column[1]):{column_width}} "
                f"{str(column[2]):{column_width}} "
                f"{str(column[3]):{column_width}} "
                f"{str(column[4] if column[4] is not None else 'NULL'):{column_width}} "
                f"{str(column[5]):{column_width}}"
            )
            f.write(row + "\n")
        f.write("\n")
        
        # 4. Count rows
        f.write("4. ROW COUNT\n")
        f.write("-" * 80 + "\n")
        row_count = count_rows(cursor, table_name)
        f.write(f"Number of rows in the table '{table_name}': {row_count}\n\n")
        
        # 5. Select all rows
        f.write("5. TABLE DATA\n")
        f.write("-" * 80 + "\n")
        rows, column_names = select_all_rows(cursor, table_name)
        
        # Write column headers
        header_row = " | ".join([f"{col}" for col in column_names])
        f.write(header_row + "\n")
        f.write("-" * len(header_row) + "\n")
        
        # Write data rows (limit to first 10 rows for brevity in report)
        display_limit = min(len(rows), 10)
        for i in range(display_limit):
            row = rows[i]
            # Ensure all values are converted to string for printing
            row_str = " | ".join([f"{val}" for val in row])
            f.write(row_str + "\n")
        
        # If there are more rows than displayed, add a note
        if len(rows) > display_limit:
            f.write(f"\n[Note: {len(rows)-display_limit} more rows exist but are not displayed in this report.]\n")
        
        # Write completion message
        f.write("\n" + "=" * 80 + "\n")
        f.write(f"Validation complete. Results saved to {output_file}\n")
        print(f"\nValidation complete. Results saved to {output_file}")
    
    # Close database connection
    cursor.close()
    connection.close()


if __name__ == "__main__":
    main()