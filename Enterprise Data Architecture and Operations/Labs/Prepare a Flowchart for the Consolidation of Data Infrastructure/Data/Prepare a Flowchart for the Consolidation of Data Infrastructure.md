# Lab: Prepare a Flowchart for the Consolidation of Data Infrastructure

## Estimated time: 30 minutes

---

## Learning objectives

After completing this lab, you will be able to:

- Illustrate the steps to consolidate dispersed data silos into an integrated and secure data infrastructure
- Highlight key aspects of data storage, integration, quality, and privacy management within a governed data framework

---

## Prerequisites

For this lab, you can use **Lucidchart**. You only need the free version of LucidChart. If you choose to purchase a paid plan, you will be responsible for any associated charges. If you've not yet signed up for the free account, you can follow the instructions to get started. You may alternatively use applications like **Microsoft Visio** or **draw.io**.

---

## Introduction

Flowcharts are essential in integrating data silos into a single infrastructure because they provide clear, visual steps breaking down the complexity of any task. They improve communication, facilitate the alignment of stakeholders, and ensure systematic integration and quality checks concerning privacy.

Thus, flowcharts enable the identification of inefficiencies, regulatory compliance, and simplification in audits and serve as blueprints for future upgrades by visualizing dependencies and workflows, streamlining collaboration, troubleshooting, and ensuring the amalgamation process becomes efficient and scalable.

---

## Scenario overview

A FinTech bank, **FinEdge**, has grown rapidly, offering digital banking, lending, and financial advisory services. However, its data infrastructure is fragmented, storing customer and transaction data across multiple siloed systems. This has led to:

| Challenge                                    | Impact                                           |
| -------------------------------------------- | ------------------------------------------------ |
| **Inconsistent reporting**             | Different departments report conflicting numbers |
| **Data duplication**                   | Customer information stored in multiple systems  |
| **High operational costs**             | Maintaining multiple redundant systems           |
| **Regulatory compliance difficulties** | Difficulty tracking data lineage and access      |
| **Poor decision-making**               | Lack of unified view of customers and operations |

FinEdge aims to consolidate its data infrastructure into a **centralized cloud-based platform** to address these challenges. By integrating data from all departments, standardizing reporting with a unified BI tool, and implementing strong data governance, the bank can enhance decision-making, ensure compliance, and reduce costs, positioning itself for scalable growth and innovation.

---

## Exercise: Prepare a flowchart for consolidation of data infrastructure for a fintech bank using Lucidchart

In this lab, you will create a detailed flowchart for consolidating dispersed data silos of a fintech bank into a unified, secure, and governed data infrastructure. The flowchart will help you navigate significant steps such as optimization of data storage, integration of systems, quality control of data, and privacy management protocols. You will design a step-by-step instructional visual for the consolidation process that will assist in the specification of clear, structured, and coordinated design to optimize efficiency, consistency, and compliance in the data infrastructure.

### Let's begin!

---

## Step 1: Identify and categorize existing data silos

**Objective:** Understand where the bank's data currently resides and its formats

### Flowchart representation:

1. Create a section titled **"Data Sources"** at the top of your flowchart
2. Within this section, add **circular nodes** for each data silo:

| Node Label                     | Description                                     |
| ------------------------------ | ----------------------------------------------- |
| **Customer Database**    | Personal information, KYC data, contact details |
| **Payment Gateway Data** | Transaction records, payment history            |
| **Loan Applications**    | Loan requests, credit scores, approval status   |
| **Account Balances**     | Current and savings account balances            |
| **Mobile App Logs**      | User behavior, app usage analytics              |
| **Regulatory Reports**   | Compliance filings, audit trails                |

### Visual representation:

```
┌─────────────────────────────────────────────────────────────┐
│                       DATA SOURCES                           │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│    ⭕ Customer        ⭕ Payment         ⭕ Loan               │
│    Database          Gateway Data      Applications         │
│                                                               │
│    ⭕ Account         ⭕ Mobile App      ⭕ Regulatory         │
│    Balances          Logs              Reports              │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

This structure ensures clarity by categorizing and visually organizing the various data sources feeding into the unified infrastructure.

---

## Step 2: Define data ingestion mechanisms

**Objective:** Establish how data from silos will be ingested into a consolidated infrastructure

### Flowchart representation:

1. Add a **rectangular node** labeled **"Data Ingestion Layer"** below the Data Sources section
2. Connect each data silo node to this layer using **arrows** to indicate data flow
3. Add a **diamond-shaped node** labeled **"Validation Checks"** connected to the Data Ingestion Layer

### Visual representation:

```
┌─────────────────────────────────────────────────────────────┐
│                       DATA SOURCES                           │
├─────────────────────────────────────────────────────────────┤
│    ⭕ Customer        ⭕ Payment         ⭕ Loan               │
│      Database          Gateway Data      Applications        │
│         ↓                 ↓                 ↓                │
└─────────┼─────────────────┼─────────────────┼──────────────┘
          │                 │                 │
          └─────────────────┼─────────────────┘
                            ↓
              ┌─────────────────────────┐
              │   Data Ingestion Layer   │
              │  (Batch & Streaming)     │
              └───────────┬─────────────┘
                          ↓
              ┌─────────────────────────┐
              │   Validation Checks      │
              │ • Format validation      │
              │ • Completeness check     │
              │ • Schema validation      │
              └─────────────────────────┘
```

This setup clearly depicts the transition from raw data sources to the quality assurance stage.

---

## Step 3: Design data storage architecture

**Objective:** Consolidate data into centralized storage systems while maintaining scalability

### Flowchart representation:

1. Add **cylindrical nodes** to represent storage solutions:
   - **Data Lake (Raw Data)** - Stores raw, unprocessed data
   - **Data Warehouse (Structured Data)** - Stores processed, structured data
2. Connect the **Validation Checks** node to these storage nodes

### Visual representation:

```
                      ┌─────────────────────────┐
                      │   Validation Checks      │
                      │ • Format validation      │
                      │ • Completeness check     │
                      │ • Schema validation      │
                      └────────────┬────────────┘
                                   │
                    ┌──────────────┼──────────────┐
                    ↓              ↓              ↓
        ┌───────────────────┐ ┌───────────────────┐
        │                   │ │                   │
        │   Data Lake       │ │  Data Warehouse   │
        │   (Raw Data)      │ │  (Structured)     │
        │                   │ │                   │
        │ • JSON, XML       │ │ • Star schema     │
        │ • Logs            │ │ • Denormalized    │
        │ • Images          │ │ • Aggregated      │
        └───────────────────┘ └───────────────────┘
```

This visual structure highlights the transition from the quality assurance stage to designated storage layers, ensuring secure management of both raw and structured data for further use.

---

## Step 4: Incorporate data integration

**Objective:** Enable interoperability and seamless flow of data across systems

### Flowchart representation:

1. Add **rectangular nodes** labeled:
   - **ETL/ELT Tools** - Extract, Transform, Load processes
   - **Integration APIs** - System connectivity interfaces
2. Connect storage nodes to these integration tools

### Visual representation:

```
┌───────────────────┐      ┌───────────────────┐
│   Data Lake       │      │  Data Warehouse   │
│   (Raw Data)      │      │  (Structured)     │
└─────────┬─────────┘      └─────────┬─────────┘
          │                          │
          └────────────┬─────────────┘
                       ↓
          ┌─────────────────────────┐
          │     ETL/ELT Tools        │
          │ • Apache Spark          │
          │ • AWS Glue              │
          │ • dbt                   │
          └────────────┬────────────┘
                       ↓
          ┌─────────────────────────┐
          │   Integration APIs       │
          │ • REST APIs             │
          │ • GraphQL               │
          │ • Message queues        │
          └─────────────────────────┘
```

This setup highlights how integration tools facilitate seamless data movement and preparation for downstream applications and systems.

---

## Step 5: Ensure data security and privacy

**Objective:** Protect sensitive financial data throughout the consolidation process

### Flowchart representation:

1. Add **shield-shaped nodes** labeled:
   - **Encryption Layer** - Data encryption at rest and in transit
   - **Access Controls** - Authentication and authorization
2. Connect these nodes to storage layers and integration tools

### Visual representation:

```
                    ┌─────────────────────┐
                    │  Encryption Layer    │
                    │ • AES-256 at rest   │
                    │ • TLS 1.3 in transit│
                    └──────────┬──────────┘
                               │
         ┌─────────────────────┼─────────────────────┐
         ↓                     ↓                     ↓
┌───────────────────┐  ┌───────────────────┐  ┌───────────────────┐
│   Data Lake       │  │  Data Warehouse   │  │  Integration APIs │
└───────────────────┘  └───────────────────┘  └───────────────────┘
         ↑                     ↑                     ↑
         └─────────────────────┼─────────────────────┘
                               │
                    ┌──────────┴──────────┐
                    │   Access Controls    │
                    │ • RBAC              │
                    │ • MFA               │
                    │ • Row-level security│
                    └─────────────────────┘
```

This setup highlights how encryption and access controls are applied at critical stages to ensure data security, privacy, and restricted access throughout the consolidation process.

---

## Step 6: Establish metadata management

**Objective:** Document and maintain information about data assets for discoverability and governance

### Flowchart representation:

1. Add a **rectangular node** labeled **"Metadata Repository"**
2. Connect this node to storage layers

### Visual representation:

```
┌───────────────────┐      ┌───────────────────┐
│   Data Lake       │      │  Data Warehouse   │
└─────────┬─────────┘      └─────────┬─────────┘
          │                          │
          └────────────┬─────────────┘
                       ↓
          ┌─────────────────────────┐
          │  Metadata Repository     │
          ├─────────────────────────┤
          │ • Data lineage          │
          │ • Data dictionary       │
          │ • Business glossary     │
          │ • Ownership tracking    │
          │ • Schema evolution      │
          └─────────────────────────┘
```

This setup highlights the role of metadata in enhancing data governance, traceability, and overall management within the consolidated infrastructure.

---

## Step 7: Address data quality management

**Objective:** Ensure data accuracy, completeness, and consistency

### Flowchart representation:

1. Add **diamond-shaped nodes** labeled **"Data Quality Checks"** at multiple stages
2. Connect these nodes to both ingestion and storage layers

### Visual representation:

```
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ Data Sources     │───▶│ Data Ingestion   │───▶│ Data Quality     │
│                  │    │ Layer            │    │ Checks (Stage 1) │
└──────────────────┘    └──────────────────┘    └────────┬─────────┘
                                                          │
                                                          ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ Data Lake        │◀──▶│ Data Warehouse   │◀──▶│ Data Quality     │
│                  │    │                  │    │ Checks (Stage 2) │
└──────────────────┘    └──────────────────┘    └────────┬─────────┘
                                                          │
                                                          ▼
                                               ┌──────────────────┐
                                               │ Data Quality     │
                                               │ Dashboard        │
                                               │ • Scorecards     │
                                               │ • Alerts         │
                                               │ • Remediation    │
                                               └──────────────────┘
```

**Quality Check Details:**

| Check Type                  | Stage     | Description                         |
| --------------------------- | --------- | ----------------------------------- |
| **Format validation** | Ingestion | Ensure data matches expected format |
| **Completeness**      | Ingestion | Check for missing required fields   |
| **Uniqueness**        | Storage   | Identify duplicate records          |
| **Accuracy**          | Storage   | Validate against reference data     |
| **Timeliness**        | Storage   | Check data freshness                |

This setup emphasizes how data quality is enforced during ingestion and after storage, maintaining the integrity of the consolidated data infrastructure.

---

## Step 8: Prepare for reporting and analytics

**Objective:** Enable advanced analytics and reporting for decision-making and compliance

### Flowchart representation:

1. Add **rectangular nodes** labeled:
   - **BI Tools** - Business intelligence and analytics
   - **Regulatory Reporting** - Compliance reporting systems
2. Connect these nodes to the Data Warehouse

### Visual representation:

```
                                   ┌─────────────────────┐
                                   │  Data Warehouse     │
                                   │  (Structured Data)  │
                                   └──────────┬──────────┘
                                              │
                    ┌─────────────────────────┼─────────────────────────┐
                    ↓                         ↓                         ↓
        ┌───────────────────────┐ ┌───────────────────────┐ ┌───────────────────────┐
        │      BI Tools         │ │  Regulatory Reporting │ │   Data Science       │
        ├───────────────────────┤ ├───────────────────────┤ ├───────────────────────┤
        │ • Tableau             │ │ • Basel III          │ │ • Python/R           │
        │ • Power BI            │ │ • SOX compliance     │ │ • ML models          │
        │ • Looker              │ │ • Audit reports      │ │ • Predictive analytics│
        │ • Executive dashboards│ │ • Regulatory filings  │ │ • Customer 360       │
        └───────────────────────┘ └───────────────────────┘ └───────────────────────┘
```

This setup highlights the data warehouse's role in supporting decision-making and compliance by providing accurate, accessible data to downstream applications.

---

## Step 9: Finalize the flowchart

**Objective:** Ensure the flowchart is complete and accurately represents the data consolidation process

### Flowchart representation:

Add final elements to complete the visualization:

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                         COMPLETE DATA CONSOLIDATION FLOWCHART                        │
│                                      FinEdge Bank                                     │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                       │
│  [Step 1]                     [Step 2]                    [Step 3]                  │
│  ┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐        │
│  │  DATA SOURCES   │────────▶│    INGESTION    │────────▶│    STORAGE      │        │
│  │  • 6 silos      │         │  • Batch/Stream │         │  • Data Lake    │        │
│  │  • Dispersed    │         │  • Validation   │         │  • Data Warehouse│        │
│  └─────────────────┘         └─────────────────┘         └─────────────────┘        │
│                                         │                       │                    │
│                                         ▼                       ▼                    │
│  [Step 4]                    [Step 5]                    [Step 6]                  │
│  ┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐        │
│  │  INTEGRATION    │◀───────▶│   SECURITY      │◀───────▶│   METADATA      │        │
│  │  • ETL/ELT      │         │  • Encryption   │         │  • Repository   │        │
│  │  • APIs         │         │  • Access Ctrl  │         │  • Lineage      │        │
│  └─────────────────┘         └─────────────────┘         └─────────────────┘        │
│         │                            │                            │                  │
│         └────────────────────────────┼────────────────────────────┘                  │
│                                      ▼                                               │
│  [Step 7]                    [Step 8]                                               │
│  ┌─────────────────┐         ┌─────────────────┐                                    │
│  │   DATA QUALITY  │────────▶│ REPORTING &     │                                    │
│  │  • Stage 1 & 2  │         │   ANALYTICS     │                                    │
│  │  • Dashboard    │         │  • BI Tools     │                                    │
│  └─────────────────┘         │  • Regulatory   │                                    │
│                              └─────────────────┘                                    │
│                                                                                       │
├─────────────────────────────────────────────────────────────────────────────────────┤
│                                      LEGEND                                           │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐                   │
│  │  Data   │  │ Process │  │Decision │  │Storage  │  │Security │                   │
│  │ Source  │  │  Step   │  │  Point  │  │         │  │ Control │                   │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘  └─────────┘                   │
│                                                                                       │
│  Created: _______________   Version: 1.0   Approved: _______________                │
└─────────────────────────────────────────────────────────────────────────────────────┘
```

### Review & validate:

- **Engage stakeholders** to review the flowchart and provide feedback
- **Verify each step** aligns with business requirements
- **Check for missing connections** or dependencies

### Annotate nodes:

Add tooltips or notes describing the functionality of each component:

| Component                     | Annotation                                      |
| ----------------------------- | ----------------------------------------------- |
| **Data Sources**        | Six source systems identified for consolidation |
| **Validation Checks**   | Ensures data quality before storage             |
| **Encryption Layer**    | AES-256 for data at rest, TLS 1.3 in transit    |
| **Metadata Repository** | Tracks data lineage for regulatory compliance   |

### Enhance clarity:

Include a **legend** to define symbols, processes, and data flows:

| Symbol       | Meaning                   |
| ------------ | ------------------------- |
| ⭕ Circle    | Data source               |
| ▭ Rectangle | Process or system         |
| ◇ Diamond   | Decision or quality check |
| ▭ Cylinder  | Storage system            |
| ⬠ Shield    | Security control          |
| → Arrow     | Data flow direction       |

This setup ensures the flowchart is well-documented, easy to interpret, and aligned with stakeholder expectations.

---

## Complete Flowchart Summary

Here's a text-based representation of the complete flowchart:

```
╔═══════════════════════════════════════════════════════════════════════════════════╗
║                       DATA CONSOLIDATION FLOWCHART - FINEDGE BANK                  ║
╠═══════════════════════════════════════════════════════════════════════════════════╣
║                                                                                     ║
║  PHASE 1: DISCOVERY                      PHASE 2: INTEGRATION                      ║
║  ┌──────────────────────┐                ┌──────────────────────┐                  ║
║  │  DATA SOURCES        │                │  DATA INGESTION      │                  ║
║  │  ⭕ Customer DB      │───────────────▶│  ▭ Batch Processing  │                  ║
║  │  ⭕ Payment Gateway  │                │  ▭ Stream Processing │                  ║
║  │  ⭕ Loan Apps        │                │         ↓           │                  ║
║  │  ⭕ Account Balances │                │  ◇ Validation       │                  ║
║  │  ⭕ Mobile Logs      │                │    • Format         │                  ║
║  │  ⭕ Regulatory       │                │    • Completeness   │                  ║
║  └──────────────────────┘                └──────────┬───────────┘                  ║
║                                                      │                              ║
║  PHASE 3: STORAGE                           PHASE 4: PROCESSING                    ║
║  ┌──────────────────────┐                ┌──────────▼───────────┐                  ║
║  │  DATA LAKE (Raw)    │                │  ETL/ELT TOOLS       │                  ║
║  │  ▭ JSON, XML       │◀──────────────▶│  ▭ Apache Spark      │                  ║
║  │  ▭ Logs, Images    │                │  ▭ AWS Glue          │                  ║
║  └──────────┬───────────┘                └──────────┬───────────┘                  ║
║             │                                       │                              ║
║  ┌──────────▼───────────┐                ┌──────────▼───────────┐                  ║
║  │  DATA WAREHOUSE      │                │  INTEGRATION APIs    │                  ║
║  │  ▭ Star Schema      │◀──────────────▶│  ▭ REST APIs         │                  ║
║  │  ▭ Aggregated       │                │  ▭ GraphQL           │                  ║
║  └──────────────────────┘                └──────────────────────┘                  ║
║                                                                                     ║
║  PHASE 5: GOVERNANCE                     PHASE 6: CONSUMPTION                      ║
║  ┌──────────────────────┐                ┌──────────────────────┐                  ║
║  │  SECURITY CONTROLS   │                │  REPORTING & ANALYTICS│                  ║
║  │  ⬠ Encryption       │◀──────────────▶│  ▭ BI Tools          │                  ║
║  │  ⬠ Access Controls  │                │  ▭ Regulatory Reports│                  ║
║  └──────────────────────┘                └──────────────────────┘                  ║
║         │                                       │                                  ║
║  ┌──────▼──────┐                      ┌──────▼──────┐                              ║
║  │  METADATA   │                      │  DATA SCIENCE│                              ║
║  │  Repository │◀────────────────────▶│  ML Models   │                              ║
║  └─────────────┘                      └─────────────┘                              ║
║                                                                                     ║
║  PHASE 7: QUALITY MANAGEMENT                                                       ║
║  ┌─────────────────────────────────────────────────────────────────────────────┐   ║
║  │  DATA QUALITY CHECKS                                                         │   ║
║  │  Stage 1 (Ingestion) ◀─────────────────▶ Stage 2 (Storage)                  │   ║
║  │  ↓                                                                           │   ║
║  │  DATA QUALITY DASHBOARD                                                      │   ║
║  │  • Scorecards  • Alerts  • Remediation Workflows                            │   ║
║  └─────────────────────────────────────────────────────────────────────────────┘   ║
║                                                                                     ║
╠═══════════════════════════════════════════════════════════════════════════════════╣
║  LEGEND:  ⭕ = Data Source  ▭ = Process  ◇ = Validation  ▭ = Storage  ⬠ = Security  ║
║  Version: 1.0 | Last Updated: _______________ | Owner: Data Architecture Team      ║
╚═══════════════════════════════════════════════════════════════════════════════════╝
```

---

## Key Benefits Achieved

After consolidation, FinEdge will realize the following benefits:

| Benefit                            | Description                                     |
| ---------------------------------- | ----------------------------------------------- |
| **Single Source of Truth**   | All departments use the same data for reporting |
| **Reduced Costs**            | Eliminated redundant systems and maintenance    |
| **Regulatory Compliance**    | Complete data lineage and audit trails          |
| **Improved Decision-Making** | Real-time analytics and unified customer view   |
| **Scalability**              | Cloud-based architecture supports growth        |
| **Data Security**            | Centralized encryption and access controls      |
| **Data Quality**             | Automated validation and monitoring             |

---

## Summary

Congratulations on completing the hands-on lab **Prepare a Flowchart for the Consolidation of Data Infrastructure**. In this lab, you learned how to create a detailed flowchart for consolidating dispersed data silos of a fintech bank into a unified, secure, and governed data infrastructure.

### What you accomplished:

| Step             | Activity                                       |
| ---------------- | ---------------------------------------------- |
| **Step 1** | Identified and categorized existing data silos |
| **Step 2** | Defined data ingestion mechanisms              |
| **Step 3** | Designed data storage architecture             |
| **Step 4** | Incorporated data integration tools            |
| **Step 5** | Ensured data security and privacy controls     |
| **Step 6** | Established metadata management                |
| **Step 7** | Addressed data quality management              |
| **Step 8** | Prepared for reporting and analytics           |
| **Step 9** | Finalized and validated the complete flowchart |

### Key Takeaways:

1. **Visual planning** is essential for complex data consolidation projects
2. **Security and privacy** must be embedded at every layer
3. **Data quality** requires checks at multiple stages
4. **Metadata management** enables governance and compliance
5. **Stakeholder alignment** is facilitated through clear visual representations

This flowchart serves as a blueprint for FinEdge's data transformation journey, ensuring a systematic approach to consolidating disparate data sources into a unified, secure, and governed infrastructure.

---

*Lab completed: _________________*
*Instructor signature: _________________*
