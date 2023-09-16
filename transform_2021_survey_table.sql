USE TrendStreamDB;

-- Declare variables
DECLARE @TableName1 NVARCHAR(128) = 'dev_survey_2021'; -- Replace with your actual table name
DECLARE @TableName2 NVARCHAR(128);
DECLARE @SQL NVARCHAR(MAX);

-- Extract the year from TableName1
DECLARE @Year NVARCHAR(4);
SET @Year = SUBSTRING(@TableName1, CHARINDEX('y', @TableName1) + 2, 4);

-- Set the name of TableName2 programmatically
SET @TableName2 = 'dev_survey_' + @Year + '_processed';
-- Print the value of @TableName2
PRINT @TableName2;



-- Create table_2 with the desired structure
DECLARE @Table2SQL NVARCHAR(MAX);

SET @Table2SQL = '
    CREATE TABLE ' + QUOTENAME(@TableName2) + ' (
		EducationLevel NVARCHAR(MAX) NULL,	
		ObjectiveForCoding NVARCHAR(MAX) NULL,
		JobDescription NVARCHAR(MAX) NULL,
		EmploymentStatus NVARCHAR(MAX) NULL,
		OrgSize NVARCHAR(MAX) NULL,
		YearsCode NVARCHAR(MAX) NULL,
		YearsCodePro NVARCHAR(MAX) NULL,
		Age NVARCHAR(MAX) NULL,
		LanguagesHaveWorkedWith NVARCHAR(MAX) NULL,
		LanguagesWantToWorkWith NVARCHAR(MAX) NULL,
		DatabasesHaveWorkedWith NVARCHAR(MAX) NULL,
		DatabasesWantToWorkWith NVARCHAR(MAX) NULL,
		PlatformsHaveWorkedWith NVARCHAR(MAX) NULL,
		PlatformWantToWorkWith NVARCHAR(MAX) NULL,
		WebFrameHaveWorkedWith NVARCHAR(MAX) NULL,
		WebFrameWantToWorkWith NVARCHAR(MAX) NULL,
		OtherTechHaveWorkedWith NVARCHAR(MAX) NULL,
		OtherTechWantToWorkWith NVARCHAR(MAX) NULL,
		NEWCollabToolsHaveWorkedWith NVARCHAR(MAX) NULL,
		NEWCollabToolsWantToWorkWith NVARCHAR(MAX) NULL,
		ToolsTechHaveWorkedWith NVARCHAR(MAX) NULL,
		ToolsTechWantToWorkWith NVARCHAR(MAX) NULL,
		Country NVARCHAR(MAX) NULL,
		StateORProvince VARCHAR(MAX) NULL,
		OsForProfessionalUse NVARCHAR(MAX) NULL,
		Currency NVARCHAR(MAX) NULL,
		AnnualCompensation NVARCHAR(MAX),
		Sexuality VARCHAR(MAX) NULL,
		Ethnicity VARCHAR(MAX) NULL,
        Year INT NOT NULL DEFAULT 2023
    );';

-- Execute the SQL to create table_2
EXEC sp_executesql @Table2SQL;


-- Insert data into TableName2 from [TrendStreamDB].[dbo].[dev_survey_2023]
SET @SQL = '
    INSERT INTO ' + QUOTENAME(@TableName2) + ' (
		EducationLevel,
		ObjectiveForCoding,
		JobDescription,
		EmploymentStatus,
		OrgSize,
		YearsCode,
		YearsCodePro,
		Age,
		LanguagesHaveWorkedWith,
		LanguagesWantToWorkWith,
		DatabasesHaveWorkedWith,
		DatabasesWantToWorkWith,
		PlatformsHaveWorkedWith,
		PlatformWantToWorkWith,
		WebFrameHaveWorkedWith,
		WebFrameWantToWorkWith,
		OtherTechHaveWorkedWith,
		OtherTechWantToWorkWith,
		NEWCollabToolsHaveWorkedWith,
		NEWCollabToolsWantToWorkWith,
		ToolsTechHaveWorkedWith,
		ToolsTechWantToWorkWith,
		Country,
		StateORProvince,
		OsForProfessionalUse,
		Currency,
		AnnualCompensation,
		Sexuality,
		Ethnicity,
        Year
    )
    SELECT
		[EdLevel] AS EducationLevel,
		[MainBranch] AS ObjectiveForCoding,
		[DevType] AS JobDescription,
		[Employment] AS EmploymentStatus,
		[OrgSize] AS OrgSize,
		[YearsCode] AS YearsCode,
		[YearsCodePro] AS YearsCodePro,
		[Age] AS Age,
		[LanguageHaveWorkedWith] AS LanguagesHaveWorkedWith,
		[LanguageWantToWorkWith] AS LanguagesWantToWorkWith,
		[DatabaseHaveWorkedWith] AS DatabasesHaveWorkedWith,
		[DatabaseWantToWorkWith] AS DatabasesWantToWorkWith,
		[PlatformHaveWorkedWith] AS PlatformsHaveWorkedWith,
		[PlatformWantToWorkWith] AS PlatformWantToWorkWith,
		[WebframeHaveWorkedWith] AS WebFrameHaveWorkedWith,
		[WebframeWantToWorkWith] AS WebFrameWantToWorkWith,
		[MiscTechHaveWorkedWith] AS OtherTechHaveWorkedWith,
		[MiscTechWantToWorkWith] AS OtherTechWantToWorkWith,
		[NEWCollabToolsHaveWorkedWith] AS NEWCollabToolsHaveWorkedWith,
		[NEWCollabToolsWantToWorkWith] AS NEWCollabToolsWantToWorkWith,
		[ToolsTechHaveWorkedWith] AS ToolsTechHaveWorkedWith,
        [ToolsTechWantToWorkWith] AS ToolsTechWantToWorkWith,
		[Country] AS Country,
		[US_State] AS StateORProvince,
		[OpSys] AS OsForProfessionalUse,
		[Currency] AS Currency,
		[CompTotal] AS AnnualCompensation,
		[Sexuality] AS Sexuality,
		[Ethnicity] AS Ethnicity,
        ' + @Year + ' AS Year
    FROM [TrendStreamDB].[dbo].[dev_survey_2021];';

-- Execute the SQL to insert data into TableName2
EXEC sp_executesql @SQL;


-- Alter table_2 to add the missing columns
SET @Table2SQL = '
    ALTER TABLE ' + QUOTENAME(@TableName2) + '
    ADD CodingCertificatesPlatforms VARCHAR(MAX) NULL,
	    LearnCodeHow NVARCHAR(MAX) NULL,
		LearnCodeOnlineWhere NVARCHAR(MAX) NULL,
		CodingActivities NVARCHAR(MAX) NULL,
		RemoteWork NVARCHAR(MAX) NULL,
		IndustryType NVARCHAR(MAX) NULL,
		CollabWorkManagementToolsHaveWorkedWith NVARCHAR(MAX) NULL,
		CollabWorkManagementToolsWantToWorkWith NVARCHAR(MAX) NULL,
		CommunicationToolsHaveWorkedWith NVARCHAR(MAX) NULL,
		CommunicationToolsWantToWorkWith NVARCHAR(MAX) NULL,
		AISearchHaveWorkedWith NVARCHAR(MAX) NULL,
		AISearchWantToWorkWith NVARCHAR(MAX) NULL,
		AIDevHaveWorkedWith NVARCHAR(MAX) NULL,
		AIDevWantToWorkWith NVARCHAR(MAX) NULL,
		AITrust NVARCHAR(MAX) NULL,
		AIBenefits NVARCHAR(MAX) NULL,
		DoYouCurrentlyUseAITools NVARCHAR(MAX) NULL, 
		AIToolCurrentlyUsing NVARCHAR(MAX) NULL,
		TaskNotInterestedInUsingAIFor NVARCHAR(MAX) NULL,
		OsForPersonalUse NVARCHAR(MAX) NULL,
		UnderGradMajor VARCHAR(MAX) NULL,
		VersionControlUsage VARCHAR(MAX) NULL,
        OfficeStack VARCHAR(MAX) NULL';

-- Execute the SQL to add the missing columns to table_2
EXEC sp_executesql @Table2SQL;
