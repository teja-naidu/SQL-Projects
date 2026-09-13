-- ============================================================
-- Project 13: Credit Card Transaction & Fraud Pattern Analytics
-- Day 1: Dataset Exploration & Core KPIs
-- ============================================================


-- 1. Total Transactions
SELECT
    COUNT(*) AS total_transactions
FROM credit_card_transactions;


-- 2. Fraud vs Legitimate Transactions
SELECT
    Class,
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 3. Overall Fraud Rate
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage
FROM credit_card_transactions;


-- 4. Total Transaction Amount
SELECT
    ROUND(SUM(Amount), 2) AS total_transaction_amount
FROM credit_card_transactions;


-- 5. Average Transaction Amount
SELECT
    ROUND(AVG(Amount), 2) AS average_transaction_amount
FROM credit_card_transactions;


-- 6. Transaction Amount by Fraud Status
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Amount), 2) AS total_amount,
    ROUND(AVG(Amount), 2) AS average_amount,
    ROUND(MIN(Amount), 2) AS minimum_amount,
    ROUND(MAX(Amount), 2) AS maximum_amount
FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 7. Check for Missing Values in Important Fields
SELECT
    SUM(CASE WHEN Time IS NULL THEN 1 ELSE 0 END) AS missing_time,
    SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS missing_amount,
    SUM(CASE WHEN Class IS NULL THEN 1 ELSE 0 END) AS missing_class
FROM credit_card_transactions;


-- 8. Dataset Time Range
SELECT
    MIN(Time) AS minimum_time_seconds,
    MAX(Time) AS maximum_time_seconds,
    ROUND((MAX(Time) - MIN(Time)) / 3600.0, 2) AS dataset_duration_hours
FROM credit_card_transactions;

-- ============================================================
-- Day 2: Transaction Amount & Fraud Risk Analysis
-- ============================================================


-- 9. Median Transaction Amount by Transaction Type
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,
    ROUND(MEDIAN(Amount), 2) AS median_transaction_amount,
    ROUND(AVG(Amount), 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 10. Transaction Distribution by Amount Band
SELECT
    CASE
        WHEN Amount = 0 THEN '$0'
        WHEN Amount <= 10 THEN '$0.01 - $10'
        WHEN Amount <= 50 THEN '$10.01 - $50'
        WHEN Amount <= 100 THEN '$50.01 - $100'
        WHEN Amount <= 500 THEN '$100.01 - $500'
        WHEN Amount <= 1000 THEN '$500.01 - $1,000'
        ELSE 'Above $1,000'
    END AS amount_band,

    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        4
    ) AS fraud_rate_percentage

FROM credit_card_transactions
GROUP BY amount_band
ORDER BY
    CASE amount_band
        WHEN '$0' THEN 1
        WHEN '$0.01 - $10' THEN 2
        WHEN '$10.01 - $50' THEN 3
        WHEN '$50.01 - $100' THEN 4
        WHEN '$100.01 - $500' THEN 5
        WHEN '$500.01 - $1,000' THEN 6
        WHEN 'Above $1,000' THEN 7
    END;


-- 11. Fraud Transaction Value by Amount Band
SELECT
    CASE
        WHEN Amount = 0 THEN '$0'
        WHEN Amount <= 10 THEN '$0.01 - $10'
        WHEN Amount <= 50 THEN '$10.01 - $50'
        WHEN Amount <= 100 THEN '$50.01 - $100'
        WHEN Amount <= 500 THEN '$100.01 - $500'
        WHEN Amount <= 1000 THEN '$500.01 - $1,000'
        ELSE 'Above $1,000'
    END AS amount_band,

    COUNT(*) AS fraudulent_transactions,

    ROUND(SUM(Amount), 2) AS fraudulent_amount,

    ROUND(AVG(Amount), 2) AS average_fraud_amount

FROM credit_card_transactions
WHERE Class = 1
GROUP BY amount_band
ORDER BY fraudulent_amount DESC;


-- 12. Fraud Share of Transaction Value
SELECT
    ROUND(SUM(Amount), 2) AS total_transaction_value,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_transaction_value,

    ROUND(
        100.0 *
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END)
        / SUM(Amount),
        4
    ) AS fraud_value_percentage

FROM credit_card_transactions;


-- 13. Zero-Value Transactions by Fraud Status
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,

    COUNT(*) AS zero_value_transactions

FROM credit_card_transactions
WHERE Amount = 0
GROUP BY Class
ORDER BY Class;


-- 14. Small-Value Transactions (Amount <= $10)
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,

    COUNT(*) AS total_transactions,

    ROUND(AVG(Amount), 2) AS average_amount,

    ROUND(SUM(Amount), 2) AS total_amount

FROM credit_card_transactions
WHERE Amount > 0
  AND Amount <= 10
GROUP BY Class
ORDER BY Class;


-- 15. High-Value Transactions (Amount > $1,000)
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,

    COUNT(*) AS total_transactions,

    ROUND(AVG(Amount), 2) AS average_amount,

    ROUND(MAX(Amount), 2) AS maximum_amount

FROM credit_card_transactions
WHERE Amount > 1000
GROUP BY Class
ORDER BY Class;


-- 16. Top 10 Highest-Value Fraudulent Transactions
SELECT
    Time,
    ROUND(Time / 3600.0, 2) AS hours_since_start,
    ROUND(Amount, 2) AS transaction_amount
FROM credit_card_transactions
WHERE Class = 1
ORDER BY Amount DESC
LIMIT 10;

-- ============================================================
-- Day 3: Time-Based Fraud Pattern Analysis
-- ============================================================


-- 17. Transaction Distribution by Dataset Day
SELECT
    FLOOR(Time / 86400) + 1 AS dataset_day,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage,
    ROUND(SUM(Amount), 2) AS total_transaction_amount,
    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount
FROM credit_card_transactions
GROUP BY dataset_day
ORDER BY dataset_day;


-- 18. Transactions by Hour Since Dataset Start
SELECT
    FLOOR(Time / 3600) AS hour_since_start,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY hour_since_start
ORDER BY hour_since_start;


-- 19. Top 10 Hours by Fraud Transaction Count
SELECT
    FLOOR(Time / 3600) AS hour_since_start,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY hour_since_start
ORDER BY fraudulent_transactions DESC, fraud_rate_percentage DESC
LIMIT 10;


-- 20. Top 10 Hours by Fraud Rate
-- Minimum transaction threshold prevents very small hourly groups
-- from dominating the ranking.
SELECT
    FLOOR(Time / 3600) AS hour_since_start,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY hour_since_start
HAVING COUNT(*) >= 1000
ORDER BY fraud_rate_percentage DESC
LIMIT 10;


-- 21. Fraud Amount by Hour
SELECT
    FLOOR(Time / 3600) AS hour_since_start,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount,
    ROUND(
        AVG(CASE WHEN Class = 1 THEN Amount END),
        2
    ) AS average_fraud_amount
FROM credit_card_transactions
GROUP BY hour_since_start
HAVING SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) > 0
ORDER BY fraudulent_amount DESC
LIMIT 10;


-- 22. Transaction Analysis by 6-Hour Time Window
SELECT
    CASE
        WHEN MOD(FLOOR(Time / 3600), 24) BETWEEN 0 AND 5
            THEN '00:00 - 05:59'
        WHEN MOD(FLOOR(Time / 3600), 24) BETWEEN 6 AND 11
            THEN '06:00 - 11:59'
        WHEN MOD(FLOOR(Time / 3600), 24) BETWEEN 12 AND 17
            THEN '12:00 - 17:59'
        ELSE '18:00 - 23:59'
    END AS time_window,

    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount

FROM credit_card_transactions
GROUP BY time_window
ORDER BY
    CASE time_window
        WHEN '00:00 - 05:59' THEN 1
        WHEN '06:00 - 11:59' THEN 2
        WHEN '12:00 - 17:59' THEN 3
        WHEN '18:00 - 23:59' THEN 4
    END;


-- 23. Fraud Statistics by Repeated Hour of Day
SELECT
    MOD(FLOOR(Time / 3600), 24) AS hour_of_day,

    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS fraud_rate_percentage,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount

FROM credit_card_transactions
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- 24. Peak Hour for Fraud Count, Rate, and Amount
WITH hourly_fraud AS (
    SELECT
        FLOOR(Time / 3600) AS hour_since_start,
        COUNT(*) AS total_transactions,
        SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
            AS fraudulent_transactions,
        100.0 *
            SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
            / COUNT(*) AS fraud_rate_percentage,
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END)
            AS fraudulent_amount
    FROM credit_card_transactions
    GROUP BY hour_since_start
)

SELECT
    'Highest Fraud Count' AS metric,
    hour_since_start,
    fraudulent_transactions,
    ROUND(fraud_rate_percentage, 4) AS fraud_rate_percentage,
    ROUND(fraudulent_amount, 2) AS fraudulent_amount
FROM hourly_fraud
ORDER BY fraudulent_transactions DESC
LIMIT 1;


-- ============================================================
-- Day 4: Fraud Feature & Behavioral Risk Analysis
-- ============================================================


-- 25. Average PCA Feature Values by Transaction Type
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,

    ROUND(AVG(V1), 4) AS avg_v1,
    ROUND(AVG(V2), 4) AS avg_v2,
    ROUND(AVG(V3), 4) AS avg_v3,
    ROUND(AVG(V4), 4) AS avg_v4,
    ROUND(AVG(V5), 4) AS avg_v5,
    ROUND(AVG(V6), 4) AS avg_v6,
    ROUND(AVG(V7), 4) AS avg_v7,
    ROUND(AVG(V8), 4) AS avg_v8,
    ROUND(AVG(V9), 4) AS avg_v9,
    ROUND(AVG(V10), 4) AS avg_v10,
    ROUND(AVG(V11), 4) AS avg_v11,
    ROUND(AVG(V12), 4) AS avg_v12,
    ROUND(AVG(V13), 4) AS avg_v13,
    ROUND(AVG(V14), 4) AS avg_v14
FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 26. Remaining PCA Feature Averages by Transaction Type
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        WHEN Class = 1 THEN 'Fraud'
    END AS transaction_type,

    ROUND(AVG(V15), 4) AS avg_v15,
    ROUND(AVG(V16), 4) AS avg_v16,
    ROUND(AVG(V17), 4) AS avg_v17,
    ROUND(AVG(V18), 4) AS avg_v18,
    ROUND(AVG(V19), 4) AS avg_v19,
    ROUND(AVG(V20), 4) AS avg_v20,
    ROUND(AVG(V21), 4) AS avg_v21,
    ROUND(AVG(V22), 4) AS avg_v22,
    ROUND(AVG(V23), 4) AS avg_v23,
    ROUND(AVG(V24), 4) AS avg_v24,
    ROUND(AVG(V25), 4) AS avg_v25,
    ROUND(AVG(V26), 4) AS avg_v26,
    ROUND(AVG(V27), 4) AS avg_v27,
    ROUND(AVG(V28), 4) AS avg_v28
FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 27. Rank Features by Absolute Difference Between
-- Fraud and Legitimate Average Values
WITH feature_averages AS (

    SELECT
        Class,
        AVG(V1) AS V1,
        AVG(V2) AS V2,
        AVG(V3) AS V3,
        AVG(V4) AS V4,
        AVG(V5) AS V5,
        AVG(V6) AS V6,
        AVG(V7) AS V7,
        AVG(V8) AS V8,
        AVG(V9) AS V9,
        AVG(V10) AS V10,
        AVG(V11) AS V11,
        AVG(V12) AS V12,
        AVG(V13) AS V13,
        AVG(V14) AS V14,
        AVG(V15) AS V15,
        AVG(V16) AS V16,
        AVG(V17) AS V17,
        AVG(V18) AS V18,
        AVG(V19) AS V19,
        AVG(V20) AS V20,
        AVG(V21) AS V21,
        AVG(V22) AS V22,
        AVG(V23) AS V23,
        AVG(V24) AS V24,
        AVG(V25) AS V25,
        AVG(V26) AS V26,
        AVG(V27) AS V27,
        AVG(V28) AS V28
    FROM credit_card_transactions
    GROUP BY Class
),

feature_differences AS (

    SELECT 'V1' AS feature,
           ABS(MAX(CASE WHEN Class = 1 THEN V1 END)
             - MAX(CASE WHEN Class = 0 THEN V1 END)) AS absolute_difference
    FROM feature_averages

    UNION ALL

    SELECT 'V2',
           ABS(MAX(CASE WHEN Class = 1 THEN V2 END)
             - MAX(CASE WHEN Class = 0 THEN V2 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V3',
           ABS(MAX(CASE WHEN Class = 1 THEN V3 END)
             - MAX(CASE WHEN Class = 0 THEN V3 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V4',
           ABS(MAX(CASE WHEN Class = 1 THEN V4 END)
             - MAX(CASE WHEN Class = 0 THEN V4 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V5',
           ABS(MAX(CASE WHEN Class = 1 THEN V5 END)
             - MAX(CASE WHEN Class = 0 THEN V5 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V6',
           ABS(MAX(CASE WHEN Class = 1 THEN V6 END)
             - MAX(CASE WHEN Class = 0 THEN V6 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V7',
           ABS(MAX(CASE WHEN Class = 1 THEN V7 END)
             - MAX(CASE WHEN Class = 0 THEN V7 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V8',
           ABS(MAX(CASE WHEN Class = 1 THEN V8 END)
             - MAX(CASE WHEN Class = 0 THEN V8 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V9',
           ABS(MAX(CASE WHEN Class = 1 THEN V9 END)
             - MAX(CASE WHEN Class = 0 THEN V9 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V10',
           ABS(MAX(CASE WHEN Class = 1 THEN V10 END)
             - MAX(CASE WHEN Class = 0 THEN V10 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V11',
           ABS(MAX(CASE WHEN Class = 1 THEN V11 END)
             - MAX(CASE WHEN Class = 0 THEN V11 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V12',
           ABS(MAX(CASE WHEN Class = 1 THEN V12 END)
             - MAX(CASE WHEN Class = 0 THEN V12 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V13',
           ABS(MAX(CASE WHEN Class = 1 THEN V13 END)
             - MAX(CASE WHEN Class = 0 THEN V13 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V14',
           ABS(MAX(CASE WHEN Class = 1 THEN V14 END)
             - MAX(CASE WHEN Class = 0 THEN V14 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V15',
           ABS(MAX(CASE WHEN Class = 1 THEN V15 END)
             - MAX(CASE WHEN Class = 0 THEN V15 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V16',
           ABS(MAX(CASE WHEN Class = 1 THEN V16 END)
             - MAX(CASE WHEN Class = 0 THEN V16 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V17',
           ABS(MAX(CASE WHEN Class = 1 THEN V17 END)
             - MAX(CASE WHEN Class = 0 THEN V17 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V18',
           ABS(MAX(CASE WHEN Class = 1 THEN V18 END)
             - MAX(CASE WHEN Class = 0 THEN V18 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V19',
           ABS(MAX(CASE WHEN Class = 1 THEN V19 END)
             - MAX(CASE WHEN Class = 0 THEN V19 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V20',
           ABS(MAX(CASE WHEN Class = 1 THEN V20 END)
             - MAX(CASE WHEN Class = 0 THEN V20 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V21',
           ABS(MAX(CASE WHEN Class = 1 THEN V21 END)
             - MAX(CASE WHEN Class = 0 THEN V21 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V22',
           ABS(MAX(CASE WHEN Class = 1 THEN V22 END)
             - MAX(CASE WHEN Class = 0 THEN V22 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V23',
           ABS(MAX(CASE WHEN Class = 1 THEN V23 END)
             - MAX(CASE WHEN Class = 0 THEN V23 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V24',
           ABS(MAX(CASE WHEN Class = 1 THEN V24 END)
             - MAX(CASE WHEN Class = 0 THEN V24 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V25',
           ABS(MAX(CASE WHEN Class = 1 THEN V25 END)
             - MAX(CASE WHEN Class = 0 THEN V25 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V26',
           ABS(MAX(CASE WHEN Class = 1 THEN V26 END)
             - MAX(CASE WHEN Class = 0 THEN V26 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V27',
           ABS(MAX(CASE WHEN Class = 1 THEN V27 END)
             - MAX(CASE WHEN Class = 0 THEN V27 END))
    FROM feature_averages

    UNION ALL

    SELECT 'V28',
           ABS(MAX(CASE WHEN Class = 1 THEN V28 END)
             - MAX(CASE WHEN Class = 0 THEN V28 END))
    FROM feature_averages
)

SELECT
    feature,
    ROUND(absolute_difference, 4) AS absolute_average_difference,
    RANK() OVER (
        ORDER BY absolute_difference DESC
    ) AS feature_rank
FROM feature_differences
ORDER BY feature_rank;


-- 28. Detailed Comparison of Top Candidate Features
SELECT
    CASE
        WHEN Class = 0 THEN 'Legitimate'
        ELSE 'Fraud'
    END AS transaction_type,

    ROUND(AVG(V3), 4) AS avg_v3,
    ROUND(MEDIAN(V3), 4) AS median_v3,

    ROUND(AVG(V10), 4) AS avg_v10,
    ROUND(MEDIAN(V10), 4) AS median_v10,

    ROUND(AVG(V12), 4) AS avg_v12,
    ROUND(MEDIAN(V12), 4) AS median_v12,

    ROUND(AVG(V14), 4) AS avg_v14,
    ROUND(MEDIAN(V14), 4) AS median_v14,

    ROUND(AVG(V17), 4) AS avg_v17,
    ROUND(MEDIAN(V17), 4) AS median_v17

FROM credit_card_transactions
GROUP BY Class
ORDER BY Class;


-- 29. V14 Quartile Risk Segmentation
WITH ranked_transactions AS (
    SELECT
        V14,
        Amount,
        Class,
        NTILE(4) OVER (ORDER BY V14) AS v14_quartile
    FROM credit_card_transactions
)

SELECT
    v14_quartile,
    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 *
        SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        4
    ) AS fraud_rate_percentage,

    ROUND(AVG(V14), 4) AS average_v14,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount

FROM ranked_transactions
GROUP BY v14_quartile
ORDER BY v14_quartile;


-- 30. V17 Quartile Risk Segmentation
WITH ranked_transactions AS (
    SELECT
        V17,
        Amount,
        Class,
        NTILE(4) OVER (ORDER BY V17) AS v17_quartile
    FROM credit_card_transactions
)

SELECT
    v17_quartile,
    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 *
        SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        4
    ) AS fraud_rate_percentage,

    ROUND(AVG(V17), 4) AS average_v17,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount

FROM ranked_transactions
GROUP BY v17_quartile
ORDER BY v17_quartile;


-- 31. Fraud Concentration in Lowest V14 and V17 Quartiles
WITH risk_segments AS (
    SELECT
        Class,
        Amount,
        NTILE(4) OVER (ORDER BY V14) AS v14_quartile,
        NTILE(4) OVER (ORDER BY V17) AS v17_quartile
    FROM credit_card_transactions
)

SELECT
    CASE
        WHEN v14_quartile = 1 AND v17_quartile = 1
            THEN 'Both Lowest Quartiles'
        ELSE 'Other Transactions'
    END AS risk_segment,

    COUNT(*) AS total_transactions,

    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        AS fraudulent_transactions,

    ROUND(
        100.0 *
        SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        4
    ) AS fraud_rate_percentage,

    ROUND(
        SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END),
        2
    ) AS fraudulent_amount

FROM risk_segments
GROUP BY risk_segment
ORDER BY fraudulent_transactions DESC;


-- 32. Rank Fraudulent Transactions by Amount
WITH fraud_rankings AS (
    SELECT
        Time,
        Amount,
        V14,
        V17,

        ROW_NUMBER() OVER (
            ORDER BY Amount DESC
        ) AS amount_rank,

        PERCENT_RANK() OVER (
            ORDER BY Amount
        ) AS amount_percentile

    FROM credit_card_transactions
    WHERE Class = 1
)

SELECT
    amount_rank,
    Time,
    ROUND(Amount, 2) AS amount,
    ROUND(V14, 4) AS v14,
    ROUND(V17, 4) AS v17,
    ROUND(amount_percentile * 100, 2) AS amount_percentile
FROM fraud_rankings
ORDER BY amount_rank
LIMIT 15;