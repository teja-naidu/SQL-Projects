# Credit Card Transaction & Fraud Pattern Analytics

## Project Overview

This project analyzes a large credit card transaction dataset to identify fraud patterns, transaction risk characteristics, temporal behavior, and concentrated fraud segments using SQL and DuckDB.

The dataset contains **284,807 transactions**, including **492 fraudulent transactions**, making fraud only **0.1727% of total transaction volume**.

The analysis progresses from portfolio-level KPIs to transaction amount analysis, time-based fraud patterns, anonymized PCA feature analysis, and multi-factor risk segmentation.

The goal is to demonstrate how SQL can be used to transform highly imbalanced transaction data into actionable fraud-risk insights.

---

## Business Questions

The project explores the following questions:

- What percentage of transactions are fraudulent?
- How much financial value is associated with fraudulent activity?
- Do fraudulent transactions differ in value from legitimate transactions?
- Which transaction amount ranges show higher fraud rates?
- Are fraud cases concentrated within particular transaction periods?
- Which anonymized PCA features show the strongest separation between legitimate and fraudulent transactions?
- Can multiple transaction signals be combined to identify concentrated high-risk segments?
- How much fraud volume and fraudulent value can be captured within a small transaction population?

---

## Dataset

The dataset contains:

- **284,807 transactions**
- **31 columns**
- Approximately **48 hours** of transaction activity
- **492 fraudulent transactions**
- **284,315 legitimate transactions**

### Key Fields

| Field | Description |
|---|---|
| Time | Seconds elapsed since the first transaction in the dataset |
| V1-V28 | Anonymized PCA-transformed transaction features |
| Amount | Transaction amount |
| Class | Fraud indicator: 0 = Legitimate, 1 = Fraud |

The V1-V28 features are anonymized, so their original business meanings are unavailable.

---

## Technology Used

- SQL
- DuckDB
- VS Code
- Git
- GitHub

---

## Project Structure

```text
13-Credit-Card-Transaction-Fraud-Analytics/
│
├── Datasets/
│   └── creditcard.csv
│
├── SQL/
│   ├── schema.sql
│   └── queries.sql
│
├── insights.md
└── README.md