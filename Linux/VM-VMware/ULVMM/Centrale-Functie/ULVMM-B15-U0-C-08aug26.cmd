@echo off
::
@echo Dit script verwijderd alle directories van de D schijf
@echo Daarom gelijk stop script
@pause
@exit /b 0
::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  ::::::::::::::::::::::::::::::: WORK IN PROGRESS :::::::::::::::::::::: CANARY VERSION :::::::::::::::::::::::::::::
::
::  LET OP
::
::  Dit script verwijderd alle directories van de D schijf bij uitvoeren van de centrale functie
::
::  LET OP
::
::
::  Changelog
::  Build 6 Debian 13 Desktop
::  Build 7 Debian 13 Server en OpenMediaVault
::  Build 8 Ubuntu 24.04 Desktop
::  Build 9 Linux commando rmrun bugfixes en schermheader als functie
::  Build 10 Debian 12 Desktop en Debian 13 Desktop aangepast
::
::  Build 12 Debian 13 Server nieuwe volgorde Linux commando's
::
::  Build 15 Centrale functie voor aanmaken virtuele machine
::
::
::  ::::::::::::::::::::::::::::::: WORK IN PROGRESS :::::::::::::::::::::: CANARY VERSION :::::::::::::::::::::::::::::
::
::
::  Ultimate Linux VM Manager (ULVMM)
::
::
@Set "ULVMMBuild=15"
@Set "ULVMMUpdate=0"
@Set "ULVMMChannel=Canary"
::
::
::  Copyright (c) 2026 John Tutert
::  Permission is hereby granted, free of charge, to any person obtaining a copy
::  of this software, to use, copy, modify, and distribute it for personal,
::  educational, or open-source purposes, provided this notice remains intact.
::  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Rechten Check
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
    @ECHO Script NIET gestart met Adminstrator permissies / Script not started with Adminitrator premissions ! 
    @PAUSE
    @EXIT 1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Gebruikersinstellingen script
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@cls
::
@call :f_Toon_ULVMM_Header
@echo.
::
@echo Script gebruikersinstellingen uitlezen ...
::
::  Virtuele machines
::
::  Standaard lokatie van de VMWare Workstation Pro virtuele machines op de eigen PC en/of Laptop
@set "VWSP_VM_Default_Location=D:\Virtual-Machines\VMware-Workstation-PRO"
::  Naam van de directory met Linux virtuele machines // default is Linux
@set "VWSP_VM_Linux_DirName=Linux"
::  Naam van de directory met Debian Linux virtuele machines // default is Debian
@set "VWSP_VM_Linux_Debian_DirName=Debian"
::  Naam van de directory met Ubuntu Linux virtuele machines // default is Ubuntu
@set "VWSP_VM_Linux_Ubuntu_DirName=Ubuntu"
::  Naam van de directory met Debian Desktop virtuele machines // default is desktop
@set "VWSP_VM_Linux_Debian_Desktop_DirName=Desktop"
::  Naam van de directory met Desktop Server virtuele machines // default is server 
@set "VWSP_VM_Linux_Debian_Server_DirName=Server"
::  Naam van de directory met Ubuntu Desktop virtuele machines // default is desktop
@set "VWSP_VM_Linux_Ubuntu_Desktop_DirName=Desktop"
::  Naam van de directory met Ubuntu Server virtuele machines // default is server
@set "VWSP_VM_Linux_Ubuntu_Server_DirName=Server"
::  Naam van de directory met Windows virtuele machines // default is Windows
@set "VWSP_VM_Windows_DirName=Windows"
::
::  Namen Debian 12 Virtuele machines
@set "Linux_Debian_12_Desktop_Hostname=D12-BKW-D-LAB-001"
@set "Linux_Debian_12_Server_Hostname=D12-BKW-S-LAB-001"
::  Namen Debian 13 Virtuele machines
@set "Linux_Debian_13_Desktop_Hostname=D13-TRX-D-LAB-001"
@set "Linux_Debian_13_Server_Hostname=D13-TRX-S-LAB-001"
::  Namen Ubuntu 24.04 virtuele machines
@set "Linux_Ubuntu_24_Desktop_Hostname=U24-LTS-D-LAB-001"
@set "Linux_Ubuntu_24_Server_Hostname=U24-LTS-S-LAB-001"
@set "Linux_Ubuntu_24_Docker_Hostname=U24-LTS-S-DKR-001"
::  Namen Ubuntu 26.04 virtuele machines
@set "Linux_Ubuntu_26_Desktop_Hostname=U26-LTS-D-LAB-001"
@set "Linux_Ubuntu_26_Server_Hostname=U26-LTS-S-LAB-001"
@set "Linux_Ubuntu_26_Docker_Hostname=U26-LTS-S-DKR-001"
::
::  Templates
::
::  Standaard lokatie van templates (sjablonen) voor virtuele machines op de eigen PC en/of Laptop
@set "Templates_Default_Location=D:\Virtual-Machines\Templates"
::  Naam van de directory met Linux tempates // default is Linux
@set "Templates_Linux_DirName=Linux"
::  Naam de directory met Debian templates // default is debian
@set "Templates_Linux_Debian_DirName=Debian"
::  Naam van de directory met Ubuntu templates // default is ubuntu
@set "Templates_Linux_Ubuntu_DirName=Ubuntu"
::  Naam van de directory met Desktop templates // default is Regular
@set "Templates_Linux_Desktop_DirName=Regular"
::  Naam van de directory met Server templates // default is Minimal
@set "Templates_Linux_Server_DirName=Minimal"
::
::  ISO Bestanden
::
@set "ISO_Default_Location=D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen"
@set "ISO_Linux_Debian12_Desktop=naambestand.iso"
@set "ISO_Linux_Debian12_Server=naambestand.iso"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Declaratie Variabelen Internet
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Linux Virtual Images Debian 12 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIDebian12D=Debian_12.0.0_VMG_LinuxVMImages.COM"
@set "LVIDebian12S=Debian_12.0.0_VMM_LinuxVMImages.COM"
::  Linux Virtual Images Debian 13 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIDebian13D=Debian_13_VMG_LinuxVMImages.COM"
@set "LVIDebian13S=Debian_13_VMM_LinuxVMImages.COM"
::  Linux Virtual Images Ubuntu 24.04 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIUbuntu24D=Ubuntu_24.04_VM_LinuxVMImages.COM"
@set "LVIUbuntu24S=UbuntuServer_24.04_VM_LinuxVMImages.COM"
::  Linux Virtual Images Ubuntu 26.04 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIUbuntu26D=Ubuntu_26.04_VM_LinuxVMImages.COM"
::  @set "LVIUbuntu26S=" Niet beschikbaar
::
::  Linux Virtual Images Debian 12 download URL
@set "Debian12DesktopUrl=https://edu.nl/kma6w"
@set "Debian12ServerUrl=https://edu.nl/pegff"
::  Linux Virtual Images Debian 13 download URL
@set "Debian13DesktopUrl=https://edu.nl/nd6dx"
@set "Debian13ServerUrl=https://edu.nl/wmdrh"
::  Linux Virtual Images Ubuntu 24 download URL
@set "Ubuntu24DesktopUrl=https://edu.nl/38aq4"
@set "Ubuntu24ServerUrl= https://edu.nl/xu78m"
::  Linux Virtual Images Ubuntu 26 download URL
@set "Ubuntu26DesktopUrl=https://edu.nl/y6nbm"
::  @set "Ubuntu26ServerUrl= ...."  Niet beschikbaar
::
::  Debian 12 ISO download URL
@set "Debian12DesktopISOUrl=https://edu.nl/r7qkg"
@set "Debian12ServerISOURL=https://edu.nl/r7qkg"
::  Debian 13 ISO download URL
@set "Debian13DesktopISOUrl=x"
@set "Debian13ServerISOURL=x"
::  Ubuntu 24.04 ISO download URL
@set "Ubuntu24DesktopISOURL=https://edu.nl/avfqr"
@set "Ubuntu24ServerISOURL=x"
::  Ubuntu 26.04 ISO download URL
@set "Ubuntu24DesktopISOURL=x"
@set "Ubuntu24ServerISOURL=x"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Declaratie Variabelen Script Automatisch
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  Samengestelde variabelen aanmaken
::
::  Virtuele Machines
::
@set "Debian12DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_12_Desktop_Hostname%"
@set "Debian12ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_12_Server_Hostname%"
::
@set "Debian13DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_13_Desktop_Hostname%"
@set "Debian13ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_13_Server_Hostname%"
::
@set "Ubuntu24DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_24_Desktop_Hostname%"
@set "Ubuntu24ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Server_Hostname%"
::
@set "Ubuntu26DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_26_Desktop_Hostname%"
@set "Ubuntu26ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Server_Hostname%"
::
::  Templates
::
@set "Debian12Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12\%Templates_Linux_Desktop_DirName%
@set "Debian12Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12\%Templates_Linux_Server_DirName%
::
@set "Debian13Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13\%Templates_Linux_Desktop_DirName%
@set "Debian13Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13\%Templates_Linux_Server_DirName%
::
@set "Ubuntu24Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404\%Templates_Linux_Desktop_DirName%
@set "Ubuntu24Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404\%Templates_Linux_Server_DirName%
::
@set "Ubuntu26Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Desktop_DirName%
@set "Ubuntu26Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Server_DirName%
::
@echo Declaratie variabelen op basis van omgeving
::
::  Bepaal het totaal aanwezige RAM
@for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    @set Host_RAM_Total_GB=%%i
)
::
@set /a Host_RAM_Quarter_MB=%Host_RAM_Total_GB% * 1024 / 4
::
::  Controleer aanwezigheid van VMWare Workstation Pro
::
@reg query "HKLM\SOFTWARE\VMware, Inc.\VMware Workstation" >nul 2>&1
::
if %errorlevel% neq 0 (
    @REM
    @REM VMWare Workstation is NIET aanwezig
    @REM
    @REM Zorg ervoor dat Curl aanwezig is
    call :f_Installeer_Tools
    @REM
    @REM doe een download van VMWare Workstation Pro
    @curl -s -L -o %userprofile%\Downloads\VMware-Workstation-Full-26H1.exe https://dl.go-trex.com/VMware/VMware-Workstation-Full-26H1.exe
    @REM
    @REM Naslag unattend Installatie
    @REM https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/installing-and-using-workstation-pro/installing-workstation-pro/run-an-unattended-workstation-pro-installation-on-a-windows-host.html
    @REM
    @REM Naslag unattend Installatie Parameters
    @REM https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/installing-and-using-workstation-pro/installing-workstation-pro/run-an-unattended-workstation-pro-installation-on-a-windows-host/installation-properties-workstation.html
    @REM
    @REM AUTOSOFTWAREUPDATE Enables automatic upgrades for Workstation Pro when a new build becomes available.
    @REM INSTALLDIR Install Workstation Pro in a directory that is different from the default Workstation Pro location.
    @REM VMware-workstation-full-x.x.x-xxxxxx.exe /s /v"/qn EULAS_AGREED=1 AUTOSOFTWAREUPDATE=1"
    @REM VMware-workstation-full-x.x.x-xxxxxx.exe /s /v"/qn EULAS_AGREED=1 INSTALLDIR=C:\tests\test_install AUTOSOFTWAREUPDATE=1"
    @REM
    @REM Naslag Verwijderen 
    @REM https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/installing-and-using-workstation-pro/installing-workstation-pro/run-an-unattended-workstation-pro-installation-on-a-windows-host.html
    @REM VMware-workstation-full-x.x.x-xxxxxx.exe /s /v"/qn REMOVE=ALL"
    @REM
    @REM Start Installatie VWware Workstation
    %userprofile%\Downloads\VMware-Workstation-Full-26H1.exe /s /v"/qn EULAS_AGREED=1 AUTOSOFTWAREUPDATE=1"
)
::
::  Bepaald locatie VMware Workstation Pro
::
@for /F "tokens=2,*" %%a in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
::
::
::  ::::::::::::::::::::::::::::::::::::::::::
::  defaultVMPath ophalen VMware Workstation
::  ::::::::::::::::::::::::::::::::::::::::::
::
::
::  Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
::
::  prefvmx.defaultVMPath = "D:\Virtual-Machines\VMware-Workstation-PRO"
::
::
@SET "prefFile=%AppData%\VMware\preferences.ini"
@FOR /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    SET "VWSP_VM_Default_Location_Setting_Met_Haakjes=%%B"
)
::
::
::  prefvmx.defaultVMPath = "D:\Virtual-Machines\VMware-Workstation-PRO"
::
:: Verwijder aanhalingstekens uit prefvmx.defaultVMPath
::
::
@SET "VWSP_VM_Default_Location_Setting_Zonder_Haakjes=%VWSP_VM_Default_Location_Setting_Met_Haakjes:"=%"
::
::
@echo %VWSP_VM_Default_Location_Setting_Zonder_Haakjes% | findstr /I "%VWSP_VM_Default_Location%" >nul 2>&1
@if %errorlevel% equ 0 (
    @REM
    @echo De geconfigureerde directory voor Virtuele machines in VMware Workstation Pro is gelijk aan voorkeur in dit script
) else (
    @REM
    @echo De geconfigureerde directory voor Virtuele machines in VMware Workstation Pro is NIET gelijk aan voorkeur in dit script
    @pause
)
::
::
::
::  ::::::::::::::::::::::::::::::::
::  SSH Hosts bestand backup maken
::  ::::::::::::::::::::::::::::::::
::
::
@if exist %userprofile%\.ssh\known_hosts (
    @for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set current_date_time=%%i
    @ren %userprofile%\.ssh\known_hosts known_hosts_%current_date_time%.bck
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Hoofdmenu
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:hoofdmenu
::
::
@cls
::
@call :f_Toon_ULVMM_Header
@echo.
@echo Hoofdmenu
@echo.
@echo [1] Debian virtual machines (Linux Virtual Images)
@echo [2] Ubuntu virtual machines (Linux Virtual Images)
@echo [3] x
@echo [4] x
@echo [5] x
@echo [6] x
@echo [7] x
@echo [8] x
@echo. 
@echo [9] Verlaten ULVMM (waarde variabelen blijven geladen)
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
::
@if %antwoord%==9 goto :einde
@if %antwoord%==8 goto :Opschonen
@if %antwoord%==7 goto :hoofdmenu
@if %antwoord%==6 goto :hoofdmenu
@if %antwoord%==5 goto :hoofdmenu
@if %antwoord%==4 goto :hoofdmenu
@if %antwoord%==3 goto :hoofdmenu
@if %antwoord%==2 goto :ubuntusubmenu
@if %antwoord%==1 goto :debiansubmenu
@goto :hoofdmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian Submenu
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debiansubmenu
::
@cls
::
@call :f_Toon_ULVMM_Header
@echo.
@echo DEBIAN 
@echo.
@echo [1] Aanmaken/Create Debian 12 Desktop    VM
@echo [2] Aanmaken/Create Debian 12 Server     VM    [NIET AANWEZIG]
@echo [3] Aanmaken/Create Debian 13 Desktop    VM
@echo [4] Aanmaken/Create Debian 13 Server     VM
@echo [5] x
@echo [6] Installeer/Install Open Media Vault (OMV) in Debian 13 Server VM
@echo [7] x
@echo [8] Aanmaken/Create Debian 13 Server     VM   [Nieuwe manier]
@echo. 
@echo [9] Terug naar hoofdmenu
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
::
@if %antwoord%==9 goto :hoofdmenu
@if %antwoord%==8 goto :debian13server_new
@if %antwoord%==7 goto :debiansubmenu
@if %antwoord%==6 goto :openmediavault
@if %antwoord%==5 goto :debiansubmenu
@if %antwoord%==4 goto :debian13server
@if %antwoord%==3 goto :debian13desktop
@if %antwoord%==2 goto :debian12server
@if %antwoord%==1 goto :debian12desktop
@goto :hoofdmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 13 Server VM nieuwe manier
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debian13server_new
::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Server (Linux Virtual Images) [Nieuwe manier]
::
::

::  Parameters
::
::  [1] Directory van de Templates
::  %Debian13Server_Template_Location%
::
::  [2] Naam van de template
::  %LVIDebian13S%
::
::  [3] Directory van de virtuele machine
::  %Debian13ServerVM%
::
::  [4] Naam van de virtuele machine
::  %Linux_Debian_13_Server_Hostname%
::
::  [5] Download URL van de virtuele machine
::  %Debian13ServerUrl%
::
call :f_maak_virtuele_machine "%Debian13Server_Template_Location%" "%LVIDebian13S%" "%Debian13ServerVM%" "%Linux_Debian_13_Server_Hostname%" "%Debian13ServerUrl%"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debian 13 Server Nieuwe manier einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto debiansubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 12 Desktop VM
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debian12desktop
::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 12 Desktop (Linux Virtual Images)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_Installeer_Tools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_maak_directory_structuur
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMware Workstation Pro afsluiten
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
::
::  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Opruimen eventueel aanwezige virtuele machine %Linux_Debian_12_Desktop_Hostname%
::
::
::  ::::::::
::  Template
::  ::::::::
::
::  Verwijderen eventueel aanwezige VMWare Workstation Pro bestanden in template directory
::
@dir /b "%Debian12Desktop_Template_Location%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%Debian12Desktop_Template_Location%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian12Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian12Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian12Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian12Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  Template directory bevat geen VMWare Workstation Pro bestanden meer Mag alleen nog maar 7Z bestand bevatten
::
::  ::::::::
::  Virtuele machine
::  ::::::::
::
::
::  Opruimen eventueel bestaande virtuele machine
::  Afsluiten
::
@IF EXIST "%Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx" (
    del %Debian12DesktopVM%\*.vm* >nul 2>&1
    del %Debian12DesktopVM%\*.nvram >nul 2>&1
    del %Debian12DesktopVM%\*.scoreboard >nul 2>&1
    del %Debian12DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%Debian12DesktopVM%\*") do rd /s "%%d"
)
::
::  Opruimen voltooid
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Downloaden 7Z Template indien niet aanwezig
::
@IF NOT EXIST "%Debian12Desktop_Template_Location%\%LVIDebian12D%.7z" (
    @echo Downloaden Debian 12 Desktop Template vanaf LinuxVMImages website ...
    @curl -s -L -o %Debian12Desktop_Template_Location%\%LVIDebian12D%.7z %Debian12DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%Debian12Desktop_Template_Location%\%LVIDebian12D%.7z" (
    @echo Uitpakken/extract Debian 12 Desktop Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %Debian12Desktop_Template_Location%\%LVIDebian12D%.7z -o%Debian12DesktopVM% -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::

@echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

for /d %%D in ("%Debian12DesktopVM%\*") do (

    set "FoundVMX="
    set "FoundVMDK="

    for %%F in ("%%~fD\*.vmx") do (
        if exist "%%~fF" set "FoundVMX=1"
    )

    for %%F in ("%%~fD\*.vmdk") do (
        if exist "%%~fF" set "FoundVMDK=1"
    )

    if defined FoundVMX if defined FoundVMDK (

        echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian12DesktopVM%\"
        )

        for %%F in ("%%~fD\*.vmdk") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian12DesktopVM%\"
        )

        echo.
    )
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Debian12DesktopVM%\%LVIDebian12D%.vmx" (
    @echo Hernoem Template VMX ...
    @rename "%Debian12DesktopVM%\%LVIDebian12D%.vmx" %Linux_Debian_12_Desktop_Hostname%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian12DesktopVM%\%LVIDebian12D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Debian12DesktopVM%\%LVIDebian12D%.vmdk" %Linux_Debian_12_Desktop_Hostname%.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  ::::::::::::::::
::  Display Name
::  ::::::::::::::::
::
::
@ECHO [VMX] DisplayName aanpassen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry displayName "%Linux_Debian_12_Desktop_Hostname%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry annotation "Debian 12 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry scsi0:0.fileName "%Linux_Debian_12_Desktop_Hostname%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry extendedConfigFile "%Linux_Debian_12_Desktop_Hostname%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry nvram "%Linux_Debian_12_Desktop_Hostname%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry vmxstats.filename "%Linux_Debian_12_Desktop_Hostname%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] Processor instellen %Linux_Debian_12_Desktop_Hostname%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  CD-ROM Drive 
::
::  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
::  Vanwege ontbreken Debian 12 ISO dit onderdeel uitgezet
::
::  @echo [VMX] CD-ROM Drive configuratie %Linux_Debian_12_Desktop_Hostname%
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk Create -f %Debian12DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Linux_Debian_12_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk Create -f %Debian12DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
@echo [VMX] Netwerkinstellingen
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
::
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet0 generated ""
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Linux_Debian_12_Desktop_Hostname%
@IF EXIST %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Linux_Debian_12_Desktop_Hostname%
@IF EXIST %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx
)
::
@echo Ga naar VMWare Workstation Pro
@echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
::
::
@echo Wachten op opstarten van virtuele machine ... 
@powershell -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  LET OP
::  In Linux moet bij SED commando een enkele aanhaakteken staan
::  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
::
::
@echo Aanpassen Linux APT Repository in virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "2c\deb https://mirror.nl.mirhosting.net/debian/ bookworm main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "3c\deb-src https://mirror.nl.mirhosting.net/debian/ bookworm main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "10c\deb https://mirror.nl.mirhosting.net/debian/ bookworm-updates main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "11c\deb-src https://mirror.nl.mirhosting.net/debian/ bookworm-updates main non-free non-free-firmware" /etc/apt/sources.list
::
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet
::
@echo Linux tijdzone aanpassen ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
::
@echo Uitvoeren APT Update in virtuele machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" apt update -y
::
@echo Installeren Linux tools in virtuele machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Aanpassen Linux Bash Shell ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
::  LET OP
::  In Linux moet bij SED commando een enkele aanhaakteken staan
::  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
::
@echo Aanpassen Linux Hosts bestand ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB12-BKW-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::
@echo Aanpassen Linux Hostname bestand ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" sed -i "s/^debian12$/DB12-TRX-S-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i 's/^debian13$/DB13-TRX-S-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debian 12 Desktop einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto debiansubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 12 Server VM
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debian12server
::
@cls
@call :f_Toon_ULVMM_Header
@echo.

@echo nog niet aanwezig
@pause


@goto debiansubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 13 Desktop VM
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debian13desktop
::
::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Desktop (Linux Virtual Images)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_Installeer_Tools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_maak_directory_structuur
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMware Workstation Pro afsluiten
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
::
::  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  ::::::::
::  Template
::  ::::::::
::
::  Verwijderen eventueel aanwezige VMWare Workstation Pro bestanden in template directory
::
@dir /b "%Debian13Desktop_Template_Location%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%Debian13Desktop_Template_Location%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian13Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian13Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Debian13Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Debian13Desktop_Template_Location%\*") do rd /s "%%d"
)
::
::  Template directory bevat geen VMWare Workstation Pro bestanden meer Mag alleen nog maar 7Z bestand bevatten
::
::  ::::::::
::  Virtuele machine
::  ::::::::
::
::
::  Opruimen eventueel bestaande virtuele machine
::  Afsluiten
::
@IF EXIST "%Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx" (
    del %Debian13DesktopVM%\*.vm* >nul 2>&1
    del %Debian13DesktopVM%\*.nvram >nul 2>&1
    del %Debian13DesktopVM%\*.scoreboard >nul 2>&1
    del %Debian13DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%Debian13DesktopVM%\*") do rd /s /q "%%d" >nul 2>&1
)
::
::  Opruimen voltooid
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Downloaden 7Z Template indien niet aanwezig
::
@IF NOT EXIST "%Debian13Desktop_Template_Location%\%LVIDebian13D%.7z" (
    @echo Downloaden Debian 13 Desktop Template vanaf LinuxVMImages website ...
    @curl -s -L -o %Debian13Desktop_Template_Location%\%LVIDebian13D%.7z %Debian13DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%Debian13Desktop_Template_Location%\%LVIDebian13D%.7z" (
    @echo Uitpakken Debian 13 Desktop Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %Debian13Desktop_Template_Location%\%LVIDebian13D%.7z -o%Debian13DesktopVM% -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::

@echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

for /d %%D in ("%Debian13DesktopVM%\*") do (

    set "FoundVMX="
    set "FoundVMDK="

    for %%F in ("%%~fD\*.vmx") do (
        if exist "%%~fF" set "FoundVMX=1"
    )

    for %%F in ("%%~fD\*.vmdk") do (
        if exist "%%~fF" set "FoundVMDK=1"
    )

    if defined FoundVMX if defined FoundVMDK (

        echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13DesktopVM%\" >nul 2>&1
        )

        for %%F in ("%%~fD\*.vmdk") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13DesktopVM%\" >nul 2>&1
        )

        echo.
    )
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%LVIDebian13D%.vmx" (
    @echo [VMX] Hernoem/rename Template
    @rename "%Debian13DesktopVM%\%LVIDebian13D%.vmx" %Linux_Debian_13_Desktop_Hostname%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%LVIDebian13D%.vmdk" (
    @echo [VMDK] Hernoem/rename Template
    @rename "%Debian13DesktopVM%\%LVIDebian13D%.vmdk" %Linux_Debian_13_Desktop_Hostname%.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  ::::::::::::::::
::  Display Name
::  ::::::::::::::::
::
::
@ECHO [VMX] DisplayName aanpassen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry displayName "%Linux_Debian_13_Desktop_Hostname%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry annotation "Debian 13 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry scsi0:0.fileName "%Linux_Debian_13_Desktop_Hostname%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry extendedConfigFile "%Linux_Debian_13_Desktop_Hostname%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry nvram "%Linux_Debian_13_Desktop_Hostname%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry vmxstats.filename "%Linux_Debian_13_Desktop_Hostname%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] Processor instellen %Linux_Debian_13_Desktop_Hostname%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  CD-ROM Drive 
::
::  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
::  Vanwege ontbreken Debian 13 ISO dit onderdeel uitgezet
::
::  @echo [VMX] CD-ROM Drive configuratie %Linux_Debian_13_Desktop_Hostname%
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk Create -f %Debian13DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Linux_Debian_13_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk Create -f %Debian13DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
@echo [VMX] Netwerk configuratie
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Linux_Debian_13_Desktop_Hostname%
@IF EXIST %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Linux_Debian_13_Desktop_Hostname%
@IF EXIST %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx
)
::
@echo Ga naar VMWare Workstation Pro
::  @echo Klik op "OK" bij Channel Migitations melding
@echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
::
::
@echo Wachten op opstarten van virtuele machine ... 
::  powershell -command "Start-Sleep -Seconds 60"
@powershell -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  LET OP
::  In Linux moet bij SED commando een enkele aanhaakteken staan
::  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
::
::
@echo Aanpassen APT Repository in virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "2c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "9c\deb https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "10c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
::
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet
::
@echo Linux tijdzone aanpassen ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
::
@echo Uitvoeren APT Update in virtuele machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" apt update -y
::
@echo Installeren Tools in virtuele machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Aanpassen Linux Bash in virtual machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
::
::  LET OP
::  In Linux moet bij SED commando een enkele aanhaakteken staan
::  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
::
::
@echo Aanpassen Linux Hosts in virtual machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB13-TRX-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::
::
::  LET OP
::  In Linux moet bij SED commando een enkele aanhaakteken staan
::  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
::
::
@echo Aanpassen Linux Hostname in virtual machine ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" sed -i "s/^debian13$/DB13-TRX-S-LAB-001/" /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun.exe -T ws -gu debian -gp debian getGuestIPAddress %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
:: @start "%Linux_Debian_13_Desktop_Hostname%" C:\Windows\System32\OpenSSH\ssh.exe -p 22 debian@%vmipadres%
@wt ssh -p 22 debian@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debian 13 Desktop einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto debiansubmenu
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 13 Server VM
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:debian13server
::
::



::  Parameters
::
::  Directory van de Templates
::  %1
::
::  Naam van de template
::  %LVIDebian13S%
::
::  Directory van de virtuele machine
::  %Debian13ServerVM%
::
::  Naam van de virtuele machine
::  %Linux_Debian_13_Server_Hostname%
::
::  Download URL van de virtuele machine
::  %Debian13ServerUrl%
::


::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Server (Linux Virtual Images)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_Installeer_Tools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_maak_directory_structuur
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMware Workstation Pro afsluiten
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
::
::  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Start Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  ::::::::
::  Template
::  ::::::::
::
::
@echo Opruimen template directory
::
if exist "%1"\*.vm* (
    @del /F /S /Q "%1"\*.vm* >nul 2>&1
)
::
if exist "%1"\*.nvram (
    @del /F /S /Q "%1"\*.nvram >nul 2>&1
)
::
if exist "%1"\*.scoreboard (
    @del /F /S /Q "%1"\*.scoreboard >nul 2>&1
)
::
if exist "%1"\*.log (
    @del /F /S /Q "%1"\*.log >nul 2>&1
)
::
@for /d %%d in ("%1\*") do rd /s /q "%%d"
::
::
::  ::::::::
::  Virtuele machine
::  ::::::::
::
@echo Stoppen eventueel draaiende virtuele machine 
@IF EXIST "%Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx >nul 2>&1
)
::
@echo Verwijderen eventueel aanwezige virtuele machine
@IF EXIST "%Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx" (
    @del %Debian13ServerVM%\*.vm* >nul 2>&1
    @del %Debian13ServerVM%\*.nvram >nul 2>&1
    @del %Debian13ServerVM%\*.scoreboard >nul 2>&1
    @del %Debian13ServerVM%\*.log >nul 2>&1
    @for /d %%d in ("%Debian13ServerVM%\*") do rd /s /q "%%d" >nul 2>&1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Einde Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Downloaden 7Z Template indien niet aanwezig
::
@IF NOT EXIST "%1\%LVIDebian13S%.7z" (
    @echo Downloaden Debian 13 Server Template vanaf LinuxVMImages website ...
    @curl -s -L -o %1\%LVIDebian13S%.7z %Debian13ServerUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%1\%LVIDebian13S%.7z" (
    @echo Uitpakken Debian 13 Server Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %1\%LVIDebian13S%.7z -o%Debian13ServerVM% -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::

@REM @echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

for /d %%D in ("%Debian13ServerVM%\*") do (

    set "FoundVMX="
    set "FoundVMDK="

    for %%F in ("%%~fD\*.vmx") do (
        if exist "%%~fF" set "FoundVMX=1"
    )

    for %%F in ("%%~fD\*.vmdk") do (
        if exist "%%~fF" set "FoundVMDK=1"
    )

    if defined FoundVMX if defined FoundVMDK (

        @REM echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            @REM echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13ServerVM%\" >nul 2>&1
        )

        for %%F in ("%%~fD\*.vmdk") do (
            @REM echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13ServerVM%\" >nul 2>&1
        )
        @REM
        @REM echo.
        @REM
    )
)
::
::
::  Verwijderen eventuele aanwezige subdirectories uit vorige stap
@for /d %%d in ("%Debian13ServerVM%\*") do rd /s /q "%%d" >nul 2>&1
::
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%LVIDebian13S%.vmx" (
    @echo [VMX] Hernoem naar %Linux_Debian_13_Server_Hostname%
    @rename "%Debian13ServerVM%\%LVIDebian13S%.vmx" %Linux_Debian_13_Server_Hostname%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%LVIDebian13S%.vmdk" (
    @echo [VMDK] Hernoem naar %Linux_Debian_13_Server_Hostname%
    @rename "%Debian13ServerVM%\%LVIDebian13S%.vmdk" %Linux_Debian_13_Server_Hostname%.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Header aanmaken
::
echo # > %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo #   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo #     TT    U    U    TT    SS      O    O  FF        TT >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo #     TT    U    U    TT    SSSSSS  O    O  FFFF      TT >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo #     TT    U    U    TT        SS  O    O  FF        TT >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo #     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # Debian 13 Server >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # Linux Virtual Images (LVI) >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
echo # >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
::
::  Huidige VMX in nieuwe VMX zetten
type %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx >> %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx
::
::
@powershell -command "Start-Sleep -Seconds 2"
::
::
rename %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx %Linux_Debian_13_Server_Hostname%.org 
rename %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%-new.vmx %Linux_Debian_13_Server_Hostname%.vmx 
del %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.org
::
::
::  :::::::::::::::::
::  Virtuele machine UUID
::  :::::::::::::::::
::
::  You can configure a virtual machine to always receive a new UUID when it is copied or moved so that you are not prompted when you move or copy the virtual machine.
::  Zie https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/configuring-and-managing-virtual-machines/moving-virtual-machines/using-the-virtual-machine-uuid/configure-a-virtual-machine-to-always-receive-a-new-uuid.html
::
::
@echo [VMX] Nieuw UUID aanmaken %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry uuid.action "create"
::
::
::  ::::::::::::::::
::  Display Name
::  ::::::::::::::::
::
::
@ECHO [VMX] DisplayName aanpassen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry displayName "%Linux_Debian_13_Server_Hostname%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry annotation "Debian 13 Server Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry scsi0:0.fileName "%Linux_Debian_13_Server_Hostname%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry extendedConfigFile "%Linux_Debian_13_Server_Hostname%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry nvram "%Linux_Debian_13_Server_Hostname%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry vmxstats.filename "%Linux_Debian_13_Server_Hostname%.scoreboard"
::
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
::
@echo [VMX] Processor instellen %Linux_Debian_13_Server_Hostname%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
::
@echo [VMX] RAM Geheugen instellen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  CD-ROM Drive 
::
::  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
::  Vanwege ontbreken Debian 13 ISO dit onderdeel uitgezet
::
::  @echo [VMX] CD-ROM Drive configuratie %Linux_Debian_13_Server_Hostname%
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk Create -f %Debian13ServerVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Linux_Debian_13_Server_Hostname%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk Create -f %Debian13ServerVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::
@echo [VMX] Netwerk configuratie ...
::
::  Ethernet0
::
::  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetVirtualDevice ethernet0 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetConnectionType ethernet0 nat
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetLinkStatePropagation ethernet0 true
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetPresent ethernet0 1
::
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry ethernet0.vnet "VMnet8"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry ethernet0.displayName "VMnet8"
::
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  Ethernet1
::
::  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetPresent ethernet1 1
:: 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
::
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Linux_Debian_13_Server_Hostname%
@IF EXIST %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Linux_Debian_13_Server_Hostname%
@IF EXIST %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx
)
::
@echo Ga naar VMWare Workstation Pro
::  @echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
::
::
@echo Wachten op opstarten van virtuele machine ... 
@powershell -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Linux tijdzone aanpassen ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
::
::  Alles aanpassen naar Nederland
@echo Aanpassen APT Repository in virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "2c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "9c\deb https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "10c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
::  Moet worden gedaan omdat APT Repositories zijn aangepast
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" apt update -y
::  Deze stap maakt curl en sed beschikbaar voor andere stappen
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
::  Voor deze stap wordt curl gebruikt
@echo Linux Bash voorkeuren downloaden ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::  Voor deze stap wordt sed gebruikt
@echo Hosts bestand aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB13-TRX-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::  Voor deze stap wordt sed gebruikt
@echo Linux Hostname aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i "s/^debian13$/DB13-TRX-S-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" sed -i 's/^debian13$/DB13-TRX-S-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" "curl -s -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet"
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debian 13 Server einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto debiansubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Debian 13 Server Open Media Vault
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:openmediavault
::
::
@echo Open Media Vault versie 8 installeren ...
@echo.
@echo Standaard gebruiker       admin
@echo Standaard wachtwoord      openmediavault
::
::
@echo OMV Installatie Script downloaden
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/omv_install.sh https://raw.githubusercontent.com/openmediavault/openmediavault/master/install.sh
::
::
@echo OMV Script uitvoerbaar maken 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" chmod +x /home/debian/omv_install.sh
::
::
@echo OMV Script starten om OMV te installeren binnen virtuele machine ... 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" /home/debian/omv_install.sh
::
::
@echo Vewijderen Sources.list bestand in virtuele machine 
@echo Anders werkt updaten niet meer ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" rm /etc/apt/sources.list
::
::
@echo OMV Toevoegen Debian gebruiker aan groepen 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-admin debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-config debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-engined debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-notify debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-webgui debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG _ssh debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG root debian
::
::
@echo.
@echo Vanaf nu is inloggen met user debian en wachtwoord debian mogelijk op Open Media Vault
@echo.
@echo Nu wordt HERSTART gedaan van virtuele machine ...
@echo.
@echo   LET OP ! Het duurt even voordat de webinterface beschikbaar is ...
@echo   Je hoort twee (zachte) piepjes als webinterface beschikbaar is. 
@echo.
::
::  ::  Upgrade OMV
::  @echo OMV upgraden naar de nieuwste versie ...
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" omv-upgrade
::
::
@pause
::
::
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" shutdown -r now
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debia 13 Server Open Media Vault Einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto debiansubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Ubuntu Submenu
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:ubuntusubmenu
::
@CLS
::
@call :f_Toon_ULVMM_Header
@echo.
@echo UBUNTU
@echo.
::
echo [1] Aanmaken Ubuntu 24.04 Desktop VM   [werkt]
echo [2] Aanmaken Ubuntu 24.04 Server VM    [niet aanwezig]
echo [3] Aanmaken Ubuntu 26.04 Desktop VM   [niet aanwezig]
echo [4] Aanmaken Ubuntu 26.04 Server VM    [niet aanwezig]
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo. 
echo [9] Terug naar hoofdmenu ULVMM
echo. 
:: echo Maak uw keuze 
::
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
::
if %antwoord%==9 goto :hoofdmenu
if %antwoord%==8 goto :ubuntusubmenu
if %antwoord%==7 goto :ubuntusubmenu
if %antwoord%==6 goto :ubuntusubmenu
if %antwoord%==5 goto :ubuntusubmenu
if %antwoord%==4 goto :ubuntusubmenu
if %antwoord%==3 goto :ubuntusubmenu
if %antwoord%==2 goto :ubuntusubmenu
if %antwoord%==1 goto :ubuntu2404deskop
goto :ubuntusubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Ubuntu 2404 Desktop
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:ubuntu2404deskop 
::
::
::
@cls
::
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Desktop (Linux Virtual Images)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_Installeer_Tools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_maak_directory_structuur
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMware Workstation Pro afsluiten
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
::
::  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  ::::::::
::  Template
::  ::::::::
::
::  Verwijderen eventueel aanwezige VMWare Workstation Pro bestanden in template directory
::
@dir /b "%Ubuntu24Desktop_Template_Location%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%Ubuntu24Desktop_Template_Location%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Ubuntu24Desktop_Template_Location%\*") do rd /s /q "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Ubuntu24Desktop_Template_Location%\*") do rd /s /q "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.vm* >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.nvram >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%Ubuntu24Desktop_Template_Location%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%Ubuntu24Desktop_Template_Location%\*") do rd /s /q "%%d"
)
::
::  Template directory bevat geen VMWare Workstation Pro bestanden meer Mag alleen nog maar 7Z bestand bevatten
::
::  ::::::::
::  Virtuele machine
::  ::::::::
::
::
::  Opruimen eventueel bestaande virtuele machine
::  Afsluiten
::
@IF EXIST "%Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx" (
    del %Ubuntu24DesktopVM%\*.vm* >nul 2>&1
    del %Ubuntu24DesktopVM%\*.nvram >nul 2>&1
    del %Ubuntu24DesktopVM%\*.scoreboard >nul 2>&1
    del %Ubuntu24DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\*") do rd /s /q "%%d" >nul 2>&1
)
::
::  Opruimen voltooid
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Downloaden 7Z Template indien niet aanwezig
::
@IF NOT EXIST "%Ubuntu24Desktop_Template_Location%\%LVIUbuntu24D%.7z" (
    @echo Downloaden template virtuele machine vanaf LinuxVMImages website ...
    @curl -s -L -o %Ubuntu24Desktop_Template_Location%\%LVIUbuntu24D%.7z %Ubuntu24DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%Ubuntu24Desktop_Template_Location%\%LVIUbuntu24D%.7z" (
    @echo Uitpakken template virtuele machine naar virtuele machine directory ...
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %Ubuntu24Desktop_Template_Location%\%LVIUbuntu24D%.7z -o%Ubuntu24DesktopVM% -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Ubuntu 13 uitpak doet naar een subdirectory binnen directory
::

@echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

for /d %%D in ("%Ubuntu24DesktopVM%\*") do (

    set "FoundVMX="
    set "FoundVMDK="

    for %%F in ("%%~fD\*.vmx") do (
        if exist "%%~fF" set "FoundVMX=1"
    )

    for %%F in ("%%~fD\*.vmdk") do (
        if exist "%%~fF" set "FoundVMDK=1"
    )

    if defined FoundVMX if defined FoundVMDK (

        echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Ubuntu24DesktopVM%\"
        )

        for %%F in ("%%~fD\*.vmdk") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Ubuntu24DesktopVM%\"
        )

        echo.
    )
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmx" (
    @echo Hernoem Template VMX ...
    @rename "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmx" %Linux_Ubuntu_24_Desktop_Hostname%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmdk" %Linux_Ubuntu_24_Desktop_Hostname%.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  ::::::::::::::::
::  Display Name
::  ::::::::::::::::
::
::
@ECHO [VMX] DisplayName aanpassen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry displayName "%Linux_Ubuntu_24_Desktop_Hostname%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry annotation "Ubuntu 24.04 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry scsi0:0.fileName "%Linux_Ubuntu_24_Desktop_Hostname%.vmdk"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry extendedConfigFile "%Linux_Ubuntu_24_Desktop_Hostname%.vmxf"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry nvram "%Linux_Ubuntu_24_Desktop_Hostname%.nvram"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry vmxstats.filename "%Linux_Ubuntu_24_Desktop_Hostname%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Linux_Ubuntu_24_Desktop_Hostname%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  CD-ROM Drive 
::
::  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
::  Vanwege ontbreken Ubuntu 13 ISO dit onderdeel uitgezet
::
::  @echo [VMX] CD-ROM Drive configuratie %Linux_Ubuntu_24_Desktop_Hostname%
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk Create -f %Ubuntu24DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Linux_Ubuntu_24_Desktop_Hostname%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk Create -f %Ubuntu24DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Linux_Ubuntu_24_Desktop_Hostname%
@IF EXIST %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Linux_Ubuntu_24_Desktop_Hostname%
@IF EXIST %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx
)
::
@echo Ga naar VMWare Workstation Pro
@echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
::
::
@echo Wachten op opstarten van virtuele machine ... 
@powershell -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Ubuntu Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo APT Repository aanpassen naar NL in virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
::
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" apt update -y
::
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Bash voorkeuren instellen ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/ubuntu/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" curl -s -o /home/ubuntu/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
@echo Hosts bestand aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-LTS-D-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
::
@echo Linux Hostname aanpassen in de virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-LTS-D-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" sed -i 's/^ubuntu2404$/U24-LTS-D-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" curl -L -o /home/ubuntu/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx "/bin/sudo" chmod +x /home/ubuntu/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Ubuntu 24 Desktop einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
goto :ubuntusubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Ubuntu 2404 Server
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:ubuntu2404server
::
@cls
::
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Server (Linux Virtual Images)

goto :ubuntusubmenu


::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    E I N D E    S C R I P T
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:einde
@cls
@call :f_Toon_ULVMM_Header
::
@echo.
@echo Einde Script
@echo.
@echo Variabele waarden zijn nog gewoon geladen !
@echo.
@exit /b 0
::
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Functies
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:f_Toon_ULVMM_Header
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo ::::: Ultimate Linux Virtual Machine Manager                           
@echo ::::: Build %ULVMMBuild% Patch %ULVMMUpdate% CHANNEL %ULVMMChannel%
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@goto :eof
::
::
:f_Installeer_Tools
::
::  Functie voor installatie van tools voor dit script
::  Installatie wordt gedaan met Winget
::
::  Aanroepen functie met call installeertools
::
@7z >nul 2>&1
@if %errorlevel% neq 0 (
    @echo NanaZIP niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id M2Team.NanaZip --silent >%TEMP%\WinGet-NanaZip-Installatie.log
)
::
@curl -V >nul 2>&1
@if %errorlevel% neq 0 (
    @echo Curl niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id cURL.cURL --silent >%TEMP%\WinGet-cURL-Installatie.log
)
::
@pwsh --version >nul 2>&1
@if %errorlevel% neq 0 (
    @echo Powershell 7 niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id Microsoft.PowerShell --silent >%TEMP%\WinGet-pwsh-Installatie.log
)
::
@set "app_dir_check=C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1"
@if not exist "%app_dir_check%*" (
    @echo Windows Terminal niet aangetroffen
    @winget install --id Microsoft.WindowsTerminal --silent >%TEMP%\WinGet-WinTerm-Installatie.log
)
::
::
@goto :eof
::
::
:f_maak_directory_structuur
::
::
::  Templates
::
::
@mkdir %Templates_Default_Location% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName% >nul 2>&1
::
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12 >nul 2>&1
@mkdir %Debian12Desktop_Template_Location% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12\%Templates_Linux_Server_DirName% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13 >nul 2>&1
@mkdir %Debian13Desktop_Template_Location% >nul 2>&1
@mkdir %1 >nul 2>&1
::
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404 >nul 2>&1
@mkdir %Ubuntu24Desktop_Template_Location% >nul 2>&1
@mkdir %Ubuntu24Server_Template_Location% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604 >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Desktop_DirName% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Server_DirName% >nul 2>&1
::
::
::  Virtuele machines
::
::
@mkdir %VWSP_VM_Default_Location% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12 >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %Debian12DesktopVM% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_12_Server_Hostname% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13 >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_13_Desktop_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_13_Server_Hostname% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404 >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_24_Desktop_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Server_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Docker_Hostname% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604 >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_26_Desktop_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Server_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Docker_Hostname% >nul 2>&1
::
::
@goto :eof
::
::
:f_maak_virtuele_machine
::

exit /b 0
::
::  Parameters
::
::  [1] Directory van de Templates
::  %Debian13Server_Template_Location%
::
::  [2] Naam van de template
::  %LVIDebian13S%
::
::  [3] Directory van de virtuele machine
::  %Debian13ServerVM%
::
::  [4] Naam van de virtuele machine
::  %Linux_Debian_13_Server_Hostname%
::
::  [5] Download URL van de virtuele machine
::  %Debian13ServerUrl%
::

@echo starten functie aanmaken virtuele machine
@echo Waarden parameters
echo %1
echo %2
echo %3
echo %4
echo %5
echo Installatie pad vmware %VMWareInstallPath%

::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_Installeer_Tools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :f_maak_directory_structuur
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMware Workstation Pro afsluiten
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
::
::  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Start Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  ::::::::
::  Template
::  ::::::::
::
::
@echo Opruimen template directory
::
if exist "%1"\*.vm* (
    @del /F /S /Q "%1"\*.vm* >nul 2>&1
)
::
if exist "%1"\*.nvram (
    @del /F /S /Q "%1"\*.nvram >nul 2>&1
)
::
if exist "%1"\*.scoreboard (
    @del /F /S /Q "%1"\*.scoreboard >nul 2>&1
)
::
if exist "%1"\*.log (
    @del /F /S /Q "%1"\*.log >nul 2>&1
)
::
@for /d %%d in ("%1\*") do rd /s "%%d"
::
::
::  ::::::::
::  Virtuele machine
::  ::::::::
::
@echo Stoppen eventueel draaiende virtuele machine 
@IF EXIST "%3\%4.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %3\%4.vmx >nul 2>&1
)
::
@echo Verwijderen eventueel aanwezige virtuele machine
@IF EXIST "%3\%4.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %3\%4.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%3\%4.vmx" (
    @del %3\*.vm* >nul 2>&1
    @del %3\*.nvram >nul 2>&1
    @del %3\*.scoreboard >nul 2>&1
    @del %3\*.log >nul 2>&1
    @for /d %%d in ("%3\*") do rd /s "%%d"
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Einde Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Downloaden 7Z Template indien niet aanwezig
::
@IF NOT EXIST "%1\%2.7z" (
    @echo Downloaden Debian 13 Server Template vanaf LinuxVMImages website ...
    @curl -s -L -o %1\%2.7z %5
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%1\%2.7z" (
    @echo Uitpakken Debian 13 Server Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %1\%2.7z -o%3 -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::

@REM @echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

for /d %%D in ("%3\*") do (

    set "FoundVMX="
    set "FoundVMDK="

    for %%F in ("%%~fD\*.vmx") do (
        if exist "%%~fF" set "FoundVMX=1"
    )

    for %%F in ("%%~fD\*.vmdk") do (
        if exist "%%~fF" set "FoundVMDK=1"
    )

    if defined FoundVMX if defined FoundVMDK (

        @REM echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            @REM echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%3\" >nul 2>&1
        )

        for %%F in ("%%~fD\*.vmdk") do (
            @REM echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%3\" >nul 2>&1
        )
        @REM
        @REM echo.
        @REM
    )
)
::
::
::  Verwijderen eventuele aanwezige subdirectories uit vorige stap
@for /d %%d in ("%3\*") do rd /s "%%d" 
::
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%3\%2.vmx" (
    @echo [VMX] Hernoem naar %4
    @rename "%3\%2.vmx" %4.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%3\%2.vmdk" (
    @echo [VMDK] Hernoem naar %4
    @rename "%3\%2.vmdk" %4.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Header aanmaken
::
echo # > %3\%4-new.vmx
echo # >> %3\%4-new.vmx
echo #   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT >> %3\%4-new.vmx
echo #     TT    U    U    TT    SS      O    O  FF        TT >> %3\%4-new.vmx
echo #     TT    U    U    TT    SSSSSS  O    O  FFFF      TT >> %3\%4-new.vmx
echo #     TT    U    U    TT        SS  O    O  FF        TT >> %3\%4-new.vmx
echo #     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT >> %3\%4-new.vmx
echo # >> %3\%4-new.vmx
echo # >> %3\%4-new.vmx
echo # Debian 13 Server >> %3\%4-new.vmx
echo # Linux Virtual Images (LVI) >> %3\%4-new.vmx
echo # >> %3\%4-new.vmx
echo # >> %3\%4-new.vmx
::
::  Huidige VMX in nieuwe VMX zetten
type %3\%4.vmx >> %3\%4-new.vmx
::
::
@powershell -command "Start-Sleep -Seconds 2"
::
::
rename %3\%4.vmx %4.org 
rename %3\%4-new.vmx %4.vmx 
del %3\%4.org
::
::
::  :::::::::::::::::
::  Virtuele machine UUID
::  :::::::::::::::::
::
::  You can configure a virtual machine to always receive a new UUID when it is copied or moved so that you are not prompted when you move or copy the virtual machine.
::  Zie https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/configuring-and-managing-virtual-machines/moving-virtual-machines/using-the-virtual-machine-uuid/configure-a-virtual-machine-to-always-receive-a-new-uuid.html
::
::
@echo [VMX] Nieuw UUID aanmaken %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry uuid.action "create"
::
::
::  ::::::::::::::::
::  Display Name
::  ::::::::::::::::
::
::
@ECHO [VMX] DisplayName aanpassen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry displayName "%4"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry annotation "Debian: debian/debian Ubuntu: ubuntu/ubuntu"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry scsi0:0.fileName "%4.vmdk"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry extendedConfigFile "%4.vmxf"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry nvram "%4.nvram"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry vmxstats.filename "%4.scoreboard"
::
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
::
@echo [VMX] Processor instellen %4
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
::
@echo [VMX] RAM Geheugen instellen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  CD-ROM Drive 
::
::  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
::  Vanwege ontbreken Debian 13 ISO dit onderdeel uitgezet
::
::  @echo [VMX] CD-ROM Drive configuratie %4
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk Create -f %3\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %4
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk Create -f %3\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::
@echo [VMX] Netwerk configuratie ...
::
::  Ethernet0
::
::  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetVirtualDevice ethernet0 vmxnet
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetConnectionType ethernet0 nat
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetLinkStatePropagation ethernet0 true
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetPresent ethernet0 1
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.vnet "VMnet8"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.displayName "VMnet8"
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  Ethernet1
::
::  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetPresent ethernet1 1
:: 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetAddressType ethernet1 generated ""
::
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %4
@IF EXIST %3\%4.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %3\%4.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %4
@IF EXIST %3\%4.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %3\%4.vmx
)
::
@echo Ga naar VMWare Workstation Pro
::  @echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
::
::
@echo Wachten op opstarten van virtuele machine ... 
@powershell -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Linux tijdzone aanpassen ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
::
::  Alles aanpassen naar Nederland
@echo Aanpassen APT Repository in virtuele machine
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "9c\deb https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "10c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
::  Moet worden gedaan omdat APT Repositories zijn aangepast
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
::  Deze stap maakt curl en sed beschikbaar voor andere stappen
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
::  Voor deze stap wordt curl gebruikt
@echo Linux Bash voorkeuren downloaden ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::  Voor deze stap wordt sed gebruikt
@echo Hosts bestand aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB13-TRX-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::  Voor deze stap wordt sed gebruikt
@echo Linux Hostname aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian13$/DB13-TRX-S-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i 's/^debian13$/DB13-TRX-S-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" "curl -s -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet"
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %3\%4.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
::
::

::
::
@goto :eof
::
::



