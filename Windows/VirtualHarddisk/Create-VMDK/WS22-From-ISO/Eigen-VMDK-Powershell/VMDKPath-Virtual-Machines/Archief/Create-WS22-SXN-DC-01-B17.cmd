@REM
@REM   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM     TT    U    U    TT    SS      O    O  FF        TT
@REM     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM     TT    U    U    TT        SS  O    O  FF        TT
@REM     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM
@REM     TutSOFT Education and Networking Services (TENS)
@REM
@REM
@REM  Virtual Machine Manager
@REM  Windows Command Prompt 
@REM
@REM  Build 17
@REM  18 Augustus 2026
@REM
@REM  By John Tutert
@REM
@REM  For Personal and/or Educational use only ! 
@REM
@REM
@REM  Echo Hardware Productkey
@REM  wmic path softwarelicensingservice get OA3xOriginalProductKey
@REM
@REM
@setlocal EnableDelayedExpansion
@REM
@echo off
@cls
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
@REM    Virtuele machine Naam
set "VirtMachName=SXN-DC-01"
@REM
@REM    Windows Versie
set "WindowsVersie=2022"
@REM
@REM Thuisdirectories
@REM
set "HyperVVMHome=D:\Virtualization-Home\Virtual-Machines\Microsoft-Hyper-V"
set "VMWVMHome=D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO"
set "MediaHome=D:\Virtualization-Home\Installation-Media"
@REM
IF %COMPUTERNAME% == CND0475SYS (
    set "GithubHome=D:\OneDrive\OneDrive - Saxion\Bestanden\GitHub-JATUTERT"
)
@REM
IF %COMPUTERNAME% == PF6FNDPL (
    set "GithubHome=D:\Bestanden\GitHub-JATUTERT"
)
@REM
@REM  ISO Bestand %VirtMachName%
@REM
Set "ISOVHDBestand=%MediaHome%\OperatingSystems\Windows\10-11\10-22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso"
@REM
@REM  VHD Bestand
Set "VHDBestandVMDK=%HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VHD"
@REM
@REM  VMDK Bestand
Set "VMDKBestandVM=%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK"
Set "VMXBestandVM=%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX"
@REM
@REM  Powershell Script
@REM
@REM    Werklaptop
@REM
IF %COMPUTERNAME% == CND0475SYS (
    set "PSISOVHDScriptDirectory=%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%VirtMachName%"
    set "PSISOVHDScriptFile=WS22-%VirtMachName%-Create-VHD-Latest.ps1"
)
@REM
@REM    Privelaptop
@REM
IF %COMPUTERNAME% == PF6FNDPL (
    set "PSISOVHDScriptDirectory=%GithubHome%\demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%VirtMachName%"
    set "PSISOVHDScriptFile=WS22-%VirtMachName%-Create-VHD-Latest.ps1"
)
@REM
@REM
@REM
for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    set TotalMemoryGB=%%i
)
@REM
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
echo [3] Aanmaken Virtuele Machines
echo [4] Starten Virtuele machine
echo [5] Stop en verwijder Virtuele machine 
echo [6] Overzetten Virtuele Machine naar NextCloud
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
choice /C:123456789 /N /M "Maak uw keuze"
set hfd_menu_keuze=%errorlevel%
if !hfd_menu_keuze! EQU 9 goto :einde
if !hfd_menu_keuze! EQU 8 goto :cleanall
if !hfd_menu_keuze! EQU 7 goto :hoofdmenu
if !hfd_menu_keuze! EQU 6 goto :nxtcld
if !hfd_menu_keuze! EQU 5 goto :deletvmx
if !hfd_menu_keuze! EQU 4 goto :startvmx
if !hfd_menu_keuze! EQU 3 goto :cvhdvmdk
if !hfd_menu_keuze! EQU 2 goto :cisonvhd
if !hfd_menu_keuze! EQU 1 goto :dlwndiso
goto :hoofdmenu


@REM
@REM  Downloaden ISO Bestanden
@REM  Menukeuze 1
@REM
:dlwndiso
@REM
@CALL :f_scrnhd
@REM
start /MAX chrome.exe https://massgrave.dev/windows-server-links#windows-server-%WindowsVersie%
start /MAX chrome.exe https://massgrave.dev/windows_11_links
@REM
@REM
goto :hoofdmenu


@REM
@REM  Aanmaken VHD Bestanden
@REM  Menukeuze 2
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
if !cisonvhd_menu_keuze! EQU 9 goto :hoofdmenu
if !cisonvhd_menu_keuze! EQU 8 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 7 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 6 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 5 goto :cisonvhd
if !cisonvhd_menu_keuze! EQU 4 call :f_mkvhdf Client 11 SXN-WS-01
if !cisonvhd_menu_keuze! EQU 3 call :f_mkvhdf Server 2022 SXN-RD-01
if !cisonvhd_menu_keuze! EQU 2 call :f_mkvhdf Server 2022 SXN-DC-01
if !cisonvhd_menu_keuze! EQU 1 call :f_mkvhdf Server 2022 SXN-DB-01
@REM
goto :cisonvhd
@REM


@REM
@REM  Converteer VHD naar VMDK
@REM  Menukeuze 3
@REM
:cvhdvmdk
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
set cvhdvmdk_menu_keuze=%errorlevel%
if !cvhdvmdk_menu_keuze! EQU 9 goto :hoofdmenu
if !cvhdvmdk_menu_keuze! EQU 8 goto :cvhdvmdk
if !cvhdvmdk_menu_keuze! EQU 7 goto :cvhdvmdk
if !cvhdvmdk_menu_keuze! EQU 6 goto :cvhdvmdk
if !cvhdvmdk_menu_keuze! EQU 5 goto :cvhdvmdk
if !cvhdvmdk_menu_keuze! EQU 4 call :f_mkvmdf Client 11 SXN-WS-01
if !cvhdvmdk_menu_keuze! EQU 3 call :f_mkvmdf Server 2022 SXN-RD-01
if !cvhdvmdk_menu_keuze! EQU 2 call :f_mkvmdf Server 2022 SXN-DC-01
if !cvhdvmdk_menu_keuze! EQU 1 call :f_mkvmdf Server 2022 SXN-DB-01
@REM
goto :cvhdvmdk
@REM


@REM
@REM  Starten Virtuele Machines
@REM  Menukeuze 4
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
if !startvmx_menu_keuze! EQU 9 goto :hoofdmenu
if !startvmx_menu_keuze! EQU 8 goto :startvmx
if !startvmx_menu_keuze! EQU 7 goto :startvmx
if !startvmx_menu_keuze! EQU 6 goto :startvmx
if !startvmx_menu_keuze! EQU 5 goto :startvmx
if !startvmx_menu_keuze! EQU 4 call :f_strtvm Client 11 SXN-WS-01
if !startvmx_menu_keuze! EQU 3 call :f_strtvm Server 2022 SXN-RD-01
if !startvmx_menu_keuze! EQU 2 call :f_strtvm Server 2022 SXN-DC-01
if !startvmx_menu_keuze! EQU 1 call :f_strtvm Server 2022 SXN-DB-01
@REM
goto :startvmx
@REM


@REM
@REM  Verwijderen Virtuele Machines
@REM  Menukeuze 5
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
if !deletvmx_menu_keuze! EQU 9 goto :hoofdmenu
if !deletvmx_menu_keuze! EQU 8 goto :deletvmx
if !deletvmx_menu_keuze! EQU 7 goto :deletvmx
if !deletvmx_menu_keuze! EQU 6 goto :deletvmx
if !deletvmx_menu_keuze! EQU 5 goto :deletvmx
if !deletvmx_menu_keuze! EQU 4 call :f_delvmx Client 11 SXN-WS-01
if !deletvmx_menu_keuze! EQU 3 call :f_delvmx Server 2022 SXN-RD-01
if !deletvmx_menu_keuze! EQU 2 call :f_delvmx Server 2022 SXN-DC-01
if !deletvmx_menu_keuze! EQU 1 call :f_delvmx Server 2022 SXN-DB-01
@REM
goto :deletvmx
@REM


@REM
@REM  Zet virtuele Machine op NextCloud
@REM  Menukeuze 6
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
if !nxtcld_menu_keuze! EQU 9 goto :hoofdmenu
if !nxtcld_menu_keuze! EQU 8 goto :nxtcld
if !nxtcld_menu_keuze! EQU 7 goto :nxtcld
if !nxtcld_menu_keuze! EQU 6 goto :nxtcld
if !nxtcld_menu_keuze! EQU 5 goto :nxtcld
if !nxtcld_menu_keuze! EQU 4 call :f_nxtcld Client 11 SXN-WS-01
if !nxtcld_menu_keuze! EQU 3 call :f_nxtcld Server 2022 SXN-RD-01
if !nxtcld_menu_keuze! EQU 2 call :f_nxtcld Server 2022 SXN-DC-01
if !nxtcld_menu_keuze! EQU 1 call :f_nxtcld Server 2022 SXN-DB-01
@REM
goto :nxtcld
@REM





@REM
@REM
@REM
@REM
@REM ==== [8] Opschonen ===================================================================================================================================
@REM
@REM
@REM
@REM
:cleanall
@REM
@CALL :f_scrnhd
@REM
@IF EXIST "%VHDBestandVMDK%" (
    del /F /S /Q "%HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName%"\*.* >nul 2>&1
) 
@REM
@REM  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
@REM
@REM  VMX is aanwezig maar VMDK niet
@REM
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q "%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%"\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM  VMDK is aanwezig maar VMX niet
@REM
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q "%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%"\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM  VMDK is aanwezig en VDMK is aanwezig 
@REM
if "%VMX%"=="1" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q "%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%"\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM
@REM
@REM
@REM
goto hoofdmenu
@REM
@REM
@REM







@REM
@REM
@REM ==== [9] EINDE ===================================================================================================================================
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
@REM      Thats all folks
@REM
@REM      This is the end
@REM      Hold your breath and count to ten
@REM      Feel the Earth move and then
@REM      Hear my heart burst again
@REM      For this is the end
@REM      I've drowned and dreamt this moment
@REM      So overdue, I owe them
@REM      Swept away, I'm stolen
@REM
@REM      Adelle
@REM
@REM      Copyright 2012 Melted Stone Ltd under exclusive license to Columbia Records / Skyfall 
@REM      Copyright 2012 Danjaq LLC, United Artists Corporation, Columbia Pictures Industries Inc., Skyfall, 007 Gun Logo, and related James Bond Trademarks Copyright 1962-2012
@REM



@REM
@REM ==== FUNCTIES ===================================================================================================================================
@REM



:f_scrnhd
@REM
@REM  Functie
@REM  Toon Scherm Header
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
@mkdir "%VMWVMHome%\Windows" >nul 2>&1
@REM
@mkdir "%VMWVMHome%\Windows\Client" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Client\11" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Client\11\SXN-WS-01" >nul 2>&1
@REM
@mkdir "%VMWVMHome%\Windows\Server" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Server\2022" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Server\2022\SXN-DB-01" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Server\2022\SXN-DC-01" >nul 2>&1
@mkdir "%VMWVMHome%\Windows\Server\2022\SXN-RD-01" >nul 2>&1
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
@REM  Conversie VHD naar VMDK mbv StarWind V2V Converter
@echo Conversie van VHD naar VMDK gestart ... 
@echo %HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD
@echo %VMWVMHome%\Windows\%1\%2\%3\%3.VMDK
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" out_file_name="%VMWVMHome%\Windows\%1\%2\%3\%3.VMDK" out_file_type=ft_vmdk_ws_growable
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
    @start /B vmware -n "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX"
    @REM
    @echo Starten VM 
    @start vmrun -T ws start "%VMWVMHome%\Windows\%1\%2\%3\%3.VMX"
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
@REM  Conversie VHD naar VMDK mbv StarWind V2V Converter
@echo Conversie van VHD naar VMDK gestart ... 
@echo %HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD
@echo %VMWVMHome%\Windows\%1\%2\%3\%3.VMDK
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%HyperVVMHOME%\Windows\%1\%2\%3\%3.VHD" out_file_name="D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\%1\%2\%3\%3.VMDK" out_file_type=ft_vmdk_ws_growable
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