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