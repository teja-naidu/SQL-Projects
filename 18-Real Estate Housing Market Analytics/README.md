Real Estate Housing Market Analytics | SQL & DuckDB
A 5-day, 60-query SQL portfolio project exploring housing prices, property characteristics, relative valuations, and statistical patterns across 300 residential property records.
Project Overview
This project uses DuckDB and SQL to investigate how property prices vary by size, bedrooms, bathrooms, construction year, garage capacity, lot size, school ratings, and crime indicators. The analysis progresses from data quality checks to descriptive statistics, market segmentation, window-function-based peer comparisons, correlation analysis, and outlier detection.

Important: This dataset has no transaction dates or usable neighborhood-level grouping (each of the 300 records has a distinct ZIP code). The results describe the dataset; they do not establish real-world market trends, investment opportunities, or causal effects on home prices.
At a Glance
Metric	Result
Properties analyzed	300
Dataset fields	10
SQL queries	60
Analysis duration	5 days
Average property price	$522,761.92
Median property price	$505,806.50
Minimum / maximum price	$112,666 / $999,684
Average property size	3,052.75 sq ft
Average property-level price per sq ft	$210.42
Price-per-sq-ft outliers (IQR)	16 (5.33%)


Metric definition: Average price per square foot is the average of each property's Price / SquareFeet, not total prices divided by total square footage.

Tools and Techniques
- Database: DuckDB
- Language: SQL
- Data loading: read_csv_auto()
- Core SQL: filtering, grouping, CASE, conditional aggregation, subqueries, and Common Table Expressions (CTEs)
- Window functions: ROW_NUMBER(), DENSE_RANK(), NTILE(), PERCENT_RANK(), and partitioned averages/medians
- Statistical functions: MEDIAN(), QUANTILE_CONT(), STDDEV_SAMP(), CORR(), SKEWNESS(), and KURTOSIS()
- Analytical methods: price segmentation, price-per-square-foot benchmarking, percentile ranking, IQR outlier detection, and value concentration
Dataset
File: data/usa_housing_kaggle.csv
Column	Description
Price	Property price in USD
Bedrooms	Number of bedrooms
Bathrooms	Number of bathrooms
SquareFeet	Interior property area in square feet
YearBuilt	Construction year
GarageSpaces	Number of garage spaces
LotSize	Lot-size measure (use the source dataset's units)
ZipCode	ZIP code identifier
CrimeRate	Dataset-provided crime indicator
SchoolRating	Dataset-provided school rating


The file contains 300 records. Every ZIP code is unique in this sample, so ZIP-level averages cannot be treated as neighborhood estimates. The data does not include sale dates, property condition, or sufficient location context for comparable-sales valuation.
Repository Structure
18-Real-Estate-Housing-Market-Analytics/
├── data/
│   └── usa_housing_kaggle.csv
├── sql/
│   └── queries.sql
├── insights/
│   └── insights.md
└── README.md
All 60 queries are stored together in sql/queries.sql, and findings from all five days are documented in insights/insights.md.
How to Run
1. Install DuckDB
Install the DuckDB command-line interface and make sure duckdb is available in your terminal.
2. Open the project directory
cd "path/to/18-Real-Estate-Housing-Market-Analytics"
3. Create or open the local database
duckdb housing_market.duckdb
4. Load the CSV
Run this once from the DuckDB prompt (with the working directory set to the project root):
CREATE OR REPLACE TABLE housing AS
SELECT * FROM read_csv_auto('data/usa_housing_kaggle.csv');
5. Execute the analysis
.mode table
.read sql/queries.sql
Tip: The script contains all 60 queries, so .read runs the complete analysis. For wide outputs, use .mode line and rerun an individual query. The housing_market.duckdb file is a local database artifact and does not need to be committed to Git.
Analysis Roadmap
Day	Query Range	Focus
1	1–12	Dataset exploration, data quality, and baseline housing metrics
2	13–24	Price segmentation, property rankings, price per square foot, and quartiles
3	25–36	Construction age, garages, lot size, school ratings, crime indicators, and feature correlations
4	37–48	Peer-relative valuations, size segments, price-per-square-foot outliers, and percentile rankings
5	49–60	Statistical distribution, median-based benchmarking, price deciles, value concentration, and final scorecard


Key Findings
1. Property prices vary widely
The average property price is $522,761.92, while the median is $505,806.50. Prices range from $112,666 to $999,684. Day 5 found a slight positive skew in prices (0.1917).
2. Smaller properties have higher average prices per square foot
Property size	Count	Average price per sq ft
Small (under 1,500 sq ft)	40	$458.94
Medium (1,500–2,999 sq ft)	104	$226.55
Large (3,000–4,499 sq ft)	121	$143.00
Extra Large (4,500+ sq ft)	35	$111.49


The Small group averages about 4.12× the price per square foot of the Extra Large group. This is a descriptive size-group difference, not proof that smaller properties are better investments.
3. Price-per-square-foot outliers reveal patterns missed by total price
Using the 1.5 × IQR rule, the analysis identified 16 price-per-square-foot outliers (5.33%), even though the earlier total-price IQR test identified zero. The highest observed price per square foot was $1,016.45, for a 964-square-foot property priced at $979,858.
4. Relative valuation depends on the comparison group
Comparing each property's price per square foot with its size-group average using a ±20% threshold produced:
Relative classification	Properties	Share
More than 20% below peer average	131	43.67%
Within ±20% of peer average	60	20.00%
More than 20% above peer average	109	36.33%


These labels flag records for further investigation; they do not establish fair market value. Day 5 further refined comparisons by combining bedroom count and size group, using the peer median.
5. Individual feature correlations with price are extremely weak
Feature	Pearson correlation with price
Square footage	+0.0438
Bathrooms	+0.0364
School rating	+0.0248
Lot size	−0.0226
Bedrooms	+0.0181
Crime indicator	+0.0096
Garage spaces	+0.0087
Construction year	+0.0050


None of the eight features has a strong individual linear relationship with price in this sample. This does not rule out nonlinear or multivariable relationships.
6. The top-priced properties account for a substantial share of total dataset value
The top 10% of properties account for 18.13% of combined listed property value; the top 25% account for 41.60%. This is a concentration measure within the sample, not a claim about market-wide wealth or sales activity.
7. Bedroom count and other characteristics do not show simple pricing trends
Average prices do not consistently increase with bedroom count. School-rating and crime-indicator combinations also show no clear monotonic price pattern in this dataset. Further modeling and better location data would be required to explain the variation.
Example SQL
Compare each property with its bedroom-group average
SELECT
    Price,
    Bedrooms,
    SquareFeet,
    ROUND(AVG(Price) OVER (PARTITION BY Bedrooms), 2)
        AS bedroom_group_avg_price,
    ROUND(
        Price - AVG(Price) OVER (PARTITION BY Bedrooms),
        2
    ) AS difference_from_group_average
FROM housing
ORDER BY ABS(
    Price - AVG(Price) OVER (PARTITION BY Bedrooms)
) DESC
LIMIT 10;
Detect price-per-square-foot outliers using the IQR rule
WITH metrics AS (
    SELECT
        Price,
        SquareFeet,
        Price * 1.0 / NULLIF(SquareFeet, 0) AS price_per_sqft
    FROM housing
),
quartiles AS (
    SELECT
        QUANTILE_CONT(price_per_sqft, 0.25) AS q1,
        QUANTILE_CONT(price_per_sqft, 0.75) AS q3
    FROM metrics
)
SELECT
    COUNT(*) AS total_properties,
    COUNT(*) FILTER (
        WHERE price_per_sqft < q1 - 1.5 * (q3 - q1)
           OR price_per_sqft > q3 + 1.5 * (q3 - q1)
    ) AS outlier_count
FROM metrics
CROSS JOIN quartiles;
Project Limitations
- No temporal analysis: There are no transaction dates, so appreciation, seasonal trends, and price changes over time cannot be estimated.
- No usable ZIP-level peer groups: Each ZIP code appears only once; ZIP-based neighborhood averages would be misleading.
- No property condition or comparable sales: Below-average price per square foot is not necessarily an undervalued property.
- Small sample: Only 300 records; findings may not generalize to the US housing market.
- Indicator definitions: School ratings and crime rates are treated as provided by the dataset; thresholds used in segmentation are analytical choices, not official safety or school-quality categories.
- Correlation is not causation: Weak pairwise linear correlations do not establish which features do or do not determine real-world property prices.
Skills Demonstrated
SQL data analysis · DuckDB · Data quality validation · Exploratory data analysis · CTEs · Window functions · Statistical SQL · Market segmentation · Peer benchmarking · Outlier detection · Analytical documentation
Full Results
See [`insights/insights.md`](insights/insights.md) for the detailed findings from Days 1–5 and [`sql/queries.sql`](sql/queries.sql) for all 60 SQL queries.