USE acl;
-- DROP TABLE IF EXISTS accounting; -- CASCADE;
IF NOT EXISTS (
    SELECT * FROM sys.tables t 
    JOIN sys.schemas s ON (t.schema_id = s.schema_id) 
    WHERE s.name = 'dbo' AND t.name = 'accounting') 
	CREATE TABLE accounting (
		[Id]				INT		NOT NULL IDENTITY (1,1),
		[UserId]			INT		NOT NULL,
		[DeviceId]			INT		NOT NULL,
		[PrescriptionId]	INT,
		note TEXT,
		CONSTRAINT pk_accounting_id
			PRIMARY KEY CLUSTERED ([Id] ASC),
		CONSTRAINT fk_user_sid
			FOREIGN KEY(UserId) REFERENCES ad_user(Id),
		CONSTRAINT fk_devise_id
			FOREIGN KEY(DeviceId) REFERENCES device(Id),
		CONSTRAINT fk_prescription_id
			FOREIGN KEY(PrescriptionId) REFERENCES prescription(Id),
		UNIQUE(DeviceId)
);                        

SELECT * FROM accounting;