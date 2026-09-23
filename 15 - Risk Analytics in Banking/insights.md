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

---

# Day 2 — Customer Financial & Credit Risk Analysis

## 1. Income and Default Risk

Customer income shows a meaningful relationship with observed default risk.

- Below 100K income: **8.20%** default rate
- 100K–150K: **8.62%**
- 150K–200K: **8.45%**
- 200K–300K: **7.55%**
- 300K+: **5.95%**

The highest-income group has the lowest observed default rate.

However, default risk does not decrease perfectly across every income band. The 100K–150K segment records a slightly higher default rate than the below-100K segment, suggesting that income alone does not determine credit risk.

---

## 2. Credit-to-Income Ratio

Credit-to-income analysis produced a non-linear relationship with default risk.

- Below 2x: **7.48%**
- 2x–4x: **8.77%**
- 4x–6x: **8.20%**
- 6x+: **7.23%**

The **2x–4x credit-to-income group** records the highest default rate at 8.77%.

Interestingly, customers with credit exceeding six times their income do not have the highest observed default rate. This suggests that credit-to-income ratio should not be treated as an isolated risk indicator.

Other underwriting factors may influence which customers receive very large credit amounts relative to their income.

---

## 3. Annuity Burden

The annuity-to-income ratio provides an estimate of how much of a customer's income is represented by scheduled loan payments.

Observed default rates are:

- Below 15%: **7.55%**
- 15%–25%: **8.44%**
- 25%–35%: **8.70%**
- 35%+: **8.07%**

Risk generally increases as payment burden rises through the 25%–35% segment.

However, the 35%+ group shows a slightly lower default rate than the 25%–35% group, indicating that payment burden alone does not fully explain default behavior.

---

## 4. Credit Amount and Default Risk

Default risk varies across loan-size segments.

- Below 250K: **7.13%**
- 250K–500K: **9.30%**
- 500K–750K: **9.46%**
- 750K–1M: **7.26%**
- 1M+: **5.87%**

The **500K–750K segment has the highest default rate at 9.46%**, closely followed by the 250K–500K segment at 9.30%.

Customers receiving credit above 1M show the lowest observed default rate at 5.87%.

This suggests that larger loan amounts are not automatically associated with greater default risk. Higher-value borrowers may differ in income, credit profile, underwriting characteristics, or other factors.

---

## 5. Age and Default Risk

Age shows one of the clearest patterns identified in Day 2.

- Under 30: **11.44%**
- Age 30–39: **9.59%**
- Age 40–49: **7.64%**
- Age 50–59: **6.12%**
- Age 60+: **4.92%**

Observed default rates decrease consistently across older age groups.

Applicants under 30 have more than twice the observed default rate of applicants aged 60+.

Age therefore appears to be an important segmentation variable in this dataset, although it should be interpreted alongside employment, income, credit history, and other borrower characteristics.

---

## 6. Employment History

Employment duration also shows a strong relationship with default risk.

- Less than 1 year: **10.97%**
- 1–3 years: **11.07%**
- 3–5 years: **9.67%**
- 5–10 years: **7.37%**
- 10+ years: **5.19%**

Customers with only 1–3 years of employment have the highest observed default rate.

Customers with more than 10 years of employment show a substantially lower default rate of 5.19%.

This pattern suggests that longer employment history is associated with lower observed credit risk.

The dataset's special `DAYS_EMPLOYED = 365243` value was treated separately as unknown/not employed rather than being interpreted as actual employment tenure.

---

## 7. Education Level

Default rates vary considerably across education categories.

- Lower secondary: **10.93%**
- Secondary / secondary special: **8.94%**
- Incomplete higher: **8.48%**
- Higher education: **5.36%**
- Academic degree: **1.83%**

Applicants with higher education show considerably lower observed default rates than applicants with secondary or lower-secondary education.

The Academic Degree category has only 164 applications, so its 1.83% default rate should be interpreted cautiously because of the small sample size.

---

## 8. Occupation Risk

Occupation shows substantial variation in default rates.

Higher observed default-rate occupations include:

- Low-skill Laborers: **17.15%**
- Drivers: **11.33%**
- Waiters/barmen staff: **11.28%**
- Security staff: **10.74%**
- Laborers: **10.58%**
- Cooking staff: **10.44%**

Lower observed default-rate occupations include:

- Accountants: **4.83%**
- High skill tech staff: **6.16%**
- Managers: **6.21%**
- Core staff: **6.30%**
- Private service staff: **6.60%**
- Medicine staff: **6.70%**

Low-skill laborers stand out with a 17.15% default rate, substantially above the overall portfolio default rate of 8.07%.

Occupation therefore appears useful for borrower segmentation when combined with income, employment stability, and other financial characteristics.

---

## 9. Asset Ownership

Customers owning both a car and real estate have a **7.33%** default rate.

Customers owning a car but not real estate have a **7.04%** default rate.

Customers without a car but owning real estate have an **8.28%** default rate.

Customers owning neither have the highest observed default rate at **8.99%**.

Customers without either asset therefore show somewhat higher observed default risk than car-owning groups.

However, asset ownership should not be interpreted independently from customer income and other socioeconomic characteristics.

---

## 10. Number of Children

Default rates increase across several household-size groups:

- 0 children: **7.71%**
- 1 child: **8.92%**
- 2 children: **8.72%**
- 3+ children: **10.04%**

Applicants with three or more children show the highest observed default rate.

Household size may therefore contribute useful information when combined with income and payment-burden measures.

---

## 11. External Credit Scores

External credit scores show a substantial difference between default and non-default customers.

### Non-Default Customers

- EXT_SOURCE_1: **0.5115**
- EXT_SOURCE_2: **0.5235**
- EXT_SOURCE_3: **0.5210**

### Default Customers

- EXT_SOURCE_1: **0.3870**
- EXT_SOURCE_2: **0.4109**
- EXT_SOURCE_3: **0.3907**

Across all three external sources, default customers have lower average scores than non-default customers.

This indicates that the external credit-risk variables contain meaningful information for distinguishing higher-risk applicants.

---

## 12. EXT_SOURCE_2 Risk Segmentation

EXT_SOURCE_2 produces one of the strongest risk gradients observed so far.

- Score below 0.30: **15.88%** default rate
- Score 0.30–0.50: **9.66%**
- Score 0.50–0.70: **6.09%**
- Score 0.70+: **3.31%**

As EXT_SOURCE_2 increases, the observed default rate consistently decreases.

Applicants with scores below 0.30 have almost five times the observed default rate of applicants with scores of 0.70 or higher.

This makes EXT_SOURCE_2 a particularly useful candidate for deeper risk segmentation and multivariable analysis.

---

## Day 2 Key Takeaways

1. **Age is strongly associated with observed default risk**, with default rates declining consistently from 11.44% for applicants under 30 to 4.92% for applicants aged 60+.

2. **Employment stability appears important.** Customers with more than 10 years of employment have a 5.19% default rate compared with approximately 11% among customers with less than three years of employment.

3. **External credit scores provide strong risk separation.** EXT_SOURCE_2 default rates decline from 15.88% in the lowest score band to only 3.31% in the highest.

4. **Occupation is associated with substantial risk differences.** Low-skill laborers have a 17.15% observed default rate, while accountants have a 4.83% rate.

5. **Higher income is generally associated with lower risk**, particularly for customers earning more than 300K.

6. Credit amount, credit-to-income ratio, and annuity burden show **non-linear relationships**, demonstrating why borrower risk should not be assessed using a single financial metric.

7. Customers with **3+ children** and customers owning neither a car nor real estate show higher observed default rates than their respective comparison groups.

8. Overall, Day 2 demonstrates that **credit risk is multidimensional**. Age, employment stability, external credit information, occupation, income, household characteristics, and financial burden should be considered together rather than independently.