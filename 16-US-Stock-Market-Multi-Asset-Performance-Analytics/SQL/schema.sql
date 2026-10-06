-- ============================================================
-- Project 16: US Stock Market & Multi-Asset Performance Analytics
-- Dataset: US Stock Market Data (2019–2024)
-- Purpose: Create the base table used for SQL analysis
-- ============================================================


-- Create the stock market table from the CSV dataset
CREATE OR REPLACE TABLE stock_market AS
SELECT *
FROM read_csv_auto(
    'Datasets/Stock Market Dataset.csv',
    HEADER = TRUE
);


-- Verify that the data was loaded successfully
SELECT COUNT(*) AS total_records
FROM stock_market;