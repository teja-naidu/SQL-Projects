
-- SQL PROJECT 18
-- REAL ESTATE HOUSING MARKET ANALYTICS
-- DAY 1: DATA EXPLORATION & QUALITY

-- Query 1: Total Housing Records
SELECT COUNT(*) AS total_properties
FROM housing;


-- Query 2: Dataset Structure
DESCRIBE housing;


-- Query 3: Preview Housing Records
SELECT *
FROM housing
LIMIT 10;


-- Query 4: Duplicate Property Records
SELECT
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(DISTINCT
        (Price, Bedrooms, Bathrooms, SquareFeet,
         YearBuilt, GarageSpaces, LotSize,
         ZipCode, CrimeRate, SchoolRating)
    ) AS duplicate_records
FROM housing;


-- Query 5: Missing Value Analysis
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE Price IS NULL)
        AS missing_price,
    COUNT(*) FILTER (WHERE Bedrooms IS NULL)
        AS missing_bedrooms,
    COUNT(*) FILTER (WHERE Bathrooms IS NULL)
        AS missing_bathrooms,
    COUNT(*) FILTER (WHERE SquareFeet IS NULL)
        AS missing_squarefeet,
    COUNT(*) FILTER (WHERE YearBuilt IS NULL)
        AS missing_yearbuilt,
    COUNT(*) FILTER (WHERE ZipCode IS NULL)
        AS missing_zipcode,
    COUNT(*) FILTER (WHERE CrimeRate IS NULL)
        AS missing_crimerate,
    COUNT(*) FILTER (WHERE SchoolRating IS NULL)
        AS missing_schoolrating
FROM housing;


-- Query 6: Housing Price Summary
SELECT
    COUNT(*) AS total_properties,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(STDDEV_SAMP(Price), 2) AS price_stddev
FROM housing;


-- Query 7: Property Size Summary
SELECT
    MIN(SquareFeet) AS minimum_sqft,
    MAX(SquareFeet) AS maximum_sqft,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(MEDIAN(SquareFeet), 2) AS median_sqft
FROM housing;


-- Query 8: Bedroom Distribution
SELECT
    Bedrooms,
    COUNT(*) AS total_properties,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_properties
FROM housing
GROUP BY Bedrooms
ORDER BY Bedrooms;


-- Query 9: Property Age Distribution
SELECT
    MIN(YearBuilt) AS oldest_construction_year,
    MAX(YearBuilt) AS newest_construction_year,
    ROUND(AVG(YearBuilt), 0) AS average_year_built
FROM housing;


-- Query 10: ZIP Code Coverage
SELECT
    COUNT(DISTINCT ZipCode) AS unique_zipcodes,
    MIN(ZipCode) AS minimum_zipcode,
    MAX(ZipCode) AS maximum_zipcode
FROM housing;


-- Query 11: Invalid Property Values
SELECT
    COUNT(*) FILTER (
        WHERE Price <= 0
    ) AS invalid_prices,
    COUNT(*) FILTER (
        WHERE SquareFeet <= 0
    ) AS invalid_squarefeet,
    COUNT(*) FILTER (
        WHERE Bedrooms < 0
    ) AS invalid_bedrooms,
    COUNT(*) FILTER (
        WHERE Bathrooms < 0
    ) AS invalid_bathrooms,
    COUNT(*) FILTER (
        WHERE YearBuilt > 2026 OR YearBuilt <= 0
    ) AS invalid_construction_years
FROM housing;


-- Query 12: Price Per Square Foot
SELECT
    ROUND(AVG(Price * 1.0 / NULLIF(SquareFeet, 0)), 2)
        AS average_price_per_sqft,
    ROUND(MIN(Price * 1.0 / NULLIF(SquareFeet, 0)), 2)
        AS minimum_price_per_sqft,
    ROUND(MAX(Price * 1.0 / NULLIF(SquareFeet, 0)), 2)
        AS maximum_price_per_sqft
FROM housing;


-- =====================================================
-- PROJECT 18: REAL ESTATE HOUSING MARKET ANALYTICS
-- DAY 2: HOUSING PRICE ANALYSIS & PROPERTY VALUATION
-- =====================================================


-- Query 13: Housing Price Segmentation
SELECT
    CASE
        WHEN Price < 250000 THEN 'Affordable'
        WHEN Price < 500000 THEN 'Mid-Range'
        WHEN Price < 750000 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS property_percentage
FROM housing
GROUP BY 1
ORDER BY MIN(Price);


-- Query 14: Top 10 Most Expensive Properties
SELECT
    Price,
    Bedrooms,
    Bathrooms,
    SquareFeet,
    YearBuilt,
    ZipCode,
    ROUND(Price * 1.0 / NULLIF(SquareFeet, 0), 2)
        AS price_per_sqft
FROM housing
ORDER BY Price DESC
LIMIT 10;


-- Query 15: Top 10 Most Affordable Properties
SELECT
    Price,
    Bedrooms,
    Bathrooms,
    SquareFeet,
    YearBuilt,
    ZipCode,
    ROUND(Price * 1.0 / NULLIF(SquareFeet, 0), 2)
        AS price_per_sqft
FROM housing
ORDER BY Price ASC
LIMIT 10;


-- Query 16: Average Housing Price by Bedroom Count
SELECT
    Bedrooms,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price
FROM housing
GROUP BY Bedrooms
ORDER BY Bedrooms;


-- Query 17: Housing Prices by Bathroom Count
SELECT
    Bathrooms,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price
FROM housing
GROUP BY Bathrooms
ORDER BY Bathrooms;


-- Query 18: Price Per Square Foot by Bedroom Count
SELECT
    Bedrooms,
    COUNT(*) AS total_properties,
    ROUND(
        AVG(Price * 1.0 / NULLIF(SquareFeet, 0)), 2
    ) AS average_price_per_sqft,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(Price), 2) AS average_price
FROM housing
GROUP BY Bedrooms
ORDER BY Bedrooms;


-- Query 19: Top 10 Highest Price Per Square Foot
WITH property_valuation AS (
    SELECT
        Price,
        Bedrooms,
        Bathrooms,
        SquareFeet,
        ZipCode,
        ROUND(
            Price * 1.0 / NULLIF(SquareFeet, 0), 2
        ) AS price_per_sqft
    FROM housing
)
SELECT *
FROM property_valuation
WHERE price_per_sqft IS NOT NULL
ORDER BY price_per_sqft DESC
LIMIT 10;


-- Query 20: Housing Price Quartile Analysis
WITH price_quartiles AS (
    SELECT
        Price,
        NTILE(4) OVER (ORDER BY Price) AS price_quartile
    FROM housing
)
SELECT
    price_quartile,
    COUNT(*) AS total_properties,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price,
    ROUND(AVG(Price), 2) AS average_price
FROM price_quartiles
GROUP BY price_quartile
ORDER BY price_quartile;


-- Query 21: Housing Price Outlier Detection (IQR)
WITH quartiles AS (
    SELECT
        QUANTILE_CONT(Price, 0.25) AS q1,
        QUANTILE_CONT(Price, 0.75) AS q3
    FROM housing
),
bounds AS (
    SELECT
        q1,
        q3,
        q3 - q1 AS iqr,
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)
SELECT
    COUNT(*) AS total_properties,
    COUNT(*) FILTER (
        WHERE h.Price < b.lower_bound
           OR h.Price > b.upper_bound
    ) AS outlier_properties,
    ROUND(MAX(b.lower_bound), 2) AS lower_bound,
    ROUND(MAX(b.upper_bound), 2) AS upper_bound
FROM housing h
CROSS JOIN bounds b;


-- Query 22: Housing Prices by Property Size
SELECT
    CASE
        WHEN SquareFeet < 1500 THEN 'Small'
        WHEN SquareFeet < 3000 THEN 'Medium'
        WHEN SquareFeet < 4500 THEN 'Large'
        ELSE 'Extra Large'
    END AS property_size_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(
        AVG(Price * 1.0 / NULLIF(SquareFeet, 0)), 2
    ) AS average_price_per_sqft
FROM housing
GROUP BY 1
ORDER BY MIN(SquareFeet);


-- Query 23: Price Deviation From Overall Market Average
WITH price_comparison AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        ZipCode,
        ROUND(AVG(Price) OVER (), 2) AS market_avg_price
    FROM housing
)
SELECT
    Price,
    Bedrooms,
    SquareFeet,
    ZipCode,
    market_avg_price,
    ROUND(Price - market_avg_price, 2)
        AS price_difference,
    ROUND(
        (Price - market_avg_price) * 100.0
        / NULLIF(market_avg_price, 0), 2
    ) AS deviation_percentage
FROM price_comparison
ORDER BY ABS(Price - market_avg_price) DESC
LIMIT 15;


-- Query 24: Property Value Ranking
SELECT
    Price,
    Bedrooms,
    Bathrooms,
    SquareFeet,
    ZipCode,
    DENSE_RANK() OVER (
        ORDER BY Price DESC
    ) AS price_rank,
    DENSE_RANK() OVER (
        ORDER BY Price * 1.0 / NULLIF(SquareFeet, 0) DESC
        NULLS LAST
    ) AS price_per_sqft_rank
FROM housing
ORDER BY price_rank
LIMIT 20;
