<#
Converting Hostnames to IP addresses
#>

Param(
    [Parameter (Mandatory=$true)][string]$HostNameList
    )

$list = Get-Content $HostNameList

ForEach ($i in $list){
    $hostname = $i
    $ip = [System.Net.Dns]::GetHostAddresses("$hostname") | select -ExpandProperty IPAddressToString
    Add-Content hostips.csv "$hostname,$ip"
    Add-Content hostips.txt "$hostname - $ip"
    Write-Host "$hostname is $ip"
 }
