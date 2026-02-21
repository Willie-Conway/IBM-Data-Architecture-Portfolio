#!/usr/bin/env python3
"""
MongoDB Database Analyzer and Migration Check
It connects to MySQL to perform the data migration and then analyzes the MongoDB database.
"""

import pymongo
import json
import datetime
import getpass
import mysql.connector 
from pymongo.errors import ConnectionFailure
from collections import defaultdict
#Import ObjectId directly from bson to avoid internal typings error
from bson.objectid import ObjectId 

# --- Utility Functions ---

def json_serial(obj):
    """JSON serializer for objects not serializable by default json code"""
    if isinstance(obj, (datetime.datetime, datetime.date)):
        return obj.isoformat()
    #Use the imported ObjectId for type checking
    if isinstance(obj, ObjectId):
        return str(obj)
    raise TypeError(f"Type {type(obj)} not serializable")

# --- Data Migration Function  ---

def migrate_data_from_mysql(mysql_config, mongo_connection_string, db_name):
    """
    Connects to MySQL, extracts data from the product_catalog schema (Products, Variants, Brands, Categories, Attributes), 
    transforms it into a denormalized MongoDB structure, and loads it.
    """
    print("\n--- Starting Data Migration ---")
    
    mongo_client = None
    mysql_conn = None
    
    try:
        # 1. Connect to MongoDB
        mongo_client = pymongo.MongoClient(mongo_connection_string)
        db = mongo_client[db_name]
        
        # Drop the database first to ensure a clean migration every time
        mongo_client.drop_database(db_name)
        db = mongo_client[db_name] 
        print(f"Cleaned up existing '{db_name}' database in MongoDB.")

        # 2. Connect to MySQL (Using the installed connector)
        mysql_conn = mysql.connector.connect(**mysql_config)
        # Use dictionary=True so we can reference columns by name (e.g., row['product_id'])
        mysql_cursor = mysql_conn.cursor(dictionary=True) 

        # 3. Fetch Lookup Data (Brands, Categories, Attributes)
        
        # Brands Lookup: {1: "Nike", 2: "Adidas", ...}
        mysql_cursor.execute("SELECT brand_id, name FROM Brands")
        brand_lookup = {row['brand_id']: row for row in mysql_cursor.fetchall()}
        print(f"Fetched {len(brand_lookup)} brands.")

        # Categories Lookup: {1: "Men", 2: "Women", ...}
        mysql_cursor.execute("SELECT category_id, name FROM Categories")
        category_lookup = {row['category_id']: row for row in mysql_cursor.fetchall()}
        print(f"Fetched {len(category_lookup)} categories.")

        # Product Attributes Lookup: {product_id: [{"name": "Feature", "value": "Quick Dry"}, ...]}
        mysql_cursor.execute("""
            SELECT pa.product_id, a.name, pa.value 
            FROM ProductAttributes pa 
            JOIN Attributes a ON pa.attribute_id = a.attribute_id
        """)
        product_attributes_map = defaultdict(list)
        for row in mysql_cursor.fetchall():
            product_attributes_map[row['product_id']].append({
                "name": row['name'],
                "value": row['value']
            })
        print(f"Fetched {len(product_attributes_map)} product attribute associations.")
        
        # Product Images Lookup: {variant_id: [{"url": "...", "is_primary": true}, ...]}
        mysql_cursor.execute("SELECT variant_id, image_url, is_primary FROM ProductImages")
        variant_images_map = defaultdict(list)
        for row in mysql_cursor.fetchall():
            variant_images_map[row['variant_id']].append({
                "url": row['image_url'],
                "is_primary": bool(row['is_primary'])
            })
        print(f"Fetched images for {len(variant_images_map)} variants.")
        
        # Product Variants Lookup: {product_id: [variant_doc1, variant_doc2, ...]}
        mysql_cursor.execute("SELECT * FROM ProductVariants")
        product_variants_map = defaultdict(list)
        for row in mysql_cursor.fetchall():
            variant_doc = {
                "variant_id": row['variant_id'],
                "sku": row['sku'],
                "color": row['color'],
                "size": row['size'],
                # Ensure correct types for numbers
                "price": float(row['price']), 
                "discounted_price": float(row['discounted_price']) if row['discounted_price'] is not None else None,
                "stock_quantity": int(row['stock_quantity']),
                "images": variant_images_map.get(row['variant_id'], []) # Embed images
            }
            product_variants_map[row['product_id']].append(variant_doc)
        print(f"Fetched variants for {len(product_variants_map)} products.")

        
        # 4. Fetch Main Products Data and Denormalize
        print("Starting main product denormalization...")
        mysql_cursor.execute("SELECT * FROM Products")
        all_products = mysql_cursor.fetchall()
        
        mongo_documents = []

        for p_row in all_products:
            product_id = p_row['product_id']
            
            # 4a. Build the denormalized document
            mongo_doc = {
                "product_id": product_id,
                "name": p_row['name'],
                "description": p_row['description'],
                "gender": p_row['gender'],
                "material": p_row['material'],
                "season": p_row['season'],
                "created_at": p_row['created_at'],
                "updated_at": p_row['updated_at'],
                
                # 4b. Embed Brand and Category
                "brand": brand_lookup.get(p_row['brand_id']),
                "category": category_lookup.get(p_row['category_id']),
                
                # 4c. Embed Attributes and Variants
                "attributes": product_attributes_map.get(product_id, []),
                "variants": product_variants_map.get(product_id, [])
            }
            mongo_documents.append(mongo_doc)

        
        # 5. Load into MongoDB
        if mongo_documents:
            # Insert into a new collection named 'products'
            db.products.insert_many(mongo_documents)
            print(f"Successfully migrated {len(mongo_documents)} documents to 'products' collection.")
        else:
             print("No products found to migrate.")

        
        # 6. Cleanup
        mysql_cursor.close()
        mysql_conn.close()
        mongo_client.close()
        
        print("Data migration routine finished.")
        return True
        
    except ConnectionFailure:
        print("MIGRATION FAILED: Could not connect to MongoDB during migration.")
        return False
    except mysql.connector.Error as err:
        print(f"MIGRATION FAILED: MySQL Error: {err}")
        print("Please verify your MySQL credentials, hostname, and database name are correct. Check if the database and tables exist.")
        return False
    except Exception as e:
        # Catch errors related to transformation or unexpected issues
        print(f"MIGRATION FAILED: An unexpected error occurred: {e}")
        return False
    finally:
        if mysql_conn and mysql_conn.is_connected():
            mysql_conn.close()
        if mongo_client:
            mongo_client.close()


# --- Analysis Function  ---

def analyze_mongodb(connection_string, db_name, output_file):
    """Connect to MongoDB and analyze the specified database"""
    
    print("\n--- Starting MongoDB Analysis ---")
    try:
        # Connect to MongoDB
        client = pymongo.MongoClient(connection_string)
        
        # Check if the connection is successful
        client.admin.command('ping')
        print("Connected successfully to MongoDB server!")
        
        # Access the database
        db = client[db_name]
        
        # Get list of collections
        collections = db.list_collection_names()
        
        if not collections:
            print(f"No collections found in the '{db_name}' database. Migration may have failed or the database is empty.")
            return
        
        with open(output_file, 'w') as f:
            f.write(f"MONGODB DATABASE ANALYSIS: {db_name}\n")
            f.write(f"Generated on: {datetime.datetime.now()}\n")
            f.write(f"Total collections: {len(collections)}\n\n")
            
            # Analyze each collection
            for coll_name in collections:
                collection = db[coll_name]
                
                # Count documents
                # Use estimated_document_count for large collections, but count_documents({}) is safer
                doc_count = collection.count_documents({}) 
                
                f.write(f"\n{'=' * 80}\n")
                f.write(f"COLLECTION: {coll_name}\n")
                f.write(f"{'=' * 80}\n")
                f.write(f"Document count: {doc_count}\n\n")
                
                if doc_count == 0:
                    f.write("Collection is empty.\n")
                    continue
                
                # Get sample documents for schema analysis
                sample_docs = list(collection.find().limit(100))
                
                # Extract schema information
                schema = defaultdict(set)
                for doc in sample_docs:
                    for field, value in doc.items():
                        # Exclude ObjectId from type checks since it's standard
                        if field != '_id':
                            schema[field].add(type(value).__name__)
                
                # Print schema
                f.write("Schema Information:\n")
                f.write("-" * 40 + "\n")
                for field, types in schema.items():
                    f.write(f"{field}: {', '.join(types)}\n")
                
                # Print sample documents (up to 5)
                sample_size = min(5, doc_count)
                f.write(f"\nSample Documents (first {sample_size}):\n")
                f.write("-" * 40 + "\n")
                
                for i, doc in enumerate(sample_docs[:sample_size]):
                    # Convert to JSON string using custom serializer
                    formatted_doc = json.dumps(doc, default=json_serial, indent=2)
                    f.write(f"Document {i+1}:\n{formatted_doc}\n\n")
        
        print(f"\nAnalysis complete! Results saved to {output_file}")
    
    except ConnectionFailure:
        print("Failed to connect to MongoDB server. Please check your connection string.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        # Close the MongoDB connection
        if 'client' in locals():
            client.close()

if __name__ == "__main__":
    
    # --- MongoDB Connection Parameters ---
    print("\n--- MongoDB Connection ---")
    print("Make sure your mongodb server is running.")
    mongo_user = input("Enter mongodb username: ")
    mongo_password = getpass.getpass("Enter mongodb password: ")
    mongo_hostname = input("Enter mongodb hostname: ")
    mongo_connection_string = f"mongodb://{mongo_user}:{mongo_password}@{mongo_hostname}:27017"
    database_name = "product_catalog"
    output_file = "rdbms2nosql.txt"

    # --- MySQL Connection Parameters (New) ---
    print("\n--- MySQL Connection (Required for Migration) ---")
    mysql_user = input("Enter mysql username: ")
    mysql_password = getpass.getpass("Enter mysql password: ")
    mysql_hostname = input("Enter mysql hostname: ")
    mysql_database = input("Enter mysql database name (e.g., product_catalog): ")
    
    mysql_config = {
        'user': mysql_user,
        'password': mysql_password,
        'host': mysql_hostname,
        'database': mysql_database
    }

    # 1. Attempt Data Migration
    migration_successful = migrate_data_from_mysql(
        mysql_config, 
        mongo_connection_string, 
        database_name
    )
    
    # 2. Run Analysis regardless of migration success (to check existing data)
    analyze_mongodb(mongo_connection_string, database_name, output_file)
