using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myDevice.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'

class myADUser
{
    [int]
    $Id
    [string]
    [ValidatePattern("^([A-z]\w+)$")]
    $AccountName
    [string]
    [ValidatePattern("^([А-Я]\w+)\s([А-Я]\w+)\s([А-Я]\w+)$")]
    $FullName
    [string]    $Title
    [string]    $Department
    [string]    $Company
    [string]    $telephoneNumber
    [string]    $email
    [boolean]   $Enabled
    [Boolean]   $PasswordExpired
    [DateTime]  $AccountExpirationDate
    [DateTime]  $PasswordLastSet
    [System.Collections.ArrayList] $Location
    [System.Collections.ArrayList] $Devices
    [System.Collections.ArrayList] $Groups
    

    myADUser ( $Identity )
    {
        if ([bool]($Identity -as [int] -is [int]))
        {
            $ADSid = 'S-1-5-21-700513275-1716406184-4085184051-'
            $ADSid = $ADSid + $Identity
            $ADUser = Get-ADUser -Identity $ADSid -Properties *
        } else
        {
            $ADUser = Get-ADUser -Identity $Identity -Properties *
        }
        
        $this.Id            = [int]::Parse($ADUser.SID.Value.ToString().Split("-")[-1])
        $this.AccountName   = $ADUser.SamAccountName
        $this.FullName      = $ADUser.DisplayName
        $this.Title         = $ADUser.Title
        $this.Department    = $ADUser.Department
        $this.Company       = $ADUser.Company
        $this.Location      = $ADUser.l, $ADUser.StreetAddress, $ADUser.Office, $ADUser.POBox 
        $this.telephoneNumber = $ADUser.telephoneNumber
        $this.email         = $ADUser.mail
        $this.Enabled       = $ADUser.Enabled

        if ($null -eq $ADUser.AccountExpirationDate)
        {
            $this.AccountExpirationDate
        } else
        {
            $this.AccountExpirationDate = $ADUser.AccountExpirationDate
        }
        if ($null -eq $ADUser.PasswordLastSet)
        {
            $this.PasswordLastSet
        } else
        {
            $this.PasswordLastSet = $ADUser.PasswordLastSet
        }
        if ($null -eq $ADUser.APasswordExpired)
        {
            $this.PasswordExpired
        } else
        {
            $this.PasswordExpired = $ADUser.PasswordExpired
        }
    
        $this.Groups = @()
        foreach ($gg in $ADUser.MemberOF.Value.TrimStart("CN="))
        {
            $gg = $gg.split(",")[0]
            $this.Groups.Add($gg) | out-null
        }
    }


    [string] ToString()
    {
        return "{0}, {1}, {2}" -f $this.FullName, $this.Department.Trim(), $this.telephoneNumber
    }

    [void] GetUserDevice([mySqlConnection] $con)
    {
        $this.Devices = @()
        $sqlText = "SELECT * FROM accounting WHERE UserId = {0}" -f $this.Id
        $dd = $con.ReturnSQL($sqlText)
        if ($null -ne $dd)
        {
            foreach ($i in $dd.Tables[0].Rows)
            {
                $d = [myDevice]::New($i.DeviceId)
                $d.Load($con)
                $this.Devices.Add($d)
            }
        } else
        {
            $this.Devices.Add("У пользователя '{0}' еще нет учтенных МНИ" -f $this.AccountName)
        }
    }

    [void] SynchronizationWithDB([mySqlConnection] $con)
    {
        $sqlText = "SELECT Id FROM ad_user WHERE Id = {0}" -f $this.Id
        $result = $con.ReturnSQL($sqlText)
        if ($null -eq $result)
        {
            $sqlText = "INSERT INTO ad_user VALUES ({0}, '{1}', '{2}')" -f $this.Id, $this.AccountName, $this.FullName
            $con.ExeSQL($sqlText)
        }
    }
}
