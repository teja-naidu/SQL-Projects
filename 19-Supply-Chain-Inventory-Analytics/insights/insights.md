# Supply Chain & Inventory Analytics – Business Insights

## Day 1: Data Exploration & Quality Analysis

### 1. Dataset Overview

The analysis combines three datasets covering inventory, warehouse fulfillment, and customer orders and shipments from 2015 to 2017.

| Dataset | Total Records | Description |
|---|---:|---|
| Fulfillment | 118 | Product-level warehouse fulfillment times |
| Inventory | 4,200 | Monthly inventory levels and unit costs |
| Orders & Shipments | 30,871 | Customer orders, sales, and shipping information |
| **Total** | **35,189** | **Combined dataset records** |

**Key Insight:** The three datasets provide complementary information for evaluating inventory availability, order demand, and fulfillment efficiency.

### 2. Data Quality Analysis

- No missing values were identified in the selected fields tested across the three datasets.
- No duplicate order item IDs were detected.
- No duplicate product-month combinations were identified in the inventory dataset.
- Both inventory and orders datasets cover 36 months, from January 2015 through December 2017.
- All three datasets were successfully imported into DuckDB.

**Business Insight:** The initial validation results support further analysis. Additional checks of data types, business rules, and product matching will help confirm reliability before combining datasets.

### 3. Overall Sales & Profit Performance

| Metric | Value |
|---|---:|
| Total Orders | 11,072 |
| Total Order Items | 30,871 |
| Unique Customers | 7,987 |
| Total Gross Sales | $6,181,476 |
| Reported Total Profit | $3,994,192 |
| Calculated Profit Margin | 64.62% |

**Key Insights:**

- The business generated approximately $6.18 million in gross sales during the three-year reporting period.
- Reported profit reached approximately $3.99 million.
- The calculated profit-to-gross-sales ratio was 64.62%.
- The dataset's definition of profit should be verified before interpreting this ratio as a net profit margin.

**Business Recommendation:** Evaluate profit contributions by product category, customer market, and shipping method to identify opportunities for improving profitability.

### 4. Top-Performing Products

| Product | Gross Sales | Reported Profit |
|---|---:|---:|
| Field & Stream Sportsman 16 Gun Fire Safe | $1,151,200 | $575,600 |
| Perfect Fitness Perfect Rip Deck | $777,120 | $630,924 |
| Diamondback Women's Serene Classic Comfort Bi | $728,100 | $364,050 |
| Nike Men's Free 5.0+ Running Shoe | $645,500 | $520,870 |
| Nike Men's Dri-FIT Victory Golf Polo | $544,300 | $452,750 |

**Key Insights:**

- Field & Stream Sportsman 16 Gun Fire Safe generated the highest gross sales at $1.15 million.
- Perfect Fitness Perfect Rip Deck generated the highest reported profit among the top 10 products by gross sales.
- The highest-revenue product was not the highest-profit product.
- Product-level profitability varies, indicating opportunities to prioritize products based on both sales and profit contributions.

**Business Recommendation:** Compare high-revenue and high-profit products when making inventory allocation and replenishment decisions.

### 5. Customer Market Performance

| Market | Total Orders | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|---:|
| LATAM | 3,060 | $1,806,987 | $1,183,753 | 65.51% |
| Europe | 3,268 | $1,788,124 | $1,136,535 | 63.56% |
| Pacific Asia | 2,553 | $1,280,575 | $817,516 | 63.84% |
| North America | 1,510 | $898,898 | $589,130 | 65.54% |
| Africa | 681 | $406,892 | $267,258 | 65.68% |

**Key Insights:**

- LATAM was the largest market by gross sales, generating approximately $1.81 million.
- Europe recorded the highest number of unique orders at 3,268.
- Pacific Asia ranked third in gross sales at approximately $1.28 million.
- Africa generated the lowest gross sales but recorded the highest calculated profit margin at 65.68%.
- North America recorded a profit margin of 65.54%.

**Business Recommendation:** Investigate regional demand patterns and fulfillment costs to determine where inventory allocation and logistics efficiency could be improved.

### 6. Inventory Performance

| Metric | Value |
|---|---:|
| Total Inventory Records | 4,200 |
| Unique Products | 118 |
| Reporting Period | 36 Months |
| Average Inventory Cost Per Unit | $1.24 |
| Cumulative Inventory Snapshot Value | $86,430.92 |

**Key Insights:**

- Inventory data spans January 2015 through December 2017.
- The dataset includes 118 unique products.
- The average recorded inventory cost per unit was $1.24.
- The cumulative inventory snapshot value was approximately $86,431 across all recorded product-month observations.
- Because inventory records represent monthly snapshots, the cumulative value does not represent inventory held at a single point in time.

**Business Recommendation:** Analyze monthly stock levels, inventory turnover, and potential stockout risks to improve replenishment planning.

### 7. Warehouse Fulfillment Performance

| Metric | Value |
|---|---:|
| Total Products | 118 |
| Average Fulfillment Time | 5.33 Days |
| Minimum Fulfillment Time | 1.0 Day |
| Maximum Fulfillment Time | 9.9 Days |

**Key Insights:**

- Average warehouse fulfillment time was 5.33 days.
- The fastest recorded fulfillment time was 1 day.
- The slowest recorded fulfillment time was 9.9 days.
- The 8.9-day difference between minimum and maximum fulfillment times indicates substantial variation across products.

**Business Recommendation:** Identify products with longer fulfillment times and investigate whether inventory availability, warehouse operations, or demand levels contribute to delays.

### 8. Day 1 Business Conclusions

The initial analysis establishes a baseline for supply chain performance across sales, inventory, and fulfillment operations.

**Major Findings:**

1. The combined datasets contain 35,189 records.
2. Initial data quality checks found no missing values in selected fields and no duplicate records under the tested keys.
3. Total gross sales reached $6.18 million, with reported profit of $3.99 million.
4. LATAM was the largest market by gross sales.
5. The inventory dataset contains 118 products across 36 months.
6. Average warehouse fulfillment time was 5.33 days.
7. Product revenue rankings and reported profit rankings differ, highlighting the importance of profitability analysis.

### 9. Next Steps – Day 2: Inventory & Stock Level Analysis

Day 2 will focus on:

- Monthly inventory trends.
- Low-stock and high-stock products.
- Inventory valuation by product.
- Inventory turnover and demand patterns.
- Stockout risk identification.
- Replenishment opportunities.

**Day 1 Status: Completed**

---

# Day 2: Inventory & Stock Level Analysis

## 1. Objective

The objective of Day 2 is to evaluate historical warehouse inventory levels, identify potential stockout risks, analyze product demand, measure stock coverage, and assess warehouse fulfillment performance.

The analysis combines three datasets:

- **Inventory:** Monthly stock levels and inventory unit costs.
- **Orders & Shipments:** Historical product sales, quantities, and order information.
- **Fulfillment:** Product-level warehouse fulfillment times.

**Analysis Period:** January 2015 – December 2017

**Latest Inventory Snapshot:** December 2017

---

## 2. Monthly Inventory Trends

The inventory dataset contains 4,200 records representing 118 unique products across 36 months.

### Key Inventory Metrics

| Metric | Value |
|---|---:|
| Total Products | 118 |
| Reporting Period | 36 Months |
| Latest Inventory Month | December 2017 |
| Latest Inventory Units | 394 |
| Latest Inventory Value | $458.19 |
| Average Inventory per Product | 3.34 Units |

### Inventory Trends During 2017

| Month | Total Inventory Units | Month-over-Month Change |
|---|---:|---:|
| January | 1,907 | -32.92% |
| February | 2,284 | +19.77% |
| March | 1,775 | -22.29% |
| April | 2,127 | +19.83% |
| May | 2,832 | +33.15% |
| June | 2,179 | -23.06% |
| July | 2,030 | -6.84% |
| August | 1,953 | -3.79% |
| September | 1,890 | -3.23% |
| October | 597 | -68.41% |
| November | 352 | -41.04% |
| December | 394 | +11.93% |

### Key Insights

1. Inventory fluctuated considerably throughout the three-year reporting period.
2. May 2017 recorded 2,832 inventory units, one of the highest monthly levels during 2017.
3. Inventory declined sharply during the final quarter of 2017.
4. October recorded a 68.41% decline compared with September.
5. November recorded a further 41.04% decline.
6. December inventory recovered slightly by 11.93%, reaching 394 units.
7. The final inventory level was substantially lower than levels recorded earlier in 2017.

### Business Interpretation

The significant inventory reduction in October and November may indicate stock depletion, changes in replenishment activity, or potential data completeness issues.

The available data does not establish the cause of the decline.

**Business Recommendation:** Investigate inventory replenishment patterns, product-level stock movements, and historical demand during the final quarter of 2017.

---

## 3. Highest Inventory Products

The following products recorded the highest warehouse inventory quantities in December 2017.

| Product | Stock Units | Inventory Value |
|---|---:|---:|
| Toys | 133 | $25.95 |
| DVDs | 64 | $130.27 |
| Smart watch | 42 | $66.69 |
| Bowflex SelectTech 1090 Dumbbells | 36 | $53.80 |
| SOLE E25 Elliptical | 23 | $42.39 |
| First aid kit | 18 | $3.40 |
| Rock music | 16 | $36.20 |
| Dell Laptop | 14 | $21.89 |
| Summer dresses | 13 | $17.71 |
| Bushnell Pro X7 Jolt Slope Rangefinder | 9 | $20.04 |

### Key Insights

- Toys recorded the highest stock quantity at 133 units.
- DVDs ranked second by stock quantity, with 64 units.
- Smart watches recorded 42 units.
- DVDs held the highest inventory value among the listed products, at $130.27.
- Higher inventory quantities do not necessarily correspond to higher inventory valuations.

### Business Recommendation

Evaluate products using both inventory quantity and inventory value. Products with higher stock quantities but lower demand may require different inventory management strategies from high-demand products with limited stock.

---

## 4. Low-Stock and Zero-Stock Products

Several products recorded zero warehouse inventory in December 2017.

Examples include:

| Product | December 2017 Stock |
|---|---:|
| Perfect Fitness Perfect Rip Deck | 0 |
| O'Brien Men's Neoprene Life Vest | 0 |
| Field & Stream Sportsman 16 Gun Fire Safe | 0 |
| Under Armour Girls' Toddler Spine Surge Running | 0 |
| Nike Men's CJ Elite 2 TD Football Cleat | 0 |
| Pelican Sunstream 100 Kayak | 0 |
| Diamondback Women's Serene Classic Comfort Bike | 0 |
| ENO Atlas Hammock Straps | 0 |

### Key Insights

- Multiple historically popular products had zero recorded inventory in December 2017.
- Several of these products generated substantial sales during the three-year reporting period.
- Zero recorded inventory may indicate stock depletion, discontinued products, or other inventory management decisions.
- Additional data would be required to confirm actual customer-facing stockouts.

### Business Recommendation

Review zero-stock products alongside recent sales demand, replenishment history, and product lifecycle information before determining which products require restocking.

---

## 5. Product Demand Analysis

Historical product demand was calculated using total units sold across the reporting period.

### Top 10 Products by Units Sold

| Product | Total Units Sold |
|---|---:|
| Perfect Fitness Perfect Rip Deck | 12,952 |
| Nike Men's Dri-FIT Victory Golf Polo | 10,886 |
| O'Brien Men's Neoprene Life Vest | 10,164 |
| Nike Men's Free 5.0+ Running Shoe | 6,455 |
| Under Armour Girls' Toddler Spine Surge Running | 5,689 |
| Nike Men's CJ Elite 2 TD Football Cleat | 3,855 |
| Field & Stream Sportsman 16 Gun Fire Safe | 2,878 |
| Pelican Sunstream 100 Kayak | 2,681 |
| Diamondback Women's Serene Classic Comfort Bike | 2,427 |
| Team Golf Pittsburgh Steelers Putter Grip | 194 |

### Key Insights

1. Perfect Fitness Perfect Rip Deck generated the highest sales volume, with 12,952 units.
2. Nike Men's Dri-FIT Victory Golf Polo ranked second with 10,886 units.
3. O'Brien Men's Neoprene Life Vest ranked third with 10,164 units.
4. Demand was concentrated among a relatively small number of products.
5. Several high-demand products had zero inventory in the final monthly snapshot.

### Business Recommendation

Use product demand patterns to prioritize inventory reviews and investigate whether high-volume products have adequate stock coverage.

---

## 6. Inventory Stock Coverage Analysis

Stock coverage was estimated by comparing December 2017 inventory with average monthly demand across the 36-month reporting period.

**Formula:**

Months of Stock Coverage = Latest Stock Units / Average Monthly Units Sold

Average Monthly Units Sold = Total Units Sold / 36

### Selected Product Coverage

| Product | Stock Units | Avg. Monthly Demand | Coverage (Months) |
|---|---:|---:|---:|
| Perfect Fitness Perfect Rip Deck | 0 | 359.78 | 0.00 |
| O'Brien Men's Neoprene Life Vest | 0 | 282.33 | 0.00 |
| Under Armour Girls' Toddler Spine Surge Running | 0 | 158.03 | 0.00 |
| Field & Stream Sportsman 16 Gun Fire Safe | 0 | 79.94 | 0.00 |
| Pelican Sunstream 100 Kayak | 0 | 74.47 | 0.00 |
| Sports Books | 2 | 1.56 | 1.29 |
| Lawn mower | 4 | 1.86 | 2.15 |
| Fighting video games | 4 | 1.81 | 2.22 |
| DVDs | 64 | 3.39 | 18.89 |
| Smart watch | 42 | 1.28 | 32.87 |
| Toys | 133 | 2.03 | 65.59 |

### Key Insights

- Several historically high-demand products recorded zero months of estimated stock coverage.
- Sports Books had approximately 1.29 months of coverage.
- Lawn mower and Fighting video games had approximately two months of coverage.
- Toys, DVDs, and Smart watch recorded substantially higher estimated coverage.
- High coverage may indicate excess inventory relative to historical demand, although seasonal and product lifecycle factors require consideration.

### Business Recommendation

Use stock coverage to identify potential replenishment priorities and investigate products with unusually high inventory relative to demand.

---

## 7. Stockout Risk Classification

Products were classified using estimated months of stock coverage.

### Risk Classification Criteria

| Risk Segment | Months of Coverage |
|---|---|
| Critical Risk | Less than 1 month |
| High Risk | 1 to less than 2 months |
| Moderate Risk | 2 to less than 3 months |
| Low Risk | 3 months or more |
| No Recorded Demand | No matching historical sales |

These thresholds are analytical assumptions rather than established business replenishment policies.

### Risk Distribution

| Risk Segment | Products | Total Stock Units | Average Coverage |
|---|---:|---:|---:|
| Critical Risk | 103 | 12 | 0.02 Months |
| High Risk | 1 | 2 | 1.29 Months |
| Moderate Risk | 2 | 8 | 2.18 Months |
| Low Risk | 7 | 289 | 28.73 Months |
| No Recorded Demand | 5 | 83 | N/A |
| **Total** | **118** | **394** | |

### Key Insights

1. **103 products (87.29%)** were classified as Critical Risk.
2. Only one product was classified as High Risk.
3. Two products were classified as Moderate Risk.
4. Seven products had at least three months of estimated coverage.
5. Five products had no matching recorded demand.
6. Critical-risk products collectively held only 12 inventory units.
7. Low-risk products collectively held 289 units.

### Business Interpretation

The risk distribution indicates a substantial imbalance between recorded inventory and historical demand.

However, these results do not prove that 103 products experienced actual stockout events.

### Business Recommendation

Prioritize investigation of critical-risk products, particularly those with historically high demand. Review demand recency and replenishment lead times before setting reorder quantities.

---

## 8. Inventory Valuation Analysis

Inventory valuation was calculated as:

Inventory Value = Warehouse Inventory × Inventory Cost Per Unit

### Highest Inventory Value Products

| Product | Inventory Value |
|---|---:|
| DVDs | $130.27 |
| Smart watch | $66.69 |
| Bowflex SelectTech 1090 Dumbbells | $53.80 |
| SOLE E25 Elliptical | $42.39 |
| Rock music | $36.20 |
| Toys | $25.95 |
| Dell Laptop | $21.89 |
| Bushnell Pro X7 Jolt Slope Rangefinder | $20.04 |
| Summer dresses | $17.71 |

### Key Insights

- DVDs recorded the highest inventory value at $130.27.
- Smart watch ranked second with $66.69.
- Bowflex SelectTech 1090 Dumbbells ranked third with $53.80.
- Inventory value depends on both stock quantity and recorded unit cost.
- The latest inventory valuation across all products was $458.19.

**Data Limitation:** The recorded inventory unit costs are unusually low relative to product sales prices. Their accounting meaning should be verified before interpreting these values as actual inventory carrying costs.

### Business Recommendation

Review inventory value concentration alongside sales demand to identify products that may require different stock management strategies.

---

## 9. Warehouse Fulfillment Performance

Warehouse fulfillment times were compared with December 2017 inventory levels.

### Selected Products with Longer Fulfillment Times

| Product | Stock Units | Fulfillment Days |
|---|---:|---:|
| Nike Kids' Grade School KD VI Basketball Shoe | 0 | 9.9 |
| Titleist Pro V1x Golf Balls | 0 | 9.9 |
| Elevation Training Mask 2.0 | 0 | 9.8 |
| LIJA Women's Eyelet Sleeveless Golf Polo | 0 | 9.5 |
| Nike Men's Free 5.0+ Running Shoe | 1 | 9.4 |
| Smart watch | 42 | 9.1 |
| Perfect Fitness Perfect Rip Deck | 0 | 8.3 |

### Key Insights

- Some products with zero recorded inventory also had long fulfillment times.
- Nike Kids' Grade School KD VI Basketball Shoe and Titleist Pro V1x Golf Balls recorded fulfillment times of 9.9 days.
- Nike Men's Free 5.0+ Running Shoe had one unit of inventory and a fulfillment time of 9.4 days.
- Smart watch had 42 units of inventory but still recorded a fulfillment time of 9.1 days.
- Long fulfillment times therefore cannot be attributed solely to low inventory using the available data.

### Business Recommendation

Investigate fulfillment delays using additional operational information, such as warehouse processing times, replenishment schedules, and shipping constraints.

---

## 10. Product Matching & Dataset Validation

Product names were compared across the inventory, orders, and fulfillment datasets.

| Metric | Count |
|---|---:|
| Total Distinct Products | 118 |
| Inventory Products | 118 |
| Products Present in All Three Datasets | 113 |
| Inventory Products Without Orders | 5 |
| Order Products Without Inventory | 0 |

### Key Insights

- The three datasets collectively contain 118 distinct product names.
- 113 products have matching records across all three datasets.
- Five inventory products have no matching sales records.
- Every product appearing in the orders dataset also appears in the inventory dataset.

### Business Recommendation

Use product-level matching to combine inventory, demand, and fulfillment information while retaining unmatched inventory products for separate analysis.

---

## 11. Overall Day 2 Business Conclusions

Day 2 analysis identified substantial inventory fluctuations, low stock availability, and differences between historical demand and final-period inventory levels.

### Major Findings

1. December 2017 inventory contained 394 units across 118 products.
2. Inventory declined by 68.41% in October 2017 and a further 41.04% in November.
3. 103 products were classified as Critical Risk based on estimated stock coverage.
4. Perfect Fitness Perfect Rip Deck was the highest-volume product, with 12,952 units sold during the reporting period.
5. Several historically high-demand products had zero recorded inventory in December 2017.
6. DVDs had the highest December inventory valuation at $130.27.
7. Some products with low or zero inventory also experienced long fulfillment times, but a causal relationship has not been established.
8. Product matching confirmed that 113 products appear across all three datasets.

### Strategic Recommendations

- **Inventory Monitoring:** Track stock coverage and month-over-month changes to detect unusual inventory declines.
- **Demand Planning:** Use historical sales trends and recent demand to support replenishment decisions.
- **Stockout Risk Management:** Investigate products with less than one month of estimated stock coverage.
- **Inventory Optimization:** Review products with unusually high stock coverage for possible overstock.
- **Fulfillment Efficiency:** Examine products with longer fulfillment times to identify operational bottlenecks.
- **Data Validation:** Confirm inventory cost definitions and investigate the late-2017 stock decline before making financial or operational decisions.

---

## 12. Next Steps – Day 3

Day 3 will focus on **Procurement, Warehouse & Logistics Performance**, including:

- Warehouse performance by country.
- Shipping mode distribution.
- Scheduled shipping times.
- Product-level fulfillment differences.
- Logistics cost and profitability relationships where supported by available data.
- Operational improvement opportunities.

The datasets do not contain explicit supplier identifiers or purchase-order information, so supplier reliability and procurement lead times cannot be measured directly.

**Day 2 Status: Completed**

---

# Day 3: Warehouse, Shipping & Logistics Performance

## 1. Objective

The objective of Day 3 is to evaluate warehouse performance, shipping mode distribution, regional logistics, scheduled shipping times, product fulfillment efficiency, and logistics-related data quality.

The analysis uses two primary datasets:

- **Orders & Shipments:** 30,871 order-item records containing warehouse locations, shipment modes, customer markets, scheduled shipping days, sales, and profit.
- **Fulfillment:** 118 product-level records containing warehouse order fulfillment times.

**Analysis Period:** January 2015 – December 2017

**SQL Queries:** 27–40

### Key Performance Indicators

| Metric | Value |
|---|---:|
| Total Orders | 11,072 |
| Total Order Items | 30,871 |
| Warehouse Countries | 2 |
| Shipping Modes | 4 |
| Customer Markets | 5 |
| Products with Fulfillment Records | 118 |
| Total Gross Sales | $6,181,476 |
| Reported Total Profit | $3,994,192 |

---

## 2. Warehouse Country Performance

Warehouse activity was analyzed across the USA and Puerto Rico.

| Warehouse Country | Total Orders | Order Items | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|---:|---:|
| USA | 6,825 | 18,997 | $3,798,206 | $2,458,430 | 64.73% |
| Puerto Rico | 4,247 | 11,874 | $2,383,270 | $1,535,762 | 64.44% |
| **Total** | **11,072** | **30,871** | **$6,181,476** | **$3,994,192** | **64.62%** |

### Key Insights

1. USA warehouses processed approximately 61.64% of all orders.
2. Puerto Rico warehouses processed approximately 38.36% of orders.
3. USA warehouses generated approximately $3.80 million in gross sales.
4. Puerto Rico warehouses generated approximately $2.38 million in gross sales.
5. The USA recorded a slightly higher calculated profit margin of 64.73%, compared with 64.44% for Puerto Rico.
6. Both warehouse countries contributed substantially to overall business activity.

### Business Interpretation

The USA accounted for the majority of warehouse-associated order volume and gross sales.

However, warehouse-level profitability cannot be fully evaluated without actual warehouse operating expenses and logistics costs.

**Business Recommendation:** Compare warehouse processing capacity, operational expenses, and fulfillment efficiency before making warehouse allocation decisions.

---

## 3. Shipping Mode Distribution

The dataset contains four shipping modes.

| Shipping Mode | Total Orders | Order Items | Units | Item Share |
|---|---:|---:|---:|---:|
| Standard Class | 6,457 | 17,994 | 38,765 | 58.29% |
| Second Class | 2,153 | 6,038 | 13,023 | 19.56% |
| First Class | 1,749 | 4,859 | 10,262 | 15.74% |
| Same Day | 713 | 1,980 | 4,317 | 6.41% |
| **Total** | **11,072** | **30,871** | **66,367** | **100%** |

### Key Insights

1. Standard Class was the most frequently used shipping mode, accounting for 58.29% of order items.
2. Second Class represented 19.56% of order items.
3. First Class accounted for 15.74%.
4. Same Day was the least frequently used shipping mode, representing 6.41%.
5. Standard Class generated the largest shipping-related order volume.

### Business Interpretation

The business relied primarily on Standard Class shipping.

This distribution may reflect customer preferences, shipping policies, or available fulfillment options. The dataset does not establish why customers selected each mode.

**Business Recommendation:** Evaluate shipping mode usage alongside actual delivery performance, customer satisfaction, and logistics expenses when those data become available.

---

## 4. Scheduled Shipping Days Analysis

Scheduled shipping days were compared across the four shipping modes.

| Shipping Mode | Average Scheduled Days | Maximum Scheduled Days | Standard Deviation |
|---|---:|---:|---:|
| Standard Class | 4.00 | 4.00 | 0.00 |
| Same Day | 3.00 | 3.00 | 0.00 |
| Second Class | 2.00 | 2.00 | 0.00 |
| First Class | 1.00 | 1.00 | 0.00 |

### Key Insights

- Standard Class had the longest scheduled shipping duration at four days.
- First Class had the shortest scheduled shipping duration at one day.
- Second Class was consistently scheduled for two days.
- Same Day was consistently recorded with a three-day scheduled duration.
- Scheduled shipping days showed no variation within each shipping mode.

### Important Data Observation

The Same Day shipping mode was assigned three scheduled days, which is inconsistent with the usual interpretation of same-day delivery.

This may reflect a dataset-specific definition, data transformation, or source-system mapping.

The underlying cause cannot be determined from the available records.

### Business Recommendation

Validate the business definition of scheduled shipping days and the mapping between shipment modes and scheduled durations before using these fields to evaluate delivery commitments.

---

## 5. Customer Market & Shipping Mode Performance

Shipping mode usage was analyzed across five customer markets:

- Africa
- Europe
- LATAM
- North America
- Pacific Asia

### Standard Class Performance by Market

| Customer Market | Standard Class Orders | Gross Sales |
|---|---:|---:|
| Europe | 1,912 | $1,026,399 |
| LATAM | 1,784 | $1,062,165 |
| Pacific Asia | 1,474 | $747,308 |
| North America | 861 | $514,038 |
| Africa | 426 | $249,470 |

### Key Insights

1. Standard Class was the leading shipping mode in every customer market.
2. Europe recorded the highest Standard Class order count, with 1,912 orders.
3. LATAM generated the highest Standard Class gross sales, at approximately $1.06 million.
4. Pacific Asia ranked third in Standard Class order volume.
5. Scheduled shipping durations remained consistent by shipping mode across all customer markets.

### Business Recommendation

Investigate regional shipping demand and customer preferences to determine whether shipping service offerings align with market requirements.

---

## 6. Customer Region Performance

The top customer regions were ranked by unique order volume.

### Leading Customer Regions

| Customer Region | Market | Orders | Gross Sales | Reported Profit |
|---|---|---:|---:|---:|
| Western Europe | Europe | 1,743 | $967,053 | $613,574 |
| Central America | LATAM | 1,705 | $1,019,057 | $666,514 |
| South America | LATAM | 897 | $523,447 | $341,756 |
| Northern Europe | Europe | 693 | $372,500 | $235,607 |
| Southeast Asia | Pacific Asia | 622 | $314,263 | $201,252 |

### Key Insights

- Western Europe generated the highest number of orders among individual customer regions.
- Central America generated the highest gross sales among the leading regions, at approximately $1.02 million.
- Central America also recorded the highest reported profit among these regions.
- South America ranked third by order volume.
- Demand was distributed across multiple geographic markets.

### Business Recommendation

Use regional demand concentration to support warehouse capacity planning, shipment allocation, and future logistics network optimization.

---

## 7. Warehouse Country vs. Customer Market

The analysis examined which warehouse countries served different customer markets.

### Selected Warehouse-Market Relationships

| Warehouse Country | Customer Market | Orders | Gross Sales | Avg. Scheduled Days |
|---|---|---:|---:|---:|
| USA | Europe | 1,995 | $1,092,668 | 3.04 |
| USA | LATAM | 1,864 | $1,101,937 | 3.11 |
| USA | Pacific Asia | 1,597 | $788,808 | 3.07 |
| Puerto Rico | Europe | 1,273 | $695,456 | 3.10 |
| Puerto Rico | LATAM | 1,196 | $705,050 | 3.02 |
| Puerto Rico | Pacific Asia | 956 | $491,767 | 3.07 |

### Key Insights

1. Both warehouse countries served customers across multiple international markets.
2. USA warehouses processed more orders than Puerto Rico warehouses in the major markets shown.
3. USA-to-Europe recorded the highest order count among the warehouse-market combinations.
4. USA-to-LATAM generated the highest gross sales among these combinations.
5. Average scheduled shipping times across these warehouse-market combinations ranged from approximately 3.02 to 3.11 days.

### Business Interpretation

Scheduled shipping times were similar across major warehouse-market combinations.

This reflects the distribution of shipping modes rather than verified physical transportation time.

**Business Recommendation:** Analyze actual delivery timestamps and transportation costs to determine whether warehouse location affects delivery efficiency.

---

## 8. Warehouse Country vs. Shipping Mode

Shipping activity was analyzed separately for USA and Puerto Rico warehouses.

### USA Warehouses

| Shipping Mode | Orders | Order Items | Gross Sales |
|---|---:|---:|---:|
| Standard Class | 3,990 | 11,058 | $2,214,155 |
| Second Class | 1,326 | 3,706 | $735,957 |
| First Class | 1,058 | 2,939 | $593,443 |
| Same Day | 451 | 1,294 | $254,651 |

### Puerto Rico Warehouses

| Shipping Mode | Orders | Order Items | Gross Sales |
|---|---:|---:|---:|
| Standard Class | 2,467 | 6,936 | $1,385,225 |
| Second Class | 827 | 2,332 | $472,234 |
| First Class | 691 | 1,920 | $389,296 |
| Same Day | 262 | 686 | $136,515 |

### Key Insights

- Standard Class was the dominant shipping mode in both warehouse countries.
- USA warehouses processed more orders and order items across all four shipping modes.
- Puerto Rico also relied heavily on Standard Class.
- Scheduled shipping days were identical for the same mode regardless of warehouse country.

### Business Recommendation

Compare warehouse-specific shipment processing times and actual logistics expenses to identify operational efficiency opportunities.

---

## 9. Product Fulfillment Performance

Product-level warehouse fulfillment times were classified into three categories.

### Fulfillment Classification

| Category | Definition |
|---|---|
| Fast Fulfillment | 4 days or less |
| Moderate Fulfillment | More than 4 and up to 7 days |
| Slow Fulfillment | More than 7 days |

### Fulfillment Results

| Category | Products | Average Days | Minimum Days | Maximum Days |
|---|---:|---:|---:|---:|
| Slow Fulfillment | 28 | 8.57 | 7.1 | 9.9 |
| Moderate Fulfillment | 53 | 5.60 | 4.1 | 7.0 |
| Fast Fulfillment | 37 | 2.51 | 1.0 | 3.9 |
| **Total** | **118** | | | |

### Key Insights

1. 28 products were classified as Slow Fulfillment.
2. 53 products were classified as Moderate Fulfillment.
3. 37 products were classified as Fast Fulfillment.
4. Slow-fulfillment products averaged 8.57 days.
5. Fast-fulfillment products averaged 2.51 days.
6. The difference between average slow and fast fulfillment times was 6.06 days.

### Business Recommendation

Investigate products with fulfillment times exceeding seven days to identify potential warehouse processing bottlenecks and replenishment constraints.

---

## 10. Products with the Longest Fulfillment Times

| Product | Fulfillment Days |
|---|---:|
| Titleist Pro V1x Golf Balls | 9.9 |
| Nike Kids' Grade School KD VI Basketball Shoe | 9.9 |
| Elevation Training Mask 2.0 | 9.8 |
| LIJA Women's Eyelet Sleeveless Golf Polo | 9.5 |
| Bridgestone e6 Straight Distance NFL Tennessee | 9.5 |
| Nike Men's Free 5.0+ Running Shoe | 9.4 |
| Rock music | 9.3 |
| adidas Brazuca 2017 Official Match Ball | 9.3 |
| Columbia Men's PFG Anchor Tough T-Shirt | 9.1 |
| Team Golf Pittsburgh Steelers Putter Grip | 9.1 |

### Key Insights

- Two products recorded the maximum fulfillment time of 9.9 days.
- Several products required more than nine days for warehouse fulfillment.
- Nike Men's Free 5.0+ Running Shoe was among the slowest products, despite substantial historical demand.

### Business Recommendation

Prioritize products with long fulfillment times and significant demand when investigating operational improvements.

---

## 11. Product Demand vs. Fulfillment Time

Product sales volume was compared with warehouse fulfillment duration.

### Selected High-Demand Products

| Product | Units Sold | Fulfillment Days | Category |
|---|---:|---:|---|
| Perfect Fitness Perfect Rip Deck | 12,952 | 8.3 | Slow |
| Nike Men's Dri-FIT Victory Golf Polo | 10,886 | 6.6 | Moderate |
| O'Brien Men's Neoprene Life Vest | 10,164 | 5.5 | Moderate |
| Nike Men's Free 5.0+ Running Shoe | 6,455 | 9.4 | Slow |
| Under Armour Girls' Toddler Spine Surge Running | 5,689 | 6.3 | Moderate |
| Nike Men's CJ Elite 2 TD Football Cleat | 3,855 | 7.0 | Moderate |
| Field & Stream Sportsman 16 Gun Fire Safe | 2,878 | 4.9 | Moderate |
| Pelican Sunstream 100 Kayak | 2,681 | 1.8 | Fast |

### Key Insights

1. Perfect Fitness Perfect Rip Deck had the highest demand, with 12,952 units sold, and a fulfillment time of 8.3 days.
2. Nike Men's Free 5.0+ Running Shoe sold 6,455 units and required 9.4 fulfillment days.
3. Pelican Sunstream 100 Kayak recorded a relatively fast fulfillment time of 1.8 days.
4. High sales volume did not consistently correspond to faster warehouse fulfillment.
5. Some of the most frequently purchased products experienced relatively long fulfillment times.

### Business Recommendation

Focus operational reviews on high-demand products with slow fulfillment, as improvements in these products may benefit a substantial portion of historical demand.

---

## 12. Monthly Shipping Activity

Monthly shipping activity was analyzed from January 2015 through December 2017.

### Selected Monthly Performance

| Month | Orders | Order Items | Gross Sales |
|---|---:|---:|---:|
| August 2016 | 613 | 1,034 | $203,949 |
| September 2017 | 477 | 935 | $200,518 |
| October 2017 | 355 | 363 | $96,605 |
| November 2017 | 346 | 348 | $84,814 |
| December 2017 | 319 | 323 | $46,069 |

### Key Insights

- August 2016 recorded the highest monthly order count in the output, with 613 orders.
- Order activity declined significantly during the final quarter of 2017.
- September 2017 recorded 477 orders.
- October 2017 declined to 355 orders.
- November 2017 recorded 346 orders.
- December 2017 declined further to 319 orders.
- Gross sales decreased substantially during the same period.

### Cross-Day Finding: Inventory and Order Activity

Day 2 identified a sharp reduction in inventory during October and November 2017.

Day 3 identified a corresponding decline in order activity and gross sales during the final quarter of 2017.

This suggests a period of significant operational change or potential data irregularity.

However, the analysis does not establish whether inventory shortages caused the sales decline.

### Business Recommendation

Investigate the late-2017 decline by comparing order demand, product availability, replenishment records, and dataset completeness.

---

## 13. Shipping Mode Profitability

| Shipping Mode | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|
| Standard Class | $3,599,380 | $2,327,869 | 64.67% |
| Second Class | $1,208,191 | $780,178 | 64.57% |
| First Class | $982,739 | $633,528 | 64.47% |
| Same Day | $391,166 | $252,617 | 64.58% |

### Key Insights

1. Standard Class generated the highest gross sales and reported profit.
2. Profit margins were relatively consistent across all four shipping modes.
3. Standard Class recorded the highest calculated margin at 64.67%.
4. First Class recorded the lowest calculated margin at 64.47%.
5. The difference between the highest and lowest margins was only 0.20 percentage points.

### Business Interpretation

The reported profit measure does not separately identify shipping expenses.

Therefore, the results cannot establish which shipping mode is most profitable after logistics costs.

**Business Recommendation:** Incorporate actual shipping charges, carrier expenses, and fulfillment costs into future shipping profitability analysis.

---

## 14. Long Scheduled Shipping Analysis

Query 38 evaluated shipments scheduled for more than five days.

### Results

- No order items were scheduled for more than five days.
- Every shipping mode recorded a fixed scheduled duration between one and four days.
- The percentage of items scheduled for more than five days was 0% across all shipping mode and customer market combinations.

### Key Insight

The absence of scheduled durations exceeding five days is a consequence of the recorded shipping mode schedules.

It does not prove that actual deliveries were completed within five days.

### Business Recommendation

Use actual delivery dates, when available, to calculate delivery delays, on-time performance, and service-level compliance.

---

## 15. Logistics Data Quality Validation

Query 40 validated key logistics fields across 30,871 order-item records.

### Confirmed Results

| Validation Check | Result |
|---|---:|
| Total Order Items | 30,871 |
| Missing Shipment Modes | 0 |
| Negative Scheduled Shipping Days | 0 |
| Missing Shipment Date Components | 0 |
| Invalid Shipment Dates | 0 |

The displayed output truncated the values for missing warehouse countries and missing scheduled shipping days. These two checks require confirmation before reporting them as zero.

### Key Insights

- No missing shipment modes were identified.
- No negative scheduled shipping durations were detected.
- Shipment date components were populated.
- No invalid shipment dates were detected by the SQL validation.
- The fixed shipping schedules and Same Day labeling discrepancy remain important business-definition questions.

### Business Recommendation

Document the shipping mode definitions and validate the remaining data quality fields before using the dataset for production-level operational reporting.

---

## 16. Overall Day 3 Business Conclusions

Day 3 analysis evaluated warehouse operations, shipping mode distribution, regional demand, fulfillment efficiency, and scheduled shipping performance.

### Major Findings

1. USA warehouses processed 6,825 orders, accounting for approximately 61.64% of total orders.
2. Standard Class was the dominant shipping mode, representing 58.29% of order items.
3. Scheduled shipping durations were fixed by shipping mode.
4. Same Day shipping was recorded with a three-day schedule, indicating a potential business-definition or data-mapping issue.
5. Western Europe recorded the highest order count among customer regions.
6. Central America generated the highest gross sales among the leading regions.
7. 28 products were classified as Slow Fulfillment.
8. Perfect Fitness Perfect Rip Deck combined the highest sales volume with a relatively long fulfillment time of 8.3 days.
9. Order volume and gross sales declined substantially in the final quarter of 2017.
10. Initial logistics data quality checks found no missing shipment modes, negative scheduled durations, or invalid shipment dates.

### Strategic Recommendations

**Warehouse Optimization:** Evaluate warehouse capacity, shipment processing efficiency, and regional demand.

**Shipping Mode Management:** Validate shipping mode definitions and assess whether shipping services align with customer expectations.

**Fulfillment Improvement:** Prioritize high-demand products with fulfillment times exceeding seven days.

**Regional Logistics Planning:** Use regional order volume and warehouse allocation data to support logistics planning.

**Operational Monitoring:** Investigate the simultaneous decline in inventory and order activity during late 2017.

**Data Quality Governance:** Validate shipping schedules and logistics field completeness before using the results for operational decision-making.

---

## 17. Next Steps – Day 4

Day 4 will focus on **Sales, Profitability & Demand Analysis**, including:

- Monthly and yearly sales trends.
- Product category profitability.
- Customer market profitability.
- High-revenue and low-profit products.
- Product demand concentration.
- Seasonal demand patterns.
- Revenue growth and decline analysis.
- Sales performance recommendations.

**Day 3 Status: Completed**

---

# Day 4: Sales, Profitability & Demand Analytics

## 1. Objective

The objective of Day 4 is to analyze historical sales performance, profitability, product demand, customer markets, revenue concentration, and seasonal sales patterns.

This analysis uses the `orders_shipments` dataset and focuses on understanding business performance from January 2015 through December 2017.

**Analysis Scope:**
- SQL Queries: 41–55
- Analysis Period: January 2015 – December 2017
- Primary Table: `orders_shipments`
- Total Order-Item Records: 30,871
- Product Departments: 11
- Customer Markets: 5

### Overall Business KPIs

| Metric | Value |
|---|---:|
| Total Order-Item Records | 30,871 |
| Distinct Order IDs | 11,072 |
| Distinct Order ID + Date Combinations | 19,966 |
| Total Gross Sales | $6,181,476 |
| Reported Profit | $3,994,192 |
| Overall Reported Profit Margin | 64.62% |

**Data Interpretation:** Distinct order IDs do not represent confirmed unique business orders because order IDs are reused across dates. Order-level metrics require additional validation.

---

## 2. Yearly Sales & Profit Performance

**SQL Query 41 – Yearly Sales and Profitability**

| Year | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|
| 2015 | $2,112,579 | $1,379,939 | 65.32% |
| 2016 | $2,213,350 | $1,446,057 | 65.33% |
| 2017 | $1,855,547 | $1,168,196 | 62.96% |
| **Total** | **$6,181,476** | **$3,994,192** | **64.62%** |

### Key Findings

1. 2016 generated the highest annual gross sales, at approximately $2.21 million.
2. 2016 also generated the highest reported profit, at approximately $1.45 million.
3. Gross sales declined to approximately $1.86 million in 2017.
4. The reported profit margin remained stable between 2015 and 2016.
5. The reported profit margin declined by 2.37 percentage points between 2016 and 2017.

### Business Interpretation

Business performance improved in 2016 but weakened in 2017.

The 2017 decline affected both gross sales and reported profitability.

**Recommendation:** Investigate the drivers of declining sales and margins, particularly changes in product mix, demand, inventory availability, and reported profit composition.

---

## 3. Year-over-Year Revenue Growth

**SQL Query 42 – Year-over-Year Sales Growth**

| Year | Gross Sales | Previous Year Sales | YoY Growth |
|---|---:|---:|---:|
| 2015 | $2,112,579 | — | — |
| 2016 | $2,213,350 | $2,112,579 | +4.77% |
| 2017 | $1,855,547 | $2,213,350 | -16.17% |

### Key Findings

- Revenue increased by 4.77% in 2016.
- Revenue declined by 16.17% in 2017.
- The 2017 revenue decline amounted to $357,803 compared with 2016.
- The decline reversed the previous year's positive growth.

### Business Interpretation

The business experienced a significant reversal in revenue growth during 2017.

**Recommendation:** Compare monthly sales, customer demand, product availability, and order composition to determine which factors contributed to the decline.

---

## 4. Monthly Sales & Profit Trends

**SQL Query 43 – Monthly Sales Performance**

Monthly sales were analyzed across all 36 months.

### Selected Monthly Results

| Month | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|
| January 2015 | $194,792 | $129,546 | 66.50% |
| August 2016 | $203,949 | $134,801 | 66.10% |
| September 2017 | $200,518 | $126,684 | 63.18% |
| October 2017 | $96,605 | $51,105 | 52.90% |
| November 2017 | $84,814 | $44,248 | 52.17% |
| December 2017 | $46,069 | $23,793 | 51.65% |

### Key Findings

1. August 2016 recorded the highest monthly gross sales, at $203,949.
2. September 2017 generated $200,518 in gross sales.
3. October 2017 revenue dropped substantially to $96,605.
4. November 2017 revenue declined further to $84,814.
5. December 2017 recorded the lowest monthly gross sales, at $46,069.
6. The reported profit margin declined from 63.18% in September 2017 to 51.65% in December 2017.

### Business Interpretation

The final quarter of 2017 experienced a substantial deterioration in revenue and reported profit margins.

This pattern aligns with the late-2017 inventory and order-activity declines identified during Days 2 and 3.

However, the available data does not establish a causal relationship between inventory levels and sales performance.

**Recommendation:** Investigate the final quarter of 2017 for potential demand changes, product availability issues, operational changes, and dataset completeness.

---

## 5. Top 10 Revenue-Generating Months

**SQL Query 44 – Highest Monthly Gross Sales**

| Rank | Month | Gross Sales |
|---|---|---:|
| 1 | August 2016 | $203,949 |
| 2 | September 2017 | $200,518 |
| 3 | October 2016 | $199,842 |
| 4 | July 2016 | $199,063 |
| 5 | November 2016 | $196,108 |
| 6 | January 2015 | $194,792 |
| 7 | January 2016 | $193,825 |
| 8 | July 2017 | $189,340 |
| 9 | May 2016 | $187,525 |
| 10 | April 2015 | $185,757 |

### Key Findings

- August 2016 was the strongest revenue month.
- Several of the highest-performing months occurred in 2016.
- September 2017 was the second-highest revenue month despite the decline that followed.
- Strong months occurred at different points throughout the year.

### Business Recommendation

Investigate the products, customer markets, and demand conditions associated with high-revenue months to identify repeatable performance drivers.

---

## 6. Product Department Sales & Profitability

**SQL Query 45 – Department Performance**

| Department | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|
| Fan Shop | $2,934,670 | $1,641,468 | 55.93% |
| Apparel | $1,341,243 | $912,034 | 68.00% |
| Golf | $805,305 | $655,012 | 81.34% |
| Footwear | $697,686 | $554,792 | 79.52% |
| Outdoors | $200,834 | $124,969 | 62.23% |
| Technology | $98,982 | $47,979 | 48.47% |
| Fitness | $59,268 | $37,363 | 63.04% |
| Discs Shop | $26,955 | $12,791 | 47.45% |
| Health and Beauty | $8,497 | $3,944 | 46.42% |
| Pet Shop | $6,300 | $3,000 | 47.62% |
| Book Shop | $1,736 | $840 | 48.39% |

### Key Findings

1. Fan Shop generated the highest revenue at approximately $2.93 million.
2. Apparel was the second-largest revenue contributor.
3. Golf recorded the highest department-level profit margin at 81.34%.
4. Footwear recorded the second-highest margin at 79.52%.
5. Fan Shop generated the most reported profit in absolute dollars despite its lower margin.
6. Technology, Discs Shop, and Health and Beauty recorded margins below 50%.

### Business Interpretation

High revenue does not necessarily correspond to the highest percentage profitability.

Fan Shop generated substantial sales volume, while Golf and Footwear demonstrated stronger reported profit margins.

**Recommendation:** Evaluate department-level revenue contribution and profit margin together when planning inventory allocation and product strategies.

---

## 7. Product Category Profitability

**SQL Query 46 – Top 15 Categories by Reported Profit**

### Leading Product Categories

| Department | Product Category | Gross Sales | Reported Profit | Profit Margin |
|---|---|---:|---:|---:|
| Apparel | Cleats | $778,920 | $631,740 | 81.10% |
| Fan Shop | Fishing | $1,151,200 | $575,600 | 50.00% |
| Footwear | Cardio Equipment | $650,270 | $524,390 | 80.64% |
| Golf | Women's Apparel | $544,300 | $452,750 | 83.18% |
| Fan Shop | Indoor/Outdoor Games | $508,200 | $427,000 | 84.02% |
| Fan Shop | Camping & Hiking | $728,100 | $364,050 | 50.00% |
| Fan Shop | Water Sports | $538,650 | $269,304 | 50.00% |
| Apparel | Men's Footwear | $501,150 | $250,575 | 50.00% |
| Golf | Shop By Sport | $234,740 | $184,550 | 78.62% |
| Technology | Cameras | $86,332 | $41,829 | 48.45% |

### Key Findings

- Cleats generated the highest category-level reported profit, at $631,740.
- Fishing generated the highest gross sales among the leading categories, at $1,151,200.
- Indoor/Outdoor Games recorded a high profit margin of 84.02%.
- Women's Apparel within Golf recorded a margin of 83.18%.
- Several high-revenue categories had margins of approximately 50%.

### Business Recommendation

Prioritize categories using both total profit contribution and percentage margin, rather than revenue alone.

---

## 8. Customer Market Profitability

**SQL Query 47 – Market-Level Profitability**

| Customer Market | Gross Sales | Reported Profit | Profit Margin |
|---|---:|---:|---:|
| LATAM | $1,806,987 | $1,183,753 | 65.51% |
| Europe | $1,788,124 | $1,136,535 | 63.56% |
| Pacific Asia | $1,280,575 | $817,516 | 63.84% |
| North America | $898,898 | $589,130 | 65.54% |
| Africa | $406,892 | $267,258 | 65.68% |

### Key Findings

1. LATAM generated the highest gross sales and reported profit.
2. Europe ranked second in gross sales and reported profit.
3. Pacific Asia generated approximately $1.28 million in revenue.
4. Africa recorded the highest percentage profit margin at 65.68%.
5. Europe recorded the lowest market-level margin at 63.56%.
6. Profit margins remained relatively close across the five markets.

### Business Interpretation

LATAM was the largest contributor to reported profit, while Africa achieved the highest percentage margin.

However, Africa's total revenue was substantially smaller than LATAM's.

**Recommendation:** Use market-level revenue, profit contribution, and margin together when evaluating regional growth opportunities.

---

## 9. Top 15 Products by Reported Profit

**SQL Query 48 – Product Profitability Ranking**

### Leading Products

| Product | Gross Sales | Reported Profit | Margin |
|---|---:|---:|---:|
| Perfect Fitness Perfect Rip Deck | $777,120 | $630,924 | 81.19% |
| Field & Stream Sportsman 16 Gun Fire Safe | $1,151,200 | $575,600 | 50.00% |
| Nike Men's Free 5.0+ Running Shoe | $645,500 | $520,870 | 80.69% |
| Nike Men's Dri-FIT Victory Golf Polo | $544,300 | $452,750 | 83.18% |
| O'Brien Men's Neoprene Life Vest | $508,200 | $427,000 | 84.02% |
| Diamondback Women's Serene Classic Comfort Bi | $728,100 | $364,050 | 50.00% |
| Pelican Sunstream 100 Kayak | $536,200 | $268,100 | 50.00% |
| Nike Men's CJ Elite 2 TD Football Cleat | $501,150 | $250,575 | 50.00% |
| Under Armour Girls' Toddler Spine Surge Running | $227,560 | $180,420 | 79.28% |
| Web Camera | $86,332 | $41,829 | 48.45% |

### Key Findings

- Perfect Fitness Perfect Rip Deck generated the highest reported profit, at $630,924.
- Field & Stream Sportsman 16 Gun Fire Safe generated the highest gross sales, at $1,151,200.
- Nike Men's Free 5.0+ Running Shoe generated $520,870 in reported profit.
- O'Brien Men's Neoprene Life Vest recorded the highest margin among these leading products, at 84.02%.
- Several high-revenue products recorded margins of exactly 50%.

### Cross-Day Insight

Day 3 identified relatively long fulfillment times for two high-profit products:

- Perfect Fitness Perfect Rip Deck: 8.3 days.
- Nike Men's Free 5.0+ Running Shoe: 9.4 days.

These products combine substantial business value with relatively slow warehouse fulfillment.

**Recommendation:** Prioritize operational reviews of high-profit, high-demand products with extended fulfillment times.

---

## 10. Bottom 15 Products by Profit Margin

**SQL Query 49 – Lowest Profit Margins**

The query included products with at least 10 order-item records and positive gross sales.

### Selected Lowest-Margin Products

| Product | Gross Sales | Reported Profit | Margin |
|---|---:|---:|---:|
| GolfBuddy VT3 GPS Watch | $2,200 | $693 | 31.50% |
| Nike Men's Kobe IX Elite Low Basketball Shoe | $2,800 | $980 | 35.00% |
| insta-bed Neverflat Air Mattress | $1,650 | $660 | 40.00% |
| Rock music | $3,654 | $1,540 | 42.15% |
| Merrell Women's Siren Mid Waterproof Hiking B | $1,755 | $767 | 43.70% |
| Fitbit The One Wireless Activity & Sleep Tracker | $3,200 | $1,404 | 43.88% |
| LIJA Women's Mid-Length Panel Golf Shorts | $3,300 | $1,452 | 44.00% |
| LIJA Women's Button Golf Dress | $1,296 | $576 | 44.44% |
| Yakima DoubleDown Ace Hitch Mount 4-Bike Rack | $2,268 | $1,020 | 44.97% |
| Nike Men's Fingertrap Max Training Shoe | $1,625 | $741 | 45.60% |
| Summer dresses | $14,904 | $6,831 | 45.83% |
| Merrell Women's Grassbow Sport Waterproof Hiking | $1,430 | $660 | 46.15% |
| Cleveland Golf Collegiate My Custom Wedge 588 | $2,310 | $1,067 | 46.19% |
| adidas Brazuca 2017 Official Match Ball | $1,600 | $740 | 46.25% |
| First aid kit | $8,497 | $3,944 | 46.42% |

### Key Findings

1. GolfBuddy VT3 GPS Watch had the lowest reported margin at 31.50%.
2. Nike Men's Kobe IX Elite Low Basketball Shoe recorded a margin of 35.00%.
3. Several low-margin products had relatively small sales volumes.
4. Summer dresses generated $14,904 in gross sales with a 45.83% margin.
5. Lower percentage margins do not necessarily indicate negative reported profit.

### Business Recommendation

Review lower-margin products for pricing, discounting, and cost structure opportunities, while considering their absolute profit contribution and demand.

---

## 11. Revenue Concentration Analysis

**SQL Query 50 – Top 10 Products by Revenue**

| Rank | Product | Gross Sales | Revenue Share | Cumulative Share |
|---|---|---:|---:|---:|
| 1 | Field & Stream Sportsman 16 Gun Fire Safe | $1,151,200 | 18.62% | 18.62% |
| 2 | Perfect Fitness Perfect Rip Deck | $777,120 | 12.57% | 31.20% |
| 3 | Diamondback Women's Serene Classic Comfort Bi | $728,100 | 11.78% | 42.97% |
| 4 | Nike Men's Free 5.0+ Running Shoe | $645,500 | 10.44% | 53.42% |
| 5 | Nike Men's Dri-FIT Victory Golf Polo | $544,300 | 8.81% | 62.22% |
| 6 | Pelican Sunstream 100 Kayak | $536,200 | 8.67% | 70.90% |
| 7 | O'Brien Men's Neoprene Life Vest | $508,200 | 8.22% | 79.12% |
| 8 | Nike Men's CJ Elite 2 TD Football Cleat | $501,150 | 8.11% | 87.22% |
| 9 | Under Armour Girls' Toddler Spine Surge Running | $227,560 | 3.68% | 90.91% |
| 10 | Web Camera | $86,332 | 1.40% | 92.30% |

### Key Findings

- The highest-revenue product contributed 18.62% of total gross sales.
- The top two products generated approximately 31.20% of total revenue.
- The top five products generated approximately 62.22%.
- The top ten products generated 92.30% of total gross sales.
- The remaining products collectively generated approximately 7.70%.

### Business Interpretation

Revenue was highly concentrated among a relatively small group of products.

This creates potential business exposure if demand, inventory availability, or fulfillment performance changes for these products.

### Business Recommendation

Monitor top-selling products closely and evaluate opportunities to diversify revenue across additional products.

---

## 12. Month-over-Month Revenue Growth

**SQL Query 51 – Monthly Revenue Growth**

### Selected Growth Results

| Month | Gross Sales | Revenue Change | MoM Growth |
|---|---:|---:|---:|
| January 2016 | $193,825 | +$22,362 | +13.04% |
| July 2016 | $199,063 | +$30,613 | +18.17% |
| October 2016 | $199,842 | +$26,851 | +15.52% |
| February 2017 | $184,755 | +$23,025 | +14.24% |
| September 2017 | $200,518 | +$19,359 | +10.69% |
| October 2017 | $96,605 | -$103,913 | -51.82% |
| November 2017 | $84,814 | -$11,791 | -12.21% |
| December 2017 | $46,069 | -$38,745 | -45.68% |

### Key Findings

1. July 2016 recorded strong month-over-month growth of 18.17%.
2. October 2016 grew by 15.52%.
3. September 2017 grew by 10.69%.
4. October 2017 experienced a 51.82% revenue decline.
5. November 2017 declined by another 12.21%.
6. December 2017 declined by a further 45.68%.

### Business Interpretation

The final quarter of 2017 represents the most significant period of sustained revenue deterioration in the analyzed results.

### Business Recommendation

Investigate the sharp decline by examining product availability, sales mix, customer demand, and potential source-data changes.

---

## 13. Monthly Demand Seasonality

**SQL Query 52 – Month-of-Year Sales Patterns**

Sales were aggregated by calendar month across 2015–2017.

| Month | Units Sold | Gross Sales |
|---|---:|---:|
| January | 6,215 | $550,347 |
| February | 5,924 | $526,085 |
| March | 6,014 | $526,883 |
| April | 5,988 | $535,921 |
| May | 5,880 | $531,347 |
| June | 5,556 | $525,507 |
| July | 6,045 | $560,527 |
| August | 5,920 | $562,055 |
| September | 5,656 | $541,157 |
| October | 4,603 | $477,650 |
| November | 4,395 | $450,043 |
| December | 4,171 | $393,954 |

### Key Findings

- August generated the highest aggregate gross sales, at $562,055.
- July ranked second, at $560,527.
- January recorded the highest aggregate units sold, at 6,215.
- December recorded the lowest aggregate gross sales and units sold.
- October through December showed weaker aggregate sales compared with most earlier months.

### Important Limitation

The late-2017 revenue decline affects the aggregated October–December results.

Therefore, these results should not be interpreted as definitive evidence of recurring seasonal demand without comparing individual years and investigating the 2017 anomaly.

### Business Recommendation

Perform year-specific seasonal comparisons before using these patterns for demand forecasting or inventory planning.

---

## 14. Average Order Value Analysis

**SQL Query 53 – Average Order Value by Year**

| Year | Distinct Year-Order ID Groups | Calculated Average Order Value | Avg. Reported Profit per Group | Avg. Units per Group |
|---|---:|---:|---:|---:|
| 2015 | 4,837 | $436.75 | $285.29 | 4.85 |
| 2016 | 5,146 | $430.11 | $281.01 | 4.80 |
| 2017 | 4,718 | $393.29 | $247.60 | 3.86 |

### Key Findings

- The calculated average order value declined across the three years.
- The 2017 average was approximately $43.46 lower than the 2015 average.
- The average number of units per year-order group also declined.

### Data Quality Qualification

The query groups records by `order_year` and `order_id`.

Additional validation established that the same order ID can occur on multiple dates within the same year.

Consequently, these values are **averages per year-order ID group**, not verified average values per individual business order.

The apparent trend should be re-evaluated using a validated order-level identifier.

### Business Recommendation

Confirm the source-system business order key before using average order value as an operational KPI.

---

## 15. Top Customers by Gross Sales

**SQL Query 54 – Customer Revenue Ranking**

| Customer ID | Reported Distinct Order IDs | Gross Sales | Reported Profit |
|---|---:|---:|---:|
| 9897 | 5 | $4,570 | $2,633 |
| 11816 | 4 | $3,805 | $2,246 |
| 9277 | 6 | $3,740 | $2,585 |
| 3297 | 3 | $3,720 | $2,037 |
| 5363 | 4 | $3,640 | $1,954 |
| 2922 | 4 | $3,635 | $2,031 |
| 6300 | 4 | $3,525 | $2,051 |
| 8078 | 4 | $3,505 | $2,288 |
| 6724 | 3 | $3,500 | $2,205 |
| 5958 | 4 | $3,486 | $2,310 |

### Key Findings

1. Customer 9897 generated the highest gross sales, at $4,570.
2. Customer 11816 ranked second with $3,805.
3. Customer 9277 ranked third with $3,740.
4. The leading customers generated multiple recorded order-item transactions.
5. Customer-level gross sales and reported profit can be compared without relying on a unique order key.

### Important Limitation

The reported distinct order ID counts may undercount actual customer orders when identifiers are reused.

**Recommendation:** Validate order-level identifiers before calculating customer purchase frequency or repeat-order metrics.

---

## 16. Sales Data Quality Validation

**SQL Query 55 – Sales Data Quality**

### Confirmed Results

| Validation Check | Result |
|---|---:|
| Total Order-Item Records | 30,871 |
| Missing Order IDs | 0 |
| Missing Customer IDs | 0 |
| Negative Gross Sales | 0 |
| Missing Order Date Components | 0 |

The displayed output truncated three additional validation fields:

- Missing gross sales
- Missing profit
- Invalid order quantities

These should be confirmed before reporting complete data quality compliance.

### Key Finding

Although the displayed checks did not identify missing identifiers or negative gross sales, additional validation revealed reuse of order IDs across years and dates.

This is a significant data-modeling consideration for order-level analytics.

---

## 17. Additional Validation: Order Identifier Reuse

Additional SQL checks were performed after Query 55 to investigate inconsistent distinct order counts.

### Validation Results

| Metric | Count |
|---|---:|
| Total Order-Item Records | 30,871 |
| Distinct Order IDs | 11,072 |
| Distinct Year + Order ID Combinations | 14,701 |
| Distinct Order ID + Full Date Combinations | 19,966 |
| Distinct Order Item IDs | 30,871 |
| Order-Date Groups with Multiple Distinct Customers | 0 |

### Finding 1: Order IDs Are Reused Across Years

The same `order_id` appeared in multiple years.

For example, Order IDs 353, 715, and 815 were each observed across three different years.

Therefore, `order_id` alone cannot be treated as a globally unique order identifier.

### Finding 2: Order IDs Are Reused Within Years

Further investigation found that some order IDs occurred on multiple dates within the same year.

Examples include:

| Year | Order ID | Distinct Order Dates |
|---|---:|---:|
| 2015 | 8151 | 5 |
| 2016 | 35676 | 5 |
| 2017 | 53871 | 5 |

This confirms that combining `order_year` and `order_id` does not uniquely identify an order.

### Finding 3: Date-Based Composite Identifier

Combining `order_id`, `order_year`, `order_month`, and `order_day` produced 19,966 distinct combinations.

A customer consistency check found no such combinations containing multiple distinct customers.

This supports the date-based combination as a candidate analytical key.

However, it does not prove business-order uniqueness because multiple orders from the same customer could share an identifier and date.

### Finding 4: Order Item Identifier Uniqueness

All 30,871 order-item records had distinct `order_item_id` values.

This supports reliable row-level aggregation and item-level analysis.

### Analytical Impact

**Metrics supported by the current data:**

- Gross sales
- Reported profit
- Reported profit margins
- Product-level units sold
- Department and category revenue
- Customer-level sales
- Monthly and yearly revenue

**Metrics requiring further validation:**

- Unique business-order counts
- Average order value
- Orders per customer
- Repeat-order frequency
- Order-level conversion and purchasing behavior

### Business Recommendation

Confirm the authoritative order identifier in the source system.

Until that identifier is verified, label order counts according to the actual SQL grouping key and avoid interpreting distinct order IDs as unique business orders.

---

## 18. Cross-Day Business Insights

The combined findings from Days 2, 3, and 4 reveal several important patterns.

### Inventory and Revenue Decline

Day 2 identified a substantial reduction in warehouse inventory during late 2017.

Day 3 identified a corresponding reduction in recorded order activity.

Day 4 confirmed that gross sales and reported profit margins declined sharply during the same period.

These findings justify further investigation, but they do not establish that inventory reductions caused the decline in sales.

### High-Demand Products and Fulfillment

Several high-revenue and high-profit products also had relatively long fulfillment times.

Examples:

- Perfect Fitness Perfect Rip Deck: $630,924 reported profit and 8.3 fulfillment days.
- Nike Men's Free 5.0+ Running Shoe: $520,870 reported profit and 9.4 fulfillment days.

These products represent strong candidates for warehouse process reviews.

### Revenue Concentration

The top ten products generated 92.30% of total gross sales.

This concentration makes the performance of a small number of products especially important to the business.

### Profitability Differences

Fan Shop generated the most revenue, while Golf and Footwear achieved stronger reported profit margins.

This illustrates why revenue and profitability should be evaluated together.

---

## 19. Overall Day 4 Business Conclusions

Day 4 provided a detailed view of sales performance, profitability, product demand, and customer market contributions.

### Major Findings

1. Total gross sales were $6.18 million, with approximately $3.99 million in reported profit.
2. Revenue increased by 4.77% in 2016 but declined by 16.17% in 2017.
3. The overall reported profit margin was 64.62%.
4. Fan Shop generated the highest department-level revenue.
5. Golf achieved the highest department-level profit margin at 81.34%.
6. LATAM generated the highest market-level reported profit.
7. Perfect Fitness Perfect Rip Deck generated the highest product-level reported profit.
8. The top ten products contributed 92.30% of gross sales.
9. October–December 2017 experienced a significant decline in revenue and reported profit margins.
10. Order identifier reuse requires additional care when calculating order-level metrics.

### Strategic Recommendations

**Revenue Monitoring:** Establish monthly and yearly revenue growth monitoring to detect significant performance changes.

**Product Portfolio Management:** Closely monitor high-revenue products and evaluate opportunities to reduce revenue concentration.

**Profitability Optimization:** Compare product and department margins alongside absolute reported profit.

**Inventory Alignment:** Investigate whether inventory availability and replenishment patterns align with product demand.

**Fulfillment Improvement:** Prioritize high-value products with long warehouse fulfillment times.

**Data Quality Governance:** Validate the business order identifier before publishing unique-order and average-order-value KPIs.

---

## 20. Next Steps – Day 5

Day 5 will focus on **Advanced Supply Chain Analytics & Final Reporting**.

Planned analysis includes:

- Product-level demand and inventory alignment.
- Inventory coverage and replenishment priorities.
- High-value product risk assessment.
- Combined sales, profit, fulfillment, and inventory analysis.
- Warehouse performance opportunities.
- Final business recommendations.
- Final project README and GitHub documentation.



---

