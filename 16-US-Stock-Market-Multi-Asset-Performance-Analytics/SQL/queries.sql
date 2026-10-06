-- ============================================================
-- PROJECT 16: US STOCK MARKET & MULTI-ASSET PERFORMANCE ANALYTICS
-- Dataset Period: 2019–2024
-- DAY 1: DATA EXPLORATION & QUALITY CHECKS
-- ============================================================


-- ============================================================
-- Query 1: Dataset Overview
-- Purpose:
-- Understand the total number of records and the time period
-- covered by the dataset.
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM stock_market;


-- ============================================================
-- Query 2: Trading Days by Year
-- Purpose:
-- Understand how many records/trading days are available
-- for each year in the dataset.
-- ============================================================

SELECT
    YEAR(Date) AS year,
    COUNT(*) AS trading_days
FROM stock_market
GROUP BY YEAR(Date)
ORDER BY year;


-- ============================================================
-- Query 3: Duplicate Date Check
-- Purpose:
-- Identify whether the dataset contains duplicate dates.
-- Ideally, each trading date should appear only once.
-- ============================================================

SELECT
    Date,
    COUNT(*) AS record_count
FROM stock_market
GROUP BY Date
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


-- ============================================================
-- Query 4: Missing Values in Major Price Columns
-- Purpose:
-- Check data completeness across the major market,
-- stock, commodity, and cryptocurrency price columns.
-- ============================================================

SELECT
    SUM(CASE WHEN "S&P_500_Price" IS NULL THEN 1 ELSE 0 END)
        AS sp500_missing,

    SUM(CASE WHEN "Nasdaq_100_Price" IS NULL THEN 1 ELSE 0 END)
        AS nasdaq_missing,

    SUM(CASE WHEN Apple_Price IS NULL THEN 1 ELSE 0 END)
        AS apple_missing,

    SUM(CASE WHEN Tesla_Price IS NULL THEN 1 ELSE 0 END)
        AS tesla_missing,

    SUM(CASE WHEN Microsoft_Price IS NULL THEN 1 ELSE 0 END)
        AS microsoft_missing,

    SUM(CASE WHEN Google_Price IS NULL THEN 1 ELSE 0 END)
        AS google_missing,

    SUM(CASE WHEN Nvidia_Price IS NULL THEN 1 ELSE 0 END)
        AS nvidia_missing,

    SUM(CASE WHEN Amazon_Price IS NULL THEN 1 ELSE 0 END)
        AS amazon_missing,

    SUM(CASE WHEN Meta_Price IS NULL THEN 1 ELSE 0 END)
        AS meta_missing,

    SUM(CASE WHEN Netflix_Price IS NULL THEN 1 ELSE 0 END)
        AS netflix_missing,

    SUM(CASE WHEN Bitcoin_Price IS NULL THEN 1 ELSE 0 END)
        AS bitcoin_missing,

    SUM(CASE WHEN Ethereum_Price IS NULL THEN 1 ELSE 0 END)
        AS ethereum_missing,

    SUM(CASE WHEN Gold_Price IS NULL THEN 1 ELSE 0 END)
        AS gold_missing,

    SUM(CASE WHEN Crude_oil_Price IS NULL THEN 1 ELSE 0 END)
        AS crude_oil_missing

FROM stock_market;


-- ============================================================
-- Query 5: Missing Values in Volume Columns
-- Purpose:
-- Identify missing trading-volume observations for the
-- major assets in the dataset.
-- ============================================================

SELECT
    SUM(CASE WHEN "Nasdaq_100_Vol." IS NULL THEN 1 ELSE 0 END)
        AS nasdaq_vol_missing,

    SUM(CASE WHEN "Apple_Vol." IS NULL THEN 1 ELSE 0 END)
        AS apple_vol_missing,

    SUM(CASE WHEN "Tesla_Vol." IS NULL THEN 1 ELSE 0 END)
        AS tesla_vol_missing,

    SUM(CASE WHEN "Microsoft_Vol." IS NULL THEN 1 ELSE 0 END)
        AS microsoft_vol_missing,

    SUM(CASE WHEN "Google_Vol." IS NULL THEN 1 ELSE 0 END)
        AS google_vol_missing,

    SUM(CASE WHEN "Nvidia_Vol." IS NULL THEN 1 ELSE 0 END)
        AS nvidia_vol_missing,

    SUM(CASE WHEN "Amazon_Vol." IS NULL THEN 1 ELSE 0 END)
        AS amazon_vol_missing,

    SUM(CASE WHEN "Meta_Vol." IS NULL THEN 1 ELSE 0 END)
        AS meta_vol_missing,

    SUM(CASE WHEN "Bitcoin_Vol." IS NULL THEN 1 ELSE 0 END)
        AS bitcoin_vol_missing,

    SUM(CASE WHEN "Ethereum_Vol." IS NULL THEN 1 ELSE 0 END)
        AS ethereum_vol_missing,

    SUM(CASE WHEN "Gold_Vol." IS NULL THEN 1 ELSE 0 END)
        AS gold_vol_missing,

    SUM(CASE WHEN "Platinum_Vol." IS NULL THEN 1 ELSE 0 END)
        AS platinum_vol_missing

FROM stock_market;


-- ============================================================
-- Query 6: S&P 500 Price Summary
-- Purpose:
-- Get a high-level view of the S&P 500 price range and
-- average level during the dataset period.
--
-- REPLACE removes commas before converting the value to DOUBLE.
-- ============================================================

SELECT
    ROUND(
        MIN(CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)),
        2
    ) AS minimum_price,

    ROUND(
        MAX(CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)),
        2
    ) AS maximum_price,

    ROUND(
        AVG(CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)),
        2
    ) AS average_price

FROM stock_market;


-- ============================================================
-- Query 7: Nasdaq 100 Price Summary
-- Purpose:
-- Understand the minimum, maximum, and average Nasdaq 100
-- levels during the analysis period.
-- ============================================================

SELECT
    ROUND(
        MIN(CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)),
        2
    ) AS minimum_price,

    ROUND(
        MAX(CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)),
        2
    ) AS maximum_price,

    ROUND(
        AVG(CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)),
        2
    ) AS average_price

FROM stock_market;


-- ============================================================
-- Query 8: Major Technology Stock Price Summary
-- Purpose:
-- Compare the average, minimum, and maximum prices of major
-- technology stocks included in the dataset.
-- ============================================================

SELECT
    'Apple' AS asset,
    ROUND(AVG(Apple_Price), 2) AS average_price,
    ROUND(MIN(Apple_Price), 2) AS minimum_price,
    ROUND(MAX(Apple_Price), 2) AS maximum_price
FROM stock_market

UNION ALL

SELECT
    'Microsoft',
    ROUND(AVG(Microsoft_Price), 2),
    ROUND(MIN(Microsoft_Price), 2),
    ROUND(MAX(Microsoft_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Tesla',
    ROUND(AVG(Tesla_Price), 2),
    ROUND(MIN(Tesla_Price), 2),
    ROUND(MAX(Tesla_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Google',
    ROUND(AVG(Google_Price), 2),
    ROUND(MIN(Google_Price), 2),
    ROUND(MAX(Google_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Nvidia',
    ROUND(AVG(Nvidia_Price), 2),
    ROUND(MIN(Nvidia_Price), 2),
    ROUND(MAX(Nvidia_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Amazon',
    ROUND(AVG(Amazon_Price), 2),
    ROUND(MIN(Amazon_Price), 2),
    ROUND(MAX(Amazon_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Meta',
    ROUND(AVG(Meta_Price), 2),
    ROUND(MIN(Meta_Price), 2),
    ROUND(MAX(Meta_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Netflix',
    ROUND(AVG(Netflix_Price), 2),
    ROUND(MIN(Netflix_Price), 2),
    ROUND(MAX(Netflix_Price), 2)
FROM stock_market

ORDER BY asset;


-- ============================================================
-- Query 9: Commodity Price Summary
-- Purpose:
-- Compare the average, minimum, and maximum prices of
-- commodities available in the dataset.
-- ============================================================

SELECT
    'Gold' AS asset,
    ROUND(
        AVG(CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE)),
        2
    ) AS average_price,
    ROUND(
        MIN(CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE)),
        2
    ) AS minimum_price,
    ROUND(
        MAX(CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE)),
        2
    ) AS maximum_price
FROM stock_market

UNION ALL

SELECT
    'Silver',
    ROUND(AVG(Silver_Price), 2),
    ROUND(MIN(Silver_Price), 2),
    ROUND(MAX(Silver_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Crude Oil',
    ROUND(AVG(Crude_oil_Price), 2),
    ROUND(MIN(Crude_oil_Price), 2),
    ROUND(MAX(Crude_oil_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Natural Gas',
    ROUND(AVG(Natural_Gas_Price), 2),
    ROUND(MIN(Natural_Gas_Price), 2),
    ROUND(MAX(Natural_Gas_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Copper',
    ROUND(AVG(Copper_Price), 2),
    ROUND(MIN(Copper_Price), 2),
    ROUND(MAX(Copper_Price), 2)
FROM stock_market

UNION ALL

SELECT
    'Platinum',
    ROUND(
        AVG(CAST(REPLACE(Platinum_Price, ',', '') AS DOUBLE)),
        2
    ),
    ROUND(
        MIN(CAST(REPLACE(Platinum_Price, ',', '') AS DOUBLE)),
        2
    ),
    ROUND(
        MAX(CAST(REPLACE(Platinum_Price, ',', '') AS DOUBLE)),
        2
    )
FROM stock_market

ORDER BY asset;


-- ============================================================
-- Query 10: Cryptocurrency Price Summary
-- Purpose:
-- Compare Bitcoin and Ethereum price ranges during
-- the dataset period.
-- ============================================================

SELECT
    'Bitcoin' AS asset,

    ROUND(
        AVG(CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE)),
        2
    ) AS average_price,

    ROUND(
        MIN(CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE)),
        2
    ) AS minimum_price,

    ROUND(
        MAX(CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE)),
        2
    ) AS maximum_price

FROM stock_market

UNION ALL

SELECT
    'Ethereum',

    ROUND(
        AVG(CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE)),
        2
    ),

    ROUND(
        MIN(CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE)),
        2
    ),

    ROUND(
        MAX(CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE)),
        2
    )

FROM stock_market

ORDER BY asset;