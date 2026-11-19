SaaS Revenue & Subscription Analytics
   
Project Overview
An end-to-end SaaS Revenue & Subscription Analytics portfolio project using SQL and DuckDB to explore customer accounts, subscription revenue, churn indicators, product engagement, support performance, and customer lifecycle patterns.

The project comprises 90 SQL queries across five analysis days, progressing from data profiling and revenue segmentation to churn-event reconciliation, feature adoption, reactivation analysis, and exploratory customer health scoring. Each phase translates query results into business insights, recommendations, and methodological limitations.
Metric interpretation: Summing mrr_amount across all subscription records produces summed recorded MRR, not necessarily active MRR on a particular date. Similarly, churn-flagged MRR is revenue associated with flagged records, not confirmed lost revenue. Upgrade/downgrade flags do not provide realized expansion or contraction amounts.

Business Objectives
- Profile the SaaS data model and validate data quality.
- Understand subscription and revenue distribution by plan, customer, and industry.
- Explore churn flags, churn events, and discrepancies between them.
- Analyze feature adoption, engagement, errors, and customer support performance.
- Examine upgrade/downgrade indicators, reactivation, and cohort patterns.
- Identify revenue concentration and accounts requiring further investigation.
- Create a consolidated executive scorecard and actionable business recommendations.
Technology Stack
Technology	Purpose
SQL	Data validation, joins, CTEs, aggregations, conditional logic, and window functions
DuckDB	Local analytical database and SQL execution
VS Code	SQL development and Markdown documentation
Git & GitHub	Version control and project publishing
PowerShell	Windows command-line workflow


Dataset & Data Model
The project uses five related tables:
Table	Records	Grain / Description
accounts	500	Customer account attributes, signup dates, industry, country, and account-level churn flag
subscriptions	5,000	Subscription records, plan, seats, dates, MRR/ARR fields, billing, trial and movement flags
feature_usage	25,000	Recorded subscription feature activity, duration, errors, and beta indicators
support_tickets	2,000	Account-level tickets, priorities, response/resolution durations, satisfaction, and escalation
churn_events	600	Account-level churn event history, reason codes, and reactivation indicators


Relationships
accounts (account_id)
  ├── subscriptions (account_id)
  │     └── feature_usage (subscription_id)
  ├── support_tickets (account_id)
  └── churn_events (account_id)
Important grain distinction: Support tickets and churn events are account-level; feature usage is subscription-level. Aggregate to the appropriate grain before joining to avoid inflated counts or monetary totals. churn_events does not provide a subscription identifier.
Project Structure
20-SaaS-Revenue-Subscription-Analytics/
├── sql/
│   └── queries.sql              # Queries 1–90
├── insights/
│   └── insights.md              # Detailed findings for Days 1–5
├── README.md                    # Project documentation
└── saas_analytics.duckdb        # Local DuckDB database (if retained locally)
Dataset files, setup scripts, and the database file may be stored locally or omitted from GitHub depending on repository configuration. Adjust the tree to reflect the files actually committed.
Five-Day Analysis Roadmap
Day	Queries	Focus
Day 1	1–30	Data exploration, profiling, quality validation, and foundational SaaS metrics
Day 2	31–45	Subscription revenue analysis and customer segmentation
Day 3	46–60	Churn flags, churn events, retention indicators, and reconciliation
Day 4	61–75	Feature adoption, engagement, support performance, and satisfaction
Day 5	76–90	Revenue movement indicators, reactivation, cohorts, concentration, and customer health


All queries are maintained in one SQL file (sql/queries.sql), with detailed findings in one Markdown insights file (insights/insights.md).
Key Results
1. Revenue & Subscription Overview
Metric	Result
Customer accounts	500
Subscription records	5,000
Summed recorded subscription MRR	$11,338,747
Average recorded MRR per subscription	$2,267.75
Churn-flagged subscription records	486
Subscription churn-flag percentage	9.72%
Churn-associated recorded MRR	$1,179,139


The 9.72% figure is the proportion of subscription records carrying a churn flag; it is not a monthly customer churn rate. The $1.18M is not verified realized lost MRR.
2. Upgrade & Downgrade Indicators
Subscription flag category	Records	Churn-flag percentage
Neither upgrade nor downgrade	4,276	9.80%
Upgrade only	506	8.30%
Downgrade only	195	10.77%
Both upgrade and downgrade	23	17.39%


- 529 subscription records carry an upgrade flag, including the 23 records with both flags.
- 218 records carry a downgrade flag, including the same 23 overlapping records.
- The overlapping records warrant investigation; flags alone do not establish whether movements occurred at different times.
- Enterprise has $318,002 in downgrade-associated recorded MRR, versus $114,023 for Pro and $27,341 for Basic. These are flagged subscription balances, not contraction amounts.
3. Churn Events & Reactivation Indicators
Metric	Result
Churn events	600
Distinct accounts with churn events	352
Reactivation-flagged churn events	61
Reactivation-flagged event share	10.17%
Churn events in December 2024	117
Reactivation-flagged events in December 2024	11


Churn reasons
Reason	Churn events	Reactivation-flagged event percentage
Features	114	11.40%
Support	104	5.77%
Budget	104	11.54%
Unknown	95	9.47%
Competitor	92	13.04%
Pricing	91	9.89%


Interpretation: Support-related churn events have the lowest reactivation-flag percentage in this grouping. This is descriptive, not evidence of causality or a verified customer win-back rate. Monthly reactivation-flag counts are grouped by churn-event month, not actual return date.
4. Feature Engagement & Product Reliability
Metric	Result
Feature usage records	25,000
Distinct usage IDs	24,979
Duplicate usage ID occurrences	21
Subscriptions with recorded usage	4,967
Subscription usage coverage	99.34%
Distinct features	40
Total recorded feature uses	250,525
Recorded feature errors	14,107
Beta feature usage records	2,544


Feature uses by subscription tier
Plan	Recorded feature uses	Usage hours
Enterprise	86,076	7,312.89
Pro	84,561	7,121.96
Basic	79,888	6,691.56


Enterprise leads in aggregate usage, but plan populations differ. Per-subscription and tenure-normalized comparisons are needed to evaluate engagement intensity.
5. Customer Support Performance
Metric	Result
Support tickets	2,000
Unique ticket IDs	2,000
Tickets with closure timestamps	2,000
Escalated tickets	95
Escalation percentage	4.75%
Missing satisfaction ratings	825
Satisfaction response percentage	58.75%
Tickets requiring 48+ hours	697
Tickets requiring at least 24 hours	1,323


Approximately 34.85% of support tickets fall into the 48+ hour resolution segment. Satisfaction averages by priority range from 3.93 to 4.02, but missing ratings limit representativeness. No service-level targets were provided, so these figures should not be labeled SLA breaches.
6. Revenue Concentration
Account revenue rank	Accounts	Summed recorded MRR	Share
Top 10	10	$964,589	8.51%
11–50	40	$2,083,437	18.37%
51–100	50	$1,803,410	15.90%
Remaining accounts	400	$6,487,311	57.21%


The top 50 accounts account for approximately 26.88% of summed recorded MRR. Revenue is spread across a broad customer base, though individual high-value accounts remain important to review.
7. Subscription Start-Year Cohorts
Start year	Subscription records	Churn-flag percentage	Recorded MRR
2023	666	12.76%	$1,313,608
2024	4,334	9.25%	$10,025,139


These are cumulative churn-flag comparisons, not equivalent-age cohort retention rates. Older subscriptions have had more time to accumulate churn indicators.
8. Exploratory Customer Health Scoring
Day 5 combines subscription churn flags, recorded feature usage, support escalations, and satisfaction into an illustrative attention score.
Attention segment	Accounts	Average feature uses	Average support tickets
High Attention	15	342.47	4.53
Elevated Attention	224	468.02	4.28
Moderate Attention	218	525.76	3.71
Standard Monitoring	43	603.19	3.86


Caution: The thresholds are manually selected and have not been validated against future churn. Because subscription churn flags contribute to the score, the same flags must not be used as an independent validation target without addressing leakage.
Data Quality & Analytical Limitations
The project explicitly documents these considerations:
1. Duplicate usage identifiers: 25,000 feature usage records contain 24,979 distinct usage IDs. Investigate before deduplicating.
2. Different entity grains: Account-level support/churn data must not be joined directly to multiple subscription records without aggregation.
3. Inconsistent churn indicators: Subscription flags, account flags, and churn-event records do not reconcile one-to-one. Earlier analysis found accounts with churn events but no subscription churn flags, and vice versa.
4. Historical revenue is incomplete: Without effective-dated MRR snapshots, actual expansion, contraction, reactivation MRR, GRR, and NRR cannot be reliably calculated.
5. Churn flags are not realized losses: Churn-associated recorded MRR is exposure, not confirmed revenue loss.
6. Reactivation timing is unavailable: Reactivation indicators do not independently identify the date of return or recovered revenue.
7. Cohorts have unequal observation windows: Compare retention at the same age rather than raw cumulative flags.
8. Support survey nonresponse: 825 tickets have no satisfaction score.
9. No SLA definitions: Ticket durations cannot establish contractual SLA compliance.
10. Customer health scoring is exploratory: Rule-based scores are not validated churn probabilities.
11. Annualized MRR is not CLV: Multiplying recorded MRR by 12 is a revenue proxy, not customer lifetime value.
Business Recommendations
Priority	Recommendation	Business rationale
High	Build a time-aware MRR movement bridge	Distinguish new, expansion, contraction, churn, and reactivation MRR
High	Reconcile churn indicators across tables	Improve trust in retention and revenue reporting
High	Review accounts with high churn-associated revenue	Prioritize investigation by monetary exposure
High	Investigate long support resolution times	Identify potential operational bottlenecks
Medium	Improve satisfaction survey coverage	Reduce uncertainty in customer experience reporting
Medium	Monitor normalized feature adoption and errors	Identify product adoption and reliability opportunities
Medium	Build equivalent-age retention cohorts	Make customer lifecycle comparisons more meaningful
Medium	Calibrate and validate customer health scores	Support responsible customer success prioritization
Medium	Measure reactivation timing and recovered revenue	Evaluate actual customer win-back outcomes


SQL Techniques Demonstrated
- Multi-table joins and grain-aware aggregation
- Common table expressions (CTEs)
- Conditional aggregation using CASE WHEN
- Distinct counts and reconciliation checks
- Date truncation and cohort grouping
- Window functions (ROW_NUMBER)
- Ranking and top-N customer analysis
- Percentage calculations using NULLIF to avoid division by zero
- Revenue segmentation and concentration analysis
- Rule-based account classification
- Data quality validation and metric interpretation
How to Run the Project
Prerequisites
- DuckDB CLI
- Git (optional, for cloning)
- A local DuckDB database populated with the five project tables
1. Clone the repository
git clone https://github.com/teja-naidu/20-SaaS-Revenue-Subscription-Analytics.git
cd 20-SaaS-Revenue-Subscription-Analytics
2. Confirm that the database exists
The SQL assumes a local database named saas_analytics.duckdb with the required tables. If the database is not committed, create or restore it using your own local dataset/import workflow before running the queries.
3. Run all 90 queries from PowerShell
duckdb saas_analytics.duckdb -f sql/queries.sql
Alternatively, open the DuckDB shell:
duckdb saas_analytics.duckdb
Then run this inside the DuckDB shell, not PowerShell:
.read sql/queries.sql
Running sql/queries.sql executes all five days. To run only one day's queries, copy the relevant numbered section into a separate SQL file and execute it using duckdb saas_analytics.duckdb -f <file.sql>.

4. Review the analysis
See [`insights/insights.md`](insights/insights.md) for detailed query-by-query findings, business interpretations, recommendations, and limitations.
Suggested Future Enhancements
- Build a monthly MRR bridge from effective-dated subscription changes.
- Calculate GRR and NRR using validated historical revenue snapshots.
- Create customer and subscription retention curves with consistent observation windows.
- Measure reactivation lag and realized recovered revenue.
- Create feature adoption funnels using eligible-account denominators.
- Develop an interactive Tableau or Power BI dashboard.
- Validate a time-aware customer churn model using historical predictors and future outcomes.
- Add automated data quality tests for identifiers, joins, dates, and revenue consistency.
Project Deliverables
- 90 SQL queries across five phases
- Five days of documented insights
- Multi-table SaaS analysis covering revenue, customer behavior, support, and churn
- Executive KPIs and exploratory account health segmentation
- Business recommendations and analytical limitations
- GitHub-ready project documentation
Repository
View this project on GitHub
Author
Teja Naidu Ganji
Portfolio project for demonstrating SQL analytics, SaaS business metric interpretation, data quality validation, and stakeholder-focused reporting.