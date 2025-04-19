#	Windows Server 2022 DataCenter ISO naar Virtual Harddisk VHD
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
SourcePath 		= 	'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_may_2024_x64_dvd_59e44c3a.iso'
#
# VHDPath = 'C:\Users\' + $env:USERNAME + '\Downloads\EN-US-W10-Edu-22H2.VHD'
VHDPath 		= 	'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD'
#
SizeBytes 		= 	90GB
VHDFormat 		= 	'VHD' 
DiskLayout 		= 	'UEFI'
UnattendPath 	= 	'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\2022\AutoUnattend\WindowsAFG-COM\autounattend.xml'
Edition 		= 	'Windows Server 2022 Datacenter (Desktop Experience)' 
Passthru 		= 	$True
BCDinVHD 		= 	'VirtualMachine'
}
#
#	Resultaat is 9 GB VHD Bestand 
#
Write-Host "Conversie Windows Server 2022 DataCenter ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams