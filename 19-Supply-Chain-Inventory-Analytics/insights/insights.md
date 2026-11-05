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

