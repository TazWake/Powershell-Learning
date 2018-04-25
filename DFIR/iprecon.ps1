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

    if ([int]$octets[0] -eq 10) {
        $test = "fail"
        Write-Host "The IP provided is in the RFC1918 private address space. It is not possible to conduct external reconnaissance against this. If this is a source of malicious activity, there may be a compromised host on the network. "
    } 
    if ([int]$octets[0] -eq 127) {
        $test = "fail"
        Write-Host "The IP provided appears to point to the local machine. No reconnaissance is possible. You might want to establish why this has shown up."
    }
    if ([int]$octets[0] -ge 224) {
        $test = "fail"
        Write-Host "This is a reserved IP Address - please see RFC3171 for more details. No reconnaissace is possible"
    }
    if ([int]$octets[0] -eq 172) {
        if ([int]$octets[1] -ge 16) {
            if ([int]$octets[1] -le 31) {
                $test = "fail"
                Write-Host "The IP provided is in the RFC1918 private address space. It is not possible to conduct external reconnaissance against this. If this is a source of malicious activity, there may be a compromised host on the network."
            }
        }
    }
    if ($firsthalf -eq "192.168") {
        $test = "fail"
        Write-Host "The IP provided is in the RFC1918 private address space. It is not possible to conduct external reconnaissance against this. If this is a source of malicious activity, there may be a compromised host on the network."
    }
    if ($test -eq "pass") {
        Write-Host "This IP address appears suitable for reconnaisance - starting browsers now"
        Start-Process -FilePath chrome.exe -ArgumentList "http://www.virustotal.com/#/ip-address/$TargetIP"
        Start-Process -FilePath chrome.exe -ArgumentList "http://www.ipvoid.com/scan/$TargetIP"
        Start-Process -FilePath chrome.exe -ArgumentList "http://www.ip-tracker.org/blacklist-check.php?ip=$TargetIP"
        Start-Process -FilePath chrome.exe -ArgumentList "http://www.evuln.com/tools/malware-scanner/$TargetIP"
    }
} 
