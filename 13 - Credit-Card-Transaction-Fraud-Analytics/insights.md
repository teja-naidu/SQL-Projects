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