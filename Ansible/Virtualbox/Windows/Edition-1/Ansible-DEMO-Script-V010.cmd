::
:: Ansible Demo Configuration Script
:: Version 1.0.10
:: Date 12 Januari 2024
:: Author John Tutert
:: 



=================================

27 april 2024 

TO DO


D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Docker\Virtualbox\Windows
Docker-DEMO-Script-V008.CMD

Overnemen in dit SCRIPT !!!

Docker Demo werkt !!!


================================================







:: 
@ECHO OFF
@CLS
::
@ECHO Ansible Demo Configuration Script ALPHA Version ONLY FOR TESTING 
@ECHO Windows and Ubuntu Linux
@ECHO By John Tutert 
@ECHO. 
::
:: Variabelen Definitie
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Locatie waar download neergezet moet worden
SET ANSIBLE_DEMO_DOWNLOAD="D:\Installatie-Catalogus\VDI-VMDK-VHD\Oracle-VM-Virtualbox-VDI\UbuntuServer_22.04_VB"
:: Locatie waar virtuele machines opgeslagen moeten worden 
SET ANSIBLE_DEMO_VIRTMACH="D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo"
:: Locatie installatie Oracle VM Virtualbox 
SET VIRTBOX_VBOXMAN="C:\Program Files\Oracle\VirtualBox\"
:: Naam van de Virtuele machine die gedownload moet worden door dit script 
SET VIRTBOX_VIRTMACH="https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VirtualBox/U/22.04/UbuntuServer_22.04_VB.7z"
:: Standaard locatie virtuele machines Virtualbox op deze laptop 
SET VIRTBOX_VIRTMACH_DIR="D:\Virtual-Machines\Oracle-VM-Virtualbox"
::
::
:: Windows Path uitbreiden 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: setx PATH "C:\Program Files\Oracle\VirtualBox\;%PATH%"
:: setx PATH "C:\cygwin64\bin;%PATH%"
:: 
::
:: Controle Benodigheden voor dit Script
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Controle Benodigheden voor Ansible DEMO omgeving 
:: 7-ZIP
winget list -e --id 7zip.7zip >nul 2>&1
if %errorlevel% neq 0 (
    :: 7zip.7zip is NIET geïnstalleerd, installeer het
    winget install --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: 7zip.7zip is geïnstalleerd, werk het bij
    winget upgrade --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: Oracle VM Virtualbox 
winget list -e --id Oracle.VirtualBox >nul 2>&1
if %errorlevel% neq 0 (
    :: Oracle.Virtualbox is NIET geïnstalleerd, installeer het
    winget install --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: Oracle.Virtualbox  is geïnstalleerd, werk het bij
    winget upgrade --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: cURL.cURL 
winget list -e --id cURL.cURL >nul 2>&1
if %errorlevel% neq 0 (
    :: cURL.cURL is NIET geïnstalleerd, installeer het
    winget install --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: cURL.cURL is geïnstalleerd, werk het bij
    winget upgrade --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
)
:: CYGWIN
if not exist C:\cygwin64\bin\sed.exe (
    del %USERPROFILE%\Downloads\setup-x86_64.exe
    curl -s -o %USERPROFILE%\Downloads\setup-x86_64.exe https://www.cygwin.com/setup-x86_64.exe
    :: https://www.cygwin.com/faq/faq.html#faq.setup.cli
    start /D %HOMEPATH% /I /B /MAX %USERPROFILE%\Downloads\setup-x86_64.exe --quiet-mode --download --local-install --no-verify --local-package-dir "%USERPROFILE%\Downloads" --root "C:\cygwin64"
)  
:: Check nieuwste versie Virtualbox 
VBoxManage -q updatecheck perform
::
:: Opruimen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
@ECHO Even opruimen ... 
:: 
:: Stoppen eventueel draaiende virtuele machines  
::  
VBoxManage -q controlvm ulx-s-2204-a-cntrl poweroff >nul 2>&1
VBoxManage -q controlvm ulx-s-2204-a-h-010 poweroff >nul 2>&1
VBoxManage -q controlvm ulx-s-2204-a-h-011 poweroff >nul 2>&1
:: 
:: Verwijderen Virtuele machines
:: 
VBoxManage -q unregistervm ulx-s-2204-a-cntrl --delete-all >nul 2>&1
VBoxManage -q unregistervm ulx-s-2204-a-h-010 --delete-all >nul 2>&1
VBoxManage -q unregistervm ulx-s-2204-a-h-011 --delete-all >nul 2>&1
::
:: Downloads
::
:: del /F %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB.7z
:: 
if exist %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox (
    del /F %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox
)
::
if exist %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi (
    del /F %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi
)
::
@rmdir /S/Q %ANSIBLE_DEMO_VIRTMACH%\Controller >nul 2>&1
@rmdir /S/Q %ANSIBLE_DEMO_VIRTMACH%\Host-010 >nul 2>&1
@rmdir /S/Q %ANSIBLE_DEMO_VIRTMACH%\Host-011 >nul 2>&1
@rmdir /S/Q %ANSIBLE_DEMO_VIRTMACH% >nul 2>&1
:: SSH RSA 
:: @mkdir %USERPROFILE%\.ssh\backup
:: @copy %USERPROFILE%\.ssh\id_rsa.* %USERPROFILE%\.ssh\backup
:: @del %USERPROFILE%\.ssh\id_rsa.* 
::
::
:: Virtuele Machine maken 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Overzicht beschikbare VM Images op linuxvmimages.com 
::
:: :::: Ubuntu Desktop 22.04.x LTS
::
:: Oracle Virtualbox
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VirtualBox/U/22.04/Ubuntu_22.04_VB.7z
::
:: VMware Workstation / Fusion PRO
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/U/22.04/Ubuntu_22.04_VM.7z
::
::
:: :::: Ubuntu Server 22.04.x LTS 
:: 
:: Oracle Virtualbox
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VirtualBox/U/22.04/UbuntuServer_22.04_VB.7z
::
:: VMware Workstation / Fusion PRO
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VMware/U/22.04/UbuntuServer_22.04_VM.7z
::
:: 
:: 
@ECHO Directories maken ...
::
:: Directories maken
::
@mkdir "%ANSIBLE_DEMO_DOWNLOAD%" >nul 2>&1
::
:: @mkdir D:\Virtual-Machines
@mkdir "%VIRTBOX_VIRTMACH_DIR%" >nul 2>&1
@mkdir "%VIRTBOX_VIRTMACH_DIR%"\Linux >nul 2>&1
:: 
@mkdir "%ANSIBLE_DEMO_VIRTMACH%"\ >nul 2>&1
@mkdir "%ANSIBLE_DEMO_VIRTMACH%"\Controller >nul 2>&1
@mkdir "%ANSIBLE_DEMO_VIRTMACH%"\Host-010 >nul 2>&1
@mkdir "%ANSIBLE_DEMO_VIRTMACH%"\Host-011 >nul 2>&1
::
if not exist %ANSIBLE_DEMO_DOWNLOAD%\UbuntuServer_22.04_VB.7z (
    @ECHO Downloaden Virtuele Machine ...
    curl -s -k -o "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB.7z "%VIRTBOX_VIRTMACH%"
)
::
@ECHO Uitpakken Virtuele Machine mbv 7-ZIP ...
c:\PROGRA~1\7-Zip\7z x -bd -y -o"%ANSIBLE_DEMO_DOWNLOAD%" "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB.7z >nul 2>&1
::
@ECHO Ansible Controller ulx-s-2204-a-cntrl Bestanden overzetten 
@xcopy /Q /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "%ANSIBLE_DEMO_VIRTMACH%\Controller"\ulx-s-2204-a-cntrl.vbox >nul 2>&1
@xcopy /Q /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "%ANSIBLE_DEMO_VIRTMACH%\Controller"\ulx-s-2204-a-cntrl.vdi >nul 2>&1
:: 
:: @ECHO Ansible Host 10 ulx-s-2204-a-h-010 Bestanden overzetten 
:: @copy /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "%ANSIBLE_DEMO_VIRTMACH%\Host-010"\ulx-s-2204-a-h-010.vbox
:: @copy /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "%ANSIBLE_DEMO_VIRTMACH%\Host-010"\ulx-s-2204-a-h-010.vdi
:: 
:: @ECHO Ansible Host 11 ulx-s-2204-a-h-011 Bestanden overzetten 
:: @copy /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "%ANSIBLE_DEMO_VIRTMACH%\Host-011"\ulx-s-2204-a-h-011.vbox
:: @copy /Y "%ANSIBLE_DEMO_DOWNLOAD%"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "%ANSIBLE_DEMO_VIRTMACH%\Host-011"\ulx-s-2204-a-h-011.vdi
:: 
@ECHO Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-cntrl
@c:\cygwin64\bin\sed.exe 's@name="UbuntuServer_22.04_VB_LinuxVMImages.COM"@name="ulx-s-2204-a-cntrl"@' %ANSIBLE_DEMO_VIRTMACH%\Controller\ulx-s-2204-a-cntrl.vbox > %ANSIBLE_DEMO_VIRTMACH%\Controller\ulx-s-2204-a-cntrl_naam.vbox
@c:\cygwin64\bin\sed.exe 's@location="UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi"@location="ulx-s-2204-a-cntrl.vdi"@' %ANSIBLE_DEMO_VIRTMACH%\Controller\ulx-s-2204-a-cntrl_naam.vbox > %ANSIBLE_DEMO_VIRTMACH%\Controller\ulx-s-2204-a-cntrl_location.vbox
@rename "%ANSIBLE_DEMO_VIRTMACH%\Controller"\ulx-s-2204-a-cntrl.vbox ulx-s-2204-a-cntrl.oud
@rename "%ANSIBLE_DEMO_VIRTMACH%\Controller"\ulx-s-2204-a-cntrl_location.vbox ulx-s-2204-a-cntrl.vbox
::
:: @ECHO Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-h-010
:: @c:\cygwin64\bin\sed.exe 's@name="UbuntuServer_22.04_VB_LinuxVMImages.COM"@name="ulx-s-2204-a-h-010"@' %ANSIBLE_DEMO_VIRTMACH%\Host-010\ulx-s-2204-a-h-010.vbox > %ANSIBLE_DEMO_VIRTMACH%\Host-010\ulx-s-2204-a-h-010_naam.vbox
:: @c:\cygwin64\bin\sed.exe 's@location="UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi"@location="ulx-s-2204-a-h-010.vdi"@' %ANSIBLE_DEMO_VIRTMACH%\Host-010\ulx-s-2204-a-h-010_naam.vbox > %ANSIBLE_DEMO_VIRTMACH%\Host-010\ulx-s-2204-a-h-010_location.vbox
:: @rename "%ANSIBLE_DEMO_VIRTMACH%\Host-010"\ulx-s-2204-a-h-010.vbox ulx-s-2204-a-h-010.oud
:: @rename "%ANSIBLE_DEMO_VIRTMACH%\Host-010"\ulx-s-2204-a-h-010_location.vbox ulx-s-2204-a-h-010.vbox
:: 
:: @ECHO Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-h-011
:: @c:\cygwin64\bin\sed.exe 's@name="UbuntuServer_22.04_VB_LinuxVMImages.COM"@name="ulx-s-2204-a-h-011"@' %ANSIBLE_DEMO_VIRTMACH%\Host-011\ulx-s-2204-a-h-011.vbox > %ANSIBLE_DEMO_VIRTMACH%\Host-011\ulx-s-2204-a-h-011_naam.vbox
:: @c:\cygwin64\bin\sed.exe 's@location="UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi"@location="ulx-s-2204-a-h-011.vdi"@' %ANSIBLE_DEMO_VIRTMACH%\Host-011\ulx-s-2204-a-h-011_naam.vbox > %ANSIBLE_DEMO_VIRTMACH%\Host-011\ulx-s-2204-a-h-011_location.vbox
:: @rename "%ANSIBLE_DEMO_VIRTMACH%\Host-011"\ulx-s-2204-a-h-011.vbox ulx-s-2204-a-h-011.oud
:: @rename "%ANSIBLE_DEMO_VIRTMACH%\Host-011"\ulx-s-2204-a-h-011_location.vbox ulx-s-2204-a-h-011.vbox
::
:: UUID Aanpassen 
:: vboxmanage internalcommands sethduuid "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vdi"
:: vboxmanage internalcommands sethduuid "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vdi"
:: 
:: Registratie Ansible Controller ulx-s-2204-a-cntrl in Virtualbox 
::
@ECHO Aanmaken Virtuele Machines in Oracle VM VirtualBOX ...
::
vboxmanage registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox"
:: Clone maken Host 010 
vboxmanage -q clonevm ulx-s-2204-a-cntrl --basefolder=D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010 --name=ulx-s-2204-a-h-010 --register >nul 2>&1
:: Clone maken Host 011 
vboxmanage -q clonevm ulx-s-2204-a-cntrl --basefolder=D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011 --name=ulx-s-2204-a-h-011 --register >nul 2>&1
::
:: :: Registratie Ansible Controller ulx-s-2204-a-h-010 in Virtualbox 
:: vboxmanage registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vbox"
:: :: Registratie Ansible Controller ulx-s-2204-a-h-011 in Virtualbox 
:: vboxmanage registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vbox"
::
@ECHO Configuratie Virtuele Machines in Oracle VM VirtualBOX ...
::
:: Aanpassen Ansible Controller Virtualbox Virtuele Machine 
:: Beschrijving aanpassen
vboxmanage -q modifyvm ulx-s-2204-a-cntrl --description="Ansible DEMO Controller Username/Password Ubuntu"
:: ram aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-cntrl --memory=4096
:: copy past modus
vboxmanage -q modifyvm ulx-s-2204-a-cntrl --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-cntrl --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: Shared Folders met Host toevoegen 
vboxmanage -q sharedfolder remove ulx-s-2204-a-cntrl --name="downloads" >nul 2>&1
vboxmanage -q sharedfolder add ulx-s-2204-a-cntrl --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
::
:: Aanpassen Ansible HOST 010 Virtualbox Virtuele Machine 
:: Beschrijving aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-010 --description="Ansible DEMO Host 010 Username/Password Ubuntu"
:: ram aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-010 --memory=4096
:: copy past modus
vboxmanage -q modifyvm ulx-s-2204-a-h-010 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-010 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
::
:: Aanpassen Ansible Host 011 Virtualbox Virtuele Machine 
:: Beschrijving aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-011 --description="Ansible DEMO Host 011 Username/Password Ubuntu"
:: ram aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-011 --memory=4096
:: copy past modus
vboxmanage -q modifyvm ulx-s-2204-a-h-011 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
vboxmanage -q modifyvm ulx-s-2204-a-h-011 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
::
:: Virtuele Machine Starten 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
@ECHO Starten Virtuele Machines ... LAUNCH ...
:: Starten Ansible Controller ulx-s-2204-a-cntrl
@vboxmanage -q --nologo startvm ulx-s-2204-a-cntrl --type=gui
TIMEOUT /T 15 /NOBREAK
::
:: Starten Ansible Host ulx-s-2204-a-h-010
@vboxmanage -q --nologo startvm ulx-s-2204-a-h-010 --type=gui
TIMEOUT /T 15 /NOBREAK
::
:: Starten Ansible Host ulx-s-2204-a-h-011
@vboxmanage -q --nologo startvm ulx-s-2204-a-h-011 --type=gui
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ECHO Configuratie PortForwarding op NAT interface ...
:: Ansible Controller ulx-s-2204-a-cntrl
@vboxmanage -q controlvm ulx-s-2204-a-cntrl natpf1 guestssh,tcp,,2222,,22
::
:: Ansible Host ulx-s-2204-a-h-010 
@vboxmanage -q controlvm ulx-s-2204-a-h-010 natpf1 guestssh,tcp,,2223,,22
::
:: Ansible Host ulx-s-2204-a-h-011 
@vboxmanage -q controlvm ulx-s-2204-a-h-011 natpf1 guestssh,tcp,,2224,,22
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
@ECHO Overzetten RSA sleutel naar Virtuele Machine ...
@ECHO Gebruikersnaam en Wachtwoord : ubuntu
::
type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2222 "cat >> .ssh/authorized_keys"
type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2223 "cat >> .ssh/authorized_keys"
type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2224 "cat >> .ssh/authorized_keys"
::
::
::
:: Configuratie Ansible Controller ulx-s-2204-a-cntrl via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::
::  Voor SSH volgend commando gebruiken: 
::  ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 
::
::
:: AutoUpgrade Uitzetten Om Lock te voorkomen
:: https://linuxhint.com/enable-disable-unattended-upgrades-ubuntu/
@ECHO Ubuntu AutoUpgrade UITZETTEN in alle Virtuele Machines
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2223 sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2224 sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
::
:: Netwerkkaart enp0s8: activeren 
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Ansible/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo netplan apply
::
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo hostnamectl set-hostname ulx-s-2204-a-cntrl
::
:: Aanpassen Ubuntu Repository 
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
:: 
:: Updaten Ubuntu Repository
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt update -qq > /dev/null 2>&1
::
:: Installeren Virtualbox Guest Additions Na afloop reboot noodzakelijk om te activeren 
@ECHO Configuratie Guest Additions in Virtuele Machine
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt remove open-vm-tools -y > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-additions-iso > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo apt install -y virtualbox-guest-utils > /dev/null 2>&1
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo adduser ubuntu vboxsf > /dev/null 2>&1
:: 
:: Installatie cURL in Ansible Controller ulx-s-2204-a-cntrl VM 
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 sudo snap install curl > /dev/null 2>&1
:: 
:: Downloaden Ubuntu configuratiescript
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@127.0.0.1 -p 2222 curl -o /home/ubuntu/ubuntu-ansible-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/demos/main/Ansible/Virtualbox/Linux/Bash-Script/ubuntu-ansible-demo-config-latest.sh
::
:: Uitvoerbaar maken Ubuntu configuratiescript
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo chmod +x /home/ubuntu/ubuntu-ansible-demo-config-latest.sh
:: 
:: Uitvoeren Ubuntu configuratiescript
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo /home/ubuntu/ubuntu-ansible-demo-config-latest.sh
::
::
::
::
exit 1
:: 
:: Configuratie Ansible Host ulx-s-2204-a-h-010 via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo apt update
:: Installatie cURL in Ansible Host ulx-s-2204-a-h-010 VM 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Ansible/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-h-010
::
::
:: Configuratie Ansible Host ulx-s-2204-a-h-011 via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo apt update
:: Installatie cURL in Ansible Host ulx-s-2204-a-h-010 VM 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Ansible/Virtualbox/Linux/Netplan/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-h-011
::
::
:: Thats all folks
EXIT 0  