
# Project 21 – Retail Sales & Customer Segmentation Analytics

![SQL](https://img.shields.io/badge/SQL-DuckDB-blue)
![DuckDB](https://img.shields.io/badge/Database-DuckDB-yellow)
![Analytics](https://img.shields.io/badge/Analytics-Retail%20%26%20Customer%20Segmentation-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Queries](https://img.shields.io/badge/SQL%20Queries-75-orange)

## Project Overview

This project analyzes retail transaction data using SQL and DuckDB to understand sales performance, customer purchasing behavior, customer segmentation, retention, and historical customer value.

The analysis follows a structured five-day workflow consisting of 75 SQL queries.

The project transforms raw retail transaction data into actionable business insights that can support customer retention, revenue growth, marketing strategy, and operational planning.

### Business Objectives

- Evaluate overall retail sales performance.
- Identify seasonal and monthly revenue patterns.
- Understand customer purchasing frequency and behavior.
- Segment customers using Recency, Frequency, and Monetary (RFM) analysis.
- Identify high-value, loyal, inactive, and at-risk customers.
- Analyze customer acquisition and retention cohorts.
- Measure repeat purchasing and customer reactivation.
- Evaluate customer revenue concentration.
- Develop actionable recommendations for retail business growth.

---

## Dataset Overview

The project uses the Online Retail transactional dataset.

The dataset contains transaction-level retail records covering December 2010 through December 2011.

### Dataset Summary

| Metric | Value |
|---|---:|
| Total Records | 541,909 |
| Unique Invoice Numbers | 25,900 |
| Unique Stock Codes | 4,070 |
| Identifiable Customers | 4,372 |
| Countries | 38 |
| Start Date | December 1, 2010 |
| End Date | December 9, 2011 |
| Database | DuckDB |
| Query Language | SQL |

### Dataset Columns

| Column | Description |
|---|---|
| invoice_no | Unique invoice identifier |
| stock_code | Product identifier |
| description | Product description |
| quantity | Number of units purchased or adjusted |
| invoice_date | Transaction date and time |
| unit_price | Price per unit |
| customer_id | Customer identifier |
| country | Country associated with the transaction |

### Data Quality Findings

Initial data profiling identified:

- 135,080 records with missing customer IDs.
- 10,624 records with negative quantities.
- 2 records with negative unit prices.
- 2,515 records with zero unit prices.
- Cancellation and adjustment transactions requiring separate treatment.

These findings influenced the filtering and interpretation of subsequent analyses.

### Sales Eligibility Rules

For gross positive-sales analysis, transactions were filtered using:

```sql
WHERE quantity > 0
  AND unit_price > 0
  AND invoice_no IS NOT NULL
  AND TRIM(invoice_no) <> ''
  AND UPPER(TRIM(invoice_no)) NOT LIKE 'C%'
  AND stock_code IS NOT NULL
  AND TRIM(stock_code) <> ''
  AND country IS NOT NULL
  AND TRIM(country) <> ''
```

Customer-level analyses additionally required:

```sql
AND customer_id IS NOT NULL
```

**Important:** Monetary metrics represent gross positive sales, not net revenue or profit. Cancellations, returns, and other negative adjustments are excluded from the positive-sales population.

---

## Tools & Technologies

| Technology | Purpose |
|---|---|
| DuckDB | Analytical SQL database |
| SQL | Data exploration, transformation, and analysis |
| PowerShell | Local project execution |
| Git | Version control |
| GitHub | Project hosting and documentation |
| Markdown | Documentation and business insights |

### SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Aggregate functions
- Window functions
- `ROW_NUMBER()`
- `NTILE()`
- `LAG()`
- Conditional aggregation
- `CASE WHEN`
- Date calculations
- Customer-level aggregations
- Cohort analysis
- RFM scoring
- Revenue contribution analysis
- Customer retention calculations
- Data quality validation

---

## Project Structure

```text
21- Retail Sales & Customer Segmentation/
│
├── data/
│   └── online_retail.csv
│
├── sql/
│   └── queries.sql
│
├── insights/
│   └── insights.md
│
├── retail.duckdb
│
├── .gitignore
│
└── README.md
```

### File Descriptions

**data/online_retail.csv**

Source dataset containing retail transactions.

**sql/queries.sql**

Contains all 75 SQL queries organized across five analytical stages.

**insights/insights.md**

Documents query results, findings, business interpretations, recommendations, and limitations.

**retail.duckdb**

Local DuckDB database used for executing SQL queries.

**.gitignore**

Excludes local database artifacts, temporary files, and other unnecessary files as configured.

**README.md**

Provides the overall project documentation and analytical summary.

---

# Five-Day SQL Analytics Workflow

## Day 1 – Data Exploration & Quality Assessment

**Queries 1–15**

### Objectives

- Understand the structure of the retail dataset.
- Identify data quality issues.
- Examine transaction distributions.
- Validate customer and invoice identifiers.
- Establish consistent sales eligibility criteria.
- Calculate baseline retail metrics.

### Key Findings

- The dataset contains 541,909 transaction records.
- There are 25,900 unique invoice numbers.
- Customer IDs are missing from 135,080 records.
- Negative quantities and zero-price transactions require careful treatment.
- After applying positive-sales eligibility rules, 530,104 records remain.

### Business Impact

Data profiling established a reliable foundation for subsequent sales and customer analytics.

Separating positive sales from cancellations and adjustments prevents misleading revenue interpretations.

---

## Day 2 – Sales Performance & Revenue Trends

**Queries 16–30**

### Objectives

- Analyze monthly retail sales.
- Identify seasonal demand patterns.
- Evaluate country-level sales.
- Identify high-value transactions.
- Examine customer revenue concentration.
- Investigate adjustments and cancellations.

### Key Findings

| KPI | Result |
|---|---:|
| Eligible Positive-Sale Records | 530,104 |
| Gross Positive Sales | 10,666,684.54 |
| Positive-Sale Invoices | 19,960 |
| Units Sold | 5,588,376 |
| Highest Complete-Month Sales | November 2011 |
| November 2011 Gross Sales | 1,509,496.33 |
| UK Share of Gross Positive Sales | 84.61% |

### Additional Insights

- Retail sales increased substantially during the September–November period.
- November 2011 was the strongest complete month.
- December 2011 contains only partial-month observations.
- The United Kingdom was the dominant sales market.
- High-value invoices contributed disproportionately to overall sales.
- Non-merchandise stock codes, including postage and manual charges, may influence sales rankings.

### Business Recommendations

- Prepare inventory and staffing for seasonal demand.
- Monitor high-value invoices separately.
- Evaluate opportunities outside the dominant UK market.
- Separate merchandise sales from service and adjustment charges when required.

---

## Day 3 – Customer RFM Segmentation

**Queries 31–45**

### Objectives

- Analyze customer purchase frequency.
- Identify one-time and repeat customers.
- Calculate customer recency.
- Measure historical customer spending.
- Develop RFM scores.
- Classify customers into actionable segments.
- Identify valuable customers at risk of inactivity.

### RFM Framework

RFM stands for:

**Recency**

How recently a customer made a purchase.

**Frequency**

How often a customer purchased.

**Monetary**

How much gross positive sales the customer generated.

Customers receive scores from 1 to 5 for each dimension.

### Customer Segments

The project uses six customer segments:

1. Champions
2. Loyal Customers
3. Recent Low-Frequency
4. At Risk
5. Hibernating
6. Potential Loyalists

### Key Findings

- 4,338 identifiable customers had eligible positive-sale transactions.
- 2,845 customers made repeat purchases.
- 1,493 customers purchased only once.
- The overall observed repeat-purchase rate was 65.58%.
- Customer spending varied considerably across the population.

### Business Recommendations

**Champions:** Prioritize relationship management and exclusive benefits.

**Loyal Customers:** Encourage continued engagement and relevant cross-selling.

**Recent Low-Frequency:** Focus on converting initial purchases into repeat behavior.

**At Risk:** Identify previously engaged customers who may benefit from reactivation.

**Hibernating:** Test selective win-back campaigns based on historical value.

**Potential Loyalists:** Encourage repeat purchases and stronger long-term relationships.

---

## Day 4 – Customer & Retail Behavioral Analytics

**Queries 46–60**

### Objectives

Extend the earlier customer and sales analysis to identify additional purchasing patterns, customer behavior, and business opportunities.

### Analytical Focus

- Customer purchasing behavior
- Product and transaction patterns
- Customer engagement
- Revenue contribution
- Purchase frequency
- Retail performance relationships
- Business opportunities and risks

### Business Value

The Day 4 analysis connects transaction-level behavior with customer-level metrics.

These findings support more informed decisions around customer engagement, merchandising, and sales optimization.

Detailed query-level findings are documented in:

`insights/insights.md`

---

## Day 5 – Cohort, Retention & Customer Value Analytics

**Queries 61–75**

### Objectives

- Analyze monthly customer acquisition.
- Compare new and returning customers.
- Measure monthly retention.
- Develop customer retention cohorts.
- Evaluate cohort revenue.
- Measure historical customer value.
- Identify customer reactivation.
- Analyze inactivity and lifecycle segments.
- Compare repeat purchasing across countries.
- Consolidate final customer KPIs.

### Final Customer KPIs

| KPI | Result |
|---|---:|
| Identifiable Customers | 4,338 |
| One-Time Customers | 1,493 |
| Repeat Customers | 2,845 |
| Repeat Purchase Rate | 65.58% |
| Customer Invoices | 18,532 |
| Known-Customer Gross Sales | 8,911,407.90 |
| Average Observed Customer Value | 2,054.27 |
| Median Observed Customer Value | 674.49 |
| Average Purchase Frequency | 4.27 |
| Average Recency | 93.06 Days |
| Average Observed Purchase Span | 130.77 Days |

### Customer Acquisition

The December 2010 cohort contained 885 identifiable customers and generated 4,512,148.22 in observed lifetime gross sales.

Customer acquisition recovered during September and October 2011, with 299 and 358 newly observed customers respectively.

Older cohorts have longer observation windows and therefore cannot be compared directly with newer cohorts using cumulative sales alone.

### Monthly Retention

Selected next-month retention rates:

| Month | Retention |
|---|---:|
| December 2010 | 36.61% |
| March 2011 | 31.21% |
| April 2011 | 42.99% |
| August 2011 | 45.45% |
| October 2011 | 45.60% |

October 2011 recorded the highest observed next-month retention among the complete-month comparisons.

### Customer Revenue Concentration

| Customer Group | Gross Sales Share |
|---|---:|
| Top 1% | 32.00% |
| Next 4% | 18.38% |
| Next 15% | 24.24% |
| Remaining 80% | 25.38% |

**Key insight:** The top 5% of identifiable customers generated 50.38% of known-customer gross sales.

The top 20% generated 74.62%.

### Customer Lifecycle

| Segment | Customers | Gross Sales |
|---|---:|---:|
| Long-Term Repeat Buyers | 1,640 | 6,866,572.50 |
| Repeat Within 91–180 Days | 548 | 767,699.69 |
| One-Time Buyers | 1,493 | 616,311.73 |
| Repeat Within 31–90 Days | 411 | 409,801.45 |
| Repeat Within 30 Days | 246 | 251,022.53 |

Long-term repeat buyers contributed approximately 77.1% of known-customer gross sales.

### Customer Reactivation

November 2011 recorded:

- 323 first-time customers
- 622 consecutive-month returning customers
- 719 customers reactivated after a purchasing gap

This demonstrates that customers who skip one or more months can still return and contribute to future sales.

### Inactivity Analysis

| Inactivity Segment | Customers |
|---|---:|
| Recently Active: 0–30 Days | 1,628 |
| Moderate: 31–90 Days | 1,261 |
| High: 91–180 Days | 588 |
| Extended: 181+ Days | 861 |

A total of 1,449 customers had been inactive for more than 90 days.

Historical customer value can help prioritize which inactive customers to target for reactivation.

---

# Overall Business Insights

## 1. Repeat Customers Drive Retail Performance

Approximately 65.58% of identifiable customers made repeat purchases.

Long-term repeat buyers generated the majority of known-customer gross sales.

**Recommendation:** Invest in retention and loyalty initiatives while measuring their incremental impact.

## 2. Customer Revenue Is Highly Concentrated

The top 5% of customers contributed 50.38% of known-customer gross sales.

**Recommendation:** Monitor high-value customer behavior and develop appropriate retention strategies.

## 3. Seasonal Demand Influences Customer Activity

November 2011 was the strongest complete month for gross positive sales.

It also recorded the highest monthly active identifiable customer count, at 1,664.

**Recommendation:** Align inventory, staffing, and marketing planning with seasonal purchasing trends.

## 4. Customer Reactivation Is a Growth Opportunity

Customers frequently returned after purchasing gaps.

**Recommendation:** Use recency and historical spending to develop targeted win-back campaigns.

## 5. One-Time Buyers Offer Conversion Opportunities

There were 1,493 customers with only one observed invoice.

**Recommendation:** Test post-purchase engagement and second-purchase conversion strategies.

## 6. Cohort Analysis Requires Consistent Observation Windows

Older cohorts naturally have more opportunities to generate repeat purchases.

**Recommendation:** Compare retention and customer value using fixed 30-, 60-, and 90-day windows.

---

# How to Run the Project

## Prerequisites

Install DuckDB and ensure the DuckDB CLI is available in your terminal.

Git is recommended for version control.

## Step 1 – Clone the Repository

```bash
git clone https://github.com/teja-naidu/SQL.git
```

Navigate to the project folder:

```powershell
cd "SQL\21- Retail Sales & Customer Segmentation"
```

## Step 2 – Start DuckDB

```powershell
duckdb retail.duckdb
```

## Step 3 – Load the Dataset

If the `online_retail` table does not already exist, create it from the CSV:

```sql
CREATE TABLE online_retail AS
SELECT
    CAST(invoice_no AS VARCHAR) AS invoice_no,
    CAST(stock_code AS VARCHAR) AS stock_code,
    CAST(description AS VARCHAR) AS description,
    CAST(quantity AS BIGINT) AS quantity,
    CAST(invoice_date AS TIMESTAMP) AS invoice_date,
    CAST(unit_price AS DOUBLE) AS unit_price,
    TRY_CAST(customer_id AS BIGINT) AS customer_id,
    CAST(country AS VARCHAR) AS country
FROM read_csv(
    'data/online_retail.csv',
    header = true,
    auto_detect = true
);
```

**Note:** The loading statement assumes the CSV uses the normalized column names listed above. If the source CSV uses different headers, adjust the import mapping accordingly.

## Step 4 – Validate the Data

```sql
SELECT COUNT(*) AS total_records
FROM online_retail;
```

Expected result:

```text
541909
```

## Step 5 – Execute the SQL Analysis

From the DuckDB CLI:

```sql
.read sql/queries.sql
```

This executes the project's cumulative SQL analysis.

## Step 6 – Review the Findings

Open:

```text
insights/insights.md
```

The insights file contains detailed query results, interpretations, business recommendations, and analytical limitations.

---

# Data Limitations

The following limitations should be considered when interpreting the analysis.

### Missing Customer IDs

Customer-level analyses exclude transactions without identifiable customer IDs.

### Returns and Cancellations

Gross positive-sales metrics exclude negative-quantity adjustments and cancellation invoices.

These metrics should not be interpreted as net revenue.

### Partial December 2011

The dataset ends on December 9, 2011.

December 2011 should not be compared directly with complete calendar months.

### Limited Historical Coverage

The dataset begins in December 2010.

Customers classified as newly observed may have purchased before the available history.

### Customer Lifetime Value

The project measures observed historical customer gross sales.

It does not estimate future lifetime value, profit, or customer acquisition costs.

### Customer Churn

Inactivity and recency are behavioral indicators.

They do not establish confirmed permanent churn.

### Large Transactions

High-value invoices can materially influence average customer and cohort metrics.

### Non-Merchandise Charges

Certain stock codes may represent postage or other charges rather than physical products.

These should be classified separately for merchandise-only analysis.

---

# Future Enhancements

Potential extensions include:

1. Develop an interactive retail analytics dashboard using Tableau or Power BI.
2. Create a customer RFM segmentation dashboard.
3. Build customer cohort retention heatmaps.
4. Develop customer churn prediction models using additional data.
5. Forecast monthly sales using time-series techniques.
6. Analyze product affinity and market basket relationships.
7. Develop predictive customer lifetime value models.
8. Automate data quality checks and reporting.
9. Incorporate marketing campaign data to measure acquisition effectiveness.
10. Introduce returns-adjusted revenue and profitability metrics.

---

# Project Outcomes

This project demonstrates the practical application of SQL to real-world retail analytics.

Across 75 queries, the analysis covers the complete workflow from raw data exploration to customer segmentation, retention, and historical value measurement.

### Technical Skills Demonstrated

- Data exploration and validation
- SQL aggregations and transformations
- Window functions
- Customer segmentation
- RFM analysis
- Cohort retention analysis
- Revenue concentration analysis
- Business KPI development
- Analytical documentation
- Git and GitHub version control

### Business Skills Demonstrated

- Translating business questions into SQL
- Identifying customer retention opportunities
- Evaluating customer value and revenue concentration
- Interpreting seasonal purchasing behavior
- Developing actionable business recommendations
- Recognizing data limitations and measurement bias

---

# Conclusion

The Retail Sales & Customer Segmentation Analytics project demonstrates how SQL and DuckDB can transform transactional retail data into meaningful business insights.

The analysis identified strong repeat-customer contributions, substantial customer revenue concentration, seasonal purchasing patterns, and opportunities to improve customer retention and reactivation.

By combining sales performance analysis, RFM segmentation, customer behavior, cohort retention, and historical customer value, the project provides a comprehensive foundation for data-driven retail decision-making.

**Project Status: Completed**

**Total SQL Queries: 75**

**Duration: 5 Analytical Stages**

---

## Author

**Teja Naidu Ganji**

SQL | Data Analytics | Business Intelligence | Customer Analytics

[GitHub Profile](https://github.com/teja-naidu)
