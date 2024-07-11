#	Windows Server 2019 Datacenter ISO naar Virtual Harddisk VHD
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
SourcePath 		= 	'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-Server-2019\Standard-DataCenter-Microsoft\10-17763\en-us_windows_server_2019_updated_march_2023_x64_dvd_f9475476.iso'
#
# VHDPath = 'C:\Users\' + $env:USERNAME + '\Downloads\EN-US-W10-Edu-22H2.VHD'
VHDPath 		= 	'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W19-DTC-S-LAB-001.VHD'
#
SizeBytes 		= 	90GB
VHDFormat 		= 	'VHD' 
DiskLayout 		= 	'UEFI'
UnattendPath 	= 	'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Guest\Windows\2019\AutoUnattend\WindowsAFG-COM\autounattend.xml'
Edition 		= 	'Windows Server 2019 Datacenter (Desktop Experience)' 
Passthru 		= 	$True
BCDinVHD 		= 	'VirtualMachine'
}
#
#	Start conversie 
# 
Write-Host "Conversie Windows Server 2019 Datacenter ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams