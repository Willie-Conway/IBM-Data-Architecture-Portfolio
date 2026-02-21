
<p float="left">
    <img src="../Screenshots/TrendyThreads.png" width="300" />
    <img src="../Screenshots/FashionMart.png" width="300" />
</p>

# Lab: Evaluate Existing EDA of the Companies

## Estimated time: 60 minutes

---

## Introduction

FashionMart and TrendyThreads have different data architectures to match their business models: physical retail and virtual e-commerce. Throughout this lab, you will critically analyze their current data environments, including data sources, storage processes, and integration flows.

Critical analysis components include data governance, security, and compliance practices to measure overall system resiliency. With the use of tools such as Lucidchart, you will map current architectures and outline inefficiencies, data silos, and integration issues.

The aim is to create best practices and suggest enhancements for a more integrated, scalable, and efficient enterprise data strategy.

---

## References

Right-click and select **Open link in new tab** to review the enterprise data architecture documents for:

- [TrendyThreads Enterprise Architecture Details]
- [FashionMart Enterprise Architecture Details]

This will help you:

- Gain insights into how each company structures, stores, and manages its data
- Understand the key differences between digital-first and brick-and-mortar data architectures
- Analyze the integration challenges and opportunities in merging two distinct data ecosystems
- Identify best practices for designing a scalable and efficient enterprise data strategy

---

## Tools

You can complete your tasks using any text editor, such as **Word**, **Google Docs**, or **Notepad**.

- If you install Microsoft Word, you can proceed directly with the instructions. However, if you don't have Microsoft Word, you can sign up for a free version of Microsoft 365 online. Follow [these instructions](https://support.microsoft.com/en-us/office/sign-up-for-microsoft-365-9ac1e0c7-0e6c-4f9d-8c8c-7e9b8e8c8c8c) to create your account.
- You can also use **Word Online** with a Microsoft 365 subscription or access through a free account. If you're new to Word and would like to learn how to get started, you can find helpful resources here: [Getting Started with Word Online](https://support.microsoft.com/en-us/office/get-started-with-word-online-5c8c3c3c-3c3c-4c3c-8c3c-3c3c3c3c3c3c).

You may use **Lucidchart** or any other diagramming tool for this lab. The free version of Lucidchart is sufficient. You will be responsible for any associated costs if you purchase a paid plan for Lucidchart or any other tool. Please follow [these instructions](https://www.lucidchart.com/pages/sign-up) if you have not yet signed up for a free version of the Lucidchart account.

> **Recommendation:** Before proceeding with this lab, it is important that you finish the lab **Create an EDA Blueprint** first, as it provides a solid understanding of how to design an efficient EDA blueprint.

---

## Part 1: Documenting the Enterprise Data Architecture (EDA) Blueprint for FashionMart

### Objective

Create a comprehensive EDA blueprint for FashionMart, capturing key architectural layers, tools, and processes. The blueprint should illustrate the end-to-end data flow, ensuring a clear understanding of data movement, transformation, and security.

---

### Task 1.1: Identify and Define Key Architectural Layers for FashionMart

Based on the FashionMart enterprise architecture document, identify the following layers:

| Layer                     | Components                                                                                                                                                                         | Description                                                                                                     |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Data Sources**    | • Retail Store Data (POS)`<br>`• Online Web-Store Data`<br>`• Customer Data (Loyalty Programs)`<br>`• Supply Chain and Inventory Data`<br>`• Marketing Campaigns Data | Multiple sources across physical and digital channels, with some data silos between store and online operations |
| **Data Ingestion**  | • Data Ingestion Layer`<br>`• ETL Processes                                                                                                                                    | Batch-oriented ingestion from various sources; likely scheduled rather than real-time                           |
| **Data Storage**    | • CRM System`<br>`• Showroom Sales Database`<br>`• Data Warehouse 1 (Store/CRM/Inventory)`<br>`• Website Sales Database`<br>`• Data Warehouse 2 (Online)              | Separate databases and warehouses for physical and online operations, indicating potential data silos           |
| **Data Processing** | • Data Transformation Layer`<br>`• ETL Tools                                                                                                                                   | Processes to clean, normalize, and structure data; separate processing streams for different business units     |
| **Analytics**       | • Business Intelligence (BI) Tools`<br>`• Dashboards and Reports                                                                                                               | Reporting tools for KPIs including sales performance, customer engagement, inventory levels, and marketing ROI  |
| **Security**        | • Access Control (RBAC)`<br>`• Data Encryption                                                                                                                                 | Role-based access control for sensitive data; basic security measures                                           |

---

### Task 1.2: Visualizing the EDA Blueprint for FashionMart

Create a structured blueprint diagram showcasing the flow of data across the layers using Lucidchart.

**FashionMart EDA Blueprint Diagram:**

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                      FASHIONMART ENTERPRISE DATA ARCHITECTURE                     │
│                              (Brick-and-Mortar Retail)                             │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         DATA SOURCES LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │  Retail      │ │  Online      │ │  Customer    │ │  Supply      │    │   │
│  │  │  Store POS   │ │  Web-Store   │ │  Data/Loyalty│ │  Chain Data  │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  │  ┌────────────────────────────────────────────────────────────────────┐ │   │
│  │  │                    Marketing Campaigns Data                         │ │   │
│  │  └────────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      DATA INGESTION LAYER                                  │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                      │   │
│  │  │   Data Ingestion    │───▶│   ETL Processes     │                      │   │
│  │  │   (Batch-oriented)  │    │   (Extract,         │                      │   │
│  │  │                     │    │    Transform, Load) │                      │   │
│  │  └─────────────────────┘    └─────────────────────┘                      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         DATA STORAGE LAYER                                 │   │
│  │  ┌───────────────────────────────────┐  ┌─────────────────────────────┐  │   │
│  │  │      Physical/Store Domain        │  │       Online Domain         │  │   │
│  │  ├───────────────────────────────────┤  ├─────────────────────────────┤  │   │
│  │  │ • CRM System                      │  │ • Website Sales Database    │  │   │
│  │  │ • Showroom Sales Database         │  │ • Data Warehouse 2          │  │   │
│  │  │ • Data Warehouse 1                 │  │   (Online Analytics)        │  │   │
│  │  │   (Store/CRM/Inventory)           │  │                             │  │   │
│  │  └───────────────────────────────────┘  └─────────────────────────────┘  │   │
│  │                                                                           │   │
│  │  ┌─────────────────────────────────────────────────────────────────────┐ │   │
│  │  │                 ⚠️ DATA SILOS IDENTIFIED ⚠️                          │ │   │
│  │  │          Separate warehouses for physical and online                 │ │   │
│  │  │          Limited real-time synchronization between domains          │ │   │
│  │  └─────────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      DATA PROCESSING LAYER                                 │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                      │   │
│  │  │   Data              │───▶│   ETL Tools         │                      │   │
│  │  │   Transformation    │    │   (Cleaning,        │                      │   │
│  │  │   Layer             │    │    Normalization)   │                      │   │
│  │  └─────────────────────┘    └─────────────────────┘                      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         ANALYTICS LAYER                                    │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                      │   │
│  │  │   BI Tools          │    │   Dashboards &      │                      │   │
│  │  │   (Power BI,        │───▶│   Reports           │                      │   │
│  │  │    Tableau, Looker) │    │   • Sales KPIs      │                      │   │
│  │  └─────────────────────┘    │   • Customer Engagement                   │   │
│  │                             │   • Inventory Levels                       │   │
│  │                             │   • Marketing ROI                          │   │
│  │                             └─────────────────────┘                      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                          SECURITY LAYER                                   │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                      │   │
│  │  │   Access Control    │    │   Data Encryption   │                      │   │
│  │  │   (RBAC)            │    │                     │                      │   │
│  │  └─────────────────────┘    └─────────────────────┘                      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      INVENTORY & SUPPLY CHAIN                             │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐                     │   │
│  │  │ Inventory    │ │ Order        │ │ Warehouse    │                     │   │
│  │  │ Management   │ │ Management   │ │ Management   │                     │   │
│  │  │ System (IMS) │ │ System (OMS) │ │ System (WMS) │                     │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘                     │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

**Save the blueprint diagram as:** `FashionMartEDABluePrint.jpg`

---

## Part 2: Documenting the Enterprise Data Architecture (EDA) Blueprint for TrendyThreads

### Objective

Create a detailed EDA blueprint for TrendyThreads, incorporating data layers, tools, and processes. This blueprint will help visualize data movement, analytics capabilities, and governance strategies.

---

### Task 2.1: Define Key Architectural Layers for TrendyThreads

Based on the TrendyThreads enterprise architecture document, identify the following layers:

| Layer                                  | Components                                                                                                                                                                               | Description                                                                       |
| -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| **Data Sources**                 | • E-commerce Platform Data`<br>`• Customer Data`<br>`• Inventory Data`<br>`• Marketing Data`<br>`• External Data (Weather, Competitor Pricing, Social Media)                | Diverse, real-time sources with external data integration for market intelligence |
| **Data Ingestion**               | • ETL Layer`<br>`• API Gateway`<br>`• Data Streaming (Kafka, Kinesis)`<br>`• Data Transformation                                                                               | Real-time and batch ingestion capabilities with modern streaming technologies     |
| **Data Storage**                 | • CRM`<br>`• PIM`<br>`• Data Warehouse (Snowflake, BigQuery, Redshift)`<br>`• Real-time Data Store (Kafka, Redis, DynamoDB)`<br>`• Cloud Storage (S3, GCS)                  | Modern, cloud-native storage with specialized systems for different use cases     |
| **Data Processing**              | • ETL Workflows`<br>`• Real-time Streaming`<br>`• Batch Processing`<br>`• Data Transformation (Spark, pandas, dbt)                                                             | Advanced processing capabilities supporting both real-time and batch workloads    |
| **Analytics**                    | • BI Tools (Tableau, Looker, Power BI)`<br>`• Predictive Analytics (SageMaker, AI Platform)`<br>`• Real-time Analytics (Flink, Kinesis Analytics)`<br>`• Customer Segmentation | Comprehensive analytics stack with ML capabilities                                |
| **Personalization & Engagement** | • Personalization Engine`<br>`• Email/Push Notifications`<br>`• Chatbots`<br>`• Loyalty Program                                                                                | AI-driven customer engagement tools                                               |
| **Security**                     | • Data Encryption`<br>`• Access Control`<br>`• GDPR Compliance`<br>`• Security Monitoring                                                                                      | Robust security with privacy compliance                                           |
| **Governance**                   | • Data Governance (Collibra, Alation)`<br>`• Compliance & Auditing (DLP, Audit Logs)                                                                                                 | Formal governance framework                                                       |

---

### Task 2.2: Visualizing the EDA Blueprint for TrendyThreads

Create a structured blueprint diagram showcasing the flow of data across the architectural layers.

**TrendyThreads EDA Blueprint Diagram:**

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                     TRENDYTHREADS ENTERPRISE DATA ARCHITECTURE                   │
│                              (Digital-First E-tailer)                             │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         DATA SOURCES LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │ E-commerce   │ │ Customer     │ │ Inventory    │ │ Marketing    │    │   │
│  │  │ Platform     │ │ Data         │ │ Data         │ │ Data         │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  │  ┌────────────────────────────────────────────────────────────────────┐ │   │
│  │  │                    External Data Sources                             │ │   │
│  │  │         (Weather, Competitor Pricing, Social Media)                 │ │   │
│  │  └────────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      DATA INGESTION LAYER                                  │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │ ETL Layer    │ │ API Gateway  │ │ Data Streaming│ │ Data         │    │   │
│  │  │ (Talend,     │ │ (AWS API     │ │ (Kafka,       │ │Transformation│    │   │
│  │  │  Nifi, dbt)  │ │  Gateway,    │ │  Kinesis,     │ │ (Spark, dbt) │    │   │
│  │  │              │ │  Kong)       │ │  Pub/Sub)     │ │              │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  │  ┌────────────────────────────────────────────────────────────────────┐ │   │
│  │  │              Real-time + Batch Ingestion Capabilities               │ │   │
│  │  └────────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         DATA STORAGE LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │ CRM          │ │ PIM          │ │ Data         │ │ Real-time    │    │   │
│  │  │ (Salesforce, │ │ (Akeneo,     │ │ Warehouse    │ │ Data Store   │    │   │
│  │  │  HubSpot)    │ │  Infor PIM)  │ │ (Snowflake,  │ │ (Kafka,      │    │   │
│  │  │              │ │              │ │  BigQuery,   │ │  Redis,      │    │   │
│  │  │              │ │              │ │  Redshift)   │ │  DynamoDB)   │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  │  ┌────────────────────────────────────────────────────────────────────┐ │   │
│  │  │                 Cloud Storage (AWS S3, GCS)                         │ │   │
│  │  └────────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                      DATA PROCESSING LAYER                                 │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │ ETL Workflows│ │ Real-time    │ │ Batch        │ │ Data         │    │   │
│  │  │              │ │ Streaming    │ │ Processing   │ │Transformation│    │   │
│  │  │              │ │ (Flink,      │ │ (Spark)      │ │ (dbt,        │    │   │
│  │  │              │ │  Kinesis)    │ │              │ │  pandas)     │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│            ┌─────────────────────────────┼─────────────────────────────┐       │
│            ▼                             ▼                             ▼       │
│  ┌───────────────────┐       ┌───────────────────┐       ┌───────────────────┐ │
│  │    ANALYTICS      │       │ PERSONALIZATION  │       │   INVENTORY &      │ │
│  │      LAYER        │       │  & ENGAGEMENT    │       │ SUPPLY CHAIN       │ │
│  ├───────────────────┤       ├───────────────────┤       ├───────────────────┤ │
│  │ • BI Tools        │       │ • Personalization │       │ • IMS             │ │
│  │   (Tableau,       │       │   Engine         │       │ • OMS             │ │
│  │    Looker,        │       │ • Email/Push     │       │ • WMS             │ │
│  │    Power BI)      │       │   Notifications  │       │ • Supply Chain    │ │
│  │ • Predictive      │       │ • Chatbots       │       │   Analytics       │ │
│  │   Analytics       │       │ • Loyalty        │       └───────────────────┘ │
│  │ • Real-time       │       │   Program        │               │             │
│  │   Analytics       │       └───────────────────┘               │             │
│  │ • Customer        │               │                           │             │
│  │   Segmentation    │               └───────────────┬───────────┘             │
│  └───────────────────┘                               │                         │
│            │                                         │                         │
│            └─────────────────────┬───────────────────┘                         │
│                                  ▼                                               │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                          SECURITY LAYER                                    │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │   │
│  │  │ Data         │ │ Access       │ │ GDPR/Privacy │ │ Security     │    │   │
│  │  │ Encryption   │ │ Control      │ │ Compliance   │ │ Monitoring   │    │   │
│  │  │              │ │ (OAuth, SSO, │ │ (OneTrust,   │ │ (Splunk,     │    │   │
│  │  │              │ │  RBAC)       │ │  TrustArc)   │ │  Datadog)    │    │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘    │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                          │                                       │
│                                          ▼                                       │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                         GOVERNANCE LAYER                                   │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                      │   │
│  │  │   Data Governance   │    │   Compliance &      │                      │   │
│  │  │   (Collibra,        │───▶│   Auditing          │                      │   │
│  │  │    Alation)         │    │   (DLP, Audit Logs) │                      │   │
│  │  └─────────────────────┘    └─────────────────────┘                      │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

**Save the blueprint diagram as:** `TrendyThreadsEDABluePrint.jpg`

---

## Part 3: Evaluating FashionMart's Data Architecture: Strengths and Areas for Improvement

### Objective

Assess FashionMart's EDA by identifying its strengths and areas for improvement across key architectural components.

---

### Task 3.1: Analyze Key Architectural Components for FashionMart

Review FashionMart's architecture and select 3 components for detailed analysis.

**Selected Components for Analysis:**

1. **Data Silos**
2. **Legacy Systems**
3. **Data Integration Capabilities**

---

### Task 3.2: Document Strengths and Areas for Improvement for FashionMart

Use the template to document your findings.

---

## Template: FashionMart Strengths and Areas for Improvement

**Part 3: Evaluating FashionMart's Data Architecture**

**1. Name of the enterprise:** FashionMart

**2. Strengths**

| Sr. No.     | Strength                                  | Description                                                                                                                                                              | Impact                                                                                                                   |
| ----------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| **1** | **Established Data Infrastructure** | FashionMart has mature, operational data systems including CRM, POS databases, and data warehouses that have been refined over decades of retail operations.             | Provides stability and reliability for core business operations; staff are familiar with existing systems and processes. |
| **2** | **Comprehensive Data Collection**   | The company collects data from multiple touchpoints including physical stores (POS), online web-store, customer loyalty programs, supply chain, and marketing campaigns. | Enables multi-faceted analysis of business performance across different channels.                                        |
| **3** | **Clear Separation of Concerns**    | Separate data warehouses for physical/store operations and online operations allow each domain to optimize their specific analytics needs.                               | Domain-specific optimization enables tailored reporting and performance tuning for different business units.             |

**3. Areas for Improvement**

| Sr. No.     | Area for Improvement                                        | Description                                                                                                                                                                                                           | Impact                                                                                                                                                                                                                                                                                                                         |
| ----------- | ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **1** | **Data Silos Between Physical and Online Operations** | FashionMart maintains separate databases and data warehouses for physical stores (Data Warehouse 1) and online operations (Data Warehouse 2). These systems are not fully integrated, creating isolated data pockets. | • Prevents a unified 360-degree view of customers who shop both online and in-store`<br>`• Inconsistent reporting across channels`<br>`• Unable to track complete customer journey`<br>`• Hinders omnichannel marketing and personalization efforts                                                                  |
| **2** | **Legacy Systems Impacting Integration**              | Older systems (legacy POS, legacy inventory management) are not fully integrated with newer architecture components. This leads to data discrepancies and manual reconciliation efforts.                              | • Data inconsistencies between systems`<br>`• Manual data reconciliation required`<br>`• Slows down data processing and reporting`<br>`• Limits scalability and ability to adopt modern technologies`<br>`• Increases maintenance costs                                                                           |
| **3** | **Limited Real-time Data Integration**                | Current architecture relies primarily on batch-oriented ETL processes with limited real-time data streaming capabilities. Data from stores and online channels is not synchronized in real-time.                      | • Inventory levels may be inaccurate between online and store systems`<br>`• Cannot provide real-time inventory availability to customers`<br>`• Delayed insights for business decision-making`<br>`• Inability to respond quickly to market changes`<br>`• Customer experience suffers from outdated information |

---

## Part 4: Evaluating TrendyThreads' Data Architecture: Strengths and Areas for Improvement

### Objective

Conduct a detailed assessment of TrendyThreads' enterprise data architecture by analyzing its core components. Identify strengths and areas for improvement to optimize performance, scalability, and security.

---

### Task 4.1: Analyze Key Architectural Components for TrendyThreads

Review TrendyThreads' architecture and select 3 components for detailed analysis.

**Selected Components for Analysis:**

1. **Scalable Data Architecture**
2. **Data Governance**
3. **Data Integration Capabilities**

---

### Task 4.2: Document Strengths and Areas for Improvement for TrendyThreads

Use the template to document your findings.

---

## Template: TrendyThreads Strengths and Areas for Improvement

**Part 4: Evaluating TrendyThreads' Data Architecture**

**1. Name of the enterprise:** TrendyThreads

**2. Strengths**

| Sr. No.     | Strength                                             | Description                                                                                                                                                                                                                  | Impact                                                                                                                                                                                                                                                                                                                                  |
| ----------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Modern, Cloud-Native Architecture**          | TrendyThreads has built its data infrastructure using modern cloud-native technologies including data warehouses (Snowflake/BigQuery/Redshift), real-time data stores (Kafka, Redis, DynamoDB), and cloud storage (S3, GCS). | • Highly scalable to handle growing data volumes`<br>`• Flexible and adaptable to changing business needs`<br>`• Supports both real-time and batch processing`<br>`• Reduced infrastructure management overhead`<br>`• Enables innovation through access to cutting-edge cloud services                                    |
| **2** | **Real-time Data Processing Capabilities**     | The architecture includes robust real-time data streaming using technologies like Apache Kafka, AWS Kinesis, and Apache Flink for processing live data streams.                                                              | • Enables instant personalization and recommendations`<br>`• Real-time inventory tracking across channels`<br>`• Immediate fraud detection and security monitoring`<br>`• Live analytics for business decision-making`<br>`• Enhanced customer experience through real-time interactions                                   |
| **3** | **Comprehensive Analytics and ML Integration** | TrendyThreads has integrated advanced analytics capabilities including BI tools, predictive analytics (AWS SageMaker, Google AI Platform), real-time analytics, and customer segmentation using AI/ML.                       | • Data-driven decision making across the organization`<br>`• Personalized customer experiences drive engagement and sales`<br>`• Predictive capabilities for demand forecasting and pricing optimization`<br>`• Competitive advantage through advanced analytics`<br>`• Continuous improvement through ML model refinement |

**3. Areas for Improvement**

| Sr. No.     | Area for Improvement                                    | Description                                                                                                                                                                                                                                    | Impact                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Immature Data Governance Framework**            | As a startup-origin company, TrendyThreads has focused more on innovation and speed than on formal data governance. While tools like Collibra and Alation are mentioned, governance policies may not be fully mature or consistently enforced. | • Risk of data quality issues as data volumes grow`<br>`• Potential compliance gaps with regulations (GDPR, CCPA)`<br>`• Difficulty in maintaining data lineage and audit trails`<br>`• Inconsistent data definitions across teams`<br>`• Challenges in scaling governance as the company grows`<br>`• May complicate integration with more mature organizations like FashionMart |
| **2** | **Complex Technology Stack**                      | The architecture includes a wide array of specialized tools (Kafka, Flink, Spark, multiple databases, multiple analytics platforms) which increases system complexity and requires diverse expertise.                                          | • Higher operational complexity and maintenance costs`<br>`• Requires broad skill sets across the data team`<br>`• Potential integration challenges between components`<br>`• Increased attack surface for security vulnerabilities`<br>`• May slow down development due to complexity`<br>`• Difficult to troubleshoot issues across the stack                                   |
| **3** | **Potential Data Silos from Specialized Systems** | While the architecture is modern, the use of specialized systems for different use cases (CRM, PIM, data warehouse, real-time store, cloud storage) can create logical data silos if not properly integrated with a unified data fabric.       | • Data may be duplicated across systems`<br>`• Inconsistent data if synchronization fails`<br>`• Complex data lineage tracking`<br>`• Challenges in creating a unified customer view`<br>`• Potential for inconsistent reporting across platforms`<br>`• Increased ETL/ELT complexity to consolidate data                                                                         |

---

## Summary

Congratulations on completing this Lab: Evaluating Existing EDA of the companies. In this lab, you've:

| Task             | Accomplishment                                                                                                                                                                       |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Part 1** | Designed comprehensive EDA blueprint for FashionMart, mapping data sources, ingestion, storage, processing, analytics, and security layers                                           |
| **Part 2** | Created detailed EDA blueprint for TrendyThreads, incorporating modern digital capabilities including real-time processing, personalization, and governance                          |
| **Part 3** | Evaluated FashionMart's architecture, identifying strengths in established infrastructure and areas for improvement in data silos, legacy systems, and integration                   |
| **Part 4** | Assessed TrendyThreads' architecture, highlighting strengths in cloud-native design and real-time capabilities, while identifying areas for improvement in governance and complexity |

These blueprints and assessments will serve as foundational documents for the subsequent phases of the merger project, guiding the design of FutureMart's integrated enterprise data architecture.

---

## Deliverables Checklist

| Deliverable                 | Filename                                                  | Status |
| --------------------------- | --------------------------------------------------------- | ------ |
| FashionMart EDA Blueprint   | `FashionMartEDABluePrint.jpg`                           | ⬜     |
| TrendyThreads EDA Blueprint | `TrendyThreadsEDABluePrint.jpg`                         | ⬜     |
| FashionMart Assessment      | `FashionMart_Strengths_and_Areas_for_Improvement.pdf`   | ⬜     |
| TrendyThreads Assessment    | `TrendyThreads_Strengths_and_Areas_for_Improvement.pdf` | ⬜     |

---

*Lab completed: _________________*
*Enterprise Data Architect: _________________*
*Date: _________________*
