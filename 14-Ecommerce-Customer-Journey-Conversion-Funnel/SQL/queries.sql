-- ============================================================
-- Project 14: E-Commerce Customer Journey & Conversion Funnel
-- Day 1: Dataset Overview & Data Quality Analysis
-- ============================================================


-- 1. Total Journey Events
SELECT
    COUNT(*) AS total_events
FROM customer_journey;


-- 2. Unique Users and Sessions
SELECT
    COUNT(DISTINCT UserID) AS unique_users,
    COUNT(DISTINCT SessionID) AS unique_sessions
FROM customer_journey;


-- 3. Dataset Date Range
SELECT
    MIN(Timestamp) AS first_event,
    MAX(Timestamp) AS last_event
FROM customer_journey;


-- 4. Events by Page Type
SELECT
    PageType,
    COUNT(*) AS total_events
FROM customer_journey
GROUP BY PageType
ORDER BY total_events DESC;


-- 5. Sessions by Device Type
SELECT
    DeviceType,
    COUNT(DISTINCT SessionID) AS total_sessions
FROM customer_journey
GROUP BY DeviceType
ORDER BY total_sessions DESC;


-- 6. Sessions by Referral Source
SELECT
    ReferralSource,
    COUNT(DISTINCT SessionID) AS total_sessions
FROM customer_journey
GROUP BY ReferralSource
ORDER BY total_sessions DESC;


-- 7. Users by Country
SELECT
    Country,
    COUNT(DISTINCT UserID) AS unique_users
FROM customer_journey
GROUP BY Country
ORDER BY unique_users DESC;


-- 8. Purchase Event Overview
SELECT
    Purchased,
    COUNT(*) AS total_events
FROM customer_journey
GROUP BY Purchased
ORDER BY Purchased;


-- 9. Average Time Spent by Page Type
SELECT
    PageType,
    ROUND(AVG(TimeOnPage_seconds), 2) AS avg_time_on_page_seconds
FROM customer_journey
GROUP BY PageType
ORDER BY avg_time_on_page_seconds DESC;


-- 10. Cart Activity Overview
SELECT
    ROUND(AVG(ItemsInCart), 2) AS avg_items_in_cart,
    MAX(ItemsInCart) AS max_items_in_cart,
    SUM(CASE WHEN ItemsInCart > 0 THEN 1 ELSE 0 END) AS events_with_items_in_cart
FROM customer_journey;

-- ============================================================
-- Day 2: Customer Journey & Behavioral Analysis
-- ============================================================


-- 11. Sessions per User
SELECT
    ROUND(AVG(session_count), 2) AS avg_sessions_per_user,
    MAX(session_count) AS max_sessions_per_user
FROM (
    SELECT
        UserID,
        COUNT(DISTINCT SessionID) AS session_count
    FROM customer_journey
    GROUP BY UserID
);


-- 12. New vs Repeat Users
WITH user_sessions AS (
    SELECT
        UserID,
        COUNT(DISTINCT SessionID) AS session_count
    FROM customer_journey
    GROUP BY UserID
)
SELECT
    CASE
        WHEN session_count = 1 THEN 'Single Session User'
        ELSE 'Repeat User'
    END AS user_type,
    COUNT(*) AS total_users,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS user_percentage
FROM user_sessions
GROUP BY user_type
ORDER BY total_users DESC;


-- 13. Average Events per Session
WITH session_activity AS (
    SELECT
        SessionID,
        COUNT(*) AS total_events
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    ROUND(AVG(total_events), 2) AS avg_events_per_session,
    MIN(total_events) AS min_events_per_session,
    MAX(total_events) AS max_events_per_session
FROM session_activity;


-- 14. Session Duration Analysis
WITH session_duration AS (
    SELECT
        SessionID,
        MIN(Timestamp) AS session_start,
        MAX(Timestamp) AS session_end,
        DATE_DIFF(
            'second',
            MIN(Timestamp),
            MAX(Timestamp)
        ) AS duration_seconds
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    ROUND(AVG(duration_seconds), 2) AS avg_session_duration_seconds,
    ROUND(AVG(duration_seconds) / 60.0, 2) AS avg_session_duration_minutes,
    MAX(duration_seconds) AS max_session_duration_seconds
FROM session_duration;


-- 15. Most Common Customer Journey Paths
WITH session_paths AS (
    SELECT
        SessionID,
        STRING_AGG(PageType, ' -> ' ORDER BY Timestamp) AS journey_path
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    journey_path,
    COUNT(*) AS total_sessions
FROM session_paths
GROUP BY journey_path
ORDER BY total_sessions DESC
LIMIT 10;


-- 16. Session-Level Purchase Behavior
WITH session_purchase AS (
    SELECT
        SessionID,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    CASE
        WHEN purchased = 1 THEN 'Purchased Session'
        ELSE 'Non-Purchased Session'
    END AS session_type,
    COUNT(*) AS total_sessions,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS session_percentage
FROM session_purchase
GROUP BY session_type
ORDER BY total_sessions DESC;


-- 17. Engagement: Purchased vs Non-Purchased Sessions
WITH session_metrics AS (
    SELECT
        SessionID,
        MAX(Purchased) AS purchased,
        COUNT(*) AS total_events,
        SUM(TimeOnPage_seconds) AS total_time_on_page,
        MAX(ItemsInCart) AS max_items_in_cart
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    CASE
        WHEN purchased = 1 THEN 'Purchased Session'
        ELSE 'Non-Purchased Session'
    END AS session_type,
    COUNT(*) AS total_sessions,
    ROUND(AVG(total_events), 2) AS avg_events_per_session,
    ROUND(AVG(total_time_on_page), 2) AS avg_time_on_page_seconds,
    ROUND(AVG(max_items_in_cart), 2) AS avg_max_items_in_cart
FROM session_metrics
GROUP BY session_type
ORDER BY total_sessions DESC;


-- 18. Device-Level Session Engagement
WITH session_metrics AS (
    SELECT
        SessionID,
        DeviceType,
        COUNT(*) AS total_events,
        SUM(TimeOnPage_seconds) AS total_time_on_page,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID, DeviceType
)
SELECT
    DeviceType,
    COUNT(*) AS total_sessions,
    ROUND(AVG(total_events), 2) AS avg_events_per_session,
    ROUND(AVG(total_time_on_page), 2) AS avg_time_on_page_seconds,
    SUM(purchased) AS purchased_sessions
FROM session_metrics
GROUP BY DeviceType
ORDER BY total_sessions DESC;


-- 19. Referral Source Session Engagement
WITH session_metrics AS (
    SELECT
        SessionID,
        ReferralSource,
        COUNT(*) AS total_events,
        SUM(TimeOnPage_seconds) AS total_time_on_page,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID, ReferralSource
)
SELECT
    ReferralSource,
    COUNT(*) AS total_sessions,
    ROUND(AVG(total_events), 2) AS avg_events_per_session,
    ROUND(AVG(total_time_on_page), 2) AS avg_time_on_page_seconds,
    SUM(purchased) AS purchased_sessions
FROM session_metrics
GROUP BY ReferralSource
ORDER BY total_sessions DESC;


-- 20. Cart Behavior by Session
WITH cart_behavior AS (
    SELECT
        SessionID,
        MAX(ItemsInCart) AS max_items_in_cart,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    max_items_in_cart,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS purchase_rate_percentage
FROM cart_behavior
GROUP BY max_items_in_cart
ORDER BY max_items_in_cart;