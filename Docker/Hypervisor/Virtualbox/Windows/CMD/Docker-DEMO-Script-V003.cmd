::
::
::
:: DOCKER Virtualbox Demo Configuration Script
:: Version 0.0.3
:: 
:: Date 24 april 2024
:: Author John Tutert
::
:: 
:: 
@ECHO OFF
@CLS
::
::
::
::
@ECHO DOCKER Virtualbox Demo Configuration Script ALPHA Version ONLY FOR TESTING 
@ECHO Windows and Ubuntu Linux
@ECHO By John Tutert 
@ECHO. 
::
::
::
::
:: Variabelen Definitie
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Linux Gebruiker
SET DOCKER_DEMO_LNX_USER=vagrant
::
:: Locatie Oracle VM Virtualbox VboxManage
SET VIRTBOX_VBOXMAN="C:\Program Files\Oracle\VirtualBox\"
::
:: Locatie virtuele harddisk template 
SET DOCKER_DEMO_HDU_TEMPLATE_DIR="D:\Virtual-Machines\Templates\VirtualDisks\Linux"
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
:: [7-ZIP]
winget list -e --id 7zip.7zip >nul 2>&1
if %errorlevel% neq 0 (
    :: 7zip.7zip is NIET geïnstalleerd, installeer het
    winget install --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: 7zip.7zip is geïnstalleerd, werk het bij
    winget upgrade --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: [Oracle VM Virtualbox]
winget list -e --id Oracle.VirtualBox >nul 2>&1
if %errorlevel% neq 0 (
    :: Oracle.Virtualbox is NIET geïnstalleerd, installeer het
    winget install --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: Oracle.Virtualbox  is geïnstalleerd, werk het bij
    winget upgrade --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: [cURL.cURL] 
winget list -e --id cURL.cURL >nul 2>&1
if %errorlevel% neq 0 (
    :: cURL.cURL is NIET geïnstalleerd, installeer het
    winget install --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: cURL.cURL is geïnstalleerd, werk het bij
    winget upgrade --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: [CYGWIN]
if not exist C:\cygwin64\bin\sed.exe (
    del %USERPROFILE%\Downloads\setup-x86_64.exe
    curl -s -o %USERPROFILE%\Downloads\setup-x86_64.exe https://www.cygwin.com/setup-x86_64.exe
    :: https://www.cygwin.com/faq/faq.html#faq.setup.cli
    start /D %HOMEPATH% /I /B /MAX %USERPROFILE%\Downloads\setup-x86_64.exe --quiet-mode --download --local-install --no-verify --local-package-dir "%USERPROFILE%\Downloads" --root "C:\cygwin64"
)
::
:: Opruimen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: Stoppen eventueel draaiende virtuele machines  
@echo Stoppen eventueel draaiende virtuele machine 
@VBoxManage -q controlvm ulx-s-2204-d-srvr poweroff >nul 2>&1
:: 
:: Verwijderen Virtuele machines
@echo Verwijderen eventueel aanwezige virtuele machine 
@VBoxManage -q unregistervm ulx-s-2204-d-srvr --delete-all >nul 2>&1
:: 
:: Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@echo Schoonmaken Oracle VM Virtualbox Medium lijst 
@VBoxManage closemedium disk %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE% >nul 2>&1
:: Onderstaande geeft foutmelding omdat niet meer bestaat
@VBoxManage closemedium disk %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
:: Onderstaande geeft foutmelding omdat niet meer bestaat 
@VBoxManage closemedium disk %DOCKER_DEMO_VIRTMACH%\Controller\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
::
:: Conversie bestaande Vagrant Generic/Ubuntu 22.04 Virtual harddisk van VMDK naar VDI
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: LET OP Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
@del "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%" >nul 2>&1
@echo VDI Clone maken van bestaande VMDK ... 
@VBoxManage.exe clonemedium disk --format=VDI "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDMK_TEMPLATE_FILE%" %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%
:: 
::
:: Omgeving voor virtuele machine maken 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
@mkdir "%DOCKER_DEMO_VIRTMACH%"\ >nul 2>&1
@mkdir "%DOCKER_DEMO_VIRTMACH%"\Controller >nul 2>&1
::
:: [24-04-24] Registratie DOCKER Controller ulx-s-2204-d-srvr in Virtualbox 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Aanmaken Virtuele Machines in Oracle VM VirtualBOX ...
::
@VBoxManage createvm --name "ulx-s-2204-d-srvr" --basefolder "%DOCKER_DEMO_VIRTMACH%\Controller" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
:: [24-04-24] Aanpassen DOCKER Controller Virtualbox Virtuele Machine
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
@ECHO Configuratie Virtuele Machines in Oracle VM VirtualBOX ...
::
:: Aanpassingen doen aan VM
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --description="Ubuntu 22.04 LTS (Vagrant) DOCKER demo"
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --firmware=bios
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --cpus=2
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --memory=8192
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --vram 256
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot1=disk
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot2=dvd
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot3=none
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --boot4=none
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --audio-enabled=off
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm ulx-s-2204-d-srvr --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add WS19DC-T-001 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
@VBoxManage -q sharedfolder remove ulx-s-2204-d-srvr --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add ulx-s-2204-d-srvr --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%DOCKER_DEMO_LNX_USER%/downloads"
::
:: [24-04-24] Toevoegen DOCKER Controller Virtualbox Virtuele Machine Harddisk
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: Overzetten VDI naar VM Directory
copy "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%" "%DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr"
::
:: Virtual Hardisk voorzien van nieuwe UUID
@VBoxManage internalcommands sethduuid %DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr\%DOCKER_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
::
:: Verwijderen VDI
del "%DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%"
@VBoxManage closemedium disk %DOCKER_DEMO_HDU_TEMPLATE_DIR%\%DOCKER_DEMO_VDI_TEMPLATE_FILE%
:: 
:: VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "ulx-s-2204-d-srvr" --storagectl "SATA" --port 0 --device 0 --type hdd --medium %DOCKER_DEMO_VIRTMACH%\Controller\ulx-s-2204-d-srvr\%DOCKER_DEMO_VDI_TEMPLATE_FILE%
::
::
:: Virtuele Machine Starten 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Starten Virtuele Machines ... LAUNCH ...
:: Starten DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q --nologo startvm ulx-s-2204-d-srvr --type=gui
@TIMEOUT /T 180 /NOBREAK
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Configuratie PortForwarding op NAT interface ...
:: DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q controlvm ulx-s-2204-d-srvr natpf1 guestssh,tcp,,3000,,22
::
::

exit 1

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
@ECHO Overzetten RSA sleutel naar Virtuele Machine ...
@ECHO Gebruikersnaam en Wachtwoord : ubuntu
::
#
#
#
# VBoxManage guestcontrol <uuid | vmname> copyto [--dereference] [--domain=domainname] [--passwordfile=password-file
#      | --password=password] [--quiet] [--no-replace] [--recursive] [--target-directory=guest-destination-dir]
#      [--update] [--username=username] [--verbose] <host-source0> host-source1 [...]
#




#
# 24 april getest: werkt ! 
VBoxManage guestcontrol ulx-s-2204-d-srvr copyto --username=vagrant --password=vagrant --target-directory=/home/vagrant/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub




:: 



:: type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2223 "cat >> .ssh/authorized_keys"
:: type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2224 "cat >> .ssh/authorized_keys"
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
::


ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 

SSH alleen nog manier vinden om YES te geven als antwoord !!
bij 1e keer !!




:: AutoUpgrade Uitzetten Om Lock te voorkomen
:: https://linuxhint.com/enable-disable-unattended-upgrades-ubuntu/


#
#  VBoxManage guestcontrol <uuid | vmname> run [--arg0=argument 0] [--domain=domainname] [--dos2unix] [--exe=filename]
#      [--ignore-orphaned-processes] [--no-wait-stderr | --wait-stderr] [--no-wait-stdout | --wait-stdout]
#      [--passwordfile=password-file | --password=password] [--profile] [--putenv=var-name=[value]] [--quiet]
#      [--timeout=msec] [--unix2dos] [--unquoted-args] [--username=username] [--verbose] <-- [argument...] >





@ECHO Ubuntu AutoUpgrade UITZETTEN in alle Virtuele Machines
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades



::
:: Netwerkkaart enp0s8: activeren 
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Ansible/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo netplan apply
::
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo hostnamectl set-hostname ulx-s-2204-d-srvr





::
:: Aanpassen Ubuntu Repository 
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
:: 




:: Updaten Ubuntu Repository
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo apt update -qq > /dev/null 2>&1
::

VBoxManage guestcontrol ulx-s-2204-d-srvr run --username=vagrant --password=vagrant "sudo apt update -qq"



:: Installeren Virtualbox Guest Additions Na afloop reboot noodzakelijk om te activeren 
@ECHO Configuratie Guest Additions in Virtuele Machine
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt remove open-vm-tools -y > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-additions-iso > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-utils > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo adduser ubuntu vboxsf > /dev/null 2>&1
::
::
:: Installatie cURL in DOCKER Controller ulx-s-2204-d-srvr VM 
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo snap install curl > /dev/null 2>&1
:: 
::



::
::
::
:: Installatie Docker 
::
::
::
::
::
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo snap install docker 
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo usermod -a -G docker $SUDO_USER



ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo apt install -y curl apt-transport-https
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo apt purge -qq -y lxc-docker* || true
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo curl -sSL https://get.docker.com/ | sh
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo service docker start
ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3000 sudo usermod -a -G docker $SUDO_USER





#
# Function Installeren Docker 
#
function install_docker() {
  # Check if Docker is installed
  if ! [ -x "$(command -v docker)" ]; then
    echo 'Docker is not installed. Installing Docker...' >&2
    # ChatGPT curl -fsSL https://get.docker.com -o get-docker.sh
    # ChatGPT sudo sh get-docker.sh
    apt install -y curl apt-transport-https
    apt purge -qq -y lxc-docker* || true
    curl -sSL https://get.docker.com/ | sh
    service docker start
    usermod -a -G docker $SUDO_USER
  else
    echo 'Docker is already installed.'
  fi
}
#











::
::

:: Downloaden Ubuntu configuratiescript
:: ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 curl -o /home/ubuntu/ubuntu-DOCKER-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/demos/main/DOCKER/Virtualbox/Linux/Bash-Script/ubuntu-DOCKER-demo-config-latest.sh
::
:: Uitvoerbaar maken Ubuntu configuratiescript
:: ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo chmod +x /home/ubuntu/ubuntu-DOCKER-demo-config-latest.sh
:: 
:: Uitvoeren Ubuntu configuratiescript
:: ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo /home/ubuntu/ubuntu-DOCKER-demo-config-latest.sh
::
::
::
::
exit 1
:: 
:: Configuratie DOCKER Host ulx-s-2204-a-h-010 via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo apt update
:: Installatie cURL in DOCKER Host ulx-s-2204-a-h-010 VM 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/DOCKER/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-h-010
::
::
:: Configuratie DOCKER Host ulx-s-2204-a-h-011 via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo apt update
:: Installatie cURL in DOCKER Host ulx-s-2204-a-h-010 VM 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/DOCKER/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-h-011
::
::
:: Thats all folks
EXIT 0  