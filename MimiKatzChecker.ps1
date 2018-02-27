<#
MimiKatzChecker UNDER DEVELOPMENT -< CODE MAY HAVE ISSUES >-

.SYNOPSIS
This tool checks some common indicators that MimiKatz has run on a target system.

.DESCRIPTION
Based on the JPCERT tool analysis sheet, this script checks key log entries to see if there
are any signs that mimikatz sekurlsa::logonpasswords has been run.

.EXAMPLE

MimiKatzChecker.ps1

.LINKS
JPCERT TOOL ANALYSIS CHART https://jpcertcc.github.io/ToolAnalysisResultSheet/

#>


# Check for SECURTIY Log event 4688
Get-EventLog -LogName Security -InstanceId 4688 # Requires parsing

# Check for SECURITY Log event 4673
Get-EventLog -LogName Security -InstanceId 4674 # Requires parsing

# Check for SECURITY Log event 4656
Get-EventLog -LogName Security -InstanceId 4656 # Requires parsing

# Check for SECURITY Log event 4663
Get-EventLog -LogName Security -InstanceId 4663 # Requires parsing

# Check for SECURITY Log event 4703
Get-EventLog -LogName Security -InstanceId 4703 # Requires parsing

# Check for SECURITY Log event 4656
Get-EventLog -LogName Security -InstanceId 4656 # Requires parsing

# Check for SECURITY Log event 4663
Get-EventLog -LogName Security -InstanceId 4663 # Requires parsing

# Check for SECURITY Log event 4658
Get-EventLog -LogName Security -InstanceId 4658 # Requires parsing

# Check for SECURITY Log event 4689
Get-EventLog -LogName Security -InstanceId 4689 # Requires parsing
