# Quick system triage
# This PS Script is designed to run a series of tasks for IR and record them in an activity record.

# ## Create Activity Folder
$f = Get-Date -Format FileDateTimeUniversal
$f = "Analysis" + $f
New-Item $f -type directory

# ## Begin Activity Logging
Add-Content $f\ActivityRecord.txt "------------------------"
Add-Content $f\ActivityRecord.txt "Begining Data Collection"
Add-Content $f\ActivityRecord.txt "------------------------"
Add-Content $f\ActivityRecord.txt "`n"

# Log Device ID
$a = Get-WMIObject Win32_ComputerSystem | Select-Object -ExpandProperty name
$b = "Target machine: " + $a
Add-Content $f\ActivityRecord.txt $b

# Timestamp
$a = Get-Date
$a = $a.ToUniversalTime()
$b = "Collection Begins: " + $a
Add-Content $f\ActivityRecord.txt $b

# ## Capture Processes

Add-Content $f\ActivityRecord.txt ""
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt "Checking Running Proccesses"
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt ""

Get-Process | Sort StartTime | Out-File $f\RunningProcesses.txt
$proclisthash = Get-FileHash $f\RunningProcesses.txt | Select Hash
$proclisthash = $proclisthash -replace "@{Hash=",""
$proclisthash = $proclisthash -replace "}",""
$proclisthash = "ProcessList.txt File Hash (SHA256): " + $proclisthash

$proclistcount = Get-Content $f\RunningProcesses.txt | Measure-Object -Line | Select Lines
$proclistcount = $proclistcount -replace "@{Lines=",""
$proclistcount = $proclistcount -replace "}",""
$proclistcount = $proclistcount -= 2
$proclistcount = "Number of Processes Logged: " + $proclistcount

Add-Content $f\ActivityRecord.txt "A process list has been taken from memory and copied to ProcessList.txt"
Add-Content $f\ActivityRecord.txt $proclisthash
Add-Content $f\ActivityRecord.txt $proclistcount

# Look for impersonation
$h = Get-Process | Select ProcessName
$h = $h -replace "@{ProcessName=",""
$h = $h -replace "}",""

foreach ($i in $h) {
    $procname = $i
    $p = $i | Measure-Object -character;
    $c = $p.Characters
    if ($c -le 2) {
        # TO DO - Select PID Here
        $fileup = "Unusually short file name - Process: " + $procname
        Add-Content $f\ActivityRecord.txt $fileup
    }
    if ($i -match "dllhot|d1lhost|dl1host|diihost|dIIhost|d11host|dIlhost|dlIhost") {
        $fileup = "Possible DLLHOST Impersonation: " + $procname
        Add-Content $f\ActivityRecord.txt $fileup
    }
    if ($i -match "svchot|svch0st|scvhost|scvh0st") {
        $fileup = "Possible SVCHOST Impersonation: " + $procname
        Add-Content $f\ActivityRecord.txt $fileup
    }
}


# ## Capture Services

Add-Content $f\ActivityRecord.txt ""
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt "     Checking Services"
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt ""

Get-Service | Where-Object { $_.Status -eq "Running" } | Out-File $f\RunningServices.txt
Get-Service | Where-Object { $_.Status -eq "Stopped" } | Out-File $f\StoppedServices.txt
$runningservicehash = Get-FileHash $f\RunningServices.txt | Select Hash
$runningservicehash = $runningservicehash -replace "@{Hash=",""
$runningservicehash = $runningservicehash -replace "}",""
$a = "RunningServices.txt file hash: " + $runningservicehash
$runningservicescount = Get-Content $f\RunningServices.txt | Measure-Object -Line | Select Lines
$runningservicescount = $runningservicescount -replace "@{Lines=",""
$runningservicescount = $runningservicescount -replace "}",""
$b = $runningservicescount -= 2
$b = "Number of running services: " + $b

Add-Content $f\ActivityRecord.txt "A list of running services has been created in RunningServices.txt"
Add-Content $f\ActivityRecord.txt $a
Add-Content $f\ActivityRecord.txt $b

$stopservhash = Get-FileHash $f\StoppedServices.txt | Select Hash
$stopservhash = $stopservhash -replace "@{Hash=",""
$stopservhash = $stopservhash -replace "}",""
$a = "StoppedServices.txt file hash: " + $stopservhash
$stopservcnt = Get-Content $f\StoppedServices.txt | Measure-Object -Line | Select Lines
$stopservcnt = $stopservcnt -replace "@{Lines=",""
$stopservcnt = $stopservcnt -replace "}",""
$b = $stopservcnt -= 2
$b = "Number of services stopped: " + $b

Add-Content $f\ActivityRecord.txt "A list of stopped services has been created in StoppedServices.txt"
Add-Content $f\ActivityRecord.txt $a
Add-Content $f\ActivityRecord.txt $b

# ## End Capture
Add-Content $f\ActivityRecord.txt ""
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt "     TASKS COMPLETE"
Add-Content $f\ActivityRecord.txt "---------------------------"
Add-Content $f\ActivityRecord.txt ""

$endtime = Get-Date
$a = $endtime.ToUniversalTime()
$b = "Activity Completed: " + $a
Add-Content $f\ActivityRecord.txt $b

Add-Content $f\ActivityRecord.txt ""
Add-Content $f\ActivityRecord.txt "---------------------------"
