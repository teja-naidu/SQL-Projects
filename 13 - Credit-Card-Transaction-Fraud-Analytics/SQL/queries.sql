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