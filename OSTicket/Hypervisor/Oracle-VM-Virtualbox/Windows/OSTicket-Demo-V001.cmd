::
::
::
:: OSTicket Virtualbox Demo Configuration Script
:: Version 0.0.1
:: 
:: Date May 08 2024
:: Author John Tutert
::
::
::  	Changelog
::
::      Version 001
::      May 8 2024
::      - duplicate from ANSIBLE Virtualbox Demo Configuration Script version 0.0.02
::
::
:: 
@echo off
@cls
::
::
::
::
@echo OSTicket Demo Auto Configurator 
@echo. 
@echo Oracle VM Virtualbox hypervisor
@echo Virtual machine uses Vagrant Ubuntu 22.04 LTS (generic/ubuntu2204)
@echo.
@echo Version 0.0.1
@echo. 
@echo May 08 2024
@echo. 
@echo Developed by John Tutert
@echo.
@echo For Personal and/or Education use only !  
@echo. 
::
::
::
::
:: Variabelen Definitie
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo #### Definitie variabelen voor dit script ... 
::
::
:: ## VAGRANT
::
:: Linux Gebruiker
set OSTICKET_DEMO_VAGRANT_LNX_USER=vagrant
:: 	Versienummer Vagrant box 
set OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER=4.3.12







:: 	Locatie Vagrant Box harddisk template
set OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR="%USERPROFILE%\.vagrant.d\boxes\generic-VAGRANTSLASH-ubuntu2204\%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER%\amd64\virtualbox"

>> aanpassen naar vmware_desktop VMDK bestand !!!! 




:: 	Naam virtuele harddisk VDMK template 
set OSTICKET_DEMO_VAGRANT_VMDK_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vmdk

>> aanpassen naar vmware_desktop VMDK bestand !!! 





::  Naam virtuele harddisk VDI template 
set OSTICKET_DEMO_VDI_TEMPLATE_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vdi
::
::	## Oracle VM Virtualbox
::
:: 	Locatie Oracle VM Virtualbox VboxManage
::
:: Oud
::
:: set VIRTBOX_VBOXMAN="C:\Program Files\Oracle\VirtualBox\"
:: setx PATH "%PATH%;C:\Program Files\Oracle\VirtualBox\"
::
:: Nieuw
::
set pathEnv=%PATH%
set vboxPath="C:\Program Files\Oracle\VirtualBox\"
:: 
:: Controleer of de map van VirtualBox in de `%PATH%`-variabele voorkomt
if "%pathEnv:~0,%vboxPath:~0%" == "%vboxPath%" (
  echo VirtualBox-map is reeds aanwezig in de `%PATH%`-variabele.
) else (
  echo VirtualBox-map is niet aanwezig in de `%PATH%`-variabele.
  rem Voeg de map van VirtualBox toe aan de `%PATH%`-variabele (optioneel)
  set newPathEnv=%pathEnv%;%vboxPath%
  setx PATH "%newPathEnv%"
  echo VirtualBox-map toegevoegd aan de `%PATH%`-variabele. Herstart de computer om de wijzigingen door te voeren.
)
::
::
:: 	Standaard locatie virtuele machines Virtualbox op deze laptop 
set VIRTBOX_VIRTMACH_DIR="D:\Virtual-Machines\Oracle-VM-Virtualbox"
::
::	## Template 
::
:: 	Locatie virtuele harddisk template 
set VIRT_MACHINES_TEMPLATE_DIRECTORY="D:\Virtual-Machines\Templates\VirtualDisks\Linux"
::
::
:: ## Virtual machine
::
:: 	Locatie waar virtuele machine opgeslagen moeten worden 
set OSTICKET_DEMO_VM_DIRECTORY="D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\OSTicket-Demo"
:: 	Type virtuele machine 
set DOCKER_DEMO_VM_TYPE=controller
::	Hostname
set OSTICKET_DEMO_WEBSRV_HOSTNAME=ulx-s-2204-ostkt-wbsrv
set OSTICKET_DEMO_DBSRV_HOSTNAME=ulx-s-2204-ostkt-dbsrv
:: set OSTICKET_DEMO_VM_H11_HOSTNAME=ulx-s-2204-a-h-011
::	Poort SSH
set OSTICKET_DEMO_VM_CNTRL_SSH_PORT=3001
set OSTICKET_DEMO_VM_H10_SSH_PORT=3002
:: set OSTICKET_DEMO_VM_H11_SSH_PORT=3003
::
::
:: Controle Benodigheden voor dit Script
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo #### Controle Benodigheden voor DOCKER DEMO omgeving 
::
::
:: [IBM/HashiCorp Vagrant]
vagrant version >nul 2>&1
if %errorlevel% neq 0 (
:: Vagrant is NIET geïnstalleerd, installeer het
    @echo Hashicorp Vagrant is NOT installed ! 
	@echo Starting install ... 
	@winget install --id Hashicorp.Vagrant --accept-package-agreements --accept-source-agreements >nul 2>&1
	@echo Hasicorp Vagrant installation done ... 
	@echo Please restart script ! 
	@pause
	@exit /B 0
) else (
    :: Vagrant is geïnstalleerd, werk het bij
    :: winget upgrade --id Hashicorp.Vagrant --accept-package-agreements --accept-source-agreements >nul 2>&1
	echo Hashicorp Vagrant is present ! Let's carry on .. 
)
::
::
:: [Oracle VM Virtualbox]
winget list -e --id Oracle.VirtualBox >nul 2>&1
if %errorlevel% neq 0 (
    :: Oracle.Virtualbox is NIET geïnstalleerd, installeer het
    @echo Oracle VM Virtualbox is NOT installed ! 
	@echo Starting install ... 
	@winget install --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
	@echo please restart script !
	@pause
	@exit /B 0 
) else (
    :: Oracle.Virtualbox  is geïnstalleerd, werk het bij
    echo Oracle VM Virtualbox is present ! 
	winget upgrade --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
:: [7-ZIP]
winget list -e --id 7zip.7zip >nul 2>&1
if %errorlevel% neq 0 (
    :: 7zip.7zip is NIET geïnstalleerd, installeer het
    winget install --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: 7zip.7zip is geïnstalleerd, werk het bij
    winget upgrade --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
:: [cURL.cURL] 
winget list -e --id cURL.cURL >nul 2>&1
if %errorlevel% neq 0 (
    :: cURL.cURL is NIET geïnstalleerd, installeer het
    winget install --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: cURL.cURL is geïnstalleerd, werk het bij
    winget upgrade --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
:: [CYGWIN]
:: 
if not exist C:\cygwin64\bin\sed.exe (
    del %USERPROFILE%\Downloads\setup-x86_64.exe
    curl -s -o %USERPROFILE%\Downloads\setup-x86_64.exe https://www.cygwin.com/setup-x86_64.exe
    :: https://www.cygwin.com/faq/faq.html#faq.setup.cli
    start /D %HOMEPATH% /I /B /MAX %USERPROFILE%\Downloads\setup-x86_64.exe --quiet-mode --download --local-install --no-verify --local-package-dir "%USERPROFILE%\Downloads" --root "C:\cygwin64"
)
::
::
::	#### VAGRANT BOXES #####
::
:: 	Vagrant box ubuntu 2204 LTS download
@echo #### Make Vagrant ready for use
:: 	Toevoegen generic/ubuntu2204 box versie 4.3.12 indien niet aanwezig  
::	https://developer.hashicorp.com/vagrant/docs/cli/box#box-add
@vagrant box add generic/ubuntu2204 --box-version %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER% --clean --provider virtualbox >nul 2>&1
:: 
:: 	@vagrant box list -i generic/ubuntu2204 >nul 2>&1
::
:: 	Vagrant box ubuntu 2204 LTS updaten
@vagrant box update --box generic/ubuntu2204 --provider virtualbox >nul 2>&1
:: 	Vagrant box ubuntu 2204 LTS opschonen
@vagrant box prune >nul 2>&1
::  
:: 	#### Opruimen #####
:: 
:: 	Verwijderen HOSTS bestand binnen userprofile directory 
@copy /Y %USERPROFILE%\.ssh\known_hosts %USERPROFILE%\.ssh\known_hosts_docker_demo.bck
@del /F %USERPROFILE%\.ssh\known_hosts >nul 2>&1
:: 	Bestand zonder port 3000 maken 
:: 	@copy %USERPROFILE%\.ssh\known_hosts.vagrant %USERPROFILE%\.ssh\known_hosts
::
::
:: ## Stoppen eventueel draaiende virtuele machines  
@echo #### Stoppen eventueel draaiende virtuele machine 
@VBoxManage -q controlvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% poweroff >nul 2>&1
@VBoxManage -q controlvm %OSTICKET_DEMO_DBSRV_HOSTNAME% poweroff >nul 2>&1
@VBoxManage -q controlvm %OSTICKET_DEMO_VM_H11_HOSTNAME% poweroff >nul 2>&1
:: 
:: ## Verwijderen Virtuele machines
@echo #### Verwijderen eventueel aanwezige virtuele machine 
@VBoxManage -q unregistervm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --delete-all >nul 2>&1
@VBoxManage -q unregistervm %OSTICKET_DEMO_DBSRV_HOSTNAME% --delete-all >nul 2>&1
@VBoxManage -q unregistervm %OSTICKET_DEMO_VM_H11_HOSTNAME% --delete-all >nul 2>&1
:: 
:: ## Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@echo #### Schoonmaken Oracle VM Virtualbox Medium lijst
:: 	Template directory VMDK
@VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
:: 	Template directory VDI
@VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
:: 	Vagrant VMDK 
@VBoxManage closemedium disk %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
:: 	Virtuele machine 
@VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
@VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
:: @VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
::
::
:: #### Conversie bestaande Vagrant Generic/Ubuntu 22.04 Virtual harddisk van VMDK naar VDI ####
:: :: LET OP Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
:: @del "%VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VDI_TEMPLATE_FILE%" >nul 2>&1
:: @echo VDI Clone maken van bestaande VMDK ... 
:: @VBoxManage.exe clonemedium disk --format=VDI "%VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VDI_TEMPLATE_FILE%
:: 
::
:: #### Omgeving voor virtuele machine maken ####
:: 
@mkdir "%OSTICKET_DEMO_VM_DIRECTORY%"\ >nul 2>&1
::
:: #### Registratie DOCKER Controller ulx-s-2204-d-srvr in Virtualbox ####
::
@echo #### Aanmaken Virtuele Machines in Oracle VM VirtualBOX ...
::
:: Gaat fout
:: Kan niet overweg met %VIRTBOX_VBOXMAN%\VBoxManage
:: @%VIRTBOX_VBOXMAN%\VBoxManage createvm --name "%DOCKER_DEMO_VM_HOSTNAME%" --basefolder %OSTICKET_DEMO_VM_DIRECTORY%\ --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
::
@VBoxManage createvm --name "%OSTICKET_DEMO_WEBSRV_HOSTNAME%" --basefolder "%OSTICKET_DEMO_VM_DIRECTORY%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
@VBoxManage createvm --name "%OSTICKET_DEMO_DBSRV_HOSTNAME%" --basefolder "%OSTICKET_DEMO_VM_DIRECTORY%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
:: @VBoxManage createvm --name "%OSTICKET_DEMO_VM_H11_HOSTNAME%" --basefolder "%OSTICKET_DEMO_VM_DIRECTORY%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
::
::
::
:: #### Aanpassen WEBSERVER Virtualbox Virtuele Machine ####
:: 
@echo #### Configuratie Ansible Controller in Oracle VM VirtualBOX ...
::
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --description="Ubuntu 22.04 LTS (generic/ubuntu2204) OSTicket Webserver"
:: EFI uitzetten 
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --firmware=bios
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --cpus=2
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --memory=2048
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --vram 256
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot1=disk
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot2=dvd
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot3=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot4=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --audio-enabled=off
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@VBoxManage -q sharedfolder remove %OSTICKET_DEMO_WEBSRV_HOSTNAME% --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add %OSTICKET_DEMO_WEBSRV_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/downloads"
::
::
::
::
:: #### Aanpassen DBMS SERVER Virtualbox Virtuele Machine ####
:: 
@echo #### Configuratie Ansible Controller in Oracle VM VirtualBOX ...
::
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --description="Ubuntu 22.04 LTS (generic/ubuntu2204) OSTicket DBMS"
:: EFI uitzetten 
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --firmware=bios
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --cpus=2
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --memory=2048
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --vram 256
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot1=disk
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot2=dvd
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot3=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot4=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --audio-enabled=off
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@VBoxManage -q sharedfolder remove %OSTICKET_DEMO_DBSRV_HOSTNAME% --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add %OSTICKET_DEMO_DBSRV_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/downloads"
::
::
::
::
:: #### Aanpassen ANSIBLE Host 011 Virtualbox Virtuele Machine ####
:: 
:: @echo #### Configuratie Ansible Controller in Oracle VM VirtualBOX ...
::
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --description="Ubuntu 22.04 LTS (generic/ubuntu2204) Ansible Host 011"
:: EFI uitzetten 
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --firmware=bios
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --cpus=2
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --memory=2048
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --vram 256
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --boot1=disk
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --boot2=dvd
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --boot3=none
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --boot4=none
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --audio-enabled=off
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: @VBoxManage -q modifyvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: @VBoxManage -q sharedfolder remove %OSTICKET_DEMO_VM_H11_HOSTNAME% --name="downloads" >nul 2>&1
:: @VBoxManage -q sharedfolder add %OSTICKET_DEMO_VM_H11_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/downloads"
::
::
::
::
:: #### Toevoegen Virtualbox Virtuele Machine Harddisk #####
:: 
:: ## Overzetten VMDK naar virtuele machine directory
@echo #### Overzetten Vagrant VMDK naar VM Directory


AANPASSEN !!!!

uit vmware_desktop halen en NIET virtualbox !!!
Bij virtualbox krijg je foutmelding UUID 

Na copy hernoemen van VMDK naar naam van de VM




:: @copy "%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%"
@copy /Y "%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
:: @copy "%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%"
@copy /Y "%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
:: @copy "%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%" "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%"
::
:: ## Virtual Hardisk voorzien van nieuwe UUID
:: 
@VBoxManage internalcommands sethduuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
:: @VBoxManage internalcommands sethdparentuuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
:: 
@VBoxManage internalcommands sethduuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
:: @VBoxManage internalcommands sethdparentuuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
::
:: @VBoxManage internalcommands sethduuid %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
::
:: ## VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "%OSTICKET_DEMO_WEBSRV_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
@VBoxManage storageattach "%OSTICKET_DEMO_DBSRV_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
:: @VBoxManage storageattach "%OSTICKET_DEMO_VM_H11_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_VMDK_FILE%
::
::
:: #### Virtuele Machine Starten ####
::
@echo #### Starten Docker DEMO virtuele machine 
:: Starten DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q --nologo startvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --type=gui >nul 2>&1
@VBoxManage -q --nologo startvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --type=gui >nul 2>&1
@VBoxManage -q --nologo startvm %OSTICKET_DEMO_VM_H11_HOSTNAME% --type=gui >nul 2>&1
:: @TIMEOUT /T 180 /NOBREAK
@echo 3 minuten wachten op start van de VM ... 
@sleep 180
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO #### Configuratie PortForwarding op NAT interface ...
:: DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q controlvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% natpf1 guestssh,tcp,,%OSTICKET_DEMO_VM_CNTRL_SSH_PORT%,,22
@VBoxManage -q controlvm %OSTICKET_DEMO_DBSRV_HOSTNAME% natpf1 guestssh,tcp,,%OSTICKET_DEMO_VM_H10_SSH_PORT%,,22
@VBoxManage -q controlvm %OSTICKET_DEMO_VM_H11_HOSTNAME% natpf1 guestssh,tcp,,%OSTICKET_DEMO_VM_H11_SSH_PORT%,,22
::
::
:: RSA sleutel genereren zonder verdere vragen aan de gebruiker 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: ssh-keygen -f id_rsa -t rsa -N ""
:: copy /Y id_rsa %USERPROFILE%\.ssh
:: copy /Y id_rsa.pub %USERPROFILE%\.ssh
::
::
:: RSA sleutel overzetten naar virtuele machine 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: SSH-COPY-ID binnen Windows mbv Python
:: zie https://pypi.org/project/sshcopyid/
::
::
:: Er wordt gevraagd om wachtwoord 
:: https://superuser.com/questions/1747549/alternative-to-ssh-copy-id-on-windows
::
::
::
::
:: 	VBoxManage guestcontrol <uuid | vmname> copyto [--dereference] [--domain=domainname] [--passwordfile=password-file
::     | --password=password] [--quiet] [--no-replace] [--recursive] [--target-directory=guest-destination-dir]
::     [--update] [--username=username] [--verbose] <host-source0> host-source1 [...]
::
::  VBoxManage guestcontrol <uuid | vmname> run [--arg0=argument 0] [--domain=domainname] [--dos2unix] [--exe=filename]
::     [--ignore-orphaned-processes] [--no-wait-stderr | --wait-stderr] [--no-wait-stdout | --wait-stdout]
::     [--passwordfile=password-file | --password=password] [--profile] [--putenv=var-name=[value]] [--quiet]
::     [--timeout=msec] [--unix2dos] [--unquoted-args] [--username=username] [--verbose] <-- [argument...] >
::
:: 
:: 
:: 
@echo #### Overzetten RSA sleutel naar Virtuele Machine ...
@VBoxManage guestcontrol %OSTICKET_DEMO_WEBSRV_HOSTNAME% copyto --username=%OSTICKET_DEMO_VAGRANT_LNX_USER% --password=%OSTICKET_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
@VBoxManage guestcontrol %OSTICKET_DEMO_DBSRV_HOSTNAME% copyto --username=%OSTICKET_DEMO_VAGRANT_LNX_USER% --password=%OSTICKET_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
@VBoxManage guestcontrol %OSTICKET_DEMO_VM_H11_HOSTNAME% copyto --username=%OSTICKET_DEMO_VAGRANT_LNX_USER% --password=%OSTICKET_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
::
::
::
::
:: 
:: Configuratie DOCKER Controller ulx-s-2204-d-srvr via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::
::  Voor SSH volgend commando gebruiken: 
::  ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 
:: 
:: 	Geen vragen bij: 
::  ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 -o StrictHostKeyChecking=no
::
::
::	1e keer SSH 
:: 	-o StrictHostKeyChecking=no nodig om vraag te voorkomen bij 1e keer
:: 	-o niet meer nodig na 1e keer 
:: 
:: ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 -o StrictHostKeyChecking=no
::
::
::
::
:: #### 1e keer SSH en AutoUpgrade Uitzetten Om Lock te voorkomen ####
:: https://linuxhint.com/enable-disable-unattended-upgrades-ubuntu/
::
@echo Ubuntu AutoUpgrade UITZETTEN ...
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
:: 
::
::	#### Configuratie DNS ivm EduRoam
::
@echo Aanpassen DNS configuratie ivm EduRoam 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo netplan apply
::
@echo Aanpassen DNS configuratie ivm EduRoam 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo netplan apply
::
@echo Aanpassen DNS configuratie ivm EduRoam 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% sudo netplan apply
::
::
::	#### Configuratie eth1 nic 
::
@echo Netwerkkaart eth1 activeren ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo netplan apply"
:: 
::
@echo Netwerkkaart eth1 activeren ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo netplan apply"
:: 
::
@echo Netwerkkaart eth1 activeren ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H11_SSH_PORT% "sudo netplan apply"
:: 
::	#### Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo hostnamectl set-hostname ulx-s-2204-d-srvr"
::
:: #### Aanpassen Ubuntu Repository 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
:: 
:: #### Updaten Ubuntu Repository
ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo apt update -qq" >nul 2>&1
::
::
::
::
:: :: Installeren Virtualbox Guest Additions Na afloop reboot noodzakelijk om te activeren 
:: @ECHO Configuratie Guest Additions in Virtuele Machine
:: ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt remove open-vm-tools -y > /dev/null 2>&1
:: ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-additions-iso > /dev/null 2>&1
:: ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-utils > /dev/null 2>&1
:: ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo adduser ubuntu vboxsf > /dev/null 2>&1
::
::
::
:: #### Installatie Docker met APT
@echo Installatie Docker met APT
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo apt install docker.io -y"
::
::	#### Installatie Docker met SNAP
::	@echo Installatie Docker met SNAP 
::	@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo snap install docker"
::
:: #### Groep docker aanmaken 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo groupadd docker"
:: 
:: #### Toevoegen gebruiker vagrant aan groep docker
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo usermod -a -G docker %OSTICKET_DEMO_VAGRANT_LNX_USER%
::
:: #### Downloaden Ubuntu MultiPass configuratiescript by JA Tutert vanaf GitHub 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "curl -s -o /home/vagrant/ubuntu-dckr-demo-config.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Ubuntu-Config/docker-demo-virtbox-linux-config-v001.sh"
::
:: #### Uitvoerbaar maken Ubuntu configuratiescript
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo chmod +x /home/vagrant/ubuntu-dckr-demo-config.sh"
:: 
:: #### Uitvoeren Ubuntu configuratiescript
@echo Uitvoeren Ubuntu configuratiescript gestart ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo /home/vagrant/ubuntu-dckr-demo-config.sh"
::
:: ####	Installatie Docker Compose Plugin 
:: 		https://gcore.com/learning/how-to-install-docker-compose-on-ubuntu/ 
::
ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "mkdir -p ~/.docker/cli-plugins/"
ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose"
ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "chmod +x ~/.docker/cli-plugins/docker-compose"
::
::  
:: 
@echo Ga naar virtuele machine
@echo via
@echo @ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000
::
::
::
:: Thats all folks
EXIT 0  