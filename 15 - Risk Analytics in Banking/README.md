# 🏦 Banking Credit Risk & Loan Default Analytics

## 📌 Project Overview

This project analyzes a large banking credit dataset to identify borrower characteristics, financial conditions, and historical application behaviors associated with loan default risk.

The analysis combines current loan application data with historical application records to explore:

- Portfolio-level default risk
- Customer financial characteristics
- Demographic and employment-related risk patterns
- Credit affordability and payment burden
- External credit score behavior
- Previous approval and refusal history
- Multi-factor borrower risk segmentation
- Credit exposure across risk segments

The project was completed using **SQL and DuckDB** and progresses from exploratory portfolio analysis to an analyst-designed enhanced risk segmentation framework.

> **Important:** The risk segments created in this project are descriptive analytical segments based on observed historical relationships. They are not a trained machine-learning credit scoring model and should not be used as production lending decisions.

---

# 🎯 Business Objective

The objective of this project is to answer a core credit-risk question:

> **Which borrower characteristics and historical credit behaviors are associated with higher observed default risk?**

The analysis focuses on identifying patterns that could help a financial institution better understand:

- Which borrower groups show elevated default rates
- How financial burden relates to default behavior
- Whether employment stability affects credit risk
- How external credit scores differentiate borrowers
- Whether previous approvals and refusals contain useful risk information
- Whether multiple risk indicators can be combined to identify concentrated high-risk segments

---

# 📂 Dataset Overview

The project uses three source files.

### `application_data.csv`

Contains current loan application information.

- **307,511 applications**
- **122 columns**
- Includes customer demographics, income, credit amount, annuity, employment history, external credit scores, asset ownership, housing information, and the target variable.

### `previous_application.csv`

Contains historical credit applications associated with customers.

- **1,670,214 previous applications**
- **37 columns**
- **338,857 unique historical customers**
- Includes previous approval/refusal status, contract type, requested amount, credit amount, product category, and rejection reason.

### `columns_description.csv`

Contains metadata and descriptions for dataset fields.

The current and historical application datasets are connected using:

```text
SK_ID_CURR
```

---

# 🎯 Target Variable

The primary outcome analyzed in this project is:

```text
TARGET
```

Where:

```text
TARGET = 0 → Non-default / no payment difficulty
TARGET = 1 → Payment difficulty / default-risk case
```

The project analyzes how borrower characteristics and historical behaviors differ across these two groups.

---

# 🛠️ Tools & Technologies

- **SQL**
- **DuckDB**
- **Visual Studio Code**
- **Git**
- **GitHub**

---

# 📁 Project Structure

```text
15-Banking-Credit-Risk-Analytics/
│
├── data/
│   ├── application_data.csv
│   ├── previous_application.csv
│   └── columns_description.csv
│
├── SQL/
│   ├── schema.sql
│   └── queries.sql
│
├── insights.md
└── README.md
```

---

# 🗄️ Database Setup

DuckDB was used as the analytical database.

Two primary tables were created:

```sql
applications
previous_applications
```

The source CSV files were loaded using DuckDB's automatic CSV schema detection.

Example:

```sql
CREATE OR REPLACE TABLE applications AS
SELECT *
FROM read_csv_auto(
    'data/application_data.csv',
    HEADER = TRUE,
    SAMPLE_SIZE = -1
);
```

---

# 📊 Portfolio Overview

The current credit portfolio contains:

| Metric | Result |
|---|---:|
| Total Applications | 307,511 |
| Non-Default Applications | 282,686 |
| Default Applications | 24,825 |
| Overall Default Rate | 8.07% |
| Total Credit Exposure | 184.21B |
| Credit Exposure Associated with Defaults | 13.85B |

Approximately **91.93%** of applications are non-default cases, while **8.07%** are classified as default/payment-difficulty cases.

Defaulted applications account for approximately **7.52% of total credit exposure**.

---

# 💰 Credit & Income Profile

The portfolio has:

| Metric | Result |
|---|---:|
| Average Credit Amount | 599,026 |
| Minimum Credit Amount | 45,000 |
| Maximum Credit Amount | 4,050,000 |
| Average Customer Income | 168,797.92 |
| Median Customer Income | 147,150 |

The maximum recorded income is **117,000,000**, indicating the presence of extreme values in the income distribution.

Because of this, median income provides useful context alongside the average.

---

# 💳 Loan Contract Analysis

Most current applications are Cash Loans.

| Contract Type | Applications | Portfolio Share | Default Rate |
|---|---:|---:|---:|
| Cash Loans | 278,232 | 90.48% | 8.35% |
| Revolving Loans | 29,279 | 9.52% | 5.48% |

Cash Loans show a higher observed default rate than Revolving Loans.

---

# 💵 Income & Default Risk

Default rates vary across income groups.

| Income Band | Default Rate |
|---|---:|
| Below 100K | 8.20% |
| 100K–150K | 8.62% |
| 150K–200K | 8.45% |
| 200K–300K | 7.55% |
| 300K+ | 5.95% |

Higher-income applicants generally show lower observed default risk, particularly among customers earning more than 300K.

However, the relationship is not perfectly linear, showing that income alone is insufficient for borrower-risk classification.

---

# 📈 Credit-to-Income Analysis

Credit-to-income ratios were calculated as:

```text
AMT_CREDIT / AMT_INCOME_TOTAL
```

Observed default rates were:

| Credit-to-Income Band | Default Rate |
|---|---:|
| Below 2x | 7.48% |
| 2x–4x | 8.77% |
| 4x–6x | 8.20% |
| 6x+ | 7.23% |

The relationship is non-linear.

Borrowers receiving the largest credit amounts relative to income do not automatically have the highest default rates.

This suggests that credit-to-income ratio should be interpreted alongside other underwriting characteristics.

---

# 💸 Payment Burden Analysis

Annuity burden was calculated as:

```text
AMT_ANNUITY / AMT_INCOME_TOTAL
```

| Annuity-to-Income Band | Default Rate |
|---|---:|
| Below 15% | 7.55% |
| 15%–25% | 8.44% |
| 25%–35% | 8.70% |
| 35%+ | 8.07% |

Risk generally rises through the 25%–35% segment but declines slightly in the highest burden group.

Therefore, payment burden alone does not produce a perfectly monotonic risk relationship.

---

# 👤 Age & Default Risk

Age is one of the clearest borrower-risk indicators identified in the project.

| Age Group | Default Rate |
|---|---:|
| Under 30 | 11.44% |
| 30–39 | 9.59% |
| 40–49 | 7.64% |
| 50–59 | 6.12% |
| 60+ | 4.92% |

Observed default rates decline consistently with age.

Applicants under 30 have more than twice the observed default rate of applicants aged 60+.

---

# 💼 Employment Stability

Employment history also shows a strong relationship with observed default risk.

| Employment History | Default Rate |
|---|---:|
| Less than 1 year | 10.97% |
| 1–3 years | 11.07% |
| 3–5 years | 9.67% |
| 5–10 years | 7.37% |
| 10+ years | 5.19% |

Borrowers with longer employment histories generally show lower observed default rates.

Customers with more than 10 years of employment have less than half the observed default rate of customers with approximately 1–3 years of employment.

The dataset's special:

```text
DAYS_EMPLOYED = 365243
```

value was treated separately rather than interpreted as actual employment tenure.

---

# 🎓 Education Risk

Default rates also vary by education level.

| Education | Default Rate |
|---|---:|
| Lower Secondary | 10.93% |
| Secondary / Secondary Special | 8.94% |
| Incomplete Higher | 8.48% |
| Higher Education | 5.36% |
| Academic Degree | 1.83% |

Higher education is associated with lower observed default rates in this dataset.

The Academic Degree category contains only **164 applications**, so its result should be interpreted cautiously.

---

# 👷 Occupation Risk

Occupation shows substantial variation in default behavior.

Some higher observed default-rate occupations include:

| Occupation | Default Rate |
|---|---:|
| Low-skill Laborers | 17.15% |
| Drivers | 11.33% |
| Waiters/Barmen Staff | 11.28% |
| Security Staff | 10.74% |
| Laborers | 10.58% |
| Cooking Staff | 10.44% |

Lower observed default-rate occupations include:

| Occupation | Default Rate |
|---|---:|
| Accountants | 4.83% |
| High Skill Tech Staff | 6.16% |
| Managers | 6.21% |
| Core Staff | 6.30% |
| Private Service Staff | 6.60% |

Occupation provides useful segmentation information when combined with income and employment stability.

---

# 🏠 Asset Ownership

Borrowers owning neither a car nor real estate show the highest observed default rate among the ownership combinations analyzed.

| Car | Realty | Default Rate |
|---|---|---:|
| Yes | Yes | 7.33% |
| Yes | No | 7.04% |
| No | Yes | 8.28% |
| No | No | 8.99% |

Asset ownership provides additional socioeconomic context but should not be interpreted independently from income and other borrower characteristics.

---

# 👨‍👩‍👧 Household Risk

Default rates by number of children were:

| Children | Default Rate |
|---|---:|
| 0 | 7.71% |
| 1 | 8.92% |
| 2 | 8.72% |
| 3+ | 10.04% |

Applicants with three or more children show the highest observed default rate.

Larger family size also shows elevated risk, with households containing five or more members reaching a **9.91% default rate**.

---

# 📉 External Credit Scores

External credit variables provide some of the strongest risk differentiation in the project.

Average external scores are consistently lower among defaulted applications.

| Risk Status | EXT_SOURCE_1 | EXT_SOURCE_2 | EXT_SOURCE_3 |
|---|---:|---:|---:|
| Non-Default | 0.5115 | 0.5235 | 0.5210 |
| Default | 0.3870 | 0.4109 | 0.3907 |

---

# 🔍 EXT_SOURCE_2 Risk Bands

EXT_SOURCE_2 shows a particularly strong and consistent risk gradient.

| EXT_SOURCE_2 | Default Rate |
|---|---:|
| Below 0.30 | 15.88% |
| 0.30–0.50 | 9.66% |
| 0.50–0.70 | 6.09% |
| 0.70+ | 3.31% |

Borrowers in the lowest score group have almost five times the observed default rate of borrowers in the highest group.

---

# 🔗 Combined Risk Drivers

One of the key goals of the project was to move beyond single-variable analysis.

Combining borrower characteristics produces substantially stronger risk separation.

---

## Age + Income

The highest observed combination was:

```text
Under 30 + Income Below 150K
Default Rate = 12.47%
```

Compared with:

```text
Age 60+ + Income 300K+
Default Rate = 3.81%
```

This demonstrates how demographic and financial characteristics can interact when segmenting borrowers.

---

## Age + Employment

A high-risk combination was:

```text
Under 30
+
Less than 3 years employment
=
12.34% default rate
```

A lower-risk combination was:

```text
Age 60+
+
10+ years employment
=
3.54% default rate
```

---

## External Score + Employment

One of the strongest Day 3 combinations was:

```text
Low External Score
+
Less than 3 Years Employment
=
20.54% Default Rate
```

Compared with:

```text
High External Score
+
10+ Years Employment
=
2.52% Default Rate
```

This demonstrates the value of combining credit information with employment stability.

---

# 🧮 Initial Multi-Factor Risk Segmentation

An analyst-designed segmentation framework was created using four risk indicators:

1. `EXT_SOURCE_2 < 0.50`
2. Employment history below 3 years
3. Age below 40
4. Annuity-to-income ratio ≥ 25%

Customers were segmented based on the number of indicators present.

| Segment | Applications | Defaults | Default Rate |
|---|---:|---:|---:|
| Low Risk | 76,181 | 3,187 | 4.18% |
| Moderate Risk | 112,141 | 7,526 | 6.71% |
| Elevated Risk | 80,972 | 8,195 | 10.12% |
| High Risk | 38,217 | 5,917 | 15.48% |

The segmentation creates a clear risk gradient:

```text
4.18%
   ↓
6.71%
   ↓
10.12%
   ↓
15.48%
```

The High Risk segment has approximately **3.7 times** the observed default rate of the Low Risk segment.

High and Elevated Risk customers represent approximately **38.76% of applications but 56.84% of all defaults**.

---

# 🕒 Previous Application Analysis

The historical dataset contains:

```text
1,670,214 previous applications
338,857 unique customers
```

Historical application outcomes were:

| Status | Applications | Share |
|---|---:|---:|
| Approved | 1,036,781 | 62.07% |
| Canceled | 316,319 | 18.94% |
| Refused | 290,678 | 17.40% |
| Unused Offer | 26,436 | 1.58% |

Historical credit behavior provides important additional information about current borrower risk.

---

# 🔄 Previous Application Frequency

Customers were grouped based on their number of historical applications.

| History | Customers |
|---|---:|
| 1 Previous Application | 60,458 |
| 2–3 Previous Applications | 98,703 |
| 4–5 Previous Applications | 69,045 |
| 6+ Previous Applications | 110,651 |

However, application frequency alone does not produce a consistent default-risk gradient.

This suggests that the **outcome of historical applications is more informative than application count alone**.

---

# ❌ Previous Refusals & Current Default Risk

Historical refusal count shows a clear relationship with current default behavior.

| Previous Refusals | Current Default Rate |
|---|---:|
| None | 7.07% |
| 1 | 8.83% |
| 2–3 | 10.65% |
| 4+ | 13.34% |

Current default risk rises consistently as previous refusals increase.

Customers with four or more previous refusals have approximately **1.9 times** the observed default rate of customers with no previous refusals.

---

# ✅ Historical Approval Rate

Historical approval percentage also provides strong risk differentiation.

| Historical Approval Rate | Current Default Rate |
|---|---:|
| 1–25% | 14.65% |
| 26–50% | 10.42% |
| 0% | 8.67% |
| 51–75% | 7.57% |
| 76–100% | 6.95% |

Among customers with historical approvals, higher approval rates are generally associated with lower current default risk.

---

# 🔀 Historical Status Profile

Customers with both approved and refused historical applications show higher observed current risk than customers with approved-only histories.

| Historical Profile | Current Default Rate |
|---|---:|
| Refused History Only | 10.85% |
| Mixed Approval/Refusal | 10.32% |
| Approved History Only | 7.08% |
| Other Historical Status | 5.34% |

The refused-only group contains relatively few customers, so its result should be interpreted cautiously.

---

# 🧠 Current + Historical Risk Analysis

Day 5 combines current borrower characteristics with historical application behavior.

This produces some of the strongest risk separation in the project.

---

## External Score + Age

The highest-risk combination was:

```text
Low External Score
+
Under 40
=
19.38% Default Rate
```

Compared with:

```text
High External Score
+
Age 60+
=
2.22% Default Rate
```

---

## External Score + Previous Refusals

Historical refusals significantly strengthen external-score segmentation.

### Highest Observed Risk

```text
Low External Score
+
4+ Previous Refusals
=
23.01% Default Rate
```

### Lowest Observed Risk

```text
High External Score
+
No Previous Refusals
=
2.78% Default Rate
```

The highest-risk combination has more than **8 times** the observed default rate of the lowest-risk combination.

---

# ⭐ External Score + Historical Approval Performance

One of the strongest findings in the entire project comes from combining external credit score with historical approval rate.

### Highest-Risk Combination

```text
Low External Score
+
0–25% Historical Approval Rate
=
25.81% Default Rate
```

### Lowest-Risk Combination

```text
High External Score
+
76–100% Historical Approval Rate
=
2.60% Default Rate
```

This represents nearly a **10x difference in observed default risk**.

It demonstrates that combining current credit indicators with historical application behavior can create much stronger risk differentiation than either factor alone.

---

# 🚨 Enhanced Multi-Factor Risk Segmentation

The final segmentation framework expands the initial model to include five indicators:

```text
External Credit Score
        +
Age
        +
Employment Stability
        +
Payment Burden
        +
Previous Refusal History
```

The five analytical risk indicators are:

1. `EXT_SOURCE_2 < 0.50`
2. Age below 40
3. Employment history below 3 years
4. Annuity-to-income ratio ≥ 25%
5. At least one previous refusal

The resulting segments are:

| Enhanced Risk Segment | Applications | Defaults | Default Rate | Credit Exposure |
|---|---:|---:|---:|---:|
| Low Risk | 151,860 | 7,458 | 4.91% | 93.15B |
| Moderate Risk | 91,548 | 8,065 | 8.81% | 54.81B |
| Elevated Risk | 48,919 | 6,515 | 13.32% | 27.63B |
| High Risk | 15,184 | 2,787 | 18.35% | 8.62B |

The final risk gradient is:

```text
Low Risk       4.91%
                  ↓
Moderate Risk  8.81%
                  ↓
Elevated Risk 13.32%
                  ↓
High Risk     18.35%
```

The High Risk segment has approximately **3.7 times** the observed default rate of the Low Risk segment.

---

# 🎯 Risk Concentration

The enhanced segmentation identifies concentrated areas of portfolio risk.

| Segment | Portfolio Share | Share of Defaults |
|---|---:|---:|
| Low Risk | 49.38% | 30.04% |
| Moderate Risk | 29.77% | 32.49% |
| Elevated Risk | 15.91% | 26.24% |
| High Risk | 4.94% | 11.23% |

The High Risk segment represents only:

```text
4.94% of applications
```

but contributes:

```text
11.23% of all defaults
```

High + Elevated Risk customers together represent:

```text
20.85% of applications
```

while contributing:

```text
37.47% of all defaults
```

This demonstrates meaningful concentration of default risk within a relatively small portion of the portfolio.

---

# 📈 Initial vs Enhanced Risk Segmentation

Adding previous refusal history improves the concentration of the highest-risk group.

| Framework | High-Risk Default Rate |
|---|---:|
| Day 3 — Current Application Indicators | 15.48% |
| Day 5 — Current + Historical Indicators | 18.35% |

The enhanced framework creates a smaller but more concentrated High Risk segment.

This supports the finding that historical credit behavior contains useful information beyond current borrower characteristics.

---

# 💡 Key Business Insights

### 1. External credit information is one of the strongest risk differentiators.

Borrowers with lower external scores consistently show substantially higher observed default rates.

### 2. Younger borrowers show elevated risk.

Default rates decline consistently with age, from **11.44% among applicants under 30 to 4.92% among applicants aged 60+**.

### 3. Employment stability matters.

Borrowers with more than 10 years of employment show a **5.19% default rate**, compared with approximately 11% among borrowers with less than three years of employment.

### 4. Historical refusals provide useful behavioral information.

Default rates increase from **7.07% among customers with no previous refusals to 13.34% among customers with four or more refusals**.

### 5. Historical approval performance is highly informative.

Customers with stronger historical approval performance generally show lower current default rates.

### 6. Combined indicators outperform isolated metrics descriptively.

The strongest observed risk groups emerge when external credit information is combined with age, employment, affordability, and historical behavior.

### 7. Risk is concentrated.

The enhanced High Risk segment represents only **4.94% of applications but 11.23% of defaults**.

### 8. Financial burden alone is insufficient.

Credit-to-income and annuity-to-income relationships are not perfectly monotonic, demonstrating why affordability measures should be interpreted alongside broader borrower information.

---

# 🧾 Executive Summary

The analysis began with **307,511 current applications** and an overall observed default rate of **8.07%**.

Single-variable analysis identified several characteristics associated with elevated risk, including:

- Younger age
- Shorter employment history
- Lower external credit scores
- Certain occupation groups
- Lower income segments
- Larger household/dependent groups

The analysis then incorporated **1.67 million historical applications**.

Historical refusal count and approval performance provided additional risk information.

The strongest observed borrower combination was:

```text
Low External Score
+
0–25% Historical Approval Rate
=
25.81% Default Rate
```

compared with:

```text
High External Score
+
76–100% Historical Approval Rate
=
2.60% Default Rate
```

Finally, an enhanced five-factor segmentation classified borrowers using external score, age, employment stability, payment burden, and previous refusal history.

This produced a clear progression from:

```text
4.91% Low Risk
```

to:

```text
18.35% High Risk
```

The project demonstrates how SQL can be used not only for data extraction and aggregation, but also for **credit portfolio analysis, customer segmentation, historical behavior analysis, risk concentration analysis, and business-focused decision support**.

---

# 🧠 SQL Concepts Demonstrated

This project uses a wide range of SQL techniques, including:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `CASE WHEN`
- Aggregate functions
  - `COUNT()`
  - `SUM()`
  - `AVG()`
- `COUNT(DISTINCT)`
- Conditional aggregation
- Common Table Expressions (`WITH`)
- Multiple CTE pipelines
- `INNER JOIN`
- `LEFT JOIN`
- Window functions
- `NULLIF()`
- `COALESCE()`
- Ratio calculations
- Percentage calculations
- Customer-level aggregation
- Multi-table historical analysis
- Analytical risk scoring
- Portfolio segmentation
- Credit exposure analysis

---

# 🔍 Example SQL — Historical Refusal Risk

```sql
WITH refusal_history AS (
    SELECT
        SK_ID_CURR,
        SUM(
            CASE
                WHEN NAME_CONTRACT_STATUS = 'Refused'
                THEN 1
                ELSE 0
            END
        ) AS previous_refusals
    FROM previous_applications
    GROUP BY SK_ID_CURR
)

SELECT
    CASE
        WHEN previous_refusals = 0 THEN 'No Previous Refusals'
        WHEN previous_refusals = 1 THEN '1 Previous Refusal'
        WHEN previous_refusals BETWEEN 2 AND 3 THEN '2-3 Previous Refusals'
        ELSE '4+ Previous Refusals'
    END AS refusal_history_group,

    COUNT(*) AS total_customers,

    ROUND(
        AVG(a.TARGET) * 100,
        2
    ) AS current_default_rate_percentage

FROM applications a

INNER JOIN refusal_history r
    ON a.SK_ID_CURR = r.SK_ID_CURR

GROUP BY refusal_history_group
ORDER BY current_default_rate_percentage DESC;
```

---

# 🔍 Example SQL — Multi-Factor Risk Logic

The final segmentation uses multiple borrower signals rather than relying on one variable.

```sql
CASE WHEN EXT_SOURCE_2 < 0.50
    THEN 1 ELSE 0 END
+
CASE WHEN ABS(DAYS_BIRTH) / 365.25 < 40
    THEN 1 ELSE 0 END
+
CASE
    WHEN DAYS_EMPLOYED != 365243
         AND ABS(DAYS_EMPLOYED) / 365.25 < 3
    THEN 1 ELSE 0
END
+
CASE
    WHEN AMT_ANNUITY /
         NULLIF(AMT_INCOME_TOTAL, 0) >= 0.25
    THEN 1 ELSE 0
END
+
CASE
    WHEN previous_refusals >= 1
    THEN 1 ELSE 0
END
```

This creates a simple and interpretable analytical risk-factor count.

---

# ▶️ How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/teja-naidu/SQL-Projects.git
```

### 2. Navigate to the project directory

```bash
cd "15-Banking-Credit-Risk-Analytics"
```

### 3. Start DuckDB

```bash
duckdb banking_risk.duckdb
```

### 4. Create/load the tables

Inside DuckDB:

```sql
.read SQL/schema.sql
```

### 5. Run the complete analysis

```sql
.read SQL/queries.sql
```

The query file contains the complete analytical workflow developed across all five project days.

---

# 🗓️ Five-Day Project Workflow

### Day 1 — Data Setup & Portfolio Overview

- Loaded current and historical application datasets
- Validated record counts
- Analyzed overall default rate
- Measured credit exposure
- Examined contract, income, family, and housing characteristics

### Day 2 — Customer Financial & Credit Risk

- Income segmentation
- Credit-to-income analysis
- Payment burden
- Credit amount segmentation
- Age analysis
- Employment stability
- Education and occupation
- Asset ownership
- External credit scores

### Day 3 — Default Drivers & Risk Segmentation

- Combined demographic and financial indicators
- Age + income analysis
- Age + employment analysis
- External score + employment analysis
- Financial stress segmentation
- Built initial four-factor risk framework
- Measured portfolio default concentration

### Day 4 — Historical Application Analysis

- Previous approval/refusal outcomes
- Contract and product history
- Rejection reasons
- Previous application frequency
- Historical refusals vs current defaults
- Historical approvals vs current defaults
- Historical approval-rate analysis
- Historical status profiling

### Day 5 — Advanced Risk Analytics

- Credit exposure analysis
- External score + age analysis
- External score + refusal history
- External score + historical approval performance
- Enhanced five-factor risk segmentation
- Portfolio risk concentration analysis
- Final business interpretation

---

# ⚠️ Analytical Limitations

This project is an exploratory and descriptive credit-risk analysis.

Important limitations include:

- Observed relationships should not be interpreted as causal.
- The custom risk segments are analyst-defined and have not been statistically calibrated or validated as a predictive model.
- Some categories contain small sample sizes and therefore require cautious interpretation.
- Historical product categories can overlap because a customer may have multiple previous applications.
- Historical analyses using joins apply to customers with matching historical application records.
- Missing values and dataset-specific sentinel values require careful handling.
- Extreme values exist in financial variables such as income.
- Rejection codes should not be assigned business definitions without supporting dataset documentation.
- Credit amounts associated with refused historical applications should not automatically be interpreted as disbursed loans.
- Real-world lending decisions require model validation, fairness analysis, regulatory review, and additional underwriting controls.

---

# 🚀 Potential Future Enhancements

Future versions of the project could include:

- Logistic regression
- Decision trees or gradient boosting
- Feature importance analysis
- ROC-AUC evaluation
- Precision/recall analysis
- Probability-of-default modeling
- Model calibration
- Vintage analysis
- Default exposure analysis
- Interactive Tableau or Power BI dashboard
- Automated DuckDB analytical pipeline
- Statistical significance testing
- Fairness and bias evaluation
- More advanced historical sequence analysis

---

# 📌 Conclusion

This project demonstrates an end-to-end SQL approach to **banking credit-risk and loan-default analytics**.

Starting from more than **300K current applications** and **1.67M historical applications**, the analysis progresses from basic portfolio profiling to multidimensional borrower segmentation.

The strongest findings show that:

- External credit information provides substantial risk differentiation.
- Age and employment stability are strongly associated with observed default behavior.
- Historical refusals and approval performance provide additional behavioral risk information.
- Individual affordability metrics alone do not fully explain default behavior.
- Combining current borrower characteristics with historical credit behavior produces substantially stronger risk segmentation.

The final enhanced segmentation separates borrowers from a **4.91% observed default rate in the Low Risk segment to 18.35% in the High Risk segment**.

Overall, the project demonstrates how SQL can transform large-scale financial data into actionable portfolio-level risk insights through **data profiling, aggregation, customer-level joins, behavioral analysis, exposure analysis, and interpretable risk segmentation**.