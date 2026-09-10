CREATE OR REPLACE TABLE credit_card_transactions AS
SELECT *
FROM read_csv_auto('Datasets/creditcard.csv');

-- Verify the table
DESCRIBE credit_card_transactions;

-- Check total number of records
SELECT COUNT(*) AS total_transactions
FROM credit_card_transactions;