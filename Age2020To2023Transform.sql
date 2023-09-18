USE TrendStreamDB;

-- Add a new column 'AgeCategory'
ALTER TABLE [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey]
ADD [AgeCategory] NVARCHAR(50); -- You can adjust the length (50) as needed

-- Update 'AgeCategory' column based on 'Age'
UPDATE [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey]
SET AgeCategory =
    CASE
        WHEN Age IS NULL OR Age = '' THEN 'Prefer not to say'
        WHEN TRY_CAST(Age AS FLOAT) IS NOT NULL THEN
            CASE
                WHEN CAST(Age AS FLOAT) < 18 THEN 'Under 18 years old'
                WHEN CAST(Age AS FLOAT) BETWEEN 18 AND 24.9 THEN '18-24 years old'
                WHEN CAST(Age AS FLOAT) BETWEEN 25 AND 34.9 THEN '25-34 years old'
                WHEN CAST(Age AS FLOAT) BETWEEN 35 AND 44.9 THEN '35-44 years old'
                WHEN CAST(Age AS FLOAT) BETWEEN 45 AND 54.9 THEN '45-54 years old'
				WHEN CAST(Age AS FLOAT) BETWEEN 55 AND 64.9 THEN '45-54 years old'
                WHEN CAST(Age AS FLOAT) >= 65 THEN '65 years or older'
                ELSE AgeCategory  -- Handle other cases as needed
            END
        WHEN CHARINDEX('-', Age) > 0 THEN
            CASE
                WHEN CAST(SUBSTRING(Age, 1, CHARINDEX('-', Age) - 1) AS FLOAT) < 18 THEN 'Under 18 years old'
                WHEN CAST(SUBSTRING(Age, 1, CHARINDEX('-', Age) - 1) AS FLOAT) BETWEEN 18 AND 24 THEN '18-24 years old'
                -- Add more range cases as needed
                ELSE AgeCategory  -- Handle other cases as needed
            END
        ELSE AgeCategory  -- Handle other cases as needed
    END;

----validate changes
--SELECT DISTINCT Age,AgeCategory
--FROM [TrendStreamDB].[dbo].[dev_survey_2020_to_2023_utf8_encoded_primarykey];	