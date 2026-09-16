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