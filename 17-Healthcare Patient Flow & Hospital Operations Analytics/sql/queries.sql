-- =====================================================
-- Project 17: Healthcare Patient & Hospital Operations
-- Day 1: Data Exploration & Quality Checks
-- Database: DuckDB
-- =====================================================


-- Query 1: Total Patient Records
SELECT
    COUNT(*) AS total_patient_records
FROM healthcare_raw;


-- Query 2: Unique Patients
SELECT
    COUNT(DISTINCT "Patient Id") AS unique_patients
FROM healthcare_raw;


-- Query 3: Patient Demographics and Operational KPIs
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT "Patient Id") AS unique_patients,
    ROUND(AVG("Patient Age"), 2) AS avg_patient_age,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score
FROM healthcare_raw;


-- Query 4: Gender Distribution
SELECT
    "Patient Gender" AS gender,
    COUNT(*) AS total_patients,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM healthcare_raw
GROUP BY "Patient Gender"
ORDER BY total_patients DESC;


-- Query 5: Patient Age Statistics
SELECT
    MIN("Patient Age") AS minimum_age,
    MAX("Patient Age") AS maximum_age,
    ROUND(AVG("Patient Age"), 2) AS average_age,
    ROUND(MEDIAN("Patient Age"), 2) AS median_age
FROM healthcare_raw;


-- Query 6: Age Group Distribution
WITH age_groups AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" BETWEEN 18 AND 30 THEN '18-30'
            WHEN "Patient Age" BETWEEN 31 AND 45 THEN '31-45'
            WHEN "Patient Age" BETWEEN 46 AND 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group
    FROM healthcare_raw
    WHERE "Patient Age" IS NOT NULL
)
SELECT
    age_group,
    COUNT(*) AS total_patients,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM age_groups
GROUP BY age_group
ORDER BY
    CASE age_group
        WHEN 'Under 18' THEN 1
        WHEN '18-30' THEN 2
        WHEN '31-45' THEN 3
        WHEN '46-60' THEN 4
        ELSE 5
    END;


-- Query 7: Department Referral Distribution
SELECT
    COALESCE(
        NULLIF(TRIM("Department Referral"), ''),
        'Not Specified'
    ) AS department,
    COUNT(*) AS total_patients
FROM healthcare_raw
GROUP BY 1
ORDER BY total_patients DESC;


-- Query 8: Admission Flag Distribution
SELECT
    "Patient Admission Flag" AS admission_flag,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM healthcare_raw
GROUP BY "Patient Admission Flag"
ORDER BY total_records DESC;


-- Query 9: Average Wait Time by Gender
SELECT
    "Patient Gender" AS gender,
    COUNT(*) AS total_records,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time,
    MIN("Patient Waittime") AS min_wait_time,
    MAX("Patient Waittime") AS max_wait_time
FROM healthcare_raw
GROUP BY "Patient Gender"
ORDER BY avg_wait_time DESC;


-- Query 10: Patient Satisfaction Overview
SELECT
    COUNT("Patient Satisfaction Score")
        AS patients_with_satisfaction_score,
    COUNT(*) - COUNT("Patient Satisfaction Score")
        AS patients_without_satisfaction_score,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    MIN("Patient Satisfaction Score")
        AS min_satisfaction_score,
    MAX("Patient Satisfaction Score")
        AS max_satisfaction_score
FROM healthcare_raw;


-- Query 11: Missing Values Analysis
SELECT
    COUNT(*) AS total_records,

    COUNT(*) FILTER (
        WHERE "Patient Id" IS NULL
           OR TRIM("Patient Id") = ''
    ) AS missing_patient_ids,

    COUNT(*) FILTER (
        WHERE "Patient Age" IS NULL
    ) AS missing_ages,

    COUNT(*) FILTER (
        WHERE "Patient Gender" IS NULL
           OR TRIM("Patient Gender") = ''
    ) AS missing_genders,

    COUNT(*) FILTER (
        WHERE "Department Referral" IS NULL
           OR TRIM("Department Referral") = ''
    ) AS missing_referrals,

    COUNT(*) FILTER (
        WHERE "Patient Satisfaction Score" IS NULL
    ) AS missing_satisfaction_scores,

    COUNT(*) FILTER (
        WHERE "Patient Waittime" IS NULL
    ) AS missing_wait_times

FROM healthcare_raw;


-- Query 12: Exact Duplicate Records
SELECT
    COALESCE(SUM(record_count - 1), 0)
        AS duplicate_records
FROM (
    SELECT
        COUNT(*) AS record_count
    FROM healthcare_raw
    GROUP BY ALL
    HAVING COUNT(*) > 1
) AS duplicates;


-- Query 13: Invalid Age and Wait Time Records
SELECT
    COUNT(*) FILTER (
        WHERE "Patient Age" < 0
           OR "Patient Age" > 120
    ) AS invalid_age_records,

    COUNT(*) FILTER (
        WHERE "Patient Waittime" < 0
    ) AS invalid_wait_time_records

FROM healthcare_raw;


-- Query 14: Admission Date Range
SELECT
    MIN(TRY_CAST("Patient Admission Date" AS DATE))
        AS earliest_admission_date,

    MAX(TRY_CAST("Patient Admission Date" AS DATE))
        AS latest_admission_date,

    COUNT(*) FILTER (
        WHERE "Patient Admission Date" IS NOT NULL
          AND TRY_CAST("Patient Admission Date" AS DATE) IS NULL
    ) AS invalid_admission_dates

FROM healthcare_raw;


-- Query 15: Monthly Patient Volume
SELECT
    DATE_TRUNC(
        'month',
        TRY_CAST("Patient Admission Date" AS DATE)
    ) AS admission_month,

    COUNT(*) AS total_patient_records

FROM healthcare_raw
WHERE TRY_CAST("Patient Admission Date" AS DATE) IS NOT NULL
GROUP BY 1
ORDER BY admission_month;