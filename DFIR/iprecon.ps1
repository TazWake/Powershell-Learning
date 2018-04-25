<#
.SYNOPSIS
A script to assist incident handlers in looking up suspicious IP address, either found in logs or provided through other IR Tools
.DESCRIPTION
Carries out a check on multiple websites to gather information.
.EXAMPLE
iprecon.ps1 -TargetIP 8.8.8.8
.EXAMPLE
.LINK
https://github.com/TazWake/Powershell-Learning/blob/master/DFIR/iprecon.ps1
.NOTES
To Do List
1) Output to a file
2) Allow multiple input IPs
3) Improve quality of search tools utilised
4) Work out why 8.x and 88.x IP addresses trigger as reserved.
#>
param(
     [Parameter(Mandatory=$true)][string]$TargetIP
     )
$test = "pass"
$separator = "."
$octets = $TargetIP.split($separator)
$firsthalf = $octets[0]+ "." + $octets[1]

<# check data #>

if ([ipaddress]$TargetIP) {
Write-Host "Checking IP Address"

    if ($octets[0] -eq 10) {
        $test = "fail"
        Write-Host "This is a private IP Address. No Recon is possible"
    } 
    if ($octets[0] -eq 127) {
        $test = "fail"
        Write-Host "This is a loopback IP Address. No Recon is possible"
    }
    if ($octets[0] -ge 224) {
        $test = "fail"
        Write-Host "This is a reserved IP Address. No Recon is possible"
    }
    if ($octets[0] -eq 172) {
        if ($octets[1] -ge 16) {
            if ($octets[1] -le 31) {
                $test = "fail"
                Write-Host "This is a private IP Address. No Recon is possible"
            }
        }
    }
    if ($firsthalf -eq "192.168") {
        $test = "fail"
        Write-Host "This is a private IP Address. No Recon is possible"
    }
    if ($test -eq "pass") {
        Write-Host "This IP address appears suitable for reconnaisance - starting browsers now"
    }
} 

<# begin searches #>
if ($test -eq "pass") {
    Start-Process -FilePath chrome.exe -ArgumentList "http://www.virustotal.com/#/ip-address/$TargetIP"
    Start-Process -FilePath chrome.exe -ArgumentList "http://www.ipvoid.com/scan/$TargetIP"
    Start-Process -FilePath chrome.exe -ArgumentList "http://www.ip-tracker.org/blacklist-check.php?ip=$TargetIP"
    Start-Process -FilePath chrome.exe -ArgumentList "http://www.evuln.com/tools/malware-scanner/$TargetIP"
    }
