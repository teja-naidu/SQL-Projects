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