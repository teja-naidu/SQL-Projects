# SaaS Revenue & Subscription Analytics — Insights

## Day 1 — Dataset exploration and quality

### Data inventory
- Accounts: 500 rows
- Subscriptions: 5,000 rows
- Feature usage: 25,000 rows
- Support tickets: 2,000 rows
- Churn events: 600 rows
- **Total: 33,100 rows**

### Data model
Accounts connect to subscriptions, support tickets, and churn events by `account_id`. Feature usage connects to subscriptions by `subscription_id`.

### Findings awaiting DuckDB validation
After executing `sql/queries.sql`, add actual outputs for Q10–Q30: primary-key uniqueness, orphan references, date coverage, revenue consistency, plan and billing mix, trial/churn flags, missing values, and invalid metrics. Do not label these checks as passed before reviewing query output.

### Analytical precautions
- The sum of historical subscription MRR rows is not current MRR.
- Account churn events can recur; event counts must not be confused with unique accounts.
- Null subscription `end_date` can mean open-ended, and null satisfaction scores may mean no response.
- Multiple subscriptions per account require explicit deduplication rules for account-level metrics.

### Business questions for subsequent days
How much revenue is active at a chosen reporting date? Which plans generate the most revenue? Which customers churn and why? Does feature adoption or support experience correlate with retention?

### Day 1 result updates
Paste DuckDB output here after execution to document confirmed numerical findings and business recommendations.


---

# Day 2 – SaaS Revenue & Subscription Performance Analytics

## Objective

Analyze SaaS subscription revenue, Monthly Recurring Revenue (MRR), Annual Recurring Revenue (ARR), subscription growth, pricing tiers, billing frequency, customer segments, revenue concentration, and subscription lifecycle characteristics.

**Dataset:** RavenStack SaaS Analytics  
**SQL Engine:** DuckDB  
**Queries:** 31–45  
**Reporting Snapshot:** December 31, 2024  
**Subscription Records:** 5,000  
**Customer Accounts:** 500

> **Important Revenue Definition:** Total recorded MRR represents the sum of MRR values across subscription records. It is not equivalent to revenue recognized over the observation period. Snapshot MRR represents the sum of qualifying active, paid subscription records at a reporting date. Because accounts can have overlapping subscriptions, these values require additional validation before being treated as production-ready financial KPIs.

---

## 1. Executive Summary

Day 2 analysis identified the following findings:

- Total recorded subscription MRR: **$11,338,747**
- Total recorded subscription ARR: **$136,064,964**
- Active paid subscription records at December 31, 2024: **3,814**
- Distinct active paid accounts: **500**
- December 31 snapshot MRR: **$10,159,608**
- Enterprise recorded MRR: **$8,473,221**
- Enterprise share of recorded MRR: **74.73%**
- Highest subscription-start month: **December 2024**
- Top industry by recorded MRR: **FinTech**
- Top country by recorded MRR: **United States**
- Top 10 accounts' share of recorded MRR: **8.51%**
- Accounts with multiple active subscription records: **496**

The analysis indicates strong representation of Enterprise-tier subscriptions, substantial subscription-start activity during late 2024, and a high degree of overlapping subscription records.

However, revenue metrics must be interpreted carefully because the dataset contains multiple subscriptions per account.

---

## 2. Detailed SQL Findings

### Query 31 – Total Recorded Subscription Revenue

**Results**

| Metric | Value |
|---|---:|
| Total subscription records | 5,000 |
| Distinct customer accounts | 500 |
| Total recorded MRR | $11,338,747 |
| Total recorded ARR | $136,064,964 |
| Average recorded ARR per subscription | $27,212.99 |

**Key Findings**

- The dataset contains 5,000 subscription records distributed across 500 accounts.
- Recorded MRR totals approximately $11.34 million.
- Recorded ARR totals approximately $136.06 million.
- ARR is consistent with annualizing recorded MRR by multiplying by 12.
- Each customer has an average of 10 subscription records across the dataset.

**Business Interpretation**

The dataset provides sufficient subscription history for studying revenue composition and subscription behavior.

However, summing all subscription records does not establish a valid point-in-time recurring revenue metric.

**Recommendation**

Use date-filtered active subscriptions for reporting-period MRR and ARR calculations.

---

### Query 32 – Active Paid Subscription Snapshot

**Reporting Date:** December 31, 2024

| Metric | Value |
|---|---:|
| Active paid subscription records | 3,814 |
| Distinct active paid accounts | 500 |
| Snapshot MRR | $10,159,608 |
| Average MRR per active subscription record | $2,663.77 |
| Summed MRR per distinct active account | $20,319.22 |

**Key Findings**

- 3,814 subscription records satisfy the active, non-trial, non-churned filtering conditions.
- All 500 customer accounts have at least one qualifying subscription.
- Summed snapshot MRR is approximately $10.16 million.
- The average active subscription record contributes approximately $2,664 in MRR.

**Business Interpretation**

The snapshot provides a more relevant recurring revenue measure than summing all historical subscription records.

Nevertheless, multiple qualifying subscriptions can belong to the same account.

**Recommendation**

Validate whether simultaneous subscriptions represent separate products, additional licenses, or overlapping historical records before publishing account-level MRR.

---

### Query 33 – Monthly Subscription Starts and Associated MRR

**Selected Results**

| Month | New Subscription Records | MRR Associated With Starts |
|---|---:|---:|
| January 2023 | 3 | $4,684 |
| December 2023 | 121 | $267,264 |
| March 2024 | 186 | $421,916 |
| June 2024 | 248 | $537,758 |
| September 2024 | 440 | $992,366 |
| October 2024 | 504 | $1,173,608 |
| November 2024 | 612 | $1,549,040 |
| December 2024 | 953 | $2,273,427 |

**Key Findings**

- Subscription-start volume increased substantially over the observation period.
- December 2024 recorded the highest number of subscription starts, with 953 records.
- December's associated recorded MRR was approximately $2.27 million.
- November 2024 recorded 612 subscription starts and approximately $1.55 million in associated MRR.
- The number of subscription starts increased by approximately 55.72% from November to December 2024.

**Business Interpretation**

Late 2024 shows substantial growth in subscription-start activity.

However, subscription starts are not necessarily unique new customer acquisitions because existing customers may create additional subscriptions.

**Recommendation**

Separate new-customer acquisition, additional subscriptions, and plan transitions in future growth reporting.

---

### Query 34 – Monthly Active Paid MRR Trend

**Selected Original Query Results**

| Snapshot Date | Active Subscription Records | Active Accounts | Summed Active MRR |
|---|---:|---:|---:|
| 2023-01-31 | 3 | 2 | $4,684 |
| 2023-06-28 | 97 | 61 | $204,818 |
| 2023-12-28 | 478 | 177 | $1,152,081 |
| 2024-03-28 | 834 | 246 | $2,085,634 |
| 2024-06-28 | 1,361 | 327 | $3,533,870 |
| 2024-09-28 | 2,215 | 410 | $5,667,273 |
| 2024-11-28 | 3,056 | 473 | $8,083,106 |
| 2024-12-28 | 3,720 | 498 | $9,898,684 |

**Key Findings**

- The original query indicates a strong upward trend in qualifying subscription records and summed active MRR.
- The December 28 snapshot reports approximately $9.90 million in summed active MRR.
- The December 31 snapshot from Query 32 reports approximately $10.16 million.
- These two results are not directly comparable because they use different reporting dates.

**Data Quality Limitation**

The original Query 34 used monthly intervals starting on January 31, 2023.

This generated February 28 followed by the 28th of subsequent months rather than consistent calendar month-end dates.

Consequently, the output must not be described as a validated month-end revenue series.

**Recommendation**

Correct the date-generation logic and rerun Query 34 before publishing month-over-month revenue growth percentages.

---

### Query 35 – Recorded Revenue by Subscription Plan Tier

| Plan Tier | Subscription Records | Recorded MRR | Recorded ARR | MRR Share |
|---|---:|---:|---:|---:|
| Enterprise | 1,723 | $8,473,221 | $101,678,652 | 74.73% |
| Pro | 1,675 | $2,105,089 | $25,261,068 | 18.57% |
| Basic | 1,602 | $760,437 | $9,125,244 | 6.71% |

*Percentages are independently rounded.*

**Key Findings**

- Enterprise subscriptions generate the largest recorded MRR contribution.
- Enterprise represents approximately 34.46% of subscription records but 74.73% of recorded MRR.
- Pro contributes 18.57% of recorded MRR.
- Basic contributes approximately 6.71%.
- Average Enterprise subscription MRR is $4,917.71, compared with $1,256.77 for Pro and $474.68 for Basic.

**Business Interpretation**

Enterprise-tier subscriptions contribute disproportionately to recorded subscription value.

**Recommendation**

Prioritize Enterprise retention and account expansion analysis while maintaining an acquisition and conversion strategy for Basic and Pro customers.

---

### Query 36 – Active Paid Revenue by Plan Tier

**December 31, 2024 Snapshot**

| Plan Tier | Active Records | Active Accounts | Active MRR | Active ARR |
|---|---:|---:|---:|---:|
| Enterprise | 1,304 | 461 | $7,546,876 | $90,562,512 |
| Pro | 1,282 | 446 | $1,924,818 | $23,097,816 |
| Basic | 1,228 | 448 | $687,914 | $8,254,968 |

**Key Findings**

- Enterprise contributes approximately $7.55 million in active-record MRR.
- Pro contributes approximately $1.92 million.
- Basic contributes approximately $688,000.
- Enterprise accounts for approximately 74.28% of summed active-record MRR.
- The number of active accounts across tiers cannot be added together to determine unique customers because an account can appear in multiple tiers.

**Business Interpretation**

The Enterprise segment remains the primary contributor to the active paid subscription snapshot.

**Recommendation**

Track active revenue by tier using a validated subscription ownership and account-level revenue model.

---

### Query 37 – Revenue by Billing Frequency

| Billing Frequency | Subscription Records | Share of Records | Average MRR |
|---|---:|---:|---:|
| Monthly | 2,539 | 50.78% | $2,261.26 |
| Annual | 2,461 | 49.22% | $2,274.44 |

**Key Findings**

- Monthly and annual billing are nearly evenly distributed.
- Monthly subscriptions represent a slight majority of records.
- Average MRR values are similar between the two billing frequencies.

**Business Interpretation**

The dataset supports comparisons of billing preferences and their relationship with retention.

However, MRR should be normalized consistently for annual billing.

**Recommendation**

Compare churn rates, renewal behavior, and customer lifetime value between annual and monthly subscriptions.

---

### Query 38 – Trial vs Paid Subscription Performance

| Subscription Type | Records | Recorded MRR | Churn-Flagged Records |
|---|---:|---:|---:|
| Paid | 4,222 | $11,338,747 | 408 |
| Trial | 778 | $0 | 78 |

**Key Findings**

- Paid subscriptions represent 84.44% of subscription records.
- Trial subscriptions represent 15.56%.
- Trial subscriptions contribute zero recorded MRR.
- The dataset contains 408 churn-flagged paid records and 78 churn-flagged trial records.

**Business Interpretation**

Trial subscriptions represent a potential conversion opportunity.

However, these results alone cannot establish a trial-to-paid conversion rate.

**Recommendation**

Use subscription histories to identify trial starts, successful conversions, time to conversion, and trial abandonment.

---

### Query 39 – Upgrade and Downgrade Distribution

| Change Category | Subscription Records | Recorded MRR |
|---|---:|---:|
| No Change | 4,276 | $9,656,818 |
| Upgrade | 506 | $1,222,563 |
| Downgrade | 195 | $418,932 |
| Both Upgrade and Downgrade | 23 | $40,434 |

**Key Findings**

- Most subscription records have neither an upgrade nor a downgrade flag.
- Upgrade-only records outnumber downgrade-only records.
- 23 records have both upgrade and downgrade flags.
- Upgrade-only records account for approximately 10.78% of total recorded MRR.

**Business Interpretation**

Upgrade activity suggests opportunities for expansion revenue.

However, the recorded MRR associated with upgraded subscriptions is not the incremental revenue gained from those upgrades.

**Recommendation**

Calculate expansion and contraction MRR from before-and-after subscription values, and investigate records with conflicting lifecycle flags.

---

### Query 40 – Revenue by Auto-Renewal Status

| Auto-Renewal | Subscription Records | Churn-Flagged Records | Churn-Flag Percentage |
|---|---:|---:|---:|
| Enabled | 4,005 | 390 | 9.74% |
| Disabled | 995 | 96 | 9.65% |

**Key Findings**

- Auto-renewal is enabled on 80.10% of subscription records.
- Churn-flag percentages are similar for enabled and disabled subscriptions.
- The observed difference is only 0.09 percentage points.

**Business Interpretation**

These results do not demonstrate that auto-renewal independently reduces churn.

**Recommendation**

Analyze renewal status alongside subscription tenure, plan tier, customer segment, and actual churn dates before drawing conclusions about retention effectiveness.

---

### Query 41 – Revenue by Customer Industry

| Industry | Accounts | Recorded MRR |
|---|---:|---:|
| FinTech | 112 | $2,669,496 |
| DevTools | 113 | $2,403,654 |
| Cybersecurity | 100 | $2,253,318 |
| EdTech | 79 | $2,043,167 |
| HealthTech | 96 | $1,969,112 |

**Key Findings**

- FinTech is the largest industry by recorded MRR.
- DevTools has the highest number of subscription records, at 1,158.
- EdTech has the highest average MRR per subscription record, at $2,602.76.
- All five industries contribute meaningful recorded subscription value.

**Business Interpretation**

Industry-level segmentation can help identify revenue opportunities and customer retention priorities.

**Recommendation**

Develop industry-specific retention, expansion, and customer-success strategies based on active revenue and churn behavior.

---

### Query 42 – Revenue by Customer Country

| Country | Subscription Records | Recorded MRR |
|---|---:|---:|
| US | 2,961 | $6,634,595 |
| UK | 590 | $1,220,471 |
| IN | 498 | $1,194,325 |
| AU | 312 | $839,980 |
| FR | 211 | $589,796 |
| CA | 217 | $477,562 |
| DE | 211 | $382,018 |

**Key Findings**

- The United States contributes approximately 58.51% of total recorded MRR.
- The United Kingdom and India are the next-largest markets by recorded MRR.
- France has the highest average MRR per subscription record at $2,795.24.
- Geographic revenue distribution is concentrated in the United States.

**Business Interpretation**

The US is the primary recorded revenue market, while international markets provide additional opportunities for growth.

**Recommendation**

Compare active MRR, churn, customer acquisition, and expansion performance by country before prioritizing geographic investments.

---

### Query 43 – Top 20 Accounts by Recorded Subscription MRR

**Top Five Accounts**

| Account | Industry | Country | Recorded MRR |
|---|---|---|---:|
| Company_403 | FinTech | US | $138,060 |
| Company_166 | DevTools | US | $133,298 |
| Company_358 | EdTech | FR | $130,152 |
| Company_368 | EdTech | AU | $94,710 |
| Company_337 | Cybersecurity | IN | $87,957 |

**Key Findings**

- Company_403 has the highest aggregate recorded subscription MRR.
- Company_166 and Company_358 are the next-largest accounts.
- Several EdTech accounts appear among the highest-value customers.
- The top accounts span multiple industries and countries.

**Business Interpretation**

High-value accounts are important candidates for customer-success prioritization.

However, the ranking is based on summed recorded subscription values, not verified current account-level MRR.

**Recommendation**

Build a validated current-revenue account ranking before assigning revenue-risk classifications or strategic account priorities.

---

### Query 44 – Revenue Concentration Among Top Accounts

| Metric | Value |
|---|---:|
| Total accounts | 500 |
| Total recorded MRR | $11,338,747 |
| Top 10 accounts' recorded MRR | $964,589 |
| Top 10 revenue share | 8.51% |
| Top 50 revenue share | 26.88% |

**Key Findings**

- The top 10 accounts represent 8.51% of total recorded MRR.
- The top 50 accounts represent 26.88%.
- Recorded subscription value is distributed across a relatively broad account base.

**Business Interpretation**

The results suggest that recorded MRR is not dominated by a small group of customers.

However, current revenue concentration may differ from historical recorded subscription concentration.

**Recommendation**

Recalculate concentration using verified current account-level MRR and monitor revenue exposure to the largest customers.

---

### Query 45 – Subscription Overlap and Revenue Quality

| Metric | Value |
|---|---:|
| Active paid accounts | 500 |
| Accounts with multiple active records | 496 |
| Maximum active records for one account | 16 |
| MRR from multi-record accounts | $10,153,020 |
| Share of summed snapshot MRR from multi-record accounts | 99.94% |

**Key Findings**

- 496 of 500 active paid accounts have multiple qualifying subscription records.
- Some accounts have as many as 16 simultaneous qualifying records.
- Multi-record accounts contribute approximately $10.15 million in summed snapshot MRR.
- Approximately 99.94% of snapshot MRR comes from accounts with multiple active subscription records.

**Critical Data Quality Finding**

The dataset contains substantial subscription overlap.

This does not automatically establish duplicate revenue because customers may legitimately hold multiple products, contracts, or licenses.

However, the current analysis does not determine whether overlapping records represent independent billable subscriptions or duplicated subscription history.

**Recommendation**

Investigate subscription overlap using subscription IDs, contract dates, plan changes, and product-level identifiers.

Do not deduplicate subscriptions solely by account ID because doing so could incorrectly remove legitimate revenue.

---

## 3. Business Recommendations

### Recommendation 1 – Protect Enterprise Revenue

Enterprise subscriptions contribute approximately three-quarters of recorded MRR.

Actions:
- Monitor Enterprise churn and downgrade behavior.
- Prioritize high-value customer retention.
- Identify expansion opportunities among established accounts.
- Evaluate customer-success coverage for high-value contracts.

### Recommendation 2 – Improve Revenue Reporting Accuracy

The dataset contains substantial overlapping subscription activity.

Actions:
- Define a validated active-subscription reporting model.
- Distinguish independent subscriptions from historical replacements.
- Establish consistent MRR and ARR calculation rules.
- Reconcile account-level subscription revenue before financial reporting.

### Recommendation 3 – Investigate Late-2024 Subscription Growth

December 2024 has the highest subscription-start volume.

Actions:
- Separate new customers from existing-customer subscription additions.
- Investigate whether plan transitions create additional records.
- Compare monthly acquisition and expansion activity.
- Validate growth trends using corrected month-end reporting dates.

### Recommendation 4 – Develop Segment-Specific Strategies

FinTech, DevTools, and Cybersecurity contribute substantial recorded MRR.

Actions:
- Compare active revenue and churn by industry.
- Identify industries with higher expansion potential.
- Develop targeted customer-success programs.
- Evaluate international growth opportunities using country-level metrics.

### Recommendation 5 – Strengthen Subscription Lifecycle Analytics

Upgrade, downgrade, trial, and churn flags provide useful lifecycle signals.

Actions:
- Measure actual expansion and contraction MRR.
- Track trial-to-paid conversion.
- Compare annual and monthly retention.
- Investigate conflicting upgrade/downgrade flags.
- Measure churn using event dates and eligible populations.

---

## 4. Data Quality Findings and Limitations

### 4.1 Historical Revenue vs Snapshot Revenue

Summing recorded MRR across all subscription rows does not produce a valid historical revenue total or current MRR figure.

Historical subscription records may represent different time periods.

### 4.2 Multiple Active Subscriptions

496 accounts contain multiple active paid subscription records at the reporting snapshot.

The business meaning of these overlapping records requires validation.

### 4.3 Month-End Date Generation

Query 34 generates the 28th of most months after February 2023 rather than true calendar month-end dates.

The original trend is retained as an exploratory result only.

### 4.4 Churn Flag Interpretation

A churn flag is not necessarily equivalent to a churn event within a specified reporting period.

Historical churn calculations require consistent event-date and population definitions.

### 4.5 Upgrade and Downgrade Revenue

MRR associated with upgrade or downgrade flags does not equal incremental expansion or contraction revenue.

Previous and subsequent subscription values are required.

### 4.6 Billing Frequency Normalization

Annual and monthly billing must be represented consistently in monthly recurring revenue calculations.

### 4.7 Account-Level Revenue Attribution

Summed MRR divided by distinct accounts does not necessarily represent standard SaaS ARPA when subscription overlap is unresolved.

### 4.8 Reporting Snapshot Assumptions

The active snapshot excludes trials and churn-flagged records and uses subscription start and end dates.

This approach assumes the flags are valid for the reporting date. If churn flags represent eventual churn rather than point-in-time churn, historical snapshots may be biased.

---

## 5. Key Performance Indicators

| KPI | Day 2 Result |
|---|---:|
| Subscription records | 5,000 |
| Distinct customer accounts | 500 |
| Total recorded MRR | $11,338,747 |
| Total recorded ARR | $136,064,964 |
| December 31 active paid records | 3,814 |
| December 31 summed active MRR | $10,159,608 |
| Enterprise recorded MRR share | 74.73% |
| Monthly billing share | 50.78% |
| Annual billing share | 49.22% |
| Trial subscription records | 778 |
| Upgrade-only records | 506 |
| Downgrade-only records | 195 |
| Auto-renewal enabled records | 4,005 |
| Top 10 account revenue share | 8.51% |
| Top 50 account revenue share | 26.88% |
| Accounts with multiple active records | 496 |

---

## 6. Final Day 2 Conclusion

Day 2 analyzed 5,000 subscription records across 500 customer accounts using 15 SQL queries.

The analysis identified Enterprise as the dominant recorded revenue tier, strong subscription-start activity in late 2024, substantial US market representation, and a relatively distributed recorded revenue base.

The most significant technical finding is the prevalence of multiple active subscription records per customer.

This requires additional validation before using aggregated subscription revenue as a production-ready financial KPI.

The monthly revenue trend also requires corrected calendar month-end snapshots.

Overall, Day 2 establishes a foundation for SaaS revenue segmentation, subscription performance reporting, and future churn and retention analysis.

**Day 2 Status:** 15 queries executed; exploratory insights documented; revenue validation limitations identified.


---

# Day 3 – Customer Churn & Retention Analytics

## Objective

Analyze SaaS customer churn events, subscription churn indicators, churn reasons, customer segments, subscription tenure, auto-renewal behavior, account-level churn exposure, and churn-related recurring revenue.

**Dataset:** RavenStack SaaS Analytics  
**SQL Engine:** DuckDB  
**Queries:** 46–60  
**Analysis Period:** January 2023 – December 2024  
**Subscription Records:** 5,000  
**Customer Accounts:** 500  
**Churn Events:** 600

### Important Metric Definitions

- **Churn Event:** An individual record in the `churn_events` table.
- **Churn-Flagged Subscription:** A record in `subscriptions` where `churn_flag = TRUE`.
- **Churn-Flag Percentage:** Churn-flagged subscription records divided by total subscription records in the relevant segment.
- **Churn-Flagged MRR:** Sum of recorded MRR associated with churn-flagged subscriptions.
- **Account Churn Exposure:** Whether an account has at least one churn-flagged subscription record or a recorded churn event.

These metrics are descriptive and should not automatically be interpreted as monthly customer churn rates, realized revenue loss, or confirmed customer departures.

---

## 1. Executive Summary

Day 3 successfully executed 15 SQL queries to examine subscription churn patterns and customer retention indicators.

### Key Performance Indicators

| KPI | Result |
|---|---:|
| Total subscription records | 5,000 |
| Total customer accounts | 500 |
| Churn-flagged subscription records | 486 |
| Non-churn-flagged subscription records | 4,514 |
| Subscription churn-flag percentage | 9.72% |
| Churn-flagged MRR | $1,179,139 |
| Total recorded churn events | 600 |
| Unique churn event IDs | 600 |
| Accounts with recorded churn events | 352 |
| Earliest churn event | January 25, 2023 |
| Latest churn event | December 31, 2024 |
| Highest churn-event month | December 2024 |
| December 2024 churn events | 117 |
| Most common churn reason | Features |
| Accounts with any subscription churn flag | 312 |
| Accounts with both churn flags and events | 227 |

### Executive Findings

1. Approximately 9.72% of subscription records are marked as churned.
2. The churn-event table contains 600 unique events affecting 352 accounts.
3. Recorded churn-event volume increased substantially toward the end of 2024.
4. Feature limitations, support issues, and budget constraints are the most frequently recorded churn reasons.
5. Enterprise subscriptions account for the largest churn-associated MRR.
6. Short-tenure subscription records have higher churn-flag percentages than longer-tenure records.
7. Subscription churn flags and account-level churn events do not fully align.
8. Churn-related revenue exposure requires further validation before being classified as actual lost MRR.

---

## 2. Detailed SQL Findings

### Query 46 – Overall Subscription Churn Overview

**Results**

| Metric | Value |
|---|---:|
| Total subscription records | 5,000 |
| Total accounts | 500 |
| Churn-flagged records | 486 |
| Non-churn-flagged records | 4,514 |
| Churn-flag percentage | 9.72% |
| Churn-flagged MRR | $1,179,139 |

**Key Findings**

- The dataset contains 486 churn-flagged subscription records.
- The remaining 4,514 records are not churn-flagged.
- Churn-flagged subscriptions represent 9.72% of all subscription records.
- Approximately $1.18 million in recorded MRR is associated with churn-flagged subscriptions.
- Churn-flagged MRR represents approximately 10.40% of the $11.34 million total recorded subscription MRR identified in Day 2.

**Business Interpretation**

The dataset contains meaningful churn-related subscription exposure.

However, the 9.72% metric is a record-level proportion across the dataset, not a monthly customer churn rate.

Similarly, churn-flagged MRR is not necessarily revenue lost during a particular reporting period.

**Business Recommendation**

Establish separate definitions for subscription churn, customer churn, gross revenue churn, and net revenue retention.

Use churn dates and period-specific revenue snapshots to calculate operational retention KPIs.

---

### Query 47 – Churn Event Summary

**Results**

| Metric | Value |
|---|---:|
| Total churn events | 600 |
| Unique churn events | 600 |
| Accounts with churn events | 352 |
| Earliest churn date | January 25, 2023 |
| Latest churn date | December 31, 2024 |

**Key Findings**

- All 600 churn event IDs are unique.
- Churn events affect 352 distinct accounts.
- Multiple churn events can belong to the same account.
- Recorded churn activity spans nearly the entire dataset observation period.

**Business Interpretation**

The event table captures churn activity at the account level but does not directly identify the subscription associated with each event.

Consequently, the 352 affected accounts should not be interpreted as 352 customers permanently lost.

**Business Recommendation**

Investigate repeat churn events, customer reactivation, and account subscription status following churn events.

---

### Query 48 – Monthly Churn Event Trend

**Results**

| Month | Churn Events | Affected Accounts |
|---|---:|---:|
| January 2023 | 1 | 1 |
| March 2023 | 5 | 5 |
| April 2023 | 3 | 3 |
| May 2023 | 3 | 3 |
| June 2023 | 5 | 5 |
| July 2023 | 6 | 6 |
| August 2023 | 7 | 6 |
| September 2023 | 6 | 6 |
| October 2023 | 10 | 10 |
| November 2023 | 11 | 11 |
| December 2023 | 16 | 16 |
| January 2024 | 20 | 18 |
| February 2024 | 10 | 10 |
| March 2024 | 24 | 24 |
| April 2024 | 25 | 23 |
| May 2024 | 27 | 25 |
| June 2024 | 40 | 38 |
| July 2024 | 35 | 33 |
| August 2024 | 42 | 40 |
| September 2024 | 53 | 48 |
| October 2024 | 66 | 60 |
| November 2024 | 68 | 60 |
| December 2024 | 117 | 96 |

*February 2023 has no row in the original query output because no churn events were recorded for that month.*

**Key Findings**

- Recorded churn-event volume generally increased during the observation period.
- December 2024 had the highest monthly event count, at 117.
- December's churn events affected 96 distinct accounts.
- November 2024 recorded 68 events affecting 60 accounts.
- Event volume increased approximately 72.06% between November and December 2024.
- Multiple events affected some accounts within individual months.

**Business Interpretation**

The rising number of churn events could reflect a growing subscription base, changing customer behavior, or both.

Event counts alone do not establish that the churn rate increased.

**Business Recommendation**

Calculate monthly customer churn rates using a consistent opening active-customer population.

Investigate the December 2024 event increase and compare it with customer acquisition and subscription growth.

---

### Query 49 – Churn Reasons Distribution

**Results**

| Churn Reason | Events | Affected Accounts | Share of Events |
|---|---:|---:|---:|
| Features | 114 | 104 | 19.00% |
| Support | 104 | 95 | 17.33% |
| Budget | 104 | 94 | 17.33% |
| Unknown | 95 | 86 | 15.83% |
| Competitor | 92 | 79 | 15.33% |
| Pricing | 91 | 86 | 15.17% |

**Key Findings**

- Feature-related issues are the most frequently recorded churn reason.
- Support issues and budget constraints are tied for second.
- Features and support together account for 218 events, or 36.33% of all churn events.
- Budget and pricing together account for 195 events, or 32.50%.
- Approximately 15.83% of churn events have an unknown reason.

**Business Interpretation**

Product capabilities, customer support, and affordability appear repeatedly in recorded churn reasons.

However, the reason distribution does not establish causality or the relative revenue impact of each reason.

**Business Recommendation**

- Review feature-related churn feedback with Product teams.
- Investigate support-related churn and ticket resolution experiences.
- Analyze budget and pricing objections by plan tier.
- Improve churn-reason collection to reduce unknown classifications.

---

### Query 50 – Churn by Subscription Plan Tier

**Results**

| Plan Tier | Records | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| Enterprise | 1,723 | 172 | 9.98% | $926,345 |
| Pro | 1,675 | 162 | 9.67% | $180,271 |
| Basic | 1,602 | 152 | 9.49% | $72,523 |

**Key Findings**

- Enterprise has the highest churn-flag percentage at 9.98%.
- Basic has the lowest at 9.49%.
- The difference between Enterprise and Basic is 0.49 percentage points.
- Enterprise contributes approximately 78.56% of all churn-flagged MRR.
- Enterprise's churn-associated MRR is significantly higher because its subscription values are larger.

**Business Interpretation**

Enterprise is the largest churn-associated revenue exposure segment.

However, the small differences in churn-flag percentages do not demonstrate a substantial difference in customer retention between tiers.

**Business Recommendation**

Prioritize Enterprise account reviews while measuring actual churn rates and realized revenue losses by plan tier.

---

### Query 51 – Churn by Billing Frequency

**Results**

| Billing Frequency | Records | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| Annual | 2,461 | 247 | 10.04% | $549,373 |
| Monthly | 2,539 | 239 | 9.41% | $629,766 |

**Key Findings**

- Annual subscriptions have a churn-flag percentage of 10.04%.
- Monthly subscriptions have a churn-flag percentage of 9.41%.
- The observed difference is 0.63 percentage points.
- Monthly subscriptions account for more churn-flagged MRR despite having fewer churn-flagged records.

**Business Interpretation**

The observed data does not support a conclusion that annual billing necessarily produces lower churn.

Differences in subscription tenure, contract expiration, and plan composition may affect the results.

**Business Recommendation**

Compare renewal outcomes and cohort-based churn rates for annual and monthly subscriptions.

---

### Query 52 – Trial vs Paid Subscription Churn

**Results**

| Subscription Type | Records | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| Trial | 778 | 78 | 10.03% | $0 |
| Paid | 4,222 | 408 | 9.66% | $1,179,139 |

**Key Findings**

- Trial subscriptions have a churn-flag percentage of 10.03%.
- Paid subscriptions have a churn-flag percentage of 9.66%.
- All churn-flagged MRR is associated with paid subscriptions.
- Trial subscriptions have zero recorded MRR.

**Business Interpretation**

Trial abandonment and paid subscription churn are different lifecycle outcomes and should not automatically be combined.

The dataset does not provide a trial-to-paid conversion rate through this query.

**Business Recommendation**

Track trial conversion, trial abandonment, paid churn, and reactivation separately.

---

### Query 53 – Churn by Customer Industry

**Results**

| Industry | Records | Accounts | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|---:|
| DevTools | 1,158 | 113 | 125 | 10.79% | $238,611 |
| Cybersecurity | 1,008 | 100 | 103 | 10.22% | $279,062 |
| HealthTech | 949 | 96 | 96 | 10.12% | $209,277 |
| FinTech | 1,100 | 112 | 96 | 8.73% | $253,446 |
| EdTech | 785 | 79 | 66 | 8.41% | $198,743 |

**Key Findings**

- DevTools has the highest churn-flag percentage at 10.79%.
- EdTech has the lowest at 8.41%.
- Cybersecurity has the largest churn-flagged MRR at $279,062.
- FinTech follows with $253,446.
- DevTools has the highest number of churn-flagged records, at 125.

**Business Interpretation**

Different industries exhibit different churn-associated subscription patterns.

Industry rankings vary depending on whether churn is measured by record count, percentage, or associated MRR.

**Business Recommendation**

Develop industry-specific retention analysis using actual churn events, revenue exposure, customer tenure, and product usage.

---

### Query 54 – Churn by Customer Country

**Results**

| Country | Records | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| FR | 211 | 25 | 11.85% | $100,563 |
| AU | 312 | 35 | 11.22% | $88,549 |
| UK | 590 | 64 | 10.85% | $175,279 |
| US | 2,961 | 288 | 9.73% | $645,721 |
| CA | 217 | 21 | 9.68% | $43,327 |
| DE | 211 | 20 | 9.48% | $44,111 |
| IN | 498 | 33 | 6.63% | $81,589 |

**Key Findings**

- France has the highest churn-flag percentage at 11.85%.
- India has the lowest at 6.63%.
- The United States has the highest churn-flagged MRR at $645,721.
- US subscriptions represent the largest absolute churn-associated revenue exposure.

**Business Interpretation**

The country with the highest churn-flag percentage is not necessarily the country with the greatest revenue exposure.

**Business Recommendation**

Monitor both churn frequency and revenue impact across markets, accounting for differences in customer composition and subscription tenure.

---

### Query 55 – Churn by Auto-Renewal Status

**Results**

| Auto-Renewal | Records | Churn-Flagged | Churn-Flag % | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| Enabled | 4,005 | 390 | 9.74% | $968,478 |
| Disabled | 995 | 96 | 9.65% | $210,661 |

**Key Findings**

- Auto-renewal is enabled on 80.10% of subscription records.
- Enabled subscriptions have a churn-flag percentage of 9.74%.
- Disabled subscriptions have a churn-flag percentage of 9.65%.
- The difference is only 0.09 percentage points.

**Business Interpretation**

The data does not establish a meaningful retention advantage for auto-renewal.

Auto-renewal settings may also change during the subscription lifecycle.

**Business Recommendation**

Study renewal success, failed payments, cancellations, and contract expiration outcomes rather than relying solely on the churn flag.

---

### Query 56 – Subscription Tenure Distribution

**Results**

| Tenure Category | Subscription Records | Accounts | Average Tenure Days |
|---|---:|---:|---:|
| Less Than 1 Month | 1,038 | 353 | 12.95 |
| 1–3 Months | 1,131 | 403 | 57.17 |
| 3–6 Months | 1,075 | 386 | 131.36 |
| 6–12 Months | 1,146 | 334 | 258.38 |
| 12+ Months | 610 | 188 | 474.11 |

**Key Findings**

- The 6–12 month category contains the most records, at 1,146.
- The 1–3 month category contains 1,131 records.
- Only 610 subscription records fall into the 12+ month category.
- A substantial portion of subscription records have relatively short calculated tenure.

**Business Interpretation**

Subscription tenure is influenced by the observation period and subscription start dates.

The query uses subscription end dates when available and December 31, 2024 otherwise.

**Business Recommendation**

Distinguish completed subscription lifetimes from ongoing, right-censored subscriptions in future retention analysis.

---

### Query 57 – Churn by Subscription Tenure

**Results**

| Tenure Category | Records | Churn-Flagged | Churn-Flag % |
|---|---:|---:|---:|
| Less Than 1 Month | 1,038 | 204 | 19.65% |
| 1–3 Months | 1,131 | 126 | 11.14% |
| 3–6 Months | 1,075 | 77 | 7.16% |
| 6–12 Months | 1,146 | 58 | 5.06% |
| 12+ Months | 610 | 21 | 3.44% |

**Key Findings**

- Subscriptions with calculated tenure below one month have the highest churn-flag percentage.
- The percentage declines across longer tenure categories.
- The 12+ month category has the lowest churn-flag percentage at 3.44%.
- The less-than-one-month category accounts for 204 churn-flagged records.

**Business Interpretation**

The descriptive pattern suggests an association between shorter calculated tenure and churn flags.

However, the query does not establish that longer tenure causes better retention.

Completed and ongoing subscriptions are treated differently, and subscription end dates may be associated with churn itself.

**Business Recommendation**

Conduct cohort-based retention and survival analysis using consistent observation windows.

Investigate early customer onboarding and activation experiences.

---

### Query 58 – Account-Level Churn Exposure

**Results**

| Metric | Accounts |
|---|---:|
| Total accounts | 500 |
| Accounts with any churn flag | 312 |
| Accounts with mixed churn flags | 312 |
| Accounts with all records churn-flagged | 0 |
| Accounts without churn flags | 188 |

**Key Findings**

- 312 accounts have at least one churn-flagged subscription.
- All 312 also have at least one non-churn-flagged subscription.
- No account has every subscription record marked as churned.
- 188 accounts have no churn-flagged subscription records.

**Business Interpretation**

A subscription-level churn flag does not necessarily indicate that the entire customer account has churned.

The presence of both flagged and non-flagged records may reflect multiple subscriptions or subscription history.

**Business Recommendation**

Define customer churn using account-level paid subscription activity and an explicit reporting period.

---

### Query 59 – Account-Level Churn Flag vs Churn Event Reconciliation

**Results**

| Reconciliation Category | Accounts | Subscription Records | Churn-Flagged Records | Churn Events |
|---|---:|---:|---:|---:|
| Has Churn Flag and Event | 227 | 2,430 | 352 | 386 |
| Has Churn Event Only | 125 | 1,098 | 0 | 214 |
| Has Churn Flag Only | 85 | 905 | 134 | 0 |
| Neither Flag nor Event | 63 | 567 | 0 | 0 |
| **Total** | **500** | **5,000** | **486** | **600** |

**Key Findings**

- 227 accounts have both churn-flagged subscriptions and recorded churn events.
- 125 accounts have churn events but no churn-flagged subscriptions.
- 85 accounts have churn-flagged subscriptions but no recorded churn events.
- 63 accounts have neither indicator.
- The reconciliation preserves all 500 accounts, 5,000 subscription records, 486 churn flags, and 600 churn events.

**Critical Data Quality Finding**

The `churn_events` table does not contain a `subscription_id` field.

Therefore, direct subscription-to-event reconciliation is not possible with the available schema.

The account-level comparison reveals differences between the two churn indicators but does not prove that either source is incorrect.

**Business Recommendation**

Investigate event-generation rules, subscription churn-flag definitions, and account reactivation behavior.

Introduce a reliable subscription-level event relationship if the source system supports it.

---

### Query 60 – Top 20 Accounts by Churn-Flagged MRR

**Top 10 Results**

| Account | Industry | Churn-Flagged Records | Churn-Flagged MRR |
|---|---|---:|---:|
| Company_358 | EdTech | 6 | $60,465 |
| Company_492 | Cybersecurity | 2 | $26,080 |
| Company_4 | HealthTech | 2 | $23,406 |
| Company_403 | FinTech | 1 | $23,283 |
| Company_47 | DevTools | 4 | $21,066 |
| Company_303 | FinTech | 1 | $20,497 |
| Company_376 | Cybersecurity | 2 | $19,502 |
| Company_278 | Cybersecurity | 2 | $19,502 |
| Company_163 | Cybersecurity | 3 | $19,144 |
| Company_91 | HealthTech | 2 | $19,104 |

**Key Findings**

- Company_358 has the highest churn-flagged MRR at $60,465.
- Company_358 also has six churn-flagged subscription records.
- Several Cybersecurity accounts appear among the highest churn-associated revenue accounts.
- Company_403, previously identified as the highest recorded MRR account in Day 2, also appears in the churn-exposure ranking.
- High churn-flagged MRR does not necessarily indicate complete customer churn.

**Business Interpretation**

Account-level churn-associated revenue can help identify candidates for further investigation.

However, these rankings should not be treated as verified lost-revenue rankings.

**Business Recommendation**

Review high-value accounts using current active MRR, churn-event history, subscription changes, product usage, and support activity.

---

## 3. Strategic Business Recommendations

### Recommendation 1 – Improve Early Customer Onboarding

**Finding:** Subscriptions with less than one month of calculated tenure have a 19.65% churn-flag percentage.

**Actions:**
- Investigate early subscription cancellations.
- Monitor onboarding completion and feature adoption.
- Identify common obstacles during initial customer activation.
- Develop proactive support for newly acquired customers.
- Validate early churn patterns using cohort-based analysis.

**Expected Business Benefit:** Better understanding of early lifecycle churn drivers and opportunities to improve customer activation.

### Recommendation 2 – Prioritize Product and Support Improvements

**Finding:** Features and support together account for 218 churn events.

**Actions:**
- Review feature-related customer feedback.
- Identify frequently requested product capabilities.
- Analyze support ticket resolution times and satisfaction.
- Investigate recurring customer complaints.
- Coordinate findings with Product and Customer Success teams.

**Expected Business Benefit:** Better prioritization of product and service improvements based on recorded churn reasons.

### Recommendation 3 – Protect Enterprise Revenue

**Finding:** Enterprise subscriptions account for $926,345 in churn-flagged MRR.

**Actions:**
- Review high-value Enterprise accounts.
- Monitor renewal and downgrade activity.
- Identify product adoption and support issues.
- Develop account-specific retention strategies.
- Validate actual revenue loss before calculating churn impact.

**Expected Business Benefit:** Improved visibility into high-value subscription exposure.

### Recommendation 4 – Improve Churn Data Reconciliation

**Finding:** 125 accounts have churn events without subscription churn flags, while 85 have subscription churn flags without recorded events.

**Actions:**
- Validate the business definitions of both churn indicators.
- Investigate event timing and reactivation behavior.
- Review subscription lifecycle status changes.
- Establish consistent account-level churn rules.
- Document reconciliation exceptions.

**Expected Business Benefit:** More reliable churn reporting and customer retention metrics.

### Recommendation 5 – Develop Industry-Specific Retention Strategies

**Finding:** DevTools has the highest churn-flag percentage, while Cybersecurity has the highest churn-flagged MRR.

**Actions:**
- Analyze churn reasons by industry.
- Compare customer tenure and plan mix.
- Investigate industry-specific product requirements.
- Evaluate account-level revenue exposure.
- Prioritize interventions based on validated business impact.

**Expected Business Benefit:** Better alignment of retention strategies with customer segment characteristics.

### Recommendation 6 – Improve Churn Reason Classification

**Finding:** 95 churn events have an unknown reason.

**Actions:**
- Improve churn-reason capture during cancellation.
- Standardize churn-reason categories.
- Review missing or ambiguous reasons.
- Establish data quality monitoring for churn event records.

**Expected Business Benefit:** More complete information for product, pricing, and customer-experience decisions.

---

## 4. Data Quality Findings and Analytical Limitations

### 4.1 Churn Flags vs Churn Events

There are 486 churn-flagged subscription records and 600 recorded churn events.

These are different measures from different tables and cannot be compared as equivalent churn populations.

### 4.2 Missing Subscription Identifier in Churn Events

The churn event table does not contain `subscription_id`.

Direct event-to-subscription reconciliation cannot be performed.

### 4.3 Churn-Flag Percentage Is Not a Period Churn Rate

The 9.72% subscription churn-flag percentage is calculated across all subscription records.

It is not a monthly, quarterly, or annual customer churn rate.

### 4.4 Churn-Flagged MRR Is Not Verified Revenue Loss

The $1,179,139 associated with churn-flagged records is not necessarily the MRR lost in a specific reporting period.

Historical subscription overlap and revenue timing must be considered.

### 4.5 Customer-Level Churn Requires Active Status Validation

An account with one churn-flagged subscription may still have other active subscriptions.

Account churn requires a defined paid-customer status at relevant reporting dates.

### 4.6 Subscription Tenure Has Censoring Limitations

The tenure calculation combines subscription end dates and a reporting-date fallback.

Ongoing subscriptions have incomplete observed lifetimes.

### 4.7 Churn Event Counts Require Population Context

Higher churn-event counts may reflect growth in the number of customers or subscriptions.

Monthly churn rates require a consistent eligible population.

### 4.8 Auto-Renewal Results Are Descriptive

The observed churn-flag percentages for enabled and disabled auto-renewal are similar.

No causal relationship can be established from these results.

### 4.9 Reactivation Is Not Yet Incorporated

Although churn events contain a reactivation indicator, the Day 3 queries do not separately analyze reactivation outcomes.

Reactivation analysis is required for a more complete customer lifecycle view.

### 4.10 Revenue Retention Metrics Are Not Yet Validated

Gross Revenue Retention (GRR) and Net Revenue Retention (NRR) require beginning-period recurring revenue, churn, contraction, and expansion values.

These cannot be established from the current Day 3 churn-flag summaries alone.

---

## 5. Day 3 KPI Summary

| KPI | Result |
|---|---:|
| Subscription records | 5,000 |
| Customer accounts | 500 |
| Churn-flagged subscription records | 486 |
| Subscription churn-flag percentage | 9.72% |
| Churn-flagged MRR | $1,179,139 |
| Recorded churn events | 600 |
| Accounts with churn events | 352 |
| December 2024 churn events | 117 |
| Feature-related churn events | 114 |
| Support-related churn events | 104 |
| Budget-related churn events | 104 |
| Enterprise churn-flagged MRR | $926,345 |
| DevTools churn-flag percentage | 10.79% |
| France churn-flag percentage | 11.85% |
| Less-than-one-month churn-flag percentage | 19.65% |
| Accounts with any churn flag | 312 |
| Accounts with mixed churn flags | 312 |
| Accounts with churn flag and event | 227 |
| Accounts with event only | 125 |
| Accounts with churn flag only | 85 |
| Accounts with neither indicator | 63 |
| Highest churn-flagged MRR account | Company_358 |
| Highest account churn-flagged MRR | $60,465 |

---

## 6. Final Day 3 Conclusion

Day 3 successfully analyzed customer churn and subscription retention indicators using 15 SQL queries across the RavenStack SaaS dataset.

The analysis identified several important patterns:

1. Churn-flagged subscription records represent 9.72% of the dataset.
2. Recorded churn-event volume increased toward the end of 2024.
3. Feature limitations, support issues, and budget constraints are leading recorded churn reasons.
4. Enterprise subscriptions contribute the largest churn-associated recurring revenue.
5. Shorter calculated subscription tenure is associated with higher churn-flag percentages.
6. Churn flags and churn events differ substantially at the account level.
7. Subscription overlap and incomplete event relationships limit the ability to calculate validated customer and revenue churn metrics.

The findings provide a foundation for improving customer onboarding, product experience, Enterprise retention, churn data quality, and revenue-risk reporting.

Future analysis should extend these results through customer cohort retention, reactivation, revenue movement, and product usage analysis.

**Day 3 Status:** Completed – Queries 46–60 executed and documented.
---

---

# Day 4 – Customer Engagement, Feature Adoption & Support Analytics

## Objective

Analyze SaaS customer engagement, feature adoption, product usage,
support ticket activity, resolution performance, customer satisfaction,
and the relationship between customer activity and churn indicators.

The analysis uses DuckDB SQL queries 61–75 to identify opportunities
for improving customer experience, product adoption, and retention.

**Dataset:** RavenStack SaaS Analytics
**SQL Engine:** DuckDB
**Queries:** 61–75
**Analysis Period:** 2023–2024
**Feature Usage Records:** 25,000
**Support Tickets:** 2,000
**Customer Accounts:** 500
**Subscription Records:** 5,000

---

## 1. Executive Summary

Day 4 examines product engagement and customer support performance
using feature usage, subscription, account, and support ticket data.

### Key Performance Indicators

| KPI | Result |
|---|---:|
| Total feature usage records | 25,000 |
| Unique feature usage IDs | 24,979 |
| Duplicate usage ID occurrences | 21 |
| Subscriptions with recorded usage | 4,967 |
| Subscription usage coverage | 99.34% |
| Distinct features | 40 |
| Total recorded feature uses | 250,525 |
| Total recorded usage hours | 21,126.41 |
| Total recorded feature errors | 14,107 |
| Beta feature usage records | 2,544 |
| Total support tickets | 2,000 |
| Unique support ticket IDs | 2,000 |
| Tickets with closure timestamps | 2,000 |
| Escalated support tickets | 95 |
| Overall ticket escalation percentage | 4.75% |
| Tickets missing satisfaction scores | 825 |
| Tickets with satisfaction scores | 1,175 |
| Satisfaction response percentage | 58.75% |
| Tickets requiring 48+ hours | 697 |
| Accounts requiring high attention | 1 |
| Accounts requiring elevated attention | 252 |
| Accounts requiring moderate attention | 247 |

### Executive Findings

1. Nearly all subscription records have associated feature usage.
2. Product activity spans 40 distinct features.
3. Enterprise subscriptions generate the highest total feature usage.
4. Feature engagement is relatively evenly distributed across subscription tiers.
5. Most customer accounts fall into low or moderate engagement categories under the selected thresholds.
6. Feature usage contains duplicate identifiers requiring investigation.
7. More than one-third of support tickets require at least 48 hours to resolve.
8. Customer satisfaction averages are relatively similar across ticket priorities.
9. A substantial portion of tickets lack satisfaction ratings.
10. Support volume and account churn indicators do not show a simple linear relationship.
11. The exploratory risk segmentation requires threshold calibration before operational use.

---

## 2. Detailed SQL Findings

### Query 61 – Feature Usage Data Profiling

**Results**

| Metric | Result |
|---|---:|
| Total usage records | 25,000 |
| Unique usage IDs | 24,979 |
| Subscriptions with usage | 4,967 |
| Distinct features | 40 |
| Total feature uses | 250,525 |
| Total usage hours | 21,126.41 |
| Total errors | 14,107 |
| Beta usage records | 2,544 |

**Key Findings**

- Feature usage is recorded for 4,967 of the 5,000 subscriptions.
- Subscription usage coverage is approximately 99.34%.
- There are 40 distinct features in the dataset.
- The dataset contains 25,000 feature usage records.
- Only 24,979 distinct usage IDs are present, resulting in 21 duplicate ID occurrences.
- Total recorded feature usage exceeds 250,000 actions.
- Beta feature records account for approximately 10.18% of all usage records.

**Business Interpretation**

The dataset provides broad coverage of subscription-level product activity.

However, recorded usage does not necessarily mean that every subscription
is actively engaged during a specific reporting period.

Duplicate usage identifiers also require validation before using
the records for financial or operational reporting.

**Business Recommendations**

- Investigate duplicate usage IDs.
- Monitor feature adoption by subscription and customer.
- Establish consistent definitions for active usage.
- Track product errors and beta feature adoption separately.
- Introduce monthly engagement monitoring.

---

### Query 62 – Feature Adoption and Engagement by Feature

**Key Results**

| Feature | Usage Records | Subscriptions Using Feature | Usage Hours | Errors per 1,000 Uses |
|---|---:|---:|---:|---:|
| feature_32 | 659 | 614 | 570.09 | 53.40 |
| feature_15 | 640 | 606 | 546.39 | 52.71 |
| feature_6 | 655 | 604 | 559.44 | 51.79 |
| feature_20 | 643 | 590 | 540.89 | 47.09 |
| feature_34 | 650 | 613 | 557.42 | 60.74 |
| feature_12 | 659 | 624 | 572.63 | 54.94 |
| feature_11 | 643 | 606 | 559.11 | 53.88 |
| feature_2 | 642 | 607 | 537.69 | 61.46 |
| feature_38 | 643 | 610 | 539.52 | 54.96 |
| feature_26 | 649 | 616 | 548.99 | 64.45 |

The table shows the first ten features from the SQL ranking by
total recorded feature uses.

**Key Findings**

- Feature usage is distributed across 40 features.
- feature_32 appears first in the total-uses ranking.
- feature_12 has 624 distinct subscriptions with recorded usage.
- feature_26 has 417 recorded errors and 64.45 errors per 1,000 uses.
- Some features show higher normalized error frequency despite similar usage volumes.

**Business Interpretation**

High usage volume indicates product activity but does not necessarily
demonstrate customer satisfaction or business value.

Feature-level error frequency may help identify areas requiring
engineering investigation.

**Business Recommendations**

- Monitor feature popularity and adoption.
- Review features with higher normalized error frequency.
- Compare adoption against eligible subscriptions.
- Prioritize reliability improvements using usage and error metrics.
- Investigate whether frequently used features contribute to retention.

---

### Query 63 – Monthly Feature Engagement Trends

**2024 Results**

| Month | Usage Records | Active Subscriptions | Total Feature Uses | Usage Hours | Errors |
|---|---:|---:|---:|---:|---:|
| January | 1,060 | 949 | 10,621 | 905.09 | 614 |
| February | 1,016 | 931 | 10,247 | 841.54 | 598 |
| March | 1,069 | 963 | 10,725 | 898.42 | 590 |
| April | 1,020 | 922 | 10,131 | 858.20 | 605 |
| May | 1,040 | 938 | 10,552 | 886.08 | 613 |
| June | 1,013 | 915 | 10,106 | 873.86 | 539 |
| July | 1,068 | 959 | 10,601 | 909.96 | 656 |
| August | 1,060 | 958 | 10,559 | 861.89 | 555 |
| September | 1,020 | 918 | 10,195 | 851.68 | 564 |
| October | 1,137 | 1,027 | 11,450 | 928.03 | 570 |
| November | 991 | 905 | 10,039 | 862.61 | 537 |
| December | 1,076 | 973 | 10,738 | 884.46 | 575 |

**Key Findings**

- Monthly feature usage remains relatively stable throughout 2024.
- October records the highest feature usage volume in 2024.
- October also has the highest number of distinct subscriptions with usage.
- November records lower usage than October.
- December usage increases compared with November.
- Product errors vary by month and do not always move proportionally with usage volume.

**Business Interpretation**

The monthly results provide a foundation for product engagement monitoring.

However, monthly active subscriptions are not equivalent to monthly
active customer accounts or unique active users.

**Business Recommendations**

- Track monthly active subscriptions and accounts separately.
- Monitor changes in engagement across subscription cohorts.
- Compare feature usage with customer acquisition and churn.
- Investigate unusual changes in monthly usage.
- Normalize error counts by usage volume.

---

### Query 64 – Feature Engagement by Subscription Plan Tier

**Results**

| Plan Tier | Usage Records | Subscriptions With Usage | Total Feature Uses | Usage Hours | Errors |
|---|---:|---:|---:|---:|---:|
| Enterprise | 8,580 | 1,723 | 86,076 | 7,312.89 | 4,855 |
| Pro | 8,440 | 1,675 | 84,561 | 7,121.96 | 4,817 |
| Basic | 7,980 | 1,602 | 79,888 | 6,691.56 | 4,435 |

**Key Findings**

- Enterprise subscriptions generate the highest total feature usage.
- Pro follows closely behind Enterprise.
- Basic generates 79,888 recorded feature uses.
- All three plan tiers contribute substantial product activity.
- Differences in total usage partly reflect differences in subscription counts.

**Business Interpretation**

Enterprise customers generate the largest aggregate feature usage,
but this does not establish that individual Enterprise subscriptions
are more engaged.

Usage intensity should be normalized by subscription count,
active days, and other relevant factors.

**Business Recommendations**

- Compare average feature usage per subscription.
- Monitor plan-specific feature adoption.
- Identify features that encourage upgrades.
- Investigate underutilized premium features.
- Develop engagement benchmarks for each plan tier.

---

### Query 65 – Top 20 Most Engaged Customer Accounts

**Top 10 Accounts by Recorded Feature Uses**

| Account | Industry | Country | Feature Uses | Usage Hours | Errors |
|---|---|---|---:|---:|---:|
| Company_10 | Cybersecurity | US | 1,053 | 90.63 | 55 |
| Company_218 | DevTools | FR | 1,005 | 76.01 | 47 |
| Company_82 | DevTools | US | 993 | 78.33 | 45 |
| Company_57 | EdTech | IN | 924 | 72.64 | 59 |
| Company_125 | DevTools | US | 922 | 71.34 | 47 |
| Company_369 | Cybersecurity | US | 902 | 74.28 | 43 |
| Company_232 | HealthTech | IN | 893 | 67.46 | 46 |
| Company_413 | HealthTech | US | 885 | 76.76 | 76 |
| Company_195 | EdTech | US | 871 | 72.75 | 55 |
| Company_166 | DevTools | US | 869 | 69.80 | 54 |

**Key Findings**

- Company_10 has the highest recorded feature usage among the ranked accounts.
- Company_218 ranks second with 1,005 feature uses.
- Several DevTools customers appear among the most engaged accounts.
- High-usage accounts also generate product errors.
- Company_413 records 76 errors despite lower total usage than the top-ranked account.

**Business Interpretation**

Highly engaged accounts may represent important opportunities for
customer advocacy, product feedback, and expansion.

However, high activity alone does not prove customer satisfaction
or low churn risk.

**Business Recommendations**

- Identify highly engaged customers for product feedback.
- Investigate error frequency among high-usage accounts.
- Evaluate opportunities for expansion and cross-selling.
- Monitor changes in engagement over time.
- Compare high-engagement accounts with churn and support history.

---

### Query 66 – Low-Engagement Customer Identification

**Results**

| Engagement Segment | Accounts | Average Feature Uses | Average Distinct Features |
|---|---:|---:|---:|
| Very Low Usage | 1 | 92.00 | 9.00 |
| Low Usage | 250 | 362.02 | 23.60 |
| Moderate Usage | 249 | 642.28 | 31.72 |

**Key Findings**

- One account falls into the Very Low Usage category.
- Exactly 250 accounts fall into the Low Usage category.
- Another 249 accounts fall into Moderate Usage.
- No accounts fall into No Recorded Usage or High Usage under the selected thresholds.
- Moderate-engagement accounts use more distinct features on average.

**Business Interpretation**

The selected thresholds divide most accounts between low and
moderate engagement.

These categories are exploratory and have not been validated against
business outcomes.

**Business Recommendations**

- Calibrate engagement thresholds using the actual usage distribution.
- Normalize engagement by customer size and subscription age.
- Identify declining engagement trends.
- Develop targeted onboarding and product education.
- Evaluate whether engagement segments predict churn.

---

### Query 67 – Feature Engagement vs Subscription Churn Flags

**Results**

| Engagement Segment | Subscriptions | Churn-Flagged | Average Distinct Features | Churn-Flagged MRR |
|---|---:|---:|---:|---:|
| No Usage | 33 | 3 | 0.00 | $3,973 |
| Very Low | 4,838 | 473 | 4.61 | $1,148,557 |
| Low | 129 | 10 | 9.10 | $26,609 |

**Calculated Churn-Flag Percentages**

- No Usage: 9.09%
- Very Low: 9.78%
- Low: 7.75%

**Key Findings**

- Most subscription records fall into the Very Low engagement segment.
- The Very Low segment contains 473 churn-flagged records.
- The No Usage segment contains 33 subscriptions.
- The Low segment has a lower churn-flag percentage than Very Low.
- No subscriptions reach the Moderate or High usage thresholds.

**Business Interpretation**

The subscription-level engagement thresholds are poorly distributed
for this dataset.

A concentration of subscriptions in one segment limits the usefulness
of the segmentation.

These results do not establish a causal relationship between
feature engagement and churn.

**Business Recommendations**

- Redefine subscription-level engagement thresholds.
- Consider usage percentiles rather than fixed thresholds.
- Normalize usage by subscription lifetime.
- Compare engagement before churn events.
- Evaluate engagement and churn within comparable cohorts.

---

### Query 68 – Feature Adoption by Customer Industry

**Results**

| Industry | Accounts With Usage | Subscriptions With Usage | Usage Hours | Errors |
|---|---:|---:|---:|---:|
| DevTools | 113 | 1,151 | 4,817.04 | 3,172 |
| FinTech | 112 | 1,096 | 4,720.17 | 3,106 |
| Cybersecurity | 100 | 999 | 4,253.66 | 2,799 |
| HealthTech | 96 | 943 | 3,967.42 | 2,753 |
| EdTech | 79 | 778 | 3,368.12 | 2,277 |

**Key Findings**

- DevTools has the highest aggregate usage duration.
- FinTech follows closely behind DevTools.
- Cybersecurity ranks third by usage duration.
- EdTech has the lowest aggregate usage duration among the five industries.
- Industries with more subscriptions generally contribute more total usage.

**Business Interpretation**

Industry-level totals reflect both customer population size and
engagement activity.

Aggregate usage should not be interpreted as normalized adoption
or engagement intensity.

**Business Recommendations**

- Normalize usage by subscription and account.
- Compare feature preferences by industry.
- Investigate industry-specific product needs.
- Develop targeted product education.
- Evaluate industry-level engagement trends over time.

---

### Query 69 – Support Ticket Data Profiling

**Results**

| Metric | Result |
|---|---:|
| Total tickets | 2,000 |
| Unique ticket IDs | 2,000 |
| Tickets with closure timestamps | 2,000 |
| Tickets without closure timestamps | 0 |
| Escalated tickets | 95 |
| Non-escalated tickets | 1,905 |
| Missing satisfaction scores | 825 |
| Available satisfaction scores | 1,175 |

**Key Findings**

- All 2,000 ticket IDs are unique.
- All tickets have closure timestamps.
- 95 tickets are marked as escalated.
- The overall escalation percentage is 4.75%.
- Satisfaction scores are missing for 825 tickets.
- Approximately 41.25% of tickets have no recorded satisfaction rating.

**Business Interpretation**

Support ticket identifiers and closure timestamps are complete in
the available dataset.

However, customer satisfaction data has substantial missingness.

A closure timestamp does not independently establish that the
customer's issue was resolved satisfactorily.

**Business Recommendations**

- Improve satisfaction survey completion.
- Monitor ticket escalation trends.
- Validate closure and resolution status definitions.
- Track support outcomes by customer and priority.
- Establish data quality checks for support metrics.

---

### Query 70 – Monthly Support Ticket Trends

**2024 Results**

| Month | Tickets | Affected Accounts | Escalated | Escalation % | Avg. First Response (min) |
|---|---:|---:|---:|---:|---:|
| January | 84 | 78 | 4 | 4.76% | 85.85 |
| February | 75 | 73 | 4 | 5.33% | 92.71 |
| March | 92 | 83 | 3 | 3.26% | 92.98 |
| April | 81 | 78 | 4 | 4.94% | 88.22 |
| May | 81 | 78 | 7 | 8.64% | 90.52 |
| June | 78 | 72 | 5 | 6.41% | 86.94 |
| July | 70 | 67 | 2 | 2.86% | 88.61 |
| August | 82 | 74 | 1 | 1.22% | 85.33 |
| September | 96 | 91 | 7 | 7.29% | 89.78 |
| October | 88 | 82 | 7 | 7.95% | 86.91 |
| November | 84 | 76 | 5 | 5.95% | 78.95 |
| December | 98 | 88 | 3 | 3.06% | 92.06 |

**Key Findings**

- December has the highest ticket volume in 2024, with 98 tickets.
- July has the lowest ticket volume, with 70 tickets.
- May has the highest escalation percentage at 8.64%.
- November has the lowest average first-response time at 78.95 minutes.
- Monthly ticket volume fluctuates without a consistently increasing trend.

**Business Interpretation**

Support workload varies across months.

Changes in ticket volume may reflect customer growth, product
issues, or normal operational variation.

**Business Recommendations**

- Monitor monthly ticket volume and escalation.
- Compare ticket volume against active customer counts.
- Review months with elevated escalation percentages.
- Evaluate response time against defined service targets.
- Investigate whether support workload affects customer satisfaction.

---

### Query 71 – Support Ticket Priority Analysis

**Results**

| Priority | Tickets | Escalated | Escalation % | Avg. First Response (min) | Avg. Resolution (hours) |
|---|---:|---:|---:|---:|---:|
| Urgent | 514 | 23 | 4.47% | 85.53 | 34.57 |
| High | 510 | 24 | 4.71% | 91.44 | 36.96 |
| Medium | 491 | 25 | 5.09% | 85.86 | 35.59 |
| Low | 485 | 23 | 4.74% | 91.15 | 36.35 |

**Key Findings**

- Urgent tickets have the highest ticket count.
- Medium-priority tickets have the highest escalation percentage.
- Urgent tickets have the lowest average resolution time.
- High-priority tickets have the highest average resolution time.
- Response times are relatively similar across priorities.

**Business Interpretation**

Priority classification does not produce a simple ranking of
resolution performance.

Differences in ticket complexity and support workflows may
affect the results.

**Business Recommendations**

- Validate priority assignment rules.
- Define response and resolution targets by priority.
- Investigate high-priority ticket resolution delays.
- Monitor escalations by ticket priority.
- Evaluate support team performance against agreed service levels.

---

### Query 72 – Support Resolution Performance

**Results**

| Resolution Segment | Tickets | Avg. Resolution Hours | Avg. First Response Minutes | Escalated |
|---|---:|---:|---:|---:|
| 48+ Hours | 697 | 59.97 | 87.77 | 40 |
| 24–48 Hours | 626 | 35.04 | 89.29 | 18 |
| 12–24 Hours | 354 | 17.16 | 88.75 | 24 |
| 4–12 Hours | 230 | 7.53 | 86.53 | 10 |
| Under 4 Hours | 93 | 1.88 | 92.11 | 3 |

**Key Findings**

- 697 tickets require at least 48 hours to resolve.
- This represents 34.85% of all support tickets.
- Another 626 tickets require between 24 and 48 hours.
- A total of 1,323 tickets, or 66.15%, require at least 24 hours.
- Only 93 tickets are resolved in under four hours.
- The 48+ hour category contains the largest number of escalated tickets.

**Business Interpretation**

Longer resolution durations represent a potential customer
experience concern.

However, service-level compliance cannot be determined without
defined targets and applicable ticket conditions.

**Business Recommendations**

- Review tickets with resolution times of 48 hours or longer.
- Identify operational bottlenecks.
- Analyze escalated tickets with long resolution times.
- Establish resolution performance targets.
- Monitor the relationship between resolution duration and satisfaction.

---

### Query 73 – Customer Satisfaction Analysis

**Results**

| Priority | Tickets | Rated Tickets | Avg. Satisfaction | Avg. Resolution Hours | Response % |
|---|---:|---:|---:|---:|---:|
| Low | 485 | 287 | 4.02 | 36.35 | 59.18% |
| High | 510 | 295 | 4.00 | 36.96 | 57.84% |
| Urgent | 514 | 301 | 3.97 | 34.57 | 58.56% |
| Medium | 491 | 292 | 3.93 | 35.59 | 59.47% |

**Key Findings**

- Low-priority tickets have the highest average satisfaction score.
- Medium-priority tickets have the lowest average score.
- Average satisfaction ranges from 3.93 to 4.02.
- Satisfaction response percentages range from 57.84% to 59.47%.
- A total of 825 tickets have missing satisfaction scores.

**Business Interpretation**

Customer satisfaction scores are similar across ticket priorities.

However, missing ratings may introduce response bias.

The scoring scale should be confirmed before using the results
as a formal customer satisfaction KPI.

**Business Recommendations**

- Improve satisfaction survey coverage.
- Investigate lower-scoring support experiences.
- Compare satisfaction with resolution time.
- Analyze satisfaction for escalated tickets.
- Monitor satisfaction trends by customer segment.

---

### Query 74 – Support Activity vs Account Churn Flags

**Results**

| Support Segment | Accounts | Churn-Flagged Accounts | Churn-Flag % | Avg. Tickets | Avg. Satisfaction |
|---|---:|---:|---:|---:|---:|
| No Tickets | 8 | 2 | 25.00% | 0.00 | N/A |
| 1 Ticket | 30 | 8 | 26.67% | 1.00 | 3.68 |
| 2–3 Tickets | 176 | 45 | 25.57% | 2.58 | 3.96 |
| 4–6 Tickets | 235 | 41 | 17.45% | 4.80 | 4.00 |
| 7+ Tickets | 51 | 14 | 27.45% | 7.63 | 3.90 |

**Key Findings**

- Accounts with 7+ tickets have the highest observed churn-flag percentage.
- Accounts with 4–6 tickets have the lowest churn-flag percentage.
- Accounts with one ticket have the lowest average satisfaction.
- Eight accounts have no recorded support tickets.
- Churn-flag percentages do not consistently increase with ticket volume.

**Business Interpretation**

Support ticket volume alone is not a reliable churn predictor
in the observed data.

The analysis uses the account-level `churn_flag`, which differs
from subscription-level churn flags and churn events.

**Business Recommendations**

- Combine support metrics with product engagement and account history.
- Investigate repeated escalations and unresolved issues.
- Analyze satisfaction and churn within comparable customer cohorts.
- Avoid interpreting support volume as a causal churn driver.
- Monitor account-level support experiences over time.

---

### Query 75 – Combined Engagement and Support Risk Segmentation

**Results**

| Attention Segment | Accounts | Avg. Feature Uses | Avg. Support Tickets | Escalations |
|---|---:|---:|---:|---:|
| High Attention | 1 | 92.00 | 6.00 | 1 |
| Elevated Attention | 252 | 364.41 | 4.02 | 42 |
| Moderate Attention | 247 | 642.11 | 3.97 | 52 |

**Key Findings**

- One account is classified as High Attention.
- 252 accounts are classified as Elevated Attention.
- 247 accounts are classified as Moderate Attention.
- No accounts fall into Standard Monitoring.
- Elevated Attention accounts have lower average feature usage than Moderate Attention accounts.
- The Moderate Attention segment has more total escalations than the Elevated Attention segment.

**Business Interpretation**

The segmentation combines feature engagement and support activity
to identify accounts requiring further review.

However, the fixed thresholds are exploratory and do not represent
validated probabilities of customer churn.

The absence of Standard Monitoring accounts indicates that
the segmentation should be recalibrated.

**Business Recommendations**

- Review the High Attention account individually.
- Recalibrate engagement and support thresholds.
- Incorporate subscription tenure and account size.
- Validate risk segments against future churn outcomes.
- Develop an explainable customer health scoring framework.

---

## 3. Strategic Business Recommendations

### Recommendation 1 – Improve Product Engagement Monitoring

**Finding:** 4,967 subscriptions have recorded feature usage.

**Actions:**
- Track monthly active subscriptions.
- Establish consistent engagement metrics.
- Monitor feature adoption by customer segment.
- Identify declining engagement trends.
- Compare usage with customer lifecycle stages.

**Expected Benefit:**
Improved visibility into customer product adoption and engagement.

### Recommendation 2 – Investigate Feature Reliability

**Finding:** 14,107 feature errors are recorded.

**Actions:**
- Monitor errors per 1,000 feature uses.
- Investigate features with elevated error frequency.
- Compare errors across subscription plans.
- Review beta feature performance.
- Prioritize engineering improvements using normalized metrics.

**Expected Benefit:**
Better product reliability and customer experience.

### Recommendation 3 – Reduce Long Support Resolution Times

**Finding:** 697 tickets require 48 hours or longer to resolve.

**Actions:**
- Review long-running support tickets.
- Identify recurring resolution bottlenecks.
- Improve escalation workflows.
- Monitor resolution times by priority.
- Establish measurable service targets.

**Expected Benefit:**
Faster support resolution and improved customer experience.

### Recommendation 4 – Improve Customer Satisfaction Data Quality

**Finding:** 825 support tickets lack satisfaction scores.

**Actions:**
- Improve post-resolution survey collection.
- Monitor response rates by priority.
- Investigate survey nonresponse.
- Review customer feedback for recurring issues.
- Establish satisfaction reporting standards.

**Expected Benefit:**
More representative customer satisfaction reporting.

### Recommendation 5 – Build Better Customer Health Segmentation

**Finding:** Existing engagement thresholds produce heavily
concentrated customer segments.

**Actions:**
- Use percentile-based engagement categories.
- Normalize usage by subscription age.
- Include support escalations and satisfaction.
- Compare segments with observed churn events.
- Validate risk categories before operational deployment.

**Expected Benefit:**
More meaningful identification of accounts requiring attention.

### Recommendation 6 – Strengthen Engagement and Support Data Quality

**Finding:** Feature usage contains 21 duplicate ID occurrences.

**Actions:**
- Investigate duplicate identifiers.
- Validate subscription and account relationships.
- Establish uniqueness checks.
- Monitor missing satisfaction scores.
- Document source-system metric definitions.

**Expected Benefit:**
Greater confidence in product and customer support reporting.

---

## 4. Data Quality Findings and Analytical Limitations

### 4.1 Duplicate Feature Usage Identifiers

The feature usage table contains 25,000 records but only
24,979 unique usage IDs.

Duplicate IDs require investigation before deduplication rules
can be established.

### 4.2 Engagement Does Not Equal Customer Retention

High product usage does not automatically imply customer retention.

Retention analysis requires time-based customer lifecycle information.

### 4.3 Subscription-Level and Account-Level Metrics Differ

Feature usage is linked to subscriptions.

Support tickets are linked to accounts.

Joining these tables without appropriate aggregation can
duplicate support records and distort results.

### 4.4 Usage Thresholds Are Exploratory

The engagement categories use fixed thresholds that are not
calibrated to the dataset distribution.

They should not be treated as validated customer health scores.

### 4.5 Missing Satisfaction Ratings

825 tickets have missing satisfaction scores.

Reported averages apply only to rated tickets and may not
represent the full support population.

### 4.6 Support Ticket Closure vs Resolution Quality

All tickets contain closure timestamps.

This does not independently confirm satisfactory resolution.

### 4.7 No Support Category Field

The support ticket dataset does not include a ticket category
or issue-type field.

Therefore, category-level support analysis is unavailable.

### 4.8 No Validated SLA Targets

The dataset contains response and resolution durations but
does not define contractual service-level targets.

SLA compliance cannot be calculated reliably.

### 4.9 Account Churn Indicators Differ From Subscription Churn

Queries 74–75 use `accounts.churn_flag`.

Day 3 primarily examined `subscriptions.churn_flag`
and records in `churn_events`.

These indicators should not be assumed to represent
identical customer churn outcomes.

### 4.10 Usage Activity May Not Reflect Valid Subscription Periods

The queries aggregate recorded feature usage without validating
every usage date against subscription start and end dates.

Future analysis should validate subscription lifecycle boundaries.

### 4.11 Feature Error Counts Need Consistent Definitions

The dataset contains `error_count` and `usage_count`.

Errors per 1,000 uses are useful descriptive measures,
but their interpretation depends on how the source system
defines errors and feature uses.

### 4.12 Customer Risk Segmentation Is Not Predictive

The attention segments are rule-based classifications.

They have not been trained or validated against future churn
outcomes and should not be presented as predictive scores.

---

## 5. Day 4 KPI Summary

| KPI | Result |
|---|---:|
| Total feature usage records | 25,000 |
| Unique usage IDs | 24,979 |
| Duplicate ID occurrences | 21 |
| Subscriptions with usage | 4,967 |
| Subscription usage coverage | 99.34% |
| Distinct features | 40 |
| Total feature uses | 250,525 |
| Total usage hours | 21,126.41 |
| Total feature errors | 14,107 |
| Beta usage records | 2,544 |
| Most-used feature in query ranking | feature_32 |
| Top engaged account | Company_10 |
| Top account feature uses | 1,053 |
| Enterprise feature uses | 86,076 |
| Pro feature uses | 84,561 |
| Basic feature uses | 79,888 |
| Total support tickets | 2,000 |
| Escalated tickets | 95 |
| Escalation percentage | 4.75% |
| Missing satisfaction scores | 825 |
| Satisfaction response percentage | 58.75% |
| Tickets with 48+ hour resolution | 697 |
| Tickets with 24+ hour resolution | 1,323 |
| Highest satisfaction priority | Low |
| Lowest satisfaction priority | Medium |
| High Attention accounts | 1 |
| Elevated Attention accounts | 252 |
| Moderate Attention accounts | 247 |
| Standard Monitoring accounts | 0 |

---

## 6. Final Day 4 Conclusion

Day 4 successfully analyzed customer engagement, feature adoption,
support ticket performance, customer satisfaction, and exploratory
customer health indicators using 15 DuckDB SQL queries.

The analysis identified several important findings:

1. Feature usage is recorded for nearly all subscriptions.
2. Product activity is distributed across 40 features.
3. Enterprise subscriptions generate the highest aggregate usage.
4. Engagement thresholds require calibration to produce useful segments.
5. Product errors provide an opportunity for reliability analysis.
6. Long support resolution times deserve operational investigation.
7. Customer satisfaction reporting is limited by missing ratings.
8. Support ticket volume alone does not establish customer churn risk.
9. Combined engagement and support metrics can support a more
   comprehensive customer health framework.
10. Data quality and consistent metric definitions remain important
    prerequisites for reliable operational reporting.

The findings provide a foundation for improving product adoption,
customer experience, support operations, and customer retention analysis.

Future analysis should incorporate account lifecycle information,
subscription revenue movements, reactivation behavior, and validated
customer health metrics.

# Day 5 – Advanced SaaS Revenue, Retention & Customer Lifecycle Analytics

## 1. Project Overview

**Project:** SaaS Revenue & Subscription Analytics  
**SQL Engine:** DuckDB  
**Analysis Period:** 2023–2024  
**SQL Queries:** 76–90  
**Analysis Focus:** Revenue movements, churn, reactivation, customer cohorts, revenue concentration, and customer health.

### Objectives

The final phase of this project focuses on:

- Analyzing subscription revenue and upgrade/downgrade patterns.
- Identifying accounts and industries with churn-associated revenue exposure.
- Evaluating churn events and reactivation indicators.
- Comparing customer signup cohorts and subscription start-year cohorts.
- Understanding revenue concentration across customer accounts.
- Developing an exploratory customer health scoring framework.
- Consolidating key SaaS metrics into an executive performance scorecard.

---

## 2. Executive Summary

Day 5 analyzes 5,000 subscription records belonging to 500 customer accounts.

The dataset contains $11,338,747 in summed recorded subscription MRR, 486 churn-flagged subscription records, and 600 churn events.

Of the churn events, 61 carry a reactivation flag, representing 10.17%.

### Key Performance Indicators

| KPI | Result |
|---|---:|
| Customer accounts | 500 |
| Subscription records | 5,000 |
| Summed recorded MRR | $11,338,747 |
| Average recorded MRR per subscription | $2,267.75 |
| Churn-flagged subscription records | 486 |
| Subscription churn-flag percentage | 9.72% |
| Churn-associated MRR | $1,179,139 |
| Upgrade-flagged records | 529 |
| Downgrade-flagged records | 218 |
| Records carrying both movement flags | 23 |
| Churn events | 600 |
| Accounts with churn events | 352 |
| Reactivation-flagged events | 61 |
| Reactivation-event percentage | 10.17% |
| Top 10 accounts' share of recorded MRR | 8.51% |
| Top 50 accounts' share of recorded MRR | 26.88% |
| High Attention accounts | 15 |
| Elevated Attention accounts | 224 |

**Important:** Summed subscription MRR is not necessarily active MRR at a single reporting date. Churn-associated MRR is not confirmed realized revenue loss.

---

## 3. Detailed SQL Analysis and Business Insights

### Query 76 – Subscription Revenue and Lifecycle Overview

**Findings**

- The dataset contains 5,000 subscription records across 500 accounts.
- Summed recorded MRR equals $11,338,747.
- Average recorded MRR per subscription is approximately $2,267.75.
- 486 subscription records carry churn flags.
- Churn-associated MRR totals $1,179,139.
- 529 records carry upgrade flags and 218 carry downgrade flags.

**Business Interpretation**

The subscription dataset provides a broad view of revenue associated with different customer plans and lifecycle indicators.

Approximately 10.40% of summed recorded MRR is associated with churn-flagged subscription records. This indicates revenue exposure in the data, not a confirmed loss.

**Business Recommendations**

1. Build a point-in-time active MRR calculation using subscription effective dates.
2. Monitor churn-associated revenue separately from realized revenue loss.
3. Establish consistent definitions for upgrades, downgrades, and cancellations.
4. Create a monthly subscription revenue reporting framework.

---

### Query 77 – Upgrade and Downgrade Revenue Exposure

| Movement Category | Records | Average Recorded MRR | Churn-Flagged Records | Churn-Flag % |
|---|---:|---:|---:|---:|
| Neither | 4,276 | $2,258.38 | 419 | 9.80% |
| Upgrade Only | 506 | $2,416.13 | 42 | 8.30% |
| Downgrade Only | 195 | $2,148.37 | 21 | 10.77% |
| Both Upgrade and Downgrade | 23 | $1,758.00 | 4 | 17.39% |

**Findings**

- Most subscriptions, 4,276 records, have neither movement flag.
- Upgrade-only records outnumber downgrade-only records.
- Upgrade-only subscriptions have a lower churn-flag percentage than downgrade-only subscriptions.
- The 23 records with both flags have the highest observed churn-flag percentage, at 17.39%.

**Business Interpretation**

Upgrade-associated subscriptions show relatively favorable churn indicators.

However, upgrade and downgrade flags do not provide historical revenue changes. The analysis cannot establish the monetary value of expansion or contraction.

The records carrying both flags require additional investigation to determine whether they represent legitimate sequential movements or inconsistent data.

**Recommendations**

- Investigate overlapping movement flags.
- Track previous and current subscription MRR.
- Calculate actual expansion and contraction MRR once historical snapshots are available.
- Analyze downgrade patterns before churn events.

---

### Query 78 – Revenue Movement Flags by Plan Tier

| Plan Tier | Subscription Records | Upgrade-Flag % | Downgrade-Flag % | Downgrade-Associated MRR |
|---|---:|---:|---:|---:|
| Enterprise | 1,723 | 11.26% | 3.95% | $318,002 |
| Pro | 1,675 | 11.58% | 5.37% | $114,023 |
| Basic | 1,602 | 8.80% | 3.75% | $27,341 |

**Findings**

- Pro has the highest upgrade-flag percentage at 11.58%.
- Pro also has the highest downgrade-flag percentage at 5.37%.
- Enterprise has the largest downgrade-associated MRR at $318,002.
- Basic has the lowest upgrade-flag percentage at 8.80%.

**Business Interpretation**

Enterprise subscriptions represent the largest monetary exposure associated with downgrade flags, while Pro shows the highest proportion of downgrade-flagged records.

These figures represent the MRR of flagged subscriptions, not the amounts by which revenue declined.

**Recommendations**

- Prioritize Enterprise downgrade reviews based on account value.
- Investigate upgrade and downgrade behavior within Pro.
- Identify obstacles to Basic-to-Pro upgrades.
- Compare movements across subscription tenure and billing frequency.

---

### Query 79 – Revenue Movement Flags by Industry

| Industry | Accounts | Subscription Records | Churn-Flagged Records | Churn-Associated MRR |
|---|---:|---:|---:|---:|
| FinTech | 112 | 1,100 | 96 | $253,446 |
| DevTools | 113 | 1,158 | 125 | $238,611 |
| Cybersecurity | 100 | 1,008 | 103 | $279,062 |
| EdTech | 79 | 785 | 66 | $198,743 |
| HealthTech | 96 | 949 | 96 | $209,277 |

**Findings**

- DevTools has the highest number of churn-flagged subscription records, at 125.
- Cybersecurity has the highest churn-associated MRR, at $279,062.
- FinTech has 96 churn-flagged records and $253,446 in associated MRR.
- EdTech has the fewest churn-flagged records, at 66.

**Business Interpretation**

Industry rankings differ depending on whether churn is measured by record count or associated revenue.

Cybersecurity deserves attention from a revenue-exposure perspective, while DevTools has the greatest flagged subscription volume.

**Recommendations**

- Develop industry-specific retention reporting.
- Prioritize high-value churn-associated accounts.
- Compare churn patterns with feature engagement and support performance.
- Evaluate customer success strategies by industry.

---

### Query 80 – Customer Expansion and Contraction Flag Patterns

| Account Movement Segment | Accounts | Subscription Records | Recorded MRR | Average Account MRR |
|---|---:|---:|---:|---:|
| Upgrade Flags Only | 190 | 1,939 | $4,556,677 | $23,982.51 |
| No Movement Flags | 133 | 1,129 | $2,514,964 | $18,909.50 |
| Both Movement Types | 117 | 1,326 | $2,950,432 | $25,217.37 |
| Downgrade Flags Only | 60 | 606 | $1,316,674 | $21,944.57 |

**Findings**

- 190 accounts have upgrade flags without downgrade flags.
- 60 accounts have downgrade flags without upgrade flags.
- 117 accounts have both movement types across their subscription records.
- 133 accounts have no movement flags.
- Accounts with both movement types have the highest average summed recorded MRR.

**Business Interpretation**

Movement patterns suggest that customers may experience different subscription lifecycle changes across records.

An account containing both movement types does not necessarily indicate contradictory data, because the flags may occur on different subscriptions or at different times.

**Recommendations**

- Build chronological account movement histories.
- Separate subscription-level movement flags from account-level classifications.
- Identify repeated downgrades and subsequent churn.
- Evaluate upgrade opportunities among stable accounts.

---

### Query 81 – Account Revenue Exposure and Subscription Churn

**Top 10 Accounts by Churn-Associated MRR**

| Account | Industry | Churn-Flagged Records | Churn-Associated MRR | Share of Account Recorded MRR |
|---|---|---:|---:|---:|
| Company_358 | EdTech | 6 | $60,465 | 46.46% |
| Company_492 | Cybersecurity | 2 | $26,080 | 50.00% |
| Company_4 | HealthTech | 2 | $23,406 | 48.00% |
| Company_403 | FinTech | 1 | $23,283 | 16.86% |
| Company_47 | DevTools | 4 | $21,066 | 55.13% |
| Company_303 | FinTech | 1 | $20,497 | 53.67% |
| Company_278 | Cybersecurity | 2 | $19,502 | 66.26% |
| Company_376 | Cybersecurity | 2 | $19,502 | 67.74% |
| Company_163 | Cybersecurity | 3 | $19,144 | 42.72% |
| Company_91 | HealthTech | 2 | $19,104 | 32.71% |

**Findings**

- Company_358 has the highest churn-associated MRR at $60,465.
- Company_376 has 67.74% of its summed recorded MRR associated with churn-flagged subscriptions.
- Company_278 has a similarly high exposure percentage of 66.26%.
- Several Cybersecurity accounts appear in the highest-exposure group.

**Business Interpretation**

The results identify accounts for further investigation based on the monetary value and concentration of churn-associated subscription records.

An account may contain both churn-flagged and non-churn-flagged subscriptions.

**Recommendations**

- Review the highest-exposure accounts first.
- Examine customer engagement, support history, and subscription tenure.
- Validate which flagged subscriptions actually terminated.
- Develop account-level revenue risk monitoring.

---

### Query 82 – Churn Event and Reactivation Overview

| Metric | Result |
|---|---:|
| Total churn events | 600 |
| Unique churn event IDs | 600 |
| Accounts with churn events | 352 |
| Reactivation-flagged events | 61 |
| Events without reactivation flags | 539 |
| Missing reactivation flags | 0 |
| Reactivation-event percentage | 10.17% |

**Findings**

- All 600 churn event IDs are unique.
- Churn events affect 352 distinct customer accounts.
- 61 events carry reactivation flags.
- No missing reactivation flags were identified.

**Business Interpretation**

Approximately one in ten churn event records is marked as associated with reactivation.

This is an event-level percentage, not a customer win-back rate. A customer may have multiple churn events, and the timing and definition of the reactivation flag require confirmation.

**Recommendations**

- Track distinct reactivated customers.
- Calculate time between churn and reactivation.
- Compare pre-churn and post-reactivation revenue.
- Investigate customer characteristics associated with reactivation.

---

### Query 83 – Reactivation Trends by Churn Event Month

**Selected Monthly Results**

| Month | Churn Events | Reactivation-Flagged Events | Reactivation % |
|---|---:|---:|---:|
| Jan 2024 | 20 | 0 | 0.00% |
| Feb 2024 | 10 | 2 | 20.00% |
| Mar 2024 | 24 | 1 | 4.17% |
| Apr 2024 | 25 | 3 | 12.00% |
| May 2024 | 27 | 3 | 11.11% |
| Jun 2024 | 40 | 5 | 12.50% |
| Jul 2024 | 35 | 3 | 8.57% |
| Aug 2024 | 42 | 5 | 11.90% |
| Sep 2024 | 53 | 7 | 13.21% |
| Oct 2024 | 66 | 6 | 9.09% |
| Nov 2024 | 68 | 9 | 13.24% |
| Dec 2024 | 117 | 11 | 9.40% |

**Findings**

- December 2024 has the highest churn event volume, at 117.
- December also has the highest number of reactivation-flagged events, at 11.
- November records nine reactivation-flagged events.
- February has the highest 2024 reactivation-event percentage at 20%, based on only ten churn events.
- Churn event volume increases substantially toward the end of 2024.

**Business Interpretation**

Higher reactivation counts in later months partly reflect larger churn event volumes.

The query groups events by churn date, so these results should not be interpreted as the actual calendar dates on which customers reactivated.

**Recommendations**

- Investigate the increase in late-2024 churn events.
- Record actual reactivation dates separately.
- Compare reactivation outcomes over consistent observation windows.
- Analyze win-back campaign effectiveness once campaign data becomes available.

---

### Query 84 – Reactivation by Churn Reason

| Churn Reason | Churn Events | Affected Accounts | Reactivation-Event % | Events With Preceding Downgrade |
|---|---:|---:|---:|---:|
| Features | 114 | 104 | 11.40% | 9 |
| Support | 104 | 95 | 5.77% | 13 |
| Budget | 104 | 94 | 11.54% | 6 |
| Unknown | 95 | 86 | 9.47% | 9 |
| Competitor | 92 | 79 | 13.04% | 12 |
| Pricing | 91 | 86 | 9.89% | 4 |

**Findings**

- Feature-related churn is the largest category, with 114 events.
- Support-related and budget-related churn each have 104 events.
- Competitor-related churn has the highest reactivation-event percentage, at 13.04%.
- Support-related churn has the lowest reactivation-event percentage, at 5.77%.
- Support-related events have the highest number of preceding downgrade indicators, at 13.

**Business Interpretation**

The low reactivation percentage associated with support-related churn suggests that these events deserve further investigation.

However, the observed differences do not establish that specific churn reasons cause reactivation outcomes.

**Recommendations**

- Review recurring feature-related churn reasons.
- Investigate support experiences preceding churn.
- Develop targeted win-back strategies by churn reason.
- Examine competitor-related reactivation cases for actionable insights.
- Improve classification of unknown churn reasons.

---

### Query 85 – Customer Signup Cohort and Churn Flag Analysis

**Selected Results**

| Signup Cohort | Accounts | Churn-Flagged Accounts | Calculated Flag % |
|---|---:|---:|---:|
| Jan 2023 | 17 | 4 | 23.53% |
| Feb 2023 | 18 | 7 | 38.89% |
| Oct 2023 | 20 | 7 | 35.00% |
| Mar 2024 | 27 | 4 | 14.81% |
| Jul 2024 | 26 | 3 | 11.54% |
| Sep 2024 | 25 | 9 | 36.00% |
| Oct 2024 | 31 | 7 | 22.58% |
| Nov 2024 | 32 | 4 | 12.50% |
| Dec 2024 | 17 | 1 | 5.88% |

**Findings**

- November 2024 has the largest signup cohort, with 32 accounts.
- October 2024 follows with 31 accounts.
- September 2024 has nine churn-flagged accounts, the highest count among the displayed cohorts.
- February 2023 has a 38.89% churn-flag percentage.
- December 2024 has a relatively low churn-flag percentage of 5.88%.

**Business Interpretation**

Customer churn indicators vary across signup cohorts.

However, newer cohorts have shorter observation periods. Their lower churn-flag percentages should not automatically be interpreted as stronger retention.

**Recommendations**

- Compare cohorts at consistent ages.
- Build month-1, month-3, month-6, and month-12 retention measures.
- Investigate cohorts with elevated churn flags.
- Analyze acquisition channels and onboarding experiences.
- Validate account-level churn flags against churn event history.

---

### Query 86 – Subscription Start-Year Cohort Analysis

| Start Year | Subscription Records | Churn-Flag % | Recorded MRR | Churn-Associated MRR |
|---|---:|---:|---:|---:|
| 2023 | 666 | 12.76% | $1,313,608 | $145,053 |
| 2024 | 4,334 | 9.25% | $10,025,139 | $1,034,086 |

**Findings**

- Most subscription records began in 2024.
- The 2023 cohort has a higher churn-flag percentage.
- The 2024 cohort has greater aggregate recorded MRR.
- The 2024 cohort also has greater churn-associated MRR in absolute terms.

**Business Interpretation**

The 2023 cohort has a longer opportunity to accumulate churn indicators.

Therefore, these results should not be interpreted as proof that 2024 subscriptions retain customers more effectively.

**Recommendations**

- Compare subscriptions at equivalent lifecycle ages.
- Develop survival and retention curves.
- Monitor churn by plan tier within each cohort.
- Analyze revenue retention after subscription activation.

---

### Query 87 – Revenue Concentration by Account Ranking

| Revenue Segment | Accounts | Recorded MRR | Share of Total |
|---|---:|---:|---:|
| Top 10 | 10 | $964,589 | 8.51% |
| Rank 11–50 | 40 | $2,083,437 | 18.37% |
| Rank 51–100 | 50 | $1,803,410 | 15.90% |
| Remaining Accounts | 400 | $6,487,311 | 57.21% |

**Findings**

- The top ten accounts contribute 8.51% of summed recorded MRR.
- The top 50 accounts contribute approximately 26.88%.
- The top 100 accounts contribute approximately 42.78%.
- The remaining 400 accounts contribute approximately 57.21%.

**Business Interpretation**

Recorded subscription revenue is distributed across a broad customer base rather than being concentrated entirely among a few accounts.

Nevertheless, individual high-value customers may still represent meaningful retention priorities.

**Recommendations**

- Monitor revenue concentration over time.
- Track high-value accounts separately.
- Establish customer concentration indicators.
- Evaluate revenue exposure by account and industry.
- Diversify acquisition and expansion opportunities.

---

### Query 88 – Customer Lifetime Value Proxy

**Top Accounts in the Annualized Recorded-MRR Ranking**

| Rank | Account | Industry | Churn-Flagged Records |
|---|---|---|---:|
| 1 | Company_403 | FinTech | 1 |
| 2 | Company_166 | DevTools | 1 |
| 3 | Company_358 | EdTech | 6 |
| 4 | Company_368 | EdTech | 1 |
| 5 | Company_337 | Cybersecurity | 1 |
| 6 | Company_130 | EdTech | 0 |
| 7 | Company_488 | EdTech | 1 |
| 8 | Company_23 | EdTech | 0 |
| 9 | Company_475 | FinTech | 1 |
| 10 | Company_480 | EdTech | 0 |

**Findings**

- Company_403 ranks first by the annualized recorded-MRR proxy.
- Company_166 ranks second.
- Company_358 ranks third and has six churn-flagged subscription records.
- Several EdTech accounts appear among the top-ranked customers.
- High recorded revenue and churn indicators can coexist.

**Business Interpretation**

The calculation multiplies summed account-level recorded MRR by 12.

This is not true customer lifetime value. It does not incorporate realized revenue over time, gross margin, acquisition cost, or expected customer lifetime.

**Recommendations**

- Rename the measure to `annualized_recorded_mrr_proxy` in dashboards.
- Build realized account revenue histories.
- Estimate customer lifetime using observed retention.
- Include gross margin when developing a true CLV model.
- Compare customer value with acquisition and retention costs.

---

### Query 89 – Multi-Factor Customer Health Assessment

| Health Segment | Accounts | Average Feature Uses | Average Support Tickets | Average Attention Score |
|---|---:|---:|---:|---:|
| High Attention | 15 | 342.47 | 4.53 | 5.07 |
| Elevated Attention | 224 | 468.02 | 4.28 | 3.33 |
| Moderate Attention | 218 | 525.76 | 3.71 | 1.64 |
| Standard Monitoring | 43 | 603.19 | 3.86 | 0.00 |

**Findings**

- 15 accounts fall into High Attention.
- 224 accounts fall into Elevated Attention.
- 218 accounts fall into Moderate Attention.
- 43 accounts fall into Standard Monitoring.
- Average feature usage generally increases as attention scores decrease.
- High Attention accounts have the highest average support ticket volume.

**Business Interpretation**

The model combines engagement, support escalation, satisfaction, and subscription churn flags into a rule-based attention score.

The segmentation is more differentiated than Day 4's initial framework.

However, the score includes subscription churn flags as an input, so comparing the score against churn outcomes requires careful separation of predictors and outcomes.

**Recommendations**

- Review High Attention accounts individually.
- Prioritize Elevated Attention accounts for engagement analysis.
- Validate score thresholds against future outcomes.
- Avoid using current churn flags to predict the same churn events.
- Develop time-based customer health scores using historical features.

---

### Query 90 – Executive SaaS Performance Scorecard

**Results**

| KPI | Result |
|---|---:|
| Customer accounts | 500 |
| Subscription records | 5,000 |
| Summed recorded MRR | $11,338,747 |
| Churn-flagged subscription records | 486 |
| Subscription churn-flag percentage | 9.72% |
| Feature usage records | 25,000 |
| Subscriptions with recorded usage | 4,967 |
| Total recorded feature uses | 250,525 |
| Feature errors | 14,107 |
| Support tickets | 2,000 |
| Escalated tickets | 95 |
| Churn events | 600 |
| Accounts with churn events | 352 |
| Reactivation-flagged events | 61 |

**Findings**

- The scorecard combines revenue, subscription lifecycle, feature engagement, customer support, and churn metrics.
- It provides a consolidated view of SaaS operational performance.
- The data supports several useful descriptive KPIs.
- Additional historical revenue data would be required for accurate MRR growth, GRR, and NRR reporting.

**Business Interpretation**

An executive SaaS dashboard should clearly distinguish recorded revenue, actual active revenue, churn indicators, and realized revenue changes.

**Recommendations**

- Develop an executive dashboard with separate revenue, retention, engagement, and support sections.
- Establish consistent reporting dates.
- Add historical subscription revenue snapshots.
- Introduce validated GRR, NRR, and realized churn metrics when the required data becomes available.

---

## 4. Strategic Business Recommendations

### 1. Improve Revenue Movement Tracking

**Observation:** Upgrade and downgrade flags are available, but historical revenue deltas are not.

**Actions:**

- Capture previous and new subscription MRR.
- Track effective dates of plan changes.
- Separate expansion, contraction, churn, and reactivation.
- Build a monthly revenue movement bridge.

**Expected Business Value:** More accurate subscription revenue reporting and better identification of expansion opportunities.

### 2. Prioritize High-Value Churn Exposure

**Observation:** $1,179,139 of summed recorded MRR is associated with churn-flagged subscriptions.

**Actions:**

- Review accounts with the highest churn-associated MRR.
- Investigate high-exposure Cybersecurity accounts.
- Combine revenue exposure with engagement and support indicators.
- Validate actual churn outcomes before calculating revenue loss.

**Expected Business Value:** Better prioritization of customer retention efforts.

### 3. Develop Targeted Reactivation Strategies

**Observation:** 61 of 600 churn events have reactivation flags.

**Actions:**

- Analyze reactivation by churn reason.
- Investigate low reactivation among support-related churn events.
- Track actual customer return dates.
- Measure revenue recovered after reactivation.

**Expected Business Value:** Improved understanding of potential win-back opportunities.

### 4. Strengthen Cohort Retention Analytics

**Observation:** Signup and subscription cohorts show different churn-flag percentages.

**Actions:**

- Compare cohorts at equal lifecycle ages.
- Track active customer retention over time.
- Analyze churn by acquisition channel and plan tier.
- Build monthly retention curves.

**Expected Business Value:** Better understanding of long-term customer behavior.

### 5. Operationalize Customer Health Monitoring Carefully

**Observation:** The exploratory health model identifies 15 High Attention and 224 Elevated Attention accounts.

**Actions:**

- Review the High Attention group.
- Refine engagement and support thresholds.
- Validate scores against future churn events.
- Monitor changes in account health over time.

**Expected Business Value:** A stronger foundation for proactive customer success workflows.

---

## 5. Data Quality Findings and Limitations

### 5.1 Recorded MRR Is Not Point-in-Time Active MRR

Summing `mrr_amount` across subscription records does not necessarily represent the company's active monthly recurring revenue at a specific date.

Subscription start dates, end dates, overlapping records, and lifecycle status must be considered.

### 5.2 Upgrade and Downgrade Flags Are Not Revenue Deltas

An upgrade flag identifies a recorded subscription characteristic but does not reveal the monetary increase in MRR.

Likewise, downgrade-associated MRR does not equal actual contraction MRR.

### 5.3 Overlapping Movement Flags

Twenty-three subscription records have both upgrade and downgrade flags.

Their validity cannot be determined without event timing or source-system definitions.

### 5.4 Churn Flags and Churn Events Differ

Subscription churn flags, account churn flags, and churn event records represent different data structures.

They should not be combined into a single churn rate without reconciliation.

### 5.5 Reactivation Flags Do Not Establish Win-Back Timing

The churn event table includes reactivation indicators, but the monthly analysis groups records by churn dates.

Actual reactivation dates are required to measure time to return.

### 5.6 Cohort Observation Periods Differ

Customers acquired in 2023 have longer observation periods than customers acquired in late 2024.

Direct comparisons of cumulative churn flags can therefore be misleading.

### 5.7 Annualized Revenue Proxy Is Not Customer Lifetime Value

Multiplying summed recorded MRR by 12 does not establish actual CLV or realized annual revenue.

### 5.8 Customer Health Scores Are Exploratory

The health scoring framework uses manually selected thresholds.

It has not been statistically calibrated or validated as a predictive churn model.

### 5.9 Missing Revenue History Limits SaaS Metrics

Accurate calculations of the following require additional historical data:

- Net Revenue Retention (NRR)
- Gross Revenue Retention (GRR)
- Realized expansion MRR
- Realized contraction MRR
- Reactivation MRR
- Point-in-time active MRR growth

### 5.10 Truncated Terminal Output

Some SQL result columns were hidden by DuckDB's display-width settings.

This documentation uses visible results and directly calculable values rather than inventing unavailable figures.

---

## 6. Final Day 5 Business Conclusions

The Day 5 analysis demonstrates how SQL can be used to evaluate SaaS subscription revenue, customer lifecycle behavior, churn exposure, reactivation indicators, and account-level health.

### Major Conclusions

1. The dataset contains substantial recorded subscription revenue across 500 customer accounts.
2. Upgrade-only subscription records outnumber downgrade-only records.
3. Enterprise subscriptions represent the largest downgrade-associated MRR.
4. Cybersecurity has the highest churn-associated MRR among the industries.
5. Several individual accounts have significant concentrations of churn-associated subscription revenue.
6. Reactivation flags appear in 10.17% of churn event records.
7. Feature-related churn is the most frequent recorded reason.
8. Support-related churn has the lowest reactivation-event percentage.
9. Customer churn indicators differ across acquisition and subscription cohorts.
10. Revenue is distributed across a relatively broad customer base.
11. The customer health framework identifies accounts requiring further review.
12. Historical revenue and lifecycle data are essential for production-grade SaaS retention metrics.

---

## 7. Final Project Summary – Days 1–5

| Day | Focus | Queries |
|---|---|---|
| Day 1 | Data exploration, quality validation, and foundational SaaS analysis | 1–30 |
| Day 2 | Subscription revenue and customer segmentation | 31–45 |
| Day 3 | Customer churn, retention indicators, and churn-event reconciliation | 46–60 |
| Day 4 | Feature engagement, adoption, and customer support analytics | 61–75 |
| Day 5 | Advanced revenue, reactivation, cohorts, and customer health | 76–90 |

### Final Deliverables

- 90 DuckDB SQL queries
- Five days of SaaS analytics
- Revenue and subscription lifecycle analysis
- Customer churn and reactivation analysis
- Feature engagement and support analytics
- Cohort and customer segmentation
- Exploratory customer health scoring
- Business recommendations and documented analytical limitations

### Overall Project Conclusion

This project demonstrates the application of SQL and DuckDB to analyze a multi-table SaaS dataset covering revenue, subscriptions, customers, product usage, support operations, and churn.

The analysis identifies business opportunities involving revenue expansion, customer retention, product adoption, customer support, and proactive account management.

It also highlights the importance of distinguishing descriptive subscription metrics from realized financial outcomes and validated predictive measures.

**Project Status: Day 5 Complete — Queries 76–90.**

**Overall SQL Project Status: 90 Queries Completed Across Five Days.**

---
