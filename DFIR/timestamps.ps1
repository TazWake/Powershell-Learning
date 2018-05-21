Write-Host "Starting collection"
Get-ItemProperty -Path * | Format-list -Property Name, Length, CreationTimeUtc, LastAccessTimeUtc, LastWriteTimeUtc
Write-Host "Collection completed"
