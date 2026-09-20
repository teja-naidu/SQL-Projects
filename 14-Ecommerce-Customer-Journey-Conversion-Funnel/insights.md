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

---

## Day 3 – Conversion Funnel & Drop-Off Analysis

### Overall Conversion Funnel

The session-level customer journey shows a progressive decline as users move through the purchasing funnel:

- Home: 5,000 sessions (100.00%)
- Product Page: 3,987 sessions (79.74%)
- Cart: 1,599 sessions (31.98%)
- Checkout: 1,123 sessions (22.46%)
- Confirmation: 1,010 sessions (20.20%)

Out of 5,000 total sessions, 1,010 completed a purchase, producing an overall session conversion rate of 20.20%.

### Stage-to-Stage Funnel Performance

The conversion and drop-off rates between funnel stages were:

| Funnel Transition | Conversion Rate | Drop-Off Rate |
|---|---:|---:|
| Home → Product Page | 79.74% | 20.26% |
| Product Page → Cart | 40.11% | 59.89% |
| Cart → Checkout | 70.23% | 29.77% |
| Checkout → Confirmation | 89.94% | 10.06% |

The Product Page → Cart transition represents the largest funnel bottleneck.

Only 40.11% of product-page sessions progressed to the cart, while 59.89% abandoned the journey at this stage.

### Product Page Abandonment

A total of 3,987 sessions reached a product page.

Of these, 2,388 sessions did not continue to the cart, resulting in a product-page abandonment rate of 59.89%.

This represents the largest loss of potential customers within the conversion funnel.

From a business perspective, product-page experience, product information, pricing, purchase intent, and add-to-cart behavior would be important areas for further investigation. The dataset identifies the location of the drop-off but does not establish its cause.

### Cart Abandonment

A total of 1,599 sessions reached the cart.

Of these, 476 sessions did not proceed to checkout.

This resulted in a cart abandonment rate of 29.77%.

Although cart abandonment remains significant, the loss is considerably smaller than the Product Page → Cart drop-off.

### Checkout Abandonment

A total of 1,123 sessions reached checkout, and 1,010 continued through purchase confirmation.

Only 113 sessions abandoned the journey during checkout.

The checkout abandonment rate was 10.06%, meaning 89.94% of sessions that reached checkout successfully progressed to confirmation.

This indicates that the later portion of the purchase funnel performs substantially better than the earlier product-to-cart stage.

### Device Conversion Performance

Conversion rates were highly consistent across device types:

- Desktop: 20.35%
- Mobile: 20.17%
- Tablet: 20.08%

The narrow difference between device conversion rates suggests that no single device category shows a major conversion disadvantage within this dataset.

### Referral Source Conversion

Session-level conversion rates by referral source were:

- Google: 21.64%
- Email: 20.06%
- Direct: 19.82%
- Social Media: 19.23%

Google recorded both the highest traffic volume and the highest observed conversion rate among the four referral sources.

The difference between the highest and lowest referral conversion rates, however, is relatively modest.

### Repeat vs Single-Session Users

Repeat-user sessions recorded a conversion rate of 20.28%, compared with 19.36% for sessions belonging to single-session users.

The results show a slightly higher observed conversion rate among repeat users, although the difference is less than one percentage point.

### Day 3 Business Insights

The funnel analysis identifies the Product Page → Cart transition as the primary conversion bottleneck.

Nearly 60% of sessions reaching a product page fail to progress to the cart, representing 2,388 lost sessions.

Once customers enter the cart, progression improves considerably:

- 70.23% continue from Cart → Checkout
- 89.94% continue from Checkout → Confirmation

Therefore, the largest opportunity indicated by the funnel is improving progression from product consideration to cart addition rather than focusing only on the checkout process.

Device conversion rates are nearly identical, while referral-source conversion varies modestly, with Google recording the highest observed rate.

Overall, the platform converts 20.20% of sessions into completed purchases, providing a clear baseline for subsequent customer-segment and channel-level analysis.

---

## Day 4 – Segment, Channel & Conversion Trend Analysis

### Country-Level Conversion

Conversion performance varied moderately across countries.

- France: 22.61%
- USA: 20.82%
- India: 20.66%
- UK: 19.62%
- Canada: 19.58%
- Australia: 19.18%
- Germany: 18.78%

France recorded the highest observed conversion rate, while Germany recorded the lowest.

The difference between the highest and lowest country conversion rates was 3.83 percentage points, indicating some geographic variation without an extreme performance gap.

### Device and Referral Source Performance

Combining device type with referral source provided a more detailed view of acquisition performance.

The highest observed conversion combinations were:

- Mobile + Google: 21.88%
- Tablet + Email: 21.77%
- Desktop + Google: 21.71%
- Tablet + Google: 21.31%
- Desktop + Direct: 20.85%

Tablet + Direct recorded the lowest observed conversion rate at 18.55%.

Google performed relatively well across multiple device categories, suggesting consistently strong observed conversion among Google-referred sessions.

### Monthly Conversion Trend

Monthly conversion rates remained relatively stable throughout the January-August 2025 observation period.

- January: 19.18%
- February: 18.55%
- March: 21.43%
- April: 20.92%
- May: 20.35%
- June: 20.32%
- July: 20.27%
- August: 20.60%

March recorded the highest monthly conversion rate at 21.43%, while February recorded the lowest at 18.55%.

From April through August, conversion remained close to 20-21%, indicating relatively stable observed funnel performance during that period.

### Day-of-Week Performance

Conversion rates by day of week were:

- Sunday: 21.72%
- Tuesday: 20.91%
- Friday: 20.76%
- Monday: 20.19%
- Saturday: 19.81%
- Thursday: 19.57%
- Wednesday: 18.50%

Sunday recorded the highest observed conversion rate, while Wednesday recorded the lowest.

### Time-of-Day Performance

Conversion rates by session start period were:

- Afternoon: 21.54%
- Late Night: 20.59%
- Evening: 19.42%
- Morning: 19.27%

Afternoon sessions recorded the highest observed conversion rate.

However, these differences represent associations within the dataset and should not be interpreted as evidence that time of day itself causes higher conversion.

### Session Depth and Conversion

Conversion increased sharply with the number of events recorded within a session.

- 1 event: 0.00%
- 2 events: 0.00%
- 3 events: 0.00%
- 4 events: 0.00%
- 5 events: 100.00%

All 1,010 five-event sessions completed a purchase.

This pattern reflects the structure of the customer journey in the dataset: a completed funnel consists of Home → Product Page → Cart → Checkout → Confirmation.

Therefore, the result should be interpreted as a representation of funnel completion rather than evidence that generating additional events causes conversion.

### Engagement Time and Conversion

Longer sessions were associated with higher observed conversion:

- Under 2 Minutes: 0.00%
- 2-5 Minutes: 1.77%
- 5-10 Minutes: 62.96%
- 10+ Minutes: 100.00%

Longer engagement is strongly associated with deeper funnel progression in this dataset.

However, session duration and funnel depth are closely related, so these results should not be interpreted as a causal effect of spending more time on the website.

### Product-to-Cart Performance by Country

Product-to-cart rates were relatively consistent across countries:

- France: 41.23%
- Australia: 40.71%
- Canada: 40.28%
- India: 40.07%
- USA: 39.93%
- Germany: 39.55%
- UK: 38.91%

France recorded the highest observed product-to-cart rate.

The relatively narrow range suggests that the Product Page → Cart bottleneck identified earlier is not isolated to a single country.

### Cart-to-Purchase Performance by Referral Source

Among sessions that reached the cart, purchase completion rates were:

- Google: 64.87%
- Social Media: 63.23%
- Direct: 62.95%
- Email: 61.52%

Google recorded the highest observed cart-to-purchase rate.

Differences across referral sources were relatively small, indicating broadly similar downstream funnel performance after customers reached the cart.

### Day 4 Business Insights

Segmentation analysis shows that overall conversion performance is relatively balanced across most customer dimensions, with moderate differences by geography, acquisition source, day of week, and time of day.

France recorded the highest country-level conversion rate, while Google-related device combinations appeared among several of the stronger acquisition segments.

Monthly conversion remained relatively stable, suggesting no major sustained deterioration or improvement in funnel performance during the observed period.

Most importantly, the Product Page → Cart bottleneck identified in Day 3 appears across countries rather than being concentrated in one geographic market.

Engagement depth and session duration are strongly associated with conversion, but these metrics are also consequences of progressing further through the funnel and should not be interpreted as causal drivers of purchase behavior.

---

## Day 5 – Executive KPI & Funnel Opportunity Analysis

### Executive KPI Summary

The final analysis covers:

- 5,000 customer sessions
- 1,872 unique users
- 1,010 purchased sessions
- 3,990 non-purchased sessions
- 20.20% overall session conversion rate
- 2.54 average events per session
- 247.84 average engagement seconds per session
- 1.74 average maximum cart items per session

These metrics provide the overall baseline for evaluating customer journey and funnel performance.

### Funnel Loss Summary

The number of sessions lost at each transition was:

| Funnel Transition | Lost Sessions | Drop-Off Rate |
|---|---:|---:|
| Product Page → Cart | 2,388 | 59.89% |
| Home → Product Page | 1,013 | 20.26% |
| Cart → Checkout | 476 | 29.77% |
| Checkout → Confirmation | 113 | 10.06% |

The Product Page → Cart transition generated the largest absolute and percentage loss in the funnel.

### Distribution of Non-Conversions

Among the 3,990 sessions that did not convert:

- Product Page exits: 2,388 (59.85%)
- Home exits: 1,013 (25.39%)
- Cart exits: 476 (11.93%)
- Checkout exits: 113 (2.83%)

Nearly 60% of all non-converted sessions exited after reaching the product page.

This reinforces the Product Page → Cart transition as the primary funnel opportunity identified in the analysis.

### Product-to-Cart Improvement Scenario

The current Product Page → Cart rate is 40.11%.

A scenario analysis was performed to estimate the potential impact of increasing this rate to 45%, while holding the observed downstream Cart → Purchase behavior constant.

Under this assumption:

- Current Product Sessions: 3,987
- Current Cart Sessions: 1,599
- Current Purchases: 1,010
- Estimated Purchases at 45% Product-to-Cart Rate: 1,133
- Estimated Incremental Purchases: 123

This represents approximately 123 additional purchases over the observed dataset period under the scenario assumptions.

This result is a what-if estimate rather than a forecast. It assumes that downstream conversion behavior remains unchanged as additional sessions enter the cart.

### Cart Size and Conversion

Conversion performance by maximum cart size was:

| Maximum Cart Items | Sessions | Purchased Sessions | Conversion Rate |
|---:|---:|---:|---:|
| 0 | 2,088 | 0 | 0.00% |
| 1 | 568 | 214 | 37.68% |
| 2 | 569 | 197 | 34.62% |
| 3 | 668 | 255 | 38.17% |
| 4 | 561 | 175 | 31.19% |
| 5 | 546 | 169 | 30.95% |

Three-item sessions recorded the highest observed conversion rate at 38.17%.

Larger cart sizes did not consistently produce higher conversion rates, indicating that cart quantity alone is not a reliable indicator of purchase completion.

### Converted Session Profile by Device

Converted sessions were distributed almost evenly across devices:

- Desktop: 339 converted sessions
- Mobile: 337 converted sessions
- Tablet: 334 converted sessions

Average engagement among converted sessions was also similar:

- Desktop: 481.02 seconds
- Mobile: 493.84 seconds
- Tablet: 480.03 seconds

The results reinforce the earlier finding that device type is not a major differentiator of conversion performance in this dataset.

### Converted Session Profile by Referral Source

Converted sessions by acquisition source were:

- Google: 277
- Email: 251
- Direct: 243
- Social Media: 239

Average engagement among converted sessions ranged from 470.00 seconds for Direct traffic to 497.65 seconds for Social Media traffic.

Google generated the highest number of converted sessions, while converted Social Media sessions recorded the highest average engagement time.

### Monthly Conversion Movement

Monthly conversion rates were:

- January: 19.18%
- February: 18.55% (-0.63 pp)
- March: 21.43% (+2.88 pp)
- April: 20.92% (-0.51 pp)
- May: 20.35% (-0.57 pp)
- June: 20.32% (-0.03 pp)
- July: 20.27% (-0.05 pp)
- August: 20.60% (+0.33 pp)

March recorded the largest positive month-over-month movement at +2.88 percentage points.

From May through August, conversion remained relatively stable around 20%.

### High-Converting Observed Segments

Among country-device-referral combinations with at least 40 sessions, some of the highest observed conversion rates included:

- Australia + Tablet + Email: 31.58%
- France + Mobile + Direct: 31.58%
- France + Mobile + Google: 31.43%
- USA + Tablet + Google: 29.03%
- UK + Tablet + Direct: 27.78%

These segments identify areas of observed strength within the dataset.

However, because these groups contain substantially fewer sessions than the overall dataset, their conversion rates should be interpreted as descriptive segment results rather than evidence that these combinations inherently cause higher conversion.

### Final Funnel KPI Summary

The final customer journey performance was:

- Home → Product Page: 79.74%
- Product Page → Cart: 40.11%
- Cart → Checkout: 70.23%
- Checkout → Confirmation: 89.94%
- Overall Session Conversion: 20.20%

The funnel becomes progressively stronger after customers add a product to their cart.

### Final Business Conclusions

The analysis identifies the Product Page → Cart transition as the primary conversion bottleneck.

Of all non-converted sessions, 59.85% exited after reaching a product page. This loss is substantially larger than abandonment during the cart or checkout stages.

Once customers reach checkout, funnel performance is strong, with 89.94% progressing to confirmation. This suggests that the largest opportunity indicated by the dataset lies earlier in the purchase journey rather than at final checkout.

A scenario increasing the Product Page → Cart rate from 40.11% to 45%, while holding downstream behavior constant, produces an estimated 123 additional purchases across the observed dataset.

Potential areas for further investigation include:

- Product page usability
- Product information quality
- Pricing and promotional presentation
- Add-to-cart call-to-action effectiveness
- Product recommendation strategy
- Customer purchase intent

The available dataset identifies where customers leave the funnel but does not contain enough information to establish why those customers abandon. Additional experimentation or behavioral data would be required to determine causal drivers.

Overall, the project demonstrates how session-level SQL analysis can transform raw clickstream data into actionable funnel metrics, customer behavior insights, segmentation analysis, and business opportunity scenarios.