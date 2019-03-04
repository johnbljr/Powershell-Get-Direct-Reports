<#
------------------------------------------------------------
Author: John Leger
Date: Feb. 20, 2019
Powershell Version Built/Tested on: 5.1
Title: Get Direct Reports
Website: https://github.com/johnbljr
License: GNU General Public License v3.0
------------------------------------------------------------
#>  

$TargetUser = Read-Host "What manager do you want to check direct reports for?"
$ExportCSV  = "C:\temp\directreport.csv"

$Properties = @(
    'SamAccountName'
    'DirectReports'
    )

    $rep = Get-AdUser -identity $TargetUser -Properties $Properties
if(!$rep.DirectReports) {
    Write-Host "This manager is not set up with any direct reports."
}
   else {
   Write-Host "See the export location for the list of direct reports."
    $rep | Select-Object -ExpandProperty DirectReports | Get-ADuser -Properties * | Select-Object SamAccountName | Export-Csv -Path $ExportCSV -append -NoTypeInformation -Force 
} 
    