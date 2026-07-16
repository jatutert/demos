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
@echo Virtual machine creator script by TutSOFT
@echo Creating SXN-RD-01 virtual machine 
::
::  Verwijderen Template 
::
::  IF EXIST "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" (
::    @del /F "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01\SXN-RD-01.VHD"
::  )
::
::  Verwijderen Virtuele machine 
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMX (
    @echo Verwijderen bestaande virtuele machine
    @vmrun -T ws stop D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx >nul 2>&1
    @vmrun -T ws DeleteVM D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx >nul 2>&1
)
::
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK (
    @echo Verwijderen bestaande virtuele machine
    @del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
)
::
::
@echo Aanmaken Directories Oracle VM Virtualbox
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\ >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
@echo Aanmaken Directories VMware Workstation Pro
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
@echo Aanmaken Directory NextCloud
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\ >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DC-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-RD-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-WS-01 >nul 2>&1
::
::  VHD
::
@IF NOT EXIST "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" (
    @echo Powershell script starten
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines"\WS22-SXN-RD-01-Create-VHD-Latest.ps1
    @echo Terug van Powershell
)

forfiles /p "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01" /m "SXN-RD-01.VHD" /d -30 >nul 2>&1

if %errorlevel%==0 (
    ::
    @echo VHD Bestand is ouder dan 30 dagen
    ::
    @del /F "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01\SXN-RD-01.VHD"
    ::
    @echo Powershell script starten
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines"\WS22-SXN-RD-01-Create-VHD-Latest.ps1
    @echo Terug van Powershell

) else (
    @echo VHD Bestand is nieuw genoeg om te gebruiken 
)

::
::  VHD naar VMDK
::
@echo Conversie van VHD naar VMDK gestart ... 
@"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK" out_file_type=ft_vmdk_ws_growable
::
::  VMDK op de juiste locaties
::
::  @echo Overzetten VMDK uit VM Directory naar NextCloud
::  @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-RD-01
::
::  VMDK Ruimte besparen op lokale schijf van de laptop
::
::  @echo Ruimte besparen NextCloud 
::  attrib +U -P "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-RD-01\SXN-RD-01.VMDK"
::
::  VMX
::
@echo Aanmaken VMX in VM Directory
@copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-RD-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
::
::  @echo Overzetten VMX uit VM Directory naar NextCloud
::  @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-RD-01
::
@echo Openen SXN-RD-01 in VMware Workstation PRO
@start /B vmware -n D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
::
@echo Starten VM 
@start vmrun -T ws start D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
::
::
::  Thats all folks
::