::
::	Docker Demo using downloaded preconfigured virtual machine
::	Created by John Tutert for TutSOFT
::
::	For Educational and/or Personal Use ! 
::
@echo off
@cls
::
@echo.
@echo Docker Demo
@echo Created by John Tutert for TutSOFT
@echo. 
::
@echo [Stap 1] Lokale variabelen voor script aanzetten
::
@setlocal enabledelayedexpansion
::
@echo [Stap 2] Installatie benodigde tools
::
::	M2Team NanaZip Deze tool heeft na installatie gelijk 7z beschikbaar 
@winget install M2Team.NanaZip
::	Curl 
@winget install cURL.cURL
::
@echo [Stap 3] Opruimen Downloads 
::
@del %USERPROFILE%\Downloads\U24VM.7z >nul 2>&1
@del %USERPROFILE%\Downloads\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx >nul 2>&1
@del %USERPROFILE%\Downloads\U24-LTS-S-DKR-001.vmx >nul 2>&1
@del %USERPROFILE%\Downloads\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk >nul 2>&1
@del %USERPROFILE%\Downloads\U24-LTS-S-DKR.vmdk >nul 2>&1
::
@echo [Stap 4] Downloaden ZIP-Bestand Even geduld AUB ...
::
@curl -s -L -o %USERPROFILE%\Downloads\U24VM.7z https://edu.nl/xu78m
::
@echo [Stap 5] Uitpakken ZIP bestand met M2Team NanaZip 7Z tool
::
@7z x %USERPROFILE%\Downloads\U24VM.7z -o%USERPROFILE%\Downloads\ -y >nul 2>&1
::
@echo [Stap 6] Verwijderen ZIP-bestand
::
:: del /F /Q %USERPROFILE%\Downloads\U24VM.7z >nul 2>&1
::
::
@echo [Stap 7] Hernoemen betanden
::
@rename %USERPROFILE%\Downloads\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmx U24-LTS-S-DKR-001.vmx
@rename %USERPROFILE%\Downloads\UbuntuServer_24.04_VM_LinuxVMImages.COM.vmdk U24-LTS-S-DKR-001.vmdk
::
@echo [Stap 7] Bepalen Default VMX Path van VMWare Workstation Pro 
::
:: Pad naar het Preferences.ini bestand
@set "prefFile=%AppData%\VMware\preferences.ini"
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
for /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    set "rawPath=%%B"
)
::
:: Verwijder aanhalingstekens
@set "vmPath=%rawPath:"=%"
::
:: 	Gebruik het pad (voorbeeld: echo of cd)
::	echo Het pad is: %vmPath%
::
:: Voorbeeld: naar de directory gaan
:: cd /d "%vmPath%"
::
::
@echo [Stap 8] Zorgen dat benodigde directories aanwezig zijn
::
@mkdir %vmPath%\Linux >nul 2>&1
::
::	Verwijderen eventueel aanwezig directory Docker
@rmdir /s /q %vmPath%\Linux\Docker
::
::	Aanmaken Docker directory 
@mkdir %vmPath%\Linux\Docker
::
@echo [Stap 9] Bestanden overzetten
::
@copy %USERPROFILE%\Downloads\U24-LTS-S-DKR-001.* %vmPath%\Linux\Docker >nul 2>&1
::
@echo [Stap 10] Aanpassen instellingen virtuele machine 
::
::	DisplayName van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry displayName "U24-LTS-S-DKR-001"
::
::	Annotation van de virtuele machine aanpassen in de VMX via VMCli
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry annotation "Docker Demo Ubuntu Server 24.04 LTS Gebruiker: ubuntu Wachtwoord: ubuntu"
::
::	Hardware configuratie
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry numvcpus "4"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry cpuid.coresPerSocket "2"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry memsize "8192"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry scsi0:0.fileName "U24-LTS-S-DKR-001.vmdk"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry extendedConfigFile "U24-LTS-S-DKR-001.vmxf"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry nvram "U24-LTS-S-DKR-001.nvram"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry vmxstats.filename "U24-LTS-S-DKR-001.scoreboard"
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry sata0:1.fileName "D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Linux\Ubuntu\Server\24-04-LTS\ubuntu-24.04-live-server-amd64.iso"
::
::	Tijd synchronisatie aanzetten tussen host en guest
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx ConfigParams SetEntry tools.syncTime "TRUE"
::

::	Tijd synchronisatie aanzetten tussen host en guest
@vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx Power Query
::
@echo Virtuele machine openen in VMware Workstation Pro
@start /B vmware -n %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx
:: vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx power start
::

:: vmcli %vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx guest run --username ubuntu --password ubuntu curl -s -L -o u24config.sh ......

::	Variabelen niet meer bechikbaar maken
@endlocal
::
::
:: Thats it folks
::