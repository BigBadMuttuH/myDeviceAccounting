USE acl;
-- DROP TABLE IF EXISTS [dbo].[ad_user];
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'ad_user') 
	CREATE TABLE [dbo].[ad_user] (
		[Id]			INT        NOT NULL ,
		[AccountName]	NCHAR (30) NOT NULL,
		[FullName]     NCHAR (100) NOT NULL,
		CONSTRAINT
			[PK_id] PRIMARY KEY CLUSTERED ([id] ASC),
		UNIQUE(AccountName),
);

SELECT * FROM ad_user;