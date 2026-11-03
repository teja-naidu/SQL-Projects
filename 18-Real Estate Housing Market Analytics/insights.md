Real Estate Housing Market Analytics

Project: SQL Project 18 – Real Estate Housing Market Analytics
Database: DuckDB
Language: SQL
Dataset: USA Housing Kaggle Dataset
Total Records: 300
Total Attributes: 10

Day 1: Data Exploration & Data Quality Analysis

1. Dataset Overview

The initial analysis focused on understanding the housing dataset, evaluating data quality, and establishing baseline property statistics.

Metric

Result

Total Properties

300

Total Attributes

10

Unique ZIP Codes

300

Duplicate Records

0

Minimum ZIP Code

10163

Maximum ZIP Code

99881

Key Insights:

The dataset contains 300 housing records with 10 property-related attributes.

All 300 records have distinct ZIP codes.

No exact duplicate property records were identified.

Since each ZIP code appears only once, ZIP-level averages cannot represent multiple properties within the same area.

2. Data Quality Assessment

The dataset was evaluated for duplicate records, missing values, and invalid property attributes.

Quality Check

Result

Duplicate Records

0

Missing Prices

0

Missing Bedrooms

0

Missing ZIP Codes

0

Missing Crime Rates

0

Missing School Ratings

0

Invalid Property Prices

0

Invalid Square Footage

0

Invalid Bedroom Counts

0

Invalid Bathroom Counts

0

Invalid Construction Years

0

Key Insights:

No duplicate records were detected across the complete set of property attributes.

No missing values were reported in the visible results for prices, bedrooms, ZIP codes, crime rates, and school ratings.

The initial validation identified no negative or zero property prices, invalid square footage, or invalid construction years.

Complete missing-value results for the remaining attributes should be verified from the untruncated DuckDB output.

Conclusion: The dataset passed the reported initial data quality checks and is suitable for further exploratory analysis.

3. Housing Price Distribution

Metric

Value

Minimum Property Price

$112,666

Maximum Property Price

$999,684

Average Property Price

$522,761.92

Median Property Price

$505,806.50

Price Standard Deviation

$256,922.35

Price Range

$887,018

Key Insights:

Property prices range from approximately $113K to nearly $1 million.

The average property price is approximately 3.35% higher than the median.

This difference suggests a slightly right-skewed price distribution.

The relatively high standard deviation indicates substantial price variability.

Business Interpretation: The dataset contains properties across a wide range of price points, making it useful for studying housing price segmentation and valuation differences.

4. Property Size Analysis

Metric

Value

Minimum Property Size

840 sqft

Maximum Property Size

4,997 sqft

Average Property Size

3,052.75 sqft

Median Property Size

3,127 sqft

Key Insights:

Property sizes vary substantially, from 840 to 4,997 square feet.

The average property size is approximately 3,053 sqft.

The median property size is slightly larger than the mean.

This variation provides opportunities to analyze how property size relates to housing prices.

5. Bedroom Distribution

Bedrooms

Total Properties

Percentage

1

67

22.33%

2

59

19.67%

3

51

17.00%

4

63

21.00%

5

60

20.00%

Total

300

100.00%

Key Insights:

One-bedroom properties represent the largest category, accounting for 22.33%.

Three-bedroom properties represent the smallest category, accounting for 17%.

Four-bedroom and five-bedroom properties together account for 41% of the dataset.

Bedroom counts are relatively evenly distributed across the five categories.

6. Property Construction Analysis

Metric

Value

Oldest Construction Year

1902

Newest Construction Year

2022

Average Construction Year

1963

Construction Year Span

120 years

Key Insights:

Properties were constructed across a 120-year period.

The average construction year is approximately 1963.

The dataset contains both older and relatively recently constructed properties.

Construction year can be evaluated as a potential factor associated with housing prices.

7. Price Per Square Foot Analysis

Metric

Value

Average Price Per Sqft

$210.42

Minimum Price Per Sqft

$27.04

Maximum Price Per Sqft

$1,016.45

Key Insights:

The average property-level price per square foot is $210.42.

The maximum observed price per square foot is approximately 4.83 times the average.

The substantial variation suggests that total price and square footage do not move proportionally across all properties.

Extreme price-per-square-foot values require further investigation before drawing conclusions about overvaluation or undervaluation.

Day 1 Conclusion

The initial analysis established a baseline understanding of the housing dataset.

Major Findings:

The dataset contains 300 properties across 300 distinct ZIP codes.

No exact duplicate records or invalid values were identified in the reported checks.

The average property price is approximately $522.8K.

Property prices and square footage vary substantially.

Bedroom counts are relatively evenly distributed.

Construction years span from 1902 to 2022.

Price per square foot varies widely across properties.

Outcome: Day 1 established the data quality and descriptive statistics needed for advanced housing price analysis.

Day 2: Housing Price Analysis & Property Valuation

1. Housing Price Segmentation

Properties were classified into four price categories using SQL CASE expressions.

Price Segment

Price Range

Properties

Average Price

Percentage

Affordable

Below $250K

58

$186,977.31

19.33%

Mid-Range

$250K–$499,999

90

$369,099.58

30.00%

Premium

$500K–$749,999

82

$625,078.95

27.33%

Luxury

$750K and above

70

$878,692.21

23.33%

Total



300



100%

Key Insights:

Mid-Range properties form the largest individual segment, representing 30% of the dataset.

Premium properties account for 27.33%.

Luxury properties represent 23.33%.

Affordable properties account for 19.33%.

Premium and Luxury properties collectively represent 50.67% of the dataset.

Business Interpretation: The dataset contains a substantial proportion of higher-priced properties under the project-defined segmentation criteria.

Note: These price categories are analytical classifications created for this project, not official US housing market definitions.

2. Top 10 Most Expensive Properties

Rank

Price

Bedrooms

Square Feet

Price/Sqft

1

$999,684

1

3,132

$319.18

2

$999,159

1

4,650

$214.87

3

$998,613

5

4,429

$225.47

4

$997,421

5

3,857

$258.60

5

$996,942

4

4,125

$241.68

6

$994,498

4

4,189

$237.41

7

$981,691

2

2,108

$465.70

8

$979,989

1

3,980

$246.23

9

$979,858

5

964

$1,016.45

10

$978,338

4

4,349

$224.96

Key Insights:

The most expensive property costs $999,684 and contains only one bedroom.

The ninth most expensive property has just 964 sqft but the highest price per square foot in the dataset.

Expensive properties do not necessarily have the greatest number of bedrooms or the largest square footage.

Business Interpretation: Total housing prices cannot be explained by bedroom count or property size alone.

3. Top 10 Most Affordable Properties

Rank

Price

Bedrooms

Square Feet

Price/Sqft

1

$112,666

2

2,790

$40.38

2

$113,986

2

1,754

$64.99

3

$115,708

4

2,258

$51.24

4

$121,959

1

1,036

$117.72

5

$122,671

1

2,439

$50.30

6

$123,247

2

4,168

$29.57

7

$124,300

2

4,597

$27.04

8

$124,538

2

1,522

$81.83

9

$125,939

2

2,720

$46.30

10

$130,535

4

4,501

$29.00

Key Insights:

The lowest-priced property costs $112,666.

Several lower-priced properties contain more than 4,000 sqft.

The property priced at $124,300 has 4,597 sqft and the lowest observed price per square foot of $27.04.

Lower total prices do not always correspond to smaller properties.

Business Interpretation: Properties with unusually low price per square foot may warrant further investigation, but affordability or investment potential cannot be established without additional location, condition, and market information.

4. Average Housing Price by Bedroom Count

Bedrooms

Properties

Average Price

Median Price

1

67

$544,384.27

$542,296.00

2

59

$474,537.12

$476,896.00

3

51

$513,232.06

$465,838.00

4

63

$549,673.43

$539,792.00

5

60

$525,881.30

$476,209.50

Key Insights:

Four-bedroom properties have the highest average price at $549,673.43.

Two-bedroom properties have the lowest average price at $474,537.12.

One-bedroom properties have a higher average price than five-bedroom properties.

Property prices do not consistently increase with bedroom count.

Business Interpretation: Bedroom count alone is not a reliable indicator of housing value in this dataset.

5. Bathroom Count and Housing Prices

The dataset contains bathroom counts ranging from 1.0 to 4.0, with 31 distinct bathroom-count categories.

Notable Findings:

Highest Average Price: $695,944.44 for properties with 1.6 bathrooms.

Lowest Average Price: $289,465.17 for properties with 1.9 bathrooms.

Properties with 1.0 bathrooms have an average price of $654,833, based on three records.

Properties with 4.0 bathrooms have an average price of $596,146.33, based on nine records.

Key Insight: Average property prices fluctuate across bathroom-count categories rather than following a consistent increasing pattern.

Analytical Consideration: Several bathroom categories contain relatively few records. These averages should therefore be interpreted cautiously.

6. Price Per Square Foot by Bedroom Count

Bedrooms

Properties

Average Price/Sqft

Average Size

1

67

$198.93

3,125.25 sqft

2

59

$197.45

3,084.93 sqft

3

51

$181.24

3,231.37 sqft

4

63

$243.76

2,870.73 sqft

5

60

$225.77

2,979.43 sqft

Key Insights:

Four-bedroom properties have the highest average price per square foot at $243.76.

Three-bedroom properties have the lowest average price per square foot at $181.24.

Three-bedroom properties also have the largest average square footage.

Average price per square foot does not increase consistently with bedroom count.

7. Highest Price Per Square Foot Properties

Rank

Property Price

Square Feet

Price/Sqft

1

$979,858

964

$1,016.45

2

$877,089

894

$981.08

3

$862,002

1,129

$763.51

4

$748,143

997

$750.39

5

$771,155

1,035

$745.08

6

$824,839

1,145

$720.38

7

$635,822

926

$686.63

8

$803,550

1,185

$678.10

9

$840,976

1,254

$670.63

10

$887,201

1,400

$633.72

Key Insights:

The highest price per square foot is $1,016.45.

All ten properties in this ranking have square footage of 1,400 sqft or less.

High total property prices combined with relatively small floor areas produce high price-per-square-foot values.

Business Interpretation: Price-per-square-foot comparisons should consider property characteristics and location before identifying potentially overpriced properties.

8. Housing Price Quartile Analysis

Properties were divided into four equally sized groups using SQL NTILE(4).

Quartile

Properties

Minimum Price

Maximum Price

Average Price

Q1

75

$112,666

$299,041

$207,795.19

Q2

75

$300,235

$502,690

$393,114.57

Q3

75

$508,923

$744,167

$620,168.87

Q4

75

$745,914

$999,684

$869,969.04

Key Insights:

Each quartile contains 75 properties.

The highest-priced quartile has an average price of $869,969.04.

The lowest-priced quartile has an average price of $207,795.19.

The Q4 average is approximately 4.19 times the Q1 average.

Business Interpretation: Quartile segmentation provides a useful way to compare lower-priced, middle-priced, and higher-priced properties without relying exclusively on fixed price thresholds.

9. Housing Price Outlier Detection

The Interquartile Range (IQR) method was used to identify unusually high or low property prices.

Metric

Value

Total Properties

300

Lower IQR Bound

-$367,064.38

Upper IQR Bound

$1,411,604.63

Identified Price Outliers

0

Key Insights:

No properties fall outside the calculated IQR boundaries.

All observed property prices are within the statistical range defined by the method.

The negative lower bound is a mathematical result of the IQR formula, not an observed negative property price.

Zero price outliers does not mean the dataset contains no unusual property characteristics or price-per-square-foot values.

Conclusion: No total-price outliers were identified using the 1.5 × IQR rule.

10. Housing Prices by Property Size

Size Category

Properties

Average Price

Average Sqft

Average Price/Sqft

Small

40

$516,181.60

1,130.93

$458.94

Medium

104

$504,139.21

2,312.61

$226.55

Large

121

$537,592.69

3,821.75

$143.00

Extra Large

35

$534,346.23

4,789.86

$111.49

Key Insights:

Large properties represent the largest size category, with 121 records.

Medium properties have the lowest average total price at $504,139.21.

Small properties have the highest average price per square foot at $458.94.

Extra Large properties have the lowest average price per square foot at $111.49.

Small properties have approximately 4.12 times the average price per square foot of Extra Large properties.

Average total property prices remain relatively similar across size categories despite substantial differences in square footage.

Business Interpretation: The dataset demonstrates a strong descriptive decline in average price per square foot as property size increases. However, the data does not establish that increasing property size causes lower unit prices.

11. Price Deviation From the Market Average

The overall dataset average of $522,761.92 was used as the benchmark for measuring individual property price deviations.

Metric

Value

Overall Average Price

$522,761.92

Highest Property Price

$999,684

Highest Positive Price Difference

$476,922.08

Highest Positive Percentage Deviation

91.23%

Key Insights:

The most expensive property is priced approximately 91.23% above the dataset average.

Multiple high-priced properties exceed the dataset average by more than 80%.

Price deviation identifies properties that differ substantially from the overall average but does not independently establish overvaluation.

12. Property Value Ranking

Two ranking methods were applied using SQL DENSE_RANK():

Ranking properties by total price.

Ranking properties by price per square foot.

Notable Findings:

The most expensive property ranks first by total price but 53rd by price per square foot.

The second most expensive property ranks 109th by price per square foot.

The ninth most expensive property ranks first by price per square foot.

Key Insight: Property rankings change significantly depending on whether total price or price per square foot is used.

Business Interpretation: Both measures should be considered when comparing property valuations because they represent different aspects of housing prices.

Day 2 Conclusion

The housing price analysis identified several important findings:

Mid-Range properties form the largest price segment at 30%.

Premium and Luxury properties together account for 50.67% of the dataset.

Bedroom and bathroom counts do not exhibit a consistent increasing relationship with average property prices.

Smaller properties have substantially higher average prices per square foot.

No total-price outliers were identified using the IQR method.

Property rankings differ significantly between total price and price per square foot.

Several properties exhibit extreme price-per-square-foot values that warrant additional investigation.

Outcome: Day 2 expanded the analysis from basic descriptive statistics to housing price segmentation, property comparisons, statistical outlier detection, and advanced SQL ranking techniques.

Overall Project Progress

Day

Analysis Focus

Status

Day 1

Data Exploration & Data Quality

Completed

Day 2

Housing Price Analysis & Property Valuation

Completed

Day 3

Property Characteristics & Housing Value Drivers

Upcoming

Day 4

Location & ZIP Code Analysis

Planned

Day 5

Advanced Housing Market Analytics

Planned

SQL Concepts Applied

Aggregate Functions: COUNT, SUM, AVG, MIN, MAX

Statistical Functions: MEDIAN, STDDEV_SAMP, QUANTILE_CONT

Conditional Logic: CASE WHEN

Data Quality Checks: IS NULL, COUNT(DISTINCT)

Window Functions: NTILE, DENSE_RANK, SUM() OVER, AVG() OVER

Common Table Expressions: WITH

Conditional Aggregation: FILTER

Safe Division: NULLIF

Sorting and Ranking: ORDER BY, LIMIT

Grouping and Segmentation: GROUP BY

# Day 3: Property Characteristics & Housing Value Drivers

## 1. Construction Decade Analysis

Properties were grouped by construction decade to examine the relationship between building age and housing prices.

| Decade | Properties | Average Price |
|---|---:|---:|
| 1900s | 22 | $473,292.86 |
| 1910s | 30 | $506,113.93 |
| 1920s | 19 | $475,332.84 |
| 1930s | 23 | $558,168.96 |
| 1940s | 25 | $611,706.20 |
| 1950s | 24 | $504,949.04 |
| 1960s | 23 | $546,232.04 |
| 1970s | 21 | $558,340.86 |
| 1980s | 27 | $503,893.37 |
| 1990s | 29 | $532,721.28 |
| 2000s | 23 | $480,463.43 |
| 2010s | 23 | $552,076.48 |
| 2020s | 11 | $441,920.09 |

**Key Insight:** Properties built during the 1940s have the highest average price, while properties built during the 2020s have the lowest. Newer construction does not consistently correspond to higher prices.

## 2. Property Age Analysis

Property age was calculated using 2026 as the reference year.

| Age Category | Properties | Average Price |
|---|---:|---:|
| 0–10 Years | 20 | $483,700.95 |
| 11–25 Years | 34 | $519,155.06 |
| 26–50 Years | 70 | $516,661.99 |
| 51–75 Years | 57 | $536,477.53 |
| Over 75 Years | 119 | $527,375.85 |

**Key Insight:** Properties aged 51–75 years have the highest average price. Properties aged 10 years or less have the lowest average price. Property age alone does not explain housing valuation.

## 3. Garage Spaces and Property Valuation

| Garage Spaces | Properties | Average Price | Average Price/Sqft |
|---|---:|---:|---:|
| 0 | 72 | $523,492.56 | $215.20 |
| 1 | 79 | $529,592.06 | $220.56 |
| 2 | 72 | $495,158.39 | $191.51 |
| 3 | 77 | $540,882.26 | $213.22 |

**Key Insight:** Three-garage-space properties have the highest average total price, while one-garage-space properties have the highest average price per square foot. Garage capacity does not show a consistent increasing relationship with housing prices.

## 4. Lot Size and Housing Prices

| Lot Category | Properties | Average Lot Size | Average Price |
|---|---:|---:|---:|
| Small Lot | 59 | 0.30 | $529,792.44 |
| Medium Lot | 78 | 0.74 | $529,788.90 |
| Large Lot | 90 | 1.27 | $517,973.62 |
| Extra Large Lot | 73 | 1.77 | $515,474.81 |

**Key Insight:** Small Lot properties have the highest average price, while Extra Large Lot properties have the lowest. Larger lots do not consistently command higher prices in the dataset.

Lot-size units have not been verified, and the categories use project-defined thresholds.

## 5. School Ratings and Housing Prices

| School Rating | Properties | Average Price |
|---|---:|---:|
| 1 | 34 | $517,210.82 |
| 2 | 27 | $498,167.81 |
| 3 | 43 | $575,489.28 |
| 4 | 31 | $455,112.39 |
| 5 | 30 | $476,083.77 |
| 6 | 29 | $533,959.72 |
| 7 | 28 | $517,270.39 |
| 8 | 34 | $607,485.09 |
| 9 | 44 | $500,748.73 |

**Key Insight:** School rating 8 has the highest average housing price, while rating 4 has the lowest. Higher school ratings do not consistently correspond to higher property prices.

## 6. Crime Rate and Property Valuation

| Crime Category | Properties | Average Crime Rate | Average Price |
|---|---:|---:|---:|
| Low Crime | 80 | 12.63 | $505,241.61 |
| Moderate Crime | 70 | 37.48 | $521,304.30 |
| High Crime | 80 | 63.55 | $554,671.46 |
| Very High Crime | 70 | 86.85 | $507,774.69 |

**Key Insight:** The High Crime category has the highest average property price, while the Low Crime category has the lowest. The dataset does not demonstrate a consistent inverse relationship between the crime indicator and property prices.

The crime categories are project-defined and should not be interpreted as official neighborhood safety classifications.

## 7. School Rating and Crime Rate Comparison

- School rating 6 has the lowest average crime-rate indicator: 32.09.
- School rating 5 has the highest average crime-rate indicator: 56.49.
- School rating 8 has the highest average property price: $607,485.09.
- School rating 9 has the largest property count: 44.

**Key Insight:** School ratings and crime-rate indicators vary independently across the grouped results. Higher school ratings do not consistently correspond to lower average crime indicators.

## 8. Correlation Between Property Features and Prices

Pearson correlation was used to measure linear relationships between housing prices and property characteristics.

| Feature | Correlation |
|---|---:|
| Square Footage | +0.0438 |
| Bedrooms | +0.0181 |
| Bathrooms | +0.0364 |
| Crime Rate | +0.0096 |
| School Rating | +0.0248 |

The remaining correlations for construction year, garage spaces, and lot size require confirmation from the complete query output.

**Key Insight:** All five visible correlation coefficients are close to zero, indicating very weak linear relationships with property prices.

These findings describe statistical associations and do not establish causation.

## 9. Newer vs Older Properties

| Construction Group | Properties | Average Price | Average Price/Sqft |
|---|---:|---:|---:|
| Built 2000 or Later | 57 | $501,921.74 | $193.32 |
| Built Before 2000 | 243 | $527,650.35 | $214.43 |

**Key Insight:** Properties built before 2000 have an average price approximately $25,728.61 higher than properties built in 2000 or later. They also have a higher average price per square foot.

This comparison does not establish that older construction causes higher property prices.

## 10. Combined Bedroom and Garage Characteristics

| Bedroom Category | Garage Category | Properties | Average Price |
|---|---|---:|---:|
| 1–2 Bedrooms | 1 Garage Space | 36 | $520,955.33 |
| 1–2 Bedrooms | 2+ Garage Spaces | 63 | $478,882.41 |
| 1–2 Bedrooms | No Garage | 27 | $575,831.56 |
| 3–4 Bedrooms | 1 Garage Space | 25 | $538,361.44 |
| 3–4 Bedrooms | 2+ Garage Spaces | 62 | $550,427.58 |
| 3–4 Bedrooms | No Garage | 27 | $489,582.04 |
| 5+ Bedrooms | 1 Garage Space | 18 | $534,685.83 |
| 5+ Bedrooms | 2+ Garage Spaces | 24 | $541,801.50 |
| 5+ Bedrooms | No Garage | 18 | $495,849.83 |

**Key Insight:** One- to two-bedroom properties without garages have the highest average price among the combined categories. Property prices do not increase consistently with bedroom count or garage capacity.

## 11. High-Value Property Characteristics

The highest-priced quartile was analyzed using SQL `NTILE(4)`.

- High-Value Properties: 75
- Average Property Price: $869,969.04
- Average Bedrooms: 3.04
- Average School Rating: 4.92
- Average Crime Rate: 52.56

**Key Insight:** The top 25% of properties have an average price of approximately $870K and an average of three bedrooms. High total property prices are not necessarily associated with the highest school ratings or lowest crime-rate indicators.

Additional feature averages were calculated but were not fully visible in the terminal output.

## 12. Property Ranking Within Bedroom Groups

SQL `DENSE_RANK()` was used to identify the three highest-priced properties within each bedroom category.

| Bedrooms | Highest Price | Price/Sqft |
|---|---:|---:|
| 1 | $999,684 | $319.18 |
| 2 | $981,691 | $465.70 |
| 3 | $974,371 | $296.16 |
| 4 | $996,942 | $241.68 |
| 5 | $998,613 | $225.47 |

**Key Insight:** The highest-priced properties across bedroom groups have relatively similar total prices despite different bedroom counts and square footage.

The five-bedroom property priced at $979,858 ranks third within its bedroom category but has the highest price per square foot in the entire dataset at $1,016.45.

## Day 3 Conclusion

The analysis examined construction decade, property age, garage capacity, lot size, school ratings, crime indicators, and combined property characteristics.

**Major Findings:**

1. Properties built during the 1940s have the highest average prices by construction decade.
2. Older properties have slightly higher average prices than properties built in 2000 or later.
3. Garage capacity and lot size do not show consistently increasing relationships with property prices.
4. Higher school ratings do not consistently correspond to higher housing prices.
5. Crime-rate categories do not demonstrate a straightforward inverse relationship with property prices.
6. The five visible Pearson correlations indicate very weak linear relationships between individual features and property prices.
7. The highest-priced quartile contains 75 properties with an average price of $869,969.04.
8. Property ranking within bedroom groups highlights substantial differences in price per square foot.

**Overall Insight:** No single property characteristic examined in the visible results provides a strong standalone explanation for housing price variation. Further multivariable analysis would be needed to assess their combined predictive relationships.

# Day 4: Advanced Property Valuation & Market Segmentation

## 1. Housing Price Distribution by Bedroom Segment

| Bedroom Segment | Properties | Average Price | Median Price | Price Standard Deviation |
|---|---:|---:|---:|---:|
| 1–2 Bedrooms | 126 | $511,678.06 | $515,353.50 | $256,419.81 |
| 3–4 Bedrooms | 114 | $533,370.71 | $521,598.00 | $264,212.30 |
| 5 Bedrooms | 60 | $525,881.30 | $476,209.50 | $247,037.21 |

**Key Insights:**
- Three- to four-bedroom properties have the highest average price at $533,370.71.
- Five-bedroom properties have a lower average price than three- to four-bedroom properties.
- All three groups show substantial price variation.
- Bedroom count alone does not explain differences in housing prices.

## 2. Property Price Compared With Bedroom-Group Average

Individual property prices were compared against the average price of properties with the same bedroom count using SQL window functions.

**Notable Findings:**
- A two-bedroom property priced at $981,691 is 106.87% above the two-bedroom group average.
- A five-bedroom property priced at $998,613 is 89.89% above its bedroom-group average.
- A four-bedroom property priced at $115,708 is 78.95% below its bedroom-group average.
- A one-bedroom property priced at $121,959 is 77.60% below its bedroom-group average.

**Key Insight:** Properties with identical bedroom counts can have significantly different prices. Comparing properties against bedroom-group averages reveals differences that overall market averages may conceal.

## 3. Price Per Square Foot by Property Size

| Property Size | Properties | Average Price/Sqft | Minimum Price/Sqft | Maximum Price/Sqft |
|---|---:|---:|---:|---:|
| Small | 40 | $458.94 | $117.72 | $1,016.45 |
| Medium | 104 | $226.55 | $40.38 | $556.42 |
| Large | 121 | $143.00 | $29.57 | $319.18 |
| Extra Large | 35 | $111.49 | $27.04 | $214.87 |

**Key Insights:**
- Small properties have the highest average price per square foot.
- Extra Large properties have the lowest average price per square foot.
- Small properties average approximately 4.12 times the price per square foot of Extra Large properties.
- Significant price-per-square-foot variation exists even within the same size category.

## 4. Relative Property Valuation Classification

Properties were classified based on their price per square foot relative to the average of their size group.

Classification rules:
- Below Peer Average: More than 20% below the size-group average.
- Near Peer Average: Within ±20% of the size-group average.
- Above Peer Average: More than 20% above the size-group average.

| Size Category | Below Peer | Near Peer | Above Peer | Total |
|---|---:|---:|---:|---:|
| Small | 17 | 8 | 15 | 40 |
| Medium | 46 | 22 | 36 | 104 |
| Large | 53 | 24 | 44 | 121 |
| Extra Large | 15 | 6 | 14 | 35 |
| **Total** | **131** | **60** | **109** | **300** |

**Key Insights:**
- 131 properties (43.67%) are classified below their size-group average.
- 60 properties (20%) are near their size-group average.
- 109 properties (36.33%) are above their size-group average.
- Large properties account for the greatest number of below-average classifications, with 53 records.

**Business Interpretation:** Relative valuation categories help identify properties for further comparison. They do not establish actual market undervaluation or overvaluation because location, condition, sale date, and other relevant characteristics are not controlled.

## 5. Price Per Square Foot Outlier Detection

The Interquartile Range method was applied to price per square foot.

| Metric | Result |
|---|---:|
| Total Properties | 300 |
| First Quartile (Q1) | $98.14 |
| Third Quartile (Q3) | $255.64 |
| Lower Boundary | −$138.12 |
| Upper Boundary | $491.89 |
| Outlier Properties | 16 |
| Outlier Percentage | 5.33% |

**Key Insights:**
- Sixteen properties are identified as price-per-square-foot outliers.
- Day 2 identified zero outliers using total property prices.
- This difference demonstrates how outlier detection depends on the metric being analyzed.
- All identified price-per-square-foot outliers are above the calculated upper boundary.

**Business Interpretation:** Price-per-square-foot analysis can highlight unusual property valuations that are not apparent when examining total prices alone.

## 6. Top 10 Properties Below Their Size-Group Average

Properties were ranked according to how far their price per square foot falls below their size-group average.

| Rank | Property Price | Square Feet | Size Category | Price/Sqft | Deviation |
|---|---:|---:|---|---:|---:|
| 1 | $112,666 | 2,790 | Medium | $40.38 | −82.18% |
| 2 | $125,939 | 2,720 | Medium | $46.30 | −79.56% |
| 3 | $123,247 | 4,168 | Large | $29.57 | −79.32% |
| 4 | $139,353 | 2,889 | Medium | $48.24 | −78.71% |
| 5 | $122,671 | 2,439 | Medium | $50.30 | −77.80% |
| 6 | $115,708 | 2,258 | Medium | $51.24 | −77.38% |
| 7 | $124,300 | 4,597 | Extra Large | $27.04 | −75.75% |
| 8 | $121,959 | 1,036 | Small | $117.72 | −74.35% |
| 9 | $130,535 | 4,501 | Extra Large | $29.00 | −73.99% |
| 10 | $141,090 | 3,698 | Large | $38.15 | −73.32% |

**Key Insights:**
- The highest-ranked property is 82.18% below its size-group average price per square foot.
- Multiple large properties appear among the lowest relative price-per-square-foot rankings.
- Low relative prices may justify further investigation, but they are not proof of investment opportunities.

## 7. Top 10 Properties Above Their Size-Group Average

| Rank | Property Price | Size Category | Price/Sqft | Deviation |
|---|---:|---|---:|---:|
| 1 | $967,055 | Medium | $556.42 | +145.60% |
| 2 | $999,684 | Large | $319.18 | +123.20% |
| 3 | $979,858 | Small | $1,016.45 | +121.48% |
| 4 | $950,937 | Large | $316.66 | +121.44% |
| 5 | $778,843 | Medium | $488.92 | +115.81% |
| 6 | $877,089 | Small | $981.08 | +113.77% |
| 7 | $937,291 | Medium | $484.14 | +113.70% |
| 8 | $974,371 | Large | $296.16 | +107.10% |
| 9 | $981,691 | Medium | $465.70 | +105.56% |
| 10 | $723,094 | Medium | $461.16 | +103.55% |

**Key Insights:**
- The highest-ranked property exceeds its size-group average price per square foot by 145.60%.
- All ten properties exceed their respective size-group averages by more than 100%.
- Relative price rankings differ from rankings based solely on total property price.

## 8. School Rating and Crime Indicator Segmentation

| School Rating Segment | Crime Indicator Segment | Properties | Average Price |
|---|---|---:|---:|
| High | Higher | 35 | $543,581.03 |
| High | Lower | 33 | $460,686.24 |
| High | Middle | 38 | $603,763.84 |
| Low | Higher | 37 | $487,825.92 |
| Low | Lower | 32 | $602,267.94 |
| Low | Middle | 35 | $527,417.29 |
| Medium | Higher | 29 | $510,386.72 |
| Medium | Lower | 38 | $467,185.55 |
| Medium | Middle | 23 | $492,241.87 |

**Key Insights:**
- The High School Rating / Middle Crime Indicator group has the highest average price at $603,763.84.
- The Low School Rating / Lower Crime Indicator group has the second-highest average price at $602,267.94.
- The High School Rating / Lower Crime Indicator group has the lowest average price at $460,686.24.
- No consistent price progression is observed across school and crime indicator combinations.

These categories are project-defined and do not represent official school quality or neighborhood safety assessments.

## 9. Construction Age and Property Size Segmentation

| Age Segment | Size Segment | Properties | Average Price |
|---|---|---:|---:|
| Mid-Age | Large | 51 | $533,155.43 |
| Mid-Age | Medium | 46 | $557,102.35 |
| Mid-Age | Small | 27 | $468,284.26 |
| Newer | Large | 21 | $491,696.90 |
| Newer | Medium | 27 | $528,066.19 |
| Newer | Small | 9 | $447,346.33 |
| Older | Large | 53 | $536,059.79 |
| Older | Medium | 35 | $510,154.23 |
| Older | Small | 31 | $531,972.87 |

**Key Insights:**
- Mid-Age / Medium properties have the highest average price at $557,102.35.
- Newer / Small properties have the lowest average price at $447,346.33.
- Larger properties are not consistently the most expensive within each age group.
- Construction age and size categories show different pricing patterns when examined together.

## 10. Housing Price Percentile Ranking

SQL `PERCENT_RANK()` was used to rank properties by total price.

**Notable Findings:**
- The highest-priced property ($999,684) has a percentile rank of 100%.
- The second-highest property ($999,159) has a percentile rank of 99.67%.
- The property priced at $887,201 has a percentile rank of 90.30%.
- The query returned the top 30 properties by total price.

**Key Insight:** Percentile ranking provides a standardized method for identifying the highest-priced properties relative to the full dataset.

## 11. Property Feature Correlation Ranking

Pearson correlation was calculated for eight property characteristics.

| Rank | Property Feature | Correlation With Price |
|---|---|---:|
| 1 | Square Footage | +0.0438 |
| 2 | Bathrooms | +0.0364 |
| 3 | School Rating | +0.0248 |
| 4 | Lot Size | −0.0226 |
| 5 | Bedrooms | +0.0181 |
| 6 | Crime Rate | +0.0096 |
| 7 | Garage Spaces | +0.0087 |
| 8 | Construction Year | +0.0050 |

**Key Insights:**
- Square footage has the highest absolute correlation with price, but the coefficient is only 0.0438.
- Lot size has a very weak negative correlation with price.
- Construction year has the weakest absolute correlation at 0.0050.
- None of the eight features exhibits a meaningful standalone linear correlation with property price in this dataset.

**Business Interpretation:** Individual property characteristics have very weak linear associations with housing prices. Multivariable modeling and better geographic data would be needed for reliable price prediction.

## 12. Housing Market Segmentation Summary

| Price Segment | Properties | Average Price | Properties With 4+ Bedrooms | Percentage With 4+ Bedrooms |
|---|---:|---:|---:|---:|
| Affordable | 58 | $186,977.31 | 19 | 32.76% |
| Mid-Range | 90 | $369,099.58 | 42 | 46.67% |
| Premium | 82 | $625,078.95 | 30 | 36.59% |
| Luxury | 70 | $878,692.21 | 32 | 45.71% |

**Key Insights:**
- Mid-Range properties represent the largest segment, with 90 records.
- The Mid-Range segment has the highest proportion of four-plus-bedroom properties at 46.67%.
- The Luxury segment has 45.71% four-plus-bedroom properties.
- The Affordable segment has the lowest proportion of four-plus-bedroom properties at 32.76%.
- Larger bedroom counts are not exclusively concentrated in the highest-priced segment.

## Day 4 Conclusion

Advanced property valuation and segmentation identified several important patterns:

1. Housing prices vary substantially even within the same bedroom group.
2. Average price per square foot decreases across larger property-size categories.
3. Of 300 properties, 131 fall below, 60 near, and 109 above their size-group price-per-square-foot averages under the ±20% classification.
4. Sixteen price-per-square-foot outliers were detected, compared with zero total-price outliers in Day 2.
5. Properties ranked by relative valuation differ from those ranked by total price.
6. School ratings, crime indicators, construction age, and size do not show consistent price patterns across the analyzed segments.
7. All eight property features exhibit extremely weak individual linear correlations with housing price.
8. The Mid-Range segment contains the largest proportion of four-plus-bedroom properties.

**Overall Insight:** Comparing properties against relevant peer groups provides a more informative descriptive perspective than relying on total price alone. However, meaningful property valuation requires additional data about geographic location, property condition, transaction dates, and comparable sales.

# Day 5: Advanced Housing Analytics & Final Project Findings

## 1. Housing Price Distribution

The analysis of 300 properties produced an average price of $522,761.92, a median price of $505,806.50, and a standard deviation of $256,922.35.

Price skewness was 0.1917, indicating a slightly right-skewed distribution. Excess kurtosis was -1.1771, indicating a flatter distribution with lighter tails than a normal distribution.

## 2. Feature Correlations by Price Segment

Correlation analysis revealed that relationships between housing prices and individual property characteristics vary across price segments.

- Affordable properties showed a positive square-footage correlation of 0.2730.
- Mid-Range properties showed a negative construction-year correlation of -0.2467.
- Luxury properties showed a positive bedroom-count correlation of 0.2455.
- Most other relationships were weak.

These are descriptive correlations within price-defined groups, not evidence of causation.

## 3. Median-Based Property Valuation

| Size Segment | Average Price/Sqft | Median Price/Sqft |
|---|---:|---:|
| Small | $458.94 | $435.33 |
| Medium | $226.55 | $207.65 |
| Large | $143.00 | $140.10 |
| Extra Large | $111.49 | $114.27 |

Smaller properties have substantially higher prices per square foot than larger properties. Median-based comparisons provide an additional perspective on valuation by reducing the influence of extreme observations.

## 4. Property Price Variability

The coefficient of variation was highest for Medium properties (53.82%), followed by Small (51.19%), Extra Large (50.78%), and Large (50.69%).

All four groups demonstrated considerable relative price-per-square-foot variation.

## 5. Housing Price Deciles

The lowest price decile contained 30 properties with an average price of $151,838.30.

The highest price decile contained 30 properties with an average price of $947,833.13.

The highest-decile average was approximately 6.24 times the lowest-decile average.

## 6. School Rating and Crime Indicator Analysis

The Higher School Rating / Higher Crime Indicator group had the highest average price at $564,418.98.

The Higher School Rating / Lower Crime Indicator group averaged $511,270.90.

The results did not demonstrate a consistent pricing advantage associated with the project-defined school and crime indicator categories.

## 7. Similar-Property Peer Benchmarking

Properties were compared using bedroom count and square-footage category.

The largest positive deviation was 158.85%, observed for a three-bedroom, 3,003-square-foot property priced at $950,937.

This property had a price per square foot of $316.66, compared with its peer median of $122.34.

Peer benchmarking identifies unusual relative valuations but cannot independently determine whether a property is fairly priced.

## 8. Price Per Square Foot Outliers

Using the Interquartile Range method, 16 properties (5.33%) were identified as high price-per-square-foot outliers.

The highest outlier was a 964-square-foot property priced at $979,858, equivalent to $1,016.45 per square foot.

No low outliers were detected.

## 9. Housing Price Concentration

| Property Group | Properties | Share of Combined Value |
|---|---:|---:|
| Top 10% | 30 | 18.13% |
| Next 15% | 45 | 23.47% |
| Next 25% | 75 | 29.66% |
| Bottom 50% | 150 | 28.74% |

The highest-priced 25% of properties accounted for 41.60% of combined property value.

This is a dataset-level concentration measure, not an estimate of real-world market share.

## 10. Property Valuation Consistency

Medium-sized properties had the highest relative absolute deviation from their size-group median price per square foot at 48.06%.

Extra Large properties had the lowest at 42.87%.

These results demonstrate substantial pricing differences even among properties of similar sizes.

## 11. Property Characteristics by Price Quartile

The highest price quartile contained 75 properties averaging $869,969.04.

Its average property size was 3,048.87 square feet, compared with 2,957.73 square feet in the lowest price quartile.

Average bedrooms, bathrooms, construction year, school rating, and crime indicator did not follow consistent increasing patterns across price quartiles.

## 12. Final Housing Market Scorecard

| Metric | Value |
|---|---:|
| Total Properties | 300 |
| Average Price | $522,761.92 |
| Median Price | $505,806.50 |
| Minimum Price | $112,666 |
| Maximum Price | $999,684 |
| Average Square Feet | 3,052.75 |
| Average Price/Sqft | $210.42 |
| Median Price/Sqft | $171.81 |
| Luxury Properties | 70 |
| Affordable Properties | 58 |
| Price/Sqft Outliers | 16 |
| Average School Rating | 5.10 |
| Average Crime Indicator | 49.32 |

## Final Day 5 Conclusion

The final analysis demonstrates that property prices vary substantially across the dataset and that individual housing characteristics have weak overall linear relationships with price.

Size-based and bedroom-based peer comparisons reveal meaningful descriptive differences that total-price rankings alone cannot identify.

The project demonstrates practical applications of DuckDB, SQL aggregations, Common Table Expressions, window functions, percentile calculations, correlation analysis, statistical dispersion, and outlier detection.

**Limitations:** The dataset contains no transaction dates, property-condition details, or reliable geographic grouping for comparable-sales analysis. Findings should be interpreted as descriptive dataset analytics rather than real-world housing market forecasts or investment recommendations.