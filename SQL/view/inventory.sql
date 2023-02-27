/*
USE acl;
DROP VIEW inventory;
*/
CREATE VIEW inventory
AS
SELECT
	accounting.Id,
	ad_user.AccountName,
	ad_user.FullName,
	device.DeviceClass,
	device.DeviceModel,
	device.InventoryNumber,
	device.SerialNumber,
	prescription.Number,
	prescription.URL
FROM
	accounting
	JOIN ad_user ON accounting.UserId = ad_user.Id
	JOIN device ON accounting.DeviceId = device.Id
	JOIN prescription ON accounting.PrescriptionId = prescription.Id
ORDER BY device.InventoryNumber ASC OFFSET 0 ROWS;