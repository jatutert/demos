:: Echo Hardware Productkey
:: wmic path softwarelicensingservice get OA3xOriginalProductKey
::
@echo off
@cls
@Powershell -file .\Maak-W11-Edu-VHD-uit-ISO-V001.ps1


::
@echo Converteren VHD naar VMDK
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-11\W11-Retail-EDU-24H2.VHD" out_file_name="D:\Installatie-Catalogus\VirtualDisks\Virtual-Machine-Disk-Format-VMDK\Windows\Windows 11\W11-Retail-EDU-24H2.VMDK" out_file_type=ft_vmdk_ws_growable

