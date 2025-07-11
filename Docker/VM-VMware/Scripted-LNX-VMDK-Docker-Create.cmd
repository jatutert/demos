::
::	Docker Demo using downloaded preconfigured virtual machine
::	Created by John Tutert for TutSOFT
::
::	For Educational and/or Personal Use ! 
::
::
::	Dit is de script versie van de handleiding 2.1 Virtualisatie 2025-2026
::	Gemaakt voor docenten
::
::
@echo off
@cls
::
@echo.
@echo Docker Demo
@echo.
@echo Virtual Machine Creator from Template for Windows 
@echo.
@echo Created by John Tutert for TutSOFT
@echo. 
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 1 VARIABELEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 1] Vullen variabelen voor dit script
::
@echo [Stap 1a] Delayed Expansion aanzetten
@setlocal enabledelayedexpansion
::
@echo [Stap 1b] Bepalen Default VMX Path van VMWare Workstation Pro 
:: Pad naar het Preferences.ini bestand
@set "prefFile=%AppData%\VMware\preferences.ini"
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
for /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    set "rawPath=%%B"
)
:: Verwijder aanhalingstekens uit prefvmx.defaultVMPath
@set "vmPath=%rawPath:"=%"
::
::
::	Virtuele machine Template Path 
::
::
@echo [Stap 1c] Instellen Virtual Machine Template Pad
set "VMTemplatePath=D:\Virtual-Machines\Templates\Linux\Ubuntu\Server\24-04-0-LTS"
::
::
::	Virtuele machine Destination Path 
::	Dit is de directory waar de virtuele gemaakt wordt 
::	Eventueel aan te passen naar eigen voorkeur 
::
::
@echo [Stap 1d] Instellen Virtual Machine Template Pad
set "VMDestinationHigherPath=\Linux\Ubuntu"
set "VMDestinationPath=\Linux\Ubuntu\Docker"
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 2 INSTALLATIE TOOLS
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 2] Installatie benodigde tools voor dit script
::
@echo [Stap 2a] NanaZIP
::
7z >nul 2>&1
if %errorlevel% neq 0 (
   echo 7-Zip is niet gevonden. Probeer te installeren via winget...
   @winget install M2Team.NanaZip --silent >nul 2>&1
) else (
   echo 7-Zip is al aanwezig
)
@echo [Stap 2b] CURL
::
curl >nul 2>&1
if %errorlevel% neq 0 (
   echo Curl is niet gevonden. Probeer te installeren via winget...
   @winget install cURL.cURL --silent >nul 2>&1
) else (
   echo Curl is al aanwezig
)
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 3 OPRUIMEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 3] Opruimen
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo [Stap 3a] Stoppen eventueel draaiende virtuele machine 
@vmrun -T ws stop %vmPath%\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx >nul 2>&1
::
::
::	Let OP!
::	Permissie foutmelding als Workstation openstaat door gebruiker met VM
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo [Stap 3b] Bestaande virtuele machine verwijderen 
@vmrun -T ws DeleteVM %vmPath%\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx >nul 2>&1
::
@echo [Stap 3c] Opruimen Virtuele Machine template bestanden
@del %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx >nul 2>&1
@del %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk >nul 2>&1
::
@echo [Stap 3d] Opruimen Virtuele Machine bestanden
@del %VMTemplatePath%\U24-LTS-S-DKR-001.vmx >nul 2>&1
@del %VMTemplatePath%\U24-LTS-S-DKR-001.vmdk >nul 2>&1
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 4 DOWNLOADEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
IF NOT EXIST "%VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z" (
    @echo [Stap 4] Downloaden ZIP-Bestand Even geduld AUB ...
    @curl -s -L -o %VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z https://edu.nl/xu78m
) ELSE (
    @echo [Stap 4] Zip-Bestand downloaden overbodig ! 
)
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 5 UITPAKKEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 5] Uitpakken ZIP bestand met M2Team NanaZip 7Z tool
@7z x %VMTemplatePath%\LVI-U24-04-LTS-S-VMDK.7z -o%VMTemplatePath% -y >nul 2>&1
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 6 HERNOEMEN BESTANDEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 6] Hernoemen betanden
@rename %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx U24-LTS-S-DKR-001.vmx
@rename %VMTemplatePath%\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk U24-LTS-S-DKR-001.vmdk
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 7 DIRECTORIES
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo [Stap 7] Zorgen dat benodigde directories aanwezig zijn
:: Linux\Ubuntu
@mkdir %vmPath%\%VMDestinationHigherPath% >nul 2>&1
::
::	Verwijderen eventueel aanwezig directory Docker binnen Linux\Ubuntu
@rmdir /s /q %vmPath%\%VMDestinationPath%
::
::	Aanmaken Docker directory 
@mkdir %vmPath%\%VMDestinationPath%
::
@echo [Stap 8] Bestanden overzetten
@copy %VMTemplatePath%\U24-LTS-S-DKR-001.* %vmPath%\%VMDestinationPath% >nul 2>&1
::
@echo [Stap 9] Aanpassen instellingen virtuele machine 
::
::	DisplayName van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry displayName "U24-LTS-S-DKR-001"
::
::	Annotation van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry annotation "Docker Demo Ubuntu Server 24.04 LTS Gebruiker: ubuntu Wachtwoord: ubuntu"
::
::	Hardware configuratie
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry numvcpus "4"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry memsize "8192"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry scsi0:0.fileName "U24-LTS-S-DKR-001.vmdk"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry extendedConfigFile "U24-LTS-S-DKR-001.vmxf"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry nvram "U24-LTS-S-DKR-001.nvram"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry vmxstats.filename "U24-LTS-S-DKR-001.scoreboard"
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sata0:1.fileName "D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Linux\Ubuntu\Server\24-04-LTS\ubuntu-24.04-live-server-amd64.iso"
::
::	Tijd synchronisatie aanzetten tussen host en guest
@vmcli %vmPath%\%VMDestinationPath%\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::
::
::
@echo [Stap 10] Verwijderen bestanden in Virtuele Machine Templates 
@del %VMTemplatePath%\U24-LTS-S-DKR-001.vmx >nul 2>&1
@del %VMTemplatePath%\U24-LTS-S-DKR-001.vmdk >nul 2>&1
::
::
::	Meerdere manieren om een VM te starten
::
::	@start /B vmware -n %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx
::	vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx power start
::	vmrun -T ws start "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" 
::
:: vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx guest run --username ubuntu --password ubuntu curl -s -L -o u24config.sh ......
::
::
::
::	Variabelen niet meer bechikbaar maken
@endlocal
::
::
:: Thats it folks
::