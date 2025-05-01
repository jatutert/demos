# Windows 11 Business Editions
# Windows Education
#
# Windows 11 Education ISO naar Virtual Harddisk VHD
#
# Versie 1.2
#
# 04 april 2025
# John Tutert
#
# PowerSHELL Script
#
#
#  Windows Insider 
#  Canary Channel
#
#
#  In D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\11\AutoUnattend\GitHub-Ruzickap
#  staan diverse autounattend.xml bestanden. 
#
#
# Declareer de parameters voor de conversie
#
$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Microsoft\Windows\10-10-11\10.22-Windows-11\Consumer-Editions-Microsoft-Insider\Canary-Channel-27xxxx\2025-April-23\Windows11_InsiderPreview_Client_x64_en-us_27842.iso'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-11\W11-Education-Insider.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\Insider-Client\AutoUnattend\GitHub-Ruzickap\Autounattend_V005.xml'
Edition = 'Windows 11 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
# Start conversie ISO bestand naar VHD
#
Clear-Host
Convert-WindowsImage @ConvertParams