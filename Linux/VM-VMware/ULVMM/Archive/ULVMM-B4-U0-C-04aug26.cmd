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
Set "ULVMMBuild=4"
Set "ULVMMUpdate=0"
::
::  Datum   4 augustus 2026
::
::  By John Tutert
::
::  For Personal and/or Educational use only ! 
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
    @CLS
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Declaratie Variabelen Gebruiker
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Declaratie variabelen gebruiker
::
::  Schijf en directory met virtuele machines VMWare Workstation Pro
@set "VMwWrkVMPath=D:\Virtual-Machines\VMware-Workstation-PRO"
::  Naam van de directory met Linux virtuele machines default is Linux
@set "VMwWrkLinuxVM=Linux"
::  Naam van de directory met Windows virtuele machines default is Windows
@set "VMwWrkWindowsVM=Windows"
::  Naam van de directory met Debian Linux virtuele machines default is Debian
@set "VMwWrkDebianVM=Debian"
::  Naam van de directory met Ubuntu Linux virtuele machines default is Ubuntu
@set "VMwWrkUbuntuVM=Ubuntu"
::  Naam van de directory met Debian Desktop virtuele machines default is desktop
@set "VMwWrkDebianVMDName=Desktop"
::  Naam van de directory met Desktop Server virtuele machines default is server 
@set "VMwWrkDebianVMSName=Server"
::  Naam van de directory met Ubuntu Desktop virtuele machines default is desktop
@set "VMwWrkUbuntuVMDName=Desktop"
::  Naam van de directory met Ubuntu Server virtuele machines default is server
@set "VMwWrkUbuntuVMSName=Server"
::
::  Schijf en directory met daarin templates (sjablonen) voor virtuele machines 
@set "VMTemplates=D:\Virtual-Machines\Templates"
::  Naam van de directory met Linux tempates default is Linux
@set "LinuxTemplates=Linux"
::  Naam de directory met Debian templates
@set "DebianTemplates=Debian"
::  Naam van de directory met Ubuntu templates
@set "UbuntuTemplates=Ubuntu"
::  Naam van de directory met Desktop templates
@set "DesktopTemplates=Regular"
::  Naam van de directory met Server templates
@set "ServerTemplates=Minimal"
::
::
@set "ISOLocation=D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen"
::
::
@set "Debian12DesktopVMName=D12-BKW-D-LAB-001"
@set "Debian12ServerVMName=D12-BKW-S-LAB-001"
::
@set "Debian13DesktopVMName=D13-TRX-D-LAB-001"
@set "Debian13ServerVMName=D13-TRX-S-LAB-001"
::
@set "Ubuntu24DesktopVMName=U24-LTS-D-LAB-001"
@set "Ubuntu24ServerVMName=U24-LTS-S-LAB-001"
@set "Ubuntu24DockerVMName=U24-LTS-S-DKR-001"
::
@set "Ubuntu26DesktopVMName=U26-LTS-D-LAB-001"
@set "Ubuntu26ServerVMName=U26-LTS-S-LAB-001"
@set "Ubuntu26DockerVMName=U26-LTS-S-DKR-001"
::
::  Linux Virtual Images Namen
@set "LVIDebian12D=Debian_12.0.0_VMG_LinuxVMImages.COM"
@set "LVIDebian12S=Debian_12.0.0_VMM_LinuxVMImages.COM"
::
@set "LVIDebian13D=Debian_13_VMG_LinuxVMImages.COM"
@set "LVIDebian13S=Debian_13_VMM_LinuxVMImages.COM"
::
@set "LVIUbuntu24D=Ubuntu_24.04_VM_LinuxVMImages.COM"
@set "LVIUbuntu24S=UbuntuServer_24.04_VM_LinuxVMImages.COM"
::
@set "LVIUbuntu26D=Ubuntu_26.04_VM_LinuxVMImages.COM"
::  @set "LVIUbuntu26S=" Niet beschikbaar
::
::  Linux VM Images 
::  Server = Minimal 
::
@set "Debian12DesktopUrl=https://edu.nl/kma6w"
@set "Debian12ServerUrl=https://edu.nl/pegff"
::
@set "Debian13DesktopUrl=https://edu.nl/nd6dx"
@set "Debian13ServerUrl=https://edu.nl/wmdrh"
::
@set "Ubuntu24DesktopUrl=https://edu.nl/38aq4"
@set "Ubuntu24ServerUrl= https://edu.nl/xu78m"
::
@set "Ubuntu26DesktopUrl=https://edu.nl/y6nbm"
::  @set "Ubuntu26ServerUrl= ...."  Niet beschikbaar
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Declaratie Variabelen Script Automatisch
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Declaratie variabelen op basis van omgeving
::
::  Bepaal het totaal aanwezige RAM
@for /f %%i in ('powershell -command "[math]::round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"') do (
    set TotalMemoryGB=%%i
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
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo ::::: Ultimate Linux Virtual Machine Manager                           :::::
@echo ::::: Hoofdmenu                                                        :::::
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo.
@echo %NUMBER_OF_PROCESSORS% vCPU %TotalMemoryGB% GB RAM
@echo.
@echo VMware gevonden in %VMWareInstallPath%
@echo.
@echo [1] Aanmaken Debian VM
@echo [2] Aanmaken Ubuntu VM
@echo [3] x
@echo [4] x
@echo [5] x
@echo [6] x
@echo [7] x
@echo [8] Opruimen VHD en VMX/VMDK van laptop
@echo. 
@echo [9] Verlaten / Einde 
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
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo ::::: Ultimate Linux Virtual Machine Manager                           :::::
@echo ::::: Debian                                                           :::::
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo.
@echo [1] Aanmaken Debian 12 Desktop VM
@echo [2] Aanmaken Debian 12 Server VM
@echo [3] Aanmaken Debian 13 Desktop VM
@echo [4] Aanmaken Debian 13 Server VM
@echo [5] x
@echo [6] Aanmaken Debian 13 met Open Media Vault (OMV)
@echo [7] x
@echo [8] Opruimen VHD en VMX/VMDK van laptop
@echo. 
@echo [9] Hoofdmenu
@echo. 
@choice /C:123456789 /N /M "Maak uw keuze"
@set antwoord=%errorlevel%
::
@if %antwoord%==9 goto :hoofdmenu
@if %antwoord%==8 goto :debiansubmenu
@if %antwoord%==7 goto :debiansubmenu
@if %antwoord%==6 goto :debiansubmenu
@if %antwoord%==5 goto :debiansubmenu
@if %antwoord%==4 goto :debian13server
@if %antwoord%==3 goto :debian13desktop
@if %antwoord%==2 goto :debian12sever
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
@IF EXIST "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel bestaande virtuele machine
::  Verwijderen
::
@IF EXIST "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%.vmx >nul 2>&1
)
::
::  Opruimen eventueel aanwezig bestanden in virtuele machine directory
::
@IF EXIST "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%.vmx" (
    del %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*.vm*
    del %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*.nvram
    del %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*.scoreboard
    del %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*.log
    @for /d %%d in ("%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\*") do rd /s /q "%%d"
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
::  Uitpakken template virtuele machine naar virtuele machine directory 
::
@IF EXIST "%VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z" (
    @echo Uitpakken Debian 12 Desktop Template
    @REM
    @REM    Bestaande virtuele machine is reeds hiervoor opgeruimd door dit script
    @REM
    @7z x %VMTemplates%\%LinuxTemplates%\%DebianTemplates%\12\%DesktopTemplates%\%LVIDebian12D%.7z -o%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName% -y >nul 2>&1
)
::
::  Hernoemen VMX bestand in virtuele machine directory
::
@IF EXIST "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%LVIDebian12D%.vmx" (
    @echo Hernoem Template VMX ...
    @rename "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%LVIDebian12D%.vmx" %Debian12DesktopVMName%.vmx
)
::
::  Hernoemen VMDK bestand in virtuele machine directory
::
@IF EXIST "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%LVIDebian12D%.vmdk" (
    @echo Hernoem Template VMDK ...
    @rename "%VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%LVIDebian12D%.vmdk" %Debian12DesktopVMName%.vmdk
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
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry displayName "%Debian12DesktopVMName%"
::
::
::  ::::::::::::::::
::  Annotation
::  ::::::::::::::::
::
::
@ECHO [VMX] Annotation aanpassen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry annotation "Debian 12 Desktop Gebruiker: debian Wachtwoord: debian"
::
::  ::::::::::::::::
::  Namen bestanden in VMX
::  ::::::::::::::::
::
@echo [VMX] Namen bestanden aanpassen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry scsi0:0.fileName "%Debian12DesktopVMName%.vmdk"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry extendedConfigFile "%Debian12DesktopVMName%.vmxf"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry nvram "%Debian12DesktopVMName%.nvram"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry vmxstats.filename "%Debian12DesktopVMName%.scoreboard"
::
::  ::::::::::::::::
::  CPU
::  ::::::::::::::::
::
@echo [VMX] PRocessor instellen %Debian12DesktopVMName%
@SET /a div_result=%NUMBER_OF_PROCESSORS% / 3
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry numvcpus "%div_result%"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
::
::  ::::::::::::::::
::  RAM
::  ::::::::::::::::
::
@echo [VMX] RAM Geheugen instellen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry memsize "%QuarterMemoryMB%"
::
::  ::::::::::::::::
::  Storage
::  ::::::::::::::::
::
::  RAID DISK 0
::
@echo [VMX] RAID DISK 0 toevoegen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk Create -f %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\RaidDisk0.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo nvme0:0 disk RaidDisk0.vmdk 1 
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetPresent nvme0:0 1 
::
::  RAID DISK 1
::
@echo [VMX] RAID DISK 1 toevoegen %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk Create -f %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\RaidDisk1.vmdk -a lsilogic -s 64GB -t 0 >nul 2>&1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx nvme SetPresent nvme0 1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo nvme0:1 disk RaidDisk1.vmdk 1 
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetPresent nvme0:1 1 
::
::
::  CD-ROM Drive 
@echo [VMX] CD-ROM Drive configuratie %Debian12DesktopVMName%
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Sata SetPresent sata0 1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetBackingInfo sata0:0 cdrom_image "%MediaPath%\%MediaFile%" 1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Disk SetPresent sata0:0 1
::
::  ::::::::::::::::
::  Netwerk
::  ::::::::::::::::
::
::  NIC0 Genereer MAC adres
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetAddressType ethernet0 generated ""
::
::  NIC1 Toevoegen Netwerkkaart type instellen beschikbare opties: vlance vmxnet e1000e vmxnet3 vrdma
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetVirtualDevice ethernet1 vmxnet
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetConnectionType ethernet1 custom
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetLinkStatePropagation ethernet1 true
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetPresent ethernet1 1
::  NIC1 VMNet1
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ethernet1.vnet "VMnet1"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ethernet1.displayName "VMnet1"
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx Ethernet SetAddressType ethernet1 generated ""
::
::  ::::::::::::::::
::  Hyper-V
::  ::::::::::::::::
::
::  Disable Side Channeld migitations for Hyper-V Enabled Hosts
::
@"%VMWareInstallPath%"\vmcli %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx ConfigParams SetEntry ulm.disableMitigations "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VMX Openen in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Openen %Debian12DesktopVMName%
@IF EXIST %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx (
    @start /B "" "%VMWareInstallPath%\vmware.exe" -n %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  VM starten in VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Starten %Debian12DesktopVMName%
@IF EXIST %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx (
    start /B "" "%VMWareInstallPath%\vmrun.exe" -T ws start %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName%\%Debian12DesktopVMName%.vmx
)
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




@goto debiansubmenu
::








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
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  ::::::::
::  ::::::::    Functies
::  ::::::::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
@mkdir %VMwWrkVMPath%\%VMwWrkLinuxVM%\%VMwWrkDebianVM%\12\%VMwWrkDebianVMDName%\%Debian12DesktopVMName% >nul 2>&1
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

