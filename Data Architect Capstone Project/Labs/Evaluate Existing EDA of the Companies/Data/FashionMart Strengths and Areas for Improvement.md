![FashionMart](../Screenshots/FashionMart.png)

# FashionMart Strengths and Areas for Improvement


---

## Solution

### Part 3: Evaluating FashionMart's Data Architecture: Strengths and Areas for Improvement

Assess FashionMart's EDA by identifying its strengths and areas for improvement across key architectural components. Refer to Part 3 in the lab instructions.

---

**1. Name of the enterprise:** FashionMart

---

**2. Strengths**

| Sr. No.     | Strength                                  | Description                                                                                                                                                                                                           | Impact                                                                                                                                                                                                                        |
| ----------- | ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Established Data Infrastructure** | FashionMart has mature, operational data systems including CRM, POS databases, and data warehouses that have been refined over decades of retail operations. These systems are reliable and well-understood by staff. | Provides stability and reliability for core business operations; staff are familiar with existing systems and processes; reduced risk of system failures in day-to-day operations.                                            |
| **2** | **Comprehensive Data Collection**   | The company collects data from multiple touchpoints including physical stores (POS systems), online web-store, customer loyalty programs, supply chain operations, and marketing campaigns.                           | Enables multi-faceted analysis of business performance across different channels; provides rich datasets for understanding customer behavior and operational efficiency.                                                      |
| **3** | **Clear Separation of Concerns**    | Separate data warehouses for physical/store operations (Data Warehouse 1) and online operations (Data Warehouse 2) allow each domain to optimize their specific analytics needs independently.                        | Domain-specific optimization enables tailored reporting and performance tuning for different business units; reduces complexity within each warehouse; allows specialized teams to focus on their specific data requirements. |

---

**3. Areas for Improvement**

| Sr. No.     | Area for Improvement                                        | Description                                                                                                                                                                                                                                                               | Impact                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------- | ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Data Silos Between Physical and Online Operations** | FashionMart maintains separate databases and data warehouses for physical stores (Data Warehouse 1) and online operations (Data Warehouse 2). These systems are not fully integrated, creating isolated data pockets that don't communicate effectively.                  | • Prevents a unified 360-degree view of customers who shop both online and in-store `<br>`• Inconsistent reporting across channels leading to conflicting business metrics `<br>`• Unable to track complete customer journey across touchpoints `<br>`• Hinders omnichannel marketing and personalization efforts `<br>`• Missed cross-selling and upselling opportunities `<br>`• Duplicate data entry and reconciliation efforts                                                                                                |
| **2** | **Legacy Systems Impacting Integration**              | Older systems (legacy POS terminals, legacy inventory management systems, older databases) are not fully integrated with newer architecture components. This leads to data discrepancies and manual reconciliation efforts between old and new systems.                   | • Data inconsistencies between systems require manual reconciliation `<br>`• Slows down data processing and reporting cycles `<br>`• Limits scalability and ability to adopt modern technologies `<br>`• Increases maintenance costs due to supporting multiple systems `<br>`• Technical debt accumulates, making future upgrades more difficult `<br>`• Integration complexity increases with each new system added                                                                                                             |
| **3** | **Limited Real-time Data Integration Capabilities**   | Current architecture relies primarily on batch-oriented ETL processes (likely nightly or scheduled runs) with limited real-time data streaming capabilities. Data from stores and online channels is not synchronized in real-time, creating latency in information flow. | • Inventory levels may be inaccurate between online and store systems, leading to overselling `<br>`• Cannot provide real-time inventory availability to customers (online vs. in-store stock)`<br>`• Delayed insights for business decision-making (e.g., reacting to trends)`<br>`• Inability to respond quickly to market changes or competitor actions `<br>`• Customer experience suffers from outdated information (e.g., showing out-of-stock items)`<br>`• Real-time personalization and recommendations are not possible |

---

*Assessment completed by: _________________*
*Date: _________________*
