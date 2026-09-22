-- ============================================================
-- QUERY 1: Total Loan Applications
-- ============================================================

SELECT
    COUNT(*) AS total_applications
FROM applications;


-- ============================================================
-- QUERY 2: Default Distribution
-- TARGET:
-- 0 = Loan repaid / non-default
-- 1 = Payment difficulties / default risk
-- ============================================================

SELECT
    TARGET,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM applications
GROUP BY TARGET
ORDER BY TARGET;


-- ============================================================
-- QUERY 3: Overall Default Rate
-- ============================================================

SELECT
    COUNT(*) AS total_applications,

    SUM(
        CASE
            WHEN TARGET = 1 THEN 1
            ELSE 0
        END
    ) AS defaulted_applications,

    ROUND(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS default_rate_percentage

FROM applications;


-- ============================================================
-- QUERY 4: Total Credit Exposure
-- ============================================================

SELECT
    ROUND(SUM(AMT_CREDIT), 2) AS total_credit_amount,
    ROUND(AVG(AMT_CREDIT), 2) AS average_credit_amount,
    ROUND(MIN(AMT_CREDIT), 2) AS minimum_credit_amount,
    ROUND(MAX(AMT_CREDIT), 2) AS maximum_credit_amount
FROM applications;


-- ============================================================
-- QUERY 5: Income Profile
-- ============================================================

SELECT
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income,
    ROUND(MEDIAN(AMT_INCOME_TOTAL), 2) AS median_income,
    ROUND(MIN(AMT_INCOME_TOTAL), 2) AS minimum_income,
    ROUND(MAX(AMT_INCOME_TOTAL), 2) AS maximum_income
FROM applications;


-- ============================================================
-- QUERY 6: Applications by Contract Type
-- ============================================================

SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*) AS total_applications,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS application_percentage

FROM applications
GROUP BY NAME_CONTRACT_TYPE
ORDER BY total_applications DESC;


-- ============================================================
-- QUERY 7: Default Rate by Contract Type
-- ============================================================

SELECT
    NAME_CONTRACT_TYPE,

    COUNT(*) AS total_applications,

    SUM(
        CASE
            WHEN TARGET = 1 THEN 1
            ELSE 0
        END
    ) AS defaulted_applications,

    ROUND(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS default_rate_percentage

FROM applications
GROUP BY NAME_CONTRACT_TYPE
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 8: Applications by Income Type
-- ============================================================

SELECT
    NAME_INCOME_TYPE,
    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM applications
GROUP BY NAME_INCOME_TYPE
ORDER BY total_applications DESC;


-- ============================================================
-- QUERY 9: Applications by Family Status
-- ============================================================

SELECT
    NAME_FAMILY_STATUS,
    COUNT(*) AS total_applications,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM applications
GROUP BY NAME_FAMILY_STATUS
ORDER BY total_applications DESC;


-- ============================================================
-- QUERY 10: Applications by Housing Type
-- ============================================================

SELECT
    NAME_HOUSING_TYPE,
    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_CREDIT), 2) AS average_credit_amount,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM applications
GROUP BY NAME_HOUSING_TYPE
ORDER BY total_applications DESC;


-- ============================================================
-- QUERY 11: Credit Amount by Default Status
-- ============================================================

SELECT
    CASE
        WHEN TARGET = 0 THEN 'Non-Default'
        WHEN TARGET = 1 THEN 'Default'
    END AS risk_status,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_CREDIT), 2) AS average_credit_amount,

    ROUND(AVG(AMT_ANNUITY), 2) AS average_annuity,

    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income

FROM applications
GROUP BY TARGET
ORDER BY TARGET;


-- ============================================================
-- QUERY 12: Previous Application Overview
-- ============================================================

SELECT
    COUNT(*) AS total_previous_applications,
    COUNT(DISTINCT SK_ID_CURR) AS unique_customers,
    ROUND(AVG(AMT_APPLICATION), 2) AS average_requested_amount,
    ROUND(AVG(AMT_CREDIT), 2) AS average_approved_credit
FROM previous_applications;


-- ============================================================
-- QUERY 13: Previous Application Status Distribution
-- ============================================================

SELECT
    NAME_CONTRACT_STATUS,
    COUNT(*) AS total_applications,

    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage

FROM previous_applications
GROUP BY NAME_CONTRACT_STATUS
ORDER BY total_applications DESC;