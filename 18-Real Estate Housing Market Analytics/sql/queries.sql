
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
