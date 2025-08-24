::
::	VMWare Workstation Pro Virtual Machine Creator
::	Created by John Tutert(TutSOFT)
::
::	For Educational and/or Personal Use ! 
::
:: LUCT 4 Debian 12 Minimal Edition
::
::	Dit is de script versie van de handleiding 2.1 Virtualisatie 2025-2026
::	Gemaakt voor docenten
::
:: Changelog
::
:: 24juli25 B1 Eerste versie op basis van Ubuntu 24 Server Docker script 
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
@echo LUCT 4 Debian 12 Minimal Edition (D12-BKW-M-DEMO-001)
@echo. 
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 1 Aanmaken lokale omgevingsvariabelen voor dit script 
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:: Instellen dat vanaf nu de variabelen tot endlocal lokaal zijn 
@setlocal enabledelayedexpansion
::
@set "prefFile=%AppData%\VMware\preferences.ini"
set "VMTemplatePath=D:\Virtual-Machines\Templates\Linux\Debian\Minimaal\12"
set "VMDestinationHigherPath=Linux\Debian"
set "VMDestinationPath=Linux\Debian\OMV"
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 2 Vullen lokale omgevingsvariabele vmpath
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
for /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    set "rawPath=%%B"
)
:: Verwijder aanhalingstekens uit prefvmx.defaultVMPath
@set "vmPath=%rawPath:"=%"
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 3 INSTALLATIE TOOLS
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
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
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 4 OPRUIMEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Stoppen eventueel draaiend VMware Workstation PRo
@taskkill /IM vmware.exe /F
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Stoppen eventueel draaiende virtuele machine
@vmrun -T ws stop %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx >nul 2>&1
::
::
::	Let OP!
::	Permissie foutmelding als Workstation openstaat door gebruiker met VM
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
@echo Verwijderen eventueel aanwezige virtuele machine 
@vmrun -T ws DeleteVM %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx >nul 2>&1
::
@echo Verwijderen eventueel aanwezige uitgepakte Template bestanden
@del %VMTemplatePath%\Debian_12.0.0_VMM_LinuxVMImages.COM.vmx >nul 2>&1
@del %VMTemplatePath%\Debian_12.0.0_VMM_LinuxVMImages.COM.vmdk >nul 2>&1
::
@echo Verwijderen eventueel overgebleven bestanden aanmaak virtuele machine
@del %VMTemplatePath%\D12-BKW-M-DEMO-001.vmx >nul 2>&1
@del %VMTemplatePath%\D12-BKW-M-DEMO-001.vmdk >nul 2>&1
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 5 DOWNLOADEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
IF NOT EXIST "%VMTemplatePath%\LVI-D12-00-BKW-M-VMDK.7z" (
    @echo Downloaden ZIP-Bestand Even geduld AUB ...
    @curl -s -L -o %VMTemplatePath%\LVI-D12-00-BKW-M-VMDK.7z https://edu.nl/pegff
) ELSE (
    @echo Debian 12 Minimal Virtuele machine ZIP-bestand is reeds aanwezig
)
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 6 UITPAKKEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Uitgepakte bestanden aanmaken in Template directory (7Z)
@7z x %VMTemplatePath%\LVI-D12-00-BKW-M-VMDK.7z -o%VMTemplatePath% -y >nul 2>&1
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 7 HERNOEMEN BESTANDEN
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Hernoemen VMX-bestand naar nieuwe naam
@rename %VMTemplatePath%\Debian_12.0.0_VMM_LinuxVMImages.COM.vmx D12-BKW-M-DEMO-001.vmx
@echo Hernoemen VMDK-bestand naar nieuwe naam
@rename %VMTemplatePath%\Debian_12.0.0_VMM_LinuxVMImages.COM.vmdk D12-BKW-M-DEMO-001.vmdk
::
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 8 DIRECTORIES
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@echo Zorgen dat directory voor Virtuele Machine aanwezig is
:: Linux\Ubuntu
@mkdir %vmPath%\%VMDestinationHigherPath% >nul 2>&1
::
::	Verwijderen eventueel aanwezig directory Docker binnen Linux\Ubuntu
@rmdir /s /q %vmPath%\%VMDestinationPath%
::
::	Aanmaken Docker directory 
@mkdir %vmPath%\%VMDestinationPath%
::
@echo Uitgepakte bestanden overzetten naar directory voor Virtuele Machine
@copy %VMTemplatePath%\D12-BKW-M-DEMO-001.* %vmPath%\%VMDestinationPath% >nul 2>&1
::
@echo Aanpassen instellingen Virtuele Machine in het VMX-bestand (VMcli)
::
::	DisplayName van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry displayName "D12-BKW-M-DEMO-001"
::
::	Annotation van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry annotation "Debian 12 Minimal Gebruiker: ubuntu Wachtwoord: ubuntu"
::
::	Hardware configuratie
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry numvcpus "4"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry memsize "8192"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry scsi0:0.fileName "D12-BKW-M-DEMO-001.vmdk"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry extendedConfigFile "D12-BKW-M-DEMO-001.vmxf"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry nvram "D12-BKW-M-DEMO-001.nvram"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry vmxstats.filename "D12-BKW-M-DEMO-001.scoreboard"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sata0:1.fileName "D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Linux\Ubuntu\Server\24-04-LTS\ubuntu-24.04-live-server-amd64.iso"
::
::	Shared Folder op Always Enabled zetten 
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry isolation.tools.hgfs.disable "False"
::	Shared Folder Downloads
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.present "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.enabled "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.readAccess "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.writeAccess "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.hostPath %USERPROFILE%"\Downloads"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.guestName "windownloads"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder0.expiration "never"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder.maxNum "1"
::	Shared Folder OneDrive
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.present "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.enabled "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.readAccess "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.writeAccess "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.hostPath %USERPROFILE%"\OneDrive"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.guestName "winonedrive"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder1.expiration "never"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder.maxNum "2"
::	Shared Folder Profile zodat oa SSH bestanden benaderd kunnen worden
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.present "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.enabled "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.readAccess "True"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.writeAccess "False"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.hostPath %USERPROFILE%
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.guestName "winuserprofile"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder2.expiration "never"
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry sharedFolder.maxNum "3"
::	Tijd synchronisatie aanzetten tussen host en guest
@vmcli %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 9 Verwijderen uitgepakte bestanden in template directory
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Verwijderen uitgepakte bestanden in template directory 
@del %VMTemplatePath%\D12-BKW-M-DEMO-001.vmx >nul 2>&1
@del %VMTemplatePath%\D12-BKW-M-DEMO-001.vmdk >nul 2>&1
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 10 Starten VMware Workstation Pro
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo Nieuw proces starten en daarin nieuwe virtuele machine openen
@start /B vmware -n %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx 
::
::
@start /B vmrun -T ws start %vmPath%\%VMDestinationPath%\D12-BKW-M-DEMO-001.vmx 
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
::	STAP 11 Lokale Variabelen vrijgeven
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@endlocal
::
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::	STAP 12 Einde Script
::	:::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Thats it folks
::