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



