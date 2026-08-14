@echo off
@REM
@REM
@REM
@REM
@REM   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM     TT    U    U    TT    SS      O    O  FF        TT
@REM     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM     TT    U    U    TT        SS  O    O  FF        TT
@REM     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM
@REM
@REM
@REM  Changelog
@REM  Build 6 Debian 13 Desktop
@REM  Build 7 Debian 13 Server en OpenMediaVault
@REM  Build 8 Ubuntu 24.04 Desktop
@REM  Build 9 Linux commando rmrun bugfixes en schermheader als functie
@REM  Build 10 Debian 12 Desktop en Debian 13 Desktop aangepast
@REM
@REM  Build 12 Debian 13 Server nieuwe volgorde Linux commando's
@REM
@REM  Build 15 Centrale functie voor aanmaken virtuele machine
@REM  Build 15 Update 1 Functie aanpassingen nav verwijderen alle directories door build 15
@REM  Build 15 Update 2 Functie Debian en Ubuntu
@REM  Build 20    Testmodus
@REM  Build 21    Virtualization-Home
@REM
@REM
@REM
@REM
@REM  Ultimate Linux VM Manager (ULVMM)
@REM
@REM
@REM
@REM
@Set "ULVMMBuild=21"
@Set "ULVMMUpdate=0"
@Set "ULVMMChannel=Canary"
@REM
@REM
@REM
@REM
@REM  Copyright (c) 2026 John Tutert
@REM  Permission is hereby granted, free of charge, to any person obtaining a copy
@REM  of this software, to use, copy, modify, and distribute it for personal,
@REM  educational, or open-source purposes, provided this notice remains intact.
@REM  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
@REM
@REM
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Rechten Check
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
    @ECHO Script NIET gestart met Adminstrator permissies / Script not started with Adminitrator premissions ! 
    @PAUSE
    @EXIT 1
)
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Gebruikersinstellingen script
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@cls
@REM
@call :f_Toon_ULVMM_Header
@echo.
@REM
@echo Script gebruikersinstellingen uitlezen ...
@REM
@REM  Virtuele machines
@REM
@REM  Standaard lokatie van de VMWare Workstation Pro virtuele machines op de eigen PC en/of Laptop
@set "VWSP_VM_Default_Location=D:\Virtualization-HomeVirtual-Machines\VMware-Workstation-PRO"
@REM
@REM  Naam van de directory met Linux virtuele machines               default is Linux
@set "VWSP_VM_Linux_DirName=Linux"
@REM  Naam van de directory met Debian Linux virtuele machines        default is Debian
@set "VWSP_VM_Linux_Debian_DirName=Debian"
@REM  Naam van de directory met Ubuntu Linux virtuele machines        default is Ubuntu
@set "VWSP_VM_Linux_Ubuntu_DirName=Ubuntu"
@REM  Naam van de directory met Debian Desktop virtuele machines      default is desktop
@set "VWSP_VM_Linux_Debian_Desktop_DirName=Desktop"
@REM  Naam van de directory met Desktop Server virtuele machines      default is server 
@set "VWSP_VM_Linux_Debian_Server_DirName=Server"
@REM  Naam van de directory met Ubuntu Desktop virtuele machines      default is desktop
@set "VWSP_VM_Linux_Ubuntu_Desktop_DirName=Desktop"
@REM  Naam van de directory met Ubuntu Server virtuele machines       default is server
@set "VWSP_VM_Linux_Ubuntu_Server_DirName=Server"
@REM  Naam van de directory met Windows virtuele machines             default is Windows
@set "VWSP_VM_Windows_DirName=Windows"
@REM
@REM  Namen Debian 12 Virtuele machines
@set "Linux_Debian_12_Desktop_Hostname=D12-BKW-D-LAB-001"
@set "Linux_Debian_12_Server_Hostname=D12-BKW-S-LAB-001"
@REM  Namen Debian 13 Virtuele machines
@set "Linux_Debian_13_Desktop_Hostname=D13-TRX-D-LAB-001"
@set "Linux_Debian_13_Server_Hostname=D13-TRX-S-LAB-001"
@REM  Namen Ubuntu 24.04 virtuele machines
@set "Linux_Ubuntu_24_Desktop_Hostname=U24-NNT-D-LAB-001"
@set "Linux_Ubuntu_24_Server_Hostname=U24-NNT-S-LAB-001"
@set "Linux_Ubuntu_24_Docker_Hostname=U24-NNT-S-DKR-001"
@REM  Namen Ubuntu 26.04 virtuele machines
@set "Linux_Ubuntu_26_Desktop_Hostname=U26-RRN-D-LAB-001"
@set "Linux_Ubuntu_26_Server_Hostname=U26-RRN-S-LAB-001"
@set "Linux_Ubuntu_26_Docker_Hostname=U26-RRN-S-DKR-001"
@REM
@REM  Templates
@REM
@REM  Standaard lokatie van templates (sjablonen) voor virtuele machines op de eigen PC en/of Laptop
@set "Templates_Default_Location=D:\Virtualization-Home\Virtual-Machines\Templates"
@REM
@REM  Naam van de directory met Linux tempates        default is Linux
@set "Templates_Linux_DirName=Linux"
@REM  Naam de directory met Debian templates          default is debian
@set "Templates_Linux_Debian_DirName=Debian"
@REM  Naam van de directory met Ubuntu templates      default is ubuntu
@set "Templates_Linux_Ubuntu_DirName=Ubuntu"
@REM  Naam van de directory met Desktop templates     default is Regular
@set "Templates_Linux_Desktop_DirName=Regular"
@REM  Naam van de directory met Server templates      default is Minimal
@set "Templates_Linux_Server_DirName=Minimal"
@REM
@REM  ISO Bestanden
@REM
@set "ISO_Default_Location=D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen"
@set "ISO_Linux_Debian12_Desktop=naambestand.iso"
@set "ISO_Linux_Debian12_Server=naambestand.iso"
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Declaratie Variabelen Internet
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@REM  Linux Virtual Images Debian 12 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIDebian12D=Debian_12.0.0_VMG_LinuxVMImages.COM"
@set "LVIDebian12S=Debian_12.0.0_VMM_LinuxVMImages.COM"
@REM  Linux Virtual Images Debian 13 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIDebian13D=Debian_13_VMG_LinuxVMImages.COM"
@set "LVIDebian13S=Debian_13_VMM_LinuxVMImages.COM"
@REM  Linux Virtual Images Ubuntu 24.04 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIUbuntu24D=Ubuntu_24.04_VM_LinuxVMImages.COM"
@set "LVIUbuntu24S=UbuntuServer_24.04_VM_LinuxVMImages.COM"
@REM  Linux Virtual Images Ubuntu 26.04 bestandsnaam // D = Desktop // S = Server (minimal)
@set "LVIUbuntu26D=Ubuntu_26.04_VM_LinuxVMImages.COM"
@REM  @set "LVIUbuntu26S=" Niet beschikbaar
@REM
@REM  Linux Virtual Images Debian 12 download URL
@set "Debian12DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/D/12/Debian_12.0.0_VMG.7z"
@set "Debian12ServerUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/D/12/Debian_12.0.0_VMM.7z"
@REM  Linux Virtual Images Debian 13 download URL
@set "Debian13DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/D/13/Debian_13_VMG.7z"
@set "Debian13ServerUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/D/13/Debian_13_VMM.7z"
@REM  Linux Virtual Images Ubuntu 24 download URL
@set "Ubuntu24DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/24.04/Ubuntu_24.04_VM.7z"
@set "Ubuntu24ServerUrl= https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/24.04/UbuntuServer_24.04_VM.7z"
@REM  Linux Virtual Images Ubuntu 26 download URL
@set "Ubuntu26DesktopUrl=https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:vmware/U/26.04/Ubuntu_26.04_VM.7z"
@REM  @set "Ubuntu26ServerUrl= ...."  Niet beschikbaar
@REM
@REM  Debian 12 ISO download URL
@set "Debian12DesktopISOUrl=https://edu.nl/r7qkg"
@set "Debian12ServerISOURL=https://edu.nl/r7qkg"
@REM  Debian 13 ISO download URL
@set "Debian13DesktopISOUrl=x"
@set "Debian13ServerISOURL=x"
@REM  Ubuntu 24.04 ISO download URL
@set "Ubuntu24DesktopISOURL=https://edu.nl/avfqr"
@set "Ubuntu24ServerISOURL=x"
@REM  Ubuntu 26.04 ISO download URL
@set "Ubuntu24DesktopISOURL=x"
@set "Ubuntu24ServerISOURL=x"
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Declaratie Variabelen Script Automatisch
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM  Samengestelde variabelen aanmaken
@REM
@REM  Virtuele Machines
@REM
@set "Debian12DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_12_Desktop_Hostname%"
@set "Debian12ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_12_Server_Hostname%"
@REM
@set "Debian13DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_13_Desktop_Hostname%"
@set "Debian13ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_13_Server_Hostname%"
@REM
@set "Ubuntu24DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_24_Desktop_Hostname%"
@set "Ubuntu24ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Server_Hostname%"
@REM
@set "Ubuntu26DesktopVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_26_Desktop_Hostname%"
@set "Ubuntu26ServerVM=%VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Server_Hostname%"
@REM
@REM  Templates
@REM
@set "Debian12Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12\%Templates_Linux_Desktop_DirName%
@set "Debian12Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12\%Templates_Linux_Server_DirName%
@REM
@set "Debian13Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13\%Templates_Linux_Desktop_DirName%
@set "Debian13Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13\%Templates_Linux_Server_DirName%
@REM
@set "Ubuntu24Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404\%Templates_Linux_Desktop_DirName%
@set "Ubuntu24Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404\%Templates_Linux_Server_DirName%
@REM
@set "Ubuntu26Desktop_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Desktop_DirName%
@set "Ubuntu26Server_Template_Location=%Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604\%Templates_Linux_Server_DirName%
@REM
@echo Declaratie variabelen op basis van omgeving
@REM
@REM  Bepaal het totaal aanwezige RAM
@for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    @set Host_RAM_Total_GB=%%i
)
@REM
@set /a Host_RAM_Quarter_MB=%Host_RAM_Total_GB% * 1024 / 4
@REM
@REM  Controleer aanwezigheid van VMWare Workstation Pro
@REM
@reg query "HKLM\SOFTWARE\VMware, Inc.\VMware Workstation" >nul 2>&1
@REM
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
@REM
@REM  Bepaald locatie VMware Workstation Pro
@REM
@for /F "tokens=2,*" %%a in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
@REM
@REM
@REM  ::::::::::::::::::::::::::::::::::::::::::
@REM  defaultVMPath ophalen VMware Workstation
@REM  ::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@REM  Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
@REM
@REM  prefvmx.defaultVMPath = "D:\Virtual-Machines\VMware-Workstation-PRO"
@REM
@REM
@SET "prefFile=%AppData%\VMware\preferences.ini"
@FOR /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    SET "VWSP_VM_Default_Location_Setting_Met_Haakjes=%%B"
)
@REM
@REM
@REM  prefvmx.defaultVMPath = "D:\Virtual-Machines\VMware-Workstation-PRO"
@REM
@REM Verwijder aanhalingstekens uit prefvmx.defaultVMPath
@REM
@REM
@SET "VWSP_VM_Default_Location_Setting_Zonder_Haakjes=%VWSP_VM_Default_Location_Setting_Met_Haakjes:"=%"
@REM
@REM
@echo %VWSP_VM_Default_Location_Setting_Zonder_Haakjes% | findstr /I "%VWSP_VM_Default_Location%" >nul 2>&1
@if %errorlevel% equ 0 (
    @REM
    @echo De geconfigureerde directory voor Virtuele machines in VMware Workstation Pro is gelijk aan voorkeur in dit script
) else (
    @REM
    @echo De geconfigureerde directory voor Virtuele machines in VMware Workstation Pro is NIET gelijk aan voorkeur in dit script
    @pause
)
@REM
@REM
@REM
@REM  ::::::::::::::::::::::::::::::::
@REM  SSH Hosts bestand backup maken
@REM  ::::::::::::::::::::::::::::::::
@REM
@REM
@if exist %userprofile%\.ssh\known_hosts (
    @for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set current_date_time=%%i
    @ren %userprofile%\.ssh\known_hosts known_hosts_%current_date_time%.bck
)
@REM
@REM
@set "ulvmmtestmodus=UIT"
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Hoofdmenu
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:hoofdmenu
@REM
@REM
@cls
@REM
@call :f_Toon_ULVMM_Header
@echo.
@echo Hoofdmenu
@echo.
@echo [1] Debian virtual machines (Linux Virtual Images)
@echo [2] Ubuntu virtual machines (Linux Virtual Images)
@echo [3] x
@echo [4] Alle Templates downloaden [niet aanwezig]
@echo [5] x
@echo [6] x
@echo [7] x
@echo [8] Testmodus aanzetten (meer meldingen tonen)
@echo. 
@echo [9] Verlaten/Exit ULVMM
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
@REM
@if %antwoord%==9 goto :einde
@if %antwoord%==8 goto :ulvmmtestmodus
@if %antwoord%==7 goto :hoofdmenu
@if %antwoord%==6 goto :hoofdmenu
@if %antwoord%==5 goto :hoofdmenu
@if %antwoord%==4 goto :hoofdmenu
@if %antwoord%==3 goto :hoofdmenu
@if %antwoord%==2 goto :ubuntusubmenu
@if %antwoord%==1 goto :debiansubmenu
@goto :hoofdmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    TestModus aanzetten
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ulvmmtestmodus
@REM
@REM
@set "ulvmmtestmodus=AAN"
@REM
@REM
goto :hoofdmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian Submenu
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:debiansubmenu
@REM
@cls
@REM
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
@REM
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
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian 12 Desktop VM
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:debian12desktop
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 12 Desktop (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Debian12Desktop_Template_Location% 
@REM  [2] %LVIDebian12D% 
@REM  [3] %Debian12DesktopVM% 
@REM  [4] %Linux_Debian_12_Desktop_Hostname% 
@REM  [5] %Debian12DesktopUrl%
@REM  [6] debian (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine %Debian12Desktop_Template_Location% %LVIDebian12D% %Debian12DesktopVM% %Linux_Debian_12_Desktop_Hostname% %Debian12DesktopUrl% debian
@REM
@REM
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12DesktopVM%\%Linux_Debian_12_Desktop_Hostname%.vmx') do set vmipadres=%%A
@REM
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Debian 12 Desktop einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto debiansubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian 12 Server VM
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:debian12server
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 12 Server (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Debian12Server_Template_Location% 
@REM  [2] %LVIDebian12S% 
@REM  [3] %Debian12ServerVM% 
@REM  [4] %Linux_Debian_12_Server_Hostname% 
@REM  [5] %Debian12ServerUrl%
@REM  [6] debian (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine %Debian12Server_Template_Location% %LVIDebian12S% %Debian12ServerVM% %Linux_Debian_12_Server_Hostname% %Debian12ServerUrl% debian
@REM
@REM
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12ServerVM%\%Linux_Debian_12_Server_Hostname%.vmx') do set vmipadres=%%A
@REM
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Debian 12 Server einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto debiansubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian 13 Desktop VM
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:debian13desktop
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Desktop (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Debian13Desktop_Template_Location% 
@REM  [2] %LVIDebian13D% 
@REM  [3] %Debian13DesktopVM% 
@REM  [4] %Linux_Debian_13_Desktop_Hostname% 
@REM  [5] %Debian13DesktopUrl%
@REM  [6] debian (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine %Debian13Desktop_Template_Location% %LVIDebian13D% %Debian13DesktopVM% %Linux_Debian_13_Desktop_Hostname% %Debian13DesktopUrl% debian
@REM
@REM
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun.exe -T ws -gu debian -gp debian getGuestIPAddress %Debian13DesktopVM%\%Linux_Debian_13_Desktop_Hostname%.vmx') do set vmipadres=%%A
@REM
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Debian 13 Desktop einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto debiansubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian 13 Server VM 
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:debian13server
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Debian 13 Server (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Debian13Server_Template_Location% 
@REM  [2] %LVIDebian13S% 
@REM  [3] %Debian13ServerVM% 
@REM  [4] %Linux_Debian_13_Server_Hostname% 
@REM  [5] %Debian13ServerUrl%
@REM  [6] debian (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine ^
%Debian13Server_Template_Location% ^
%LVIDebian13S% ^
%Debian13ServerVM% ^
%Linux_Debian_13_Server_Hostname% ^
%Debian13ServerUrl% ^
debian
@REM
@REM
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx') do set vmipadres=%%A
@REM
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 debian@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Debian 13 Server einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto debiansubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Debian 13 Server Open Media Vault
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:openmediavault
@REM
@REM
@echo Open Media Vault versie 8 installeren ...
@echo.
@echo Standaard gebruiker       admin
@echo Standaard wachtwoord      openmediavault
@REM
@REM
@echo OMV Installatie Script downloaden
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" curl -s -o /home/debian/omv_install.sh https://raw.githubusercontent.com/openmediavault/openmediavault/master/install.sh
@REM
@REM
@echo OMV Script uitvoerbaar maken 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" chmod +x /home/debian/omv_install.sh
@REM
@REM
@echo OMV Script starten om OMV te installeren binnen virtuele machine ... 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" /home/debian/omv_install.sh
@REM
@REM
@echo Vewijderen Sources.list bestand in virtuele machine 
@echo Anders werkt updaten niet meer ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" rm /etc/apt/sources.list
@REM
@REM
@echo OMV Toevoegen Debian gebruiker aan groepen 
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-admin debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-config debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-engined debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-notify debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG openmediavault-webgui debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG _ssh debian
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" usermod -aG root debian
@REM
@REM
@echo.
@echo Vanaf nu is inloggen met user debian en wachtwoord debian mogelijk op Open Media Vault
@echo.
@echo Nu wordt HERSTART gedaan van virtuele machine ...
@echo.
@echo   LET OP ! Het duurt even voordat de webinterface beschikbaar is ...
@echo   Je hoort twee (zachte) piepjes als webinterface beschikbaar is. 
@echo.
@REM
@REM  @REM  Upgrade OMV
@REM  @echo OMV upgraden naar de nieuwste versie ...
@REM  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" omv-upgrade
@REM
@REM
@pause
@REM
@REM
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Linux_Debian_13_Server_Hostname%.vmx "/bin/sudo" shutdown -r now
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Debia 13 Server Open Media Vault Einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto debiansubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Ubuntu Submenu
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ubuntusubmenu
@REM
@CLS
@REM
@call :f_Toon_ULVMM_Header
@echo.
@echo UBUNTU
@echo.
@REM
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
@REM echo Maak uw keuze 
@REM
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
@REM
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
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Ubuntu 2404 Desktop
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ubuntu2404deskop 
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Desktop (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Ubuntu24Desktop_Template_Location% 
@REM  [2] %LVIUbuntu24D% 
@REM  [3] %Ubuntu24DesktopVM% 
@REM  [4] %Linux_Ubuntu_24_Desktop_Hostname% 
@REM  [5] %Ubuntu24DesktopUrl%
@REM  [6] ubuntu (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine ^
%Ubuntu24Desktop_Template_Location% ^
%LVIUbuntu24D% ^
%Ubuntu24DesktopVM% ^
%Linux_Ubuntu_24_Desktop_Hostname% ^
%Ubuntu24DesktopUrl% ^
ubuntu
@REM
@REM

@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu24DesktopVM%\%Linux_Ubuntu_24_Desktop_Hostname%.vmx') do set vmipadres=%%A
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Ubuntu 24 Desktop einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
goto :ubuntusubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Ubuntu 2404 Server
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ubuntu2404server
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 24.04 LTS Server (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Ubuntu24Server_Template_Location% 
@REM  [2] %LVIUbuntu24S% 
@REM  [3] %Ubuntu24ServerVM% 
@REM  [4] %Linux_Ubuntu_24_Server_Hostname% 
@REM  [5] %Ubuntu24ServerUrl%
@REM  [6] ubuntu (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine ^
%Ubuntu24Server_Template_Location% ^
%LVIUbuntu24S% ^
%Ubuntu24ServerVM% ^
%Linux_Ubuntu_24_Server_Hostname% ^
%Ubuntu24ServerUrl% ^
ubuntu
@REM
@REM
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubntu -gp ubuntu getGuestIPAddress %Ubuntu24ServerVM%\%Linux_Ubuntu_24_Server_Hostname%.vmx') do set vmipadres=%%A
@REM
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Ubuntu 24.04 LTS Server einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
goto :ubuntusubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Ubuntu 26.04 LTS Desktop
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ubuntu2604deskop 
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 26.04 LTS Desktop (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Ubuntu26Desktop_Template_Location% 
@REM  [2] %LVIUbuntu26D% 
@REM  [3] %Ubuntu26DesktopVM% 
@REM  [4] %Linux_Ubuntu_26_Desktop_Hostname% 
@REM  [5] %Ubuntu26DesktopUrl%
@REM  [6] ubuntu (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine %Ubuntu26Desktop_Template_Location% %LVIUbunu26D% %Ubuntu26DesktopVM% %Linux_Ubuntu_26_Desktop_Hostname% %Ubuntu26DesktopUrl% ubuntu
@REM
@REM

@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu26DesktopVM%\%Linux_Ubuntu_26_Desktop_Hostname%.vmx') do set vmipadres=%%A
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Ubuntu 26 Desktop einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
goto :ubuntusubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Ubuntu 26.04 LTS Server
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:ubuntu2604server
@REM
@REM
@cls
@call :f_Toon_ULVMM_Header
@echo.
@echo Ubuntu 26.04 LTS Server (Linux Virtual Images) Virtual Machine
@REM
@REM
@REM  De volgende parameters gaan naar de functie:
@REM  [1] %Ubuntu26Server_Template_Location% 
@REM  [2] %LVIUbuntu26S% 
@REM  [3] %Ubuntu26ServerVM% 
@REM  [4] %Linux_Ubuntu_26_Server_Hostname% 
@REM  [5] %Ubuntu26ServerUrl%
@REM  [6] ubuntu (gebruikersnaam virtuele machine)
@REM
@REM
call :f_maak_virtuele_machine %Ubuntu26Server_Template_Location% %LVIUbunu26S% %Ubuntu26ServerVM% %Linux_Ubuntu_26_Server_Hostname% %Ubuntu26ServerUrl% ubuntu
@REM
@REM

@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu26DesktopVM%\%Linux_Ubuntu_26_Desktop_Hostname%.vmx') do set vmipadres=%%A
@REM
@echo SSH Sessie virtuele machine starten
@wt ssh -p 22 ubuntu@%vmipadres%
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Ubuntu 26 Server einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
goto :ubuntusubmenu
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    LVI Ubuntu Website
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:lviubuntuwebsite
@REM
@REM

start chrome https://www.linuxvmimages.com/images/vmware/

@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  LVI Ubuntu Website einde
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
goto :ubuntusubmenu
@REM
@REM
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    E I N D E    S C R I P T
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@REM
@REM
:einde
@cls
@call :f_Toon_ULVMM_Header
@REM
@echo.
@echo Einde Script
@echo.
@echo Variabele waarden zijn nog gewoon geladen !
@echo.
@exit /b 0
@REM
@REM
@REM
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::@REM    Functies
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
:f_Toon_ULVMM_Header
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo :::@REM Ultimate Linux Virtual Machine Manager                           
@echo :::@REM Build %ULVMMBuild% Patch %ULVMMUpdate% CHANNEL %ULVMMChannel%
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@goto :eof
@REM
@REM
:f_Installeer_Tools
@REM
@REM  Functie voor installatie van tools voor dit script
@REM  Installatie wordt gedaan met Winget
@REM
@REM  Aanroepen functie met call installeertools
@REM
@7z >nul 2>&1
@if %errorlevel% neq 0 (
    @echo NanaZIP niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id M2Team.NanaZip --silent >%TEMP%\WinGet-NanaZip-Installatie.log
)
@REM
@curl -V >nul 2>&1
@if %errorlevel% neq 0 (
    @echo Curl niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id cURL.cURL --silent >%TEMP%\WinGet-cURL-Installatie.log
)
@REM
@pwsh --version >nul 2>&1
@if %errorlevel% neq 0 (
    @echo Powershell 7 niet aangetroffen op deze machine .. Installatie wordt gestart .. 
    @winget install --id Microsoft.PowerShell --silent >%TEMP%\WinGet-pwsh-Installatie.log
)
@REM
@set "app_dir_check=C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1"
@if not exist "%app_dir_check%*" (
    @echo Windows Terminal niet aangetroffen
    @winget install --id Microsoft.WindowsTerminal --silent >%TEMP%\WinGet-WinTerm-Installatie.log
)
@REM
@REM
@goto :eof
@REM
@REM
:f_maak_directory_structuur
@REM
@REM
@REM  Templates
@REM
@REM
@mkdir %Templates_Default_Location% >nul 2>&1
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName% >nul 2>&1
@REM  Debian
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName% >nul 2>&1
@REM  Debian Versie 12
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\12 >nul 2>&1
@mkdir %Debian12Desktop_Template_Location% >nul 2>&1
@mkdir %Debian12Server_Template_Location% >nul 2>&1
@REM  Debian Versie 13
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Debian_DirName%\13 >nul 2>&1
@mkdir %Debian13Desktop_Template_Location% >nul 2>&1
@mkdir %Debian13Server_Template_Location% >nul 2>&1
@REM  Ubuntu
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName% >nul 2>&1
@REM  Ubuntu 24.04 LTS
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2404 >nul 2>&1
@mkdir %Ubuntu24Desktop_Template_Location% >nul 2>&1
@mkdir %Ubuntu24Server_Template_Location% >nul 2>&1
@REM  Ubuntu 26.04 LTS
@mkdir %Templates_Default_Location%\%Templates_Linux_DirName%\%Templates_Linux_Ubuntu_DirName%\2604 >nul 2>&1
@mkdir %Ubuntu26Desktop_Template_Location% >nul 2>&1
@mkdir %Ubuntu26Server_Template_Location% >nul 2>&1
@REM
@REM
@REM  Virtuele machines
@REM
@REM
@mkdir %VWSP_VM_Default_Location% >nul 2>&1
@REM
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName% >nul 2>&1
@REM  Debian
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName% >nul 2>&1
@REM  Debian 12
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12 >nul 2>&1
@REM  Debian 12 Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_12_Desktop_Hostname% >nul 2>&1
@REM  Debian 12 Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\12\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_12_Server_Hostname% >nul 2>&1
@REM  Debian 13
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13 >nul 2>&1
@REM  Debian 13 Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Desktop_DirName%\%Linux_Debian_13_Desktop_Hostname% >nul 2>&1
@REM  Debian 13 Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Debian_DirName%\13\%VWSP_VM_Linux_Debian_Server_DirName%\%Linux_Debian_13_Server_Hostname% >nul 2>&1
@REM  Ubuntu
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName% >nul 2>&1
@REM  Ubuntu 24.04 LTS
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404 >nul 2>&1
@REM  Ubuntu 24.04 LTS Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_24_Desktop_Hostname% >nul 2>&1
@REM  Ubuntu 24.04 LTS Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Server_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2404\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_24_Docker_Hostname% >nul 2>&1
@REM  Ubuntu 26.04 LTS
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604 >nul 2>&1
@REM  Ubuntu 26.04 LTS Desktop
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Desktop_DirName%\%Linux_Ubuntu_26_Desktop_Hostname% >nul 2>&1
@REM  Ubuntu 26.04 LTS Server
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Server_Hostname% >nul 2>&1
@mkdir %VWSP_VM_Default_Location%\%VWSP_VM_Linux_DirName%\%VWSP_VM_Linux_Ubuntu_DirName%\2604\%VWSP_VM_Linux_Ubuntu_Server_DirName%\%Linux_Ubuntu_26_Docker_Hostname% >nul 2>&1
@REM
@REM
@goto :eof
@REM
@REM
:f_maak_virtuele_machine
@REM
@REM
@REM
@cls
@REM
@REM
@REM  =============================== Weergave parameters functie
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo. 
    @echo ----------------------------------------------------
    @echo Waarden parameters
    @echo [1] Template Location %1
    @echo [2] Template Name %2
    @echo [3] VM Location %3
    @echo [4] VM Name %4
    @echo [5] Download URL %5
    @echo [6] VM Username  %6
    @echo.
    @echo Installatie pad vmware %VMWareInstallPath%
    @echo ----------------------------------------------------
    @echo.
    @pause
)
@REM
@REM
@REM  =============================== Weergave parameters functie
@REM
@REM
@echo [Stap 1] Installeer Tools
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Functie Installeer tools
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@call :f_Installeer_Tools
@REM
@REM
@echo [Stap 2] Maak directory structuur
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Functie maak directories
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@call :f_maak_directory_structuur
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  VMware Workstation Pro afsluiten
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@echo [Stap 3] VMWare Workstation Pro afsluiten (indien actief)
@REM
@REM
@REM  Onderzoek of VMWare Workstation Pro actief is
@tasklist /FI "IMAGENAME eq vmware.exe" | findstr "vmware.exe"
@REM
@REM  Bij errorlevel 0 is VMWare Workstation Pro actief en wordt afgesloten
@if %errorlevel% equ 0 (
    @taskkill /IM vmware.exe /F
)
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Start Opruimen
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@echo [Stap 4] Start Opruimen
@REM
@REM
@REM  ::::::::
@REM  Template
@REM  ::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMEM
)
if exist "%1\*.vmem" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMSD
)
if exist "%1\*.vmsd" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMSN
)
if exist "%1\*.vmsn" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMX
)
if exist "%1\*.vmx" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMXF
)
if exist "%1\*.vmxf" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen VMDK
)
if exist "%1\*.vmdk" (
    @del /F /S %1\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen NVRAM
)
if exist "%1\*.nvram" (
    @del /F /S %1\*.nvram
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen Scoreboard
)
if exist "%1\*.scoreboard" (
    @del /F /S %1\*.scoreboard
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Template] Verwijderen Log
)
if exist "%1\*.log" (
    @del /F /S %1\*.log
)
@REM
@REM  @echo [Template] Verwijderen subdirectories
@REM  @for /d %%d in ("%1\*") do rd /s "%%d"
@REM
@REM
@REM  ::::::::
@REM  Virtuele machine
@REM  ::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Stoppen eventueel draaiende virtuele machine 
)
@IF EXIST "%3\%4.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %3\%4.vmx >nul 2>&1
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Verwijderen eventueel aanwezige virtuele machine
)
@IF EXIST "%3\%4.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %3\%4.vmx >nul 2>&1
)
@REM
@REM  Opruimen eventueel aanwezig bestanden in virtuele machine directory
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VirtualMachine] Verwijderen VM*
)
if exist "%3\*.vm*" (
    @del /F %3\*.vm*
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VirtualMachine] Verwijderen NVRAM
)
if exist "%3\*.nvram" (
    @del /F %3\*.nvram
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VirtualMachine] Verwijderen Scoreboard
)
if exist "%3\*.scoreboard" (
    @del /F %3\*.scoreboard
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VirtualMachine] Verwijderen Log
)
if exist "%3\*.log" (
    @del /F %3\*.log 
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VirtualMachine] Verwijderen subdirectories
)
@REM
@REM
@for /d %%d in ("%3\*") do rd /s "%%d"
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Einde Opruimen
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@echo [Stap 5] Maken Template %2
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Downloaden template als 7z bestand vanaf Linux VM Images website
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Controleer aanwezigheid %2 template
)
@IF NOT EXIST "%1\%2.7z" (
    @echo Downloaden %2 template Gestart ...
    if %ulvmmtestmodus% == AAN (
        @curl -L -o %1\%2.7z %5
    ) else (
        @curl -s -L -o %1\%2.7z %5
    )
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Uitpakken %2 template
)
@IF EXIST "%1\%2.7z" (
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    if %ulvmmtestmodus% == AAN (
        @7z x %1\%2.7z -o%3 -y
    ) else (
        @7z x %1\%2.7z -o%3 -y >nul 2>&1
    )
)
@REM
@REM
@echo [Stap 6] Maken Virtuele Machine %4
@REM
@REM  Overzetten bestanden uit eventuele subdirectory naar directory 
@REM  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
@REM
if %ulvmmtestmodus% == AAN (
    @echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 
)
@REM
@REM
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
@REM
@REM
@REM  Verwijderen eventuele aanwezige subdirectories uit vorige stap
@REM  @for /d %%d in ("%3\*") do rd /s /q "%%d" >nul 2>&1
@for /d %%d in ("%3\*") do rd /s "%%d"
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Hernoemen VMX bestand in virtuele machine directory
)
@IF EXIST "%3\%2.vmx" (
    if %ulvmmtestmodus% == AAN (
        @echo [VMX] Hernoem %2 naar %4
    )
    @rename "%3\%2.vmx" %4.vmx >nul 2>&1
)
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Hernoemen VMDK bestand in virtuele machine directory
)
@IF EXIST "%3\%2.vmdk" (
    if %ulvmmtestmodus% == AAN (
        @echo [VMDK] Hernoem %2 naar %4
    )
    @rename "%3\%2.vmdk" %4.vmdk >nul 2>&1
)
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  Configuratie virtuele machine 
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@echo [Stap 7] Configuratie virtuele machine %4
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Header toevoegen
)
@REM
@REM
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
@REM
@REM  Huidige VMX in nieuwe VMX zetten
type %3\%4.vmx >> %3\%4-new.vmx
@REM
@REM
@powershell -command "Start-Sleep -Seconds 2"
@REM
@REM
@rename %3\%4.vmx %4.org >nul 2>&1
@rename %3\%4-new.vmx %4.vmx >nul 2>&1
@del %3\%4.org >nul 2>&1
@REM
@REM
@REM  :::::::::::::::::
@REM  Virtuele machine UUID
@REM  :::::::::::::::::
@REM
@REM  You can configure a virtual machine to always receive a new UUID when it is copied or moved so that you are not prompted when you move or copy the virtual machine.
@REM  Zie https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/26H1/using-vmware-workstation-pro/configuring-and-managing-virtual-machines/moving-virtual-machines/using-the-virtual-machine-uuid/configure-a-virtual-machine-to-always-receive-a-new-uuid.html
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Nieuw UUID aanmaken %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry uuid.action "create"
@REM
@REM
@REM  ::::::::::::::::
@REM  Display Name
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] DisplayName aanpassen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry displayName "%4"
@REM
@REM
@REM  ::::::::::::::::
@REM  Annotation
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Annotation aanpassen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry annotation "Debian: debian/debian Ubuntu: ubuntu/ubuntu"
@REM
@REM
@REM  ::::::::::::::::
@REM  Namen bestanden in VMX
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Namen bestanden aanpassen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry scsi0:0.fileName "%4.vmdk"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry extendedConfigFile "%4.vmxf"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry nvram "%4.nvram"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry vmxstats.filename "%4.scoreboard"
@REM
@REM
@REM  ::::::::::::::::
@REM  CPU
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Processor instellen %4
)
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@REM
@REM
@REM  ::::::::::::::::
@REM  RAM
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] RAM Geheugen instellen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry memsize "%Host_RAM_Quarter_MB%"
@REM
@REM
@REM  ::::::::::::::::
@REM  Storage
@REM  ::::::::::::::::
@REM
@REM
@REM  CD-ROM Drive 
@REM
@REM  Je krijgt SetBackingInfo foutmelding is er geen geldig ISO bestand aanwezig is
@REM  Vanwege ontbreken Debian 13 ISO dit onderdeel uitgezet
@REM
@REM  @echo [VMX] CD-ROM Drive configuratie %4
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Sata SetPresent sata0 1
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent sata0:0 1
@REM
@REM  RAID DISK 0
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] RAID DISK 0 toevoegen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk Create -f %3\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent nvme0:0 1 
@REM
@REM  RAID DISK 1
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] RAID DISK 1 toevoegen %4
)
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk Create -f %3\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Disk SetPresent nvme0:1 1 
@REM
@REM
@REM  ::::::::::::::::
@REM  Netwerk
@REM  ::::::::::::::::
@REM
@REM
@REM
@REM  Ethernet0
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Netwerk configuratie Ethernet0
)
@REM  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetVirtualDevice ethernet0 vmxnet
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetConnectionType ethernet0 nat
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetLinkStatePropagation ethernet0 true
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetPresent ethernet0 1
@REM
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.vnet "VMnet8"
@REM  @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet0.displayName "VMnet8"
@REM
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetAddressType ethernet0 generated ""
@REM
@REM  Ethernet1
@REM
if %ulvmmtestmodus% == AAN (
    @echo [VMX] Netwerk configuratie Ethernet1
)
@REM  Type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetPresent ethernet1 1
@REM 
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@REM
@"%VMWareInstallPath%"\vmcli %3\%4.vmx Ethernet SetAddressType ethernet1 generated ""
@REM
@REM
@REM  ::::::::::::::::
@REM  Hyper-V
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Disable Side Channeld migitations for Hyper-V Enabled Hosts
)
@REM
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
@REM
@REM
@REM  ::::::::::::::::
@REM  Time Sync
@REM  ::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo Synchronisatie tijd tussen host en virtuele machine aanzetten
)
@REM
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry tools.syncTime "TRUE"
@REM
@REM
@REM  ::::::::::::::::::::
@REM  Serial 0 ThinPrint uitzetten in Debian 12
@REM  ::::::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo ThinPrint virtual Printer verwijderen 
)
echo %2 | findstr /c:"12" >nul
if %errorlevel% equ 0 (
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams SetEntry serial0.present "FALSE"

)
@REM
@REM
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  VMX Openen in VMware Workstation Pro
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@REM
@REM
@echo [Stap 8] Openen Virtuele Machine %4
@IF EXIST %3\%4.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %3\%4.vmx
)
@REM
@REM
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  VM starten in VMware Workstation Pro
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@REM
@REM
@echo [Stap 9] Starten Virtuele Machine %4
@IF EXIST %3\%4.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %3\%4.vmx
)
@REM
@echo Ga naar VMWare Workstation Pro
@REM  @echo Klik op "I Copied it" bij virtual machine might have been moved or copied
@echo Klik op "OK" bij Removable Devices melding 
@REM
@REM
@echo [Stap 10] Wachten totdat virtuele machine geheel is opgestart
@REM  @powershell -command "Start-Sleep -Seconds 60"
@powershell -NoProfile -Command "1..60 | ForEach-Object { Write-Progress -Activity '[Stap 10] Wachten totdat virtuele machine geheel is opgestart' -Status \"$_ sec\" -PercentComplete ($_/60*100); Start-Sleep 1 }"
@REM
@REM
@echo [Stap 11] Linux Configuratie %4
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Stap 11A] Tijdzone aanpassen in virtuele machine %4
)
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" timedatectl set-timezone "Europe/Amsterdam"
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Stap 11B] APT Bijwerken in virtuele machine %4
)
@"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo [Stap 11C] Tools installeren in virtuele machine %4
)
@"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
@REM
@REM
@REM  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  DEBIAN
@REM  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
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
    @echo [Debian] Bash Shell voorkeuren downloaden in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
    @REM
    @REM
)
@REM
@REM
@REM  Debian 12
@REM
@REM
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
    if %4 == %Linux_Debian_12_Desktop_Hostname% (
        @REM
        @REM DESKTOP
        @REM
        @echo [Debian 12 Desktop] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D12-BKW-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 12 Desktop] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian12$/D12-BKW-D-LAB-001/" /etc/hostname
    )
    if %4 == %Linux_Debian_12_Server_Hostname% (
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
@REM
@REM
@REM  Debian 13
@REM
@REM
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
    if %4 == %Linux_Debian_13_Desktop_Hostname% (
        @REM
        @REM DESKTOP
        @REM
        @echo [Debian 13 Desktop] Hosts bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       D13-TRX-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
        @REM
        @echo [Debian 13 Desktop] Hostname bestand aanpassen in virtuele machine %4
        @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^debian13$/D13-TRX-D-LAB-001/" /etc/hostname
    )
    if %4 == %Linux_Debian_13_Server_Hostname% (
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
@REM
@REM
@REM  Debian
@REM
@REM
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
@REM
@REM
@REM  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  UBUNTU
@REM  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
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
    @echo [Linux] Bash Shell voorkeuren downloaden in virtuele machine %4
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/ubuntu/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /home/ubuntu/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
    @REM
    @REM
)
@REM
@REM
@REM  Ubntu 24.04 LTS
@REM
@REM
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
    @echo [Ubuntu 24.04 LTS] Aanpassen APT Repository in virtuele machine
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo [Ubuntu 24.04 LTS] APT Update uitvoeren in virtuele machine ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    if %4 == %Linux_Ubuntu_24_Desktop_Hostname% (
        @REM
        @REM    DESKTOP
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Hosts bestand aanpassen in de virtuele machine ...
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-NNT-D-LAB-001" /etc/hosts
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts        
        @REM
        @echo [Ubuntu 24.04 LTS Desktop] Linux Hostname aanpassen in de virtuele machine
        @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-NNT-D-LAB-001/" /etc/hostname
    )
    if %4 == %Linux_Ubuntu_24_Server_Hostname% (
        @REM echo %1 | findstr /c:"Minimal" >nul
        @REM if %errorlevel% equ 0 (
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
@REM
@REM
@REM  Ubntu 26.04 LTS
@REM
@REM
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
    @echo [Ubuntu 26.04 LTS] Aanpassen APT Repository in virtuele machine
    @"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
    @REM
    @REM  Moet worden gedaan omdat APT Repositories zijn aangepast
    @REM
    @echo [Ubuntu 26.04 LTS] APT Update uitvoeren in virtuele machine ...
    @"%VMWareInstallPath%"\vmrun -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" apt update -y
    @REM
    if %4 == %Linux_Ubuntu_26_Desktop_Hostname% (
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
    )
    if %4 == %Linux_Ubuntu_26_Server_Hostname% (
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
@REM
@REM
@REM  Ubuntu
@REM
@REM
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
@REM

@REM
@echo Linux APT stiller maken ...
@"%VMWareInstallPath%"\vmrun.exe -T ws -gu %6 -gp %6 runProgramInGuest %3\%4.vmx "/bin/sudo" curl -L -o /etc/apt/apt.conf.d/99quiet https://raw.githubusercontent.com/jatutert/Ubuntu-Config/refs/heads/main/99quiet
@REM


@REM
@REM
@REM  ::::::::::::::::::::
@REM  Power Management Virtuele Machine in VMWare Workstation Pro aanpassen
@REM  ::::::::::::::::::::
@REM
@REM
if %ulvmmtestmodus% == AAN (
    @echo VMWare Workstation Pro virtuele machine Power Management aanpassen
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.powerOff "hard"
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.powerOn "hard"
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.suspend "soft"
    @"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams powerType.reset "soft"
)


@REM
@REM
@REM  ::::::::::::::::::::
@REM  TutSOFT Appliance Author 
@REM  ::::::::::::::::::::
@REM
@REM
@"%VMWareInstallPath%"\vmcli %3\%4.vmx ConfigParams applianceView.coverPage.author "TutSOFT"

if %ulvmmtestmodus% == AAN (
    echo Einde functie
)


goto :eof

@REM
@REM  Thats all folks
@REM