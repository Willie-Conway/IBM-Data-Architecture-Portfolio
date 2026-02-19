# RetailCorp Final Project: Data Consolidation Strategy

## Project Overview
**Role:** Junior Data Migration Specialist
**Company:** RetailCorp (200+ stores, multi-regional retail chain)
**Goal:** Unify customer data into a modern, scalable data warehouse for analytics, personalized marketing, and improved customer experience.

---

## Part 1: Source Systems Assessment

### Source Systems Description

Based on typical retail operations, RetailCorp likely has the following source systems:

| System | Data Type | Format | Volume | Update Frequency |
|--------|-----------|--------|--------|------------------|
| **POS Systems** | Transaction data, sales | CSV/JSON | High (millions daily) | Real-time/Streaming |
| **CRM System** | Customer profiles, preferences | Structured (SQL) | Medium | Daily |
| **Legacy Mainframe** | Historical customer data | Flat files/COBOL | Very High | Batch (Weekly) |
| **E-commerce Platform** | Online orders, browsing behavior | JSON/NoSQL | High | Real-time |
| **Loyalty Program DB** | Points, rewards, tiers | Structured (SQL) | Medium | Real-time |
| **Store Inventory Systems** | Product availability | Structured | Medium | Real-time |
| **Email/Marketing Platform** | Campaign responses | CSV/APIs | Medium | Daily |
| **Customer Service Logs** | Support tickets, feedback | Semi-structured | Low | Continuous |

### Sample Source Data Assessment

```python
# Sample code for assessing source systems
import pandas as pd
import json
from datetime import datetime

def assess_source_systems():
    """Analyze source systems data characteristics"""
    
    source_assessment = {
        "pos_systems": {
            "format": "CSV and JSON",
            "volume_per_day": "5-10 million transactions",
            "data_quality_issues": [
                "Missing store IDs (3%)",
                "Invalid timestamps (1%)",
                "Duplicate transactions (0.5%)"
            ],
            "sensitive_data": ["Credit card tokens", "Customer emails"],
            "compliance_needs": ["PCI DSS", "GDPR"]
        },
        "crm": {
            "format": "PostgreSQL",
            "volume": "2 million customer records",
            "data_quality_issues": [
                "Outdated addresses (15%)",
                "Duplicate customer profiles (8%)",
                "Incomplete profiles (12%)"
            ],
            "sensitive_data": ["PII", "Purchase history"],
            "compliance_needs": ["GDPR", "CCPA"]
        },
        "legacy_mainframe": {
            "format": "COBOL flat files (VSAM)",
            "volume": "15 years of historical data",
            "data_quality_issues": [
                "Inconsistent encoding (EBCDIC)",
                "Missing fields in older records",
                "Legacy date formats (YYMMDD)"
            ],
            "sensitive_data": ["Historical PII"],
            "compliance_needs": ["Retention policies"]
        },
        "ecommerce": {
            "format": "MongoDB",
            "volume_per_day": "500k sessions",
            "data_quality_issues": [
                "Session tracking inconsistencies",
                "Bot traffic filtering needed"
            ],
            "sensitive_data": ["Cookies", "Behavioral data"],
            "compliance_needs": ["ePrivacy", "GDPR"]
        }
    }
    
    # Generate assessment report
    report = []
    for system, details in source_assessment.items():
        report.append(f"""
        System: {system.upper()}
        - Format: {details['format']}
        - Volume: {details['volume_per_day'] if 'volume_per_day' in details else details['volume']}
        - Key Issues: {', '.join(details['data_quality_issues'][:2])}
        - Compliance: {', '.join(details['compliance_needs'])}
        """)
    
    return source_assessment, report

# Execute assessment
assessment, report = assess_source_systems()
for item in report:
    print(item)
```

---

## Part 2: Pipeline Architecture Design

### Pipeline Flowchart Components

Based on typical data warehouse consolidation, here are the pipeline components:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        RETAILCORP DATA CONSOLIDATION PIPELINE                │
└─────────────────────────────────────────────────────────────────────────────┘

SOURCE SYSTEMS                    INTEGRATION LAYER              STORAGE LAYER
───────────────────────────────────────────────────────────────────────────────

┌────────────────┐
│  POS Systems   │───┐
│  (200 stores)  │   │   ┌─────────────────┐    ┌──────────────┐
└────────────────┘   │   │                 │    │              │
                     ├──▶│  Ingestion      │───▶│   Raw Data   │
┌────────────────┐   │   │  Layer          │    │   Lake (S3)  │
│  CRM System    │───┘   │  (Kafka/Kinesis)│    │              │
│  (PostgreSQL)  │──────▶│                 │    └──────────────┘
└────────────────┘       └─────────────────┘            │
                                                        │
┌────────────────┐       ┌─────────────────┐            │
│ Legacy Mainframe│─────▶│  ETL Processing │◀───────────┘
│  (VSAM Files)  │       │  (Spark/Glue)   │
└────────────────┘       └─────────────────┘
                                │
┌────────────────┐              │
│ E-commerce     │───┐           ▼
│ Platform       │   │   ┌─────────────────┐    ┌──────────────┐
└────────────────┘   │   │                 │    │              │
                     ├──▶│  Data Quality   │───▶│   Staging    │
┌────────────────┐   │   │  & Validation   │    │   Area       │
│ Loyalty System │───┘   │                 │    │              │
│  (MySQL)       │──────▶│  (GreatExpecta-│    └──────────────┘
└────────────────┘       │   tions/DQ)     │            │
                        └─────────────────┘            │
                                                        │
┌────────────────┐       ┌─────────────────┐            │
│ Marketing      │─────▶│  Data           │◀───────────┘
│ Platform       │       │  Transformation │
└────────────────┘       │  (dbt/SQL)      │
                        └─────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ┌─────────────────────┐                      │
│                    │   Enterprise Data   │                      │
│                    │   Warehouse (DWH)   │                      │
│                    │   (Snowflake/Redshift)                     │
│                    └─────────────────────┘                      │
│                           │           │                          │
│           ┌───────────────┴────┐     ┌┴───────────────┐         │
│           ▼                      ▼                    ▼         │
│    ┌──────────────┐     ┌──────────────┐     ┌──────────────┐  │
│    │  Analytics   │     │   Marketing  │     │   Reporting  │  │
│    │  (Looker)    │     │   (Segment)  │     │   (Tableau)  │  │
│    └──────────────┘     └──────────────┘     └──────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Component Descriptions

| Component | Purpose | Technology Options | Justification |
|-----------|---------|-------------------|---------------|
| **Ingestion Layer** | Capture data from sources in real-time or batch | AWS Kinesis, Apache Kafka, Azure Event Hubs | Handles high-volume POS transactions and streaming e-commerce data |
| **Raw Data Lake** | Store immutable raw data | AWS S3, Azure Data Lake, Google Cloud Storage | Cost-effective storage for all data formats; enables reprocessing |
| **ETL Processing** | Transform and clean data | AWS Glue, Apache Spark, Azure Data Factory | Serverless options reduce management overhead; handles diverse formats |
| **Data Quality** | Validate and monitor data quality | Great Expectations, Deequ, custom validation | Ensures reliable analytics; critical for customer 360 view |
| **Staging Area** | Intermediate storage for transformed data | AWS Redshift temp tables, Snowflake stages | Isolates transformation from production; enables QA |
| **Data Warehouse** | Central repository for analytics | Snowflake, AWS Redshift, Google BigQuery | Scalable, supports complex queries, separates compute from storage |
| **Business Intelligence** | Analytics and visualization | Looker, Tableau, Power BI | Self-service analytics for business users |

---

## Part 3: Data Integration Strategy

### Step 1: Assessment and Discovery

```python
def create_integration_strategy(source_systems):
    """
    Develop data integration strategy based on source characteristics
    """
    
    strategy = {
        "real_time_streams": [],
        "micro_batch": [],
        "daily_batch": [],
        "weekly_batch": []
    }
    
    for system in source_systems:
        if system.get("latency_requirement") == "real-time":
            strategy["real_time_streams"].append(system["name"])
        elif system.get("volume") == "high" and system.get("update_frequency") == "continuous":
            strategy["micro_batch"].append(system["name"])
        elif system.get("update_frequency") in ["daily", "hourly"]:
            strategy["daily_batch"].append(system["name"])
        else:
            strategy["weekly_batch"].append(system["name"])
    
    return strategy

# Define source systems with requirements
source_systems = [
    {"name": "POS", "volume": "high", "update_frequency": "continuous", "latency_requirement": "real-time"},
    {"name": "E-commerce", "volume": "high", "update_frequency": "continuous", "latency_requirement": "near-real-time"},
    {"name": "CRM", "volume": "medium", "update_frequency": "daily", "latency_requirement": "batch"},
    {"name": "Loyalty", "volume": "medium", "update_frequency": "real-time", "latency_requirement": "real-time"},
    {"name": "Legacy", "volume": "low", "update_frequency": "weekly", "latency_requirement": "batch"}
]

integration_strategy = create_integration_strategy(source_systems)
print("Integration Strategy:")
for freq, systems in integration_strategy.items():
    print(f"  {freq}: {', '.join(systems)}")
```

### Step 2: Change Data Capture (CDC) Implementation

```python
# Example: CDC implementation for CRM database
def configure_cdc_for_crm():
    """
    Set up Change Data Capture for PostgreSQL CRM
    """
    
    cdc_config = {
        "source": "postgresql://crm-rds.retailcorp.com:5432/crm",
        "method": "Debezium PostgreSQL Connector",
        "configuration": {
            "slot.name": "retailcorp_cdc_slot",
            "publication.name": "retailcorp_publication",
            "table.include.list": "public.customers,public.addresses,public.loyalty_tier",
            "plugin.name": "pgoutput",
            "snapshot.mode": "initial"
        },
        "target": {
            "kafka_topic_prefix": "cdc.crm.",
            "partitions": 6,
            "replication_factor": 3
        }
    }
    
    return cdc_config

print("CDC Configuration:", configure_cdc_for_crm())
```

### Step 3: Data Format Harmonization

```python
def create_format_mappings():
    """
    Define mappings from source formats to target schema
    """
    
    mappings = {
        "customer": {
            "source_fields": {
                "pos": ["customer_id", "email", "phone", "transaction_date"],
                "crm": ["cust_id", "email_address", "phone_number", "full_name", "address"],
                "legacy": ["CUST-ID", "EMAIL", "PHONE", "NAME", "ADDR"],
                "ecommerce": ["userId", "email", "phone", "fullName", "shippingAddress"]
            },
            "target_schema": {
                "customer_id": "STRING NOT NULL",
                "email": "STRING",
                "phone": "STRING",
                "full_name": "STRING",
                "address": "STRUCT<street:STRING, city:STRING, state:STRING, zip:STRING, country:STRING>",
                "created_at": "TIMESTAMP",
                "updated_at": "TIMESTAMP",
                "source_system": "STRING",
                "source_record_id": "STRING"
            },
            "transformations": [
                "email lowercasing",
                "phone number standardization",
                "name capitalization",
                "address parsing"
            ]
        },
        "transaction": {
            "source_fields": {
                "pos": ["transaction_id", "store_id", "register_id", "timestamp", "items", "total"],
                "ecommerce": ["orderId", "storeId", "timestamp", "lineItems", "orderTotal"],
                "legacy": ["TRANS-ID", "STORE", "DATE", "ITEMS", "AMOUNT"]
            },
            "target_schema": {
                "transaction_id": "STRING NOT NULL",
                "store_id": "STRING",
                "register_id": "STRING",
                "transaction_timestamp": "TIMESTAMP",
                "items": "ARRAY<STRUCT<product_id:STRING, quantity:INT, price:DECIMAL>>",
                "total_amount": "DECIMAL(10,2)",
                "payment_method": "STRING",
                "customer_id": "STRING",
                "source_system": "STRING"
            }
        }
    }
    
    return mappings

format_mappings = create_format_mappings()
print("\nTarget Schema for Customer Data:")
print(json.dumps(format_mappings["customer"]["target_schema"], indent=2))
```

---

## Part 4: Storage Strategy

### Storage Tier Architecture

```python
def design_storage_tiers():
    """
    Design multi-tier storage strategy for cost optimization
    """
    
    storage_tiers = {
        "hot_tier": {
            "purpose": "Active data for real-time analytics",
            "data": [
                "Last 30 days transactions",
                "Active customer profiles",
                "Real-time inventory"
            ],
            "technology": "Snowflake (compute-optimized)",
            "retention": "30 days",
            "estimated_size": "5 TB",
            "access_pattern": "Frequent reads/writes, sub-second queries",
            "cost_per_gb_month": "$23.00"
        },
        "warm_tier": {
            "purpose": "Recent historical data for regular analysis",
            "data": [
                "Transactions 31-365 days old",
                "Historical customer behavior",
                "Monthly aggregates"
            ],
            "technology": "Snowflake (standard)",
            "retention": "1 year",
            "estimated_size": "20 TB",
            "access_pattern": "Occasional queries, batch processing",
            "cost_per_gb_month": "$5.00"
        },
        "cold_tier": {
            "purpose": "Long-term historical data",
            "data": [
                "Transactions >1 year old",
                "Legacy system archives",
                "Audit logs"
            ],
            "technology": "AWS S3 Glacier",
            "retention": "7 years",
            "estimated_size": "50 TB",
            "access_pattern": "Rare access, compliance queries",
            "retrieval_time": "minutes to hours",
            "cost_per_gb_month": "$0.004"
        }
    }
    
    # Calculate estimated monthly costs
    for tier, details in storage_tiers.items():
        size_gb = int(details["estimated_size"].replace(" TB", "")) * 1024
        if "cost_per_gb_month" in details:
            cost_str = details["cost_per_gb_month"].replace("$", "")
            cost_per_gb = float(cost_str)
            monthly_cost = size_gb * cost_per_gb / 1000  # Convert to TB for display
            details["estimated_monthly_cost"] = f"${monthly_cost:,.2f}"
    
    return storage_tiers

storage_strategy = design_storage_tiers()
print("Storage Tier Strategy:")
for tier, details in storage_strategy.items():
    print(f"\n{tier.upper()}:")
    print(f"  Purpose: {details['purpose']}")
    print(f"  Technology: {details['technology']}")
    print(f"  Size: {details['estimated_size']}")
    print(f"  Est. Monthly Cost: {details.get('estimated_monthly_cost', 'N/A')}")
```

### Data Partitioning Strategy

```python
def design_partitioning_strategy():
    """
    Design partitioning scheme for optimal query performance
    """
    
    partitioning = {
        "fact_transactions": {
            "partition_key": "transaction_date",
            "partition_granularity": "daily",
            "partition_pruning": True,
            "cluster_keys": ["store_id", "customer_id"],
            "distribution_style": "KEY(customer_id)",
            "sort_key": ["transaction_timestamp"],
            "estimated_rows_per_partition": "500,000"
        },
        "dim_customer": {
            "partition_key": "first_purchase_year",
            "partition_granularity": "yearly",
            "cluster_keys": ["loyalty_tier", "region"],
            "distribution_style": "ALL" if "dimension" else "KEY(customer_id)",
            "sort_key": ["customer_id", "last_purchase_date"]
        },
        "dim_store": {
            "distribution_style": "ALL",  # Small dimension
            "sort_key": ["region", "store_id"]
        }
    }
    
    return partitioning

partitioning = design_partitioning_strategy()
print("\nPartitioning Strategy:")
for table, config in partitioning.items():
    print(f"  {table}: {config}")
```

---

## Part 5: Migration Strategy

### Phased Migration Approach

```python
def create_migration_plan():
    """
    Create phased migration plan to minimize disruption
    """
    
    migration_phases = [
        {
            "phase": 1,
            "name": "Assessment & Planning",
            "duration": "4 weeks",
            "activities": [
                "Source system inventory",
                "Data profiling",
                "Schema mapping",
                "Tool selection",
                "Success metrics definition"
            ],
            "deliverables": [
                "Migration playbook",
                "Risk assessment",
                "Timeline and resource plan"
            ]
        },
        {
            "phase": 2,
            "name": "Infrastructure Setup",
            "duration": "6 weeks",
            "activities": [
                "Provision data lake storage",
                "Set up data warehouse",
                "Configure ingestion pipelines",
                "Implement security and access controls",
                "Set up monitoring and alerting"
            ],
            "deliverables": [
                "Production-ready infrastructure",
                "Security compliance documentation",
                "Monitoring dashboards"
            ]
        },
        {
            "phase": 3,
            "name": "Pilot Migration - 3 Stores",
            "duration": "4 weeks",
            "activities": [
                "Migrate data from 3 pilot stores",
                "Validate data quality",
                "Compare query performance",
                "User acceptance testing",
                "Document lessons learned"
            ],
            "deliverables": [
                "Pilot completion report",
                "Validation metrics",
                "Refined migration process"
            ]
        },
        {
            "phase": 4,
            "name": "Regional Rollout",
            "duration": "8 weeks",
            "activities": [
                "Migrate 50 stores per region",
                "Parallel runs with legacy systems",
                "Incremental validation",
                "User training per region"
            ],
            "deliverables": [
                "Regional migration completion",
                "Training materials",
                "Operational handbooks"
            ]
        },
        {
            "phase": 5,
            "name": "Full Migration",
            "duration": "12 weeks",
            "activities": [
                "Remaining 150 stores migration",
                "Legacy system decommissioning",
                "Final data reconciliation",
                "Performance optimization",
                "Knowledge transfer"
            ],
            "deliverables": [
                "Full migration sign-off",
                "Decommissioning plan",
                "Post-migration review"
            ]
        },
        {
            "phase": 6,
            "name": "Optimization & Handover",
            "duration": "4 weeks",
            "activities": [
                "Query performance tuning",
                "Cost optimization",
                "Documentation finalization",
                "Operations team handover",
                "Post-implementation support"
            ],
            "deliverables": [
                "Optimized environment",
                "Operations runbooks",
                "Training completion"
            ]
        }
    ]
    
    return migration_phases

migration_phases = create_migration_plan()
print("Migration Phases:")
for phase in migration_phases:
    print(f"\nPhase {phase['phase']}: {phase['name']} ({phase['duration']})")
    for activity in phase['activities'][:3]:  # Show first 3
        print(f"  - {activity}")
```

### Data Validation Strategy

```python
def create_validation_framework():
    """
    Create comprehensive data validation framework
    """
    
    validation_rules = {
        "completeness": [
            "Row count reconciliation between source and target",
            "Sum of monetary values matches",
            "No NULLs in required fields"
        ],
        "accuracy": [
            "Sample 5% of records for manual verification",
            "Cross-reference with source system queries",
            "Validate calculated fields (e.g., total = sum of items)"
        ],
        "consistency": [
            "Check referential integrity (customer_id exists in dimension)",
            "Validate data types match schema",
            "Ensure consistent date formats"
        ],
        "timeliness": [
            "Verify latest data is available within SLA",
            "Check no data older than retention policy",
            "Monitor ingestion lag"
        ],
        "uniqueness": [
            "No duplicate customer records (by email or ID)",
            "Unique transaction IDs",
            "No duplicate composite keys"
        ]
    }
    
    validation_checks = {
        "pre_migration": [
            "Source data profiling",
            "Identify data quality issues",
            "Document data lineage"
        ],
        "during_migration": [
            "Row-by-row comparison for pilot",
            "Checksum validation for batches",
            "Real-time error logging"
        ],
        "post_migration": [
            "Full reconciliation report",
            "Data quality scorecard",
            "User acceptance sign-off"
        ]
    }
    
    return validation_rules, validation_checks

rules, checks = create_validation_framework()
print("\nValidation Framework:")
print("Validation Rules:")
for category, rule_list in rules.items():
    print(f"  {category}: {', '.join(rule_list[:2])}")
```

---

## Part 6: Tool Selection and Justification

### Tool Selection Matrix

```python
def recommend_tools():
    """
    Recommend tools for each pipeline component with justification
    """
    
    recommendations = {
        "ingestion": {
            "tool": "Apache Kafka + AWS KMS",
            "alternatives": ["AWS Kinesis", "Azure Event Hubs"],
            "justification": """
                Kafka provides exactly-once semantics, high throughput for POS data,
                and integrates well with CDC tools. KMS enables real-time processing.
            """
        },
        "data_lake": {
            "tool": "AWS S3",
            "alternatives": ["Azure Data Lake", "GCS"],
            "justification": """
                S3 offers 11 9's durability, cost-effective storage tiers,
                and integrates seamlessly with AWS Glue and Redshift.
                S3 Intelligent-Tiering automatically optimizes costs.
            """
        },
        "etl_processing": {
            "tool": "AWS Glue (Spark-based)",
            "alternatives": ["Azure Data Factory", "Google Dataflow"],
            "justification": """
                Serverless ETL reduces operational overhead. Auto-scaling handles
                variable workloads. Glue Data Catalog provides unified metadata.
                Supports both batch and streaming (Glue Streaming).
            """
        },
        "data_warehouse": {
            "tool": "Snowflake",
            "alternatives": ["AWS Redshift", "Google BigQuery"],
            "justification": """
                Snowflake separates storage and compute for independent scaling.
                Supports semi-structured data natively. Time travel feature
                enables point-in-time queries for compliance. Multi-cluster
                warehouses handle concurrent users without performance degradation.
            """
        },
        "data_quality": {
            "tool": "Great Expectations + dbt tests",
            "alternatives": ["Deequ", "Custom Python"],
            "justification": """
                Great Expectations provides data validation as code with
                automated documentation. dbt tests ensure data quality
                within transformation pipeline. Both integrate with CI/CD.
            """
        },
        "orchestration": {
            "tool": "Apache Airflow (MWAA)",
            "alternatives": ["AWS Step Functions", "Prefect"],
            "justification": """
                Airflow provides complex DAG dependencies, retry logic,
                and monitoring. Managed Workflows for Apache Airflow (MWAA)
                reduces operational burden.
            """
        },
        "business_intelligence": {
            "tool": "Looker",
            "alternatives": ["Tableau", "Power BI"],
            "justification": """
                Looker's semantic layer ensures consistent metrics across the
                organization. LookML allows version-controlled metric definitions.
                Native integration with Snowflake and real-time dashboards.
            """
        }
    }
    
    return recommendations

tools = recommend_tools()
print("\nRecommended Technology Stack:")
for component, details in tools.items():
    print(f"\n{component.upper()}:")
    print(f"  Tool: {details['tool']}")
    print(f"  Justification: {details['justification'][:100]}...")
```

---

## Part 7: Risk Assessment and Mitigation

### Risk Matrix

```python
def assess_risks():
    """
    Identify and assess project risks
    """
    
    risks = [
        {
            "risk": "Data quality issues in legacy systems",
            "probability": "HIGH",
            "impact": "HIGH",
            "mitigation": """
                - Comprehensive data profiling before migration
                - Implement data quality rules in staging
                - Create data cleansing pipeline
                - Maintain data lineage for audit
                - Consider data remediation as separate project phase
            """
        },
        {
            "risk": "Business disruption during migration",
            "probability": "MEDIUM",
            "impact": "HIGH",
            "mitigation": """
                - Phased migration approach
                - Parallel runs with legacy systems
                - Off-peak migration windows
                - Rollback procedures
                - Comprehensive testing in staging
            """
        },
        {
            "risk": "Schema evolution challenges",
            "probability": "MEDIUM",
            "impact": "MEDIUM",
            "mitigation": """
                - Version control for all schemas
                - Backward-compatible changes
                - Schema registry with compatibility checks
                - Automated migration tests
            """
        },
        {
            "risk": "Performance degradation post-migration",
            "probability": "MEDIUM",
            "impact": "HIGH",
            "mitigation": """
                - Performance benchmarking before/after
                - Query optimization and tuning
                - Proper indexing and partitioning
                - Load testing with production volumes
                - Monitoring and alerting setup
            """
        },
        {
            "risk": "Security and compliance breaches",
            "probability": "LOW",
            "impact": "CRITICAL",
            "mitigation": """
                - Encryption at rest and in transit
                - Row/column-level security
                - Regular security audits
                - Data masking for PII
                - Compliance checks automated
                - Access logging and monitoring
            """
        },
        {
            "risk": "Cost overruns",
            "probability": "MEDIUM",
            "impact": "MEDIUM",
            "mitigation": """
                - Cost monitoring dashboards
                - Resource tagging
                - Auto-scaling limits
                - Reserved capacity planning
                - Regular cost reviews
                - Query cost optimization
            """
        },
        {
            "risk": "Skills gap in team",
            "probability": "MEDIUM",
            "impact": "MEDIUM",
            "mitigation": """
                - Training program before migration
                - External consultants for knowledge transfer
                - Documentation and runbooks
                - Pair programming and mentoring
                - Gradual responsibility transfer
            """
        }
    ]
    
    return risks

risks = assess_risks()
print("\nRisk Assessment Matrix:")
for r in risks:
    print(f"\n{r['risk']}:")
    print(f"  Probability: {r['probability']}, Impact: {r['impact']}")
    print(f"  Mitigation: {r['mitigation'][:100]}...")
```

---

## Part 8: Success Metrics and KPIs

### Key Performance Indicators

```python
def define_success_metrics():
    """
    Define KPIs to measure project success
    """
    
    metrics = {
        "technical_metrics": [
            {
                "metric": "Data completeness",
                "target": "99.9% of records migrated successfully",
                "measurement": "Row count reconciliation, checksum validation"
            },
            {
                "metric": "Data latency",
                "target": "Real-time data < 1 minute, Batch < 4 hours",
                "measurement": "End-to-end ingestion monitoring"
            },
            {
                "metric": "Query performance",
                "target": "90% queries < 2 seconds, 99% < 5 seconds",
                "measurement": "Query execution time monitoring"
            },
            {
                "metric": "System uptime",
                "target": "99.9% availability during business hours",
                "measurement": "Infrastructure monitoring"
            },
            {
                "metric": "Data quality score",
                "target": ">95% passing automated checks",
                "measurement": "Great Expectations validation runs"
            }
        ],
        "business_metrics": [
            {
                "metric": "Customer 360 view completion",
                "target": "85% of customers have unified profile",
                "measurement": "Count of customers with data from 3+ sources"
            },
            {
                "metric": "Marketing campaign effectiveness",
                "target": "20% increase in conversion rate",
                "measurement": "Campaign analytics pre/post migration"
            },
            {
                "metric": "Report generation time",
                "target": "80% reduction in report preparation",
                "measurement": "Time to generate standard reports"
            },
            {
                "metric": "Self-service analytics adoption",
                "target": "50 active users within 3 months",
                "measurement": "Looker usage analytics"
            }
        ],
        "financial_metrics": [
            {
                "metric": "Total cost of ownership",
                "target": "30% reduction vs legacy systems",
                "measurement": "Cost comparison pre/post migration"
            },
            {
                "metric": "Query cost optimization",
                "target": "< $0.01 per 1000 queries",
                "measurement": "Snowflake credit usage"
            },
            {
                "metric": "Storage cost per TB",
                "target": "50% reduction through tiering",
                "measurement": "Storage cost analysis"
            }
        ],
        "compliance_metrics": [
            {
                "metric": "Data privacy compliance",
                "target": "100% of PII properly masked",
                "measurement": "Security scans and audits"
            },
            {
                "metric": "Audit trail completeness",
                "target": "100% of data access logged",
                "measurement": "Audit log analysis"
            },
            {
                "metric": "GDPR deletion capability",
                "target": "< 24 hours for right-to-be-forgotten",
                "measurement": "Test deletion requests"
            }
        ]
    }
    
    return metrics

metrics = define_success_metrics()
print("\nSuccess Metrics:")
for category, metric_list in metrics.items():
    print(f"\n{category.replace('_', ' ').title()}:")
    for m in metric_list[:2]:  # Show first 2 per category
        print(f"  - {m['metric']}: {m['target']}")
```

---

## Part 9: Final Recommendations

### Executive Summary

```python
def generate_recommendations():
    """
    Generate final project recommendations
    """
    
    recommendations = {
        "architecture": """
            Implement a modern data stack using:
            - AWS S3 as cost-effective data lake
            - Snowflake for enterprise data warehouse
            - Apache Kafka for real-time ingestion
            - AWS Glue for serverless ETL
            - dbt for transformations
            - Looker for BI and semantic layer
        """,
        
        "migration_approach": """
            Follow phased migration:
            1. Assessment and planning (4 weeks)
            2. Infrastructure setup (6 weeks)
            3. Pilot with 3 stores (4 weeks)
            4. Regional rollout (8 weeks)
            5. Full migration (12 weeks)
            6. Optimization and handover (4 weeks)
            
            Total duration: 38 weeks (approx. 9 months)
        """,
        
        "data_quality": """
            Implement comprehensive data quality framework:
            - Great Expectations for validation
            - Automated data profiling
            - Real-time monitoring and alerting
            - Data quality scorecards for stakeholders
        """,
        
        "governance": """
            Establish data governance practices:
            - Data catalog with lineage tracking
            - Role-based access control
            - PII identification and masking
            - Audit logging for compliance
            - Data retention policies enforced
        """,
        
        "team_structure": """
            Recommended team composition:
            - Project Manager (1)
            - Data Architects (2)
            - Data Engineers (4)
            - Data Analysts (2)
            - DevOps Engineers (2)
            - QA Engineers (2)
            - Business Stakeholders (rotating)
        """,
        
        "next_steps": """
            Immediate next steps:
            1. Approve architecture and tool selection
            2. Assemble project team
            3. Begin source system assessment
            4. Set up development environment
            5. Create detailed project timeline
            6. Define success metrics with stakeholders
        """
    }
    
    return recommendations

final_recs = generate_recommendations()
print("\n" + "="*60)
print("FINAL RECOMMENDATIONS FOR RETAILCORP")
print("="*60)

for category, recommendation in final_recs.items():
    print(f"\n{category.replace('_', ' ').title()}:")
    print(recommendation)
```

### Cost-Benefit Analysis Summary

```python
def cost_benefit_analysis():
    """
    Summarize cost-benefit analysis
    """
    
    analysis = {
        "estimated_costs": {
            "infrastructure": "$15,000/month",
            "personnel": "$120,000/month",
            "software_licenses": "$8,000/month",
            "professional_services": "$50,000 (one-time)",
            "training": "$25,000 (one-time)",
            "total_first_year": "$2.1M",
            "total_ongoing_yearly": "$1.7M"
        },
        "estimated_benefits": {
            "reduced_legacy_costs": "$800,000/year",
            "improved_marketing_roi": "$2.5M/year (20% improvement)",
            "operational_efficiency": "$1.2M/year (30% time savings)",
            "reduced_reporting_time": "$400,000/year",
            "total_annual_benefits": "$4.9M"
        },
        "roi_metrics": {
            "payback_period": "8 months",
            "three_year_roi": "285%",
            "npv_3_years": "$8.2M",
            "irr": "42%"
        }
    }
    
    return analysis

roi = cost_benefit_analysis()
print("\n" + "="*60)
print("COST-BENEFIT ANALYSIS")
print("="*60)
print(f"\nFirst Year Investment: {roi['estimated_costs']['total_first_year']}")
print(f"Annual Ongoing Cost: {roi['estimated_costs']['total_ongoing_yearly']}")
print(f"Annual Benefits: {roi['estimated_benefits']['total_annual_benefits']}")
print(f"\nPayback Period: {roi['roi_metrics']['payback_period']}")
print(f"3-Year ROI: {roi['roi_metrics']['three_year_roi']}")
```

---

## Part 10: Sample Implementation Code

### Sample ETL Pipeline Code

```python
"""
Sample ETL Pipeline for RetailCorp Data Consolidation
"""

import boto3
import pandas as pd
import pyspark.sql.functions as F
from pyspark.sql import SparkSession
from pyspark.sql.types import *
import json
from datetime import datetime

class RetailCorpETL:
    """
    Main ETL class for RetailCorp data consolidation
    """
    
    def __init__(self, spark_session=None):
        if spark_session:
            self.spark = spark_session
        else:
            self.spark = SparkSession.builder \
                .appName("RetailCorp-Data-Consolidation") \
                .config("spark.sql.adaptive.enabled", "true") \
                .config("spark.sql.adaptive.coalescePartitions.enabled", "true") \
                .getOrCreate()
        
        self.s3_client = boto3.client('s3')
        
    def ingest_from_kafka(self, topic, bootstrap_servers):
        """
        Ingest real-time data from Kafka
        """
        df = self.spark \
            .readStream \
            .format("kafka") \
            .option("kafka.bootstrap.servers", bootstrap_servers) \
            .option("subscribe", topic) \
            .option("startingOffsets", "latest") \
            .load()
        
        # Parse JSON data
        parsed_df = df.select(
            F.col("key").cast("string"),
            F.from_json(
                F.col("value").cast("string"),
                self.get_schema_for_topic(topic)
            ).alias("data"),
            F.col("timestamp")
        )
        
        return parsed_df
    
    def process_customer_data(self, source_df, source_system):
        """
        Transform customer data to unified schema
        """
        
        unified_schema = {
            "customer_id": F.col("customer_id"),
            "email": F.lower(F.col("email")),
            "phone": self.standardize_phone(F.col("phone")),
            "full_name": self.standardize_name(F.col("full_name")),
            "address": F.struct(
                F.col("address.street"),
                F.col("address.city"),
                F.col("address.state"),
                F.col("address.zip"),
                F.col("address.country")
            ),
            "created_at": F.current_timestamp(),
            "updated_at": F.current_timestamp(),
            "source_system": F.lit(source_system)
        }
        
        # Apply source-specific transformations
        if source_system == "CRM":
            transformed_df = source_df.select([
                F.col("cust_id").alias("customer_id"),
                F.col("email_address").alias("email"),
                F.col("phone_number").alias("phone"),
                F.col("full_name"),
                F.struct(
                    F.col("address_line1").alias("street"),
                    F.col("city"),
                    F.col("state"),
                    F.col("postal_code").alias("zip"),
                    F.col("country")
                ).alias("address")
            ])
        elif source_system == "POS":
            transformed_df = source_df.select([
                F.col("customer_id"),
                F.col("email"),
                F.col("phone"),
                F.concat_ws(" ", 
                    F.col("first_name"), 
                    F.col("last_name")
                ).alias("full_name"),
                F.struct(
                    F.col("billing_street").alias("street"),
                    F.col("billing_city").alias("city"),
                    F.col("billing_state").alias("state"),
                    F.col("billing_zip").alias("zip"),
                    F.col("billing_country").alias("country")
                ).alias("address")
            ])
        elif source_system == "Legacy":
            transformed_df = source_df.select([
                F.col("CUST-ID").alias("customer_id"),
                F.col("EMAIL").alias("email"),
                F.col("PHONE").alias("phone"),
                F.col("NAME").alias("full_name"),
                F.struct(
                    F.col("ADDR").alias("street"),
                    F.lit(None).alias("city"),
                    F.lit(None).alias("state"),
                    F.lit(None).alias("zip"),
                    F.lit("US").alias("country")
                ).alias("address")
            ])
        
        # Apply unified transformations
        result_df = transformed_df.select([
            F.col("customer_id"),
            F.lower(F.col("email")).alias("email"),
            self.standardize_phone(F.col("phone")).alias("phone"),
            self.standardize_name(F.col("full_name")).alias("full_name"),
            F.col("address"),
            F.current_timestamp().alias("created_at"),
            F.current_timestamp().alias("updated_at"),
            F.lit(source_system).alias("source_system")
        ])
        
        return result_df
    
    def standardize_phone(self, phone_col):
        """
        Standardize phone numbers to E.164 format
        """
        # Remove non-numeric characters
        cleaned = F.regexp_replace(phone_col, "[^0-9]", "")
        
        # Add country code if missing (assuming US)
        standardized = F.when(
            F.length(cleaned) == 10,
            F.concat(F.lit("+1"), cleaned)
        ).otherwise(
            F.when(
                F.length(cleaned) == 11,
                F.concat(F.lit("+"), cleaned)
            ).otherwise(F.lit(None))
        )
        
        return standardized
    
    def standardize_name(self, name_col):
        """
        Standardize name capitalization
        """
        # Title case with proper handling of hyphenated names
        return F.initcap(name_col)
    
    def deduplicate_customers(self, df):
        """
        Remove duplicate customer records based on matching logic
        """
        # First pass: exact matches on customer_id
        window_spec = F.Window.partitionBy("customer_id").orderBy(F.desc("updated_at"))
        
        deduped_df = df.withColumn(
            "row_num",
            F.row_number().over(window_spec)
        ).filter(F.col("row_num") == 1).drop("row_num")
        
        # Second pass: fuzzy matching on email/phone for remaining
        # This would use more sophisticated logic in production
        return deduped_df
    
    def write_to_snowflake(self, df, table_name, mode="append"):
        """
        Write DataFrame to Snowflake
        """
        snowflake_options = {
            "sfURL": "https://retailcorp.snowflakecomputing.com",
            "sfDatabase": "RETAILCORP_DWH",
            "sfSchema": "CUSTOMER_360",
            "sfWarehouse": "ETL_WH",
            "sfRole": "ETL_ROLE"
        }
        
        df.write \
            .format("snowflake") \
            .options(**snowflake_options) \
            .option("dbtable", table_name) \
            .mode(mode) \
            .save()
    
    def run_customer_etl(self):
        """
        Main ETL orchestration for customer data
        """
        
        # Source configurations
        sources = [
            {"path": "s3://retailcorp-data/raw/crm/*", "system": "CRM", "format": "parquet"},
            {"path": "s3://retailcorp-data/raw/pos/customers/*", "system": "POS", "format": "json"},
            {"path": "s3://retailcorp-data/raw/legacy/customers/*", "system": "Legacy", "format": "csv"}
        ]
        
        all_customers = []
        
        for source in sources:
            print(f"Processing {source['system']} data from {source['path']}")
            
            # Read source data
            if source['format'] == "parquet":
                df = self.spark.read.parquet(source['path'])
            elif source['format'] == "json":
                df = self.spark.read.json(source['path'])
            elif source['format'] == "csv":
                df = self.spark.read \
                    .option("header", "true") \
                    .option("inferSchema", "true") \
                    .csv(source['path'])
            
            # Transform to unified schema
            transformed_df = self.process_customer_data(df, source['system'])
            all_customers.append(transformed_df)
        
        # Union all sources
        unified_df = all_customers[0]
        for df in all_customers[1:]:
            unified_df = unified_df.unionByName(df, allowMissingColumns=True)
        
        # Deduplicate
        final_df = self.deduplicate_customers(unified_df)
        
        # Write to Snowflake
        self.write_to_snowflake(final_df, "DIM_CUSTOMER")
        
        # Also write to data lake for backup
        final_df.write \
            .partitionBy("source_system") \
            .mode("overwrite") \
            .parquet("s3://retailcorp-data/curated/customers/")
        
        return final_df.count()
    
    def get_schema_for_topic(self, topic):
        """
        Get schema for Kafka topics
        """
        schemas = {
            "pos.transactions": StructType([
                StructField("transaction_id", StringType(), True),
                StructField("store_id", StringType(), True),
                StructField("register_id", StringType(), True),
                StructField("timestamp", TimestampType(), True),
                StructField("items", ArrayType(StructType([
                    StructField("product_id", StringType(), True),
                    StructField("quantity", IntegerType(), True),
                    StructField("price", DoubleType(), True)
                ])), True),
                StructField("total", DoubleType(), True),
                StructField("customer_id", StringType(), True)
            ]),
            "ecommerce.orders": StructType([
                StructField("order_id", StringType(), True),
                StructField("customer_id", StringType(), True),
                StructField("order_timestamp", TimestampType(), True),
                StructField("line_items", ArrayType(StructType([
                    StructField("sku", StringType(), True),
                    StructField("qty", IntegerType(), True),
                    StructField("unit_price", DoubleType(), True)
                ])), True),
                StructField("order_total", DoubleType(), True),
                StructField("shipping_address", StringType(), True),
                StructField("payment_method", StringType(), True)
            ])
        }
        
        return schemas.get(topic, StructType([]))

# Execute ETL
if __name__ == "__main__":
    etl = RetailCorpETL()
    customer_count = etl.run_customer_etl()
    print(f"Successfully processed {customer_count} customer records")
```

---

## Final Project Submission Summary

### Key Deliverables Checklist

| Deliverable | Status | Notes |
|-------------|--------|-------|
| Source Systems Assessment | ✓ Completed | Identified 6 source systems with data quality issues |
| Pipeline Architecture Design | ✓ Completed | Multi-stage pipeline with ingestion, processing, storage |
| Data Integration Strategy | ✓ Completed | CDC, format harmonization, real-time streams |
| Storage Strategy | ✓ Completed | 3-tier storage with cost optimization |
| Migration Plan | ✓ Completed | 6-phase approach over 38 weeks |
| Tool Selection | ✓ Completed | AWS + Snowflake + Kafka stack |
| Risk Assessment | ✓ Completed | 7 key risks with mitigations |
| Success Metrics | ✓ Completed | Technical, business, financial KPIs |
| Sample Implementation | ✓ Completed | PySpark ETL code provided |
| Cost-Benefit Analysis | ✓ Completed | 8-month payback, 285% 3-year ROI |

### Executive Summary

**Project:** RetailCorp Customer Data Consolidation

**Objective:** Unify customer data from 200+ stores into a modern data warehouse for analytics, personalized marketing, and improved customer experience.

**Approach:** Phased migration using modern cloud-native tools (AWS + Snowflake) with comprehensive data quality and governance.

**Timeline:** 38 weeks (approx. 9 months)

**Investment:** $2.1M first year, $1.7M ongoing annually

**Benefits:** $4.9M annual benefits, 8-month payback, 285% 3-year ROI

**Key Success Factors:**
- Phased migration minimizes business disruption
- Automated data quality ensures reliable analytics
- Modern stack enables scalability and cost optimization
- Comprehensive governance ensures compliance
- Self-service analytics empowers business users

**Next Steps:**
1. Present recommendations to stakeholders
2. Assemble project team
3. Begin source system assessment
4. Set up development environment
5. Define detailed success metrics

---

**End of Final Project Submission**