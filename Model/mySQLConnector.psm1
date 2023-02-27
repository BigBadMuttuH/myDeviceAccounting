class mySqlConnection
{
    [string] $Server
    [string] $DataBase
    [string] $sqlText

    mySqlConnection()
    {
        $this.Server = "MUR-FS"
        $this.DataBase = "acl"
    }
    
    [System.Data.DataSet] ReturnSQL ([string] $sqlText)
    {
        return Invoke-Sqlcmd -ServerInstance $this.Server -Database $this.DataBase -Query $sqlText -As DataSet
    }
    [void] ExeSQL([string] $sqlText)
    {
        Invoke-Sqlcmd -ServerInstance $this.Server -Database $this.DataBase -Query $sqlText
    }
}
