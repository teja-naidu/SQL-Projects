-- =====================================================
-- Project 17: Healthcare Patient & Hospital Operations
-- Day 1: Database Schema and Data Loading
-- Database: DuckDB
-- =====================================================

CREATE OR REPLACE TABLE healthcare_raw AS
SELECT *
FROM read_csv_auto(
    'dataset/healthcare_analytics_patient_flow_data.csv',
    header = true
);

-- Verify total records
SELECT COUNT(*) AS total_records
FROM healthcare_raw;

-- Verify schema
DESCRIBE healthcare_raw;

-- Preview data
SELECT *
FROM healthcare_raw
LIMIT 10;