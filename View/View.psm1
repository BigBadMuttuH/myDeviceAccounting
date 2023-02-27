using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myDevice.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\Prescription.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myADUser.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myAccounting.psm1'

class myView
{
  [int]
  [ValidateRange(1,99999)]
  $MaxRows
  [string]
  [ValidateSet("accounting", "device", "prescription")]
  $Table
  [System.Collections.ArrayList] $View

  myView([int] $MaxRows, [string] $table)
  {
    $con = [mySqlConnection]::new()

    $this.MaxRows = $MaxRows
    $this.Table   = $table
    $sqlText = "SELECT * FROM (SELECT TOP({0}) * FROM {1} ORDER BY Id DESC) AS T ORDER BY T.Id ASC" -f $this.MaxRows, $this.Table
    $result = $con.ReturnSQL($sqlText).Tables[0]
    $this.View = [System.Collections.ArrayList]::New($result.Rows.Count)
    foreach ($item in $result.Rows)
    {
      switch ($this.Table)
      {
        "accounting"
        {
          $this.View.Add([myAccounting]::New($item.UserId, $item.DeviceId, $item.PrescriptionId))
        }
        "device"
        {
          $this.View.Add([myDevice]::New($item.Id, $item.DeviceClass.Trim(), $item.DeviceModel.Trim(), $item.InventoryNumber.Trim(), $item.SerialNumber))
        }
        "prescription"
        {
          $this.View.Add([Prescription]::New($item.Id, $item.Number, $item.RegDate, $item.RegNumber, $item.URL))
        }
      }
    }
  }
}

Function Get-MyView (
  [string]
  [ValidateSet("accounting", "device", "prescription")]
  $Table,
  [int]
  [ValidateRange(1,10000)]
  $MaxRows = 1000
)
{
  $v = [myView]::New($MaxRows, $Table)
  Write-Verbose "Последние $MaxRows стр. из таблицы: $Table"
  $v.View
}


Set-Alias -Name gmv -Value Get-MyView      
