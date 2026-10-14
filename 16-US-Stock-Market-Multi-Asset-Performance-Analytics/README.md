# US Stock Market & Multi-Asset Performance Analytics

## Project Overview

This project analyzes historical financial-market data across equities, market indices, commodities, and cryptocurrencies using SQL and DuckDB.

The analysis covers **1,243 trading-day observations from February 4, 2019 through February 2, 2024** and evaluates market performance from multiple perspectives including cumulative returns, annual returns, volatility, drawdowns, rolling metrics, market trends, and cross-asset risk-return behavior.

The project was structured as a five-day analytical workflow containing **50 SQL queries**, progressing from data validation and exploratory analysis to advanced window functions and executive-level market insights.

---

## Business Questions

The analysis was designed to answer questions such as:

- How did the S&P 500 and Nasdaq 100 perform across different market environments?
- Which technology stocks generated the strongest historical price returns?
- How much additional volatility accompanied higher-return assets?
- Which assets experienced the largest drawdowns?
- How did cryptocurrencies compare with equities, indices, and gold?
- Which years and months represented the strongest and weakest market periods?
- How can rolling averages and rolling volatility help identify changing market conditions?
- How did positive and negative trading-day distributions change across years?

---

## Dataset

The dataset contains daily market information across several asset classes.

### Market Indices
- S&P 500
- Nasdaq 100

### Technology & Large-Cap Stocks
- Apple
- Tesla
- Microsoft
- Google
- Nvidia
- Berkshire Hathaway
- Netflix
- Amazon
- Meta

### Commodities
- Gold
- Silver
- Crude Oil
- Natural Gas
- Copper
- Platinum

### Cryptocurrencies
- Bitcoin
- Ethereum

**Dataset size:** 1,243 records  
**Date range:** February 4, 2019 – February 2, 2024

2019 and 2024 contain partial-year observations.

---

## Tools & Technologies

- SQL
- DuckDB
- Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
- Conditional Aggregation
- Time-Series Analysis
- Ranking Functions
- Rolling Metrics
- Git
- GitHub

---

## Project Structure

```text
16-US-Stock-Market-Multi-Asset-Performance-Analytics/
│
├── Datasets/
│   └── Stock Market Dataset.csv
│
├── SQL/
│   ├── schema.sql
│   └── queries.sql
│
├── insights.md
└── README.md
```

`schema.sql` creates the analytical table from the source CSV, while `queries.sql` contains the complete 50-query analytical workflow.

---

# Analysis Workflow

## Day 1 — Data Validation & Exploratory Analysis

The first stage focused on understanding the dataset and validating its quality.

Analysis included:

- Dataset dimensions
- Date coverage
- Trading days by year
- Duplicate-date detection
- Missing-value analysis
- Index price summaries
- Technology-stock price summaries
- Commodity price summaries
- Cryptocurrency price summaries

### Key Findings

- Total observations: **1,243**
- Date range: **2019-02-04 to 2024-02-02**
- Duplicate dates: **0**
- Selected major price fields contained no missing values.
- Platinum volume contained substantial missing data.
- Crude oil reached a negative minimum price during the 2020 market disruption.

---

## Day 2 — Returns & Performance Analysis

The second stage measured historical price performance.

### Index Annual Returns

| Year | S&P 500 | Nasdaq 100 |
|------|--------:|-----------:|
| 2019* | 18.57% | 25.48% |
| 2020 | 15.29% | 45.27% |
| 2021 | 28.79% | 28.56% |
| 2022 | -19.95% | -33.71% |
| 2023 | 24.73% | 54.90% |
| 2024* | 4.55% | 6.64% |

\* Partial-year observations.

### Technology Stock Cumulative Returns

| Rank | Asset | Return |
|-----:|-------|-------:|
| 1 | Nvidia | 1673.73% |
| 2 | Tesla | 800.81% |
| 3 | Apple | 334.13% |
| 4 | Microsoft | 288.90% |
| 5 | Meta | 180.64% |
| 6 | Google | 149.48% |
| 7 | Amazon | 110.37% |
| 8 | Netflix | 60.71% |

Nvidia recorded the highest cumulative price return among the selected technology stocks.

---

## Day 3 — Risk, Volatility & Drawdowns

The third stage shifted the analysis from return to risk.

### Annualized Volatility

| Asset | Annualized Volatility |
|-------|----------------------:|
| Ethereum | 86.65% |
| Bitcoin | 67.86% |
| Nvidia | 51.26% |
| Apple | 31.82% |
| Nasdaq 100 | 25.74% |
| S&P 500 | 21.32% |
| Gold | 16.04% |

Crypto assets displayed substantially higher historical volatility than traditional market indices and gold.

### Maximum Drawdowns

- S&P 500: **-33.92%**
- Nasdaq 100: **-35.56%**
- Meta: **-76.73%**
- Netflix: **-75.95%**
- Tesla: **-73.63%**
- Nvidia: **-66.36%**

The results demonstrate why cumulative return should be evaluated alongside downside risk.

---

## Day 4 — Advanced SQL & Rolling Market Analytics

The fourth stage used advanced SQL techniques to evaluate changing market conditions.

Techniques included:

- 20-day moving averages
- 50-day moving averages
- Trend classification
- 30-day rolling volatility
- Rolling 30-trading-day returns
- Yearly stock rankings
- Window-based ranking
- Monthly performance ranking

At the final observation on **February 2, 2024**:

- S&P 500 close: **4,958.61**
- 20-day moving average: **4,831.14**
- 50-day moving average: **4,726.82**
- Trend classification: **Bullish**
- S&P 500 rolling 30-day annualized volatility: **11.35%**
- Nasdaq 100 rolling 30-day annualized volatility: **16.04%**
- S&P 500 rolling 30-trading-day return: **3.99%**

### Technology Stock Leaders by Year

| Year | Highest Return Stock | Return |
|------|---------------------|-------:|
| 2019* | Apple | 71.48% |
| 2020 | Tesla | 720.15% |
| 2021 | Nvidia | 124.29% |
| 2022 | Microsoft | -28.36% |
| 2023 | Nvidia | 245.94% |
| 2024* | Nvidia | 37.35% |

The 2022 result is especially notable: Microsoft ranked first among the selected stocks despite having a negative return, showing that relative leadership does not necessarily imply positive performance.

---

## Day 5 — Final Market Intelligence

The final stage consolidated the analysis into executive-level market comparisons.

### Cross-Asset Cumulative Performance

| Rank | Asset | Return |
|-----:|-------|-------:|
| 1 | Ethereum | 2040.20% |
| 2 | Nvidia | 1673.73% |
| 3 | Bitcoin | 1147.39% |
| 4 | Tesla | 800.81% |
| 5 | Apple | 334.13% |
| 6 | Nasdaq 100 | 153.49% |
| 7 | S&P 500 | 81.98% |
| 8 | Gold | 55.67% |

Ethereum generated the highest cumulative return in this selected comparison, while the earlier volatility analysis showed that it also carried the highest annualized volatility.

### Best and Worst Full Years

**S&P 500**
- Best: **2021 (+28.79%)**
- Worst: **2022 (-19.95%)**

**Nasdaq 100**
- Best: **2023 (+54.90%)**
- Worst: **2022 (-33.71%)**

### Extreme Daily Movements

The S&P 500's largest observed daily decline was **-11.98% on March 16, 2020**, while its largest gain was **+9.38% on March 24, 2020**.

The Nasdaq 100's largest observed daily decline was **-12.19% on March 16, 2020**, while its largest gain was **+10.07% on March 13, 2020**.

These extreme movements highlight the exceptional market volatility observed during March 2020.

---

# Key Insights

1. **Higher historical returns generally came with greater risk.** Ethereum, Bitcoin, Nvidia, and Tesla generated exceptional cumulative returns but also displayed substantially greater volatility or drawdown exposure.

2. **Nasdaq demonstrated stronger upside and downside sensitivity than the S&P 500.** It substantially outperformed during periods such as 2020 and 2023 but experienced a deeper decline in 2022.

3. **2022 represented the clearest broad risk-off period in the dataset.** Both major indices produced negative annual returns, and the S&P 500 recorded more negative trading days than positive ones.

4. **Technology leadership changed significantly over time.** Tesla dominated 2020, while Nvidia led the selected technology stocks in 2021, 2023, and the partial 2024 period.

5. **March 2020 contained many of the dataset's most extreme daily index movements**, illustrating how rapidly volatility can expand during periods of market stress.

6. **Gold exhibited a different risk-return profile from growth-oriented assets.** Its cumulative return was lower, but its annualized volatility was also substantially below crypto assets and major technology stocks.

---

# SQL Skills Demonstrated

This project demonstrates practical use of:

- `GROUP BY`
- `CASE`
- `UNION ALL`
- `LAG()`
- `AVG() OVER()`
- `STDDEV_SAMP()`
- `ROW_NUMBER()`
- `RANK()`
- `ARG_MIN()`
- `ARG_MAX()`
- Common Table Expressions
- Conditional aggregation
- Data-type conversion
- Missing-value analysis
- Time-series calculations
- Daily and annual return calculations
- Annualized volatility
- Running peaks and drawdowns
- Moving averages
- Rolling volatility
- Rolling returns
- Cross-asset performance ranking

---

# Analytical Methodology

### Total Return

```text
(Ending Price - Starting Price) / Starting Price × 100
```

### Daily Return

```text
(Current Price / Previous Price - 1) × 100
```

### Annualized Volatility

```text
Standard Deviation of Daily Returns × √252
```

### Drawdown

```text
(Current Price - Running Peak) / Running Peak × 100
```

The project also uses a simple **total-return-to-volatility ratio** for comparative analysis. This metric should not be interpreted as a Sharpe Ratio because it does not incorporate a risk-free rate or matching annualized return methodology.

---

# Conclusion

This project demonstrates an end-to-end SQL workflow for analyzing financial time-series data across multiple asset classes.

Rather than evaluating assets solely by price appreciation, the analysis combines **returns, volatility, drawdowns, rolling indicators, market direction, and cross-asset comparisons** to provide a more complete historical performance perspective.

The results highlight a central analytical principle: **higher returns cannot be evaluated independently of the risk required to achieve them.**

> **Disclaimer:** This project is intended for SQL portfolio and historical data-analysis purposes only. It does not constitute investment advice.