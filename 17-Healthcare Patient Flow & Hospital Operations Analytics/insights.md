# SQL Project 17 – Healthcare Patient & Hospital Operations Analytics

## Day 1: Data Exploration & Data Quality Analysis

### Project Overview

This project analyzes healthcare patient records using DuckDB and SQL to understand patient demographics, hospital admissions, department referrals, waiting times, patient satisfaction, and data quality.

The objective is to identify operational trends, evaluate patient experiences, and generate data-driven insights that can help healthcare organizations improve hospital operations.

**Tools Used:** DuckDB, SQL, Git, GitHub

**Dataset:** healthcare_analytics_patient_flow_data.csv

---

## 1. Dataset Overview

The dataset contains 9,216 patient records across 11 columns.

### Key Dataset Statistics

| Metric | Value |
|--------|-------|
| Total Patient Records | 9,216 |
| Unique Patients | 9,216 |
| Total Columns | 11 |
| Average Patient Age | 39.86 years |
| Median Patient Age | 39 years |
| Average Patient Wait Time | 35.26 minutes |
| Average Patient Satisfaction Score | 4.99 / 10 |
| Earliest Admission Date | 2023-04-01 |
| Latest Admission Date | 2024-10-30 |
| Exact Duplicate Records | 0 |

### Key Insight

All 9,216 patient records have unique patient identifiers, and no exact duplicate records were identified.

The dataset covers approximately 19 months of patient activity, providing sufficient historical information to analyze admission patterns and operational performance.

---

## 2. Patient Gender Distribution

| Gender | Total Patients | Percentage |
|--------|---------------|------------|
| Male | 4,729 | 51.31% |
| Female | 4,470 | 48.50% |
| Femaleemale | 17 | 0.18% |

### Key Insights

- Male patients account for 51.31% of total records.
- Female patients account for 48.50% before data cleaning.
- A data quality issue was identified where 17 records contained the incorrect gender value "Femaleemale".
- After standardizing these records to "Female", the corrected female patient count becomes 4,487 (48.69%).

### Business Recommendation

Standardize gender values during the data transformation process to maintain consistency in demographic reporting.

---

## 3. Patient Age Distribution

### Age Statistics

| Metric | Value |
|--------|-------|
| Minimum Age | 1 year |
| Maximum Age | 79 years |
| Average Age | 39.86 years |
| Median Age | 39 years |

### Age Group Analysis

| Age Group | Total Patients | Percentage |
|-----------|---------------|------------|
| Under 18 | 1,971 | 21.39% |
| 18–30 | 1,572 | 17.06% |
| 31–45 | 1,748 | 18.97% |
| 46–60 | 1,727 | 18.74% |
| Above 60 | 2,198 | 23.85% |

### Key Insights

- Patients above 60 represent the largest age group at 23.85%.
- Patients under 18 represent the second-largest age group at 21.39%.
- The 18–30 age group has the lowest representation at 17.06%.
- The patient population is distributed across different age groups, with relatively higher representation among older adults and children.

### Business Recommendation

Hospital administrators should evaluate staffing and resource requirements for older adults and pediatric patients.

Additional analysis can determine whether these age groups experience longer waiting times or higher admission rates.

---

## 4. Department Referral Analysis

| Department | Total Patients |
|------------|---------------|
| None | 5,400 |
| General Practice | 1,840 |
| Orthopedics | 995 |
| Physiotherapy | 276 |
| Cardiology | 248 |
| Neurology | 193 |
| Gastroenterology | 178 |
| Renal | 86 |

### Key Insights

- Approximately 58.59% of patient records have no specified department referral.
- General Practice accounts for 1,840 records, making it the largest named referral department.
- Orthopedics ranks second among named departments with 995 referrals.
- Renal has the lowest referral count, with 86 records.

### Business Recommendation

Hospital management should examine the large proportion of patients without department referrals.

These records may represent patients who did not require a referral or another operational category.

The hospital should confirm the meaning of "None" before treating these records as missing data.

---

## 5. Hospital Admission Analysis

| Admission Status | Total Patients | Percentage |
|------------------|---------------|------------|
| Admission | 4,612 | 50.04% |
| Not Admission | 4,604 | 49.96% |

### Key Insights

- Approximately half of the patient records resulted in hospital admission.
- The admission rate is 50.04%.
- The difference between admitted and non-admitted patients is only eight records.

### Business Recommendation

Further analysis should investigate admission rates by age group, gender, department referral, and waiting time.

Understanding these patterns may help hospitals identify operational requirements and improve patient flow.

---

## 6. Patient Waiting Time Analysis

### Overall Waiting Time

Average Patient Wait Time: 35.26 minutes

### Waiting Time by Gender

| Gender | Average Wait Time | Minimum | Maximum |
|--------|-------------------|---------|---------|
| Male | 35.41 minutes | 10 | 60 |
| Female | 35.10 minutes | 10 | 60 |
| Femaleemale | 35.35 minutes | 12 | 59 |

### Key Insights

- The overall average waiting time is approximately 35 minutes.
- Male patients experience an average wait time of 35.41 minutes.
- Female patients experience an average wait time of 35.10 minutes.
- The difference between male and female average waiting times is approximately 0.31 minutes.
- The observed waiting-time range is between 10 and 60 minutes.

### Business Recommendation

Hospital management should evaluate waiting times by admission hour, department, and patient age group.

This analysis could help identify peak demand periods and opportunities to improve staffing allocation.

---

## 7. Patient Satisfaction Analysis

| Metric | Value |
|--------|-------|
| Patients With Satisfaction Scores | 2,517 |
| Patients Without Satisfaction Scores | 6,699 |
| Average Satisfaction Score | 4.99 / 10 |
| Minimum Satisfaction Score | 0 |
| Maximum Satisfaction Score | 10 |
| Satisfaction Response Coverage | 27.31% |

### Key Insights

- Only 27.31% of patients have recorded satisfaction scores.
- Approximately 72.69% of records have missing satisfaction scores.
- The average recorded satisfaction score is 4.99 out of 10.
- The large proportion of missing satisfaction scores limits the ability to generalize satisfaction findings across all patients.

### Business Recommendation

Hospitals should improve patient feedback collection and investigate whether satisfaction scores vary by waiting time, admission status, and department.

Future analysis should examine whether patients experiencing longer waits report lower satisfaction.

---

## 8. Monthly Patient Volume Analysis

| Month | Patient Records |
|-------|-----------------|
| Apr 2023 | 479 |
| May 2023 | 480 |
| Jun 2023 | 506 |
| Jul 2023 | 464 |
| Aug 2023 | 494 |
| Sep 2023 | 469 |
| Oct 2023 | 493 |
| Nov 2023 | 464 |
| Dec 2023 | 489 |
| Jan 2024 | 513 |
| Feb 2024 | 431 |
| Mar 2024 | 506 |
| Apr 2024 | 469 |
| May 2024 | 519 |
| Jun 2024 | 485 |
| Jul 2024 | 488 |
| Aug 2024 | 530 |
| Sep 2024 | 466 |
| Oct 2024 | 471 |

### Key Insights

- August 2024 recorded the highest patient volume, with 530 records.
- February 2024 recorded the lowest patient volume, with 431 records.
- Monthly patient volume remained relatively stable, generally ranging between 450 and 530 records.
- The dataset contains patient records from April 2023 through October 2024.

### Business Recommendation

Hospital administrators can use historical patient volumes to support workforce planning and operational forecasting.

Further analysis should investigate weekday, weekend, and hourly admission patterns to identify peak demand periods.

---

## 9. Data Quality Assessment

| Data Quality Check | Result |
|--------------------|--------|
| Total Records | 9,216 |
| Unique Patient IDs | 9,216 |
| Exact Duplicate Records | 0 |
| Missing Patient IDs | 0 |
| Missing Patient Ages | 0 |
| Missing Patient Genders | 0 |
| Missing Patient Wait Times | 0 |
| Missing Satisfaction Scores | 6,699 |
| Invalid Patient Ages | 0 |
| Invalid Wait Times | 0 |
| Invalid Admission Dates | 0 |
| Inconsistent Gender Values | 17 |

### Data Quality Findings

1. No exact duplicate patient records were identified.
2. No invalid patient ages were detected.
3. No negative patient waiting times were identified.
4. All admission dates were successfully interpreted.
5. Seventeen gender values require standardization.
6. Satisfaction scores are missing for 6,699 records.
7. Department Referral contains 5,400 records labeled "None", which should be treated as a separate category unless the source documentation indicates otherwise.

### Recommended Data Cleaning Actions

- Standardize "Femaleemale" to "Female".
- Preserve missing satisfaction scores as NULL rather than replacing them with zero.
- Maintain "None" as a distinct department referral category.
- Validate data types during CSV ingestion.
- Preserve the original raw dataset and apply transformations in a separate cleaned table or view.

---

## 10. Overall Business Insights

### Patient Demographics

The hospital serves patients across a wide age range, with older adults representing the largest age group.

### Hospital Admissions

The admission rate is approximately 50%, indicating an almost equal distribution between admitted and non-admitted patients.

### Operational Efficiency

The average patient waiting time is 35.26 minutes. Additional analysis is required to determine whether waiting times differ significantly across departments and admission periods.

### Patient Satisfaction

The average recorded satisfaction score is 4.99 out of 10. However, the low response coverage means this metric should be interpreted cautiously.

### Department Referrals

General Practice and Orthopedics account for the largest volumes among named referral departments.

### Data Quality

The dataset contains no exact duplicates or invalid age, wait-time, or admission-date values. The primary issues are inconsistent gender labels and incomplete satisfaction scores.

---

## 11. SQL Concepts Applied

Day 1 analysis used the following SQL concepts:

- SELECT and WHERE
- COUNT and COUNT DISTINCT
- AVG, MIN, MAX, and MEDIAN
- GROUP BY and ORDER BY
- CASE WHEN
- Common Table Expressions (CTEs)
- Window Functions
- Conditional Aggregation using FILTER
- COALESCE and NULLIF
- DATE_TRUNC
- TRY_CAST
- Data Quality Validation
- Duplicate Detection

---
