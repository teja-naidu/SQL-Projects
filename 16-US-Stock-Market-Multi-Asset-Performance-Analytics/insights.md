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

## Day 2 — Returns & Performance Analysis

### S&P 500 Annual Performance

- The S&P 500 generated positive returns in every analyzed year except **2022**.
- The strongest full-year performance in the dataset occurred in **2021**, when the index increased by **28.79%**.
- This was followed by a **24.73% gain in 2023**, demonstrating a strong recovery after the previous year's decline.
- In **2022**, the S&P 500 declined by **19.95%**, making it the weakest year in the dataset.
- The dataset contains partial-year observations for 2019 and 2024, so their returns represent the available periods rather than complete calendar-year performance.

### Nasdaq 100 Annual Performance

- The Nasdaq 100 experienced stronger gains as well as larger declines than the S&P 500 during several years.
- The index gained **45.27% in 2020** and **28.56% in 2021**.
- In **2022**, the Nasdaq 100 declined by **33.71%**, significantly more than the S&P 500's 19.95% decline.
- The Nasdaq subsequently rebounded by **54.90% in 2023**, the strongest annual-period return observed for the index in this dataset.
- These results demonstrate the higher growth potential and greater downside exposure associated with the technology-heavy Nasdaq 100.

### Technology Stock Performance

Across the complete dataset period, all eight analyzed technology stocks generated positive total returns.

| Rank | Stock | Total Return |
|---|---|---:|
| 1 | Nvidia | 1,673.73% |
| 2 | Tesla | 800.81% |
| 3 | Apple | 334.13% |
| 4 | Microsoft | 288.90% |
| 5 | Meta | 180.64% |
| 6 | Google | 149.48% |
| 7 | Amazon | 110.37% |
| 8 | Netflix | 60.71% |

- **Nvidia was the strongest-performing technology stock**, increasing from $37.30 to $661.60 and producing a total return of approximately **1,673.73%**.
- Tesla ranked second with an **800.81%** total return.
- Apple and Microsoft generated total returns of **334.13% and 288.90%**, respectively.
- Netflix produced the lowest return among the eight stocks but still gained **60.71%** over the complete analysis period.

### Technology Stock Performance by Year

- **2020 was an exceptional year for Tesla**, which gained approximately **720.15%** over the available yearly observations.
- Nvidia delivered particularly strong gains in multiple periods, including **117.66% in 2020**, **124.29% in 2021**, and **245.94% in 2023**.
- The technology sector experienced broad weakness in **2022**, with all eight analyzed stocks recording negative returns.
- Tesla experienced the largest 2022 decline among the analyzed stocks at **-69.20%**, followed by Meta at **-64.45%**.
- The sector recovered strongly in **2023**, led by Nvidia at **245.94%**, Meta at **183.76%**, and Tesla at **129.86%**.
- This demonstrates that high-growth technology stocks can generate exceptional upside while also experiencing substantial downside during market contractions.

### Commodity Performance

- **Gold was the strongest-performing commodity** across the complete dataset period, returning **55.67%**.
- Silver gained **43.50%**, while Copper returned **36.60%**.
- Crude Oil produced a **32.48%** total return despite experiencing extreme price disruption during the analysis period.
- Platinum recorded a relatively modest **9.62%** gain.
- Natural Gas was the only analyzed commodity with a negative overall return, declining by **21.84%**.

### Cryptocurrency Performance

- Cryptocurrencies generated some of the largest total returns in the dataset.
- Ethereum increased from **$107.90 to $2,309.28**, generating approximately **2,040.20%**.
- Bitcoin increased from **$3,462.80 to $43,194.70**, producing approximately **1,147.39%**.
- The magnitude of these returns substantially exceeded the broad market indices and Gold, although return alone does not measure the amount of risk required to achieve those gains.

### Cross-Asset Performance

Among the representative assets selected for comparison:

| Asset | Asset Class | Total Return |
|---|---|---:|
| Ethereum | Cryptocurrency | 2,040.20% |
| Nvidia | Stock | 1,673.73% |
| Bitcoin | Cryptocurrency | 1,147.39% |
| Apple | Stock | 334.13% |
| Nasdaq 100 | Market Index | 153.49% |
| S&P 500 | Market Index | 81.98% |
| Gold | Commodity | 55.67% |

- Ethereum generated the highest total return among the selected representative assets.
- Nvidia outperformed both Bitcoin and the broader equity indices during the dataset period.
- The Nasdaq 100 returned **153.49%**, compared with **81.98% for the S&P 500**.
- Gold produced a more moderate **55.67% return**.
- The results show substantial differences in return potential across asset classes, but these returns should be evaluated together with volatility and downside risk before drawing conclusions about risk-adjusted performance.

### Extreme Market Movements

- The largest S&P 500 daily gain in the dataset was **9.38% on March 24, 2020**.
- Its largest daily decline was **-11.98% on March 16, 2020**.
- Four of the five largest S&P 500 gains and four of its five largest declines occurred during **March 2020**, highlighting the extreme market volatility during that period.
- The Nasdaq 100 experienced its largest daily gain of **10.07% on March 13, 2020**.
- Its largest daily decline was **-12.19% on March 16, 2020**.
- Extreme Nasdaq movements were also concentrated around the 2020 market disruption, although major volatility events also appeared during 2022.

## Day 2 Key Takeaways

The performance analysis reveals substantial differences between broad market indices, individual technology stocks, commodities, and cryptocurrencies.

High-growth assets such as **Ethereum, Nvidia, Bitcoin, and Tesla** generated exceptional cumulative returns, while diversified market indices produced comparatively moderate gains. However, the sharp declines observed in 2022 and the extreme daily movements during 2020 demonstrate that high return potential can be accompanied by significant market risk.

The next stage of the analysis will therefore focus on **volatility, drawdowns, and risk characteristics** to determine not only which assets generated the highest returns, but also how much risk investors experienced in achieving those returns.