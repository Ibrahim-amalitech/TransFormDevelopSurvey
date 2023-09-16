-- Create a temporary table to store table information
CREATE TABLE #TableInfo
(
    TableName NVARCHAR(255),
    ColumnCount INT
);

-- Query for tables whose names end with 'processed' and count their columns
INSERT INTO #TableInfo
SELECT 
    t.name AS TableName,
    COUNT(c.name) AS ColumnCount
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
WHERE t.name LIKE '%processed'
GROUP BY t.name;

-- Get the list of distinct column counts
DECLARE @DistinctColumnCounts INT;
SELECT @DistinctColumnCounts = COUNT(DISTINCT ColumnCount) FROM #TableInfo;

-- Compare table structures
IF @DistinctColumnCounts > 1
BEGIN
    PRINT 'Tables deviating from the conditions:';
    SELECT TableName, ColumnCount FROM #TableInfo;
END
ELSE
BEGIN
    PRINT 'All tables have the same column count and structure.';
END

-- Clean up the temporary table
DROP TABLE #TableInfo;
