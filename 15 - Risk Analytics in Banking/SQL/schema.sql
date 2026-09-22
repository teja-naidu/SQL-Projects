-- ------------------------------------------------------------
-- 1. Create Current Loan Applications Table
-- ------------------------------------------------------------

CREATE OR REPLACE TABLE applications AS
SELECT *
FROM read_csv_auto(
    'data/application_data.csv',
    HEADER = TRUE,
    SAMPLE_SIZE = -1
);


-- ------------------------------------------------------------
-- 2. Create Previous Loan Applications Table
-- ------------------------------------------------------------

CREATE OR REPLACE TABLE previous_applications AS
SELECT *
FROM read_csv_auto(
    'data/previous_application.csv',
    HEADER = TRUE,
    SAMPLE_SIZE = -1
);


-- ------------------------------------------------------------
-- 3. Verify Record Counts
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_current_applications
FROM applications;


SELECT COUNT(*) AS total_previous_applications
FROM previous_applications;


-- ------------------------------------------------------------
-- 4. Preview Current Applications
-- ------------------------------------------------------------

SELECT *
FROM applications
LIMIT 5;


-- ------------------------------------------------------------
-- 5. Preview Previous Applications
-- ------------------------------------------------------------

SELECT *
FROM previous_applications
LIMIT 5;