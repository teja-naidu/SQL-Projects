# E-Commerce Customer Journey & Conversion Funnel Analytics

## Day 1 – Dataset Overview & Initial Exploration

### Dataset Summary

The dataset contains 12,719 customer journey events recorded across 5,000 unique sessions and 1,872 unique users.

The customer activity covers the period from January 1, 2025 through August 31, 2025.

### Customer Journey Events

The distribution of events across the customer journey is:

- Home: 5,000 events
- Product Page: 3,987 events
- Cart: 1,599 events
- Checkout: 1,123 events
- Confirmation: 1,010 events

The event distribution shows a progressive reduction in activity as customers move deeper into the purchasing journey.

The largest visible decline occurs between the Product Page and Cart stages, indicating that product-to-cart behavior will be an important area for deeper funnel analysis.

### Device Distribution

Customer sessions are almost evenly distributed across device types:

- Mobile: 1,671 sessions
- Desktop: 1,666 sessions
- Tablet: 1,663 sessions

This balanced distribution provides a strong basis for comparing conversion behavior across devices in later analysis.

### Referral Source Distribution

Google generated the highest number of sessions with 1,280, followed closely by:

- Email: 1,251 sessions
- Social Media: 1,243 sessions
- Direct: 1,226 sessions

Traffic acquisition is relatively balanced across all four referral sources.

### Geographic Coverage

The dataset contains customer activity from seven countries:

- UK
- France
- Germany
- Canada
- USA
- India
- Australia

The UK has the highest number of unique users in the initial country-level analysis.

### Page Engagement

Average time spent across page types remains relatively consistent at approximately 96–99 seconds.

Cart pages recorded the highest average time on page at 98.74 seconds, while confirmation pages recorded the lowest at 95.92 seconds.

### Cart Activity

The average number of items recorded in the cart across all events is 1.14, with a maximum of 5 items.

A total of 4,813 event records contained at least one item in the cart.

### Purchase Indicator

The dataset contains:

- 7,669 event records with Purchased = 0
- 5,050 event records with Purchased = 1

Because the dataset records multiple events within the same customer session, purchase-event counts should not be interpreted directly as the number of converted sessions.

Session-level conversion logic will be used in the funnel analysis to avoid double-counting purchases.

### Initial Business Observation

The dataset provides a complete view of the e-commerce journey from landing through purchase confirmation.

Initial event counts suggest that the Product Page to Cart transition may represent a major point of customer drop-off. Further analysis will measure conversion and abandonment at the session level and compare performance across customer, device, referral, and geographic segments.


---

## Day 2 – Customer Journey & Behavioral Analysis

### User Engagement and Repeat Behavior

Customers generated an average of 2.67 sessions per user, with the most active user reaching 10 sessions.

Repeat engagement is significant:

- Repeat Users: 1,433 (76.55%)
- Single Session Users: 439 (23.45%)

More than three-quarters of users returned for multiple sessions, indicating strong repeat interaction within the observed customer base.

### Session Engagement

The average session contained 2.54 events, with sessions ranging from 1 to 5 events.

Average session duration was approximately 150.05 seconds, or 2.5 minutes, while the longest observed session lasted 668 seconds.

### Customer Journey Paths

The most common customer journey paths were:

- Home → Product Page: 2,388 sessions
- Home only: 1,013 sessions
- Home → Product Page → Cart → Checkout → Confirmation: 1,010 sessions
- Home → Product Page → Cart: 476 sessions
- Home → Product Page → Cart → Checkout: 113 sessions

The largest group of sessions stopped after reaching the product page, making the Product Page → Cart transition an important area for further funnel analysis.

A total of 1,010 sessions completed the full customer journey through confirmation.

### Purchase Behavior

At the session level:

- Purchased Sessions: 1,010 (20.20%)
- Non-Purchased Sessions: 3,990 (79.80%)

This establishes a baseline session-level conversion rate of 20.20%.

### Purchased vs Non-Purchased Session Engagement

Purchased sessions demonstrated substantially deeper engagement than non-purchased sessions.

Purchased sessions averaged:

- 5.00 events per session
- 484.97 seconds of accumulated page engagement
- 2.89 maximum cart items

Non-purchased sessions averaged:

- 1.92 events per session
- 187.81 seconds of accumulated page engagement
- 1.45 maximum cart items

Converted sessions therefore progressed through more journey stages and accumulated substantially more engagement time.

### Device-Level Behavior

Traffic and purchase volumes were highly balanced across devices:

- Mobile: 1,671 sessions and 337 purchased sessions
- Desktop: 1,666 sessions and 339 purchased sessions
- Tablet: 1,663 sessions and 334 purchased sessions

Average events per session were also nearly identical across the three device types, suggesting similar overall engagement patterns.

### Referral Source Behavior

Google generated the highest session and purchase volumes:

- Google: 1,280 sessions and 277 purchased sessions
- Email: 1,251 sessions and 251 purchased sessions
- Social Media: 1,243 sessions and 239 purchased sessions
- Direct: 1,226 sessions and 243 purchased sessions

Conversion-rate analysis is required before determining whether higher purchase volume is driven by better conversion performance or simply higher traffic volume.

### Cart Behavior

Sessions with no items added to the cart produced no purchases.

Purchase rates among sessions that added products to the cart were:

- 1 item: 37.68%
- 2 items: 34.62%
- 3 items: 38.17%
- 4 items: 31.19%
- 5 items: 30.95%

Three-item sessions recorded the highest purchase rate at 38.17%.

The results also show that larger cart sizes do not necessarily correspond to higher purchase rates. Sessions reaching four or five items converted at lower rates than several smaller-cart groups.

### Day 2 Business Insights

Customer behavior shows a clear relationship between deeper journey engagement and purchase completion.

The Product Page → Cart transition appears to be a major behavioral drop-off point, while customers who progress through additional stages demonstrate substantially stronger engagement.

Repeat users represent the majority of the customer base, providing an opportunity to investigate whether returning users convert differently from single-session users.

Device behavior is relatively balanced, while referral-source performance requires conversion-rate analysis rather than comparison based solely on purchase volume.

These findings establish the behavioral foundation for detailed conversion funnel and stage-level drop-off analysis.