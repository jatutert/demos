#	Windows 11 Business Editions
#	Windows Education
#
#	Windows 11 Education ISO naar Virtual Harddisk VHD
#	
#	Versie x
#
#	01 april 2025
#	John Tutert
#
#	PowerSHELL Script
#
#
#	Declareer de parameters voor de conversie
#
#	Passthru geeft nog foutmelding
#	Oplossen door Dismount-DiskImage te geven van de nieuwe gemaakte VHD bestand
#
$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Microsoft\Windows\10-10-11\10.22-Windows-11\Business-Editions-Microsoft\24H2\RETAIL-OEM\nl-nl_windows_11_business_editions_version_24h2_x64_dvd_0719b251.ISO'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-11\W11-Retail-EDU-24H2.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Microsoft\Windows\10-10-11\10.22-Windows-11\Business-Editions-AutoUnattend-JT\22H2-19045\autounattend.xml'
Edition = 'Windows 11 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
#	Start conversie 
# 
Convert-WindowsImage @ConvertParams