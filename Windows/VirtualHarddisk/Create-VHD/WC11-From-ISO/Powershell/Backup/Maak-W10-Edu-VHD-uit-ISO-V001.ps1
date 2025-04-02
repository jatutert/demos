#	Windows 10 Education ISO naar Virtual Harddisk VHD
#	Versie 1
#
#	31 mei 2024
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
SourcePath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\Win10-Consumer_may_2023_autounattend_jtu03.iso'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\W10-Edu-Trail.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\autounattend.xml'
Edition = 'Windows 10 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}
#
#	Start conversie 
# 
Convert-WindowsImage @ConvertParams