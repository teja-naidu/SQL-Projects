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
    COALESCE(SUM(record_count - 1), 0) AS duplicate_records
FROM (
    SELECT
        "Patient Id",
        "Patient Admission Date",
        "Patient Admission Time",
        "Merged",
        "Patient Gender",
        "Patient Age",
        "Patient Race",
        "Department Referral",
        "Patient Admission Flag",
        "Patient Satisfaction Score",
        "Patient Waittime",
        COUNT(*) AS record_count
    FROM healthcare_raw
    GROUP BY ALL
    HAVING COUNT(*) > 1
) AS duplicate_groups;


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


-- ============================================================
-- SQL PROJECT 17
-- Healthcare Patient Flow & Hospital Operations Analytics
-- DAY 2: Patient Demographics & Admission Pattern Analysis
-- Database: DuckDB
-- ============================================================


-- Query 16: Admission Rate by Patient Age Group

WITH age_groups AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" BETWEEN 18 AND 30 THEN '18-30'
            WHEN "Patient Age" BETWEEN 31 AND 45 THEN '31-45'
            WHEN "Patient Age" BETWEEN 46 AND 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group,
        "Patient Admission Flag" AS admission_status
    FROM healthcare_raw
    WHERE "Patient Age" IS NOT NULL
)
SELECT
    age_group,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE admission_status = 'Admission'
    ) AS admitted_patients,
    COUNT(*) FILTER (
        WHERE admission_status = 'Not Admission'
    ) AS non_admitted_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE admission_status = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
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


-- Query 17: Admission Rate by Gender
-- Standardize the known gender typo in the query.

SELECT
    CASE
        WHEN "Patient Gender" = 'Femaleemale'
            THEN 'Female'
        ELSE "Patient Gender"
    END AS gender,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Admission Flag" = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY admission_rate_percentage DESC;


-- Query 18: Department-Wise Admission Analysis

SELECT
    COALESCE(
        NULLIF(TRIM("Department Referral"), ''),
        'Not Specified'
    ) AS department,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Not Admission'
    ) AS non_admitted_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Admission Flag" = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY admitted_patients DESC;


-- Query 19: Daily Patient Arrival Trends

SELECT
    "Patient Admission Date" AS visit_date,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY visit_date;


-- Query 20: Patient Volume by Day of Week

SELECT
    DAYNAME("Patient Admission Date") AS day_of_week,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY
    CASE day_of_week
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        ELSE 7
    END;


-- Query 21: Weekday vs Weekend Patient Analysis

SELECT
    CASE
        WHEN DAYOFWEEK("Patient Admission Date")
             IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Admission Flag" = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY total_patients DESC;


-- Query 22: Hourly Patient Arrival Distribution
-- Admission Time is stored as 12-hour text with AM/PM.

WITH patient_hours AS (
    SELECT
        TRY_STRPTIME(
            TRIM("Patient Admission Time"),
            '%I:%M:%S %p'
        ) AS parsed_time
    FROM healthcare_raw
)
SELECT
    HOUR(parsed_time) AS arrival_hour,
    COUNT(*) AS total_patients
FROM patient_hours
WHERE parsed_time IS NOT NULL
GROUP BY 1
ORDER BY arrival_hour;


-- Query 23: Peak Patient Arrival Hours

WITH hourly_arrivals AS (
    SELECT
        HOUR(
            TRY_STRPTIME(
                TRIM("Patient Admission Time"),
                '%I:%M:%S %p'
            )
        ) AS arrival_hour
    FROM healthcare_raw
),
hourly_volume AS (
    SELECT
        arrival_hour,
        COUNT(*) AS total_patients
    FROM hourly_arrivals
    WHERE arrival_hour IS NOT NULL
    GROUP BY 1
)
SELECT
    arrival_hour,
    total_patients,
    DENSE_RANK() OVER (
        ORDER BY total_patients DESC
    ) AS volume_rank
FROM hourly_volume
ORDER BY volume_rank, arrival_hour
LIMIT 5;


-- Query 24: Average Wait Time by Age Group

WITH patient_age_groups AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" BETWEEN 18 AND 30 THEN '18-30'
            WHEN "Patient Age" BETWEEN 31 AND 45 THEN '31-45'
            WHEN "Patient Age" BETWEEN 46 AND 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group,
        "Patient Waittime" AS wait_time
    FROM healthcare_raw
    WHERE "Patient Age" IS NOT NULL
)
SELECT
    age_group,
    COUNT(*) AS total_patients,
    ROUND(AVG(wait_time), 2) AS avg_wait_time,
    ROUND(MEDIAN(wait_time), 2) AS median_wait_time,
    MIN(wait_time) AS min_wait_time,
    MAX(wait_time) AS max_wait_time
FROM patient_age_groups
GROUP BY age_group
ORDER BY avg_wait_time DESC;


-- Query 25: Waiting Time by Admission Status

SELECT
    "Patient Admission Flag" AS admission_status,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2)
        AS median_wait_time,
    MIN("Patient Waittime") AS min_wait_time,
    MAX("Patient Waittime") AS max_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY avg_wait_time DESC;


-- Query 26: Monthly Admission Rate Trends

SELECT
    DATE_TRUNC(
        'month', "Patient Admission Date"
    )::DATE AS admission_month,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Admission Flag" = 'Admission'
    ) AS admitted_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Admission Flag" = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY admission_month;


-- Query 27: Admission Rates by Age Group and Gender

WITH patient_segments AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" BETWEEN 18 AND 30 THEN '18-30'
            WHEN "Patient Age" BETWEEN 31 AND 45 THEN '31-45'
            WHEN "Patient Age" BETWEEN 46 AND 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group,
        CASE
            WHEN "Patient Gender" = 'Femaleemale'
                THEN 'Female'
            ELSE "Patient Gender"
        END AS gender,
        "Patient Admission Flag" AS admission_status
    FROM healthcare_raw
    WHERE "Patient Age" IS NOT NULL
)
SELECT
    age_group,
    gender,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE admission_status = 'Admission'
    ) AS admitted_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE admission_status = 'Admission'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS admission_rate_percentage
FROM patient_segments
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- Query 28: Patient Arrival Time Data Quality Check

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE TRY_STRPTIME(
            TRIM("Patient Admission Time"),
            '%I:%M:%S %p'
        ) IS NULL
    ) AS invalid_arrival_times
FROM healthcare_raw;


-- ============================================================
-- SQL PROJECT 17
-- Healthcare Patient Flow & Hospital Operations Analytics
-- DAY 3: Hospital Waiting Time & Department Performance
-- Queries 29-43
-- ============================================================


-- Query 29: Department-Wise Waiting Time Performance

SELECT
    "Department Referral" AS department,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    MIN("Patient Waittime") AS min_wait_time,
    MAX("Patient Waittime") AS max_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY avg_wait_time DESC;


-- Query 30: Patients Experiencing Long Waiting Times
-- Long wait threshold: greater than 45 minutes

SELECT
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" > 45
    ) AS long_wait_patients,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" <= 45
    ) AS patients_within_45_minutes,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS long_wait_percentage
FROM healthcare_raw;


-- Query 31: Long Waiting Time Rate by Department

SELECT
    "Department Referral" AS department,
    COUNT(*) AS total_patients,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" > 45
    ) AS long_wait_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS long_wait_percentage,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY long_wait_percentage DESC;


-- Query 32: Waiting Time Distribution

WITH wait_categories AS (
    SELECT
        CASE
            WHEN "Patient Waittime" <= 15 THEN '0-15 min'
            WHEN "Patient Waittime" <= 30 THEN '16-30 min'
            WHEN "Patient Waittime" <= 45 THEN '31-45 min'
            ELSE '46-60+ min'
        END AS wait_category
    FROM healthcare_raw
    WHERE "Patient Waittime" IS NOT NULL
)
SELECT
    wait_category,
    COUNT(*) AS total_patients,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM wait_categories
GROUP BY 1
ORDER BY
    CASE wait_category
        WHEN '0-15 min' THEN 1
        WHEN '16-30 min' THEN 2
        WHEN '31-45 min' THEN 3
        ELSE 4
    END;


-- Query 33: Waiting Time Percentiles

SELECT
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    ROUND(
        QUANTILE_CONT("Patient Waittime", 0.75),
        2
    ) AS p75_wait_time,
    ROUND(
        QUANTILE_CONT("Patient Waittime", 0.90),
        2
    ) AS p90_wait_time,
    ROUND(
        QUANTILE_CONT("Patient Waittime", 0.95),
        2
    ) AS p95_wait_time,
    MAX("Patient Waittime") AS max_wait_time
FROM healthcare_raw;


-- Query 34: Hourly Patient Arrivals and Average Wait Time

WITH hourly_data AS (
    SELECT
        HOUR(
            TRY_STRPTIME(
                TRIM("Patient Admission Time"),
                '%I:%M:%S %p'
            )
        ) AS arrival_hour,
        "Patient Waittime" AS wait_time
    FROM healthcare_raw
)
SELECT
    arrival_hour,
    COUNT(*) AS total_patients,
    ROUND(AVG(wait_time), 2) AS avg_wait_time,
    COUNT(*) FILTER (
        WHERE wait_time > 45
    ) AS long_wait_patients
FROM hourly_data
WHERE arrival_hour IS NOT NULL
GROUP BY 1
ORDER BY arrival_hour;


-- Query 35: Top 5 Hours with Highest Average Waiting Time

WITH hourly_waits AS (
    SELECT
        HOUR(
            TRY_STRPTIME(
                TRIM("Patient Admission Time"),
                '%I:%M:%S %p'
            )
        ) AS arrival_hour,
        "Patient Waittime" AS wait_time
    FROM healthcare_raw
),
hourly_summary AS (
    SELECT
        arrival_hour,
        COUNT(*) AS total_patients,
        ROUND(AVG(wait_time), 2) AS avg_wait_time
    FROM hourly_waits
    WHERE arrival_hour IS NOT NULL
    GROUP BY 1
)
SELECT
    arrival_hour,
    total_patients,
    avg_wait_time,
    DENSE_RANK() OVER (
        ORDER BY avg_wait_time DESC
    ) AS wait_rank
FROM hourly_summary
ORDER BY wait_rank, arrival_hour
LIMIT 5;


-- Query 36: Average Waiting Time by Day of Week

SELECT
    DAYNAME("Patient Admission Date") AS day_of_week,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS long_wait_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY
    CASE day_of_week
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        ELSE 7
    END;


-- Query 37: Monthly Waiting Time Trends

SELECT
    DATE_TRUNC(
        'month', "Patient Admission Date"
    )::DATE AS visit_month,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS long_wait_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY visit_month;


-- Query 38: Average Satisfaction Score by Waiting Time Category
-- NULL satisfaction scores are excluded from AVG.

WITH wait_groups AS (
    SELECT
        CASE
            WHEN "Patient Waittime" <= 15 THEN '0-15 min'
            WHEN "Patient Waittime" <= 30 THEN '16-30 min'
            WHEN "Patient Waittime" <= 45 THEN '31-45 min'
            ELSE '46-60+ min'
        END AS wait_category,
        "Patient Satisfaction Score" AS satisfaction_score
    FROM healthcare_raw
    WHERE "Patient Waittime" IS NOT NULL
)
SELECT
    wait_category,
    COUNT(*) AS total_patients,
    COUNT(satisfaction_score) AS satisfaction_responses,
    ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT(satisfaction_score)
        / NULLIF(COUNT(*), 0),
        2
    ) AS response_rate_percentage
FROM wait_groups
GROUP BY 1
ORDER BY
    CASE wait_category
        WHEN '0-15 min' THEN 1
        WHEN '16-30 min' THEN 2
        WHEN '31-45 min' THEN 3
        ELSE 4
    END;


-- Query 39: Correlation Between Waiting Time and Satisfaction
-- Only patients with recorded satisfaction scores.

SELECT
    COUNT(*) AS satisfaction_responses,
    ROUND(
        CORR(
            "Patient Waittime",
            "Patient Satisfaction Score"
        ),
        4
    ) AS wait_satisfaction_correlation
FROM healthcare_raw
WHERE "Patient Satisfaction Score" IS NOT NULL
  AND "Patient Waittime" IS NOT NULL;


-- Query 40: Department Satisfaction and Waiting Time

SELECT
    "Department Referral" AS department,
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0),
        2
    ) AS satisfaction_response_rate
FROM healthcare_raw
GROUP BY 1
ORDER BY avg_wait_time DESC;


-- Query 41: Department Performance Ranking by Wait Time

WITH department_metrics AS (
    SELECT
        "Department Referral" AS department,
        COUNT(*) AS total_patients,
        ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE "Patient Waittime" > 45
            ) / NULLIF(COUNT(*), 0),
            2
        ) AS long_wait_percentage
    FROM healthcare_raw
    GROUP BY 1
)
SELECT
    department,
    total_patients,
    avg_wait_time,
    long_wait_percentage,
    DENSE_RANK() OVER (
        ORDER BY avg_wait_time DESC
    ) AS wait_time_rank
FROM department_metrics
ORDER BY wait_time_rank, department;


-- Query 42: Patient Waiting Time by Admission Status
-- Compare admitted and non-admitted patients.

SELECT
    "Patient Admission Flag" AS admission_status,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" > 45
    ) AS long_wait_patients,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS long_wait_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY avg_wait_time DESC;


-- Query 43: Overall Waiting Time Performance Scorecard

SELECT
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2) AS median_wait_time,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" <= 30
    ) AS patients_within_30_minutes,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" <= 30
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS within_30_min_percentage,
    COUNT(*) FILTER (
        WHERE "Patient Waittime" > 45
    ) AS patients_above_45_minutes,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS above_45_min_percentage,
    ROUND(
        QUANTILE_CONT("Patient Waittime", 0.90),
        2
    ) AS p90_wait_time
FROM healthcare_raw;


-- ============================================================
-- SQL PROJECT 17
-- Healthcare Patient Flow & Hospital Operations Analytics
-- DAY 4: Patient Satisfaction & Experience Analytics
-- Queries 44-58
-- ============================================================


-- Query 44: Overall Patient Satisfaction Scorecard
-- Satisfaction is measured only for non-NULL responses.

SELECT
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score") AS satisfaction_responses,
    COUNT(*) - COUNT("Patient Satisfaction Score") AS missing_responses,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(MEDIAN("Patient Satisfaction Score"), 2)
        AS median_satisfaction_score,
    MIN("Patient Satisfaction Score") AS min_score,
    MAX("Patient Satisfaction Score") AS max_score
FROM healthcare_raw;


-- Query 45: Satisfaction Score Distribution

SELECT
    "Patient Satisfaction Score" AS satisfaction_score,
    COUNT(*) AS total_responses,
    ROUND(
        100.0 * COUNT(*)
        / NULLIF(
            SUM(COUNT(*)) OVER (), 0
        ), 2
    ) AS percentage_of_responses
FROM healthcare_raw
WHERE "Patient Satisfaction Score" IS NOT NULL
GROUP BY 1
ORDER BY satisfaction_score;


-- Query 46: Low, Moderate, and High Satisfaction Segments
-- Project-defined categories, not official clinical standards.

WITH satisfaction_groups AS (
    SELECT
        CASE
            WHEN "Patient Satisfaction Score" BETWEEN 0 AND 4
                THEN 'Low (0-4)'
            WHEN "Patient Satisfaction Score" BETWEEN 5 AND 7
                THEN 'Moderate (5-7)'
            WHEN "Patient Satisfaction Score" BETWEEN 8 AND 10
                THEN 'High (8-10)'
            ELSE 'Invalid Score'
        END AS satisfaction_segment
    FROM healthcare_raw
    WHERE "Patient Satisfaction Score" IS NOT NULL
)
SELECT
    satisfaction_segment,
    COUNT(*) AS total_responses,
    ROUND(
        100.0 * COUNT(*)
        / NULLIF(SUM(COUNT(*)) OVER (), 0), 2
    ) AS percentage_of_responses
FROM satisfaction_groups
GROUP BY 1
ORDER BY
    CASE satisfaction_segment
        WHEN 'Low (0-4)' THEN 1
        WHEN 'Moderate (5-7)' THEN 2
        WHEN 'High (8-10)' THEN 3
        ELSE 4
    END;


-- Query 47: Patient Satisfaction by Gender
-- Standardize the known gender typo during analysis.

WITH normalized_patients AS (
    SELECT
        CASE
            WHEN "Patient Gender" = 'Femaleemale'
                THEN 'Female'
            ELSE "Patient Gender"
        END AS gender,
        "Patient Satisfaction Score" AS satisfaction_score
    FROM healthcare_raw
)
SELECT
    gender,
    COUNT(*) AS total_patients,
    COUNT(satisfaction_score) AS satisfaction_responses,
    ROUND(AVG(satisfaction_score), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT(satisfaction_score)
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM normalized_patients
GROUP BY 1
ORDER BY gender;


-- Query 48: Satisfaction by Age Group

WITH patient_ages AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" <= 30 THEN '18-30'
            WHEN "Patient Age" <= 45 THEN '31-45'
            WHEN "Patient Age" <= 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group,
        "Patient Satisfaction Score" AS satisfaction_score
    FROM healthcare_raw
)
SELECT
    age_group,
    COUNT(*) AS total_patients,
    COUNT(satisfaction_score) AS satisfaction_responses,
    ROUND(AVG(satisfaction_score), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT(satisfaction_score)
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM patient_ages
GROUP BY 1
ORDER BY
    CASE age_group
        WHEN 'Under 18' THEN 1
        WHEN '18-30' THEN 2
        WHEN '31-45' THEN 3
        WHEN '46-60' THEN 4
        ELSE 5
    END;


-- Query 49: Satisfaction by Admission Status

SELECT
    "Patient Admission Flag" AS admission_status,
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY admission_status;


-- Query 50: Satisfaction by Referral Department

SELECT
    "Department Referral" AS department,
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY avg_satisfaction_score DESC;


-- Query 51: Monthly Satisfaction Trends

SELECT
    DATE_TRUNC(
        'month', "Patient Admission Date"
    )::DATE AS visit_month,
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY visit_month;


-- Query 52: Satisfaction by Arrival Hour

WITH hourly_patients AS (
    SELECT
        HOUR(
            TRY_STRPTIME(
                TRIM("Patient Admission Time"),
                '%I:%M:%S %p'
            )
        ) AS arrival_hour,
        "Patient Satisfaction Score" AS satisfaction_score,
        "Patient Waittime" AS wait_time
    FROM healthcare_raw
)
SELECT
    arrival_hour,
    COUNT(*) AS total_patients,
    COUNT(satisfaction_score) AS satisfaction_responses,
    ROUND(AVG(satisfaction_score), 2)
        AS avg_satisfaction_score,
    ROUND(AVG(wait_time), 2) AS avg_wait_time,
    ROUND(
        100.0 * COUNT(satisfaction_score)
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM hourly_patients
WHERE arrival_hour IS NOT NULL
GROUP BY 1
ORDER BY arrival_hour;


-- Query 53: Low Satisfaction Rate by Department
-- Low satisfaction defined as scores 0-4.

SELECT
    "Department Referral" AS department,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    COUNT(*) FILTER (
        WHERE "Patient Satisfaction Score" BETWEEN 0 AND 4
    ) AS low_satisfaction_responses,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Satisfaction Score" BETWEEN 0 AND 4
        )
        / NULLIF(COUNT("Patient Satisfaction Score"), 0),
        2
    ) AS low_satisfaction_rate,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score
FROM healthcare_raw
GROUP BY 1
ORDER BY low_satisfaction_rate DESC;


-- Query 54: Satisfaction Response Coverage by Age and Gender

WITH demographic_data AS (
    SELECT
        CASE
            WHEN "Patient Age" < 18 THEN 'Under 18'
            WHEN "Patient Age" <= 30 THEN '18-30'
            WHEN "Patient Age" <= 45 THEN '31-45'
            WHEN "Patient Age" <= 60 THEN '46-60'
            ELSE 'Above 60'
        END AS age_group,
        CASE
            WHEN "Patient Gender" = 'Femaleemale'
                THEN 'Female'
            ELSE "Patient Gender"
        END AS gender,
        "Patient Satisfaction Score" AS satisfaction_score
    FROM healthcare_raw
)
SELECT
    age_group,
    gender,
    COUNT(*) AS total_patients,
    COUNT(satisfaction_score) AS satisfaction_responses,
    COUNT(*) - COUNT(satisfaction_score) AS missing_responses,
    ROUND(
        100.0 * COUNT(satisfaction_score)
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage
FROM demographic_data
GROUP BY 1, 2
ORDER BY
    CASE age_group
        WHEN 'Under 18' THEN 1
        WHEN '18-30' THEN 2
        WHEN '31-45' THEN 3
        WHEN '46-60' THEN 4
        ELSE 5
    END,
    gender;


-- Query 55: Satisfaction vs. Wait Time Within Each Department
-- Correlation uses only records with valid satisfaction scores.

SELECT
    "Department Referral" AS department,
    COUNT(*) FILTER (
        WHERE "Patient Satisfaction Score" IS NOT NULL
          AND "Patient Waittime" IS NOT NULL
    ) AS satisfaction_responses,
    ROUND(
        CORR(
            "Patient Waittime",
            "Patient Satisfaction Score"
        ), 4
    ) AS wait_satisfaction_correlation,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score
FROM healthcare_raw
GROUP BY 1
ORDER BY department;


-- Query 56: Waiting Time Comparison for Satisfaction Respondents
-- Check whether respondents and nonrespondents differ in waiting time.

SELECT
    CASE
        WHEN "Patient Satisfaction Score" IS NOT NULL
            THEN 'Responded'
        ELSE 'No Response'
    END AS response_status,
    COUNT(*) AS total_patients,
    ROUND(AVG("Patient Waittime"), 2)
        AS avg_wait_time,
    ROUND(MEDIAN("Patient Waittime"), 2)
        AS median_wait_time,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Waittime" > 45
        ) / NULLIF(COUNT(*), 0), 2
    ) AS long_wait_percentage
FROM healthcare_raw
GROUP BY 1
ORDER BY response_status;


-- Query 57: Patient Satisfaction by Weekday vs Weekend

SELECT
    CASE
        WHEN DAYOFWEEK("Patient Admission Date") IN (0, 6)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time
FROM healthcare_raw
GROUP BY 1
ORDER BY day_type;


-- Query 58: Final Patient Experience Scorecard

SELECT
    COUNT(*) AS total_patients,
    COUNT("Patient Satisfaction Score")
        AS satisfaction_responses,
    ROUND(
        100.0 * COUNT("Patient Satisfaction Score")
        / NULLIF(COUNT(*), 0), 2
    ) AS response_rate_percentage,
    ROUND(AVG("Patient Satisfaction Score"), 2)
        AS avg_satisfaction_score,
    COUNT(*) FILTER (
        WHERE "Patient Satisfaction Score" BETWEEN 0 AND 4
    ) AS low_satisfaction_responses,
    COUNT(*) FILTER (
        WHERE "Patient Satisfaction Score" BETWEEN 8 AND 10
    ) AS high_satisfaction_responses,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Satisfaction Score" BETWEEN 0 AND 4
        )
        / NULLIF(COUNT("Patient Satisfaction Score"), 0), 2
    ) AS low_satisfaction_rate,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "Patient Satisfaction Score" BETWEEN 8 AND 10
        )
        / NULLIF(COUNT("Patient Satisfaction Score"), 0), 2
    ) AS high_satisfaction_rate,
    ROUND(AVG("Patient Waittime"), 2) AS avg_wait_time,
    ROUND(
        CORR(
            "Patient Waittime",
            "Patient Satisfaction Score"
        ), 4
    ) AS wait_satisfaction_correlation
FROM healthcare_raw;
