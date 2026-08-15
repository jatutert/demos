::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Ultimate Linux VM Manager
::  Windows Command Prompt 
::
::  Build 1
::  30 augustus 2026
::
::  By John Tutert
::
::  For Personal and/or Educational use only ! 
::
::
@echo off
@cls
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Declaratie Variabelen
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::






::  ISO Bestand SXN-DC-01
::
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    Set "ISOVHDBestand=C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso"
)
::
::  VHD Bestand
Set "VHDBestandVMDK=D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DC-01\SXN-DC-01.VHD"
::
::  VMDK Bestand
Set "VMDKBestandVM=D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.VMDK"
Set "VMXBestandVM=D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01\SXN-DC-01.VMX"
::
::  Powershell Script
Set "PSISOVHDScriptDirectory=D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-DC-01"
Set "PSISOVHDScriptFile=WS22-SXN-DC-01-Create-VHD-Latest.ps1"
::
for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    SET TotalMemoryGB=%%i
)
::
@FOR /F "tokens=2,*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b





@echo [Stap 7] Eventuele installatie software noodzakelijk voor dit script
7z >nul 2>&1
if %errorlevel% neq 0 (
    @echo NanaZIP niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id M2Team.NanaZip --silent >%TEMP%\WinGet-NanaZip-Installatie.log
)
::
curl -V >nul 2>&1
if %errorlevel% neq 0 (
    @echo Curl niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id cURL.cURL --silent >%TEMP%\WinGet-cURL-Installatie.log
)
::
pwsh --version >nul 2>&1
if %errorlevel% neq 0 (
    @echo Powershell 7 niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id Microsoft.PowerShell --silent >%TEMP%\WinGet-pwsh-Installatie.log
)
::
set "app_dir_check=C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1"
if not exist "%app_dir_check%*" (
    @echo Windows Terminal niet aangetroffen
    @winget install --id Microsoft.WindowsTerminal --silent >%TEMP%\WinGet-WinTerm-Installatie.log
)
::





::
:hoofdmenu
::
@CLS
::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: Ultimate Linux Virtual Machine Manager                           :::::
echo ::::: Hoofdmenu                                                        :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
::
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
echo VMware gevonden in %VMWareInstallPath%
echo.
::
echo [1] Aanmaken Debian VM
echo [2] Aanmaken Ubuntu VM
echo [3] x
echo [4] x
echo [5] x
echo [6] x
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
:: echo Maak uw keuze 
::
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
::
if %antwoord%==9 goto :einde
if %antwoord%==8 goto :Opschonen
if %antwoord%==7 goto :hoofdmenu
if %antwoord%==6 goto :NextCloud
if %antwoord%==5 goto :VMWRemoveVM
if %antwoord%==4 goto :VMWStartVM
if %antwoord%==3 goto :VMWManager
if %antwoord%==2 goto :VHDManager
if %antwoord%==1 goto :ISODownload
goto :hoofdmenu
::
::
::


::
:debiansubmenu
::
@CLS
::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: Ultimate Linux Virtual Machine Manager                           :::::
echo ::::: Debian                                                           :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
::
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
echo VMware gevonden in %VMWareInstallPath%
echo.
::
echo [1] Aanmaken Debian 12 Desktop VM
echo [2] Aanmaken Debian 12 Server VM
echo [3] Aanmaken Debian 13 Desktop VM
echo [4] Aanmaken Debian 13 Server VM
echo [5] x
echo [6] x
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
:: echo Maak uw keuze 
::
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
::
if %antwoord%==9 goto :einde
if %antwoord%==8 goto :Opschonen
if %antwoord%==7 goto :hoofdmenu
if %antwoord%==6 goto :NextCloud
if %antwoord%==5 goto :VMWRemoveVM
if %antwoord%==4 goto :VMWStartVM
if %antwoord%==3 goto :VMWManager
if %antwoord%==2 goto :VHDManager
if %antwoord%==1 goto :ISODownload
goto :hoofdmenu
::
::
::



::
:ubuntusubmenu
::
@CLS
::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: Ultimate Linux Virtual Machine Manager                           :::::
echo ::::: Ubuntu                                                           :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
::
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
echo VMware gevonden in %VMWareInstallPath%
echo.
::
echo [1] Aanmaken Ubuntu 24.04 Desktop VM
echo [2] Aanmaken Ubuntu 24.04 Server VM
echo [3] Aanmaken Ubuntu 26.04 Desktop VM
echo [4] Aanmaken Ubuntu 26.04 Server VM
echo [5] x
echo [6] x
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
:: echo Maak uw keuze 
::
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
::
if %antwoord%==9 goto :einde
if %antwoord%==8 goto :Opschonen
if %antwoord%==7 goto :hoofdmenu
if %antwoord%==6 goto :NextCloud
if %antwoord%==5 goto :VMWRemoveVM
if %antwoord%==4 goto :VMWStartVM
if %antwoord%==3 goto :VMWManager
if %antwoord%==2 goto :VHDManager
if %antwoord%==1 goto :ISODownload
goto :hoofdmenu
::
::
::





:debian13desktop

::  Naam van de bestanden in het ZIP bestand vanuit download linuxvmimages website
@SET "LVI_Inside_ZIP_Filename=Debian_13_VMM_LinuxVMImages.COM"
::  Eigen naam gegeven aan ZIP bestand afkomstig van LinuxVMImages website
@SET "LVI_Download_ZIP_Filename=LVI-D13-00-TRX-M-VMDK"
