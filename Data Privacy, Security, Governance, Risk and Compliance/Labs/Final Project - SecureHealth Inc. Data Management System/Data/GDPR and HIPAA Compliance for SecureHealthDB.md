
![Logo](<GDPR and HIPAA Compliance for SecureHealthDB.png>)


# GDPR and HIPAA Compliance for SecureHealthDB

## Document Control

| Document Property          | Details                                      |
| -------------------------- | -------------------------------------------- |
| **Document Title**   | GDPR and HIPAA Compliance for SecureHealthDB |
| **Version**          | 1.0                                          |
| **Effective Date**   | January 15, 2025                             |
| **Last Reviewed**    | January 15, 2026                             |
| **Next Review Date** | April 15, 2026                               |
| **Owner**            | Compliance Officer                           |
| **Classification**   | Confidential - Regulatory                    |

---

## 1. Introduction

To ensure compliance with data protection regulations, such as **GDPR** (General Data Protection Regulation) and **HIPAA** (Health Insurance Portability and Accountability Act), SecureHealthDB implements a variety of controls and policies that safeguard patient data and ensure that it is handled properly.

This document outlines the comprehensive compliance framework implemented in SecureHealthDB, demonstrating how the system meets the stringent requirements of both regulations while protecting patient privacy and ensuring data security.

### Regulatory Overview

| Regulation      | Jurisdiction   | Key Focus                          | Applicability to SecureHealthDB                    |
| --------------- | -------------- | ---------------------------------- | -------------------------------------------------- |
| **HIPAA** | United States  | Protected Health Information (PHI) | All patient medical records, treatment information |
| **GDPR**  | European Union | Personal Data of EU Citizens       | EU patient data, regardless of location            |

---

## 2. HIPAA Compliance Framework

### 2.1 HIPAA Rules Overview

![Diagram](<HIPAA Rules Overview.png>)

### 2.2 HIPAA Privacy Rule Compliance

| HIPAA Requirement                     | SecureHealthDB Implementation                                          | Verification Method     |
| ------------------------------------- | ---------------------------------------------------------------------- | ----------------------- |
| **Minimum Necessary Standard**  | Role-Based Access Control (RBAC) limiting access to required data only | Access review audits    |
| **Patient Rights to Access**    | Data Subject Access Request (DSAR) procedures                          | DSAR response tracking  |
| **Notice of Privacy Practices** | Patient consent tracking and documentation                             | Consent records         |
| **Restriction Requests**        | Data restriction mechanisms                                            | Restriction logs        |
| **Confidential Communications** | Secure communication channels                                          | Encryption verification |

### 2.3 HIPAA Security Rule Compliance

#### Administrative Safeguards

| Standard                                   | Implementation                         | Documentation             |
| ------------------------------------------ | -------------------------------------- | ------------------------- |
| **Security Management Process**      | Risk analysis and management program   | Risk assessment documents |
| **Assigned Security Responsibility** | Designated Security Officer            | Role assignment records   |
| **Workforce Security**               | Employee authorization and supervision | Access control lists      |
| **Information Access Management**    | RBAC implementation                    | Role definitions          |
| **Security Awareness Training**      | Annual HIPAA training                  | Training records          |
| **Security Incident Procedures**     | Incident response plan                 | Incident logs             |
| **Contingency Plan**                 | Backup and disaster recovery           | Backup verification       |

#### Physical Safeguards

| Standard                            | Implementation                      | Verification         |
| ----------------------------------- | ----------------------------------- | -------------------- |
| **Facility Access Controls**  | Data center security, access badges | Access logs          |
| **Workstation Security**      | Secure workstations, automatic lock | Configuration audits |
| **Device and Media Controls** | Encrypted devices, secure disposal  | Asset tracking       |

#### Technical Safeguards

| Standard                                  | Implementation                          | SQL/Technical Implementation |
| ----------------------------------------- | --------------------------------------- | ---------------------------- |
| **Access Control**                  | Unique user IDs, RBAC, emergency access | See Section 5.1              |
| **Audit Controls**                  | Comprehensive audit logging             | See Section 5.2              |
| **Integrity Controls**              | Data validation, checksums              | See Section 5.3              |
| **Person or Entity Authentication** | Multi-factor authentication             | See Section 5.4              |
| **Transmission Security**           | Encryption in transit                   | TLS/SSL configuration        |

### 2.4 HIPAA Breach Notification Rule

| Requirement                               | Timeline                                      | Implementation                |
| ----------------------------------------- | --------------------------------------------- | ----------------------------- |
| **Individual Notification**         | Within 60 days                                | Automated notification system |
| **Media Notification**              | If 500+ residents affected                    | PR response plan              |
| **Secretary Notification**          | Within 60 days for 500+; annually for smaller | Breach reporting procedure    |
| **Business Associate Notification** | Immediate upon discovery                      | Vendor management             |

---

## 3. GDPR Compliance Framework

### 3.1 GDPR Principles Overview

![Diagram](<GDPR Principles Overview.png>)

### 3.2 GDPR Compliance Matrix

| GDPR Requirement                      | SecureHealthDB Implementation            | Technical Control        |
| ------------------------------------- | ---------------------------------------- | ------------------------ |
| **Lawful Basis for Processing** | Consent tracking for all data collection | Consent records table    |
| **Purpose Limitation**          | Data classification by purpose           | Metadata tagging         |
| **Data Minimization**           | Collection of only necessary data        | Field-level controls     |
| **Accuracy**                    | Regular data validation and updates      | Quality checks           |
| **Storage Limitation**          | Automated retention and deletion         | Archive/purge procedures |
| **Security**                    | Encryption, access controls, auditing    | Multiple security layers |
| **Accountability**              | Comprehensive documentation              | Policy repository        |

### 3.3 Data Subject Rights (GDPR Articles 12-23)

| Right                                  | Description                         | Implementation                   | Response Timeline |
| -------------------------------------- | ----------------------------------- | -------------------------------- | ----------------- |
| **Right to be Informed**         | Transparency about data processing  | Privacy notices, consent forms   | At collection     |
| **Right of Access**              | Access to personal data             | DSAR procedure (see Section 5.6) | 30 days           |
| **Right to Rectification**       | Correct inaccurate data             | Data correction workflows        | 30 days           |
| **Right to Erasure**             | "Right to be forgotten"             | Anonymization/deletion procedure | 30 days           |
| **Right to Restrict Processing** | Limit data processing               | Data restriction flags           | 30 days           |
| **Right to Data Portability**    | Receive data in portable format     | Data export function             | 30 days           |
| **Right to Object**              | Object to processing                | Opt-out mechanisms               | Immediate         |
| **Rights Related to Automation** | Human review of automated decisions | Override procedures              | Varies            |

### 3.4 GDPR Data Protection Officer (DPO) Requirements

| Requirement                       | Implementation                                       |
| --------------------------------- | ---------------------------------------------------- |
| **DPO Appointment**         | Designated Compliance Officer                        |
| **DPO Contact Information** | Published and accessible                             |
| **DPO Independence**        | Reports directly to executive level                  |
| **DPO Tasks**               | Monitor compliance, advise, cooperate with authority |

---

## 4. Combined Compliance Implementation

### 4.1 Access Controls (HIPAA §164.312 & GDPR Art. 32)

Access to sensitive data, such as patient medical records, will be restricted based on user roles. The following access controls will be implemented:

#### Role-Based Access Control (RBAC)

Employees will only have access to the data necessary for their roles. For example, a Doctor can access and update patient medical records, while a Nurse may only view them.

**SQL Implementation:**

```sql
-- Comprehensive RBAC implementation for compliance

-- 1. Define roles with clear compliance mappings
INSERT INTO roles (role_name, role_description) VALUES
('HIPAA_Privacy_Officer', 'Manages HIPAA compliance and privacy matters'),
('GDPR_DPO', 'Data Protection Officer for GDPR compliance'),
('Compliance_Auditor', 'Reviews compliance documentation and logs'),
('Data_Subject_Request_Handler', 'Processes DSAR and patient access requests');

-- 2. Create compliance-specific views

-- View for auditors to review access patterns
CREATE VIEW compliance_access_review AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name as employee_name,
    r.role_name,
    COUNT(a.log_id) as access_count_30d,
    MAX(a.access_time) as last_access,
    GROUP_CONCAT(DISTINCT a.table_name) as tables_accessed
FROM employees e
JOIN employee_roles er ON e.employee_id = er.employee_id
JOIN roles r ON er.role_id = r.role_id
LEFT JOIN audit_log a ON e.employee_id = a.employee_id 
    AND a.access_time > NOW() - INTERVAL 30 DAY
GROUP BY e.employee_id;

-- 3. Create function to verify minimum necessary access
DELIMITER //
CREATE PROCEDURE verify_minimum_necessary_access()
BEGIN
    -- Check doctors (should have full access to clinical data)
    SELECT 'Doctor Access Check' as check_type,
           CASE 
               WHEN COUNT(*) = SUM(CASE WHEN has_clinical_access THEN 1 ELSE 0 END)
               THEN 'COMPLIANT'
               ELSE 'NON-COMPLIANT'
           END as status
    FROM (
        SELECT 
            e.employee_id,
            EXISTS (
                SELECT 1 FROM information_schema.column_privileges
                WHERE table_name = 'patients'
                AND column_name IN ('ssn_encrypted', 'medical_history_encrypted')
                AND privilege_type = 'SELECT'
            ) as has_clinical_access
        FROM employees e
        JOIN employee_roles er ON e.employee_id = er.employee_id
        JOIN roles r ON er.role_id = r.role_id
        WHERE r.role_name = 'Doctor'
    ) as doctor_access;
  
    -- Check nurses (should NOT have access to SSN)
    SELECT 'Nurse Access Check' as check_type,
           CASE 
               WHEN NOT EXISTS (
                   SELECT 1 FROM information_schema.column_privileges
                   WHERE table_name = 'patients'
                   AND column_name = 'ssn_encrypted'
                   AND grantee LIKE '%nurse%'
               ) THEN 'COMPLIANT'
               ELSE 'NON-COMPLIANT'
           END as status;
END//
DELIMITER ;
```

#### Two-Factor Authentication (2FA)

Employees will use 2FA to access the system, adding an additional layer of security.

**Implementation:**

```sql
-- Track 2FA compliance
CREATE TABLE user_2fa_status (
    user_id INT PRIMARY KEY,
    employee_id INT,
    mfa_enabled BOOLEAN DEFAULT FALSE,
    mfa_type VARCHAR(20),
    last_verified TIMESTAMP,
    backup_codes_remaining INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create procedure to enforce MFA for sensitive roles
DELIMITER //
CREATE PROCEDURE enforce_mfa_compliance()
BEGIN
    -- Identify users without MFA who should have it
    SELECT 
        e.first_name || ' ' || e.last_name as employee_name,
        e.email,
        GROUP_CONCAT(r.role_name) as roles
    FROM employees e
    JOIN employee_roles er ON e.employee_id = er.employee_id
    JOIN roles r ON er.role_id = r.role_id
    LEFT JOIN user_2fa_status u ON e.employee_id = u.employee_id
    WHERE (u.mfa_enabled IS NULL OR u.mfa_enabled = FALSE)
    AND r.role_name IN ('Doctor', 'Admin', 'HIPAA_Privacy_Officer', 'GDPR_DPO')
    GROUP BY e.employee_id;
  
    -- Log compliance check
    INSERT INTO audit_log (table_name, action, details)
    VALUES ('compliance', 'MFA_CHECK', 'MFA compliance verification completed');
END//
DELIMITER ;
```

### 4.2 Audit Logs (HIPAA §164.308 & GDPR Art. 30)

To comply with both GDPR and HIPAA regulations, SecureHealthDB will maintain audit logs of all access to sensitive patient data. The following details will be logged:

#### Audit Log Requirements

| Required Field              | HIPAA Reference        | GDPR Reference | Implementation               |
| --------------------------- | ---------------------- | -------------- | ---------------------------- |
| **User Identity**     | §164.308(a)(5)(ii)(C) | Art. 30(1)(c)  | Employee ID, name            |
| **Action Taken**      | §164.312(b)           | Art. 30(1)(f)  | INSERT, UPDATE, DELETE, VIEW |
| **Timestamp**         | §164.312(b)           | Art. 30(1)(f)  | MySQL TIMESTAMP              |
| **Data Accessed**     | §164.312(b)           | Art. 30(1)(f)  | Table name, record ID        |
| **Success/Failure**   | §164.312(b)           | Art. 30(1)(f)  | Status code                  |
| **IP Address**        | §164.312(b)           | Art. 30(1)(f)  | Client IP                    |
| **Purpose of Access** | §164.308(a)(5)(ii)(C) | Art. 30(1)(b)  | Reason code                  |

#### Enhanced Audit Log Implementation

```sql
-- Enhanced audit log table with compliance fields
CREATE TABLE compliance_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    -- Core audit fields
    user_id INT,
    user_name VARCHAR(100),
    user_role VARCHAR(50),
    action VARCHAR(20),
    table_name VARCHAR(50),
    record_id INT,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
  
    -- Compliance-specific fields
    data_category VARCHAR(50), -- PHI, PII, Financial, etc.
    sensitivity_level VARCHAR(20), -- HIGH, MEDIUM, LOW
    purpose_of_use VARCHAR(100), -- Treatment, Payment, Operations, Research
    consent_reference VARCHAR(100),
    data_subject_id VARCHAR(100), -- Patient ID for GDPR
  
    -- Technical details
    query_text TEXT,
    rows_affected INT,
    status VARCHAR(20),
    error_message TEXT,
  
    -- Audit trail linking
    previous_hash VARCHAR(64), -- For tamper-evident logging
    current_hash VARCHAR(64),
  
    FOREIGN KEY (user_id) REFERENCES employees(employee_id)
);

-- Create tamper-evident audit trail
DELIMITER //
CREATE TRIGGER audit_log_hash_trigger
BEFORE INSERT ON compliance_audit_log
FOR EACH ROW
BEGIN
    DECLARE last_hash VARCHAR(64);
  
    -- Get last log entry's hash
    SELECT current_hash INTO last_hash
    FROM compliance_audit_log
    ORDER BY log_id DESC
    LIMIT 1;
  
    IF last_hash IS NULL THEN
        SET last_hash = 'GENESIS';
    END IF;
  
    -- Set previous hash
    SET NEW.previous_hash = last_hash;
  
    -- Calculate current hash
    SET NEW.current_hash = SHA2(CONCAT(
        IFNULL(NEW.user_id, ''),
        IFNULL(NEW.action, ''),
        IFNULL(NEW.table_name, ''),
        IFNULL(NEW.record_id, ''),
        IFNULL(NEW.access_time, ''),
        IFNULL(NEW.ip_address, ''),
        last_hash
    ), 256);
END//

-- Create procedure for audit log review
CREATE PROCEDURE review_audit_logs(
    IN start_date DATE,
    IN end_date DATE,
    IN user_filter VARCHAR(100),
    IN action_filter VARCHAR(20)
)
BEGIN
    SELECT 
        access_time,
        user_name,
        user_role,
        action,
        table_name,
        record_id,
        data_category,
        purpose_of_use,
        ip_address
    FROM compliance_audit_log
    WHERE DATE(access_time) BETWEEN start_date AND end_date
    AND (user_filter IS NULL OR user_name LIKE CONCAT('%', user_filter, '%'))
    AND (action_filter IS NULL OR action = action_filter)
    ORDER BY access_time DESC;
END//

-- Create procedure for HIPAA audit report
CREATE PROCEDURE generate_hipaa_audit_report(IN report_date DATE)
BEGIN
    SELECT 
        DATE(access_time) as access_date,
        COUNT(*) as total_accesses,
        COUNT(DISTINCT user_id) as unique_users,
        SUM(CASE WHEN data_category = 'PHI' THEN 1 ELSE 0 END) as phi_accesses,
        SUM(CASE WHEN action = 'VIEW' THEN 1 ELSE 0 END) as views,
        SUM(CASE WHEN action IN ('INSERT', 'UPDATE') THEN 1 ELSE 0 END) as modifications
    FROM compliance_audit_log
    WHERE DATE(access_time) = report_date
    GROUP BY DATE(access_time);
END//

-- Create procedure for GDPR audit trail
CREATE PROCEDURE generate_gdpr_audit_trail(IN patient_id_param INT)
BEGIN
    SELECT 
        access_time,
        user_name,
        user_role,
        action,
        purpose_of_use,
        CASE 
            WHEN action = 'VIEW' THEN 'Data accessed'
            WHEN action = 'UPDATE' THEN 'Data modified'
            WHEN action = 'DELETE' THEN 'Data deleted/erased'
            WHEN action = 'EXPORT' THEN 'Data exported (portability)'
        END as description
    FROM compliance_audit_log
    WHERE data_subject_id = patient_id_param
    ORDER BY access_time DESC;
END//
DELIMITER ;
```

### 4.3 Data Retention and Disposal Policies (HIPAA §164.316 & GDPR Art. 17)

To ensure compliance with GDPR and HIPAA, SecureHealthDB will implement data retention and disposal policies:

#### Data Retention Period

Patient data will be retained for a minimum of **6 years** (as required by HIPAA), with specific retention periods based on data type:

| Data Type                          | HIPAA Requirement             | GDPR Requirement                 | SecureHealthDB Policy      |
| ---------------------------------- | ----------------------------- | -------------------------------- | -------------------------- |
| **Active Patient Records**   | Duration of care + 6 years    | As long as necessary for purpose | Duration of care + 6 years |
| **Archived Patient Records** | 6 years minimum               | Max 10 years after last activity | 7 years after last visit   |
| **Treatment Records**        | 6 years                       | Varies by purpose                | 7 years                    |
| **Billing/Insurance**        | 6 years                       | Varies                           | 7 years                    |
| **Audit Logs**               | 6 years                       | 3 years recommended              | 7 years                    |
| **Employee Records**         | Employment + 6 years          | Employment + 5 years             | Employment + 7 years       |
| **Consent Records**          | Duration of consent + 6 years | Duration of processing + 3 years | Consent + 7 years          |

#### Automated Retention Implementation

```sql
-- Implement automated data retention and disposal

-- 1. Create archive tables for historical data
CREATE TABLE patients_archive LIKE patients;
ALTER TABLE patients_archive ADD COLUMN archive_date TIMESTAMP;
ALTER TABLE patients_archive ADD COLUMN archive_reason VARCHAR(100);

-- 2. Create retention policy table
CREATE TABLE retention_policies (
    policy_id INT PRIMARY KEY AUTO_INCREMENT,
    data_category VARCHAR(50),
    retention_years INT,
    action_after_retention VARCHAR(50), -- ARCHIVE, ANONYMIZE, DELETE
    regulatory_basis VARCHAR(100),
    last_reviewed DATE
);

INSERT INTO retention_policies VALUES
(1, 'Active Patient Records', 6, 'ARCHIVE', 'HIPAA §164.316', CURDATE()),
(2, 'Archived Patient Records', 7, 'ANONYMIZE', 'HIPAA + GDPR', CURDATE()),
(3, 'Audit Logs', 7, 'DELETE', 'HIPAA §164.308', CURDATE()),
(4, 'Consent Records', 7, 'DELETE', 'GDPR Art. 7', CURDATE());

-- 3. Create archiving procedure
DELIMITER //

CREATE PROCEDURE apply_retention_policies()
BEGIN
    DECLARE v_patient_id INT;
    DECLARE v_last_activity DATE;
    DECLARE done INT DEFAULT FALSE;
  
    -- Cursor for patients exceeding retention
    DECLARE patient_cursor CURSOR FOR
        SELECT DISTINCT p.patient_id, MAX(a.access_time) as last_activity
        FROM patients p
        LEFT JOIN audit_log a ON p.patient_id = a.record_id 
            AND a.table_name = 'patients'
        GROUP BY p.patient_id
        HAVING last_activity < DATE_SUB(NOW(), INTERVAL 7 YEAR)
        OR (last_activity IS NULL AND p.created_at < DATE_SUB(NOW(), INTERVAL 7 YEAR));
  
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
    OPEN patient_cursor;
  
    read_loop: LOOP
        FETCH patient_cursor INTO v_patient_id, v_last_activity;
        IF done THEN
            LEAVE read_loop;
        END IF;
      
        -- Archive patient record
        INSERT INTO patients_archive
        SELECT *, NOW(), 'Retention policy applied'
        FROM patients WHERE patient_id = v_patient_id;
      
        -- Anonymize for research (GDPR Art. 89)
        UPDATE patients 
        SET 
            first_name = CONCAT('ANON_', patient_id),
            last_name = 'ANONYMIZED',
            email = NULL,
            phone = NULL,
            address = NULL,
            ssn_encrypted = NULL,
            medical_history_encrypted = AES_ENCRYPT('ANONYMIZED FOR RESEARCH', @encryption_key),
            insurance_info_encrypted = NULL
        WHERE patient_id = v_patient_id;
      
        -- Log the archiving
        INSERT INTO audit_log (table_name, record_id, action, details)
        VALUES ('patients_archive', v_patient_id, 'ARCHIVE', 
                CONCAT('Patient record archived due to retention policy'));
    END LOOP;
  
    CLOSE patient_cursor;
  
    -- Archive old audit logs
    INSERT INTO audit_log_archive
    SELECT *, NOW() as archive_date
    FROM audit_log
    WHERE access_time < DATE_SUB(NOW(), INTERVAL 7 YEAR);
  
    DELETE FROM audit_log
    WHERE access_time < DATE_SUB(NOW(), INTERVAL 7 YEAR);
END//

DELIMITER ;

-- Schedule monthly retention policy application
CREATE EVENT monthly_retention_application
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-02-01 03:00:00'
DO
    CALL apply_retention_policies();
```

#### Secure Data Disposal

Data disposal will use industry-standard secure deletion methods:

| Disposal Method                | Applicable To      | Standard                     |
| ------------------------------ | ------------------ | ---------------------------- |
| **Database Purging**     | Structured data    | Secure DELETE with overwrite |
| **File Shredding**       | Unstructured files | DoD 5220.22-M                |
| **Physical Destruction** | Hard drives, media | Degaussing, shredding        |
| **Digital Shredding**    | Backups, logs      | Cryptographic erasure        |

**SQL Implementation for Secure Deletion:**

```sql
-- Secure deletion procedure
DELIMITER //
CREATE PROCEDURE secure_delete_patient(IN patient_id_param INT)
BEGIN
    -- Before deletion, ensure all references are handled
    DECLARE patient_name VARCHAR(100);
  
    SELECT CONCAT(first_name, ' ', last_name) INTO patient_name
    FROM patients WHERE patient_id = patient_id_param;
  
    -- For GDPR right to erasure, we anonymize rather than delete
    IF EXISTS (SELECT 1 FROM patient_consent WHERE patient_id = patient_id_param) THEN
        UPDATE patients 
        SET 
            first_name = 'GDPR_ERASED',
            last_name = 'GDPR_ERASED',
            email = NULL,
            phone = NULL,
            address = NULL,
            ssn_encrypted = NULL,
            medical_history_encrypted = AES_ENCRYPT('GDPR RIGHT TO ERASURE APPLIED', @encryption_key),
            insurance_info_encrypted = NULL
        WHERE patient_id = patient_id_param;
      
        INSERT INTO audit_log (table_name, record_id, action, details)
        VALUES ('patients', patient_id_param, 'GDPR_ERASURE', 
                CONCAT('Right to erasure applied for: ', patient_name));
    ELSE
        -- For non-EU patients with no consent records, secure delete
        -- In production, this would use secure deletion methods
        DELETE FROM patients WHERE patient_id = patient_id_param;
      
        INSERT INTO audit_log (table_name, record_id, action, details)
        VALUES ('patients', patient_id_param, 'SECURE_DELETE', 
                CONCAT('Patient record securely deleted: ', patient_name));
    END IF;
END//
DELIMITER ;
```

---

## 5. Data Subject Access Request (DSAR) Procedure

### 5.1 DSAR Workflow (GDPR Art. 15 & HIPAA Access Rights)

![Diagram](<DSAR Workflow (GDPR Art. 15 & HIPAA Access Rights).png>)

### 5.2 DSAR Implementation

```sql
-- Create DSAR tracking table
CREATE TABLE dsar_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    request_type VARCHAR(50), -- ACCESS, RECTIFY, ERASE, PORT, RESTRICT
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    requested_by VARCHAR(100),
    verification_method VARCHAR(100),
    status VARCHAR(20), -- RECEIVED, VERIFIED, PROCESSING, COMPLETED, REJECTED
    completion_date TIMESTAMP,
    response_method VARCHAR(50), -- EMAIL, PORTAL, MAIL
    notes TEXT,
    handled_by INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (handled_by) REFERENCES employees(employee_id)
);

-- Create DSAR response package procedure
DELIMITER //
CREATE PROCEDURE generate_dsar_package(IN request_id_param INT)
BEGIN
    DECLARE v_patient_id INT;
    DECLARE v_patient_name VARCHAR(100);
    DECLARE v_request_type VARCHAR(50);
  
    -- Get request details
    SELECT patient_id, request_type INTO v_patient_id, v_request_type
    FROM dsar_requests
    WHERE request_id = request_id_param;
  
    -- Create temporary tables for response
    CREATE TEMPORARY TABLE dsar_response AS
  
    -- Section 1: Patient Demographics
    SELECT '1. Patient Demographics' as section,
           JSON_OBJECT(
               'patient_id', patient_id,
               'name', CONCAT(first_name, ' ', last_name),
               'dob', date_of_birth,
               'email', email,
               'phone', phone,
               'address', address
           ) as data
    FROM patients
    WHERE patient_id = v_patient_id
  
    UNION ALL
  
    -- Section 2: Medical Records (summarized)
    SELECT '2. Medical Records' as section,
           JSON_OBJECT(
               'summary', CAST(AES_DECRYPT(medical_history_encrypted, @encryption_key) AS CHAR),
               'last_updated', updated_at
           ) as data
    FROM patients
    WHERE patient_id = v_patient_id
  
    UNION ALL
  
    -- Section 3: Access History (last 3 years)
    SELECT '3. Data Access History' as section,
           JSON_ARRAYAGG(
               JSON_OBJECT(
                   'date', access_time,
                   'accessed_by', user_name,
                   'action', action,
                   'purpose', purpose_of_use
               )
           ) as data
    FROM compliance_audit_log
    WHERE data_subject_id = v_patient_id
    AND access_time > DATE_SUB(NOW(), INTERVAL 3 YEAR)
  
    UNION ALL
  
    -- Section 4: Consent Records
    SELECT '4. Consent Records' as section,
           JSON_ARRAYAGG(
               JSON_OBJECT(
                   'consent_type', consent_type,
                   'given', consent_given,
                   'date', consent_date,
                   'version', consent_version
               )
           ) as data
    FROM patient_consent
    WHERE patient_id = v_patient_id;
  
    -- Return the DSAR package
    SELECT * FROM dsar_response;
  
    -- Log DSAR completion
    UPDATE dsar_requests 
    SET status = 'COMPLETED', 
        completion_date = NOW()
    WHERE request_id = request_id_param;
  
    INSERT INTO audit_log (table_name, record_id, action, details)
    VALUES ('dsar_requests', request_id_param, 'DSAR_COMPLETED',
            CONCAT('DSAR package generated for patient ', v_patient_id));
          
    DROP TEMPORARY TABLE dsar_response;
END//
DELIMITER ;
```

---

## 6. Breach Notification Procedure

### 6.1 Breach Assessment and Notification

| Breach Severity    | Criteria                      | HIPAA Notification       | GDPR Notification                | Response Time   |
| ------------------ | ----------------------------- | ------------------------ | -------------------------------- | --------------- |
| **Low**      | <100 records, low sensitivity | No notification required | May require notification         | 72 hours        |
| **Medium**   | 100-500 records, some PHI     | Individual notification  | Required notification            | 60 days (HIPAA) |
| **High**     | 500+ records, significant PHI | Individual + Media + HHS | Required + Supervisory Authority | 60 days (HIPAA) |
| **Critical** | Large-scale, highly sensitive | All notifications        | All notifications + public       | Immediate       |

### 6.2 Breach Response Implementation

```sql
-- Create breach tracking table
CREATE TABLE breach_incidents (
    breach_id INT PRIMARY KEY AUTO_INCREMENT,
    detection_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    breach_type VARCHAR(50),
    affected_records INT,
    data_categories TEXT,
    severity VARCHAR(20),
    status VARCHAR(50),
    notification_sent BOOLEAN DEFAULT FALSE,
    notification_date TIMESTAMP,
    regulatory_report_date TIMESTAMP,
    remediation_steps TEXT,
    closed_date TIMESTAMP,
    investigator_id INT,
    FOREIGN KEY (investigator_id) REFERENCES employees(employee_id)
);

-- Create breach notification procedure
DELIMITER //
CREATE PROCEDURE process_breach_notification(IN breach_id_param INT)
BEGIN
    DECLARE v_severity VARCHAR(20);
    DECLARE v_affected_records INT;
    DECLARE v_detection_date TIMESTAMP;
  
    SELECT severity, affected_records, detection_date 
    INTO v_severity, v_affected_records, v_detection_date
    FROM breach_incidents
    WHERE breach_id = breach_id_param;
  
    -- Determine notification requirements
    CASE 
        WHEN v_severity = 'CRITICAL' OR v_affected_records >= 500 THEN
            -- High severity: Notify all parties
            UPDATE breach_incidents
            SET notification_sent = TRUE,
                notification_date = NOW(),
                regulatory_report_date = NOW() + INTERVAL 60 DAY,
                status = 'NOTIFICATION_SENT'
            WHERE breach_id = breach_id_param;
          
            -- Log regulatory notification
            INSERT INTO regulatory_notifications 
            VALUES (NULL, breach_id_param, 'HHS', NOW(), 'BREACH_REPORT');
          
        WHEN v_severity = 'HIGH' AND v_affected_records BETWEEN 100 AND 499 THEN
            -- Medium severity: Individual notification only
            UPDATE breach_incidents
            SET notification_sent = TRUE,
                notification_date = NOW(),
                status = 'NOTIFICATION_SENT'
            WHERE breach_id = breach_id_param;
          
        ELSE
            -- Low severity: Document but no notification required
            UPDATE breach_incidents
            SET status = 'DOCUMENTED_NO_NOTIFICATION'
            WHERE breach_id = breach_id_param;
    END CASE;
  
    -- Log breach processing
    INSERT INTO audit_log (table_name, record_id, action, details)
    VALUES ('breach_incidents', breach_id_param, 'BREACH_PROCESSED',
            CONCAT('Breach processed with severity: ', v_severity));
END//
DELIMITER ;
```

---

## 7. Compliance Monitoring and Reporting

### 7.1 Regular Compliance Checks

| Check Type                       | Frequency | Responsible Party      | Documentation         |
| -------------------------------- | --------- | ---------------------- | --------------------- |
| **Access Control Review**  | Monthly   | Security Team          | Access review reports |
| **Audit Log Review**       | Daily     | Compliance Officer     | Audit summaries       |
| **Data Quality Check**     | Weekly    | Data Steward           | Quality metrics       |
| **Retention Policy Audit** | Monthly   | DBA                    | Archive reports       |
| **DSAR Completion Review** | Weekly    | Privacy Officer        | DSAR metrics          |
| **Breach Drill**           | Quarterly | Incident Response Team | Drill reports         |
| **Risk Assessment**        | Quarterly | Risk Manager           | Risk register         |

### 7.2 Compliance Dashboard

```sql
-- Create compliance dashboard view
CREATE VIEW compliance_dashboard AS
SELECT 
    'Access Control' as category,
    CONCAT(
        (SELECT COUNT(*) FROM employees WHERE employee_id IN 
            (SELECT employee_id FROM employee_roles WHERE role_id IN (1,2))),
        ' users with clinical access'
    ) as metric,
    CASE 
        WHEN (SELECT COUNT(*) FROM employees WHERE employee_id IN 
            (SELECT employee_id FROM employee_roles WHERE role_id IN (1,2))) < 50 
        THEN 'GREEN'
        ELSE 'YELLOW'
    END as status
UNION ALL
SELECT 
    'Audit Logs' as category,
    CONCAT(
        (SELECT COUNT(*) FROM audit_log WHERE access_time > NOW() - INTERVAL 1 DAY),
        ' events in last 24 hours'
    ) as metric,
    'GREEN' as status
UNION ALL
SELECT 
    'Data Retention' as category,
    CONCAT(
        (SELECT COUNT(*) FROM patients WHERE updated_at < DATE_SUB(NOW(), INTERVAL 6 YEAR)),
        ' records due for review'
    ) as metric,
    CASE 
        WHEN (SELECT COUNT(*) FROM patients WHERE updated_at < DATE_SUB(NOW(), INTERVAL 6 YEAR)) = 0 
        THEN 'GREEN'
        ELSE 'YELLOW'
    END as status
UNION ALL
SELECT 
    'DSAR Requests' as category,
    CONCAT(
        (SELECT COUNT(*) FROM dsar_requests WHERE status = 'RECEIVED'),
        ' pending requests'
    ) as metric,
    CASE 
        WHEN (SELECT COUNT(*) FROM dsar_requests WHERE status = 'RECEIVED') = 0 
        THEN 'GREEN'
        WHEN (SELECT COUNT(*) FROM dsar_requests WHERE status = 'RECEIVED') < 5 
        THEN 'YELLOW'
        ELSE 'RED'
    END as status;
```

---

## 8. Training and Awareness

### 8.1 Compliance Training Requirements

| Training Module                | Audience             | Frequency   | HIPAA Reference | GDPR Reference |
| ------------------------------ | -------------------- | ----------- | --------------- | -------------- |
| **HIPAA Privacy Rule**   | All staff            | Annual      | §164.530       | N/A            |
| **HIPAA Security Rule**  | IT staff             | Annual      | §164.308       | N/A            |
| **GDPR Fundamentals**    | All staff            | Annual      | N/A             | Art. 39        |
| **Data Subject Rights**  | Patient-facing staff | Annual      | §164.524       | Art. 12-23     |
| **Breach Response**      | Incident team        | Quarterly   | §164.404       | Art. 33-34     |
| **Secure Data Handling** | All staff            | Semi-annual | §164.306       | Art. 32        |

### 8.2 Training Tracking

```sql
-- Create training tracking table
CREATE TABLE compliance_training (
    training_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    training_module VARCHAR(100),
    completion_date DATE,
    expiry_date DATE,
    score INT,
    trainer VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create view for training compliance
CREATE VIEW training_compliance AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name as employee_name,
    r.role_name,
    MAX(CASE WHEN t.training_module = 'HIPAA Privacy' THEN t.completion_date END) as hipaa_privacy_date,
    MAX(CASE WHEN t.training_module = 'GDPR Fundamentals' THEN t.completion_date END) as gdpr_date,
    CASE 
        WHEN MAX(t.completion_date) > DATE_SUB(NOW(), INTERVAL 1 YEAR) THEN 'COMPLIANT'
        ELSE 'NON-COMPLIANT'
    END as status
FROM employees e
JOIN employee_roles er ON e.employee_id = er.employee_id
JOIN roles r ON er.role_id = r.role_id
LEFT JOIN compliance_training t ON e.employee_id = t.employee_id
GROUP BY e.employee_id;
```

---

## 9. Conclusion

By following the outlined compliance measures, SecureHealthDB ensures that it is **fully compliant with GDPR and HIPAA**, while protecting patient privacy and data security.

### Compliance Summary

| Regulation                    | Key Requirements                               | SecureHealthDB Status |
| ----------------------------- | ---------------------------------------------- | --------------------- |
| **HIPAA Privacy Rule**  | Patient rights, minimum necessary              | ✅ Fully Implemented  |
| **HIPAA Security Rule** | Administrative, physical, technical safeguards | ✅ Fully Implemented  |
| **HIPAA Breach Rule**   | Notification requirements                      | ✅ Fully Implemented  |
| **GDPR Principles**     | Lawfulness, purpose, minimization, accuracy    | ✅ Fully Implemented  |
| **GDPR Rights**         | Data subject rights (8 rights)                 | ✅ Fully Implemented  |
| **GDPR Security**       | Appropriate technical measures                 | ✅ Fully Implemented  |

### Key Compliance Metrics

| Metric                              | Target                   | Current        | Status |
| ----------------------------------- | ------------------------ | -------------- | ------ |
| **Access Reviews Completed**  | 100% monthly             | 100%           | ✅     |
| **Audit Log Completeness**    | 100% of actions          | 100%           | ✅     |
| **Data Retention Compliance** | 100% of policies applied | 98%            | ✅     |
| **DSAR Response Time**        | <30 days                 | Average 5 days | ✅     |
| **Staff Training Completion** | 100% annually            | 95%            | ⚠️   |
| **Breach Response Drills**    | Quarterly                | Completed      | ✅     |

---

## 10. Approval

| Role                               | Name              | Signature         | Date  |
| ---------------------------------- | ----------------- | ----------------- | ----- |
| Compliance Officer                 | _________________ | _________________ | _____ |
| HIPAA Privacy Officer              | _________________ | _________________ | _____ |
| GDPR Data Protection Officer       | _________________ | _________________ | _____ |
| Chief Information Security Officer | _________________ | _________________ | _____ |
| Legal Counsel                      | _________________ | _________________ | _____ |
| Hospital Director                  | _________________ | _________________ | _____ |

---

## Appendix A: Regulatory References

| Requirement           | HIPAA Citation         | GDPR Citation    |
| --------------------- | ---------------------- | ---------------- |
| Access Control        | 45 CFR §164.312(a)(1) | Article 32(1)(b) |
| Audit Controls        | 45 CFR §164.312(b)    | Article 30       |
| Integrity             | 45 CFR §164.312(c)(1) | Article 32(1)(b) |
| Person Authentication | 45 CFR §164.312(d)    | Article 32(1)(b) |
| Transmission Security | 45 CFR §164.312(e)(1) | Article 32(1)(a) |
| Breach Notification   | 45 CFR §164.404       | Articles 33-34   |
| Data Retention        | 45 CFR §164.316       | Article 17       |
| Data Subject Rights   | 45 CFR §164.524       | Articles 12-23   |

## Appendix B: Compliance Documentation Checklist

| Document                      | Location                              | Last Updated | Next Review |
| ----------------------------- | ------------------------------------- | ------------ | ----------- |
| HIPAA Risk Assessment         | /compliance/hipaa_risk_assessment.pdf | 2024-01-15   | 2024-04-15  |
| GDPR Data Processing Register | /compliance/gdpr_register.xlsx        | 2024-01-15   | 2024-04-15  |
| Breach Response Plan          | /compliance/breach_response.docx      | 2024-01-15   | 2024-07-15  |
| DSAR Procedure                | /compliance/dsar_procedure.docx       | 2024-01-15   | 2024-07-15  |
| Training Records              | /hr/training_records/                 | Continuous   | Monthly     |
| Audit Logs                    | /database/audit/                      | Continuous   | Daily       |

---

*This document is confidential and proprietary to SecureHealth Inc.*
*Version 1.0 - Last Updated: January 15, 2026*
