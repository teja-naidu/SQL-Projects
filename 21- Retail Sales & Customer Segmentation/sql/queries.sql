
-- ============================================================
-- PROJECT 21: ONLINE RETAIL & CUSTOMER BEHAVIOR ANALYTICS
-- DAY 1: DATA EXPLORATION & QUALITY ASSESSMENT
-- DATABASE: DUCKDB
-- QUERIES: 1-15
-- ============================================================


-- ============================================================
-- QUERY 1: TOTAL RECORDS
-- ============================================================

SELECT
    COUNT(*) AS total_records
FROM online_retail;


-- ============================================================
-- QUERY 2: DATASET SCHEMA
-- ============================================================

DESCRIBE online_retail;


-- ============================================================
-- QUERY 3: DATE RANGE AND COVERAGE
-- ============================================================

SELECT
    MIN(invoice_date) AS earliest_transaction,
    MAX(invoice_date) AS latest_transaction,
    DATE_DIFF(
        'day',
        MIN(invoice_date)::DATE,
        MAX(invoice_date)::DATE
    ) + 1 AS calendar_days,
    COUNT(DISTINCT invoice_date::DATE)
        AS active_transaction_days
FROM online_retail;


-- ============================================================
-- QUERY 4: UNIQUE INVOICES, PRODUCTS, CUSTOMERS AND COUNTRIES
-- ============================================================

SELECT
    COUNT(DISTINCT invoice_no) AS unique_invoices,
    COUNT(DISTINCT stock_code) AS unique_products,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT country) AS unique_countries
FROM online_retail;


-- ============================================================
-- QUERY 5: MISSING AND BLANK VALUES
-- ============================================================

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE invoice_no IS NULL
           OR TRIM(invoice_no) = ''
    ) AS missing_invoice_no,

    COUNT(*) FILTER (
        WHERE stock_code IS NULL
           OR TRIM(stock_code) = ''
    ) AS missing_stock_code,

    COUNT(*) FILTER (
        WHERE description IS NULL
           OR TRIM(description) = ''
    ) AS missing_description,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS missing_customer_id,

    COUNT(*) FILTER (
        WHERE country IS NULL
           OR TRIM(country) = ''
    ) AS missing_country

FROM online_retail;


-- ============================================================
-- QUERY 6: MISSING CUSTOMER PERCENTAGE
-- ============================================================

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS missing_customer_rows,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE customer_id IS NULL
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_customer_pct

FROM online_retail;


-- ============================================================
-- QUERY 7: EXACT DUPLICATE BUSINESS ROWS
-- Excludes source_row_index from duplicate definition
-- ============================================================

WITH duplicate_groups AS (
    SELECT
        invoice_no,
        stock_code,
        description,
        quantity,
        invoice_date,
        unit_price,
        customer_id,
        country,
        COUNT(*) AS occurrence_count
    FROM online_retail
    GROUP BY ALL
    HAVING COUNT(*) > 1
)

SELECT
    COUNT(*) AS duplicate_groups,

    COALESCE(
        SUM(occurrence_count - 1), 0
    ) AS excess_duplicate_rows,

    COALESCE(
        SUM(occurrence_count), 0
    ) AS rows_in_duplicate_groups

FROM duplicate_groups;


-- ============================================================
-- QUERY 8: QUANTITY DISTRIBUTION
-- ============================================================

SELECT
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,

    COUNT(*) FILTER (
        WHERE quantity > 0
    ) AS positive_quantity_rows,

    COUNT(*) FILTER (
        WHERE quantity < 0
    ) AS negative_quantity_rows,

    COUNT(*) FILTER (
        WHERE quantity = 0
    ) AS zero_quantity_rows

FROM online_retail;


-- ============================================================
-- QUERY 9: UNIT PRICE DISTRIBUTION
-- ============================================================

SELECT
    MIN(unit_price) AS min_unit_price,
    MAX(unit_price) AS max_unit_price,

    COUNT(*) FILTER (
        WHERE unit_price > 0
    ) AS positive_price_rows,

    COUNT(*) FILTER (
        WHERE unit_price = 0
    ) AS zero_price_rows,

    COUNT(*) FILTER (
        WHERE unit_price < 0
    ) AS negative_price_rows

FROM online_retail;


-- ============================================================
-- QUERY 10: INVOICE CANCELLATION PREFIX ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN UPPER(TRIM(invoice_no)) LIKE 'C%'
            THEN 'Cancellation Prefix'
        ELSE 'Other Invoice'
    END AS invoice_type,

    COUNT(*) AS transaction_rows,

    COUNT(DISTINCT invoice_no) AS unique_invoices,

    SUM(quantity) AS total_quantity,

    ROUND(
        SUM(quantity * unit_price), 2
    ) AS signed_line_amount

FROM online_retail

GROUP BY 1
ORDER BY transaction_rows DESC;


-- ============================================================
-- QUERY 11: TRANSACTION QUALITY CLASSIFICATION
-- ============================================================

SELECT
    CASE
        WHEN invoice_no IS NULL
          OR TRIM(invoice_no) = ''
          OR stock_code IS NULL
          OR TRIM(stock_code) = ''
          OR country IS NULL
          OR TRIM(country) = ''
            THEN 'Missing Essential Fields'

        WHEN quantity < 0
          OR UPPER(TRIM(invoice_no)) LIKE 'C%'
            THEN 'Return or Cancellation'

        WHEN quantity = 0
            THEN 'Zero Quantity'

        WHEN unit_price < 0
            THEN 'Negative Price'

        WHEN unit_price = 0
            THEN 'Zero Price'

        WHEN customer_id IS NULL
            THEN 'Valid Sale - Unknown Customer'

        ELSE 'Valid Sale - Known Customer'

    END AS transaction_class,

    COUNT(*) AS row_count,

    COUNT(DISTINCT invoice_no) AS unique_invoices,

    ROUND(
        SUM(quantity * unit_price), 2
    ) AS signed_line_amount

FROM online_retail

GROUP BY 1
ORDER BY row_count DESC;


-- ============================================================
-- QUERY 12: COUNTRY-LEVEL DATA DISTRIBUTION
-- ============================================================

SELECT
    country,

    COUNT(*) AS transaction_rows,

    COUNT(DISTINCT invoice_no) AS unique_invoices,

    COUNT(DISTINCT customer_id) AS unique_customers

FROM online_retail

GROUP BY country
ORDER BY transaction_rows DESC;


-- ============================================================
-- QUERY 13: TOP 20 PRODUCT CODES BY ROW FREQUENCY
-- ============================================================

SELECT
    stock_code,

    COUNT(*) AS transaction_rows,

    COUNT(DISTINCT invoice_no) AS unique_invoices,

    SUM(quantity) AS signed_quantity

FROM online_retail

GROUP BY stock_code
ORDER BY transaction_rows DESC
LIMIT 20;


-- ============================================================
-- QUERY 14: INVOICE IDENTIFIER INTEGRITY
-- ============================================================

WITH invoice_checks AS (
    SELECT
        invoice_no,

        COUNT(*) AS line_count,

        COUNT(DISTINCT customer_id)
            AS distinct_customers,

        COUNT(DISTINCT country)
            AS distinct_countries,

        COUNT(DISTINCT invoice_date)
            AS distinct_timestamps

    FROM online_retail
    GROUP BY invoice_no
)

SELECT
    COUNT(*) AS total_invoice_ids,

    COUNT(*) FILTER (
        WHERE line_count > 1
    ) AS multi_line_invoices,

    COUNT(*) FILTER (
        WHERE distinct_customers > 1
    ) AS multi_customer_invoices,

    COUNT(*) FILTER (
        WHERE distinct_countries > 1
    ) AS multi_country_invoices,

    COUNT(*) FILTER (
        WHERE distinct_timestamps > 1
    ) AS multi_timestamp_invoices,

    MAX(line_count) AS max_lines_per_invoice

FROM invoice_checks;


-- ============================================================
-- QUERY 15: REVENUE ELIGIBILITY AND QUALITY SUMMARY
-- ============================================================

WITH classified AS (
    SELECT
        *,

        quantity * unit_price AS line_amount,

        quantity > 0
          AND unit_price > 0
          AND invoice_no IS NOT NULL
          AND TRIM(invoice_no) <> ''
          AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
          AND stock_code IS NOT NULL
          AND TRIM(stock_code) <> ''
          AND country IS NOT NULL
          AND TRIM(country) <> ''
          AS is_positive_sale

    FROM online_retail
)

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE is_positive_sale
    ) AS positive_sale_rows,

    COUNT(DISTINCT invoice_no) FILTER (
        WHERE is_positive_sale
    ) AS positive_sale_invoices,

    COUNT(DISTINCT customer_id) FILTER (
        WHERE is_positive_sale
    ) AS known_customers_in_sales,

    ROUND(
        SUM(line_amount) FILTER (
            WHERE is_positive_sale
        ), 2
    ) AS gross_sales_amount,

    COUNT(*) FILTER (
        WHERE NOT is_positive_sale
    ) AS excluded_rows,

    COUNT(*) FILTER (
        WHERE is_positive_sale
          AND customer_id IS NULL
    ) AS anonymous_sale_rows

FROM classified;

