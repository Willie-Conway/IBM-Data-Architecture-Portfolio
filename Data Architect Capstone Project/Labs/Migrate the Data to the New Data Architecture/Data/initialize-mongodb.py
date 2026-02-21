import subprocess
import sys

# Ensure pymongo is installed
try:
    from pymongo import MongoClient
except ImportError:
    print("pymongo not found. Installing...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "pymongo"])
    import importlib
    pymongo = importlib.import_module("pymongo")
    from pymongo import MongoClient

import random
from datetime import datetime, timedelta
import getpass

returns =[
  {
    "order_id": 1000,
    "product_name": "Men's Slim Fit Jeans",
    "sku": "MSFJ-32-IND",
    "size": "38",
    "color": "Indigo",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-04"
  },
  {
    "order_id": 1001,
    "product_name": "Women's Cotton T-Shirt",
    "sku": "WCTS-M-BLK",
    "size": "XS",
    "color": "Black",
    "return_reason": "Looks different than picture",
    "return_date": "2025-04-05"
  },
  {
    "order_id": 1002,
    "product_name": "Unisex Hoodie",
    "sku": "UH-L-GRY",
    "size": "38",
    "color": "Grey",
    "return_reason": "Item damaged on arrival",
    "return_date": "2025-04-08"
  },
  {
    "order_id": 1003,
    "product_name": "Kids Rain Jacket",
    "sku": "KRJ-XS-YLW",
    "size": "M",
    "color": "Yellow",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-20"
  },
  {
    "order_id": 1004,
    "product_name": "Men's Formal Shirt",
    "sku": "MFS-40-WHT",
    "size": "36",
    "color": "White",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-12"
  },
  {
    "order_id": 1005,
    "product_name": "Women's Maxi Dress",
    "sku": "WMD-L-RED",
    "size": "36",
    "color": "Red",
    "return_reason": "Item damaged on arrival",
    "return_date": "2025-04-18"
  },
  {
    "order_id": 1006,
    "product_name": "Men's Running Shorts",
    "sku": "MRS-M-NVY",
    "size": "L",
    "color": "Navy",
    "return_reason": "Ordered by mistake",
    "return_date": "2025-04-07"
  },
  {
    "order_id": 1007,
    "product_name": "Women's Sports Bra",
    "sku": "WSB-S-PNK",
    "size": "38",
    "color": "Pink",
    "return_reason": "Wrong item delivered",
    "return_date": "2025-04-16"
  },
  {
    "order_id": 1008,
    "product_name": "Kids Pajama Set",
    "sku": "KPS-4T-GRN",
    "size": "38",
    "color": "Green",
    "return_reason": "Wrong item delivered",
    "return_date": "2025-04-17"
  },
  {
    "order_id": 1009,
    "product_name": "Men's Leather Jacket",
    "sku": "MLJ-XL-BRN",
    "size": "S",
    "color": "Brown",
    "return_reason": "Too expensive",
    "return_date": "2025-04-14"
  },
  {
    "order_id": 1010,
    "product_name": "Men's Slim Fit Jeans",
    "sku": "MSFJ-32-IND",
    "size": "32",
    "color": "Indigo",
    "return_reason": "Ordered by mistake",
    "return_date": "2025-04-23"
  },
  {
    "order_id": 1011,
    "product_name": "Women's Cotton T-Shirt",
    "sku": "WCTS-M-BLK",
    "size": "XL",
    "color": "Black",
    "return_reason": "Too expensive",
    "return_date": "2025-04-12"
  },
  {
    "order_id": 1012,
    "product_name": "Unisex Hoodie",
    "sku": "UH-L-GRY",
    "size": "XL",
    "color": "Grey",
    "return_reason": "Size too small",
    "return_date": "2025-04-21"
  },
  {
    "order_id": 1013,
    "product_name": "Kids Rain Jacket",
    "sku": "KRJ-XS-YLW",
    "size": "L",
    "color": "Yellow",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1014,
    "product_name": "Men's Formal Shirt",
    "sku": "MFS-40-WHT",
    "size": "32",
    "color": "White",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-19"
  },
  {
    "order_id": 1015,
    "product_name": "Women's Maxi Dress",
    "sku": "WMD-L-RED",
    "size": "34",
    "color": "Red",
    "return_reason": "Wrong item delivered",
    "return_date": "2025-04-13"
  },
  {
    "order_id": 1016,
    "product_name": "Men's Running Shorts",
    "sku": "MRS-M-NVY",
    "size": "34",
    "color": "Navy",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-01"
  },
  {
    "order_id": 1017,
    "product_name": "Women's Sports Bra",
    "sku": "WSB-S-PNK",
    "size": "38",
    "color": "Pink",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-02"
  },
  {
    "order_id": 1018,
    "product_name": "Kids Pajama Set",
    "sku": "KPS-4T-GRN",
    "size": "36",
    "color": "Green",
    "return_reason": "Ordered by mistake",
    "return_date": "2025-04-05"
  },
  {
    "order_id": 1019,
    "product_name": "Men's Leather Jacket",
    "sku": "MLJ-XL-BRN",
    "size": "S",
    "color": "Brown",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-24"
  },
  {
    "order_id": 1020,
    "product_name": "Men's Slim Fit Jeans",
    "sku": "MSFJ-32-IND",
    "size": "40",
    "color": "Indigo",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-13"
  },
  {
    "order_id": 1021,
    "product_name": "Women's Cotton T-Shirt",
    "sku": "WCTS-M-BLK",
    "size": "40",
    "color": "Black",
    "return_reason": "Wrong item delivered",
    "return_date": "2025-04-20"
  },
  {
    "order_id": 1022,
    "product_name": "Unisex Hoodie",
    "sku": "UH-L-GRY",
    "size": "36",
    "color": "Grey",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1023,
    "product_name": "Kids Rain Jacket",
    "sku": "KRJ-XS-YLW",
    "size": "38",
    "color": "Yellow",
    "return_reason": "Changed my mind",
    "return_date": "2025-04-07"
  },
  {
    "order_id": 1024,
    "product_name": "Men's Formal Shirt",
    "sku": "MFS-40-WHT",
    "size": "XL",
    "color": "White",
    "return_reason": "Size too small",
    "return_date": "2025-04-02"
  },
  {
    "order_id": 1025,
    "product_name": "Women's Maxi Dress",
    "sku": "WMD-L-RED",
    "size": "32",
    "color": "Red",
    "return_reason": "Item arrived late",
    "return_date": "2025-04-17"
  },
  {
    "order_id": 1026,
    "product_name": "Men's Running Shorts",
    "sku": "MRS-M-NVY",
    "size": "S",
    "color": "Navy",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-07"
  },
  {
    "order_id": 1027,
    "product_name": "Women's Sports Bra",
    "sku": "WSB-S-PNK",
    "size": "32",
    "color": "Pink",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-28"
  },
  {
    "order_id": 1028,
    "product_name": "Kids Pajama Set",
    "sku": "KPS-4T-GRN",
    "size": "XS",
    "color": "Green",
    "return_reason": "Too expensive",
    "return_date": "2025-04-03"
  },
  {
    "order_id": 1029,
    "product_name": "Men's Leather Jacket",
    "sku": "MLJ-XL-BRN",
    "size": "36",
    "color": "Brown",
    "return_reason": "Size too small",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1030,
    "product_name": "Men's Slim Fit Jeans",
    "sku": "MSFJ-32-IND",
    "size": "32",
    "color": "Indigo",
    "return_reason": "Too expensive",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1031,
    "product_name": "Women's Cotton T-Shirt",
    "sku": "WCTS-M-BLK",
    "size": "M",
    "color": "Black",
    "return_reason": "Ordered by mistake",
    "return_date": "2025-04-14"
  },
  {
    "order_id": 1032,
    "product_name": "Unisex Hoodie",
    "sku": "UH-L-GRY",
    "size": "XL",
    "color": "Grey",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-05"
  },
  {
    "order_id": 1033,
    "product_name": "Kids Rain Jacket",
    "sku": "KRJ-XS-YLW",
    "size": "XL",
    "color": "Yellow",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1034,
    "product_name": "Men's Formal Shirt",
    "sku": "MFS-40-WHT",
    "size": "38",
    "color": "White",
    "return_reason": "Too expensive",
    "return_date": "2025-04-13"
  },
  {
    "order_id": 1035,
    "product_name": "Women's Maxi Dress",
    "sku": "WMD-L-RED",
    "size": "34",
    "color": "Red",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-22"
  },
  {
    "order_id": 1036,
    "product_name": "Men's Running Shorts",
    "sku": "MRS-M-NVY",
    "size": "32",
    "color": "Navy",
    "return_reason": "Looks different than picture",
    "return_date": "2025-04-22"
  },
  {
    "order_id": 1037,
    "product_name": "Women's Sports Bra",
    "sku": "WSB-S-PNK",
    "size": "XL",
    "color": "Pink",
    "return_reason": "Looks different than picture",
    "return_date": "2025-04-25"
  },
  {
    "order_id": 1038,
    "product_name": "Kids Pajama Set",
    "sku": "KPS-4T-GRN",
    "size": "36",
    "color": "Green",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-25"
  },
  {
    "order_id": 1039,
    "product_name": "Men's Leather Jacket",
    "sku": "MLJ-XL-BRN",
    "size": "38",
    "color": "Brown",
    "return_reason": "Looks different than picture",
    "return_date": "2025-04-19"
  },
  {
    "order_id": 1040,
    "product_name": "Men's Slim Fit Jeans",
    "sku": "MSFJ-32-IND",
    "size": "38",
    "color": "Indigo",
    "return_reason": "Wrong item delivered",
    "return_date": "2025-04-26"
  },
  {
    "order_id": 1041,
    "product_name": "Women's Cotton T-Shirt",
    "sku": "WCTS-M-BLK",
    "size": "XS",
    "color": "Black",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-03"
  },
  {
    "order_id": 1042,
    "product_name": "Unisex Hoodie",
    "sku": "UH-L-GRY",
    "size": "38",
    "color": "Grey",
    "return_reason": "Item damaged on arrival",
    "return_date": "2025-04-14"
  },
  {
    "order_id": 1043,
    "product_name": "Kids Rain Jacket",
    "sku": "KRJ-XS-YLW",
    "size": "32",
    "color": "Yellow",
    "return_reason": "Didn't like the color",
    "return_date": "2025-04-14"
  },
  {
    "order_id": 1044,
    "product_name": "Men's Formal Shirt",
    "sku": "MFS-40-WHT",
    "size": "XL",
    "color": "White",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-04"
  },
  {
    "order_id": 1045,
    "product_name": "Women's Maxi Dress",
    "sku": "WMD-L-RED",
    "size": "36",
    "color": "Red",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-09"
  },
  {
    "order_id": 1046,
    "product_name": "Men's Running Shorts",
    "sku": "MRS-M-NVY",
    "size": "S",
    "color": "Navy",
    "return_reason": "Poor fabric quality",
    "return_date": "2025-04-02"
  },
  {
    "order_id": 1047,
    "product_name": "Women's Sports Bra",
    "sku": "WSB-S-PNK",
    "size": "36",
    "color": "Pink",
    "return_reason": "Too expensive",
    "return_date": "2025-04-01"
  },
  {
    "order_id": 1048,
    "product_name": "Kids Pajama Set",
    "sku": "KPS-4T-GRN",
    "size": "38",
    "color": "Green",
    "return_reason": "Item damaged on arrival",
    "return_date": "2025-04-15"
  },
  {
    "order_id": 1049,
    "product_name": "Men's Leather Jacket",
    "sku": "MLJ-XL-BRN",
    "size": "36",
    "color": "Brown",
    "return_reason": "Item damaged on arrival",
    "return_date": "2025-04-24"
  }
]


# Get MongoDB credentials
username = input("Enter MongoDB username: ")
password = getpass.getpass("Enter MongoDB password: ")
host = input("Enter MongoDB server hostname: ")

# MongoDB URI (modify for local if needed)
uri = f"mongodb://{username}:{password}@{host}/?retryWrites=true&w=majority"

try:
    client = MongoClient(uri)
    db = client["product_returns"]
    collection = db["details"]

    
    collection.insert_many(returns)

    print("Data inserted successfully into 'product_returns.details'.")
    print("You can proceed with your lab now.")

except Exception as e:
    print("Failed to connect or insert data.")
    print("Error:", e)