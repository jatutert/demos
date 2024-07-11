#	Windows 10 Education ISO naar Virtual Harddisk VHD
#	Versie 3
#
#	02 juni 2024
#	John Tutert
#
#	PowerSHELL Script
#
#	WERKT!
#	GETEST 2 JUNI
#
#
#	Resultaat is 10 GB VHD Bestand 
# 
#
#	Declareer de parameters voor de conversie
$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\Consumer-Editions-Microsoft\22H2-19045\en-us_windows_10_consumer_editions_version_22h2_updated_may_2024_x64_dvd_49ddadb6.iso'
#
VHDPath = 'C:\Users\' + $env:USERNAME + '\Downloads\EN-US-W10-Edu-22H2.VHD'
#
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\AutoUnattend\SchneeGans\autounattend.xml'
Edition = 'Windows 10 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
#	Start conversie 
# 
Convert-WindowsImage @ConvertParams