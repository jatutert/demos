::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Create VMDK from VHD (from ISO) 
::  Windows Command Prompt 
::
::  Version 005
::  3 APRIL 2026
::
::  By John Tutert
::
::  For Personal and/or Educational use only ! 
::
::
::  Echo Hardware Productkey
::  wmic path softwarelicensingservice get OA3xOriginalProductKey
::
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Administrator PRIVILEGES Detected! 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::
@del /F D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001.VHD
@del /F D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001.VMDK
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001
::
Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines"\W11-EDU-Create-VHD-Latest.ps1
::
@echo Conversie van VHD naar VMDK gestart ... 
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001\W11-EDU-C-LAB-001.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001\W11-EDU-C-LAB-001.VMDK" out_file_type=ft_vmdk_ws_growable
::
copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\Windows Server 2022.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\
::