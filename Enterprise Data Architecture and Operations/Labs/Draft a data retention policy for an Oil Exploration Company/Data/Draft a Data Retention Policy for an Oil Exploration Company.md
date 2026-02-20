![Logo](<../Screenshots/PetroQuest Energy.png>)

# Lab: Draft a Data Retention Policy for an Oil Exploration Company

## Estimated time: 30 minutes

---

## Learning objectives

After completing this lab, you will be able to:

- Apply the principles of data retention in enterprise data operations
- Develop a robust data retention policy tailored for an oil exploration company
- Ensure compliance with regulatory, operational, and business requirements

---

## Tools

You can complete your tasks using any text editor, such as **Word**, **Google Docs**, or **Notepad**.

- If you install Microsoft Word, you can proceed directly with the instructions. However, if you don't have Microsoft Word, you can sign up for a free version of Microsoft 365 online. Follow [these instructions](https://support.microsoft.com/en-us/office/sign-up-for-microsoft-365-9ac1e0c7-0e6c-4f9d-8c8c-7e9b8e8c8c8c) to create your account.
- You can also use **Word Online** with a Microsoft 365 subscription or access through a free account. If you're new to Word and would like to learn how to get started, you can find helpful resources here: [Getting Started with Word Online](https://support.microsoft.com/en-us/office/get-started-with-word-online-5c8c3c3c-3c3c-4c3c-8c3c-3c3c3c3c3c3c).

For this lab, you can use **Lucidchart**. You only need the free version of LucidChart. If you choose to purchase a paid plan, you will be responsible for any associated charges. If you've not yet signed up for the free account, you can follow [these instructions](https://www.lucidchart.com/pages/sign-up) to get started. You may alternatively use applications like **Microsoft Visio** or **draw.io**.

You will need **internet access** for research on regulations and standards such as **GDPR**, **CCPA**, and industry-specific rules such as **EPA** or **OSHA** requirements.

You will also need access to company-specific data governance policies, if available. You will also need a template to create policy documents.

---

## Introduction

In today's data-driven world, managing data assets effectively has become critical for enterprises that deal with huge amounts of data from disparate sources. Saving organizations from unnecessary data hoarding, a **data retention policy** provides them with a structured approach to managing data by helping them determine:

- How long a certain type of data must be kept for compliance and legal and regulatory purposes
- In what format it must be stored
- What access controls are required
- How it must be securely destroyed when it is no longer required

---

## Exercise: Create a data retention policy for an oil exploration company

In this lab, you will develop a comprehensive data retention policy for an oil exploration company. You will need to perform the following tasks:

1. Identify the types of data managed by the organization
2. Review the applicable regulatory requirements and list the retention timelines for key data categories
3. Work with key stakeholders to understand the challenges in managing the data lifecycle
4. Categorize data types
5. Define the retention periods for each category
6. Create a structured policy document
7. Implement the data retention policy

---

## Scenario

**PetroQuest Energy** is an oil and gas exploration and production company that collects vast amounts of data from seismic surveys, drilling operations, environmental impact studies, financial transactions, and regulatory compliance documents.

### The Challenge

PetroQuest Energy has received a notice from a **regulatory authority** requesting historical drilling data and environmental impact reports from a specific offshore project conducted **ten years ago**. The company is struggling to retrieve the required data due to:

- Inconsistent storage practices
- Missing records
- An outdated document management system

Simultaneously, a **legal dispute** has arisen regarding land rights for one of its past drilling operations. The opposing party claims PetroQuest trespassed beyond its designated area and demands access to geospatial and drilling records from **seven years ago**. Without a well-defined data retention policy, the company cannot efficiently retrieve the necessary information to defend itself, leading to financial penalties and reputational damage.

### The Solution

PetroQuest Energy needs a comprehensive data retention policy that ensures:

| Requirement                      | Description                                                 |
| -------------------------------- | ----------------------------------------------------------- |
| **Regulatory Compliance**  | Meet all legal and industry requirements for data retention |
| **Operational Efficiency** | Enable quick retrieval of historical data when needed       |
| **Legal Protection**       | Defend against disputes with proper documentation           |
| **Cost Optimization**      | Reduce storage costs by eliminating unnecessary data        |
| **Risk Management**        | Securely dispose of data when no longer required            |

---

## Template to use

If you are using Microsoft Word, right-click the link and download the template document. You can use the template to perform the tasks outlined in the lab.

You can also use the PDF format for any other word-processing software.

---

## Task 1: Understand the scope and objectives

### Step 1: Identify the types of data managed by the organization

PetroQuest Energy manages various types of data across its exploration and production operations:

| Data Category                  | Examples                                                                    |
| ------------------------------ | --------------------------------------------------------------------------- |
| **Seismic Data**         | 2D/3D seismic surveys, processed seismic volumes, interpretation data       |
| **Well Data**            | Drilling reports, well logs, completion reports, production data            |
| **Geological Data**      | Core samples, rock analysis, reservoir models, geological maps              |
| **Environmental Data**   | Impact assessments, emission monitoring, spill reports, remediation records |
| **Financial Data**       | Contracts, invoices, royalty payments, tax records, investment documents    |
| **Health & Safety Data** | Incident reports, safety audits, training records, medical surveillance     |
| **Regulatory Data**      | Permits, licenses, compliance reports, regulatory correspondence            |
| **Operational Data**     | Equipment maintenance logs, inventory records, supply chain documents       |
| **Employee Data**        | Personnel files, payroll records, benefits information                      |
| **Legal Data**           | Land rights documents, lease agreements, litigation records                 |

### Step 2: Define the policy objectives

| Policy Objective                         | Description                                                                                   |
| ---------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Ensure Regulatory Compliance**   | Meet all federal, state, and local regulations for data retention in the oil and gas industry |
| **Optimize Data Storage Costs**    | Reduce storage expenses by eliminating redundant, obsolete, and trivial (ROT) data            |
| **Safeguard Sensitive Data**       | Protect critical operational and proprietary information throughout its lifecycle             |
| **Support Operational Continuity** | Ensure historical data is available for future exploration and production activities          |
| **Enable Legal Defense**           | Maintain records necessary for litigation and dispute resolution                              |
| **Facilitate Audits**              | Provide ready access to data for internal and external audits                                 |
| **Standardize Data Management**    | Create consistent practices across all business units and geographic locations                |

---

## Task 2: Review applicable regulations

### Step 1: Research and document all applicable regulatory requirements

The oil exploration industry is subject to numerous regulations across different sectors:

| Sector                             | Regulatory Body                                      | Applicable Requirements                                                                                                                            | Typical Retention Period        |
| ---------------------------------- | ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| **Environmental**            | EPA (Environmental Protection Agency)                | • Clean Water Act records`<br>`• Spill Prevention Control records`<br>`• Environmental Impact Statements`<br>`• Emission monitoring data | 5-10 years                      |
| **Financial**                | SEC (Securities and Exchange Commission)             | • SOX compliance records`<br>`• Financial statements`<br>`• Audit records`<br>`• Revenue recognition docs                                | 7 years                         |
| **Health & Safety**          | OSHA (Occupational Safety and Health Administration) | • Incident reports`<br>`• Exposure records`<br>`• Safety training records`<br>`• Medical surveillance data                               | 5-30 years (medical: 30+ years) |
| **Drilling Operations**      | BOEM (Bureau of Ocean Energy Management)             | • Drilling permits`<br>`• Well completion reports`<br>`• Production reports`<br>`• Reservoir data                                        | Life of well + 5 years          |
| **Land Management**          | BLM (Bureau of Land Management)                      | • Lease agreements`<br>`• Land rights documents`<br>`• Royalty payment records                                                              | Duration of lease + 7 years     |
| **International Operations** | Various (EU, UN, etc.)                               | • GDPR (for EU operations)`<br>`• UN conventions`<br>`• Host country regulations                                                            | Varies by jurisdiction          |

### Global Data Protection Regulations

| Regulation       | Jurisdiction    | Applicability                                              | Key Requirements                                          |
| ---------------- | --------------- | ---------------------------------------------------------- | --------------------------------------------------------- |
| **GDPR**   | European Union  | If PetroQuest operates in or handles data from EU citizens | Right to erasure, data minimization, retention limitation |
| **CCPA**   | California, USA | If handling data of California residents                   | Right to delete, right to access, opt-out rights          |
| **PIPEDA** | Canada          | For Canadian operations                                    | Consent, retention limits, safeguards                     |
| **LGPD**   | Brazil          | For Brazilian operations                                   | Data retention, disposal, rights                          |

### Industry-Specific Standards

| Standard              | Organization                                   | Focus Area                     | Retention Implications                          |
| --------------------- | ---------------------------------------------- | ------------------------------ | ----------------------------------------------- |
| **API RP 1175** | American Petroleum Institute                   | Pipeline safety management     | Records for pipeline operations and maintenance |
| **ISO 14001**   | International Organization for Standardization | Environmental management       | Environmental records and audits                |
| **ISO 45001**   | International Organization for Standardization | Occupational health and safety | Safety records and incident documentation       |

---

## Task 3: Conduct stakeholder consultations

### Step 1: Engage with key stakeholders

| Stakeholder Group                                     | Purpose of Consultation                                                                                                                                                                           | Key Insights                                                                                                                                                                                                      |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **IT and Data Management Teams**                | • Understand current storage capabilities`<br>`• Identify system limitations`<br>`• Assess backup and archiving processes`<br>`• Determine technical feasibility of retention schedules | • Current storage capacity: 500 TB`<br>`• Backup frequency: Daily incremental, weekly full`<br>`• Archive system nearing end-of-life`<br>`• Need for automated retention enforcement                    |
| **Legal and Compliance Teams**                  | • Identify legal hold requirements`<br>`• Understand litigation risks`<br>`• Document regulatory obligations`<br>`• Define compliance reporting needs                                   | • Ongoing litigation requires data preservation`<br>`• Multiple jurisdictions with conflicting requirements`<br>`• Need for legal hold process`<br>`• Audit response time requirements                  |
| **Geology and Exploration Teams**               | • Capture operational data needs`<br>`• Understand data reuse patterns`<br>`• Identify critical historical data`<br>`• Document data value over time                                    | • Seismic data valuable for decades`<br>`• Reservoir models used for field development`<br>`• Historical well data critical for new drilling`<br>`• Need for long-term preservation of exploration data |
| **Health, Safety, and Environment (HSE) Teams** | • Document safety record requirements`<br>`• Understand environmental monitoring needs`<br>`• Identify incident reporting obligations                                                      | • Employee exposure records needed for 30+ years`<br>`• Incident reports required for insurance claims`<br>`• Environmental monitoring data for trend analysis                                             |
| **Finance and Accounting Teams**                | • Identify financial record requirements`<br>`• Understand audit retention needs`<br>`• Document tax record obligations                                                                    | • SOX compliance requires 7-year retention`<br>`• Tax records needed for audit defense`<br>`• Royalty payment records for landowner disputes                                                               |

---

## Task 4: Categorize data

### Step 1: Classify data into logical categories

| Category                                  | Description                                                                 | Data Types                                                                                                                                                                                 |
| ----------------------------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Critical Operational Data**       | Data essential for current and future exploration and production activities | • Seismic survey data`<br>`• Well logs and completion reports`<br>`• Reservoir models`<br>`• Production data`<br>`• Geological maps and interpretations                       |
| **Compliance Data**                 | Data required to demonstrate regulatory compliance                          | • Environmental impact assessments`<br>`• Emission monitoring records`<br>`• Safety incident reports`<br>`• Permit and license documentation`<br>`• Regulatory correspondence |
| **Financial and Legal Data**        | Data related to financial transactions and legal obligations                | • Contracts and agreements`<br>`• Lease and land rights documents`<br>`• Royalty payment records`<br>`• Tax returns and supporting docs`<br>`• Litigation records             |
| **Health and Safety Data**          | Data related to employee and public safety                                  | • Medical surveillance records`<br>`• Safety training records`<br>`• Incident investigation reports`<br>`• Exposure monitoring data`<br>`• Safety audit reports               |
| **Administrative and Support Data** | Data supporting business operations but not critical                        | • Internal emails`<br>`• Meeting minutes`<br>`• Travel and expense reports`<br>`• Training materials`<br>`• Internal memos                                                    |
| **Archived Data**                   | Data no longer actively used but retained for historical or legal reasons   | • Legacy system data`<br>`• Closed project records`<br>`• Decommissioned well data`<br>`• Historical exploration records                                                         |

### Data Classification Matrix

| Data Type                | Sensitivity Level | Criticality | Regulatory Impact |
| ------------------------ | ----------------- | ----------- | ----------------- |
| Seismic Data             | Confidential      | High        | Medium            |
| Well Logs                | Internal          | High        | Medium            |
| Employee Medical Records | Restricted        | Medium      | High (HIPAA)      |
| Financial Records        | Confidential      | High        | High (SOX)        |
| Environmental Reports    | Public            | Medium      | High (EPA)        |
| Safety Incident Reports  | Internal          | High        | High (OSHA)       |
| Lease Agreements         | Confidential      | High        | High              |
| Internal Emails          | Internal          | Low         | Low               |

---

## Task 5: Define retention periods

### Step 1: Establish retention periods for each data category

| Data Category                       | Data Type                        | Retention Period                                | Retention Reason                         | Disposal Method                        |
| ----------------------------------- | -------------------------------- | ----------------------------------------------- | ---------------------------------------- | -------------------------------------- |
| **Critical Operational Data** | Seismic Data                     | 20+ years (permanent if strategically valuable) | Future exploration, field development    | N/A (permanent archive)                |
|                                     | Well Logs                        | Life of well + 10 years                         | Reservoir management, well interventions | Secure deletion after well abandonment |
|                                     | Reservoir Models                 | 25 years                                        | Field development planning               | Secure deletion                        |
|                                     | Production Data                  | Life of field + 7 years                         | Reserve reporting, forecasting           | Secure deletion                        |
| **Compliance Data**           | Environmental Impact Assessments | 10 years                                        | Regulatory audits, future permitting     | Secure deletion                        |
|                                     | Emission Monitoring              | 7 years                                         | EPA compliance, trend analysis           | Secure deletion                        |
|                                     | Permit Documentation             | Life of operation + 5 years                     | Regulatory verification                  | Secure deletion                        |
| **Financial and Legal Data**  | Contracts and Agreements         | Contract term + 7 years                         | Legal protection, dispute resolution     | Secure deletion                        |
|                                     | Lease Agreements                 | Lease term + 7 years                            | Land rights verification                 | Secure deletion                        |
|                                     | Royalty Records                  | 7 years                                         | Payment verification, audits             | Secure deletion                        |
|                                     | Tax Records                      | 7 years                                         | IRS/SEC requirements                     | Secure deletion                        |
|                                     | SOX Compliance Records           | 7 years                                         | Financial audits                         | Secure deletion                        |
| **Health and Safety Data**    | Medical Surveillance Records     | Employment + 30 years                           | Long-term health monitoring              | Physical shredding/secure wipe         |
|                                     | Incident Reports                 | 10 years                                        | Insurance, safety analysis               | Secure deletion                        |
|                                     | Exposure Monitoring              | 30 years                                        | Occupational health tracking             | Secure deletion                        |
|                                     | Safety Training Records          | 5 years                                         | Training verification                    | Secure deletion                        |
| **Administrative Data**       | Internal Emails                  | 3 years                                         | Business reference                       | Secure deletion                        |
|                                     | Meeting Minutes                  | 5 years                                         | Decision documentation                   | Secure deletion                        |
|                                     | Travel Reports                   | 3 years                                         | Expense verification                     | Secure deletion                        |
| **Archived Data**             | Legacy System Data               | 10 years after system decommission              | Historical reference, legal holds        | Secure deletion after hold release     |
|                                     | Closed Project Records           | 7 years after project closure                   | Lessons learned, future reference        | Secure deletion                        |

### Retention Period Rationale

| Retention Period      | Rationale                                                             | Examples                           |
| --------------------- | --------------------------------------------------------------------- | ---------------------------------- |
| **30+ years**   | Long-term health monitoring requirements, permanent operational value | Medical records, seismic data      |
| **20-25 years** | Extended operational value, field life cycles                         | Reservoir models, exploration data |
| **10 years**    | Regulatory requirements, environmental impact assessments             | EPA records, well data             |
| **7 years**     | Financial audit requirements, statute of limitations                  | SOX records, contracts, tax docs   |
| **5 years**     | Business reference, training verification                             | Meeting minutes, training records  |
| **3 years**     | Short-term operational value                                          | Internal emails, travel reports    |

---

## Task 6: Outline policy structure

### Step 1: Draft a clear and structured policy document

# Data Retention Policy for PetroQuest Energy

## Document Control

| Document Property          | Details                 |
| -------------------------- | ----------------------- |
| **Policy Title**     | Data Retention Policy   |
| **Version**          | 1.0                     |
| **Effective Date**   | [Current Date]          |
| **Next Review Date** | [Current Date + 1 Year] |
| **Policy Owner**     | Chief Data Officer      |
| **Department**       | Data Governance         |
| **Classification**   | Internal - Confidential |

---

## 1. Purpose and Scope

### 1.1 Purpose

The purpose of this Data Retention Policy is to establish a consistent framework for managing the lifecycle of data assets within PetroQuest Energy. This policy ensures that:

- Data is retained for appropriate periods to meet **regulatory, legal, and operational requirements**
- Data is **securely disposed** when no longer needed
- Storage costs are **optimized** by eliminating unnecessary data
- Critical historical data is **preserved** for future exploration activities
- The organization can **respond effectively** to legal disputes and regulatory audits

### 1.2 Scope

This policy applies to:

- **All business units** and departments within PetroQuest Energy
- **All data types** regardless of format (physical or digital)
- **All storage media** including databases, file servers, cloud storage, and physical records
- **All employees, contractors, and third parties** handling company data
- **All geographic locations** where PetroQuest operates

---

## 2. Definitions

| Term                       | Definition                                                                                                 |
| -------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Data Retention**   | The practice of storing data for a specified period to meet legal, regulatory, or operational requirements |
| **Retention Period** | The length of time data must be kept before disposal                                                       |
| **Data Disposal**    | The secure destruction of data when it is no longer needed                                                 |
| **Legal Hold**       | A process that suspends normal retention and disposal practices when data is required for litigation       |
| **Active Data**      | Data that is regularly accessed and used for current operations                                            |
| **Archived Data**    | Data that is no longer actively used but must be preserved for historical or legal reasons                 |
| **ROT Data**         | Redundant, Obsolete, or Trivial data that can be safely deleted                                            |
| **Data Custodian**   | The person responsible for the technical storage and security of data                                      |
| **Data Steward**     | The person responsible for data quality and compliance within a business unit                              |
| **Data Owner**       | The senior manager accountable for specific data assets                                                    |

---

## 3. Roles and Responsibilities

| Role                                   | Responsibilities                                                                                                                                                                                                     |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Governance Committee**    | • Approve retention schedules`<br>`• Review policy annually`<br>`• Resolve disputes`<br>`• Ensure cross-departmental alignment                                                                             |
| **Data Owners**                  | • Define retention requirements for their data domains`<br>`• Approve deviations from standard retention`<br>`• Ensure compliance within their areas                                                          |
| **Data Stewards**                | • Monitor compliance with retention schedules`<br>`• Coordinate with IT for implementation`<br>`• Identify data quality issues`<br>`• Escalate non-compliance                                              |
| **IT and Data Management Teams** | • Implement technical controls for retention`<br>`• Manage backup and archive systems`<br>`• Execute secure data disposal`<br>`• Maintain storage infrastructure`<br>`• Provide access to retained data |
| **Legal and Compliance Teams**   | • Identify regulatory requirements`<br>`• Manage legal holds`<br>`• Approve retention timelines`<br>`• Ensure compliance with laws`<br>`• Respond to regulatory requests                                |
| **Internal Audit**               | • Verify compliance with policy`<br>`• Test disposal procedures`<br>`• Report findings to governance committee                                                                                                |
| **All Employees**                | • Follow policy requirements`<br>`• Classify data appropriately`<br>`• Report data management issues                                                                                                          |

---

## 4. Data Classification and Retention Schedule

### 4.1 Data Classification Matrix

| Classification Level            | Description                                           | Examples                                                                                         | Security Requirements                                  |
| ------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------ |
| **Level 4: Restricted**   | Highly sensitive data with severe impact if disclosed | • Seismic data`<br>`• Proprietary reservoir models`<br>`• Unannounced exploration targets | Encryption, strict access controls, full audit logging |
| **Level 3: Confidential** | Sensitive data with moderate impact if disclosed      | • Financial records`<br>`• Employee data`<br>`• Contracts                                 | Encryption, role-based access                          |
| **Level 2: Internal**     | Internal use only, limited impact                     | • Operational reports`<br>`• Meeting minutes`<br>`• Training materials                    | Basic access controls                                  |
| **Level 1: Public**       | Non-sensitive, no impact                              | • Public announcements`<br>`• Marketing materials                                            | No special controls                                    |

### 4.2 Retention Schedule

| Data Category                   | Data Type           | Retention Period            | Format           | Storage Class   | Access Level |
| ------------------------------- | ------------------- | --------------------------- | ---------------- | --------------- | ------------ |
| **Seismic & Exploration** | Raw Seismic Data    | Permanent                   | Digital          | Archive         | Restricted   |
|                                 | Processed Seismic   | 25 years                    | Digital          | Cold Storage    | Restricted   |
|                                 | Interpretation Data | 20 years                    | Digital          | Cold Storage    | Restricted   |
| **Well Data**             | Drilling Reports    | Life of well + 10 years     | Digital          | Active/Archive  | Confidential |
|                                 | Well Logs           | Life of well + 10 years     | Digital          | Active/Archive  | Confidential |
|                                 | Completion Reports  | Life of well + 10 years     | Digital          | Active/Archive  | Confidential |
|                                 | Production Data     | Life of field + 7 years     | Digital          | Active          | Confidential |
| **Reservoir Data**        | Reservoir Models    | 25 years                    | Digital          | Archive         | Restricted   |
|                                 | Simulation Results  | 25 years                    | Digital          | Archive         | Restricted   |
| **Environmental**         | Impact Assessments  | 10 years                    | Digital/Physical | Archive         | Internal     |
|                                 | Emission Monitoring | 7 years                     | Digital          | Active          | Internal     |
|                                 | Spill Reports       | 10 years                    | Digital          | Archive         | Confidential |
|                                 | Remediation Records | 10 years                    | Digital          | Archive         | Confidential |
| **Health & Safety**       | Incident Reports    | 10 years                    | Digital          | Active          | Confidential |
|                                 | Medical Records     | Employment + 30 years       | Digital/Physical | Restricted      | Restricted   |
|                                 | Exposure Monitoring | 30 years                    | Digital          | Restricted      | Restricted   |
|                                 | Safety Audits       | 7 years                     | Digital          | Internal        | Internal     |
|                                 | Training Records    | 5 years                     | Digital          | Internal        | Internal     |
| **Financial**             | Contracts           | Term + 7 years              | Digital          | Confidential    | Confidential |
|                                 | Lease Agreements    | Term + 7 years              | Digital          | Confidential    | Confidential |
|                                 | Royalty Records     | 7 years                     | Digital          | Confidential    | Confidential |
|                                 | Tax Records         | 7 years                     | Digital          | Confidential    | Confidential |
|                                 | SOX Records         | 7 years                     | Digital          | Confidential    | Confidential |
|                                 | Invoices            | 7 years                     | Digital          | Internal        | Internal     |
| **Legal**                 | Litigation Records  | Case closed + 7 years       | Digital/Physical | Restricted      | Restricted   |
|                                 | Land Rights         | Perpetual                   | Digital/Physical | Confidential    | Restricted   |
|                                 | Permits             | Life + 5 years              | Digital          | Confidential    | Internal     |
| **Administrative**        | Internal Emails     | 3 years                     | Digital          | Internal        | Internal     |
|                                 | Meeting Minutes     | 5 years                     | Digital          | Internal        | Internal     |
|                                 | Travel Reports      | 3 years                     | Digital          | Internal        | Internal     |
|                                 | Training Materials  | 3 years after update        | Digital          | Public/Internal | Public       |
| **Archived**              | Legacy Systems      | 10 years after decommission | Digital          | Deep Archive    | Restricted   |
|                                 | Closed Projects     | 7 years after closure       | Digital          | Archive         | Internal     |

---

## 5. Data Archiving Procedures

### 5.1 Archiving Triggers

Data should be archived when:

- It has not been accessed for **2 years** (active → cold storage)
- A project is **completed or closed**
- A well is **abandoned or decommissioned**
- A lease or contract **expires**
- An employee **terminates** (HR records)
- Systems are **decommissioned**

### 5.2 Archive Storage Tiers

| Tier                      | Description                | Storage Type                | Access Time   | Cost     |
| ------------------------- | -------------------------- | --------------------------- | ------------- | -------- |
| **Active Storage**  | Frequently accessed data   | SSD, High-performance NAS   | Milliseconds  | High     |
| **Cold Storage**    | Infrequently accessed data | HDD, Standard cloud storage | Seconds       | Medium   |
| **Archive Storage** | Rarely accessed data       | Tape, Glacier, Deep Archive | Hours to days | Low      |
| **Deep Archive**    | Permanent preservation     | WORM media, Offline tape    | Days to weeks | Very Low |

### 5.3 Archiving Process


![Diagram](<../Screenshots/Archiving Process.png>)
---

## 6. Data Disposal Procedures

### 6.1 Disposal Triggers

Data should be securely disposed when:

- Retention period has **expired**
- No **legal hold** is active
- Data is **redundant, obsolete, or trivial (ROT)**
- Systems are being **decommissioned**
- Physical records are no longer required

### 6.2 Disposal Methods by Format

| Format                         | Disposal Method                    | Standard                     | Verification                |
| ------------------------------ | ---------------------------------- | ---------------------------- | --------------------------- |
| **Digital Files**        | Secure deletion with overwrite     | DoD 5220.22-M (3 passes)     | Certificate of deletion     |
| **Databases**            | Cryptographic erasure              | AES-256 key destruction      | Key destruction certificate |
| **Hard Drives**          | Degaussing or physical destruction | NIST SP 800-88               | Certificate of destruction  |
| **SSDs**                 | Secure erase command + encryption  | ATA Secure Erase             | Verification log            |
| **Cloud Storage**        | API-based deletion + verification  | Cloud provider certification | Deletion confirmation       |
| **Paper Records**        | Cross-cut shredding                | DIN 66399 (P-5 level)        | Certificate of shredding    |
| **Microfilm/Microfiche** | Incineration                       | Witnessed destruction        | Destruction certificate     |
| **Backup Tapes**         | Degaussing or physical destruction | Vendor certification         | Chain of custody            |

### 6.3 Disposal Process

![Diagram](<../Screenshots/Disposal Process.png>)

### 6.4 Disposal Documentation

For each disposal event, document:

- Data description and volume
- Retention period expiration date
- Disposal method used
- Date and time of disposal
- Person authorizing disposal
- Person executing disposal
- Witness (if required)
- Certificate of destruction reference

---

## 7. Legal Hold Process

### 7.1 Legal Hold Triggers

A legal hold is triggered when:

- Litigation is **anticipated or filed**
- A regulatory **investigation** is initiated
- An **audit** is announced
- A **government inquiry** is received
- A **subpoena** is served
- A **contract dispute** arises

### 7.2 Legal Hold Procedure

| Step | Action                                            | Responsible Party  |
| ---- | ------------------------------------------------- | ------------------ |
| 1    | Legal counsel issues hold notice                  | Legal Team         |
| 2    | Identify relevant data custodians                 | Legal Team         |
| 3    | Notify custodians of hold                         | Legal Team         |
| 4    | Suspend normal retention for affected data        | IT/Data Management |
| 5    | Preserve data in place or copy to secure location | IT/Data Management |
| 6    | Monitor compliance with hold                      | Legal Team         |
| 7    | Release hold when no longer required              | Legal Team         |
| 8    | Resume normal retention schedule                  | IT/Data Management |

### 7.3 Legal Hold Documentation

For each legal hold, maintain:

- Hold notice and date issued
- Scope of data covered
- List of affected custodians
- Hold release notice and date
- Chain of custody for preserved data

---

## 8. Policy Compliance and Enforcement

### 8.1 Compliance Monitoring

| Monitoring Activity                     | Frequency    | Responsible Party         |
| --------------------------------------- | ------------ | ------------------------- |
| **Retention Schedule Compliance** | Quarterly    | Data Stewards             |
| **Disposal Verification**         | Per disposal | IT/Data Management        |
| **Legal Hold Compliance**         | Per hold     | Legal Team                |
| **Storage Cost Analysis**         | Monthly      | IT Finance                |
| **Data Classification Accuracy**  | Quarterly    | Data Stewards             |
| **Policy Review**                 | Annually     | Data Governance Committee |

### 8.2 Non-Compliance Consequences

| Violation                                    | Consequence                                | Reporting    |
| -------------------------------------------- | ------------------------------------------ | ------------ |
| **Accidental retention beyond period** | Warning, process review                    | Data Steward |
| **Failure to dispose of expired data** | Written warning, retraining                | HR Record    |
| **Unauthorized data destruction**      | Formal investigation, possible termination | HR/Legal     |
| **Bypassing legal hold**               | Immediate escalation, legal action         | Legal Team   |
| **Misclassification of data**          | Retraining, performance review             | Data Steward |

---

## 9. Policy Review and Updates

### 9.1 Review Cycle

- **Annual review** by Data Governance Committee
- **Interim updates** as regulations change
- **Post-incident reviews** after data breaches or legal challenges
- **Technology-driven updates** when storage systems change

### 9.2 Change Management

| Change Type                              | Approval Required         | Notification              |
| ---------------------------------------- | ------------------------- | ------------------------- |
| **Minor updates** (clarifications) | Data Governance Lead      | Email notification        |
| **Retention period changes**       | Data Governance Committee | Training update           |
| **New data categories**            | Data Governance Committee | Policy version update     |
| **Major restructuring**            | Executive approval        | Company-wide announcement |

---

## 10. Appendices

### Appendix A: Regulatory Reference Table

| Regulation                    | Jurisdiction | Requirements                 | Retention Period       |
| ----------------------------- | ------------ | ---------------------------- | ---------------------- |
| **SOX**                 | USA          | Financial records retention  | 7 years                |
| **EPA Clean Water Act** | USA          | Discharge monitoring reports | 5 years                |
| **OSHA 29 CFR 1910**    | USA          | Medical records              | Employment + 30 years  |
| **OSHA 29 CFR 1904**    | USA          | Incident reports             | 5 years                |
| **GDPR**                | EU           | Personal data                | As needed + 3 years    |
| **BLM Onshore Orders**  | USA          | Drilling permits             | Life of well + 6 years |
| **BOEM 30 CFR 250**     | USA          | Offshore operations          | Life of well + 5 years |

### Appendix B: Data Disposal Certificate Template

```
╔══════════════════════════════════════════════════════════════════╗
║                  CERTIFICATE OF DATA DESTRUCTION                  ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                     ║
║  Data Description: ______________________________________________   ║
║                                                                     ║
║  Data Category: □ Seismic  □ Well  □ Environmental  □ Financial    ║
║                 □ HSE      □ Legal  □ Administrative  □ Other      ║
║                                                                     ║
║  Retention Period Expired: ______________ (date)                    ║
║                                                                     ║
║  Volume of Data: ______________ (GB/TB/Boxes)                       ║
║                                                                     ║
║  Disposal Method:                                                  ║
║  □ Secure Deletion (DoD 5220.22-M)                                 ║
║  □ Degaussing                                                      ║
║  □ Physical Destruction                                            ║
║  □ Shredding (DIN 66399 P-5)                                       ║
║  □ Incineration                                                    ║
║  □ Cryptographic Erasure                                           ║
║  □ Other: ______________________                                   ║
║                                                                     ║
║  Disposal Date: _________________  Time: ______________            ║
║                                                                     ║
║  Authorized By:                                                   ║
║  Name: _________________________  Title: ____________________      ║
║  Signature: _____________________  Date: ___________________       ║
║                                                                     ║
║  Executed By:                                                     ║
║  Name: _________________________  Title: ____________________      ║
║  Signature: _____________________  Date: ___________________       ║
║                                                                     ║
║  Witness (if required):                                            ║
║  Name: _________________________  Signature: _________________     ║
║                                                                     ║
║  Certificate Reference: PED-CERT-_________-________                ║
║                                                                     ║
╚══════════════════════════════════════════════════════════════════╝
```

### Appendix C: Legal Hold Notice Template

```
╔══════════════════════════════════════════════════════════════════╗
║                      LEGAL HOLD NOTICE                             ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                     ║
║  TO: [Data Custodian Name/Department]                               ║
║  FROM: Legal Department                                             ║
║  DATE: _______________                                              ║
║  REFERENCE: LH-_________-________                                   ║
║                                                                     ║
║  SUBJECT: Legal Hold for [Matter Name/Case Number]                 ║
║                                                                     ║
║  This notice is to inform you that you are required to preserve    ║
║  all records and data related to the following matter:             ║
║                                                                     ║
║  Matter Description: ___________________________________________    ║
║                                                                     ║
║  Scope of Hold:                                                   ║
║  □ All data related to [project/well/contract]                     ║
║  □ Date range: from ______________ to ______________               ║
║  □ Data types: _______________________________________              ║
║  □ Custodians: _______________________________________              ║
║                                                                     ║
║  INSTRUCTIONS:                                                     ║
║  1. Do not delete, alter, or destroy any data within scope         ║
║  2. Suspend all normal retention and disposal activities           ║
║  3. Preserve data in current format and location                   ║
║  4. Notify Legal of any potential data loss                        ║
║  5. Acknowledge receipt within 3 business days                     ║
║                                                                     ║
║  This hold remains in effect until released in writing by Legal.   ║
║                                                                     ║
║  ACKNOWLEDGMENT OF RECEIPT:                                        ║
║  I acknowledge receipt of this Legal Hold and understand my        ║
║  obligation to preserve the identified data.                       ║
║                                                                     ║
║  Name: _________________________  Date: ___________________        ║
║  Signature: _____________________                                  ║
║                                                                     ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## 11. Approval

| Role               | Name              | Signature         | Date  |
| ------------------ | ----------------- | ----------------- | ----- |
| Chief Data Officer | _________________ | _________________ | _____ |
| General Counsel    | _________________ | _________________ | _____ |
| VP of Exploration  | _________________ | _________________ | _____ |
| HSE Director       | _________________ | _________________ | _____ |
| CFO                | _________________ | _________________ | _____ |
| CEO                | _________________ | _________________ | _____ |

---

## Summary

Congratulations on completing the hands-on lab: **Draft a Data Retention Policy for an Oil Exploration Company**. In this lab, you explored how to develop a comprehensive data retention policy for PetroQuest Energy.

### What you accomplished:

| Task             | Activity                                                                                                                           |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **Task 1** | Identified data types and defined policy objectives                                                                                |
| **Task 2** | Researched applicable regulations (EPA, OSHA, SOX, GDPR, etc.)                                                                     |
| **Task 3** | Conducted stakeholder consultations with key teams                                                                                 |
| **Task 4** | Categorized data into logical groups (Critical Operational, Compliance, Financial, HSE, Administrative, Archived)                  |
| **Task 5** | Defined retention periods for each data category (3 years to permanent)                                                            |
| **Task 6** | Created structured policy document with purpose, scope, roles, retention schedule, archiving, disposal, legal hold, and compliance |

### Key Takeaways:

1. **Data retention policies** are essential for regulatory compliance, operational efficiency, and legal protection
2. **Oil exploration companies** handle diverse data types with varying retention requirements
3. **Regulatory landscape** includes environmental (EPA), financial (SOX), safety (OSHA), and privacy (GDPR/CCPA) requirements
4. **Stakeholder consultation** ensures policy meets operational needs while maintaining compliance
5. **Retention periods** must balance legal requirements with business value and storage costs
6. **Secure disposal** procedures are as important as retention for protecting sensitive information
7. **Legal hold processes** prevent data destruction during litigation
8. **Regular policy reviews** keep retention schedules aligned with changing regulations

### Business Value:

This data retention policy enables PetroQuest Energy to:

- **Respond confidently** to regulatory requests and legal disputes
- **Reduce storage costs** by eliminating unnecessary data
- **Protect proprietary information** through proper classification and disposal
- **Demonstrate compliance** during audits and investigations
- **Preserve valuable historical data** for future exploration activities
- **Standardize practices** across all business units and locations

---

## Exemplar Comparison

Here is the exemplar document for your reference.

Please remember that the exemplar is just a point of view and not a definitive solution. Your data retention policy may include additional categories or different retention periods based on your specific regulatory environment and business requirements.

---

*Lab completed: _________________*
*Instructor signature: _________________*
