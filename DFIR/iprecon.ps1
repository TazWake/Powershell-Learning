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

1) Output to a file
2) Allow multiple input IPs
3) Improve quality of search tools utilised.
#>

<# input data #>

<# check data #>

<# begin searches #>
Start-Process -FilePath chrome.exe -ArgumentList "http://example.com"
