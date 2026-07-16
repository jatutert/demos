::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Maak VMWare Workstation Pro Virtual Machine Totaal Script 
::  Windows Command Prompt 
::
::  Version 001
::  15 juli 2026
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
:hoofdmenu
::
@CLS
::
echo ===========================================================================
echo ==== Virtual Machine Manager
echo ===========================================================================
echo ====
echo ==== [1] Ethical Hacking
echo ==== [2] Scripting met Powershell
echo ==== [3] Virtualisatie
echo ==== [4] x
echo ==== [5] x
echo ==== [6] x 
echo ==== [7] Maak mappenstructuur
echo ==== [8] Opschonen
echo ====
echo ==== [9] Verlaten / Einde 
echo ====
echo ==== Maak uw keuze 
echo ====
::
choice /C:123456789 /N
set antwoord=%errorlevel%
::
if %antwoord%==9 exit /b
if %antwoord%==8 goto :scripting 
if %antwoord%==7 goto :hm-maak-mappen-structuur
if %antwoord%==6 goto :virtualisatie
if %antwoord%==5 goto :storeapps
if %antwoord%==4 goto :tools
if %antwoord%==3 goto :virtualiatie
if %antwoord%==2 goto :scriptingpowershell
if %antwoord%==1 goto :ethicalhacking
goto :hoofdmenu
::
::
::  Keuze 7
::
:hm-maak-mappen-structuur
::
@echo off
@cls
::
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::  Oracle VM Virtualbox
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Aanmaken Directories Oracle VM Virtualbox
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\ >nul 2>&1
::
::
::
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\EthicalHacking\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\ScriptPwrshell\
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\Virtualisatie\
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\EthicalHacking\SXN-EH-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\EthicalHacking\SXN-EH-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\ScriptPwrshell\SXN-SP-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\ScriptPwrshell\SXN-SP-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\Virtualisatie\SXN-VA-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\Virtualisatie\SXN-VA-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
::
::
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::  VMWare Workstation PRO
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Aanmaken Directories VMware Workstation Pro
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\ >nul 2>&1
::
::
::
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\EthicalHacking\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\Virtualisatie\
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\EthicalHacking\SXN-EH-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\EthicalHacking\SXN-EH-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\SXN-SP-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\SXN-SP-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\Virtualisatie\SXN-VA-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\Virtualisatie\SXN-VA-DC-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
::
::
::
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::  NextCloud
::      ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Aanmaken Directories NextCloud
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\ >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\ >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\ >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\EthicalHacking >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Powershell >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Virtualisatie >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\EthicalHacking\SXN-EH-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\EthicalHacking\SXN-EH-DC-01 >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Powershell\SXN-PS-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Powershell\SXN-PS-DC-01 >nul 2>&1
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Virtualisatie\SXN-VA-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\Windows\Server\Virtualisatie\SXN-VA-DC-01 >nul 2>&1
::
goto :hoofdmenu
::
:hm-opschonen




::
goto :hoofdmenu
::













::
::
:: ==== [1] Ethical Hacking ===================================================================================================================================
::
:ethicalhacking


goto hoofdmenu

::
::
::
::
:: ==== [2] Scripting met Powershell ===================================================================================================================================
::
:sm-2-scriptpwrshell
::
@echo off
@cls
::
@echo ===========================================================================
@echo ==== Virtual Machine Manager 
@echo ==== Submenu Scripting met Powershell
@echo ===========================================================================
@echo ====
@echo ==== [1] Maak Windows Server 2022 DataCenter Edition Template VHD
@echo ==== [2] Maak Active Directory Domain Services Controller (ADDS DC) van template VHD
@echo ==== [3] Maak Database (DBMS) Server van template VHD
@echo ==== [4] x
@echo ==== [5] x
@echo ==== [6] x
@echo ==== [7] x
@echo ==== [8] x
@echo ====
@echo ==== [9] Hoofdmenu
@echo ====
@echo ==== Maak uw keuze 
@echo ====
::
@choice /C:123456789 /N
@set subtoolantw=%errorlevel%
::
@if %subtoolantw%==9 goto :hoofdmenu
@if %subtoolantw%==8 goto :documenten
@if %subtoolantw%==7 goto :grafisch
@if %subtoolantw%==6 goto :hoofdmenu
@if %subtoolantw%==5 goto :remotecontrol
@if %subtoolantw%==4 goto :schoonmaken
@if %subtoolantw%==3 goto :mstooling
@if %subtoolantw%==2 goto :wintoolextra
@if %subtoolantw%==1 goto :installdrivers
goto :scriptpwrshell
::
:sm-2-scriptpwrshell-maak-template-vhd

@IF EXIST "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-TMPLT-01\SXN-TMPLT-01.VHD" (
    ::
    forfiles /p "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-TMPLT-01" /m "SXN-TPMLT-01.VHD" /d -30 >nul 2>&1
    if %errorlevel%==0 (
        @echo Verwijderen bestaande virtuele machine
        @echo Verwijderen bestaande virtuele machine
        @del /F /S /Q D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-TMPLT-01\*.* >nul 2>&1
    ) else (
        @echo VHD Bestand is nieuw genoeg om te gebruiken 
    )
)
::
@IF NOT EXIST "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-TMPLT-01\SXN-TMPLT-01.VHD" (
    @echo Powershell script starten
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-TMPLT-01"\WS22-SXN-TMPLT-01-Create-VHD-Latest.ps1
    @echo Terug van Powershell
)
::
goto :scriptpwrshell
::
:sm-2-scriptpwrshell-maak-vmx-adds
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\SXN-SP-DC-01\SXN-SP-DC-01.vmx (
    ::
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\SXN-SP-DC-01" /m "SXN-SP-DC-01.vmx" /d -30 >nul 2>&1
    if %errorlevel%==0 (
        @echo Verwijderen bestaande virtuele machine
        @vmrun -T ws stop D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx >nul 2>&1
        @vmrun -T ws DeleteVM D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx >nul 2>&1
        ::
        @echo Verwijderen bestaande virtuele machine
        @del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ScriptPwrshell\SXN-SP-DC-01\*.* >nul 2>&1
        ::
        ::  VHD naar VMDK
        ::
        @echo Conversie van VHD naar VMDK gestart ... 
        @"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-TMPLT-01\SXN-TMPLT-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-PS-DC-01\SXN-PS-DC-01.VMDK" out_file_type=ft_vmdk_ws_growable
        ::  VMX
        ::
        @echo Aanmaken VMX in VM Directory
        @copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-PS-DC-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-PS-DC-01\SXN-PS-DC-01.vmx
        ::
    ) else (
        @echo VMX Bestand is nieuw genoeg om te gebruiken 
    )
)

goto :scriptpwrshell





























goto hoofdmenu

::
::
::
::
:: ==== [3]Virtualisatie ===================================================================================================================================
::
:virtualisatie






@CLS
::
echo ===========================================================================
echo ==== Installatie Applicaties 
echo ==== Submenu Tooling
echo ===========================================================================
echo ====
echo ==== [1] Active Directory Domain Services Controller (ADDS DC)
echo ==== [2] Remote Desktop Services (RDS) Server
echo ==== [3] x
echo ==== [4] x
echo ==== [5] x
echo ==== [6] x
echo ==== [7] x
echo ==== [8] x
echo ====
echo ==== [9] Hoofdmenu
echo ====
echo ==== Maak uw keuze 
echo ====
::
choice /C:123456789 /N
set subtoolantw=%errorlevel%
::
if %subtoolantw%==9 goto :hoofdmenu
if %subtoolantw%==8 goto :documenten
if %subtoolantw%==7 goto :grafisch
if %subtoolantw%==6 goto :hoofdmenu
if %subtoolantw%==5 goto :remotecontrol
if %subtoolantw%==4 goto :schoonmaken
if %subtoolantw%==3 goto :mstooling
if %subtoolantw%==2 goto :wintoolextra
if %subtoolantw%==1 goto :installdrivers
goto :virtualisatie

















goto hoofdmenu

































































@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-VA-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-VA-DC-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-VA-WS-01 >nul 2>&1



















::
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.VMDK (

)
::
::




::
::
::
::  VHD
::


forfiles /p "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DC-01" /m "SXN-DC-01.VHD" /d -30 >nul 2>&1

if %errorlevel%==0 (
    ::
    @echo VHD Bestand is ouder dan 30 dagen
    ::
    @del /F "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DC-01\SXN-DC-01.VHD"
    ::
    @echo Powershell script starten
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines"\WS22-SXN-DC-01-Create-VHD-Latest.ps1
    @echo Terug van Powershell

) else (
    @echo VHD Bestand is nieuw genoeg om te gebruiken 
)

::
::  VHD naar VMDK
::
@echo Conversie van VHD naar VMDK gestart ... 
@"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DC-01\SXN-DC-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.VMDK" out_file_type=ft_vmdk_ws_growable
::
::  VMDK op de juiste locaties
::
::  @echo Overzetten VMDK uit VM Directory naar NextCloud
::  @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.VMDK C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DC-01
::
::  VMDK Ruimte besparen op lokale schijf van de laptop
::
::  @echo Ruimte besparen NextCloud 
::  attrib +U -P "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DC-01\SXN-DC-01.VMDK"
::
::  VMX
::
@echo Aanmaken VMX in VM Directory
@copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-DC-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx
::
::  @echo Overzetten VMX uit VM Directory naar NextCloud
::  @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DC-01
::
@echo Openen SXN-DC-01 in VMware Workstation PRO
@start /B vmware -n D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx
::
@echo Starten VM 
@start vmrun -T ws start D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.vmx
::
::
::  Thats all folks
::