::
::	Create VMDK from VHD (from ISO) 
:: 	Windows Command Prompt 
::
::  Version 005
::  3 APRIL 2026
::
::  By John Tutert
::
::  For Personal and/or Educational use only ! 
::
::
:: Echo Hardware Productkey
:: wmic path softwarelicensingservice get OA3xOriginalProductKey
::
::
::
del /F D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD
del /F D:\Virtual-Machines\VMware-Workstation-PRO\Windows\W22-DTC-S-LAB-001.VMDK
::
Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines"\W22-DTC-Create-VHD-V005.ps1
::
@echo Conversie van VHD naar VMDK gestart ... 
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\W22-DTC-S-LAB-001.VMDK" out_file_type=ft_vmdk_ws_growable
::
copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\Windows Server 2022.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\
::