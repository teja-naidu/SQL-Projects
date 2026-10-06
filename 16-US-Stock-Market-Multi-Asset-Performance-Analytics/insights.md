# US Stock Market & Multi-Asset Performance Analytics (2019–2024)

## Day 1 — Data Exploration & Quality Analysis

### Dataset Overview

- The dataset contains **1,243 daily market records** covering the period from **February 4, 2019 to February 2, 2024**.
- The dataset includes major US market indices, technology stocks, commodities, and cryptocurrencies.
- The number of available trading-day records varies by year:
  - **2019:** 230 records
  - **2020:** 249 records
  - **2021:** 246 records
  - **2022:** 245 records
  - **2023:** 250 records
  - **2024:** 23 records
- The 2019 and 2024 counts are lower because the dataset contains only partial-year data for those years.

### Data Quality

- No duplicate trading dates were identified, indicating that each date is uniquely represented in the dataset.
- Major asset price columns, including the S&P 500, Nasdaq 100, major technology stocks, Bitcoin, Ethereum, Gold, and Crude Oil, contained **no missing price values**.
- Some volume fields contain missing observations.
- Platinum has a particularly high number of missing volume records, with **607 missing observations**.
- Nasdaq 100 volume contains **1 missing observation**, while Gold volume contains **2 missing observations**.
- Missing volume values should therefore be handled carefully in future volume-based analysis.

### US Market Index Overview

- The **S&P 500** ranged from **2,237.40 to 4,958.61**, with an average level of **3,793.32** during the dataset period.
- The **Nasdaq 100** ranged from **6,904.98 to 17,642.73**, with an average level of **12,037.32**.
- Both indices experienced substantial variation during the 2019–2024 period, providing a useful foundation for analyzing market returns, volatility, and drawdowns.

### Technology Stock Overview

- Among the technology stocks analyzed, **Netflix had the highest average share price at $404.84**, followed by Microsoft at **$241.24** and Meta at **$239.73**.
- Nvidia ranged from **$33.45 to $661.60**, showing a wide price range during the analysis period.
- Tesla also experienced a substantial price range, moving between **$11.93 and $409.97**.
- Apple ranged from **$42.36 to $198.11**, while Microsoft ranged from **$105.25 to $411.22**.
- These price ranges suggest significant differences in price movement across major technology companies.

### Commodity Overview

- Gold had an average price of **$1,759.25**, ranging from **$1,272.00 to $2,089.70**.
- Platinum averaged **$959.00**, with prices ranging from **$595.20 to $1,297.10**.
- Silver averaged **$21.59**, while Copper averaged **$3.54**.
- Natural Gas ranged from **$1.48 to $9.65**, indicating considerable variation during the period.
- Crude Oil ranged from **-$37.63 to $123.70**, with an average price of **$67.58**.
- The negative minimum crude oil price reflects the extraordinary oil-market conditions experienced during 2020 and represents an important event for later market-risk analysis.

### Cryptocurrency Overview

- Bitcoin recorded an average price of **$25,241.90**, with prices ranging from **$3,397.70 to $67,527.90**.
- Ethereum averaged **$1,445.82**, ranging from **$104.55 to $4,808.38**.
- The large difference between minimum and maximum cryptocurrency prices highlights the substantial price variation within the crypto market during the analysis period.

## Day 1 Key Takeaways

The initial exploration confirms that the dataset provides a strong foundation for multi-asset financial market analysis. Price data is highly complete and no duplicate dates were identified. The dataset also captures significant market movements across equities, indices, commodities, and cryptocurrencies between 2019 and early 2024.

The large price ranges observed in assets such as Nvidia, Tesla, Bitcoin, Ethereum, Natural Gas, and Crude Oil indicate that further analysis should focus on **returns, volatility, drawdowns, and comparative asset performance** rather than comparing absolute asset prices alone.