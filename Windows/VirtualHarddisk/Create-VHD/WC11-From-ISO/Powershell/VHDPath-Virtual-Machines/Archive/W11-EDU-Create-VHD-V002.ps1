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
#	DECLARATIE VARIABELEN
#
$TS_WIN_ISO_FOLDER		= 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.22-Windows-11\Consumer-Editions-Microsoft\23H2-22621\'
$TS_WIN_ISO_FILE		= 'en-us_windows_11_consumer_editions_version_23h2_updated_june_2024_x64_dvd_78b33b16.iso'
$TS_WIN_UNATTEND_FOLDER	= 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\2022\AutoUnattend\GitHub-Ruzickap\'
$TS_WIN_UNATTEND_FILE	= 'autounattend.xml'
# 
#
Clear-Host
#
#
Write-Host "Declaratie van parameters voor conversie"
$ConvertParams = @{
SourcePath 		= 	$TS_WIN_ISO_FOLDER + $TS_WIN_ISO_FILE
#
# VHDPath = 'C:\Users\' + $env:USERNAME + '\Downloads\EN-US-W10-Edu-22H2.VHD'
VHDPath 		= 	'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001.VHD'
#
SizeBytes 		= 	60GB
VHDFormat 		= 	'VHD' 
DiskLayout 		= 	'UEFI'
UnattendPath 	= 	$TS_WIN_UNATTEND_FOLDER + $TS_WIN_UNATTEND_FILE
Edition 		= 	'Windows 11 Education' 
Passthru 		= 	$True
BCDinVHD 		= 	'VirtualMachine'
}
#
#	Resultaat is 19 GB VHD Bestand 
#
Write-Host "Conversie Windows 11 ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams