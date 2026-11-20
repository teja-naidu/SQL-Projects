
# Retail Sales & Customer Segmentation Analytics

## Day 1 – Data Exploration & Quality Assessment

### Objective

The objective of Day 1 is to explore the online retail dataset, validate its structure, identify data-quality issues, assess invoice integrity, and establish reliable transaction definitions for subsequent sales, customer segmentation, product performance, and retention analysis.

A total of 15 SQL queries were executed using DuckDB.

---

## 1. Dataset Overview (Queries 1–4)

### Key Findings

- Total transaction records: 541,909
- Total columns: 9
- Unique invoices: 25,900
- Unique products: 4,070
- Unique customers: 4,372
- Countries represented: 38
- Earliest transaction: December 1, 2010
- Latest transaction: December 9, 2011
- Calendar period: 374 days
- Active transaction days: 305

### Business Insights

1. The dataset provides approximately one year of retail transaction history, supporting monthly sales trends, customer segmentation, product demand analysis, and purchasing behavior studies.

2. The 25,900 unique invoice identifiers represent transaction documents, while 541,909 rows represent individual transaction lines.

3. The 4,372 identifiable customers provide a foundation for customer-level segmentation, although not all customers necessarily have eligible positive sales.

4. The 38 country values allow geographical comparisons, but sales activity is heavily concentrated in the United Kingdom.

5. Transactions occurred on 305 of the 374 calendar days, indicating that daily analysis should distinguish active trading days from days without recorded transactions.

### Recommendations

- Use invoice-level aggregation for order metrics.
- Use line-level data for product and quantity analysis.
- Apply consistent date boundaries when comparing periods.
- Separate customer-level and transaction-level KPIs.

---

## 2. Missing Values & Data Quality (Queries 5–7)

### Key Findings

- Missing invoice numbers: 0
- Missing stock codes: 0
- Missing descriptions: 1,454
- Missing customer IDs: 135,080
- Missing countries: 0
- Missing customer ID percentage: 24.93%
- Duplicate business-row groups: 4,879
- Excess matching rows: 5,268
- Total rows within duplicate groups: 10,147

### Business Insights

1. Customer identification is the largest observed completeness issue, affecting 24.93% of transaction records.

2. Missing customer IDs prevent reliable attribution of those rows to individual customers and therefore limit customer segmentation, repeat purchase analysis, and retention calculations.

3. The 1,454 missing product descriptions may reduce the accuracy of product categorization and descriptive reporting.

4. No missing invoice numbers, stock codes, or country values were identified, supporting invoice, product-code, and geographical grouping.

5. The 5,268 excess matching rows represent approximately 0.97% of all records.

6. Identical business rows do not necessarily represent erroneous duplicates. They may reflect legitimate repeated invoice lines.

### Recommendations

- Exclude missing customer IDs from customer-level RFM calculations.
- Retain anonymous transactions in eligible aggregate sales reporting.
- Investigate duplicate groups before applying deduplication.
- Use stock codes to investigate missing descriptions.
- Preserve the original raw dataset for auditability.

### Limitations

- Duplicate status cannot be conclusively determined from matching business fields alone.
- Missing customer IDs cannot be reliably reconstructed without additional customer reference data.

---

## 3. Quantity & Price Validation (Queries 8–9)

### Key Findings

Quantity distribution:

- Minimum quantity: -80,995
- Maximum quantity: 80,995
- Positive quantity rows: 531,285
- Negative quantity rows: 10,624
- Zero quantity rows: 0

Unit price distribution:

- Minimum unit price: -11,062.06
- Maximum unit price: 38,970.00
- Positive price rows: 539,392
- Zero price rows: 2,515
- Negative price rows: 2

### Business Insights

1. Negative quantities account for approximately 1.96% of all transaction rows and require separate investigation as potential returns, cancellations, or inventory adjustments.

2. Extremely large positive and negative quantities indicate potential bulk transactions, reversals, or exceptional operational activity.

3. Zero-price transactions may represent promotional items, replacements, samples, or administrative adjustments. Their exact purpose is not confirmed.

4. Two negative-price records require investigation before inclusion in revenue reporting.

5. The maximum unit price of 38,970.00 suggests that exceptional transactions could materially influence revenue and average-value metrics.

### Recommendations

- Separate positive sales from negative-quantity transactions.
- Investigate extreme quantity and price values.
- Exclude zero-price and negative-price records from the initial gross positive-sales definition.
- Avoid treating every negative-quantity record as a confirmed customer return.

---

## 4. Cancellation & Transaction Classification (Queries 10–11)

### Invoice Prefix Analysis

Other invoices:

- Transaction rows: 532,621
- Unique invoices: 22,064
- Total signed quantity: 5,454,024
- Signed line amount: 10,644,560.42

Cancellation-prefix invoices:

- Transaction rows: 9,288
- Unique invoices: 3,836
- Total signed quantity: -277,574
- Signed line amount: -896,812.49

### Transaction Classification

| Transaction Class | Rows | Signed Amount |
|---|---:|---:|
| Valid Sale - Known Customer | 397,884 | 8,911,407.90 |
| Valid Sale - Unknown Customer | 132,220 | 1,755,276.64 |
| Return or Cancellation | 10,624 | -896,812.49 |
| Zero Price | 1,179 | 0.00 |
| Negative Price | 2 | -22,124.12 |

### Business Insights

1. The transaction classification identifies 530,104 eligible positive-sale rows across known and unknown customers.

2. Cancellation-prefix invoices contribute a signed amount of -896,812.49, demonstrating the importance of accounting for reversals.

3. The broader return-or-cancellation classification contains 10,624 rows, compared with 9,288 cancellation-prefix rows.

4. The 1,336-row difference indicates negative-quantity records outside the cancellation-prefix group that require additional investigation.

5. Known-customer positive sales contribute 8,911,407.90, while anonymous positive sales contribute 1,755,276.64.

6. The transaction classifications are mutually exclusive under the CASE statement's precedence rules.

7. The 1,179 zero-price records in the classification are not the same as the 2,515 total zero-price records, because negative-quantity and cancellation conditions are evaluated first.

### Recommendations

- Maintain separate gross-sales and return/cancellation metrics.
- Investigate negative-quantity transactions without cancellation prefixes.
- Retain anonymous positive sales in aggregate reporting.
- Document the classification precedence before creating production KPIs.
- Investigate whether adjustments and service charges require separate accounting treatment.

### Limitations

- Cancellation-prefix records cannot independently confirm completed refunds.
- The signed cancellation amount is not a verified refund total.
- Gross positive sales are not equivalent to net recognized revenue.

---

## 5. Geographical Distribution (Query 12)

### Top Countries by Transaction Rows

| Country | Transaction Rows | Unique Invoices | Unique Customers |
|---|---:|---:|---:|
| United Kingdom | 495,478 | 23,494 | 3,950 |
| Germany | 9,495 | 603 | 95 |
| France | 8,557 | 461 | 87 |
| EIRE | 8,196 | 360 | 3 |
| Spain | 2,533 | 105 | 31 |
| Netherlands | 2,371 | 101 | 9 |
| Belgium | 2,069 | 119 | 25 |
| Switzerland | 2,002 | 74 | 21 |
| Portugal | 1,519 | 71 | 19 |
| Australia | 1,259 | 69 | 9 |

### Business Insights

1. The United Kingdom accounts for approximately 91.43% of all transaction rows.

2. Germany, France, and EIRE are the next largest markets by transaction-line volume.

3. The high concentration of transactions in the United Kingdom suggests that aggregate performance trends will be strongly influenced by the UK market.

4. EIRE contains 8,196 transaction rows but only three identifiable customers, suggesting potentially concentrated purchasing activity.

5. Hong Kong contains 288 transaction rows but no identifiable customers.

6. Country values such as "Unspecified" and "European Community" require standardization or separate classification for geographical reporting.

### Recommendations

- Analyze UK and non-UK performance separately.
- Compare international markets using revenue and invoice-level metrics rather than row counts alone.
- Investigate countries with high transaction volumes but few identified customers.
- Standardize geographical labels where appropriate.

### Limitations

- Transaction-row volume does not directly represent revenue.
- Customer counts exclude missing customer identifiers.
- Country-level revenue rankings have not yet been calculated.

---

## 6. Product Frequency Analysis (Query 13)

### Top Product Codes

| Stock Code | Transaction Rows | Unique Invoices |
|---|---:|---:|
| 85123A | 2,313 | 2,246 |
| 22423 | 2,203 | 2,172 |
| 85099B | 2,159 | 2,135 |
| 47566 | 1,727 | 1,706 |
| 20725 | 1,639 | 1,608 |
| 84879 | 1,502 | 1,468 |
| 22720 | 1,477 | 1,462 |
| 22197 | 1,476 | 1,442 |
| 21212 | 1,385 | 1,334 |
| 20727 | 1,350 | 1,295 |

### Business Insights

1. Stock code 85123A appears most frequently, with 2,313 transaction rows across 2,246 invoices.

2. Stock codes 22423 and 85099B follow closely, suggesting strong transaction frequency.

3. Product transaction frequency is not necessarily equivalent to total units sold or revenue contribution.

4. Stock code POST appears in 1,256 transaction rows and requires non-merchandise classification before product-performance reporting.

5. Product-level signed quantities may be affected by returns, cancellations, and adjustments.

### Recommendations

- Rank products separately by sales revenue, units sold, and invoice frequency.
- Investigate non-merchandise stock codes.
- Evaluate return-adjusted product performance.
- Use product descriptions to improve business interpretability.
- Identify potential cross-selling opportunities during Day 4.

---

## 7. Invoice Identifier Integrity (Query 14)

### Key Findings

- Total invoice identifiers: 25,900
- Multi-line invoices: 20,059
- Multi-customer invoices: 0
- Multi-country invoices: 0
- Multi-timestamp invoices: 43
- Maximum lines per invoice: 1,114

### Business Insights

1. Approximately 77.45% of invoice identifiers contain multiple transaction lines.

2. No invoice identifiers contain multiple distinct known customer IDs.

3. No invoice identifiers span multiple distinct country values.

4. The 43 multi-timestamp invoices require investigation before assigning a single invoice timestamp.

5. The maximum of 1,114 lines per invoice suggests potentially large or exceptional transactions that could affect average basket-size calculations.

### Recommendations

- Use distinct invoice identifiers for invoice-count metrics.
- Investigate invoices containing multiple timestamps.
- Examine exceptionally large invoices.
- Define a consistent invoice-date rule before customer frequency and retention analysis.

### Limitations

- Zero multi-customer invoices does not establish that every invoice has a known customer.
- Invoice identifiers with multiple timestamps may require additional business context.

---

## 8. Revenue Eligibility Assessment (Query 15)

### Key Findings

- Total transaction rows: 541,909
- Eligible positive-sale rows: 530,104
- Positive-sale invoices: 19,960
- Known purchasing customers: 4,338
- Gross positive sales: 10,666,684.54
- Excluded rows: 11,805
- Anonymous positive-sale rows: 132,220

### Business Insights

1. Approximately 97.82% of transaction rows qualify under the initial positive-sale eligibility definition.

2. The eligible positive-sale dataset contains 19,960 unique invoice identifiers.

3. There are 4,338 identifiable customers with eligible positive-sale transactions, compared with 4,372 identifiable customers across the full dataset.

4. Anonymous positive-sale transactions represent approximately 24.94% of eligible positive-sale rows.

5. The initial gross positive-sales baseline is 10,666,684.54 in dataset currency units.

6. The 11,805 excluded rows include negative quantities, cancellations, zero-price records, negative-price records, and any records failing essential-field checks.

7. The gross positive-sales metric has not yet been adjusted for returns, cancellations, non-merchandise charges, or other accounting adjustments.

### Recommendations

- Use the positive-sale eligibility definition consistently in Day 2.
- Separate known and anonymous customer transactions.
- Calculate return-adjusted sales separately.
- Investigate non-merchandise charges before finalizing merchandise revenue.
- Use the 4,338 known purchasing customers as the initial population for customer segmentation.

---

## 9. Overall Day 1 Business Recommendations

### Priority 1: Establish Reliable Sales Metrics

- Maintain a consistent definition of eligible positive sales.
- Separate cancellations and negative-quantity transactions.
- Distinguish gross positive sales from net revenue.
- Investigate negative prices and non-merchandise charges.

### Priority 2: Improve Customer Analytics

- Exclude missing customer IDs from customer-level metrics.
- Retain anonymous transactions for aggregate sales analysis.
- Segment the 4,338 identifiable purchasing customers.
- Investigate customer identification gaps by country and transaction type.

### Priority 3: Strengthen Data Quality

- Review 5,268 excess matching business rows.
- Investigate 43 multi-timestamp invoices.
- Examine extreme quantity and price values.
- Address missing descriptions where reliable mappings exist.

### Priority 4: Improve Geographical and Product Reporting

- Separate UK and international performance.
- Identify high-value international markets using revenue.
- Exclude or separately report non-merchandise stock codes.
- Evaluate products using revenue, units, and purchase frequency.

---

## 10. Assumptions & Limitations

1. The dataset contains transaction-line records rather than one row per invoice.

2. Customer identifiers are missing from 24.93% of records.

3. Duplicate-looking rows are retained until their business validity can be established.

4. Negative quantities are treated as potential returns, cancellations, or adjustments, not automatically confirmed refunds.

5. Gross positive sales are calculated using eligible positive quantities multiplied by positive unit prices.

6. The dataset does not explicitly establish currency, taxes, shipping treatment, or accounting revenue recognition.

7. Customer-level analysis is limited to identifiable customers.

8. The data covers December 2010 through December 2011 and may not represent current retail behavior.

9. Multi-timestamp invoices require investigation before selecting a canonical invoice date.

10. Product rankings require additional separation of merchandise and service-related stock codes.

---

## 11. Day 1 Conclusion

Day 1 successfully established the dataset structure, validated 541,909 transaction rows, identified major data-quality issues, assessed invoice integrity, and calculated an initial gross positive-sales baseline of 10,666,684.54.

The most significant analytical limitations are missing customer identifiers, duplicate-looking transaction lines, returns and cancellations, exceptional price and quantity values, and non-merchandise stock codes.

These findings provide the foundation for Day 2 sales performance and revenue trend analysis.


---

# Day 2 – Sales Performance & Revenue Trends

## Objective

The objective of Day 2 is to evaluate gross sales performance,
monthly revenue trends, purchasing patterns, geographical sales,
invoice values, returns and cancellations, product revenue,
and customer sales concentration.

A total of 15 SQL queries (Queries 16–30) were executed using
DuckDB against the online_retail dataset.

All monetary amounts are reported in dataset currency units.

The analysis uses the positive-sale eligibility definition
established during Day 1.

---

## 1. Overall Sales Performance (Query 16)

### Key Findings

- Eligible positive-sale lines: 530,104
- Positive-sale invoices: 19,960
- Identifiable purchasing customers: 4,338
- Total positive-sale units: 5,588,376
- Gross positive sales: 10,666,684.54
- Average invoice value: 534.40
- Average units per invoice: 279.98

### Business Insights

1. The dataset generated 10.67 million in gross positive sales
   across 19,960 eligible invoice identifiers.

2. Average invoice value was 534.40, providing a baseline
   for measuring changes in customer purchasing behavior.

3. Average units per invoice reached 279.98, indicating
   substantial purchasing quantities across the dataset.

4. High average unit quantities may reflect bulk purchasing
   activity and should not automatically be interpreted
   as typical consumer basket sizes.

5. The 4,338 identifiable purchasing customers provide
   the population for subsequent customer segmentation.

### Business Recommendations

- Monitor gross sales, invoice counts, and average invoice
  value as separate performance indicators.
- Investigate large-volume invoices before interpreting
  average basket size.
- Compare mean and median invoice values to understand
  the influence of unusually large transactions.
- Maintain consistent transaction eligibility rules.

---

## 2. Monthly Sales Performance (Query 17)

### Key Findings

| Month | Invoices | Gross Sales |
|---|---:|---:|
| Dec 2010 | 1,559 | 823,746.14 |
| Jan 2011 | 1,086 | 691,364.56 |
| Feb 2011 | 1,100 | 523,631.89 |
| Mar 2011 | 1,454 | 717,639.36 |
| Apr 2011 | 1,246 | 537,808.62 |
| May 2011 | 1,681 | 770,536.02 |
| Jun 2011 | 1,533 | 761,739.90 |
| Jul 2011 | 1,475 | 719,221.19 |
| Aug 2011 | 1,361 | 759,138.38 |
| Sep 2011 | 1,837 | 1,058,590.17 |
| Oct 2011 | 2,040 | 1,154,979.30 |
| Nov 2011 | 2,769 | 1,509,496.33 |
| Dec 2011* | 819 | 638,792.68 |

*December 2011 contains data only through December 9.

### Business Insights

1. November 2011 recorded the highest full-month gross sales,
   reaching 1,509,496.33.

2. November also recorded the highest monthly invoice count,
   with 2,769 invoices.

3. February 2011 had the lowest gross sales among complete
   2011 months, at 523,631.89.

4. September, October, and November showed particularly
   strong sales activity compared with earlier months.

5. Monthly performance reflects both transaction frequency
   and invoice value, not solely customer growth.

### Recommendations

- Investigate the drivers of September–November growth.
- Prepare inventory and operational capacity for periods
  with historically higher transaction volumes.
- Compare monthly sales against invoice counts and units.
- Exclude partial months from direct full-month comparisons.

---

## 3. Month-over-Month Sales Growth (Query 18)

### Key Findings

| Month | MoM Growth |
|---|---:|
| Jan 2011 | -16.07% |
| Feb 2011 | -24.26% |
| Mar 2011 | +37.05% |
| Apr 2011 | -25.06% |
| May 2011 | +43.27% |
| Jun 2011 | -1.14% |
| Jul 2011 | -5.58% |
| Aug 2011 | +5.55% |
| Sep 2011 | +39.45% |
| Oct 2011 | +9.11% |
| Nov 2011 | +30.69% |
| Dec 2011* | -57.68% |

### Business Insights

1. May 2011 recorded the highest positive monthly growth,
   increasing 43.27% from April.

2. September recorded 39.45% growth, followed by
   another 9.11% increase in October.

3. November achieved 30.69% growth over October.

4. February and April experienced significant declines,
   demonstrating volatility in monthly performance.

5. The reported December 2011 decline of 57.68%
   is distorted by incomplete monthly coverage.

### Recommendations

- Investigate seasonal demand patterns and promotional
  activity associated with major growth periods.
- Evaluate month-over-month changes alongside invoice
  counts and average invoice values.
- Use comparable complete periods for growth analysis.
- Avoid interpreting the partial December decline
  as evidence of deteriorating business performance.

---

## 4. Highest Gross Sales Days (Query 19)

### Top Five Days

| Date | Invoices | Gross Sales |
|---|---:|---:|
| Dec 9, 2011 | 44 | 200,920.60 |
| Nov 14, 2011 | 107 | 114,419.89 |
| Sep 20, 2011 | 70 | 109,612.03 |
| Dec 7, 2010 | 84 | 99,618.20 |
| Jan 18, 2011 | 41 | 95,978.05 |

### Business Insights

1. December 9, 2011 generated the highest daily gross sales,
   reaching 200,920.60 across only 44 invoices.

2. The high revenue relative to invoice count indicates
   that exceptional invoice values materially influenced
   the day's performance.

3. November 14 and September 20 also recorded unusually
   strong daily gross sales.

4. High-revenue days do not necessarily correspond
   to the highest transaction counts.

5. Daily performance should be analyzed for large-order
   concentration and unusual purchasing activity.

### Recommendations

- Investigate exceptional high-value invoices.
- Compare daily sales with invoice count and units sold.
- Use median and percentile-based daily metrics
  to reduce the influence of extreme transactions.

---

## 5. Weekday Sales Performance (Query 20)

### Key Findings

| Day | Gross Sales | Average per Active Day |
|---|---:|---:|
| Sunday | 813,827.61 | 16,276.55 |
| Monday | 1,779,575.04 | 37,863.30 |
| Tuesday | 2,178,632.61 | 41,896.78 |
| Wednesday | 1,851,147.81 | 34,927.32 |
| Thursday | 2,203,161.24 | 41,569.08 |
| Friday | 1,840,340.23 | 36,806.80 |

### Business Insights

1. Thursday generated the highest total gross sales,
   reaching 2,203,161.24.

2. Tuesday generated the highest average gross sales
   per active day at 41,896.78.

3. Sunday recorded the lowest average daily sales,
   at 16,276.55.

4. No Saturday positive-sale activity appeared
   in the query results.

5. Weekday differences suggest varying operational
   and purchasing activity across the week.

### Recommendations

- Evaluate staffing and order-processing capacity
  for Tuesday and Thursday demand.
- Investigate the absence of Saturday transactions.
- Compare active-day averages rather than total
  weekday revenue alone.
- Avoid assuming the weekday pattern reflects
  consumer preference without operational context.

---

## 6. Hourly Sales Performance (Query 21)

### Key Findings

- Highest hourly gross sales: 10 AM, 1,446,742.70
- Second-highest: 12 PM, 1,444,245.88
- 3 PM gross sales: 1,352,972.18
- 1 PM gross sales: 1,265,736.30
- Highest invoice count: 12 PM, 3,220 invoices
- Lowest observed hourly sales: 6 AM, 4.25

### Business Insights

1. Sales activity was concentrated primarily
   between 9 AM and 4 PM.

2. The 10 AM hour generated the highest gross sales.

3. The 12 PM hour generated the highest invoice count,
   indicating that revenue and transaction frequency
   peak at different times.

4. Early morning and evening hours showed substantially
   lower recorded activity.

### Recommendations

- Evaluate operational capacity during peak hours.
- Investigate whether transaction timestamps reflect
  order creation, processing, or invoicing.
- Confirm timezone consistency before using hourly
  trends for staffing or customer behavior decisions.

---

## 7. Country-Level Gross Sales (Query 22)

### Top Countries

| Country | Gross Sales | Invoices |
|---|---:|---:|
| United Kingdom | 9,025,222.08 | 18,019 |
| Netherlands | 285,446.34 | 94 |
| EIRE | 283,453.96 | 288 |
| Germany | 228,867.14 | 457 |
| France | 209,715.11 | 392 |
| Australia | 138,521.31 | 57 |
| Spain | 61,577.11 | 90 |
| Switzerland | 57,089.90 | 54 |
| Belgium | 41,196.34 | 98 |
| Sweden | 38,378.33 | 36 |

### Business Insights

1. The United Kingdom dominates gross sales,
   generating more than 9 million.

2. The Netherlands ranks second by gross sales
   despite having only 94 eligible invoices.

3. The Netherlands recorded an average invoice
   value of 3,036.66.

4. Australia recorded an average invoice value
   of 2,430.20 across 57 invoices.

5. International markets show significant differences
   in purchasing frequency and invoice values.

### Recommendations

- Analyze high-value international markets separately.
- Investigate bulk purchasing behavior in the Netherlands
  and Australia.
- Compare country performance using gross sales,
  average invoice value, and customer concentration.
- Avoid ranking market opportunity by revenue alone.

---

## 8. UK vs International Sales (Query 23)

### Key Findings

United Kingdom:
- Invoices: 18,019
- Known customers: 3,920
- Gross sales: 9,025,222.08
- Revenue share: 84.61%

International:
- Invoices: 1,941
- Known customers: 418
- Gross sales: 1,641,462.46
- Revenue share: 15.39%

### Business Insights

1. The UK contributes 84.61% of gross positive sales.

2. International markets collectively contribute 15.39%.

3. The UK has a substantially larger identified
   customer base and invoice volume.

4. International customers may represent opportunities
   for targeted expansion, particularly in markets
   with high invoice values.

### Recommendations

- Maintain separate UK and international KPIs.
- Evaluate international market growth opportunities.
- Investigate customer concentration and order size
  in smaller but high-value markets.
- Consider geographic diversification as a potential
  long-term strategy, subject to additional analysis.

---

## 9. Monthly Average Order Value (Query 24)

### Key Findings

| Month | Average Value | Median Value |
|---|---:|---:|
| Dec 2010 | 528.38 | 258.95 |
| Jan 2011 | 636.62 | 307.33 |
| Feb 2011 | 476.03 | 304.25 |
| Mar 2011 | 493.56 | 300.00 |
| Apr 2011 | 431.63 | 301.81 |
| May 2011 | 458.38 | 305.45 |
| Jun 2011 | 496.89 | 294.20 |
| Jul 2011 | 487.61 | 304.10 |
| Aug 2011 | 557.78 | 306.02 |
| Sep 2011 | 576.26 | 326.12 |
| Oct 2011 | 566.17 | 313.86 |
| Nov 2011 | 545.14 | 300.60 |
| Dec 2011* | 779.97 | 300.54 |

### Business Insights

1. December 2011 recorded the highest average
   invoice value at 779.97, but the month is incomplete.

2. January 2011 recorded the highest average
   invoice value among complete 2011 months, at 636.62.

3. Median invoice values remained much lower than
   average invoice values across most months.

4. The difference between mean and median values
   indicates a right-skewed invoice-value distribution.

5. The December 2011 maximum invoice value
   reached 168,469.60, materially affecting its mean.

### Recommendations

- Report median invoice value alongside average value.
- Investigate extreme invoices separately.
- Use invoice-value distributions to identify
  typical versus exceptional purchasing patterns.

---

## 10. Gross Sales vs Returns and Adjustments (Query 25)

### Key Findings

| Transaction Type | Rows | Signed Amount |
|---|---:|---:|
| Positive Sale | 530,104 | 10,666,684.54 |
| Return or Cancellation | 10,624 | -896,812.49 |
| Other Adjustment | 1,181 | -22,124.12 |

### Business Insights

1. Gross positive sales total 10,666,684.54.

2. Returns and cancellations contribute a signed
   negative amount of 896,812.49.

3. Other adjustments contribute a further signed
   negative amount of 22,124.12.

4. The gross-sales figure therefore overstates
   the signed transaction total when reversals
   and adjustments are excluded.

5. The negative transaction amounts should not
   automatically be interpreted as completed refunds.

### Recommendations

- Report gross positive sales separately from
  returns and other adjustments.
- Investigate the two negative-price records.
- Reconcile transaction classifications before
  labeling any metric as recognized net revenue.

---

## 11. Monthly Return and Cancellation Impact (Query 26)

### Key Findings

| Month | Return Impact |
|---|---:|
| Dec 2010 | 9.08% |
| Jan 2011 | 19.00% |
| Feb 2011 | 4.88% |
| Mar 2011 | 4.79% |
| Apr 2011 | 8.29% |
| May 2011 | 6.13% |
| Jun 2011 | 9.27% |
| Jul 2011 | 5.27% |
| Aug 2011 | 7.16% |
| Sep 2011 | 3.67% |
| Oct 2011 | 7.30% |
| Nov 2011 | 3.16% |
| Dec 2011* | 32.11% |

### Business Insights

1. December 2011 showed the highest reported
   return impact at 32.11%.

2. January 2011 recorded a substantial
   return impact of 19.00%.

3. November 2011 had the lowest reported impact
   at 3.16%, followed by September at 3.67%.

4. Return activity varies materially across months.

5. Monthly return impact is based on the month
   in which negative transactions were recorded,
   not necessarily the original purchase month.

### Recommendations

- Investigate months with unusually high
  return and cancellation impact.
- Identify products and customers associated
  with large negative transactions.
- Link returns to original purchases where possible.
- Avoid interpreting monthly return impact as
  a true purchase-cohort return rate.

---

## 12. Highest-Value Invoices (Query 27)

### Top Five Invoices

| Invoice | Gross Value | Units |
|---|---:|---:|
| 581483 | 168,469.60 | 80,995 |
| 541431 | 77,183.60 | 74,215 |
| 574941 | 52,940.94 | 14,149 |
| 576365 | 50,653.91 | 13,956 |
| 556444 | 38,970.00 | 60 |

### Business Insights

1. Invoice 581483 generated 168,469.60
   from a single transaction line.

2. Invoice 541431 generated 77,183.60
   from a single line containing 74,215 units.

3. Several other high-value invoices contained
   large numbers of units or transaction lines.

4. Exceptional invoices materially influence
   average invoice values and daily sales totals.

5. These invoices may reflect bulk purchasing,
   but their business purpose is not established
   by the SQL output alone.

### Recommendations

- Investigate exceptionally large invoices.
- Analyze high-value transactions separately
  from typical purchasing activity.
- Assess whether these transactions represent
  recurring customers or one-time purchases.
- Evaluate their influence on sales concentration.

---

## 13. Top Products by Gross Sales (Query 28)

### Key Findings

| Stock Code | Description | Gross Sales |
|---|---|---:|
| DOT | DOTCOM POSTAGE | 206,248.77 |
| 22423 | REGENCY CAKESTAND 3 TIER | 174,484.74 |
| 23843 | PAPER CRAFT, LITTLE BIRDIE | 168,469.60 |
| 85123A | WHITE HANGING HEART T-LIGHT HOLDER | 104,518.80 |
| 47566 | PARTY BUNTING | 99,504.33 |
| 85099B | JUMBO BAG RED RETROSPOT | 94,340.05 |
| 23166 | MEDIUM CERAMIC TOP STORAGE JAR | 81,700.92 |
| M | Manual | 78,110.27 |
| POST | POSTAGE | 78,101.88 |
| 23084 | RABBIT NIGHT LIGHT | 66,964.99 |

### Business Insights

1. DOTCOM POSTAGE ranks first by gross sales,
   but represents a non-merchandise charge.

2. REGENCY CAKESTAND 3 TIER generated
   174,484.74 across 1,988 invoices.

3. PAPER CRAFT, LITTLE BIRDIE generated
   168,469.60 from one invoice, indicating
   extreme revenue concentration.

4. WHITE HANGING HEART T-LIGHT HOLDER and
   PARTY BUNTING also generated substantial sales.

5. POSTAGE and Manual entries require separate
   classification before final merchandise rankings.

### Recommendations

- Separate merchandise from postage and manual charges.
- Identify products with recurring sales across
  many invoices.
- Investigate one-time high-revenue products.
- Use return-adjusted merchandise sales for
  future product-performance rankings.

---

## 14. Customer Sales Concentration (Query 29)

### Key Findings

| Segment | Customers | Sales Share |
|---|---:|---:|
| Top 1% | 44 | 32.00% |
| Next 4% | 173 | 18.38% |
| Next 15% | 651 | 24.24% |
| Remaining 80% | 3,470 | 25.38% |

### Business Insights

1. The top 44 customers generate 32.00%
   of identifiable-customer gross sales.

2. The top 5% collectively contribute 50.38%
   of identifiable-customer gross sales.

3. The top 20% collectively contribute 74.62%.

4. The remaining 80% contribute only 25.38%.

5. This distribution demonstrates substantial
   sales concentration among high-value customers.

6. The analysis excludes transactions without
   identifiable customer IDs.

### Recommendations

- Prioritize retention analysis for high-value customers.
- Identify whether top customers purchase frequently
  or primarily through large one-time orders.
- Develop targeted engagement strategies.
- Investigate concentration risk.
- Use RFM analysis to distinguish loyal customers
  from occasional high-spending customers.

---

## 15. Monthly KPI Summary (Query 30)

### Key Findings

- Highest full-month gross sales:
  November 2011 – 1,509,496.33

- Highest full-month invoice count:
  November 2011 – 2,769

- Highest full-month known customer count:
  November 2011 – 1,664

- Highest full-month units sold:
  November 2011 – 754,507

- Highest full-month average invoice value:
  January 2011 – 636.62

- Highest observed monthly average invoice value:
  Partial December 2011 – 779.97

- Highest observed monthly average units per invoice:
  Partial December 2011 – 383.70

### Business Insights

1. November 2011 represents the strongest
   complete month across several sales KPIs.

2. Sales growth in September–November coincides
   with increased invoice volumes and customer activity.

3. Average invoice value varies independently
   from invoice count.

4. December 2011 metrics are affected by incomplete
   coverage and exceptional invoice values.

5. Monthly KPI reporting should combine gross sales,
   invoice counts, units sold, and average invoice value.

### Recommendations

- Create a standardized monthly sales KPI dashboard.
- Distinguish volume-driven growth from changes
  in average invoice value.
- Flag incomplete reporting periods.
- Investigate exceptional transactions separately.

---

## 16. Overall Day 2 Business Recommendations

### Priority 1: Improve Revenue Reporting

- Separate gross sales, returns, and adjustments.
- Establish a consistent return-adjusted sales metric.
- Investigate non-merchandise stock codes.
- Avoid labeling transaction totals as recognized revenue.

### Priority 2: Strengthen Customer Retention

- Prioritize analysis of high-value customers.
- Evaluate purchasing frequency and recency.
- Investigate dependence on the top customer segments.
- Develop customer-specific engagement strategies.

### Priority 3: Optimize Sales Operations

- Investigate peak weekday and hourly activity.
- Review high-volume invoice processing requirements.
- Prepare for historically stronger sales periods.
- Validate timestamps before operational scheduling.

### Priority 4: Improve Product and Market Performance

- Separate postage and administrative charges.
- Identify recurring high-performing products.
- Evaluate international markets with high invoice values.
- Investigate exceptional bulk transactions.

---

## 17. Assumptions and Limitations

1. Gross sales include eligible positive-value transaction
   lines and may contain postage or administrative charges.

2. Negative-quantity transactions are classified as
   potential returns or cancellations.

3. Return-adjusted sales are not equivalent to
   accounting-recognized net revenue.

4. Customer concentration excludes anonymous transactions.

5. Product rankings may be influenced by non-merchandise
   charges and exceptional transactions.

6. December 2011 is an incomplete month ending December 9.

7. High-value invoices can materially influence
   average invoice values and daily sales metrics.

8. Invoice timestamps have not been verified against
   operational timezone definitions.

9. Monthly return impact uses transaction recording dates,
   not original purchase cohort dates.

10. Country-level sales represent dataset transaction
    values and do not establish market profitability.

11. Gross sales retain duplicate-looking business rows
    pending validation.

12. The dataset does not establish recognized revenue,
    taxes, or complete refund accounting.

---

## 18. Day 2 Conclusion

Day 2 successfully analyzed gross sales performance,
monthly revenue trends, daily and hourly purchasing activity,
geographical revenue distribution, invoice values,
returns and cancellations, product performance,
and customer sales concentration.

Gross positive sales reached 10,666,684.54 across
19,960 eligible invoices.

November 2011 was the strongest complete month,
generating 1,509,496.33 in gross sales.

The United Kingdom contributed 84.61% of gross sales,
while international markets contributed 15.39%.

The top 1% of identifiable purchasing customers
generated 32.00% of known-customer gross sales.

The analysis also identified substantial return impacts,
non-merchandise charges, and exceptional invoices
requiring additional investigation.

