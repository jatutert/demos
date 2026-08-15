@REM
@REM   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM     TT    U    U    TT    SS      O    O  FF        TT
@REM     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM     TT    U    U    TT        SS  O    O  FF        TT
@REM     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM
@REM  SXN-DC-01 Virtual Machine Manager
@REM  Windows Command Prompt 
@REM
@REM  Build 14
@REM  14 Augustus 2026
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
@echo off
@cls
@REM
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::::    Declaratie Variabelen
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM Thuisdirectories
@REM
Set "HyperVVMHome=D:\Virtualization-Home\Virtual-Machines\Microsoft-Hyper-V"
set "VMWVMHome=D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO"

IF %COMPUTERNAME% == CND0475SYS (
    set "GithubHome=D:\OneDrive\OneDrive - Saxion\Bestanden\GitHub-JATUTERT"
)
@REM
IF %COMPUTERNAME% == PF6FNDPL (
    set "GithubHome=D:\Bestanden\GitHub-JATUTERT
)
@REM
@REM  ISO Bestand SXN-DC-01
@REM
Set "ISOVHDBestand=D:\Virtualization-Home\Installation-Media\OperatingSystems\Windows\10-11\10-22-Windows-Server-2022\Standard-DataCenter-Microsoft\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso"
@REM
@REM  VHD Bestand
Set "VHDBestandVMDK=%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VHD"
@REM
@REM  VMDK Bestand
Set "VMDKBestandVM=%VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK"
Set "VMXBestandVM=%VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX"
@REM
@REM  Powershell Script
@REM
@REM    Werklaptop
@REM
IF %COMPUTERNAME% == CND0475SYS (
    Set "PSISOVHDScriptDirectory=%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-DC-01"
    Set "PSISOVHDScriptFile=WS22-SXN-DC-01-Create-VHD-Latest.ps1"
)
@REM
@REM    Privelaptop
@REM
IF %COMPUTERNAME% == PF6FNDPL (
    Set "PSISOVHDScriptDirectory=%GithubHome%\demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-DC-01"
    Set "PSISOVHDScriptFile=WS22-SXN-DC-01-Create-VHD-Latest.ps1"
)
@REM
@REM
@REM
for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    SET TotalMemoryGB=%%i
)
@REM
@FOR /F "tokens=2,*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
@REM
:hoofdmenu
@REM
@CLS
@REM
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: SXN-DC-01 virtuele machine Manager                               :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
echo [1] Downloaden ISO Bestanden
echo [2] Aanmaken SXN-DC-01 VHD
echo [3] Aanmaken SXN-DC-01 VMDK en VMX
echo [4] Starten VMWare Workstation Pro SXN-DC-01 virtuele machine
echo [5] Stop en verwijder VMWare Workstation Pro SXN-DC-01 virtuele machine 
echo [6] Overzetten SXN-DC-01 VMDK en VMX naar NextCloud
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
@REM echo Maak uw keuze 
@REM
choice /C:123456789 /N /M "Maak uw keuze"
set antwoord=%errorlevel%
@REM
if %antwoord%==9 goto :einde
if %antwoord%==8 goto :Opschonen
if %antwoord%==7 goto :hoofdmenu
if %antwoord%==6 goto :NextCloud
if %antwoord%==5 goto :VMWDELVM
if %antwoord%==4 goto :VMWRunVM
if %antwoord%==3 goto :VMWMnger
if %antwoord%==2 goto :VHDMnger
if %antwoord%==1 goto :ISODwnld
goto :hoofdmenu
@REM
@REM
@REM
@REM
@REM ==== [1] ISODwnld ===================================================================================================================================
@REM
@REM
@REM
@REM
@REM
:ISODwnld
@REM
@REM
@REM
@REM
start /MAX chrome.exe https://massgrave.dev/windows-server-links#windows-server-2022
start /MAX chrome.exe https://massgrave.dev/windows_11_links
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
@REM ==== [2] VHDMnger ===================================================================================================================================
@REM
@REM
@REM
@REM
@REM
:VHDMnger
@REM
@REM
@REM
@REM
@echo off
@cls
@REM
@REM  Aanmaken noodzakelijke directories en subdirectories voor VHD omgeving 
@REM
@mkdir %HyperVVMHOME%\Windows\ >nul 2>&1
@REM
@mkdir %HyperVVMHOME%\Windows\Client\ >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client\11\SXN-WS-01 >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client\11\W11-EDU-C-LAB-001 >nul 2>&1
@REM
@mkdir %HyperVVMHOME%\Windows\Server\ >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022\SXN-DB-01 >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022\SXN-DC-01 >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022\SXN-RD-01 >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022\W22-DTC-S-LAB-001 >nul 2>&1
@REM
@REM  Controleren leeftijd van eventueel aanwezige VHD
@REM
@IF EXIST "%VHDBestandVMDK%" (
    @REM
    forfiles /p "%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01" /m "SXN-DC-01.VHD" /d -21 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo Het VHD Bestand is aanwezig maar ouder dan 21 dagen
        @echo Verwijderen VHD bestand op D schijf 
        @REM
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q "%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01"\*.* >nul 2>&1
        @REM
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory 
        @REM for /d %%d in ("%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
        for /d %%d in ("%HyperVVMHOME%\Windows\Server\2022\SXN-DC-01\*") do rd /s "%%d"
        @REM
    ) else (
        @REM
        @echo VHD bestand is aanwezig en is niet ouder dan 21 dagen.
        @echo VHD bestand blijft daarom behouden. 
        @REM
    )
)
@REM
@REM  Controle aanwezigheid ISO bestand  
@REM
@IF NOT EXIST "%ISOVHDBestand%" (
    @echo Windows Server 2022 ISO bestand voor conversie is NIET gevonden
    @echo.
    @echo VHD kan NIET aangemaakt worden ... 
    @echo.
    @echo Zorg voor en-us_windows_server_2022_updated_latest.iso
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM  Controle aanwezigheid Powershell script
@REM
Set "PowershellScriptBestand=%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-DC-01\WS22-SXN-DC-01-Create-VHD-Latest.ps1"
@REM
@IF NOT EXIST "%PowershellScriptBestand%" (
    @echo Powershell Script voor conversie is NIET gevonden
    @echo.
    @echo VHD kan NIET aangemaakt worden ... 
    @echo.
    @echo Maak WS22-SXN-DC-01-Create-VHD-Latest.ps1
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM  Aanmaken VHD bestand indien niet aanwezig 
@REM
@IF NOT EXIST "%VHDBestandVMDK%" (
    @REM    VHD bestand is niet aanwezig
    @REM 
    @REM    Powershell script voor aanmaken van VHD wordt gestart
    @REM
    @echo Aanmaken VHD bestand ...
    @@Powershell -file "%PSISOVHDScriptDirectory%\%PSISOVHDScriptFile%"
    @echo VHD bestand is aangemaakt ... 
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
@REM ==== [3] VMWMnger ===================================================================================================================================
@REM
@REM
@REM
@REM
@REM
:VMWMnger
@REM
@REM
@REM
@REM
@echo off
@cls
@REM
@REM  Aanmaken noodzakelijke directories en subdirectories VMWare Workstation Pro virtuele machines 
@REM
@mkdir %VMWVMHome%\Windows\ >nul 2>&1
@mkdir %VMWVMHome%\Windows\Client\ >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\ >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Client\11\SXN-WS-01 >nul 2>&1
@mkdir %VMWVMHome%\Windows\Client\11\W11-EDU-C-LAB-001 >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Server\2022\SXN-DB-01 >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\2022\SXN-DC-01 >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\2022\SXN-RD-01 >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\2022\W22-DTC-S-LAB-001 >nul 2>&1
@REM
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM      ::::
@REM      ::::    VMDK
@REM      ::::
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=%VMWVMHome%\Windows\Server\2022\SXN-DC-01"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
@REM
@REM  Ongeldig VMX
@REM
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM
    @REM Er is wel een VMX gevonden maar geen VMDK aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  Ongeldig VMDK
@REM
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM
    @REM Er is wel een VMDK gevonden maar geen VMX aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  Geldig VMX en VMDK
@REM
if "%VMX%"=="1" if "%VMDK%"=="1" (
    @REM
    @REM Er is zowel een VMX als een VMDK aangetroffen
    @REM
    @REM    ##########################################
    @REM    VMDK
    @REM    ##########################################
    @REM
    @REM    Controleer of het aanwezige VMDK bestand niet ouder is dan 22 dagen (maand) 
    forfiles /p "%VMWVMHome%\Windows\Server\2022\SXN-DC-01" /m "SXN-DC-01.VMDK" /d -22 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @REM Stoppen eventueel draaiende virtuele machine
        @vmrun -T ws stop "%VMXBestandVM%" >nul 2>&1
        @REM Verwijderen eventueel aanwezige virtuele machine
        @vmrun -T ws DeleteVM "%VMXBestandVM%" >nul 2>&1
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
        for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
        @REM
    ) else (
        @REM
        @echo VMDK van Virtuele machine is aanwezig en ook niet ouder dan 22 dagen. 
        @echo Er is geen reden om VMDK van de virtuele machine opnieuw aan te maken.
        @REM
    )
    @REM
    @REM    ##########################################
    @REM    VMX
    @REM    ##########################################
    @REM
    @REM    Controleer of het aanwezige VMX bestand niet ouder is dan 22 dagen (maand)
    forfiles /p "%VMWVMHome%\Windows\Server\2022\SXN-DC-01" /m "SXN-DC-01.VMX" /d -22 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMX is aanwezig maar ouder dan 22 dagen
        @echo Verwijderen VMX 
        @REM
        del "%VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX"
    ) else (
        @REM
        @echo VMX van Virtuele machine is aanwezig en ook niet ouder dan 22 dagen. 
        @echo Er is geen reden om VMX van de virtuele machine opnieuw aan te maken.
        @REM
    )
)
@REM
@REM  Controle aanwezigheid ISO bestand  
@REM
@IF NOT EXIST "%VHDBestandVMDK%" (
    @echo SXN-DC-01 VHD bestand voor conversie is NIET gevonden
    @echo.
    @echo VMDK kan NIET aangemaakt worden ... 
    @echo.
    @echo Zorg voor SXN-DC-01.VHD
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM  Aanmaken VMDK indien niet aanwezig 
@REM
@IF NOT EXIST "%VMDKBestandVM%" (
    @REM
    @REM    Aanmaken VDMK door conversie VHD
    @echo.
    @echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @echo ::::: SXN-DC-01 virtuele machine Manager                               :::::
    @echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @echo.
    @echo Conversie van VHD naar VMDK gestart ... 
    @"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%VHDBestandVMDK%" out_file_name="%VMDKBestandVM%" out_file_type=ft_vmdk_ws_growable
    @REM
)
@REM
@REM  Log bestanden overzetten naar C: schijf zodat ze niet mee worden genomen in update naar GitHub
@robocopy "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VMDK\WS22-From-ISO\Eigen-VMDK-Powershell\VMDKPath-Virtual-Machines\logs" "C:\Program Files\StarWind Software\StarWind V2V Converter\logs" *.log /MOV
@REM
@REM  Aanmaken VMX indien niet aanwezig
@REM
@IF NOT EXIST "%VMXBestandVM%" (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo   Aanmaken VMX in VM Directory VMWare Workstation 
    @copy "%GithubHome%\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-DC-01.vmx" "%VMXBestandVM%"
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
@REM ==== [4] VMWRunVM ===================================================================================================================================
@REM
@REM
@REM
@REM
:VMWRunVM
@REM
@REM
@REM
@REM
@echo off
@cls
@REM
@IF EXIST %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX (
    @REM
    @echo Openen SXN-DC-01 in VMware Workstation PRO
    @start /B vmware -n %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.vmx
    @REM
    @echo Starten VM 
    @start vmrun -T ws start %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.vmx
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
@REM ==== [5] VMWDELVM ===================================================================================================================================
@REM
@REM
@REM
@REM
:VMWDELVM
@REM
@REM
@REM
@REM
@REM  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=%VMWVMHome%\Windows\Server\2022\SXN-DC-01"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
@REM
@REM  Ongeldig VMX
@REM
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM
    @REM Er is wel een VMX gevonden maar geen VMDK aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  Ongeldig VMDK
@REM
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM
    @REM Er is wel een VMDK gevonden maar geen VMX aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  Geldige VMX en VMDK
@REM
if "%VMX%"=="1" if "%VMDK%"=="1" (
        @REM Stoppen eventueel draaiende virtuele machine
        @vmrun -T ws stop %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige virtuele machine
        @vmrun -T ws DeleteVM %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
        for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
        @REM
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
@REM ==== [6] NextCloud ===================================================================================================================================
@REM
@REM
@REM
@REM
:NextCloud
@REM
@REM
@REM
@REM
@echo off
@cls
@REM
@REM  Aanmaken directory structuur op NextCloud shared disk
@REM
@REM  Vanaf 17 juli 2026 op D schijf en niet meer op C schijf 
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @mkdir D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DB-01 >nul 2>&1
    @mkdir D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01 >nul 2>&1
    @mkdir D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-RD-01 >nul 2>&1
    @mkdir D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-WS-01 >nul 2>&1
)
@REM
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM      ::::
@REM      ::::    VMDK
@REM      ::::
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK" (
        @REM
        @REM    Bepalen of het aanwezige VMDK bestand op NextCloud ouder is dan 30 dagen
        @REM
        forfiles /p "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01" /m "SXN-DC-01.VMDK" /d -21 >nul 2>&1
        @REM
        if %errorlevel%==0 (
            @REM
            @echo VMDK Bestand op NextCloud is ouder dan 21 dagen
            @echo Verwijderen VDMK bestand op NextCloud 
            @REM
            del "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK"
            @REM
        )
    )
)
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF NOT EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK" (
        @REM
        @echo Overzetten VMDK uit VM Directory naar NextCloud
        @REM
        @robocopy %VMWVMHome%\Windows\Server\2022\SXN-DC-01 D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01 SXN-DC-01.VMDK /MT:16 /J /ETA
        @REM
        @REM copy %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01
        @REM
    )
)
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK" (
        @echo Ruimte besparen NextCloud 
        attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMDK"
    )
)
@REM
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM      ::::
@REM      ::::    VMX
@REM      ::::
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF EXIST D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX (
        @REM
        forfiles /p "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01" /m "SXN-DC-01.VMX" /d -30 >nul 2>&1
        @REM
        if %errorlevel%==0 (
            @REM
            @echo VMX is aanwezig maar ouder dan 30 dagen
            @echo Verwijderen VMX 
            @REM
            del "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX"
        )
    )
)
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF NOT EXIST D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX (
        @REM
        @REM  VMX bestand is niet aanwezig
        @REM
        @echo Overzetten VMX uit VM Directory naar NextCloud
        @copy %VMWVMHome%\Windows\Server\2022\SXN-DC-01\SXN-DC-01.vmx D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01
    )
)
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX" (
        @echo Ruimte besparen NextCloud 
        attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\SXN-DC-01\SXN-DC-01.VMX"
    )
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
@REM ==== [8] Opschonen ===================================================================================================================================
@REM
@REM
@REM
@REM
:Opschonen
@REM
@REM
@REM
@REM
@REM
@IF EXIST "%VHDBestandVMDK%" (
    del /F /S /Q %HyperVVMHOME%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
) 
@REM
@REM  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=%VMWVMHome%\Windows\Server\2022\SXN-DC-01"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
@REM
@REM  VMX is aanwezig maar VMDK niet
@REM
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  VMDK is aanwezig maar VMX niet
@REM
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
)
@REM
@REM  VMDK is aanwezig en VDMK is aanwezig 
@REM
if "%VMX%"=="1" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\SXN-DC-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\SXN-DC-01\*") do rd /s /q "%%d"
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
@REM
@REM
@REM
:einde
@REM
@echo off
@cls
@REM
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: SXN-DC-01 virtuele machine Manager                               :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@echo Einde Script !
@REM
exit /b
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