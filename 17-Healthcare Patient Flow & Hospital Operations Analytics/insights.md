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

---

# Day 2: Patient Demographics & Hospital Admission Pattern Analysis

## 1. Overview

Day 2 focuses on understanding patient admission patterns, demographic differences, department-level admission rates, patient arrival trends, and waiting-time variations.

The analysis uses 9,216 patient records collected between April 1, 2023, and October 30, 2024.

### Key Performance Indicators

| Metric | Value |
|---|---|
| Total Patient Records | 9,216 |
| Total Admitted Patients | 4,612 |
| Total Non-Admitted Patients | 4,604 |
| Overall Admission Rate | 50.04% |
| Average Patient Wait Time | 35.26 minutes |
| Peak Patient Arrival Hour | 11 PM |
| Highest Monthly Admission Rate | 54.51% (July 2024) |
| Invalid Admission Times | 0 |

## 2. Admission Rates by Age Group

The analysis compares admission rates across five age categories.

| Age Group | Total Patients | Admitted | Admission Rate |
|---|---:|---:|---:|
| Under 18 | 1,971 | 1,014 | 51.45% |
| 18–30 | 1,572 | 779 | 49.55% |
| 31–45 | 1,748 | 864 | 49.43% |
| 46–60 | 1,727 | 877 | 50.78% |
| Above 60 | 2,198 | 1,078 | 49.04% |

### Key Findings

- Patients under 18 recorded the highest admission rate at 51.45%.
- Patients above 60 accounted for the largest number of admissions, with 1,078 admitted patients.
- The 31–45 age group had an admission rate of 49.43%.
- Admission rates were relatively consistent across all age groups, ranging from 49.04% to 51.45%.

### Business Insight

Patient admission volumes vary across age groups, but admission rates show relatively small differences.

The above-60 population contributes the highest absolute admission volume, making it an important group for hospital capacity planning.

However, admission rates alone cannot establish differences in medical severity or healthcare needs.

## 3. Gender-Based Admission Analysis

Gender values were standardized within the SQL analysis by mapping the 17 records labeled "Femaleemale" to "Female".

| Gender | Total Patients | Admitted | Admission Rate |
|---|---:|---:|---:|
| Female | 4,487 | 2,250 | 50.14% |
| Male | 4,729 | 2,362 | 49.95% |

### Key Findings

- Male patients represented 4,729 records.
- Female patients represented 4,487 records after standardizing the gender typo.
- Female patients had a slightly higher admission rate of 50.14%.
- Male patients had an admission rate of 49.95%.
- The difference between gender-based admission rates was only 0.19 percentage points.

### Business Insight

Admission rates are nearly identical across male and female patients.

The dataset does not show a substantial gender-based admission-rate difference.

Gender standardization also demonstrates the importance of consistent categorical values before performing demographic analysis.

## 4. Department-Wise Admission Analysis

The analysis evaluates patient admission volume and admission rates across referral departments.

| Department Referral | Total Patients | Admitted | Admission Rate |
|---|---:|---:|---:|
| None | 5,400 | 2,736 | 50.67% |
| General Practice | 1,840 | 887 | 48.21% |
| Orthopedics | 995 | 498 | 50.05% |
| Physiotherapy | 276 | 137 | 49.64% |
| Cardiology | 248 | 122 | 49.19% |
| Neurology | 193 | 97 | 50.26% |
| Gastroenterology | 178 | 89 | 50.00% |
| Renal | 86 | 46 | 53.49% |

### Key Findings

- The "None" referral category accounted for the highest patient volume, with 5,400 records and 2,736 admissions.
- General Practice recorded 887 admissions.
- Orthopedics recorded 498 admissions.
- Renal had the highest admission rate at 53.49%, but only 86 patient records.
- General Practice had the lowest admission rate at 48.21%.

### Business Insight

Patient volume is concentrated in the "None", General Practice, and Orthopedics referral categories.

The "None" value is an actual category in the dataset and should not automatically be interpreted as missing data.

Renal recorded the highest admission rate, but its smaller sample size means that the result should be interpreted cautiously.

Department-level patient volume can support referral workload analysis and resource-planning discussions.

## 5. Daily and Weekly Patient Arrival Trends

### Day-of-Week Analysis

| Day | Total Patients | Admitted | Average Wait Time |
|---|---:|---:|---:|
| Monday | 1,314 | 653 | 35.67 min |
| Tuesday | 1,305 | 672 | 35.09 min |
| Wednesday | 1,260 | 629 | 35.19 min |
| Thursday | 1,332 | 649 | 34.88 min |
| Friday | 1,310 | 666 | 35.08 min |
| Saturday | 1,377 | 686 | 35.65 min |
| Sunday | 1,318 | 657 | 35.25 min |

### Key Findings

- Saturday recorded the highest total patient count at 1,377.
- Wednesday recorded the lowest total patient count at 1,260.
- Saturday also recorded the highest admitted-patient count at 686.
- Monday had the highest average wait time at 35.67 minutes.
- Thursday had the lowest average wait time at 34.88 minutes.

### Business Insight

Total patient volumes were relatively consistent across the seven weekdays.

Saturday recorded the highest cumulative volume, but comparing average daily demand requires adjusting for the number of Mondays, Tuesdays, and other weekdays in the dataset.

These findings provide an initial foundation for scheduling and workload analysis.

## 6. Weekday vs. Weekend Analysis

| Day Type | Total Patients | Admitted | Avg Wait Time | Admission Rate |
|---|---:|---:|---:|---:|
| Weekday | 6,521 | 3,269 | 35.18 min | 50.13% |
| Weekend | 2,695 | 1,343 | 35.45 min | 49.83% |

### Key Findings

- Weekdays accounted for 6,521 patient records.
- Weekends accounted for 2,695 patient records.
- Weekend waiting times averaged 35.45 minutes.
- Weekday waiting times averaged 35.18 minutes.
- Weekday admission rates were 0.30 percentage points higher.

### Business Insight

Average waiting times and admission rates were very similar between weekdays and weekends.

The higher cumulative weekday patient volume reflects the larger number of weekdays in the observation period and should not be interpreted directly as higher daily demand.

## 7. Hourly Patient Arrival Analysis

Patient admission times were converted from 12-hour AM/PM text into a 24-hour format using DuckDB's TRY_STRPTIME() function.

### Top Five Patient Arrival Hours

| Rank | Arrival Hour | Total Patients |
|---|---|---:|
| 1 | 11 PM (23:00) | 436 |
| 2 | 7 AM (07:00) | 415 |
| 3 | 1 PM (13:00) | 410 |
| 4 | 12 AM (00:00) | 406 |
| 5 | 11 AM (11:00) | 403 |

### Key Findings

- The highest number of recorded arrivals occurred at 11 PM, with 436 patients.
- The second-highest arrival hour was 7 AM, with 415 patients.
- The third-highest was 1 PM, with 410 patients.
- Patient arrivals were distributed across all 24 hours.
- All 9,216 admission-time values were successfully parsed.

### Business Insight

The 11 PM arrival hour represents the highest observed hourly patient volume.

Hourly arrival analysis can help hospitals identify potential staffing and registration workload patterns.

However, arrival volumes alone do not establish actual staffing shortages or capacity constraints.

## 8. Waiting Time by Age Group

| Age Group | Patients | Average Wait | Median Wait |
|---|---:|---:|---:|
| 31–45 | 1,748 | 35.51 min | 36 min |
| Under 18 | 1,971 | 35.46 min | 36 min |
| 18–30 | 1,572 | 35.30 min | 36 min |
| Above 60 | 2,198 | 35.10 min | 35 min |
| 46–60 | 1,727 | 34.94 min | 35 min |

### Key Findings

- Patients aged 31–45 had the highest average waiting time at 35.51 minutes.
- Patients aged 46–60 had the lowest average waiting time at 34.94 minutes.
- The difference between the highest and lowest average waiting times was only 0.57 minutes.
- Median waiting times ranged between 35 and 36 minutes.
- Recorded waiting times ranged from 10 to 60 minutes across age groups.

### Business Insight

Waiting times were highly consistent across age groups.

The small differences suggest that age-based averages alone do not reveal major waiting-time disparities in this dataset.

Further analysis by department, arrival hour, and admission status may help identify more meaningful operational patterns.

## 9. Waiting Time by Admission Status

| Admission Status | Patients | Average Wait | Median Wait |
|---|---:|---:|---:|
| Not Admission | 4,604 | 35.55 min | 36 min |
| Admission | 4,612 | 34.97 min | 35 min |

### Key Findings

- Non-admitted patients waited an average of 35.55 minutes.
- Admitted patients waited an average of 34.97 minutes.
- Non-admitted patients had a 0.58-minute higher average wait.
- Both groups had recorded waiting times between 10 and 60 minutes.

### Business Insight

The average waiting-time difference between admitted and non-admitted patients was minimal.

The available data does not establish whether waiting time influences admission decisions.

## 10. Monthly Admission Rate Trends

### Notable Monthly Results

| Month | Total Patients | Admitted | Admission Rate |
|---|---:|---:|---:|
| September 2023 | 469 | 249 | 53.09% |
| January 2024 | 513 | 269 | 52.44% |
| April 2024 | 469 | 217 | 46.27% |
| July 2024 | 488 | 266 | 54.51% |
| August 2024 | 530 | 242 | 45.66% |
| October 2024 | 471 | 247 | 52.44% |

### Key Findings

- July 2024 had the highest monthly admission rate at 54.51%.
- August 2024 had the lowest monthly admission rate at 45.66%.
- August 2024 recorded the highest monthly patient volume, with 530 records.
- January 2024 recorded the highest number of admitted patients, with 269.
- Monthly admission rates fluctuated around the overall admission rate of 50.04%.

### Business Insight

Higher patient arrival volume does not necessarily correspond to a higher admission rate.

August 2024 had the largest patient volume but the lowest admission rate.

These trends could be explored further using referral department, patient demographics, and admission patterns.

## 11. Combined Age Group and Gender Analysis

The analysis compares admission rates across age and gender segments.

### Notable Findings

- Female patients under 18 had an admission rate of 52.11%.
- Male patients aged 46–60 had an admission rate of 52.02%.
- Male patients aged 31–45 had an admission rate of 51.45%.
- Female patients above 60 had an admission rate of 51.29%.
- Male patients above 60 had an admission rate of 46.85%, the lowest among the ten analyzed segments.

### Business Insight

Although overall male and female admission rates were almost identical, individual age-and-gender segments showed greater variation.

For example, female patients above 60 had a 4.44-percentage-point higher admission rate than male patients in the same age group.

These differences are descriptive and do not establish medical or demographic causes.

## 12. Data Quality Validation

An additional validation checked whether patient admission times could be converted into a usable time format.

| Validation Metric | Result |
|---|---:|
| Total Records | 9,216 |
| Invalid Arrival Times | 0 |
| Successfully Parsed Times | 9,216 |
| Gender Values Standardized in Analysis | 17 |

All admission times were successfully parsed using TRY_STRPTIME().

The gender correction was applied within the relevant analytical queries without changing the raw source data.

## 13. Overall Day 2 Business Insights

1. **Balanced Admission Rates:** Overall admission rates remained close to 50% across most demographic and referral categories.

2. **Older Patient Volume:** Patients above 60 contributed the largest number of admissions among age groups, despite not having the highest admission rate.

3. **Referral Workload Concentration:** The "None", General Practice, and Orthopedics categories accounted for most patient records.

4. **Hourly Arrival Patterns:** The largest recorded arrival volume occurred at 11 PM, providing a useful starting point for examining staffing patterns.

5. **Consistent Waiting Times:** Average waiting times showed relatively small differences across age groups, genders, and admission outcomes.

6. **Monthly Variability:** Admission rates fluctuated across months, with July 2024 recording the highest rate and August 2024 recording the lowest.

7. **Data Quality:** All admission-time values were valid, and a known gender-label inconsistency was standardized during analysis.

## 14. SQL Concepts Practiced

Day 2 applied the following SQL concepts:

- Common Table Expressions (CTEs)
- Conditional aggregation using FILTER
- CASE WHEN expressions
- GROUP BY and ORDER BY
- DATE_TRUNC(), DAYNAME(), and DAYOFWEEK()
- TRY_STRPTIME() for time parsing
- HOUR() for hourly analysis
- DENSE_RANK() window function
- AVG(), MEDIAN(), MIN(), and MAX()
- COUNT() and percentage calculations
- NULLIF() to protect against division by zero
- Data standardization during aggregation

## 15. Day 2 Conclusion

Day 2 expanded the healthcare analytics project from basic data exploration into demographic segmentation and operational trend analysis.

The results show relatively balanced admission rates, consistent waiting times across demographic groups, and identifiable hourly and monthly patient-volume patterns.

These findings establish a foundation for deeper waiting-time, department performance, and patient satisfaction analysis.

**Day 2 Status: Completed**


---

# Day 3: Hospital Waiting Time & Department Performance Analysis

## 1. Overview

Day 3 focuses on evaluating hospital waiting-time performance, identifying longer patient waits, comparing referral departments, analyzing arrival-hour patterns, and exploring the relationship between waiting time and patient satisfaction.

The analysis covers 9,216 patient records from April 1, 2023, through October 30, 2024.

### Key Performance Indicators

| Metric | Value |
|---|---:|
| Total Patient Records | 9,216 |
| Average Waiting Time | 35.26 minutes |
| Median Waiting Time | 35 minutes |
| Patients Waiting Over 45 Minutes | 2,750 |
| Percentage Waiting Over 45 Minutes | 29.84% |
| Patients Waiting Within 45 Minutes | 6,466 |
| 75th Percentile Waiting Time | 48 minutes |
| 90th Percentile Waiting Time | 56 minutes |
| 95th Percentile Waiting Time | 58 minutes |
| Maximum Waiting Time | 60 minutes |
| Waiting Time–Satisfaction Correlation | -0.0212 |

**Analysis Note:** A waiting time greater than 45 minutes is classified as a long wait for this project. This is an analytical threshold, not a verified hospital service-level agreement.

## 2. Department-Wise Waiting Time Performance (Query 29)

| Department | Total Patients | Average Wait | Median Wait |
|---|---:|---:|---:|
| Neurology | 193 | 36.80 min | 38.0 min |
| Physiotherapy | 276 | 36.57 min | 38.5 min |
| Gastroenterology | 178 | 35.83 min | 36.0 min |
| Cardiology | 248 | 35.35 min | 35.0 min |
| None | 5,400 | 35.29 min | 35.0 min |
| Orthopedics | 995 | 34.98 min | 34.0 min |
| General Practice | 1,840 | 34.91 min | 35.0 min |
| Renal | 86 | 34.70 min | 35.0 min |

### Key Findings

- Neurology recorded the highest average waiting time at 36.80 minutes.
- Physiotherapy followed at 36.57 minutes.
- Renal recorded the lowest average waiting time at 34.70 minutes.
- The difference between the highest and lowest department averages was 2.10 minutes.
- The "None" referral category had the largest patient volume, with 5,400 records.

### Business Insight

Department-level average waiting times were relatively similar, with a spread of only 2.10 minutes.

Neurology and Physiotherapy could be prioritized for further workflow analysis because they recorded the highest average waits.

However, the available dataset does not include staffing levels, treatment complexity, or department capacity, so the causes of these differences cannot be established.

## 3. Overall Long Waiting Time Analysis (Query 30)

| Metric | Value |
|---|---:|
| Total Patients | 9,216 |
| Patients Waiting Over 45 Minutes | 2,750 |
| Patients Waiting 45 Minutes or Less | 6,466 |
| Long Wait Percentage | 29.84% |

### Key Findings

- 2,750 patients experienced waiting times greater than 45 minutes.
- These patients represented 29.84% of the dataset.
- The remaining 70.16% waited 45 minutes or less.

### Business Insight

Approximately three out of ten patient records exceeded the project's 45-minute analytical threshold.

This metric provides a useful baseline for evaluating the frequency of longer waiting times and monitoring changes over time.

## 4. Department-Wise Long Waiting Time Rates (Query 31)

| Department | Total Patients | Long Wait Patients | Long Wait Rate |
|---|---:|---:|---:|
| Physiotherapy | 276 | 92 | 33.33% |
| Neurology | 193 | 63 | 32.64% |
| Cardiology | 248 | 79 | 31.85% |
| Gastroenterology | 178 | 56 | 31.46% |
| Orthopedics | 995 | 299 | 30.05% |
| General Practice | 1,840 | 549 | 29.84% |
| None | 5,400 | 1,590 | 29.44% |
| Renal | 86 | 22 | 25.58% |

### Key Findings

- Physiotherapy had the highest long-wait rate at 33.33%.
- Neurology followed at 32.64%.
- Renal recorded the lowest long-wait rate at 25.58%.
- The "None" referral category had the largest absolute number of long waits, with 1,590 patients.
- General Practice recorded 549 long waits.

### Business Insight

Department rankings differ depending on whether performance is measured using average waiting time, long-wait percentage, or total long-wait volume.

Physiotherapy had the highest long-wait rate, while Neurology had the highest average wait.

The "None" referral category contributed the most long-wait records because of its substantially larger patient volume.

A balanced operational review should consider all three measures.

## 5. Waiting Time Distribution (Query 32)

| Waiting Time Category | Patients | Percentage |
|---|---:|---:|
| 0–15 minutes | 1,082 | 11.74% |
| 16–30 minutes | 2,667 | 28.94% |
| 31–45 minutes | 2,717 | 29.48% |
| 46–60 minutes | 2,750 | 29.84% |

### Key Findings

- The largest waiting-time category was 46–60 minutes, representing 29.84% of patients.
- Another 29.48% waited between 31 and 45 minutes.
- Only 11.74% waited 15 minutes or less.
- A total of 3,749 patients waited 30 minutes or less.

### Business Insight

Waiting times were distributed across multiple categories rather than concentrated exclusively in short waits.

The relatively large share of patients waiting more than 45 minutes makes long-wait frequency an important operational metric.

## 6. Waiting Time Percentile Analysis (Query 33)

| Metric | Waiting Time |
|---|---:|
| Average | 35.26 minutes |
| Median | 35 minutes |
| 75th Percentile | 48 minutes |
| 90th Percentile | 56 minutes |
| 95th Percentile | 58 minutes |
| Maximum | 60 minutes |

### Key Findings

- The median patient waiting time was 35 minutes.
- The 75th-percentile waiting time was 48 minutes.
- The 90th-percentile waiting time was 56 minutes.
- The 95th-percentile waiting time was 58 minutes.
- The maximum recorded wait was 60 minutes.

### Business Insight

Average waiting time alone does not describe the experience of patients with longer waits.

Percentile metrics provide additional visibility into the upper end of the waiting-time distribution.

For future performance monitoring, average wait, median wait, 90th-percentile wait, and long-wait percentage can be tracked together.

## 7. Hourly Patient Arrivals and Waiting Times (Query 34)

The analysis grouped patient records by arrival hour using DuckDB's TRY_STRPTIME() and HOUR() functions.

### Selected Hourly Results

| Arrival Hour | Patients | Average Wait | Long Wait Patients |
|---|---:|---:|---:|
| 12 AM | 406 | 34.25 min | 106 |
| 3 AM | 385 | 37.22 min | 134 |
| 7 AM | 415 | 35.26 min | 119 |
| 11 AM | 403 | 36.46 min | 134 |
| 1 PM | 410 | 35.56 min | 134 |
| 10 PM | 372 | 36.60 min | 120 |
| 11 PM | 436 | 36.25 min | 134 |

### Key Findings

- The highest arrival volume occurred at 11 PM, with 436 patients.
- The highest average waiting time occurred at 3 AM, with 37.22 minutes.
- The lowest hourly average wait occurred at 12 PM, with 33.88 minutes.
- The 3 AM, 11 AM, 1 PM, and 11 PM groups each recorded 134 long-wait patients.

### Business Insight

The hour with the highest patient volume was not the hour with the highest average waiting time.

This indicates that arrival volume alone does not fully explain differences in observed waiting times.

Hourly patterns can support further investigation into patient-flow processes, but staffing adequacy cannot be determined from this dataset alone.

## 8. Top Five Hours with Highest Average Waiting Times (Query 35)

| Rank | Arrival Hour | Patients | Average Wait |
|---|---|---:|---:|
| 1 | 3 AM | 385 | 37.22 min |
| 2 | 10 PM | 372 | 36.60 min |
| 3 | 11 AM | 403 | 36.46 min |
| 4 | 5 AM | 393 | 36.39 min |
| 5 | 9 AM | 388 | 36.36 min |

### Key Findings

- The 3 AM arrival hour recorded the highest average waiting time.
- Three of the five highest-wait hours occurred between 3 AM and 9 AM.
- The difference between the highest hourly average wait and the overall average was 1.96 minutes.

### Business Insight

The identified hours provide potential starting points for targeted workflow analysis.

However, hourly averages differ by relatively small amounts, and further investigation is required before recommending specific staffing changes.

## 9. Day-of-Week Waiting Time Performance (Query 36)

| Day | Patients | Average Wait | Long Wait Rate |
|---|---:|---:|---:|
| Monday | 1,314 | 35.67 min | 29.91% |
| Tuesday | 1,305 | 35.09 min | 30.73% |
| Wednesday | 1,260 | 35.19 min | 30.00% |
| Thursday | 1,332 | 34.88 min | 28.98% |
| Friday | 1,310 | 35.08 min | 29.77% |
| Saturday | 1,377 | 35.65 min | 31.23% |
| Sunday | 1,318 | 35.25 min | 28.22% |

### Key Findings

- Monday recorded the highest average waiting time at 35.67 minutes.
- Thursday recorded the lowest average waiting time at 34.88 minutes.
- Saturday had the highest long-wait percentage at 31.23%.
- Sunday had the lowest long-wait percentage at 28.22%.
- The difference between the highest and lowest weekday average waits was 0.79 minutes.

### Business Insight

Average waiting times were relatively consistent across weekdays.

Saturday's higher long-wait percentage may warrant additional analysis, but the observed differences are not sufficient to establish an operational problem.

## 10. Monthly Waiting Time Trends (Query 37)

### Notable Monthly Results

| Month | Patients | Average Wait | Long Wait Rate |
|---|---:|---:|---:|
| August 2023 | 494 | 36.39 min | 31.17% |
| November 2023 | 464 | 35.19 min | 32.76% |
| January 2024 | 513 | 36.32 min | 32.94% |
| February 2024 | 431 | 36.67 min | 32.48% |
| August 2024 | 530 | 35.11 min | 28.49% |
| October 2024 | 471 | 34.05 min | 28.87% |

### Key Findings

- February 2024 had the highest monthly average waiting time at 36.67 minutes.
- October 2024 had the lowest monthly average waiting time at 34.05 minutes.
- January 2024 recorded the highest monthly long-wait rate at 32.94%.
- August 2024 had the highest patient volume, with 530 records, but its average wait was 35.11 minutes.

### Business Insight

Monthly waiting-time patterns varied without showing a simple relationship between total patient volume and average waiting time.

These findings support monitoring waiting-time trends alongside patient arrivals and referral categories.

## 11. Patient Satisfaction by Waiting Time Category (Query 38)

Only patients with recorded satisfaction scores were included when calculating average satisfaction.

| Waiting Time | Patients | Responses | Avg Satisfaction | Response Rate |
|---|---:|---:|---:|---:|
| 0–15 min | 1,082 | 322 | 5.35 | 29.76% |
| 16–30 min | 2,667 | 687 | 4.90 | 25.76% |
| 31–45 min | 2,717 | 768 | 4.91 | 28.27% |
| 46–60 min | 2,750 | 740 | 5.02 | 26.91% |

### Key Findings

- Patients waiting 15 minutes or less reported the highest average satisfaction score at 5.35.
- Patients waiting 16–30 minutes reported the lowest average satisfaction score at 4.90.
- The longest-wait category had an average satisfaction score of 5.02.
- Response rates ranged from 25.76% to 29.76%.

### Business Insight

The relationship between waiting-time categories and satisfaction was not consistently decreasing.

Although the shortest-wait category had the highest satisfaction average, longer waiting-time categories did not show a steady decline in scores.

Satisfaction results should be interpreted cautiously because many patients did not have recorded scores.

## 12. Waiting Time and Satisfaction Correlation (Query 39)

| Metric | Value |
|---|---:|
| Satisfaction Responses | 2,517 |
| Pearson Correlation | -0.0212 |

### Key Findings

- The correlation between waiting time and satisfaction was -0.0212.
- The result indicates almost no linear association among patients with recorded satisfaction scores.
- Satisfaction scores were available for only 27.31% of patient records.

### Business Insight

The available satisfaction responses do not show a meaningful linear relationship between waiting time and satisfaction.

This does not establish that waiting time has no effect on patient experience.

Missing satisfaction data, unmeasured patient characteristics, and possible nonlinear relationships limit the conclusions that can be drawn.

## 13. Department Satisfaction and Waiting Time (Query 40)

| Department | Average Wait | Responses | Avg Satisfaction |
|---|---:|---:|---:|
| Neurology | 36.80 min | 53 | 5.28 |
| Physiotherapy | 36.57 min | 83 | 4.99 |
| Gastroenterology | 35.83 min | 54 | 5.80 |
| Cardiology | 35.35 min | 71 | 5.14 |
| None | 35.29 min | 1,440 | 4.95 |
| Orthopedics | 34.98 min | 290 | 4.86 |
| General Practice | 34.91 min | 503 | 5.06 |
| Renal | 34.70 min | 23 | 4.57 |

### Key Findings

- Gastroenterology had the highest average satisfaction score at 5.80.
- Renal had the lowest average satisfaction score at 4.57.
- Neurology had the highest average wait but a satisfaction average of 5.28.
- The "None" referral category contributed the largest number of satisfaction responses, with 1,440.
- Renal had only 23 satisfaction responses, limiting the reliability of direct comparisons.

### Business Insight

Departments with shorter average waiting times did not consistently have higher average satisfaction scores.

Patient satisfaction may be influenced by factors not represented in this dataset.

Department-level satisfaction averages should be reviewed together with response counts and response rates.

## 14. Department Waiting Time Rankings (Query 41)

| Rank | Department | Average Wait | Long Wait Rate |
|---|---|---:|---:|
| 1 | Neurology | 36.80 min | 32.64% |
| 2 | Physiotherapy | 36.57 min | 33.33% |
| 3 | Gastroenterology | 35.83 min | 31.46% |
| 4 | Cardiology | 35.35 min | 31.85% |
| 5 | None | 35.29 min | 29.44% |
| 6 | Orthopedics | 34.98 min | 30.05% |
| 7 | General Practice | 34.91 min | 29.84% |
| 8 | Renal | 34.70 min | 25.58% |

### Business Insight

Neurology and Physiotherapy rank highest for average waiting time.

These departments are reasonable candidates for closer process review, while the much larger "None" referral category deserves attention because of its total long-wait volume.

Rankings are descriptive and should not be treated as proof of department inefficiency.

## 15. Waiting Time by Admission Status (Query 42)

| Admission Status | Patients | Avg Wait | Median Wait | Long Wait Rate |
|---|---:|---:|---:|---:|
| Not Admission | 4,604 | 35.55 min | 36 min | 30.50% |
| Admission | 4,612 | 34.97 min | 35 min | 29.18% |

### Key Findings

- Non-admitted patients had an average waiting time of 35.55 minutes.
- Admitted patients had an average waiting time of 34.97 minutes.
- Non-admitted patients had a 1.32-percentage-point higher long-wait rate.
- The average waiting-time difference was 0.58 minutes.

### Business Insight

Waiting-time performance was similar for admitted and non-admitted patients.

The observed differences do not establish whether admission status influences waiting time or vice versa.

## 16. Overall Waiting Time Performance Scorecard (Query 43)

| Metric | Value |
|---|---:|
| Total Patients | 9,216 |
| Average Waiting Time | 35.26 min |
| Median Waiting Time | 35 min |
| Patients Waiting Within 30 Minutes | 3,749 |
| Percentage Within 30 Minutes | 40.68% |
| Patients Waiting Over 45 Minutes | 2,750 |
| Percentage Over 45 Minutes | 29.84% |
| 90th Percentile Waiting Time | 56 min |

### Business Insight

The hospital waiting-time scorecard provides a consolidated view of average, median, long-wait, and percentile performance.

These measures can form the basis of a recurring operational dashboard and help compare future performance against the current dataset.

## 17. Overall Day 3 Business Insights

1. **Long-Wait Frequency:** 29.84% of patient records exceeded the project's 45-minute waiting-time threshold.

2. **Department Differences:** Neurology had the highest average waiting time, while Physiotherapy had the highest long-wait percentage.

3. **High-Volume Referral Category:** The "None" referral category contributed 1,590 long-wait records, the highest absolute volume.

4. **Arrival Hour vs. Waiting Time:** The busiest arrival hour was 11 PM, but the highest average wait occurred at 3 AM.

5. **Waiting-Time Percentiles:** The 90th-percentile wait was 56 minutes, showing the importance of measuring longer waits rather than relying only on averages.

6. **Patient Satisfaction:** Waiting time and recorded satisfaction showed almost no linear correlation, but missing satisfaction data limits interpretation.

7. **Monthly Trends:** February 2024 had the highest monthly average wait, while October 2024 had the lowest.

8. **Admission Outcomes:** Admitted and non-admitted patients had similar average waiting times and long-wait percentages.

## 18. Operational Recommendations

Based on the descriptive analysis, the following areas are worth investigating:

- Review Neurology and Physiotherapy workflows to understand their comparatively higher waiting times.
- Track long-wait counts and percentages separately, particularly for high-volume referral categories.
- Compare hourly patient arrivals with staffing and service capacity data if those datasets become available.
- Monitor average, median, 90th-percentile, and long-wait metrics together.
- Improve satisfaction-score collection coverage before making broad conclusions about patient experience.
- Use monthly waiting-time trends to identify periods that may require further investigation.

These are analytical recommendations, not confirmed findings of operational deficiencies.

## 19. SQL Concepts Practiced

- Conditional aggregation using FILTER
- Common Table Expressions (CTEs)
- CASE WHEN expressions
- GROUP BY and ORDER BY
- COUNT(), AVG(), MEDIAN(), MIN(), and MAX()
- QUANTILE_CONT() for percentile analysis
- CORR() for Pearson correlation
- TRY_STRPTIME() for parsing admission times
- HOUR(), DAYNAME(), and DATE_TRUNC()
- DENSE_RANK() window function
- Percentage calculations and NULLIF()
- Department-level performance scorecards
- Handling missing satisfaction values

## 20. Day 3 Conclusion

Day 3 expanded the healthcare analytics project into hospital waiting-time and department performance analysis.

The findings show that nearly 30% of patient records exceeded 45 minutes of waiting time, while average waits remained relatively similar across departments, weekdays, and admission outcomes.

The analysis also found almost no linear relationship between waiting time and recorded patient satisfaction, although limited satisfaction-response coverage restricts interpretation.

These results provide a foundation for deeper patient experience analysis and operational performance reporting.

**Day 3 Status: Completed**


---

# Day 4: Patient Satisfaction & Experience Analytics

## 1. Overview

Day 4 focuses on understanding patient satisfaction patterns, demographic differences, department-level patient experience, monthly and hourly satisfaction trends, and potential response bias.

The analysis covers 9,216 patient records collected between April 1, 2023, and October 30, 2024.

Because satisfaction scores are missing for a large proportion of patients, all satisfaction-based findings are interpreted using the available responses rather than the entire patient population.

### Key Performance Indicators

| Metric | Value |
|---|---:|
| Total Patient Records | 9,216 |
| Satisfaction Responses | 2,517 |
| Missing Satisfaction Scores | 6,699 |
| Satisfaction Response Rate | 27.31% |
| Missing Satisfaction Rate | 72.69% |
| Average Satisfaction Score | 4.99/10 |
| Median Satisfaction Score | 5/10 |
| Minimum Satisfaction Score | 0 |
| Maximum Satisfaction Score | 10 |
| Low Satisfaction Responses (0–4) | 1,148 |
| Moderate Satisfaction Responses (5–7) | 708 |
| High Satisfaction Responses (8–10) | 661 |
| Low Satisfaction Rate | 45.61% |
| High Satisfaction Rate | 26.26% |
| Wait–Satisfaction Correlation | -0.0212 |

**Analysis Note:** Satisfaction segments are project-defined: Low (0–4), Moderate (5–7), and High (8–10). These are not official hospital satisfaction benchmarks. All segment percentages use recorded satisfaction responses as their denominator.

## 2. Overall Patient Satisfaction Scorecard (Query 44)

### Key Findings

- Out of 9,216 patient records, only 2,517 contained satisfaction scores.
- The remaining 6,699 records had missing satisfaction values.
- The overall response rate was 27.31%.
- Average satisfaction among respondents was approximately 4.99 out of 10.
- The median satisfaction score was 5.
- Recorded scores ranged from 0 to 10.

### Business Insight

The low satisfaction-response coverage is an important limitation for patient experience reporting.

Although the available responses provide a useful descriptive baseline, the average satisfaction score should not be interpreted as representing every patient.

Improving the completeness and consistency of satisfaction-score collection would strengthen future analysis.

## 3. Satisfaction Score Distribution (Query 45)

| Satisfaction Score | Responses | Percentage |
|---|---:|---:|
| 0 | 222 | 8.82% |
| 1 | 246 | 9.77% |
| 2 | 204 | 8.10% |
| 3 | 228 | 9.06% |
| 4 | 248 | 9.85% |
| 5 | 221 | 8.78% |
| 6 | 231 | 9.18% |
| 7 | 256 | 10.17% |
| 8 | 218 | 8.66% |
| 9 | 222 | 8.82% |
| 10 | 221 | 8.78% |

### Key Findings

- Score 7 was the most frequently recorded satisfaction score, with 256 responses.
- Score 4 followed with 248 responses.
- Score 2 had the fewest responses, with 204.
- Individual score frequencies were relatively evenly distributed across the 0–10 range.

### Business Insight

The satisfaction distribution does not show a strong concentration at a single score.

Using both average satisfaction and score distribution provides a more complete picture of recorded patient experience than relying on the mean alone.

## 4. Low, Moderate, and High Satisfaction Segments (Query 46)

| Satisfaction Segment | Responses | Percentage |
|---|---:|---:|
| Low (0–4) | 1,148 | 45.61% |
| Moderate (5–7) | 708 | 28.13% |
| High (8–10) | 661 | 26.26% |

### Key Findings

- Low satisfaction represented the largest segment at 45.61%.
- Moderate satisfaction accounted for 28.13%.
- High satisfaction accounted for 26.26%.
- Low satisfaction responses exceeded high satisfaction responses by 487.

### Business Insight

Almost half of recorded satisfaction responses fell into the project's low-satisfaction category.

This makes low-satisfaction frequency a useful metric for ongoing monitoring.

However, the high missing-response rate means the observed distribution may differ from the experience of patients who did not provide scores.

## 5. Patient Satisfaction by Gender (Query 47)

The known gender typo, "Femaleemale", was standardized to "Female" during SQL analysis.

| Gender | Total Patients | Responses | Average Satisfaction | Response Rate |
|---|---:|---:|---:|---:|
| Female | 4,487 | 1,206 | 4.96 | 26.88% |
| Male | 4,729 | 1,311 | 5.03 | 27.72% |

### Key Findings

- Male patients recorded an average satisfaction score of 5.03.
- Female patients recorded an average score of 4.96.
- The difference was 0.07 points.
- Response rates were similar across both groups.

### Business Insight

Gender-based average satisfaction scores were nearly identical.

The available responses do not reveal a substantial difference in reported satisfaction between male and female patients.

## 6. Patient Satisfaction by Age Group (Query 48)

| Age Group | Total Patients | Responses | Average Satisfaction | Response Rate |
|---|---:|---:|---:|---:|
| Under 18 | 1,971 | 532 | 5.01 | 26.99% |
| 18–30 | 1,572 | 428 | 5.07 | 27.23% |
| 31–45 | 1,748 | 481 | 4.94 | 27.52% |
| 46–60 | 1,727 | 471 | 5.19 | 27.27% |
| Above 60 | 2,198 | 605 | 4.80 | 27.53% |

### Key Findings

- Patients aged 46–60 had the highest average satisfaction score at 5.19.
- Patients above 60 had the lowest average satisfaction score at 4.80.
- The difference between the highest and lowest age-group averages was 0.39 points.
- Satisfaction response rates ranged from 26.99% to 27.53%.

### Business Insight

Average satisfaction varied modestly across age groups.

Patients above 60 recorded the lowest average score, making this group a possible area for further patient-experience investigation.

However, the dataset does not provide enough information to identify the causes of these differences.

## 7. Satisfaction by Admission Status (Query 49)

| Admission Status | Total Patients | Responses | Average Satisfaction | Average Wait |
|---|---:|---:|---:|---:|
| Admission | 4,612 | 1,235 | 5.08 | 34.97 min |
| Not Admission | 4,604 | 1,282 | 4.91 | 35.55 min |

### Key Findings

- Admitted patients had an average satisfaction score of 5.08.
- Non-admitted patients had an average score of 4.91.
- The satisfaction difference was 0.17 points.
- Non-admitted patients also experienced slightly longer average waiting times.
- Response rates were 26.78% for admitted patients and 27.85% for non-admitted patients.

### Business Insight

Admitted patients reported slightly higher satisfaction than non-admitted patients.

However, the differences in both satisfaction and waiting time were small.

The results do not establish whether admission outcome or waiting time caused the observed satisfaction differences.

## 8. Department-Wise Satisfaction Analysis (Query 50)

| Department | Total Patients | Responses | Average Satisfaction | Response Rate |
|---|---:|---:|---:|---:|
| Gastroenterology | 178 | 54 | 5.80 | 30.34% |
| Neurology | 193 | 53 | 5.28 | 27.46% |
| Cardiology | 248 | 71 | 5.14 | 28.63% |
| General Practice | 1,840 | 503 | 5.06 | 27.34% |
| Physiotherapy | 276 | 83 | 4.99 | 30.07% |
| None | 5,400 | 1,440 | 4.95 | 26.67% |
| Orthopedics | 995 | 290 | 4.86 | 29.15% |
| Renal | 86 | 23 | 4.57 | 26.74% |

### Key Findings

- Gastroenterology recorded the highest average satisfaction score at 5.80.
- Renal recorded the lowest average score at 4.57.
- General Practice recorded an average score of 5.06 across 503 responses.
- The "None" referral category accounted for 1,440 satisfaction responses.
- Renal had only 23 recorded responses.

### Business Insight

Department-level satisfaction averages show variation, but response counts differ substantially.

Smaller groups, particularly Renal, are more sensitive to individual scores.

For operational reporting, department satisfaction should be evaluated alongside sample size and response coverage rather than ranking departments solely by their average score.

## 9. Monthly Patient Satisfaction Trends (Query 51)

| Month | Responses | Average Satisfaction | Response Rate |
|---|---:|---:|---:|
| Apr 2023 | 145 | 5.30 | 30.27% |
| May 2023 | 128 | 5.16 | 26.67% |
| Jun 2023 | 143 | 5.18 | 28.26% |
| Jul 2023 | 115 | 4.99 | 24.78% |
| Aug 2023 | 127 | 5.06 | 25.71% |
| Sep 2023 | 123 | 4.98 | 26.23% |
| Oct 2023 | 149 | 4.74 | 30.22% |
| Nov 2023 | 140 | 5.09 | 30.17% |
| Dec 2023 | 129 | 4.68 | 26.38% |
| Jan 2024 | 147 | 4.96 | 28.65% |
| Feb 2024 | 123 | 4.72 | 28.54% |
| Mar 2024 | 119 | 5.33 | 23.52% |
| Apr 2024 | 126 | 4.63 | 26.87% |
| May 2024 | 158 | 5.15 | 30.44% |
| Jun 2024 | 141 | 4.71 | 29.07% |
| Jul 2024 | 146 | 4.79 | 29.92% |
| Aug 2024 | 113 | 5.18 | 21.32% |
| Sep 2024 | 120 | 4.91 | 25.75% |
| Oct 2024 | 125 | 5.31 | 26.54% |

### Key Findings

- March 2024 recorded the highest monthly average satisfaction at 5.33.
- April 2024 recorded the lowest monthly average satisfaction at 4.63.
- May 2024 had the highest response rate at 30.44%.
- August 2024 had the lowest response rate at 21.32%.
- Monthly satisfaction averages fluctuated without showing a consistent upward or downward trend.

### Business Insight

Monthly satisfaction patterns provide a foundation for monitoring patient experience over time.

However, changing response rates may influence monthly comparisons.

Tracking response counts and response rates alongside average scores is essential for interpreting these trends.

## 10. Patient Satisfaction by Arrival Hour (Query 52)

### Selected Hourly Results

| Arrival Hour | Responses | Average Satisfaction | Average Wait |
|---|---:|---:|---:|
| 1 AM | 94 | 4.32 | 34.06 min |
| 2 AM | 109 | 5.42 | 35.36 min |
| 3 AM | 112 | 5.33 | 37.22 min |
| 7 AM | 99 | 4.83 | 35.26 min |
| 11 AM | 106 | 5.28 | 36.46 min |
| 1 PM | 111 | 5.34 | 35.56 min |
| 10 PM | 99 | 4.42 | 36.60 min |
| 11 PM | 139 | 4.88 | 36.25 min |

### Key Findings

- The highest hourly satisfaction average occurred at 2 AM, with a score of 5.42.
- The lowest occurred at 1 AM, with a score of 4.32.
- The 11 PM arrival hour had 139 satisfaction responses, the highest hourly response count.
- Hourly satisfaction did not consistently decline as average waiting time increased.

### Business Insight

Patient satisfaction varied across arrival hours, but the available data does not establish whether the differences were caused by staffing, waiting time, or other factors.

Hourly satisfaction patterns may be useful for further operational investigation when combined with additional patient-flow data.

## 11. Low Satisfaction Rate by Department (Query 53)

| Department | Responses | Low Satisfaction Responses | Low Satisfaction Rate |
|---|---:|---:|---:|
| Renal | 23 | 13 | 56.52% |
| Orthopedics | 290 | 138 | 47.59% |
| None | 1,440 | 677 | 47.01% |
| Cardiology | 71 | 33 | 46.48% |
| Physiotherapy | 83 | 37 | 44.58% |
| General Practice | 503 | 212 | 42.15% |
| Neurology | 53 | 22 | 41.51% |
| Gastroenterology | 54 | 16 | 29.63% |

### Key Findings

- Renal had the highest low-satisfaction rate at 56.52%, based on only 23 responses.
- Orthopedics had a low-satisfaction rate of 47.59%.
- The "None" referral category recorded 677 low-satisfaction responses.
- Gastroenterology had the lowest low-satisfaction rate at 29.63%.

### Business Insight

Low-satisfaction rate and total low-satisfaction volume highlight different aspects of patient experience.

Renal had the highest percentage, but the "None" referral category contributed the largest number of low-satisfaction responses.

A practical review should consider both the rate and the number of affected respondents, together with response coverage.

## 12. Satisfaction Response Coverage by Age and Gender (Query 54)

| Age Group | Gender | Patients | Responses | Response Rate |
|---|---|---:|---:|---:|
| Under 18 | Female | 973 | 246 | 25.28% |
| Under 18 | Male | 998 | 286 | 28.66% |
| 18–30 | Female | 741 | 205 | 27.67% |
| 18–30 | Male | 831 | 223 | 26.84% |
| 31–45 | Female | 850 | 246 | 28.94% |
| 31–45 | Male | 898 | 235 | 26.17% |
| 46–60 | Female | 837 | 221 | 26.40% |
| 46–60 | Male | 890 | 250 | 28.09% |
| Above 60 | Female | 1,086 | 288 | 26.52% |
| Above 60 | Male | 1,112 | 317 | 28.51% |

### Key Findings

- Female patients aged 31–45 had the highest response rate at 28.94%.
- Female patients under 18 had the lowest response rate at 25.28%.
- Response rates across the ten demographic segments ranged from 25.28% to 28.94%.
- Missing satisfaction scores remained common across every demographic segment.

### Business Insight

Satisfaction-response coverage was relatively similar across the age-and-gender groups.

However, consistent response rates do not guarantee that respondents accurately represent nonrespondents.

Missing-response patterns should continue to be monitored across demographic and operational segments.

## 13. Waiting Time and Satisfaction Correlation by Department (Query 55)

| Department | Responses | Correlation |
|---|---:|---:|
| Cardiology | 71 | -0.0720 |
| Gastroenterology | 54 | +0.4061 |
| General Practice | 503 | +0.0004 |
| Neurology | 53 | -0.3439 |
| None | 1,440 | -0.0159 |
| Orthopedics | 290 | -0.0637 |
| Physiotherapy | 83 | -0.0067 |
| Renal | 23 | -0.0551 |

### Key Findings

- Gastroenterology showed a positive correlation of +0.4061.
- Neurology showed a negative correlation of -0.3439.
- General Practice showed almost no linear correlation at +0.0004.
- The "None" referral category also showed almost no linear correlation at -0.0159.
- Several departments had relatively small satisfaction-response samples.

### Business Insight

The relationship between waiting time and satisfaction differed across referral departments.

However, smaller response samples and missing satisfaction values limit the reliability and generalizability of department-level correlations.

These findings should be treated as exploratory rather than causal.

## 14. Respondents vs. Nonrespondents Waiting-Time Comparison (Query 56)

| Response Status | Patients | Average Wait | Median Wait | Long Wait Rate |
|---|---:|---:|---:|---:|
| No Response | 6,699 | 35.23 min | 35 min | 30.00% |
| Responded | 2,517 | 35.35 min | 36 min | 29.40% |

### Key Findings

- Respondents had an average waiting time of 35.35 minutes.
- Nonrespondents had an average waiting time of 35.23 minutes.
- The difference was only 0.12 minutes.
- Long-wait percentages were also similar between the two groups.

### Business Insight

Waiting-time distributions were broadly similar between satisfaction respondents and nonrespondents.

This reduces concern about large observed waiting-time differences between these groups, but it does not eliminate possible response bias involving other factors.

## 15. Weekday vs. Weekend Satisfaction (Query 57)

| Day Type | Patients | Responses | Avg Satisfaction | Response Rate | Avg Wait |
|---|---:|---:|---:|---:|---:|
| Weekday | 6,521 | 1,799 | 4.96 | 27.59% | 35.18 min |
| Weekend | 2,695 | 718 | 5.08 | 26.64% | 35.45 min |

### Key Findings

- Weekend respondents recorded a slightly higher average satisfaction score at 5.08.
- Weekday respondents recorded an average score of 4.96.
- Weekend waiting times were slightly longer, averaging 35.45 minutes.
- Weekday response coverage was slightly higher.

### Business Insight

Weekend satisfaction was marginally higher despite a slightly longer average waiting time.

The differences were small and do not establish a meaningful relationship between day type, waiting time, and satisfaction.

## 16. Final Patient Experience Scorecard (Query 58)

| Metric | Value |
|---|---:|
| Total Patients | 9,216 |
| Satisfaction Responses | 2,517 |
| Response Rate | 27.31% |
| Average Satisfaction | 4.99/10 |
| Low Satisfaction Responses | 1,148 |
| High Satisfaction Responses | 661 |
| Low Satisfaction Rate | 45.61% |
| High Satisfaction Rate | 26.26% |
| Average Waiting Time | 35.26 minutes |
| Wait–Satisfaction Correlation | -0.0212 |

### Business Insight

The final scorecard combines satisfaction, response coverage, waiting time, and correlation measures.

These metrics can be used as a baseline for a patient-experience dashboard, provided that missing-response limitations remain visible.

## 17. Overall Day 4 Business Insights

1. **Limited Response Coverage:** Only 27.31% of patients had recorded satisfaction scores, making data completeness a central consideration.

2. **Low Satisfaction Segment:** 45.61% of recorded responses fell into the project's low-satisfaction category.

3. **Small Gender Differences:** Male and female respondents reported nearly identical average satisfaction scores.

4. **Age-Based Variation:** Patients aged 46–60 had the highest average satisfaction, while patients above 60 had the lowest.

5. **Department Differences:** Gastroenterology recorded the highest satisfaction average, while Renal recorded the lowest, although smaller response samples limit interpretation.

6. **Monthly Variation:** Satisfaction scores fluctuated across months without a consistent directional trend.

7. **Weak Overall Correlation:** Waiting time and satisfaction had almost no linear association among recorded responses.

8. **Response Bias Considerations:** Respondents and nonrespondents had similar waiting-time measures, but other potential sources of response bias remain untested.

## 18. Operational Recommendations

Based on the descriptive findings:

- Improve satisfaction-score collection and reporting coverage.
- Track low-satisfaction percentages alongside average scores.
- Review patient-experience patterns among older patients and high-volume referral categories.
- Use department response counts and response rates when comparing satisfaction.
- Monitor monthly satisfaction trends alongside changes in response coverage.
- Investigate department-level differences using additional information such as treatment type, service quality, and patient feedback when available.
- Avoid making staffing or clinical decisions solely from satisfaction correlations.

These recommendations identify areas for further investigation rather than confirmed operational deficiencies.

## 19. SQL Concepts Practiced

- Conditional aggregation using FILTER
- Common Table Expressions (CTEs)
- CASE WHEN expressions
- COUNT(), AVG(), MEDIAN(), MIN(), and MAX()
- CORR() for Pearson correlation
- DATE_TRUNC() for monthly trends
- TRY_STRPTIME() and HOUR() for arrival-time analysis
- DAYOFWEEK() for weekday/weekend segmentation
- GROUP BY and ORDER BY
- Percentage calculations using NULLIF()
- Missing-data and response-coverage analysis
- Demographic and department-level segmentation

## 20. Day 4 Conclusion

Day 4 expanded the healthcare analytics project into patient satisfaction and experience analysis.

The results show that low satisfaction scores represented the largest project-defined response segment, while satisfaction differences across demographics, departments, and arrival times were generally modest or limited by small samples.

The analysis also confirmed almost no overall linear correlation between waiting time and recorded satisfaction.

Most importantly, the 72.69% missing satisfaction rate highlights the need for better response coverage before drawing broad conclusions about the full patient population.

The findings establish a foundation for a final hospital operations performance dashboard and executive-level recommendations.

**Day 4 Status: Completed**

---

# Day 5: Hospital Operations KPI Dashboard & Executive Analytics

## 1. Overview

Day 5 consolidates the previous four days of healthcare analytics into a comprehensive hospital operations performance assessment.

The objective is to evaluate patient volume, admissions, waiting times, department performance, patient satisfaction, operational trends, and data quality using advanced SQL techniques.

**Dataset:** Healthcare Patient Flow & Hospital Operations Analytics  
**Database:** DuckDB  
**Analysis Period:** April 1, 2023 – October 30, 2024  
**Total Records:** 9,216  
**SQL Queries:** 59–73

### Executive KPI Summary

| KPI | Result |
|---|---:|
| Total Patient Records | 9,216 |
| Unique Patient IDs | 9,216 |
| Admitted Patients | 4,612 |
| Admission Rate | 50.04% |
| Average Waiting Time | 35.26 minutes |
| Median Waiting Time | 35 minutes |
| 90th Percentile Waiting Time | 56 minutes |
| Patients Waiting Over 45 Minutes | 2,750 |
| Long-Wait Rate | 29.84% |
| Satisfaction Responses | 2,517 |
| Satisfaction Response Rate | 27.31% |
| Average Satisfaction Score | 4.99/10 |

**Executive Insight:** Approximately half of the recorded patients were admitted, nearly 30% experienced waits exceeding 45 minutes, and satisfaction scores were available for only 27.31% of records. These metrics establish a baseline for monitoring hospital operations and patient experience.

The 45-minute threshold is an analytical definition used in this project, not a verified hospital service-level agreement.

## 2. Executive Hospital Operations KPI Scorecard (Query 59)

### Key Findings

- All 9,216 patient records have distinct patient IDs.
- A total of 4,612 patients were classified as admitted.
- The admission rate was approximately 50.04%.
- Average waiting time was 35.26 minutes, with a median of 35 minutes.
- The 90th percentile waiting time was 56 minutes.
- Approximately 29.84% of patients waited longer than 45 minutes.
- Satisfaction scores were recorded for 2,517 patients, with an average of 4.99/10.

### Business Insight

The consolidated scorecard brings patient-flow efficiency, admission outcomes, and patient-experience measures into a single reporting framework.

Waiting-time performance and satisfaction-response coverage are particularly useful areas for further operational investigation.

## 3. Monthly Hospital Operations Dashboard (Query 60)

### Selected Monthly Performance

| Month | Patients | Admitted | Avg Wait | Avg Satisfaction |
|---|---:|---:|---:|---:|
| Apr 2023 | 479 | 237 | 34.90 min | 5.30 |
| Aug 2023 | 494 | 234 | 36.39 min | 5.06 |
| Jan 2024 | 513 | 269 | 36.32 min | 4.96 |
| Feb 2024 | 431 | 224 | 36.67 min | 4.72 |
| May 2024 | 519 | 266 | 35.81 min | 5.15 |
| Aug 2024 | 530 | 242 | 35.11 min | 5.18 |
| Oct 2024 | 471 | 247 | 34.05 min | 5.31 |

### Key Findings

- August 2024 recorded the highest monthly patient volume at 530.
- February 2024 recorded the lowest monthly volume at 431.
- February 2024 had the highest monthly average waiting time at 36.67 minutes.
- October 2024 had the lowest monthly average waiting time at 34.05 minutes.
- Monthly satisfaction averages fluctuated without a consistent directional trend.

### Business Insight

Monthly patient volume and average waiting time did not move consistently together.

For example, August 2024 had the highest recorded monthly volume but an average waiting time close to the overall hospital average.

Monthly volume should therefore be considered alongside patient arrival patterns and other operational factors rather than treated as the sole explanation for waiting times.

**Limitation:** Monthly patient totals are not adjusted for differences in the number of calendar days.

## 4. Month-over-Month Patient Volume Growth (Query 61)

### Significant Monthly Changes

| Month | Patients | Change | MoM Growth |
|---|---:|---:|---:|
| Feb 2024 | 431 | -82 | -15.98% |
| Mar 2024 | 506 | +75 | +17.40% |
| May 2024 | 519 | +50 | +10.66% |
| Aug 2024 | 530 | +42 | +8.61% |
| Sep 2024 | 466 | -64 | -12.08% |
| Oct 2024 | 471 | +5 | +1.07% |

### Key Findings

- March 2024 recorded the largest month-over-month increase at 17.40%.
- February 2024 recorded the largest decline at 15.98%.
- September 2024 experienced a 12.08% decrease following the August volume peak.
- October 2024 showed a modest recovery of 1.07%.

### Business Insight

Patient volumes fluctuated across the analysis period.

Month-over-month reporting can help identify periods requiring closer review, but raw monthly growth percentages may also reflect calendar differences, seasonal patterns, or other factors not captured in the dataset.

## 5. Monthly Admission Rate Changes (Query 62)

### Key Findings

- The highest monthly admission rate was 54.51% in July 2024.
- The lowest monthly admission rate was 45.66% in August 2024.
- August 2024 experienced the largest month-over-month admission-rate decrease, falling by 8.85 percentage points.
- July 2024 recorded the largest increase, rising by 6.06 percentage points.
- The overall admission rate remained close to 50%.

### Business Insight

Admission rates varied across months even when overall patient volumes were relatively stable.

Tracking these changes may help identify shifts in the proportion of visits resulting in admission.

However, the dataset does not include clinical severity, diagnosis, or admission criteria, so the reasons for these changes cannot be established.

## 6. Department Operational Performance Scorecard (Query 63)

| Referral Category | Patients | Volume Share | Avg Wait | Long-Wait Rate | Avg Satisfaction |
|---|---:|---:|---:|---:|---:|
| None | 5,400 | 58.59% | 35.29 | 29.44% | 4.95 |
| General Practice | 1,840 | 19.97% | 34.91 | 29.84% | 5.06 |
| Orthopedics | 995 | 10.80% | 34.98 | 30.05% | 4.86 |
| Physiotherapy | 276 | 2.99% | 36.57 | 33.33% | 4.99 |
| Cardiology | 248 | 2.69% | 35.35 | 31.85% | 5.14 |
| Neurology | 193 | 2.09% | 36.80 | 32.64% | 5.28 |
| Gastroenterology | 178 | 1.93% | 35.83 | 31.46% | 5.80 |
| Renal | 86 | 0.93% | 34.70 | 25.58% | 4.57 |

### Key Findings

- The "None" referral category represented 58.59% of all records.
- General Practice accounted for 19.97% of patient records.
- Neurology had the highest average waiting time at 36.80 minutes.
- Physiotherapy had the highest long-wait rate at 33.33%.
- Gastroenterology recorded the highest average satisfaction among respondents at 5.80.
- Renal recorded the lowest average satisfaction at 4.57, based on only 23 responses.

### Business Insight

Department referral categories vary in both volume and waiting-time performance.

High-volume categories have greater influence on overall hospital metrics, while smaller categories may show higher waiting-time percentages.

Department comparisons should consider patient counts, response coverage, and differences in service requirements.

**Data Interpretation:** "None" means no department referral was recorded. It should not be treated as a clinical department.

## 7. Department Contribution to Long Waiting Times (Query 64)

| Referral Category | Long-Wait Patients | Share of All Long Waits |
|---|---:|---:|
| None | 1,590 | 57.82% |
| General Practice | 549 | 19.96% |
| Orthopedics | 299 | 10.87% |
| Physiotherapy | 92 | 3.35% |
| Cardiology | 79 | 2.87% |
| Neurology | 63 | 2.29% |
| Gastroenterology | 56 | 2.04% |
| Renal | 22 | 0.80% |

### Key Findings

- The "None" category contributed 1,590 long-wait records.
- General Practice contributed 549 long-wait records.
- Together, these categories accounted for 77.78% of all long waits.
- Physiotherapy had the highest long-wait rate, but only 92 long-wait records.

### Business Insight

There is an important distinction between **long-wait volume** and **long-wait rate**.

High-volume referral categories account for more long-wait records, while smaller categories can have higher percentages.

An effective operational review should consider both measures when identifying areas for investigation.

## 8. Patient Experience Risk Segmentation (Query 65)

| Experience Segment | Patients | Percentage | Avg Wait |
|---|---:|---:|---:|
| Other Patient Records | 5,649 | 61.30% | 27.58 min |
| Long Wait + Missing Feedback | 2,010 | 21.81% | 53.02 min |
| Shorter Wait + Low Satisfaction | 817 | 8.87% | 28.31 min |
| Long Wait + Other Feedback | 409 | 4.44% | 53.18 min |
| Long Wait + Low Satisfaction | 331 | 3.59% | 53.56 min |

### Key Findings

- A total of 2,010 patients experienced long waits without providing satisfaction feedback.
- This group represented 21.81% of all patient records.
- Approximately 73.09% of long-wait patients had missing satisfaction scores.
- Another 331 patients experienced long waits and recorded low satisfaction scores.
- A total of 817 patients recorded low satisfaction despite waiting 45 minutes or less.

### Business Insight

The largest clearly identified patient-experience information gap involved patients who waited longer than 45 minutes and had no recorded satisfaction score.

Low satisfaction also occurred among patients with shorter waits, suggesting that waiting time alone does not explain every negative patient experience.

Additional service-quality and patient-feedback data would be needed to investigate potential causes.

**Methodology Note:** These segments are mutually exclusive, based on the CASE expression used in Query 65. They are analytical categories rather than clinical risk classifications.

## 9. Monthly Long-Wait Trend Analysis (Query 66)

### Selected Results

| Month | Long-Wait Patients | Long-Wait Rate |
|---|---:|---:|
| Jul 2023 | 126 | 27.16% |
| Nov 2023 | 152 | 32.76% |
| Jan 2024 | 169 | 32.94% |
| Feb 2024 | 140 | 32.48% |
| May 2024 | 149 | 28.71% |
| Aug 2024 | 151 | 28.49% |
| Oct 2024 | 136 | 28.87% |

### Key Findings

- January 2024 had the highest long-wait rate at 32.94%.
- July 2023 had the lowest rate at 27.16%.
- November 2023 recorded a month-over-month increase of 4.16 percentage points.
- August 2023 recorded an increase of 4.01 percentage points.
- October 2024 ended with a long-wait rate of 28.87%.

### Business Insight

Long-wait rates fluctuated throughout the analysis period, generally remaining near the overall rate of 29.84%.

The monthly variations provide useful signals for further investigation but do not establish consistent improvement or deterioration.

## 10. Rolling Three-Month Patient Volume and Waiting Time (Query 67)

### Selected Rolling Metrics

| Month | Rolling 3-Month Patients | Rolling Avg Wait |
|---|---:|---:|
| Jun 2023 | 1,465 | 34.98 min |
| Sep 2023 | 1,427 | 35.15 min |
| Dec 2023 | 1,446 | 34.96 min |
| Mar 2024 | 1,450 | 36.27 min |
| Jun 2024 | 1,473 | 35.47 min |
| Aug 2024 | 1,503 | 35.27 min |
| Oct 2024 | 1,467 | 34.76 min |

### Key Findings

- March 2024 recorded the highest three-month rolling average wait at 36.27 minutes.
- August 2024 recorded the highest three-month rolling patient total at 1,503.
- By October 2024, the rolling average wait had decreased to 34.76 minutes.
- Rolling averages were less volatile than individual monthly values.

### Business Insight

Rolling metrics help identify broader operational patterns by reducing the effect of individual monthly fluctuations.

The decline from 36.27 minutes in March 2024 to 34.76 minutes in October 2024 suggests an improvement in the rolling waiting-time measure over that interval.

This observation does not establish the cause of the change.

**Methodology Note:** The first two rolling-window rows use fewer than three months of available data.

## 11. Peak Arrival Hours and Operational Performance (Query 68)

### Selected Hourly Results

| Arrival Hour | Patients | Admitted | Long-Wait Rate | Avg Satisfaction |
|---|---:|---:|---:|---:|
| 11 PM | 436 | 226 | 30.73% | 4.88 |
| 7 AM | 415 | 207 | 28.67% | 4.83 |
| 1 PM | 410 | 220 | 32.68% | 5.34 |
| 12 AM | 406 | 197 | 26.11% | 4.68 |
| 11 AM | 403 | 211 | 33.25% | 5.28 |
| 3 AM | 385 | 177 | 34.81% | 5.33 |

### Key Findings

- The 11 PM hour had the highest patient volume at 436 records.
- The 3 AM hour had the highest long-wait rate at 34.81%.
- The 11 AM hour recorded a long-wait rate of 33.25%.
- The 1 PM hour recorded a long-wait rate of 32.68%.
- The busiest arrival hour was not the hour with the highest long-wait rate.

### Business Insight

Arrival volume and waiting-time performance differed across hours.

These patterns can help identify time periods for additional operational review, but the dataset does not include staffing levels, available treatment resources, or patient acuity.

Therefore, staffing requirements cannot be calculated directly from these results.

## 12. Daily Patient Volume and Waiting-Time Correlation (Query 69)

| Metric | Result |
|---|---:|
| Total Days | 579 |
| Average Daily Patients | 15.92 |
| Minimum Daily Patients | 7 |
| Maximum Daily Patients | 30 |
| Daily Volume–Wait Correlation | +0.0429 |

### Key Findings

- The dataset contained patient records across 579 dates.
- Average daily patient volume was approximately 15.92.
- Daily patient counts ranged from 7 to 30.
- The correlation between daily patient volume and daily average waiting time was +0.0429.

### Business Insight

The correlation indicates almost no linear relationship between daily patient volume and daily average waiting time in this dataset.

This does not mean patient volume can never affect waiting time.

Other operational factors and relationships not represented in the available data may influence patient waiting times.

## 13. Department Waiting Time vs. Hospital Average (Query 70)

**Hospital Average Waiting Time: 35.26 minutes**

| Referral Category | Avg Wait | Difference from Hospital |
|---|---:|---:|
| Neurology | 36.80 | +1.54 min |
| Physiotherapy | 36.57 | +1.31 min |
| Gastroenterology | 35.83 | +0.57 min |
| Cardiology | 35.35 | +0.09 min |
| None | 35.29 | +0.03 min |
| Orthopedics | 34.98 | -0.28 min |
| General Practice | 34.91 | -0.35 min |
| Renal | 34.70 | -0.56 min |

### Key Findings

- Neurology exceeded the hospital average by 1.54 minutes.
- Physiotherapy exceeded the hospital average by 1.31 minutes.
- Renal was 0.56 minutes below the hospital average.
- The difference between the highest and lowest department averages was 2.10 minutes.

### Business Insight

Although Neurology and Physiotherapy had the highest average waits, differences between referral categories were relatively small.

The comparison helps identify categories for further review, but being above the hospital average does not automatically indicate unacceptable performance.

## 14. Monthly Satisfaction and Waiting-Time Comparison (Query 71)

### Key Findings

- February 2024 had the highest monthly average waiting time at 36.67 minutes, with average satisfaction of 4.72.
- March 2024 recorded average waiting time of 35.88 minutes and average satisfaction of 5.33.
- April 2024 recorded the lowest monthly average satisfaction at 4.63.
- August 2024 had the lowest satisfaction-response rate at 21.32%.
- October 2024 recorded average waiting time of 34.05 minutes and satisfaction of 5.31.

### Business Insight

Monthly satisfaction scores did not consistently move in the opposite direction of waiting times.

This is consistent with the earlier overall wait–satisfaction correlation of -0.0212, which showed almost no linear relationship among patients with recorded satisfaction scores.

Satisfaction comparisons remain limited by missing responses.

## 15. Executive Operational Priority Matrix (Query 72)

| Referral Category | Operational Priority |
|---|---|
| None | High Volume – Monitor |
| General Practice | High Volume – Monitor |
| Orthopedics | Higher Long-Wait Rate – Review |
| Physiotherapy | Higher Long-Wait Rate – Review |
| Cardiology | Higher Long-Wait Rate – Review |
| Neurology | Higher Long-Wait Rate – Review |
| Gastroenterology | Higher Long-Wait Rate – Review |
| Renal | Routine Monitoring |

### Key Findings

- The "None" and General Practice categories met the project's high-volume threshold.
- Physiotherapy, Neurology, Cardiology, Gastroenterology, and Orthopedics exceeded the project's 30% long-wait-rate threshold.
- Renal was classified under routine monitoring.
- No referral category met both the 1,000-patient volume threshold and the 30% long-wait-rate threshold.

### Business Insight

The priority matrix provides a repeatable method for organizing operational review.

However, its thresholds are project-defined and should not be treated as official hospital service standards.

For practical use, the thresholds should be validated against hospital goals, patient needs, and operational capacity.

## 16. Final Data Quality Validation (Query 73)

| Validation Metric | Result |
|---|---:|
| Total Records | 9,216 |
| Unique Patient IDs | 9,216 |
| Repeated Patient ID Records | 0 |
| Invalid Satisfaction Scores | 0 |
| First Visit Date | April 1, 2023 |
| Last Visit Date | October 30, 2024 |
| Missing Satisfaction Scores | 6,699 |

### Key Findings

- All 9,216 patient IDs were unique.
- No repeated patient ID records were identified.
- No satisfaction scores outside the permitted 0–10 range were identified.
- Satisfaction scores were missing for 72.69% of records.
- The dataset covered April 2023 through October 2024.

### Data Quality Limitations

The exported Query 73 output truncated several fields, including some missing-value and invalid-value checks. Those specific results require expanded output before being documented as fully verified.

Additional interpretation considerations:

- The raw gender data contains the category "Femaleemale", which was normalized to "Female" during analysis.
- The "None" department referral value represents an unrecorded referral category.
- Missing satisfaction scores limit conclusions about overall patient experience.
- The dataset does not contain staffing, discharge, bed capacity, treatment cost, insurance, or clinical severity information.

## 17. Final Executive Business Insights

### Insight 1: Long Waiting Times Affect a Substantial Share of Records

A total of 2,750 patients, representing 29.84% of the dataset, experienced waiting times exceeding 45 minutes.

This provides a useful baseline for future waiting-time monitoring.

### Insight 2: High-Volume Categories Dominate Absolute Long-Wait Counts

The "None" referral category and General Practice accounted for 77.78% of long-wait records.

Their contribution primarily reflects their large share of total patient volume.

### Insight 3: Smaller Categories Can Have Higher Long-Wait Rates

Physiotherapy had the highest long-wait percentage at 33.33%, followed by Neurology at 32.64%.

These categories may warrant further investigation, even though their absolute patient counts were smaller.

### Insight 4: Satisfaction Data Completeness Is a Major Limitation

Only 27.31% of patients had recorded satisfaction scores.

This limits the extent to which satisfaction results can be generalized to the entire patient population.

### Insight 5: Waiting Time Alone Does Not Explain Satisfaction

The overall waiting-time and satisfaction correlation was -0.0212 among respondents.

The data does not support a strong linear association between these measures.

### Insight 6: Monthly Patient Volume Fluctuates

Patient volume ranged from 431 to 530 records per month.

These fluctuations provide useful operational context but do not establish a consistent long-term growth trend.

### Insight 7: Daily Patient Volume Has Almost No Linear Association with Average Waiting Time

The daily volume–wait correlation was +0.0429.

Daily patient counts alone were not strongly associated with average waiting times in this dataset.

### Insight 8: Rolling Waiting-Time Performance Improved Toward the End of the Period

The three-month rolling average wait decreased from 36.27 minutes in March 2024 to 34.76 minutes in October 2024.

This suggests an improvement over that specific interval, although the causes remain unknown.

## 18. Final Operational Recommendations

Based on the five-day analysis, the following recommendations are proposed for further evaluation.

1. **Monitor Long-Wait Rates:** Track the proportion of patients waiting over 45 minutes, together with average and percentile waiting times.

2. **Review High-Volume Referral Categories:** Investigate the patient-flow processes associated with General Practice and the large "None" referral category.

3. **Investigate Higher Long-Wait Rates:** Examine Physiotherapy, Neurology, and other categories with elevated long-wait percentages.

4. **Improve Satisfaction Data Collection:** Increase response coverage and track missing satisfaction scores by department, month, and arrival hour.

5. **Monitor Peak Arrival Hours:** Review patient-flow patterns during high-volume and high-wait periods, particularly late evening and early morning.

6. **Use Rolling Performance Metrics:** Track three-month rolling patient volumes and waiting times to distinguish short-term fluctuations from broader patterns.

7. **Maintain Data Quality Checks:** Validate patient identifiers, admission timestamps, demographic categories, and satisfaction-score completeness.

8. **Expand Future Data Collection:** Incorporate staffing, treatment duration, clinical severity, discharge, and capacity data when available to support deeper operational analysis.

These are exploratory recommendations based on descriptive analytics, not confirmed findings of clinical or operational deficiencies.

## 19. Advanced SQL Concepts Applied

Day 5 demonstrated the following SQL techniques:

- Common Table Expressions (CTEs)
- Conditional aggregation using FILTER
- Window functions
- LAG() for month-over-month comparisons
- SUM() OVER() for contribution analysis
- Rolling window calculations
- Weighted rolling averages
- CORR() for Pearson correlation
- QUANTILE_CONT() for percentile analysis
- CASE WHEN for operational segmentation
- DATE_TRUNC() for monthly aggregation
- TRY_STRPTIME() and HOUR() for arrival-time analysis
- NULLIF() for safe percentage calculations
- CROSS JOIN for hospital-wide baseline comparisons
- Data validation and missing-value analysis

## 20. Final Project Conclusion

The Healthcare Patient Flow & Hospital Operations Analytics project analyzed 9,216 patient records using DuckDB and SQL.

Across five days and 73 analytical queries, the project examined:

- Patient demographics and admission patterns
- Daily, weekly, and monthly patient-flow trends
- Department referral distribution
- Waiting-time performance and percentiles
- Long-wait patient segments
- Patient satisfaction and response coverage
- Operational correlations
- Month-over-month growth
- Rolling three-month performance
- Executive KPI scorecards
- Data quality and reporting limitations

The analysis identified meaningful opportunities for further investigation in long-wait monitoring, department-level patient flow, and satisfaction-data completeness.

It also demonstrated that patient volume and waiting time had little linear association at the daily level, while waiting time and satisfaction showed almost no overall linear association among respondents.

**Final Outcome:** A reproducible SQL analytics portfolio project combining 73 queries, operational KPIs, trend analysis, patient-experience segmentation, and evidence-based executive recommendations.

**Day 5 Status: Completed**
