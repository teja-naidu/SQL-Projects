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


---

# Day 3 — Default Drivers & Risk Segmentation

## 1. Gender and Default Risk

Default rates differ across gender groups in the portfolio.

- Male applicants: **10.14%**
- Female applicants: **7.00%**

Male applicants show a higher observed default rate than female applicants in this dataset.

The `XNA` category contains only four records and therefore should not be used to draw meaningful conclusions.

---

## 2. Applicant Accompaniment Type

Default rates also vary based on who accompanied the applicant during the application process.

- Other_B: **9.83%**
- Other_A: **8.78%**
- Group of people: **8.49%**
- Unaccompanied: **8.18%**
- Spouse/partner: **7.87%**
- Family: **7.49%**
- Children: **7.38%**

Unaccompanied applicants represent by far the largest segment with **248,526 applications**.

The differences between the major accompaniment groups are relatively modest, suggesting this variable may be more useful when combined with stronger risk indicators.

---

## 3. Family Size and Default Risk

Observed default rates by household size are:

- Single member: **8.36%**
- Two members: **7.58%**
- Three members: **8.76%**
- Four members: **8.65%**
- Five or more members: **9.91%**

Two-member households have the lowest observed default rate.

Applicants from households containing five or more members have the highest rate at 9.91%.

This supports the Day 2 observation that larger dependent or household structures may be associated with additional financial pressure.

---

## 4. Combined Age and Income Risk

Combining age and income produces stronger segmentation than examining either variable independently.

The highest observed default rate occurs among:

**Under 30 + Income below 150K → 12.47%**

Other higher-risk combinations include:

- Under 30 + 150K–300K: **10.60%**
- Age 30–39 + Below 150K: **10.44%**
- Age 30–39 + 150K–300K: **9.30%**

At the opposite end:

**Age 60+ + Income 300K+ → 3.81%**

Within younger age groups, higher income is associated with substantially lower observed default rates.

The results demonstrate that combining demographic and financial characteristics provides more useful risk differentiation than relying on a single variable.

---

## 5. Combined Age and Employment Risk

Age and employment stability also produce clear differences in default behavior.

Higher-risk combinations include:

- Under 30 + less than 3 years employment: **12.34%**
- Age 30–39 + less than 3 years employment: **12.00%**
- Under 30 + 3–10 years employment: **10.35%**
- Age 40–49 + less than 3 years employment: **9.95%**

Lower-risk combinations include:

- Age 60+ + 10+ years employment: **3.54%**
- Age 50–59 + 10+ years employment: **4.49%**
- Age 60+ + less than 3 years employment: **4.80%**
- Age 40–49 + 10+ years employment: **5.13%**

Younger borrowers with short employment histories show particularly elevated default rates.

Longer employment history generally reduces observed risk, especially when combined with greater age.

---

## 6. External Credit Score + Employment Stability

Combining external credit information with employment history creates one of the strongest risk separations in the analysis.

### Highest-Risk Combination

**Low external score + less than 3 years employment**

- Applications: **17,258**
- Default rate: **20.54%**

Other high-risk combinations include:

- Low score + 3–10 years employment: **16.99%**
- Medium-low score + less than 3 years employment: **12.43%**
- Low score + 10+ years employment: **10.50%**

### Lower-Risk Combinations

- High score + less than 3 years employment: **4.53%**
- High score + 3–10 years employment: **3.40%**
- High score + 10+ years employment: **2.52%**
- High score + unknown/not employed: **2.38%**

External credit score remains a strong differentiator even after employment stability is considered.

The difference between the highest and lowest observed groups is substantial: **20.54% versus 2.38%**.

---

## 7. Financial Stress Segmentation

Customers were segmented using two financial burden indicators:

- Credit-to-income ratio
- Annuity-to-income ratio

Results:

### High Financial Stress

- Applications: **49,841**
- Average credit-to-income ratio: **8.04x**
- Average annuity-to-income ratio: **33.60%**
- Default rate: **8.41%**

### Moderate Financial Stress

- Applications: **79,477**
- Average credit-to-income ratio: **5.21x**
- Average annuity-to-income ratio: **20.43%**
- Default rate: **7.49%**

### Low Financial Stress

- Applications: **178,181**
- Average credit-to-income ratio: **2.26x**
- Average annuity-to-income ratio: **12.71%**
- Default rate: **8.24%**

Although the High Financial Stress group has the highest observed default rate, the Low Financial Stress group still records an 8.24% rate.

The relationship is therefore not monotonic.

This reinforces the conclusion that financial burden metrics alone are insufficient to classify borrower risk and should be combined with broader credit and customer characteristics.

---

## 8. Multi-Factor Risk Segmentation

A custom risk framework was created using four indicators:

1. EXT_SOURCE_2 below 0.50
2. Employment history below 3 years
3. Customer age below 40
4. Annuity-to-income ratio of at least 25%

Customers were classified based on the number of risk indicators present.

### High Risk

- Applications: **38,217**
- Defaults: **5,917**
- Default rate: **15.48%**
- Credit exposure: approximately **22.06 billion**

### Elevated Risk

- Applications: **80,972**
- Defaults: **8,195**
- Default rate: **10.12%**
- Credit exposure: approximately **48.17 billion**

### Moderate Risk

- Applications: **112,141**
- Defaults: **7,526**
- Default rate: **6.71%**
- Credit exposure: approximately **68.19 billion**

### Low Risk

- Applications: **76,181**
- Defaults: **3,187**
- Default rate: **4.18%**
- Credit exposure: approximately **45.78 billion**

The custom segmentation produces a clear risk gradient:

**4.18% → 6.71% → 10.12% → 15.48%**

The High Risk segment has approximately **3.7 times** the observed default rate of the Low Risk segment.

This demonstrates how combining several moderate risk indicators can produce substantially stronger borrower segmentation.

---

## 9. Portfolio Risk Concentration

Risk is not distributed evenly throughout the portfolio.

### Elevated Risk

- **26.33%** of applications
- **33.01%** of all defaults

### Moderate Risk

- **36.47%** of applications
- **30.32%** of all defaults

### High Risk

- **12.43%** of applications
- **23.83%** of all defaults

### Low Risk

- **24.77%** of applications
- Only **12.84%** of all defaults

The High Risk segment represents only 12.43% of the portfolio but contributes 23.83% of all defaults.

Combining High and Elevated Risk segments:

- They represent approximately **38.76% of applications**.
- They account for approximately **56.84% of all defaults**.

This demonstrates meaningful concentration of defaults within the higher-risk segments.

---

## 10. High-Risk Customer Profile

The custom segmentation identifies **38,217 High Risk customers**.

Their profile includes:

- Average age: **31.9 years**
- Average annuity: **28,598.06**
- Average credit-to-income ratio: **4.51x**
- Default rate: **15.48%**

This segment is characterized by the presence of at least three of the four selected risk indicators.

Rather than representing risk through a single borrower characteristic, the segment captures customers with overlapping demographic, employment, financial burden, and external credit-risk signals.

---

## Day 3 Key Takeaways

1. **Risk becomes much clearer when variables are combined rather than analyzed independently.**

2. Younger customers with lower incomes show elevated default rates, with under-30 applicants earning below 150K reaching **12.47%**.

3. Younger borrowers with short employment histories also show elevated risk, reaching **12.34%** for under-30 customers employed for less than three years.

4. **External credit score combined with employment stability provides particularly strong risk separation.** Low-score borrowers with short employment histories have a **20.54%** default rate.

5. Financial burden alone does not produce a clean risk gradient, reinforcing the importance of multi-dimensional credit analysis.

6. The custom multi-factor segmentation successfully separates the portfolio from **4.18% default risk in the Low Risk segment to 15.48% in the High Risk segment**.

7. High and Elevated Risk customers represent approximately **38.76% of the portfolio but account for 56.84% of all defaults**.

8. The results demonstrate the value of combining credit scores, employment stability, age, and payment burden to identify concentrated areas of portfolio risk.

---

# Day 4 — Previous Application History & Default Risk Analysis

## 1. Previous Application Outcomes

The previous application dataset contains a large history of customer credit applications.

Application outcomes were:

- Approved: **1,036,781 (62.07%)**
- Canceled: **316,319 (18.94%)**
- Refused: **290,678 (17.40%)**
- Unused offer: **26,436 (1.58%)**

Approved applications represent the majority of historical applications.

However, refused applications still account for a meaningful portion of historical activity and provide useful information for analyzing future credit risk.

---

## 2. Previous Contract Types

Historical applications were primarily concentrated in three contract types.

### Cash Loans

- Previous applications: **747,553**
- Unique customers: **200,825**
- Average requested amount: **274,760.43**
- Average credit amount: **304,061.49**

### Consumer Loans

- Previous applications: **729,151**
- Unique customers: **313,316**
- Average requested amount: **93,787.83**
- Average credit amount: **91,524.59**

### Revolving Loans

- Previous applications: **193,164**
- Unique customers: **123,445**
- Average requested amount: **97,816.24**
- Average credit amount: **173,505.60**

Cash loans involve substantially larger average requested amounts than consumer loans.

Consumer loans, however, reach the largest number of unique historical customers.

---

## 3. Previous Product Categories

The largest identified historical product categories include:

- Mobile: **224,708 applications**
- Consumer Electronics: **121,576**
- Computers: **105,769**
- Audio/Video: **99,441**
- Furniture: **53,656**

A very large number of historical applications are classified as `XNA`, with **950,809 records**.

Because `XNA` does not identify a meaningful product category, it should be treated separately rather than interpreted as an actual loan purpose.

Among identified categories, mobile-related financing represents the largest volume.

---

## 4. Previous Application Rejection Reasons

Among refused historical applications, the largest rejection codes were:

- HC: **175,231 (60.28%)**
- LIMIT: **55,680 (19.16%)**
- SCO: **37,467 (12.89%)**
- SCOFR: **12,811 (4.41%)**
- VERIF: **3,535 (1.22%)**
- SYSTEM: **717 (0.25%)**

The `HC` code accounts for more than 60% of historical refusals.

The dataset output provides rejection codes rather than descriptive definitions, so these codes should not be assigned business meanings without supporting documentation.

---

## 5. Requested vs Credit Amount

Historical application outcomes show differences between requested and recorded credit amounts.

### Approved Applications

- Average requested: **180,567.18**
- Average credit: **202,564.18**
- Average difference: **+21,997.01**

### Refused Applications

- Average requested: **331,760.51**
- Average credit: **371,689.84**
- Average difference: **+39,929.33**

Refused applications involve considerably larger average requested amounts than approved applications.

The average credit fields are also higher for refused applications in this dataset.

These figures describe historical application records and should not be interpreted as actual disbursed credit for refused applications.

---

## 6. Previous Application Frequency

Historical customers show substantial variation in the number of previous applications.

- 1 previous application: **60,458 customers**
- 2–3 previous applications: **98,703**
- 4–5 previous applications: **69,045**
- 6+ previous applications: **110,651**

Customers in the 6+ group average **9.57 previous applications**, making repeat application activity common within the historical dataset.

---

## 7. Application Frequency vs Current Default Risk

After linking previous application history to current applicants:

- 6+ previous applications: **8.73%** current default rate
- 1 previous application: **8.38%**
- 2–3 previous applications: **7.84%**
- 4–5 previous applications: **7.70%**

Application frequency alone does not produce a consistent risk gradient.

The 6+ application group has the highest observed current default rate, but customers with only one previous application also show higher risk than the 2–5 application groups.

Therefore, the number of historical applications alone is not sufficient to classify current borrower risk.

---

## 8. Previous Refusals vs Current Default Risk

Previous refusal history produces a much clearer risk pattern.

- No previous refusals: **7.07%**
- 1 previous refusal: **8.83%**
- 2–3 previous refusals: **10.65%**
- 4+ previous refusals: **13.34%**

Observed current default risk increases consistently as the number of historical refusals increases.

Customers with four or more previous refusals have approximately **1.9 times** the current default rate of customers with no previous refusals.

This makes historical refusal count one of the strongest behavioral risk indicators identified in Day 4.

---

## 9. Previous Approvals vs Current Default Risk

Historical approval count also shows differences in current default behavior.

- No previous approvals: **8.67%**
- 1 previous approval: **9.38%**
- 2–3 previous approvals: **8.38%**
- 4+ previous approvals: **6.97%**

Customers with four or more historical approvals show the lowest observed current default rate.

However, the relationship is not perfectly linear because customers with one historical approval have a higher default rate than customers with no previous approvals.

The no-approval group also contains only **992 customers**, so comparisons involving this segment should be interpreted cautiously.

---

## 10. Historical Approval Rate

Historical approval percentage produces particularly strong risk differentiation.

- 1–25% approved: **14.65%** current default rate
- 26–50% approved: **10.42%**
- 0% approved: **8.67%**
- 51–75% approved: **7.57%**
- 76–100% approved: **6.95%**

Among customers with at least some historical approvals, current default risk generally declines as historical approval rate increases.

The **1–25% approval group has more than twice the observed default rate of the 76–100% approval group**.

The 0% approval segment contains only 992 customers and does not follow the broader pattern, so it should be interpreted separately.

---

## 11. Historical Product Categories and Current Risk

Previous product history also shows variation in current default rates.

Higher observed default rates include:

- Vehicles: **9.63%**
- Auto Accessories: **8.95%**
- Jewelry: **8.79%**
- Mobile: **8.61%**
- Office Appliances: **8.33%**

Lower observed rates include:

- Furniture: **5.93%**
- Other: **5.75%**
- Clothing and Accessories: **5.63%**
- Medical Supplies: **5.48%**
- Tourism: **4.37%**

These categories describe customers who historically had applications associated with each product.

A customer may appear in multiple product categories, so these groups are not mutually exclusive.

Product history may provide useful additional segmentation information but should not be interpreted as a direct cause of default.

---

## 12. Historical Status Profile

Combining previous approval and refusal history creates another useful customer segmentation.

### Refused History Only

- Customers: **599**
- Current default rate: **10.85%**

### Mixed Approval/Refusal History

- Customers: **99,695**
- Current default rate: **10.32%**

### Approved History Only

- Customers: **190,370**
- Current default rate: **7.08%**

### Other Historical Status

- Customers: **393**
- Current default rate: **5.34%**

Customers with mixed approval/refusal histories have a substantially higher observed default rate than customers with approved-only histories.

The refused-only segment also has a high default rate but contains only 599 customers, so its result should be interpreted with greater caution.

---

## Day 4 Key Takeaways

1. **Historical credit behavior provides meaningful information about current default risk.**

2. Previous refusal count shows a clear risk gradient: current default rates increase from **7.07% with no previous refusals to 13.34% with four or more refusals**.

3. Historical approval rate is another strong indicator. Customers with a **1–25% historical approval rate have a 14.65% current default rate**, compared with **6.95% among customers with a 76–100% approval rate**.

4. Customers with **four or more previous approvals** have a relatively low current default rate of **6.97%**.

5. Previous application frequency by itself is less predictive because default rates do not increase consistently with application count.

6. Customers with both approval and refusal history show a **10.32%** current default rate compared with **7.08%** for customers with approved-only histories.

7. Previous product history shows meaningful variation, but product groups can overlap and should not be interpreted as independent customer segments.

8. Historical application behavior can complement the demographic, financial, employment, and external credit indicators identified during Days 2 and 3.

9. The results support using both **current applicant characteristics and historical credit behavior** when constructing more comprehensive borrower-risk segmentation.

---

# Day 5 — Advanced Risk Analytics & Enhanced Risk Segmentation

## 1. Overall Portfolio Risk Summary

The current application portfolio contains:

- Total applications: **307,511**
- Total defaults: **24,825**
- Overall default rate: **8.07%**
- Total credit exposure: approximately **184.21 billion**
- Credit exposure associated with defaulted applications: approximately **13.85 billion**

Although defaulted applications represent a relatively small portion of the overall portfolio, they are associated with a substantial amount of credit exposure.

This highlights the importance of identifying concentrated high-risk borrower groups rather than relying only on the overall portfolio default rate.

---

## 2. Credit Exposure by Default Status

Credit exposure is heavily concentrated among non-defaulting applications.

### Non-Default

- Applications: **282,686**
- Total credit exposure: approximately **170.36 billion**
- Average credit amount: **602,648.28**
- Share of total exposure: **92.48%**

### Default

- Applications: **24,825**
- Total credit exposure: approximately **13.85 billion**
- Average credit amount: **557,778.53**
- Share of total exposure: **7.52%**

Defaulted applications account for **7.52% of total credit exposure**.

Interestingly, the average credit amount among defaulted applications is lower than among non-defaulted applications.

This suggests that higher loan size alone does not explain default behavior within this portfolio.

---

## 3. External Credit Score + Age Risk

Combining external credit score with customer age produces strong risk differentiation.

### Highest-Risk Combination

**Low External Score + Under 40**

- Applications: **24,456**
- Defaults: **4,740**
- Default rate: **19.38%**

Other higher-risk combinations include:

- Low Score + Age 40–59: **13.94%**
- Medium-Low Score + Under 40: **11.53%**
- Low Score + Age 60+: **8.83%**

### Lower-Risk Combinations

- High Score + Under 40: **3.81%**
- High Score + Age 40–59: **3.25%**
- High Score + Age 60+: **2.22%**

The difference between the highest and lowest observed combinations is substantial:

**19.38% vs 2.22%**

Within every external-score category, younger customers generally show higher observed default rates than older customers.

However, external credit score remains a strong differentiator across all age groups.

---

## 4. External Credit Score + Previous Refusal History

Combining current external credit information with historical refusal behavior produces even stronger segmentation.

### Highest Observed Risk

**Low Score + 4+ Previous Refusals**

- Customers: **3,599**
- Current default rate: **23.01%**

Other high-risk combinations include:

- Low Score + 2–3 previous refusals: **19.96%**
- Low Score + 1 previous refusal: **16.51%**
- Medium-Low Score + 4+ previous refusals: **15.08%**
- Low Score + no previous refusals: **14.25%**

### Lowest Observed Risk

**High Score + No Previous Refusals**

- Customers: **29,391**
- Current default rate: **2.78%**

Other lower-risk combinations include:

- High Score + 1 previous refusal: **4.04%**
- High Score + 2–3 previous refusals: **5.18%**
- High Score + 4+ previous refusals: **5.97%**

The highest-risk combination has more than **8 times** the observed default rate of the lowest-risk combination.

Within each external-score group, customers with more historical refusals generally show higher current default rates.

This demonstrates the value of combining current credit indicators with historical application behavior.

---

## 5. External Credit Score + Historical Approval Rate

Historical approval performance provides additional separation when combined with external credit score.

### Highest-Risk Combination

**Low Score + 0–25% Historical Approval Rate**

- Customers: **2,526**
- Current default rate: **25.81%**

Other high-risk combinations include:

- Low Score + 26–50% approved: **19.63%**
- Medium-Low Score + 0–25% approved: **16.62%**
- Low Score + 51–75% approved: **14.50%**
- Low Score + 76–100% approved: **13.94%**

### Lowest-Risk Combination

**High Score + 76–100% Historical Approval Rate**

- Customers: **22,612**
- Current default rate: **2.60%**

Other lower-risk combinations include:

- High Score + 51–75% approved: **3.55%**
- High Score + 26–50% approved: **4.78%**
- High Score + 0–25% approved: **5.89%**

The highest-risk combination has nearly **10 times** the observed default rate of the lowest-risk combination.

This is one of the strongest risk separations identified across the project.

Customers with weaker current external credit scores and weaker historical approval performance form a particularly high-risk group.

---

## 6. Enhanced Multi-Factor Risk Segmentation

The final Day 5 segmentation expands the Day 3 risk framework by incorporating historical application behavior.

Five risk indicators are used:

1. External Score 2 below 0.50
2. Customer age below 40
3. Employment history below 3 years
4. Annuity-to-income ratio of at least 25%
5. At least one previous refused application

Customers are then classified based on the number of risk indicators present.

### High Risk

- Applications: **15,184**
- Defaults: **2,787**
- Default rate: **18.35%**
- Total credit exposure: approximately **8.62 billion**

### Elevated Risk

- Applications: **48,919**
- Defaults: **6,515**
- Default rate: **13.32%**
- Total credit exposure: approximately **27.63 billion**

### Moderate Risk

- Applications: **91,548**
- Defaults: **8,065**
- Default rate: **8.81%**
- Total credit exposure: approximately **54.81 billion**

### Low Risk

- Applications: **151,860**
- Defaults: **7,458**
- Default rate: **4.91%**
- Total credit exposure: approximately **93.15 billion**

The enhanced segmentation produces a clear risk gradient:

**4.91% → 8.81% → 13.32% → 18.35%**

The High Risk segment has approximately **3.7 times** the observed default rate of the Low Risk segment.

This demonstrates that combining demographic, employment, affordability, external credit, and historical behavioral indicators creates substantially stronger risk differentiation than relying on individual variables.

---

## 7. Portfolio Concentration by Enhanced Risk Segment

The enhanced segmentation also shows how defaults are distributed across the portfolio.

### Low Risk

- **49.38%** of applications
- **30.04%** of all defaults

### Moderate Risk

- **29.77%** of applications
- **32.49%** of all defaults

### Elevated Risk

- **15.91%** of applications
- **26.24%** of all defaults

### High Risk

- **4.94%** of applications
- **11.23%** of all defaults

The High Risk segment represents only **4.94% of the portfolio**, yet it contributes **11.23% of all defaults**.

Combining the High and Elevated Risk segments:

- They represent approximately **20.85% of applications**
- They account for approximately **37.47% of all defaults**

This demonstrates meaningful concentration of default risk within a relatively small portion of the portfolio.

---

## 8. Comparison with the Day 3 Risk Framework

Day 3 used four current-application risk indicators:

- External credit score
- Age
- Employment stability
- Payment burden

Day 5 adds a fifth behavioral indicator:

- Previous refusal history

The Day 3 High Risk segment had an observed default rate of **15.48%**.

The enhanced Day 5 High Risk segment has an observed default rate of **18.35%**.

The enhanced framework therefore creates a smaller and more concentrated high-risk group by incorporating historical credit application behavior.

This supports the broader finding from Day 4 that previous refusals contain useful information about current borrower risk.

---

## 9. Key Risk Drivers Identified Across the Project

The complete analysis identifies several characteristics associated with elevated observed default rates.

### External Credit Score

External credit score is one of the strongest individual risk differentiators.

Lower external scores consistently correspond with higher observed default rates.

### Age

Younger customers generally show higher observed default rates, particularly when combined with weaker credit scores.

### Employment Stability

Short employment history is associated with elevated risk, especially among younger customers and customers with weaker external credit scores.

### Historical Refusals

Repeated historical refusals show a clear relationship with higher current default rates.

### Historical Approval Performance

Low historical approval rates, particularly when combined with weak external credit scores, identify some of the highest-risk groups in the portfolio.

### Financial Burden

Credit-to-income and annuity-to-income measures provide useful affordability context, although financial burden alone does not create a perfectly monotonic default-risk pattern.

The strongest segmentation is achieved when several of these indicators are analyzed together.

---

## 10. Business Interpretation

The analysis suggests that credit risk should not be evaluated using a single borrower characteristic.

A more informative risk assessment combines:

- Current external credit information
- Customer demographics
- Employment stability
- Payment affordability
- Historical credit application behavior

For example:

**Low External Score + 0–25% Historical Approval Rate**

shows a **25.81% current default rate**.

By comparison:

**High External Score + 76–100% Historical Approval Rate**

shows only a **2.60% current default rate**.

This large difference demonstrates how combining current and historical information can identify materially different borrower-risk profiles.

---

## Day 5 Key Takeaways

1. The portfolio contains **307,511 applications** with an overall observed default rate of **8.07%**.

2. Approximately **13.85 billion** of credit exposure is associated with defaulted applications.

3. Combining age with external credit score separates default rates from **19.38% for Low Score + Under 40** to **2.22% for High Score + Age 60+**.

4. Historical refusals strengthen risk segmentation. Customers with a **Low Score + 4+ Previous Refusals** have a **23.01%** default rate compared with **2.78% for High Score + No Previous Refusals**.

5. Historical approval performance provides even stronger differentiation. **Low Score + 0–25% Approved** reaches **25.81%**, while **High Score + 76–100% Approved** records only **2.60%**.

6. The enhanced multi-factor segmentation produces a clear default-risk progression:

   **Low Risk 4.91% → Moderate Risk 8.81% → Elevated Risk 13.32% → High Risk 18.35%**

7. The High Risk segment represents only **4.94% of applications but contributes 11.23% of all defaults**.

8. High and Elevated Risk segments together represent approximately **20.85% of the portfolio while contributing 37.47% of all defaults**.

9. Adding previous refusal history to the Day 3 framework increases the observed default rate of the most concentrated High Risk segment from **15.48% to 18.35%**.

10. The overall analysis demonstrates that combining current borrower characteristics with historical credit behavior provides substantially stronger descriptive risk segmentation than analyzing individual variables independently.

---

## Analytical Note

The risk segments created in this project are analyst-designed descriptive segments based on observed historical relationships.

They are not a trained machine-learning credit scoring model and should not be interpreted as causal relationships or production lending decisions.

The analysis demonstrates SQL-based portfolio segmentation, historical behavior analysis, and credit-risk exploration using the available dataset.