::
::
::
:: DOCKER Virtualbox Demo Configuration Script
:: Version 0.0.8
:: 
:: Date 27 april 2024
:: Author John Tutert
::
:: 
:: 
@echo off
@cls
::
::
::
::
@echo Docker and Docker Composes Demo Auto Configurator 
@echo. 
@echo Oracle VM Virtualbox hypervisor
@echo Virtual machine uses Vagrant Ubuntu 22.04 LTS (generic/ubuntu2204)
@echo.
@echo Version 0.0.8
@echo April 27 2024
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
@echo Definitie variabelen voor dit script ... 
:: Linux Gebruiker
SET DOCKER_DEMO_LNX_USER=vagrant
::
:: Locatie Oracle VM Virtualbox VboxManage
SET VIRTBOX_VBOXMAN="C:\Program Files\Oracle\VirtualBox\"
::
:: Locatie virtuele harddisk template 
SET DOCKER_DEMO_HDU_TEMPLATE_DIR="D:\Virtual-Machines\Templates\VirtualDisks\Linux"
::
:: Locatie Vagrant Box harddisk template
set DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR="%USERPROFILE%\.vagrant.d\boxes\generic-VAGRANTSLASH-ubuntu2204\4.3.12\amd64\virtualbox"
:: 
:: Naam virtuele harddisk VDMK template 
SET DOCKER_DEMO_VDMK_TEMPLATE_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vmdk
::
:: Naam virtuele harddisk VDI template 
SET DOCKER_DEMO_VDI_TEMPLATE_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vdi
::
:: Standaard locatie virtuele machines Virtualbox op deze laptop 
SET VIRTBOX_VIRTMACH_DIR="D:\Virtual-Machines\Oracle-VM-Virtualbox"
::
:: Locatie waar virtuele machine opgeslagen moeten worden 
SET DOCKER_DEMO_VIRTMACH="D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Docker-Demo"
::
::
:: Controle Benodigheden voor dit Script
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Controle Benodigheden voor DOCKER DEMO omgeving 
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
	@echo Hashicorp Vagrant is present ! Let's carry on .. 
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
    @echo Oracle VM Virtualbox is present ! 
	@winget upgrade --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
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
:: #### VAGRANT BOXES #####
::
:: Vagrant box ubuntu 2204 LTS download
@echo Add Vagrant Box generic/ubuntu2204 ...
@vagrant box add generic/ubuntu2204 --clean --provider virtualbox >nul 2>&1
:: Vagrant box ubuntu 2204 LTS updaten
@echo Vagrant box update ...
@vagrant box update >nul 2>&1
:: Vagrant box ubuntu 2204 LTS opschonen
@echo Vagrant box prune ...
@vagrant box prune >nul 2>&1
::  
:: #### Opruimen #####
:: 
:: Verwijderen HOSTS bestand met poort 3000
@copy %USERPROFILE%\.ssh\known_hosts %USERPROFILE%\.ssh\known_hosts_docker_demo.bck
@del %USERPROFILE%\.ssh\known_hosts
:: Bestand zonder port 3000 maken 
:: @copy %USERPROFILE%\.ssh\known_hosts.vagrant %USERPROFILE%\.ssh\known_hosts
::
:: ## Stoppen eventueel draaiende virtuele machines  
@echo Stoppen eventueel draaiende virtuele machine 
@%VIRTBOX_VBOXMAN%\VBoxManage -q controlvm ulx-s-2204-d-srvr poweroff >nul 2>&1
:: 
:: ## Verwijderen Virtuele machines
@echo Verwijderen eventueel aanwezige virtuele machine 
@%VIRTBOX_VBOXMAN%\VBoxManage -q unregistervm ulx-s-2204-d-srvr --delete-all >nul 2>&1
:: 
:: ## Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@echo Schoonmaken Oracle VM Virtualbox Medium lijst
:: Template directory VMDK
@%VIRTBOX_VBOXMAN%\VBoxManage closemedium disk %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE% >nul 2>&1
:: Template directory VDI
@%VIRTBOX_VBOXMAN%\VBoxManage closemedium disk %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
:: Vagrant VMDK 
@%VIRTBOX_VBOXMAN%\VBoxManage closemedium disk %DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE% >nul 2>&1
:: Virtuele machine 
:: Geeft foutmelding omdat virtuele machine niet meer bestaat 
@%VIRTBOX_VBOXMAN%\VBoxManage closemedium disk %DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
::
::
:: #### Conversie bestaande Vagrant Generic/Ubuntu 22.04 Virtual harddisk van VMDK naar VDI ####
:: :: LET OP Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
:: @del "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%" >nul 2>&1
:: @echo VDI Clone maken van bestaande VMDK ... 
:: @VBoxManage.exe clonemedium disk --format=VDI "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE%" %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%
:: 
::
:: #### Omgeving voor virtuele machine maken ####
:: 
@mkdir "%DOCKER_DEMO_VIRTMACH%"\ >nul 2>&1
@mkdir "%DOCKER_DEMO_VIRTMACH%"\Controller >nul 2>&1
::
:: #### Registratie DOCKER Controller ulx-s-2204-d-srvr in Virtualbox ####
::
@ECHO Aanmaken Virtuele Machines in Oracle VM VirtualBOX ...
@%VIRTBOX_VBOXMAN%\VBoxManage createvm --name "ulx-s-2204-d-srvr" --basefolder "%DOCKER_DEMO_VIRTMACH%\Controller" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
:: #### Aanpassen DOCKER Controller Virtualbox Virtuele Machine ####
:: 
@ECHO Configuratie Virtuele Machines in Oracle VM VirtualBOX ...
::
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --description="Ubuntu 22.04 LTS (generic/ubuntu2204) DOCKER demo"
:: EFI uitzetten 
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --firmware=bios
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --cpus=2
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --memory=8192
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --vram 256
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot1=disk
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot2=dvd
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot3=none
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot4=none
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --audio-enabled=off
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@%VIRTBOX_VBOXMAN%\VBoxManage -q modifyvm ulx-s-2204-d-srvr --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@%VIRTBOX_VBOXMAN%\VBoxManage -q sharedfolder remove ulx-s-2204-d-srvr --name="downloads" >nul 2>&1
@%VIRTBOX_VBOXMAN%\VBoxManage -q sharedfolder add ulx-s-2204-d-srvr --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%DOCKER_DEMO_LNX_USER%/downloads"
::
:: #### Toevoegen DOCKER Controller Virtualbox Virtuele Machine Harddisk #####
:: 
:: ## Overzetten VMDK naar virtuele machine directory
@echo Overzetten Vagrant VMDK naar VM Directory
@copy "%DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE%" "%DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr"
::
:: ## Virtual Hardisk voorzien van nieuwe UUID
@%VIRTBOX_VBOXMAN%\VBoxManage internalcommands sethduuid %DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr\%DOCKER_DEMO_VDMK_TEMPLATE_FILE% >nul 2>&1
::
:: ## VM Aanpassen zodat VDI wordt gebruikt 
@%VIRTBOX_VBOXMAN%\VBoxManage storageattach "ulx-s-2204-d-srvr" --storagectl "SATA" --port 0 --device 0 --type hdd --medium %DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr\%DOCKER_DEMO_VDMK_TEMPLATE_FILE%
::
::
:: #### Virtuele Machine Starten ####
::
@echo Starten Virtuele Machines ... LAUNCH ...
:: Starten DOCKER Controller ulx-s-2204-d-srvr
@%VIRTBOX_VBOXMAN%\VBoxManage -q --nologo startvm ulx-s-2204-d-srvr --type=gui
:: @TIMEOUT /T 180 /NOBREAK
@echo 3 minuten wachten op start van de VM ... 
@sleep 180
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Configuratie PortForwarding op NAT interface ...
:: DOCKER Controller ulx-s-2204-d-srvr
@%VIRTBOX_VBOXMAN%\VBoxManage -q controlvm ulx-s-2204-d-srvr natpf1 guestssh,tcp,,3000,,22
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
@echo Overzetten RSA sleutel naar Virtuele Machine ...
@%VIRTBOX_VBOXMAN%\VBoxManage guestcontrol ulx-s-2204-d-srvr copyto --username=vagrant --password=vagrant --target-directory=/home/vagrant/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
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
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
:: 
::
::
::
:: Netwerkkaart ETH1: activeren 
::
::
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo netplan apply
::
::
::
:: 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo hostnamectl set-hostname ulx-s-2204-d-srvr
::
::
::
::
:: #### Aanpassen Ubuntu Repository 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
::
::
::
:: 
:: #### Updaten Ubuntu Repository
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 "sudo apt update -qq" >nul 2>&1
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
:: #### Installatie Docker 
@echo Installatie Docker met APT
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo apt install docker.io -y
:: 
@echo Installatie Docker met SNAP 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo snap install docker 
::
:: #### Groep docker aanmaken 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo groupadd docker
:: 
:: #### Toevoegen gebruiker vagrant aan groep docker
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo usermod -a -G docker vagrant
:: 
::
::
::
:: Downloaden Ubuntu MultiPass configuratiescript by JA Tutert vanaf GitHub 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 curl -o /home/vagrant/ubuntu-dckr-demo-config-V002.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/Multipass/Ubuntu-Linux-Shell-Scripts/ubuntu-dckr-demo-config-V002.sh
::
:: Uitvoerbaar maken Ubuntu configuratiescript
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo chmod +x /home/vagrant/ubuntu-dckr-demo-config-V002.sh
:: 
:: Uitvoeren Ubuntu configuratiescript
@echo Uitvoeren Ubuntu configuratiescript gestart ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo /home/vagrant/ubuntu-dckr-demo-config-V002.sh
::
::
::
:: Installatie Docker Compose Plugin 
:: https://gcore.com/learning/how-to-install-docker-compose-on-ubuntu/ 
::
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 "mkdir -p ~/.docker/cli-plugins/"
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 "curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose"
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 "chmod +x ~/.docker/cli-plugins/docker-compose"
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