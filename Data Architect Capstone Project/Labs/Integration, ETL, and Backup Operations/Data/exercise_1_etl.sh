#!/bin/bash

# Step 1: Extract - Extract columns (Product_Name,Category) from sales_file2.csv and save to sales_extracted2.csv
cut -d',' -f2,3 sales-file2.csv > sales_extracted2.csv

# Step 2: Transform - Remove duplicates from sales_file1.csv and save to sales_uniq1.csv
sort sales-file1.csv | uniq > sales_uniq1.csv

# Step 3: Transform - Remove duplicates from sales_extracted2.csv and save to sales_uniq2.csv
sort sales_extracted2.csv | uniq > sales_uniq2.csv

# Step 4: Load - Combine the two files sales_uniq1.csv, sales_uniq2.csv so that the out file has the columns Sale_ID,Price,Date_Returned,Product_Name,Category make sure the delimiter is a comma.
paste -d',' sales_uniq1.csv sales_uniq2.csv > combined_output.csv