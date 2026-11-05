
-- ============================================================
-- SQL PROJECT 19: SUPPLY CHAIN & INVENTORY ANALYTICS
-- DAY 1: DATA EXPLORATION & QUALITY ANALYSIS
-- DATABASE: DuckDB
-- DATASETS:
--   1. fulfillment.csv
--   2. inventory.csv
--   3. orders_and_shipments.csv
-- ============================================================


-- ============================================================
-- SECTION 1: DATASET IMPORT
-- ============================================================

-- Query 1: Import Fulfillment Dataset

CREATE OR REPLACE TABLE fulfillment AS
SELECT
    TRIM("Product Name") AS product_name,
    TRY_CAST(
        "Warehouse Order Fulfillment (days)" AS DOUBLE
    ) AS fulfillment_days
FROM read_csv_auto(
    'data/fulfillment.csv',
    all_varchar = true
);


-- Query 2: Import Inventory Dataset

CREATE OR REPLACE TABLE inventory AS
SELECT
    TRIM("Product Name") AS product_name,
    TRY_CAST("Year Month" AS INTEGER) AS year_month,
    TRY_CAST("Warehouse Inventory" AS DOUBLE)
        AS warehouse_inventory,
    TRY_CAST("Inventory Cost Per Unit" AS DOUBLE)
        AS inventory_cost_per_unit
FROM read_csv_auto(
    'data/inventory.csv',
    all_varchar = true
);

-- Query 3: Import Orders and Shipments

CREATE OR REPLACE TABLE orders_shipments AS
SELECT
    TRY_CAST("Order ID" AS BIGINT) AS order_id,
    TRY_CAST("Order Item ID" AS BIGINT) AS order_item_id,
    TRY_CAST("Order YearMonth" AS INTEGER) AS order_year_month,
    TRY_CAST("Order Year" AS INTEGER) AS order_year,
    TRY_CAST("Order Month" AS INTEGER) AS order_month,
    TRY_CAST("Order Day" AS INTEGER) AS order_day,
    TRIM("Order Time") AS order_time,
    TRY_CAST("Order Quantity" AS INTEGER) AS order_quantity,
    TRIM("Product Department") AS product_department,
    TRIM("Product Category") AS product_category,
    TRIM("Product Name") AS product_name,
    TRY_CAST("Customer ID" AS BIGINT) AS customer_id,
    TRIM("Customer Market") AS customer_market,
    TRIM("Customer Region") AS customer_region,
    TRIM("Customer Country") AS customer_country,
    TRIM("Warehouse Country") AS warehouse_country,
    TRY_CAST("Shipment Year" AS INTEGER) AS shipment_year,
    TRY_CAST("Shipment Month" AS INTEGER) AS shipment_month,
    TRY_CAST("Shipment Day" AS INTEGER) AS shipment_day,
    TRIM("Shipment Mode") AS shipment_mode,
    TRY_CAST("Shipment Days - Scheduled" AS DOUBLE)
        AS scheduled_shipping_days,
    TRY_CAST("Gross Sales" AS DOUBLE) AS gross_sales,
    TRY_CAST("Discount %" AS DOUBLE) AS discount_pct,
    TRY_CAST("Profit" AS DOUBLE) AS profit
FROM read_csv_auto(
    'data/orders_and_shipments_utf8.csv',
    all_varchar = true,
    header = true
);


-- ============================================================
-- SECTION 2: DATA EXPLORATION
-- ============================================================

-- Query 4: Total Records in Each Dataset

SELECT
    'Fulfillment' AS dataset,
    COUNT(*) AS total_records
FROM fulfillment

UNION ALL

SELECT
    'Inventory',
    COUNT(*)
FROM inventory

UNION ALL

SELECT
    'Orders & Shipments',
    COUNT(*)
FROM orders_shipments;


-- Query 5: Dataset Structure

DESCRIBE fulfillment;

DESCRIBE inventory;

DESCRIBE orders_shipments;


-- ============================================================
-- SECTION 3: DATA QUALITY ANALYSIS
-- ============================================================

-- Query 6: Missing Values Across All Datasets

SELECT
    'Fulfillment' AS dataset,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE product_name IS NULL OR product_name = ''
    ) AS missing_products,
    COUNT(*) FILTER (
        WHERE fulfillment_days IS NULL
    ) AS missing_measurements
FROM fulfillment

UNION ALL

SELECT
    'Inventory',
    COUNT(*),
    COUNT(*) FILTER (
        WHERE product_name IS NULL OR product_name = ''
    ),
    COUNT(*) FILTER (
        WHERE warehouse_inventory IS NULL
           OR inventory_cost_per_unit IS NULL
           OR year_month IS NULL
    )
FROM inventory

UNION ALL

SELECT
    'Orders & Shipments',
    COUNT(*),
    COUNT(*) FILTER (
        WHERE product_name IS NULL OR product_name = ''
    ),
    COUNT(*) FILTER (
        WHERE order_quantity IS NULL
           OR gross_sales IS NULL
           OR profit IS NULL
    )
FROM orders_shipments;


-- Query 7: Duplicate Order Item IDs

SELECT
    order_item_id,
    COUNT(*) AS duplicate_count
FROM orders_shipments
GROUP BY order_item_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- Query 8: Duplicate Product-Month Inventory Records

SELECT
    product_name,
    year_month,
    COUNT(*) AS duplicate_count
FROM inventory
GROUP BY
    product_name,
    year_month
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================
-- SECTION 4: SALES & PROFIT PERFORMANCE
-- ============================================================

-- Query 9: Overall Business Performance KPIs

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_name) AS total_products,
    SUM(order_quantity) AS total_units_sold,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(gross_sales), 0),
        2
    ) AS profit_margin_pct
FROM orders_shipments;


-- Query 10: Top 10 Products by Gross Sales

SELECT
    product_name,
    SUM(order_quantity) AS units_sold,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders_shipments
GROUP BY product_name
ORDER BY total_gross_sales DESC
LIMIT 10;


-- Query 11: Sales Performance by Customer Market

SELECT
    customer_market,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(order_quantity) AS total_units_sold,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit)
        / NULLIF(SUM(gross_sales), 0),
        2
    ) AS profit_margin_pct
FROM orders_shipments
GROUP BY customer_market
ORDER BY total_gross_sales DESC;


-- ============================================================
-- SECTION 5: INVENTORY ANALYSIS
-- ============================================================

-- Query 12: Inventory Overview

SELECT
    COUNT(*) AS total_inventory_records,
    COUNT(DISTINCT product_name) AS unique_products,
    COUNT(DISTINCT year_month) AS total_months,
    MIN(year_month) AS first_inventory_month,
    MAX(year_month) AS last_inventory_month,
    ROUND(
        AVG(warehouse_inventory), 2
    ) AS avg_warehouse_inventory,
    ROUND(
        AVG(inventory_cost_per_unit), 2
    ) AS avg_inventory_cost_per_unit,
    ROUND(
        SUM(
            warehouse_inventory * inventory_cost_per_unit
        ), 2
    ) AS cumulative_inventory_snapshot_value
FROM inventory;


-- ============================================================
-- SECTION 6: WAREHOUSE FULFILLMENT ANALYSIS
-- ============================================================

-- Query 13: Warehouse Fulfillment Performance

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT product_name) AS unique_products,
    ROUND(
        AVG(fulfillment_days), 2
    ) AS avg_fulfillment_days,
    ROUND(
        MIN(fulfillment_days), 2
    ) AS min_fulfillment_days,
    ROUND(
        MAX(fulfillment_days), 2
    ) AS max_fulfillment_days
FROM fulfillment;


-- ============================================================
-- ADDITIONAL VALIDATION: DATASET DATE COVERAGE
-- ============================================================

SELECT
    MIN(order_year_month) AS first_order_month,
    MAX(order_year_month) AS last_order_month,
    COUNT(DISTINCT order_year_month) AS total_order_months
FROM orders_shipments;


SELECT
    MIN(year_month) AS first_inventory_month,
    MAX(year_month) AS last_inventory_month,
    COUNT(DISTINCT year_month) AS total_inventory_months
FROM inventory;

