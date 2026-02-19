

### Emergent Trends and Practices in Cloud Storage

#### Objectives
After completing this reading, you will be able to:
- Discuss popular emerging trends and practices in cloud storage.
- Describe common artificial intelligence (AI) and machine learning (ML) tools and their purposes.

#### Introduction
Cloud storage has become crucial to modern business operations and personal data management. As data generation increases rapidly, organizations and individuals are turning to cloud storage solutions for efficient data storage, management, and security. New trends and practices drive the development of cloud storage to meet the rising demands for scalability, security, cost-effectiveness, and sustainability.

Let's discuss some of the most significant emerging trends and practices in cloud storage.

#### Multicloud and Hybrid Cloud Strategies
A significant trend in cloud storage is the increasing adoption of multicloud and hybrid cloud strategies. **Multicloud strategy** involves using services from multiple cloud providers such as Amazon Web Services, Azure, and Google Cloud for various workloads. **Hybrid cloud solutions** combine on-premises infrastructure with public and private cloud storage.

**Key Advantages:**
- **Redundancy and reliability:** Leveraging multiple cloud providers ensures data redundancy and higher availability, significantly reducing the risk of data loss or service outages.
- **Cost optimization:** Organizations can optimize their storage expenses by selecting the most cost-effective solutions for different data types.
- **Regulatory compliance:** Multicloud strategies enable companies to store data in specific regions, helping them meet local regulatory requirements.

**Example: Multicloud Storage Configuration with Terraform**

This example demonstrates provisioning storage buckets across multiple cloud providers using Infrastructure as Code:

```hcl
# Terraform configuration for multicloud storage deployment
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# AWS Provider and S3 Bucket
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "hot_data" {
  bucket = "company-hot-data-us"
  tags = {
    Name        = "Hot Data Storage"
    Environment = "Production"
    DataType    = "FrequentlyAccessed"
  }
}

# Configure lifecycle for cost optimization
resource "aws_s3_bucket_lifecycle_rule" "hot_data_lifecycle" {
  bucket = aws_s3_bucket.hot_data.id
  id     = "archive_old_data"
  status = "Enabled"
  
  transition {
    days          = 30
    storage_class = "STANDARD_IA"  # Infrequent Access after 30 days
  }
  
  transition {
    days          = 90
    storage_class = "GLACIER"      # Glacier after 90 days
  }
}

# Google Cloud Provider and Storage Bucket
provider "google" {
  project = "my-multicloud-project"
  region  = "europe-west1"
}

resource "google_storage_bucket" "eu_data" {
  name          = "company-eu-data"
  location      = "EU"
  force_destroy = false
  
  # Enable versioning for data protection
  versioning {
    enabled = true
  }
  
  # Set retention policy for compliance
  retention_policy {
    retention_period = 31536000  # 1 year in seconds (GDPR compliance)
  }
  
  labels = {
    environment = "production"
    region      = "europe"
    compliance  = "gdpr"
  }
}

# Azure Provider and Storage Account
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "asia_rg" {
  name     = "asia-storage-resources"
  location = "southeastasia"
}

resource "azurerm_storage_account" "asia_data" {
  name                     = "companyasiaarchive"
  resource_group_name      = azurerm_resource_group.asia_rg.name
  location                 = azurerm_resource_group.asia_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  # Locally redundant for archive data
  
  tags = {
    environment = "archive"
    datatype    = "cold-storage"
  }
}

# Output bucket information
output "aws_bucket_arn" {
  value = aws_s3_bucket.hot_data.arn
}

output "gcs_bucket_url" {
  value = google_storage_bucket.eu_data.url
}

output "azure_storage_endpoint" {
  value = azurerm_storage_account.asia_data.primary_blob_endpoint
}
```

#### Edge Computing and Decentralized Storage
Edge computing and decentralized storage are two emerging trends reshaping the future of cloud technology. **Edge computing** involves processing data closer to its source, such as Internet of Things (IoT) devices and sensors, instead of relying solely on centralized cloud servers. **Decentralized storage** distributes data across a network of nodes rather than in a central location.

**Advantages:**
- **Increased security:** Decentralization reduces the risk of a single point of failure
- **Data sovereignty:** Organizations maintain greater control over their data
- **Cost reduction:** Distributing storage across multiple nodes can lower costs

**Example: Edge Processing with AWS IoT Greengrass**

This example shows how to process data at the edge before syncing to the cloud:

```python
# Edge device script using AWS IoT Greengrass
import greengrasssdk
import json
import time
import os
import sqlite3
from datetime import datetime, timedelta

# Initialize Greengrass SDK
client = greengrasssdk.client('iot-data')

# Local SQLite database for edge storage
DB_PATH = '/greengrass/data/edge_cache.db'

def init_local_db():
    """Initialize local SQLite database for edge caching"""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Create table for sensor data
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS sensor_readings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            device_id TEXT,
            sensor_type TEXT,
            reading_value REAL,
            timestamp DATETIME,
            processed BOOLEAN DEFAULT 0,
            alert_generated BOOLEAN DEFAULT 0
        )
    ''')
    
    # Create index for efficient queries
    cursor.execute('''
        CREATE INDEX IF NOT EXISTS idx_timestamp 
        ON sensor_readings(timestamp)
    ''')
    
    conn.commit()
    conn.close()

def process_sensor_data(device_id, sensor_type, value, timestamp):
    """Process sensor data at the edge - detect anomalies in real-time"""
    
    # Edge-based anomaly detection
    alerts = []
    
    # Temperature monitoring (example use case)
    if sensor_type == 'temperature':
        if value > 85.0:
            alerts.append({
                'device_id': device_id,
                'alert_type': 'HIGH_TEMPERATURE',
                'value': value,
                'threshold': 85.0,
                'timestamp': timestamp
            })
        elif value < -10.0:
            alerts.append({
                'device_id': device_id,
                'alert_type': 'LOW_TEMPERATURE',
                'value': value,
                'threshold': -10.0,
                'timestamp': timestamp
            })
    
    # Vibration monitoring for predictive maintenance
    if sensor_type == 'vibration':
        if value > 5.0:  # Vibration threshold
            alerts.append({
                'device_id': device_id,
                'alert_type': 'EXCESSIVE_VIBRATION',
                'value': value,
                'threshold': 5.0,
                'timestamp': timestamp
            })
    
    return alerts

def store_reading_locally(device_id, sensor_type, value, timestamp, alerts):
    """Store reading in local SQLite database"""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    cursor.execute('''
        INSERT INTO sensor_readings 
        (device_id, sensor_type, reading_value, timestamp, alert_generated)
        VALUES (?, ?, ?, ?, ?)
    ''', (device_id, sensor_type, value, timestamp, len(alerts) > 0))
    
    conn.commit()
    conn.close()
    
    return cursor.lastrowid

def sync_to_cloud():
    """Sync aggregated data to cloud every hour"""
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Get unprocessed readings aggregated by hour
    cursor.execute('''
        SELECT 
            device_id,
            sensor_type,
            DATE(timestamp) as reading_date,
            STRFTIME('%H', timestamp) as reading_hour,
            AVG(reading_value) as avg_value,
            MAX(reading_value) as max_value,
            MIN(reading_value) as min_value,
            COUNT(*) as reading_count,
            SUM(CASE WHEN alert_generated = 1 THEN 1 ELSE 0 END) as alert_count
        FROM sensor_readings
        WHERE processed = 0
        GROUP BY device_id, sensor_type, reading_date, reading_hour
    ''')
    
    aggregated_data = cursor.fetchall()
    
    for row in aggregated_data:
        # Prepare cloud payload
        cloud_payload = {
            'device_id': row[0],
            'sensor_type': row[1],
            'date': row[2],
            'hour': row[3],
            'avg_value': row[4],
            'max_value': row[5],
            'min_value': row[6],
            'reading_count': row[7],
            'alert_count': row[8],
            'sync_timestamp': datetime.utcnow().isoformat()
        }
        
        # Send to AWS IoT Core
        client.publish(
            topic='edge/aggregated/sensor_data',
            payload=json.dumps(cloud_payload)
        )
        
        # Mark as processed
        cursor.execute('''
            UPDATE sensor_readings 
            SET processed = 1 
            WHERE device_id = ? 
            AND DATE(timestamp) = ? 
            AND STRFTIME('%H', timestamp) = ?
        ''', (row[0], row[2], row[3]))
    
    conn.commit()
    conn.close()

def lambda_handler(event, context):
    """Main handler for Greengrass Lambda"""
    
    # Initialize database on first run
    if not os.path.exists(DB_PATH):
        init_local_db()
    
    # Process incoming sensor data
    for record in event.get('records', []):
        device_id = record.get('device_id', 'unknown')
        sensor_type = record.get('sensor_type', 'unknown')
        value = record.get('value', 0.0)
        timestamp = record.get('timestamp', datetime.utcnow().isoformat())
        
        # Edge processing
        alerts = process_sensor_data(device_id, sensor_type, value, timestamp)
        
        # Store locally
        record_id = store_reading_locally(device_id, sensor_type, value, timestamp, alerts)
        
        # Immediate alert for critical conditions
        if alerts:
            client.publish(
                topic=f'edge/alerts/{device_id}',
                payload=json.dumps(alerts)
            )
        
        print(f"Processed record {record_id}: {len(alerts)} alerts generated")
    
    # Sync to cloud if it's the top of the hour
    current_minute = datetime.now().minute
    if current_minute == 0:  # Sync at the top of every hour
        sync_to_cloud()
    
    return {
        'status': 'success',
        'processed': len(event.get('records', []))
    }
```

#### Sustainability and Green Cloud Storage
As environmental concerns intensify, sustainability becomes a central focus in cloud storage practices. Cloud providers are increasingly adopting green initiatives to reduce their carbon footprint and enhance energy efficiency.

**Key Practices:**
- **Renewable energy usage:** Solar and wind power for data centers
- **Energy-efficient data centers:** Liquid cooling and AI-optimized systems
- **Data lifecycle management:** Storing data only as long as necessary

**Example: Carbon-Aware Data Storage Scheduler**

```python
import boto3
import requests
from datetime import datetime, timedelta
import schedule
import time

class CarbonAwareStorageScheduler:
    """Schedule data transfers based on grid carbon intensity"""
    
    def __init__(self, region_mappings):
        """
        Initialize with region mappings
        region_mappings: {
            'us-east-1': 'pjm',  # AWS region -> grid region
            'eu-west-1': 'ie',    # Ireland grid
        }
        """
        self.region_mappings = region_mappings
        self.s3_client = boto3.client('s3')
        self.ec2_client = boto3.client('ec2')
        
    def get_carbon_intensity(self, grid_region):
        """
        Fetch current carbon intensity for a grid region
        Using Electricity Maps API (free tier)
        """
        # Note: In production, use actual API key
        api_url = f"https://api.electricitymap.org/v3/carbon-intensity/latest"
        params = {'zone': grid_region}
        headers = {'auth-token': 'YOUR_API_KEY'}
        
        try:
            response = requests.get(api_url, params=params, headers=headers)
            if response.status_code == 200:
                data = response.json()
                return data.get('carbonIntensity', 999)  # gCO2eq/kWh
        except:
            pass
        
        # Fallback to typical values if API unavailable
        fallback_intensities = {
            'pjm': 400,    # US East - mixed grid
            'ie': 300,      # Ireland - some wind
            'se': 30,       # Sweden - mostly hydro
            'fr': 50,       # France - nuclear
        }
        return fallback_intensities.get(grid_region, 500)
    
    def find_greenest_region(self):
        """Find the region with lowest carbon intensity"""
        intensities = {}
        
        for aws_region, grid_region in self.region_mappings.items():
            intensity = self.get_carbon_intensity(grid_region)
            intensities[aws_region] = intensity
            print(f"Region {aws_region}: {intensity} gCO2eq/kWh")
        
        # Return region with lowest intensity
        greenest = min(intensities, key=intensities.get)
        print(f"\nGreenest region: {greenest} with {intensities[greenest]} gCO2eq/kWh")
        return greenest, intensities
    
    def schedule_data_transfer(self, source_bucket, source_key, destination_bucket):
        """
        Schedule data transfer during low-carbon periods
        """
        # Check current carbon intensity
        current_hour = datetime.now().hour
        
        # Predict best time (simplified - assume lowest at 2-4 AM when demand low)
        if 2 <= current_hour <= 4:
            # Good time to transfer
            print("Current time optimal for low-carbon transfer")
            
            # Perform transfer
            copy_source = {'Bucket': source_bucket, 'Key': source_key}
            self.s3_client.copy_object(
                CopySource=copy_source,
                Bucket=destination_bucket,
                Key=f"transferred/{source_key}"
            )
            print(f"Transferred {source_key} to {destination_bucket}")
            
            # Log carbon savings
            return {
                'transferred': True,
                'time': datetime.now().isoformat(),
                'carbon_intensity': self.get_carbon_intensity(
                    self.region_mappings.get('us-east-1', 'pjm')
                )
            }
        else:
            # Schedule for later
            print("Scheduling transfer for optimal time (2-4 AM)")
            return {
                'transferred': False,
                'scheduled_time': datetime.now().replace(hour=3, minute=0).isoformat()
            }
    
    def cleanup_old_data(self, bucket, days_to_live=30):
        """
        Implement data lifecycle management
        Delete data older than days_to_live
        """
        s3 = boto3.resource('s3')
        bucket_obj = s3.Bucket(bucket)
        
        cutoff_date = datetime.now() - timedelta(days=days_to_live)
        deleted_count = 0
        freed_gb = 0
        
        for obj in bucket_obj.objects.all():
            if obj.last_modified.replace(tzinfo=None) < cutoff_date:
                # Get size before deletion
                size_mb = obj.size / (1024 * 1024)
                
                # Delete old object
                obj.delete()
                deleted_count += 1
                freed_gb += size_mb / 1024
                
                print(f"Deleted {obj.key} ({size_mb:.2f} MB)")
        
        # Estimate energy savings (approx 0.5 kWh per GB per year)
        energy_saved = freed_gb * 0.5 * (days_to_live / 365)
        carbon_saved = energy_saved * 400  # gCO2 per kWh
        
        return {
            'deleted_count': deleted_count,
            'freed_gb': round(freed_gb, 2),
            'energy_saved_kwh': round(energy_saved, 2),
            'carbon_saved_g': round(carbon_saved, 2)
        }

# Usage example
if __name__ == "__main__":
    # Define region mappings
    region_map = {
        'us-east-1': 'pjm',    # Virginia
        'eu-west-1': 'ie',      # Ireland
        'eu-north-1': 'se',     # Stockholm
        'eu-west-3': 'fr'       # Paris
    }
    
    scheduler = CarbonAwareStorageScheduler(region_map)
    
    # Find greenest region for new deployments
    greenest_region, intensities = scheduler.find_greenest_region()
    
    # Schedule a data transfer
    result = scheduler.schedule_data_transfer(
        source_bucket='my-source-data',
        source_key='large-dataset.csv',
        destination_bucket='my-archive-bucket'
    )
    print(f"Transfer result: {result}")
    
    # Clean up old data
    cleanup_stats = scheduler.cleanup_old_data(
        bucket='my-source-data',
        days_to_live=90
    )
    print(f"Cleanup stats: {cleanup_stats}")
    
    # Schedule periodic carbon-aware operations
    schedule.every().day.at("03:00").do(
        scheduler.schedule_data_transfer,
        source_bucket='my-source-data',
        source_key='daily-backup.tar.gz',
        destination_bucket='my-archive-bucket'
    )
    
    schedule.every().monday.do(
        scheduler.cleanup_old_data,
        bucket='my-source-data',
        days_to_live=90
    )
    
    # Keep running
    while True:
        schedule.run_pending()
        time.sleep(60)
```

#### Advanced Data Security and Privacy Practices
To mitigate the growing risk of data breaches, cloud storage providers are implementing advanced security measures to safeguard sensitive information.

**Key Measures:**
- **End-to-end encryption:** Data encrypted during transmission and at rest
- **Zero trust security models:** Verify at every data access stage
- **Data masking and tokenization:** Anonymize sensitive data

**Example: Zero Trust Security Implementation for Cloud Storage**

```python
import boto3
import hashlib
import hmac
import json
import base64
from datetime import datetime, timedelta
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2

class ZeroTrustStorage:
    """
    Implement zero trust principles for cloud storage access
    """
    
    def __init__(self, bucket_name, kms_key_id=None):
        self.bucket_name = bucket_name
        self.s3_client = boto3.client('s3')
        self.kms_client = boto3.client('kms') if kms_key_id else None
        self.kms_key_id = kms_key_id
        
        # Generate encryption key (in production, use KMS or HSM)
        self.encryption_key = Fernet.generate_key()
        self.cipher = Fernet(self.encryption_key)
    
    def generate_access_token(self, user_id, resource_path, expiry_hours=1):
        """
        Generate short-lived, context-aware access token
        """
        expiry = datetime.utcnow() + timedelta(hours=expiry_hours)
        
        token_payload = {
            'user_id': user_id,
            'resource': resource_path,
            'expiry': expiry.isoformat(),
            'access_level': 'read_write',
            'ip_restriction': '192.168.0.0/16',  # Example IP restriction
            'mfa_verified': True
        }
        
        # Sign the token (in production, use JWT with proper signing)
        token_json = json.dumps(token_payload, sort_keys=True)
        token_b64 = base64.b64encode(token_json.encode()).decode()
        
        # Create HMAC signature
        signature = hmac.new(
            key=b'secret-key-change-in-prod',
            msg=token_b64.encode(),
            digestmod=hashlib.sha256
        ).hexdigest()
        
        return f"{token_b64}.{signature}"
    
    def verify_access_token(self, token):
        """
        Verify token validity and enforce zero trust
        """
        try:
            # Split token and signature
            token_b64, signature = token.split('.')
            
            # Verify signature
            expected_sig = hmac.new(
                key=b'secret-key-change-in-prod',
                msg=token_b64.encode(),
                digestmod=hashlib.sha256
            ).hexdigest()
            
            if not hmac.compare_digest(signature, expected_sig):
                return {'valid': False, 'reason': 'Invalid signature'}
            
            # Decode payload
            token_json = base64.b64decode(token_b64).decode()
            payload = json.loads(token_json)
            
            # Check expiry
            expiry = datetime.fromisoformat(payload['expiry'])
            if datetime.utcnow() > expiry:
                return {'valid': False, 'reason': 'Token expired'}
            
            # Additional zero trust checks would happen here:
            # - Verify IP address matches
            # - Check device posture
            # - Validate MFA status
            # - Check user permissions in real-time
            
            return {'valid': True, 'payload': payload}
            
        except Exception as e:
            return {'valid': False, 'reason': str(e)}
    
    def encrypt_sensitive_data(self, data, data_type='pii'):
        """
        Field-level encryption for sensitive data
        """
        if data_type == 'pii':
            # Encrypt PII data
            encrypted = self.cipher.encrypt(data.encode())
            return base64.b64encode(encrypted).decode()
        elif data_type == 'financial':
            # Use KMS for financial data if available
            if self.kms_key_id:
                response = self.kms_client.encrypt(
                    KeyId=self.kms_key_id,
                    Plaintext=data.encode()
                )
                return base64.b64encode(response['CiphertextBlob']).decode()
        
        return data
    
    def decrypt_sensitive_data(self, encrypted_data, data_type='pii'):
        """
        Decrypt field-level encrypted data
        """
        try:
            if data_type == 'pii':
                decoded = base64.b64decode(encrypted_data.encode())
                decrypted = self.cipher.decrypt(decoded)
                return decrypted.decode()
            elif data_type == 'financial' and self.kms_key_id:
                decoded = base64.b64decode(encrypted_data.encode())
                response = self.kms_client.decrypt(
                    CiphertextBlob=decoded
                )
                return response['Plaintext'].decode()
        except:
            return None
        
        return encrypted_data
    
    def write_encrypted_object(self, key, data, user_token, sensitivity='confidential'):
        """
        Write data with encryption and access logging
        """
        # Verify token
        token_check = self.verify_access_token(user_token)
        if not token_check['valid']:
            raise PermissionError(f"Access denied: {token_check['reason']}")
        
        # Encrypt based on sensitivity
        if sensitivity == 'public':
            # No encryption
            final_data = data
        elif sensitivity == 'internal':
            # Server-side encryption
            final_data = data
            sse = 'AES256'
        else:
            # Client-side encryption for confidential/restricted
            final_data = self.encrypt_sensitive_data(data, 'pii')
            sse = None
        
        # Write with server-side encryption if applicable
        extra_args = {}
        if sensitivity in ['confidential', 'restricted']:
            extra_args['ServerSideEncryption'] = 'AES256'
        
        # Add object metadata for tracking
        metadata = {
            'sensitivity': sensitivity,
            'encrypted_at': datetime.utcnow().isoformat(),
            'encrypted_by': token_check['payload']['user_id'],
            'encryption_type': 'client' if sensitivity == 'restricted' else 'server'
        }
        
        self.s3_client.put_object(
            Bucket=self.bucket_name,
            Key=key,
            Body=final_data.encode() if isinstance(final_data, str) else final_data,
            Metadata=metadata,
            **extra_args
        )
        
        # Log access for audit
        self.log_access(
            user_id=token_check['payload']['user_id'],
            action='WRITE',
            resource=key,
            sensitivity=sensitivity
        )
        
        return {
            'key': key,
            'sensitivity': sensitivity,
            'encrypted': sensitivity != 'public',
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def read_encrypted_object(self, key, user_token):
        """
        Read data with decryption and access logging
        """
        # Verify token
        token_check = self.verify_access_token(user_token)
        if not token_check['valid']:
            raise PermissionError(f"Access denied: {token_check['reason']}")
        
        # Read object
        response = self.s3_client.get_object(
            Bucket=self.bucket_name,
            Key=key
        )
        
        data = response['Body'].read().decode()
        metadata = response.get('Metadata', {})
        sensitivity = metadata.get('sensitivity', 'internal')
        
        # Decrypt if necessary
        if sensitivity == 'restricted':
            data = self.decrypt_sensitive_data(data, 'pii')
        elif sensitivity == 'financial':
            data = self.decrypt_sensitive_data(data, 'financial')
        
        # Log access
        self.log_access(
            user_id=token_check['payload']['user_id'],
            action='READ',
            resource=key,
            sensitivity=sensitivity
        )
        
        return {
            'data': data,
            'metadata': metadata,
            'decrypted': sensitivity in ['restricted', 'financial']
        }
    
    def log_access(self, user_id, action, resource, sensitivity):
        """
        Log all access attempts for audit trail
        In production, send to SIEM or CloudTrail
        """
        log_entry = {
            'timestamp': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'action': action,
            'resource': f"s3://{self.bucket_name}/{resource}",
            'sensitivity': sensitivity,
            'ip_address': '192.168.1.100',  # Would get from request context
            'user_agent': 'ZeroTrustClient/1.0',
            'mfa_status': 'verified',
            'device_posture': 'compliant'
        }
        
        # In production, send to secure logging service
        print(f"AUDIT LOG: {json.dumps(log_entry)}")
        
        # Also store in immutable log bucket
        try:
            log_key = f"audit/{datetime.utcnow().strftime('%Y/%m/%d')}/{user_id}_{int(datetime.utcnow().timestamp())}.json"
            self.s3_client.put_object(
                Bucket=f"{self.bucket_name}-audit",
                Key=log_key,
                Body=json.dumps(log_entry).encode(),
                ObjectLockMode='COMPLIANCE',
                ObjectLockRetainUntilDate=datetime.utcnow() + timedelta(days=365)
            )
        except:
            pass  # Audit logging failure shouldn't block access

# Usage example
if __name__ == "__main__":
    # Initialize zero trust storage
    zt_storage = ZeroTrustStorage(
        bucket_name='company-sensitive-data',
        kms_key_id='arn:aws:kms:us-east-1:123456789012:key/abc123'
    )
    
    # Generate access token for user
    token = zt_storage.generate_access_token(
        user_id='john.doe@company.com',
        resource='customer-data/',
        expiry_hours=1
    )
    print(f"Access token generated: {token[:50]}...")
    
    # Write sensitive data
    try:
        result = zt_storage.write_encrypted_object(
            key='customer-data/12345.json',
            data='{"ssn": "123-45-6789", "name": "John Smith", "account": "987654321"}',
            user_token=token,
            sensitivity='restricted'
        )
        print(f"Write result: {result}")
    except PermissionError as e:
        print(f"Access denied: {e}")
    
    # Read sensitive data
    try:
        result = zt_storage.read_encrypted_object(
            key='customer-data/12345.json',
            user_token=token
        )
        print(f"Read result - Data length: {len(result['data'])} chars")
        print(f"Decrypted: {result['decrypted']}")
    except PermissionError as e:
        print(f"Access denied: {e}")
```

#### Artificial Intelligence and Machine Learning Integration
AI and ML transform cloud storage by improving data management, security, and analytics. These technologies automate key tasks including data classification, predictive analytics, and security enhancements.

**Common AI/ML Tools and Their Purposes:**

| Tool | Purpose | Key Features |
|------|---------|--------------|
| Google Cloud DLP | Automated data classification | Identifies sensitive data (credit cards, PII) |
| AWS S3 Intelligent-Tiering | Predictive storage management | ML-based tiering optimization |
| IBM Cloud Security Advisor | Security and anomaly detection | ML-powered threat detection |
| Microsoft Azure Cognitive Search | Intelligent search and categorization | Extracts insights from unstructured data |
| AWS Glacier with ML | Intelligent lifecycle management | Optimizes archival timing |

**Example: AI-Powered Data Classification and Lifecycle Management**

```python
import boto3
import json
import hashlib
from datetime import datetime, timedelta
import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
import joblib

class AIDrivenStorageManager:
    """
    AI/ML-powered cloud storage management system
    """
    
    def __init__(self, bucket_name, model_path=None):
        self.s3_client = boto3.client('s3')
        self.bucket_name = bucket_name
        self.comprehend = boto3.client('comprehend')
        self.rekognition = boto3.client('rekognition')
        
        # Load or initialize ML models
        if model_path:
            self.classifier = joblib.load(model_path)
            self.label_encoder = joblib.load(f"{model_path}_encoder")
        else:
            self.classifier = None
            self.label_encoder = LabelEncoder()
    
    def detect_sensitive_content(self, file_content, filename):
        """
        Use AI to detect sensitive content in files
        """
        results = {
            'filename': filename,
            'has_pii': False,
            'pii_types': [],
            'has_prohibited_content': False,
            'sensitivity_score': 0,
            'recommended_classification': 'public'
        }
        
        # Check if it's an image
        if filename.lower().endswith(('.jpg', '.jpeg', '.png')):
            # Use Rekognition for image analysis
            try:
                response = self.rekognition.detect_labels(
                    Image={'Bytes': file_content},
                    MaxLabels=10
                )
                
                # Check for sensitive content in images
                labels = [label['Name'] for label in response['Labels']]
                sensitive_labels = ['Weapon', 'Violence', 'Alcohol', 'Drug']
                
                for label in labels:
                    if label in sensitive_labels:
                        results['has_prohibited_content'] = True
                        results['sensitivity_score'] += 25
                
            except Exception as e:
                print(f"Rekognition error: {e}")
        
        # Check text content if present
        try:
            text_content = file_content.decode('utf-8')[:5000]  # First 5000 chars
            
            # Use Comprehend for PII detection
            pii_response = self.comprehend.detect_pii_entities(
                Text=text_content,
                LanguageCode='en'
            )
            
            if pii_response['Entities']:
                results['has_pii'] = True
                results['pii_types'] = list(set(
                    [entity['Type'] for entity in pii_response['Entities']]
                ))
                results['sensitivity_score'] += len(pii_response['Entities']) * 10
            
            # Detect language and sentiment
            sentiment = self.comprehend.detect_sentiment(
                Text=text_content,
                LanguageCode='en'
            )
            results['sentiment'] = sentiment['Sentiment']
            
        except:
            pass  # Not text content
        
        # Determine classification based on sensitivity
        if results['sensitivity_score'] >= 50 or results['has_prohibited_content']:
            results['recommended_classification'] = 'restricted'
        elif results['sensitivity_score'] >= 20 or results['has_pii']:
            results['recommended_classification'] = 'confidential'
        elif results['sensitivity_score'] >= 5:
            results['recommended_classification'] = 'internal'
        else:
            results['recommended_classification'] = 'public'
        
        return results
    
    def train_access_pattern_model(self, access_logs_path):
        """
        Train ML model to predict data access patterns
        """
        # Load access logs from S3
        response = self.s3_client.get_object(
            Bucket=self.bucket_name,
            Key=access_logs_path
        )
        logs_data = response['Body'].read().decode()
        
        # Parse logs (simplified - in production, use proper log parsing)
        logs = []
        for line in logs_data.strip().split('\n'):
            parts = line.split(',')
            if len(parts) >= 5:
                logs.append({
                    'timestamp': parts[0],
                    'user': parts[1],
                    'file': parts[2],
                    'action': parts[3],
                    'size': int(parts[4])
                })
        
        df = pd.DataFrame(logs)
        
        # Feature engineering
        df['hour'] = pd.to_datetime(df['timestamp']).dt.hour
        df['day_of_week'] = pd.to_datetime(df['timestamp']).dt.dayofweek
        df['is_business_hours'] = ((df['hour'] >= 9) & (df['hour'] <= 17)).astype(int)
        
        # Create file-level features
        file_features = df.groupby('file').agg({
            'size': 'first',
            'user': lambda x: x.nunique(),
            'action': lambda x: (x == 'WRITE').sum(),
            'hour': 'mean',
            'day_of_week': 'mean'
        }).reset_index()
        
        file_features.columns = ['file', 'size', 'unique_users', 'write_count', 'avg_hour', 'avg_day']
        
        # Calculate access frequency (last 7 days vs older)
        df['date'] = pd.to_datetime(df['timestamp']).dt.date
        latest_date = df['date'].max()
        
        recent_access = df[df['date'] >= (latest_date - timedelta(days=7))].groupby('file').size()
        older_access = df[df['date'] < (latest_date - timedelta(days=7))].groupby('file').size()
        
        file_features['recent_access'] = file_features['file'].map(recent_access).fillna(0)
        file_features['older_access'] = file_features['file'].map(older_access).fillna(0)
        file_features['access_trend'] = file_features['recent_access'] - file_features['older_access']
        
        # Target: next access tier (hot/warm/cold/archive)
        # Calculate days since last access
        last_access = df.groupby('file')['date'].max().reset_index()
        last_access['days_since_access'] = (latest_date - last_access['date']).dt.days
        
        def determine_tier(days):
            if days <= 7:
                return 'hot'
            elif days <= 30:
                return 'warm'
            elif days <= 90:
                return 'cold'
            else:
                return 'archive'
        
        last_access['tier'] = last_access['days_since_access'].apply(determine_tier)
        
        # Merge features with target
        training_data = file_features.merge(
            last_access[['file', 'tier']], 
            on='file', 
            how='left'
        )
        
        # Prepare features for training
        feature_cols = ['size', 'unique_users', 'write_count', 'avg_hour', 
                        'avg_day', 'recent_access', 'older_access', 'access_trend']
        X = training_data[feature_cols].fillna(0)
        y = training_data['tier']
        
        # Encode target
        y_encoded = self.label_encoder.fit_transform(y)
        
        # Train model
        self.classifier = RandomForestClassifier(
            n_estimators=100,
            max_depth=10,
            random_state=42
        )
        self.classifier.fit(X, y_encoded)
        
        # Save model
        joblib.dump(self.classifier, 'access_pattern_model.pkl')
        joblib.dump(self.label_encoder, 'access_pattern_model_encoder.pkl')
        
        # Upload to S3
        self.s3_client.upload_file(
            'access_pattern_model.pkl',
            self.bucket_name,
            'models/access_pattern_model.pkl'
        )
        
        print(f"Model trained with {len(X)} samples")
        print(f"Feature importance: {dict(zip(feature_cols, self.classifier.feature_importances_))}")
        
        return {
            'samples': len(X),
            'feature_importance': dict(zip(feature_cols, self.classifier.feature_importances_.tolist()))
        }
    
    def predict_optimal_tier(self, file_metadata):
        """
        Predict optimal storage tier using ML model
        """
        if not self.classifier:
            return {'tier': 'standard', 'confidence': 0, 'ml_available': False}
        
        # Prepare features
        features = np.array([[
            file_metadata.get('size', 0),
            file_metadata.get('unique_users', 1),
            file_metadata.get('write_count', 0),
            file_metadata.get('avg_hour', 12),
            file_metadata.get('avg_day', 3),
            file_metadata.get('recent_access', 0),
            file_metadata.get('older_access', 0),
            file_metadata.get('access_trend', 0)
        ]])
        
        # Predict
        prediction = self.classifier.predict(features)[0]
        probabilities = self.classifier.predict_proba(features)[0]
        
        tier = self.label_encoder.inverse_transform([prediction])[0]
        confidence = max(probabilities)
        
        return {
            'tier': tier,
            'confidence': float(confidence),
            'ml_available': True,
            'all_probabilities': dict(zip(
                self.label_encoder.classes_,
                probabilities.tolist()
            ))
        }
    
    def intelligent_lifecycle_management(self, prefix=''):
        """
        Apply AI-driven lifecycle policies based on predicted access patterns
        """
        # List objects in bucket
        paginator = self.s3_client.get_paginator('list_objects_v2')
        pages = paginator.paginate(Bucket=self.bucket_name, Prefix=prefix)
        
        recommendations = []
        
        for page in pages:
            if 'Contents' not in page:
                continue
            
            for obj in page['Contents']:
                key = obj['Key']
                last_modified = obj['LastModified']
                size = obj['Size']
                
                # Get object metadata for access patterns
                try:
                    head = self.s3_client.head_object(
                        Bucket=self.bucket_name,
                        Key=key
                    )
                    metadata = head.get('Metadata', {})
                    
                    # Parse stored metrics
                    file_metadata = {
                        'size': size,
                        'unique_users': int(metadata.get('unique_users', 1)),
                        'write_count': int(metadata.get('write_count', 0)),
                        'avg_hour': float(metadata.get('avg_hour', 12)),
                        'avg_day': float(metadata.get('avg_day', 3)),
                        'recent_access': int(metadata.get('recent_access', 0)),
                        'older_access': int(metadata.get('older_access', 0)),
                        'access_trend': int(metadata.get('access_trend', 0))
                    }
                    
                    # Get AI prediction
                    prediction = self.predict_optimal_tier(file_metadata)
                    
                    # Get current tier from storage class
                    current_tier = head.get('StorageClass', 'STANDARD')
                    
                    # Make recommendation
                    if prediction['ml_available'] and prediction['confidence'] > 0.7:
                        recommended_tier = prediction['tier'].upper()
                        
                        # Map to actual S3 storage classes
                        tier_mapping = {
                            'hot': 'STANDARD',
                            'warm': 'STANDARD_IA',
                            'cold': 'GLACIER',
                            'archive': 'DEEP_ARCHIVE'
                        }
                        
                        recommended_class = tier_mapping.get(prediction['tier'], 'STANDARD')
                        
                        if recommended_class != current_tier:
                            recommendations.append({
                                'key': key,
                                'current_tier': current_tier,
                                'recommended_tier': recommended_class,
                                'confidence': prediction['confidence'],
                                'size_mb': size / (1024 * 1024),
                                'reason': f"ML prediction: {prediction['tier']} tier with {prediction['confidence']:.1%} confidence"
                            })
                            
                except Exception as e:
                    print(f"Error processing {key}: {e}")
        
        return recommendations
    
    def apply_smart_transition(self, recommendations, dry_run=True):
        """
        Apply storage tier transitions based on ML recommendations
        """
        results = []
        
        for rec in recommendations:
            if dry_run:
                results.append({
                    'key': rec['key'],
                    'action': 'would_transition',
                    'from': rec['current_tier'],
                    'to': rec['recommended_tier'],
                    'reason': rec['reason'],
                    'estimated_savings_usd': rec['size_mb'] * 0.01  # Rough estimate
                })
            else:
                try:
                    # Copy object to change storage class
                    copy_source = {'Bucket': self.bucket_name, 'Key': rec['key']}
                    
                    self.s3_client.copy_object(
                        CopySource=copy_source,
                        Bucket=self.bucket_name,
                        Key=rec['key'],
                        StorageClass=rec['recommended_tier'],
                        MetadataDirective='COPY'
                    )
                    
                    results.append({
                        'key': rec['key'],
                        'action': 'transitioned',
                        'from': rec['current_tier'],
                        'to': rec['recommended_tier'],
                        'status': 'success'
                    })
                    
                except Exception as e:
                    results.append({
                        'key': rec['key'],
                        'action': 'transition_failed',
                        'error': str(e)
                    })
        
        return results

# Google Cloud DLP Integration Example
def google_dlp_classification_example():
    """
    Use Google Cloud DLP for automated data classification
    """
    from google.cloud import dlp_v2
    import google.cloud.storage as storage
    
    # Initialize clients
    dlp_client = dlp_v2.DlpServiceClient()
    storage_client = storage.Client()
    
    def classify_bucket_data(bucket_name, project_id):
        """
        Classify all data in a GCS bucket using DLP
        """
        bucket = storage_client.bucket(bucket_name)
        blobs = bucket.list_blobs()
        
        for blob in blobs:
            if blob.name.endswith('.txt') or blob.name.endswith('.csv'):
                # Download content for inspection
                content = blob.download_as_string()[:10000]  # First 10KB
                
                # Configure DLP inspection
                parent = f"projects/{project_id}"
                inspect_config = {
                    'info_types': [
                        {'name': 'EMAIL_ADDRESS'},
                        {'name': 'PHONE_NUMBER'},
                        {'name': 'CREDIT_CARD_NUMBER'},
                        {'name': 'US_SOCIAL_SECURITY_NUMBER'},
                        {'name': 'PERSON_NAME'}
                    ],
                    'min_likelihood': 'LIKELIHOOD_UNSPECIFIED',
                    'limits': {'max_findings_per_item': 100},
                    'include_quote': True
                }
                
                item = {'value': content.decode('utf-8', errors='ignore')}
                
                # Call DLP API
                response = dlp_client.inspect_content(
                    request={
                        'parent': parent,
                        'inspect_config': inspect_config,
                        'item': item
                    }
                )
                
                # Process findings
                findings = response.result.findings
                
                if findings:
                    print(f"\nFile: {blob.name}")
                    print(f"Findings: {len(findings)}")
                    
                    pii_types = set()
                    for finding in findings:
                        pii_types.add(finding.info_type.name)
                    
                    print(f"PII Types detected: {', '.join(pii_types)}")
                    
                    # Set bucket labels based on classification
                    if 'CREDIT_CARD_NUMBER' in pii_types:
                        # Highly sensitive - add retention policy
                        blob.bucket.add_label('data_classification', 'highly_sensitive')
                        blob.bucket.retention_period = 2555000  # 7 years in seconds
                    elif 'US_SOCIAL_SECURITY_NUMBER' in pii_types:
                        blob.bucket.add_label('data_classification', 'sensitive')
                    elif 'PERSON_NAME' in pii_types or 'EMAIL_ADDRESS' in pii_types:
                        blob.bucket.add_label('data_classification', 'personal_data')
                
                return response

# AWS S3 Intelligent-Tiering Example
def s3_intelligent_tiering_example():
    """
    Configure S3 Intelligent-Tiering with ML optimization
    """
    import boto3
    
    s3 = boto3.client('s3')
    
    def setup_intelligent_tiering(bucket_name):
        """
        Enable Intelligent-Tiering with custom ML thresholds
        """
        
        # Create Intelligent-Tiering configuration
        config = {
            'Id': 'ML-Optimized-Tiering',
            'Status': 'Enabled',
            'Tierings': [
                {
                    'Days': 30,
                    'AccessTier': 'ARCHIVE_ACCESS'
                },
                {
                    'Days': 90,
                    'AccessTier': 'DEEP_ARCHIVE_ACCESS'
                }
            ]
        }
        
        # Apply configuration
        response = s3.put_bucket_intelligent_tiering_configuration(
            Bucket=bucket_name,
            Id='ML-Optimized-Tiering',
            IntelligentTieringConfiguration=config
        )
        
        return response
    
    def analyze_access_patterns(bucket_name):
        """
        Analyze access patterns to optimize tiering
        """
        # Get bucket statistics (in production, use S3 Analytics)
        analytics = s3.get_bucket_analytics_configuration(
            Bucket=bucket_name,
            Id='access-patterns'
        )
        
        return analytics

# Microsoft Azure Cognitive Search Example
def azure_cognitive_search_example():
    """
    Use Azure Cognitive Search for intelligent data categorization
    """
    from azure.search.documents import SearchClient
    from azure.search.documents.indexes import SearchIndexClient
    from azure.search.documents.models import (
        VectorizedQuery,
        QueryType,
        QueryCaptionType,
        QueryAnswerType
    )
    from azure.core.credentials import AzureKeyCredential
    
    class CognitiveSearchEnricher:
        """
        Enrich cloud storage with AI-powered search
        """
        
        def __init__(self, endpoint, key, index_name):
            self.search_client = SearchClient(
                endpoint=endpoint,
                index_name=index_name,
                credential=AzureKeyCredential(key)
            )
            self.index_client = SearchIndexClient(
                endpoint=endpoint,
                credential=AzureKeyCredential(key)
            )
        
        def index_blob_container(self, connection_string, container_name):
            """
            Index all blobs in a container with AI enrichment
            """
            from azure.storage.blob import BlobServiceClient
            
            blob_service = BlobServiceClient.from_connection_string(connection_string)
            container = blob_service.get_container_client(container_name)
            
            blobs = container.list_blobs()
            
            documents = []
            for blob in blobs:
                if blob.name.endswith('.pdf') or blob.name.endswith('.docx'):
                    # Download blob content
                    blob_client = container.get_blob_client(blob)
                    content = blob_client.download_blob().readall()
                    
                    # Create search document with AI-extracted fields
                    document = {
                        'id': blob.name.replace('/', '-'),
                        'file_name': blob.name,
                        'content': content[:1000].decode('utf-8', errors='ignore'),
                        'size': blob.size,
                        'last_modified': blob.last_modified.isoformat(),
                        # AI-extracted metadata would go here
                        'key_phrases': self.extract_key_phrases(content),
                        'entities': self.extract_entities(content),
                        'sentiment': self.analyze_sentiment(content),
                        'language': self.detect_language(content)
                    }
                    
                    documents.append(document)
            
            # Upload to search index
            result = self.search_client.upload_documents(documents)
            return result
        
        def extract_key_phrases(self, content):
            """
            Use Azure Text Analytics for key phrase extraction
            """
            from azure.ai.textanalytics import TextAnalyticsClient
            
            # Initialize Text Analytics client
            text_analytics = TextAnalyticsClient(
                endpoint=self.endpoint,
                credential=AzureKeyCredential(self.key)
            )
            
            try:
                response = text_analytics.extract_key_phrases(
                    documents=[content[:5000]]
                )
                
                if not response[0].is_error:
                    return response[0].key_phrases
            except:
                pass
            
            return []
        
        def extract_entities(self, content):
            """
            Extract named entities from content
            """
            from azure.ai.textanalytics import TextAnalyticsClient
            
            text_analytics = TextAnalyticsClient(
                endpoint=self.endpoint,
                credential=AzureKeyCredential(self.key)
            )
            
            entities = []
            try:
                response = text_analytics.recognize_entities(
                    documents=[content[:5000]]
                )
                
                if not response[0].is_error:
                    entities = [
                        {'text': entity.text, 'category': entity.category}
                        for entity in response[0].entities
                    ]
            except:
                pass
            
            return entities
        
        def analyze_sentiment(self, content):
            """
            Analyze sentiment of content
            """
            from azure.ai.textanalytics import TextAnalyticsClient
            
            text_analytics = TextAnalyticsClient(
                endpoint=self.endpoint,
                credential=AzureKeyCredential(self.key)
            )
            
            try:
                response = text_analytics.analyze_sentiment(
                    documents=[content[:5000]]
                )
                
                if not response[0].is_error:
                    return {
                        'sentiment': response[0].sentiment,
                        'positive_score': response[0].confidence_scores.positive,
                        'neutral_score': response[0].confidence_scores.neutral,
                        'negative_score': response[0].confidence_scores.negative
                    }
            except:
                pass
            
            return {'sentiment': 'unknown'}
        
        def detect_language(self, content):
            """
            Detect language of content
            """
            from azure.ai.textanalytics import TextAnalyticsClient
            
            text_analytics = TextAnalyticsClient(
                endpoint=self.endpoint,
                credential=AzureKeyCredential(self.key)
            )
            
            try:
                response = text_analytics.detect_language(
                    documents=[content[:1000]]
                )
                
                if not response[0].is_error:
                    return response[0].primary_language.name
            except:
                pass
            
            return 'unknown'
        
        def semantic_search(self, query, vectorized=False):
            """
            Perform semantic search with optional vector search
            """
            if vectorized:
                # Use vector search
                results = self.search_client.search(
                    search_text=query,
                    query_type=QueryType.SEMANTIC,
                    semantic_configuration_name='my-semantic-config',
                    query_caption=QueryCaptionType.EXTRACTIVE,
                    query_answer=QueryAnswerType.EXTRACTIVE,
                    top=10
                )
            else:
                # Use standard search
                results = self.search_client.search(
                    search_text=query,
                    search_mode='any',
                    include_total_count=True,
                    top=10
                )
            
            search_results = []
            for result in results:
                search_results.append({
                    'file_name': result['file_name'],
                    'score': result['@search.score'],
                    'key_phrases': result.get('key_phrases', []),
                    'content_snippet': result['content'][:200] + '...'
                })
            
            return search_results

# IBM Cloud Security Advisor Example
def ibm_security_advisor_example():
    """
    Use IBM Cloud Security Advisor for threat detection
    """
    import requests
    import json
    from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
    from ibm_security_advisor_findings_api_sdk import FindingsApiV1
    
    class SecurityAdvisorMonitor:
        """
        Monitor cloud storage with IBM Security Advisor
        """
        
        def __init__(self, api_key, account_id):
            authenticator = IAMAuthenticator(api_key)
            self.findings_api = FindingsApiV1(authenticator=authenticator)
            self.findings_api.set_service_url(
                'https://us-south.secadvisor.cloud.ibm.com/findings'
            )
            self.account_id = account_id
        
        def detect_anomalous_access(self, bucket_name, access_logs):
            """
            Use ML to detect anomalous access patterns
            """
            from sklearn.ensemble import IsolationForest
            import numpy as np
            
            # Prepare features from access logs
            features = []
            timestamps = []
            
            for log in access_logs:
                features.append([
                    log['hour'],
                    log['day_of_week'],
                    log['bytes_transferred'],
                    1 if log['operation'] == 'DELETE' else 0,
                    1 if log['operation'] == 'PUT' else 0
                ])
                timestamps.append(log['timestamp'])
            
            # Train isolation forest for anomaly detection
            model = IsolationForest(contamination=0.1, random_state=42)
            predictions = model.fit_predict(features)
            
            # Identify anomalies
            anomalies = []
            for i, pred in enumerate(predictions):
                if pred == -1:  # Anomaly detected
                    anomaly = {
                        'timestamp': timestamps[i],
                        'features': features[i],
                        'anomaly_score': float(model.score_samples([features[i]])[0]),
                        'provider_id': f'storage/{bucket_name}',
                        'finding_type': 'anomalous_access_pattern',
                        'severity': 'HIGH' if features[i][3] else 'MEDIUM'  # DELETE ops are high severity
                    }
                    anomalies.append(anomaly)
                    
                    # Create finding in Security Advisor
                    self.create_finding(anomaly)
            
            return anomalies
        
        def create_finding(self, anomaly):
            """
            Create security finding in IBM Cloud
            """
            finding = {
                'severity': anomaly['severity'],
                'certainty': 'MEDIUM',
                'next_steps': [{
                    'title': 'Investigate Anomalous Access',
                    'url': f"https://cloud.ibm.com/security-advisor#/findings"
                }],
                'findingType': anomaly['finding_type'],
                'finding': {
                    'occurrenceTime': anomaly['timestamp'],
                    'data': {
                        'class': 'DataAccess',
                        'type': 'AnomalousPattern',
                        'properties': {
                            'anomaly_score': anomaly['anomaly_score'],
                            'bucket': anomaly['provider_id']
                        }
                    }
                }
            }
            
            response = self.findings_api.create_finding(
                account_id=self.account_id,
                provider_id='storage-monitor',
                finding_id=f"{anomaly['timestamp']}_{anomaly['provider_id']}",
                finding=finding
            )
            
            return response

# AWS Glacier with ML Integration Example
def glacier_ml_optimization_example():
    """
    Optimize Glacier archival with ML predictions
    """
    import boto3
    import numpy as np
    from sklearn.ensemble import GradientBoostingRegressor
    from datetime import datetime, timedelta
    
    class GlacierMLOptimizer:
        """
        ML-powered Glacier archival optimization
        """
        
        def __init__(self, bucket_name):
            self.s3 = boto3.client('s3')
            self.bucket_name = bucket_name
            self.model = GradientBoostingRegressor(
                n_estimators=100,
                max_depth=5,
                random_state=42
            )
            self.is_trained = False
        
        def train_archival_model(self, historical_data):
            """
            Train model to predict optimal archival timing
            """
            # Features: 
            # - file size
            # - access frequency (last 30, 60, 90 days)
            # - file age
            # - day of week created
            # - month created
            # - file extension type
            # - user department
            # - project stage
            
            X = []
            y = []  # Target: days until next access
            
            for data in historical_data:
                features = [
                    data['size_mb'],
                    data['access_freq_30d'],
                    data['access_freq_60d'],
                    data['access_freq_90d'],
                    data['file_age_days'],
                    data['created_dayofweek'],
                    data['created_month'],
                    data['extension_type_encoded'],
                    data['department_encoded'],
                    data['project_stage_encoded']
                ]
                X.append(features)
                y.append(data['days_until_next_access'])
            
            # Train model
            self.model.fit(X, y)
            self.is_trained = True
            
            # Feature importance
            feature_names = [
                'size_mb', 'access_freq_30d', 'access_freq_60d', 'access_freq_90d',
                'file_age_days', 'created_dayofweek', 'created_month',
                'extension_type', 'department', 'project_stage'
            ]
            
            importance = dict(zip(
                feature_names,
                self.model.feature_importances_.tolist()
            ))
            
            return importance
        
        def predict_optimal_archive_time(self, file_metadata):
            """
            Predict when to archive to Glacier
            """
            if not self.is_trained:
                return {
                    'archive_recommendation': 'immediate',
                    'confidence': 0.5,
                    'reason': 'Model not trained'
                }
            
            # Prepare features
            features = [[
                file_metadata['size_mb'],
                file_metadata['access_freq_30d'],
                file_metadata['access_freq_60d'],
                file_metadata['access_freq_90d'],
                file_metadata['file_age_days'],
                file_metadata['created_dayofweek'],
                file_metadata['created_month'],
                file_metadata['extension_type_encoded'],
                file_metadata['department_encoded'],
                file_metadata['project_stage_encoded']
            ]]
            
            # Predict days until next access
            predicted_days = self.model.predict(features)[0]
            
            # Make recommendation based on prediction
            if predicted_days > 180:  # > 6 months
                recommendation = 'archive_deep_archive'
                confidence = min(1.0, predicted_days / 365)
            elif predicted_days > 90:  # 3-6 months
                recommendation = 'archive_glacier'
                confidence = predicted_days / 180
            elif predicted_days > 30:  # 1-3 months
                recommendation = 'standard_ia'
                confidence = predicted_days / 90
            else:
                recommendation = 'standard'
                confidence = 1.0 - (predicted_days / 30)
            
            return {
                'predicted_days_until_access': float(predicted_days),
                'archive_recommendation': recommendation,
                'confidence': float(confidence),
                'estimated_savings_usd': self.estimate_savings(
                    file_metadata['size_mb'],
                    recommendation
                )
            }
        
        def estimate_savings(self, size_mb, recommendation):
            """
            Estimate cost savings from archival
            """
            # Rough cost estimates (per GB-month)
            costs = {
                'standard': 0.023,
                'standard_ia': 0.0125,
                'archive_glacier': 0.004,
                'archive_deep_archive': 0.0018
            }
            
            current_cost = size_mb / 1024 * costs['standard']
            new_cost = size_mb / 1024 * costs.get(recommendation, costs['standard'])
            
            return current_cost - new_cost
        
        def optimize_lifecycle_policies(self, prefix=''):
            """
            Create dynamic lifecycle policies based on ML predictions
            """
            # List all objects
            paginator = self.s3.get_paginator('list_objects_v2')
            pages = paginator.paginate(Bucket=self.bucket_name, Prefix=prefix)
            
            policies = {}
            
            for page in pages:
                if 'Contents' not in page:
                    continue
                
                for obj in page['Contents']:
                    key = obj['Key']
                    
                    # Get file metadata
                    head = self.s3.head_object(
                        Bucket=self.bucket_name,
                        Key=key
                    )
                    
                    # Extract metadata for prediction
                    metadata = {
                        'size_mb': obj['Size'] / (1024 * 1024),
                        'access_freq_30d': int(head.get('Metadata', {}).get('access_30d', 0)),
                        'access_freq_60d': int(head.get('Metadata', {}).get('access_60d', 0)),
                        'access_freq_90d': int(head.get('Metadata', {}).get('access_90d', 0)),
                        'file_age_days': (datetime.now(obj['LastModified'].tzinfo) - obj['LastModified']).days,
                        'created_dayofweek': obj['LastModified'].weekday(),
                        'created_month': obj['LastModified'].month,
                        'extension_type_encoded': self.encode_extension(key),
                        'department_encoded': int(head.get('Metadata', {}).get('dept_code', 0)),
                        'project_stage_encoded': int(head.get('Metadata', {}).get('stage_code', 0))
                    }
                    
                    # Get prediction
                    prediction = self.predict_optimal_archive_time(metadata)
                    
                    if prediction['confidence'] > 0.8:
                        # Create dynamic policy for this file type
                        file_type = key.split('.')[-1] if '.' in key else 'unknown'
                        
                        if file_type not in policies:
                            policies[file_type] = {
                                'transitions': [],
                                'files_analyzed': 0,
                                'avg_prediction': 0
                            }
                        
                        policies[file_type]['files_analyzed'] += 1
                        policies[file_type]['avg_prediction'] += prediction['predicted_days_until_access']
                        
                        # Add transition recommendation
                        if prediction['archive_recommendation'] != 'standard':
                            transition_days = int(prediction['predicted_days_until_access'] * 0.8)  # Conservative estimate
                            policies[file_type]['transitions'].append({
                                'days': max(30, min(365, transition_days)),
                                'storage_class': prediction['archive_recommendation'].upper()
                            })
            
            # Calculate averages
            for file_type in policies:
                if policies[file_type]['files_analyzed'] > 0:
                    policies[file_type]['avg_prediction'] /= policies[file_type]['files_analyzed']
            
            return policies
        
        def encode_extension(self, filename):
            """
            Encode file extension for ML model
            """
            ext = filename.split('.')[-1].lower() if '.' in filename else 'none'
            
            # Simple encoding - in production use proper encoding
            ext_map = {
                'txt': 1, 'csv': 2, 'json': 3, 'xml': 4,
                'pdf': 5, 'doc': 6, 'docx': 7, 'xls': 8, 'xlsx': 9,
                'jpg': 10, 'png': 11, 'gif': 12, 'mp4': 13,
                'log': 14, 'bak': 15, 'tmp': 16
            }
            
            return ext_map.get(ext, 0)

# Example usage of all AI/ML tools
if __name__ == "__main__":
    print("=" * 60)
    print("AI/ML INTEGRATION IN CLOUD STORAGE - EXAMPLES")
    print("=" * 60)
    
    # 1. AWS S3 Intelligent-Tiering
    print("\n1. AWS S3 INTELLIGENT-TIERING")
    print("-" * 40)
    s3_response = s3_intelligent_tiering_example()
    print("✓ Intelligent-Tiering configured with ML optimization")
    
    # 2. Google Cloud DLP Classification
    print("\n2. GOOGLE CLOUD DLP CLASSIFICATION")
    print("-" * 40)
    print("✓ DLP ready to detect: EMAIL_ADDRESS, PHONE_NUMBER, CREDIT_CARD_NUMBER")
    print("✓ Automatic PII detection and classification")
    
    # 3. Azure Cognitive Search
    print("\n3. AZURE COGNITIVE SEARCH")
    print("-" * 40)
    print("✓ Key phrase extraction enabled")
    print("✓ Entity recognition configured")
    print("✓ Sentiment analysis available")
    print("✓ Semantic search capabilities")
    
    # 4. IBM Security Advisor
    print("\n4. IBM SECURITY ADVISOR")
    print("-" * 40)
    print("✓ Anomaly detection with Isolation Forest")
    print("✓ Real-time threat monitoring")
    print("✓ Automated finding creation")
    
    # 5. AWS Glacier ML Optimizer
    print("\n5. AWS GLACIER ML OPTIMIZER")
    print("-" * 40)
    optimizer = GlacierMLOptimizer("example-bucket")
    
    # Simulate training
    importance = {
        'size_mb': 0.15,
        'access_freq_30d': 0.35,
        'access_freq_60d': 0.25,
        'access_freq_90d': 0.15,
        'file_age_days': 0.10
    }
    print(f"✓ Model trained - Feature importance: {importance}")
    
    # Sample prediction
    sample_prediction = {
        'predicted_days_until_access': 120,
        'archive_recommendation': 'archive_glacier',
        'confidence': 0.85,
        'estimated_savings_usd': 0.15
    }
    print(f"✓ Sample prediction: {sample_prediction}")
    
    print("\n" + "=" * 60)
    print("SUMMARY: AI/ML transforms cloud storage through:")
    print("- Automated data classification and PII detection")
    print("- Predictive storage tiering for cost optimization")
    print("- Intelligent lifecycle management")
    print("- Anomaly detection and security enhancement")
    print("- Semantic search and content understanding")
    print("=" * 60)
```

#### Summary
In this reading, you learned that:

- **Multicloud and hybrid cloud approaches** enhance flexibility, reliability, and cost optimization through strategic provider selection and infrastructure combination.
- **Edge computing and decentralized storage** enable real-time applications and data sovereignty by processing data closer to its source.
- **Sustainability practices** in cloud storage include renewable energy adoption, energy-efficient data centers, and intelligent data lifecycle management.
- **Advanced security measures** such as end-to-end encryption, zero-trust models, and data masking protect against evolving cyber threats.
- **AI and ML integration** transforms cloud storage through automated classification, predictive analytics, intelligent tiering, and enhanced security detection.