# Quick system triage

# ## Begin Activity Logging
Add-Content .\ActivityRecord.txt "------------------------"
Add-Content .\ActivityRecord.txt "Begining Data Collection"
Add-Content .\ActivityRecord.txt "------------------------"
Add-Content .\ActivityRecord.txt "`n"

# Log Device ID
$a = Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty name
$b = "Target machine: " + $a
Add-Content .\ActivityRecord.txt $b

# Timestamp
$a = Get-Date
$a = $a.ToUniversalTime()
$b = "Collection Begins: " + $a
Add-Content .\ActivityRecord.txt $b

# ## Capture Processes

Add-Content .\ActivityRecord.txt ""
Add-Content .\ActivityRecord.txt "---------------------------"
Add-Content .\ActivityRecord.txt "Checking Running Proccesses"
Add-Content .\ActivityRecord.txt "---------------------------"
Add-Content .\ActivityRecord.txt ""

Get-Process | Sort StartTime | Out-File .\RunningProcesses.txt
$proclisthash = Get-FileHash .\RunningProcesses.txt | Select Hash
$proclisthash = $proclisthash -replace "@{Hash=",""
$proclisthash = $proclisthash -replace "}",""
$proclisthash = "ProcessList.txt File Hash (SHA256): " + $proclisthash

$proclistcount = Get-Content .\RunningProcesses.txt | Measure-Object -Line | Select Lines
$proclistcount = $proclistcount -replace "@{Lines=",""
$proclistcount = $proclistcount -replace "}",""
$proclistcount = $proclistcount -= 2
$proclistcount = "Number of Processes Logged: " + $proclistcount

Add-Content .\ActivityRecord.txt "A process list has been taken from memory and copied to ProcessList.txt"
Add-Content .\ActivityRecord.txt $proclisthash
Add-Content .\ActivityRecord.txt $proclistcount

# ## End Capture
Add-Content .\ActivityRecord.txt ""
Add-Content .\ActivityRecord.txt "---------------------------"
Add-Content .\ActivityRecord.txt "     TASKS COMPLETE"
Add-Content .\ActivityRecord.txt "---------------------------"
Add-Content .\ActivityRecord.txt ""

$endtime = Get-Date
$a = $endtime.ToUniversalTime()
$b = "Activity Completed: " + $a
Add-Content .\ActivityRecord.txt $b

Add-Content .\ActivityRecord.txt ""
Add-Content .\ActivityRecord.txt "---------------------------"
