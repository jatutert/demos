::
::
::
:: DOCKER Virtualbox Demo Configuration Script
:: Version 0.0.12
:: 
:: Date May 01 2024
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
@echo Version 0.0.12
@echo May 01 2024
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
set	DOCKER_DEMO_VAGRANT_LNX_USER=vagrant
:: 	Versienummer Vagrant box 
set DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_VER=4.3.12
:: 	Locatie Vagrant Box harddisk template
set DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR="%USERPROFILE%\.vagrant.d\boxes\generic-VAGRANTSLASH-ubuntu2204\%DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_VER%\amd64\virtualbox"
:: 	Naam virtuele harddisk VDMK template 
set DOCKER_DEMO_VAGRANT_VMDK_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vmdk
:: 	Naam virtuele harddisk VDI template 
set DOCKER_DEMO_VDI_TEMPLATE_FILE=generic-ubuntu2204-virtualbox-x64-disk001.vdi
::
::	## Oracle VM Virtualbox
::
:: 	Locatie Oracle VM Virtualbox VboxManage
set VIRTBOX_VBOXMAN="C:\Program Files\Oracle\VirtualBox\"
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
set DOCKER_DEMO_VM_DIRECTORY="D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Docker-Demo"
:: 	Type virtuele machine 
set DOCKER_DEMO_VM_TYPE=controller
::	Hostname
set DOCKER_DEMO_VM_HOSTNAME=ulx-s-2204-d-srvr
::	Poort SSH
set DOCKER_DEMO_VM_SSH_PORT=3000
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
@vagrant box add generic/ubuntu2204 --clean --provider virtualbox >nul 2>&1
@vagrant box list -i generic/ubuntu2204 >nul 2>&1
:: 	Vagrant box ubuntu 2204 LTS updaten
@vagrant box update >nul 2>&1
:: 	Vagrant box ubuntu 2204 LTS opschonen
@vagrant box prune >nul 2>&1
::  
:: 	#### Opruimen #####
:: 
:: 	Verwijderen HOSTS bestand met poort 3000
@copy %USERPROFILE%\.ssh\known_hosts %USERPROFILE%\.ssh\known_hosts_docker_demo.bck
@del %USERPROFILE%\.ssh\known_hosts >nul 2>&1
:: 	Bestand zonder port 3000 maken 
:: 	@copy %USERPROFILE%\.ssh\known_hosts.vagrant %USERPROFILE%\.ssh\known_hosts
::
::
:: ## Stoppen eventueel draaiende virtuele machines  
@echo #### Stoppen eventueel draaiende virtuele machine 
@VBoxManage -q controlvm %DOCKER_DEMO_VM_HOSTNAME% poweroff >nul 2>&1
:: 
:: ## Verwijderen Virtuele machines
@echo #### Verwijderen eventueel aanwezige virtuele machine 
@VBoxManage -q unregistervm %DOCKER_DEMO_VM_HOSTNAME% --delete-all >nul 2>&1
:: 
:: ## Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@echo #### Schoonmaken Oracle VM Virtualbox Medium lijst
:: 	Template directory VMDK
@VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%DOCKER_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
:: 	Template directory VDI
@VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
:: 	Vagrant VMDK 
@VBoxManage closemedium disk %DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
:: 	Virtuele machine 
@VBoxManage closemedium disk %DOCKER_DEMO_VM_DIRECTORY%\%DOCKER_DEMO_VM_TYPE%\%DOCKER_DEMO_VM_HOSTNAME%\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
::
::
:: #### Conversie bestaande Vagrant Generic/Ubuntu 22.04 Virtual harddisk van VMDK naar VDI ####
:: :: LET OP Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
:: @del "%VIRT_MACHINES_TEMPLATE_DIRECTORY%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%" >nul 2>&1
:: @echo VDI Clone maken van bestaande VMDK ... 
:: @VBoxManage.exe clonemedium disk --format=VDI "%VIRT_MACHINES_TEMPLATE_DIRECTORY%\%DOCKER_DEMO_VAGRANT_VMDK_FILE%" %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%
:: 
::
:: #### Omgeving voor virtuele machine maken ####
:: 
@mkdir "%DOCKER_DEMO_VM_DIRECTORY%"\ >nul 2>&1
@mkdir "%DOCKER_DEMO_VM_DIRECTORY%"\%DOCKER_DEMO_VM_TYPE% >nul 2>&1
::
:: #### Registratie DOCKER Controller ulx-s-2204-d-srvr in Virtualbox ####
::
@echo #### Aanmaken Virtuele Machines in Oracle VM VirtualBOX ...
::
:: Gaat fout
:: Kan niet overweg met %VIRTBOX_VBOXMAN%\VBoxManage
:: @%VIRTBOX_VBOXMAN%\VBoxManage createvm --name "%DOCKER_DEMO_VM_HOSTNAME%" --basefolder %DOCKER_DEMO_VM_DIRECTORY%\ --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
::
@VBoxManage createvm --name "%DOCKER_DEMO_VM_HOSTNAME%" --basefolder "%DOCKER_DEMO_VM_DIRECTORY%\%DOCKER_DEMO_VM_TYPE%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
:: #### Aanpassen DOCKER Controller Virtualbox Virtuele Machine ####
:: 
@echo #### Configuratie Virtuele Machines in Oracle VM VirtualBOX ...
::
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --description="Ubuntu 22.04 LTS (generic/ubuntu2204) DOCKER demo"
:: EFI uitzetten 
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --firmware=bios
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --cpus=2
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --memory=8192
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --vram 256
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --boot1=disk
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --boot2=dvd
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --boot3=none
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --boot4=none
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --audio-enabled=off
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm %DOCKER_DEMO_VM_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@VBoxManage -q sharedfolder remove %DOCKER_DEMO_VM_HOSTNAME% --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add %DOCKER_DEMO_VM_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%DOCKER_DEMO_VAGRANT_LNX_USER%/downloads"
::
:: #### Toevoegen DOCKER Controller Virtualbox Virtuele Machine Harddisk #####
:: 
:: ## Overzetten VMDK naar virtuele machine directory
@echo #### Overzetten Vagrant VMDK naar VM Directory
@copy "%DOCKER_DEMO_VAGRANT_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VAGRANT_VMDK_FILE%" "%DOCKER_DEMO_VM_DIRECTORY%\%DOCKER_DEMO_VM_TYPE%\%DOCKER_DEMO_VM_HOSTNAME%"
::
:: ## Virtual Hardisk voorzien van nieuwe UUID
@VBoxManage internalcommands sethduuid %DOCKER_DEMO_VM_DIRECTORY%\%DOCKER_DEMO_VM_TYPE%\%DOCKER_DEMO_VM_HOSTNAME%\%DOCKER_DEMO_VAGRANT_VMDK_FILE% >nul 2>&1
::
:: ## VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "%DOCKER_DEMO_VM_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium %DOCKER_DEMO_VM_DIRECTORY%\%DOCKER_DEMO_VM_TYPE%\%DOCKER_DEMO_VM_HOSTNAME%\%DOCKER_DEMO_VAGRANT_VMDK_FILE%
::
::
:: #### Virtuele Machine Starten ####
::
@echo #### Starten Docker DEMO virtuele machine 
:: Starten DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q --nologo startvm %DOCKER_DEMO_VM_HOSTNAME% --type=gui >nul 2>&1
:: @TIMEOUT /T 180 /NOBREAK
@echo 3 minuten wachten op start van de VM ... 
@sleep 180
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO #### Configuratie PortForwarding op NAT interface ...
:: DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q controlvm %DOCKER_DEMO_VM_HOSTNAME% natpf1 guestssh,tcp,,3000,,22
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
@VBoxManage guestcontrol %DOCKER_DEMO_VM_HOSTNAME% copyto --username=%DOCKER_DEMO_VAGRANT_LNX_USER% --password=%DOCKER_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%DOCKER_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
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
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
:: 
::
::	#### Configuratie DNS ivm EduRoam
::
@echo Aanpassen DNS configuratie ivm EduRoam 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo netplan apply
::
::
::	#### Configuratie eth1 nic 
::
@echo Netwerkkaart eth1 activeren ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo netplan apply"
:: 
::	#### Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo hostnamectl set-hostname ulx-s-2204-d-srvr"
::
:: #### Aanpassen Ubuntu Repository 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
:: 
:: #### Updaten Ubuntu Repository
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo apt update -qq" >nul 2>&1
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
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo apt install docker.io -y"
::
::	#### Installatie Docker met SNAP
::	@echo Installatie Docker met SNAP 
::	@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo snap install docker"
::
:: #### Groep docker aanmaken 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo groupadd docker"
:: 
:: #### Toevoegen gebruiker vagrant aan groep docker
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo usermod -a -G docker %DOCKER_DEMO_VAGRANT_LNX_USER%
::
:: #### Downloaden Ubuntu MultiPass configuratiescript by JA Tutert vanaf GitHub 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "curl -s -o /home/vagrant/ubuntu-dckr-demo-config.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Ubuntu-Config/docker-demo-virtbox-linux-config-v001.sh"
::
:: #### Uitvoerbaar maken Ubuntu configuratiescript
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo chmod +x /home/vagrant/ubuntu-dckr-demo-config.sh"
:: 
:: #### Uitvoeren Ubuntu configuratiescript
@echo Uitvoeren Ubuntu configuratiescript gestart ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "sudo /home/vagrant/ubuntu-dckr-demo-config.sh"
::
:: ####	Installatie Docker Compose Plugin 
:: 		https://gcore.com/learning/how-to-install-docker-compose-on-ubuntu/ 
::
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "mkdir -p ~/.docker/cli-plugins/"
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose"
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% "chmod +x ~/.docker/cli-plugins/docker-compose"
::
:: 
::	#### Installatie Powershell
::	https://ubuntuhandbook.org/index.php/2020/11/install-powershell-7-1-0-apt-ubuntu-20-04-18-04/
::
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O /home/vagrant/packages-microsoft-prod.deb
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo dpkg -i /home/vagrant/packages-microsoft-prod.deb
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo apt update -qq
ssh -i %USERPROFILE%\.ssh\id_rsa %DOCKER_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %DOCKER_DEMO_VM_SSH_PORT% sudo apt install powershell -y
::
:: 
@echo Ga naar virtuele machine
@echo via
@echo @ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000
::
::
::
:: Thats all folks
EXIT 1  