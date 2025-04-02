::
::	Create VMDK from VHD (from ISO) 
:: 	Windows Command Prompt 
::
::	Version 003 (initial version) 
::	July 4 2024
::
::	By John Tutert
::
::	For Personal and/or Educational use only ! 
::
::
:: Echo Hardware Productkey
:: wmic path softwarelicensingservice get OA3xOriginalProductKey
::
::
::
Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\VirtualHarddisk\VHD\W22-ISO-VHD-VM\Eigen-VHD-Powershell\VHDPath-Virtual-Machines"\W22-DTC-Create-VHD-V003.ps1
::
@echo Conversie van VHD naar VMDK gestart ... 
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD" out_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VMDK" out_file_type=ft_vmdk_ws_growable