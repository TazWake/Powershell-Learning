Get-WinEvent -ListLog * -ComputerName ABC | Where-Object {$_.RecordCount -GT 0} | select Logname,RecordCount
