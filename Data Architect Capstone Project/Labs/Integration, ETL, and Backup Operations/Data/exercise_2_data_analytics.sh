#!/bin/bash

# Input file
INPUT_FILE="product-launch-data.csv"

# Step 1: Remove header and extract column Product_Name
echo "Step 1: Extracting Product_Name and removing header..."

# Extract columns Product_Name and Category, then remove the header
cut -d',' -f2,3 "$INPUT_FILE" | tail -n +2 > extracted_data.csv

# Step 2: Filter Apparel products
echo "Step 2: Selecting only Apparel products..."

# Select all rows that belong to the 'Apparel' category
grep "Apparel" extracted_data.csv > filtered_data.csv

# Step 3: Sort the filtered products
echo "Step 3: Sorting data by Product_Name..."

# Sort the filtered data by Product_Name
sort filtered_data.csv > sorted_data.csv

# Step 4: Count the number of products
echo "Step 5: Counting the number of products..."

# Count how many times each product occurs and sort in descending order of count
cut -d',' -f1 sorted_data.csv | sort | uniq -c | sort -rn > final_data.csv

# Final output
echo "Product launch statistics"
cat final_data.csv