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

-- ============================================================
-- DAY 2: CUSTOMER FINANCIAL & CREDIT RISK ANALYSIS
-- ============================================================


-- ============================================================
-- QUERY 14: Default Risk by Income Band
-- ============================================================

SELECT
    CASE
        WHEN AMT_INCOME_TOTAL < 100000 THEN '1. Below 100K'
        WHEN AMT_INCOME_TOTAL < 150000 THEN '2. 100K - 150K'
        WHEN AMT_INCOME_TOTAL < 200000 THEN '3. 150K - 200K'
        WHEN AMT_INCOME_TOTAL < 300000 THEN '4. 200K - 300K'
        ELSE '5. 300K+'
    END AS income_band,

    COUNT(*) AS total_applications,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS defaulted_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY income_band
ORDER BY income_band;


-- ============================================================
-- QUERY 15: Credit-to-Income Ratio Risk
-- ============================================================

WITH credit_income AS (
    SELECT
        TARGET,
        AMT_CREDIT / NULLIF(AMT_INCOME_TOTAL, 0)
            AS credit_income_ratio
    FROM applications
)

SELECT
    CASE
        WHEN credit_income_ratio < 2 THEN '1. Below 2x'
        WHEN credit_income_ratio < 4 THEN '2. 2x - 4x'
        WHEN credit_income_ratio < 6 THEN '3. 4x - 6x'
        ELSE '4. 6x+'
    END AS credit_income_band,

    COUNT(*) AS total_applications,

    ROUND(AVG(credit_income_ratio), 2)
        AS average_credit_income_ratio,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM credit_income
GROUP BY credit_income_band
ORDER BY credit_income_band;


-- ============================================================
-- QUERY 16: Annuity-to-Income Burden
-- ============================================================

WITH annuity_income AS (
    SELECT
        TARGET,
        AMT_ANNUITY / NULLIF(AMT_INCOME_TOTAL, 0)
            AS annuity_income_ratio
    FROM applications
    WHERE AMT_ANNUITY IS NOT NULL
)

SELECT
    CASE
        WHEN annuity_income_ratio < 0.15 THEN '1. Below 15%'
        WHEN annuity_income_ratio < 0.25 THEN '2. 15% - 25%'
        WHEN annuity_income_ratio < 0.35 THEN '3. 25% - 35%'
        ELSE '4. 35%+'
    END AS annuity_burden_band,

    COUNT(*) AS total_applications,

    ROUND(AVG(annuity_income_ratio) * 100, 2)
        AS average_annuity_income_percentage,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM annuity_income
GROUP BY annuity_burden_band
ORDER BY annuity_burden_band;


-- ============================================================
-- QUERY 17: Default Risk by Credit Amount Band
-- ============================================================

SELECT
    CASE
        WHEN AMT_CREDIT < 250000 THEN '1. Below 250K'
        WHEN AMT_CREDIT < 500000 THEN '2. 250K - 500K'
        WHEN AMT_CREDIT < 750000 THEN '3. 500K - 750K'
        WHEN AMT_CREDIT < 1000000 THEN '4. 750K - 1M'
        ELSE '5. 1M+'
    END AS credit_band,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_CREDIT), 2)
        AS average_credit_amount,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY credit_band
ORDER BY credit_band;


-- ============================================================
-- QUERY 18: Default Risk by Age Group
-- DAYS_BIRTH stores age as negative number of days
-- ============================================================

WITH customer_age AS (
    SELECT
        TARGET,
        ABS(DAYS_BIRTH) / 365.25 AS age
    FROM applications
)

SELECT
    CASE
        WHEN age < 30 THEN '1. Under 30'
        WHEN age < 40 THEN '2. 30 - 39'
        WHEN age < 50 THEN '3. 40 - 49'
        WHEN age < 60 THEN '4. 50 - 59'
        ELSE '5. 60+'
    END AS age_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(age), 1) AS average_age,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM customer_age
GROUP BY age_group
ORDER BY age_group;


-- ============================================================
-- QUERY 19: Default Risk by Employment Length
--
-- 365243 is a special placeholder in this dataset and should
-- not be treated as actual employment history.
-- ============================================================

WITH employment AS (
    SELECT
        TARGET,

        CASE
            WHEN DAYS_EMPLOYED = 365243 THEN NULL
            ELSE ABS(DAYS_EMPLOYED) / 365.25
        END AS employment_years

    FROM applications
)

SELECT
    CASE
        WHEN employment_years IS NULL THEN '6. Unknown / Not employed'
        WHEN employment_years < 1 THEN '1. Less than 1 year'
        WHEN employment_years < 3 THEN '2. 1 - 3 years'
        WHEN employment_years < 5 THEN '3. 3 - 5 years'
        WHEN employment_years < 10 THEN '4. 5 - 10 years'
        ELSE '5. 10+ years'
    END AS employment_band,

    COUNT(*) AS total_applications,

    ROUND(AVG(employment_years), 2)
        AS average_employment_years,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM employment
GROUP BY employment_band
ORDER BY employment_band;


-- ============================================================
-- QUERY 20: Default Risk by Education Level
-- ============================================================

SELECT
    NAME_EDUCATION_TYPE,

    COUNT(*) AS total_applications,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS defaulted_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY NAME_EDUCATION_TYPE
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 21: Default Risk by Occupation
-- Only occupations with at least 1,000 applications
-- ============================================================

SELECT
    OCCUPATION_TYPE,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_INCOME_TOTAL), 2)
        AS average_income,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
WHERE OCCUPATION_TYPE IS NOT NULL
GROUP BY OCCUPATION_TYPE
HAVING COUNT(*) >= 1000
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 22: Car and Property Ownership Risk
-- ============================================================

SELECT
    FLAG_OWN_CAR,
    FLAG_OWN_REALTY,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_INCOME_TOTAL), 2)
        AS average_income,

    ROUND(AVG(AMT_CREDIT), 2)
        AS average_credit_amount,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY
    FLAG_OWN_CAR,
    FLAG_OWN_REALTY
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 23: Default Risk by Number of Children
-- ============================================================

SELECT
    CASE
        WHEN CNT_CHILDREN = 0 THEN '0 Children'
        WHEN CNT_CHILDREN = 1 THEN '1 Child'
        WHEN CNT_CHILDREN = 2 THEN '2 Children'
        ELSE '3+ Children'
    END AS children_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_INCOME_TOTAL), 2)
        AS average_income,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY children_group
ORDER BY children_group;


-- ============================================================
-- QUERY 24: External Credit Score Comparison
--
-- EXT_SOURCE_1, EXT_SOURCE_2 and EXT_SOURCE_3 are normalized
-- external credit-risk scores.
-- ============================================================

SELECT
    CASE
        WHEN TARGET = 0 THEN 'Non-Default'
        WHEN TARGET = 1 THEN 'Default'
    END AS risk_status,

    COUNT(*) AS total_applications,

    ROUND(AVG(EXT_SOURCE_1), 4)
        AS avg_external_score_1,

    ROUND(AVG(EXT_SOURCE_2), 4)
        AS avg_external_score_2,

    ROUND(AVG(EXT_SOURCE_3), 4)
        AS avg_external_score_3

FROM applications
GROUP BY TARGET
ORDER BY TARGET;


-- ============================================================
-- QUERY 25: External Score 2 Risk Bands
-- ============================================================

SELECT
    CASE
        WHEN EXT_SOURCE_2 < 0.3 THEN '1. Below 0.30'
        WHEN EXT_SOURCE_2 < 0.5 THEN '2. 0.30 - 0.50'
        WHEN EXT_SOURCE_2 < 0.7 THEN '3. 0.50 - 0.70'
        ELSE '4. 0.70+'
    END AS external_score_band,

    COUNT(*) AS total_applications,

    ROUND(AVG(EXT_SOURCE_2), 4)
        AS average_external_score,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
WHERE EXT_SOURCE_2 IS NOT NULL
GROUP BY external_score_band
ORDER BY external_score_band;

-- ============================================================
-- DAY 3: DEFAULT DRIVERS & RISK SEGMENTATION
-- ============================================================


-- ============================================================
-- QUERY 26: Default Risk by Gender
-- ============================================================

SELECT
    CODE_GENDER,

    COUNT(*) AS total_applications,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS defaulted_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
GROUP BY CODE_GENDER
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 27: Default Risk by Applicant Accompaniment Type
-- ============================================================

SELECT
    NAME_TYPE_SUITE,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_CREDIT), 2)
        AS average_credit_amount,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS defaulted_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
WHERE NAME_TYPE_SUITE IS NOT NULL
GROUP BY NAME_TYPE_SUITE
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 28: Family Size and Financial Dependents
-- ============================================================

SELECT
    CASE
        WHEN CNT_FAM_MEMBERS <= 1 THEN '1. Single Member'
        WHEN CNT_FAM_MEMBERS = 2 THEN '2. Two Members'
        WHEN CNT_FAM_MEMBERS = 3 THEN '3. Three Members'
        WHEN CNT_FAM_MEMBERS = 4 THEN '4. Four Members'
        ELSE '5. Five+ Members'
    END AS family_size_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(AMT_INCOME_TOTAL), 2)
        AS average_household_income,

    ROUND(AVG(AMT_ANNUITY), 2)
        AS average_annuity,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM applications
WHERE CNT_FAM_MEMBERS IS NOT NULL
GROUP BY family_size_group
ORDER BY family_size_group;


-- ============================================================
-- QUERY 29: Age + Income Combined Risk
-- ============================================================

WITH customer_profile AS (
    SELECT
        TARGET,

        CASE
            WHEN ABS(DAYS_BIRTH) / 365.25 < 30 THEN 'Under 30'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 40 THEN '30 - 39'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 50 THEN '40 - 49'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 60 THEN '50 - 59'
            ELSE '60+'
        END AS age_group,

        CASE
            WHEN AMT_INCOME_TOTAL < 150000 THEN 'Below 150K'
            WHEN AMT_INCOME_TOTAL < 300000 THEN '150K - 300K'
            ELSE '300K+'
        END AS income_group

    FROM applications
)

SELECT
    age_group,
    income_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM customer_profile
GROUP BY age_group, income_group
HAVING COUNT(*) >= 500
ORDER BY
    default_rate_percentage DESC;


-- ============================================================
-- QUERY 30: Age + Employment Stability Risk
-- ============================================================

WITH employment_profile AS (
    SELECT
        TARGET,

        CASE
            WHEN ABS(DAYS_BIRTH) / 365.25 < 30 THEN 'Under 30'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 40 THEN '30 - 39'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 50 THEN '40 - 49'
            WHEN ABS(DAYS_BIRTH) / 365.25 < 60 THEN '50 - 59'
            ELSE '60+'
        END AS age_group,

        CASE
            WHEN DAYS_EMPLOYED = 365243 THEN 'Unknown / Not employed'
            WHEN ABS(DAYS_EMPLOYED) / 365.25 < 3 THEN 'Less than 3 years'
            WHEN ABS(DAYS_EMPLOYED) / 365.25 < 10 THEN '3 - 10 years'
            ELSE '10+ years'
        END AS employment_group

    FROM applications
)

SELECT
    age_group,
    employment_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM employment_profile
GROUP BY age_group, employment_group
HAVING COUNT(*) >= 500
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 31: External Score + Employment Risk
-- ============================================================

WITH risk_profile AS (
    SELECT
        TARGET,

        CASE
            WHEN EXT_SOURCE_2 < 0.30 THEN 'Low Score'
            WHEN EXT_SOURCE_2 < 0.50 THEN 'Medium-Low Score'
            WHEN EXT_SOURCE_2 < 0.70 THEN 'Medium-High Score'
            ELSE 'High Score'
        END AS external_score_group,

        CASE
            WHEN DAYS_EMPLOYED = 365243 THEN 'Unknown / Not employed'
            WHEN ABS(DAYS_EMPLOYED) / 365.25 < 3 THEN 'Less than 3 years'
            WHEN ABS(DAYS_EMPLOYED) / 365.25 < 10 THEN '3 - 10 years'
            ELSE '10+ years'
        END AS employment_group

    FROM applications
    WHERE EXT_SOURCE_2 IS NOT NULL
)

SELECT
    external_score_group,
    employment_group,

    COUNT(*) AS total_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage

FROM risk_profile
GROUP BY
    external_score_group,
    employment_group
HAVING COUNT(*) >= 500
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 32: Financial Stress Indicators
-- ============================================================

WITH financial_stress AS (
    SELECT
        TARGET,

        AMT_CREDIT / NULLIF(AMT_INCOME_TOTAL, 0)
            AS credit_income_ratio,

        AMT_ANNUITY / NULLIF(AMT_INCOME_TOTAL, 0)
            AS annuity_income_ratio

    FROM applications
    WHERE
        AMT_INCOME_TOTAL > 0
        AND AMT_ANNUITY IS NOT NULL
)

SELECT
    CASE
        WHEN credit_income_ratio >= 4
             AND annuity_income_ratio >= 0.25
            THEN 'High Financial Stress'

        WHEN credit_income_ratio >= 4
             OR annuity_income_ratio >= 0.25
            THEN 'Moderate Financial Stress'

        ELSE 'Low Financial Stress'
    END AS financial_stress_segment,

    COUNT(*) AS total_applications,

    ROUND(
        AVG(credit_income_ratio),
        2
    ) AS average_credit_income_ratio,

    ROUND(
        AVG(annuity_income_ratio) * 100,
        2
    ) AS average_annuity_income_percentage,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM financial_stress
GROUP BY financial_stress_segment
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 33: Multi-Factor Risk Segmentation
--
-- Risk indicators:
-- 1. EXT_SOURCE_2 < 0.50
-- 2. Employment history < 3 years
-- 3. Age < 40
-- 4. Annuity-to-income ratio >= 25%
-- ============================================================

WITH risk_factors AS (
    SELECT
        SK_ID_CURR,
        TARGET,
        AMT_CREDIT,

        (
            CASE
                WHEN EXT_SOURCE_2 < 0.50 THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN DAYS_EMPLOYED != 365243
                     AND ABS(DAYS_EMPLOYED) / 365.25 < 3
                    THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN ABS(DAYS_BIRTH) / 365.25 < 40
                    THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN AMT_ANNUITY /
                     NULLIF(AMT_INCOME_TOTAL, 0) >= 0.25
                    THEN 1
                ELSE 0
            END
        ) AS risk_factor_count

    FROM applications
)

SELECT
    CASE
        WHEN risk_factor_count = 0 THEN 'Low Risk'
        WHEN risk_factor_count = 1 THEN 'Moderate Risk'
        WHEN risk_factor_count = 2 THEN 'Elevated Risk'
        ELSE 'High Risk'
    END AS risk_segment,

    COUNT(*) AS total_applications,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS defaulted_applications,

    ROUND(AVG(TARGET) * 100, 2)
        AS default_rate_percentage,

    ROUND(SUM(AMT_CREDIT), 2)
        AS total_credit_exposure

FROM risk_factors
GROUP BY risk_segment
ORDER BY default_rate_percentage DESC;


-- ============================================================
-- QUERY 34: Risk Segment Share of Portfolio
-- ============================================================

WITH risk_factors AS (
    SELECT
        TARGET,

        (
            CASE WHEN EXT_SOURCE_2 < 0.50 THEN 1 ELSE 0 END
            +
            CASE
                WHEN DAYS_EMPLOYED != 365243
                     AND ABS(DAYS_EMPLOYED) / 365.25 < 3
                THEN 1 ELSE 0
            END
            +
            CASE
                WHEN ABS(DAYS_BIRTH) / 365.25 < 40
                THEN 1 ELSE 0
            END
            +
            CASE
                WHEN AMT_ANNUITY /
                     NULLIF(AMT_INCOME_TOTAL, 0) >= 0.25
                THEN 1 ELSE 0
            END
        ) AS risk_factor_count

    FROM applications
),

segments AS (
    SELECT
        TARGET,

        CASE
            WHEN risk_factor_count = 0 THEN 'Low Risk'
            WHEN risk_factor_count = 1 THEN 'Moderate Risk'
            WHEN risk_factor_count = 2 THEN 'Elevated Risk'
            ELSE 'High Risk'
        END AS risk_segment

    FROM risk_factors
)

SELECT
    risk_segment,

    COUNT(*) AS total_applications,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS portfolio_percentage,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS total_defaults,

    ROUND(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        SUM(
            SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        ) OVER (),
        2
    ) AS share_of_all_defaults_percentage

FROM segments
GROUP BY risk_segment
ORDER BY
    share_of_all_defaults_percentage DESC;


-- ============================================================
-- QUERY 35: High-Risk Customer Profile
-- ============================================================

WITH risk_factors AS (
    SELECT
        *,

        (
            CASE WHEN EXT_SOURCE_2 < 0.50 THEN 1 ELSE 0 END
            +
            CASE
                WHEN DAYS_EMPLOYED != 365243
                     AND ABS(DAYS_EMPLOYED) / 365.25 < 3
                THEN 1 ELSE 0
            END
            +
            CASE
                WHEN ABS(DAYS_BIRTH) / 365.25 < 40
                THEN 1 ELSE 0
            END
            +
            CASE
                WHEN AMT_ANNUITY /
                     NULLIF(AMT_INCOME_TOTAL, 0) >= 0.25
                THEN 1 ELSE 0
            END
        ) AS risk_factor_count

    FROM applications
)

SELECT
    COUNT(*) AS high_risk_customers,

    ROUND(
        AVG(ABS(DAYS_BIRTH) / 365.25),
        1
    ) AS average_age,

    ROUND(
        AVG(AMT_INCOME_TOTAL),
        2
    ) AS average_income,

    ROUND(
        AVG(AMT_CREDIT),
        2
    ) AS average_credit,

    ROUND(
        AVG(AMT_ANNUITY),
        2
    ) AS average_annuity,

    ROUND(
        AVG(AMT_CREDIT /
            NULLIF(AMT_INCOME_TOTAL, 0)),
        2
    ) AS average_credit_income_ratio,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM risk_factors
WHERE risk_factor_count >= 3;