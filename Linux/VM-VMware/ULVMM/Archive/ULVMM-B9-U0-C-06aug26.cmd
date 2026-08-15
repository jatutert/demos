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
::  To do
::
::  Debian 12 Desktop heeft op het laatst nog niet het juiste linux gedeelte
::  Debian 12 nog draaien en aanpassen ! 
::
::
::
::  Changelog
::  Build 6 Debian 13 Desktop
::  Build 7 Debian 13 Server en OpenMediaVault
::  Build 8 Ubuntu 24.04 Desktop
::  Build 9 Linux commando rmrun bugfixes en schermheader als functie
::
::
::  ::::::::::::::::::::::::::::::: WORK IN PROGRESS :::::::::::::::::::::: CANARY VERSION :::::::::::::::::::::::::::::
::
::
::  Ultimate Linux VM Manager (ULVMM)
::
::
@Set "ULVMMBuild=9"
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
@call :schermheader
@echo.
::
@echo Gebruikersinstellingen script uitlezen / Reading user settings of the script
::
::  Virtuele machines
::
::  Standaard lokatie van de VMWare Workstation Pro virtuele machines op de eigen PC en/of Laptop
@set "VMwWrkVMPath=D:\Virtual-Machines\VMware-Workstation-PRO"
::  Naam van de directory met Linux virtuele machines // default is Linux
@set "VMwWrkLinuxVM=Linux"
::  Naam van de directory met Windows virtuele machines // default is Windows
@set "VMwWrkWindowsVM=Windows"
::  Naam van de directory met Debian Linux virtuele machines // default is Debian
@set "VMwWrkDebianVM=Debian"
::  Naam van de directory met Ubuntu Linux virtuele machines // default is Ubuntu
@set "VMwWrkUbuntuVM=Ubuntu"
::  Naam van de directory met Debian Desktop virtuele machines // default is desktop
@set "VMwWrkDebianVMDName=Desktop"
::  Naam van de directory met Desktop Server virtuele machines // default is server 
@set "VMwWrkDebianVMSName=Server"
::  Naam van de directory met Ubuntu Desktop virtuele machines // default is desktop
@set "VMwWrkUbuntuVMDName=Desktop"
::  Naam van de directory met Ubuntu Server virtuele machines // default is server
@set "VMwWrkUbuntuVMSName=Server"
::  Namen Debian 12 Virtuele machines
@set "Debian12DesktopVMName=D12-BKW-D-LAB-001"
@set "Debian12ServerVMName=D12-BKW-S-LAB-001"
::  Namen Debian 13 Virtuele machines
@set "Debian13DesktopVMName=D13-TRX-D-LAB-001"
@set "Debian13ServerVMName=D13-TRX-S-LAB-001"
::  Namen Ubuntu 24.04 virtuele machines
@set "Ubuntu24DesktopVMName=U24-LTS-D-LAB-001"
@set "Ubuntu24ServerVMName=U24-LTS-S-LAB-001"
@set "Ubuntu24DockerVMName=U24-LTS-S-DKR-001"
::  Namen Ubuntu 26.04 virtuele machines
@set "Ubuntu26DesktopVMName=U26-LTS-D-LAB-001"
@set "Ubuntu26ServerVMName=U26-LTS-S-LAB-001"
@set "Ubuntu26DockerVMName=U26-LTS-S-DKR-001"
::
::  Templates
::
::  Standaard lokatie van templates (sjablonen) voor virtuele machines op de eigen PC en/of Laptop
@set "VMTemplates=D:\Virtual-Machines\Templates"
::  Naam van de directory met Linux tempates // default is Linux
@set "LinuxTemplates=Linux"
::  Naam de directory met Debian templates // default is debian
@set "DebianTemplates=Debian"
::  Naam van de directory met Ubuntu templates // default is ubuntu
@set "UbuntuTemplates=Ubuntu"
::  Naam van de directory met Desktop templates // default is Regular
@set "DesktopTemplates=Regular"
::  Naam van de directory met Server templates // default is Minimal
@set "ServerTemplates=Minimal"
::
::  ISO Bestanden
::
@set "ISOLocation=D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen"
@set "ISODebian12Desktop=naambestand.iso"
@set "ISODebian12Server=naambestand.iso"
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
@set "Debian12DesktopVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%"
@set "Debian12ServerVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMSName%\%Debian12ServerVMName%"
::
@set "Debian13DesktopVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMDName%\%Debian13DesktopVMName%"
@set "Debian13ServerVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMSName%\%Debian13ServerVMName%"
::
@set "Ubuntu24DesktopVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMDName%\%Ubuntu24DesktopVMName%"
@set "Ubuntu24ServerVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMSName%\%Ubuntu24ServerVMName%"
::
@set "Ubuntu26DesktopVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMDName%\%Ubuntu26DesktopVMName%"
@set "Ubuntu26ServerVM=%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMSName%\%Ubuntu26ServerVMName%"
::
@echo Declaratie variabelen op basis van omgeving
::
::  Bepaal het totaal aanwezige RAM
@for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    @set TotalMemoryGB=%%i
)
::
@set /a QuarterMemoryMB=%TotalMemoryGB% * 1024 / 4
::
::  Bepaald locatie VMware Workstation Pro
::
@for /F "tokens=2,*" %%a in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
::
@SET "prefFile=%AppData%\VMware\preferences.ini"
@FOR /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    SET "rawPath=%%B"
)
::
:: Verwijder aanhalingstekens uit prefvmx.defaultVMPath
@SET "vmPath=%rawPath:"=%"
::
::
::  SSH Hosts bestand backup maken
::
@if exist %userprofile%\.ssh\hosts (
    @for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set ts=%%i
    @ren %userprofile%\.ssh\hosts hosts_%ts%.oud
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
@call :schermheader
@echo.
@echo Hoofdmenu/Main Menu [[ Work in Progress // Script contains bugs ! ]]
@echo.
@echo [1] Aanmaken/Create Debian VM
@echo [2] Aanmaken/Create Ubuntu VM
@echo [3] x
@echo [4] x
@echo [5] x
@echo [6] x
@echo [7] x
@echo [8] x
@echo. 
@echo [9] Verlaten/Exit
@echo. 
@choice /C:123456789 /N /M "Uw keuze/Your Choice"
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
@call :schermheader
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
@echo [8] x
@echo. 
@echo [9] Hoofdmenu/Main menu ULVMM
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
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :installeertools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :maakdirectories
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
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\*") do rd /s /q "%%d"
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
@IF EXIST "%Debian12DesktopVM%\%Debian12DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Debian12DesktopVM%\%Debian12DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian12DesktopVM%\%Debian12DesktopVMName%.vmx" (
    del %Debian12DesktopVM%\*.vm* >nul 2>&1
    del %Debian12DesktopVM%\*.nvram >nul 2>&1
    del %Debian12DesktopVM%\*.scoreboard >nul 2>&1
    del %Debian12DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*") do rd /s /q "%%d" >nul 2>&1
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
@IF NOT EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z" (
    @echo Downloaden Debian 12 Desktop Template vanaf LinuxVMImages website ...
    @curl -s -L -o %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z %Debian12DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z" (
    @echo Uitpakken Debian 12 Desktop Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z -o%Debian12DesktopVM% -y >nul 2>&1
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
    @rename "%Debian12DesktopVM%\%LVIDebian12D%.vmx" %Debian12DesktopVMName%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian12DesktopVM%\%LVIDebian12D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Debian12DesktopVM%\%LVIDebian12D%.vmdk" %Debian12DesktopVMName%.vmdk
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
@ECHO [VMX] DisplayName aanpassen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry displayName "%Debian12DesktopVMName%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry annotation "Debian 12 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry scsi0:0.fileName "%Debian12DesktopVMName%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry extendedConfigFile "%Debian12DesktopVMName%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry nvram "%Debian12DesktopVMName%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry vmxstats.filename "%Debian12DesktopVMName%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Debian12DesktopVMName%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry memsize "%QuarterMemoryMB%"
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
::  @echo [VMX] CD-ROM Drive configuratie %Debian12DesktopVMName%
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk Create -f %Debian12DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk Create -f %Debian12DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Debian12DesktopVMName%
@IF EXIST %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Debian12DesktopVMName%
@IF EXIST %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx
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
@pwsh -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 18 VM voorzien van LUCT 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx "/bin/sudo" apt update -y
::
@echo Curl installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx "/bin/sudo" apt install curl -y
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian12DesktopVM%\%Debian12DesktopVMName%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@C:\Windows\System32\OpenSSH\ssh.exe -p 22 debian@%vmipadres%
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
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :installeertools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :maakdirectories
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
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\*") do rd /s /q "%%d"
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
@IF EXIST "%Debian13DesktopVM%\%Debian13DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Debian13DesktopVM%\%Debian13DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%Debian13DesktopVMName%.vmx" (
    del %Debian13DesktopVM%\*.vm* >nul 2>&1
    del %Debian13DesktopVM%\*.nvram >nul 2>&1
    del %Debian13DesktopVM%\*.scoreboard >nul 2>&1
    del %Debian13DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMDName%\*") do rd /s /q "%%d" >nul 2>&1
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
@IF NOT EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\%LVIDebian13D%.7z" (
    @echo Downloaden Debian 13 Desktop Template vanaf LinuxVMImages website ...
    @curl -s -L -o %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\%LVIDebian13D%.7z %Debian13DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\%LVIDebian13D%.7z" (
    @echo Uitpakken Debian 13 Desktop Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates%\%LVIDebian13D%.7z -o%Debian13DesktopVM% -y >nul 2>&1
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
            move /Y "%%~fF" "%Debian13DesktopVM%\"
        )

        for %%F in ("%%~fD\*.vmdk") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13DesktopVM%\"
        )

        echo.
    )
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%LVIDebian13D%.vmx" (
    @echo Hernoem Template VMX ...
    @rename "%Debian13DesktopVM%\%LVIDebian13D%.vmx" %Debian13DesktopVMName%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian13DesktopVM%\%LVIDebian13D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Debian13DesktopVM%\%LVIDebian13D%.vmdk" %Debian13DesktopVMName%.vmdk
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
@ECHO [VMX] DisplayName aanpassen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry displayName "%Debian13DesktopVMName%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry annotation "Debian 13 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry scsi0:0.fileName "%Debian13DesktopVMName%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry extendedConfigFile "%Debian13DesktopVMName%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry nvram "%Debian13DesktopVMName%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry vmxstats.filename "%Debian13DesktopVMName%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Debian13DesktopVMName%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry memsize "%QuarterMemoryMB%"
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
::  @echo [VMX] CD-ROM Drive configuratie %Debian13DesktopVMName%
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk Create -f %Debian13DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Debian13DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk Create -f %Debian13DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Debian13DesktopVMName%
@IF EXIST %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Debian13DesktopVMName%
@IF EXIST %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx
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
@pwsh -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo APT Repository aanpassen in virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i '1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware' /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i '1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware' /etc/apt/sources.list
::
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" apt update -y
::
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Bash voorkeuren instellen ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
@echo Linux Hosts bestand aanpassen ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB13-TRX-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::  Linux Versie
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i '1a\\127.0.1.1       DB13-TRX-S-LAB-001' /etc/hosts
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i '3s/^127\.0\.1\.1/99.99.99.99/' /etc/hosts
::
@echo Linux Hostname aanpassen
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i "s/^debian13$/DB13-TRX-S-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" sed -i 's/^debian13$/DB13-TRX-S-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian13DesktopVM%\%Debian13DesktopVMName%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@C:\Windows\System32\OpenSSH\ssh.exe -p 22 debian@%vmipadres%
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
::
::
@cls
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :installeertools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :maakdirectories
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
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\*") do rd /s /q "%%d"
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
@IF EXIST "%Debian13ServerVM%\%Debian13ServerVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Debian13ServerVM%\%Debian13ServerVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Debian13ServerVM%\%Debian13ServerVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Debian13ServerVM%\%Debian13ServerVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%Debian13ServerVMName%.vmx" (
    del %Debian13ServerVM%\*.vm* >nul 2>&1
    del %Debian13ServerVM%\*.nvram >nul 2>&1
    del %Debian13ServerVM%\*.scoreboard >nul 2>&1
    del %Debian13ServerVM%\*.log >nul 2>&1
    @for /d %%d in ("%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMDName%\*") do rd /s /q "%%d" >nul 2>&1
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
@IF NOT EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\%LVIDebian13S%.7z" (
    @echo Downloaden Debian 13 Server Template vanaf LinuxVMImages website ...
    @curl -s -L -o %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\%LVIDebian13S%.7z %Debian13ServerUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\%LVIDebian13S%.7z" (
    @echo Uitpakken Debian 13 Server Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates%\%LVIDebian13S%.7z -o%Debian13ServerVM% -y >nul 2>&1
)
::
::  Overzetten bestanden uit eventuele subdirectory naar directory 
::  Noodzakelijk omdat Debian 13 uitpak doet naar een subdirectory binnen directory
::

@echo Eventueel VMX en VMDK bestand uit subdirectory op de juiste plek zetten 

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

        echo VM directory gevonden: %%~fD

        for %%F in ("%%~fD\*.vmx") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13ServerVM%\"
        )

        for %%F in ("%%~fD\*.vmdk") do (
            echo Verplaatsen: %%~nxF
            move /Y "%%~fF" "%Debian13ServerVM%\"
        )

        echo.
    )
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%LVIDebian13S%.vmx" (
    @echo Hernoem Template VMX ...
    @rename "%Debian13ServerVM%\%LVIDebian13S%.vmx" %Debian13ServerVMName%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Debian13ServerVM%\%LVIDebian13S%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Debian13ServerVM%\%LVIDebian13S%.vmdk" %Debian13ServerVMName%.vmdk
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
@ECHO [VMX] DisplayName aanpassen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry displayName "%Debian13ServerVMName%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry annotation "Debian 13 Server Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry scsi0:0.fileName "%Debian13ServerVMName%.vmdk"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry extendedConfigFile "%Debian13ServerVMName%.vmxf"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry nvram "%Debian13ServerVMName%.nvram"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry vmxstats.filename "%Debian13ServerVMName%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Debian13ServerVMName%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry memsize "%QuarterMemoryMB%"
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
::  @echo [VMX] CD-ROM Drive configuratie %Debian13ServerVMName%
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk Create -f %Debian13ServerVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Debian13ServerVMName%
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk Create -f %Debian13ServerVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Debian13ServerVM%\%Debian13ServerVMName%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Debian13ServerVMName%
@IF EXIST %Debian13ServerVM%\%Debian13ServerVMName%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Debian13ServerVM%\%Debian13ServerVMName%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Debian13ServerVMName%
@IF EXIST %Debian13ServerVM%\%Debian13ServerVMName%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Debian13ServerVM%\%Debian13ServerVMName%.vmx
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
@pwsh -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Debian Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo APT Repository aanpassen in virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i '1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware' /etc/apt/sources.list
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i '1c\deb https://mirror.nl.mirhosting.net/debian/ trixie main non-free non-free-firmware' /etc/apt/sources.list
::
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" apt update -y
::
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Bash voorkeuren instellen ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" curl -s -o /home/debian/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" curl -s -o /home/debian/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
@echo Hosts bestand aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1       DB13-TRX-S-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
::  Linux Versie
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i '1a\\127.0.1.1       DB13-TRX-S-LAB-001' /etc/hosts
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i '3s/^127\.0\.1\.1/99.99.99.99/' /etc/hosts
::
@echo Linux Hostname aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i "s/^debian13$/DB13-TRX-S-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" sed -i 's/^debian13$/DB13-TRX-S-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" curl -L -o /home/debian/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" chmod +x /home/debian/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu debian -gp debian getGuestIPAddress %Debian13ServerVM%\%Debian13ServerVMName%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@C:\Windows\System32\OpenSSH\ssh.exe -p 22 debian@%vmipadres%
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
::  Installatie OMV
@echo Open Media Vault installeren ...
@echo.
@echo Standaard gebruiker is admin
@echo Standaard wachtwoord is openmediavault
::
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" wget -q -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
::  Upgrade OMV
@echo OMV upgraden naar de nieuwste versie ...
@"%VMWareInstallPath%"\vmrun -T ws -gu debian -gp debian runProgramInGuest %Debian13ServerVM%\%Debian13ServerVMName%.vmx "/bin/sudo" omv-upgrade
::
@echo LET OP! Inloggen met debian gebruiker is NIET meer mogelijk na eerste gebruik van de GUI OMV !
@pause
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
@call :schermheader
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
@call :schermheader
@echo.
@echo Ubuntu 24.04 LTS Desktop (Linux Virtual Images)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie Installeer tools
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :installeertools
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Functie maak directories
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@call :maakdirectories
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
@dir /b "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@dir /b "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  WMX is aanwezig en VMDK is afwezig
::
@if "%VMX%"=="1" if "%VMDK%"=="0" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is afwezig en VMDK is aanwezig
::
@if "%VMX%"=="0" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\*") do rd /s /q "%%d"
)
::
::  VMX is aanwezig en VMDK is aanwezig 
::
@if "%VMX%"=="1" if "%VMDK%"=="1" (
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.vm* >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.nvram >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.scoreboard >nul 2>&1
    @del /F /S /Q "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%"\*.log >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    @for /d %%d in ("%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\*") do rd /s /q "%%d"
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
@IF EXIST "%Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx" (
    del %Ubuntu24DesktopVM%\*.vm* >nul 2>&1
    del %Ubuntu24DesktopVM%\*.nvram >nul 2>&1
    del %Ubuntu24DesktopVM%\*.scoreboard >nul 2>&1
    del %Ubuntu24DesktopVM%\*.log >nul 2>&1
    @for /d %%d in ("%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMDName%\*") do rd /s /q "%%d" >nul 2>&1
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
@IF NOT EXIST "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\%LVIUbuntu24D%.7z" (
    @echo Downloaden template virtuele machine vanaf LinuxVMImages website ...
    @curl -s -L -o %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\%LVIUbuntu24D%.7z %Ubuntu24DesktopUrl%
)
::
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\%LVIUbuntu24D%.7z" (
    @echo Uitpakken template virtuele machine naar virtuele machine directory ...
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates%\%LVIUbuntu24D%.7z -o%Ubuntu24DesktopVM% -y >nul 2>&1
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
    @rename "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmx" %Ubuntu24DesktopVMName%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%Ubuntu24DesktopVM%\%LVIUbuntu24D%.vmdk" %Ubuntu24DesktopVMName%.vmdk
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
@ECHO [VMX] DisplayName aanpassen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry displayName "%Ubuntu24DesktopVMName%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry annotation "Ubuntu 24.04 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry scsi0:0.fileName "%Ubuntu24DesktopVMName%.vmdk"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry extendedConfigFile "%Ubuntu24DesktopVMName%.vmxf"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry nvram "%Ubuntu24DesktopVMName%.nvram"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry vmxstats.filename "%Ubuntu24DesktopVMName%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Ubuntu24DesktopVMName%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry memsize "%QuarterMemoryMB%"
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
::  @echo [VMX] CD-ROM Drive configuratie %Ubuntu24DesktopVMName%
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Sata SetPresent sata0 1
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
::  @"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetPresent sata0:0 1
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk Create -f %Ubuntu24DesktopVM%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Ubuntu24DesktopVMName%
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk Create -f %Ubuntu24DesktopVM%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Disk SetPresent nvme0:1 1 
::
::
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Ubuntu24DesktopVMName%
@IF EXIST %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Ubuntu24DesktopVMName%
@IF EXIST %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx
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
@pwsh -command "Start-Sleep -Seconds 60"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM configuratie Ubuntu Linux
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo APT Repository aanpassen naar NL in virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i "2c\URIs: http://nl.archive.ubuntu.com/ubuntu/" /etc/apt/sources.list.d/ubuntu.sources
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i '2c\URIs: http://nl.archive.ubuntu.com/ubuntu/' /etc/apt/sources.list.d/ubuntu.sources
::
@echo APT Update uitvoeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" apt update -y
::
@echo Tools installeren in virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" apt install curl jq sed wget wget2 -y
::
@echo Bash voorkeuren instellen ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" curl -s -o /home/ubuntu/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" curl -s -o /home/ubuntu/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
::
@echo Hosts bestand aanpassen in de virtuele machine ...
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i "1a\\127.0.1.1 U24-LTS-D-LAB-001" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i "3s/^127\.0\.1\.1/99.99.99.99/" /etc/hosts
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i "3s/ubuntu2404/ubuntu2404.linuxvmimages.com ubuntu2404/" /etc/hosts
::  In Linux moet SED ' ' maar bij vmrun moet SED " "
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i '3s/ubuntu2404/ubuntu2404.virtualimages.com ubuntu2404/' /etc/hosts
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i '3s/^127\.0\.1\.1/99.99.99.99/' /etc/hosts
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i '1a\\127.0.1.1 U24-LTS-D-LAB-001' /etc/hosts
::
@echo Linux Hostname aanpassen in de virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i "s/^ubuntu2404$/U24-LTS-D-LAB-001/" /etc/hostname
::  @"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" sed -i 's/^ubuntu2404$/U24-LTS-D-LAB-001/' /etc/hostname
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub John Tutert 
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" curl -L -o /home/ubuntu/luctv42.sh https://edu.nl/vnej9
:: 
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx "/bin/sudo" chmod +x /home/ubuntu/luctv42.sh
::
@echo IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress %Ubuntu24DesktopVM%\%Ubuntu24DesktopVMName%.vmx') do set vmipadres=%%A
::
@echo SSH Sessie virtuele machine starten
@C:\Windows\System32\OpenSSH\ssh.exe -p 22 ubuntu@%vmipadres%
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
@call :schermheader
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
@call :schermheader
::
@echo.
@echo Einde Script
@echo.
exit 1
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
:schermheader
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo ::::: Ultimate Linux Virtual Machine Manager                           
@echo ::::: Build %ULVMMBuild% Patch %ULVMMPatch% CHANNEL %ULVMMChannel%
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@goto :eof
::
::
:installeertools
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
@goto :eof
::
::
:maakdirectories
::
::
::  Templates
::
::
@mkdir %VMTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates% >nul 2>&1
::
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12 >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%ServerTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13 >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%DesktopTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\13\%ServerTemplates% >nul 2>&1
::
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404 >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%DesktopTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2404\%ServerTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2604 >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2604\%DesktopTemplates% >nul 2>&1
@mkdir %VMTemplates%\%LinuxTemplates%\%UbuntuTemplates%\2604\%ServerTemplates% >nul 2>&1
::
::
::  Virtuele machines
::
::
@mkdir %VMwWrkVMPath% >nul 2>&1
::
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM% >nul 2>&1
::
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12 >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName% >nul 2>&1
@mkdir %Debian12DesktopVM% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMSName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMSName%\%Debian12ServerVMName% >nul 2>&1
::
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13 >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMDName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMDName%\%Debian13DesktopVMName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMSName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\13\%VMwWrkDebianVMSName%\%Debian13ServerVMName% >nul 2>&1
::
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404 >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMDName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMDName%\%Ubuntu24DesktopVMName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMSName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMSName%\%Ubuntu24ServerVMName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2404\%VMwWrkUbuntuVMSName%\%Ubuntu24DockerVMName% >nul 2>&1
::
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604 >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMDName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMDName%\%Ubuntu26DesktopVMName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMSName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMSName%\%Ubuntu26ServerVMName% >nul 2>&1
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkUbuntuVM%\2604\%VMwWrkUbuntuVMSName%\%Ubuntu26DockerVMName% >nul 2>&1
::
@goto :eof
::

