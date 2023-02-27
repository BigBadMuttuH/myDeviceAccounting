USE acl; --SvcControlUSB
SELECT * FROM accounting ORDER BY DeviceId;
SELECT * FROM accounting WHERE UserId = 30050424;
SELECT * FROM inventory WHERE InventoryNumber LIKE '0300%';
SELECT * FROM inventory;
SELECT * FROM logbook;
SELECT * FROM accounting WHERE UserId = 200108;
SELECT * FROM (SELECT TOP(10) * FROM prescription ORDER BY Id DESC) AS T ORDER BY T.Id ASC;
/*
SELECT * FROM logbook;
SELECT * FROM inventory WHERE SerialNumber = '900072B5423D3755';
SELECT * FROM device WHERE Id = 300;
SELECT * FROM prescription                                                                                                                  
UPDATE device set DeviceModel ='USB DISK 3.0 USB Device' WHERE Id = 300;                                                                                                                    
UPDATE device set inventoryNumber ='0300/04П' WHERE Id = 300; 

SELECT * FROM device WHERE SerialNumber = '900072B5423D3755';
UPDATE device set SerialNumber = '900072B5423D3755' WHERE Id = 151;
SELECT * FROM logbook WHERE [МНИ] LIKE '0300%';
*/
                                                                                                
/*
SELECT * FROM prescription;
SELECT MAX(Id) AS MaxID FROM device;
*/


/*
-- TRUNCATE TABLE device;
-- INSERT INTO prescription(prescription_number, reg_number) VALUES
-- ('23/10207000/12-58/001', '2019-01-01');
SELECT * FROM prescription WHERE number LIKE '%46';
SELECT * FROM prescription ORDER BY prescription_id;
UPDATE prescription
	SET url = '<a href="prescriptions/0001.pdf" style="text-align: left;">X</a>'
	WHERE prescription_id = 1;

SELECT * FROM device_type;

INSERT INTO device(type_id, device_model, serial_number, inventory_number) VALUES
(1, 'Kingston DataTraveler G2 USB Device', '001CC05FE930F9A0115B0261', '0001/23П');
SELECT * FROM device;

SELECT device_type.device_type, device.device_model, device.serial_number, device.inventory_number FROM device
JOIN device_type ON device_type.device_type_id = device.type_id
ORDER BY device.inventory_number;

SELECT * FROM department WHERE department_short_name LIKE 'Мурманский%'; --41

SELECT * FROM ad_user WHERE department_id > 0;
SELECT * FROM ad_user WHERE account_name = 'StatnovDA';

UPDATE ad_user
	SET department_id = 41
	WHERE account_name = 'StatnovDA';
	
SELECT ad_user.account_name, ad_user.full_name, department.department_short_name FROM ad_user
JOIN department ON department.department_id = ad_user.department_id;

INSERT INTO accounting(device_id, user_sid, prescription_id, note)
VALUES -- ИДФлешки (Может не совпадать с номером), ИД пользователя, НомерПредписания
	(9, 29956165, 46, '');
	
UPDATE accounting
	SET
		device_id = 9,
		prescription_id = 46
	WHERE user_sid = 29956165;
	
SELECT * FROM accounting;

SELECT * FROM inventory;

SELECT * FROM inventory WHERE inventory_number LIKE '%15%'
*/


-- UPDATE prescription SET Number = '34/10207000/12-58/0002', RegDate = '2019-10-30', RegNumber = '', URL = 'http://mur-fs/prescriptions/0002.pdf' WHERE Id = 2;
	
/*
SELECT * FROM device WHERE inventory_number LIKE '0020/%'

SELECT * FROM ad_user WHERE account_name = 'KulaykovDN';

INSERT INTO accounting (device_id, user_id, prescription_id) VALUES
(19, 157, 2);


SELECT * FROM inventory;



SELECT * FROM prescription WHERE Id = 2;

UPDATE prescription
	SET
		Number = '34/10207000/12-58/0002',
		RegDate = '2019-10-09',
		RegNumber = '',
		URL = 'http://mur-fs/prescriptions/0002.pdf'
	WHERE Id = 2;
*/