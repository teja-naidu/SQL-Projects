
-- ============================================================
-- PROJECT 22: FINANCIAL RECONCILIATION & PAYMENT ANALYTICS
-- DATABASE: DuckDB
-- DAY 1: DATA EXPLORATION & FINANCIAL DATA QUALITY
-- ============================================================


-- ============================================================
-- QUERY 1: Dataset Record Counts
-- ============================================================

SELECT 'Main Checking Account' AS dataset,
       COUNT(*) AS total_records
FROM checking_account_main

UNION ALL

SELECT 'Secondary Checking Account', COUNT(*)
FROM checking_account_secondary

UNION ALL

SELECT 'Credit Card Account', COUNT(*)
FROM credit_card_account

UNION ALL

SELECT 'Gusto Payroll', COUNT(*)
FROM gusto_payroll

UNION ALL

SELECT 'Gusto Payroll BC', COUNT(*)
FROM gusto_payroll_bc

UNION ALL

SELECT 'Total Records',
       (SELECT COUNT(*) FROM checking_account_main)
       + (SELECT COUNT(*) FROM checking_account_secondary)
       + (SELECT COUNT(*) FROM credit_card_account)
       + (SELECT COUNT(*) FROM gusto_payroll)
       + (SELECT COUNT(*) FROM gusto_payroll_bc);


-- ============================================================
-- QUERY 2: Dataset Schema Validation
-- ============================================================

SELECT
    table_name,
    ordinal_position,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name IN (
    'checking_account_main',
    'checking_account_secondary',
    'credit_card_account',
    'gusto_payroll',
    'gusto_payroll_bc'
)
ORDER BY table_name, ordinal_position;


-- ============================================================
-- QUERY 3: Transaction and Payroll Date Coverage
-- ============================================================

SELECT
    'Main Checking Account' AS dataset,
    MIN(CAST(date AS DATE)) AS earliest_date,
    MAX(CAST(date AS DATE)) AS latest_date,
    COUNT(DISTINCT date) AS distinct_dates,
    DATE_DIFF('day', MIN(CAST(date AS DATE)),
                     MAX(CAST(date AS DATE))) + 1 AS coverage_days
FROM checking_account_main

UNION ALL

SELECT
    'Secondary Checking Account',
    MIN(CAST(date AS DATE)),
    MAX(CAST(date AS DATE)),
    COUNT(DISTINCT date),
    DATE_DIFF('day', MIN(CAST(date AS DATE)),
                     MAX(CAST(date AS DATE))) + 1
FROM checking_account_secondary

UNION ALL

SELECT
    'Credit Card Account',
    MIN(CAST(date AS DATE)),
    MAX(CAST(date AS DATE)),
    COUNT(DISTINCT date),
    DATE_DIFF('day', MIN(CAST(date AS DATE)),
                     MAX(CAST(date AS DATE))) + 1
FROM credit_card_account

UNION ALL

SELECT
    'Gusto Payroll',
    MIN(CAST(pay_date AS DATE)),
    MAX(CAST(pay_date AS DATE)),
    COUNT(DISTINCT pay_date),
    DATE_DIFF('day', MIN(CAST(pay_date AS DATE)),
                     MAX(CAST(pay_date AS DATE))) + 1
FROM gusto_payroll

UNION ALL

SELECT
    'Gusto Payroll BC',
    MIN(CAST(Pay_Date AS DATE)),
    MAX(CAST(Pay_Date AS DATE)),
    COUNT(DISTINCT Pay_Date),
    DATE_DIFF('day', MIN(CAST(Pay_Date AS DATE)),
                     MAX(CAST(Pay_Date AS DATE))) + 1
FROM gusto_payroll_bc;


-- ============================================================
-- QUERY 4: Bank and Credit Card Missing Value Validation
-- ============================================================

WITH account_data AS (
    SELECT
        'Main Checking' AS account_name,
        date,
        transaction_id,
        description AS transaction_description,
        category,
        type,
        amount,
        balance
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        date,
        transaction_id,
        description,
        category,
        type,
        amount,
        balance
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        date,
        transaction_id,
        vendor,
        category,
        type,
        amount,
        balance
    FROM credit_card_account
)
SELECT
    account_name,
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(date) AS missing_dates,
    COUNT(*) - COUNT(transaction_id) AS missing_transaction_ids,
    COUNT(*) - COUNT(transaction_description) AS missing_descriptions,
    COUNT(*) - COUNT(category) AS missing_categories,
    COUNT(*) - COUNT(type) AS missing_transaction_types,
    COUNT(*) - COUNT(amount) AS missing_amounts,
    COUNT(*) - COUNT(balance) AS missing_balances
FROM account_data
GROUP BY account_name
ORDER BY account_name;


-- ============================================================
-- QUERY 5: Payroll Missing Value Validation
-- ============================================================

SELECT
    'Gusto Payroll' AS dataset,
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(pay_date) AS missing_pay_dates,
    COUNT(*) - COUNT(employee_id) AS missing_employee_ids,
    COUNT(*) - COUNT(employee_name) AS missing_employee_names,
    COUNT(*) - COUNT(role) AS missing_roles,
    COUNT(*) - COUNT(type) AS missing_payment_types,
    COUNT(*) - COUNT(amount) AS missing_amounts,
    COUNT(*) - COUNT(account) AS missing_accounts
FROM gusto_payroll;

SELECT
    'Gusto Payroll BC' AS dataset,
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(Employee_ID) AS missing_employee_ids,
    COUNT(*) - COUNT(Employee_Name) AS missing_employee_names,
    COUNT(*) - COUNT(Role) AS missing_roles,
    COUNT(*) - COUNT(Pay_Date) AS missing_pay_dates,
    COUNT(*) - COUNT(Gross_Pay) AS missing_gross_pay,
    COUNT(*) - COUNT(Federal_Tax) AS missing_federal_tax,
    COUNT(*) - COUNT(Provincial_Tax) AS missing_provincial_tax,
    COUNT(*) - COUNT(CPP) AS missing_cpp,
    COUNT(*) - COUNT(EI) AS missing_ei,
    COUNT(*) - COUNT(Other_Deductions) AS missing_other_deductions,
    COUNT(*) - COUNT(Net_Pay) AS missing_net_pay,
    COUNT(*) - COUNT(Employer_CPP) AS missing_employer_cpp,
    COUNT(*) - COUNT(Employer_EI) AS missing_employer_ei,
    COUNT(*) - COUNT(Tips) AS missing_tips,
    COUNT(*) - COUNT(Travel_Reimbursement) AS missing_reimbursements
FROM gusto_payroll_bc;


-- ============================================================
-- QUERY 6: Fully Duplicated Record Detection
-- ============================================================

SELECT
    'Main Checking' AS dataset,
    COUNT(*) AS total_records,
    COUNT(*) - (
        SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM checking_account_main)
    ) AS duplicate_records
FROM checking_account_main

UNION ALL

SELECT
    'Secondary Checking',
    COUNT(*),
    COUNT(*) - (
        SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM checking_account_secondary)
    )
FROM checking_account_secondary

UNION ALL

SELECT
    'Credit Card',
    COUNT(*),
    COUNT(*) - (
        SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM credit_card_account)
    )
FROM credit_card_account

UNION ALL

SELECT
    'Gusto Payroll',
    COUNT(*),
    COUNT(*) - (
        SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM gusto_payroll)
    )
FROM gusto_payroll

UNION ALL

SELECT
    'Gusto Payroll BC',
    COUNT(*),
    COUNT(*) - (
        SELECT COUNT(*)
        FROM (SELECT DISTINCT * FROM gusto_payroll_bc)
    )
FROM gusto_payroll_bc;


-- ============================================================
-- QUERY 7: Transaction Identifier Uniqueness
-- ============================================================

WITH transactions AS (
    SELECT 'Main Checking' AS account_name, transaction_id
    FROM checking_account_main

    UNION ALL

    SELECT 'Secondary Checking', transaction_id
    FROM checking_account_secondary

    UNION ALL

    SELECT 'Credit Card', transaction_id
    FROM credit_card_account
)
SELECT
    account_name,
    COUNT(*) AS total_records,
    COUNT(transaction_id) AS non_null_ids,
    COUNT(DISTINCT transaction_id) AS unique_transaction_ids,
    COUNT(transaction_id) - COUNT(DISTINCT transaction_id)
        AS repeated_transaction_ids
FROM transactions
GROUP BY account_name
ORDER BY account_name;


-- ============================================================
-- QUERY 8: Transaction Type Distribution
-- ============================================================

WITH transactions AS (
    SELECT
        'Main Checking' AS account_name,
        type,
        amount
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        type,
        amount
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        type,
        amount
    FROM credit_card_account
)
SELECT
    account_name,
    type AS transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY account_name),
        2
    ) AS transaction_percentage
FROM transactions
GROUP BY account_name, type
ORDER BY account_name, transaction_count DESC;


-- ============================================================
-- QUERY 9: Transaction Category Distribution
-- ============================================================

WITH transactions AS (
    SELECT
        'Main Checking' AS account_name,
        category,
        amount
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        category,
        amount
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        category,
        amount
    FROM credit_card_account
)
SELECT
    account_name,
    category,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY account_name),
        2
    ) AS transaction_percentage
FROM transactions
GROUP BY account_name, category
ORDER BY account_name, transaction_count DESC;


-- ============================================================
-- QUERY 10: Transaction Amount and Balance Validation
-- ============================================================

WITH transactions AS (
    SELECT
        'Main Checking' AS account_name,
        amount,
        balance
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        amount,
        balance
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        amount,
        balance
    FROM credit_card_account
)
SELECT
    account_name,
    COUNT(*) AS total_transactions,
    MIN(amount) AS minimum_transaction_amount,
    MAX(amount) AS maximum_transaction_amount,
    ROUND(AVG(amount), 2) AS average_transaction_amount,
    ROUND(MEDIAN(amount), 2) AS median_transaction_amount,
    COUNT(*) FILTER (WHERE amount = 0) AS zero_amount_transactions,
    COUNT(*) FILTER (WHERE amount < 0) AS negative_amount_transactions,
    MIN(balance) AS minimum_balance,
    MAX(balance) AS maximum_balance,
    COUNT(*) FILTER (WHERE balance < 0) AS negative_balance_records
FROM transactions
GROUP BY account_name
ORDER BY account_name;


-- ============================================================
-- QUERY 11: Monthly Transaction Coverage
-- ============================================================

WITH transactions AS (
    SELECT
        'Main Checking' AS account_name,
        CAST(date AS DATE) AS transaction_date
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        CAST(date AS DATE)
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        CAST(date AS DATE)
    FROM credit_card_account
)
SELECT
    YEAR(transaction_date) AS transaction_year,
    MONTH(transaction_date) AS transaction_month,
    COUNT(*) FILTER (
        WHERE account_name = 'Main Checking'
    ) AS main_checking_transactions,
    COUNT(*) FILTER (
        WHERE account_name = 'Secondary Checking'
    ) AS secondary_checking_transactions,
    COUNT(*) FILTER (
        WHERE account_name = 'Credit Card'
    ) AS credit_card_transactions,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY
    YEAR(transaction_date),
    MONTH(transaction_date)
ORDER BY transaction_year, transaction_month;


-- ============================================================
-- QUERY 12: Payroll Employee Identifier Validation
-- ============================================================

SELECT
    'Gusto Payroll' AS dataset,
    COUNT(*) AS payroll_records,
    COUNT(DISTINCT employee_id) AS unique_employee_ids,
    COUNT(DISTINCT employee_name) AS unique_employee_names,
    COUNT(DISTINCT role) AS unique_roles,
    COUNT(DISTINCT pay_date) AS unique_pay_dates,
    COUNT(DISTINCT (employee_id, pay_date))
        AS unique_employee_pay_date_combinations,
    COUNT(*) - COUNT(DISTINCT (employee_id, pay_date))
        AS repeated_employee_pay_date_combinations
FROM gusto_payroll

UNION ALL

SELECT
    'Gusto Payroll BC',
    COUNT(*),
    COUNT(DISTINCT Employee_ID),
    COUNT(DISTINCT Employee_Name),
    COUNT(DISTINCT Role),
    COUNT(DISTINCT Pay_Date),
    COUNT(DISTINCT (Employee_ID, Pay_Date)),
    COUNT(*) - COUNT(DISTINCT (Employee_ID, Pay_Date))
FROM gusto_payroll_bc;


-- ============================================================
-- QUERY 13: Payroll Role and Payment Type Distribution
-- ============================================================

SELECT
    role,
    type AS payment_type,
    COUNT(DISTINCT employee_id) AS unique_employees,
    COUNT(*) AS payroll_records,
    ROUND(SUM(amount), 2) AS total_payroll_amount,
    ROUND(AVG(amount), 2) AS average_payment,
    MIN(amount) AS minimum_payment,
    MAX(amount) AS maximum_payment
FROM gusto_payroll
GROUP BY role, type
ORDER BY total_payroll_amount DESC;

SELECT
    Role AS employee_role,
    COUNT(DISTINCT Employee_ID) AS unique_employees,
    COUNT(*) AS payroll_records,
    ROUND(SUM(Gross_Pay), 2) AS total_gross_pay,
    ROUND(SUM(Net_Pay), 2) AS total_net_pay,
    ROUND(AVG(Gross_Pay), 2) AS average_gross_pay,
    ROUND(AVG(Net_Pay), 2) AS average_net_pay
FROM gusto_payroll_bc
GROUP BY Role
ORDER BY total_gross_pay DESC;


-- ============================================================
-- QUERY 14: Payroll Financial Amount Validation
-- ============================================================

SELECT
    'Gusto Payroll' AS dataset,
    COUNT(*) AS payroll_records,
    MIN(amount) AS minimum_payment,
    MAX(amount) AS maximum_payment,
    ROUND(AVG(amount), 2) AS average_payment,
    COUNT(*) FILTER (WHERE amount = 0) AS zero_payments,
    COUNT(*) FILTER (WHERE amount < 0) AS negative_payments
FROM gusto_payroll;

SELECT
    COUNT(*) AS payroll_records,
    COUNT(*) FILTER (WHERE Gross_Pay <= 0)
        AS non_positive_gross_pay,
    COUNT(*) FILTER (WHERE Net_Pay < 0)
        AS negative_net_pay,
    COUNT(*) FILTER (WHERE Federal_Tax < 0)
        AS negative_federal_tax,
    COUNT(*) FILTER (WHERE Provincial_Tax < 0)
        AS negative_provincial_tax,
    COUNT(*) FILTER (WHERE CPP < 0)
        AS negative_cpp,
    COUNT(*) FILTER (WHERE EI < 0)
        AS negative_ei,
    COUNT(*) FILTER (WHERE Other_Deductions < 0)
        AS negative_other_deductions,
    COUNT(*) FILTER (WHERE Employer_CPP < 0)
        AS negative_employer_cpp,
    COUNT(*) FILTER (WHERE Employer_EI < 0)
        AS negative_employer_ei,
    COUNT(*) FILTER (WHERE Tips < 0)
        AS negative_tips,
    COUNT(*) FILTER (WHERE Travel_Reimbursement < 0)
        AS negative_reimbursements,
    COUNT(*) FILTER (WHERE Net_Pay > Gross_Pay)
        AS net_pay_exceeds_gross_pay
FROM gusto_payroll_bc;


-- ============================================================
-- QUERY 15: Consolidated Data Quality Scorecard
-- ============================================================

WITH quality_metrics AS (
    SELECT
        'Main Checking' AS dataset,
        COUNT(*) AS total_records,
        COUNT(*) FILTER (
            WHERE date IS NULL
               OR transaction_id IS NULL
               OR description IS NULL
               OR category IS NULL
               OR type IS NULL
               OR amount IS NULL
               OR balance IS NULL
        ) AS incomplete_records,
        COUNT(*) FILTER (
            WHERE TRY_CAST(date AS DATE) IS NULL
        ) AS invalid_date_records,
        COUNT(*) FILTER (
            WHERE amount <= 0
        ) AS amount_review_records,
        COUNT(*) FILTER (
            WHERE date IS NOT NULL
              AND transaction_id IS NOT NULL
              AND description IS NOT NULL
              AND category IS NOT NULL
              AND type IS NOT NULL
              AND amount IS NOT NULL
              AND balance IS NOT NULL
              AND TRY_CAST(date AS DATE) IS NOT NULL
              AND amount > 0
        ) AS passing_records
    FROM checking_account_main

    UNION ALL

    SELECT
        'Secondary Checking',
        COUNT(*),
        COUNT(*) FILTER (
            WHERE date IS NULL
               OR transaction_id IS NULL
               OR description IS NULL
               OR category IS NULL
               OR type IS NULL
               OR amount IS NULL
               OR balance IS NULL
        ),
        COUNT(*) FILTER (
            WHERE TRY_CAST(date AS DATE) IS NULL
        ),
        COUNT(*) FILTER (WHERE amount <= 0),
        COUNT(*) FILTER (
            WHERE date IS NOT NULL
              AND transaction_id IS NOT NULL
              AND description IS NOT NULL
              AND category IS NOT NULL
              AND type IS NOT NULL
              AND amount IS NOT NULL
              AND balance IS NOT NULL
              AND TRY_CAST(date AS DATE) IS NOT NULL
              AND amount > 0
        )
    FROM checking_account_secondary

    UNION ALL

    SELECT
        'Credit Card',
        COUNT(*),
        COUNT(*) FILTER (
            WHERE date IS NULL
               OR transaction_id IS NULL
               OR vendor IS NULL
               OR category IS NULL
               OR type IS NULL
               OR amount IS NULL
               OR balance IS NULL
        ),
        COUNT(*) FILTER (
            WHERE TRY_CAST(date AS DATE) IS NULL
        ),
        COUNT(*) FILTER (WHERE amount <= 0),
        COUNT(*) FILTER (
            WHERE date IS NOT NULL
              AND transaction_id IS NOT NULL
              AND vendor IS NOT NULL
              AND category IS NOT NULL
              AND type IS NOT NULL
              AND amount IS NOT NULL
              AND balance IS NOT NULL
              AND TRY_CAST(date AS DATE) IS NOT NULL
              AND amount > 0
        )
    FROM credit_card_account

    UNION ALL

    SELECT
        'Gusto Payroll',
        COUNT(*),
        COUNT(*) FILTER (
            WHERE pay_date IS NULL
               OR employee_id IS NULL
               OR employee_name IS NULL
               OR role IS NULL
               OR type IS NULL
               OR amount IS NULL
               OR account IS NULL
        ),
        COUNT(*) FILTER (
            WHERE TRY_CAST(pay_date AS DATE) IS NULL
        ),
        COUNT(*) FILTER (WHERE amount <= 0),
        COUNT(*) FILTER (
            WHERE pay_date IS NOT NULL
              AND employee_id IS NOT NULL
              AND employee_name IS NOT NULL
              AND role IS NOT NULL
              AND type IS NOT NULL
              AND amount IS NOT NULL
              AND account IS NOT NULL
              AND TRY_CAST(pay_date AS DATE) IS NOT NULL
              AND amount > 0
        )
    FROM gusto_payroll

    UNION ALL

    SELECT
        'Gusto Payroll BC',
        COUNT(*),
        COUNT(*) FILTER (
            WHERE Employee_ID IS NULL
               OR Employee_Name IS NULL
               OR Role IS NULL
               OR Pay_Date IS NULL
               OR Gross_Pay IS NULL
               OR Net_Pay IS NULL
               OR Federal_Tax IS NULL
               OR Provincial_Tax IS NULL
               OR CPP IS NULL
               OR EI IS NULL
               OR Other_Deductions IS NULL
               OR Employer_CPP IS NULL
               OR Employer_EI IS NULL
               OR Tips IS NULL
               OR Travel_Reimbursement IS NULL
        ),
        COUNT(*) FILTER (
            WHERE TRY_CAST(Pay_Date AS DATE) IS NULL
        ),
        COUNT(*) FILTER (
            WHERE Gross_Pay <= 0 OR Net_Pay < 0
        ),
        COUNT(*) FILTER (
            WHERE Employee_ID IS NOT NULL
              AND Employee_Name IS NOT NULL
              AND Role IS NOT NULL
              AND Pay_Date IS NOT NULL
              AND Gross_Pay IS NOT NULL
              AND Net_Pay IS NOT NULL
              AND Federal_Tax IS NOT NULL
              AND Provincial_Tax IS NOT NULL
              AND CPP IS NOT NULL
              AND EI IS NOT NULL
              AND Other_Deductions IS NOT NULL
              AND Employer_CPP IS NOT NULL
              AND Employer_EI IS NOT NULL
              AND Tips IS NOT NULL
              AND Travel_Reimbursement IS NOT NULL
              AND TRY_CAST(Pay_Date AS DATE) IS NOT NULL
              AND Gross_Pay > 0
              AND Net_Pay >= 0
        )
    FROM gusto_payroll_bc
)
SELECT
    dataset,
    total_records,
    incomplete_records,
    invalid_date_records,
    amount_review_records,
    passing_records,
    total_records - passing_records AS records_requiring_review,
    ROUND(
        100.0 * passing_records / NULLIF(total_records, 0),
        2
    ) AS basic_quality_score_percentage,
    CASE
        WHEN passing_records = total_records
            THEN 'Passed Basic Checks'
        ELSE 'Requires Review'
    END AS data_quality_status
FROM quality_metrics
ORDER BY dataset;


-- ============================================================
-- END OF DAY 1
-- ============================================================
