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