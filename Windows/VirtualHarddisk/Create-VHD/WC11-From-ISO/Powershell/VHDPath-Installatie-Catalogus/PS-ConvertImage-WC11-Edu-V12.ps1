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
# LET OP!
# Script wordt gebruikt door ISO naar VHD maar ook door ISO naar VDMK via VHD
#
#
#
#
#  In D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\11\AutoUnattend\GitHub-Ruzickap
#  staan diverse autounattend.xml bestanden. 
#
#
# Declareer de parameters voor de conversie
#
$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Microsoft\Windows\10-10-11\10.22-Windows-11\Business-Editions-Microsoft\24H2\RETAIL-OEM\nl-nl_windows_11_business_editions_version_24h2_x64_dvd_0719b251.ISO'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-11\W11-Retail-EDU-24H2.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\11\AutoUnattend\GitHub-Ruzickap\Autounattend_V005.xml'
Edition = 'Windows 11 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
# Start conversie ISO bestand naar VHD
#
Clear-Host
Convert-WindowsImage @ConvertParams