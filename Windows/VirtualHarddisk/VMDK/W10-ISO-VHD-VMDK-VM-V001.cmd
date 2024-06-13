::
::	Windows 10 Education Virtual Machine Creator
::
::	Werkt alleen op laptop CND0475SYS 
::
::	[0]	Omgeving
::	[1] ISO Download
::	[2] Convert ISO to VHD
::	[3] Create Virtual Machine
::
::	Script
::	Version 002
::	07 juni 2024
::
::	John Tutert
::
::	[0] OMGEVING
::
::	Installeren Convert-WimImage in Powershell
:: 	powershell Install-Module -Name Hyper-ConvertImage -Repository PSGallery
::
::	[1] ISO Download
::
::	Downloaden Windows 10 ISO Bestand 
::
::	Download site https://massgrave.dev/windows_10_links
::
::	powershell Invoke-WebRequest -URI https://drive.massgrave.dev/en-us_windows_10_consumer_editions_version_22h2_updated_may_2024_x64_dvd_49ddadb6.iso -OutFile %userprofile%\Downloads\en-us_windows_10_consumer_editions_version_22h2_updated_may_2024_x64_dvd_49ddadb6.iso
::
::
::	[2] Convert ISO to VHD
::
::
::	Download Powershell script voor conversie van eigen GitHub
::	powershell Invoke-WebRequest -URI    -OutFile %userprofile%\Downloads\
::
::	Resultaat EN-US-W10-Edu-22H2.VHD
::
@echo Maken VHD-bestand gestart mbv Powershell Hyper-ConvertImage versie 10.2 
@echo Versie 4 Powershell
@echo Versie 1 Autounattend
@powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\Hypervisor\Virtualbox\Edition-2\W10-ISO-VHD-VM\Eigen-VHD-Powershell"\Maak-W10-Edu-VHD-uit-ISO-V004.ps1
::
::
@echo Converteren VHD naar VMDK
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%USERPROFILE%\Downloads\EN-US-W10-Edu-22H2.vhd" out_file_name="%USERPROFILE%\Downloads\EN-US-W10-Edu-22H2.vmdk" out_file_type=ft_vmdk_ws_growable






::
::	That's all folks ! 
@echo Einde script ... 
::