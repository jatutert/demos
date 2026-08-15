@REM
@REM   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM     TT    U    U    TT    SS      O    O  FF        TT
@REM     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM     TT    U    U    TT        SS  O    O  FF        TT
@REM     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM
@REM  Virtual Machine Manager
@REM  Windows Command Prompt 
@REM
@REM  Build 15
@REM  15 Augustus 2026
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
    @REM
    @cls
    @echo.
    echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo ::::: Windows Virtuele machine Manager
    echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo.
    @IF "%COMPUTERNAME%"=="CND0475SYS" (
        echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
    )   
    echo VMware gevonden in %VMWareInstallPath%
    echo.
    @REM
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT /b 0
)
@REM
@REM
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM  ::::::::
@REM  ::::::::    Declaratie Variabelen
@REM  ::::::::
@REM  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
    Set "PSISOVHDScriptDirectory=%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%VirtMachName%"
    Set "PSISOVHDScriptFile=WS22-%VirtMachName%-Create-VHD-Latest.ps1"
)
@REM
@REM    Privelaptop
@REM
IF %COMPUTERNAME% == PF6FNDPL (
    Set "PSISOVHDScriptDirectory=%GithubHome%\demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%VirtMachName%"
    Set "PSISOVHDScriptFile=WS22-%VirtMachName%-Create-VHD-Latest.ps1"
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
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
echo [1] Downloaden ISO Bestanden
echo [2] Aanmaken %VirtMachName% VHD
echo [3] Aanmaken %VirtMachName% VMDK en VMX
echo [4] Starten VMWare Workstation Pro %VirtMachName% virtuele machine
echo [5] Stop en verwijder VMWare Workstation Pro %VirtMachName% virtuele machine 
echo [6] Overzetten %VirtMachName% VMDK en VMX naar NextCloud
echo [7] x
echo [8] Opruimen VHD en VMX/VMDK van laptop
echo. 
echo [9] Verlaten / Einde 
echo. 
@REM echo Maak uw keuze 
@REM
choice /C:123456789 /N /M "Maak uw keuze"
set hfd_menu_keuze=%errorlevel%
@REM
if %hfd_menu_keuze% EQU 9 goto :einde
if %hfd_menu_keuze% EQU 8 goto :cleanall
if %hfd_menu_keuze% EQU 7 goto :hoofdmenu
if %hfd_menu_keuze% EQU 6 goto :nxtcld
if %hfd_menu_keuze% EQU 5 goto :delvmx
if %hfd_menu_keuze% EQU 4 goto :runvmx
if %hfd_menu_keuze% EQU 3 goto :vhdvmdk
if %hfd_menu_keuze% EQU 2 goto :visonvhd
if %hfd_menu_keuze% EQU 1 goto :dwndiso
goto :hoofdmenu
@REM
@REM
@REM
@REM
@REM ==== [1] ISODwnld ===================================================================================================================================
@REM
:dwndiso
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@REM
@REM
start /MAX chrome.exe https://massgrave.dev/windows-server-links#windows-server-%WindowsVersie%
start /MAX chrome.exe https://massgrave.dev/windows_11_links
@REM
@REM
@REM
goto hoofdmenu
@REM
@REM
@REM
@REM
@REM ==== [2] ISO2VHD ===================================================================================================================================
@REM
:visonvhd
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@REM    Stap 0A Aanmaken noodzakelijke directories en subdirectories VHD 
@REM
@mkdir %HyperVVMHOME%\Windows\ >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client\11 >nul 2>&1
@REM
@mkdir %HyperVVMHOME%\Windows\Server\ >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\%WindowsVersie% >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName% >nul 2>&1
@REM
@REM
@REM    Stap 0B Aanmaken noodzakelijke directories en subdirectories VMWare Workstation Pro virtuele machines 
@REM
@mkdir %VMWVMHome%\Windows\ >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Client\ >nul 2>&1
@mkdir %VMWVMHome%\Windows\Client\11 >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Server\ >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\%WindowsVersie% >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName% >nul 2>&1
@REM
@REM
@REM
@REM    Stap 1  Controleren leeftijd van eventueel aanwezige VHD
@REM
@IF EXIST "%VHDBestandVMDK%" (
    @REM
    forfiles /p "%HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName%" /m "%VirtMachName%.VHD" /d -30 >nul 2>&1
    @REM
    if %errorlevel% EQU 0 (
        @REM
        @echo Het VHD Bestand is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VHD bestand op D schijf 
        @REM
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q "%HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName%"\*.* >nul 2>&1
        @REM
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory 
        for /d %%d in ("%HyperVVMHOME%\Windows\Server\%WindowsVersie%\%VirtMachName%\*") do rd /s /q "%%d"
        @REM
    ) else (
        @REM
        @echo VHD bestand is aanwezig en is niet ouder dan 30 dagen.
        @echo VHD bestand blijft daarom behouden. 
        @pause
        @REM
    )
)
@REM
@REM    Stap 2  Controle aanwezigheid ISO bestand  
@REM
@IF NOT EXIST "%ISOVHDBestand%" (
    @echo Windows Server %WindowsVersie% ISO bestand voor conversie is NIET gevonden
    @echo.
    @echo VHD kan NIET aangemaakt worden ... 
    @echo.
    @echo Zorg voor en-us_windows_server_2022_updated_latest.iso
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM    Stap 3  Controle aanwezigheid Powershell script
@REM
Set "PowershellScriptBestand=%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\%VirtMachName%\WS22-%VirtMachName%-Create-VHD-Latest.ps1"
@REM
@IF NOT EXIST "%PowershellScriptBestand%" (
    @echo Powershell Script voor conversie is NIET gevonden
    @echo.
    @echo VHD kan NIET aangemaakt worden ... 
    @echo.
    @echo Maak WS22-%VirtMachName%-Create-VHD-Latest.ps1
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM    Stap 4  Aanmaken VHD bestand indien niet aanwezig 
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
goto hoofdmenu
@REM
@REM
@REM
@REM ==== [3] vhd2vmdk ===================================================================================================================================
@REM
:vhdvmdk
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@REM   Stap 0A Aanmaken noodzakelijke directories en subdirectories VHD 
@REM
@mkdir %HyperVVMHOME%\Windows >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Client\11 >nul 2>&1
@REM
@mkdir %HyperVVMHOME%\Windows\Server >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022 >nul 2>&1
@mkdir %HyperVVMHOME%\Windows\Server\2022\%VirtMachName% >nul 2>&1
@REM
@REM
@REM   Stap 0B Aanmaken noodzakelijke directories en subdirectories VMWare Workstation Pro virtuele machines 
@REM
@mkdir %VMWVMHome%\Windows\ >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Client >nul 2>&1
@mkdir %VMWVMHome%\Windows\Client\11 >nul 2>&1
@REM
@mkdir %VMWVMHome%\Windows\Server >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\2022 >nul 2>&1
@mkdir %VMWVMHome%\Windows\Server\2022\%VirtMachName% >nul 2>&1
@REM
@REM    Stap 1 Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
@REM 
@REM ==============================================================================================================================
@REM set "VM_Check_DIR_NAME=D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\%VirtMachName%"
@REM dir /b "%VM_Check_DIR_NAME%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
@REM dir /b "%VM_Check_DIR_NAME%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
@REM ==============================================================================================================================
@REM
@REM    GEEN VMX gevonden en daarom alles verwijderen
@REM
IF NOT EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%"\%VirtMachName%\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM    WEL VMX Gevonden
@REM
IF EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX" (
    @REM
    @REM    Geen VMDK gevonden en daarom alles verwijderen
    @REM
    IF NOT EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
        @REM Verwijderen eventueel aanwezige bestanden
        del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%"\%VirtMachName%\*.* >nul 2>&1
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
        for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
    )
    @REM
    @REM    Wel VMDK gevonden
    @REM
    IF EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
      @REM    Controleer of het aanwezige VMDK bestand niet ouder is dan 30 dagen
      forfiles /p "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%" /m "%VirtMachName%.VMDK" /d -30 >nul 2>&1
      if %errorlevel%=="0" (
            @echo VMDK is aanwezig maar ouder dan 30 dagen
            @REM Stoppen eventueel draaiende virtuele machine
            @%VMWareInstallPath%\vmrun -T ws stop "%VMXBestandVM%" >nul 2>&1
            @REM Verwijderen eventueel aanwezige virtuele machine
            @%VMWareInstallPath%\vmrun -T ws DeleteVM "%VMXBestandVM%" >nul 2>&1
            @REM Verwijderen eventueel aanwezige bestanden
            @del /F /S /Q D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\*.* >nul 2>&1
            @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
            for /d %%d in ("%VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\*") do rd /s /q "%%d"
      ) else (
            @REM
            @echo VMDK bestand is aanwezig en is niet ouder dan 30 dagen.
            @echo VMDK bestand blijft daarom behouden. 
            @pause
            @REM
      )
    )
)
@REM
@REM ==============================================================================================================================
@REM
@REM @REM
@REM @REM  Stap 1    Ongeldig VMX
@REM @REM
@REM if "%VMX%"=="1" if "%VMDK%"=="0" (
@REM     @REM
@REM     @REM Er is wel een VMX gevonden maar geen VMDK aangetroffen
@REM     @REM
@REM )
@REM @REM
@REM @REM  Stap 1    Ongeldig VMDK
@REM @REM
@REM if "%VMX%"=="0" if "%VMDK%"=="1" (
@REM     @REM
@REM     @REM Er is wel een VMDK gevonden maar geen VMX aangetroffen
@REM     @REM
@REM     @REM Verwijderen eventueel aanwezige bestanden
@REM     del /F /S /Q "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022"\%VirtMachName%\*.* >nul 2>&1
@REM     @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
@REM     for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
@REM )
@REM @REM
@REM @REM  Stap 1    Geldig VMX en VMDK
@REM @REM
@REM if "%VMX%"=="1" if "%VMDK%"=="1" (
@REM     @REM    Er is zowel een VMX als een VMDK aangetroffen
@REM     @REM
@REM     @REM    ##########################################
@REM     @REM    VMDK 
@REM     @REM    ##########################################
@REM     @REM
@REM     @REM    Controleer of het aanwezige VMDK bestand niet ouder is dan 30 dagen
@REM     forfiles /p "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\%VirtMachName%" /m "%VirtMachName%.VMDK" /d -30 >nul 2>&1
@REM     @REM
@REM     if %errorlevel%=="0" (
@REM         @REM
@REM         @echo VMDK is aanwezig maar ouder dan 22 dagen
@REM         @echo Verwijderen Virtuele Machine
@REM         @REM
@REM         @REM Stoppen eventueel draaiende virtuele machine
@REM         @%VMWareInstallPath%\vmrun -T ws stop "%VMXBestandVM%" >nul 2>&1
@REM         @REM Verwijderen eventueel aanwezige virtuele machine
@REM         @%VMWareInstallPath%\vmrun -T ws DeleteVM "%VMXBestandVM%" >nul 2>&1
@REM         @REM Verwijderen eventueel aanwezige bestanden
@REM         @del /F /S /Q D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\%VirtMachName%\*.* >nul 2>&1
@REM         @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
@REM         for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
@REM         @REM
@REM     )
@REM     @REM
@REM     @REM    ##########################################
@REM     @REM    VMX
@REM     @REM    ##########################################
@REM     @REM
@REM     @REM    Controleer of het aanwezige VMX bestand niet ouder is dan 30 dagen
@REM     forfiles /p "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\%VirtMachName%" /m "%VirtMachName%.VMX" /d -30 >nul 2>&1
@REM     @REM
@REM     if %errorlevel%=="0" (
@REM         @REM
@REM         @echo VMX is aanwezig maar ouder dan 22 dagen
@REM         @echo Verwijderen Virtuele Machine
@REM         @REM
@REM         @REM Stoppen eventueel draaiende virtuele machine
@REM         @vmrun -T ws stop "%VMXBestandVM%" >nul 2>&1
@REM         @REM Verwijderen eventueel aanwezige virtuele machine
@REM         @vmrun -T ws DeleteVM "%VMXBestandVM%" >nul 2>&1
@REM         @REM Verwijderen eventueel aanwezige bestanden
@REM         @del /F /S /Q D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\2022\%VirtMachName%\*.* >nul 2>&1
@REM         @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
@REM         for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
@REM         @REM
@REM     )
@REM )
@REM
@REM ==============================================================================================================================
@REM


@REM
@REM    Stap 2  Controle aanwezigheid VHD bestand voor aanmaak van VMDK
@REM
@IF NOT EXIST "D:\Virtualization-Home\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VHD" (
    @echo %VirtMachName% VHD bestand voor conversie is NIET gevonden
    @echo.
    @echo VMDK kan NIET aangemaakt worden ... 
    @echo.
    @echo Zorg voor %VirtMachName%.VHD
    @echo.
    @pause
    goto hoofdmenu
)
@REM
@REM   Stap 3  Aanmaken VMDK indien niet aanwezig 
@REM
@IF NOT EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
    @REM
    @REM    Aanmaken VDMK door conversie VHD
    @echo.
    @echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @echo ::::: %VirtMachName% virtuele machine Manager
    @echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @echo.
    @echo Conversie van VHD naar VMDK gestart ... 
    @"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%VHDBestandVMDK%" out_file_name="%VMDKBestandVM%" out_file_type=ft_vmdk_ws_growable
    @REM
)
@REM
@REM   Stap 4   Log bestanden overzetten naar C: schijf zodat ze niet mee worden genomen in update naar GitHub
IF EXIST "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VMDK\WS22-From-ISO\Eigen-VMDK-Powershell\VMDKPath-Virtual-Machines\logs\*.log" (
    @robocopy "%GithubHome%\Demos\Windows\VirtualHarddisk\Create-VMDK\WS22-From-ISO\Eigen-VMDK-Powershell\VMDKPath-Virtual-Machines\logs" "C:\Program Files\StarWind Software\StarWind V2V Converter\logs" *.log /MOV
)
@REM
@REM   Stap 5   Aanmaken VMX indien niet aanwezig
@REM
@IF NOT EXIST "D:\Virtualization-Home\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX" (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo   Aanmaken VMX in VM Directory VMWare Workstation 
    @copy "%GithubHome%\Demos\Windows\Hypervisor\VMware-Desktop\VMX\%VirtMachName%.vmx" "%VMXBestandVM%"
)
@REM
@REM
goto hoofdmenu
@REM
@REM
@REM ==== [4] VMWRunVM ===================================================================================================================================
@REM
:runvmx
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@IF EXIST %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX (
    @REM
    @echo Openen %VirtMachName% in VMware Workstation PRO
    @start /B vmware -n %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.vmx
    @REM
    @echo Starten VM 
    @start vmrun -T ws start %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.vmx
)
@REM
goto hoofdmenu
@REM
@REM ==== [5] Delete VMX ===================================================================================================================================
@REM
:delvmx
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@REM
@REM  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=%VMWVMHome%\Windows\Server\2022\%VirtMachName%"
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
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\%VirtMachName%\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM  Ongeldig VMDK
@REM
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM
    @REM Er is wel een VMDK gevonden maar geen VMX aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q %VMWVMHome%\Windows\Server\2022\%VirtMachName%\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
)
@REM
@REM  Geldige VMX en VMDK
@REM
if "%VMX%"=="1" if "%VMDK%"=="1" (
        @REM Stoppen eventueel draaiende virtuele machine
        @vmrun -T ws stop %VMWVMHome%\Windows\Server\2022\%VirtMachName%\%VirtMachName%.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige virtuele machine
        @vmrun -T ws DeleteVM %VMWVMHome%\Windows\Server\2022\%VirtMachName%\%VirtMachName%.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q %VMWVMHome%\Windows\Server\2022\%VirtMachName%\*.* >nul 2>&1
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
        for /d %%d in ("%VMWVMHome%\Windows\Server\2022\%VirtMachName%\*") do rd /s /q "%%d"
        @REM
)
@REM
@REM
goto hoofdmenu
@REM
@REM
@REM ==== [6] NextCloud ===================================================================================================================================
@REM
@REM
:nxtcld
@REM
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    echo Werk laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
@IF %COMPUTERNAME% == PF6FNDPL (
    echo Prive laptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
@REM
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
@REM
@REM  Aanmaken directory structuur op NextCloud shared disk
@REM
@REM  Vanaf 17 juli 2026 op D schijf en niet meer op C schijf 
@REM
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    @mkdir D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\2022\%VirtMachName% >nul 2>&1
)
@REM
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM      ::::
@REM      ::::    VMDK
@REM      ::::
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
        @REM
        @REM    Bepalen of het aanwezige VMDK bestand op NextCloud ouder is dan 30 dagen
        @REM
        forfiles /p "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%" /m "%VirtMachName%.VMDK" /d -21 >nul 2>&1
        @REM
        if %errorlevel% EQU 0 (
            @REM
            @echo VMDK Bestand op NextCloud is ouder dan 21 dagen
            @echo Verwijderen VDMK bestand op NextCloud 
            @REM
            del "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK"
            @REM
        )
    )
)
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    @IF NOT EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
        @REM
        @echo Overzetten VMDK uit VM Directory naar NextCloud
        @REM
        @robocopy %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName% D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName% %VirtMachName%.VMDK /MT:16 /J /ETA
        @REM
        @REM copy %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%
        @REM
    )
)
@REM
@IF  %COMPUTERNAME% == CND0475SYS (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK" (
        @echo Ruimte besparen NextCloud 
        attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMDK"
    )
)
@REM
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM      ::::
@REM      ::::    VMX
@REM      ::::
@REM      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    @IF EXIST D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX (
        @REM
        forfiles /p "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%" /m "%VirtMachName%.VMX" /d -30 >nul 2>&1
        @REM
        if %errorlevel% EQU 0 (
            @REM
            @echo VMX is aanwezig maar ouder dan 30 dagen
            @echo Verwijderen VMX 
            @REM
            del "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX"
        )
    )
)
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    @IF NOT EXIST D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX (
        @REM
        @REM  VMX bestand is niet aanwezig
        @REM
        @echo Overzetten VMX uit VM Directory naar NextCloud
        @copy %VMWVMHome%\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.vmx D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%
    )
)
@REM
@IF %COMPUTERNAME% == CND0475SYS (
    @IF EXIST "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX" (
        @echo Ruimte besparen NextCloud 
        attrib +U -P "D:\SurfDrive-Home\Virtualization\VirtualMachines\Windows\Server\%WindowsVersie%\%VirtMachName%\%VirtMachName%.VMX"
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
:clearnall
@REM
@REM
@REM
@REM
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
@cls
@echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: %VirtMachName% virtuele machine Manager
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
@IF "%COMPUTERNAME%"=="CND0475SYS" (
    echo Werklaptop %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
)
echo VMware gevonden in %VMWareInstallPath%
echo.
@REM
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

