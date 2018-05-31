# Kansa Guide
This is a brain dump of the steps needed to utilise Kansa at its best.

## Addon Requirements
* Sysinternals
* * handle.exe
* * autorunsc.exe
* LogParser

## Set Up
* Ensure PowerShell 3.0 or later is deployed domain wide
* On investigator machine install `handle.exe` and `autorunssc.exe` from Sysinternals (ideally into C:\Windows)
* Check the kansa `\bin\` folder to ensure any deployable executables are stored
* On the investigator machine install `Logparser` from Microsoft
* Ensure all target machines have WinRM enabled ( `winrm quickconfig` )
* Create a hosts file listing all the targeted machines

## Run Kansa
`kansa.ps1 -TargetList .\hosts.txt -ModulePath .\Modules -PushBin -RmBin -Verbose -Analysis`
