
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


-- ============================================================
-- SQL PROJECT 19: SUPPLY CHAIN & INVENTORY ANALYTICS
-- DAY 2: INVENTORY & STOCK LEVEL ANALYSIS
-- ============================================================


-- ============================================================
-- QUERY 14: MONTHLY INVENTORY TRENDS
-- ============================================================

SELECT
    year_month,
    COUNT(DISTINCT product_name) AS total_products,
    ROUND(SUM(warehouse_inventory), 2) AS total_inventory_units,
    ROUND(AVG(warehouse_inventory), 2) AS avg_inventory_per_product,
    ROUND(
        SUM(warehouse_inventory * inventory_cost_per_unit),
        2
    ) AS total_inventory_value
FROM inventory
GROUP BY year_month
ORDER BY year_month;


-- ============================================================
-- QUERY 15: LATEST MONTH INVENTORY OVERVIEW
-- ============================================================

SELECT
    year_month,
    COUNT(DISTINCT product_name) AS total_products,
    ROUND(SUM(warehouse_inventory), 2) AS total_stock_units,
    ROUND(
        SUM(warehouse_inventory * inventory_cost_per_unit),
        2
    ) AS inventory_value,
    ROUND(AVG(warehouse_inventory), 2) AS avg_stock_per_product
FROM inventory
WHERE year_month = (
    SELECT MAX(year_month)
    FROM inventory
)
GROUP BY year_month;


-- ============================================================
-- QUERY 16: TOP 10 PRODUCTS BY INVENTORY LEVEL
-- ============================================================

SELECT
    product_name,
    year_month,
    warehouse_inventory,
    inventory_cost_per_unit,
    ROUND(
        warehouse_inventory * inventory_cost_per_unit,
        2
    ) AS inventory_value
FROM inventory
WHERE year_month = (
    SELECT MAX(year_month)
    FROM inventory
)
ORDER BY warehouse_inventory DESC
LIMIT 10;


-- ============================================================
-- QUERY 17: BOTTOM 10 PRODUCTS BY INVENTORY LEVEL
-- ============================================================

SELECT
    product_name,
    year_month,
    warehouse_inventory,
    inventory_cost_per_unit,
    ROUND(
        warehouse_inventory * inventory_cost_per_unit,
        2
    ) AS inventory_value
FROM inventory
WHERE year_month = (
    SELECT MAX(year_month)
    FROM inventory
)
ORDER BY warehouse_inventory ASC
LIMIT 10;


-- ============================================================
-- QUERY 18: INVENTORY VALUATION BY PRODUCT
-- ============================================================

SELECT
    product_name,
    warehouse_inventory AS stock_units,
    inventory_cost_per_unit,
    ROUND(
        warehouse_inventory * inventory_cost_per_unit,
        2
    ) AS inventory_value
FROM inventory
WHERE year_month = (
    SELECT MAX(year_month)
    FROM inventory
)
ORDER BY inventory_value DESC
LIMIT 15;


-- ============================================================
-- QUERY 19: MONTHLY PRODUCT DEMAND
-- ============================================================

SELECT
    order_year_month AS year_month,
    product_name,
    SUM(order_quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales
FROM orders_shipments
GROUP BY
    order_year_month,
    product_name
ORDER BY
    year_month,
    total_units_sold DESC;


-- ============================================================
-- QUERY 20: TOP 15 PRODUCTS BY TOTAL UNITS SOLD
-- ============================================================

SELECT
    product_name,
    SUM(order_quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(SUM(profit), 2) AS reported_profit
FROM orders_shipments
GROUP BY product_name
ORDER BY total_units_sold DESC
LIMIT 15;


-- ============================================================
-- QUERY 21: PRODUCT INVENTORY VS MONTHLY DEMAND
-- Latest inventory compared with average monthly sales
-- across the 36-month reporting period.
-- ============================================================

WITH monthly_demand AS (
    SELECT
        product_name,
        order_year_month,
        SUM(order_quantity) AS monthly_units_sold
    FROM orders_shipments
    GROUP BY
        product_name,
        order_year_month
),
product_demand AS (
    SELECT
        product_name,
        ROUND(
            SUM(monthly_units_sold) / 36.0,
            2
        ) AS avg_monthly_demand
    FROM monthly_demand
    GROUP BY product_name
),
latest_inventory AS (
    SELECT
        product_name,
        warehouse_inventory AS stock_units
    FROM inventory
    WHERE year_month = (
        SELECT MAX(year_month)
        FROM inventory
    )
)
SELECT
    i.product_name,
    i.stock_units,
    COALESCE(d.avg_monthly_demand, 0) AS avg_monthly_demand,
    ROUND(
        i.stock_units /
        NULLIF(d.avg_monthly_demand, 0),
        2
    ) AS months_of_stock_coverage
FROM latest_inventory i
LEFT JOIN product_demand d
    ON i.product_name = d.product_name
ORDER BY months_of_stock_coverage ASC NULLS LAST;


-- ============================================================
-- QUERY 22: POTENTIAL STOCKOUT RISK CLASSIFICATION
-- Risk thresholds are analytical assumptions:
-- Critical: < 1 month
-- High: 1 to < 2 months
-- Moderate: 2 to < 3 months
-- Low: >= 3 months
-- No Demand: no matching sales recorded
-- ============================================================

WITH product_demand AS (
    SELECT
        product_name,
        SUM(order_quantity) / 36.0 AS avg_monthly_demand
    FROM orders_shipments
    GROUP BY product_name
),
latest_inventory AS (
    SELECT
        product_name,
        warehouse_inventory AS stock_units
    FROM inventory
    WHERE year_month = (
        SELECT MAX(year_month)
        FROM inventory
    )
),
stock_analysis AS (
    SELECT
        i.product_name,
        i.stock_units,
        COALESCE(d.avg_monthly_demand, 0) AS avg_monthly_demand,
        i.stock_units /
            NULLIF(d.avg_monthly_demand, 0)
            AS months_of_stock_coverage
    FROM latest_inventory i
    LEFT JOIN product_demand d
        ON i.product_name = d.product_name
)
SELECT
    product_name,
    ROUND(stock_units, 2) AS stock_units,
    ROUND(avg_monthly_demand, 2) AS avg_monthly_demand,
    ROUND(months_of_stock_coverage, 2)
        AS months_of_stock_coverage,
    CASE
        WHEN avg_monthly_demand = 0
            THEN 'No Recorded Demand'
        WHEN months_of_stock_coverage < 1
            THEN 'Critical Risk'
        WHEN months_of_stock_coverage < 2
            THEN 'High Risk'
        WHEN months_of_stock_coverage < 3
            THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS stockout_risk
FROM stock_analysis
ORDER BY
    CASE
        WHEN avg_monthly_demand = 0 THEN 5
        WHEN months_of_stock_coverage < 1 THEN 1
        WHEN months_of_stock_coverage < 2 THEN 2
        WHEN months_of_stock_coverage < 3 THEN 3
        ELSE 4
    END,
    months_of_stock_coverage ASC NULLS LAST;


-- ============================================================
-- QUERY 23: INVENTORY RISK SUMMARY
-- ============================================================

WITH product_demand AS (
    SELECT
        product_name,
        SUM(order_quantity) / 36.0 AS avg_monthly_demand
    FROM orders_shipments
    GROUP BY product_name
),
latest_inventory AS (
    SELECT
        product_name,
        warehouse_inventory AS stock_units
    FROM inventory
    WHERE year_month = (
        SELECT MAX(year_month)
        FROM inventory
    )
),
coverage AS (
    SELECT
        i.product_name,
        i.stock_units,
        COALESCE(d.avg_monthly_demand, 0) AS avg_monthly_demand,
        i.stock_units /
            NULLIF(d.avg_monthly_demand, 0)
            AS months_of_coverage
    FROM latest_inventory i
    LEFT JOIN product_demand d
        ON i.product_name = d.product_name
),
risk_segments AS (
    SELECT
        *,
        CASE
            WHEN avg_monthly_demand = 0
                THEN 'No Recorded Demand'
            WHEN months_of_coverage < 1
                THEN 'Critical Risk'
            WHEN months_of_coverage < 2
                THEN 'High Risk'
            WHEN months_of_coverage < 3
                THEN 'Moderate Risk'
            ELSE 'Low Risk'
        END AS risk_segment
    FROM coverage
)
SELECT
    risk_segment,
    COUNT(*) AS total_products,
    ROUND(SUM(stock_units), 2) AS total_stock_units,
    ROUND(AVG(months_of_coverage), 2)
        AS avg_months_of_coverage
FROM risk_segments
GROUP BY risk_segment
ORDER BY
    CASE risk_segment
        WHEN 'Critical Risk' THEN 1
        WHEN 'High Risk' THEN 2
        WHEN 'Moderate Risk' THEN 3
        WHEN 'Low Risk' THEN 4
        ELSE 5
    END;


-- ============================================================
-- QUERY 24: INVENTORY LEVEL VS FULFILLMENT TIME
-- ============================================================

WITH latest_inventory AS (
    SELECT
        product_name,
        warehouse_inventory AS stock_units
    FROM inventory
    WHERE year_month = (
        SELECT MAX(year_month)
        FROM inventory
    )
)
SELECT
    i.product_name,
    i.stock_units,
    f.fulfillment_days,
    CASE
        WHEN f.fulfillment_days > 7
            THEN 'Slow Fulfillment'
        WHEN f.fulfillment_days > 4
            THEN 'Moderate Fulfillment'
        ELSE 'Fast Fulfillment'
    END AS fulfillment_category
FROM latest_inventory i
LEFT JOIN fulfillment f
    ON i.product_name = f.product_name
ORDER BY
    f.fulfillment_days DESC NULLS LAST,
    i.stock_units ASC;


-- ============================================================
-- QUERY 25: INVENTORY MONTH-OVER-MONTH CHANGES
-- ============================================================

WITH monthly_inventory AS (
    SELECT
        year_month,
        SUM(warehouse_inventory) AS total_inventory_units
    FROM inventory
    GROUP BY year_month
),
inventory_trends AS (
    SELECT
        year_month,
        total_inventory_units,
        LAG(total_inventory_units) OVER (
            ORDER BY year_month
        ) AS previous_month_inventory
    FROM monthly_inventory
)
SELECT
    year_month,
    ROUND(total_inventory_units, 2)
        AS total_inventory_units,
    ROUND(previous_month_inventory, 2)
        AS previous_month_inventory,
    ROUND(
        total_inventory_units - previous_month_inventory,
        2
    ) AS inventory_change,
    ROUND(
        100.0 * (
            total_inventory_units - previous_month_inventory
        ) / NULLIF(previous_month_inventory, 0),
        2
    ) AS inventory_change_pct
FROM inventory_trends
ORDER BY year_month;


-- ============================================================
-- QUERY 26: PRODUCT MATCHING VALIDATION
-- Check whether product names match across datasets.
-- ============================================================

WITH product_lists AS (
    SELECT
        product_name,
        1 AS in_inventory,
        0 AS in_orders,
        0 AS in_fulfillment
    FROM (
        SELECT DISTINCT product_name
        FROM inventory
    )

    UNION ALL

    SELECT
        product_name,
        0,
        1,
        0
    FROM (
        SELECT DISTINCT product_name
        FROM orders_shipments
    )

    UNION ALL

    SELECT
        product_name,
        0,
        0,
        1
    FROM (
        SELECT DISTINCT product_name
        FROM fulfillment
    )
),
product_coverage AS (
    SELECT
        product_name,
        MAX(in_inventory) AS in_inventory,
        MAX(in_orders) AS in_orders,
        MAX(in_fulfillment) AS in_fulfillment
    FROM product_lists
    GROUP BY product_name
)
SELECT
    COUNT(*) AS total_distinct_products,
    SUM(in_inventory) AS inventory_products,
    SUM(in_orders) AS order_products,
    SUM(in_fulfillment) AS fulfillment_products,
    COUNT(*) FILTER (
        WHERE in_inventory = 1
          AND in_orders = 1
          AND in_fulfillment = 1
    ) AS products_in_all_three,
    COUNT(*) FILTER (
        WHERE in_inventory = 1
          AND in_orders = 0
    ) AS inventory_products_without_orders,
    COUNT(*) FILTER (
        WHERE in_orders = 1
          AND in_inventory = 0
    ) AS order_products_without_inventory
FROM product_coverage;


-- ============================================================
-- SQL PROJECT 19: SUPPLY CHAIN & INVENTORY ANALYTICS
-- DAY 3: WAREHOUSE, SHIPPING & LOGISTICS PERFORMANCE
-- QUERIES 27-40
-- ============================================================


-- QUERY 27: WAREHOUSE COUNTRY PERFORMANCE

SELECT
    warehouse_country,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(order_quantity) AS total_units_shipped,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit) /
        NULLIF(SUM(gross_sales), 0), 2
    ) AS profit_margin_pct
FROM orders_shipments
GROUP BY warehouse_country
ORDER BY total_orders DESC;


-- QUERY 28: SHIPPING MODE DISTRIBUTION

SELECT
    shipment_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(order_quantity) AS total_units,
    ROUND(SUM(gross_sales), 2) AS total_gross_sales,
    ROUND(
        100.0 * COUNT(*) /
        NULLIF(
            (SELECT COUNT(*) FROM orders_shipments), 0
        ), 2
    ) AS shipment_item_share_pct
FROM orders_shipments
GROUP BY shipment_mode
ORDER BY total_order_items DESC;


-- QUERY 29: SCHEDULED SHIPPING DAYS BY MODE

SELECT
    shipment_mode,
    COUNT(*) AS total_order_items,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days,
    MIN(scheduled_shipping_days)
        AS min_scheduled_days,
    MAX(scheduled_shipping_days)
        AS max_scheduled_days,
    ROUND(STDDEV_SAMP(scheduled_shipping_days), 2)
        AS stddev_scheduled_days
FROM orders_shipments
GROUP BY shipment_mode
ORDER BY avg_scheduled_days DESC;


-- QUERY 30: SHIPPING MODE BY CUSTOMER MARKET

SELECT
    customer_market,
    shipment_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(order_quantity) AS total_units,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days,
    ROUND(SUM(gross_sales), 2) AS gross_sales
FROM orders_shipments
GROUP BY customer_market, shipment_mode
ORDER BY customer_market, total_order_items DESC;


-- QUERY 31: TOP 15 CUSTOMER REGIONS BY ORDER VOLUME

SELECT
    customer_market,
    customer_region,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(order_quantity) AS total_units,
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders_shipments
GROUP BY customer_market, customer_region
ORDER BY total_orders DESC
LIMIT 15;


-- QUERY 32: WAREHOUSE COUNTRY VS CUSTOMER MARKET

SELECT
    warehouse_country,
    customer_market,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days
FROM orders_shipments
GROUP BY warehouse_country, customer_market
ORDER BY total_orders DESC;


-- QUERY 33: WAREHOUSE COUNTRY VS SHIPPING MODE

SELECT
    warehouse_country,
    shipment_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days,
    ROUND(SUM(gross_sales), 2) AS gross_sales
FROM orders_shipments
GROUP BY warehouse_country, shipment_mode
ORDER BY warehouse_country, total_order_items DESC;


-- QUERY 34: TOP 15 PRODUCTS BY FULFILLMENT TIME

SELECT
    product_name,
    fulfillment_days,
    CASE
        WHEN fulfillment_days > 7
            THEN 'Slow Fulfillment'
        WHEN fulfillment_days > 4
            THEN 'Moderate Fulfillment'
        ELSE 'Fast Fulfillment'
    END AS fulfillment_category
FROM fulfillment
ORDER BY fulfillment_days DESC
LIMIT 15;


-- QUERY 35: FULFILLMENT PERFORMANCE CATEGORIES

SELECT
    CASE
        WHEN fulfillment_days > 7
            THEN 'Slow Fulfillment'
        WHEN fulfillment_days > 4
            THEN 'Moderate Fulfillment'
        ELSE 'Fast Fulfillment'
    END AS fulfillment_category,
    COUNT(*) AS total_products,
    ROUND(AVG(fulfillment_days), 2)
        AS avg_fulfillment_days,
    ROUND(MIN(fulfillment_days), 2)
        AS min_fulfillment_days,
    ROUND(MAX(fulfillment_days), 2)
        AS max_fulfillment_days
FROM fulfillment
GROUP BY fulfillment_category
ORDER BY avg_fulfillment_days DESC;


-- QUERY 36: MONTHLY SHIPPING ACTIVITY

SELECT
    order_year_month AS year_month,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(order_quantity) AS total_units,
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days
FROM orders_shipments
GROUP BY order_year_month
ORDER BY year_month;


-- QUERY 37: SHIPPING MODE PROFITABILITY

SELECT
    shipment_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(gross_sales), 2) AS gross_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        100.0 * SUM(profit) /
        NULLIF(SUM(gross_sales), 0), 2
    ) AS profit_margin_pct,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days
FROM orders_shipments
GROUP BY shipment_mode
ORDER BY total_profit DESC;


-- QUERY 38: LONG SCHEDULED SHIPPING SEGMENTS

SELECT
    shipment_mode,
    customer_market,
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(scheduled_shipping_days), 2)
        AS avg_scheduled_days,
    COUNT(*) FILTER (
        WHERE scheduled_shipping_days > 5
    ) AS items_scheduled_over_5_days,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE scheduled_shipping_days > 5
        ) / NULLIF(COUNT(*), 0), 2
    ) AS pct_items_scheduled_over_5_days
FROM orders_shipments
GROUP BY shipment_mode, customer_market
ORDER BY pct_items_scheduled_over_5_days DESC,
         total_order_items DESC;


-- QUERY 39: PRODUCT DEMAND VS FULFILLMENT TIME

WITH product_sales AS (
    SELECT
        product_name,
        SUM(order_quantity) AS total_units_sold,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(SUM(gross_sales), 2) AS gross_sales
    FROM orders_shipments
    GROUP BY product_name
)
SELECT
    p.product_name,
    p.total_units_sold,
    p.total_orders,
    p.gross_sales,
    f.fulfillment_days,
    CASE
        WHEN f.fulfillment_days > 7
            THEN 'Slow Fulfillment'
        WHEN f.fulfillment_days > 4
            THEN 'Moderate Fulfillment'
        ELSE 'Fast Fulfillment'
    END AS fulfillment_category
FROM product_sales p
LEFT JOIN fulfillment f
    ON p.product_name = f.product_name
ORDER BY p.total_units_sold DESC
LIMIT 20;


-- QUERY 40: LOGISTICS DATA QUALITY VALIDATION

SELECT
    COUNT(*) AS total_order_items,

    COUNT(*) FILTER (
        WHERE shipment_mode IS NULL
           OR shipment_mode = ''
    ) AS missing_shipment_modes,

    COUNT(*) FILTER (
        WHERE warehouse_country IS NULL
           OR warehouse_country = ''
    ) AS missing_warehouse_countries,

    COUNT(*) FILTER (
        WHERE scheduled_shipping_days IS NULL
    ) AS missing_scheduled_days,

    COUNT(*) FILTER (
        WHERE scheduled_shipping_days < 0
    ) AS negative_scheduled_days,

    COUNT(*) FILTER (
        WHERE shipment_year IS NULL
           OR shipment_month IS NULL
           OR shipment_day IS NULL
    ) AS missing_shipment_date_parts,

    COUNT(*) FILTER (
        WHERE TRY_CAST(
            CAST(shipment_year AS VARCHAR) || '-' ||
            LPAD(CAST(shipment_month AS VARCHAR), 2, '0') || '-' ||
            LPAD(CAST(shipment_day AS VARCHAR), 2, '0')
            AS DATE
        ) IS NULL
    ) AS invalid_shipment_dates

FROM orders_shipments;


