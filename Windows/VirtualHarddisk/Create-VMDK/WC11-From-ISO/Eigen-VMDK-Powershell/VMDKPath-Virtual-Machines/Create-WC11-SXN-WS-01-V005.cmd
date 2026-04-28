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
::  17 APRIL 2026
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
@IF EXIST "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD" (
    @del /F "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD" >nul 2>&1
)
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.VMDK (
    @del /F D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.VMDK >nul 2>&1
)
::
@echo Aanmaken Directories Oracle VM Virtualbox
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DB-01
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DC-01
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001
::
@echo Aanmaken Directories VMware Workstation Pro
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001
::
::  VHD
::
@echo Overschakelen naar Powershell
@Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines"\WC11-SXN-WS-01-Create-VHD-Latest.ps1
@echo Terug van Powershell
::
::  VHD naar VMDK
::
@echo Conversie van VHD naar VMDK mbv StarWind V2V Converter gestart ... 
@"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.VMDK" out_file_type=ft_vmdk_ws_growable >nul 2>&1
::
::  VMDK op de juiste locaties
::
@echo Overzetten VMDK uit VM Directory naar NextCloud
@copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.VMDK C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-WS-01
::
::  VMDK Ruimte besparen op lokale schijf van de laptop
::
@echo Attributen aanpassen NextCloud bestand om ruimte te besparen
@sattrib +U -P "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-WS-01\SXN-WS-01.VMDK"
::
::  VHD Verwijderen
::
@echo VHD verwijderen
@del D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD
::
::  VMX
::
@echo Aanmaken VMX in VM Directory
@copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-WS-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.vmx
::
::
@echo Overzetten VMX uit VM Directory naar NextCloud
@copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.vmx C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-WS-01
::
::
@echo Openen VM in VMware Workstation PRO
@start /B vmware -n D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.vmx
::
::
@echo Starten VM in VMware Workstation PRO
@start vmrun -T ws start D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01\SXN-WS-01.vmx
::
::  Thats all folks
::