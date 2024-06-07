#	Windows Server 2019 ISO naar Virtual Harddisk VHD
#	Versie 1
#
#	01 juni 2024
#	John Tutert
#
#	PowerSHELL Script
#
#	Declareer de parameters voor de conversie
#
$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-Server-2019\Standard-DataCenter-Microsoft\10-17763\en-us_windows_server_2019_updated_march_2023_x64_dvd_f9475476.iso'
VHDPath = 'C:\Users\jtu03\Downloads\EN-US-W19-DC-17763.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
# UnattendPath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\AutoUnattend\SchneeGans\autounattend.xml'
Edition = 'Windows Server 2019 Datacenter (Desktop Experience)' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
#	Start conversie 
# 
Convert-WindowsImage @ConvertParams