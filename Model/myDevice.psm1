using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'

class myDevice
{
    [int]
    [ValidateRange(1,99999)]
    $Id
    [string]
    [ValidateSet("USBDevice", "License", "InfoSecurityDevice")]
    $DeviceClass
    [string]
    [ValidateLength(1,120)]
    $DeviceModel
    [string]
    [ValidateLength(1,60)]
    $InventoryNumber
    [string]
    [ValidateLength(1,60)]
    $SerialNumber

    myDevice($Id, $DeviceClass, $DeviceModel, $InventoryNumber, $SerialNumber)
    {
        $this.Id = $Id
        $this.DeviceClass = $DeviceClass
        $this.DeviceModel = $DeviceModel
        $this.InventoryNumber = $InventoryNumber
        $this.SerialNumber = $SerialNumber
    }

    # перегрузка по последнему номеру
    myDevice([mySqlConnection] $con)
    {
        $sqlText = 'SELECT MAX(Id) AS MaxID FROM device'
        $MaxId = $con.ReturnSQL($sqlText).Tables[0].Rows[0].MaxID
        $this.Id = $MaxId + 1
    }
    # Overload
    myDevice([int] $Id)
    {
        $this.Id = $Id
    }
    # Overload
    myDevice([string] $InventoryNumber)
    {
        $this.InventoryNumber = $InventoryNumber
    }

    [string] ToString ()
    {
        return "ID:{0}: IN:{1}, Model:{2}, SN:{3}" -f $this.Id, $this.InventoryNumber, $this.DeviceModel, $this.SerialNumber
    }

    [void] Load([mySqlConnection] $con)
    {
        $sqlText = "SELECT * FROM device WHERE Id  = {0}" -f $this.Id
        $result = $con.ReturnSQL($sqlText).Tables[0].Rows[0]
        $this.Id                = $result.ItemArray.Get(0)
        $this.DeviceClass       = $result.ItemArray.Get(1).ToString().Trim()
        $this.DeviceModel       = $result.ItemArray.Get(2).ToString().Trim()
        $this.InventoryNumber   = $result.ItemArray.Get(3).ToString().Trim()
        $this.SerialNumber      = $result.ItemArray.Get(4).ToString().Trim()
    }

    [void] Update([mySqlConnection] $con)
    {
        $sqlText = "UPDATE Device SET DeviceClass = '{1}', DeviceModel = '{2}', InventoryNumber = '{3}', SerialNumber = '{4}' WHERE Id = {0}" `
            -f $this.Id, $this.DeviceClass, $this.DeviceModel, $this.InventoryNumber, $this.SerialNumber
        $con.ExeSQL($sqlText)

    }
    [void] Insert([mySqlConnection] $con)
    {
        $sqlText = "INSERT INTO device (DeviceClass, DeviceModel, InventoryNumber, SerialNumber) VALUES ('{0}', '{1}', '{2}', '{3}')" `
            -f $this.DeviceClass, $this.DeviceModel, $this.InventoryNumber, $this.SerialNumber
        $con.ExeSQL($sqlText)
    }

    [void] SearchByInvetoryNumber([mySqlConnection] $con)
    {
        $sqlText = "SELECT * FROM device WHERE InventoryNumber LIKE '{0}%'" -f $this.InventoryNumber
        $result = $con.ReturnSQL($sqlText).Tables[0].Rows[0]
        $this.Id                = $result.ItemArray.Get(0)
        $this.DeviceClass       = $result.ItemArray.Get(1).ToString().Trim()
        $this.DeviceModel       = $result.ItemArray.Get(2).ToString().Trim()
        $this.InventoryNumber   = $result.ItemArray.Get(3).ToString().Trim()
        $this.SerialNumber      = $result.ItemArray.Get(4).ToString().Trim()
    }
}

class myUsbDevice : myDevice
{
    myUsbDevice([mySqlConnection] $con)
    {
        $sqlText = 'SELECT MAX(Id) AS MaxID FROM device'
        $MaxId = $con.ReturnSQL($sqlText).Tables[0].Rows[0].MaxID
        $this.Id = $MaxId + 1
        $this.DeviceClass = "USBDevice"
    }
    # Overload
    myUsbDevice([int] $Id)
    {
        $this.Id = $Id
        $this.DeviceClass = "USBDevice"
    }
}
