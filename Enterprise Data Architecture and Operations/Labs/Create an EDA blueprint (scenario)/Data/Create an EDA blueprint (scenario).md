# Lab: Create an EDA Blueprint

## Estimated time: 30 minutes

---

## Learning objectives

After completing this lab, you will be able to:

- Design a scalable, secure, and efficient data architecture blueprint to optimize supply chain operations
- Enable effective decision-making and ensure compliance through tailored data architecture solutions

---

## Prerequisites

You can complete your tasks using any text editor, such as Word, Google Docs, or Notepad.

If you install Microsoft Word, you can proceed directly with the instructions. However, if you don't have Microsoft Word, you can sign up for a free version of Microsoft 365 online. Follow [these instructions](https://support.microsoft.com/en-us/office/sign-up-for-microsoft-365-9ac1e0c7-0e6c-4f9d-8c8c-7e9b8e8c8c8c) to create your account.

You can also use Word Online with a Microsoft 365 subscription or access through a free account. If you're new to Word and would like to learn how to get started, you can find helpful resources here: [Getting Started with Word Online](https://support.microsoft.com/en-us/office/get-started-with-word-online-5c8c3c3c-3c3c-4c3c-8c3c-3c3c3c3c3c3c).

For this lab, you can use **Lucidchart**. You only need the free version of LucidChart. If you choose to purchase a paid plan, you will be responsible for any associated charges. If you've not yet signed up for the free account, you can follow [these instructions](https://www.lucidchart.com/pages/sign-up) to get started. You may alternatively use applications like **Microsoft Visio** or **draw.io**.

---

## Introduction

Reliable and accurate data is the foundation of effective strategy development and decision-making in today's data-driven landscape.

**Enterprise Data Architecture (EDA)** provides a structured framework for collecting, storing, integrating, and managing data. In a supply chain company, a well-designed EDA ensures:

| Benefit                             | Description                                        |
| ----------------------------------- | -------------------------------------------------- |
| **Seamless data flow**        | Information moves effortlessly across systems      |
| **Improved data consistency** | Single source of truth eliminates discrepancies    |
| **Enhanced accessibility**    | Right data available to right people at right time |
| **Maintained data quality**   | Clean, accurate, and reliable data throughout      |

By adopting a structured EDA approach, supply chain companies can enhance operations, make informed decisions, and stay competitive in a rapidly evolving market.

---

## Scenario overview

A **supply chain company** aims to streamline operations and improve decision-making by developing an Enterprise Data Architecture (EDA) blueprint. The process begins with identifying key data sources, such as inventory systems, transportation logs, supplier databases, and customer orders. The team defines data flow processes, integrating real-time tracking and analytics platforms. Using cloud-based solutions, they establish a centralized data lake for seamless storage and retrieval. The blueprint outlines data governance policies, ensuring security and compliance. Advanced analytics tools are incorporated to forecast demand, optimize routes, and reduce costs. This comprehensive EDA blueprint becomes the foundation for the company's digital transformation journey.

### Company Profile: Garment Manufacturing Supply Chain

| Aspect               | Details                                                                       |
| -------------------- | ----------------------------------------------------------------------------- |
| **Industry**   | Textile and garment manufacturing supply chain                                |
| **Operations** | Sourcing raw materials (cotton, synthetic fibers, dyes) from global suppliers |
| **Challenges** | Fragmented data systems, delayed shipments, inventory inefficiencies          |
| **Goal**       | Create integrated data architecture for end-to-end visibility                 |

---

## Exercise: Create an Enterprise Data Architecture blueprint for a supply chain company

In this lab, you will design an enterprise data architecture blueprint for a **supply chain company that provides raw materials for garment manufacturing**. The blueprint will focus on core components: data sources, ingestion, storage, processing, analytics, and governance.

You will be guided step by step to design a framework that ensures efficient data flow, scalability, and compliance. By the end of this lab, you will have a comprehensive and structured data architecture plan tailored to streamline supply chain operations.

---

## Template to use

If you are using Microsoft Word, right-click the link and download the template document. You can use the template to perform the tasks outlined in the lab.

You can also use the PDF format for any other word-processing software.

---

## Task 1: Understand business requirements

Identify the specific data requirements for optimizing supply chain operations for a garment manufacturing raw materials supplier.

### Step 1: Compile a list of all critical data sources

| Key Data Resources                        | Description                                                                                           |
| ----------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| **Supplier Database**               | Information about raw material suppliers (cotton farms, synthetic fiber manufacturers, dye producers) |
| **Inventory Management System**     | Real-time stock levels of raw materials across warehouses                                             |
| **Order Management System**         | Customer orders from garment manufacturers                                                            |
| **Transportation & Logistics Data** | Shipment tracking, carrier information, delivery schedules                                            |
| **ERP System**                      | Financial data, procurement records, resource planning                                                |
| **Quality Control Records**         | Inspection results, material quality metrics                                                          |
| **Market Trends API**               | Global commodity prices, demand forecasts                                                             |
| **Weather Data**                    | Climate conditions affecting crop yields (cotton) and shipping routes                                 |
| **IoT Sensor Data**                 | Temperature/humidity monitoring for sensitive materials                                               |
| **Regulatory Compliance Data**      | Trade regulations, tariffs, sustainability certifications                                             |

### Step 2: Define practical applications for the data

| Critical Use Cases                      | Description                                                                    |
| --------------------------------------- | ------------------------------------------------------------------------------ |
| **Inventory Forecasting**         | Predict raw material requirements based on historical orders and market trends |
| **Supplier Performance Analysis** | Evaluate suppliers based on delivery time, quality, and pricing                |
| **Transportation Optimization**   | Optimize shipping routes to reduce costs and delivery times                    |
| **Demand and Supply Matching**    | Align raw material procurement with garment manufacturer demand                |
| **Quality Assurance**             | Track quality issues and identify problematic suppliers                        |
| **Cost Optimization**             | Analyze total landed costs across different sourcing options                   |
| **Sustainability Reporting**      | Track carbon footprint and ethical sourcing metrics                            |
| **Risk Management**               | Identify supply chain disruptions due to weather, geopolitical events          |

### Step 3: Outline the data compliance standards and regulations that must be followed

| Data Compliance Requirements                                          | Description                                                                                                                                                                                                      |
| --------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **GDPR**                                                        | • Applies if the company handles personal data of EU citizens`<br>`• Ensure data minimization, lawful processing, and user consent`<br>`• Provide mechanisms for data access, rectification, and deletion |
| **CCPA**                                                        | • Protects data privacy of California residents`<br>`• Enables users to opt out of data sales and request data access or deletion                                                                            |
| **Environmental, Social, and Governance (ESG) Regulations**     | • Monitor and report sustainability data in supply chain operations`<br>`• Track carbon emissions, fair labor practices, ethical sourcing                                                                    |
| **ISO 27001**                                                   | • Implements an Information Security Management System (ISMS) to protect sensitive data                                                                                                                         |
| **Industry-Specific Regulations**                               | • Textile industry standards for material safety`<br>`• Import/export documentation requirements                                                                                                             |
| **GDPR**                                                        | • Applies if the company handles personal data of EU citizens`<br>`• Ensure data minimization, lawful processing, and user consent`<br>`• Provide mechanisms for data access, rectification, and deletion |
| **Health Insurance Portability and Accountability Act (HIPAA)** | • Relevant if healthcare-related goods (e.g., medical textiles) are shipped`<br>`• Safeguard sensitive health information                                                                                    |

---

## Task 2: Identify and define the core components of data architecture

### Step 1: Data Sources

Identify and categorize all internal and external data sources for the garment manufacturing supply chain.

| Data Source Type   | Examples                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Internal** | • ERP System (SAP, Oracle)`<br>`• Warehouse Management System (WMS)`<br>`• Inventory Management Database`<br>`• Order Processing System`<br>`• Quality Control Records`<br>`• Transportation Management System`<br>`• Production Logs                                                                                                                          |
| **External** | • Supplier APIs (real-time inventory from cotton suppliers)`<br>`• Weather Data APIs (affecting crop yields and shipping)`<br>`• Market Trends Data (commodity prices for cotton, synthetic fibers)`<br>`• Shipping Carrier APIs (FedEx, DHL, Maersk tracking)`<br>`• Regulatory Databases (customs, trade tariffs)`<br>`• Sustainability Certification Databases |

### Step 2: Data Ingestion

Establish the data ingestion methods for capturing data from various sources.

| Ingestion Method                    | Description                                           | Examples                                                                                                               | Tools                                                     |
| ----------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| **Batch Ingestion**           | Processes data at scheduled intervals                 | • Daily supplier inventory reports`<br>`• Weekly financial updates`<br>`• Monthly supplier performance reviews  | Apache Kafka, AWS Kinesis, Talend, Apache NiFi            |
| **Real-time Ingestion**       | Captures and processes data dynamically as it arrives | • IoT sensors in transportation vehicles`<br>`• Real-time shipment tracking`<br>`• Live inventory level updates | Apache Kafka, AWS Kinesis, Apache Flume, Azure Event Hubs |
| **Change Data Capture (CDC)** | Captures changes in databases in real-time            | • Database updates in ERP system`<br>`• New orders in Order Management System                                      | Debezium, AWS DMS, Oracle GoldenGate                      |

### Step 3: Data Storage

Define the data storage types for the supply chain data architecture.

| Storage Type                   | Purpose                                          | Examples                                                                                         |
| ------------------------------ | ------------------------------------------------ | ------------------------------------------------------------------------------------------------ |
| **Data Lake**            | Stores raw, unprocessed data in native format    | • Hadoop HDFS`<br>`• AWS S3`<br>`• Azure Data Lake Storage`<br>`• Google Cloud Storage |
| **Data Warehouse**       | Stores structured, analytical data for reporting | • Snowflake`<br>`• Google BigQuery`<br>`• Amazon Redshift`<br>`• Azure Synapse         |
| **Operational Database** | Supports day-to-day transaction processing       | • PostgreSQL`<br>`• MySQL`<br>`• MongoDB                                                  |
| **Data Mart**            | Department-specific data subsets                 | • Finance Data Mart`<br>`• Procurement Data Mart`<br>`• Logistics Data Mart               |
| **Archive Storage**      | Stores historical data for long-term retention   | • AWS S3 Glacier`<br>`• Azure Archive Storage`<br>`• IBM Cloud Object Storage             |

### Step 4: Data Processing

Define the data processing methods for transforming raw data into actionable insights.

| Processing Method           | Description                                          | Examples/Tools                                                                                                             |
| --------------------------- | ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **ETL/ELT Pipelines** | Transform raw data for further analysis              | • Apache Spark`<br>`• Talend`<br>`• AWS Glue`<br>`• Microsoft Azure Data Factory`<br>`• dbt (data build tool) |
| **Stream Processing** | Process data in real time for immediate use          | • Apache Flink`<br>`• Apache Kafka Streams`<br>`• Spark Streaming`<br>`• Azure Stream Analytics                  |
| **Batch Processing**  | Process large volumes of data at scheduled intervals | • Apache Hadoop MapReduce`<br>`• AWS Batch`<br>`• Google Cloud Dataflow                                             |

### Step 5: Analytics

Identify and report business intelligence capabilities for supply chain optimization.

| Analytics Type                   | Description                                                                             | Examples/Use Cases                                                                                                                       | Tools                                                 |
| -------------------------------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| **Dashboards**             | Visualize key metrics such as inventory levels, supplier performance, and cost analysis | • Inventory turnover dashboard`<br>`• Supplier scorecard`<br>`• Cost analysis by material type`<br>`• On-time delivery metrics | Tableau, Power BI, Looker, Qlik                       |
| **Predictive Analytics**   | Use historical data to forecast future demand                                           | • Raw material demand forecasting`<br>`• Supplier delivery delay prediction`<br>`• Price trend analysis                           | Python (scikit-learn), R, SAS, Azure Machine Learning |
| **Prescriptive Analytics** | Recommend optimal actions based on data                                                 | • Route optimization suggestions`<br>`• Inventory reorder recommendations`<br>`• Supplier selection optimization                  | IBM CPLEX, Gurobi, OptaPlanner                        |
| **Ad-hoc Reporting**       | Custom reports for specific business questions                                          | • Impact of weather on shipping delays`<br>`• Supplier quality trend analysis                                                        | SQL, Excel, Jupyter Notebooks                         |

### Step 6: Data Governance

Define the data governance tasks to ensure data quality, security, and compliance.

| Governance Task                        | Description                                                           | Examples/Tools                                                                                |
| -------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Data Ownership & Stewardship** | Define roles and responsibilities for data management                 | • Collibra`<br>`• Alation`<br>`• Informatica Axon                                      |
| **Data Quality Management**      | Monitor and improve data accuracy, completeness, and consistency      | • Talend Data Quality`<br>`• Great Expectations`<br>`• Apache Griffin                  |
| **Access Policies**              | Establish guidelines for who can access the data                      | • Okta`<br>`• Immuta`<br>`• AWS IAM`<br>`• Azure Active Directory                   |
| **Compliance & Audit**           | Ensure data usage complies with regulations and maintain audit trails | • AWS Audit Manager`<br>`• IBM OpenPages with Watson`<br>`• OneTrust                   |
| **Data Lineage**                 | Track data flow from source to consumption                            | • Apache Atlas`<br>`• Marquez`<br>`• Collibra Lineage                                  |
| **Master Data Management (MDM)** | Create single source of truth for critical data entities              | • Supplier master data`<br>`• Product/material master data`<br>`• Customer master data |

---

## Task 3: Create the blueprint using Lucidchart

### Step 1: Set-up the core layers

1. Open **Lucidchart** and click the **New** button
2. Select **Blank Document** to create a new diagram
3. Add six rectangular shapes, each representing a core section:
   - **Data Sources**
   - **Data Ingestion**
   - **Data Storage**
   - **Data Processing**
   - **Analytics**
   - **Governance**
4. Connect these sections with arrows to illustrate the data flow between them

**Visual layout:**

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              GOVERNANCE LAYER                                     │
│              (Security, Compliance, Metadata, Data Quality)                       │
└─────────────────────────────────────────────────────────────────────────────────┘
                                    ↑ ↓
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  DATA SOURCES   │───▶│ DATA INGESTION  │───▶│  DATA STORAGE   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                    │
                                                    ↓
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   ANALYTICS     │◀───│ DATA PROCESSING │◀───│                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Step 2: Populate the data sources

Drag and drop circular shapes to represent data sources and connect them to the **Data Ingestion Layer** with arrows.

```
                    ⭕ Supplier APIs
                    ⭕ ERP System
                    ⭕ IoT Devices (Sensors)
┌─────────────────┐ ⭕ Market Trends API  ┌─────────────────┐
│  DATA SOURCES   │ ⭕ Weather Data API   │ DATA INGESTION  │
│                 │ ⭕ Warehouse Mgmt Sys │                 │
│                 │ ⭕ Transportation Logs│                 │
│                 │ ⭕ Quality Control    │                 │
└─────────────────┘ ⭕ Customer Orders    └─────────────────┘
                    ⭕ Regulatory DB
```

### Step 3: Design data ingestion

List the tools and mechanisms under the rectangle labeled **Data Ingestion Layer** and annotate the arrows to specify batch or real-time ingestion.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            DATA INGESTION LAYER                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────────────┐    ┌─────────────────────┐                         │
│  │   BATCH INGESTION   │    │  REAL-TIME INGESTION│                         │
│  │   ───────────────   │    │   ────────────────  │                         │
│  │ • Daily supplier    │    │ • IoT sensor data  │                         │
│  │   reports           │    │ • Shipment tracking│                         │
│  │ • Weekly inventory  │    │ • Live inventory   │                         │
│  │ • Monthly financial │    │   updates          │                         │
│  │                     │    │ • Order status     │                         │
│  │   Tools:            │    │   changes          │                         │
│  │   - Apache NiFi     │    │                     │                         │
│  │   - Talend          │    │   Tools:            │                         │
│  │   - AWS Glue        │    │   - Apache Kafka   │                         │
│  └─────────────────────┘    │   - AWS Kinesis    │                         │
│                             │   - Azure Event Hubs│                         │
│                             └─────────────────────┘                         │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Step 4: Define the storage architecture

Add cylinder shapes to represent each storage tier and establish connections to the **Data Storage** box.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                             DATA STORAGE LAYER                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐          │
│  │   ║ DATA LAKE   │    │   ║ DATA        │    │   ║ ARCHIVAL    │          │
│  │   ║ (Raw Data)  │    │   ║ WAREHOUSE   │    │   ║ STORAGE     │          │
│  │   ║             │    │   ║ (Structured)│    │   ║             │          │
│  │   ║ AWS S3      │    │   ║ Snowflake   │    │   ║ AWS Glacier │          │
│  │   ║ Hadoop HDFS │    │   ║ BigQuery    │    │   ║ Azure Archive│          │
│  │   ║ Azure Data   │    │   ║ Redshift    │    │   ║             │          │
│  │   ║   Lake       │    │   ║             │    │   ║             │          │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘          │
│                                                                               │
│  ┌─────────────────┐    ┌─────────────────┐                                  │
│  │   ║ OPERATIONAL │    │   ║ DATA MARTS  │                                  │
│  │   ║ DATABASE    │    │   ║             │                                  │
│  │   ║ PostgreSQL  │    │   ║ Procurement │                                  │
│  │   ║ MySQL       │    │   ║ Logistics   │                                  │
│  │   ║ MongoDB     │    │   ║ Finance     │                                  │
│  └─────────────────┘    └─────────────────┘                                  │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Step 5: Detail data processing

Under the **Data Processing Layer** rectangle, list the processing methods and connect the data lake to the processing layer.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DATA PROCESSING LAYER                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────────────┐    ┌─────────────────────┐                         │
│  │   ETL/ELT PIPELINES │    │  STREAM PROCESSING  │                         │
│  │   ────────────────  │    │  ─────────────────  │                         │
│  │ • Data cleaning     │    │ • Real-time alerts  │                         │
│  │ • Transformation    │    │ • Anomaly detection │                         │
│  │ • Aggregation       │    │ • Live dashboards   │                         │
│  │ • Enrichment        │    │ • Event processing  │                         │
│  │                     │    │                     │                         │
│  │   Tools:            │    │   Tools:            │                         │
│  │   - Apache Spark    │    │   - Apache Flink    │                         │
│  │   - AWS Glue        │    │   - Kafka Streams   │                         │
│  │   - dbt             │    │   - Spark Streaming │                         │
│  │   - Azure Data      │    │                     │                         │
│  │     Factory         │    │                     │                         │
│  └─────────────────────┘    └─────────────────────┘                         │
│                                                                               │
│  ┌─────────────────────┐                                                     │
│  │   BATCH PROCESSING  │                                                     │
│  │   ────────────────  │                                                     │
│  │ • Daily summaries   │                                                     │
│  │ • Monthly reports   │                                                     │
│  │ • Model training    │                                                     │
│  │                     │                                                     │
│  │   Tools:            │                                                     │
│  │   - Hadoop          │                                                     │
│  │   - AWS Batch       │                                                     │
│  │   - Google Dataflow │                                                     │
│  └─────────────────────┘                                                     │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Step 6: Map the analytics

Create rectangular shapes to represent analytics tools and connect the data warehouse to these tools.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                             ANALYTICS LAYER                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐          │
│  │   DASHBOARDS    │    │   PREDICTIVE    │    │  PRESCRIPTIVE   │          │
│  │                 │    │   ANALYTICS     │    │   ANALYTICS     │          │
│  │ • Tableau       │    │ • Demand        │    │ • Route         │          │
│  │ • Power BI      │    │   forecasting   │    │   optimization  │          │
│  │ • Looker        │    │ • Price         │    │ • Inventory     │          │
│  │ • Qlik          │    │   prediction    │    │   reordering    │          │
│  │                 │    │ • Delay         │    │ • Supplier      │          │
│  │                 │    │   prediction    │    │   selection     │          │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘          │
│                                                                               │
│  ┌─────────────────┐    ┌─────────────────┐                                 │
│  │   AD-HOC        │    │   ML MODELS     │                                 │
│  │   REPORTING     │    │                 │                                 │
│  │ • SQL queries   │    │ • Python        │                                 │
│  │ • Excel         │    │ • R             │                                 │
│  │ • Jupyter       │    │ • TensorFlow    │                                 │
│  │   Notebooks     │    │ • PyTorch       │                                 │
│  └─────────────────┘    └─────────────────┘                                 │
│                                                                               │
│  EXAMPLE DASHBOARD:                                                          │
│  ┌────────────────────────────────────────────────────┐                     │
│  │         INVENTORY OPTIMIZATION DASHBOARD           │                     │
│  ├────────────────────────────────────────────────────┤                     │
│  │ Current Stock: 45,000 units    Reorder Point: 12,000                     │
│  │ Forecast Demand (Next 30 days): 38,500 units                             │
│  │ Supplier Performance: 94% on-time delivery                               │
│  │ Cost Savings YTD: $2.3M                                                  │
│  └────────────────────────────────────────────────────┘                     │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Step 7: Illustrate data governance

Add a rectangle labeled **Data Governance** at the top and connect it to all layers.

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                              DATA GOVERNANCE LAYER                                    │
│  ┌─────────────────────────────────────────────────────────────────────────────┐     │
│  │                                                                               │     │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐              │     │
│  │  │ Data Ownership  │  │ Data Quality    │  │ Access Policies │              │     │
│  │  │ & Stewardship   │  │ Management      │  │                 │              │     │
│  │  │ • Collibra      │  │ • Great         │  │ • Okta         │              │     │
│  │  │ • Alation       │  │   Expectations  │  │ • Immuta       │              │     │
│  │  │ • Informatica   │  │ • Talend Data   │  │ • AWS IAM      │              │     │
│  │  │   Axon          │  │   Quality       │  │                │              │     │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘              │     │
│  │                                                                               │     │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐              │     │
│  │  │ Compliance &    │  │ Data Lineage    │  │ Master Data     │              │     │
│  │  │ Audit           │  │                 │  │ Management      │              │     │
│  │  │ • AWS Audit     │  │ • Apache Atlas  │  │ • Supplier MDM  │              │     │
│  │  │   Manager       │  │ • Marquez       │  │ • Product MDM   │              │     │
│  │  │ • IBM OpenPages │  │ • Collibra      │  │ • Informatica   │              │     │
│  │  │ • OneTrust      │  │   Lineage       │  │   MDM           │              │     │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘              │     │
│  │                                                                               │     │
│  └─────────────────────────────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────────────────────────┘
                                          ↑ ↓
                                          ↑ ↓
                                          ↑ ↓
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  DATA SOURCES   │───▶│ DATA INGESTION  │───▶│  DATA STORAGE   │───▶│ DATA PROCESSING │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
                                                                              │
                                                                              ↓
                                                                       ┌─────────────────┐
                                                                       │   ANALYTICS     │
                                                                       └─────────────────┘
```

### Step 8: Finalize and share the blueprint

Export the blueprint in **PDF** or **PNG** format to ensure clarity and accessibility. Then, integrate the exported file into the documentation to support the implementation process, providing stakeholders with a clear visual reference.

---

## Complete EDA Blueprint

Here's a text-based representation of the complete Enterprise Data Architecture blueprint:

```
╔══════════════════════════════════════════════════════════════════════════════════════════════════════╗
║                     ENTERPRISE DATA ARCHITECTURE BLUEPRINT - SUPPLY CHAIN COMPANY                     ║
║                         (Raw Materials for Garment Manufacturing)                                      ║
╠══════════════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                                          ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                DATA GOVERNANCE LAYER                                               │   ║
║  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │   ║
║  │  │   Ownership  │  │    Quality   │  │    Access    │  │  Compliance  │  │   Lineage    │        │   ║
║  │  │   Collibra   │  │Great Expect. │  │    Okta      │  │  AWS Audit   │  │ Apache Atlas │        │   ║
║  │  │   Alation    │  │  Talend DQ   │  │    Immuta    │  │  IBM OpenPages│  │   Marquez    │        │   ║
║  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘        │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                   │                                                     ║
║                                                   ▼                                                     ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                   DATA SOURCES LAYER                                               │   ║
║  │                                                                                                   │   ║
║  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │   ║
║  │  │    SUPPLIER  │  │      ERP     │  │      IOT     │  │    MARKET    │  │   WEATHER    │        │   ║
║  │  │    DATABASE  │  │   SYSTEM     │  │   SENSORS    │  │   TRENDS API │  │    DATA API  │        │   ║
║  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘        │   ║
║  │                                                                                                   │   ║
║  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                           │   ║
║  │  │   WAREHOUSE  │  │ TRANSPORT-   │  │   QUALITY    │  │   CUSTOMER   │                           │   ║
║  │  │   MANAGEMENT │  │   ATION LOGS │  │   CONTROL    │  │   ORDERS     │                           │   ║
║  │  │   SYSTEM     │  │              │  │              │  │              │                           │   ║
║  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘                           │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                   │                                                     ║
║                                                   ▼                                                     ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                DATA INGESTION LAYER                                                │   ║
║  │                                                                                                   │   ║
║  │  ┌─────────────────────────────────┐    ┌─────────────────────────────────┐                       │   ║
║  │  │       BATCH INGESTION           │    │       REAL-TIME INGESTION        │                       │   ║
║  │  │  ───────────────────────────    │    │  ────────────────────────────    │                       │   ║
║  │  │  • Daily supplier reports       │    │  • IoT sensor data              │                       │   ║
║  │  │  • Weekly inventory updates     │    │  • Shipment tracking            │                       │   ║
║  │  │  • Monthly financial data       │    │  • Live inventory changes       │                       │   ║
║  │  │                                 │    │  • Order status updates         │                       │   ║
║  │  │  Tools: Apache NiFi, Talend,    │    │  Tools: Apache Kafka, AWS Kinesis,                      │   ║
║  │  │        AWS Glue                  │    │        Azure Event Hubs         │                       │   ║
║  │  └─────────────────────────────────┘    └─────────────────────────────────┘                       │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                   │                                                     ║
║                                                   ▼                                                     ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                 DATA STORAGE LAYER                                                 │   ║
║  │                                                                                                   │   ║
║  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │   ║
║  │  │   DATA LAKE  │  │    DATA      │  │  OPERATIONAL │  │  DATA MARTS  │  │   ARCHIVAL   │        │   ║
║  │  │  (Raw Data)  │  │  WAREHOUSE   │  │  DATABASE    │  │              │  │   STORAGE    │        │   ║
║  │  │  ──────────  │  │  ──────────  │  │  ──────────  │  │  ──────────  │  │  ──────────  │        │   ║
║  │  │  AWS S3      │  │  Snowflake   │  │  PostgreSQL  │  │ Procurement  │  │  AWS Glacier │        │   ║
║  │  │  Hadoop HDFS │  │  BigQuery    │  │  MySQL       │  │ Logistics    │  │  Azure Archive│        │   ║
║  │  │  Azure Data  │  │  Redshift    │  │  MongoDB     │  │ Finance      │  │              │        │   ║
║  │  │    Lake      │  │              │  │              │  │              │  │              │        │   ║
║  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘        │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                   │                                                     ║
║                                                   ▼                                                     ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                DATA PROCESSING LAYER                                               │   ║
║  │                                                                                                   │   ║
║  │  ┌─────────────────────────────────┐    ┌─────────────────────────────────┐                       │   ║
║  │  │        ETL/ELT PIPELINES        │    │       STREAM PROCESSING          │                       │   ║
║  │  │  ───────────────────────────    │    │  ────────────────────────────    │                       │   ║
║  │  │  • Data cleaning                │    │  • Real-time alerts             │                       │   ║
║  │  │  • Transformation               │    │  • Anomaly detection            │                       │   ║
║  │  │  • Aggregation                  │    │  • Live dashboards              │                       │   ║
║  │  │  • Enrichment                   │    │  • Event processing             │                       │   ║
║  │  │                                 │    │                                 │                       │   ║
║  │  │  Tools: Apache Spark, AWS Glue, │    │  Tools: Apache Flink, Kafka     │                       │   ║
║  │  │        dbt, Azure Data Factory  │    │        Streams, Spark Streaming │                       │   ║
║  │  └─────────────────────────────────┘    └─────────────────────────────────┘                       │   ║
║  │                                                                                                   │   ║
║  │  ┌─────────────────────────────────┐                                                              │   ║
║  │  │        BATCH PROCESSING          │                                                              │   ║
║  │  │  ───────────────────────────    │                                                              │   ║
║  │  │  • Daily summaries              │                                                              │   ║
║  │  │  • Monthly reports              │                                                              │   ║
║  │  │  • Model training               │                                                              │   ║
║  │  │                                 │                                                              │   ║
║  │  │  Tools: Hadoop, AWS Batch,      │                                                              │   ║
║  │  │        Google Dataflow           │                                                              │   ║
║  │  └─────────────────────────────────┘                                                              │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                   │                                                     ║
║                                                   ▼                                                     ║
║  ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐   ║
║  │                                   ANALYTICS LAYER                                                  │   ║
║  │                                                                                                   │   ║
║  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                           │   ║
║  │  │  DASHBOARDS  │  │  PREDICTIVE  │  │ PRESCRIPTIVE │  │   AD-HOC     │                           │   ║
║  │  │              │  │  ANALYTICS   │  │  ANALYTICS   │  │  REPORTING   │                           │   ║
║  │  │  Tableau     │  │  Demand      │  │  Route       │  │  SQL         │                           │   ║
║  │  │  Power BI    │  │  Forecasting │  │  Optimization│  │  Excel       │                           │   ║
║  │  │  Looker      │  │  Price       │  │  Inventory   │  │  Jupyter     │                           │   ║
║  │  │  Qlik        │  │  Prediction  │  │  Reordering  │  │  Notebooks   │                           │   ║
║  │  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘                           │   ║
║  │                                                                                                   │   ║
║  │                    ┌────────────────────────────────────────────────────┐                        │   ║
║  │                    │         INVENTORY OPTIMIZATION DASHBOARD            │                        │   ║
║  │                    ├────────────────────────────────────────────────────┤                        │   ║
║  │                    │ Current Stock: 45,000 units    Reorder Point: 12,000                        │   ║
║  │                    │ Forecast Demand (Next 30 days): 38,500 units                               │   ║
║  │                    │ Supplier Performance: 94% on-time delivery                                 │   ║
║  │                    │ Cost Savings YTD: $2.3M                                                   │   ║
║  │                    └────────────────────────────────────────────────────┘                        │   ║
║  └─────────────────────────────────────────────────────────────────────────────────────────────────┘   ║
║                                                                                                          ║
╠══════════════════════════════════════════════════════════════════════════════════════════════════════╣
║  COMPLIANCE & REGULATIONS: GDPR | CCPA | ESG | ISO 27001 | HIPAA (if applicable)                        ║
║  KEY USE CASES: Inventory Forecasting | Supplier Performance | Route Optimization | Demand Matching      ║
╚══════════════════════════════════════════════════════════════════════════════════════════════════════╝
```

---

## Summary

Congratulations on completing the hands-on lab: **Create an EDA Blueprint**. In this lab, you explored how to design an enterprise data architecture blueprint for a supply chain company.

### What you accomplished:

| Task             | Activity                                                                                                  |
| ---------------- | --------------------------------------------------------------------------------------------------------- |
| **Task 1** | Understood business requirements for a garment manufacturing supply chain                                 |
|                  | Identified critical data sources (supplier DB, ERP, IoT, market trends, etc.)                             |
|                  | Defined practical use cases (inventory forecasting, supplier performance, etc.)                           |
|                  | Outlined compliance standards (GDPR, CCPA, ESG, ISO 27001)                                                |
| **Task 2** | Defined core architecture components: Data Sources, Ingestion, Storage, Processing, Analytics, Governance |
|                  | Specified tools and technologies for each layer                                                           |
| **Task 3** | Created comprehensive EDA blueprint using Lucidchart                                                      |
|                  | Illustrated data flow across all layers                                                                   |
|                  | Incorporated governance layer connecting to all components                                                |

### Key Takeaways:

1. **EDA provides a structured framework** for managing data across the enterprise
2. **Supply chain optimization** relies on integrating data from multiple sources
3. **Layered architecture** (sources → ingestion → storage → processing → analytics) ensures modularity and scalability
4. **Governance must be embedded** throughout all layers, not added as an afterthought
5. **Compliance requirements** drive design decisions for data handling and security
6. **Real-time vs. batch processing** decisions depend on business needs
7. **Analytics layer** transforms raw data into actionable business insights

### Business Value:

This EDA blueprint enables the supply chain company to:

- Gain end-to-end visibility across the entire supply chain
- Reduce costs through route optimization and inventory efficiency
- Improve supplier relationships through performance analytics
- Enhance customer satisfaction with accurate delivery forecasts
- Maintain compliance with evolving regulations
- Scale operations with a future-proof data architecture

---

## Exemplar Comparison

Here is the exemplar document for your reference.

Right-click to open the file. Please remember that the exemplar is just a point of view and not a definitive solution. Your EDA blueprint may include additional components or different tools based on your specific requirements.

---

*Lab completed: _________________*
*Instructor signature: _________________*
