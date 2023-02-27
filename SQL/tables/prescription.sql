USE acl;
-- DROP TABLE IF EXISTS [dbo].[prescription];
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'prescription') 	
	CREATE TABLE [acl].[dbo].[prescription]
	(
		[Id]		INT NOT NULL IDENTITY (1,1),
		[Number]	NCHAR(22) NOT NULL, 
		[RegDate]	DATE NOT NULL DEFAULT GETDATE(), 
		[RegNumber]	NCHAR(11), 
		[URL]		TEXT NULL,
		CONSTRAINT [PK_prescription_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
	);

SELECT * FROM [acl].[dbo].[prescription];