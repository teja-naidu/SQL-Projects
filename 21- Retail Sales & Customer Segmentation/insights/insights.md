
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


---

# Day 3 – Customer Segmentation & RFM Analytics

## Objective

The objective of Day 3 is to analyze customer purchasing
behavior using Recency, Frequency, and Monetary (RFM)
metrics.

The analysis identifies repeat customers, high-value
customers, inactive customers, purchasing patterns,
and customer segments that may benefit from targeted
retention or engagement strategies.

Queries 31–45 were executed using DuckDB.

### Analysis Definitions

- Recency: Days since a customer's last eligible purchase.
- Frequency: Number of distinct eligible purchase invoices.
- Monetary: Total gross positive sales for a customer.
- Analysis reference date: December 10, 2011.
- Customer population: Identifiable customers with
  at least one eligible positive-sale transaction.

All monetary amounts are in dataset currency units.

---

## Query 31 – Customer Purchase Summary

### Findings

- Total identifiable purchasing customers: 4,338
- Known-customer invoices: 18,532
- Known-customer gross sales: 8,911,407.90
- Average gross sales per customer: 2,054.27
- Average invoices per customer: 4.27

### Business Insights

The dataset contains 4,338 identifiable purchasing
customers who generated approximately 8.91 million
in gross positive sales.

The average customer generated 4.27 invoices
during the observed period.

Average gross sales per customer reached 2,054.27,
but this value is influenced by high-spending customers.

### Recommendations

- Track customer-level revenue and purchase frequency.
- Compare average and median customer spending.
- Identify high-value customers for further analysis.
- Maintain separate reporting for anonymous sales.

---

## Query 32 – Repeat Purchase Rate

### Findings

- Total customers: 4,338
- One-time customers: 1,493
- Repeat customers: 2,845
- Repeat purchase rate: 65.58%

### Business Insights

Approximately 65.58% of identifiable customers
completed at least two eligible purchase invoices.

The remaining 34.42% purchased only once
during the observed dataset period.

Repeat purchasing represents a significant
component of customer activity.

### Recommendations

- Develop strategies to encourage second purchases.
- Investigate differences between one-time and
  repeat customers.
- Monitor repeat purchase rates by acquisition cohort.
- Avoid treating all one-time customers as churned.

---

## Query 33 – Purchase Frequency Distribution

### Findings

| Purchase Frequency | Customers | Share |
|---|---:|---:|
| 1 invoice | 1,493 | 34.42% |
| 2 invoices | 835 | 19.25% |
| 3–5 invoices | 1,138 | 26.23% |
| 6–10 invoices | 535 | 12.33% |
| 11+ invoices | 337 | 7.77% |

### Business Insights

The largest individual group consists of customers
who purchased only once.

A total of 872 customers generated six or more
purchase invoices.

The 337 customers with at least 11 invoices
represent a relatively small but highly active
customer population.

### Recommendations

- Investigate customers with frequent purchases.
- Encourage one-time buyers to make additional purchases.
- Compare purchase frequency with monetary contribution.
- Develop differentiated engagement strategies.

---

## Query 34 – Customer Recency Distribution

### Findings

| Recency | Customers | Share |
|---|---:|---:|
| 0–30 days | 1,628 | 37.53% |
| 31–60 days | 748 | 17.24% |
| 61–90 days | 513 | 11.83% |
| 91–180 days | 588 | 13.55% |
| 181+ days | 861 | 19.85% |

### Business Insights

A total of 1,628 customers purchased within
30 days of the historical reference date.

Meanwhile, 861 customers had not made an eligible
purchase for more than 180 days.

A combined 1,449 customers had recency greater
than 90 days, representing approximately one-third
of identifiable purchasing customers.

### Recommendations

- Monitor customer inactivity using historical recency.
- Investigate longer purchase gaps.
- Prioritize valuable customers with declining activity.
- Account for customer purchasing cycles before
  defining churn.

---

## Query 35 – Customer Monetary Value Distribution

### Findings

| Monetary Value | Customers | Gross Sales |
|---|---:|---:|
| Below 100 | 155 | 10,346.74 |
| 100–499 | 1,606 | 447,603.55 |
| 500–999 | 909 | 649,786.44 |
| 1,000–4,999 | 1,393 | 3,001,899.65 |
| 5,000+ | 275 | 4,801,771.52 |

### Business Insights

Only 275 customers generated at least 5,000
in gross positive sales.

These customers contributed approximately
53.88% of known-customer gross sales.

This demonstrates substantial spending concentration
among a relatively small customer group.

### Recommendations

- Prioritize high-value customer retention.
- Investigate concentration risk.
- Analyze purchasing frequency within the
  highest monetary group.
- Distinguish recurring high spenders from
  one-time bulk purchasers.

---

## Query 36 – Customer Tenure and Activity

### Findings

| Observed Tenure | Customers | Gross Sales |
|---|---:|---:|
| Same day | 1,548 | 704,741.62 |
| 1–30 days | 191 | 162,592.64 |
| 31–90 days | 411 | 409,801.45 |
| 91–180 days | 548 | 767,699.69 |
| 181+ days | 1,640 | 6,866,572.50 |

### Business Insights

Customers with an observed purchase span exceeding
180 days generated 6.87 million in gross sales.

This group had an average purchase frequency
of 8.16 invoices.

Customers whose first and last observed purchases
occurred on the same day generated substantially
less aggregate revenue.

Longer observed purchasing relationships are
associated with higher purchasing activity
in this dataset.

### Recommendations

- Analyze purchasing behavior over time.
- Identify long-term high-value customers.
- Compare customer tenure with frequency and spending.
- Avoid treating observed purchase span as the
  customer's complete relationship lifetime.

---

## Query 37 – Customer RFM Scores

### Findings

The RFM model assigns each customer three scores:

- Recency score: 1–5
- Frequency score: 1–5
- Monetary score: 1–5

Higher scores indicate stronger relative performance
under the chosen ranking method.

The maximum combined RFM score is 15.

Examples of customers receiving a score of 15:

| Customer ID | Frequency | Monetary |
|---|---:|---:|
| 14646 | 73 | 280,206.02 |
| 18102 | 60 | 259,657.30 |
| 17450 | 46 | 194,550.79 |
| 14911 | 201 | 143,825.06 |
| 14156 | 55 | 117,379.63 |

### Business Insights

High-scoring customers combine recent purchases,
frequent transactions, and high spending.

Customer 14646 generated 280,206.02 across
73 invoices.

Customer 14911 completed 201 invoices,
demonstrating exceptionally frequent purchasing.

### Recommendations

- Use RFM scores to identify strong customers.
- Monitor changes in customer RFM scores over time.
- Investigate whether high monetary scores result
  from recurring purchases or exceptional orders.
- Validate segmentation boundaries before
  operational deployment.

---

## Query 38 – RFM Customer Segmentation

### Findings

| Segment | Customers | Gross Sales |
|---|---:|---:|
| Champions | 946 | 5,746,144.46 |
| Loyal Customers | 505 | 939,911.31 |
| At Risk | 659 | 822,090.05 |
| Potential Loyalists | 842 | 739,795.46 |
| Hibernating | 1,077 | 525,901.52 |
| Recent Low-Frequency | 309 | 137,565.10 |

### Business Insights

Champions generated the highest gross sales,
contributing approximately 5.75 million.

Loyal Customers represent another important
repeat-purchasing segment.

The At Risk segment contains 659 customers
with relatively weak recency scores despite
meaningful purchasing histories.

Hibernating is the largest segment by customer
count, with 1,077 customers.

### Recommendations

- Champions: Focus on retention and relationship quality.
- Loyal Customers: Encourage continued engagement.
- At Risk: Investigate declining purchase activity.
- Potential Loyalists: Encourage additional purchases.
- Hibernating: Evaluate reactivation opportunities.
- Recent Low-Frequency: Support early repeat purchasing.

---

## Query 39 – RFM Segment Revenue Contribution

### Findings

| Segment | Customers | Sales Share |
|---|---:|---:|
| Champions | 946 | 64.48% |
| Loyal Customers | 505 | 10.55% |
| At Risk | 659 | 9.23% |
| Potential Loyalists | 842 | 8.30% |
| Hibernating | 1,077 | 5.90% |
| Recent Low-Frequency | 309 | 1.54% |

### Business Insights

Champions represent 21.81% of customers
but generate 64.48% of gross sales.

Champions and Loyal Customers together contribute
75.03% of known-customer gross sales.

This demonstrates a strong dependence on
high-performing customer segments.

### Recommendations

- Prioritize retention of Champions and Loyal Customers.
- Monitor high-value customer concentration.
- Develop segment-specific engagement strategies.
- Measure the effectiveness of future retention initiatives.

---

## Query 40 – Top High-Value Customers

### Findings

| Customer ID | Invoices | Gross Sales |
|---|---:|---:|
| 14646 | 73 | 280,206.02 |
| 18102 | 60 | 259,657.30 |
| 17450 | 46 | 194,550.79 |
| 16446 | 2 | 168,472.50 |
| 14911 | 201 | 143,825.06 |

### Business Insights

Customer 14646 generated the highest
known-customer gross sales.

Customer 18102 followed closely.

Customer 16446 generated 168,472.50
from only two invoices.

This demonstrates that high monetary value
does not always correspond to high frequency.

### Recommendations

- Distinguish recurring high-value customers
  from exceptional large-order customers.
- Evaluate customer concentration risk.
- Investigate whether top customers maintain
  consistent purchasing patterns.

---

## Query 41 – High-Value Customers at Risk

### Findings

The screening rule identifies customers with:

- Recency greater than 90 days.
- Gross positive sales of at least 5,000.

The query returned 10 customers.

Examples:

| Customer ID | Recency Days | Gross Sales |
|---|---:|---:|
| 12346 | 326 | 77,183.60 |
| 15749 | 236 | 44,534.30 |
| 15098 | 183 | 39,916.50 |
| 16180 | 101 | 10,254.18 |
| 12590 | 212 | 9,864.26 |

### Business Insights

Several historically high-spending customers
had long gaps since their last recorded purchases.

Customer 12346 had gross positive sales
of 77,183.60 but only one eligible purchase invoice.

These cases require return-adjusted validation
before interpreting their commercial value.

### Recommendations

- Investigate high-value customers with long inactivity.
- Review returns and cancellations associated with
  their original purchases.
- Evaluate whether customers have naturally
  infrequent bulk-purchasing cycles.
- Avoid classifying inactivity as confirmed churn.

---

## Query 42 – One-Time vs Repeat Customers

### Findings

| Customer Type | Customers | Gross Sales | Sales Share |
|---|---:|---:|---:|
| Repeat | 2,845 | 8,295,096.17 | 93.08% |
| One-Time | 1,493 | 616,311.73 | 6.92% |

### Business Insights

Repeat customers generated 93.08% of
known-customer gross positive sales.

One-time customers contributed only 6.92%.

Average customer sales were:

- Repeat customers: 2,915.68
- One-time customers: 412.80

Repeat purchasing is strongly associated
with higher customer-level spending.

### Recommendations

- Encourage customers to make a second purchase.
- Investigate successful repeat-purchasing patterns.
- Evaluate retention opportunities using cohort analysis.
- Measure incremental value rather than assuming
  repeat purchasing itself causes higher spending.

---

## Query 43 – Customer Purchase Gap Analysis

### Findings

- Repeat purchase intervals: 14,194
- Customers with intervals: 2,845
- Average gap: 39.97 days
- Median gap: 22 days
- Minimum gap: 0 days
- Maximum gap: 366 days

### Business Insights

The median observed interval between consecutive
eligible invoices was 22 days.

The mean interval was approximately 40 days,
indicating a distribution influenced by longer gaps.

Some customers completed multiple invoices
on the same day.

### Recommendations

- Investigate purchase timing distributions.
- Explore engagement windows around typical
  purchasing intervals.
- Segment purchase gaps by customer value.
- Validate whether repeated same-day invoices
  represent separate purchasing occasions.

---

## Query 44 – Customer Behavior by Country

### Findings

| Country | Customers | Repeat Rate |
|---|---:|---:|
| United Kingdom | 3,920 | 65.56% |
| Netherlands | 9 | 55.56% |
| EIRE | 3 | 100.00% |
| Germany | 94 | 72.34% |
| France | 87 | 67.82% |
| Australia | 9 | 100.00% |
| Spain | 30 | 63.33% |
| Switzerland | 21 | 71.43% |
| Belgium | 25 | 72.00% |
| Sweden | 8 | 50.00% |

### Business Insights

The United Kingdom contains the largest identifiable
customer population.

Germany recorded a repeat purchase rate of 72.34%.

France recorded a repeat purchase rate of 67.82%.

EIRE and Australia showed 100% repeat rates
within their small identifiable customer populations.

Small sample sizes limit the reliability of
cross-country comparisons.

### Recommendations

- Compare retention behavior across major markets.
- Investigate international customers with high spending.
- Apply minimum customer-count thresholds before
  ranking countries by repeat purchase rate.
- Evaluate customer identification gaps by country.

---

## Query 45 – Final Customer Segmentation Summary

### Findings

- Total customers: 4,338
- One-time customers: 1,493
- Repeat customers: 2,845
- Repeat purchase rate: 65.58%
- Average purchase frequency: 4.27
- Average customer sales: 2,054.27
- Median customer sales: 674.49
- Total known-customer gross sales: 8,911,407.90
- Average customer recency: 93.06 days

### Business Insights

The repeat purchase rate indicates that a majority
of identifiable customers completed multiple invoices.

Average customer spending substantially exceeds
median customer spending, reflecting a skewed
distribution.

Average historical recency was 93.06 days.

Customer behavior varies significantly across
frequency, spending, and inactivity dimensions.

### Recommendations

- Monitor repeat purchasing and recency together.
- Use median spending to complement average spending.
- Build RFM dashboards and historical segment snapshots.
- Investigate changes in customer behavior over time.

---

## Overall Day 3 Business Recommendations

### 1. Protect High-Value Customers

Champions and Loyal Customers collectively generate
75.03% of known-customer gross sales.

Prioritize understanding their purchase behavior
and retention requirements.

### 2. Improve Repeat Purchasing

One-time customers represent 34.42%
of identifiable purchasing customers.

Investigate opportunities to encourage second purchases.

### 3. Investigate At-Risk Customers

The RFM At Risk segment contains 659 customers.

Review their purchase histories and inactivity patterns
before designing reactivation strategies.

### 4. Develop Segment-Specific Engagement

Different customer groups require different approaches.

Potential Loyalists may benefit from additional
engagement, while Hibernating customers require
a separate reactivation assessment.

### 5. Improve Customer Analytics

Track recency, frequency, monetary value,
purchase gaps, and customer concentration
through consistent reporting definitions.

---

## Assumptions and Limitations

1. The analysis includes only identifiable customers
   with eligible positive-sale transactions.

2. Anonymous transactions are excluded from RFM analysis.

3. Monetary value represents gross positive sales,
   not return-adjusted or recognized net revenue.

4. RFM recency uses December 10, 2011,
   as the historical reference date.

5. RFM quintiles are rank-based and use customer IDs
   to break ties.

6. Customers with identical frequency values may
   receive different quintile scores near boundaries.

7. Customer segments are analytical classifications,
   not confirmed lifecycle statuses.

8. At-risk and hibernating classifications do not
   prove customer churn.

9. Observed customer tenure does not represent
   complete relationship lifetime.

10. Purchase gaps are measured between eligible
    invoice timestamps.

11. Multiple same-day invoices can produce
    zero-day purchase gaps.

12. Country-level customer populations may be small.

13. High-value customers may have substantial
    cancellations or returns excluded from gross sales.

14. RFM segment results depend on the chosen
    scoring and segmentation rules.

15. Historical customer behavior does not establish
    current customer status.

---

## Day 3 Conclusion

Day 3 successfully evaluated purchasing frequency,
customer recency, monetary value, RFM scores,
customer segments, high-value customers,
and purchase intervals.

The dataset contains 4,338 identifiable
purchasing customers.

Of these, 2,845 are repeat customers,
representing a 65.58% repeat purchase rate.

Repeat customers generate 93.08%
of known-customer gross sales.

The Champions segment contributes 64.48%
of known-customer gross sales.

The median observed purchase gap is 22 days.

These findings demonstrate the importance
of customer retention, repeat purchasing,
and differentiated customer engagement.


---

# Day 4 – Product Performance & Market Basket Analytics

## Objective

The objective of Day 4 is to evaluate product sales
performance, revenue concentration, return-related
transactions, basket composition, product associations,
and potential cross-selling opportunities.

Queries 46–60 were executed using DuckDB.

### Analysis Scope

- Dataset: Online Retail
- Positive-sale lines: 530,104
- Eligible invoices: 19,960
- Active stock codes: 3,922
- Gross positive sales: 10,666,684.54
- Analysis period: December 2010 to December 2011

Monetary values are expressed in dataset currency units.

Eligible positive sales require positive quantity and
unit price, a non-cancellation invoice identifier,
a valid stock code, and a nonblank country.

Stock codes are used as product identifiers. Some codes
represent postage, fees, discounts, or adjustments rather
than physical merchandise.

---

## Query 46 – Product Portfolio Overview

### Findings

| Metric | Result |
|---|---:|
| Unique stock codes | 3,922 |
| Unique descriptions | 4,026 |
| Positive-sale lines | 530,104 |
| Eligible invoices | 19,960 |
| Units sold | 5,588,376 |
| Gross positive sales | 10,666,684.54 |
| Average sales per stock code | 2,719.71 |

### Business Insights

The dataset contains 3,922 stock codes associated with
eligible positive sales.

The number of descriptions exceeds the number of stock
codes, indicating that some stock codes have multiple
descriptions across transactions.

Total gross positive sales reached 10.67 million.

The average revenue per stock code is 2,719.71, but
this average masks substantial variation in performance.

### Recommendations

- Establish a consistent product master reference.
- Review stock codes with multiple descriptions.
- Separate merchandise from service and adjustment codes.
- Compare product-level revenue with purchase frequency.

---

## Query 47 – Top Products by Gross Sales

### Findings

| Stock Code | Product / Entry | Gross Sales |
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

DOTCOM POSTAGE recorded the highest gross positive
transaction value, but it is a service-related entry.

REGENCY CAKESTAND 3 TIER was a leading physical
merchandise product.

PAPER CRAFT, LITTLE BIRDIE generated 168,469.60
from one invoice containing 80,995 units.

This exceptional transaction also appears in the
negative-quantity analysis and requires separate review.

The rankings include Manual and POSTAGE entries,
which should not be interpreted as merchandise demand.

### Recommendations

- Create separate merchandise-only sales rankings.
- Review exceptional bulk transactions.
- Investigate consistently high-selling products.
- Avoid prioritizing service codes for inventory decisions.

---

## Query 48 – Most Frequently Purchased Products

### Findings

| Stock Code | Product | Invoices |
|---|---|---:|
| 85123A | WHITE HANGING HEART T-LIGHT HOLDER | 2,198 |
| 85099B | JUMBO BAG RED RETROSPOT | 2,089 |
| 22423 | REGENCY CAKESTAND 3 TIER | 1,988 |
| 47566 | PARTY BUNTING | 1,685 |
| 20725 | LUNCH BAG RED SPOTTY | 1,565 |
| 84879 | ASSORTED COLOUR BIRD ORNAMENT | 1,455 |
| 22197 | SMALL POPCORN HOLDER | 1,392 |
| 22720 | SET OF 3 CAKE TINS PANTRY DESIGN | 1,385 |
| 21212 | PACK OF 72 RETROSPOT CAKE CASES | 1,320 |
| 22383 | LUNCH BAG SUKI DESIGN | 1,284 |

### Business Insights

WHITE HANGING HEART T-LIGHT HOLDER appeared in
2,198 eligible invoices, making it the most frequently
purchased stock code by distinct invoice count.

JUMBO BAG RED RETROSPOT appeared in 2,089 invoices.

Several bags, lunch bags, and household accessories
appeared frequently across customer baskets.

High invoice frequency does not necessarily imply
the highest revenue or unit volume.

### Recommendations

- Monitor frequently purchased products separately
  from highest-revenue products.
- Evaluate stock availability for frequently ordered items.
- Investigate opportunities for related-product placement.
- Compare invoice frequency with return-adjusted sales.

---

## Query 49 – Product Revenue and Volume Comparison

### Findings

| Product Group | Stock Codes | Units | Gross Sales |
|---|---:|---:|---:|
| High Revenue - High Volume | 669 | 3,817,334 | 7,389,116.16 |
| High Revenue - Lower Volume | 311 | 236,864 | 1,599,233.06 |
| Lower Revenue - High Volume | 311 | 797,442 | 412,388.26 |
| Other Products | 2,631 | 736,736 | 1,265,947.06 |

### Business Insights

The 669 products classified as both high revenue and
high volume generated approximately 69.27% of total
gross positive sales.

The high-revenue, lower-volume group generated
approximately 1.60 million.

The lower-revenue, high-volume group sold 797,442
units but generated only 412,388.26.

Revenue and volume rankings capture different aspects
of product performance.

### Recommendations

- Monitor high-revenue, high-volume products closely.
- Investigate pricing and unit economics for high-volume,
  lower-revenue products.
- Evaluate inventory priorities using multiple metrics.
- Do not interpret revenue quartiles as profit margins.

---

## Query 50 – Product Revenue Concentration

### Findings

| Product Group | Stock Codes | Gross Sales | Sales Share |
|---|---:|---:|---:|
| Top 1% | 40 | 2,281,126.37 | 21.39% |
| Next 4% | 157 | 2,784,825.79 | 26.11% |
| Next 15% | 588 | 3,411,523.20 | 31.98% |
| Remaining 80% | 3,137 | 2,189,209.18 | 20.52% |

### Business Insights

The top 40 stock codes generated 21.39% of gross sales.

The top 5% of products collectively generated 47.50%.

The top 20% collectively generated 79.48%.

The remaining 80% contributed 20.52%.

This demonstrates substantial revenue concentration
across the product portfolio.

### Recommendations

- Prioritize analysis of the top-performing product group.
- Review long-tail product performance.
- Investigate product assortment opportunities.
- Recalculate concentration after excluding
  non-merchandise codes and unusual adjustments.

---

## Query 51 – Low-Frequency Products

### Findings

The query identified stock codes purchased in three
or fewer distinct invoices.

Examples from the lowest-revenue results:

| Stock Code | Product | Invoices | Gross Sales |
|---|---|---:|---:|
| 84227 | HEN HOUSE W CHICK IN NEST | 1 | 0.42 |
| 51014c | FEATHER PEN, COAL BLACK | 1 | 0.83 |
| 21268 | VINTAGE BLUE TINSEL REEL | 1 | 0.84 |
| 90084 | PINK CRYSTAL GUITAR PHONE CHARM | 1 | 0.85 |
| 84206B | CAT WITH SUNGLASSES BLANK CARD | 1 | 0.95 |

### Business Insights

Several products appeared in only one invoice and
generated very low gross sales.

These products may represent slow-moving merchandise,
short-lived listings, discontinued items, or products
introduced near the end of the observation period.

The output is limited to 30 selected products and
does not establish the total number of slow movers.

### Recommendations

- Investigate low-frequency products before delisting.
- Review product launch and discontinuation dates.
- Consider seasonality and product availability.
- Combine sales frequency with inventory and cost data.

---

## Query 52 – Products with Highest Return-Related Values

### Findings

| Stock Code | Entry | Absolute Negative-Quantity Value |
|---|---|---:|
| AMAZONFEE | AMAZON FEE | 235,281.59 |
| 23843 | PAPER CRAFT, LITTLE BIRDIE | 168,469.60 |
| M | Manual | 146,784.46 |
| 23166 | MEDIUM CERAMIC TOP STORAGE JAR | 77,479.64 |
| POST | POSTAGE | 11,871.24 |
| 22423 | REGENCY CAKESTAND 3 TIER | 9,722.55 |
| CRUK | CRUK Commission | 7,933.43 |
| BANK CHARGES | Bank Charges | 7,340.64 |
| 85123A | WHITE HANGING HEART T-LIGHT HOLDER | 6,624.30 |
| 21108 | FAIRY CAKE FLANNEL ASSORTED COLOUR | 6,591.42 |

### Business Insights

AMAZONFEE recorded the highest absolute value among
negative-quantity transactions.

Manual entries and bank charges also appeared among
the largest negative-quantity values.

These records cannot all be interpreted as customer
product returns.

PAPER CRAFT, LITTLE BIRDIE recorded 80,995 negative
units with an absolute transaction value of 168,469.60.

MEDIUM CERAMIC TOP STORAGE JAR recorded 74,494
negative units and an absolute value of 77,479.64.

### Recommendations

- Separate physical returns from financial adjustments.
- Investigate unusually large quantity reversals.
- Establish a transaction-type classification.
- Validate return-related values before using them
  for product quality or refund-rate reporting.

---

## Query 53 – Return-Adjusted Product Performance

### Findings

| Stock Code | Gross Sales | Return-Adjusted Sales | Return Impact |
|---|---:|---:|---:|
| DOT | 206,248.77 | 206,245.48 | 0.00% |
| 22423 | 174,484.74 | 164,762.19 | 5.57% |
| 47566 | 99,504.33 | 98,302.98 | 1.21% |
| 85123A | 104,518.80 | 97,894.50 | 6.34% |
| 85099B | 94,340.05 | 92,356.03 | 2.10% |
| 23084 | 66,964.99 | 66,756.59 | 0.31% |
| POST | 78,101.88 | 66,230.64 | 15.20% |
| 22086 | 64,952.29 | 63,791.94 | 1.79% |

### Business Insights

REGENCY CAKESTAND 3 TIER generated 174,484.74 in
gross sales and 164,762.19 after signed adjustments.

WHITE HANGING HEART T-LIGHT HOLDER recorded a
6.34% return-related impact.

POSTAGE recorded a 15.20% impact, but this is
not a physical product return rate.

The exceptional PAPER CRAFT, LITTLE BIRDIE
transaction did not appear among the top 20
return-adjusted results.

### Recommendations

- Compare gross and return-adjusted performance.
- Investigate stock codes with substantial adjustments.
- Review transaction descriptions for correction entries.
- Avoid treating the calculated impact percentage
  as a verified customer return rate.

---

## Query 54 – Product Performance by Country

### Findings

| Country | Leading Stock Code | Gross Sales |
|---|---|---:|
| Australia | 23084 | 3,375.84 |
| EIRE | 22423 | 7,844.25 |
| France | POST | 15,454.00 |
| Germany | POST | 21,001.00 |
| Netherlands | 23084 | 9,568.48 |
| United Kingdom | DOT | 206,248.77 |

### Business Insights

RABBIT NIGHT LIGHT was the leading stock code by
gross sales in Australia and the Netherlands.

REGENCY CAKESTAND 3 TIER led in EIRE.

POSTAGE was the leading entry in France and Germany.

DOTCOM POSTAGE led in the United Kingdom.

The country rankings therefore mix merchandise
demand with service-related charges.

### Recommendations

- Produce country-specific merchandise rankings.
- Exclude postage from product demand comparisons.
- Investigate regional product preferences.
- Consider differences in market size and invoice volume.

---

## Query 55 – Market Basket Size Distribution

### Findings

| Basket Size | Invoices | Average Basket Value | Gross Sales |
|---|---:|---:|---:|
| 1 Product | 1,641 | 399.12 | 654,962.24 |
| 2–5 Products | 2,867 | 284.55 | 815,806.90 |
| 6–10 Products | 2,979 | 363.31 | 1,082,300.96 |
| 11–20 Products | 5,009 | 404.27 | 2,024,971.24 |
| 21+ Products | 7,464 | 815.73 | 6,088,643.20 |

### Business Insights

The 21+ product group contains 7,464 invoices.

This group generated approximately 57.08% of total
gross positive sales.

Its average basket value was 815.73.

The 1-product group had a relatively high average
basket value of 399.12, indicating that a single
stock code can still represent a substantial order.

Basket size and value are associated, but the
relationship is not strictly increasing across groups.

### Recommendations

- Investigate large multi-product baskets.
- Compare basket value with customer segments.
- Explore recommendations for smaller baskets.
- Account for bulk quantities and service entries.

---

## Query 56 – Most Frequent Product Pairs

### Findings

| Product A | Product B | Shared Invoices |
|---|---|---:|
| 22386 | 85099B | 825 |
| 22697 | 22699 | 767 |
| 21931 | 85099B | 724 |
| 22411 | 85099B | 680 |
| 20725 | 22383 | 655 |
| 20725 | 20727 | 641 |
| 22726 | 22727 | 640 |
| 22697 | 22698 | 632 |
| 20725 | 22384 | 606 |
| 22698 | 22699 | 598 |

### Business Insights

JUMBO BAG PINK POLKADOT and JUMBO BAG RED
RETROSPOT appeared together in 825 invoices.

JUMBO STORAGE BAG SUKI and JUMBO BAG RED
RETROSPOT appeared together in 724 invoices.

Several lunch bag stock codes frequently appeared
in the same baskets.

Repeated co-purchasing may reflect complementary
products, coordinated assortments, or customers
buying different variants of similar products.

### Recommendations

- Evaluate product-pair recommendation opportunities.
- Review whether frequent pairs represent variants.
- Consider related-product placement.
- Validate performance through controlled experiments.

---

## Query 57 – Product Association Rules

### Findings

Selected high-lift rules:

| Product A | Product B | Pair Baskets | Confidence | Lift |
|---|---|---:|---:|---:|
| 23556 | 23554 | 40 | 75.47% | 264.28 |
| 84931A | 84931B | 33 | 64.71% | 263.58 |
| 84997b | 84997c | 53 | 79.10% | 254.67 |
| 84997d | 84997c | 55 | 75.34% | 242.55 |
| 84997d | 84997b | 59 | 80.82% | 240.78 |

### Business Insights

Some product combinations have very high lift values.

For example, stock codes 23556 and 23554 have
a lift of 264.28 and occur together in 40 invoices.

However, their support is only 0.20% of all
eligible baskets.

High lift can occur when relatively uncommon
products are frequently purchased together.

Association confidence is directional:
confidence(A -> B) can differ from confidence(B -> A).

Lift is symmetric for the same product pair.

### Recommendations

- Consider support, confidence, and lift together.
- Validate high-lift combinations against product descriptions.
- Apply minimum support thresholds.
- Evaluate whether related variants or bundled products
  explain strong associations.
- Test recommendations before deployment.

---

## Query 58 – Cross-Selling Opportunities

### Findings

Selected directional recommendations:

| Anchor Product | Recommended Product | Shared Baskets | Confidence |
|---|---|---:|---:|
| 22386 | 85099B | 825 | 67.73% |
| 21931 | 85099B | 724 | 61.15% |
| 22411 | 85099B | 680 | 57.87% |
| 22383 | 20725 | 655 | 51.01% |
| 20727 | 20725 | 641 | 50.35% |
| 22086 | 22910 | 552 | 47.59% |
| 23203 | 85099B | 577 | 46.87% |
| 22469 | 22470 | 493 | 41.05% |

### Business Insights

Among baskets containing JUMBO BAG PINK POLKADOT,
67.73% also contained JUMBO BAG RED RETROSPOT.

Among baskets containing JUMBO STORAGE BAG SUKI,
61.15% also contained JUMBO BAG RED RETROSPOT.

Several lunch bag and storage bag combinations
showed relatively strong directional confidence.

These patterns provide candidates for recommendation
experiments rather than proven incremental sales gains.

### Recommendations

- Evaluate "Frequently Bought Together" suggestions.
- Investigate coordinated product collections.
- Use directional confidence for recommendation ranking.
- Validate candidate products against availability
  and current assortment data.
- Measure incremental revenue through experiments.

---

## Query 59 – Product Co-Purchase Network

### Findings

| Stock Code | Connected Products | Pair Occurrences |
|---|---:|---:|
| 85123A | 1,449 | 108,348 |
| 85099B | 1,434 | 118,405 |
| DOT | 1,409 | 103,501 |
| 22197 | 1,357 | 96,683 |
| 22961 | 1,326 | 90,904 |
| 22423 | 1,319 | 94,901 |
| 21212 | 1,270 | 91,637 |
| 22457 | 1,266 | 81,676 |

### Business Insights

WHITE HANGING HEART T-LIGHT HOLDER had the
highest number of qualifying product connections.

JUMBO BAG RED RETROSPOT had the highest total
pair occurrences among the displayed results.

DOTCOM POSTAGE also appeared as a highly connected
stock code.

This confirms that service entries can distort
product co-purchase network analysis.

Total pair occurrences represent sums across
different pair relationships, not unique invoices.

### Recommendations

- Exclude non-merchandise codes from recommendation networks.
- Investigate highly connected merchandise products.
- Explore product groups and purchasing communities.
- Compare co-purchase frequency with commercial value.

---

## Query 60 – Final Product Performance KPIs

### Findings

| Metric | Result |
|---|---:|
| Unique stock codes | 3,922 |
| Positive-sale lines | 530,104 |
| Eligible baskets | 19,960 |
| Units sold | 5,588,376 |
| Gross positive sales | 10,666,684.54 |
| Average unique products per basket | 26.03 |
| Median unique products per basket | 15.00 |
| Average basket value | 534.40 |

### Business Insights

The dataset contains 19,960 eligible purchase baskets.

The average basket includes 26.03 unique stock codes.

The median basket contains 15 unique stock codes,
indicating that larger baskets increase the average.

Average gross basket value is 534.40.

These results suggest that multi-product purchasing
is an important characteristic of the dataset.

### Recommendations

- Track basket size and basket value together.
- Monitor product assortment performance.
- Compare basket behavior across customer segments.
- Validate product-only KPIs after excluding service codes.

---

## Overall Day 4 Business Recommendations

### 1. Prioritize High-Performing Merchandise

The top 20% of stock codes generate 79.48%
of gross positive sales.

Investigate these products for inventory,
availability, and merchandising decisions.

### 2. Separate Merchandise from Financial Entries

Postage, fees, discounts, and manual adjustments
appear in product sales and return rankings.

Create a classification layer before using these
metrics for operational decisions.

### 3. Investigate Exceptional Reversals

The PAPER CRAFT, LITTLE BIRDIE transaction has
matching gross positive and negative-quantity
absolute values.

Review the transaction history before interpreting
the stock code as a high-performing product.

### 4. Evaluate Product Recommendations

Frequently purchased product pairs provide
candidates for cross-selling experiments.

Prioritize combinations with sufficient transaction
volume and meaningful directional confidence.

### 5. Improve Product Portfolio Reporting

Monitor revenue, invoice frequency, unit volume,
return-adjusted sales, and basket associations
through separate but connected product metrics.

### 6. Analyze Large Baskets

The 21+ product group generates approximately
57.08% of gross positive sales.

Investigate the characteristics of customers
and invoices associated with these baskets.

---

## Assumptions and Limitations

1. Product-level analysis uses stock codes as
   identifiers.

2. Multiple descriptions may exist for one stock code.

3. MAX(description) selects a representative string
   and does not guarantee the canonical product name.

4. Gross sales exclude negative-quantity transactions.

5. Some stock codes represent postage, discounts,
   fees, or administrative adjustments.

6. Product revenue rankings are not merchandise-only.

7. Product profitability cannot be calculated because
   costs and margins are unavailable.

8. Return-related calculations include financial
   adjustments and cannot be interpreted as verified
   customer return rates.

9. Negative-quantity rows with negative unit prices
   can contribute positive signed values.

10. Return-adjusted sales are analytical transaction
    values, not audited recognized revenue.

11. Exceptional bulk transactions may distort rankings.

12. Basket analysis groups transactions by invoice
    identifier, including invoices with multiple
    timestamps identified during Day 1.

13. Product pairs are based on distinct stock codes
    per invoice, not purchased quantities.

14. Association rules describe historical co-occurrence
    and do not establish causal relationships.

15. High-lift pairs may have low support.

16. Association rule results are directional, and
    reverse-direction rules may have different confidence.

17. The network uses a minimum pair frequency of
    30 invoices.

18. Cross-selling recommendations have not been
    validated through experiments.

19. Inventory levels, product costs, stockouts,
    and product availability are not included.

20. Historical purchasing patterns do not necessarily
    represent current customer demand.

---

## Day 4 Conclusion

Day 4 successfully analyzed product performance,
revenue concentration, return-related transactions,
basket composition, product associations,
cross-selling candidates, and product networks.

The dataset contains 3,922 active stock codes,
19,960 eligible baskets, and 10.67 million
in gross positive sales.

The top 20% of stock codes contribute 79.48%
of gross sales.

The most frequent observed product pair is
22386 and 85099B, appearing together in
825 eligible invoices.

Average basket size is 26.03 distinct products,
while median basket size is 15.

The analysis also identifies the importance
of separating merchandise from financial entries
and reviewing exceptional transaction reversals.

These findings establish a foundation for product
portfolio optimization and future cross-selling
experiments.

# Day 5 – Customer Cohort, Retention & Lifetime Value Analytics

**Project:** Retail Sales & Customer Segmentation  
**Analysis:** Queries 61–75  
**Database:** DuckDB  
**Dataset period:** December 1, 2010 – December 9, 2011

## Day 5 Objectives

The final analysis focuses on understanding how customers are acquired, how frequently they return, how much gross sales they generate during the observed period, and which customer groups offer opportunities for retention and reactivation.

The analysis covers:

- Customer acquisition and cohort performance
- New versus returning customers
- Monthly retention and cohort retention patterns
- Cohort revenue development
- Observed customer lifetime value
- Customer revenue concentration
- Reactivation and inactivity
- Customer purchasing lifecycle
- Repeat-purchase conversion
- Geographical customer behavior
- Final customer engagement KPIs

---

## Query 61 – Customer Acquisition Cohorts

### Findings

Customer acquisition varied substantially across the observation period.

| Acquisition cohort | Customers | Observed lifetime gross sales | Average per customer |
|---|---:|---:|---:|
| Dec 2010 | 885 | 4,512,148.22 | 5,098.47 |
| Jan 2011 | 417 | 1,125,882.28 | 2,699.96 |
| Feb 2011 | 380 | 593,876.88 | 1,562.83 |
| Mar 2011 | 452 | 643,758.94 | 1,424.25 |
| Apr 2011 | 300 | 326,621.03 | 1,088.74 |
| May 2011 | 284 | 455,545.38 | 1,604.03 |
| Jun 2011 | 242 | 273,455.23 | 1,129.98 |
| Jul 2011 | 188 | 144,468.34 | 768.45 |
| Aug 2011 | 169 | 196,049.05 | 1,160.05 |
| Sep 2011 | 299 | 233,296.82 | 780.26 |
| Oct 2011 | 358 | 227,369.54 | 635.11 |
| Nov 2011 | 323 | 151,876.73 | 470.21 |
| Dec 2011 | 41 | 27,059.46 | 659.99 |

The December 2010 cohort was the largest, with 885 customers, and generated 4.51 million in observed gross sales. It also had the longest available observation window.

Customer acquisition declined to 169 in August 2011 before recovering to 299 in September and 358 in October.

The October 2011 cohort acquired more customers than September, but its observed sales per customer were lower.

### Business Insights

1. Early cohorts contributed a disproportionate share of historical sales.
2. Acquisition recovered during the September–November seasonal period.
3. Newer cohorts naturally have less time to accumulate repeat purchases and gross sales.
4. Cohort value should be compared at equivalent ages, such as the first 30, 60, or 90 days.

### Recommendations

- Track acquisition volume and customer quality together.
- Compare cohorts using equal observation windows.
- Investigate which acquisition channels or product categories produced high-value customers, if those attributes become available.
- Monitor whether seasonal acquisition campaigns generate repeat purchasers.

---

## Query 62 – Monthly New vs Returning Customers

### Findings

| Month | Active customers | New | Returning |
|---|---:|---:|---:|
| Dec 2010 | 885 | 885 | 0 |
| Jan 2011 | 741 | 417 | 324 |
| Feb 2011 | 758 | 380 | 378 |
| Mar 2011 | 974 | 452 | 522 |
| Apr 2011 | 856 | 300 | 556 |
| May 2011 | 1,056 | 284 | 772 |
| Jun 2011 | 991 | 242 | 749 |
| Jul 2011 | 949 | 188 | 761 |
| Aug 2011 | 935 | 169 | 766 |
| Sep 2011 | 1,266 | 299 | 967 |
| Oct 2011 | 1,364 | 358 | 1,006 |
| Nov 2011 | 1,664 | 323 | 1,341 |
| Dec 2011* | 615 | 41 | 574 |

*December 2011 is incomplete.*

November 2011 recorded the highest number of active customers, at 1,664.

Of these, 1,341 were returning customers, representing approximately 80.6% of November's active customer base.

Returning customers increasingly dominated monthly activity as the customer base matured.

### Business Insights

- Existing customers were important contributors to late-2011 purchasing activity.
- Customer growth was driven by both new acquisition and repeat engagement.
- The November activity peak was not dependent exclusively on first-time buyers.

### Recommendations

- Develop targeted campaigns for returning customers before peak shopping periods.
- Maintain separate acquisition and returning-customer KPIs.
- Measure whether new customers acquired during seasonal peaks return in subsequent months.

---

## Query 63 – Monthly Customer Retention

### Findings

| Purchase month | Next-month retention |
|---|---:|
| Dec 2010 | 36.61% |
| Jan 2011 | 35.36% |
| Feb 2011 | 38.26% |
| Mar 2011 | 31.21% |
| Apr 2011 | 42.99% |
| May 2011 | 38.83% |
| Jun 2011 | 36.83% |
| Jul 2011 | 40.89% |
| Aug 2011 | 45.45% |
| Sep 2011 | 38.63% |
| Oct 2011 | 45.60% |
| Nov 2011 | 22.30% |
| Dec 2011 | N/A |

October 2011 achieved the highest observed next-month retention rate, at 45.60%.

August followed closely at 45.45%.

March recorded the lowest rate among the complete-month comparisons before November, at 31.21%.

November's reported retention of 22.30% is not directly comparable because December data ends on December 9.

### Business Insights

- Next-month purchasing generally ranged from approximately 31% to 46% across the fully observable month pairs.
- A substantial proportion of customers did not purchase in consecutive months.
- Consecutive-month retention is a relatively strict definition for retail businesses, where customers may purchase intermittently.

### Recommendations

- Monitor 30-, 60-, and 90-day repeat purchasing alongside calendar-month retention.
- Investigate the purchase categories associated with frequent repeat behavior.
- Avoid treating customers who skip one month as permanently churned.

---

## Query 64 – Cohort Retention Matrix

### Findings

The December 2010 cohort demonstrated substantial long-term engagement.

| Cohort age | Dec 2010 cohort retention |
|---|---:|
| Month 0 | 100.00% |
| Month 1 | 36.61% |
| Month 2 | 32.32% |
| Month 3 | 38.42% |
| Month 6 | 36.27% |
| Month 9 | 39.55% |
| Month 11 | 50.28% |
| Month 12* | 26.55% |

*Month 12 is only partially observed.*

At month 11, 445 of the original 885 customers purchased again.

Other first-month retention results included:

- January 2011: 22.06%
- February 2011: 18.68%
- March 2011: 15.04%
- April 2011: 21.33%
- May 2011: 19.01%
- June 2011: 17.36%
- July 2011: 18.09%
- August 2011: 20.71%
- September 2011: 23.41%
- October 2011: 24.02%
- November 2011: 11.15%, with an incomplete following month

### Business Insights

1. The December 2010 cohort displayed stronger first-month retention than most subsequent cohorts.
2. Retention did not decline monotonically; customers sometimes returned after skipping earlier months.
3. The December 2010 cohort reached 50.28% monthly activity at month 11, coinciding with November 2011.
4. Later cohorts have progressively shorter observation windows.

### Recommendations

- Use cohort heatmaps to visualize repeat-purchase patterns.
- Compare cohort retention at identical ages.
- Evaluate seasonal reactivation separately from continuous retention.
- Treat unobserved future cohort periods as unavailable, not as zero retention.

---

## Query 65 – Cohort Revenue Performance

### Findings

The December 2010 cohort generated:

- Month 0 gross sales: 572,713.89
- Month 9 gross sales: 472,813.64
- Month 10 gross sales: 456,080.61
- Month 11 gross sales: 513,803.59

At month 11, the cohort generated 580.57 in gross sales per original cohort customer.

The January 2011 cohort generated 293,207.35 during its acquisition month and 123,882.10 at month 10.

The September 2011 cohort generated 155,103.90 in month 0 and 37,033.97 in month 2.

An important outlier appears in the May 2011 cohort:

- Month 7 purchasing customers: 27
- Month 7 gross sales: 179,251.53
- Gross sales per original cohort customer: 631.17

This is unusually high relative to the small number of active customers and should be investigated for large transactions.

### Business Insights

- Cohort revenue depends on both the number of returning customers and their transaction values.
- Older cohorts continued generating meaningful sales throughout the observation period.
- A small number of large purchases can materially affect cohort-level revenue.
- Strong cohort revenue does not necessarily imply strong customer retention.

### Recommendations

- Analyze cohort revenue together with active-customer counts.
- Track median transaction value and top-customer concentration within cohorts.
- Investigate unusually large cohort-month transactions.
- Calculate cumulative revenue at consistent cohort ages.

---

## Query 66 – Customer Lifetime Value Proxy

### Findings

The highest-value identifiable customers were:

| Customer ID | Invoices | Observed gross sales |
|---|---:|---:|
| 14646 | 73 | 280,206.02 |
| 18102 | 60 | 259,657.30 |
| 17450 | 46 | 194,550.79 |
| 16446 | 2 | 168,472.50 |
| 14911 | 201 | 143,825.06 |
| 12415 | 21 | 124,914.53 |
| 14156 | 55 | 117,379.63 |
| 17511 | 31 | 91,062.38 |
| 16029 | 63 | 81,024.84 |
| 12346 | 1 | 77,183.60 |

Customer 14646 generated the highest observed gross sales, at 280,206.02 across 73 invoices.

Customer 14911 placed 201 invoices, demonstrating that purchase frequency and monetary value are distinct dimensions.

Customer 16446 generated 168,472.50 from only two invoices, while customer 12346 generated 77,183.60 from one invoice.

### Business Insights

- Customer value is highly uneven.
- High-frequency customers and high-ticket customers may require different retention strategies.
- Large one-off purchases can distort average customer value.
- Gross sales do not account for cancellations, refunds, costs, or margins.

### Recommendations

- Separate high-frequency and high-ticket customer segments.
- Prioritize relationship management for valuable recurring customers.
- Review unusually large invoices before drawing conclusions about customer profitability.
- Use observed gross customer sales as a historical value proxy, not predictive CLV.

---

## Query 67 – Customer Lifetime Value Segments

### Findings

| Observed value segment | Customers | Gross sales |
|---|---:|---:|
| 10,000+ | 104 | 3,653,544.48 |
| 5,000–9,999 | 171 | 1,148,227.04 |
| 1,000–4,999 | 1,393 | 3,001,899.65 |
| 500–999 | 909 | 649,786.44 |
| Below 500 | 1,761 | 457,950.29 |

Only 104 customers, approximately 2.4% of identifiable customers, generated approximately 41.0% of known-customer gross sales.

The 1,761 customers below 500 represented approximately 40.6% of customers but contributed only about 5.1% of gross sales.

### Business Insights

- A small high-value customer segment accounts for a large proportion of revenue.
- Mid-value customers collectively generate substantial sales and may offer opportunities for growth.
- Lower-value customers represent a large population with relatively small individual contributions.

### Recommendations

- Establish differentiated engagement strategies by observed value.
- Offer proactive support and relationship management to high-value customers.
- Test cross-selling and repeat-purchase campaigns for mid-value customers.
- Evaluate campaign profitability before investing heavily in low-value segments.

---

## Query 68 – Customer Revenue Concentration

### Findings

| Customer group | Customers | Gross sales | Sales share |
|---|---:|---:|---:|
| Top 1% | 44 | 2,851,548.57 | 32.00% |
| Next 4% | 173 | 1,637,851.64 | 18.38% |
| Next 15% | 651 | 2,160,037.25 | 24.24% |
| Remaining 80% | 3,470 | 2,261,970.44 | 25.38% |

The top 5% of customers generated 50.38% of identifiable-customer gross sales.

The top 20% generated 74.62%.

The remaining 80% collectively generated 25.38%.

### Business Insights

- Revenue concentration creates dependence on a relatively small customer population.
- Retaining high-value customers may have a disproportionate financial impact.
- The broad customer base still provides diversification and potential for future growth.

### Recommendations

- Monitor revenue concentration regularly.
- Develop retention strategies for high-value customers.
- Identify mid-value customers with potential to become high-value customers.
- Avoid overreliance on a small group of large purchasers.

---

## Query 69 – Customer Reactivation Analysis

### Findings

Customers who returned after skipping at least one calendar month increased substantially throughout 2011.

| Month | First-time | Consecutive-month returners | Reactivated after gap |
|---|---:|---:|---:|
| May 2011 | 284 | 368 | 404 |
| Jun 2011 | 242 | 410 | 339 |
| Jul 2011 | 188 | 365 | 396 |
| Aug 2011 | 169 | 388 | 378 |
| Sep 2011 | 299 | 425 | 542 |
| Oct 2011 | 358 | 489 | 517 |
| Nov 2011 | 323 | 622 | 719 |

November 2011 recorded the highest observed reactivation count, at 719 customers.

This exceeded both the 622 consecutive-month returners and 323 first-time customers.

### Business Insights

- Returning after a purchasing gap was an important component of customer activity.
- The September–November period was particularly strong for customer re-engagement.
- Monthly inactivity does not necessarily represent permanent customer loss.

### Recommendations

- Build win-back campaigns for customers with prior purchasing history.
- Analyze seasonal reactivation behavior.
- Use prior purchase categories and historical value to prioritize reactivation.
- Distinguish reactivated customers from continuously active customers in reporting.

---

## Query 70 – Customer Inactivity Risk Proxy

### Findings

| Inactivity segment | Customers | Historical gross sales |
|---|---:|---:|
| Recently Active: 0–30 days | 1,628 | 6,237,842.63 |
| Moderate: 31–90 days | 1,261 | 1,638,294.86 |
| High: 91–180 days | 588 | 478,857.73 |
| Extended: 181+ days | 861 | 556,412.68 |

Recently active customers averaged 7.32 invoices, compared with 1.51 among customers inactive for at least 181 days.

The 1,449 customers in the 91+ day groups represented approximately 33.4% of the identifiable customer base.

Their combined historical gross sales were 1,035,270.41.

### Business Insights

- Recently active customers accounted for a substantial proportion of historical gross sales.
- Longer-inactive customers generally demonstrated lower observed purchase frequency.
- Some inactive customers have meaningful historical value and may be worthwhile reactivation targets.

### Recommendations

- Prioritize previously valuable customers who have become inactive.
- Use 30-, 90-, and 180-day recency thresholds for operational monitoring.
- Test reactivation campaigns with control groups.
- Treat inactivity as a behavioral risk indicator rather than confirmed churn.

---

## Query 71 – Customer Purchasing Lifecycle

### Findings

| Lifecycle segment | Customers | Gross sales |
|---|---:|---:|
| Long-Term Repeat Buyer | 1,640 | 6,866,572.50 |
| Repeat Within 91–180 Days | 548 | 767,699.69 |
| One-Time Buyer | 1,493 | 616,311.73 |
| Repeat Within 31–90 Days | 411 | 409,801.45 |
| Repeat Within 30 Days | 246 | 251,022.53 |

Long-term repeat buyers generated approximately 77.1% of known-customer gross sales.

These 1,640 customers averaged 8.16 invoices and had an average observed first-to-last purchase span of 284 days.

One-time buyers represented approximately 34.4% of identifiable customers.

### Business Insights

- Long-term repeat buyers were the strongest customer lifecycle group by gross sales.
- A significant population purchased only once during the observation period.
- The number of purchases and the time between first and last purchases both help distinguish customer behavior.

### Recommendations

- Develop loyalty and account-management programs for established repeat buyers.
- Encourage second purchases through post-purchase engagement.
- Investigate whether one-time buyers purchased seasonal or infrequently replenished products.
- Monitor transitions between lifecycle segments over time.

**Interpretation note:** These lifecycle labels describe the span between first and last observed purchases. They do not measure the exact delay between the first and second purchase.

---

## Query 72 – Cohort Repeat Purchase Conversion

### Findings

| Acquisition cohort | Customers | Repeat customers | Observed repeat rate |
|---|---:|---:|---:|
| Dec 2010 | 885 | 774 | 87.46% |
| Jan 2011 | 417 | 340 | 81.53% |
| Feb 2011 | 380 | 293 | 77.11% |
| Mar 2011 | 452 | 326 | 72.12% |
| Apr 2011 | 300 | 200 | 66.67% |
| May 2011 | 284 | 197 | 69.37% |
| Jun 2011 | 242 | 156 | 64.46% |
| Jul 2011 | 188 | 114 | 60.64% |
| Aug 2011 | 169 | 92 | 54.44% |
| Sep 2011 | 299 | 143 | 47.83% |
| Oct 2011 | 358 | 124 | 34.64% |
| Nov 2011 | 323 | 85 | 26.32% |
| Dec 2011 | 41 | 1 | 2.44% |

The December 2010 cohort achieved the highest observed repeat-purchase conversion at 87.46%.

Later cohorts show lower observed repeat rates, particularly in October–December 2011.

### Business Insights

- Earlier cohorts had more time to make additional purchases.
- The downward pattern across newer cohorts is strongly affected by unequal observation windows.
- The results do not establish that recent acquisition quality deteriorated.

### Recommendations

- Compare repeat conversion within fixed 30-, 60-, and 90-day windows.
- Exclude cohorts without sufficient follow-up time from mature-cohort benchmarks.
- Monitor first-to-second purchase timing.
- Evaluate onboarding and second-purchase campaigns.

---

## Query 73 – Customer Retention by Country

### Findings

| Country | Customers | Repeat purchase rate |
|---|---:|---:|
| United Kingdom | 3,920 | 65.56% |
| Germany | 94 | 72.34% |
| France | 87 | 67.82% |
| Spain | 28 | 64.29% |
| Belgium | 24 | 75.00% |
| Switzerland | 20 | 75.00% |
| Portugal | 19 | 63.16% |
| Italy | 14 | 42.86% |
| Netherlands | 9 | 55.56% |
| Australia | 9 | 100.00% |

The United Kingdom dominated the identifiable customer base, with 3,920 customers.

Germany demonstrated a 72.34% repeat-purchase rate among 94 customers.

Australia recorded a 100% observed repeat-purchase rate, but its sample contained only nine customers.

Netherlands customers averaged 10.44 invoices per customer, despite the small sample of nine customers.

### Business Insights

- Customer repeat behavior varies across markets.
- The UK provides the largest customer population for retention analysis.
- Some international markets demonstrate strong repeat behavior but have limited sample sizes.
- Small-country comparisons can be heavily influenced by individual customers.

### Recommendations

- Prioritize statistically meaningful markets for retention benchmarking.
- Investigate Germany and France as potential international retention opportunities.
- Analyze customer purchasing patterns within smaller high-frequency markets.
- Avoid ranking countries solely on repeat rates without considering sample size.

---

## Query 74 – Monthly Customer Engagement KPIs

### Findings

| Month | Active customers | Invoices | Known-customer gross sales |
|---|---:|---:|---:|
| Jan 2011 | 741 | 987 | 569,445.04 |
| Mar 2011 | 974 | 1,321 | 595,500.76 |
| May 2011 | 1,056 | 1,555 | 678,594.56 |
| Aug 2011 | 935 | 1,280 | 645,343.90 |
| Sep 2011 | 1,266 | 1,755 | 952,838.38 |
| Oct 2011 | 1,364 | 1,929 | 1,039,318.79 |
| Nov 2011 | 1,664 | 2,657 | 1,161,817.38 |
| Dec 2011* | 615 | 778 | 518,192.79 |

*December 2011 is partial.*

November 2011 recorded the highest active customer count, invoice count, and known-customer gross sales among the complete months.

Its average invoices per active customer reached 1.60, compared with 1.39 in September and 1.41 in October.

September and October also demonstrated strong sales performance as the peak season approached.

December 2011 showed 842.59 in gross sales per active customer, but the incomplete month and large transactions limit comparability.

### Business Insights

- September–November showed a strong increase in customer engagement.
- November's sales performance was supported by both customer volume and purchasing frequency.
- Sales per active customer and invoice frequency provide complementary measures of engagement.

### Recommendations

- Prepare inventory and operational capacity ahead of peak demand.
- Track active customers, invoices per customer, and sales per customer together.
- Compare seasonal months year over year when additional historical data becomes available.
- Monitor the influence of unusually large transactions.

---

## Query 75 – Final Customer Analytics KPI Summary

### Findings

| KPI | Result |
|---|---:|
| Identifiable customers | 4,338 |
| One-time customers | 1,493 |
| Repeat customers | 2,845 |
| Repeat purchase rate | 65.58% |
| Customer invoices | 18,532 |
| Known-customer gross sales | 8,911,407.90 |
| Average observed customer value | 2,054.27 |
| Median observed customer value | 674.49 |
| Average purchase frequency | 4.27 invoices |
| Average recency | 93.06 days |
| Average observed purchase span | 130.77 days |

### Business Insights

1. **Repeat purchasing is a major business driver.** Approximately two-thirds of identifiable customers purchased more than once during the observation period.

2. **Customer value is highly skewed.** Average observed customer value was approximately three times the median, reflecting the influence of high-value customers.

3. **A significant one-time customer population remains.** The 1,493 one-time buyers represent an opportunity to investigate barriers to repeat purchasing.

4. **Customer relationships vary considerably in duration.** The average observed first-to-last purchase span was 130.77 days.

5. **Customer inactivity is meaningful but not equivalent to churn.** Average recency was 93.06 days, and many customers returned after purchasing gaps.

### Recommendations

- Establish a customer retention dashboard with repeat rate, recency, frequency, and observed value.
- Develop a second-purchase conversion strategy for one-time buyers.
- Protect high-value customer relationships.
- Test win-back campaigns for valuable inactive customers.
- Monitor acquisition cohorts using standardized observation windows.

---

## Overall Day 5 Business Recommendations

### Priority 1 – Strengthen High-Value Customer Retention

The top 5% of identifiable customers generated 50.38% of known-customer gross sales.

**Recommended actions:**
- Identify high-value customers with increasing inactivity.
- Develop targeted account-management and loyalty strategies.
- Monitor concentration risk and changes in top-customer behavior.

### Priority 2 – Improve Second-Purchase Conversion

There were 1,493 customers with only one observed invoice.

**Recommended actions:**
- Analyze products associated with one-time purchases.
- Test post-purchase follow-ups and relevant cross-selling.
- Measure second-purchase conversion within consistent time windows.

### Priority 3 – Build Customer Reactivation Campaigns

November 2011 recorded 719 customers returning after at least one skipped calendar month.

**Recommended actions:**
- Segment customers by historical spending and inactivity.
- Test personalized reactivation campaigns.
- Evaluate incremental purchases and campaign profitability.

### Priority 4 – Improve Cohort Measurement

Later cohorts have shorter observation periods and cannot be compared directly with mature cohorts.

**Recommended actions:**
- Standardize 30-, 60-, and 90-day retention and value metrics.
- Build a cohort retention heatmap.
- Report incomplete cohort periods separately.

### Priority 5 – Prepare for Seasonal Demand

November 2011 reached 1,664 active customers and 1,161,817.38 in known-customer gross sales.

**Recommended actions:**
- Prepare marketing and operational capacity before peak months.
- Use returning-customer history for demand planning.
- Monitor large transactions separately from typical customer behavior.

---

## Data Quality and Analytical Limitations

1. **Incomplete observation window:** The dataset ends on December 9, 2011. December results are not full-month results.

2. **Left-censored acquisition history:** December 2010 represents the first available dataset month. Customers classified as new may have purchased before the dataset began.

3. **Unequal cohort maturity:** Earlier cohorts have more time to accumulate purchases and revenue.

4. **Missing customer identifiers:** Customers without valid IDs are excluded from customer-level analyses. These results therefore do not represent all retail sales.

5. **Gross positive sales:** Monetary metrics include eligible positive sales only. They do not deduct returns, cancellations, operating costs, or fulfillment expenses.

6. **Currency:** Monetary values are presented in dataset currency units without assuming an explicit currency code.

7. **Observed value versus predictive CLV:** Historical cumulative sales are not forecasts of future customer value.

8. **Inactivity versus churn:** A customer with no recent purchase is not necessarily permanently lost.

9. **Small geographical samples:** Country-level repeat rates may be unstable when customer counts are low.

10. **Large-transaction outliers:** A small number of unusually large invoices can significantly influence customer and cohort averages.

11. **Non-merchandise charges:** Eligible positive sales may include postage and manual charge stock codes. Merchandise-only revenue requires a separate classification.

12. **Invoice identification:** Purchase frequency uses distinct invoice numbers, assuming invoice identifiers consistently represent separate purchases.

---

## Final Day 5 Conclusion

The final analysis demonstrates that customer retention, repeat purchasing, and revenue concentration are central to understanding the historical retail business.

Across 4,338 identifiable customers, 2,845 made repeat purchases, producing an observed repeat-purchase rate of 65.58%.

Customer value was highly concentrated: the top 5% generated 50.38% of known-customer gross sales, while long-term repeat buyers generated approximately 77.1%.

Cohort analysis revealed meaningful repeat purchasing over time, but also highlighted the importance of comparing customers using consistent observation windows.

Customer reactivation was particularly significant during the September–November seasonal period, demonstrating that purchasing gaps should not automatically be interpreted as permanent churn.

**Final recommendation:** Combine cohort retention, RFM segmentation, historical customer value, and inactivity monitoring into a unified customer analytics framework to support targeted retention, reactivation, and customer growth strategies.

---

## Project Completion Summary

**Project 21 – Retail Sales & Customer Segmentation Analytics**

- Day 1: Data Exploration & Quality Assessment — Queries 1–15
- Day 2: Sales Performance & Revenue Trends — Queries 16–30
- Day 3: Customer RFM Segmentation — Queries 31–45
- Day 4: Customer & Retail Behavioral Analytics — Queries 46–60
- Day 5: Cohort, Retention & Customer Value Analytics — Queries 61–75

**Total: 75 SQL queries across five analytical stages.**

The project demonstrates practical DuckDB SQL skills in data cleaning, aggregations, window functions, CTEs, customer segmentation, cohort analysis, retention measurement, and business insight generation.