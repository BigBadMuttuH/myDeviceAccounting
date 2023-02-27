using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myDevice.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\Prescription.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myADUser.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'

class myAccounting
{
  [myADUser] $User
  [myDevice] $Device
  [Prescription] $Prescription

  myAccounting (
    $Identity,
    [int] $DeviceID,
    [int] $PrescriptionID)
  {
    $con = [mySqlConnection]::New()
    $this.User = [myADUser]::New($Identity)
    $this.User.GetUserDevice($con)
    $this.User.SynchronizationWithDB($con)
    $this.Device = [myDevice]::new($DeviceID)
    $this.Device.Load($con) 
    $this.Prescription = [Prescription]::new($PrescriptionID)
    $this.Prescription.Load($con)
  }
  

  [String] toString()
  {
    return "{0}, {1}::{2}, {3}" -f $this.User.AccountName, $this.Device.InventoryNumber, $this.Device.SerialNumber, $this.Prescription.URL 
  }

  [void] Insert()
  {
    $con = [mySqlConnection]::New()
    $sqlText = "INSERT INTO accounting (UserId, DeviceID, PrescriptionId) VALUES ({0}, {1}, {2})" `
      -f $this.User.Id, $this.Device.Id, $this.Prescription.Id
    $con.ExeSQL($sqlText)
  }
  [void] Update()
  {
    $con = [mySqlConnection]::New()
    $sqlText = "UPDATE accounting SET UserId = {0}, PrescriptionID = {2} WHERE DeviceID = {1}" `
      -f $this.User.Id, $this.Device.Id, $this.Prescription.Id
    $con.ExeSQL($sqlText)
  }
  [void] Remove()
  {
    $con = [mySqlConnection]::New()
  }
}
