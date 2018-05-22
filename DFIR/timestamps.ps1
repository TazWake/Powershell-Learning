<#
.SYNOPSIS

Script to display the Creation, Access and Write times of files in a given folder.

.DESCRIPTION

This script reports key details about files in a given folder. It identifies the filename, filesize (in bytes), creation/access/write times.
If no path is provided with the execution it looks at files in the current path.

.EXAMPLE



.EXAMPLE

.LINK

https://github.com/TazWake/Powershell-Learning/blob/master/DFIR/timestamps.ps1

.NOTES
To Do List
1) Output to file
#>

param(
    [Parameter(Mandatory=$false)][string]$targetPath
    )

$path = "*"

if ($targetPath) {
    $path = $targetPath
    }

Write-Host "Starting collection"
Get-ItemProperty -Path $path | Format-list -Property Name, Length, CreationTimeUtc, LastAccessTimeUtc, LastWriteTimeUtc
Write-Host "Collection completed"
