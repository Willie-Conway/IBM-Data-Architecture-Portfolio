
![FutureMart](../Screenshots/FutureMart.png)


# Assignment Overview: Data Integration

## Estimated time: 4 minutes

---

## Learning objectives

- Develop and execute data transformation and validation scripts using Linux shell to support data integration for fraud detection
- Automate MySQL database backup operations using Bash scripting to ensure data reliability and recovery

---

## Introduction

In **Phase 1**, you critically evaluated the existing data architectures of FashionMart and TrendyThreads. This evaluation uncovered key challenges such as data silos, inefficiencies, and integration issues. You reviewed data storage mechanisms and assessed data quality, integration points, security protocols, and governance practices to identify areas for improvement in the merged organization.

In **Phase 2**, you used these insights to design a consolidated data architecture for FutureMart. This included developing data architecture diagrams, entity-relationship (ER) diagrams, database table structures, and initial schemas to address the previously identified gaps and performance bottlenecks.

In **Phase 3**, you carried out the actual data migration between systems. This involved transferring data between RDBMS and NoSQL platforms, ensuring data integrity and consistency across staging environments to support a seamless transition to the new architecture.

In this module, you will work on the tasks of **Phase 4**.

---

## Phase 4: Integrate Data Systems for Seamless Data Flow

In this phase, you will focus on integrating FutureMart's data systems to enable smooth and reliable data flow across platforms.

You will:

| Task                                         | Description                                           |
| -------------------------------------------- | ----------------------------------------------------- |
| **Develop ETL/ELT scripts**            | Create scripts to move and transform data efficiently |
| **Build robust data pipelines**        | Connect various data sources and systems              |
| **Design data warehouse schema**       | Support real-time analytics and reporting             |
| **Implement fraud detection pipeline** | Ensure timely insights and secure transactions        |

---

## Tasks

### Exercise 1: Create ETL Script Using Bash

In this exercise, you will create an ETL (Extract, Transform, Load) script using Bash to process CSV data.

**Objectives:**

- Extract data from two separate CSV files
- Clean data by removing duplicate rows from each file
- Merge the clean data into a single CSV file

---

### Exercise 2: Create Data Analytics Script Using Bash

In this exercise, you will build a Bash script to perform basic data analytics on product launch data.

**Objectives:**

- Extract data from specific columns
- Delete the header row from the extracted data
- Filter data and store it
- Count the number of products for FutureMart

---

### Exercise 3: Optimize Data Analytics Using Bash Script (Optional)

In this exercise, you will optimize the data analytics script by combining multiple steps into a single command using Linux pipes.

---

### Exercise 4: Backup MySQL Database Using Bash

In this exercise, you will write a Bash script to perform a backup of a MySQL database server.

**Objectives:**

- Declare variables for database connection
- Implement the logic to back up the database

**Variables to define:**

- `DBUSERNAME`
- `DBPASSWORD`
- `HOST`
- `DB_NAME`
- `BACKUP_DIRECTORY`

---

## Deliverables

By the end of Module 4, you will have completed the following deliverables:

| Exercise             | Deliverable                                             | Filename                         |
| -------------------- | ------------------------------------------------------- | -------------------------------- |
| **Exercise 1** | ETL script created using Bash                           | `exercise_1_etl.sh`            |
| **Exercise 2** | Data analytics script created using Bash                | `exercise_2_data_analytics.sh` |
| **Exercise 4** | Bash script to back up the database on the MySQL server | `exercise_4_mysql_backup.sh`   |

---

## Solution Templates

### Exercise 1: ETL Script Template (`exercise_1_etl.sh`)

```bash
#!/bin/bash
# =====================================================
# ETL SCRIPT: Extract, Transform, Load CSV Data
# =====================================================
# This script performs ETL operations on CSV files:
# 1. Extract data from two source CSV files
# 2. Remove duplicate rows
# 3. Merge clean data into a single output file
# =====================================================

set -e  # Exit on error

# Configuration
SCRIPT_NAME="exercise_1_etl.sh"
SOURCE_FILE1="data_source1.csv"
SOURCE_FILE2="data_source2.csv"
TEMP_FILE1="temp_clean1.csv"
TEMP_FILE2="temp_clean2.csv"
OUTPUT_FILE="merged_data.csv"
LOG_FILE="etl_log.txt"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to check if files exist
check_file_exists() {
    if [ ! -f "$1" ]; then
        log_message "ERROR: File $1 not found!"
        exit 1
    fi
}

# =====================================================
# EXTRACT PHASE
# =====================================================
log_message "=== STARTING ETL PROCESS ==="
log_message "EXTRACT: Checking source files..."

check_file_exists "$SOURCE_FILE1"
check_file_exists "$SOURCE_FILE2"

log_message "EXTRACT: Source files verified"
log_message "  - $SOURCE_FILE1"
log_message "  - $SOURCE_FILE2"

# =====================================================
# TRANSFORM PHASE - Clean data by removing duplicates
# =====================================================
log_message "TRANSFORM: Cleaning data..."

# Remove duplicates from first file
log_message "  - Processing $SOURCE_FILE1..."
sort "$SOURCE_FILE1" | uniq > "$TEMP_FILE1"
original_count1=$(wc -l < "$SOURCE_FILE1")
clean_count1=$(wc -l < "$TEMP_FILE1")
duplicates_removed1=$((original_count1 - clean_count1))
log_message "    Original: $original_count1 rows, Clean: $clean_count1 rows, Duplicates removed: $duplicates_removed1"

# Remove duplicates from second file
log_message "  - Processing $SOURCE_FILE2..."
sort "$SOURCE_FILE2" | uniq > "$TEMP_FILE2"
original_count2=$(wc -l < "$SOURCE_FILE2")
clean_count2=$(wc -l < "$TEMP_FILE2")
duplicates_removed2=$((original_count2 - clean_count2))
log_message "    Original: $original_count2 rows, Clean: $clean_count2 rows, Duplicates removed: $duplicates_removed2"

# =====================================================
# LOAD PHASE - Merge clean data
# =====================================================
log_message "LOAD: Merging clean data..."

# Combine cleaned files and remove any duplicates across both files
cat "$TEMP_FILE1" "$TEMP_FILE2" | sort | uniq > "$OUTPUT_FILE"

final_count=$(wc -l < "$OUTPUT_FILE")
total_original=$((original_count1 + original_count2))
total_clean=$((clean_count1 + clean_count2))
cross_duplicates=$((total_clean - final_count))

log_message "LOAD: Output file created: $OUTPUT_FILE"
log_message "  - Total original rows: $total_original"
log_message "  - Total clean rows: $total_clean"
log_message "  - Cross-file duplicates removed: $cross_duplicates"
log_message "  - Final merged rows: $final_count"

# =====================================================
# Cleanup temporary files
# =====================================================
log_message "Cleaning up temporary files..."
rm -f "$TEMP_FILE1" "$TEMP_FILE2"

log_message "=== ETL PROCESS COMPLETED SUCCESSFULLY ==="

# Display sample of output
echo ""
echo "Sample of merged data (first 5 rows):"
head -5 "$OUTPUT_FILE"
echo ""

exit 0
```

---

### Exercise 2: Data Analytics Script Template (`exercise_2_data_analytics.sh`)

```bash
#!/bin/bash
# =====================================================
# DATA ANALYTICS SCRIPT: Product Launch Analysis
# =====================================================
# This script performs analytics on product launch data:
# 1. Extract data from specific columns
# 2. Remove header row
# 3. Filter data based on criteria
# 4. Count products for FutureMart
# =====================================================

set -e  # Exit on error

# Configuration
SCRIPT_NAME="exercise_2_data_analytics.sh"
INPUT_FILE="product_launch_data.csv"
OUTPUT_DIR="analytics_output"
EXTRACTED_FILE="$OUTPUT_DIR/extracted_columns.csv"
FILTERED_FILE="$OUTPUT_DIR/filtered_data.csv"
SUMMARY_FILE="$OUTPUT_DIR/analysis_summary.txt"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if input file exists
check_input_file() {
    if [ ! -f "$INPUT_FILE" ]; then
        log_message "ERROR: Input file $INPUT_FILE not found!"
        exit 1
    fi
}

# =====================================================
# Display header
# =====================================================
echo "====================================================="
echo "  PRODUCT LAUNCH DATA ANALYTICS"
echo "====================================================="
echo ""

# =====================================================
# Step 1: Extract data from specific columns
# =====================================================
log_message "Step 1: Extracting data from specific columns..."

check_input_file

# Display column headers for reference
echo ""
echo "Available columns in input file:"
head -1 "$INPUT_FILE" | tr ',' '\n' | nl
echo ""

# Extract columns 1, 3, and 5 (assuming these are relevant columns)
# Adjust column numbers based on actual data structure
log_message "  - Extracting columns 1, 3, and 5..."
cut -d',' -f1,3,5 "$INPUT_FILE" > "$EXTRACTED_FILE"

extracted_count=$(wc -l < "$EXTRACTED_FILE")
log_message "  - Extracted $extracted_count rows (including header)"

# =====================================================
# Step 2: Delete the header row from extracted data
# =====================================================
log_message "Step 2: Removing header row..."

tail -n +2 "$EXTRACTED_FILE" > "${EXTRACTED_FILE}.tmp"
mv "${EXTRACTED_FILE}.tmp" "$EXTRACTED_FILE"

data_rows=$(wc -l < "$EXTRACTED_FILE")
log_message "  - Removed header, $data_rows data rows remaining"

# =====================================================
# Step 3: Filter data and store it
# =====================================================
log_message "Step 3: Filtering data based on criteria..."

# Example filter: rows where column 2 (after extraction) contains "FutureMart"
# Adjust filter criteria based on actual data
grep -i "FutureMart" "$EXTRACTED_FILE" > "$FILTERED_FILE"

filtered_count=$(wc -l < "$FILTERED_FILE")
log_message "  - Filtered to $filtered_count rows matching criteria"

# =====================================================
# Step 4: Count the number of products for FutureMart
# =====================================================
log_message "Step 4: Counting products for FutureMart..."

# Count products (assuming each row represents a product)
product_count=$filtered_count

# =====================================================
# Generate summary report
# =====================================================
log_message "Generating analysis summary..."

cat > "$SUMMARY_FILE" << EOF
========================================
PRODUCT LAUNCH DATA ANALYSIS SUMMARY
========================================
Date: $(date '+%Y-%m-%d %H:%M:%S')
Input file: $INPUT_FILE

DATA EXTRACTION:
- Columns extracted: 1, 3, 5
- Total rows extracted (including header): $extracted_count
- Data rows after header removal: $data_rows

FILTERING CRITERIA:
- Filter applied: Contains "FutureMart"
- Records matching criteria: $filtered_count

PRODUCT COUNT:
- Total products for FutureMart: $product_count

========================================
EOF

# =====================================================
# Display results
# =====================================================
echo ""
echo "====================================================="
echo "  ANALYSIS RESULTS"
echo "====================================================="
echo ""
echo "📊 Products for FutureMart: $product_count"
echo ""
echo "Sample of filtered data (first 5 rows):"
echo "----------------------------------------"
head -5 "$FILTERED_FILE" | while IFS= read -r line; do
    echo "  $line"
done
echo ""
echo "Full summary saved to: $SUMMARY_FILE"
echo "====================================================="

exit 0
```

---

### Exercise 3: Optimized Data Analytics Script (Optional) (`exercise_3_optimized_analytics.sh`)

```bash
#!/bin/bash
# =====================================================
# OPTIMIZED DATA ANALYTICS SCRIPT
# =====================================================
# This script combines multiple steps using Linux pipes
# for efficient data processing
# =====================================================

set -e

INPUT_FILE="product_launch_data.csv"
OUTPUT_DIR="analytics_output_optimized"
mkdir -p "$OUTPUT_DIR"

echo "====================================================="
echo "  OPTIMIZED PRODUCT LAUNCH DATA ANALYTICS"
echo "====================================================="
echo ""

# Using pipes to chain commands - single pipeline
echo "Running optimized pipeline..."

cat "$INPUT_FILE" | \
    tail -n +2 |                    # Remove header
    cut -d',' -f1,3,5 |              # Extract columns
    grep -i "FutureMart" |            # Filter for FutureMart
    tee "$OUTPUT_DIR/filtered_data.csv" |  # Save intermediate result
    wc -l > "$OUTPUT_DIR/product_count.txt"  # Count products

product_count=$(cat "$OUTPUT_DIR/product_count.txt")

echo ""
echo "====================================================="
echo "  OPTIMIZED ANALYSIS RESULTS"
echo "====================================================="
echo ""
echo "📊 Products for FutureMart: $product_count"
echo ""
echo "Sample of filtered data (first 5 rows):"
echo "----------------------------------------"
head -5 "$OUTPUT_DIR/filtered_data.csv"
echo ""
echo "====================================================="

# Generate summary
cat > "$OUTPUT_DIR/optimized_summary.txt" << EOF
OPTIMIZED PIPELINE ANALYSIS
===========================
Date: $(date '+%Y-%m-%d %H:%M:%S')
Pipeline commands used:
  cat $INPUT_FILE | tail -n +2 | cut -d',' -f1,3,5 | grep -i "FutureMart" | tee filtered_data.csv | wc -l

Products for FutureMart: $product_count
EOF

exit 0
```

---

### Exercise 4: MySQL Database Backup Script (`exercise_4_mysql_backup.sh`)

```bash
#!/bin/bash
# =====================================================
# MYSQL DATABASE BACKUP SCRIPT
# =====================================================
# This script performs automated backup of MySQL database
# with timestamp, compression, and retention management
# =====================================================

set -e  # Exit on error

# =====================================================
# DECLARE VARIABLES (Update these with your credentials)
# =====================================================

# Database connection parameters
DBUSERNAME="root"                    # Database username
DBPASSWORD="your_password_here"       # Database password
HOST="localhost"                      # Database host
DB_NAME="fashionmart"                  # Database name to backup

# Backup configuration
BACKUP_DIRECTORY="/backup/mysql"       # Directory to store backups
RETENTION_DAYS=7                        # Number of days to keep backups
DATE=$(date +'%Y-%m-%d_%H-%M-%S')       # Timestamp for backup file
BACKUP_FILENAME="${DB_NAME}_${DATE}.sql"
BACKUP_FILE="${BACKUP_DIRECTORY}/${BACKUP_FILENAME}"
COMPRESSED_FILE="${BACKUP_FILE}.gz"
LOG_FILE="${BACKUP_DIRECTORY}/backup_log.txt"

# =====================================================
# FUNCTIONS
# =====================================================

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to check if backup directory exists
check_backup_directory() {
    if [ ! -d "$BACKUP_DIRECTORY" ]; then
        log_message "Creating backup directory: $BACKUP_DIRECTORY"
        mkdir -p "$BACKUP_DIRECTORY"
        if [ $? -ne 0 ]; then
            log_message "ERROR: Failed to create backup directory"
            exit 1
        fi
    fi
}

# Function to test database connection
test_database_connection() {
    log_message "Testing database connection..."
  
    mysql -h "$HOST" -u "$DBUSERNAME" -p"$DBPASSWORD" -e "SELECT 1" "$DB_NAME" > /dev/null 2>&1
  
    if [ $? -eq 0 ]; then
        log_message "✅ Database connection successful"
        return 0
    else
        log_message "❌ ERROR: Database connection failed"
        log_message "   Please check:"
        log_message "   - Database server is running"
        log_message "   - Credentials are correct"
        log_message "   - Database '$DB_NAME' exists"
        exit 1
    fi
}

# Function to perform database backup
perform_backup() {
    log_message "Starting backup of database: $DB_NAME"
  
    # Get database size before backup (optional)
    DB_SIZE=$(mysql -h "$HOST" -u "$DBUSERNAME" -p"$DBPASSWORD" -e "
        SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
        FROM information_schema.tables 
        WHERE table_schema = '$DB_NAME'" 2>/dev/null | tail -1)
  
    log_message "Database size: ${DB_SIZE:-Unknown} MB"
  
    # Perform the backup using mysqldump
    log_message "Dumping database to: $BACKUP_FILE"
  
    mysqldump -h "$HOST" -u "$DBUSERNAME" -p"$DBPASSWORD" \
        --single-transaction \
        --routines \
        --triggers \
        --events \
        --databases "$DB_NAME" > "$BACKUP_FILE" 2>> "$LOG_FILE"
  
    if [ $? -eq 0 ]; then
        BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
        log_message "✅ Backup completed successfully: $BACKUP_SIZE"
    else
        log_message "❌ ERROR: Backup failed"
        exit 1
    fi
}

# Function to compress backup
compress_backup() {
    log_message "Compressing backup file..."
  
    gzip -9 "$BACKUP_FILE"
  
    if [ $? -eq 0 ]; then
        COMPRESSED_SIZE=$(du -h "$COMPRESSED_FILE" | cut -f1)
        log_message "✅ Compression completed: $COMPRESSED_SIZE"
    else
        log_message "⚠️ Warning: Compression failed, keeping uncompressed file"
    fi
}

# Function to clean old backups
cleanup_old_backups() {
    log_message "Cleaning backups older than $RETENTION_DAYS days..."
  
    find "$BACKUP_DIRECTORY" -name "${DB_NAME}_*.sql.gz" -type f -mtime +$RETENTION_DAYS -delete
    find "$BACKUP_DIRECTORY" -name "${DB_NAME}_*.sql" -type f -mtime +$RETENTION_DAYS -delete
  
    # Count remaining backups
    BACKUP_COUNT=$(find "$BACKUP_DIRECTORY" -name "${DB_NAME}_*.sql*" -type f | wc -l)
    log_message "Retention policy applied: $BACKUP_COUNT backups retained"
}

# Function to verify backup integrity
verify_backup() {
    log_message "Verifying backup integrity..."
  
    # Check if compressed file exists and is not empty
    if [ -f "$COMPRESSED_FILE" ]; then
        if [ -s "$COMPRESSED_FILE" ]; then
            log_message "✅ Backup file exists and is not empty"
        else
            log_message "❌ ERROR: Backup file is empty"
            exit 1
        fi
    elif [ -f "$BACKUP_FILE" ]; then
        if [ -s "$BACKUP_FILE" ]; then
            log_message "✅ Backup file exists and is not empty"
        else
            log_message "❌ ERROR: Backup file is empty"
            exit 1
        fi
    else
        log_message "❌ ERROR: Backup file not found"
        exit 1
    fi
  
    # Test the backup by checking if it contains valid SQL
    if [ -f "$COMPRESSED_FILE" ]; then
        gunzip -c "$COMPRESSED_FILE" | head -100 | grep -q "CREATE TABLE" > /dev/null 2>&1
    else
        head -100 "$BACKUP_FILE" | grep -q "CREATE TABLE" > /dev/null 2>&1
    fi
  
    if [ $? -eq 0 ]; then
        log_message "✅ Backup contains valid SQL structure"
    else
        log_message "⚠️ Warning: Backup may be corrupted (no CREATE TABLE statements found)"
    fi
}

# Function to send notification (optional - can be extended)
send_notification() {
    # This is a placeholder for notification logic
    # Could send email, Slack message, etc.
    log_message "Backup process completed for database: $DB_NAME"
}

# =====================================================
# MAIN EXECUTION
# =====================================================

echo ""
echo "====================================================="
echo "  MYSQL DATABASE BACKUP SCRIPT"
echo "====================================================="
echo ""

# Start backup process
log_message "=== BACKUP PROCESS STARTED ==="
log_message "Database: $DB_NAME"
log_message "Host: $HOST"
log_message "Backup directory: $BACKUP_DIRECTORY"

# Execute backup steps
check_backup_directory
test_database_connection
perform_backup
compress_backup
verify_backup
cleanup_old_backups
send_notification

# Summary
echo ""
echo "====================================================="
echo "  BACKUP SUMMARY"
echo "====================================================="
echo ""

if [ -f "$COMPRESSED_FILE" ]; then
    FINAL_FILE="$COMPRESSED_FILE"
    FINAL_SIZE=$(du -h "$COMPRESSED_FILE" | cut -f1)
else
    FINAL_FILE="$BACKUP_FILE"
    FINAL_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
fi

echo "✅ Backup completed successfully!"
echo ""
echo "Backup file: $FINAL_FILE"
echo "Backup size: $FINAL_SIZE"
echo "Backup time: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "Backups retained: $(find "$BACKUP_DIRECTORY" -name "${DB_NAME}_*.sql*" -type f | wc -l)"
echo "Log file: $LOG_FILE"
echo ""

log_message "=== BACKUP PROCESS COMPLETED SUCCESSFULLY ==="

exit 0
```

---

## Usage Instructions

### Exercise 1: ETL Script

```bash
# Make script executable
chmod +x exercise_1_etl.sh

# Run the script
./exercise_1_etl.sh

# Expected output files:
# - merged_data.csv (final merged dataset)
# - etl_log.txt (execution log)
```

### Exercise 2: Data Analytics Script

```bash
# Make script executable
chmod +x exercise_2_data_analytics.sh

# Run the script
./exercise_2_data_analytics.sh

# Expected output files in analytics_output/ directory:
# - extracted_columns.csv
# - filtered_data.csv
# - analysis_summary.txt
```

### Exercise 4: MySQL Backup Script

```bash
# First, edit the script to set your database credentials
# Update DBUSERNAME, DBPASSWORD, DB_NAME variables

# Make script executable
chmod +x exercise_4_mysql_backup.sh

# Run the script
./exercise_4_mysql_backup.sh

# Expected output:
# - Compressed backup file in BACKUP_DIRECTORY
# - Log file with execution details
```

---

## Deliverables Checklist

| Exercise   | Filename                         | Status |
| ---------- | -------------------------------- | ------ |
| Exercise 1 | `exercise_1_etl.sh`            | ⬜     |
| Exercise 2 | `exercise_2_data_analytics.sh` | ⬜     |
| Exercise 4 | `exercise_4_mysql_backup.sh`   | ⬜     |

---

## Summary

In this phase, you will develop critical data integration scripts that:

| Exercise             | Skill               | Application                                          |
| -------------------- | ------------------- | ---------------------------------------------------- |
| **Exercise 1** | ETL Processing      | Extract, clean, and merge data from multiple sources |
| **Exercise 2** | Data Analytics      | Extract and analyze specific data columns            |
| **Exercise 4** | Database Operations | Automate backup procedures for data reliability      |

These scripts form the foundation of FutureMart's data integration pipeline, enabling efficient data processing, analysis, and protection.

---

*Assignment started: _________________*
*Data Integration Engineer: _________________*
*Due date: _________________*
