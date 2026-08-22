@echo off
@cls
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM       TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM         TT    U    U    TT    SS      O    O  FF        TT
@REM         TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM         TT    U    U    TT        SS  O    O  FF        TT
@REM         TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM        TutSOFT Education and Networking Services (TENS)
@REM
@REM        The Netherlands/Nederland/Niederlande/Pays Bas/Paisos Bajos
@REM        NL EU
@REM
@REM
@REM    Copyright (c) 2026 John Tutert
@REM    Permission is hereby granted, free of charge, to any person obtaining a copy
@REM    of this software, to use, copy, modify, and distribute it for personal,
@REM    educational, or open-source purposes, provided this notice remains intact.
@REM    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM    Virtual Machine Manager
@REM    Windows Command Prompt 
@REM
@REM    Build 19
@REM    21 Augustus 2026
@REM
@REM    By John Tutert
@REM
@REM    For Personal and/or Educational use only ! 
@REM
@REM
@REM    Echo Hardware Productkey
@REM    wmic path softwarelicensingservice get OA3xOriginalProductKey
@REM
@REM
@setlocal EnableDelayedExpansion
@REM
@REM
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
   @REM
   @CALL :f_scrnhd
   @REM
   @ECHO Script NIET gestart met Adminstrator rechten ! 
   pause
   endlocal
   exit /b 1
)
@REM
@REM
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM  @@@@@@
@REM  @@@@@@    Declaratie Variabelen
@REM  @@@@@@
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM
@REM
@REM

@REM Thuisdirectories
set "HyperVVMHome=D:\Virtualization-Home\Virtual-Machines\Microsoft-Hyper-V"
set "VMWVMHome=D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO"
set "MediaHome=D:\Virtualization-Home\Installation-Media"

@REM  GitHub Desktop Home op deze laptop
IF /I "%COMPUTERNAME%"=="CND0475SYS" (
    set "GithubHome=D:\OneDrive\OneDrive - Saxion\Bestanden\GitHub-JATUTERT"
)
@REM
IF /I "%COMPUTERNAME%"=="PF6FNDPL" (
    set "GithubHome=D:\Bestanden\GitHub-JATUTERT"
)

@REM  Ophalen totaal aanwezig RAM geheugen van deze laptop
for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    set TotalMemoryGB=%%i
)

@REM  Ophalen installatie lokatie VMWare Workstation Pro op deze laptop
@FOR /F "tokens=2,*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
@REM


@REM
@REM  Hoofdmenu
@REM
:hoofdmenu
@REM
@CALL :f_scrnhd
@REM
echo [1] Downloaden ISO Bestanden
echo [2] Aanmaken VHD bestanden
echo [3] Aanmaken virtuele Machines
echo [4] Starten virtuele machines
echo [5] Verwijderen virtuele machines 
echo [6] Aanmaken virtuele Machines op NextCloud
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set hfd_menu_keuze=%errorlevel%
@REM
if !hfd_menu_keuze! EQU 9 (
    goto :einde
)
if !hfd_menu_keuze! EQU 8 (
    goto :cleanall
)
if !hfd_menu_keuze! EQU 7 (
    goto :keuze7
)
if !hfd_menu_keuze! EQU 6 (
    goto :nxtcld
)
if !hfd_menu_keuze! EQU 5 (
    goto :deletvmx
)
if !hfd_menu_keuze! EQU 4 (
    goto :startvmx
)
if !hfd_menu_keuze! EQU 3 (
    goto :maakvmdk
)
if !hfd_menu_keuze! EQU 2 (
    goto :cisonvhd
)
if !hfd_menu_keuze! EQU 1 (
    goto :dlwndiso
)
@REM
goto :hoofdmenu

@REM
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM  @@@@@@@@@@  Hoofdmenu keuzes
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM

@REM
@REM  Downloaden ISO Bestanden
@REM  Hoofdmenu menukeuze 1
@REM
:dlwndiso
@REM
@CALL :f_scrnhd
@REM
start /MAX chrome.exe https://massgrave.dev/windows-server-links#windows-server-2022
start /MAX chrome.exe https://massgrave.dev/windows_11_links
@REM
@REM
goto :hoofdmenu


@REM
@REM  Aanmaken VHD Bestanden
@REM  Hoofdmenu menukeuze 2
@REM
:cisonvhd
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
echo [1] Aanmaken SXN-DB-01 VHD
echo [2] Aanmaken SXN-DC-01 VHD
echo [3] Aanmaken SXN-RD-01 VHD
echo [4] Aanmaken SXN-WS-01 VHD
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set cisonvhd_menu_keuze=%errorlevel%
@REM
if !cisonvhd_menu_keuze! EQU 9 (
    goto :hoofdmenu
)
if !cisonvhd_menu_keuze! EQU 8 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 7 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 6 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 5 goto :cisonvhd
@REM
if !cisonvhd_menu_keuze! EQU 4 (
   call :f_mkvhdf Client 11 SXN-WS-01
)
if !cisonvhd_menu_keuze! EQU 3 (
   call :f_mkvhdf Server 2022 SXN-RD-01
)
if !cisonvhd_menu_keuze! EQU 2 (
   call :f_mkvhdf Server 2022 SXN-DC-01
)
if !cisonvhd_menu_keuze! EQU 1 (
   call :f_mkvhdf Server 2022 SXN-DB-01
)
@REM
goto :cisonvhd
@REM


@REM
@REM  Converteer VHD naar VMDK
@REM  Hoofdmenu menukeuze 3
@REM
:maakvmdk
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
echo [1] Maak SXN-DB-01 Virtuele Machine 
echo [2] Maak SXN-DC-01 Virtuele Machine
echo [3] Maak SXN-RD-01 Virtuele Machine
echo [4] Maak SXN-WS-01 Virtuele Machine
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set maakvmdk_menu_keuze=%errorlevel%
@REM
if !maakvmdk_menu_keuze! EQU 9 (
    goto :hoofdmenu
)
if !maakvmdk_menu_keuze! EQU 8 goto :maakvmdk
if !maakvmdk_menu_keuze! EQU 7 goto :maakvmdk
if !maakvmdk_menu_keuze! EQU 6 goto :maakvmdk
if !maakvmdk_menu_keuze! EQU 5 goto :maakvmdk
if !maakvmdk_menu_keuze! EQU 4 (
   call :f_mkvmdf Client 11 SXN-WS-01
)
if !maakvmdk_menu_keuze! EQU 3 (
   call :f_mkvmdf Server 2022 SXN-RD-01
)
if !maakvmdk_menu_keuze! EQU 2 ( 
   call :f_mkvmdf Server 2022 SXN-DC-01
)
if !maakvmdk_menu_keuze! EQU 1 (
   call :f_mkvmdf Server 2022 SXN-DB-01
)
@REM
goto :maakvmdk
@REM


@REM
@REM  Starten Virtuele Machines
@REM  Hoofdmenu Menukeuze 4
@REM
:startvmx
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
echo [1] Start SXN-DB-01 Virtuele Machine
echo [2] Start SXN-DC-01 Virtuele Machine
echo [3] Start SXN-RD-01 Virtuele Machine
echo [4] Start SXN-WS-01 Virtuele Machine
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set startvmx_menu_keuze=%errorlevel%
if !startvmx_menu_keuze! EQU 9 (
    goto :hoofdmenu
)
if !startvmx_menu_keuze! EQU 8 goto :startvmx
if !startvmx_menu_keuze! EQU 7 goto :startvmx
if !startvmx_menu_keuze! EQU 6 goto :startvmx
if !startvmx_menu_keuze! EQU 5 goto :startvmx
if !startvmx_menu_keuze! EQU 4 (
   call :f_strtvm Client 11 SXN-WS-01
)
if !startvmx_menu_keuze! EQU 3 ( 
   call :f_strtvm Server 2022 SXN-RD-01
)
if !startvmx_menu_keuze! EQU 2 (
   call :f_strtvm Server 2022 SXN-DC-01
)
if !startvmx_menu_keuze! EQU 1 (
   call :f_strtvm Server 2022 SXN-DB-01
)
@REM
goto :startvmx
@REM


@REM
@REM  Verwijderen Virtuele Machines
@REM  Hoofdmenu Menukeuze 5
@REM
:deletvmx
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
echo [1] Verwijder SXN-DB-01 Virtuele Machine 
echo [2] Verwijder SXN-DC-01 Virtuele Machine
echo [3] Verwijder SXN-RD-01 Virtuele Machine
echo [4] Verwijder SXN-WS-01 Virtuele Machine
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set deletvmx_menu_keuze=%errorlevel%
@REM
if !deletvmx_menu_keuze! EQU 9 (
    goto :hoofdmenu
)
if !deletvmx_menu_keuze! EQU 8 goto :deletvmx
if !deletvmx_menu_keuze! EQU 7 goto :deletvmx
if !deletvmx_menu_keuze! EQU 6 goto :deletvmx
if !deletvmx_menu_keuze! EQU 5 goto :deletvmx
if !deletvmx_menu_keuze! EQU 4 (
   call :f_delvmx Client 11 SXN-WS-01
)
if !deletvmx_menu_keuze! EQU 3 (
   call :f_delvmx Server 2022 SXN-RD-01
)
if !deletvmx_menu_keuze! EQU 2 (
   call :f_delvmx Server 2022 SXN-DC-01
)
if !deletvmx_menu_keuze! EQU 1 (
   call :f_delvmx Server 2022 SXN-DB-01
)
@REM
goto :deletvmx
@REM


@REM
@REM  Zet virtuele Machine op NextCloud
@REM  Hoofdmenu Menukeuze 6
@REM
@REM  De eigen virtuele machine op laptop wordt niet meer gebruikt om over te zetten
@REM  Virtuele machine wordt nu aangemaakt door conversie te doen
@REM
:nxtcld
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
@echo Virtuele Machine op Laptop wordt niet gebruikt
echo [1] Maak SXN-DB-01 Virtuele Machine op NextCloud
echo [2] Maak SXN-DC-01 Virtuele Machine op NextCloud
echo [3] Maak SXN-RD-01 Virtuele Machine op NextCloud
echo [4] Maak SXN-WS-01 Virtuele Machine op NextCloud
echo [5] x
echo [6] x
echo [7] x
echo [8] x
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set nxtcld_menu_keuze=%errorlevel%
@REM
if !nxtcld_menu_keuze! EQU 9 (
    goto :hoofdmenu
)
if !nxtcld_menu_keuze! EQU 8 goto :nxtcld
if !nxtcld_menu_keuze! EQU 7 goto :nxtcld
if !nxtcld_menu_keuze! EQU 6 goto :nxtcld
if !nxtcld_menu_keuze! EQU 5 goto :nxtcld
if !nxtcld_menu_keuze! EQU 4 (
   call :f_nxtcld Client 11 SXN-WS-01
)
if !nxtcld_menu_keuze! EQU 3 (
   call :f_nxtcld Server 2022 SXN-RD-01
)
if !nxtcld_menu_keuze! EQU 2 (
   call :f_nxtcld Server 2022 SXN-DC-01
)
if !nxtcld_menu_keuze! EQU 1 (
   call :f_nxtcld Server 2022 SXN-DB-01
)
@REM
goto :nxtcld
@REM

@REM
@REM  Verwijder ALLE virtuele machines op deze Laptop
@REM  Hoofdmenu Menukeuze 7
@REM
:keuze7
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
goto hoofdmenu
@REM


@REM
@REM  Verwijder ALLE virtuele machines op deze Laptop
@REM  Hoofdmenu Menukeuze 8
@REM
:cleanall
@REM
@CALL :f_scrnhd
@REM
del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\11\SXN-WS-01"\*.* >nul 2>&1
@REM
del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-DB-01\*.*" >nul 2>&1
del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-DC-01\*.*" >nul 2>&1
del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-RD-01\*.*" >nul 2>&1
@REM
@CALL :f_mkflds
@REM
goto hoofdmenu
@REM


@REM
@REM  Einde Script
@REM  Menukeuze 9
@REM
:einde
@REM
@CALL :f_scrnhd
@REM

@REM  Log-bestand verplaatsen
IF EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VMDK\WS22-From-ISO\Eigen-VMDK-Powershell\VMDKPath-Virtual-Machines\logs\*.log" (
   @robocopy "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VMDK\WS22-From-ISO\Eigen-VMDK-Powershell\VMDKPath-Virtual-Machines\logs" "C:\Program Files\StarWind Software\StarWind V2V Converter\logs" *.log /MOV
)

@echo Einde Script !
@REM
exit /b 0


@REM
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM  @@@@@@@@@@  Functies
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM

:f_scrnhd
@REM
@REM  Functie
@REM  Toon Scherm Header
@REM
@REM
@cls
@echo.
@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@echo @@@@@ Windows Virtuele machine Manager
@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@echo.
IF /I "%COMPUTERNAME%"=="CND0475SYS" (
   echo Werk Laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)   
@REM
IF /I "%COMPUTERNAME%"=="PF6FNDPL" (
   echo Prive Laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
goto :eof



:f_mkflds
@REM
@REM  Functie
@REM  Maak Folders
@REM
@REM
@REM    Stap 0A Aanmaken noodzakelijke directories en subdirectories VHD 
@REM
@mkdir "%HyperVVMHOME%\Windows" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Client" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Client\11" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Client\11\SXN-WS-01" >nul 2>&1
@REM
@mkdir "%HyperVVMHOME%\Windows\Server" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Server\2022" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Server\2022\SXN-DB-01" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01" >nul 2>&1
@mkdir "%HyperVVMHOME%\Windows\Server\2022\SXN-RD-01" >nul 2>&1
@REM
@REM    Stap 0B Aanmaken noodzakelijke directories en subdirectories VMWare Workstation Pro virtuele machines 
@REM
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows" >nul 2>&1
@REM
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Client" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\11" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\11\SXN-WS-01" >nul 2>&1
@REM
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-DB-01" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-DC-01" >nul 2>&1
@mkdir "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\SXN-RD-01" >nul 2>&1
@REM
@mkdir "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Client\11\SXN-WS-01" >nul 2>&1
@REM
@mkdir "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DB-01" >nul 2>&1
@mkdir "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01" >nul 2>&1
@mkdir "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-RD-01" >nul 2>&1
@REM
goto :eof


:f_mkvhdf
@REM
@REM  Functie
@REM  Maak VHD bestand
@REM
@REM  Parameter 1 is Client of Server
@REM  Parameter 2 is Naam van de VM 
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
@REM  Stap 1  Controle aanwezigheid ISO bestand  
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%MediaHome%\OperatingSystems\Windows\10-11\10-22-Windows-11\Consumer-Editions-Microsoft\25H2\en-us_windows_11_consumer_editions_version_25h2_updated_Latest.iso" (
      goto :eof
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%MediaHome%\OperatingSystems\Windows\10-11\10-22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso" (
      goto :eof
   )
)
@REM
@REM    Stap 2  Controle aanwezigheid Powershell script
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines\%1\WC11-%3-Create-VHD-Latest.ps1" (
      @echo Powershell Script voor conversie is NIET gevonden
      @echo.
      @echo VHD kan NIET aangemaakt worden ... 
      @echo.
      @echo Maak WC11-%3-Create-VHD-Latest.ps1
      @echo.
      @pause
      goto :eof
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WS22-%3-Create-VHD-Latest.ps1" (
      @echo Powershell Script voor conversie is NIET gevonden
      @echo.
      @echo VHD kan NIET aangemaakt worden ... 
      @echo.
      @echo Maak WS22-%3-Create-VHD-Latest.ps1
      @echo.
      @pause
      goto :eof
   )
)
@REM
@REM    Stap 3  Aanmaken VHD bestand indien niet aanwezig 
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" (
      powershell -file "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WC11-%3-Create-VHD-Latest.ps1"
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" (
      powershell -file "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WS22-%3-Create-VHD-Latest.ps1"
   )
)
@REM
goto :eof


:f_mkvmdf
@REM
@REM  Functie
@REM  Maak VMDK bestand
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
@IF NOT EXIST "%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" (
   goto :eof
)
@REM
@REM Stoppen eventueel draaiende virtuele machine
"%VMWareInstallPath%\vmrun.exe" -T ws stop "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\%3.VMX" >nul 2>&1
@REM
@REM Verwijderen eventueel aanwezige virtuele machine
"%VMWareInstallPath%\vmrun.exe" -T ws DeleteVM "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\%3.VMX" >nul 2>&1
@REM
@REM Verwijderen eventueel aanwezige bestanden
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmem" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmsd" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmsn" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmx" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmxf" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.vmdk" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.nvram" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.scoreboard" >nul 2>&1
@del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*.log" >nul 2>&1
@REM
@REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
for /d %%d in ("D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\%1\%2\%3\*") do rd /s /q "%%d"
@REM
@REM  Conversie VHD naar VMDK mbv StarWind V2V Converter
@echo Conversie van VHD naar VMDK gestart ... 
@echo %HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD
@echo %VMWVMHome%\Windows\%1\%2\%3\%3.VMDK
IF EXIST "C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" (
   "C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" out_file_name="%VMWVMHome%\Windows\%1\%2\%3\%3.VMDK" out_file_type=ft_vmdk_ws_growable
)
@REM
@REM  VMX bestand aanmaken
@echo Aanmaken VMX in VM Directory VMWare Workstation 
@copy /Y "%GithubHome%\Demos\Windows\Hypervisor\VMware-Desktop\VMX\%3.vmx" "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX"
@REM
goto :eof


:f_strtvm
@REM
@REM  Functie
@REM  Maak VMDK bestand
@REM
@CALL :f_scrnhd
@REM
@IF EXIST "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX" (
    @REM
    @echo Openen %3 in VMware Workstation PRO
    @start /B "VMWareInstallPath\vmware.exe" -n "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX"
    @REM
    @echo Starten VM 
    @start "%VMWareInstallPath%\vmrun.exe" -T ws start "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX"
)
@REM
goto :eof


:f_delvmx
@REM
@REM  Functie
@REM  Maak VMDK bestand
@REM
@CALL :f_scrnhd
@REM
@IF EXIST "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX" (
   @REM
   @REM Stoppen eventueel draaiende virtuele machine
   "%VMWareInstallPath%\vmrun.exe" -T ws stop "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX" >nul 2>&1
   @REM
   @REM Verwijderen eventueel aanwezige virtuele machine
   "%VMWareInstallPath%\vmrun.exe" -T ws DeleteVM "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX" >nul 2>&1
   @REM
   @REM Verwijderen eventueel aanwezige bestanden
   @del /F /S /Q "%VMWVMHome%\Windows\%1\%2\%3\*.*" >nul 2>&1
   @REM
   @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
   for /d %%d in ("%VMWVMHome%\Windows\%1\%2\%3\*") do rd /s /q "%%d"
   @REM
)
@REM
goto :eof


:f_nxtcld
@REM
@REM  Functie
@REM  NextCloud vullen
@REM
@REM  Parameter 1 is Client of Server
@REM  Parameter 2 is Windows Versie
@REM  Parameter 3 is Naam van de Virtuele machine 
@REM
@CALL :f_scrnhd
@REM
@CALL :f_mkflds
@REM
@REM  Stap 1  Controle aanwezigheid ISO bestand  
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%MediaHome%\OperatingSystems\Windows\10-11\10-22-Windows-11\Consumer-Editions-Microsoft\25H2\en-us_windows_11_consumer_editions_version_25h2_updated_Latest.iso" (
      goto :eof
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%MediaHome%\OperatingSystems\Windows\10-11\10-22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso" (
      goto :eof
   )
)
@REM
@REM    Stap 2  Controle aanwezigheid Powershell script
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WC11-%3-Create-VHD-Latest.ps1" (
      @echo Powershell Script voor conversie is NIET gevonden
      @echo.
      @echo VHD kan NIET aangemaakt worden ... 
      @echo.
      @echo Maak WC11-%3-Create-VHD-Latest.ps1
      @echo.
      @pause
      goto :eof
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WS22-%3-Create-VHD-Latest.ps1" (
      @echo Powershell Script voor conversie is NIET gevonden
      @echo.
      @echo VHD kan NIET aangemaakt worden ... 
      @echo.
      @echo Maak WS22-%3-Create-VHD-Latest.ps1
      @echo.
      @pause
      goto :eof
   )
)
@REM
@REM    Stap 3  Aanmaken VHD bestand indien niet aanwezig 
@REM
IF "%~1" == "Client" (
   @REM
   @IF NOT EXIST "%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" (
      powershell -file "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WC11-%3-Create-VHD-Latest.ps1"
   )
)
@REM
IF "%~1" == "Server" (
   @REM
   @IF NOT EXIST "%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" (
      powershell -file "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%3\WS22-%3-Create-VHD-Latest.ps1"
   )
)
@REM
@REM  Conversie VHD naar VMDK mbv StarWind V2V Converter
@echo Conversie van VHD naar VMDK gestart ... 
@echo %HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD
@echo D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMDK
IF EXIST "C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" (
   "C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" out_file_name="D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMDK" out_file_type=ft_vmdk_ws_growable
)
@REM
@REM
attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMDK"
@REM
@REM  VMX bestand aanmaken
@echo Aanmaken VMX in VM Directory VMWare Workstation 
@copy /Y "%GithubHome%\Demos\Windows\Hypervisor\VMware-Desktop\VMX\%3.vmx" "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMX"
@REM
@REM
attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMX"
@REM
goto :eof