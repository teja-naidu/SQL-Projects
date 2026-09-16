-- ============================================================
-- Project 14: E-Commerce Customer Journey & Conversion Funnel
-- Day 1: Database Schema Creation
-- ============================================================

CREATE OR REPLACE TABLE customer_journey AS
SELECT *
FROM read_csv_auto('Datasets/customer_journey.csv');

-- Verify table structure
DESCRIBE customer_journey;

-- Verify total records
SELECT COUNT(*) AS total_records
FROM customer_journey;