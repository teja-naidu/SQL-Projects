
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


-- =====================================================
-- PROJECT 18: REAL ESTATE HOUSING MARKET ANALYTICS
-- DAY 4: ADVANCED PROPERTY VALUATION & MARKET SEGMENTATION
-- QUERIES 37-48
-- =====================================================


-- Query 37: Housing Price Distribution by Bedroom Segment
SELECT
    CASE
        WHEN Bedrooms <= 2 THEN '1-2 Bedrooms'
        WHEN Bedrooms <= 4 THEN '3-4 Bedrooms'
        ELSE '5 Bedrooms'
    END AS bedroom_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(STDDEV_SAMP(Price), 2) AS price_stddev,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price
FROM housing
GROUP BY 1
ORDER BY bedroom_segment;


-- Query 38: Property Price vs Bedroom Group Average
WITH bedroom_comparison AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        ZipCode,
        ROUND(
            AVG(Price) OVER (
                PARTITION BY Bedrooms
            ), 2
        ) AS bedroom_avg_price
    FROM housing
)
SELECT
    Price,
    Bedrooms,
    SquareFeet,
    ZipCode,
    bedroom_avg_price,
    ROUND(Price - bedroom_avg_price, 2)
        AS price_difference,
    ROUND(
        100.0 * (Price - bedroom_avg_price)
        / NULLIF(bedroom_avg_price, 0), 2
    ) AS deviation_percentage
FROM bedroom_comparison
ORDER BY ABS(deviation_percentage) DESC, Price DESC
LIMIT 20;


-- Query 39: Price Per Sqft Within Property Size Groups
WITH property_segments AS (
    SELECT
        Price,
        SquareFeet,
        Bedrooms,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_comparison AS (
    SELECT
        *,
        AVG(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_avg_price_per_sqft
    FROM property_segments
)
SELECT
    size_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(price_per_sqft), 2)
        AS average_price_per_sqft,
    ROUND(AVG(peer_avg_price_per_sqft), 2)
        AS peer_average_validation,
    ROUND(MIN(price_per_sqft), 2)
        AS minimum_price_per_sqft,
    ROUND(MAX(price_per_sqft), 2)
        AS maximum_price_per_sqft
FROM peer_comparison
GROUP BY size_segment
ORDER BY
    CASE size_segment
        WHEN 'Small' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Large' THEN 3
        ELSE 4
    END;


-- Query 40: Relative Valuation Classification
WITH property_segments AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        ZipCode,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_averages AS (
    SELECT
        *,
        AVG(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_avg_price_per_sqft
    FROM property_segments
),
valuation AS (
    SELECT
        *,
        100.0 * (price_per_sqft - peer_avg_price_per_sqft)
        / NULLIF(peer_avg_price_per_sqft, 0)
            AS peer_deviation_pct
    FROM peer_averages
)
SELECT
    size_segment,
    CASE
        WHEN peer_deviation_pct < -20
            THEN 'Below Peer Average'
        WHEN peer_deviation_pct > 20
            THEN 'Above Peer Average'
        ELSE 'Near Peer Average'
    END AS valuation_category,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(price_per_sqft), 2)
        AS average_price_per_sqft,
    ROUND(AVG(peer_deviation_pct), 2)
        AS average_deviation_pct
FROM valuation
GROUP BY 1, 2
ORDER BY size_segment, valuation_category;


-- Query 41: Price Per Sqft Outlier Detection (IQR)
WITH price_metrics AS (
    SELECT
        Price,
        SquareFeet,
        Bedrooms,
        ZipCode,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
quartiles AS (
    SELECT
        QUANTILE_CONT(price_per_sqft, 0.25) AS q1,
        QUANTILE_CONT(price_per_sqft, 0.75) AS q3
    FROM price_metrics
),
bounds AS (
    SELECT
        q1,
        q3,
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)
SELECT
    COUNT(*) AS total_properties,
    COUNT(*) FILTER (
        WHERE p.price_per_sqft < b.lower_bound
           OR p.price_per_sqft > b.upper_bound
    ) AS price_per_sqft_outliers,
    ROUND(MAX(b.q1), 2) AS q1,
    ROUND(MAX(b.q3), 2) AS q3,
    ROUND(MAX(b.lower_bound), 2) AS lower_bound,
    ROUND(MAX(b.upper_bound), 2) AS upper_bound
FROM price_metrics p
CROSS JOIN bounds b;


-- Query 42: Top 10 Potential Value Opportunities
WITH property_segments AS (
    SELECT
        Price,
        Bedrooms,
        Bathrooms,
        SquareFeet,
        YearBuilt,
        ZipCode,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_comparison AS (
    SELECT
        *,
        AVG(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_avg_price_per_sqft
    FROM property_segments
),
ranked AS (
    SELECT
        *,
        ROUND(
            100.0 * (price_per_sqft - peer_avg_price_per_sqft)
            / NULLIF(peer_avg_price_per_sqft, 0), 2
        ) AS deviation_pct,
        ROW_NUMBER() OVER (
            ORDER BY
                price_per_sqft / NULLIF(peer_avg_price_per_sqft, 0)
                ASC NULLS LAST,
                Price ASC
        ) AS value_rank
    FROM peer_comparison
)
SELECT
    value_rank,
    Price,
    Bedrooms,
    SquareFeet,
    YearBuilt,
    ZipCode,
    size_segment,
    ROUND(price_per_sqft, 2) AS price_per_sqft,
    ROUND(peer_avg_price_per_sqft, 2)
        AS peer_avg_price_per_sqft,
    deviation_pct
FROM ranked
ORDER BY value_rank
LIMIT 10;


-- Query 43: Top 10 Highest Prices Relative to Peers
WITH property_segments AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        ZipCode,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_comparison AS (
    SELECT
        *,
        AVG(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_avg_price_per_sqft
    FROM property_segments
),
ranked AS (
    SELECT
        *,
        ROUND(
            100.0 * (price_per_sqft - peer_avg_price_per_sqft)
            / NULLIF(peer_avg_price_per_sqft, 0), 2
        ) AS deviation_pct,
        ROW_NUMBER() OVER (
            ORDER BY
                price_per_sqft / NULLIF(peer_avg_price_per_sqft, 0)
                DESC NULLS LAST,
                Price DESC
        ) AS relative_price_rank
    FROM peer_comparison
)
SELECT
    relative_price_rank,
    Price,
    Bedrooms,
    SquareFeet,
    ZipCode,
    size_segment,
    ROUND(price_per_sqft, 2) AS price_per_sqft,
    ROUND(peer_avg_price_per_sqft, 2)
        AS peer_avg_price_per_sqft,
    deviation_pct
FROM ranked
ORDER BY relative_price_rank
LIMIT 10;


-- Query 44: School Rating and Crime Segmentation
SELECT
    CASE
        WHEN SchoolRating <= 3 THEN 'Low School Rating'
        WHEN SchoolRating <= 6 THEN 'Medium School Rating'
        ELSE 'High School Rating'
    END AS school_segment,
    CASE
        WHEN CrimeRate < 33.33 THEN 'Lower Crime Indicator'
        WHEN CrimeRate < 66.67 THEN 'Middle Crime Indicator'
        ELSE 'Higher Crime Indicator'
    END AS crime_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM housing
GROUP BY 1, 2
ORDER BY school_segment, crime_segment;


-- Query 45: Construction Age and Property Size Segmentation
WITH property_features AS (
    SELECT
        Price,
        SquareFeet,
        YearBuilt,
        CASE
            WHEN YearBuilt >= 2000 THEN 'Newer'
            WHEN YearBuilt >= 1950 THEN 'Mid-Age'
            ELSE 'Older'
        END AS age_segment,
        CASE
            WHEN SquareFeet < 2000 THEN 'Small'
            WHEN SquareFeet < 3500 THEN 'Medium'
            ELSE 'Large'
        END AS size_segment
    FROM housing
)
SELECT
    age_segment,
    size_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft
FROM property_features
GROUP BY 1, 2
ORDER BY age_segment, size_segment;


-- Query 46: Housing Price Percentile Ranking
WITH property_percentiles AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        ZipCode,
        ROUND(
            100.0 * PERCENT_RANK() OVER (
                ORDER BY Price
            ), 2
        ) AS price_percentile
    FROM housing
)
SELECT
    Price,
    Bedrooms,
    SquareFeet,
    ZipCode,
    price_percentile,
    CASE
        WHEN price_percentile >= 90 THEN 'Top 10%'
        WHEN price_percentile >= 75 THEN 'Top 25%'
        WHEN price_percentile >= 50 THEN 'Upper Middle'
        WHEN price_percentile >= 25 THEN 'Lower Middle'
        ELSE 'Bottom 25%'
    END AS percentile_segment
FROM property_percentiles
ORDER BY Price DESC
LIMIT 30;


-- Query 47: Property Feature Correlation Ranking
WITH correlations AS (
    SELECT
        CORR(Price, SquareFeet) AS square_feet,
        CORR(Price, Bedrooms) AS bedrooms,
        CORR(Price, Bathrooms) AS bathrooms,
        CORR(Price, YearBuilt) AS year_built,
        CORR(Price, GarageSpaces) AS garage_spaces,
        CORR(Price, LotSize) AS lot_size,
        CORR(Price, CrimeRate) AS crime_rate,
        CORR(Price, SchoolRating) AS school_rating
    FROM housing
),
feature_correlations AS (
    UNPIVOT correlations
    ON
        square_feet,
        bedrooms,
        bathrooms,
        year_built,
        garage_spaces,
        lot_size,
        crime_rate,
        school_rating
    INTO
        NAME feature
        VALUE correlation_value
)
SELECT
    feature,
    ROUND(correlation_value, 4) AS correlation,
    ROUND(ABS(correlation_value), 4)
        AS absolute_correlation,
    DENSE_RANK() OVER (
        ORDER BY ABS(correlation_value) DESC NULLS LAST
    ) AS correlation_rank
FROM feature_correlations
ORDER BY correlation_rank, feature;


-- Query 48: Housing Market Segmentation Summary
WITH property_segments AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        SchoolRating,
        CrimeRate,
        CASE
            WHEN Price < 250000 THEN 'Affordable'
            WHEN Price < 500000 THEN 'Mid-Range'
            WHEN Price < 750000 THEN 'Premium'
            ELSE 'Luxury'
        END AS price_segment
    FROM housing
)
SELECT
    price_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(Bedrooms), 2) AS average_bedrooms,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(SchoolRating), 2) AS average_school_rating,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate,
    COUNT(*) FILTER (
        WHERE Bedrooms >= 4
    ) AS properties_with_4plus_bedrooms,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE Bedrooms >= 4
        ) / NULLIF(COUNT(*), 0), 2
    ) AS pct_with_4plus_bedrooms
FROM property_segments
GROUP BY price_segment
ORDER BY MIN(Price);


-- =====================================================
-- PROJECT 18: REAL ESTATE HOUSING MARKET ANALYTICS
-- DAY 5: ADVANCED HOUSING ANALYTICS & FINAL FINDINGS
-- QUERIES 49-60
-- DATABASE: DUCKDB
-- =====================================================


-- Query 49: Housing Price Distribution & Statistical Shape
SELECT
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(STDDEV_SAMP(Price), 2) AS price_stddev,
    ROUND(SKEWNESS(Price), 4) AS price_skewness,
    ROUND(KURTOSIS(Price), 4) AS price_excess_kurtosis,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price
FROM housing;


-- Query 50: Feature Correlations Within Price Segments
WITH price_segments AS (
    SELECT
        Price,
        SquareFeet,
        Bedrooms,
        Bathrooms,
        YearBuilt,
        SchoolRating,
        CrimeRate,
        CASE
            WHEN Price < 250000 THEN 'Affordable'
            WHEN Price < 500000 THEN 'Mid-Range'
            WHEN Price < 750000 THEN 'Premium'
            ELSE 'Luxury'
        END AS price_segment
    FROM housing
)
SELECT
    price_segment,
    COUNT(*) AS total_properties,
    ROUND(CORR(Price, SquareFeet), 4)
        AS sqft_price_correlation,
    ROUND(CORR(Price, Bedrooms), 4)
        AS bedrooms_price_correlation,
    ROUND(CORR(Price, Bathrooms), 4)
        AS bathrooms_price_correlation,
    ROUND(CORR(Price, YearBuilt), 4)
        AS yearbuilt_price_correlation,
    ROUND(CORR(Price, SchoolRating), 4)
        AS school_price_correlation,
    ROUND(CORR(Price, CrimeRate), 4)
        AS crime_price_correlation
FROM price_segments
GROUP BY price_segment
ORDER BY MIN(Price);


-- Query 51: Median-Based Property Valuation
WITH property_segments AS (
    SELECT
        Price,
        SquareFeet,
        Bedrooms,
        ZipCode,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_medians AS (
    SELECT
        *,
        MEDIAN(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_median_price_per_sqft
    FROM property_segments
)
SELECT
    size_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(price_per_sqft), 2)
        AS average_price_per_sqft,
    ROUND(MAX(peer_median_price_per_sqft), 2)
        AS median_price_per_sqft,
    COUNT(*) FILTER (
        WHERE price_per_sqft < peer_median_price_per_sqft
    ) AS below_median_properties,
    COUNT(*) FILTER (
        WHERE price_per_sqft > peer_median_price_per_sqft
    ) AS above_median_properties,
    COUNT(*) FILTER (
        WHERE price_per_sqft = peer_median_price_per_sqft
    ) AS at_median_properties
FROM peer_medians
GROUP BY size_segment
ORDER BY
    CASE size_segment
        WHEN 'Small' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Large' THEN 3
        ELSE 4
    END;


-- Query 52: Price Per Sqft Variation by Size Category
WITH size_groups AS (
    SELECT
        Price,
        SquareFeet,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
)
SELECT
    size_segment,
    COUNT(*) AS total_properties,
    ROUND(AVG(price_per_sqft), 2)
        AS average_price_per_sqft,
    ROUND(MEDIAN(price_per_sqft), 2)
        AS median_price_per_sqft,
    ROUND(STDDEV_SAMP(price_per_sqft), 2)
        AS price_per_sqft_stddev,
    ROUND(
        100.0 * STDDEV_SAMP(price_per_sqft)
        / NULLIF(AVG(price_per_sqft), 0), 2
    ) AS coefficient_of_variation_pct
FROM size_groups
GROUP BY size_segment
ORDER BY
    CASE size_segment
        WHEN 'Small' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Large' THEN 3
        ELSE 4
    END;


-- Query 53: Housing Price Decile Analysis
WITH price_deciles AS (
    SELECT
        Price,
        SquareFeet,
        Bedrooms,
        NTILE(10) OVER (
            ORDER BY Price
        ) AS price_decile
    FROM housing
)
SELECT
    price_decile,
    COUNT(*) AS total_properties,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(Bedrooms), 2) AS average_bedrooms
FROM price_deciles
GROUP BY price_decile
ORDER BY price_decile;


-- Query 54: School and Crime Indicator Price Comparison
WITH neighborhood_segments AS (
    SELECT
        Price,
        SquareFeet,
        SchoolRating,
        CrimeRate,
        CASE
            WHEN SchoolRating >= 7
                THEN 'Higher School Rating'
            ELSE 'Lower-Middle School Rating'
        END AS school_group,
        CASE
            WHEN CrimeRate < 50
                THEN 'Lower Crime Indicator'
            ELSE 'Higher Crime Indicator'
        END AS crime_group
    FROM housing
)
SELECT
    school_group,
    crime_group,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(MEDIAN(Price), 2) AS median_price,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(SchoolRating), 2) AS average_school_rating,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate
FROM neighborhood_segments
GROUP BY school_group, crime_group
ORDER BY school_group, crime_group;


-- Query 55: Similar-Property Peer Benchmarking
WITH property_peers AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        YearBuilt,
        ZipCode,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
benchmarked AS (
    SELECT
        *,
        COUNT(*) OVER (
            PARTITION BY Bedrooms, size_segment
        ) AS peer_count,
        AVG(price_per_sqft) OVER (
            PARTITION BY Bedrooms, size_segment
        ) AS peer_avg_price_per_sqft,
        MEDIAN(price_per_sqft) OVER (
            PARTITION BY Bedrooms, size_segment
        ) AS peer_median_price_per_sqft
    FROM property_peers
)
SELECT
    Price,
    Bedrooms,
    SquareFeet,
    YearBuilt,
    ZipCode,
    size_segment,
    peer_count,
    ROUND(price_per_sqft, 2) AS price_per_sqft,
    ROUND(peer_median_price_per_sqft, 2)
        AS peer_median_price_per_sqft,
    ROUND(
        100.0 * (price_per_sqft - peer_median_price_per_sqft)
        / NULLIF(peer_median_price_per_sqft, 0), 2
    ) AS median_deviation_pct
FROM benchmarked
WHERE peer_count >= 5
ORDER BY ABS(
    (price_per_sqft - peer_median_price_per_sqft)
    / NULLIF(peer_median_price_per_sqft, 0)
) DESC NULLS LAST
LIMIT 20;


-- Query 56: Extreme Price Per Sqft Outlier Properties
WITH property_metrics AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        YearBuilt,
        ZipCode,
        ROUND(
            Price * 1.0 / NULLIF(SquareFeet, 0), 2
        ) AS price_per_sqft
    FROM housing
),
quartiles AS (
    SELECT
        QUANTILE_CONT(price_per_sqft, 0.25) AS q1,
        QUANTILE_CONT(price_per_sqft, 0.75) AS q3
    FROM property_metrics
),
outlier_bounds AS (
    SELECT
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)
SELECT
    p.Price,
    p.Bedrooms,
    p.SquareFeet,
    p.YearBuilt,
    p.ZipCode,
    p.price_per_sqft,
    ROUND(b.upper_bound, 2) AS upper_iqr_bound,
    CASE
        WHEN p.price_per_sqft > b.upper_bound
            THEN 'High Outlier'
        WHEN p.price_per_sqft < b.lower_bound
            THEN 'Low Outlier'
    END AS outlier_type
FROM property_metrics p
CROSS JOIN outlier_bounds b
WHERE p.price_per_sqft > b.upper_bound
   OR p.price_per_sqft < b.lower_bound
ORDER BY p.price_per_sqft DESC;


-- Query 57: Housing Price Concentration
WITH ranked_prices AS (
    SELECT
        Price,
        ROW_NUMBER() OVER (
            ORDER BY Price DESC
        ) AS price_rank,
        COUNT(*) OVER () AS total_properties,
        SUM(Price) OVER () AS total_property_value
    FROM housing
)
SELECT
    CASE
        WHEN price_rank <= total_properties * 0.10
            THEN 'Top 10%'
        WHEN price_rank <= total_properties * 0.25
            THEN 'Next 15%'
        WHEN price_rank <= total_properties * 0.50
            THEN 'Next 25%'
        ELSE 'Bottom 50%'
    END AS property_group,
    COUNT(*) AS total_properties,
    ROUND(SUM(Price), 2) AS combined_property_value,
    ROUND(
        100.0 * SUM(Price)
        / NULLIF(MAX(total_property_value), 0), 2
    ) AS share_of_total_value_pct
FROM ranked_prices
GROUP BY property_group
ORDER BY
    CASE property_group
        WHEN 'Top 10%' THEN 1
        WHEN 'Next 15%' THEN 2
        WHEN 'Next 25%' THEN 3
        ELSE 4
    END;


-- Query 58: Property Valuation Consistency by Size
WITH property_groups AS (
    SELECT
        Price,
        SquareFeet,
        CASE
            WHEN SquareFeet < 1500 THEN 'Small'
            WHEN SquareFeet < 3000 THEN 'Medium'
            WHEN SquareFeet < 4500 THEN 'Large'
            ELSE 'Extra Large'
        END AS size_segment,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft
    FROM housing
),
peer_medians AS (
    SELECT
        *,
        MEDIAN(price_per_sqft) OVER (
            PARTITION BY size_segment
        ) AS peer_median
    FROM property_groups
)
SELECT
    size_segment,
    COUNT(*) AS total_properties,
    ROUND(MAX(peer_median), 2)
        AS median_price_per_sqft,
    ROUND(
        AVG(ABS(price_per_sqft - peer_median)), 2
    ) AS mean_absolute_deviation_from_median,
    ROUND(
        100.0 * AVG(
            ABS(price_per_sqft - peer_median)
        ) / NULLIF(MAX(peer_median), 0), 2
    ) AS relative_absolute_deviation_pct
FROM peer_medians
GROUP BY size_segment
ORDER BY relative_absolute_deviation_pct DESC;


-- Query 59: Property Characteristics by Price Quartile
WITH price_quartiles AS (
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
        NTILE(4) OVER (
            ORDER BY Price
        ) AS price_quartile
    FROM housing
)
SELECT
    price_quartile,
    COUNT(*) AS total_properties,
    ROUND(AVG(Price), 2) AS average_price,
    ROUND(AVG(Bedrooms), 2) AS average_bedrooms,
    ROUND(AVG(Bathrooms), 2) AS average_bathrooms,
    ROUND(AVG(SquareFeet), 2) AS average_sqft,
    ROUND(AVG(YearBuilt), 2) AS average_year_built,
    ROUND(AVG(GarageSpaces), 2) AS average_garage_spaces,
    ROUND(AVG(LotSize), 2) AS average_lot_size,
    ROUND(AVG(SchoolRating), 2) AS average_school_rating,
    ROUND(AVG(CrimeRate), 2) AS average_crime_rate
FROM price_quartiles
GROUP BY price_quartile
ORDER BY price_quartile;


-- Query 60: Final Housing Market Analytical Scorecard
WITH property_metrics AS (
    SELECT
        Price,
        Bedrooms,
        SquareFeet,
        SchoolRating,
        CrimeRate,
        Price * 1.0 / NULLIF(SquareFeet, 0)
            AS price_per_sqft,
        CASE
            WHEN Price < 250000 THEN 'Affordable'
            WHEN Price < 500000 THEN 'Mid-Range'
            WHEN Price < 750000 THEN 'Premium'
            ELSE 'Luxury'
        END AS price_segment
    FROM housing
),
quartiles AS (
    SELECT
        QUANTILE_CONT(price_per_sqft, 0.25) AS q1,
        QUANTILE_CONT(price_per_sqft, 0.75) AS q3
    FROM property_metrics
),
outlier_bounds AS (
    SELECT
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)
SELECT
    COUNT(*) AS total_properties,
    ROUND(AVG(p.Price), 2) AS average_price,
    ROUND(MEDIAN(p.Price), 2) AS median_price,
    MIN(p.Price) AS minimum_price,
    MAX(p.Price) AS maximum_price,
    ROUND(AVG(p.SquareFeet), 2) AS average_sqft,
    ROUND(AVG(p.price_per_sqft), 2)
        AS average_price_per_sqft,
    ROUND(MEDIAN(p.price_per_sqft), 2)
        AS median_price_per_sqft,
    COUNT(*) FILTER (
        WHERE p.Price >= 750000
    ) AS luxury_properties,
    COUNT(*) FILTER (
        WHERE p.Price < 250000
    ) AS affordable_properties,
    COUNT(*) FILTER (
        WHERE p.price_per_sqft < b.lower_bound
           OR p.price_per_sqft > b.upper_bound
    ) AS price_per_sqft_outliers,
    ROUND(AVG(p.SchoolRating), 2)
        AS average_school_rating,
    ROUND(AVG(p.CrimeRate), 2)
        AS average_crime_rate
FROM property_metrics p
CROSS JOIN outlier_bounds b;
