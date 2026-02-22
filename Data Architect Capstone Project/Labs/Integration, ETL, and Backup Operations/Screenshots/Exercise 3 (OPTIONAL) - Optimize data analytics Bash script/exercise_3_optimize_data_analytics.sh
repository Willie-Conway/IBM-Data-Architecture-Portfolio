#!/bin/bash

# Input file
INPUT_FILE="product-launch-data.csv"

# Optimized single line using pipes to perform all operations
echo "Step 1-4: Extracting, filtering, sorting, and counting products in one pipeline..."

# Single line of code combining all steps with pipes
cut -d',' -f2,3 "$INPUT_FILE" | tail -n +2 | grep "Apparel" | cut -d',' -f1 | sort | uniq -c | sort -rn > final_data.csv

# Final output
echo "Product launch statistics"
cat final_data.csv