Use TrendStreamDB;
-- Declare a variable to store A_values
DECLARE @A_values TABLE (
    currency NVARCHAR(MAX)
);

-- Insert A_values into the variable
INSERT INTO @A_values (currency)
SELECT currency
FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded]
WHERE currency COLLATE Latin1_General_BIN LIKE '[A-Z][^A-Z][^A-Z]%';

-- Update the original table to replace A_values with corresponding B_values
UPDATE a
SET a.CurrencyCheck = b.currency
FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded] a
INNER JOIN @A_values b ON a.currency LIKE '%' + b.currency + '%';