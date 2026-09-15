# Credit Card Transaction & Fraud Pattern Analytics - Insights

## Day 1 - Dataset Exploration & Core KPIs

### Dataset Overview

- The dataset contains **284,807 credit card transactions**.
- The transactions span approximately **48 hours**.
- No missing values were found in the key fields `Time`, `Amount`, and `Class`.
- The dataset contains anonymized transaction features `V1` through `V28`, along with transaction time, amount, and fraud classification.

### Fraud Distribution

- **284,315 transactions** were classified as legitimate.
- Only **492 transactions** were identified as fraudulent.
- The overall fraud rate was approximately **0.1727%**.
- This indicates a highly imbalanced dataset where fraudulent activity represents only a very small portion of all transactions.

### Transaction Value Analysis

- The total transaction value across the dataset was approximately **$25.16 million**.
- The overall average transaction amount was **$88.35**.

### Legitimate Transactions

- Total legitimate transactions: **284,315**
- Total legitimate transaction amount: **$25,102,462.04**
- Average legitimate transaction amount: **$88.29**
- Maximum legitimate transaction amount: **$25,691.16**

### Fraudulent Transactions

- Total fraudulent transactions: **492**
- Total fraudulent transaction amount: **$60,127.97**
- Average fraudulent transaction amount: **$122.21**
- Maximum fraudulent transaction amount: **$2,125.87**

### Key Findings

1. Fraudulent transactions account for only **0.1727%** of all transactions, highlighting significant class imbalance.

2. Despite being relatively rare, fraudulent transactions have a higher average transaction amount (**$122.21**) compared with legitimate transactions (**$88.29**).

3. Fraudulent transactions represent approximately **$60.13K** in transaction value within the 48-hour observation period.

4. The largest legitimate transaction (**$25,691.16**) is substantially higher than the largest fraudulent transaction (**$2,125.87**), suggesting that fraud is not concentrated only among the highest-value transactions.

5. The clean dataset and anonymized behavioral features provide a strong foundation for deeper fraud-pattern, transaction-value, and time-based risk analysis.

---

## Day 2 - Transaction Amount & Fraud Risk Analysis

### Median vs Average Transaction Amount

- Legitimate transactions had a median amount of **$22.00** and an average amount of **$88.29**.
- Fraudulent transactions had a much lower median amount of **$9.25**, despite having a higher average amount of **$122.21**.
- The large difference between the fraud median and average indicates that a relatively small number of high-value fraudulent transactions significantly increase the overall fraud average.

### Fraud Risk by Transaction Amount

Fraud was not distributed evenly across transaction value ranges.

- **$0 transactions** recorded the highest fraud rate at **1.4795%**, with 27 fraudulent transactions.
- Transactions between **$500.01 and $1,000** had a fraud rate of **0.4192%**.
- Transactions above **$1,000** had a fraud rate of **0.3061%**.
- Small transactions between **$0.01 and $10** had a fraud rate of **0.2255%**.
- The lowest fraud rate was observed in the **$10.01 to $50** range at only **0.0628%**.

This shows that transaction amount alone does not have a simple linear relationship with fraud risk.

### Fraud Transaction Concentration

The largest fraudulent transaction count occurred in the **$0.01 to $10** range:

- **222 fraud transactions** occurred between $0.01 and $10.
- These transactions represented only **$458.90** in fraudulent value, with an average amount of **$2.07**.

In contrast, the **$100.01 to $500** range contained only 95 fraudulent transactions but generated approximately **$21,913.81** in fraudulent transaction value.

### Fraudulent Transaction Value

- Total transaction value: **$25,162,590.01**
- Fraudulent transaction value: **$60,127.97**
- Fraudulent transactions represented approximately **0.239%** of total transaction value.

Although fraud represented only **0.1727% of transaction count**, it accounted for a slightly larger **0.239% of transaction value**.

### Zero-Value Transaction Pattern

- The dataset contained **1,825 zero-value transactions**.
- Of these, **27 were fraudulent** and 1,798 were legitimate.
- Zero-value transactions had a fraud rate of approximately **1.48%**, substantially higher than the overall dataset fraud rate of **0.1727%**.

This makes zero-value activity an interesting risk segment for further investigation.

### High-Value Transaction Analysis

For transactions above $1,000:

- **2,931 legitimate transactions** were recorded.
- Only **9 fraudulent transactions** were recorded.
- Legitimate high-value transactions averaged **$1,808.96**.
- Fraudulent high-value transactions averaged **$1,470.81**.
- The largest fraudulent transaction was **$2,125.87**, compared with a maximum legitimate transaction of **$25,691.16**.

Therefore, extremely high transaction values were not necessarily associated with higher fraud occurrence.

### Key Findings

1. Fraudulent transactions had a **lower median ($9.25)** but a **higher average ($122.21)** than legitimate transactions, indicating a highly skewed fraud amount distribution.

2. **222 of the 492 fraud transactions** occurred between $0.01 and $10, meaning approximately **45% of all fraud cases** were small-value transactions.

3. Small fraudulent transactions were frequent but had limited monetary impact, while the **$100.01-$500** and **$500.01-$1,000** ranges contributed substantially more fraudulent value.

4. Zero-value transactions showed a fraud rate of approximately **1.48%**, more than eight times the overall dataset fraud rate.

5. Fraud represented approximately **0.239% of total transaction value**, compared with only **0.1727% of transaction volume**.

6. Transaction value by itself is not sufficient to identify fraud. Both low-value and higher-value ranges exhibit distinct fraud patterns, suggesting that transaction amount should be combined with behavioral and temporal indicators for effective fraud detection.


---

## Day 3 - Time-Based Fraud Pattern Analysis

### Fraud Distribution Across the Dataset

The dataset covers approximately 48 hours of transaction activity.

- Day 1 contained **144,786 transactions**, including **281 fraudulent transactions**.
- Day 2 contained **140,021 transactions**, including **211 fraudulent transactions**.
- Fraudulent transaction value was approximately **$33,239.11** on Day 1 and **$26,888.86** on Day 2.
- Both fraud count and fraudulent transaction value were higher during the first 24-hour period.

### Hourly Fraud Concentration

Fraud activity was not evenly distributed throughout the observation period.

The highest fraud transaction counts occurred during:

- Hour 11: **43 fraud transactions**
- Hour 26: **36 fraud transactions**
- Hour 7: **23 fraud transactions**
- Hour 2: **21 fraud transactions**
- Hour 42: **18 fraud transactions**

Hour 11 recorded the highest number of fraudulent transactions, with **43 fraud cases** and approximately **$5,393.83** in fraudulent transaction value.

### Highest-Risk Hours

When hourly fraud rate was considered instead of fraud count, a different pattern emerged.

- Hour 26 recorded a fraud rate of **2.0548%**.
- Hour 28 recorded a fraud rate of **1.5084%**.
- Hour 2 recorded a fraud rate of **1.3325%**.
- Hour 3 recorded a fraud rate of **0.7139%**.
- Hour 7 recorded a fraud rate of **0.6829%**.

This demonstrates an important distinction between transaction volume and fraud risk. An hour with the largest number of fraud cases is not necessarily the hour with the highest probability of fraud.

### Fraudulent Transaction Value by Hour

The largest fraudulent transaction value was recorded during Hour 11:

- Fraud transactions: **43**
- Fraudulent value: **$5,393.83**
- Average fraudulent transaction: **$125.44**

Other notable periods included:

- Hour 42: **$3,367.58**
- Hour 36: **$3,181.65**
- Hour 18: **$2,977.56**
- Hour 17: **$2,916.38**

Hour 36 is particularly notable because only **8 fraud transactions** generated approximately **$3,181.65**, resulting in an average fraudulent transaction value of **$397.71**.

### Repeated 24-Hour Pattern

When the two-day dataset was grouped into repeated 24-hour positions, Hour 2 showed the strongest fraud-rate concentration.

- Hour 2 contained **57 fraud transactions** among 3,328 total transactions.
- The resulting fraud rate was approximately **1.7127%**.
- Hour 4 had the second-highest repeated-hour fraud rate at approximately **1.0412%**.

By comparison, several higher-volume periods showed considerably lower fraud rates.

### Six-Hour Window Analysis

The first six-hour window showed the highest fraud rate:

| Time Window | Transactions | Fraud Transactions | Fraud Rate | Fraud Amount |
|---|---:|---:|---:|---:|
| 00:00 - 05:59 | 23,934 | 124 | 0.5181% | $10,816.15 |
| 06:00 - 11:59 | 70,912 | 118 | 0.1664% | $14,371.84 |
| 12:00 - 17:59 | 96,435 | 134 | 0.1390% | $19,355.18 |
| 18:00 - 23:59 | 93,526 | 116 | 0.1240% | $15,584.80 |

Although the **00:00-05:59** window had the lowest transaction volume, it recorded the highest fraud rate at **0.5181%**.

The **12:00-17:59** window generated the largest fraudulent transaction value at approximately **$19,355.18**, but its fraud rate was only **0.1390%**.

### Key Findings

1. Fraud activity varied substantially across the 48-hour observation period rather than being evenly distributed.

2. Hour 11 recorded the highest absolute fraud count with **43 fraudulent transactions**, while Hour 26 recorded the highest hourly fraud rate among the analyzed hourly groups at **2.0548%**.

3. The difference between fraud count and fraud rate demonstrates why transaction volume must be considered when identifying high-risk periods.

4. The repeated Hour 2 position showed particularly elevated risk, with **57 fraud transactions and a 1.7127% fraud rate** across the two-day dataset.

5. The first six-hour window had a fraud rate of **0.5181%**, significantly higher than the other six-hour windows despite having the lowest transaction volume.

6. High fraud count, high fraud rate, and high financial exposure do not always occur during the same periods. Effective fraud monitoring should therefore consider all three metrics rather than relying on transaction counts alone.

### Analytical Note

The `Time` field represents elapsed seconds from the first transaction in the dataset rather than an actual calendar timestamp.

Therefore, labels such as `00:00 - 05:59` represent positions within a repeated 24-hour transaction cycle and should not be interpreted as confirmed real-world clock times or specific times of day.

---

## Day 4 - Fraud Feature & Behavioral Risk Analysis

### PCA Feature Separation

The anonymized PCA features showed substantial differences between legitimate and fraudulent transactions.

Ranking the features by the absolute difference between their average values identified the strongest separation in:

| Rank | Feature | Absolute Average Difference |
|---|---|---:|
| 1 | V3 | 7.0455 |
| 2 | V14 | 6.9838 |
| 3 | V17 | 6.6774 |
| 4 | V12 | 6.2702 |
| 5 | V10 | 5.6867 |
| 6 | V7 | 5.5784 |
| 7 | V1 | 4.7802 |
| 8 | V4 | 4.5499 |
| 9 | V16 | 4.1471 |
| 10 | V11 | 3.8067 |

V3 produced the largest average separation between legitimate and fraudulent transactions, followed closely by V14 and V17.

### Fraud vs Legitimate Feature Profiles

Several of the strongest features showed large differences between the two transaction classes.

For V3:

- Legitimate average: **0.0122**
- Fraud average: **-7.0333**
- Legitimate median: **0.1822**
- Fraud median: **-5.0753**

For V14:

- Legitimate average: **0.0121**
- Fraud average: **-6.9717**
- Legitimate median: **0.0519**
- Fraud median: **-6.7297**

For V17:

- Legitimate average: **0.0115**
- Fraud average: **-6.6658**
- Legitimate median: **-0.0648**
- Fraud median: **-5.3029**

Both average and median values show substantial separation, suggesting these anonymized features contain strong signals associated with fraud classification.

### V14 Risk Segmentation

Transactions were divided into four equal-sized groups based on V14 values.

The lowest V14 quartile contained:

- **71,202 total transactions**
- **463 fraudulent transactions**
- Fraud rate: **0.6503%**
- Fraudulent transaction value: **$52,896.91**

The remaining V14 quartiles contained only 29 fraud transactions combined.

This means approximately **94.1% of all fraud cases** were concentrated in the lowest V14 quartile.

The lowest V14 quartile also contained approximately **88.0% of total fraudulent transaction value**.

### V17 Risk Segmentation

The lowest V17 quartile also showed substantial fraud concentration:

- **71,202 total transactions**
- **381 fraudulent transactions**
- Fraud rate: **0.5351%**
- Fraudulent transaction value: **$47,647.37**

Approximately **77.4% of all fraud cases** occurred in the lowest V17 quartile.

Unlike V14, however, the highest V17 quartile still contained **83 fraud transactions**, showing that V17 alone does not capture all fraudulent activity.

### Combined V14 and V17 Risk Segment

A particularly strong pattern emerged when the two features were combined.

Transactions falling into both the lowest V14 and lowest V17 quartiles produced:

- **10,194 total transactions**
- **372 fraudulent transactions**
- Fraud rate: **3.6492%**
- Fraudulent transaction value: **$46,646.49**

All other transactions combined contained:

- **274,613 total transactions**
- **120 fraudulent transactions**
- Fraud rate: **0.0437%**
- Fraudulent transaction value: **$13,481.48**

Therefore, the combined low-V14/low-V17 segment represented only approximately **3.6% of all transactions**, while capturing approximately **75.6% of all fraud cases**.

The fraud rate in this segment was more than **80 times higher** than the fraud rate among all other transactions.

It also captured approximately **77.6% of total fraudulent transaction value**.

### High-Value Fraudulent Transactions

Ranking fraudulent transactions by transaction amount showed that many high-value fraud cases also had strongly negative V14 and/or V17 values.

The largest fraudulent transaction was **$2,125.87**, although its V14 and V17 values did not follow the strongly negative pattern seen in many other high-value fraud cases.

Other examples included:

- **$1,809.68** with V14 = -3.7380 and V17 = -5.1361
- **$1,504.93** with V14 = -6.1062 and V17 = -2.0841
- **$1,402.16** with V14 = -6.0434 and V17 = -10.0756
- **$1,218.89** with V14 = -10.1402 and V17 = -17.5066

This demonstrates that strong feature signals can identify many high-risk transactions, but no single feature pattern captures every fraudulent transaction.

### Key Findings

1. V3, V14, V17, V12, and V10 produced the five largest average differences between legitimate and fraudulent transactions.

2. V14 showed particularly strong fraud concentration, with approximately **94.1% of all fraud cases** occurring in its lowest quartile.

3. The lowest V17 quartile captured approximately **77.4% of fraudulent transactions**.

4. Combining V14 and V17 created a much more concentrated risk segment: only approximately **3.6% of transactions** accounted for approximately **75.6% of all fraud cases**.

5. The combined low-V14/low-V17 segment recorded a **3.6492% fraud rate**, compared with only **0.0437%** among all other transactions.

6. Approximately **$46.65K of the dataset's $60.13K fraudulent transaction value** was concentrated in the combined high-risk segment.

7. Feature-based segmentation provides significantly stronger fraud discrimination than transaction amount alone, demonstrating the value of combining behavioral signals with transaction-level characteristics.

### Analytical Note

The features V1 through V28 are anonymized PCA-transformed variables.

Their original business meanings are not available in the dataset. Therefore, this analysis evaluates their statistical relationship with fraud but does not assign real-world interpretations such as customer behavior, merchant type, geography, or transaction channel to individual PCA features.

The identified relationships represent descriptive associations within this dataset and should not be interpreted as proof that individual features independently cause or perfectly predict fraudulent activity.

---

## Day 5 - Final Fraud Risk Segmentation & Executive Summary

### Multi-Factor Risk Segmentation

A final analytical risk segmentation was created using V14, V17, and transaction amount.

Transactions were classified into four analytical segments:

- Critical Risk
- High Risk
- Elevated Risk
- Standard Risk

These categories were created specifically for this portfolio analysis and do not represent a production fraud policy or financial institution risk framework.

### Risk Segment Performance

| Risk Segment | Transactions | Fraud Transactions | Fraud Rate | Fraudulent Amount |
|---|---:|---:|---:|---:|
| Critical Risk | 2,004 | 104 | 5.1896% | $40,215.87 |
| High Risk | 8,190 | 268 | 3.2723% | $6,430.62 |
| Elevated Risk | 122,016 | 100 | 0.0820% | $7,251.30 |
| Standard Risk | 152,597 | 20 | 0.0131% | $6,230.18 |

The Critical Risk segment recorded the highest fraud rate at **5.1896%**, substantially above the overall dataset fraud rate of **0.1727%**.

### Fraud Capture Efficiency

The High Risk segment represented only **2.88% of all transactions** but captured **54.47% of all fraud cases**.

The Critical Risk segment represented only **0.70% of transactions** while capturing another **21.14% of fraud cases**.

Combined, Critical Risk and High Risk contained:

- **10,194 transactions**
- Approximately **3.58% of the transaction population**
- **372 fraudulent transactions**
- Approximately **75.61% of all fraud cases**

This demonstrates that a relatively small transaction population contained the majority of fraudulent activity.

### Fraudulent Value Concentration

The Critical Risk segment alone accounted for:

- **$40,215.87** in fraudulent transaction value
- **66.88% of total fraudulent value**

Fraud value capture across the remaining segments was:

- Elevated Risk: **12.06%**
- High Risk: **10.69%**
- Standard Risk: **10.36%**

Critical Risk therefore represented a particularly important segment from a financial exposure perspective.

### Combined V14/V17 Risk Signal

The broader combined low-V14 and low-V17 population contained:

- **10,194 transactions**
- **372 fraud cases**
- **$46,646.49** in fraudulent transaction value

This represented approximately:

- **3.58% of all transactions**
- **75.61% of all fraud cases**
- **77.58% of total fraudulent transaction value**

The result demonstrates strong fraud concentration within a relatively small subset of the overall transaction population.

### Transaction Amount Profile

The Critical Risk segment also had the highest transaction amounts:

- Average transaction amount: **$423.07**
- Median transaction amount: **$211.67**
- Maximum transaction amount: **$25,691.16**

The High Risk segment, in comparison, had:

- Average transaction amount: **$23.44**
- Median transaction amount: **$11.98**
- Maximum transaction amount: **$100.00**

This shows that fraud risk can appear across very different transaction-value profiles.

### Overall Portfolio Summary

Across the full dataset:

- Total transactions: **284,807**
- Fraudulent transactions: **492**
- Overall fraud rate: **0.1727%**
- Total transaction value: **$25,162,590.01**
- Total fraudulent transaction value: **$60,127.97**
- Fraudulent value represented approximately **0.2390%** of total transaction value.

### Final Key Findings

1. Fraud was extremely rare at the portfolio level, representing only **0.1727% of transactions**.

2. Transaction amount alone was insufficient for identifying fraud because fraudulent activity occurred across both small and large transaction values.

3. V3, V14, V17, V12, and V10 showed the largest average differences between legitimate and fraudulent transactions.

4. V14 and V17 together provided particularly strong fraud segmentation.

5. Approximately **3.58% of transactions captured 75.61% of all fraud cases** when the lowest V14 and V17 quartiles were combined.

6. The same population captured approximately **77.58% of total fraudulent transaction value**.

7. The Critical Risk segment recorded a **5.1896% fraud rate**, approximately 30 times the overall portfolio fraud rate.

8. High fraud count, fraud probability, and financial exposure are different dimensions of risk and should be evaluated together.

9. Multi-factor segmentation produced substantially stronger fraud concentration than using transaction amount alone.

10. A practical fraud-monitoring strategy could prioritize highly concentrated risk segments for further investigation while still maintaining broader controls for fraud cases outside those segments.

### Final Analytical Note

This project is a descriptive SQL analytics exercise rather than a production fraud detection model.

The V1-V28 variables are anonymized PCA-transformed features, so their original business meanings are unavailable. The analytical risk segments used in this project were created to demonstrate SQL-based segmentation and should not be interpreted as production fraud rules or causal relationships.