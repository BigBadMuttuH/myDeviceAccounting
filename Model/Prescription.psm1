using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'

class Prescription
{
    [int]
    [ValidateRange(1,99999)]
    $Id
    [string]
    [ValidateLength(1,22)]
    $Number
    [System.DateOnly]
    $RegDate
    [string]
    [ValidateLength(0,11)]
    $RegNumber
    [String]
    $URL

    Prescription($Id, $Number, $RegDate, $RegNumber, $URL)
    {
        $this.Id        = $Id
        $this.Number    = $Number
        $dt = $RegDate.Day, $RegDate.Month, $RegDate.Year -join "."
        $this.RegDate   = [System.DateOnly]::Parse($dt)
        $this.RegNumber = $RegNumber
        $this.URL       = $URL
    }

    Prescription([mySqlConnection] $con)
    {
        $sqlText = 'SELECT MAX(Id) AS MaxID FROM prescription'
        $MaxId = $con.ReturnSQL($sqlText).Tables[0].Rows[0].MaxID
        $this.Id = $MaxId + 1
    }
    # Overload
    Prescription([int] $Id)
    {
        $this.Id = $Id
    }
    # Overload
    Prescription([string] $Number)
    {
        $this.Number = $Number
    }

    [string] ToString()
    {
        return "ID:{0}: #{1}; URL: {2}" -f $this.Id, $this.Number, $this.URL
    }

    [void] Load([mySqlConnection] $con)
    {
        $sqlText = "SELECT * FROM prescription WHERE Id = {0}" -f $this.Id
        $result = $con.ReturnSQL($sqlText).Tables[0].Rows[0]
        $this.Number    = $result.Number
        $dt = $result.RegDate.Day, $result.RegDate.Month, $result.RegDate.Year -join "."
        $this.RegDate   = [System.DateOnly]::Parse($dt)
        $this.RegNumber = $result.ItemArray.Get(3)
        $this.URL       = $result.ItemArray.Get(4)
    }

    [void] Update([mySqlConnection] $con)
    {
        $dateConvert = "{0}-{1}-{2}" -f $this.RegDate.Year, $this.RegDate.Month, $this.RegDate.Day
        $sqlText = "UPDATE prescription SET Number = '{1}', RegDate = '{2}', RegNumber = '{3}', URL = '{4}' WHERE Id = {0}" `
            -f $this.Id, $this.Number, $dateConvert, $this.RegNumber, $this.URL
        $con.ExeSQL($sqlText)
    }

    [void] Insert([mySqlConnection] $con)
    {
        $dateConvert = "{0}-{1}-{2}" -f $this.RegDate.Year, $this.RegDate.Month, $this.RegDate.Day
        $sqlText = "INSERT INTO Prescription (Number, RegDate, RegNumber, URL) VALUES ('{0}', '{1}', '{2}', '{3}')" `
            -f $this.Number, $dateConvert, $this.RegNumber, $this.URL
        $con.ExeSQL($sqlText)
    }
}
