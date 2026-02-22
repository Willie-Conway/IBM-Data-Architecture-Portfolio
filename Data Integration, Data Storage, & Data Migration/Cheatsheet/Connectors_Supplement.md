# Connectors Supplement

![AWS Glue](<AWS Glue.png>)


## AWS Glue Connector for MongoDB

The AWS Glue Connector for MongoDB allows you to extract data from MongoDB databases and load it into AWS Glue Data Catalog. This connector supports both MongoDB Atlas and self-managed MongoDB instances.

### Prerequisites

- AWS Glue version 3.0 or later
- MongoDB database with read access
- AWS IAM role with permissions to access MongoDB and AWS Glue

### Configuration

1. **Create a MongoDB Connection in AWS Glue**:
   - Navigate to the AWS Glue console.
   - Go to the "Connections" section and click "Add connection".
   - Select "MongoDB" as the connection type.
   - Provide the connection details:
     - Connection name
     - MongoDB URI (e.g., `mongodb://username:password@host:port/database`)
     - Authentication method (if required)
   - Save the connection.

2. **Create a Crawler**:
   - Go to the "Crawlers" section and click "Add crawler".
   - Provide a name for the crawler.
   - Select the IAM role with the necessary permissions.
   - Choose the data store as "

## AWS Glue Code Example

This example shows an AWS Glue PySpark script that processes company data from CSV to Parquet format .

```python
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.functions import col, current_date, when
from pyspark.sql.types import IntegerType, DoubleType

# Initialize Glue context and job
args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Extract: Read CSV from S3
source_path = "s3://mybucket3s2/dados/originais/dados_empresas.csv"
source_df = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [source_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","}
)

# Convert DynamicFrame to DataFrame for transformations
df = source_df.toDF()

# Transform: Data type conversion and column additions
df_transformed = df \
    .withColumn("valor", col("valor").cast(DoubleType())) \
    .withColumn("data_int", current_date().cast(IntegerType())) \
    .withColumn("valor_com_imposto", col("valor") * 1.1) \
    .withColumn("categoria_nivel", 
                when(col("valor") > 1000, "ALTA")
                .when(col("valor") > 500, "MEDIA")
                .otherwise("BAIXA"))

# Load: Write transformed data as Parquet to S3
output_path = "s3://mybucket3s2/dados/processados/empresas_processed"
df_transformed.write \
    .mode("overwrite") \
    .partitionBy("categoria_nivel") \
    .parquet(output_path)

# Log completion
print(f"Successfully processed {df_transformed.count()} records")
print(f"Data written to {output_path}")

job.commit()
```

**Key AWS Glue features demonstrated** :
- **DynamicFrame API**: Specialized AWS Glue DataFrame with ETL optimizations
- **S3 integration**: Direct read/write to S3 buckets
- **Schema inference**: Automatic header detection from CSV
- **Partitioning**: Data written with partitioning by category level

![Google Cloud Dataflow](<Google Dataflow.png>)

## Google Cloud Dataflow Connector for MongoDB

The Google Cloud Dataflow connector for MongoDB allows you to read and write data between MongoDB and Google Cloud Dataflow pipelines. This connector is useful for scenarios where you need to integrate MongoDB data with other Google Cloud services or perform complex transformations on MongoDB data using Dataflow's distributed processing capabilities.

### Key Features: 

- **Read from MongoDB**: Extract data from MongoDB collections
- **Write to MongoDB**: Load transformed data back to MongoDB
- **Schema inference**: Automatic detection of MongoDB document structure
- **Batch and streaming**: Support for both batch and streaming pipelines
- **Fault tolerance**: Built-in recovery mechanisms for pipeline failures
- **Scalability**: Automatic scaling of Dataflow workers based on data volume
  
### Use Cases:
- Real-time data processing from MongoDB
- Data migration between MongoDB and other Google Cloud services
- Complex ETL jobs requiring Dataflow's distributed processing capabilities
  

## Google Cloud Dataflow Code Example

This example demonstrates a streaming pipeline using Apache Beam (Python) that reads from Pub/Sub Lite and writes to Cloud Storage .

```python
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions, GoogleCloudOptions
import argparse
import re
from datetime import datetime

def run_pipeline():
    # Parse command-line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('--subscription', required=True, 
                       help='Pub/Sub Lite subscription ID')
    parser.add_argument('--output', required=True,
                       help='GCS output path')
    parser.add_argument('--window_size', type=int, default=1,
                       help='Window size in minutes')
    
    known_args, pipeline_args = parser.parse_known_args()
    
    # Configure pipeline options
    pipeline_options = PipelineOptions(pipeline_args)
    google_cloud_options = pipeline_options.view_as(GoogleCloudOptions)
    
    # Define the pipeline
    with beam.Pipeline(options=pipeline_options) as p:
        # Read from Pub/Sub Lite subscription
        messages = (
            p
            | "Read from Pub/Sub Lite" >> 
                beam.io.ReadFromPubSub(
                    subscription=known_args.subscription,
                    with_attributes=False
                )
        )
        
        # Parse JSON messages and transform
        transformed = (
            messages
            | "Decode bytes" >> beam.Map(lambda x: x.decode('utf-8'))
            | "Parse JSON" >> beam.Map(json_parser)
            | "Add processing timestamp" >> 
                beam.Map(lambda x: {**x, 'processing_time': str(datetime.utcnow())})
        )
        
        # Apply windowing for streaming aggregation
        windowed_data = (
            transformed
            | "Fixed windows" >> 
                beam.WindowInto(beam.window.FixedWindows(60 * known_args.window_size))
            | "Count by type" >> 
                beam.combiners.Count.PerKey(lambda x: x.get('event_type', 'unknown'))
        )
        
        # Write results to GCS
        (
            windowed_data
            | "Format output" >> beam.Map(format_output)
            | "Write to GCS" >> 
                beam.io.WriteToText(
                    known_args.output,
                    file_name_suffix='.json',
                    num_shards=1,
                    shard_name_template='-SSSSS-of-NNNNN'
                )
        )

def json_parser(message):
    """Simple JSON parser for demonstration"""
    import json
    try:
        return json.loads(message)
    except:
        return {'event_type': 'invalid', 'raw': message}

def format_output(element):
    """Format (key, count) pairs for output"""
    import json
    return json.dumps({
        'event_type': element[0],
        'count': element[1],
        'window_end': str(datetime.utcnow())
    })

if __name__ == '__main__':
    run_pipeline()
```

**Key Dataflow features demonstrated** :
- **Unified streaming/batch**: Same code works for both processing modes
- **Windowing**: Fixed-time windows for aggregating streaming data
- **Pub/Sub integration**: Native connector for Google's messaging service
- **Auto-scaling**: Pipeline automatically scales based on data volume


![IBM InfoSphere DataStage](<IBM InfoSphere DataStage.png>)

# IBM InfoSphere DataStage
IBM InfoSphere DataStage is a data integration tool that enables organizations to move, transform, and manage data across various systems. It provides a visual environment for designing data pipelines, ensuring efficient and reliable data processing.

The IBM InfoSphere DataStage is a powerful data integration tool that provides a visual environment for designing and executing data pipelines. It supports various connectors and transformations, making it suitable for complex data integration tasks.


## IBM InfoSphere DataStage Example

DataStage uses a graphical job design interface, but here's a representation of a typical job configuration :

```dsx
# IBM InfoSphere DataStage Job Configuration
# Job: CleanCustomerData (Parallel Job)

JOB 'CleanCustomerData'
  DESCRIPTION "Customer data ingestion with validation and standardization"
  VERSION "1.0"
  
  # SOURCE STAGE: Sequential File Input
  STAGE 'Cust_CSV_Input' TYPE 'SequentialFileStage'
    PROPERTIES
      FilePattern = "/data/input/customers/*.csv"
      Format = "Delimited"
      Delimiter = ","
      HeaderLines = 1
      Columns = (
        'cust_id' : SQL_TYPE_INTEGER,
        'name' : SQL_TYPE_VARCHAR(100),
        'email' : SQL_TYPE_VARCHAR(255),
        'reg_date' : SQL_TYPE_DATE,
        'country' : SQL_TYPE_VARCHAR(50)
      )
    OUTPUT 'link_cust_raw'
      COLUMNS = ('cust_id', 'name', 'email', 'reg_date', 'country')
  END
  
  # TRANSFORMATION STAGE: Filter invalid emails
  STAGE 'ValidateEmail_Filter' TYPE 'FilterStage'
    PROPERTIES
      Constraint = "RegexMatch(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')"
    INPUT 'link_cust_raw' FROM 'Cust_CSV_Input'
    OUTPUT 'link_valid' WHEN TRUE
      COLUMNS = ALL
    OUTPUT 'link_reject' WHEN FALSE
      COLUMNS = ALL
  END
  
  # TRANSFORMATION STAGE: Standardize name format
  STAGE 'StandardizeName_Transformer' TYPE 'TransformerStage'
    PROPERTIES
      # Field derivations
      full_name = "UCase(Trim(name))"
      country_code = 
        "CASE country 
           WHEN 'United States' THEN 'US'
           WHEN 'Canada' THEN 'CA'
           WHEN 'United Kingdom' THEN 'UK'
           ELSE 'OT'
         END"
      load_timestamp = "CurrentTimestamp()"
    INPUT 'link_valid' FROM 'ValidateEmail_Filter'
    OUTPUT 'link_standardized'
      COLUMNS = ('cust_id', 'full_name', 'email', 'reg_date', 'country_code', 'load_timestamp')
  END
  
  # TARGET STAGE: Valid records to database
  STAGE 'Valid_Output' TYPE 'OracleConnectorStage'
    PROPERTIES
      SQLConnection = "Oracle_DW_Connection"
      TableName = "DW.CUSTOMER_DIM"
      LoadAction = "Insert"
      CommitInterval = 1000
    INPUT 'link_standardized' FROM 'StandardizeName_Transformer'
  END
  
  # TARGET STAGE: Invalid records to reject file
  STAGE 'Reject_Log' TYPE 'SequentialFileStage'
    PROPERTIES
      FilePath = "/data/rejects/email_invalid_@DATE.csv"
      Format = "Delimited"
      Delimiter = "|"
      WriteMode = "Append"
    INPUT 'link_reject' FROM 'ValidateEmail_Filter'
  END
END JOB
```

**Key DataStage features demonstrated** :
- **Parallel processing**: Native parallel execution for large datasets
- **Rich transformations**: Built-in functions like `RegexMatch`, `UCase`, `Trim`
- **Conditional routing**: Filter stage with true/false output paths
- **Enterprise connectivity**: Direct Oracle database integration
- **Error handling**: Separate error path for invalid records

## Comparison Summary

| Feature | AWS Glue | Google Dataflow | IBM InfoSphere |
|---------|----------|-----------------|----------------|
| **Code approach** | PySpark/Scala scripts | Apache Beam (Java/Python/Go) | Graphical job design + scripting |
| **Processing model** | Batch-focused (streaming available) | Unified batch/streaming | Batch-focused with real-time options |
| **Key strength** | Serverless, AWS integration | Real-time, auto-scaling | Enterprise governance, complex transformations |
| **Language** | Python (PySpark), Scala | Java, Python, Go | Visual + SQL + shell scripts |

Each example reflects the tool's primary use case: AWS Glue for serverless batch ETL , Dataflow for real-time streaming , and DataStage for complex enterprise data integration .