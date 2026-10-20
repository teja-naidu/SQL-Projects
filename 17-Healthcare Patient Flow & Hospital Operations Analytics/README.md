# Healthcare Patient Flow & Hospital Operations Analytics

**SQL Project 17 | DuckDB | Healthcare Operations | 5-Day Analytics Project | 73 SQL Queries**

## Project Overview

This project analyzes patient flow, admission outcomes, waiting times, referral categories, and recorded patient satisfaction to develop a practical hospital operations reporting framework. Using **DuckDB and SQL**, the project progresses from data exploration and quality checks to operational segmentation, patient experience analysis, and an executive KPI scorecard.

The analysis uses **9,216 patient records** spanning **April 1, 2023 through October 30, 2024**. Findings are descriptive and intended for analytics practice, not clinical decision-making.

## Project Objectives

- Profile patient demographics, admissions, and referral categories.
- Identify patient volume patterns by date, weekday, month, and arrival hour.
- Evaluate waiting times using averages, medians, percentiles, and long-wait rates.
- Compare referral categories and admission outcomes.
- Analyze satisfaction scores, response coverage, and potential response bias.
- Build consolidated KPIs, rolling trends, and a project-defined operational priority matrix.
- Document actionable areas for further operational investigation.

## Executive KPI Summary

| KPI | Result |
|---|---:|
| Patient records | 9,216 |
| Unique patient IDs | 9,216 |
| Admitted patients | 4,612 |
| Admission rate | 50.04% |
| Average waiting time | 35.26 minutes |
| Median waiting time | 35 minutes |
| 90th-percentile waiting time | 56 minutes |
| Patients waiting over 45 minutes | 2,750 |
| Long-wait rate | 29.84% |
| Recorded satisfaction responses | 2,517 |
| Satisfaction response rate | 27.31% |
| Average satisfaction among respondents | 4.99 / 10 |
| Missing satisfaction scores | 6,699 (72.69%) |

> **Important:** A wait of more than 45 minutes is a project-defined analytical threshold, not a verified hospital service-level agreement. Satisfaction findings reflect only patients with recorded scores.

## Dataset

**Source file:** `Dataset/healthcare_analytics_patient_flow_data.csv`  
**Database table:** `healthcare_raw`  
**Database engine:** DuckDB

| Source column | Meaning |
|---|---|
| `Patient Id` | Patient identifier |
| `Patient Admission Date` | Date of patient visit/admission record |
| `Patient Admission Time` | Recorded arrival time, in 12-hour format |
| `Merged` | Source field retained in the dataset; not used for the principal KPIs |
| `Patient Gender` | Recorded gender category |
| `Patient Age` | Patient age |
| `Patient Race` | Recorded race category |
| `Department Referral` | Referral category; includes literal `None` |
| `Patient Admission Flag` | `Admission` or `Not Admission` |
| `Patient Satisfaction Score` | Recorded satisfaction score on a 0–10 scale; often missing |
| `Patient Waittime` | Patient waiting time in minutes |

### Data preparation and interpretation

- All 9,216 patient IDs were unique in the analyzed data.
- The gender value `Femaleemale` appears in the source and is normalized to `Female` in relevant SQL analyses; the raw data is retained.
- `Department Referral = 'None'` indicates no recorded department referral and is **not** a clinical department.
- Satisfaction scores are missing for 72.69% of records, limiting generalization.
- The dataset does not contain staffing levels, treatment duration, discharge information, bed capacity, billing, insurance, or clinical severity.

## Repository Structure

```text
SQL-Project-17/
├── Dataset/
│   └── healthcare_analytics_patient_flow_data.csv
├── sql/
│   ├── schema.sql
│   └── queries.sql              # All 73 queries, Days 1–5
├── healthcare.duckdb            # Local DuckDB database (if retained)
├── insights.md                  # All five days of findings
└── README.md
```

> The tree illustrates the project-level layout. The exact parent directory name may differ in your repository. A local `.duckdb` database can be excluded from version control if you prefer a smaller repository.

## Five-Day SQL Analysis Roadmap

| Day | Focus | Query numbers |
|---|---|---|
| **Day 1** | Dataset exploration, quality checks, demographics, admissions, and baseline KPIs | 1–14 |
| **Day 2** | Patient flow, arrival patterns, and operational segmentation | 15–28 |
| **Day 3** | Waiting-time analysis, percentiles, department comparisons, and correlations | 29–43 |
| **Day 4** | Satisfaction distribution, demographic patterns, response coverage, and experience analysis | 44–58 |
| **Day 5** | Executive scorecards, month-over-month trends, rolling metrics, priority matrix, and final validation | 59–73 |

All queries are maintained sequentially in **`sql/queries.sql`**, and the detailed interpretation is maintained in **`insights.md`**.

## Key Findings

### 1. Nearly 30% of patients experienced long waits

**2,750 of 9,216** patient records had waiting times over 45 minutes (**29.84%**). The overall mean was **35.26 minutes**, and the 90th percentile was **56 minutes**.

### 2. Referral categories differ in long-wait rates and volume

**Physiotherapy** had the highest long-wait rate (**33.33%**), while **Neurology** had the highest average wait (**36.80 minutes**). However, the high-volume `None` referral category accounted for **1,590 long waits**, or **57.82%** of all long-wait records. These are different ways of measuring operational impact.

### 3. Satisfaction coverage is limited

Only **2,517 patients (27.31%)** had a recorded satisfaction score. The average among those respondents was **4.99/10**. Using project-defined satisfaction bands, **45.61% of responses** were in the low range (0–4), while **26.26%** were in the high range (8–10).

### 4. Many long-wait patients had no recorded feedback

**2,010 records** combined a wait over 45 minutes with a missing satisfaction score. This represents **21.81% of all records** and about **73.09% of long-wait records**. Improving feedback collection could help better understand this segment.

### 5. Patient volume had little linear association with average waiting time

The correlation between **daily patient count** and **daily average waiting time** was **+0.0429**. The correlation between **patient waiting time** and **satisfaction among respondents** was **−0.0212**. Neither finding establishes causation or rules out nonlinear relationships.

### 6. Monthly performance fluctuated

The highest monthly patient count was **530 in August 2024**, and the lowest was **431 in February 2024**. The three-month rolling average waiting time declined from **36.27 minutes in March 2024** to **34.76 minutes in October 2024**. Monthly counts are not normalized for month length.

### 7. Operational review should balance rate and volume

High-volume categories account for the most long-wait records, while smaller categories may have higher long-wait percentages. The Day 5 priority matrix is a **portfolio-defined analytical classification**, not an official clinical or hospital priority system.

## Recommendations for Further Investigation

1. Track average, median, 90th-percentile, and over-45-minute waiting times together.
2. Review patient-flow patterns for high-volume referral categories and clarify the meaning and use of the `None` referral value.
3. Examine referral categories with elevated long-wait rates, including Physiotherapy and Neurology.
4. Improve satisfaction-response coverage and report response rates alongside all satisfaction metrics.
5. Investigate late-evening and early-morning arrival patterns with additional staffing and capacity data when available.
6. Use rolling metrics and data-quality checks in recurring operational reporting.

These are exploratory recommendations. The dataset does not support definitive conclusions about staffing adequacy, clinical quality, or causes of dissatisfaction.

## SQL Techniques Demonstrated

- Data profiling and validation
- `GROUP BY`, `ORDER BY`, and conditional aggregation
- `CASE WHEN`, `FILTER`, `NULLIF`, and `COALESCE` where applicable
- Common Table Expressions (CTEs)
- `DATE_TRUNC`, `DAYOFWEEK`, `HOUR`, and `TRY_STRPTIME`
- `MEDIAN`, `QUANTILE_CONT`, and `CORR`
- Window functions including `LAG` and `SUM() OVER`
- Month-over-month comparisons and percentage-point changes
- Rolling three-month, observation-weighted waiting-time averages
- Executive KPI and segmentation queries

## How to Run the Project

### Prerequisites

- DuckDB CLI installed and available in your terminal
- Project dataset present in the `Dataset/` folder

### 1. Open the project directory

```powershell
cd path\to\SQL-Project-17
```

Replace the example path with your actual project folder.

### 2. Start DuckDB

```powershell
duckdb healthcare.duckdb
```

### 3. Initialize the schema if the database has not been created

From the DuckDB prompt:

```sql
.read sql/schema.sql
```

The exact setup depends on the contents of `sql/schema.sql` and whether the local database has already been initialized. Ensure that `healthcare_raw` exists before running the analysis.

### 4. Run all 73 queries

```sql
.read sql/queries.sql
```

### 5. Optionally save terminal results

```sql
.mode box
.output query_results.txt
.read sql/queries.sql
.output stdout
```

This writes the combined query output to `query_results.txt` in the working directory. Some wide tables may be truncated in standard terminal display; use `.mode line` when reviewing individual queries with many columns.

## Detailed Insights

See **[`insights.md`](insights.md)** for the full five-day findings, including query-level interpretations, operational comparisons, limitations, and recommendations.

See **[`sql/queries.sql`](sql/queries.sql)** for the complete SQL implementation.

## Project Limitations

- Satisfaction is missing for **72.69%** of patient records; respondents may not represent all patients.
- Correlations are descriptive, not causal.
- The `None` referral value should not be treated as a clinical department.
- The project uses analytical thresholds for waiting time, satisfaction bands, and operational priorities.
- Monthly patient counts are not adjusted for calendar month length.
- The dataset lacks staffing, capacity, discharge, acuity, and cost information needed for more advanced operational conclusions.
- Some final data-quality columns were truncated in the captured terminal output; do not treat unseen checks as independently verified.

## Project Outcome

This five-day portfolio project demonstrates how **DuckDB and SQL** can turn patient-level records into a structured operational analytics workflow: from exploration and data quality to trend analysis, patient experience metrics, and an executive scorecard.

**Completed:** 5 days of analysis · **73 SQL queries** · **9,216 patient records**
