# E-Commerce Customer Journey & Conversion Funnel Analytics

## Project Overview

This project analyzes e-commerce customer journey data to understand how users move through the purchasing funnel, identify major conversion bottlenecks, evaluate customer behavior across different segments, and estimate potential conversion opportunities.

Using SQL and DuckDB, raw clickstream events were transformed into session-level funnel metrics covering the complete customer journey:

**Home → Product Page → Cart → Checkout → Confirmation**

The analysis focuses on customer engagement, conversion behavior, funnel abandonment, device and referral performance, geographic differences, temporal trends, and potential opportunities to improve conversion.

---

## Business Objective

The primary objectives of this project are to:

- Understand how customers progress through the e-commerce journey
- Measure overall and stage-level conversion rates
- Identify the largest funnel drop-off points
- Analyze cart and checkout abandonment
- Compare conversion performance across devices and referral sources
- Evaluate geographic and temporal conversion patterns
- Compare repeat and single-session customer behavior
- Identify high-performing customer segments
- Estimate the potential impact of improving the largest funnel bottleneck

---

## Dataset Overview

The dataset contains customer clickstream activity recorded between **January 1, 2025 and August 31, 2025**.

### Dataset Summary

| Metric | Value |
|---|---:|
| Total Events | 12,719 |
| Unique Sessions | 5,000 |
| Unique Users | 1,872 |
| Purchased Sessions | 1,010 |
| Non-Purchased Sessions | 3,990 |
| Overall Conversion Rate | 20.20% |

### Dataset Fields

The dataset includes:

- `SessionID`
- `UserID`
- `Timestamp`
- `PageType`
- `DeviceType`
- `Country`
- `ReferralSource`
- `TimeOnPage_seconds`
- `ItemsInCart`
- `Purchased`

---

## Tools & Technologies

- **SQL**
- **DuckDB**
- **VS Code**
- **Git**
- **GitHub**

---

## SQL Concepts Used

This project demonstrates practical SQL techniques including:

- Common Table Expressions (CTEs)
- Conditional aggregation
- `CASE WHEN` logic
- `COUNT(DISTINCT)`
- `SUM()` and `AVG()`
- Window functions
- `LAG()`
- `STRING_AGG()`
- Date and timestamp functions
- `DATE_TRUNC()`
- `DATE_DIFF()`
- Session-level aggregation
- Funnel analysis
- Behavioral segmentation
- Conversion-rate calculations
- Scenario analysis

---

# Customer Journey Analysis

## Most Common Journey Paths

The most common customer journeys were:

| Customer Journey | Sessions |
|---|---:|
| Home → Product Page | 2,388 |
| Home Only | 1,013 |
| Home → Product Page → Cart → Checkout → Confirmation | 1,010 |
| Home → Product Page → Cart | 476 |
| Home → Product Page → Cart → Checkout | 113 |

The largest group of customers stopped after reaching the product page.

A total of **1,010 sessions completed the entire purchase journey**.

---

# Conversion Funnel

The session-level conversion funnel was:

| Funnel Stage | Sessions | Reach Rate |
|---|---:|---:|
| Home | 5,000 | 100.00% |
| Product Page | 3,987 | 79.74% |
| Cart | 1,599 | 31.98% |
| Checkout | 1,123 | 22.46% |
| Confirmation | 1,010 | 20.20% |

### Funnel Visualization

```text
Home
5,000 Sessions
100.00%
      |
      v
Product Page
3,987 Sessions
79.74%
      |
      v
Cart
1,599 Sessions
31.98%
      |
      v
Checkout
1,123 Sessions
22.46%
      |
      v
Confirmation
1,010 Sessions
20.20%
```

The overall session conversion rate was **20.20%**.

---

# Stage-Level Drop-Off Analysis

| Funnel Transition | Conversion Rate | Drop-Off Rate | Lost Sessions |
|---|---:|---:|---:|
| Home → Product Page | 79.74% | 20.26% | 1,013 |
| Product Page → Cart | 40.11% | **59.89%** | **2,388** |
| Cart → Checkout | 70.23% | 29.77% | 476 |
| Checkout → Confirmation | 89.94% | 10.06% | 113 |

The largest funnel bottleneck occurs between:

**Product Page → Cart**

Only **40.11%** of product-page sessions progressed to the cart, while **59.89%** dropped out at this transition.

---

# Non-Conversion Analysis

Among the **3,990 non-converted sessions**, the final observed stages were:

| Exit Stage | Lost Sessions | Share of Non-Conversions |
|---|---:|---:|
| Product Page | 2,388 | **59.85%** |
| Home | 1,013 | 25.39% |
| Cart | 476 | 11.93% |
| Checkout | 113 | 2.83% |

Nearly **60% of all non-conversions occurred after customers reached a product page**.

This reinforces the Product Page → Cart transition as the primary opportunity identified by the funnel analysis.

---

# Customer Behavior

## Repeat vs Single-Session Users

| User Type | Users | Share |
|---|---:|---:|
| Repeat Users | 1,433 | 76.55% |
| Single Session Users | 439 | 23.45% |

Customers generated an average of **2.67 sessions per user**, with a maximum of 10 sessions.

Repeat-user sessions converted at **20.28%**, compared with **19.36%** for single-session users.

---

## Purchased vs Non-Purchased Sessions

Purchased sessions showed substantially deeper engagement.

| Metric | Purchased | Non-Purchased |
|---|---:|---:|
| Average Events | 5.00 | 1.92 |
| Average Engagement Seconds | 484.97 | 187.81 |
| Average Maximum Cart Items | 2.89 | 1.45 |

The relationship should be interpreted carefully because progressing further through the funnel naturally produces additional events and engagement time.

---

# Device Performance

Conversion rates were highly consistent across devices.

| Device | Sessions | Purchases | Conversion Rate |
|---|---:|---:|---:|
| Desktop | 1,666 | 339 | 20.35% |
| Mobile | 1,671 | 337 | 20.17% |
| Tablet | 1,663 | 334 | 20.08% |

No major device-level conversion disadvantage was observed.

---

# Referral Source Performance

| Referral Source | Sessions | Purchases | Conversion Rate |
|---|---:|---:|---:|
| Google | 1,280 | 277 | **21.64%** |
| Email | 1,251 | 251 | 20.06% |
| Direct | 1,226 | 243 | 19.82% |
| Social Media | 1,243 | 239 | 19.23% |

Google generated both the highest traffic volume and the highest observed overall conversion rate.

Among sessions that reached the cart, cart-to-purchase rates were:

| Referral Source | Cart-to-Purchase Rate |
|---|---:|
| Google | 64.87% |
| Social Media | 63.23% |
| Direct | 62.95% |
| Email | 61.52% |

---

# Geographic Performance

Country-level conversion rates were:

| Country | Conversion Rate |
|---|---:|
| France | **22.61%** |
| USA | 20.82% |
| India | 20.66% |
| UK | 19.62% |
| Canada | 19.58% |
| Australia | 19.18% |
| Germany | 18.78% |

France recorded the highest observed country-level conversion rate.

Product-to-cart rates were relatively consistent across countries, ranging from **38.91% to 41.23%**, indicating that the Product Page → Cart bottleneck was not isolated to a single geography.

---

# Cart Behavior

Conversion rates by maximum cart size were:

| Maximum Items | Sessions | Purchases | Conversion Rate |
|---:|---:|---:|---:|
| 0 | 2,088 | 0 | 0.00% |
| 1 | 568 | 214 | 37.68% |
| 2 | 569 | 197 | 34.62% |
| 3 | 668 | 255 | **38.17%** |
| 4 | 561 | 175 | 31.19% |
| 5 | 546 | 169 | 30.95% |

Three-item sessions recorded the highest observed conversion rate.

Larger cart sizes did not consistently correspond to higher conversion rates.

---

# Monthly Conversion Trend

| Month | Conversion Rate |
|---|---:|
| January | 19.18% |
| February | 18.55% |
| March | **21.43%** |
| April | 20.92% |
| May | 20.35% |
| June | 20.32% |
| July | 20.27% |
| August | 20.60% |

March recorded the highest monthly conversion rate.

From May through August, conversion remained relatively stable around 20%.

---

# Day and Time Analysis

## Conversion by Day of Week

Sunday recorded the highest observed conversion rate at **21.72%**, while Wednesday recorded the lowest at **18.50%**.

## Conversion by Time of Day

| Time Period | Conversion Rate |
|---|---:|
| Afternoon | **21.54%** |
| Late Night | 20.59% |
| Evening | 19.42% |
| Morning | 19.27% |

Afternoon sessions recorded the highest observed conversion rate.

These results represent observed associations and should not be interpreted as evidence that the time period itself causes higher conversion.

---

# Funnel Opportunity Scenario

The most significant opportunity identified in the project is the **Product Page → Cart** transition.

### Current Performance

- Product Page Sessions: 3,987
- Cart Sessions: 1,599
- Product-to-Cart Rate: 40.11%
- Current Purchases: 1,010

A scenario was evaluated where the Product-to-Cart rate increases from **40.11% to 45%**, while the observed downstream Cart → Purchase behavior remains unchanged.

### Scenario Result

| Metric | Result |
|---|---:|
| Target Product-to-Cart Rate | 45.00% |
| Estimated Purchases | 1,133 |
| Current Purchases | 1,010 |
| Estimated Incremental Purchases | **+123** |

Under these assumptions, improving the Product-to-Cart rate to 45% could correspond to approximately **123 additional purchases** across the observed dataset period.

This is a **what-if scenario rather than a forecast**. It assumes downstream conversion performance remains unchanged as additional customers enter the cart.

---

# Key Business Insights

### 1. Product Page Is the Primary Funnel Bottleneck

The Product Page → Cart transition has a **59.89% drop-off rate**, resulting in 2,388 lost sessions.

Furthermore, product-page exits account for **59.85% of all non-converted sessions**.

### 2. Checkout Performance Is Strong

Customers who reach checkout have an **89.94% progression rate to confirmation**.

Only 113 sessions were lost between checkout and confirmation.

This suggests that the largest observed opportunity exists earlier in the journey rather than at final checkout.

### 3. Device Performance Is Highly Consistent

Desktop, Mobile, and Tablet conversion rates are all approximately 20%.

There is no evidence of a major device-specific conversion gap in the dataset.

### 4. Google Traffic Shows Strong Observed Performance

Google produced the highest overall referral conversion rate at **21.64%** and the highest cart-to-purchase rate at **64.87%**.

### 5. Geographic Differences Are Moderate

France recorded the highest observed conversion rate at 22.61%, while Germany recorded 18.78%.

However, product-to-cart performance remains relatively similar across countries.

### 6. Conversion Remained Relatively Stable Over Time

After monthly variation early in the period, conversion remained close to 20% from May through August.

### 7. Funnel Optimization Has Measurable Potential

A scenario increasing Product-to-Cart performance to 45% produced approximately **123 incremental purchases**, assuming downstream behavior remains constant.

---

# Business Recommendations

Based on the observed funnel behavior, further investigation should prioritize the Product Page → Cart transition.

Potential areas for analysis and experimentation include:

- Product page usability
- Add-to-cart call-to-action placement
- Product descriptions and information quality
- Pricing presentation
- Promotional messaging
- Product imagery
- Shipping and delivery information
- Product recommendations
- Trust signals and customer reviews
- A/B testing of product-page layouts

The dataset identifies **where** customers leave the funnel but does not provide enough information to determine **why** they leave.

Therefore, these recommendations represent areas for further testing rather than confirmed causes of abandonment.

---

# Project Structure

```text
14-Ecommerce-Customer-Journey-Conversion-Funnel/
│
├── Datasets/
│   └── customer_journey.csv
│
├── SQL/
│   ├── schema.sql
│   └── queries.sql
│
├── insights.md
└── README.md
```

---

# Key Takeaway

The project transformed **12,719 raw customer journey events** into a session-level conversion funnel covering **5,000 sessions and 1,872 users**.

The analysis identified:

- **20.20% overall session conversion**
- **59.89% Product Page → Cart drop-off**
- **59.85% of all non-conversions ending at the Product Page**
- **89.94% Checkout → Confirmation progression**
- Relatively consistent conversion across devices
- Moderate geographic and acquisition-channel differences
- A scenario indicating approximately **123 additional purchases** if Product-to-Cart performance reached 45% while downstream behavior remained unchanged

The central business finding is that the greatest observed conversion opportunity exists at the **Product Page → Cart** stage rather than at checkout.

---

## Author

**Teja Naidu Ganji**

SQL Portfolio Project – E-Commerce Customer Journey & Conversion Funnel Analytics