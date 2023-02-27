/*
USE acl;
DROP VIEW logbook;
*/
CREATE VIEW logbook
AS
SELECT
	prescription.RegDate as [����],
	TRIM(device.InventoryNumber) as [���],
	CONCAT(TRIM(device.DeviceModel), '; ', TRIM(device.SerialNumber)) as [ID],
	CONCAT(TRIM(ad_user.FullName), ' (',TRIM(ad_user.AccountName), ')') as [���],
	TRIM(prescription.Number) as [����� �����������]
FROM
	accounting
	JOIN ad_user ON accounting.UserId = ad_user.Id
	JOIN device ON accounting.DeviceId = device.Id
	JOIN prescription ON accounting.PrescriptionId = prescription.Id
ORDER BY device.InventoryNumber ASC OFFSET 0 ROWS;