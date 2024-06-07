powershell 

https://www.powershellgallery.com/packages/Hyper-ConvertImage/10.2/Content/Convert-WindowsImage.ps1




$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\Win10-Consumer_may_2023_autounattend_jtu03.iso'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\W10-Edu-Trail.VHD'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\autounattend.xml'
Edition = 'Windows 10 Education' 
Passthru = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows'
BCDinVHD = 'VirtualMachine'
}



1e opzetje // Backup // 


$ConvertParams = @{
SourcePath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\Win10-Consumer_may_2023_autounattend_jtu03.iso'
VHDPath = 'D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\W10-Edu-Trail.VHD'
WorkingDirectory = 'C:\Users\jtu03\Downloads'
SizeBytes = 60GB
VHDFormat = 'VHD' 
DiskLayout = 'UEFI'
UnattendPath = 'D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\autounattend.xml'
Edition = 'Windows 10 Education' 
Passthru = $True
BCDinVHD = 'VirtualMachine'
}

Convert-WindowsImage @ConvertParams

Foutmelding PassThru


Dismount-DiskImage
Geef naam van de VHD op 






 

 
