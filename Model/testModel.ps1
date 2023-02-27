using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myDevice.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\Prescription.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myADUser.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\mySQLConnector.psm1'
using module 'C:\Program Files\WindowsPowerShell\Modules\Regions2MSSQL\Model\myAccounting.psm1'

# $c = [mySQLConnection]::New()
# $u = [myADUser]::New("SveshnikovaAI")
# $u.GetUserDevice($c)

# $u = [myADUser]::New("SVCControlUSB")
# $u.GetFromAD()

# class Accounting {
#     [myADUser] $myADUser
#     [myDevice] $myDevice
#     [Prescription] $Prescription

#     Accounting([string] $ADuser) {
#         $this.myADUser = [myADUser]::New($ADuser)
#         $this.myDevice = [myDevice]::New()
#         $this.Prescription = [Prescription]::New(0)
#     }

#     [void] ShowLastPrescription ([mySqlConnection] $con) {
#         $MaxId = $con.ReturnSQL("SELECT MAX(Id) FROM prescription").Tables[0].Row[0].Column1
#         "Last Prescription: {0}" -f $MaxId
#     }
# }

$c = [mySqlConnection]::New()
# $a = [Accounting]::New("GoldinAP")
# $a.ShowLastPrescription($c)
# $x = Invoke-Sqlcmd -ServerInstance mur-fs -Database acl -Query "SELECT MAX(Id) FROM prescription"   
# $x.Column1.GetType()


$p = [Prescription]::New(2)
# $t = "SELECT * FROM Prescription"
# $r = $c.ExeSQL($t).Tables[0].Rows[0]
# $r
# $r.RegDate.Date
# $p = [Prescription]::New(2)
$p.Load($c)
# $p.RegDate = "07/15/2021"
# $p
# $p.Update($c)
# $p
# $p.Load($C)
# $p
# class myModel {
#     static [mySqlConnection] $conn = [mySqlConnection]::New()

#     [myADUser] $ADuser
#     [myDevice] $myDevice
#     [Prescription] $pr

#     myModel ([string] $SamAccontName){
#         $this.ADuser = [myADUser]::New($SamAccontName)
#         $this.ADuser.GetFromAD()


#     }
# }

# $m = [myModel]::New("GoldinAP")
# $m

# Remove-Module Device, Connector, User, Prescription -Force
# $u1 = [User]::new()
# $u2 = [myADUser]::new("GoldinAP")
# $u2.GetFromAD()
# $d1 = [Device]::new()
# $d2 = [UsbDevice]::new("0001/35", "Kingston", "1230918310983")
# $u1
# $u2
# $d1
# $d2
# $p1
# # $t = "SELECT * FROM prescription WHERE prescription_Id = 1"
# $t = "SELECT * FROM prescription"
# $s = [mySqlConnection]::new($t)
# $dbDate = Invoke-Sqlcmd -ServerInstance $s.Server -Database $s.DataBase -Query $s.text
# $p1.Number = $dbDate.ItemArray.GetValue(1)
# $p1.RegistrationDate = [System.DateOnly]::ParseExact(($dbDate.ItemArray.Get(2).ToString().Split()[0]), "dd.mm.yyyy", $null)
# $p1.RegistrationNumber = $dbDate.ItemArray.Get(3)
# $p1.URL = $dbDate.ItemArray.Get(4)
# $p1
# $p1 = [Prescription]::new(100)
# $c = [mySqlConnection]::new()
# $p1.GetPrescription($c)
# $p1
# $con = [mySqlConnection]::new()
# $r = $con.ExeSQL("SELECT * FROM prescription").ItemArray
# $r