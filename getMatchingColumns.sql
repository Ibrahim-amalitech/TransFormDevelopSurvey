DECLARE @TableName NVARCHAR(128)
DECLARE @CommonColumns NVARCHAR(MAX) = ''

-- Create a cursor to loop through table names
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME LIKE 'dev_survey%'

-- Loop through the tables
OPEN table_cursor
FETCH NEXT FROM table_cursor INTO @TableName

-- Initialize a flag to indicate the first table
DECLARE @IsFirstTable BIT = 1

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Build dynamic SQL to get column names for each table
    DECLARE @CurrentColumns NVARCHAR(MAX)

    SET @CurrentColumns = (
        SELECT COLUMN_NAME + ','
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName
        FOR XML PATH('')
    )

    -- Remove the trailing comma
    SET @CurrentColumns = LEFT(@CurrentColumns, LEN(@CurrentColumns) - 1)

    -- If it's the first table, store its columns as common columns
    IF @IsFirstTable = 1
    BEGIN
        SET @CommonColumns = @CurrentColumns
        SET @IsFirstTable = 0
    END
    ELSE
    BEGIN
        -- Intersect the current columns with the common columns
        SET @CommonColumns = (
            SELECT STRING_AGG(value, ',')
            FROM STRING_SPLIT(@CommonColumns, ',')
            WHERE value IN (SELECT value FROM STRING_SPLIT(@CurrentColumns, ','))
        )
    END

    FETCH NEXT FROM table_cursor INTO @TableName
END

-- Close and deallocate the cursor
CLOSE table_cursor
DEALLOCATE table_cursor

-- Split and select the distinct common columns
SELECT DISTINCT value AS CommonColumn
FROM STRING_SPLIT(@CommonColumns, ',')
WHERE RTRIM(value) <> ''
ORDER BY CommonColumn;
