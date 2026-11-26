# Financial Reconciliation & Payment Analytics – Insights

## Day 1 – Data Exploration & Financial Data Quality

### 1. Dataset Overview

Five financial datasets were successfully imported and analyzed
using DuckDB.

| Dataset | Records | Columns |
|---|---:|---:|
| Main Checking Account | 877 | 7 |
| Secondary Checking Account | 48 | 7 |
| Credit Card Account | 133 | 7 |
| Gusto Payroll | 92 | 7 |
| Gusto Payroll BC | 266 | 15 |
| **Total** | **1,416** | **43** |

- The datasets contain 1,058 financial account transactions
  and 358 payroll records.
- The overall analysis period spans January 2022 to December 2023.
- Main Checking contains daily transactions across all 730 days.
- All three financial accounts contain activity across 24 months.

### 2. Data Quality Assessment

| Validation Metric | Result |
|---|---:|
| Total Records | 1,416 |
| Missing Values | 0 |
| Fully Duplicated Records | 0 |
| Invalid Dates | 0 |
| Repeated Account-Level Transaction IDs | 0 |
| Repeated Employee-Date Combinations | 0 |
| Basic Amount Exceptions | 0 |
| Records Passing Basic Checks | 1,416 |
| Basic Data Quality Score | 100% |

All five datasets passed the defined basic data quality checks.
No record removal or missing value treatment was required.

Transaction identifiers are unique within each financial account,
while employee ID and payroll date combinations are unique within
each payroll dataset.

### 3. Financial Transaction Analysis

| Financial Metric | Amount |
|---|---:|
| Sales Revenue | 582,807 |
| Operating Expenses | 26,208 |
| Cost of Goods Sold | 16,991 |
| Main Checking Net Movement | 539,608 |
| Secondary Checking Transfers | 110,617 |
| Secondary Checking Payroll | 97,811 |
| Secondary Checking Net Movement | 12,806 |
| Credit Card Purchases | 36,797 |
| Credit Card Payments | 15,146 |
| Credit Card Purchase-Payment Difference | 21,651 |

#### Key Findings

- Sales Revenue accounts for 83.24% of Main Checking transactions.
- Secondary Checking contains 24 transfers and 24 payroll transactions.
- Payroll expenditures represent approximately 88.42% of incoming
  Secondary Checking transfers.
- Credit card payments represent approximately 41.16% of purchases.
- Marketing is the largest credit card purchase category, totaling 10,030.
- All account transactions contain positive amounts, with transaction
  direction represented through Credit and Debit classifications.
- No negative account balances were identified.

### 4. Payroll Analysis

| Metric | Gusto Payroll | Gusto Payroll BC |
|---|---:|---:|
| Payroll Records | 92 | 266 |
| Unique Payees | 4 | 6 |
| Unique Roles | 3 | 5 |
| Payroll Dates | 23 | 52 |
| Repeated Employee-Date Records | 0 | 0 |

#### Gusto Payroll

- Total recorded compensation: 159,854.
- Employee compensation: 132,001.
- Contractor compensation: 27,853.
- Average payroll payment: 1,737.54.
- Baristas represent the largest compensation category at 81,246.
- No zero or negative payroll payments were identified.

#### Gusto Payroll BC

- Total gross payroll: 395,511.62.
- Total net payroll: 306,005.64.
- Gross-to-net difference: 89,505.98.
- Net payroll represents approximately 77.37% of gross payroll.
- Baristas represent the largest gross compensation category
  at 133,720.57.
- No negative payroll deductions, employer contributions,
  tips, or reimbursements were identified.

### 5. Preliminary Reconciliation Observations

- Secondary Checking contains incoming transfers of 110,617,
  but Main Checking has no explicitly classified Transfer category.
- Credit card purchases exceed recorded payments by 21,651.
- Secondary Checking payroll expenditures differ from the
  compensation totals recorded in both payroll datasets.
- Account running balances and opening balances require
  independent validation.
- These differences represent preliminary reconciliation
  observations rather than confirmed financial exceptions.

### 6. Business Recommendations

- Implement recurring financial data quality and duplicate checks.
- Reconcile inter-account transfers using dates, amounts,
  and transaction descriptions.
- Validate credit card payments against bank disbursements.
- Prevent double counting of internal transfers and credit card payments.
- Separate employee and contractor compensation during payroll reporting.
- Use fixed-precision DECIMAL calculations for financial reconciliation.
- Validate gross-to-net payroll calculations against applicable
  deductions and adjustments.

### 7. Dataset Limitations

- General ledger and payment processor settlement records are unavailable.
- Currency information is not explicitly provided.
- Shared reconciliation identifiers have not been established.
- The two payroll datasets have different employee identifier formats
  and payment frequencies.
- Basic data quality checks do not establish complete financial accuracy.

### 8. Conclusion

Day 1 successfully analyzed 1,416 records across five financial
datasets using 15 SQL queries.

All records achieved a 100% basic data quality score, with no
missing values, fully duplicated records, invalid dates, or
basic amount exceptions.

The analysis established a reliable foundation for financial
performance analysis, cash flow reporting, bank reconciliation,
payroll validation, and financial control assessment.

**Day 1 Status: Completed**

