#!/bin/bash

# MySQL database backup script

# Database connection variables
DB_USERNAME="your_username"
DB_PASSWORD="your_password"
HOST="localhost"
DB_NAME="web_products"
BACKUP_DIRECTORY="/home/project/backups"

# Get current date in YYYY-MM-DD format
CURRENT_DATE=$(date +%Y-%m-%d)

# Create backup filename with date
BACKUP_FILE="webproducts_backup_${CURRENT_DATE}.sql"

# Full path to backup file
FULL_BACKUP_PATH="${BACKUP_DIRECTORY}/${BACKUP_FILE}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIRECTORY"

# Perform MySQL database backup
echo "Starting MySQL database backup..."
echo "Database: $DB_NAME"
echo "Backup location: $FULL_BACKUP_PATH"

mysqldump -u "$DB_USERNAME" -p"$DB_PASSWORD" -h "$HOST" "$DB_NAME" > "$FULL_BACKUP_PATH"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!"
    echo "Backup file created: $BACKUP_FILE"
    
    # Optional: Compress the backup file
    # gzip "$FULL_BACKUP_PATH"
    # echo "Backup compressed: ${BACKUP_FILE}.gz"
else
    echo "Error: Backup failed!"
    exit 1
fi

# Optional: Display backup file information
echo "Backup file details:"
ls -lh "$FULL_BACKUP_PATH"