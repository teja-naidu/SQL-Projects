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

## Day 3 — Risk, Volatility & Drawdown Analysis

### Market Index Volatility

- The S&P 500 recorded an annualized volatility of **21.32%**.
- The Nasdaq 100 recorded a higher annualized volatility of **25.74%**.
- This indicates that the technology-heavy Nasdaq experienced larger daily price fluctuations than the broader S&P 500 during the analysis period.

### Technology Stock Volatility

Technology stocks showed substantial differences in risk based on annualized daily-return volatility.

| Rank | Stock | Annualized Volatility |
|---|---|---:|
| 1 | Tesla | 64.47% |
| 2 | Nvidia | 51.26% |
| 3 | Netflix | 46.18% |
| 4 | Meta | 44.53% |
| 5 | Amazon | 35.25% |
| 6 | Google | 32.07% |
| 7 | Apple | 31.82% |
| 8 | Microsoft | 30.33% |

- **Tesla was the most volatile technology stock**, with annualized volatility of **64.47%**.
- Nvidia ranked second at **51.26%**, showing that its exceptional long-term return was accompanied by substantial price fluctuations.
- Microsoft had the lowest volatility among the analyzed technology stocks at **30.33%**.
- Apple also remained toward the lower end of the technology-stock risk ranking at **31.82%**.

### Cryptocurrency Risk

- Ethereum recorded annualized volatility of **86.65%**.
- Bitcoin recorded annualized volatility of **67.86%**.
- Both cryptocurrencies were considerably more volatile than the market indices, Gold, Apple, and Nvidia.
- Ethereum therefore combined the highest total return in the selected cross-asset comparison with the highest annualized volatility.

### Cross-Asset Volatility Comparison

| Asset | Asset Class | Annualized Volatility |
|---|---|---:|
| Ethereum | Cryptocurrency | 86.65% |
| Bitcoin | Cryptocurrency | 67.86% |
| Nvidia | Stock | 51.26% |
| Apple | Stock | 31.82% |
| Nasdaq 100 | Market Index | 25.74% |
| S&P 500 | Market Index | 21.32% |
| Gold | Commodity | 16.04% |

- **Ethereum was the most volatile representative asset**, while **Gold was the least volatile**.
- Bitcoin and Ethereum exhibited substantially greater price risk than the two broad market indices.
- Nvidia carried considerably more volatility than the S&P 500 and Nasdaq 100, but also generated a much higher cumulative return.
- Gold showed the lowest annualized volatility at **16.04%**, demonstrating a substantially different risk profile from growth stocks and cryptocurrencies.

### S&P 500 Maximum Drawdown

- The S&P 500 experienced a maximum drawdown of **-33.92%**.
- The drawdown bottom occurred on **March 23, 2020**, when the index reached **2,237.40** after previously reaching a running peak of **3,386.15**.
- This demonstrates that even a diversified broad-market index can experience substantial short-term losses during severe market stress.

### Nasdaq 100 Maximum Drawdown

- The Nasdaq 100 experienced a maximum drawdown of **-35.56%**.
- The drawdown bottom occurred on **December 28, 2022**, when the index stood at **10,679.34**, compared with its previous running peak of **16,573.34**.
- The Nasdaq's maximum drawdown was slightly larger than that of the S&P 500.

### Technology Stock Maximum Drawdowns

| Stock | Maximum Drawdown |
|---|---:|
| Meta | -76.73% |
| Netflix | -75.95% |
| Tesla | -73.63% |
| Nvidia | -66.36% |
| Amazon | -56.15% |
| Google | -44.32% |
| Microsoft | -37.56% |
| Apple | -31.43% |

- **Meta experienced the largest maximum drawdown at -76.73%**.
- Netflix and Tesla also experienced peak-to-trough declines exceeding **70%**.
- Nvidia experienced a maximum drawdown of **-66.36%**, despite ultimately producing the highest total return among the analyzed technology stocks.
- Apple had the smallest maximum drawdown among the eight stocks at **-31.43%**.
- These results demonstrate why cumulative return alone is not sufficient for evaluating an investment's historical performance.

### Positive vs Negative S&P 500 Trading Days

- The S&P 500 recorded **673 positive trading days**, representing **54.19%** of analyzed daily movements.
- It recorded **569 negative trading days**, representing **45.81%**.
- Positive days occurred more frequently than negative days over the analysis period.

### Risk vs Return Comparison

A simple return-to-volatility ratio was calculated by dividing total return by annualized volatility.

| Asset | Total Return | Annualized Volatility | Return-to-Volatility Ratio |
|---|---:|---:|---:|
| Nvidia | 1,673.73% | 51.26% | 32.65 |
| Ethereum | 2,040.20% | 86.65% | 23.54 |
| Bitcoin | 1,147.39% | 67.86% | 16.91 |
| Apple | 334.13% | 31.82% | 10.50 |
| Nasdaq 100 | 153.49% | 25.74% | 5.96 |
| S&P 500 | 81.98% | 21.32% | 3.85 |
| Gold | 55.67% | 16.04% | 3.47 |

- Nvidia achieved the highest **return-to-volatility ratio of 32.65** among the selected assets.
- Ethereum generated a higher total return than Nvidia but also experienced substantially greater volatility, resulting in a lower ratio of **23.54**.
- Bitcoin ranked third with a ratio of **16.91**.
- Gold had the lowest volatility but also a much lower cumulative return, producing a ratio of **3.47**.
- This metric is a simplified comparison of cumulative return relative to annualized volatility and **should not be interpreted as a Sharpe Ratio or formal risk-adjusted performance measure**.

## Day 3 Key Takeaways

The Day 3 analysis demonstrates that the assets producing the largest returns were generally accompanied by substantially greater risk.

Cryptocurrencies showed the highest volatility, while individual growth stocks such as Tesla and Nvidia were significantly more volatile than broad market indices. Gold displayed the lowest volatility among the representative assets.

Maximum drawdown analysis further highlights the importance of downside risk. Several major technology stocks experienced peak-to-trough losses exceeding 50%, even when their long-term cumulative returns were strongly positive.

Among the selected assets, Nvidia produced the strongest simple return-to-volatility relationship. Overall, the analysis reinforces that investment performance should be evaluated using both **return and risk measures**, rather than cumulative returns alone.

## Day 4 — Advanced SQL & Rolling Market Analytics

### Moving Average Analysis

- 20-day and 50-day moving averages were calculated using SQL window functions to evaluate short-term and longer-term S&P 500 market trends.
- The 20-day moving average reacts more quickly to recent price movements, while the 50-day moving average provides a smoother representation of the broader trend.
- A trend signal was created by comparing the two moving averages:
  - **Bullish Trend:** 20-day moving average > 50-day moving average
  - **Bearish Trend:** 20-day moving average < 50-day moving average
- On **February 2, 2024**, the S&P 500 closed at **4,958.61**, while its 20-day moving average was **4,831.14** and its 50-day moving average was **4,726.82**.
- Since the 20-day moving average was above the 50-day moving average, the latest observation was classified as a **Bullish Trend**.

### Rolling Market Volatility

- A 30-trading-day rolling volatility measure was calculated for both the S&P 500 and Nasdaq 100 using daily returns and annualizing their rolling standard deviation.
- This approach allows market risk to be evaluated dynamically rather than relying only on a single volatility value for the entire dataset.
- On **February 2, 2024**, S&P 500 30-day annualized volatility was **11.35%**.
- On the same date, Nasdaq 100 rolling annualized volatility was **16.04%**.
- The Nasdaq therefore showed greater short-term volatility than the S&P 500 at the end of the dataset.

### Rolling S&P 500 Returns

- Rolling 30-trading-day returns were calculated using `LAG()` to compare each closing price with the price 30 trading observations earlier.
- On **February 2, 2024**, the S&P 500's rolling 30-trading-day return was **3.99%**.
- The rolling-return calculation provides a more dynamic view of market momentum than calendar-year returns because the measurement window moves forward with every trading observation.

### Technology Stock Yearly Rankings

Technology-stock performance was ranked independently within each year using the `RANK()` window function.

The highest-ranked stock for each available year was:

| Year | Best-Performing Stock | Return |
|---|---|---:|
| 2019 | Apple | 71.48% |
| 2020 | Tesla | 720.15% |
| 2021 | Nvidia | 124.29% |
| 2022 | Microsoft | -28.36% |
| 2023 | Nvidia | 245.94% |
| 2024 | Nvidia | 37.35% |

- Apple ranked first among the analyzed technology stocks in **2019**, returning **71.48%** over the available observations.
- Tesla dominated **2020** with an exceptional **720.15%** return.
- Nvidia ranked first in **2021**, **2023**, and the partial **2024** period.
- In 2023, Nvidia returned **245.94%**, followed by Meta at **183.76%** and Tesla at **129.86%**.
- **2022 was unique because even the highest-ranked stock had a negative return.** Microsoft ranked first with **-28.36%**, demonstrating broad weakness across the analyzed technology stocks.
- For 2019 and 2024, rankings represent the available partial-year observations rather than complete calendar years.

### S&P 500 vs Nasdaq 100 Performance

| Year | S&P 500 Return | Nasdaq 100 Return | Nasdaq vs S&P Gap | Better Performer |
|---|---:|---:|---:|---|
| 2019 | 18.57% | 25.48% | +6.91% | Nasdaq 100 |
| 2020 | 15.29% | 45.27% | +29.97% | Nasdaq 100 |
| 2021 | 28.79% | 28.56% | -0.23% | S&P 500 |
| 2022 | -19.95% | -33.71% | -13.75% | S&P 500 |
| 2023 | 24.73% | 54.90% | +30.17% | Nasdaq 100 |
| 2024 | 4.55% | 6.64% | +2.09% | Nasdaq 100 |

- The Nasdaq 100 outperformed the S&P 500 in **four of the six available yearly periods**.
- Its largest positive performance advantage occurred in **2023**, when it exceeded the S&P 500 return by **30.17 percentage points**.
- Nasdaq also strongly outperformed in **2020**, with a performance gap of **29.97 percentage points**.
- In **2021**, the S&P 500 narrowly outperformed Nasdaq by **0.23 percentage points**.
- During the 2022 market decline, the S&P 500 performed better because its **-19.95%** decline was less severe than Nasdaq's **-33.71%** decline.
- These results complement the earlier volatility analysis: Nasdaq demonstrated stronger upside during several growth periods but also experienced a substantially larger decline in 2022.

### Strongest and Weakest S&P 500 Months

The five strongest monthly periods in the dataset were:

| Year | Month | Return |
|---|---:|---:|
| 2020 | April | 17.89% |
| 2020 | November | 9.41% |
| 2022 | July | 7.97% |
| 2023 | November | 7.79% |
| 2020 | May | 7.55% |

The five weakest monthly periods were:

| Year | Month | Return |
|---|---:|---:|
| 2022 | June | -7.70% |
| 2020 | February | -9.07% |
| 2022 | April | -9.11% |
| 2022 | September | -9.61% |
| 2020 | March | -16.36% |

- **April 2020 was the strongest monthly period**, producing a **17.89%** first-to-last available trading-day return.
- **March 2020 was the weakest**, declining by **16.36%**.
- The rapid transition from the dataset's weakest month in March 2020 to its strongest month in April 2020 illustrates the magnitude of the market reversal during that period.
- Three of the five weakest monthly observations occurred during **2022**, consistent with the broader negative market performance observed for that year.

## Day 4 Key Takeaways

Advanced SQL window functions make it possible to move beyond static summary statistics and analyze how market behavior changes through time.

Moving averages provided a simple method for identifying market trend conditions, while rolling returns measured changing momentum and rolling volatility captured changing short-term risk.

Yearly rankings also showed that leadership among technology stocks changed substantially across periods. Nvidia demonstrated particularly strong performance by ranking first in three available yearly periods, while Tesla dominated 2020.

The comparison between the S&P 500 and Nasdaq 100 further demonstrated the relationship between growth and risk. Nasdaq produced stronger returns in several periods, but its losses were also substantially greater during the 2022 downturn.

Together, these analyses demonstrate practical use of **CTEs, `LAG()`, `RANK()`, `ROW_NUMBER()`, `PARTITION BY`, `ARG_MIN()`, `ARG_MAX()`, and rolling window calculations** for financial time-series analytics.