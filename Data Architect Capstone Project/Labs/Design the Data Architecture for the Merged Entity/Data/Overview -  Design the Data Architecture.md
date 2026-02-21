![FutureMart](../Screenshots/FutureMart.png)

# Assignment Overview: Design the Data Architecture

## Estimated time: 4 minutes

---

## Learning objectives

- Identify key criteria for designing the data architecture for the merged organization, FutureMart
- List the main tasks and expected deliverables for completing the assignment on designing the data architecture

---

## Introduction

In **Phase 1**, you've thoroughly evaluated the existing data architectures of FashionMart and TrendyThreads. During your evaluation, you've determined potential gaps, inefficiencies, and improvement areas in the data architecture before designing the data architecture for the newly merged company, **FutureMart**.

You've analyzed and documented the current data architecture of both companies and captured information about:

- Data storage, data pipelines, and integration points
- Data integration mechanisms and areas needing standardization
- Quality of existing data quality processes
- Security processes, compliance levels, data governance frameworks, and policies
- Best practices for simplifying the architecture for future integration

In this phase, you will work to design the data architecture of the merged organization, FutureMart.

---

## Phase 2: Design the Data Architecture of FutureMart

In Phase 2, you'll design a target data architecture for the merged company, FutureMart, considering the evaluation report generated in Phase 1. You'll create:

- Data architecture diagrams for FutureMart's new databases
- Entity-relationship (ER) diagrams and table designs
- Initial schemas
- Documentation of how the new architecture addresses gaps, bottlenecks, and previously noted inefficiencies

---

## References

Download the template below to design the data architecture of FutureMart:

- [Template_Design the data architecture of a merged entity.docx]

> **Note:** Right-click on the link to open it in a new tab.

---

## Tasks

### Task 1: Create the Enterprise Data Architecture (EDA) Blueprint for FutureMart

In this task, you'll design a comprehensive EDA blueprint for FutureMart, including key capabilities to enhance a competitive workplace in the digital market.

**Include the following layers, tools, and processes:**

| Layer                                           | Description                                     | Key Components to Include                                                                                        |
| ----------------------------------------------- | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Data Sources**                          | All sources of data feeding into the system     | Physical store POS, e-commerce platform, customer data, inventory systems, marketing data, external data sources |
| **Data Integration**                      | Methods for ingesting and integrating data      | Real-time streaming (Kafka), batch ETL/ELT, API gateways, data transformation tools                              |
| **Data Storage**                          | Storage solutions for different data types      | Operational databases (OLTP), data warehouse (OLAP), data lake, real-time data stores, cloud storage             |
| **Data Processing**                       | Processing frameworks for data transformation   | Batch processing (Spark), stream processing (Flink), ETL workflows, data transformation tools                    |
| **Inventory and Supply Chain Management** | Systems for managing inventory and supply chain | IMS, OMS, WMS, supply chain analytics                                                                            |
| **Analytics and Reporting**               | Tools for business intelligence and reporting   | BI tools (Tableau, Power BI, Looker), dashboards, reporting platforms                                            |
| **Personalization and Engagement**        | Customer engagement and personalization tools   | Personalization engine, recommendation systems, email/push notifications, chatbots, loyalty programs             |
| **AI-based Shopping Recommendations**     | Machine learning for product recommendations    | ML models, recommendation algorithms, collaborative filtering, real-time personalization                         |
| **Real-time Reporting**                   | Live analytics and monitoring                   | Real-time dashboards, streaming analytics, operational monitoring                                                |
| **Data Governance**                       | Governance framework and policies               | Data quality, metadata management, data lineage, compliance, security, access control                            |

---

### Task 2: Evaluate FutureMart's Data Architecture

Evaluate FutureMart's data architecture by analyzing its key components and identifying its strengths and areas for improvement.

#### 1. Analyze Key Architectural Components

Assess the following key components:

| Component                                         | Evaluation Criteria                                               |
| ------------------------------------------------- | ----------------------------------------------------------------- |
| **Data silos**                              | Are there isolated data pockets? How well are systems integrated? |
| **Legacy systems**                          | Are outdated systems still present? What is their impact?         |
| **Scalable data architecture**              | Can the architecture handle growth in data volume and users?      |
| **Data integration capabilities**           | How well do real-time and batch systems integrate?                |
| **Robust data governance**                  | Are governance policies mature and enforced?                      |
| **Performance bottlenecks**                 | Where are potential processing slowdowns?                         |
| **High availability and disaster recovery** | Are resilience patterns implemented?                              |
| **Analytics and BI tools**                  | How advanced are analytics capabilities?                          |
| **Data security measures**                  | Are modern security practices implemented?                        |

#### 2. Document Strengths and Areas for Improvement

In this task, you'll identify strengths and areas for improvement in FutureMart's data architecture.

---

### Task 3: Designing the FutureMart's OLTP Database and ER Diagram

In this task, you'll create an entity-relationship diagram (ERD) and define the database structure for FutureMart's OLTP system.

#### 1. Define Database Requirements

Record sales for all apparel and track inventory levels for FutureMart's OLTP system.

**Key Requirements:**

- Track customer information and purchase history
- Manage product catalog with apparel details (sizes, colors, styles)
- Process orders across online and in-store channels
- Maintain real-time inventory levels
- Handle returns and exchanges
- Support omnichannel operations (buy online, pick up in store)

#### 2. Design the ER Diagram

For creating an ER diagram for FutureMart:

| Step        | Action                          | Description                                                                                                                                                 |
| ----------- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Identify key entities** | Customers, orders, products, inventory, categories, suppliers, stores, employees, payments, shipments                                                       |
| **2** | **Define relationships**  | Customers place orders (1:N), orders contain products (N:N via order_items), products belong to categories (N:1), inventory tracks products in stores (1:1) |
| **3** | **Specify keys**          | Primary keys for each entity, foreign keys to establish relationships                                                                                       |
| **4** | **Define attributes**     | Relevant fields for each entity with appropriate data types                                                                                                 |
| **5** | **Ensure normalization**  | Apply 3NF to reduce redundancy and improve efficiency                                                                                                       |

---

## Deliverables

By completing this assignment, you will have the following deliverables:

| Deliverable             | Description                                                                                                 | Format                                     |
| ----------------------- | ----------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| **Deliverable 1** | A blueprint diagram of the Enterprise Data Architecture (EDA) for FutureMart                                | Diagram (PNG/JPG) + Description            |
| **Deliverable 2** | An assessment report highlighting the strengths and areas for improvement in FutureMart's data architecture | Document (DOC/PDF) using provided template |
| **Deliverable 3** | An Entity-Relationship Diagram (ERD) for FutureMart's OLTP system                                           | Diagram (PNG/JPG)                          |
| **Deliverable 4** | Database schema design with table structures                                                                | Document (DOC/PDF)                         |

---

## Template: Evaluate the Data Architecture of FutureMart

Use this template to enter your solution. You may modify the template to include more information.

---

## Solution

### Part 2: Document the Strengths and Areas for Improvement for FutureMart

Analyze and document the organization's strengths and areas for improvement. Refer to Part 3 in the lab instructions.

---

### Strengths and Areas for Improvement

**1. Name of the enterprise:** FutureMart

**2. Strengths**

| Serial No.  | Strength | Description | Impact |
| ----------- | -------- | ----------- | ------ |
| **1** |          |             |        |
| **2** |          |             |        |
| **3** |          |             |        |
| **4** |          |             |        |
| **5** |          |             |        |

**3. Areas for Improvement**

| Serial No.  | Area for Improvement | Description | Impact |
| ----------- | -------------------- | ----------- | ------ |
| **1** |                      |             |        |
| **2** |                      |             |        |
| **3** |                      |             |        |
| **4** |                      |             |        |
| **5** |                      |             |        |

---

## Summary Checklist

| Task                                                                               | Completed |
| ---------------------------------------------------------------------------------- | --------- |
| ✓ Task 1: FutureMart EDA Blueprint created with all layers                        | ⬜        |
| ✓ Task 2: FutureMart architecture evaluated (strengths and areas for improvement) | ⬜        |
| ✓ Task 3: OLTP requirements defined                                               | ⬜        |
| ✓ Task 3: ER diagram created with key entities and relationships                  | ⬜        |
| ✓ All deliverables formatted and ready for submission                             | ⬜        |

---

*Assignment started: _________________*
*Enterprise Data Architect: _________________*
*Due date: _________________*
