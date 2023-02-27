USE acl;
-- DROP TABLE IF EXISTS [dbo].[department];
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'department') 	
	CREATE TABLE [dbo].[department]
	(
		[department_id] INT NOT NULL IDENTITY (1,1), 
		[department_short_name] NCHAR(35) NOT NULL, 
		[department_name] NCHAR(100), 
		[telephone] NCHAR(24) NULL,
		UNIQUE([department_name], [department_short_name]),
		CONSTRAINT
			[PK_departmen_id] PRIMARY KEY ([department_id] ASC)
	)

SELECT * FROM department;