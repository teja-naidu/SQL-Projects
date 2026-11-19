
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