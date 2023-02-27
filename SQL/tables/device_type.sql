USE acl;
-- DROP TABLE IF EXISTS [dbo].[device_type];
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'device_type') 
CREATE TABLE [dbo].[device_type]
(
	[device_type_id] INT NOT NULL IDENTITY(1,1), 
    [device_type] NCHAR(16) NOT NULL UNIQUE,
    CONSTRAINT [PK_device_typw] PRIMARY KEY CLUSTERED ([device_type_id] ASC)
)
/*
INSERT INTO device_type (device_type) VALUES
('USB-device'),
('Athena SmartCard'),
('АПКШ Континент'),
('Генератор шума'),
('Лицензия');
*/

SELECT * FROM [acl].[dbo].[device_type] ORDER BY device_type_id;