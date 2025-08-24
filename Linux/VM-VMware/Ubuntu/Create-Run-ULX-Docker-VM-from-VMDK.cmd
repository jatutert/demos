::
::  VMWare Workstation Pro Virtual Machine Creator
::  Created by John Tutert(TutSOFT)
::
::  For Educational and/or Personal Use ! 
::
:: LUCT 4 Docker demo Edition
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
@echo off
@cls
::
@echo.
@echo VMWare Workstation Pro Virtual Machine Creator
@echo.
@echo Created by John Tutert (TutSOFT)
@echo.
@echo LUCT 4 Docker Demo Edition (U24-LTS-S-DKR-001)
@echo. 
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 1 Instellen dat vanaf nu de variabelen tot endlocal lokaal zijn 
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: 
@setlocal enabledelayedexpansion
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 2 Aanmaken lokale omgevingsvariabelen voor dit script 
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Locatie van download bestanden van Linux VM Images website
@set "VMTemplatePath=D:\Virtual-Machines\Templates\Linux\Ubuntu\Server\24-04-0-LTS"
::  Besturingssysteem van de demo
@set "VMOSPath=Linux"
::  Distro van het besturingssysteem van de demo
@set "VMOSDistroPath=Ubuntu"
::  Applicatie bovenop het het besturingssysteem van de demo
@set "VMAPPPath=Docker"
::  Naam van virtuele machine en alle bestanden van de virtuele machine
@set "VirtMachNaam=U24-LTS-S-DKR-001"
::
@set "VMDestinationHigherPath=Linux\Ubuntu"
@set "VMDestinationPath=Linux\Ubuntu\Docker"
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 3 Vullen lokale omgevingsvariabele vmpath
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
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
::  STAP 4 Vullen lokale omgevingsvariabele vmwareinstallpath uit register
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@FOR /F "tokens=2,*" %%a IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\VMware, Inc.\VMware Workstation" /v "InstallPath"') DO SET VMWareInstallPath=%%b
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 5 INSTALLATIE TOOLS
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
::  STAP 6 OPRUIMEN
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Stoppen eventueel draaiend VMware Workstation PRo
@taskkill /IM vmware.exe /F
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Stoppen eventueel draaiende virtuele machine
@"%VMWareInstallPath%"\vmrun -T ws stop %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx >nul 2>&1
::
::
::	Let OP!
::	Permissie foutmelding als Workstation openstaat door gebruiker met VM
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Verwijderen eventueel aanwezige virtuele machine 
@"%VMWareInstallPath%"\vmrun -T ws DeleteVM %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx >nul 2>&1
::
@echo Verwijderen eventueel aanwezige uitgepakte Template bestanden
@del %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx >nul 2>&1
@del %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk >nul 2>&1
::
@echo Verwijderen eventueel overgebleven bestanden aanmaak virtuele machine
@del %VMTemplatePath%\%VirtMachNaam%.vmx >nul 2>&1
@del %VMTemplatePath%\%VirtMachNaam%.vmdk >nul 2>&1
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 7 DOWNLOADEN
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
IF NOT EXIST "%VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z" (
    @echo Downloaden ZIP-Bestand Even geduld AUB ...
    @curl -s -L -o %VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z https://edu.nl/xu78m
) ELSE (
    @echo Ubuntu 24.04 LTS Server Virtuele machine ZIP-bestand is reeds aanwezig
)
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 8 UITPAKKEN
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Uitgepakte bestanden aanmaken in Template directory (7Z)
@7z x %VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z -o%VMTemplatePath% -y >nul 2>&1
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 9 HERNOEMEN BESTANDEN
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Hernoemen VMX-bestand naar nieuwe naam
@rename %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx %VirtMachNaam%.vmx
@echo Hernoemen VMDK-bestand naar nieuwe naam
@rename %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk %VirtMachNaam%.vmdk
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 10 DIRECTORIES
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
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
@echo Uitgepakte bestanden overzetten naar directory voor Virtuele Machine
@copy %VMTemplatePath%\%VirtMachNaam%.* %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath% >nul 2>&1
::
@echo Aanpassen instellingen Virtuele Machine in het VMX-bestand (VMcli)
::
::  DisplayName van de virtuele machine aanpassen in de VMX via VMCli
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry displayName "U24-LTS-S-DKR-001"
::
::  Annotation van de virtuele machine aanpassen in de VMX via VMCli
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry annotation "Docker Demo Ubuntu Server 24.04 LTS Gebruiker: ubuntu Wachtwoord: ubuntu"
::
::  Hardware configuratie
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry numvcpus "4"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry memsize "8192"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry scsi0:0.fileName "U24-LTS-S-DKR-001.vmdk"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry extendedConfigFile "U24-LTS-S-DKR-001.vmxf"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry nvram "U24-LTS-S-DKR-001.nvram"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry vmxstats.filename "U24-LTS-S-DKR-001.scoreboard"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sata0:1.fileName "D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Linux\Ubuntu\Server\24-04-LTS\ubuntu-24.04-live-server-amd64.iso"
::
::  Shared Folder op Always Enabled zetten 
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry isolation.tools.hgfs.disable "False"
::  Shared Folder Downloads
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.writeAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.hostPath %USERPROFILE%"\Downloads"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.guestName "windownloads"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder0.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder.maxNum "1"
::  Shared Folder OneDrive
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.writeAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.hostPath %USERPROFILE%"\OneDrive"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.guestName "winonedrive"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder1.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder.maxNum "2"
::  Shared Folder Profile zodat oa SSH bestanden benaderd kunnen worden
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.present "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.enabled "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.readAccess "True"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.writeAccess "False"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.hostPath %USERPROFILE%
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.guestName "winuserprofile"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder2.expiration "never"
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sharedFolder.maxNum "3"
::  Tijd synchronisatie aanzetten tussen host en guest
@"%VMWareInstallPath%"\vmcli %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 11 Verwijderen uitgepakte bestanden in template directory
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Verwijderen uitgepakte bestanden in template directory 
@del %VMTemplatePath%\%VirtMachNaam%.vmx >nul 2>&1
@del %VMTemplatePath%\%VirtMachNaam%.vmdk >nul 2>&1
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 12 Starten VMware Workstation Pro
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Nieuw proces starten en daarin nieuwe virtuele machine openen niet starten
@start /B vmware -n %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx 
::
::
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::  STAP 13 Starten Virtuele machine 
::  :::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@start vmrun -T ws start %vmPath%\%VMOSPath%\%VMOSDistroPath%\%VMAPPPath%\%VirtMachNaam%.vmx
::
::
::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	Meerdere manieren om een VM te starten
::
::	@start /B vmware -n %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx
::	vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx power start
::	vmrun -T ws start "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" 
::
:: vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx guest run --username ubuntu --password ubuntu curl -s -L -o u24config.sh ......
::
::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 14 Lokale Variabelen vrijgeven
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@endlocal
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 15 Einde Script
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Thats it folks
::