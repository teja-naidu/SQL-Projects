-- PROJECT 20: SaaS Revenue & Subscription Analytics
-- DAY 1: Dataset exploration and data quality validation
-- Run from the project root using: duckdb saas_analytics.duckdb < sql/queries.sql

-- Q01-Q05: Load raw CSV files as persistent DuckDB tables
CREATE OR REPLACE TABLE accounts AS SELECT * FROM read_csv_auto('data/ravenstack_accounts.csv', HEADER=TRUE);
CREATE OR REPLACE TABLE subscriptions AS SELECT * FROM read_csv_auto('data/ravenstack_subscriptions.csv', HEADER=TRUE);
CREATE OR REPLACE TABLE feature_usage AS SELECT * FROM read_csv_auto('data/ravenstack_feature_usage.csv', HEADER=TRUE);
CREATE OR REPLACE TABLE support_tickets AS SELECT * FROM read_csv_auto('data/ravenstack_support_tickets.csv', HEADER=TRUE);
CREATE OR REPLACE TABLE churn_events AS SELECT * FROM read_csv_auto('data/ravenstack_churn_events.csv', HEADER=TRUE);

-- Q06: Row counts across tables
SELECT 'accounts' AS table_name, COUNT(*) AS total_rows FROM accounts
UNION ALL SELECT 'subscriptions', COUNT(*) FROM subscriptions
UNION ALL SELECT 'feature_usage', COUNT(*) FROM feature_usage
UNION ALL SELECT 'support_tickets', COUNT(*) FROM support_tickets
UNION ALL SELECT 'churn_events', COUNT(*) FROM churn_events;

-- Q07: Inspect tables and inferred types
DESCRIBE accounts;
DESCRIBE subscriptions;
DESCRIBE feature_usage;
DESCRIBE support_tickets;
DESCRIBE churn_events;

-- Q08: Sample account records
SELECT * FROM accounts LIMIT 5;
-- Q09: Sample subscription records
SELECT * FROM subscriptions LIMIT 5;
-- Q10: Unique IDs versus row counts
SELECT 'accounts' AS table_name, COUNT(*) AS rows, COUNT(DISTINCT account_id) AS unique_ids FROM accounts
UNION ALL SELECT 'subscriptions', COUNT(*), COUNT(DISTINCT subscription_id) FROM subscriptions
UNION ALL SELECT 'feature_usage', COUNT(*), COUNT(DISTINCT usage_id) FROM feature_usage
UNION ALL SELECT 'support_tickets', COUNT(*), COUNT(DISTINCT ticket_id) FROM support_tickets
UNION ALL SELECT 'churn_events', COUNT(*), COUNT(DISTINCT churn_event_id) FROM churn_events;

-- Q11: Null primary keys
SELECT 'accounts' AS table_name, COUNT(*) AS null_ids FROM accounts WHERE account_id IS NULL
UNION ALL SELECT 'subscriptions', COUNT(*) FROM subscriptions WHERE subscription_id IS NULL
UNION ALL SELECT 'feature_usage', COUNT(*) FROM feature_usage WHERE usage_id IS NULL
UNION ALL SELECT 'support_tickets', COUNT(*) FROM support_tickets WHERE ticket_id IS NULL
UNION ALL SELECT 'churn_events', COUNT(*) FROM churn_events WHERE churn_event_id IS NULL;

-- Q12: Orphan subscriptions
SELECT COUNT(*) AS orphan_subscriptions FROM subscriptions s LEFT JOIN accounts a ON s.account_id=a.account_id WHERE a.account_id IS NULL;
-- Q13: Orphan feature usage
SELECT COUNT(*) AS orphan_usage_events FROM feature_usage u LEFT JOIN subscriptions s ON u.subscription_id=s.subscription_id WHERE s.subscription_id IS NULL;
-- Q14: Orphan support tickets
SELECT COUNT(*) AS orphan_tickets FROM support_tickets t LEFT JOIN accounts a ON t.account_id=a.account_id WHERE a.account_id IS NULL;
-- Q15: Orphan churn events
SELECT COUNT(*) AS orphan_churn_events FROM churn_events c LEFT JOIN accounts a ON c.account_id=a.account_id WHERE a.account_id IS NULL;

-- Q16: Date coverage
SELECT MIN(signup_date) AS first_signup, MAX(signup_date) AS last_signup FROM accounts;
SELECT MIN(start_date) AS first_start, MAX(start_date) AS last_start, MIN(end_date) AS earliest_end, MAX(end_date) AS latest_end FROM subscriptions;
SELECT MIN(usage_date) AS first_usage, MAX(usage_date) AS last_usage FROM feature_usage;
SELECT MIN(churn_date) AS first_churn, MAX(churn_date) AS last_churn FROM churn_events;

-- Q17: Invalid subscription periods
SELECT COUNT(*) AS invalid_periods FROM subscriptions WHERE end_date < start_date;
-- Q18: Invalid revenue and seat amounts
SELECT COUNT(*) AS invalid_revenue_or_seats FROM subscriptions WHERE mrr_amount < 0 OR arr_amount < 0 OR seats <= 0;
-- Q19: ARR vs 12 times MRR (check for expected model relationship)
SELECT COUNT(*) AS arr_mrr_mismatches FROM subscriptions WHERE ABS(arr_amount - 12*mrr_amount) > 0.01;
-- Q20: Revenue summary (historical subscription rows, NOT point-in-time active MRR)
SELECT COUNT(*) AS subscription_records, ROUND(SUM(mrr_amount),2) AS sum_recorded_mrr, ROUND(AVG(mrr_amount),2) AS avg_recorded_mrr, ROUND(SUM(arr_amount),2) AS sum_recorded_arr FROM subscriptions;

-- Q21: Plan distribution
SELECT plan_tier, COUNT(*) AS subscription_records, ROUND(AVG(mrr_amount),2) AS avg_mrr FROM subscriptions GROUP BY plan_tier ORDER BY subscription_records DESC;
-- Q22: Billing frequency distribution
SELECT billing_frequency, COUNT(*) AS subscription_records FROM subscriptions GROUP BY billing_frequency ORDER BY subscription_records DESC;
-- Q23: Trial, churn, upgrade, downgrade flags
SELECT COUNT(*) AS subscriptions, COUNT(*) FILTER (WHERE is_trial) AS trial_rows, COUNT(*) FILTER (WHERE churn_flag) AS churn_flag_rows, COUNT(*) FILTER (WHERE upgrade_flag) AS upgrade_rows, COUNT(*) FILTER (WHERE downgrade_flag) AS downgrade_rows FROM subscriptions;
-- Q24: Missing support satisfaction scores
SELECT COUNT(*) AS tickets, COUNT(*) FILTER (WHERE satisfaction_score IS NULL) AS missing_satisfaction, ROUND(100.0*COUNT(*) FILTER (WHERE satisfaction_score IS NULL)/NULLIF(COUNT(*),0),2) AS missing_pct FROM support_tickets;
-- Q25: Churn reason counts
SELECT reason_code, COUNT(*) AS churn_events FROM churn_events GROUP BY reason_code ORDER BY churn_events DESC;
-- Q26: Account-level subscription frequency
SELECT COUNT(*) AS accounts, MIN(subscription_count) AS min_subscriptions, MAX(subscription_count) AS max_subscriptions, ROUND(AVG(subscription_count),2) AS avg_subscriptions FROM (SELECT account_id, COUNT(*) AS subscription_count FROM subscriptions GROUP BY account_id);
-- Q27: Duplicate account/date subscription rows (review, not automatically erroneous)
SELECT account_id, start_date, COUNT(*) AS records FROM subscriptions GROUP BY account_id,start_date HAVING COUNT(*)>1 ORDER BY records DESC LIMIT 20;
-- Q28: Null counts for important subscription attributes
SELECT COUNT(*) FILTER (WHERE account_id IS NULL) AS missing_account_id, COUNT(*) FILTER (WHERE start_date IS NULL) AS missing_start_date, COUNT(*) FILTER (WHERE plan_tier IS NULL) AS missing_plan_tier, COUNT(*) FILTER (WHERE mrr_amount IS NULL) AS missing_mrr, COUNT(*) FILTER (WHERE end_date IS NULL) AS open_end_dates FROM subscriptions;
-- Q29: Usage quality
SELECT COUNT(*) AS usage_events, COUNT(*) FILTER (WHERE usage_count < 0 OR usage_duration_secs < 0 OR error_count < 0) AS negative_metrics, COUNT(*) FILTER (WHERE usage_date IS NULL) AS missing_usage_dates FROM feature_usage;
-- Q30: Support ticket quality
SELECT COUNT(*) AS tickets, COUNT(*) FILTER (WHERE closed_at < submitted_at) AS closed_before_opened, COUNT(*) FILTER (WHERE resolution_time_hours < 0 OR first_response_time_minutes < 0) AS negative_response_metrics FROM support_tickets;


-- ============================================================
-- PROJECT 20: SaaS Revenue & Subscription Analytics
-- DAY 2: Revenue & Subscription Performance
-- Queries 31–45
-- Reporting snapshot: 2024-12-31
-- ============================================================

-- NOTE:
-- Subscription rows may overlap for the same account.
-- Snapshot MRR below is the sum of qualifying subscription
-- records, not necessarily deduplicated account-level MRR.
-- Historical sums are not recognized accounting revenue.


-- ============================================================
-- QUERY 31: Total Recorded Subscription Revenue
-- ============================================================

SELECT
    COUNT(*) AS total_subscription_records,
    COUNT(DISTINCT account_id) AS total_accounts,
    SUM(mrr_amount) AS total_recorded_mrr,
    ROUND(AVG(mrr_amount), 2) AS avg_subscription_mrr,
    SUM(arr_amount) AS total_recorded_arr,
    ROUND(AVG(arr_amount), 2) AS avg_subscription_arr
FROM subscriptions;


-- ============================================================
-- QUERY 32: Active Subscription Snapshot (2024-12-31)
-- ============================================================

WITH snapshot AS (
    SELECT *
    FROM subscriptions
    WHERE start_date <= DATE '2024-12-31'
      AND (
          end_date IS NULL
          OR end_date > DATE '2024-12-31'
      )
      AND COALESCE(churn_flag, FALSE) = FALSE
      AND COALESCE(is_trial, FALSE) = FALSE
)
SELECT
    COUNT(*) AS active_paid_subscription_records,
    COUNT(DISTINCT account_id) AS active_paid_accounts,
    SUM(mrr_amount) AS snapshot_mrr,
    SUM(arr_amount) AS snapshot_arr,
    ROUND(AVG(mrr_amount), 2) AS avg_active_subscription_mrr,
    ROUND(
        SUM(mrr_amount) * 1.0 /
        NULLIF(COUNT(DISTINCT account_id), 0),
        2
    ) AS mrr_per_active_account
FROM snapshot;


-- ============================================================
-- QUERY 33: Monthly Subscription Starts and Recorded MRR
-- ============================================================

SELECT
    DATE_TRUNC('month', start_date)::DATE AS start_month,
    COUNT(*) AS new_subscription_records,
    COUNT(DISTINCT account_id) AS accounts_starting_subscriptions,
    SUM(mrr_amount) AS recorded_mrr_from_starts,
    ROUND(AVG(mrr_amount), 2) AS avg_new_subscription_mrr
FROM subscriptions
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 34: Monthly Active Paid MRR Trend
-- ============================================================

WITH months AS (
    SELECT
        month_end::DATE AS snapshot_date
    FROM generate_series(
        DATE '2023-01-31',
        DATE '2024-12-31',
        INTERVAL '1 month'
    ) AS t(month_end)
),
active_records AS (
    SELECT
        m.snapshot_date,
        s.subscription_id,
        s.account_id,
        s.mrr_amount
    FROM months m
    JOIN subscriptions s
      ON s.start_date <= m.snapshot_date
     AND (
         s.end_date IS NULL
         OR s.end_date > m.snapshot_date
     )
    WHERE COALESCE(s.churn_flag, FALSE) = FALSE
      AND COALESCE(s.is_trial, FALSE) = FALSE
)
SELECT
    snapshot_date,
    COUNT(*) AS active_paid_subscription_records,
    COUNT(DISTINCT account_id) AS active_paid_accounts,
    SUM(mrr_amount) AS active_record_mrr,
    ROUND(
        SUM(mrr_amount) -
        LAG(SUM(mrr_amount)) OVER (
            ORDER BY snapshot_date
        ),
        2
    ) AS mom_mrr_change
FROM active_records
GROUP BY snapshot_date
ORDER BY snapshot_date;


-- ============================================================
-- QUERY 35: Revenue by Subscription Plan Tier
-- ============================================================

SELECT
    plan_tier,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(mrr_amount) AS recorded_mrr,
    SUM(arr_amount) AS recorded_arr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr,
    ROUND(
        100.0 * SUM(mrr_amount) /
        NULLIF(
            (SELECT SUM(mrr_amount) FROM subscriptions),
            0
        ),
        2
    ) AS pct_recorded_mrr
FROM subscriptions
GROUP BY plan_tier
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 36: Active Paid Revenue by Plan Tier
-- ============================================================

SELECT
    plan_tier,
    COUNT(*) AS active_subscription_records,
    COUNT(DISTINCT account_id) AS active_accounts,
    SUM(mrr_amount) AS active_record_mrr,
    SUM(arr_amount) AS active_record_arr,
    ROUND(AVG(mrr_amount), 2) AS avg_active_mrr
FROM subscriptions
WHERE start_date <= DATE '2024-12-31'
  AND (
      end_date IS NULL
      OR end_date > DATE '2024-12-31'
  )
  AND COALESCE(churn_flag, FALSE) = FALSE
  AND COALESCE(is_trial, FALSE) = FALSE
GROUP BY plan_tier
ORDER BY active_record_mrr DESC;


-- ============================================================
-- QUERY 37: Revenue by Billing Frequency
-- ============================================================

SELECT
    billing_frequency,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(mrr_amount) AS recorded_mrr,
    SUM(arr_amount) AS recorded_arr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS pct_subscription_records
FROM subscriptions
GROUP BY billing_frequency
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 38: Trial vs Paid Subscription Performance
-- ============================================================

SELECT
    CASE
        WHEN is_trial = TRUE THEN 'Trial'
        WHEN is_trial = FALSE THEN 'Paid'
        ELSE 'Unknown'
    END AS subscription_type,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(mrr_amount) AS recorded_mrr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flag_records
FROM subscriptions
GROUP BY 1
ORDER BY subscription_records DESC;


-- ============================================================
-- QUERY 39: Upgrade and Downgrade Distribution
-- ============================================================

SELECT
    CASE
        WHEN upgrade_flag = TRUE
         AND downgrade_flag = TRUE
            THEN 'Both Upgrade and Downgrade'
        WHEN upgrade_flag = TRUE
            THEN 'Upgrade'
        WHEN downgrade_flag = TRUE
            THEN 'Downgrade'
        ELSE 'No Change'
    END AS change_category,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(mrr_amount) AS recorded_mrr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr
FROM subscriptions
GROUP BY 1
ORDER BY subscription_records DESC;


-- ============================================================
-- QUERY 40: Revenue by Auto-Renewal Status
-- ============================================================

SELECT
    auto_renew_flag,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(mrr_amount) AS recorded_mrr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flag_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage
FROM subscriptions
GROUP BY auto_renew_flag
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 41: Revenue by Customer Industry
-- ============================================================

SELECT
    a.industry,
    COUNT(s.subscription_id) AS subscription_records,
    COUNT(DISTINCT a.account_id) AS distinct_accounts,
    SUM(s.mrr_amount) AS recorded_mrr,
    ROUND(AVG(s.mrr_amount), 2) AS avg_mrr,
    SUM(s.arr_amount) AS recorded_arr
FROM subscriptions s
JOIN accounts a
  ON s.account_id = a.account_id
GROUP BY a.industry
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 42: Revenue by Customer Country
-- ============================================================

SELECT
    a.country,
    COUNT(s.subscription_id) AS subscription_records,
    COUNT(DISTINCT a.account_id) AS distinct_accounts,
    SUM(s.mrr_amount) AS recorded_mrr,
    ROUND(AVG(s.mrr_amount), 2) AS avg_mrr
FROM subscriptions s
JOIN accounts a
  ON s.account_id = a.account_id
GROUP BY a.country
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 43: Top 20 Accounts by Recorded Subscription MRR
-- ============================================================

SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    COUNT(s.subscription_id) AS subscription_records,
    SUM(s.mrr_amount) AS recorded_mrr,
    SUM(s.arr_amount) AS recorded_arr,
    ROUND(AVG(s.mrr_amount), 2) AS avg_subscription_mrr
FROM accounts a
JOIN subscriptions s
  ON a.account_id = s.account_id
GROUP BY
    a.account_id,
    a.account_name,
    a.industry,
    a.country
ORDER BY recorded_mrr DESC
LIMIT 20;


-- ============================================================
-- QUERY 44: Revenue Concentration Among Top Accounts
-- ============================================================

WITH account_revenue AS (
    SELECT
        account_id,
        SUM(mrr_amount) AS recorded_mrr
    FROM subscriptions
    GROUP BY account_id
),
ranked_accounts AS (
    SELECT
        account_id,
        recorded_mrr,
        ROW_NUMBER() OVER (
            ORDER BY recorded_mrr DESC, account_id
        ) AS revenue_rank
    FROM account_revenue
)
SELECT
    COUNT(*) AS total_accounts,
    SUM(recorded_mrr) AS total_recorded_mrr,
    SUM(
        CASE WHEN revenue_rank <= 10
             THEN recorded_mrr ELSE 0 END
    ) AS top_10_recorded_mrr,
    ROUND(
        100.0 *
        SUM(
            CASE WHEN revenue_rank <= 10
                 THEN recorded_mrr ELSE 0 END
        ) / NULLIF(SUM(recorded_mrr), 0),
        2
    ) AS top_10_revenue_share_pct,
    ROUND(
        100.0 *
        SUM(
            CASE WHEN revenue_rank <= 50
                 THEN recorded_mrr ELSE 0 END
        ) / NULLIF(SUM(recorded_mrr), 0),
        2
    ) AS top_50_revenue_share_pct
FROM ranked_accounts;


-- ============================================================
-- QUERY 45: Subscription Overlap and Revenue Quality Check
-- ============================================================

WITH active_snapshot AS (
    SELECT
        account_id,
        subscription_id,
        plan_tier,
        mrr_amount
    FROM subscriptions
    WHERE start_date <= DATE '2024-12-31'
      AND (
          end_date IS NULL
          OR end_date > DATE '2024-12-31'
      )
      AND COALESCE(churn_flag, FALSE) = FALSE
      AND COALESCE(is_trial, FALSE) = FALSE
),
account_summary AS (
    SELECT
        account_id,
        COUNT(*) AS active_subscription_records,
        COUNT(DISTINCT plan_tier) AS active_plan_tiers,
        SUM(mrr_amount) AS combined_active_mrr
    FROM active_snapshot
    GROUP BY account_id
)
SELECT
    COUNT(*) AS active_accounts,
    SUM(
        CASE WHEN active_subscription_records > 1
             THEN 1 ELSE 0 END
    ) AS accounts_with_multiple_active_records,
    MAX(active_subscription_records)
        AS max_active_records_per_account,
    SUM(
        CASE WHEN active_plan_tiers > 1
             THEN 1 ELSE 0 END
    ) AS accounts_with_multiple_active_tiers,
    SUM(
        CASE WHEN active_subscription_records > 1
             THEN combined_active_mrr ELSE 0 END
    ) AS mrr_from_multi_record_accounts,
    ROUND(
        100.0 *
        SUM(
            CASE WHEN active_subscription_records > 1
                 THEN combined_active_mrr ELSE 0 END
        ) / NULLIF(SUM(combined_active_mrr), 0),
        2
    ) AS multi_record_mrr_share_pct
FROM account_summary;


-- ============================================================
-- PROJECT 20: SaaS Revenue & Subscription Analytics
-- DAY 3: Customer Churn & Retention Analytics
-- Queries 46–60
-- ============================================================

-- Reporting date: 2024-12-31
-- Churn flags represent subscription-record characteristics.
-- Churn events represent separately recorded churn activity.
-- Do not assume that these populations are identical.


-- ============================================================
-- QUERY 46: Overall Subscription Churn Overview
-- ============================================================

SELECT
    COUNT(*) AS total_subscription_records,
    COUNT(DISTINCT account_id) AS total_accounts,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    SUM(CASE WHEN NOT churn_flag THEN 1 ELSE 0 END)
        AS non_churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS mrr_associated_with_churn_flags
FROM subscriptions;

-- ============================================================
-- QUERY 47: Churn Event Summary
-- ============================================================

SELECT
    COUNT(*) AS total_churn_events,
    COUNT(DISTINCT churn_event_id) AS unique_churn_events,
    COUNT(DISTINCT account_id) AS accounts_with_churn_events,
    MIN(churn_date) AS earliest_churn_date,
    MAX(churn_date) AS latest_churn_date
FROM churn_events;

-- ============================================================
-- QUERY 48: Monthly Churn Event Trend
-- ============================================================

SELECT
    DATE_TRUNC('month', churn_date)::DATE AS churn_month,
    COUNT(*) AS churn_events,
    COUNT(DISTINCT account_id) AS affected_accounts
FROM churn_events
GROUP BY 1
ORDER BY 1;

-- ============================================================
-- QUERY 49: Churn Reasons Distribution
-- ============================================================

SELECT
    reason_code,
    COUNT(*) AS churn_events,
    COUNT(DISTINCT account_id) AS affected_accounts,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS pct_churn_events
FROM churn_events
GROUP BY reason_code
ORDER BY churn_events DESC;

-- ============================================================
-- QUERY 50: Churn by Subscription Plan Tier
-- ============================================================

SELECT
    plan_tier,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions
GROUP BY plan_tier
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 51: Churn by Billing Frequency
-- ============================================================

SELECT
    billing_frequency,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions
GROUP BY billing_frequency
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 52: Churn by Trial vs Paid Subscription
-- ============================================================

SELECT
    CASE
        WHEN is_trial = TRUE THEN 'Trial'
        WHEN is_trial = FALSE THEN 'Paid'
        ELSE 'Unknown'
    END AS subscription_type,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions
GROUP BY 1
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 53: Churn by Customer Industry
-- ============================================================

SELECT
    a.industry,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT s.account_id) AS accounts,
    SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN s.churn_flag THEN s.mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions s
JOIN accounts a
    ON s.account_id = a.account_id
GROUP BY a.industry
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 54: Churn by Customer Country
-- ============================================================

SELECT
    a.country,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN s.churn_flag THEN s.mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions s
JOIN accounts a
    ON s.account_id = a.account_id
GROUP BY a.country
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 55: Churn by Auto-Renewal Status
-- ============================================================

SELECT
    auto_renew_flag,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions
GROUP BY auto_renew_flag
ORDER BY churn_flag_percentage DESC;


-- ============================================================
-- QUERY 56: Subscription Tenure Distribution
-- ============================================================

WITH subscription_tenure AS (
    SELECT
        subscription_id,
        account_id,
        DATE_DIFF(
            'day',
            start_date,
            COALESCE(end_date, DATE '2024-12-31')
        ) AS tenure_days
    FROM subscriptions
    WHERE start_date <= DATE '2024-12-31'
)
SELECT
    CASE
        WHEN tenure_days < 0 THEN 'Invalid Negative Tenure'
        WHEN tenure_days < 30 THEN 'Less Than 1 Month'
        WHEN tenure_days < 90 THEN '1–3 Months'
        WHEN tenure_days < 180 THEN '3–6 Months'
        WHEN tenure_days < 365 THEN '6–12 Months'
        ELSE '12+ Months'
    END AS tenure_category,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS accounts,
    ROUND(AVG(tenure_days), 2) AS avg_tenure_days
FROM subscription_tenure
GROUP BY 1
ORDER BY MIN(tenure_days);


-- ============================================================
-- QUERY 57: Churn Flag Percentage by Subscription Tenure
-- ============================================================

WITH subscription_tenure AS (
    SELECT
        subscription_id,
        churn_flag,
        DATE_DIFF(
            'day',
            start_date,
            COALESCE(end_date, DATE '2024-12-31')
        ) AS tenure_days
    FROM subscriptions
    WHERE start_date <= DATE '2024-12-31'
)
SELECT
    CASE
        WHEN tenure_days < 0 THEN 'Invalid Negative Tenure'
        WHEN tenure_days < 30 THEN 'Less Than 1 Month'
        WHEN tenure_days < 90 THEN '1–3 Months'
        WHEN tenure_days < 180 THEN '3–6 Months'
        WHEN tenure_days < 365 THEN '6–12 Months'
        ELSE '12+ Months'
    END AS tenure_category,
    COUNT(*) AS subscription_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage
FROM subscription_tenure
GROUP BY 1
ORDER BY MIN(tenure_days);


-- ============================================================
-- QUERY 58: Account-Level Churn Exposure
-- ============================================================

WITH account_churn AS (
    SELECT
        account_id,
        COUNT(*) AS total_subscription_records,
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
            AS churn_flagged_records,
        SUM(CASE WHEN NOT churn_flag THEN 1 ELSE 0 END)
            AS non_churn_flagged_records
    FROM subscriptions
    GROUP BY account_id
)
SELECT
    COUNT(*) AS total_accounts,
    SUM(
        CASE WHEN churn_flagged_records > 0
             THEN 1 ELSE 0 END
    ) AS accounts_with_any_churn_flag,
    SUM(
        CASE WHEN churn_flagged_records > 0
              AND non_churn_flagged_records > 0
             THEN 1 ELSE 0 END
    ) AS accounts_with_mixed_churn_flags,
    SUM(
        CASE WHEN churn_flagged_records > 0
              AND non_churn_flagged_records = 0
             THEN 1 ELSE 0 END
    ) AS accounts_with_all_records_churn_flagged,
    SUM(
        CASE WHEN churn_flagged_records = 0
             THEN 1 ELSE 0 END
    ) AS accounts_without_churn_flags
FROM account_churn;



-- ============================================================
-- QUERY 59: Account-Level Churn Flag vs Churn Event Reconciliation
-- ============================================================

WITH subscription_flags AS (
    SELECT
        account_id,
        COUNT(*) AS total_subscription_records,
        SUM(
            CASE WHEN churn_flag THEN 1 ELSE 0 END
        ) AS churn_flagged_records
    FROM subscriptions
    GROUP BY account_id
),
event_summary AS (
    SELECT
        account_id,
        COUNT(*) AS churn_event_count
    FROM churn_events
    GROUP BY account_id
)
SELECT
    CASE
        WHEN s.churn_flagged_records > 0
         AND e.account_id IS NOT NULL
            THEN 'Has Churn Flag and Event'
        WHEN s.churn_flagged_records > 0
         AND e.account_id IS NULL
            THEN 'Has Churn Flag Only'
        WHEN s.churn_flagged_records = 0
         AND e.account_id IS NOT NULL
            THEN 'Has Churn Event Only'
        ELSE 'Neither Flag nor Event'
    END AS reconciliation_category,
    COUNT(*) AS accounts,
    SUM(s.total_subscription_records)
        AS subscription_records,
    SUM(s.churn_flagged_records)
        AS churn_flagged_records,
    SUM(COALESCE(e.churn_event_count, 0))
        AS churn_events
FROM subscription_flags s
LEFT JOIN event_summary e
    ON s.account_id = e.account_id
GROUP BY 1
ORDER BY accounts DESC;

-- ============================================================
-- QUERY 60: Top 20 Accounts by Churn-Flagged MRR Exposure
-- ============================================================

SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    COUNT(s.subscription_id) AS total_subscription_records,
    SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    SUM(
        CASE WHEN s.churn_flag
             THEN s.mrr_amount ELSE 0 END
    ) AS churn_flagged_mrr,
    SUM(
        CASE WHEN NOT s.churn_flag
             THEN s.mrr_amount ELSE 0 END
    ) AS non_churn_flagged_mrr
FROM accounts a
JOIN subscriptions s
    ON a.account_id = s.account_id
GROUP BY
    a.account_id,
    a.account_name,
    a.industry,
    a.country
HAVING SUM(
    CASE WHEN s.churn_flag THEN 1 ELSE 0 END
) > 0
ORDER BY churn_flagged_mrr DESC
LIMIT 20;


-- ============================================================
-- PROJECT 20: SaaS Revenue & Subscription Analytics
-- DAY 4: Customer Engagement, Feature Adoption & Support
-- Queries 61–75
-- ============================================================


-- ============================================================
-- QUERY 61: Feature Usage Data Profiling
-- ============================================================

SELECT
    COUNT(*) AS total_usage_records,
    COUNT(DISTINCT usage_id) AS unique_usage_ids,
    COUNT(DISTINCT subscription_id) AS subscriptions_with_usage,
    COUNT(DISTINCT feature_name) AS distinct_features,
    MIN(usage_date) AS earliest_usage_date,
    MAX(usage_date) AS latest_usage_date,
    SUM(usage_count) AS total_feature_uses,
    ROUND(SUM(usage_duration_secs) / 3600.0, 2)
        AS total_usage_hours,
    SUM(error_count) AS total_errors,
    SUM(CASE WHEN is_beta_feature THEN 1 ELSE 0 END)
        AS beta_usage_records
FROM feature_usage;


-- ============================================================
-- QUERY 62: Feature Adoption and Engagement by Feature
-- ============================================================

SELECT
    feature_name,
    COUNT(*) AS usage_records,
    COUNT(DISTINCT subscription_id) AS subscriptions_using_feature,
    SUM(usage_count) AS total_feature_uses,
    ROUND(AVG(usage_count), 2) AS avg_uses_per_record,
    ROUND(SUM(usage_duration_secs) / 3600.0, 2)
        AS total_usage_hours,
    SUM(error_count) AS total_errors,
    ROUND(
        1000.0 * SUM(error_count) /
        NULLIF(SUM(usage_count), 0),
        2
    ) AS errors_per_1000_uses
FROM feature_usage
GROUP BY feature_name
ORDER BY total_feature_uses DESC;


-- ============================================================
-- QUERY 63: Monthly Feature Engagement Trends
-- ============================================================

SELECT
    DATE_TRUNC('month', usage_date)::DATE AS usage_month,
    COUNT(*) AS usage_records,
    COUNT(DISTINCT subscription_id) AS active_subscriptions,
    COUNT(DISTINCT feature_name) AS features_used,
    SUM(usage_count) AS total_feature_uses,
    ROUND(SUM(usage_duration_secs) / 3600.0, 2)
        AS total_usage_hours,
    SUM(error_count) AS total_errors
FROM feature_usage
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 64: Feature Engagement by Subscription Plan Tier
-- ============================================================

SELECT
    s.plan_tier,
    COUNT(f.usage_id) AS usage_records,
    COUNT(DISTINCT s.subscription_id)
        AS subscriptions_with_usage,
    COUNT(DISTINCT f.feature_name) AS distinct_features,
    COALESCE(SUM(f.usage_count), 0) AS total_feature_uses,
    ROUND(
        COALESCE(SUM(f.usage_duration_secs), 0) / 3600.0,
        2
    ) AS total_usage_hours,
    COALESCE(SUM(f.error_count), 0) AS total_errors
FROM subscriptions s
LEFT JOIN feature_usage f
    ON s.subscription_id = f.subscription_id
GROUP BY s.plan_tier
ORDER BY total_feature_uses DESC;


-- ============================================================
-- QUERY 65: Top 20 Most Engaged Customer Accounts
-- ============================================================

WITH account_engagement AS (
    SELECT
        s.account_id,
        COUNT(f.usage_id) AS usage_records,
        COUNT(DISTINCT f.feature_name) AS distinct_features,
        COUNT(DISTINCT f.usage_date) AS active_usage_days,
        SUM(f.usage_count) AS total_feature_uses,
        SUM(f.usage_duration_secs) AS total_duration_secs,
        SUM(f.error_count) AS total_errors
    FROM subscriptions s
    JOIN feature_usage f
        ON s.subscription_id = f.subscription_id
    GROUP BY s.account_id
)
SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    e.usage_records,
    e.distinct_features,
    e.active_usage_days,
    e.total_feature_uses,
    ROUND(e.total_duration_secs / 3600.0, 2)
        AS total_usage_hours,
    e.total_errors
FROM account_engagement e
JOIN accounts a
    ON e.account_id = a.account_id
ORDER BY e.total_feature_uses DESC
LIMIT 20;


-- ============================================================
-- QUERY 66: Low-Engagement Customer Identification
-- ============================================================

WITH account_engagement AS (
    SELECT
        a.account_id,
        a.account_name,
        a.industry,
        COUNT(DISTINCT f.usage_id) AS usage_records,
        COALESCE(SUM(f.usage_count), 0) AS total_feature_uses,
        COUNT(DISTINCT f.feature_name) AS distinct_features
    FROM accounts a
    LEFT JOIN subscriptions s
        ON a.account_id = s.account_id
    LEFT JOIN feature_usage f
        ON s.subscription_id = f.subscription_id
    GROUP BY a.account_id, a.account_name, a.industry
)
SELECT
    CASE
        WHEN total_feature_uses = 0 THEN 'No Recorded Usage'
        WHEN total_feature_uses < 100 THEN 'Very Low Usage'
        WHEN total_feature_uses < 500 THEN 'Low Usage'
        WHEN total_feature_uses < 2000 THEN 'Moderate Usage'
        ELSE 'High Usage'
    END AS engagement_segment,
    COUNT(*) AS accounts,
    ROUND(AVG(total_feature_uses), 2)
        AS avg_feature_uses_per_account,
    ROUND(AVG(distinct_features), 2)
        AS avg_distinct_features
FROM account_engagement
GROUP BY 1
ORDER BY MIN(total_feature_uses);


-- ============================================================
-- QUERY 67: Feature Engagement vs Subscription Churn Flags
-- ============================================================

WITH subscription_engagement AS (
    SELECT
        s.subscription_id,
        s.churn_flag,
        s.mrr_amount,
        COUNT(f.usage_id) AS usage_records,
        COALESCE(SUM(f.usage_count), 0) AS total_feature_uses,
        COUNT(DISTINCT f.feature_name) AS distinct_features,
        COALESCE(SUM(f.error_count), 0) AS total_errors
    FROM subscriptions s
    LEFT JOIN feature_usage f
        ON s.subscription_id = f.subscription_id
    GROUP BY
        s.subscription_id,
        s.churn_flag,
        s.mrr_amount
)
SELECT
    CASE
        WHEN total_feature_uses = 0 THEN 'No Usage'
        WHEN total_feature_uses < 100 THEN 'Very Low'
        WHEN total_feature_uses < 500 THEN 'Low'
        WHEN total_feature_uses < 2000 THEN 'Moderate'
        ELSE 'High'
    END AS engagement_segment,
    COUNT(*) AS subscriptions,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_subscriptions,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS churn_flag_percentage,
    ROUND(AVG(distinct_features), 2)
        AS avg_distinct_features,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscription_engagement
GROUP BY 1
ORDER BY MIN(total_feature_uses);


-- ============================================================
-- QUERY 68: Feature Adoption by Customer Industry
-- ============================================================

SELECT
    a.industry,
    COUNT(DISTINCT a.account_id) AS accounts_with_usage,
    COUNT(DISTINCT f.subscription_id)
        AS subscriptions_with_usage,
    COUNT(DISTINCT f.feature_name) AS distinct_features,
    COUNT(f.usage_id) AS usage_records,
    SUM(f.usage_count) AS total_feature_uses,
    ROUND(SUM(f.usage_duration_secs) / 3600.0, 2)
        AS total_usage_hours,
    SUM(f.error_count) AS total_errors
FROM feature_usage f
JOIN subscriptions s
    ON f.subscription_id = s.subscription_id
JOIN accounts a
    ON s.account_id = a.account_id
GROUP BY a.industry
ORDER BY total_feature_uses DESC;


-- ============================================================
-- QUERY 69: Support Ticket Data Profiling
-- ============================================================

SELECT
    COUNT(*) AS total_tickets,
    COUNT(DISTINCT ticket_id) AS unique_ticket_ids,
    COUNT(DISTINCT account_id) AS accounts_with_tickets,
    MIN(submitted_at) AS earliest_ticket_date,
    MAX(submitted_at) AS latest_ticket_date,
    SUM(CASE WHEN closed_at IS NOT NULL THEN 1 ELSE 0 END)
        AS closed_tickets,
    SUM(CASE WHEN closed_at IS NULL THEN 1 ELSE 0 END)
        AS tickets_without_closed_at,
    SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
        AS escalated_tickets,
    SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END)
        AS missing_satisfaction_scores
FROM support_tickets;


-- ============================================================
-- QUERY 70: Monthly Support Ticket Trends
-- ============================================================

SELECT
    DATE_TRUNC('month', submitted_at)::DATE AS ticket_month,
    COUNT(*) AS total_tickets,
    COUNT(DISTINCT account_id) AS affected_accounts,
    SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
        AS escalated_tickets,
    ROUND(
        100.0 *
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS escalation_percentage,
    ROUND(AVG(first_response_time_minutes), 2)
        AS avg_first_response_minutes
FROM support_tickets
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 71: Support Ticket Priority Analysis
-- ============================================================

SELECT
    priority,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
        AS escalated_tickets,
    ROUND(
        100.0 *
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS escalation_percentage,
    ROUND(AVG(first_response_time_minutes), 2)
        AS avg_first_response_minutes,
    ROUND(AVG(resolution_time_hours), 2)
        AS avg_resolution_hours
FROM support_tickets
GROUP BY priority
ORDER BY total_tickets DESC;


-- ============================================================
-- QUERY 72: Support Resolution Performance
-- ============================================================

SELECT
    CASE
        WHEN closed_at IS NULL THEN 'No Closure Timestamp'
        WHEN resolution_time_hours IS NULL THEN 'Missing Resolution Time'
        WHEN resolution_time_hours < 4 THEN 'Under 4 Hours'
        WHEN resolution_time_hours < 12 THEN '4–12 Hours'
        WHEN resolution_time_hours < 24 THEN '12–24 Hours'
        WHEN resolution_time_hours < 48 THEN '24–48 Hours'
        ELSE '48+ Hours'
    END AS resolution_segment,
    COUNT(*) AS tickets,
    ROUND(AVG(resolution_time_hours), 2)
        AS avg_resolution_hours,
    ROUND(AVG(first_response_time_minutes), 2)
        AS avg_first_response_minutes,
    SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
        AS escalated_tickets
FROM support_tickets
GROUP BY 1
ORDER BY tickets DESC;


-- ============================================================
-- QUERY 73: Customer Satisfaction Analysis
-- ============================================================

SELECT
    priority,
    COUNT(*) AS total_tickets,
    COUNT(satisfaction_score) AS rated_tickets,
    SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END)
        AS unrated_tickets,
    ROUND(AVG(satisfaction_score), 2)
        AS avg_satisfaction_score,
    ROUND(AVG(resolution_time_hours), 2)
        AS avg_resolution_hours,
    ROUND(
        100.0 * COUNT(satisfaction_score) /
        NULLIF(COUNT(*), 0),
        2
    ) AS satisfaction_response_percentage
FROM support_tickets
GROUP BY priority
ORDER BY avg_satisfaction_score DESC NULLS LAST;


-- ============================================================
-- QUERY 74: Support Activity vs Account Churn Flags
-- ============================================================

WITH account_support AS (
    SELECT
        account_id,
        COUNT(*) AS ticket_count,
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
            AS escalated_tickets,
        AVG(satisfaction_score) AS avg_satisfaction
    FROM support_tickets
    GROUP BY account_id
)
SELECT
    CASE
        WHEN COALESCE(t.ticket_count, 0) = 0 THEN 'No Tickets'
        WHEN t.ticket_count = 1 THEN '1 Ticket'
        WHEN t.ticket_count BETWEEN 2 AND 3 THEN '2–3 Tickets'
        WHEN t.ticket_count BETWEEN 4 AND 6 THEN '4–6 Tickets'
        ELSE '7+ Tickets'
    END AS support_segment,
    COUNT(*) AS accounts,
    SUM(CASE WHEN a.churn_flag THEN 1 ELSE 0 END)
        AS account_churn_flagged,
    ROUND(
        100.0 *
        SUM(CASE WHEN a.churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS account_churn_flag_percentage,
    ROUND(AVG(COALESCE(t.ticket_count, 0)), 2)
        AS avg_tickets_per_account,
    ROUND(AVG(t.avg_satisfaction), 2)
        AS avg_satisfaction
FROM accounts a
LEFT JOIN account_support t
    ON a.account_id = t.account_id
GROUP BY 1
ORDER BY MIN(COALESCE(t.ticket_count, 0));


-- ============================================================
-- QUERY 75: Combined Engagement and Support Risk Segmentation
-- ============================================================

WITH account_engagement AS (
    SELECT
        s.account_id,
        COALESCE(SUM(f.usage_count), 0) AS total_feature_uses,
        COALESCE(SUM(f.error_count), 0) AS total_errors
    FROM subscriptions s
    LEFT JOIN feature_usage f
        ON s.subscription_id = f.subscription_id
    GROUP BY s.account_id
),
account_support AS (
    SELECT
        account_id,
        COUNT(*) AS ticket_count,
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
            AS escalated_tickets
    FROM support_tickets
    GROUP BY account_id
),
account_metrics AS (
    SELECT
        a.account_id,
        a.churn_flag,
        COALESCE(e.total_feature_uses, 0) AS total_feature_uses,
        COALESCE(e.total_errors, 0) AS total_errors,
        COALESCE(t.ticket_count, 0) AS ticket_count,
        COALESCE(t.escalated_tickets, 0) AS escalated_tickets
    FROM accounts a
    LEFT JOIN account_engagement e
        ON a.account_id = e.account_id
    LEFT JOIN account_support t
        ON a.account_id = t.account_id
),
risk_segments AS (
    SELECT
        *,
        CASE
            WHEN total_feature_uses < 100
                 AND (ticket_count >= 4 OR escalated_tickets >= 1)
                THEN 'High Attention'
            WHEN total_feature_uses < 500
                 OR escalated_tickets >= 2
                THEN 'Elevated Attention'
            WHEN total_feature_uses < 2000
                 OR ticket_count >= 4
                THEN 'Moderate Attention'
            ELSE 'Standard Monitoring'
        END AS attention_segment
    FROM account_metrics
)
SELECT
    attention_segment,
    COUNT(*) AS accounts,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS account_churn_flagged,
    ROUND(
        100.0 *
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) /
        NULLIF(COUNT(*), 0),
        2
    ) AS account_churn_flag_percentage,
    ROUND(AVG(total_feature_uses), 2)
        AS avg_feature_uses,
    ROUND(AVG(ticket_count), 2)
        AS avg_support_tickets,
    SUM(escalated_tickets) AS total_escalations
FROM risk_segments
GROUP BY attention_segment
ORDER BY
    CASE attention_segment
        WHEN 'High Attention' THEN 1
        WHEN 'Elevated Attention' THEN 2
        WHEN 'Moderate Attention' THEN 3
        ELSE 4
    END;


-- ============================================================
-- PROJECT 20: SaaS Revenue & Subscription Analytics
-- DAY 5: Advanced Revenue, Retention & Lifecycle Analytics
-- Queries 76–90
-- ============================================================


-- ============================================================
-- QUERY 76: Subscription Revenue and Lifecycle Overview
-- ============================================================

SELECT
    COUNT(*) AS total_subscription_records,
    COUNT(DISTINCT account_id) AS total_accounts,
    SUM(mrr_amount) AS total_recorded_mrr,
    SUM(arr_amount) AS total_recorded_arr,
    ROUND(AVG(mrr_amount), 2) AS avg_mrr_per_subscription,
    SUM(CASE WHEN is_trial THEN 1 ELSE 0 END)
        AS trial_subscriptions,
    SUM(CASE WHEN NOT is_trial THEN 1 ELSE 0 END)
        AS paid_subscriptions,
    SUM(CASE WHEN upgrade_flag THEN 1 ELSE 0 END)
        AS upgrade_flagged_records,
    SUM(CASE WHEN downgrade_flag THEN 1 ELSE 0 END)
        AS downgrade_flagged_records,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions;


-- ============================================================
-- QUERY 77: Upgrade and Downgrade Revenue Exposure
-- ============================================================

WITH movement_flags AS (
    SELECT
        *,
        CASE
            WHEN upgrade_flag AND downgrade_flag
                THEN 'Both Upgrade and Downgrade'
            WHEN upgrade_flag
                THEN 'Upgrade Only'
            WHEN downgrade_flag
                THEN 'Downgrade Only'
            ELSE 'Neither'
        END AS movement_category
    FROM subscriptions
)
SELECT
    movement_category,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS accounts,
    SUM(mrr_amount) AS recorded_mrr,
    ROUND(AVG(mrr_amount), 2) AS avg_recorded_mrr,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS churn_flag_percentage
FROM movement_flags
GROUP BY movement_category
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 78: Revenue Movement Flags by Plan Tier
-- ============================================================

SELECT
    plan_tier,
    COUNT(*) AS subscription_records,
    SUM(mrr_amount) AS recorded_mrr,
    SUM(CASE WHEN upgrade_flag THEN 1 ELSE 0 END)
        AS upgrade_flagged_records,
    SUM(CASE WHEN downgrade_flag THEN 1 ELSE 0 END)
        AS downgrade_flagged_records,
    SUM(CASE WHEN upgrade_flag THEN mrr_amount ELSE 0 END)
        AS upgrade_associated_mrr,
    SUM(CASE WHEN downgrade_flag THEN mrr_amount ELSE 0 END)
        AS downgrade_associated_mrr,
    ROUND(
        100.0 * SUM(CASE WHEN upgrade_flag THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS upgrade_flag_percentage,
    ROUND(
        100.0 * SUM(CASE WHEN downgrade_flag THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS downgrade_flag_percentage
FROM subscriptions
GROUP BY plan_tier
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 79: Revenue Movement Flags by Industry
-- ============================================================

SELECT
    a.industry,
    COUNT(DISTINCT a.account_id) AS accounts,
    COUNT(s.subscription_id) AS subscription_records,
    SUM(s.mrr_amount) AS recorded_mrr,
    SUM(CASE WHEN s.upgrade_flag THEN 1 ELSE 0 END)
        AS upgrade_flagged_records,
    SUM(CASE WHEN s.downgrade_flag THEN 1 ELSE 0 END)
        AS downgrade_flagged_records,
    SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    SUM(CASE WHEN s.churn_flag THEN s.mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM accounts a
JOIN subscriptions s
    ON a.account_id = s.account_id
GROUP BY a.industry
ORDER BY recorded_mrr DESC;


-- ============================================================
-- QUERY 80: Customer Expansion and Contraction Flag Patterns
-- ============================================================

WITH account_movements AS (
    SELECT
        account_id,
        COUNT(*) AS subscription_records,
        SUM(mrr_amount) AS recorded_mrr,
        SUM(CASE WHEN upgrade_flag THEN 1 ELSE 0 END)
            AS upgrade_records,
        SUM(CASE WHEN downgrade_flag THEN 1 ELSE 0 END)
            AS downgrade_records
    FROM subscriptions
    GROUP BY account_id
)
SELECT
    CASE
        WHEN upgrade_records > 0 AND downgrade_records > 0
            THEN 'Both Movement Types'
        WHEN upgrade_records > 0
            THEN 'Upgrade Flags Only'
        WHEN downgrade_records > 0
            THEN 'Downgrade Flags Only'
        ELSE 'No Movement Flags'
    END AS account_movement_segment,
    COUNT(*) AS accounts,
    SUM(subscription_records) AS subscription_records,
    SUM(recorded_mrr) AS recorded_mrr,
    ROUND(AVG(recorded_mrr), 2) AS avg_account_recorded_mrr
FROM account_movements
GROUP BY 1
ORDER BY accounts DESC;


-- ============================================================
-- QUERY 81: Account Revenue Exposure and Subscription Churn
-- ============================================================

WITH account_revenue AS (
    SELECT
        account_id,
        COUNT(*) AS subscription_records,
        SUM(mrr_amount) AS recorded_mrr,
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
            AS churn_flagged_records,
        SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
            AS churn_flagged_mrr
    FROM subscriptions
    GROUP BY account_id
)
SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    r.subscription_records,
    r.recorded_mrr,
    r.churn_flagged_records,
    r.churn_flagged_mrr,
    ROUND(
        100.0 * r.churn_flagged_mrr
        / NULLIF(r.recorded_mrr, 0), 2
    ) AS churn_associated_mrr_percentage
FROM account_revenue r
JOIN accounts a
    ON r.account_id = a.account_id
ORDER BY r.churn_flagged_mrr DESC, r.recorded_mrr DESC
LIMIT 20;


-- ============================================================
-- QUERY 82: Churn Event and Reactivation Overview
-- ============================================================

SELECT
    COUNT(*) AS total_churn_events,
    COUNT(DISTINCT churn_event_id) AS unique_churn_events,
    COUNT(DISTINCT account_id) AS accounts_with_churn_events,
    SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        AS reactivation_flagged_events,
    SUM(CASE WHEN NOT is_reactivation THEN 1 ELSE 0 END)
        AS non_reactivation_events,
    SUM(CASE WHEN is_reactivation IS NULL THEN 1 ELSE 0 END)
        AS missing_reactivation_flags,
    ROUND(
        100.0 * SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS reactivation_event_percentage
FROM churn_events;


-- ============================================================
-- QUERY 83: Reactivation Trends by Churn Event Month
-- ============================================================

SELECT
    DATE_TRUNC('month', churn_date)::DATE AS event_month,
    COUNT(*) AS churn_events,
    SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        AS reactivation_flagged_events,
    COUNT(DISTINCT CASE WHEN is_reactivation THEN account_id END)
        AS accounts_with_reactivation_flag,
    ROUND(
        100.0 * SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS reactivation_event_percentage
FROM churn_events
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 84: Reactivation by Churn Reason
-- ============================================================

SELECT
    reason_code,
    COUNT(*) AS churn_events,
    COUNT(DISTINCT account_id) AS affected_accounts,
    SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        AS reactivation_flagged_events,
    ROUND(
        100.0 * SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS reactivation_event_percentage,
    SUM(CASE WHEN preceding_downgrade_flag THEN 1 ELSE 0 END)
        AS events_with_preceding_downgrade
FROM churn_events
GROUP BY reason_code
ORDER BY churn_events DESC;


-- ============================================================
-- QUERY 85: Customer Signup Cohort and Churn Flag Analysis
-- ============================================================

SELECT
    DATE_TRUNC('month', signup_date)::DATE AS signup_cohort,
    COUNT(*) AS customer_accounts,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_accounts,
    ROUND(
        100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS account_churn_flag_percentage,
    MIN(signup_date) AS first_signup_date,
    MAX(signup_date) AS last_signup_date
FROM accounts
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 86: Subscription Start-Year Cohort Analysis
-- ============================================================

SELECT
    EXTRACT(YEAR FROM start_date) AS start_year,
    COUNT(*) AS subscription_records,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        AS churn_flagged_records,
    ROUND(
        100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0), 2
    ) AS churn_flag_percentage,
    SUM(mrr_amount) AS recorded_mrr,
    SUM(CASE WHEN churn_flag THEN mrr_amount ELSE 0 END)
        AS churn_flagged_mrr
FROM subscriptions
GROUP BY 1
ORDER BY 1;


-- ============================================================
-- QUERY 87: Revenue Concentration by Account Ranking
-- ============================================================

WITH account_revenue AS (
    SELECT
        account_id,
        SUM(mrr_amount) AS recorded_mrr
    FROM subscriptions
    GROUP BY account_id
),
ranked_accounts AS (
    SELECT
        account_id,
        recorded_mrr,
        ROW_NUMBER() OVER (
            ORDER BY recorded_mrr DESC, account_id
        ) AS revenue_rank
    FROM account_revenue
)
SELECT
    CASE
        WHEN revenue_rank <= 10 THEN 'Top 10'
        WHEN revenue_rank <= 50 THEN 'Rank 11–50'
        WHEN revenue_rank <= 100 THEN 'Rank 51–100'
        ELSE 'Remaining Accounts'
    END AS revenue_segment,
    COUNT(*) AS accounts,
    SUM(recorded_mrr) AS recorded_mrr,
    ROUND(
        100.0 * SUM(recorded_mrr)
        / NULLIF((SELECT SUM(recorded_mrr) FROM account_revenue), 0),
        2
    ) AS share_of_total_recorded_mrr
FROM ranked_accounts
GROUP BY 1
ORDER BY MIN(revenue_rank);


-- ============================================================
-- QUERY 88: Customer Lifetime Value Proxy
-- ============================================================

WITH account_summary AS (
    SELECT
        a.account_id,
        a.account_name,
        a.industry,
        COUNT(s.subscription_id) AS subscription_records,
        SUM(s.mrr_amount) AS recorded_mrr,
        MIN(s.start_date) AS first_subscription_date,
        MAX(s.start_date) AS latest_subscription_start,
        SUM(CASE WHEN s.churn_flag THEN 1 ELSE 0 END)
            AS churn_flagged_records
    FROM accounts a
    JOIN subscriptions s
        ON a.account_id = s.account_id
    GROUP BY a.account_id, a.account_name, a.industry
)
SELECT
    account_id,
    account_name,
    industry,
    subscription_records,
    recorded_mrr,
    recorded_mrr * 12 AS annualized_recorded_mrr_proxy,
    first_subscription_date,
    latest_subscription_start,
    churn_flagged_records
FROM account_summary
ORDER BY annualized_recorded_mrr_proxy DESC
LIMIT 20;


-- ============================================================
-- QUERY 89: Multi-Factor Customer Health Assessment
-- ============================================================

WITH subscription_metrics AS (
    SELECT
        account_id,
        COUNT(*) AS subscription_records,
        SUM(mrr_amount) AS recorded_mrr,
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
            AS churn_flagged_records
    FROM subscriptions
    GROUP BY account_id
),
engagement_metrics AS (
    SELECT
        s.account_id,
        COALESCE(SUM(f.usage_count), 0) AS total_feature_uses,
        COALESCE(SUM(f.error_count), 0) AS total_feature_errors
    FROM subscriptions s
    LEFT JOIN feature_usage f
        ON s.subscription_id = f.subscription_id
    GROUP BY s.account_id
),
support_metrics AS (
    SELECT
        account_id,
        COUNT(*) AS support_tickets,
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
            AS escalations,
        AVG(satisfaction_score) AS avg_satisfaction
    FROM support_tickets
    GROUP BY account_id
),
account_health AS (
    SELECT
        a.account_id,
        a.account_name,
        a.industry,
        a.churn_flag AS account_churn_flag,
        COALESCE(s.subscription_records, 0) AS subscription_records,
        COALESCE(s.recorded_mrr, 0) AS recorded_mrr,
        COALESCE(s.churn_flagged_records, 0) AS churn_flagged_records,
        COALESCE(e.total_feature_uses, 0) AS total_feature_uses,
        COALESCE(e.total_feature_errors, 0) AS total_feature_errors,
        COALESCE(t.support_tickets, 0) AS support_tickets,
        COALESCE(t.escalations, 0) AS escalations,
        t.avg_satisfaction
    FROM accounts a
    LEFT JOIN subscription_metrics s
        ON a.account_id = s.account_id
    LEFT JOIN engagement_metrics e
        ON a.account_id = e.account_id
    LEFT JOIN support_metrics t
        ON a.account_id = t.account_id
),
scored_accounts AS (
    SELECT
        *,
        CASE
            WHEN total_feature_uses < 250 THEN 2
            WHEN total_feature_uses < 500 THEN 1
            ELSE 0
        END
        + CASE
            WHEN escalations >= 2 THEN 2
            WHEN escalations = 1 THEN 1
            ELSE 0
        END
        + CASE
            WHEN avg_satisfaction < 3 THEN 2
            WHEN avg_satisfaction < 4 THEN 1
            ELSE 0
        END
        + CASE
            WHEN churn_flagged_records > 0 THEN 2
            ELSE 0
        END AS health_attention_score
    FROM account_health
)
SELECT
    CASE
        WHEN health_attention_score >= 5 THEN 'High Attention'
        WHEN health_attention_score >= 3 THEN 'Elevated Attention'
        WHEN health_attention_score >= 1 THEN 'Moderate Attention'
        ELSE 'Standard Monitoring'
    END AS health_segment,
    COUNT(*) AS accounts,
    SUM(CASE WHEN account_churn_flag THEN 1 ELSE 0 END)
        AS account_churn_flagged,
    ROUND(AVG(recorded_mrr), 2) AS avg_recorded_mrr,
    ROUND(AVG(total_feature_uses), 2) AS avg_feature_uses,
    ROUND(AVG(support_tickets), 2) AS avg_support_tickets,
    ROUND(AVG(health_attention_score), 2)
        AS avg_attention_score
FROM scored_accounts
GROUP BY 1
ORDER BY
    CASE health_segment
        WHEN 'High Attention' THEN 1
        WHEN 'Elevated Attention' THEN 2
        WHEN 'Moderate Attention' THEN 3
        ELSE 4
    END;


-- ============================================================
-- QUERY 90: Executive SaaS Performance Scorecard
-- ============================================================

WITH subscription_kpis AS (
    SELECT
        COUNT(*) AS subscription_records,
        COUNT(DISTINCT account_id) AS accounts_with_subscriptions,
        SUM(mrr_amount) AS recorded_mrr,
        SUM(arr_amount) AS recorded_arr,
        SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)
            AS churn_flagged_records,
        SUM(CASE WHEN upgrade_flag THEN 1 ELSE 0 END)
            AS upgrade_flagged_records,
        SUM(CASE WHEN downgrade_flag THEN 1 ELSE 0 END)
            AS downgrade_flagged_records
    FROM subscriptions
),
usage_kpis AS (
    SELECT
        COUNT(*) AS usage_records,
        COUNT(DISTINCT subscription_id) AS subscriptions_with_usage,
        SUM(usage_count) AS total_feature_uses,
        SUM(error_count) AS total_feature_errors
    FROM feature_usage
),
support_kpis AS (
    SELECT
        COUNT(*) AS support_tickets,
        SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
            AS escalated_tickets,
        ROUND(AVG(resolution_time_hours), 2)
            AS avg_resolution_hours,
        ROUND(AVG(satisfaction_score), 2)
            AS avg_satisfaction
    FROM support_tickets
),
churn_kpis AS (
    SELECT
        COUNT(*) AS churn_events,
        COUNT(DISTINCT account_id) AS accounts_with_churn_events,
        SUM(CASE WHEN is_reactivation THEN 1 ELSE 0 END)
            AS reactivation_flagged_events
    FROM churn_events
)
SELECT
    s.*,
    ROUND(
        100.0 * s.churn_flagged_records
        / NULLIF(s.subscription_records, 0), 2
    ) AS subscription_churn_flag_percentage,
    u.*,
    t.*,
    c.*
FROM subscription_kpis s
CROSS JOIN usage_kpis u
CROSS JOIN support_kpis t
CROSS JOIN churn_kpis c;
