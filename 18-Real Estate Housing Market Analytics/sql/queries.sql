
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


-- =====================================================
-- PROJECT 18: REAL ESTATE HOUSING MARKET ANALYTICS
-- DAY 3: PROPERTY CHARACTERISTICS & HOUSING VALUE DRIVERS
-- =====================================================


-- Query 25: Housing Prices by Construction Decade
SELECT
    CAST(FLOOR(YearBuilt / 10.0) * 10 AS INTEGER)
        AS construction_decade,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM housing
GROUP BY 1
ORDER BY construction_decade;


-- Query 26: Property Age and Housing Prices
WITH property_age AS (
    SELECT
        Price,
        SquareFeet,
        YearBuilt,
        2026 - YearBuilt AS property_age,
        CASE
            WHEN 2026 - YearBuilt <= 10 THEN '0-10 Years'
            WHEN 2026 - YearBuilt <= 25 THEN '11-25 Years'
            WHEN 2026 - YearBuilt <= 50 THEN '26-50 Years'
            WHEN 2026 - YearBuilt <= 75 THEN '51-75 Years'
            ELSE 'Over 75 Years'
        END AS age_category
    FROM housing
)
SELECT
    age_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(property_age), 2) AS average_age,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM property_age
GROUP BY age_category
ORDER BY MIN(property_age);


-- Query 27: Garage Spaces and Property Valuation
SELECT
    GarageSpaces,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(
        AVG(Price * 1.0 / NULLIF(SquareFeet, 0)), 2
    ) AS average_price_per_sqft
FROM housing
GROUP BY GarageSpaces
ORDER BY GarageSpaces;


-- Query 28: Lot Size and Property Prices
WITH lot_categories AS (
    SELECT
        Price,
        LotSize,
        SquareFeet,
        CASE
            WHEN LotSize < 0.5 THEN 'Small Lot'
            WHEN LotSize < 1.0 THEN 'Medium Lot'
            WHEN LotSize < 1.5 THEN 'Large Lot'
            ELSE 'Extra Large Lot'
        END AS lot_category
    FROM housing
)
SELECT
    lot_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(LotSize), 2) AS average_lot_size,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM lot_categories
GROUP BY lot_category
ORDER BY MIN(LotSize);


-- Query 29: School Ratings and Housing Prices
SELECT
    SchoolRating,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate
FROM housing
GROUP BY SchoolRating
ORDER BY SchoolRating;


-- Query 30: Crime Rate and Property Valuation
WITH crime_categories AS (
    SELECT
        Price,
        CrimeRate,
        SchoolRating,
        SquareFeet,
        CASE
            WHEN CrimeRate < 25 THEN 'Low Crime'
            WHEN CrimeRate < 50 THEN 'Moderate Crime'
            WHEN CrimeRate < 75 THEN 'High Crime'
            ELSE 'Very High Crime'
        END AS crime_category
    FROM housing
)
SELECT
    crime_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SchoolRating), 2) AS average_school_rating
FROM crime_categories
GROUP BY crime_category
ORDER BY MIN(CrimeRate);


-- Query 31: School Rating vs Crime Rate
SELECT
    SchoolRating,
    COUNT(*) AS total_properties,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate,
    ROUND(MIN(CrimeRate), 2) AS minimum_crime_rate,
    ROUND(MAX(CrimeRate), 2) AS maximum_crime_rate,
    ROUND(AVG(Price), 2) AS average_price
FROM housing
GROUP BY SchoolRating
ORDER BY SchoolRating;


-- Query 32: Correlation Between Features and Price
SELECT
    ROUND(CORR(Price, SquareFeet), 4)
        AS price_sqft_correlation,
    ROUND(CORR(Price, Bedrooms), 4)
        AS price_bedrooms_correlation,
    ROUND(CORR(Price, Bathrooms), 4)
        AS price_bathrooms_correlation,
    ROUND(CORR(Price, YearBuilt), 4)
        AS price_yearbuilt_correlation,
    ROUND(CORR(Price, GarageSpaces), 4)
        AS price_garage_correlation,
    ROUND(CORR(Price, LotSize), 4)
        AS price_lotsize_correlation,
    ROUND(CORR(Price, CrimeRate), 4)
        AS price_crimerate_correlation,
    ROUND(CORR(Price, SchoolRating), 4)
        AS price_schoolrating_correlation
FROM housing;


-- Query 33: Newer vs Older Properties
WITH property_comparison AS (
    SELECT
        Price,
        SquareFeet,
        YearBuilt,
        CASE
            WHEN YearBuilt >= 2000 THEN 'Built 2000 or Later'
            ELSE 'Built Before 2000'
        END AS construction_group
    FROM housing
)
SELECT
    construction_group,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(
        AVG(Price * 1.0 / NULLIF(SquareFeet, 0)), 2
    ) AS average_price_per_sqft
FROM property_comparison
GROUP BY construction_group
ORDER BY construction_group;


-- Query 34: Combined Property Characteristics
SELECT
    CASE
        WHEN Bedrooms <= 2 THEN '1-2 Bedrooms'
        WHEN Bedrooms <= 4 THEN '3-4 Bedrooms'
        ELSE '5+ Bedrooms'
    END AS bedroom_category,
    CASE
        WHEN GarageSpaces = 0 THEN 'No Garage'
        WHEN GarageSpaces = 1 THEN '1 Garage Space'
        ELSE '2+ Garage Spaces'
    END AS garage_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM housing
GROUP BY 1, 2
ORDER BY bedroom_category, garage_category;


-- Query 35: High-Value Property Characteristics
WITH ranked_properties AS (
    SELECT
        Price,
        Bedrooms,
        Bathrooms,
        SquareFeet,
        YearBuilt,
        GarageSpaces,
        LotSize,
        SchoolRating,
        CrimeRate,
        NTILE(4) OVER (ORDER BY Price DESC)
            AS value_quartile
    FROM housing
)
SELECT
    COUNT(*) AS high_value_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(Bedrooms), 2) AS average_bedrooms,
    ROUND(AVG(Bathrooms), 2) AS average_bathrooms,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(YearBuilt), 0) AS average_year_built,
    ROUND(AVG(GarageSpaces), 2) AS average_garage_spaces,
    ROUND(AVG(LotSize), 2) AS average_lot_size,
    ROUND(AVG(SchoolRating), 2) AS average_school_rating,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate
FROM ranked_properties
WHERE value_quartile = 1;


-- Query 36: Property Ranking by Price Within Bedroom Groups
SELECT
    Price,
    Bedrooms,
    Bathrooms,
    SquareFeet,
    GarageSpaces,
    SchoolRating,
    DENSE_RANK() OVER (
        PARTITION BY Bedrooms
        ORDER BY Price DESC
    ) AS price_rank_within_bedrooms,
    ROUND(
        Price * 1.0 / NULLIF(SquareFeet, 0), 2
    ) AS price_per_sqft
FROM housing
QUALIFY DENSE_RANK() OVER (
    PARTITION BY Bedrooms
    ORDER BY Price DESC
) <= 3
ORDER BY Bedrooms, price_rank_within_bedrooms;
