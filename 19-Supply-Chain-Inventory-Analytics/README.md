Supply Chain & Inventory Analytics | SQL Project 19
End-to-end supply chain analytics using SQL and DuckDB

This project explores historical sales, inventory, product demand, fulfillment, shipping, and profitability to identify operational risks and opportunities. It consists of 70 SQL queries across five analysis phases, using order-item records from January 2015 through December 2017.
Scope note: This is a historical portfolio analysis, not a live inventory monitoring system. Inventory coverage and replenishment recommendations are scenario estimates based on historical demand.

Project overview
The analysis answers questions such as:
- Which products contribute the most sales and reported profit?
- How does inventory availability compare with historical demand?
- Which products merit further replenishment or fulfillment review?
- How do warehouses, customer markets, and shipping modes compare?
- What data-quality issues affect order-level reporting?
Dataset summary
Dataset	Records	Purpose
Orders & Shipments	30,871	Order items, customers, products, sales, profit, and shipping
Inventory	4,200	Product-month inventory levels and recorded unit costs
Fulfillment	118	Product-level fulfillment duration


Coverage: 118 distinct products in the combined datasets; 113 have recorded orders and five inventory products have no recorded orders.
Executive KPIs
Metric	Result
Gross sales	$6,181,476
Source-reported profit	$3,994,192
Reported profit margin	64.62%
Order-item records	30,871
Distinct order-item IDs	30,871
Distinct order IDs	11,072
Distinct order ID + date combinations	19,966
Latest inventory snapshot	December 2017
Latest recorded inventory	394 units


Important: Order IDs are reused across years and dates. The 19,966 order-date combinations are not verified unique business orders. The profit column is source-reported profit, not independently verified net profit.
Technology and SQL techniques
- DuckDB for local analytical SQL execution
- SQL for profiling, aggregation, segmentation, and reconciliation
- PowerShell for running scripts and exporting query results
- Git and GitHub for version control and documentation
- Common table expressions (CTEs), window functions, conditional CASE expressions, joins, GROUP BY, HAVING, COUNT(DISTINCT ...), and QUALIFY
Project structure
19-Supply-Chain-Inventory-Analytics/
├── data/
│   ├── fulfillment.csv
│   ├── inventory.csv
│   ├── orders_and_shipments.csv
│   └── orders_and_shipments_utf8.csv
├── sql/
│   └── queries.sql
├── insights/
│   └── insights.md
├── supply_chain.duckdb
├── .gitignore
└── README.md
The UTF-8 orders file is a converted copy used to resolve source-file encoding issues. The local .duckdb database and original CSV files may be excluded from Git depending on .gitignore and repository data-sharing choices.
Five-day analysis roadmap
Day	Queries	Focus
Day 1	1–13	Data import, profiling, quality checks, and baseline KPIs
Day 2	14–26	Inventory trends, product demand, inventory valuation, and stock risk
Day 3	27–40	Warehouse activity, fulfillment, shipping modes, and logistics quality
Day 4	41–55	Sales growth, profitability, product and market performance, revenue concentration
Day 5	56–70	Inventory coverage, replenishment scenarios, operational prioritization, executive KPIs, and final validation


Detailed findings for each phase are documented in [`insights/insights.md`](insights/insights.md). All SQL is maintained in [`sql/queries.sql`](sql/queries.sql).
Key analytical findings
1. Annual revenue peaked in 2016
Year	Gross sales	Reported profit	Reported margin
2015	$2,112,579	$1,379,939	65.32%
2016	$2,213,350	$1,446,057	65.33%
2017	$1,855,547	$1,168,196	62.96%


Gross sales grew 4.77% in 2016 and fell 16.17% in 2017. The final quarter of 2017 showed particularly steep declines, but the dataset does not establish whether inventory availability, demand, operations, or data completeness caused them.
2. Revenue is highly concentrated
The top 10 products generated 92.30% of gross sales. The top five alone accounted for approximately 62.22%. This concentration makes the availability and operational performance of leading products especially important.
3. Department and market profitability vary
- Fan Shop: Highest department gross sales, $2,934,670.
- Golf: Highest department reported profit margin, 81.34%.
- LATAM: Highest customer-market gross sales, $1,806,987.
- Africa: Highest customer-market reported margin, 65.68%, on a smaller revenue base.
High revenue does not always mean high percentage margin; both should inform product and market decisions.
4. Historical-demand inventory coverage flags substantial risk
The December 2017 snapshot contains 394 inventory units across 118 products. Using each product's average monthly demand across the full 36-month analysis period:
Estimated coverage segment	Products	Inventory units
Critical: less than 1 month	103	12
High: 1 to less than 3 months	3	10
Moderate: 3 to less than 6 months	0	0
Low: 6 months or more	7	289
No recorded demand	5	83


103 of 118 products (87.3%) fall into the critical category under this illustrative rule. This is a screening result, not proof of future stockouts; it must be checked against recent demand, product status, supplier lead times, and data completeness.
5. High-value products have low latest stock and long fulfillment times
Product	Historical reported profit	December 2017 stock	Recorded fulfillment
Perfect Fitness Perfect Rip Deck	$630,924	0	8.3 days
Nike Men's Free 5.0+ Running Shoe	$520,870	1	9.4 days


These products merit investigation because they combine high historical business contribution, minimal latest inventory, and relatively long recorded fulfillment times. No service-level breach is inferred without an agreed SLA.
6. Replenishment planning scenarios
The project estimates replenishment units using a three-month historical average-demand target:
Average monthly demand = Total units sold over 36 months / 36
Target stock = CEIL(Average monthly demand × 3)
Replenishment units = MAX(0, Target stock − Latest stock)
Estimated replenishment cost = Replenishment units × Recorded inventory unit cost
Examples include 1,080 units for Perfect Fitness Perfect Rip Deck and 906 units for Nike Men's Dri-FIT Victory Golf Polo. These are illustrative quantities, not purchasing instructions. The recorded unit-cost field requires verification before financial use.
7. Warehouse performance and shipping definitions
Warehouse country	Gross sales	Reported profit	Margin
USA	$3,798,206	$2,458,430	64.73%
Puerto Rico	$2,383,270	$1,535,762	64.44%


Standard Class was the most common shipping mode. A data-definition anomaly was also identified: Same Day shipments have three scheduled shipping days, while First Class has one. Scheduled duration is not the same as actual delivery performance.
8. Five inventory products have no recorded orders
Five products in inventory have no matching sales records for the analysis period. Together they account for 83 units of the December 2017 inventory snapshot. Their product lifecycle and transaction coverage should be verified before labeling them obsolete or excess stock.
Data quality and analytical caveats
The final checks found no missing product names or invalid quantity/duration values in the three tables, and no missing sales or profit values in the order-item data. Important qualifications remain:
1. Order ID reuse: order_id is not globally unique and can recur on different dates within a year. Year + order ID is also insufficient. Distinct order-date combinations are a candidate grouping, not a confirmed order key; average order value and order-frequency measures remain provisional.
2. Historical inventory comparison: December 2017 stock is compared with 2015–2017 average demand. This can misrepresent current or seasonal requirements.
3. Inventory unit-cost semantics: The December 2017 inventory valuation derived from source costs is $458.18, unusually low relative to historical sales; cost units and meaning need validation.
4. Profit definition: Reported profit is supplied by the source and is not reconciled to every expense.
5. Shipping data: Scheduled shipping days do not establish actual delivery times or shipping profitability.
6. Late-2017 decline: Inventory, order activity, and sales fell sharply, but correlation does not establish causation.
Business recommendations
1. Validate active-product status before replenishing products flagged by historical coverage estimates.
2. Prioritize high-value products using recent demand, latest stock, reported profitability, and supplier lead times.
3. Review slow fulfillment for important products against agreed service-level targets.
4. Investigate inventory without recorded demand before deciding on clearance, transfers, or replenishment.
5. Resolve order identifier and shipping definition issues before publishing operational order KPIs.
6. Build a recurring dashboard for inventory coverage, product sales, reported margin, fulfillment, and data-quality exceptions.
How to run the project
Prerequisites
- DuckDB CLI installed and accessible from the terminal
- PowerShell or another terminal
- Project CSV files available under data/
Option A: Run against the existing local DuckDB database
From the project directory:
cd "D:\GitHub Projects\SQL\19-Supply-Chain-Inventory-Analytics"
duckdb supply_chain.duckdb
In the DuckDB prompt:
.read sql/queries.sql
Option B: Save query output to a text file
From PowerShell, outside the DuckDB prompt:
duckdb supply_chain.duckdb -f sql/queries.sql > query_output.txt 2>&1
Fresh setup: The queries assume that the tables orders_shipments, inventory, and fulfillment have already been created and loaded. Review the import and table-creation statements in sql/queries.sql before running against a new database. The original orders CSV required conversion to UTF-8 for reliable loading.
Project outcomes
This project demonstrates practical SQL skills in:
- Data import and quality assessment
- Inventory trend and coverage analysis
- Demand and replenishment modeling
- Sales growth and profitability reporting
- Product, category, department, and market segmentation
- Warehouse and shipping performance analysis
- Multi-dataset joins and reconciliation
- Identification and documentation of source-data limitations
- Translating analytical results into operational recommendations
Future improvements
- Confirm the source-system unique business-order key.
- Add recent rolling-demand windows and seasonality-aware forecasts.
- Include supplier lead times, safety stock, and minimum order quantities.
- Validate inventory costs and source-reported profit definitions.
- Add actual shipment and delivery timestamps for SLA measurement.
- Build interactive dashboards and automated data-quality checks.
Conclusion
Across 70 DuckDB SQL queries, this project integrates sales, inventory, and fulfillment data to identify historical performance patterns and potential supply chain improvement opportunities. Its strongest findings are the concentration of revenue among leading products, widespread low estimated inventory coverage in December 2017, and important order-ID and shipping-definition data quality issues.

The analysis is intended as a transparent, reproducible portfolio case study, with assumptions and limitations documented alongside its recommendations.