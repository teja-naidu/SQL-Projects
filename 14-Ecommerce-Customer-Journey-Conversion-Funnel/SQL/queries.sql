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


-- ============================================================
-- Day 3: Conversion Funnel & Drop-Off Analysis
-- ============================================================


-- 21. Session-Level Conversion Funnel
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home' THEN 1 ELSE 0 END) AS reached_home,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END) AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END) AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END) AS reached_checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END) AS reached_confirmation
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    SUM(reached_home) AS home_sessions,
    SUM(reached_product) AS product_sessions,
    SUM(reached_cart) AS cart_sessions,
    SUM(reached_checkout) AS checkout_sessions,
    SUM(reached_confirmation) AS confirmation_sessions
FROM session_stages;


-- 22. Funnel Stage Reach Rate
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home' THEN 1 ELSE 0 END) AS reached_home,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END) AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END) AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END) AS reached_checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END) AS reached_confirmation
    FROM customer_journey
    GROUP BY SessionID
),
funnel AS (
    SELECT
        SUM(reached_home) AS home_sessions,
        SUM(reached_product) AS product_sessions,
        SUM(reached_cart) AS cart_sessions,
        SUM(reached_checkout) AS checkout_sessions,
        SUM(reached_confirmation) AS confirmation_sessions
    FROM session_stages
)
SELECT 'Home' AS funnel_stage,
       home_sessions AS sessions,
       100.00 AS reach_rate_percentage
FROM funnel

UNION ALL

SELECT 'Product Page',
       product_sessions,
       ROUND(product_sessions * 100.0 / home_sessions, 2)
FROM funnel

UNION ALL

SELECT 'Cart',
       cart_sessions,
       ROUND(cart_sessions * 100.0 / home_sessions, 2)
FROM funnel

UNION ALL

SELECT 'Checkout',
       checkout_sessions,
       ROUND(checkout_sessions * 100.0 / home_sessions, 2)
FROM funnel

UNION ALL

SELECT 'Confirmation',
       confirmation_sessions,
       ROUND(confirmation_sessions * 100.0 / home_sessions, 2)
FROM funnel;


-- 23. Stage-to-Stage Conversion and Drop-Off
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home' THEN 1 ELSE 0 END) AS home,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END) AS product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END) AS cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END) AS checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END) AS confirmation
    FROM customer_journey
    GROUP BY SessionID
),
counts AS (
    SELECT
        SUM(home) AS home_sessions,
        SUM(product) AS product_sessions,
        SUM(cart) AS cart_sessions,
        SUM(checkout) AS checkout_sessions,
        SUM(confirmation) AS confirmation_sessions
    FROM session_stages
)
SELECT
    'Home -> Product Page' AS transition,
    home_sessions AS starting_sessions,
    product_sessions AS continuing_sessions,
    home_sessions - product_sessions AS dropped_sessions,
    ROUND(product_sessions * 100.0 / home_sessions, 2)
        AS conversion_rate_percentage,
    ROUND((home_sessions - product_sessions) * 100.0 / home_sessions, 2)
        AS drop_off_rate_percentage
FROM counts

UNION ALL

SELECT
    'Product Page -> Cart',
    product_sessions,
    cart_sessions,
    product_sessions - cart_sessions,
    ROUND(cart_sessions * 100.0 / product_sessions, 2),
    ROUND((product_sessions - cart_sessions) * 100.0 / product_sessions, 2)
FROM counts

UNION ALL

SELECT
    'Cart -> Checkout',
    cart_sessions,
    checkout_sessions,
    cart_sessions - checkout_sessions,
    ROUND(checkout_sessions * 100.0 / cart_sessions, 2),
    ROUND((cart_sessions - checkout_sessions) * 100.0 / cart_sessions, 2)
FROM counts

UNION ALL

SELECT
    'Checkout -> Confirmation',
    checkout_sessions,
    confirmation_sessions,
    checkout_sessions - confirmation_sessions,
    ROUND(confirmation_sessions * 100.0 / checkout_sessions, 2),
    ROUND((checkout_sessions - confirmation_sessions) * 100.0 / checkout_sessions, 2)
FROM counts;


-- 24. Overall Session Conversion Rate
WITH session_conversion AS (
    SELECT
        SessionID,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    COUNT(*) AS total_sessions,
    SUM(purchased) AS converted_sessions,
    COUNT(*) - SUM(purchased) AS non_converted_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS overall_conversion_rate_percentage
FROM session_conversion;


-- 25. Product Page Abandonment
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END)
            AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    SUM(reached_product) AS product_page_sessions,
    SUM(
        CASE
            WHEN reached_product = 1 AND reached_cart = 0 THEN 1
            ELSE 0
        END
    ) AS product_page_abandonments,
    ROUND(
        SUM(
            CASE
                WHEN reached_product = 1 AND reached_cart = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / SUM(reached_product),
        2
    ) AS product_page_abandonment_rate
FROM session_stages;


-- 26. Cart Abandonment Rate
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    SUM(reached_cart) AS cart_sessions,
    SUM(
        CASE
            WHEN reached_cart = 1 AND reached_checkout = 0 THEN 1
            ELSE 0
        END
    ) AS abandoned_cart_sessions,
    ROUND(
        SUM(
            CASE
                WHEN reached_cart = 1 AND reached_checkout = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / SUM(reached_cart),
        2
    ) AS cart_abandonment_rate_percentage
FROM session_stages;


-- 27. Checkout Abandonment Rate
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END)
            AS reached_confirmation
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    SUM(reached_checkout) AS checkout_sessions,
    SUM(
        CASE
            WHEN reached_checkout = 1
             AND reached_confirmation = 0 THEN 1
            ELSE 0
        END
    ) AS checkout_abandonments,
    ROUND(
        SUM(
            CASE
                WHEN reached_checkout = 1
                 AND reached_confirmation = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / SUM(reached_checkout),
        2
    ) AS checkout_abandonment_rate_percentage
FROM session_stages;


-- 28. Funnel Conversion by Device Type
WITH session_funnel AS (
    SELECT
        SessionID,
        MAX(DeviceType) AS device_type,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END)
            AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    device_type,
    COUNT(*) AS total_sessions,
    SUM(reached_product) AS product_sessions,
    SUM(reached_cart) AS cart_sessions,
    SUM(reached_checkout) AS checkout_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_funnel
GROUP BY device_type
ORDER BY conversion_rate_percentage DESC;


-- 29. Funnel Conversion by Referral Source
WITH session_funnel AS (
    SELECT
        SessionID,
        MAX(ReferralSource) AS referral_source,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END)
            AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    referral_source,
    COUNT(*) AS total_sessions,
    SUM(reached_product) AS product_sessions,
    SUM(reached_cart) AS cart_sessions,
    SUM(reached_checkout) AS checkout_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_funnel
GROUP BY referral_source
ORDER BY conversion_rate_percentage DESC;


-- 30. Conversion Rate: Repeat vs Single-Session Users
WITH user_sessions AS (
    SELECT
        UserID,
        COUNT(DISTINCT SessionID) AS user_session_count
    FROM customer_journey
    GROUP BY UserID
),
session_conversion AS (
    SELECT
        SessionID,
        UserID,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID, UserID
)
SELECT
    CASE
        WHEN u.user_session_count = 1 THEN 'Single Session User'
        ELSE 'Repeat User'
    END AS user_type,
    COUNT(*) AS total_sessions,
    SUM(s.purchased) AS purchased_sessions,
    ROUND(
        SUM(s.purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_conversion s
JOIN user_sessions u
    ON s.UserID = u.UserID
GROUP BY user_type
ORDER BY conversion_rate_percentage DESC;


-- ============================================================
-- Day 4: Segment, Channel & Trend Analysis
-- ============================================================


-- 31. Conversion Rate by Country
WITH session_metrics AS (
    SELECT
        SessionID,
        MAX(Country) AS country,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    country,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY country
ORDER BY conversion_rate_percentage DESC;


-- 32. Conversion by Device and Referral Source
WITH session_metrics AS (
    SELECT
        SessionID,
        MAX(DeviceType) AS device_type,
        MAX(ReferralSource) AS referral_source,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    device_type,
    referral_source,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY device_type, referral_source
ORDER BY conversion_rate_percentage DESC;


-- 33. Monthly Traffic and Conversion Trend
WITH session_metrics AS (
    SELECT
        SessionID,
        DATE_TRUNC('month', MIN(Timestamp)) AS session_month,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    session_month,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY session_month
ORDER BY session_month;


-- 34. Day-of-Week Conversion Performance
WITH session_metrics AS (
    SELECT
        SessionID,
        MIN(Timestamp) AS session_start,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    DAYNAME(session_start) AS day_of_week,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY
    DAYNAME(session_start),
    DAYOFWEEK(session_start)
ORDER BY DAYOFWEEK(session_start);


-- 35. Conversion by Time of Day
WITH session_metrics AS (
    SELECT
        SessionID,
        MIN(Timestamp) AS session_start,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM session_start) BETWEEN 0 AND 5
            THEN 'Late Night'
        WHEN EXTRACT(HOUR FROM session_start) BETWEEN 6 AND 11
            THEN 'Morning'
        WHEN EXTRACT(HOUR FROM session_start) BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_period,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY time_period
ORDER BY conversion_rate_percentage DESC;


-- 36. Conversion by Number of Events in Session
WITH session_metrics AS (
    SELECT
        SessionID,
        COUNT(*) AS events_in_session,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    events_in_session,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY events_in_session
ORDER BY events_in_session;


-- 37. Conversion by Total Engagement Time
WITH session_metrics AS (
    SELECT
        SessionID,
        SUM(TimeOnPage_seconds) AS total_engagement_seconds,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
),
engagement_segments AS (
    SELECT
        *,
        CASE
            WHEN total_engagement_seconds < 120
                THEN 'Under 2 Minutes'
            WHEN total_engagement_seconds < 300
                THEN '2-5 Minutes'
            WHEN total_engagement_seconds < 600
                THEN '5-10 Minutes'
            ELSE '10+ Minutes'
        END AS engagement_segment
    FROM session_metrics
)
SELECT
    engagement_segment,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM engagement_segments
GROUP BY engagement_segment
ORDER BY conversion_rate_percentage DESC;


-- 38. Product-to-Cart Rate by Country
WITH session_funnel AS (
    SELECT
        SessionID,
        MAX(Country) AS country,
        MAX(CASE
            WHEN PageType = 'product_page' THEN 1
            ELSE 0
        END) AS reached_product,
        MAX(CASE
            WHEN PageType = 'cart' THEN 1
            ELSE 0
        END) AS reached_cart
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    country,
    SUM(reached_product) AS product_sessions,
    SUM(reached_cart) AS cart_sessions,
    ROUND(
        SUM(reached_cart) * 100.0 /
        NULLIF(SUM(reached_product), 0),
        2
    ) AS product_to_cart_rate_percentage
FROM session_funnel
GROUP BY country
ORDER BY product_to_cart_rate_percentage DESC;


-- 39. Cart-to-Purchase Rate by Referral Source
WITH session_funnel AS (
    SELECT
        SessionID,
        MAX(ReferralSource) AS referral_source,
        MAX(CASE
            WHEN PageType = 'cart' THEN 1
            ELSE 0
        END) AS reached_cart,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    referral_source,
    SUM(reached_cart) AS cart_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 /
        NULLIF(SUM(reached_cart), 0),
        2
    ) AS cart_to_purchase_rate_percentage
FROM session_funnel
GROUP BY referral_source
ORDER BY cart_to_purchase_rate_percentage DESC;


-- 40. Monthly Funnel Performance
WITH session_funnel AS (
    SELECT
        SessionID,
        DATE_TRUNC('month', MIN(Timestamp)) AS session_month,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END)
            AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    session_month,
    COUNT(*) AS total_sessions,
    SUM(reached_product) AS product_sessions,
    SUM(reached_cart) AS cart_sessions,
    SUM(reached_checkout) AS checkout_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_funnel
GROUP BY session_month
ORDER BY session_month;

-- ============================================================
-- Day 5: Executive KPIs & Funnel Opportunity Analysis
-- ============================================================


-- 41. Executive KPI Summary
WITH session_metrics AS (
    SELECT
        SessionID,
        UserID,
        COUNT(*) AS total_events,
        SUM(TimeOnPage_seconds) AS total_engagement_seconds,
        MAX(ItemsInCart) AS max_items_in_cart,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID, UserID
)
SELECT
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT UserID) AS unique_users,
    SUM(purchased) AS purchased_sessions,
    COUNT(*) - SUM(purchased) AS non_purchased_sessions,
    ROUND(SUM(purchased) * 100.0 / COUNT(*), 2)
        AS conversion_rate_percentage,
    ROUND(AVG(total_events), 2)
        AS avg_events_per_session,
    ROUND(AVG(total_engagement_seconds), 2)
        AS avg_engagement_seconds,
    ROUND(AVG(max_items_in_cart), 2)
        AS avg_max_items_in_cart
FROM session_metrics;


-- 42. Funnel Loss Summary
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home' THEN 1 ELSE 0 END)
            AS reached_home,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END)
            AS reached_product,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END)
            AS reached_cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END)
            AS reached_checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END)
            AS reached_confirmation
    FROM customer_journey
    GROUP BY SessionID
),
funnel AS (
    SELECT
        SUM(reached_home) AS home_sessions,
        SUM(reached_product) AS product_sessions,
        SUM(reached_cart) AS cart_sessions,
        SUM(reached_checkout) AS checkout_sessions,
        SUM(reached_confirmation) AS confirmation_sessions
    FROM session_stages
)
SELECT
    'Home -> Product Page' AS transition,
    home_sessions - product_sessions AS lost_sessions,
    ROUND(
        (home_sessions - product_sessions) * 100.0 /
        home_sessions,
        2
    ) AS loss_rate_percentage
FROM funnel

UNION ALL

SELECT
    'Product Page -> Cart',
    product_sessions - cart_sessions,
    ROUND(
        (product_sessions - cart_sessions) * 100.0 /
        product_sessions,
        2
    )
FROM funnel

UNION ALL

SELECT
    'Cart -> Checkout',
    cart_sessions - checkout_sessions,
    ROUND(
        (cart_sessions - checkout_sessions) * 100.0 /
        cart_sessions,
        2
    )
FROM funnel

UNION ALL

SELECT
    'Checkout -> Confirmation',
    checkout_sessions - confirmation_sessions,
    ROUND(
        (checkout_sessions - confirmation_sessions) * 100.0 /
        checkout_sessions,
        2
    )
FROM funnel

ORDER BY lost_sessions DESC;


-- 43. Share of Total Non-Conversions by Exit Stage
WITH session_exit AS (
    SELECT
        SessionID,
        CASE
            WHEN MAX(CASE WHEN PageType = 'confirmation'
                          THEN 1 ELSE 0 END) = 1
                THEN 'Converted'

            WHEN MAX(CASE WHEN PageType = 'checkout'
                          THEN 1 ELSE 0 END) = 1
                THEN 'Checkout'

            WHEN MAX(CASE WHEN PageType = 'cart'
                          THEN 1 ELSE 0 END) = 1
                THEN 'Cart'

            WHEN MAX(CASE WHEN PageType = 'product_page'
                          THEN 1 ELSE 0 END) = 1
                THEN 'Product Page'

            ELSE 'Home'
        END AS exit_stage
    FROM customer_journey
    GROUP BY SessionID
),
non_converted AS (
    SELECT *
    FROM session_exit
    WHERE exit_stage <> 'Converted'
)
SELECT
    exit_stage,
    COUNT(*) AS lost_sessions,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS share_of_non_conversions_percentage
FROM non_converted
GROUP BY exit_stage
ORDER BY lost_sessions DESC;


-- 44. Product-to-Cart Opportunity Scenario
WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE
            WHEN PageType = 'product_page'
            THEN SessionID
        END) AS product_sessions,

        COUNT(DISTINCT CASE
            WHEN PageType = 'cart'
            THEN SessionID
        END) AS cart_sessions,

        COUNT(DISTINCT CASE
            WHEN PageType = 'confirmation'
            THEN SessionID
        END) AS purchased_sessions
    FROM customer_journey
),
metrics AS (
    SELECT
        *,
        cart_sessions * 1.0 / product_sessions
            AS current_product_to_cart_rate,

        purchased_sessions * 1.0 / cart_sessions
            AS current_cart_to_purchase_rate
    FROM funnel
)
SELECT
    product_sessions,
    cart_sessions,
    purchased_sessions,

    ROUND(current_product_to_cart_rate * 100, 2)
        AS current_product_to_cart_rate_percentage,

    ROUND(current_cart_to_purchase_rate * 100, 2)
        AS current_cart_to_purchase_rate_percentage,

    ROUND(product_sessions * 0.45)
        AS cart_sessions_at_45_percent,

    ROUND(
        product_sessions * 0.45 *
        current_cart_to_purchase_rate
    ) AS estimated_purchases_at_45_percent,

    ROUND(
        product_sessions * 0.45 *
        current_cart_to_purchase_rate
        - purchased_sessions
    ) AS estimated_incremental_purchases

FROM metrics;


-- 45. Conversion Performance by Cart Size
WITH session_metrics AS (
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
    COUNT(*) - SUM(purchased) AS non_purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY max_items_in_cart
ORDER BY max_items_in_cart;


-- 46. Converted Session Profile by Device
WITH converted_sessions AS (
    SELECT
        SessionID,
        MAX(DeviceType) AS device_type,
        SUM(TimeOnPage_seconds) AS engagement_seconds,
        MAX(ItemsInCart) AS max_items_in_cart,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    device_type,
    COUNT(*) AS converted_sessions,
    ROUND(AVG(engagement_seconds), 2)
        AS avg_engagement_seconds,
    ROUND(AVG(max_items_in_cart), 2)
        AS avg_max_items_in_cart
FROM converted_sessions
WHERE purchased = 1
GROUP BY device_type
ORDER BY converted_sessions DESC;


-- 47. Converted Session Profile by Referral Source
WITH converted_sessions AS (
    SELECT
        SessionID,
        MAX(ReferralSource) AS referral_source,
        SUM(TimeOnPage_seconds) AS engagement_seconds,
        MAX(ItemsInCart) AS max_items_in_cart,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    referral_source,
    COUNT(*) AS converted_sessions,
    ROUND(AVG(engagement_seconds), 2)
        AS avg_engagement_seconds,
    ROUND(AVG(max_items_in_cart), 2)
        AS avg_max_items_in_cart
FROM converted_sessions
WHERE purchased = 1
GROUP BY referral_source
ORDER BY converted_sessions DESC;


-- 48. Monthly Conversion Change
WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', session_start) AS session_month,
        COUNT(*) AS total_sessions,
        SUM(purchased) AS purchased_sessions
    FROM (
        SELECT
            SessionID,
            MIN(Timestamp) AS session_start,
            MAX(Purchased) AS purchased
        FROM customer_journey
        GROUP BY SessionID
    )
    GROUP BY session_month
),
conversion_metrics AS (
    SELECT
        session_month,
        total_sessions,
        purchased_sessions,
        ROUND(
            purchased_sessions * 100.0 / total_sessions,
            2
        ) AS conversion_rate
    FROM monthly_metrics
)
SELECT
    session_month,
    total_sessions,
    purchased_sessions,
    conversion_rate,
    ROUND(
        conversion_rate -
        LAG(conversion_rate) OVER (ORDER BY session_month),
        2
    ) AS conversion_rate_change_pp
FROM conversion_metrics
ORDER BY session_month;


-- 49. Best Observed Conversion Segments
WITH session_metrics AS (
    SELECT
        SessionID,
        MAX(Country) AS country,
        MAX(DeviceType) AS device_type,
        MAX(ReferralSource) AS referral_source,
        MAX(Purchased) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)
SELECT
    country,
    device_type,
    referral_source,
    COUNT(*) AS total_sessions,
    SUM(purchased) AS purchased_sessions,
    ROUND(
        SUM(purchased) * 100.0 / COUNT(*),
        2
    ) AS conversion_rate_percentage
FROM session_metrics
GROUP BY
    country,
    device_type,
    referral_source
HAVING COUNT(*) >= 40
ORDER BY conversion_rate_percentage DESC
LIMIT 10;


-- 50. Final Funnel KPI Summary
WITH session_stages AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home'
                 THEN 1 ELSE 0 END) AS home,
        MAX(CASE WHEN PageType = 'product_page'
                 THEN 1 ELSE 0 END) AS product,
        MAX(CASE WHEN PageType = 'cart'
                 THEN 1 ELSE 0 END) AS cart,
        MAX(CASE WHEN PageType = 'checkout'
                 THEN 1 ELSE 0 END) AS checkout,
        MAX(CASE WHEN PageType = 'confirmation'
                 THEN 1 ELSE 0 END) AS confirmation
    FROM customer_journey
    GROUP BY SessionID
),
funnel AS (
    SELECT
        SUM(home) AS home_sessions,
        SUM(product) AS product_sessions,
        SUM(cart) AS cart_sessions,
        SUM(checkout) AS checkout_sessions,
        SUM(confirmation) AS confirmation_sessions
    FROM session_stages
)
SELECT
    home_sessions AS total_sessions,
    confirmation_sessions AS converted_sessions,

    ROUND(
        confirmation_sessions * 100.0 /
        home_sessions,
        2
    ) AS overall_conversion_rate,

    ROUND(
        product_sessions * 100.0 /
        home_sessions,
        2
    ) AS home_to_product_rate,

    ROUND(
        cart_sessions * 100.0 /
        product_sessions,
        2
    ) AS product_to_cart_rate,

    ROUND(
        checkout_sessions * 100.0 /
        cart_sessions,
        2
    ) AS cart_to_checkout_rate,

    ROUND(
        confirmation_sessions * 100.0 /
        checkout_sessions,
        2
    ) AS checkout_to_confirmation_rate

FROM funnel;