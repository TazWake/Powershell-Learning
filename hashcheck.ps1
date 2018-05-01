<# 
Generates multiple hashes of an input file
#>

param(
    [Parameter(Mandatory=$true)][string]$TargetFile
    )
$md5 = Get-FileHash $TargetFile -Algorithm MD5 | select -ExpandProperty hash
$sha1 = Get-FileHash $TargetFile -Algorithm SHA1 | select -ExpandProperty hash
$sha2 = Get-FileHash $TargetFile -Algorithm SHA256 | select -ExpandProperty hash
$ripemd = Get-FileHash $TargetFile -Algorithm RIPEMD160 | select -ExpandProperty hash

Add-Content filehashes.txt "--------------------------------------------------------------------------"
Add-Content filehashes.txt "File Hashes Generated for $TargetFile"
Add-Content filehashes.txt $md5
Add-Content filehashes.txt $sha1
Add-Content filehashes.txt $sha2
Add-Content filehashes.txt $ripemd
Add-Content filehashes.txt "--------------------------------------------------------------------------"

Clear-Host

Write-Host "MD5 Hash: $md5"
Write-Host "SHA1 Hash: $sha1"
Write-Host "SHA2 Hash: $sha2"
Write-Host "RIPEMD160 Hash: $ripemd"
Write-Host "Hashes stored in filehashes.txt"
