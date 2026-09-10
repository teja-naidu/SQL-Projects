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