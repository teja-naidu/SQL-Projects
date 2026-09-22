# Banking Credit Risk & Loan Default Analytics — Insights

## Day 1 — Data Exploration & Portfolio Overview

### 1. Portfolio Overview

- The current application dataset contains **307,511 loan applications**.
- **282,686 applications (91.93%)** are classified as non-default.
- **24,825 applications (8.07%)** are classified as default/payment difficulty cases.
- The overall portfolio therefore has a baseline **default rate of 8.07%**.

### 2. Credit Exposure

- Total credit issued across current applications is approximately **184.21 billion**.
- The average credit amount is approximately **599,026**.
- Credit amounts range from **45,000** to **4,050,000**.
- This indicates substantial variation in loan size across the portfolio.

### 3. Customer Income Profile

- Average customer income is approximately **168,798**.
- Median customer income is **147,150**.
- The difference between average and median income suggests that the income distribution is positively skewed.
- The maximum reported income of **117 million** is substantially higher than the typical customer income and may represent an extreme value that should be investigated during deeper analysis.

### 4. Loan Contract Mix

- **Cash loans account for 278,232 applications (90.48%)**, making them the dominant lending product.
- Revolving loans represent **29,279 applications (9.52%)**.
- Cash loans have a default rate of **8.35%**, compared with **5.48%** for revolving loans.
- This indicates that cash-loan applicants experience a higher observed default rate within this portfolio.

### 5. Income Type and Default Risk

- Working customers form the largest borrower segment with **158,774 applications**.
- Their default rate is **9.59%**, which is above the overall portfolio default rate of 8.07%.
- Commercial associates have a default rate of **7.48%**.
- State servants and pensioners show lower observed default rates of **5.75%** and **5.39%**, respectively.
- Some categories show very high or zero default rates, but their sample sizes are extremely small. For example, there are only 22 unemployed customers, 18 students, 10 businessmen, and 5 customers on maternity leave.
- These small groups should therefore not be used to draw broad risk conclusions without additional evidence.

### 6. Family Status and Default Risk

- Married customers represent the largest segment with **196,432 applications** and a default rate of **7.56%**.
- Civil marriage customers show a **9.94%** default rate.
- Single/not-married customers show a similar **9.81%** default rate.
- Widowed customers have the lowest observed default rate among the major family-status groups at **5.82%**.
- Family status appears associated with different observed default rates and can be explored alongside income, age, employment, and other variables.

### 7. Housing Type and Default Risk

- Most applicants (**272,868**) live in a house or apartment.
- This group has a default rate of **7.80%**.
- Customers living in rented apartments have the highest observed default rate among the meaningful housing groups at **12.31%**.
- Customers living with parents also show an elevated default rate of **11.70%**.
- Office-apartment residents have a lower observed default rate of **6.57%**.
- Housing situation may therefore provide useful information when combined with other borrower characteristics in risk segmentation.

### 8. Default vs Non-Default Borrower Profile

Non-default customers have:

- Average credit amount: **602,648.28**
- Average annuity: **27,163.62**
- Average income: **169,077.72**

Default customers have:

- Average credit amount: **557,778.53**
- Average annuity: **26,481.74**
- Average income: **165,611.76**

Defaulting customers have slightly lower average income, credit amounts, and annuity values than non-defaulting customers.

However, the differences in simple averages alone are not sufficient to explain default behavior. Additional variables such as debt burden, employment history, age, credit-to-income ratio, and external credit scores should be examined.

### 9. Previous Application History

- The historical dataset contains approximately **1.67 million previous applications**.
- These applications belong to **338,857 unique customers**.
- The average amount previously requested was approximately **175,233.86**.
- The average recorded credit amount was approximately **196,114.02**.
- The large historical dataset provides an opportunity to examine whether previous application behavior is associated with current default risk.

### 10. Previous Application Outcomes

Historical applications were distributed as follows:

- **Approved:** 1,036,781 (62.07%)
- **Canceled:** 316,319 (18.94%)
- **Refused:** 290,678 (17.40%)
- **Unused offer:** 26,436 (1.58%)

Approved applications make up the majority of historical applications, while a substantial share was either refused or canceled.

In later analysis, previous approval, refusal, and cancellation behavior can be linked to current customers to determine whether historical application patterns are associated with current default outcomes.

---

## Day 1 Key Takeaways

1. The portfolio contains **307K+ current applications** with an overall default rate of **8.07%**.
2. Cash loans dominate the portfolio and have a higher observed default rate than revolving loans.
3. Working customers form the largest income segment and show a default rate above the portfolio average.
4. Rented-apartment customers and customers living with parents show elevated default rates compared with the dominant house/apartment segment.
5. Income and credit averages differ only moderately between default and non-default customers, suggesting that default risk cannot be explained by a single financial variable.
6. The **1.67M historical applications** provide a strong foundation for analyzing prior approval/refusal behavior and its relationship with current credit risk.
7. Day 1 establishes the portfolio baseline; subsequent analysis will focus on identifying more meaningful financial and behavioral risk drivers.