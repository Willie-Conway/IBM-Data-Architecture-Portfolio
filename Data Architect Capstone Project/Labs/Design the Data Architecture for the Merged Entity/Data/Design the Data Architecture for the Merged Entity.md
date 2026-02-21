
![FutureMart](../Screenshots/FutureMart.png)

# Lab: Design the Data Architecture for the Merged Entity

## Estimated time: 60 minutes

---

## Introduction

FashionMart's acquisition of TrendyThreads has led to the formation of a new unified entity: **FutureMart**. In this lab, you will build upon the outputs of the **Lab: Evaluate Existing EDA of the Companies**, including architectural diagrams, identified strengths, and areas of improvement for both organizations.

Your task is to design a comprehensive Enterprise Data Architecture (EDA) blueprint for FutureMart that unifies the distinct architectures of both companies. This includes critically analyzing inherited data components to eliminate redundancies and bridge architectural gaps.

You will document how the new EDA addresses existing bottlenecks, inefficiencies, and integration challenges, laying the foundation for a streamlined and scalable data infrastructure.

Additionally, you will design Entity Relationship Diagrams (ERDs) and define future-state database table structures, ensuring alignment with FutureMart's business goals and data strategy.

---

## References

Right-click and select **Open link in new tab** to review the enterprise data architecture documents for FutureMart:

- [Enterprise Architectural Details of FutureMart]

---

## Tools

You can complete your tasks using any text editor, such as **Word**, **Google Docs**, or **Notepad**.

- If you install Microsoft Word, you can proceed directly with the instructions. However, if you don't have Microsoft Word, you can sign up for a free version of Microsoft 365 online. Follow [these instructions](https://support.microsoft.com/en-us/office/sign-up-for-microsoft-365-9ac1e0c7-0e6c-4f9d-8c8c-7e9b8e8c8c8c) to create your account.
- You can also use **Word Online** with a Microsoft 365 subscription or access through a free account. If you're new to Word and would like to learn how to get started, you can find helpful resources here: [Getting Started with Word Online](https://support.microsoft.com/en-us/office/get-started-with-word-online-5c8c3c3c-3c3c-4c3c-8c3c-3c3c3c3c3c3c).

You may use **Lucidchart** or any other diagramming tool for this lab. The free version of Lucidchart is sufficient. You will be responsible for any associated costs if you purchase a paid plan for Lucidchart or any other tool. Please follow [these instructions](https://www.lucidchart.com/pages/sign-up) if you have not yet signed up for a free version of the Lucidchart account.

---

## Recommendations

Before proceeding with this lab, it is suggested that you finish the following labs first:

| Lab                                                                | Purpose                                                                    |
| ------------------------------------------------------------------ | -------------------------------------------------------------------------- |
| **Create an EDA Blueprint**                                  | Provides a solid understanding of how to design an efficient EDA blueprint |
| **Prepare a Data Model for a Transaction Processing System** | Explains how to create an Entity Relation Diagram (ERD) using Lucidchart   |

---

## Part 1: Documenting the Enterprise Data Architecture (EDA) Blueprint for FutureMart

### Objective

Design a comprehensive EDA blueprint for FutureMart, incorporating key capabilities such as real-time analytics, AI-powered product recommendations, and fraud detection to enhance its competitive edge in the online marketplace. Additionally, FutureMart is migrating from physical servers to the cloud to improve scalability and resilience.

---

### Task 1.1: Identify and Define Key Architectural Layers for FutureMart

Based on the FutureMart enterprise architecture document, create a detailed EDA blueprint that captures the following layers along with the tools used at each stage, and clearly illustrate the direction of data flow:

| Layer                                         | Description                                                                                                                                 | Tools/Technologies                                                                                                                                       |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Sources**                        | Various input channels such as customer transactions (web, app, in-store), user behavior data, supplier records, and third-party data feeds | E-commerce platform, POS systems, CRM, social media, external APIs                                                                                       |
| **Data Ingestion**                      | Tools and methods used to collect and transfer data                                                                                         | Apache Kafka, AWS Kinesis, Google Pub/Sub, ETL pipelines, API Gateway (Kong, Apigee)                                                                     |
| **Data Storage**                        | Cloud-based databases and storage solutions for structured and unstructured data                                                            | Data Warehouse (Snowflake, BigQuery, Redshift), Real-time data store (Redis, DynamoDB), Cloud storage (S3, GCS), CRM (Salesforce, HubSpot), PIM (Akeneo) |
| **Data Processing**                     | Data transformation, cleaning, and aggregation techniques                                                                                   | Apache Spark, Apache Flink, dbt, Python (pandas), ETL tools (Talend, Apache Nifi)                                                                        |
| **Inventory & Supply Chain Management** | Real-time tracking of stock levels, logistics, and demand forecasting                                                                       | IMS (TradeGecko, NetSuite), OMS (Shopify Plus), WMS (Manhattan Associates), Supply Chain Analytics (Llamasoft)                                           |
| **Analytics & Reporting**               | BI tools and dashboards to support data-driven decision-making                                                                              | Tableau, Looker, Power BI, Google Analytics                                                                                                              |
| **Personalization & Engagement**        | Capture customer preferences, browsing behavior, and targeted promotions                                                                    | Personalization Engine (Dynamic Yield, Algolia), Email/Push (Klaviyo, Braze), Chatbots (Intercom), Loyalty Program (Smile.io)                            |
| **AI-based Shopping Recommendations**   | ML models to enhance product recommendations based on user activity                                                                         | AWS Personalize, TensorFlow, PyTorch, Recommendation algorithms                                                                                          |
| **Real-time Reporting**                 | Real-time analytics engine to track sales, trends, and potential fraud indicators                                                           | Apache Flink, AWS Kinesis Analytics, Real-time dashboards                                                                                                |
| **AI & Machine Learning**               | Advanced ML capabilities for personalization and optimization                                                                               | TensorFlow, PyTorch, AWS SageMaker, Dynamic Pricing AI, Sentiment Analysis tools                                                                         |
| **Cloud Infrastructure**                | Scalable infrastructure to host the platform                                                                                                | AWS, GCP, Azure, CDN (Cloudflare, CloudFront), Serverless (AWS Lambda)                                                                                   |
| **Data Governance**                     | Access controls, compliance policies, and data quality measures                                                                             | Collibra, Alation, Data Encryption, RBAC, GDPR compliance tools (OneTrust), Security monitoring (Splunk, Datadog)                                        |

---

### Task 1.2: Visualizing the EDA Blueprint for FutureMart

Create a structured blueprint diagram showcasing the flow of data across the layers using Lucidchart or any other diagramming tool of your choice.

**FutureMart EDA Blueprint Diagram:**

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                         FUTUREMART ENTERPRISE DATA ARCHITECTURE                      │
│                    (Merged Entity: FashionMart + TrendyThreads)                       │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                       │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                           DATA SOURCES LAYER                                    │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐         │   │
│  │  │ Physical     │ │ E-commerce   │ │ Customer     │ │ Inventory    │         │   │
│  │  │ Store POS    │ │ Platform     │ │ Data/CRM     │ │ Data         │         │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘         │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌───────────────────────────────────────┐ │   │
│  │  │ Marketing    │ │ External     │ │     Supplier & Third-party Data        │ │   │
│  │  │ Data         │ │ Data APIs    │ │                                         │ │   │
│  │  └──────────────┘ └──────────────┘ └───────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                         DATA INGESTION LAYER                                   │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐    ┌───────────────────┐ │   │
│  │  │  Real-time Streaming│    │  Batch ETL/ELT      │    │  API Gateway      │ │   │
│  │  │  (Kafka, Kinesis)   │    │  (Talend, Nifi, dbt)│    │  (Kong, Apigee)   │ │   │
│  │  └─────────────────────┘    └─────────────────────┘    └───────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                           DATA STORAGE LAYER                                   │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐         │   │
│  │  │ Data         │ │ Real-time    │ │ CRM          │ │ PIM          │         │   │
│  │  │ Warehouse    │ │ Data Store   │ │ (Salesforce, │ │ (Akeneo,     │         │   │
│  │  │ (Snowflake,  │ │ (Redis,      │ │  HubSpot)    │ │  Infor PIM)  │         │   │
│  │  │  BigQuery)   │ │  DynamoDB)   │ └──────────────┘ └──────────────┘         │   │
│  │  └──────────────┘ └──────────────┘ ┌───────────────────────────────────────┐ │   │
│  │                                    │        Cloud Storage                   │ │   │
│  │                                    │        (AWS S3, GCS)                   │ │   │
│  │                                    └───────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                          DATA PROCESSING LAYER                                 │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                         │   │
│  │  │  Batch Processing   │    │  Stream Processing  │                         │   │
│  │  │  (Apache Spark)     │    │  (Apache Flink)     │                         │   │
│  │  └─────────────────────┘    └─────────────────────┘                         │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                         │   │
│  │  │  Data Transformation│    │  ETL Workflows      │                         │   │
│  │  │  (dbt, pandas)      │    │  (Orchestration)    │                         │   │
│  │  └─────────────────────┘    └─────────────────────┘                         │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│            ┌───────────────────────────────┼───────────────────────────────┐       │
│            ▼                               ▼                               ▼       │
│  ┌─────────────────────┐      ┌─────────────────────┐      ┌─────────────────────┐ │
│  │  ANALYTICS &        │      │  PERSONALIZATION    │      │  INVENTORY &        │ │
│  │  REPORTING LAYER    │      │  & ENGAGEMENT       │      │  SUPPLY CHAIN       │ │
│  ├─────────────────────┤      ├─────────────────────┤      ├─────────────────────┤ │
│  │ • BI Tools          │      │ • Personalization   │      │ • IMS               │ │
│  │   (Tableau, Looker, │      │   Engine           │      │ • OMS               │ │
│  │    Power BI)        │      │ • Email/Push        │      │ • WMS              │ │
│  │ • Predictive        │      │   Notifications     │      │ • Supply Chain     │ │
│  │   Analytics         │      │ • Chatbots          │      │   Analytics        │ │
│  │ • Real-time         │      │ • Loyalty Program   │      └─────────────────────┘ │
│  │   Analytics         │      └─────────────────────┘               │              │
│  │ • Customer          │                    │                        │              │
│  │   Segmentation      │                    └────────────┬───────────┘              │
│  └─────────────────────┘                                 │                          │
│            │                                              │                          │
│            └──────────────────────────────┬───────────────┘                          │
│                                           ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                      AI & MACHINE LEARNING LAYER                               │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐    ┌───────────────────┐ │   │
│  │  │  Product            │    │  Dynamic Pricing    │    │  Sentiment        │ │   │
│  │  │  Recommendations    │    │  Engine             │    │  Analysis         │ │   │
│  │  │  (AWS Personalize,  │    │  (Dynamic Pricing   │    │  (MonkeyLearn,    │ │   │
│  │  │   TensorFlow)       │    │   AI, Pricemoov)    │    │   Lexalytics)     │ │   │
│  │  └─────────────────────┘    └─────────────────────┘    └───────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                      CLOUD INFRASTRUCTURE LAYER                                │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐    ┌───────────────────┐ │   │
│  │  │  Cloud Hosting      │    │  CDN                │    │  Serverless       │ │   │
│  │  │  (AWS, GCP, Azure)  │    │  (Cloudflare,       │    │  (AWS Lambda,     │ │   │
│  │  │                     │    │   CloudFront)       │    │   Cloud Functions)│ │   │
│  │  └─────────────────────┘    └─────────────────────┘    └───────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                        SECURITY & PRIVACY LAYER                                │   │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐         │   │
│  │  │ Data         │ │ Access       │ │ GDPR/Privacy │ │ Security     │         │   │
│  │  │ Encryption   │ │ Control      │ │ Compliance   │ │ Monitoring   │         │   │
│  │  │              │ │ (OAuth, SSO, │ │ (OneTrust,   │ │ (Splunk,     │         │   │
│  │  │              │ │  RBAC)       │ │  TrustArc)   │ │  Datadog)    │         │   │
│  │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘         │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                            │                                         │
│                                            ▼                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────┐   │
│  │                          GOVERNANCE LAYER                                      │   │
│  │  ┌─────────────────────┐    ┌─────────────────────┐                          │   │
│  │  │  Data Governance    │    │  Compliance &       │                          │   │
│  │  │  (Collibra,         │───▶│  Auditing           │                          │   │
│  │  │   Alation)          │    │  (DLP, Audit Logs)  │                          │   │
│  │  └─────────────────────┘    └─────────────────────┘                          │   │
│  └─────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                       │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

**Save the blueprint diagram as:** `FutureMartEDABluePrint.jpg`

---

## Part 2: Evaluating FutureMart's Data Architecture: Strengths and Areas for Improvement

### Objective

Assess FutureMart's enterprise data architecture by analyzing its key components. Identify strengths and areas for improvement to enhance efficiency, scalability, and security.

---

### Task 2.1: Analyze Key Architectural Components for FutureMart

Review FutureMart's architecture and select 3 components for detailed analysis.

**Selected Components for Analysis:**

1. **Scalable Data Architecture**
2. **Data Integration Capabilities**
3. **Robust Data Governance**

---

### Task 2.2: Document Strengths and Areas for Improvement for FutureMart

Use the template to document your findings.

---

## Template: FutureMart Strengths and Areas for Improvement

**Part 2: Evaluating FutureMart's Data Architecture: Strengths and Areas for Improvement**

Assess FutureMart's enterprise data architecture by analyzing its key components. Identify strengths and areas for improvement to enhance efficiency, scalability, and security. Refer to Part 2 in the lab instructions.

---

**1. Name of the enterprise:** FutureMart

**2. Strengths**

| Sr. No.     | Strength                                            | Description                                                                                                                                                                                                                                                                              | Impact                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------- | --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Highly Scalable Cloud-Native Architecture** | FutureMart leverages a modern cloud-native architecture built on AWS/GCP/Azure with components like Snowflake/BigQuery for warehousing, Kafka/Kinesis for streaming, and serverless computing (AWS Lambda). This architecture is designed from the ground up for horizontal scalability. | • Can handle growing data volumes and user traffic seamlessly `<br>`• Elastic scaling during peak shopping seasons (Black Friday, holidays)`<br>`• Reduced infrastructure management overhead `<br>`• Pay-as-you-go model optimizes costs `<br>`• Future-proof design that can incorporate new technologies easily `<br>`• Supports both the merged entity's combined data volume from both legacy companies                                                                              |
| **2** | **Unified Data Integration Across Channels**  | The architecture integrates data from both FashionMart's physical stores (POS, in-store inventory) and TrendyThreads' digital channels (e-commerce, mobile app) into a unified data platform using modern integration tools (API Gateway, Kafka, ETL pipelines).                         | • Provides a single 360-degree view of customers across all touchpoints `<br>`• Enables true omnichannel experiences (buy online, pick up in-store)`<br>`• Consistent inventory data across physical and digital channels `<br>`• Unified reporting and analytics for the entire business `<br>`• Eliminates data silos that existed in the separate companies `<br>`• Enables cross-channel marketing and personalization                                                                |
| **3** | **Advanced Analytics and AI Capabilities**    | FutureMart incorporates a comprehensive analytics stack including BI tools (Tableau, Looker), predictive analytics (AWS SageMaker), real-time analytics (Flink, Kinesis Analytics), and AI/ML capabilities for recommendations, dynamic pricing, and sentiment analysis.                 | • Data-driven decision-making across all business functions `<br>`• Personalized customer experiences drive higher conversion and loyalty `<br>`• Predictive capabilities for demand forecasting and inventory optimization `<br>`• Real-time fraud detection and security monitoring `<br>`• Competitive advantage through AI-powered features `<br>`• Continuous improvement through ML model refinement `<br>`• Enhanced customer satisfaction through personalized recommendations |

**3. Areas for Improvement**

| Sr. No.     | Area for Improvement                                      | Description                                                                                                                                                                                                                                                                                                                         | Impact                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ----------- | --------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **1** | **Complex Technology Stack Integration Challenges** | The merged architecture inherits complexity from both organizations, with a wide array of specialized tools and platforms. Integrating these diverse systems (legacy POS from FashionMart, modern cloud stack from TrendyThreads) while maintaining data consistency and real-time synchronization presents significant challenges. | • Higher operational complexity and maintenance costs `<br>`• Potential integration issues between legacy and modern systems `<br>`• Data consistency challenges during the transition period `<br>`• Requires diverse skill sets across the data team `<br>`• Extended timeline for full integration and optimization `<br>`• Risk of data discrepancies during migration `<br>`• Increased testing and validation requirements                                                                                              |
| **2** | **Data Governance Maturity Gap**                    | While TrendyThreads brings modern technology, its governance framework is immature (startup origins). FashionMart has mature governance but may have rigid processes. Merging these approaches requires establishing a federated governance model that balances control with agility, which takes time to implement effectively.    | • Risk of data quality issues during and after migration `<br>`• Potential compliance gaps if governance isn't established quickly `<br>`• Difficulty maintaining data lineage across complex integrated systems `<br>`• Inconsistent data definitions across merged business units `<br>`• Challenges in scaling governance to cover both retail and e-commerce domains `<br>`• May delay compliance certifications (GDPR, CCPA) for the merged entity `<br>`• Potential for data access and security policy inconsistencies |
| **3** | **Legacy System Phase-out Timeline**                | FashionMart's legacy systems (older POS terminals, legacy inventory systems, potentially outdated databases) cannot be replaced overnight. They must coexist with modern systems during a transition period, creating temporary technical debt and requiring bridge solutions.                                                      | • Ongoing maintenance costs for dual systems during transition `<br>`• Data synchronization challenges between old and new systems `<br>`• Limited functionality from legacy systems may constrain new capabilities `<br>`• Staff must work with both old and new systems, reducing efficiency `<br>`• Risk of data inconsistencies during the migration period `<br>`• Delayed realization of full benefits from the new architecture `<br>`• Security vulnerabilities in legacy systems must be managed                     |

---

## Part 3: Designing the FutureMart OLTP Database and ERD

### Objective

Create an Entity-Relationship Diagram (ERD) and define database structures for FutureMart's OLTP (online transaction processing) system. This system records transactions from web, app, and in-store purchases while managing customer, product, and inventory data.

---

### Task 3.1: Define Database Requirements

FutureMart's OLTP system must:

- Record all apparel sales, including price, mode of purchase (web, app, in-store)
- Track inventory levels across multiple fulfillment centers
- Manage customer information and purchase history
- Support omnichannel operations (buy online, pick up in-store, returns across channels)

---

### Task 3.2: Design the ER Diagram

**Key Entities:**

| Entity                       | Description                             | Key Attributes                                                                              |
| ---------------------------- | --------------------------------------- | ------------------------------------------------------------------------------------------- |
| **Customers**          | Individuals who purchase products       | CustomerID, Name, Email, Phone, Address, LoyaltyTier, RegistrationDate                      |
| **Products**           | Apparel items available for sale        | ProductID, SKU, Name, Description, Category, Size, Color, Price, Cost                       |
| **Inventory**          | Stock levels across fulfillment centers | InventoryID, ProductID, FulfillmentCenterID, QuantityAvailable, ReorderLevel, LastUpdated   |
| **FulfillmentCenters** | Warehouse/store locations               | CenterID, CenterName, Type (Warehouse/Store), Address, Contact                              |
| **Orders**             | Customer purchase transactions          | OrderID, CustomerID, OrderDate, TotalAmount, Status, PaymentMethod, Channel (Web/App/Store) |
| **OrderItems**         | Individual line items within orders     | OrderItemID, OrderID, ProductID, Quantity, UnitPrice, Discount                              |
| **Payments**           | Payment transactions                    | PaymentID, OrderID, Amount, PaymentMethod, TransactionID, PaymentDate, Status               |
| **Returns**            | Product returns and exchanges           | ReturnID, OrderID, ProductID, Quantity, ReturnDate, Reason, RefundAmount                    |
| **Employees**          | Staff who process in-store transactions | EmployeeID, Name, Role, StoreID, HireDate                                                   |
| **Categories**         | Product categories                      | CategoryID, CategoryName, ParentCategory, Description                                       |
| **Suppliers**          | Product vendors                         | SupplierID, SupplierName, Contact, LeadTime, PaymentTerms                                   |

**Relationships:**

| Entity 1           | Relationship | Entity 2           | Cardinality      |
| ------------------ | ------------ | ------------------ | ---------------- |
| Customers          | place        | Orders             | 1:N              |
| Orders             | contain      | OrderItems         | 1:N              |
| Products           | appear in    | OrderItems         | 1:N              |
| Products           | have         | Inventory          | 1:N              |
| FulfillmentCenters | hold         | Inventory          | 1:N              |
| Orders             | have         | Payments           | 1:1              |
| Orders             | may have     | Returns            | 1:N              |
| Products           | belong to    | Categories         | N:1              |
| Products           | supplied by  | Suppliers          | N:1              |
| Employees          | work at      | FulfillmentCenters | N:1 (for stores) |

---

### Task 3.3: Save and Document the ER Diagram

**FutureMart OLTP ERD Diagram:**

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                      FUTUREMART OLTP DATABASE - ENTITY RELATIONSHIP DIAGRAM          │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                       │
│  ┌──────────────┐         ┌──────────────┐         ┌──────────────┐                 │
│  │  Customers   │         │    Orders    │         │   Payments   │                 │
│  ├──────────────┤         ├──────────────┤         ├──────────────┤                 │
│  │PK CustomerID │─────────┤PK OrderID    │─────────┤PK PaymentID  │                 │
│  │ FirstName    │   1:N   │FK CustomerID │   1:1   │FK OrderID    │                 │
│  │ LastName     │         │ OrderDate    │         │ Amount       │                 │
│  │ Email        │         │ TotalAmount  │         │ PaymentMethod│                 │
│  │ Phone        │         │ Status       │         │ TransactionID│                 │
│  │ LoyaltyTier  │         │ Channel      │         │ PaymentDate  │                 │
│  │ RegDate      │         └──────┬───────┘         │ Status       │                 │
│  └──────────────┘                 │                 └──────────────┘                 │
│                                   │                                                  │
│                                   │1:N                                               │
│                                   │                                                  │
│                           ┌───────▼───────┐         ┌──────────────┐                 │
│                           │  OrderItems   │         │   Returns    │                 │
│                           ├───────────────┤         ├──────────────┤                 │
│                           │PK OrderItemID │─────────┤PK ReturnID   │                 │
│                           │FK OrderID     │   1:N   │FK OrderID    │                 │
│                           │FK ProductID   │         │FK ProductID  │                 │
│                           │ Quantity      │         │ Quantity     │                 │
│                           │ UnitPrice     │         │ ReturnDate   │                 │
│                           │ Discount      │         │ Reason       │                 │
│                           └───────┬───────┘         │ RefundAmount │                 │
│                                   │                  └──────────────┘                 │
│                                   │N:1                                                │
│                                   │                                                  │
│                          ┌────────▼────────┐         ┌──────────────┐                 │
│                          │    Products     │         │  Categories  │                 │
│                          ├─────────────────┤         ├──────────────┤                 │
│                          │PK ProductID     │─────────┤PK CategoryID │                 │
│                          │ SKU             │   N:1   │ CategoryName │                 │
│                          │ ProductName     │         │ ParentCategory│                 │
│                          │ Description     │         │ Description  │                 │
│                          │ CategoryID (FK) │         └──────────────┘                 │
│                          │ Size            │                                           │
│                          │ Color           │         ┌──────────────┐                 │
│                          │ Price           │─────────┤  Suppliers   │                 │
│                          │ Cost            │   N:1   ├──────────────┤                 │
│                          └────────┬────────┘         │PK SupplierID │                 │
│                                   │                  │ SupplierName │                 │
│                                   │1:N               │ Contact      │                 │
│                                   │                  │ LeadTime     │                 │
│                                   │                  │ PaymentTerms │                 │
│                                   │                  └──────────────┘                 │
│                                   ▼                                                   │
│  ┌─────────────────────────────────────────────────────────────────────────────┐     │
│  │                            Inventory                                           │     │
│  │  ┌─────────────────────────────────────────────────────────────────────────┐ │     │
│  │  │PK InventoryID │ FK ProductID │ FK FulfillmentCenterID │ Quantity │ ReorderLevel │ │     │
│  │  └─────────────────────────────────────────────────────────────────────────┘ │     │
│  └─────────────────────────────────────────────────────────────────────────────┘     │
│                                   ▲                                                   │
│                                   │                                                   │
│                                   │1:N                                                │
│                          ┌────────┴────────┐                                          │
│                          │FulfillmentCenters│                                          │
│                          ├─────────────────┤                                          │
│                          │PK CenterID      │                                          │
│                          │ CenterName      │                                          │
│                          │ Type            │                                          │
│                          │ Address         │         ┌──────────────┐                 │
│                          │ Contact         │─────────┤  Employees   │                 │
│                          └─────────────────┘   1:N   ├──────────────┤                 │
│                                                      │PK EmployeeID │                 │
│                                                      │ Name         │                 │
│                                                      │ Role         │                 │
│                                                      │FK StoreID    │                 │
│                                                      │ HireDate     │                 │
│                                                      └──────────────┘                 │
│                                                                                       │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

**Save the diagram as:** `FutureMartERdiagram.jpg`

---

### Task 3.4: Create SQL Statements for Schema Creation

Using the ER diagram developed in Task 3.2, write the SQL statements needed to create the database schema on a PostgreSQL server.

---

## SQL Schema Definition: FutureMart OLTP Database

### 1. Objective

Create a schema for FutureMart's OLTP system that manages customers, products, orders, inventory, and fulfillment across both online and physical retail channels. The system must support omnichannel operations and real-time inventory tracking.

---

### 2. Tables Overview

| Table                        | Description                                                   |
| ---------------------------- | ------------------------------------------------------------- |
| **Customers**          | Stores customer personal information and loyalty program data |
| **Categories**         | Product category hierarchy for apparel classification         |
| **Suppliers**          | Vendor information for product sourcing                       |
| **Products**           | Product catalog with apparel details (size, color, price)     |
| **FulfillmentCenters** | Warehouses and physical store locations                       |
| **Inventory**          | Real-time stock levels across fulfillment centers             |
| **Employees**          | Staff who process in-store transactions                       |
| **Orders**             | Customer order header information                             |
| **OrderItems**         | Line items within each order                                  |
| **Payments**           | Payment transactions for orders                               |
| **Returns**            | Product return and exchange records                           |

---

### 3. SQL: CREATE TABLE Statements

```sql
-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50) DEFAULT 'USA',
    LoyaltyTier VARCHAR(20) DEFAULT 'Bronze',
    RegistrationDate DATE NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(20),
    Preferences JSONB,
    IsActive BOOLEAN DEFAULT TRUE
);

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    ParentCategoryID INT,
    Description TEXT,
    FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Address TEXT,
    LeadTime INT, -- in days
    PaymentTerms VARCHAR(50),
    Rating DECIMAL(3,2),
    IsActive BOOLEAN DEFAULT TRUE
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    SKU VARCHAR(50) UNIQUE NOT NULL,
    ProductName VARCHAR(200) NOT NULL,
    Description TEXT,
    CategoryID INT,
    SupplierID INT,
    Size VARCHAR(20),
    Color VARCHAR(50),
    Material VARCHAR(100),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    ReorderLevel INT DEFAULT 10,
    IsActive BOOLEAN DEFAULT TRUE,
    CreatedDate DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create FulfillmentCenters table
CREATE TABLE FulfillmentCenters (
    CenterID INT PRIMARY KEY,
    CenterName VARCHAR(100) NOT NULL,
    CenterType VARCHAR(20) CHECK (CenterType IN ('Warehouse', 'Store', 'Distribution Center')),
    Address TEXT NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50) DEFAULT 'USA',
    ContactPhone VARCHAR(20),
    IsActive BOOLEAN DEFAULT TRUE
);

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    CenterID INT NOT NULL,
    QuantityAvailable INT DEFAULT 0,
    ReservedQuantity INT DEFAULT 0,
    ReorderLevel INT,
    ReorderQuantity INT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CenterID) REFERENCES FulfillmentCenters(CenterID),
    UNIQUE(ProductID, CenterID)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Role VARCHAR(50),
    StoreID INT,
    HireDate DATE,
    IsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (StoreID) REFERENCES FulfillmentCenters(CenterID)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(12,2) NOT NULL,
    Status VARCHAR(50) CHECK (Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Returned')),
    PaymentStatus VARCHAR(50) CHECK (PaymentStatus IN ('Pending', 'Paid', 'Failed', 'Refunded')),
    Channel VARCHAR(20) CHECK (Channel IN ('Web', 'App', 'In-Store', 'Phone')),
    ShippingAddress TEXT,
    BillingAddress TEXT,
    Notes TEXT,
    ProcessedBy INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProcessedBy) REFERENCES Employees(EmployeeID)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(10,2) DEFAULT 0,
    TotalPrice DECIMAL(12,2) GENERATED ALWAYS AS ((UnitPrice - Discount) * Quantity) STORED,
    Status VARCHAR(20) DEFAULT 'Pending',
    FulfilledFrom INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (FulfilledFrom) REFERENCES FulfillmentCenters(CenterID)
);

-- Create Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal', 'Gift Card', 'Store Credit', 'Cash')),
    TransactionID VARCHAR(100),
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    RefundAmount DECIMAL(12,2) DEFAULT 0,
    LastFourDigits VARCHAR(4),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Returns table
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    ReturnDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ReturnReason VARCHAR(200),
    Condition VARCHAR(50),
    RefundAmount DECIMAL(12,2),
    RefundMethod VARCHAR(50),
    Status VARCHAR(20) CHECK (Status IN ('Requested', 'Approved', 'Processed', 'Rejected')),
    ProcessedBy INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProcessedBy) REFERENCES Employees(EmployeeID)
);

-- Create indexes for performance
CREATE INDEX idx_orders_customer ON Orders(CustomerID);
CREATE INDEX idx_orders_date ON Orders(OrderDate);
CREATE INDEX idx_orderitems_order ON OrderItems(OrderID);
CREATE INDEX idx_orderitems_product ON OrderItems(ProductID);
CREATE INDEX idx_inventory_product ON Inventory(ProductID);
CREATE INDEX idx_inventory_center ON Inventory(CenterID);
CREATE INDEX idx_products_category ON Products(CategoryID);
CREATE INDEX idx_products_supplier ON Products(SupplierID);
CREATE INDEX idx_payments_order ON Payments(OrderID);
CREATE INDEX idx_returns_order ON Returns(OrderID);
CREATE INDEX idx_returns_product ON Returns(ProductID);
```

---

### 4. Design Assumptions / Notes

| Aspect                          | Description                                                                                                                   |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Primary Keys**          | All tables use INT as primary key type, assuming auto-increment or sequence-based generation in production                    |
| **Normalization**         | Schema follows 3NF to minimize redundancy, with Inventory serving as a junction table between Products and FulfillmentCenters |
| **Omnichannel Support**   | Orders table includes Channel field to distinguish between web, app, and in-store purchases                                   |
| **Real-time Inventory**   | Inventory table supports real-time tracking with QuantityAvailable and ReservedQuantity fields                                |
| **Product Attributes**    | Products table includes size, color, and material for apparel-specific attributes                                             |
| **Audit Trail**           | Timestamp fields (CreatedDate, LastUpdated, OrderDate, PaymentDate, ReturnDate) provide audit capabilities                    |
| **Data Integrity**        | Check constraints ensure data validity (positive quantities, valid status values)                                             |
| **Flexibility**           | JSONB field in Customers allows storing flexible customer preferences without schema changes                                  |
| **Performance**           | Indexes on foreign keys and frequently queried columns optimize query performance                                             |
| **Referential Integrity** | Foreign key constraints maintain data consistency across related tables                                                       |

---

## Summary

Congratulations on completing the **Lab: Designing the Data Architecture for FutureMart**. In this lab, you:

| Task             | Accomplishment                                                                                                                                                        |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Part 1** | Built upon architectural diagrams from FashionMart and TrendyThreads to create a comprehensive future-state EDA blueprint for the merged entity, FutureMart           |
| **Part 1** | Incorporated key capabilities including real-time analytics, AI-powered recommendations, fraud detection, and cloud-native infrastructure                             |
| **Part 2** | Identified and addressed key gaps, bottlenecks, and inefficiencies from the previous systems, ensuring a more scalable and efficient data environment                 |
| **Part 3** | Designed a new ER diagram and table structures to support FutureMart's integrated databases, laying the foundation for seamless data management across the enterprise |
| **Part 3** | Created comprehensive SQL schema definitions with proper normalization, constraints, and indexes                                                                      |

### Key Outcomes

| Outcome                        | Description                                                                               |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| **Unified Architecture** | Integrated physical retail and e-commerce data flows into a single, cohesive architecture |
| **Cloud-Native Design**  | Leveraged cloud infrastructure for scalability, resilience, and cost optimization         |
| **Omnichannel Support**  | Designed systems to support seamless customer experiences across all channels             |
| **Advanced Analytics**   | Incorporated AI/ML capabilities for personalization, recommendations, and fraud detection |
| **Robust Governance**    | Established governance framework to ensure data quality, security, and compliance         |
| **Scalable Database**    | Created normalized OLTP schema to support transaction processing across the merged entity |

---

## Deliverables Checklist

| Deliverable                                    | Filename                                               | Status |
| ---------------------------------------------- | ------------------------------------------------------ | ------ |
| FutureMart EDA Blueprint                       | `FutureMartEDABluePrint.jpg`                         | ⬜     |
| FutureMart Strengths and Areas for Improvement | `FutureMart_Strengths_and_Areas_for_Improvement.pdf` | ⬜     |
| FutureMart ER Diagram                          | `FutureMartERdiagram.jpg`                            | ⬜     |
| SQL Schema Definition                          | `SQL_Schema_Definition_Solution.txt`                 | ⬜     |

---

*Lab completed: _________________*
*Enterprise Data Architect: _________________*
*Date: _________________*
