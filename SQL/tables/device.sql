USE acl;
-- DROP TABLE IF EXISTS [dbo].[device];
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'device') 	
	CREATE TABLE [dbo].[device]
	(
		[Id] INT NOT NULL IDENTITY (1,1), 
		[DeviceClass] NCHAR(30) NOT NULL, 
		[DeviceModel] NCHAR(120) NOT NULL, 
		[InventoryNumber] NCHAR(30) NOT NULL, 
		[SerialNumber] NCHAR(30) NULL,
--		[VID] varchar(6),
--		[PID] varchar(6),
		UNIQUE([SerialNumber]),
		CONSTRAINT
			[PK_device_id] PRIMARY KEY ([Id]), 
--		CONSTRAINT
-- 			[FK_type_id] FOREIGN KEY ([type_id]) REFERENCES [dbo].[device_type]([device_type_id])
	);


SELECT * FROM [acl].[dbo].[device];

