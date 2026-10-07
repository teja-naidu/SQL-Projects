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

-- ============================================================
-- DAY 2: RETURNS & PERFORMANCE ANALYSIS
-- ============================================================


-- ============================================================
-- Query 11: S&P 500 Yearly Performance
-- Purpose:
-- Calculate the first price, last price, and percentage return
-- of the S&P 500 for each year.
-- ============================================================

WITH yearly_prices AS (
    SELECT
        YEAR(Date) AS year,

        ARG_MIN(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE),
            Date
        ) AS start_price,

        ARG_MAX(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE),
            Date
        ) AS end_price

    FROM stock_market
    GROUP BY YEAR(Date)
)

SELECT
    year,
    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS return_percentage

FROM yearly_prices
ORDER BY year;


-- ============================================================
-- Query 12: Nasdaq 100 Yearly Performance
-- Purpose:
-- Calculate annual Nasdaq 100 performance using the first
-- and last available prices for each year.
-- ============================================================

WITH yearly_prices AS (
    SELECT
        YEAR(Date) AS year,

        ARG_MIN(
            CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE),
            Date
        ) AS start_price,

        ARG_MAX(
            CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE),
            Date
        ) AS end_price

    FROM stock_market
    GROUP BY YEAR(Date)
)

SELECT
    year,
    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS return_percentage

FROM yearly_prices
ORDER BY year;


-- ============================================================
-- Query 13: Overall Technology Stock Performance
-- Purpose:
-- Compare total returns of major technology stocks from the
-- first available trading date to the last available date.
-- ============================================================

WITH performance AS (

    SELECT
        'Apple' AS asset,
        ARG_MIN(Apple_Price, Date) AS start_price,
        ARG_MAX(Apple_Price, Date) AS end_price
    FROM stock_market

    UNION ALL

    SELECT
        'Microsoft',
        ARG_MIN(Microsoft_Price, Date),
        ARG_MAX(Microsoft_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Tesla',
        ARG_MIN(Tesla_Price, Date),
        ARG_MAX(Tesla_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Google',
        ARG_MIN(Google_Price, Date),
        ARG_MAX(Google_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Nvidia',
        ARG_MIN(Nvidia_Price, Date),
        ARG_MAX(Nvidia_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Amazon',
        ARG_MIN(Amazon_Price, Date),
        ARG_MAX(Amazon_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Meta',
        ARG_MIN(Meta_Price, Date),
        ARG_MAX(Meta_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Netflix',
        ARG_MIN(Netflix_Price, Date),
        ARG_MAX(Netflix_Price, Date)
    FROM stock_market
)

SELECT
    asset,
    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS total_return_percentage

FROM performance
ORDER BY total_return_percentage DESC;


-- ============================================================
-- Query 14: Technology Stock Performance Ranking
-- Purpose:
-- Rank technology stocks from best to worst based on their
-- total return during the dataset period.
-- ============================================================

WITH performance AS (

    SELECT
        'Apple' AS asset,
        ARG_MIN(Apple_Price, Date) AS start_price,
        ARG_MAX(Apple_Price, Date) AS end_price
    FROM stock_market

    UNION ALL

    SELECT 'Microsoft',
        ARG_MIN(Microsoft_Price, Date),
        ARG_MAX(Microsoft_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Tesla',
        ARG_MIN(Tesla_Price, Date),
        ARG_MAX(Tesla_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Google',
        ARG_MIN(Google_Price, Date),
        ARG_MAX(Google_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Nvidia',
        ARG_MIN(Nvidia_Price, Date),
        ARG_MAX(Nvidia_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Amazon',
        ARG_MIN(Amazon_Price, Date),
        ARG_MAX(Amazon_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Meta',
        ARG_MIN(Meta_Price, Date),
        ARG_MAX(Meta_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT 'Netflix',
        ARG_MIN(Netflix_Price, Date),
        ARG_MAX(Netflix_Price, Date)
    FROM stock_market
),

returns AS (
    SELECT
        asset,
        ((end_price - start_price) / start_price) * 100
            AS total_return_percentage
    FROM performance
)

SELECT
    RANK() OVER (
        ORDER BY total_return_percentage DESC
    ) AS performance_rank,

    asset,

    ROUND(
        total_return_percentage,
        2
    ) AS total_return_percentage

FROM returns
ORDER BY performance_rank;


-- ============================================================
-- Query 15: Technology Stock Yearly Returns
-- Purpose:
-- Compare annual performance across major technology stocks.
-- ============================================================

WITH yearly_prices AS (

    SELECT
        YEAR(Date) AS year,

        ARG_MIN(Apple_Price, Date) AS apple_start,
        ARG_MAX(Apple_Price, Date) AS apple_end,

        ARG_MIN(Microsoft_Price, Date) AS microsoft_start,
        ARG_MAX(Microsoft_Price, Date) AS microsoft_end,

        ARG_MIN(Tesla_Price, Date) AS tesla_start,
        ARG_MAX(Tesla_Price, Date) AS tesla_end,

        ARG_MIN(Google_Price, Date) AS google_start,
        ARG_MAX(Google_Price, Date) AS google_end,

        ARG_MIN(Nvidia_Price, Date) AS nvidia_start,
        ARG_MAX(Nvidia_Price, Date) AS nvidia_end,

        ARG_MIN(Amazon_Price, Date) AS amazon_start,
        ARG_MAX(Amazon_Price, Date) AS amazon_end,

        ARG_MIN(Meta_Price, Date) AS meta_start,
        ARG_MAX(Meta_Price, Date) AS meta_end,

        ARG_MIN(Netflix_Price, Date) AS netflix_start,
        ARG_MAX(Netflix_Price, Date) AS netflix_end

    FROM stock_market
    GROUP BY YEAR(Date)
)

SELECT
    year,

    ROUND(
        ((apple_end - apple_start) / apple_start) * 100,
        2
    ) AS apple_return,

    ROUND(
        ((microsoft_end - microsoft_start) / microsoft_start) * 100,
        2
    ) AS microsoft_return,

    ROUND(
        ((tesla_end - tesla_start) / tesla_start) * 100,
        2
    ) AS tesla_return,

    ROUND(
        ((google_end - google_start) / google_start) * 100,
        2
    ) AS google_return,

    ROUND(
        ((nvidia_end - nvidia_start) / nvidia_start) * 100,
        2
    ) AS nvidia_return,

    ROUND(
        ((amazon_end - amazon_start) / amazon_start) * 100,
        2
    ) AS amazon_return,

    ROUND(
        ((meta_end - meta_start) / meta_start) * 100,
        2
    ) AS meta_return,

    ROUND(
        ((netflix_end - netflix_start) / netflix_start) * 100,
        2
    ) AS netflix_return

FROM yearly_prices
ORDER BY year;


-- ============================================================
-- Query 16: Commodity Overall Performance
-- Purpose:
-- Compare total returns across major commodities.
-- ============================================================

WITH performance AS (

    SELECT
        'Gold' AS asset,

        ARG_MIN(
            CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE),
            Date
        ) AS start_price,

        ARG_MAX(
            CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE),
            Date
        ) AS end_price

    FROM stock_market

    UNION ALL

    SELECT
        'Silver',
        ARG_MIN(Silver_Price, Date),
        ARG_MAX(Silver_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Crude Oil',
        ARG_MIN(Crude_oil_Price, Date),
        ARG_MAX(Crude_oil_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Natural Gas',
        ARG_MIN(Natural_Gas_Price, Date),
        ARG_MAX(Natural_Gas_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Copper',
        ARG_MIN(Copper_Price, Date),
        ARG_MAX(Copper_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Platinum',

        ARG_MIN(
            CAST(REPLACE(Platinum_Price, ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE(Platinum_Price, ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market
)

SELECT
    asset,
    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS total_return_percentage

FROM performance
ORDER BY total_return_percentage DESC;


-- ============================================================
-- Query 17: Cryptocurrency Overall Performance
-- Purpose:
-- Compare Bitcoin and Ethereum returns over the complete
-- dataset period.
-- ============================================================

WITH performance AS (

    SELECT
        'Bitcoin' AS asset,

        ARG_MIN(
            CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE),
            Date
        ) AS start_price,

        ARG_MAX(
            CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE),
            Date
        ) AS end_price

    FROM stock_market

    UNION ALL

    SELECT
        'Ethereum',

        ARG_MIN(
            CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market
)

SELECT
    asset,
    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS total_return_percentage

FROM performance
ORDER BY total_return_percentage DESC;


-- ============================================================
-- Query 18: Cross-Asset Performance Comparison
-- Purpose:
-- Compare representative assets across equities,
-- commodities, cryptocurrencies, and market indices.
-- ============================================================

WITH performance AS (

    SELECT
        'S&P 500' AS asset,
        'Market Index' AS asset_class,

        ARG_MIN(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE),
            Date
        ) AS start_price,

        ARG_MAX(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE),
            Date
        ) AS end_price

    FROM stock_market

    UNION ALL

    SELECT
        'Nasdaq 100',
        'Market Index',

        ARG_MIN(
            CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market

    UNION ALL

    SELECT
        'Apple',
        'Stock',
        ARG_MIN(Apple_Price, Date),
        ARG_MAX(Apple_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Nvidia',
        'Stock',
        ARG_MIN(Nvidia_Price, Date),
        ARG_MAX(Nvidia_Price, Date)
    FROM stock_market

    UNION ALL

    SELECT
        'Gold',
        'Commodity',

        ARG_MIN(
            CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market

    UNION ALL

    SELECT
        'Bitcoin',
        'Cryptocurrency',

        ARG_MIN(
            CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market

    UNION ALL

    SELECT
        'Ethereum',
        'Cryptocurrency',

        ARG_MIN(
            CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE),
            Date
        ),

        ARG_MAX(
            CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE),
            Date
        )

    FROM stock_market
)

SELECT
    asset,
    asset_class,

    ROUND(start_price, 2) AS start_price,
    ROUND(end_price, 2) AS end_price,

    ROUND(
        ((end_price - start_price) / start_price) * 100,
        2
    ) AS total_return_percentage

FROM performance
ORDER BY total_return_percentage DESC;


-- ============================================================
-- Query 19: Largest S&P 500 Daily Movements
-- Purpose:
-- Identify the largest positive and negative daily percentage
-- movements in the S&P 500.
-- ============================================================

WITH daily_prices AS (

    SELECT
        Date,

        CAST(
            REPLACE("S&P_500_Price", ',', '')
            AS DOUBLE
        ) AS price,

        LAG(
            CAST(
                REPLACE("S&P_500_Price", ',', '')
                AS DOUBLE
            )
        ) OVER (
            ORDER BY Date
        ) AS previous_price

    FROM stock_market
),

daily_returns AS (

    SELECT
        Date,
        price,

        ((price - previous_price) / previous_price) * 100
            AS daily_return_percentage

    FROM daily_prices
    WHERE previous_price IS NOT NULL
),

ranked_returns AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            ORDER BY daily_return_percentage DESC
        ) AS positive_rank,

        ROW_NUMBER() OVER (
            ORDER BY daily_return_percentage ASC
        ) AS negative_rank

    FROM daily_returns
)

SELECT
    Date,
    ROUND(price, 2) AS closing_price,

    ROUND(
        daily_return_percentage,
        2
    ) AS daily_return_percentage,

    CASE
        WHEN positive_rank <= 5 THEN 'Top Positive Day'
        WHEN negative_rank <= 5 THEN 'Top Negative Day'
    END AS movement_type

FROM ranked_returns

WHERE positive_rank <= 5
   OR negative_rank <= 5

ORDER BY daily_return_percentage DESC;


-- ============================================================
-- Query 20: Largest Nasdaq 100 Daily Movements
-- Purpose:
-- Identify the largest positive and negative daily percentage
-- movements in the Nasdaq 100.
-- ============================================================

WITH daily_prices AS (

    SELECT
        Date,

        CAST(
            REPLACE("Nasdaq_100_Price", ',', '')
            AS DOUBLE
        ) AS price,

        LAG(
            CAST(
                REPLACE("Nasdaq_100_Price", ',', '')
                AS DOUBLE
            )
        ) OVER (
            ORDER BY Date
        ) AS previous_price

    FROM stock_market
),

daily_returns AS (

    SELECT
        Date,
        price,

        ((price - previous_price) / previous_price) * 100
            AS daily_return_percentage

    FROM daily_prices
    WHERE previous_price IS NOT NULL
),

ranked_returns AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            ORDER BY daily_return_percentage DESC
        ) AS positive_rank,

        ROW_NUMBER() OVER (
            ORDER BY daily_return_percentage ASC
        ) AS negative_rank

    FROM daily_returns
)

SELECT
    Date,
    ROUND(price, 2) AS closing_price,

    ROUND(
        daily_return_percentage,
        2
    ) AS daily_return_percentage,

    CASE
        WHEN positive_rank <= 5 THEN 'Top Positive Day'
        WHEN negative_rank <= 5 THEN 'Top Negative Day'
    END AS movement_type

FROM ranked_returns

WHERE positive_rank <= 5
   OR negative_rank <= 5

ORDER BY daily_return_percentage DESC;

-- ============================================================
-- DAY 3: RISK, VOLATILITY & DRAWDOWN ANALYSIS
-- ============================================================


-- ============================================================
-- Query 21: S&P 500 Annualized Volatility
-- Purpose:
-- Measure annualized volatility using the standard deviation
-- of daily percentage returns.
-- ============================================================

WITH prices AS (
    SELECT
        Date,
        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE) AS price,
        LAG(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
        ) OVER (ORDER BY Date) AS previous_price
    FROM stock_market
),

returns AS (
    SELECT
        Date,
        ((price - previous_price) / previous_price) AS daily_return
    FROM prices
    WHERE previous_price IS NOT NULL
)

SELECT
    ROUND(
        STDDEV_SAMP(daily_return) * SQRT(252) * 100,
        2
    ) AS annualized_volatility_percentage
FROM returns;


-- ============================================================
-- Query 22: S&P 500 vs Nasdaq 100 Annualized Volatility
-- Purpose:
-- Compare risk levels of the two major market indices.
-- ============================================================

WITH prices AS (
    SELECT
        Date,

        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
            AS sp500_price,

        CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)
            AS nasdaq_price,

        LAG(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
        ) OVER (ORDER BY Date) AS previous_sp500,

        LAG(
            CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)
        ) OVER (ORDER BY Date) AS previous_nasdaq

    FROM stock_market
),

returns AS (
    SELECT
        ((sp500_price - previous_sp500) / previous_sp500)
            AS sp500_return,

        ((nasdaq_price - previous_nasdaq) / previous_nasdaq)
            AS nasdaq_return

    FROM prices
    WHERE previous_sp500 IS NOT NULL
)

SELECT
    ROUND(
        STDDEV_SAMP(sp500_return) * SQRT(252) * 100,
        2
    ) AS sp500_annualized_volatility,

    ROUND(
        STDDEV_SAMP(nasdaq_return) * SQRT(252) * 100,
        2
    ) AS nasdaq_annualized_volatility

FROM returns;


-- ============================================================
-- Query 23: Technology Stock Volatility Ranking
-- Purpose:
-- Compare annualized volatility across major technology stocks.
-- Higher volatility indicates larger day-to-day price movements.
-- ============================================================

WITH daily_returns AS (
    SELECT
        Date,

        (Apple_Price /
            LAG(Apple_Price) OVER (ORDER BY Date) - 1)
            AS apple_return,

        (Microsoft_Price /
            LAG(Microsoft_Price) OVER (ORDER BY Date) - 1)
            AS microsoft_return,

        (Tesla_Price /
            LAG(Tesla_Price) OVER (ORDER BY Date) - 1)
            AS tesla_return,

        (Google_Price /
            LAG(Google_Price) OVER (ORDER BY Date) - 1)
            AS google_return,

        (Nvidia_Price /
            LAG(Nvidia_Price) OVER (ORDER BY Date) - 1)
            AS nvidia_return,

        (Amazon_Price /
            LAG(Amazon_Price) OVER (ORDER BY Date) - 1)
            AS amazon_return,

        (Meta_Price /
            LAG(Meta_Price) OVER (ORDER BY Date) - 1)
            AS meta_return,

        (Netflix_Price /
            LAG(Netflix_Price) OVER (ORDER BY Date) - 1)
            AS netflix_return

    FROM stock_market
),

volatility AS (

    SELECT 'Apple' AS asset,
        STDDEV_SAMP(apple_return) * SQRT(252) * 100 AS volatility
    FROM daily_returns

    UNION ALL

    SELECT 'Microsoft',
        STDDEV_SAMP(microsoft_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Tesla',
        STDDEV_SAMP(tesla_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Google',
        STDDEV_SAMP(google_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Nvidia',
        STDDEV_SAMP(nvidia_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Amazon',
        STDDEV_SAMP(amazon_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Meta',
        STDDEV_SAMP(meta_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT 'Netflix',
        STDDEV_SAMP(netflix_return) * SQRT(252) * 100
    FROM daily_returns
)

SELECT
    RANK() OVER (
        ORDER BY volatility DESC
    ) AS volatility_rank,

    asset,

    ROUND(volatility, 2)
        AS annualized_volatility_percentage

FROM volatility
ORDER BY volatility_rank;


-- ============================================================
-- Query 24: Cryptocurrency Volatility
-- Purpose:
-- Compare Bitcoin and Ethereum annualized volatility.
-- ============================================================

WITH prices AS (
    SELECT
        Date,

        CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE)
            AS bitcoin_price,

        CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE)
            AS ethereum_price

    FROM stock_market
),

daily_returns AS (
    SELECT
        Date,

        bitcoin_price /
        LAG(bitcoin_price) OVER (ORDER BY Date) - 1
            AS bitcoin_return,

        ethereum_price /
        LAG(ethereum_price) OVER (ORDER BY Date) - 1
            AS ethereum_return

    FROM prices
)

SELECT
    ROUND(
        STDDEV_SAMP(bitcoin_return) * SQRT(252) * 100,
        2
    ) AS bitcoin_annualized_volatility,

    ROUND(
        STDDEV_SAMP(ethereum_return) * SQRT(252) * 100,
        2
    ) AS ethereum_annualized_volatility

FROM daily_returns;


-- ============================================================
-- Query 25: Cross-Asset Volatility Comparison
-- Purpose:
-- Compare annualized risk across representative market indices,
-- stocks, commodities, and cryptocurrencies.
-- ============================================================

WITH prices AS (
    SELECT
        Date,

        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
            AS sp500,

        CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE)
            AS nasdaq,

        Apple_Price AS apple,
        Nvidia_Price AS nvidia,

        CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE)
            AS gold,

        CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE)
            AS bitcoin,

        CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE)
            AS ethereum

    FROM stock_market
),

daily_returns AS (
    SELECT
        Date,

        sp500 / LAG(sp500) OVER (ORDER BY Date) - 1
            AS sp500_return,

        nasdaq / LAG(nasdaq) OVER (ORDER BY Date) - 1
            AS nasdaq_return,

        apple / LAG(apple) OVER (ORDER BY Date) - 1
            AS apple_return,

        nvidia / LAG(nvidia) OVER (ORDER BY Date) - 1
            AS nvidia_return,

        gold / LAG(gold) OVER (ORDER BY Date) - 1
            AS gold_return,

        bitcoin / LAG(bitcoin) OVER (ORDER BY Date) - 1
            AS bitcoin_return,

        ethereum / LAG(ethereum) OVER (ORDER BY Date) - 1
            AS ethereum_return

    FROM prices
),

risk AS (

    SELECT
        'S&P 500' AS asset,
        'Market Index' AS asset_class,
        STDDEV_SAMP(sp500_return) * SQRT(252) * 100 AS volatility
    FROM daily_returns

    UNION ALL

    SELECT
        'Nasdaq 100',
        'Market Index',
        STDDEV_SAMP(nasdaq_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT
        'Apple',
        'Stock',
        STDDEV_SAMP(apple_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT
        'Nvidia',
        'Stock',
        STDDEV_SAMP(nvidia_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT
        'Gold',
        'Commodity',
        STDDEV_SAMP(gold_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT
        'Bitcoin',
        'Cryptocurrency',
        STDDEV_SAMP(bitcoin_return) * SQRT(252) * 100
    FROM daily_returns

    UNION ALL

    SELECT
        'Ethereum',
        'Cryptocurrency',
        STDDEV_SAMP(ethereum_return) * SQRT(252) * 100
    FROM daily_returns
)

SELECT
    asset,
    asset_class,
    ROUND(volatility, 2)
        AS annualized_volatility_percentage
FROM risk
ORDER BY volatility DESC;


-- ============================================================
-- Query 26: S&P 500 Maximum Drawdown
-- Purpose:
-- Calculate the largest percentage decline from a previous
-- running peak in the S&P 500.
-- ============================================================

WITH prices AS (
    SELECT
        Date,
        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE) AS price
    FROM stock_market
),

running_peak AS (
    SELECT
        Date,
        price,

        MAX(price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS peak_price

    FROM prices
),

drawdowns AS (
    SELECT
        Date,
        price,
        peak_price,

        ((price - peak_price) / peak_price) * 100
            AS drawdown_percentage

    FROM running_peak
)

SELECT
    Date AS drawdown_date,
    ROUND(price, 2) AS price,
    ROUND(peak_price, 2) AS previous_peak,

    ROUND(
        drawdown_percentage,
        2
    ) AS drawdown_percentage

FROM drawdowns
ORDER BY drawdown_percentage ASC
LIMIT 1;


-- ============================================================
-- Query 27: Nasdaq 100 Maximum Drawdown
-- Purpose:
-- Calculate the largest percentage decline from a previous
-- running peak in the Nasdaq 100.
-- ============================================================

WITH prices AS (
    SELECT
        Date,
        CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE) AS price
    FROM stock_market
),

running_peak AS (
    SELECT
        Date,
        price,

        MAX(price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS peak_price

    FROM prices
),

drawdowns AS (
    SELECT
        Date,
        price,
        peak_price,

        ((price - peak_price) / peak_price) * 100
            AS drawdown_percentage

    FROM running_peak
)

SELECT
    Date AS drawdown_date,
    ROUND(price, 2) AS price,
    ROUND(peak_price, 2) AS previous_peak,

    ROUND(
        drawdown_percentage,
        2
    ) AS drawdown_percentage

FROM drawdowns
ORDER BY drawdown_percentage ASC
LIMIT 1;


-- ============================================================
-- Query 28: Technology Stock Maximum Drawdowns
-- Purpose:
-- Measure the worst peak-to-trough decline experienced by
-- each major technology stock.
-- ============================================================

WITH running_peaks AS (
    SELECT
        Date,

        Apple_Price,
        MAX(Apple_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS apple_peak,

        Microsoft_Price,
        MAX(Microsoft_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS microsoft_peak,

        Tesla_Price,
        MAX(Tesla_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS tesla_peak,

        Google_Price,
        MAX(Google_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS google_peak,

        Nvidia_Price,
        MAX(Nvidia_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS nvidia_peak,

        Amazon_Price,
        MAX(Amazon_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS amazon_peak,

        Meta_Price,
        MAX(Meta_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS meta_peak,

        Netflix_Price,
        MAX(Netflix_Price) OVER (
            ORDER BY Date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS netflix_peak

    FROM stock_market
),

drawdowns AS (

    SELECT 'Apple' AS asset,
        MIN((Apple_Price - apple_peak) / apple_peak * 100)
            AS max_drawdown
    FROM running_peaks

    UNION ALL

    SELECT 'Microsoft',
        MIN((Microsoft_Price - microsoft_peak) /
            microsoft_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Tesla',
        MIN((Tesla_Price - tesla_peak) /
            tesla_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Google',
        MIN((Google_Price - google_peak) /
            google_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Nvidia',
        MIN((Nvidia_Price - nvidia_peak) /
            nvidia_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Amazon',
        MIN((Amazon_Price - amazon_peak) /
            amazon_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Meta',
        MIN((Meta_Price - meta_peak) /
            meta_peak * 100)
    FROM running_peaks

    UNION ALL

    SELECT 'Netflix',
        MIN((Netflix_Price - netflix_peak) /
            netflix_peak * 100)
    FROM running_peaks
)

SELECT
    asset,
    ROUND(max_drawdown, 2)
        AS maximum_drawdown_percentage
FROM drawdowns
ORDER BY max_drawdown ASC;


-- ============================================================
-- Query 29: S&P 500 Positive vs Negative Trading Days
-- Purpose:
-- Understand how frequently the market moved higher or lower
-- on a daily basis.
-- ============================================================

WITH prices AS (
    SELECT
        Date,

        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
            AS price,

        LAG(
            CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE)
        ) OVER (ORDER BY Date) AS previous_price

    FROM stock_market
),

returns AS (
    SELECT
        Date,
        ((price - previous_price) / previous_price) * 100
            AS daily_return
    FROM prices
    WHERE previous_price IS NOT NULL
)

SELECT
    CASE
        WHEN daily_return > 0 THEN 'Positive Day'
        WHEN daily_return < 0 THEN 'Negative Day'
        ELSE 'No Change'
    END AS market_movement,

    COUNT(*) AS trading_days,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_days

FROM returns
GROUP BY market_movement
ORDER BY trading_days DESC;


-- ============================================================
-- Query 30: Cross-Asset Risk vs Return
-- Purpose:
-- Compare total return and annualized volatility across
-- representative assets.
--
-- Return-to-volatility ratio:
-- Total Return % / Annualized Volatility %
-- This is a simple project metric, NOT a Sharpe Ratio.
-- ============================================================

WITH prices AS (
    SELECT
        Date,

        CAST(REPLACE("S&P_500_Price", ',', '') AS DOUBLE) AS sp500,
        CAST(REPLACE("Nasdaq_100_Price", ',', '') AS DOUBLE) AS nasdaq,

        Apple_Price AS apple,
        Nvidia_Price AS nvidia,

        CAST(REPLACE(Gold_Price, ',', '') AS DOUBLE) AS gold,
        CAST(REPLACE(Bitcoin_Price, ',', '') AS DOUBLE) AS bitcoin,
        CAST(REPLACE(Ethereum_Price, ',', '') AS DOUBLE) AS ethereum

    FROM stock_market
),

daily_returns AS (
    SELECT
        Date,

        sp500,
        nasdaq,
        apple,
        nvidia,
        gold,
        bitcoin,
        ethereum,

        sp500 / LAG(sp500) OVER (ORDER BY Date) - 1
            AS sp500_return,

        nasdaq / LAG(nasdaq) OVER (ORDER BY Date) - 1
            AS nasdaq_return,

        apple / LAG(apple) OVER (ORDER BY Date) - 1
            AS apple_return,

        nvidia / LAG(nvidia) OVER (ORDER BY Date) - 1
            AS nvidia_return,

        gold / LAG(gold) OVER (ORDER BY Date) - 1
            AS gold_return,

        bitcoin / LAG(bitcoin) OVER (ORDER BY Date) - 1
            AS bitcoin_return,

        ethereum / LAG(ethereum) OVER (ORDER BY Date) - 1
            AS ethereum_return

    FROM prices
),

metrics AS (

    SELECT
        'S&P 500' AS asset,

        ((ARG_MAX(sp500, Date) - ARG_MIN(sp500, Date))
            / ARG_MIN(sp500, Date)) * 100 AS total_return,

        STDDEV_SAMP(sp500_return) * SQRT(252) * 100
            AS volatility

    FROM daily_returns

    UNION ALL

    SELECT
        'Nasdaq 100',

        ((ARG_MAX(nasdaq, Date) - ARG_MIN(nasdaq, Date))
            / ARG_MIN(nasdaq, Date)) * 100,

        STDDEV_SAMP(nasdaq_return) * SQRT(252) * 100

    FROM daily_returns

    UNION ALL

    SELECT
        'Apple',

        ((ARG_MAX(apple, Date) - ARG_MIN(apple, Date))
            / ARG_MIN(apple, Date)) * 100,

        STDDEV_SAMP(apple_return) * SQRT(252) * 100

    FROM daily_returns

    UNION ALL

    SELECT
        'Nvidia',

        ((ARG_MAX(nvidia, Date) - ARG_MIN(nvidia, Date))
            / ARG_MIN(nvidia, Date)) * 100,

        STDDEV_SAMP(nvidia_return) * SQRT(252) * 100

    FROM daily_returns

    UNION ALL

    SELECT
        'Gold',

        ((ARG_MAX(gold, Date) - ARG_MIN(gold, Date))
            / ARG_MIN(gold, Date)) * 100,

        STDDEV_SAMP(gold_return) * SQRT(252) * 100

    FROM daily_returns

    UNION ALL

    SELECT
        'Bitcoin',

        ((ARG_MAX(bitcoin, Date) - ARG_MIN(bitcoin, Date))
            / ARG_MIN(bitcoin, Date)) * 100,

        STDDEV_SAMP(bitcoin_return) * SQRT(252) * 100

    FROM daily_returns

    UNION ALL

    SELECT
        'Ethereum',

        ((ARG_MAX(ethereum, Date) - ARG_MIN(ethereum, Date))
            / ARG_MIN(ethereum, Date)) * 100,

        STDDEV_SAMP(ethereum_return) * SQRT(252) * 100

    FROM daily_returns
)

SELECT
    asset,

    ROUND(total_return, 2)
        AS total_return_percentage,

    ROUND(volatility, 2)
        AS annualized_volatility_percentage,

    ROUND(
        total_return / volatility,
        2
    ) AS return_to_volatility_ratio

FROM metrics
ORDER BY return_to_volatility_ratio DESC;