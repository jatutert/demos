#	Windows 11 Education ISO naar Virtual Harddisk VHD
#	PowerSHELL SCRIPT
#
#
#	29 juni 2024
#
#
#	Gebaseerd op versie 4 dd 7 juni 2024
#	In versie 4 is migratie van Convert-WindowsImage naar Hyper-ConvertImage gedaan 
#	Van Convert-WindowsImage Versie 10.0 naar Hyper-ConvertImage versie 10.2 
#
#
#	Dit script maakt gebruik van Schneegans autounattend.xml versie 1 (basis versie) 
#
#
#	Auteur: John Tutert
#
#
#	For Personal and/or Education Use Only ! 
#
# 
#
Clear-Host
#
#
Write-Host "Declaratie van parameters voor conversie"
$ConvertParams = @{
SourcePath 		= 	'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.22-Windows-11\Consumer-Editions-Microsoft\23H2-22621\en-us_windows_11_consumer_editions_version_23h2_updated_june_2024_x64_dvd_78b33b16.iso'
#
# VHDPath = 'C:\Users\' + $env:USERNAME + '\Downloads\EN-US-W10-Edu-22H2.VHD'
VHDPath 		= 	'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\EN-US-W11-Edu-23H2.VHD'
#
SizeBytes 		= 	60GB
VHDFormat 		= 	'VHD' 
DiskLayout 		= 	'UEFI'
UnattendPath 	= 	'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\11\AutoUnattend\SchneeGans\V001\autounattend.xml'
Edition 		= 	'Windows 11 Education' 
Passthru 		= 	$True
BCDinVHD 		= 	'VirtualMachine'
}
#
#	Resultaat is 19 GB VHD Bestand 
#
Write-Host "Conversie Windows 11 ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams