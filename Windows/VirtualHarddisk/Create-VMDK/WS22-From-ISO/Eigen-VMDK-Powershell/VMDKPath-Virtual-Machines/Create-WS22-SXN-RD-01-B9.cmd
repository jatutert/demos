::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  SXN-RD-01 Virtual Machine Manager
::  Windows Command Prompt 
::
::  Build 8
::  24 juli 2026
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
:hoofdmenu
::
@CLS
::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: SXN-RD-01 virtuele machine Manager                               :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo [1] Downloaden ISO Bestanden
echo [2] Aanmaken SXN-RD-01 VHD
echo [3] Aanmaken SXN-RD-01 VMDK en VMX
echo [4] Starten VMWare Workstation Pro SXN-RD-01 virtuele machine
echo [5] Overzetten SXN-RD-01 VMDK en VMX naar NextCloud
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
if %antwoord%==6 goto :hoofdmenu
if %antwoord%==5 goto :NextCloud
if %antwoord%==4 goto :VMWStartVM
if %antwoord%==3 goto :VMWManager
if %antwoord%==2 goto :VHDManager
if %antwoord%==1 goto :ISODownload
goto :hoofdmenu
::
::
::
::
:: ==== [1] ISODownload ===================================================================================================================================
::
::
::
::
::
:ISODownload
::
::
::
::
start /MAX chrome.exe https://massgrave.dev/windows-server-links#windows-server-2022
start /MAX chrome.exe https://massgrave.dev/windows_11_links
::
::
::
::
::
goto hoofdmenu
::
::
::
::
:: ==== [2] VHDManager ===================================================================================================================================
::
::
::
::
::
:VHDManager
::
::
::
::
@echo off
@cls
::
::  Aanmaken noodzakelijke directories en subdirectories voor VHD omgeving 
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\ >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
::  Controleren leeftijd van eventueel aanwezige VHD
::
@IF EXIST "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" (
    @REM
    forfiles /p "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01" /m "SXN-RD-01.VHD" /d -21 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo Het VHD Bestand is aanwezig maar ouder dan 21 dagen
        @echo Verwijderen VHD bestand op D schijf 
        @REM
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01"\*.* >nul 2>&1
        @REM
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory 
        for /d %%d in ("D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
        @REM
    ) else (
        @REM
        @echo VHD bestand is aanwezig en is niet ouder dan 21 dagen.
        @echo VHD bestand blijft daarom behouden. 
        @REM
    )
)
::
::  Controle aanwezigheid ISO bestand  
::
Set "ISOVHDBestand=C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\en-us_windows_server_2022_updated_latest.iso"
::
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
::
::  Controle aanwezigheid Powershell script
::
Set "PowershellScriptBestand=D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-RD-01\WS22-SXN-RD-01-Create-VHD-Latest.ps1"
::
@IF NOT EXIST "%PowershellScriptBestand%" (
    @echo Powershell Script voor conversie is NIET gevonden
    @echo.
    @echo VHD kan NIET aangemaakt worden ... 
    @echo.
    @echo Maak WS22-SXN-RD-01-Create-VHD-Latest.ps1
    @echo.
    @pause
    goto hoofdmenu
)
::
::  Aanmaken VHD bestand indien niet aanwezig 
::
@IF NOT EXIST "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" (
    @REM    VHD bestand is niet aanwezig
    @REM 
    @REM    Powershell script voor aanmaken van VHD wordt gestart
    @REM
    @echo   Aanmaken VHD bestand ...
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-RD-01"\WS22-SXN-RD-01-Create-VHD-Latest.ps1
    @echo   VHD bestand is aangemaakt ... 
)
::
::
::
::
::
goto hoofdmenu
::
::
::
::
:: ==== [3] VMWManager ===================================================================================================================================
::
::
::
::
::
:VMWManager
::
::
::
::
@echo off
@cls
::
::  Aanmaken noodzakelijke directories en subdirectories VMWare Workstation Pro virtuele machines 
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMDK
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  Ongeldig VMX
::
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM
    @REM Er is wel een VMX gevonden maar geen VMDK aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
)
::
::  Ongeldig VMDK
::
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM
    @REM Er is wel een VMDK gevonden maar geen VMX aangetroffen
    @REM
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
)
::
::  Geldig VMX en VMDK
::
if "%VMX%"=="1" if "%VMDK%"=="1" (
    @REM
    @REM Er is zowel een VMX als een VMDK aangetroffen 
    @REM
    @REM    Controleer of het aanwezige VMDK bestand niet ouder is dan 22 dagen (maand) 
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01" /m "SXN-RD-01.VMDK" /d -22 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @REM Stoppen eventueel draaiende virtuele machine
        @vmrun -T ws stop D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige virtuele machine
        @vmrun -T ws DeleteVM D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx >nul 2>&1
        @REM Verwijderen eventueel aanwezige bestanden
        @del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
        @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
        for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
        @REM
    ) else (
        @REM
        @echo VMDK van Virtuele machine is aanwezig en ook niet ouder dan 22 dagen. 
        @echo Er is geen reden om VMDK van de virtuele machine opnieuw aan te maken.
        @REM
    )
    @REM
    @REM    Controleer of het aanwezige VMX bestand niet ouder is dan 22 dagen (maand)
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01" /m "SXN-RD-01.VMX" /d -22 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMX is aanwezig maar ouder dan 22 dagen
        @echo Verwijderen VMX 
        @REM
        del "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMX"
    ) else (
        @REM
        @echo VMX van Virtuele machine is aanwezig en ook niet ouder dan 22 dagen. 
        @echo Er is geen reden om VMX van de virtuele machine opnieuw aan te maken.
        @REM
    )
)
::
::  Controle aanwezigheid ISO bestand  
::
Set "VHDBestandVMDK=D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD"
::
@IF NOT EXIST "%VHDBestandVMDK%" (
    @echo SXN-RD-01 VHD bestand voor conversie is NIET gevonden
    @echo.
    @echo VMDK kan NIET aangemaakt worden ... 
    @echo.
    @echo Zorg voor SXN-RD-01.VHD
    @echo.
    @pause
    goto hoofdmenu
)
::
::  Aanmaken VMDK indien niet aanwezig 
::
@IF NOT EXIST "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK" (
    @REM
    @REM    Aanmaken VDMK door conversie VHD
    @echo   Conversie van VHD naar VMDK gestart ... 
    @"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK" out_file_type=ft_vmdk_ws_growable
    @REM
)
::
::  Aanmaken VMX indien niet aanwezig
::
@IF NOT EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMX (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo   Aanmaken VMX in VM Directory VMWare Workstation 
    @copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-RD-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
)
::
::
::
::
::
goto hoofdmenu
::
::
::
::
:: ==== [4] VMWStartVM ===================================================================================================================================
::
::
::
::
:VMWStartVM
::
::
::
::
@echo off
@cls
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMX (
    @REM
    @echo Openen SXN-RD-01 in VMware Workstation PRO
    @start /B vmware -n D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
    @REM
    @echo Starten VM 
    @start vmrun -T ws start D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx
)
::
::
::
::
::
goto hoofdmenu
::
::
::
::
:: ==== [5] NextCloud ===================================================================================================================================
::
::
::
::
:NextCloud
::
::
::
::
@echo off
@cls
::
::  Aanmaken directory structuur op NextCloud shared disk
::
::  Vanaf 17 juli 2026 op D schijf en niet meer op C schijf 
::
@mkdir D:\Virtual-Machines\Shared\NextCloud\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Shared\NextCloud\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Shared\NextCloud\SXN-WS-01 >nul 2>&1
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMDK
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@IF EXIST "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMDK" (
    @REM
    @REM    Bepalen of het aanwezige VMDK bestand op NextCloud ouder is dan 30 dagen
    @REM
    forfiles /p "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01" /m "SXN-RD-01.VMDK" /d -21 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMDK Bestand op NextCloud is ouder dan 21 dagen
        @echo Verwijderen VDMK bestand op NextCloud 
        @REM
        del "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMDK"
        @REM
    )
)
::
@IF NOT EXIST "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMDK" (
    @REM
    @echo Overzetten VMDK uit VM Directory naar NextCloud
    @REM
    @robocopy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01 D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01 SXN-RD-01.VMDK /MT:16 /J /ETA
    @REM
    @REM copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.VMDK D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01
    @REM
) 
::
@IF EXIST "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMDK" (
    @echo Ruimte besparen NextCloud 
    attrib +U -P "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMDK"
)
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMX
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@IF EXIST D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMX (
    @REM
    forfiles /p "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01" /m "SXN-RD-01.VMX" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMX is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VMX 
        @REM
        del "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMX"
    )
)
::
@IF NOT EXIST D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMX (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo Overzetten VMX uit VM Directory naar NextCloud
    @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\SXN-RD-01.vmx D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01
)
::
@IF EXIST "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMX" (
    @echo Ruimte besparen NextCloud 
    attrib +U -P "D:\Virtual-Machines\Shared\NextCloud\SXN-RD-01\SXN-RD-01.VMX"
)
::
::
::
::
::
goto hoofdmenu
::
::
::
::
:: ==== [8] Opschonen ===================================================================================================================================
::
::
::
::
:Opschonen
::
::
::
::
::
@IF EXIST "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD" (
    del /F /S /Q D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\*.* >nul 2>&1
) 
::
::  Controleer aanwezigheid van VMX en VMDK in de directory van de virtuele machine 
set "DIR=D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01"
dir /b "%DIR%\*.vmx" >nul 2>&1 && set VMX=1 || set VMX=0
dir /b "%DIR%\*.vmdk" >nul 2>&1 && set VMDK=1 || set VMDK=0
::
::  VMX is aanwezig maar VMDK niet
::
if "%VMX%"=="1" if "%VMDK%"=="0" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
)
::
::  VMDK is aanwezig maar VMX niet
::
if "%VMX%"=="0" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
)
::
::  VMDK is aanwezig en VDMK is aanwezig 
::
if "%VMX%"=="1" if "%VMDK%"=="1" (
    @REM Verwijderen eventueel aanwezige bestanden
    del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*.* >nul 2>&1
    @REM Verwijder ook eventueel aanwezige subdirectories in de directory van de virtuele machine
    for /d %%d in ("D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-RD-01\*") do rd /s /q "%%d"
)
::
::
::
::
::
goto hoofdmenu
::
::
::
::
::
:: ==== [9] EINDE ===================================================================================================================================
::
::
::
::
:einde
::
@echo off
@cls
::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::::: SXN-RD-01 virtuele machine Manager                               :::::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Einde Script !
::
exit /b
::
::      Thats all folks
::
::      This is the end
::      Hold your breath and count to ten
::      Feel the Earth move and then
::      Hear my heart burst again
::      For this is the end
::      I've drowned and dreamt this moment
::      So overdue, I owe them
::      Swept away, I'm stolen
::
::      Adelle
::