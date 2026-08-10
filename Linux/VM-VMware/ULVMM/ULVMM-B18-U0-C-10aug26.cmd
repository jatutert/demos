@echo off
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
::  
::
:: To do
::
:: Ubuntu 26.04 LTS Server beschikbaar maken zodra beschikbaar op LVI website
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
::  Build 15 Update 1 Functie aanpassingen nav verwijderen alle directories door build 15
::  Build 15 Update 2 Functie Debian en Ubuntu
::
::
::  ::::::::::::::::::::::::::::::: WORK IN PROGRESS :::::::::::::::::::::: CANARY VERSION :::::::::::::::::::::::::::::
::
::
::  Ultimate Linux VM Manager (ULVMM)
::
::
@Set "ULVMMBuild=18"
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
::
::  Naam van de directory met Linux virtuele machines               default is Linux
@set "VWSP_VM_Linux_DirName=Linux"
::  Naam van de directory met Debian Linux virtuele machines        default is Debian
@set "VWSP_VM_Linux_Debian_DirName=Debian"
::  Naam van de directory met Ubuntu Linux virtuele machines        default is Ubuntu
@set "VWSP_VM_Linux_Ubuntu_DirName=Ubuntu"
::  Naam van de directory met Debian Desktop virtuele machines      default is desktop
@set "VWSP_VM_Linux_Debian_Desktop_DirName=Desktop"
::  Naam van de directory met Desktop Server virtuele machines      default is server 
@set "VWSP_VM_Linux_Debian_Server_DirName=Server"
::  Naam van de directory met Ubuntu Desktop virtuele machines      default is desktop
@set "VWSP_VM_Linux_Ubuntu_Desktop_DirName=Desktop"
::  Naam van de directory met Ubuntu Server virtuele machines       default is server
@set "VWSP_VM_Linux_Ubuntu_Server_DirName=Server"
::  Naam van de directory met Windows virtuele machines             default is Windows
@set "VWSP_VM_Windows_DirName=Windows"
::
::  Namen Debian 12 Virtuele machines
@set "Linux_Debian_12_Desktop_Hostname=D12-BKW-D-LAB-001"
@set "Linux_Debian_12_Server_Hostname=D12-BKW-S-LAB-001"
::  Namen Debian 13 Virtuele machines
@set "Linux_Debian_13_Desktop_Hostname=D13-TRX-D-LAB-001"
@set "Linux_Debian_13_Server_Hostname=D13-TRX-S-LAB-001"
::  Namen Ubuntu 24.04 virtuele machines
@set "Linux_Ubuntu_24_Desktop_Hostname=U24-NNT-D-LAB-001"
@set "Linux_Ubuntu_24_Server_Hostname=U24-NNT-S-LAB-001"
@set "Linux_Ubuntu_24_Docker_Hostname=U24-NNT-S-DKR-001"
::  Namen Ubuntu 26.04 virtuele machines
@set "Linux_Ubuntu_26_Desktop_Hostname=U26-RRN-D-LAB-001"
@set "Linux_Ubuntu_26_Server_Hostname=U26-RRN-S-LAB-001"
@set "Linux_Ubuntu_26_Docker_Hostname=U26-RRN-S-DKR-001"
::
::  Templates
::
::  Standaard lokatie van templates (sjablonen) voor virtuele machines op de eigen PC en/of Laptop
@set "Templates_Default_Location=D:\Virtual-Machines\Templates"
::
::  Naam van de directory met Linux tempates        default is Linux
@set "Templates_Linux_DirName=Linux"
::  Naam de directory met Debian templates          default is debian
@set "Templates_Linux_Debian_DirName=Debian"
::  Naam van de directory met Ubuntu templates      default is ubuntu
@set "Templates_Linux_Ubuntu_DirName=Ubuntu"
::  Naam van de directory met Desktop templates     default is Regular
@set "Templates_Linux_Desktop_DirName=Regular"
::  Naam van de directory met Server templates      default is Minimal
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
@set "Debian12DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/D/12/Debian_12.0.0_VMG.7z"
@set "Debian12ServerUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/D/12/Debian_12.0.0_VMM.7z"
::  Linux Virtual Images Debian 13 download URL
@set "Debian13DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/D/13/Debian_13_VMG.7z"
@set "Debian13ServerUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/D/13/Debian_13_VMM.7z"
::  Linux Virtual Images Ubuntu 24 download URL
@set "Ubuntu24DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/24.04/Ubuntu_24.04_VM.7z"
@set "Ubuntu24ServerUrl= https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/24.04/UbuntuServer_24.04_VM.7z"
::  Linux Virtual Images Ubuntu 26 download URL
@set "Ubuntu26DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/26.04/Ubuntu_26.04_VM.7z"
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
@echo [8] Alle Templates downloaden [niet aanwezig]
@echo. 
@echo [9] Verlaten/Exit ULVMM
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
::
@if %antwoord%==9 goto :einde
@if %antwoord%==8 goto :hoofdmenu
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
@echo [1] Aanmaken/Create Debian 12 Desktop virtual machine
@echo [2] Aanmaken/Create Debian 12 Server virtual machine
@echo [3] Aanmaken/Create Debian 13 Desktop virtual machine
@echo [4] Aanmaken/Create Debian 13 Server virtual machine
@echo [5] x
@echo [6] Installeer/Install Open Media Vault (OMV) in Debian 13 Server VM
@echo [7] x
@echo [8] x
@echo. 
@echo [9] Terug naar hoofdmenu
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
::
@if %antwoord%==9 goto :hoofdmenu
@if %antwoord%==8 goto :debiansubmenu
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
@echo Debian 12 Desktop (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Debian12Desktop_Template_Location% 
::  [2] %LVIDebian12D% 
::  [3] %Debian12DesktopVM% 
::  [4] %Linux_Debian_12_Desktop_Hostname% 
::  [5] %Debian12DesktopUrl%
::  [6] debian (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Debian12Desktop_Template_Location% %LVIDebian12D% %Debian12DesktopVM% %Linux_Debian_12_Desktop_Hostname% %Debian12DesktopUrl% debian
::
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
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
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 12 Server (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Debian12Server_Template_Location% 
::  [2] %LVIDebian12S% 
::  [3] %Debian12ServerVM% 
::  [4] %Linux_Debian_12_Server_Hostname% 
::  [5] %Debian12ServerUrl%
::  [6] debian (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Debian12Server_Template_Location% %LVIDebian12S% %Debian12ServerVM% %Linux_Debian_12_Server_Hostname% %Debian12ServerUrl% debian
::
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12ServerVM%\%Linux_Debian_12_Server_Hostname%.vmx') do set vmipadres=%%A
::
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Debian 12 Server einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
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
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Desktop (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Debian13Desktop_Template_Location% 
::  [2] %LVIDebian13D% 
::  [3] %Debian13DesktopVM% 
::  [4] %Linux_Debian_13_Desktop_Hostname% 
::  [5] %Debian13DesktopUrl%
::  [6] debian (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Debian13Desktop_Template_Location% %LVIDebian13D% %Debian13DesktopVM% %Linux_Debian_13_Desktop_Hostname% %Debian13DesktopUrl% debian
::
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun.exe -T ws -gu debian -gp debian getGuestIPAddress %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
::
@echo SSH Sessie virtuele machine starten
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
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Server (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Debian13Server_Template_Location% 
::  [2] %LVIDebian13S% 
::  [3] %Debian13ServerVM% 
::  [4] %Linux_Debian_13_Server_Hostname% 
::  [5] %Debian13ServerUrl%
::  [6] debian (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Debian13Server_Template_Location% %LVIDebian13S% %Debian13ServerVM% %Linux_Debian_13_Server_Hostname% %Debian13ServerUrl% debian
::
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx') do set vmipadres=%%A
::
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
echo [1] Aanmaken/Create Ubuntu 24.04 Desktop virtual machine
echo [2] Aanmaken/Create Ubuntu 24.04 Server virtual machine
echo [3] Aanmaken/Create Ubuntu 26.04 Desktop virtual machine
echo [4] Aanmaken/Create Ubuntu 26.04 Server virtual machine [niet beschikbaar vanuit LVI website]
echo [5] x
echo [6] x
echo [7] x
echo [8] Ga naar LVI website VMWare Images
echo. 
echo [9] Terug naar hoofdmenu ULVMM
echo. 
:: echo Maak uw keuze 
::
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
::
if %antwoord%==9 goto :hoofdmenu
if %antwoord%==8 goto :lviubuntuwebsite
if %antwoord%==7 goto :ubuntusubmenu
if %antwoord%==6 goto :ubuntusubmenu
if %antwoord%==5 goto :ubuntusubmenu
if %antwoord%==4 goto :ubuntusubmenu
if %antwoord%==3 goto :ubuntu2604deskop
if %antwoord%==2 goto :ubuntu2404server
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
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Desktop (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Ubuntu24Desktop_Template_Location% 
::  [2] %LVIUbuntu24D% 
::  [3] %Ubuntu24DesktopVM% 
::  [4] %Linux_Ubuntu_24_Desktop_Hostname% 
::  [5] %Ubuntu24DesktopUrl%
::  [6] ubuntu (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Ubuntu24Desktop_Template_Location% %LVIUbunu24D% %Ubuntu24DesktopVM% %Linux_Ubuntu_24_Desktop_Hostname% %Ubuntu24DesktopUrl% ubuntu
::
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
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Server (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Ubuntu24Server_Template_Location% 
::  [2] %LVIUbuntu24S% 
::  [3] %Ubuntu24ServerVM% 
::  [4] %Linux_Ubuntu_24_Server_Hostname% 
::  [5] %Ubuntu24ServerUrl%
::  [6] ubuntu (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Ubuntu24Server_Template_Location% %LVIUbuntu24S% %Ubuntu24ServerVM% %Linux_Ubuntu_24_Server_Hostname% %Ubuntu24ServerUrl% ubuntu
::
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubntu -gp ubuntu getGuestIPAddress %Ubuntu24ServerVM%\%Linux_Ubuntu_24_Server_Hostname%.vmx') do set vmipadres=%%A
::
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Ubuntu 24.04 LTS Server einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
goto :ubuntusubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Ubuntu 26.04 LTS Desktop
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:ubuntu2604deskop 
::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 26.04 LTS Desktop (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Ubuntu26Desktop_Template_Location% 
::  [2] %LVIUbuntu26D% 
::  [3] %Ubuntu26DesktopVM% 
::  [4] %Linux_Ubuntu_26_Desktop_Hostname% 
::  [5] %Ubuntu26DesktopUrl%
::  [6] ubuntu (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Ubuntu26Desktop_Template_Location% %LVIUbunu26D% %Ubuntu26DesktopVM% %Linux_Ubuntu_26_Desktop_Hostname% %Ubuntu26DesktopUrl% ubuntu
::
::

@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu26DesktopVM%\%Linux_Ubuntu_26_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Ubuntu 26 Desktop einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
goto :ubuntusubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Ubuntu 26.04 LTS Server
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:ubuntu2604server
::
::
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 26.04 LTS Server (Linux Virtual Images) Virtual Machine
::
::
::  De volgende parameters gaan naar de functie:
::  [1] %Ubuntu26Server_Template_Location% 
::  [2] %LVIUbuntu26S% 
::  [3] %Ubuntu26ServerVM% 
::  [4] %Linux_Ubuntu_26_Server_Hostname% 
::  [5] %Ubuntu26ServerUrl%
::  [6] ubuntu (gebruikersnaam virtuele machine)
::
::
call :f_maak_virtuele_machine %Ubuntu26Server_Template_Location% %LVIUbunu26S% %Ubuntu26ServerVM% %Linux_Ubuntu_26_Server_Hostname% %Ubuntu26ServerUrl% ubuntu
::
::

@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu26DesktopVM%\%Linux_Ubuntu_26_Desktop_Hostname%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Ubuntu 26 Server einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
goto :ubuntusubmenu
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    LVI Ubuntu Website
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:lviubuntuwebsite
::
::

start chrome https://www.linuxvmimages.com/images/vmware/

::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  LVI Ubuntu Website einde
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
goto :ubuntusubmenu
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    E I N D E    S C R I P T
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
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
::  Debian
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName% >nul 2>&1
::  Debian Versie 12
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12 >nul 2>&1
@mkdir %Debian12Desktop_Template_Location% >nul 2>&1
@mkdir %Debian12Server_Template_Location% >nul 2>&1
::  Debian Versie 13
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13 >nul 2>&1
@mkdir %Debian13Desktop_Template_Location% >nul 2>&1
@mkdir %Debian13Server_Template_Location% >nul 2>&1
::  Ubuntu
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName% >nul 2>&1
::  Ubuntu 24.04 LTS
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404 >nul 2>&1
@mkdir %Ubuntu24Desktop_Template_Location% >nul 2>&1
@mkdir %Ubuntu24Server_Template_Location% >nul 2>&1
::  Ubuntu 26.04 LTS
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604 >nul 2>&1
@mkdir %Ubuntu26Desktop_Template_Location% >nul 2>&1
@mkdir %Ubuntu26Server_Template_Location% >nul 2>&1
::
::
::  Virtuele machines
::
::
@mkdir %VWSP_VM_Default_Location% >nul 2>&1
::
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName% >nul 2>&1
::  Debian
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName% >nul 2>&1
::  Debian 12
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12 >nul 2>&1
::  Debian 12 Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_12_Desktop_Hostname% >nul 2>&1
::  Debian 12 Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_12_Server_Hostname% >nul 2>&1
::  Debian 13
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13 >nul 2>&1
::  Debian 13 Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_13_Desktop_Hostname% >nul 2>&1
::  Debian 13 Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_13_Server_Hostname% >nul 2>&1
::  Ubuntu
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName% >nul 2>&1
::  Ubuntu 24.04 LTS
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404 >nul 2>&1
::  Ubuntu 24.04 LTS Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_24_Desktop_Hostname% >nul 2>&1
::  Ubuntu 24.04 LTS Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Server_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Docker_Hostname% >nul 2>&1
::  Ubuntu 26.04 LTS
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604 >nul 2>&1
::  Ubuntu 26.04 LTS Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_26_Desktop_Hostname% >nul 2>&1
::  Ubuntu 26.04 LTS Server
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
::
::
@cls
@echo. 
@echo ----------------------------------------------------
@echo Waarden parameters
@echo Parameter 1 %1
@echo Parameter 2 %2
@echo Parameter 3 %3
@echo Parameter 4 %4
@echo Parameter 5 %5
@echo Parameter 6 %6
@echo.
@echo Installatie pad vmware %VMWareInstallPath%
@echo ----------------------------------------------------
@echo.
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
@echo [Template] Verwijderen VMEM
if exist "%1\*.vmem" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen VMSD
if exist "%1\*.vmsd" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen VMSN
if exist "%1\*.vmsn" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen VMX
if exist "%1\*.vmx" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen VMXF
if exist "%1\*.vmxf" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen VMDK
if exist "%1\*.vmdk" (
    @del /F /S %1\*.vm*
)
::
@echo [Template] Verwijderen NVRAM
if exist "%1\*.nvram" (
    @del /F /S %1\*.nvram
)
::
@echo [Template] Verwijderen Scoreboard
if exist "%1\*.scoreboard" (
    @del /F /S %1\*.scoreboard
)
::
@echo [Template] Verwijderen Log
if exist "%1\*.log" (
    @del /F /S %1\*.log
)
::
::  @echo [Template] Verwijderen subdirectories
::  @for /d %%d in ("%1\*") do rd /s "%%d"
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
@echo [VirtualMachine] Verwijderen VM*
if exist "%3\*.vm*" (
    @del /F %3\*.vm*
)
@echo [VirtualMachine] Verwijderen NVRAM
if exist "%3\*.nvram" (
    @del /F %3\*.nvram
)
@echo [VirtualMachine] Verwijderen Scoreboard
if exist "%3\*.scoreboard" (
    @del /F %3\*.scoreboard
)
@echo [VirtualMachine] Verwijderen Log
if exist "%3\*.log" (
    @del /F %3\*.log 
)
@echo [VirtualMachine] Verwijderen subdirectories
@for /d %%d in ("%3\*") do rd /s "%%d"
::
::
@echo Einde Opruimen 
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Einde Opruimen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@cls
@echo Template %2
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Downloaden template als 7z bestand vanaf Linux VM Images website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Controleer aanwezigheid %2 template
::
@IF NOT EXIST "%1\%2.7z" (
    @echo Downloaden %2 template Gestart ...
    @curl -s -L -o %1\%2.7z %5
)
::
@echo Uitpakken %2 template
::
@IF EXIST "%1\%2.7z" (
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %1\%2.7z -o%3 -y >nul 2>&1
)
::
::
@cls
@echo Virtuele Machine %3
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::
@echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 
::
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
    )
)
::
::
::  Verwijderen eventuele aanwezige subdirectories uit vorige stap
::  @for /d %%d in ("%3\*") do rd /s /q "%%d" >nul 2>&1
@for /d %%d in ("%3\*") do rd /s "%%d"
::
::
@echo Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%3\%2.vmx" (
    @echo [VMX] Hernoem %2 naar %4
    @rename "%3\%2.vmx" %4.vmx >nul 2>&1
)
::
@echo Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%3\%2.vmdk" (
    @echo [VMDK] Hernoem %2 naar %4
    @rename "%3\%2.vmdk" %4.vmdk >nul 2>&1
)
::

::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Configuratie virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [VMX] Header toevoegen
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
@rename %3\%4.vmx %4.org >nul 2>&1
@rename %3\%4-new.vmx %4.vmx >nul 2>&1
@del %3\%4.org >nul 2>&1
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
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
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
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
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
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetVirtualDevice ethernet0 vmxnet
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetConnectionType ethernet0 nat
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetLinkStatePropagation ethernet0 true
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetPresent ethernet0 1
::
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.vnet "VMnet8"
::  @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.displayName "VMnet8"
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
::
@echo Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  ::::::::::::::::
::  Time Sync
::  ::::::::::::::::
::
::
@echo Synchronisatie tijd tussen host en virtuele machine aanzetten
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::
::
::  ::::::::::::::::::::
::  Serial 0 ThinPrint uitzetten in Debian 12
::  ::::::::::::::::::::
::
::
@echo ThinPrint virtual Printer verwijderen 
echo %2 | findstr /c:"12" >nul
if %errorlevel% equ 0 (
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry serial0.present "FALSE"

)
::
::
::  ::::::::::::::::::::
::  TutSOFT Appliance Author 
::  ::::::::::::::::::::
::
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams applianceView.coverPage.author "TutSOFT"
::
::
::  ::::::::::::::::::::
::  Power Management Virtuele Machine in VMWare Workstation Pro aanpassen
::  ::::::::::::::::::::
::
::
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.powerOff = "hard"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.powerOn = "hard"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.suspend = "soft"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.reset = "soft"
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::
::
@echo Openen %4
@IF EXIST %3\%4.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %3\%4.vmx
)
::
::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
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
@echo 1 minuut wachten totdat virtuele machine geheel is opgestart ... 
@powershell -command "Start-Sleep -Seconds 60"
::
::
@echo [Linux] tijdzone aanpassen in virtuele machine %4
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
::
::
@echo [Linux] APT Bijwerken in virtuele machine %4
@"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
::
::
@echo [Linux] Tools installeren in virtuele machine %4
@"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  DEBIAN
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
echo %6 | findstr /c:"debian" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Debian 12 Desktop Linux
    @REM  VM configuratie Debian 12 Server Linux
    @REM  VM configuratie Debian 13 Desktop Linux
    @REM  VM configuratie Debian 13 Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM  Voor deze stap wordt curl gebruikt
    @REM
    @REM
    @echo [Debian] Bash voorkeuren downloaden in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
    @REM
    @REM
)
::
::
::  Debian 12
::
::
echo %2 | findstr /c:"12" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Debian 12 Desktop Linux
    @REM  VM configuratie Debian 12 Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @REM
    @REM
    @REM
    @echo [Debian 12] APT Repository aanpassen in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\deb https://mirror.nl.mirhosting.net/debian/ bookworm main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3c\deb-src https://mirror.nl.mirhosting.net/debian/ bookworm main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "10c\deb https://mirror.nl.mirhosting.net/debian/ bookworm-updates main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "11c\deb-src https://mirror.nl.mirhosting.net/debian/ bookworm-updates main non-free non-free-firmware" /etc/apt/sources.list
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo [Debian 12] APT Update uitvoeren in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    echo %2 | findstr /c:"Desktop" >nul
    if %errorlevel% equ 0 (
        @REM
        @REM DESKTOP
        @REM
        @echo [Debian 12 Desktop] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D12-BKW-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 12 Desktop] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian12$/D12-BKW-D-LAB-001/" /etc/hostname
    ) else (
        @REM
        @REM SERVER
        @REM
        @echo [Debian 12 Server] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D12-BKW-S-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 12 Server] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian12$/D12-BKW-S-LAB-001/" /etc/hostname
    )
    @REM
)
::
::
::  Debian 13
::
::
echo %2 | findstr /c:"13" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Debian 13 Desktop Linux
    @REM  VM configuratie Debian 13 Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @REM
    @REM
    @REM
    @echo [Debian 13] APT Repository aanpassen in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "9c\deb https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "10c\deb-src https://mirror.nl.mirhosting.net/debian/ trixie-updates main non-free non-free-firmware" /etc/apt/sources.list
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo [Debian 13] APT Update uitvoeren in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    echo %2 | findstr /c:"Desktop" >nul
    if %errorlevel% equ 0 (
        @REM
        @REM DESKTOP
        @REM
        @echo [Debian 13 Desktop] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D13-TRX-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 13 Desktop] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian13$/D13-TRX-D-LAB-001/" /etc/hostname
    ) else (
        @REM
        @REM    Server
        @REM
        @echo [Debian 13 Server] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D13-TRX-S-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 13 Server] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian13$/D13-TRX-S-LAB-001/" /etc/hostname
    )
    @REM
)
::
::
::  Debian
::
::
echo %6 | findstr /c:"debian" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Debian 12 Desktop Linux
    @REM  VM configuratie Debian 12 Server Linux
    @REM  VM configuratie Debian 13 Desktop Linux
    @REM  VM configuratie Debian 13 Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
    @REM
    @echo Uitvoerbaar maken van LUCT binnen virtuele machine
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
    @REM
)
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  UBUNTU
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
echo %6 | findstr /c:"ubuntu" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Ubuntu 24.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 24.04 LTS Server Linux
    @REM  VM configuratie Ubuntu 26.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 26.04 LTS Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @REM  Voor deze stap wordt curl gebruikt
    @REM
    @echo Linux Bash voorkeuren downloaden ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
    @REM
    @REM
)
::
::
::  Ubntu 24.04 LTS
::
::
echo %2 | findstr /c:"24" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Ubuntu 24.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 24.04 LTS Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @echo Aanpassen APT Repository in virtuele machine
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo APT Update uitvoeren in virtuele machine ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    echo %2 | findstr /c:"Desktop" >nul
    if %errorlevel% equ 0 (
        @REM
        @REM    DESKTOP
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-NNT-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-NNT-D-LAB-001/" /etc/hostname
    ) else (
        @REM
        @REM    SERVER
        @REM
        @echo [Ubuntu 24.04 LTS Server] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-NNT-S-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
        @REM
        @echo [Ubuntu 24.04 LTS Server] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-NNT-S-LAB-001/" /etc/hostname
    )
    @REM
)
::
::
::  Ubntu 24.04 LTS
::
::
echo %2 | findstr /c:"24" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Ubuntu 24.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 24.04 LTS Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @echo Aanpassen APT Repository in virtuele machine
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo APT Update uitvoeren in virtuele machine ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    echo %2 | findstr /c:"Desktop" >nul
    if %errorlevel% equ 0 (
        @REM
        @REM    DESKTOP
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-NNT-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-NNT-D-LAB-001/" /etc/hostname
    ) else (
        @REM
        @REM    SERVER
        @REM
        @echo [Ubuntu 24.04 LTS Server] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-NNT-S-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
        @REM
        @echo [Ubuntu 24.04 LTS Server] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-NNT-S-LAB-001/" /etc/hostname
    )
    @REM
)
::
::
::  Ubntu 26.04 LTS
::
::
echo %2 | findstr /c:"26" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Ubuntu 26.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 26.04 LTS Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @echo Aanpassen APT Repository in virtuele machine
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo APT Update uitvoeren in virtuele machine ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    echo %2 | findstr /c:"Desktop" >nul
    if %errorlevel% equ 0 (
        @REM
        @REM    DESKTOP
        @REM
        @echo [Ubuntu 26.04 LTS Desktop] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U26-RRN-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2604/ubuntu2604.linuxvmimages.com ubuntu2604/" /etc/hosts
        @REM
        @echo [Ubuntu 26.04 LTS Desktop] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2604$/U26-RRN-D-LAB-001/" /etc/hostname
    ) else (
        @REM
        @REM    SERVER
        @REM
        @echo [Ubuntu 26.04 LTS Server] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U26-RNN-S-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/ubuntu2604/ubuntu2604.linuxvmimages.com ubuntu2604/" /etc/hosts
        @REM
        @echo [Ubuntu 26.04 LTS Server] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2604$/U26-RRN-S-LAB-001/" /etc/hostname
    )
    @REM
)
::
::
::  Ubuntu
::
::
echo %6 | findstr /c:"ubuntu" >nul
if %errorlevel% equ 0 (
    @REM
    @REM
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM  VM configuratie Ubuntu 24.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 24.04 LTS Server Linux
    @REM  VM configuratie Ubuntu 26.04 LTS Desktop Linux
    @REM  VM configuratie Ubuntu 26.04 LTS Server Linux
    @REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
    @REM
    @REM
    @REM  LET OP
    @REM  In Linux moet bij SED commando een enkele aanhaakteken staan
    @REM  Bij VMRUN moet een dubbele aanhaaktekens staan in plaats van een enkel aanhaakteken
    @REM
    @REM
    @echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
    @REM
    @echo Uitvoerbaar maken van LUCT binnen virtuele machine
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
    @REM
    @REM
)
::

@REM
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet
@REM


goto :eof

::
::  Thats all folks
::