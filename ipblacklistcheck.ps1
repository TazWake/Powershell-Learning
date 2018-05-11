<#
check an IP address against blocklists
https://raw.githubusercontent.com/ktsaou/blocklist-ipsets/master/firehol_level1.netset
#>

param(
    [Parameter(Mandatory=$true)][string]$suspIP
    )

$webcheck = Invoke-WebRequest "https://raw.githubusercontent.com/ktsaou/blocklist-ipsets/master/firehol_level1.netset"
$webcheck.content | Out-File .\blacklist.txt

$checks = Get-Content .\blacklist.txt

if ($checks -contains $suspIP) {
    Write-Host "This IP is likely to be malicious"
    } else {
    Write-Host "No hits found"
    }
