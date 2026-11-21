
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


-- ============================================================
-- PROJECT 21: RETAIL SALES & CUSTOMER SEGMENTATION
-- DAY 2: SALES PERFORMANCE & REVENUE TRENDS
-- DATABASE: DUCKDB
-- QUERIES: 16-30
-- ============================================================


-- ============================================================
-- QUERY 16: OVERALL GROSS SALES PERFORMANCE
-- ============================================================

WITH valid_sales AS (
    SELECT
        invoice_no,
        customer_id,
        quantity,
        quantity * unit_price AS sales_amount
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
)
SELECT
    COUNT(*) AS sale_lines,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT customer_id) AS known_customers,
    SUM(quantity) AS total_units,
    ROUND(SUM(sales_amount), 2) AS gross_sales,
    ROUND(
        SUM(sales_amount) /
        NULLIF(COUNT(DISTINCT invoice_no), 0), 2
    ) AS avg_invoice_value,
    ROUND(
        SUM(quantity) * 1.0 /
        NULLIF(COUNT(DISTINCT invoice_no), 0), 2
    ) AS avg_units_per_invoice
FROM valid_sales;


-- ============================================================
-- QUERY 17: MONTHLY GROSS SALES PERFORMANCE
-- ============================================================

SELECT
    DATE_TRUNC('month', invoice_date)::DATE
        AS sales_month,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT customer_id) AS known_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY 1
ORDER BY sales_month;


-- ============================================================
-- QUERY 18: MONTH-OVER-MONTH SALES GROWTH
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::DATE
            AS sales_month,
        SUM(quantity * unit_price) AS gross_sales
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
    GROUP BY 1
),
growth AS (
    SELECT
        sales_month,
        gross_sales,
        LAG(gross_sales) OVER (
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(gross_sales, 2) AS gross_sales,
    ROUND(previous_month_sales, 2)
        AS previous_month_sales,
    ROUND(
        100.0 * (gross_sales - previous_month_sales) /
        NULLIF(previous_month_sales, 0), 2
    ) AS mom_growth_pct
FROM growth
ORDER BY sales_month;


-- ============================================================
-- QUERY 19: TOP 15 SALES DAYS
-- ============================================================

SELECT
    invoice_date::DATE AS sales_date,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY 1
ORDER BY gross_sales DESC
LIMIT 15;


-- ============================================================
-- QUERY 20: SALES PERFORMANCE BY DAY OF WEEK
-- ============================================================

SELECT
    DAYOFWEEK(invoice_date) AS weekday_number,
    DAYNAME(invoice_date) AS weekday_name,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT invoice_date::DATE)
        AS active_days,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales,
    ROUND(
        SUM(quantity * unit_price) /
        NULLIF(
            COUNT(DISTINCT invoice_date::DATE), 0
        ), 2
    ) AS avg_sales_per_active_day
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY 1, 2
ORDER BY weekday_number;


-- ============================================================
-- QUERY 21: HOURLY SALES PERFORMANCE
-- ============================================================

SELECT
    EXTRACT(HOUR FROM invoice_date) AS sales_hour,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY 1
ORDER BY sales_hour;


-- ============================================================
-- QUERY 22: COUNTRY-LEVEL GROSS SALES
-- ============================================================

SELECT
    country,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT customer_id) AS known_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales,
    ROUND(
        SUM(quantity * unit_price) /
        NULLIF(COUNT(DISTINCT invoice_no), 0), 2
    ) AS avg_invoice_value
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY country
ORDER BY gross_sales DESC;


-- ============================================================
-- QUERY 23: UK VS INTERNATIONAL SALES
-- ============================================================

WITH regional_sales AS (
    SELECT
        CASE
            WHEN country = 'United Kingdom'
                THEN 'United Kingdom'
            ELSE 'International'
        END AS sales_region,
        invoice_no,
        customer_id,
        quantity,
        quantity * unit_price AS sales_amount
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
)
SELECT
    sales_region,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT customer_id) AS known_customers,
    ROUND(SUM(sales_amount), 2) AS gross_sales,
    ROUND(
        100.0 * SUM(sales_amount) /
        SUM(SUM(sales_amount)) OVER (), 2
    ) AS revenue_share_pct
FROM regional_sales
GROUP BY sales_region
ORDER BY gross_sales DESC;


-- ============================================================
-- QUERY 24: AVERAGE ORDER VALUE BY MONTH
-- ============================================================

WITH invoice_sales AS (
    SELECT
        invoice_no,
        MIN(invoice_date)::DATE AS invoice_date,
        SUM(quantity * unit_price) AS invoice_value
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
    GROUP BY invoice_no
)
SELECT
    DATE_TRUNC('month', invoice_date)::DATE
        AS sales_month,
    COUNT(*) AS total_invoices,
    ROUND(AVG(invoice_value), 2)
        AS avg_order_value,
    ROUND(MEDIAN(invoice_value), 2)
        AS median_order_value,
    ROUND(MAX(invoice_value), 2)
        AS highest_invoice_value
FROM invoice_sales
GROUP BY 1
ORDER BY sales_month;


-- ============================================================
-- QUERY 25: GROSS SALES VS SIGNED TRANSACTION VALUE
-- ============================================================

WITH classified AS (
    SELECT
        quantity,
        unit_price,
        invoice_no,
        CASE
            WHEN quantity > 0
             AND unit_price > 0
             AND invoice_no IS NOT NULL
             AND TRIM(invoice_no) <> ''
             AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
             AND stock_code IS NOT NULL
             AND TRIM(stock_code) <> ''
             AND country IS NOT NULL
             AND TRIM(country) <> ''
                THEN 'Positive Sale'

            WHEN quantity < 0
              OR UPPER(TRIM(invoice_no)) LIKE 'C%'
                THEN 'Return or Cancellation'

            ELSE 'Other Adjustment'
        END AS transaction_type
    FROM online_retail
)
SELECT
    transaction_type,
    COUNT(*) AS transaction_rows,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    ROUND(SUM(quantity * unit_price), 2)
        AS signed_amount
FROM classified
GROUP BY transaction_type
ORDER BY transaction_rows DESC;


-- ============================================================
-- QUERY 26: MONTHLY CANCELLATION IMPACT
-- ============================================================

WITH monthly_transactions AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::DATE
            AS sales_month,
        SUM(
            CASE
                WHEN quantity > 0
                 AND unit_price > 0
                 AND invoice_no IS NOT NULL
                 AND TRIM(invoice_no) <> ''
                 AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
                 AND stock_code IS NOT NULL
                 AND TRIM(stock_code) <> ''
                 AND country IS NOT NULL
                 AND TRIM(country) <> ''
                THEN quantity * unit_price
                ELSE 0
            END
        ) AS gross_sales,
        SUM(
            CASE
                WHEN quantity < 0
                  OR UPPER(TRIM(invoice_no)) LIKE 'C%'
                THEN quantity * unit_price
                ELSE 0
            END
        ) AS return_signed_amount
    FROM online_retail
    GROUP BY 1
)
SELECT
    sales_month,
    ROUND(gross_sales, 2) AS gross_sales,
    ROUND(return_signed_amount, 2)
        AS return_signed_amount,
    ROUND(
        gross_sales + return_signed_amount, 2
    ) AS return_adjusted_sales,
    ROUND(
        100.0 * ABS(return_signed_amount) /
        NULLIF(gross_sales, 0), 2
    ) AS return_impact_pct
FROM monthly_transactions
ORDER BY sales_month;


-- ============================================================
-- QUERY 27: TOP 20 HIGHEST VALUE INVOICES
-- ============================================================

SELECT
    invoice_no,
    MIN(invoice_date) AS first_invoice_timestamp,
    COUNT(*) AS invoice_lines,
    SUM(quantity) AS total_units,
    ROUND(SUM(quantity * unit_price), 2)
        AS invoice_value
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY invoice_no
ORDER BY invoice_value DESC
LIMIT 20;


-- ============================================================
-- QUERY 28: TOP 20 STOCK CODES BY GROSS SALES
-- ============================================================

SELECT
    stock_code,
    MAX(description) AS sample_description,
    COUNT(DISTINCT invoice_no) AS total_invoices,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
GROUP BY stock_code
ORDER BY gross_sales DESC
LIMIT 20;


-- ============================================================
-- QUERY 29: CUSTOMER SALES CONCENTRATION
-- ============================================================

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS gross_sales
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        gross_sales,
        ROW_NUMBER() OVER (
            ORDER BY gross_sales DESC, customer_id
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_sales
)
SELECT
    CASE
        WHEN customer_rank <=
             CEIL(total_customers * 0.01)
            THEN 'Top 1%'
        WHEN customer_rank <=
             CEIL(total_customers * 0.05)
            THEN 'Next 4%'
        WHEN customer_rank <=
             CEIL(total_customers * 0.20)
            THEN 'Next 15%'
        ELSE 'Remaining 80%'
    END AS customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(gross_sales), 2)
        AS segment_sales,
    ROUND(
        100.0 * SUM(gross_sales) /
        SUM(SUM(gross_sales)) OVER (), 2
    ) AS sales_share_pct
FROM ranked_customers
GROUP BY customer_segment
ORDER BY segment_sales DESC;


-- ============================================================
-- QUERY 30: MONTHLY SALES KPI SUMMARY
-- ============================================================

WITH valid_sales AS (
    SELECT
        DATE_TRUNC('month', invoice_date)::DATE
            AS sales_month,
        invoice_no,
        customer_id,
        quantity,
        quantity * unit_price AS sales_amount
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
)
SELECT
    sales_month,
    COUNT(*) AS sale_lines,
    COUNT(DISTINCT invoice_no) AS invoices,
    COUNT(DISTINCT customer_id) AS known_customers,
    SUM(quantity) AS units_sold,
    ROUND(SUM(sales_amount), 2)
        AS gross_sales,
    ROUND(
        SUM(sales_amount) /
        NULLIF(COUNT(DISTINCT invoice_no), 0), 2
    ) AS avg_invoice_value,
    ROUND(
        SUM(quantity) * 1.0 /
        NULLIF(COUNT(DISTINCT invoice_no), 0), 2
    ) AS avg_units_per_invoice
FROM valid_sales
GROUP BY sales_month
ORDER BY sales_month;


-- ============================================================
-- PROJECT 21: RETAIL SALES & CUSTOMER SEGMENTATION
-- DAY 3: CUSTOMER SEGMENTATION & RFM ANALYTICS
-- QUERIES 31-45
-- DATABASE: DUCKDB
-- ============================================================


-- ============================================================
-- QUERY 31: CUSTOMER PURCHASE SUMMARY
-- ============================================================

WITH customer_sales AS (
    SELECT
        customer_id,
        invoice_no,
        invoice_date,
        quantity,
        quantity * unit_price AS sales_amount
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
)
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT invoice_no) AS known_customer_invoices,
    ROUND(SUM(sales_amount), 2) AS known_customer_sales,
    ROUND(
        SUM(sales_amount) /
        NULLIF(COUNT(DISTINCT customer_id), 0), 2
    ) AS avg_sales_per_customer,
    ROUND(
        COUNT(DISTINCT invoice_no) * 1.0 /
        NULLIF(COUNT(DISTINCT customer_id), 0), 2
    ) AS avg_invoices_per_customer
FROM customer_sales;


-- ============================================================
-- QUERY 32: REPEAT PURCHASE RATE
-- ============================================================

WITH customer_frequency AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS purchase_frequency
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE purchase_frequency = 1
    ) AS one_time_customers,
    COUNT(*) FILTER (
        WHERE purchase_frequency >= 2
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE purchase_frequency >= 2
        ) / NULLIF(COUNT(*), 0), 2
    ) AS repeat_customer_pct
FROM customer_frequency;


-- ============================================================
-- QUERY 33: CUSTOMER PURCHASE FREQUENCY DISTRIBUTION
-- ============================================================

WITH customer_frequency AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS purchase_frequency
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN purchase_frequency = 1 THEN '1 Invoice'
        WHEN purchase_frequency = 2 THEN '2 Invoices'
        WHEN purchase_frequency BETWEEN 3 AND 5
            THEN '3-5 Invoices'
        WHEN purchase_frequency BETWEEN 6 AND 10
            THEN '6-10 Invoices'
        ELSE '11+ Invoices'
    END AS frequency_group,
    COUNT(*) AS customers,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2
    ) AS customer_share_pct
FROM customer_frequency
GROUP BY 1
ORDER BY
    CASE frequency_group
        WHEN '1 Invoice' THEN 1
        WHEN '2 Invoices' THEN 2
        WHEN '3-5 Invoices' THEN 3
        WHEN '6-10 Invoices' THEN 4
        ELSE 5
    END;


-- ============================================================
-- QUERY 34: CUSTOMER RECENCY DISTRIBUTION
-- ============================================================

WITH customer_recency AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            MAX(invoice_date)::DATE,
            DATE '2011-12-10'
        ) AS recency_days
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN recency_days <= 30 THEN '0-30 Days'
        WHEN recency_days <= 60 THEN '31-60 Days'
        WHEN recency_days <= 90 THEN '61-90 Days'
        WHEN recency_days <= 180 THEN '91-180 Days'
        ELSE '181+ Days'
    END AS recency_group,
    COUNT(*) AS customers,
    ROUND(AVG(recency_days), 2) AS avg_recency_days,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2
    ) AS customer_share_pct
FROM customer_recency
GROUP BY 1
ORDER BY MIN(recency_days);


-- ============================================================
-- QUERY 35: CUSTOMER MONETARY VALUE DISTRIBUTION
-- ============================================================

WITH customer_monetary AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS monetary_value
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN monetary_value < 100 THEN 'Below 100'
        WHEN monetary_value < 500 THEN '100-499'
        WHEN monetary_value < 1000 THEN '500-999'
        WHEN monetary_value < 5000 THEN '1000-4999'
        ELSE '5000+'
    END AS monetary_group,
    COUNT(*) AS customers,
    ROUND(SUM(monetary_value), 2) AS total_sales,
    ROUND(AVG(monetary_value), 2) AS avg_customer_sales
FROM customer_monetary
GROUP BY 1
ORDER BY MIN(monetary_value);


-- ============================================================
-- QUERY 36: CUSTOMER TENURE AND PURCHASE ACTIVITY
-- ============================================================

WITH customer_activity AS (
    SELECT
        customer_id,
        MIN(invoice_date)::DATE AS first_purchase_date,
        MAX(invoice_date)::DATE AS last_purchase_date,
        COUNT(DISTINCT invoice_no) AS purchase_frequency,
        SUM(quantity * unit_price) AS monetary_value
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN DATE_DIFF(
            'day', first_purchase_date, last_purchase_date
        ) = 0 THEN 'Same Day'
        WHEN DATE_DIFF(
            'day', first_purchase_date, last_purchase_date
        ) <= 30 THEN '1-30 Days'
        WHEN DATE_DIFF(
            'day', first_purchase_date, last_purchase_date
        ) <= 90 THEN '31-90 Days'
        WHEN DATE_DIFF(
            'day', first_purchase_date, last_purchase_date
        ) <= 180 THEN '91-180 Days'
        ELSE '181+ Days'
    END AS observed_tenure_group,
    COUNT(*) AS customers,
    ROUND(AVG(purchase_frequency), 2)
        AS avg_purchase_frequency,
    ROUND(SUM(monetary_value), 2) AS gross_sales
FROM customer_activity
GROUP BY 1
ORDER BY MIN(
    DATE_DIFF(
        'day', first_purchase_date, last_purchase_date
    )
);


-- ============================================================
-- QUERY 37: CUSTOMER RFM SCORES
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            MAX(invoice_date)::DATE,
            DATE '2011-12-10'
        ) AS recency_days,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),
rfm_scores AS (
    SELECT
        *,
        NTILE(5) OVER (
            ORDER BY recency_days DESC, customer_id
        ) AS r_score,
        NTILE(5) OVER (
            ORDER BY frequency ASC, customer_id
        ) AS f_score,
        NTILE(5) OVER (
            ORDER BY monetary ASC, customer_id
        ) AS m_score
    FROM customer_metrics
)
SELECT
    customer_id,
    recency_days,
    frequency,
    ROUND(monetary, 2) AS monetary,
    r_score,
    f_score,
    m_score,
    r_score + f_score + m_score AS rfm_total_score
FROM rfm_scores
ORDER BY rfm_total_score DESC, monetary DESC
LIMIT 30;


-- ============================================================
-- QUERY 38: CUSTOMER RFM SEGMENTATION
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            MAX(invoice_date)::DATE,
            DATE '2011-12-10'
        ) AS recency_days,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),
rfm AS (
    SELECT
        *,
        NTILE(5) OVER (
            ORDER BY recency_days DESC, customer_id
        ) AS r_score,
        NTILE(5) OVER (
            ORDER BY frequency ASC, customer_id
        ) AS f_score,
        NTILE(5) OVER (
            ORDER BY monetary ASC, customer_id
        ) AS m_score
    FROM customer_metrics
),
segments AS (
    SELECT
        *,
        CASE
            WHEN r_score >= 4
             AND f_score >= 4
             AND m_score >= 4
                THEN 'Champions'
            WHEN r_score >= 3
             AND f_score >= 4
                THEN 'Loyal Customers'
            WHEN r_score >= 4
             AND f_score <= 2
                THEN 'Recent Low-Frequency'
            WHEN r_score <= 2
             AND f_score >= 3
                THEN 'At Risk'
            WHEN r_score <= 2
             AND f_score <= 2
                THEN 'Hibernating'
            ELSE 'Potential Loyalists'
        END AS customer_segment
    FROM rfm
)
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(AVG(recency_days), 2) AS avg_recency_days,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary,
    ROUND(SUM(monetary), 2) AS total_gross_sales
FROM segments
GROUP BY customer_segment
ORDER BY total_gross_sales DESC;


-- ============================================================
-- QUERY 39: RFM SEGMENT SALES CONTRIBUTION
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            MAX(invoice_date)::DATE,
            DATE '2011-12-10'
        ) AS recency_days,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),
rfm AS (
    SELECT
        *,
        NTILE(5) OVER (
            ORDER BY recency_days DESC, customer_id
        ) AS r_score,
        NTILE(5) OVER (
            ORDER BY frequency ASC, customer_id
        ) AS f_score,
        NTILE(5) OVER (
            ORDER BY monetary ASC, customer_id
        ) AS m_score
    FROM customer_metrics
),
segments AS (
    SELECT
        *,
        CASE
            WHEN r_score >= 4
             AND f_score >= 4
             AND m_score >= 4
                THEN 'Champions'
            WHEN r_score >= 3
             AND f_score >= 4
                THEN 'Loyal Customers'
            WHEN r_score >= 4
             AND f_score <= 2
                THEN 'Recent Low-Frequency'
            WHEN r_score <= 2
             AND f_score >= 3
                THEN 'At Risk'
            WHEN r_score <= 2
             AND f_score <= 2
                THEN 'Hibernating'
            ELSE 'Potential Loyalists'
        END AS customer_segment
    FROM rfm
)
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(monetary), 2) AS gross_sales,
    ROUND(
        100.0 * SUM(monetary) /
        SUM(SUM(monetary)) OVER (), 2
    ) AS sales_share_pct,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2
    ) AS customer_share_pct
FROM segments
GROUP BY customer_segment
ORDER BY gross_sales DESC;


-- ============================================================
-- QUERY 40: TOP 20 HIGH-VALUE CUSTOMERS
-- ============================================================

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS purchase_frequency,
    MIN(invoice_date)::DATE AS first_purchase_date,
    MAX(invoice_date)::DATE AS last_purchase_date,
    DATE_DIFF(
        'day',
        MAX(invoice_date)::DATE,
        DATE '2011-12-10'
    ) AS recency_days,
    ROUND(SUM(quantity * unit_price), 2)
        AS gross_sales
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
  AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY gross_sales DESC
LIMIT 20;


-- ============================================================
-- QUERY 41: HIGH-VALUE CUSTOMERS AT RISK
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            MAX(invoice_date)::DATE,
            DATE '2011-12-10'
        ) AS recency_days,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    customer_id,
    recency_days,
    frequency,
    ROUND(monetary, 2) AS gross_sales
FROM customer_metrics
WHERE recency_days > 90
  AND monetary >= 5000
ORDER BY monetary DESC
LIMIT 30;


-- ============================================================
-- QUERY 42: ONE-TIME VS REPEAT CUSTOMER SALES
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN frequency = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(SUM(monetary), 2) AS gross_sales,
    ROUND(AVG(monetary), 2) AS avg_customer_sales,
    ROUND(
        100.0 * SUM(monetary) /
        SUM(SUM(monetary)) OVER (), 2
    ) AS sales_share_pct
FROM customer_metrics
GROUP BY 1
ORDER BY gross_sales DESC;


-- ============================================================
-- QUERY 43: CUSTOMER PURCHASE GAP ANALYSIS
-- ============================================================

WITH invoice_dates AS (
    SELECT
        customer_id,
        invoice_no,
        MIN(invoice_date) AS invoice_timestamp
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id, invoice_no
),
ordered_purchases AS (
    SELECT
        customer_id,
        invoice_no,
        invoice_timestamp,
        LAG(invoice_timestamp) OVER (
            PARTITION BY customer_id
            ORDER BY invoice_timestamp, invoice_no
        ) AS previous_invoice_timestamp
    FROM invoice_dates
),
purchase_gaps AS (
    SELECT
        customer_id,
        DATE_DIFF(
            'day',
            previous_invoice_timestamp,
            invoice_timestamp
        ) AS gap_days
    FROM ordered_purchases
    WHERE previous_invoice_timestamp IS NOT NULL
)
SELECT
    COUNT(*) AS repeat_purchase_intervals,
    COUNT(DISTINCT customer_id)
        AS customers_with_intervals,
    ROUND(AVG(gap_days), 2)
        AS avg_gap_days,
    ROUND(MEDIAN(gap_days), 2)
        AS median_gap_days,
    MIN(gap_days) AS min_gap_days,
    MAX(gap_days) AS max_gap_days
FROM purchase_gaps;


-- ============================================================
-- QUERY 44: CUSTOMER BEHAVIOR BY COUNTRY
-- ============================================================

WITH customer_country_sales AS (
    SELECT
        country,
        customer_id,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY country, customer_id
)
SELECT
    country,
    COUNT(*) AS known_customers,
    COUNT(*) FILTER (
        WHERE frequency >= 2
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE frequency >= 2
        ) / NULLIF(COUNT(*), 0), 2
    ) AS repeat_customer_pct,
    ROUND(SUM(monetary), 2) AS gross_sales,
    ROUND(AVG(monetary), 2) AS avg_customer_sales
FROM customer_country_sales
GROUP BY country
ORDER BY gross_sales DESC
LIMIT 20;


-- ============================================================
-- QUERY 45: FINAL CUSTOMER SEGMENTATION KPI SUMMARY
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        MIN(invoice_date)::DATE AS first_purchase_date,
        MAX(invoice_date)::DATE AS last_purchase_date,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(quantity * unit_price) AS monetary
    FROM online_retail
    WHERE quantity > 0
      AND unit_price > 0
      AND invoice_no IS NOT NULL
      AND TRIM(invoice_no) <> ''
      AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
      AND stock_code IS NOT NULL
      AND TRIM(stock_code) <> ''
      AND country IS NOT NULL
      AND TRIM(country) <> ''
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE frequency = 1
    ) AS one_time_customers,
    COUNT(*) FILTER (
        WHERE frequency >= 2
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE frequency >= 2
        ) / NULLIF(COUNT(*), 0), 2
    ) AS repeat_customer_pct,
    ROUND(AVG(frequency), 2)
        AS avg_purchase_frequency,
    ROUND(AVG(monetary), 2)
        AS avg_customer_sales,
    ROUND(MEDIAN(monetary), 2)
        AS median_customer_sales,
    ROUND(SUM(monetary), 2)
        AS total_known_customer_sales,
    ROUND(AVG(
        DATE_DIFF(
            'day',
            last_purchase_date,
            DATE '2011-12-10'
        )
    ), 2) AS avg_recency_days
FROM customer_metrics;
