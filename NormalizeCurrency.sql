Use TrendStreamDB;
---- Declare a variable to store A_values
--DECLARE @A_values TABLE (
--    currency NVARCHAR(MAX)
--);

---- Insert A_values into the variable
--INSERT INTO @A_values (currency)
--SELECT currency
--FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded]
--WHERE currency COLLATE Latin1_General_BIN LIKE '[A-Z][^A-Z][^A-Z]%';

---- Update the original table to replace A_values with corresponding B_values
--UPDATE a
--SET a.CurrencyCheck = b.currency
--FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded] a
--INNER JOIN @A_values b ON a.currency LIKE '%' + b.currency + '%';

-- --Add a new column 'AgeCategory'
--ALTER TABLE [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey]
--ADD [CurrencyCheck] NVARCHAR(50) NULL; -- You can adjust the length (50) as needed

UPDATE a
SET a.CurrencyCheck = 
    CASE
        -- When a_value satisfies the condition [A-Z][^A-Z][^A-Z]%
        WHEN a.currency COLLATE Latin1_General_BIN LIKE '[A-Z][^A-Z][^A-Z]%'
        THEN
            CONCAT(
                -- Get the first three characters of w.currency for concatenation
                (SELECT TOP 1 
                    LEFT(w.currency, 3)
                 FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey] w
                 WHERE CHARINDEX(a.currency, w.currency COLLATE Latin1_General_BIN) > 0
                ),
                ' ' + a.currency
            )
        ELSE a.Currency -- Use a.Currency when the condition is not met
    END
FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey] a;

----validate changes
--SELECT DISTINCT currency,CurrencyCheck
--FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey]
--;