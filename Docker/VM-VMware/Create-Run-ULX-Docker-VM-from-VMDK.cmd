::
::  VMWare Workstation Pro Virtual Machine Creator
::  Created by John Tutert(TutSOFT)
::
::  For Educational and/or Personal Use ! 
::
::  LUCT 4 Docker demo Edition
::
::  Dit is de script versie van de handleiding 2.1 Virtualisatie 2025-2026
::  Gemaakt voor docenten
::
::  Changelog
::  04juli25 Introductie substap meldingen
::  04juli25 Introductie variabelen in paden 
::  24juli25 Volgorde van het Script aangepast
::  24juli25 Substap meldingen verwijderd 
::  24juli25 Bugfix path
::  24juli25 taskkill van vmware workstation pro 
::  16aug25  auto start vm na inlezen vm en inlezen vmware workstation path uit register
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 0 Schoon scherm 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 
@echo off
@cls
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 1 Administrator rechten check
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% NEQ 0 (
    @echo.
    @echo Script NIET gestart met de vereiste Adminstrator rechten 
    @echo.
    @echo Script wordt afgebroken !
    @echo. 
    @pause
    @exit 1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 2 Instellen dat vanaf nu de variabelen tot endlocal lokaal zijn 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 
@setlocal enabledelayedexpansion
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 3 Aanmaken lokale omgevingsvariabelen voor dit script 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Onderstaande variabele aanpassen naar eigen voorkeur
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  Locatie van download bestanden van Linux VM Images website
@set "VMTemplatePath=D:\Virtual-Machines\Templates\Linux\Ubuntu\Server\24-04-0-LTS"
@mkdir %VMTemplatePath% >nul 2>&1
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  Onderstaande variabelen NIET aanpassen
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::  Besturingssysteem van de demo
@set "VMOSPath=Linux"
::  Distro van het besturingssysteem van de demo
@set "VMOSDistroPath=Ubuntu"
::  Applicatie bovenop het het besturingssysteem van de demo
@set "VMAPPPath=Docker"
::  Naam van virtuele machine en alle bestanden van de virtuele machine
@set "VirtMachNaam=U24-LTS-S-DKR-001"
::  Naam van de bestanden in het ZIP bestand vanuit download linuxvmimages website
@set "LVI_Inside_ZIP_Filename=UbuntuServer_24.04_VM_LinuxVMImages.COM"
::  Eigen naam gegeven aan ZIP bestand afkomstig van LinuxVMImages website
@set "LVI_Download_ZIP_Filename=LVI-U24-04-LTS-S-VMDK"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 4 Bepalen installatie locatie VMWare Workstation Pro 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@FOR /F "tokens=2,*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 5 Bepalen ingestelde standaard locatie voor virtuele machines in VMW Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
@set "prefFile=%AppData%\VMware\preferences.ini"
for /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    set "rawPath=%%B"
)
:: Verwijder aanhalingstekens uit prefvmx.defaultVMPath
@set "vmPath=%rawPath:"=%"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 6 Tonen welkomscherm gebruiker
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo.
@echo VMWare Workstation Pro Virtual Machine Creator
@echo.
@echo Created by John Tutert (TutSOFT)
@echo.
@echo LUCT 4 Docker Demo Edition (%VirtMachNaam%)
@echo. 
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 7 Eventuele installie software noodzakelijk voor dit script
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
7z >nul 2>&1
if %errorlevel% neq 0 (
   @winget install --id M2Team.NanaZip --silent >%TEMP%\WinGet-NanaZip-Installatie.log
) else (
   echo 7z is aanwezig ... 
)
::
curl -V >nul 2>&1
if %errorlevel% neq 0 (
   @winget install --id cURL.cURL --silent >%TEMP%\WinGet-cURL-Installatie.log
) else (
   echo cURL is aanwezig ...
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 8 Opruimen eventueel aanwezige virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Stoppen eventueel draaiend VMware Workstation PRo
@echo Stoppen eventueel draaiende VMWare Workstation Pro
@taskkill /IM vmware.exe /F
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Stoppen eventueel draaiende virtuele machine
IF EXIST "%vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws stop %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx >nul 2>&1
)
::
::
::	Let OP!
::	Permissie foutmelding als Workstation openstaat door gebruiker met VM
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Verwijderen eventueel aanwezige virtuele machine 
IF EXIST "%vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx" (
    @"%VMWareInstallPath%"\vmrun -T ws DeleteVM %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx >nul 2>&1
)
::
@echo Verwijderen eventueel aanwezige uitgepakte Template bestanden
IF EXIST "%VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmx" (
    @del %VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmx >nul 2>&1
)
::
IF EXIST "%VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmdk" (
    @del %VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmdk >nul 2>&1
)
::
@echo Verwijderen eventueel overgebleven bestanden aanmaak virtuele machine
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmx" (
    @del %VMTemplatePath%\%VirtMachNaam%.vmx >nul 2>&1
)
::
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmdk" (
    @del %VMTemplatePath%\%VirtMachNaam%.vmdk >nul 2>&1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 9 Eventueel downloaden Template van LinuxVMImages website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
IF NOT EXIST "%VMTemplatePath%\%LVI_Download_ZIP_Filename%.7z" (
    @echo Downloaden ZIP-Bestand Even geduld AUB ...
    @curl -s -L -o %VMTemplatePath%\%LVI_Download_ZIP_Filename%.7z https://edu.nl/xu78m
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 10 Uitpakken ZIP bestand afkomstig van LinuxVMImages website
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Uitgepakte bestanden aanmaken in Template directory (7Z)
IF EXIST "%VMTemplatePath%\%LVI_Download_ZIP_Filename%.7z" (
    @7z x %VMTemplatePath%\%LVI_Download_ZIP_Filename%.7z -o%VMTemplatePath% -y >nul 2>&1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 11 HERNOEMEN BESTANDEN
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Hernoemen VMX-bestand naar nieuwe naam
IF EXIST "%VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmx" (
    @rename %VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmx %VirtMachNaam%.vmx
)
@echo Hernoemen VMDK-bestand naar nieuwe naam
IF EXIST "%VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmdk" (
    @rename %VMTemplatePath%\%LVI_Inside_ZIP_Filename%.vmdk %VirtMachNaam%.vmdk
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 12 Zorgen dat noodzakelijk directories aanwezig zijn 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Directories maken
:: Maken OS directories
@mkdir %vmPath%\%VMOSPath% >nul 2>&1
@mkdir %vmPath%\Android >nul 2>&1
@mkdir %vmPath%\ChromeOS >nul 2>&1
@mkdir %vmPath%\Linux >nul 2>&1
@mkdir %vmPath%\MACos >nul 2>&1
@mkdir %vmPath%\Unix >nul 2>&1
@mkdir %vmPath%\Windows >nul 2>&1
:: Maken OS Distro directory
@mkdir %vmPath%\Linux\%VMOSDistroPath% >nul 2>&1
@mkdir %vmPath%\Linux\Debian >nul 2>&1
@mkdir %vmPath%\Linux\Fedora >nul 2>&1
@mkdir %vmPath%\Linux\Mint >nul 2>&1
@mkdir %vmPath%\Linux\Mint\Debian-Edition >nul 2>&1
@mkdir %vmPath%\Linux\Mint\Ubuntu-Edition >nul 2>&1
@mkdir %vmPath%\Linux\RHEL >nul 2>&1
@mkdir %vmPath%\Linux\Ubuntu >nul 2>&1
::
:: Zorgen dat directory voor virtuele machine leeg is door te verwijderen
@rmdir /s /q %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%
::
:: Aanmaken directory voor virtuele machine na eerst verwijderen 
@mkdir %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 13 Bestanden overzetten  
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Uitgepakte bestanden overzetten naar directory voor Virtuele Machine
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmx" (
    @copy %VMTemplatePath%\%VirtMachNaam%.vmx %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath% >nul 2>&1
)
::
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmdk" (
    @copy %VMTemplatePath%\%VirtMachNaam%.vmdk %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath% >nul 2>&1
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 14 Template VMX aanpassen naar eigen settings 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo DisplayName van de virtuele machine aanpassen in de VMX via VMCli
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry displayName "%VirtMachNaam%"
::
@echo Annotation van de virtuele machine aanpassen in de VMX via VMCli
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry annotation "Docker Demo Ubuntu Server 24.04 LTS Gebruiker: ubuntu Wachtwoord: ubuntu"
::
@echo Hardware configuratie van de virtuele machine in de VMX aanpassen via VMCli
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry numvcpus "4"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry memsize "8192"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry scsi0:0.fileName "%VirtMachNaam%.vmdk"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry extendedConfigFile "%VirtMachNaam%.vmxf"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry nvram "%VirtMachNaam%.nvram"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry vmxstats.filename "%VirtMachNaam%.scoreboard"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sata0:1.fileName "D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Linux\Ubuntu\Server\24-04-LTS\ubuntu-24.04-live-server-amd64.iso"
::
@echo Shared Folders van de virtuele machine in de VMX aanpassen via VMCli
::  Shared Folder op Always Enabled zetten 
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry isolation.tools.hgfs.disable "False"
::  Shared Folder Downloads
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.writeAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.hostPath %USERPROFILE%"\Downloads"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.guestName "windownloads"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder0.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder.maxNum "1"
::  Shared Folder OneDrive
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.writeAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.hostPath %USERPROFILE%"\OneDrive"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.guestName "winonedrive"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder1.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder.maxNum "2"
::  Shared Folder Profile zodat oa SSH bestanden benaderd kunnen worden
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.writeAccess "False"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.hostPath %USERPROFILE%
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.guestName "winuserprofile"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder2.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry sharedFolder.maxNum "3"
::  Tijd synchronisatie aanzetten tussen host en guest
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 15 Opruimen Template directory voor toekomstig gebruik
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Opruimen Template directory voor toekomstig gebruik
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmx" (
    @del %VMTemplatePath%\%VirtMachNaam%.vmx >nul 2>&1
)
::
IF EXIST "%VMTemplatePath%\%VirtMachNaam%.vmdk" (
    @del %VMTemplatePath%\%VirtMachNaam%.vmdk >nul 2>&1
)
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 16 Starten VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Nieuw proces starten en daarin nieuwe virtuele machine openen niet starten
IF EXIST %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx (
    @start /B vmware -n %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx 
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 17 Starten Virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Starten van de virtuele machine 
IF EXIST %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx (
    @start /B vmrun -T ws start %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx
)
::
::
@echo Twee minuten wachten voordat LUCT wordt overgezet naar VM
sleep 2m
::
::
@echo Downloaden nieuwste versie LUCT vanaf GitHub
vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx "/bin/curl" -L -o /home/ubuntu/luctv41.sh https://edu.nl/n7faw
@echo Uitvoerbaar maken van LUCT binnen virtuele machine
vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx "/bin/sudo" chmod +x /home/ubuntu/luctv41.sh
::
::
@start /B wt -p "Ubuntu Demo VM"
::
::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	Meerdere manieren om een VM te starten
::
::	@start /B vmware -n %vmPath%\Linux\Docker\%VirtMachNaam%.vmx
::	vmcli %vmPath%\Linux\Docker\%VirtMachNaam%.vmx power start
::	vmrun -T ws start "%vmPath%\Linux\Docker\%VirtMachNaam%.vmx" 
::
:: vmcli %vmPath%\Linux\Docker\%VirtMachNaam%.vmx guest run --username ubuntu --password ubuntu curl -s -L -o u24config.sh ......
::
::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 18 Lokale Variabelen vrijgeven
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@endlocal
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 19 Einde Script
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Thats it folks
::