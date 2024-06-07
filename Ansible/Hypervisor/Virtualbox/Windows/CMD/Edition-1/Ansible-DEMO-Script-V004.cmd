::
:: Ansible Demo Configuration Script
:: Version 1.0 
:: Date December 26 2023 
:: Author John Tutert
:: 
:: 
@ECHO OFF
@CLS
::
@ECHO Ansible Demo Configuration Script
@ECHO Windows and Ubuntu Linux
@ECHO By John Tutert 
@ECHO. 
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
winget list -e --id Oracle.Virtualbox >nul 2>&1
if %errorlevel% neq 0 (
  :: Oracle.Virtualbox is NIET geïnstalleerd, installeer het
  winget install --id Oracle.Virtualbox --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
  :: Oracle.Virtualbox  is geïnstalleerd, werk het bij
  winget upgrade --id Oracle.Virtualbox --accept-package-agreements --accept-source-agreements >nul 2>&1
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
:: CYGWIN Installeren (tbv SED) 
@del %USERPROFILE%\Downloads\setup-x86_64.exe
@curl -s -o %USERPROFILE%\Downloads\setup-x86_64.exe https://www.cygwin.com/setup-x86_64.exe
:: https://www.cygwin.com/faq/faq.html#faq.setup.cli
start /D %HOMEPATH% /I /B /MAX %USERPROFILE%\Downloads\setup-x86_64.exe --quiet-mode --download --local-install --no-verify --local-package-dir "%USERPROFILE%\Downloads" --root "C:\cygwin64"
::
:: Opruimen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
@ECHO Even opruimen ... 
:: 
@del /F %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z
@del /F %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox
@del /F %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi
::
@rmdir "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo"\Controller /S/Q
@rmdir "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo"\Host-010 /S/Q
@rmdir "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo"\Host-011 /S/Q
:: SSH RSA 
@del %USERPROFILE%\.ssh\id_rsa.* 
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
@ECHO Virtuele Machines maken ...
:: 
@curl -s -o %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VirtualBox/U/22.04/UbuntuServer_22.04_VB.7z
::
:: Uitpakken Virtuele Machine
@c:\PROGRA~1\7-Zip\7z x -y -o%USERPROFILE%\Downloads\ %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z >nul 2>&1
::
:: Directories maken 
@mkdir D:\Virtual-Machines
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010
@mkdir D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011
::
:: Ansible Controller ulx-s-2204-a-cntrl Bestanden overzetten 
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vdi
::
:: Ansible Host 10 ulx-s-2204-a-h-010 Bestanden overzetten 
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vbox
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vdi
::
:: Ansible Host 11 ulx-s-2204-a-h-011 Bestanden overzetten 
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vbox
@copy /Y %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vdi
::
:: Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-cntrl
c:\cygwin64\bin\sed.exe 's@UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi@ulx-s-2204-a-cntrl.vdi@' "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox > "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl_nieuw.vbox
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox ulx-s-2204-a-cntrl.oud
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl_nieuw.vbox ulx-s-2204-a-cntrl.vbox
:: Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-h-010
c:\cygwin64\bin\sed.exe 's@UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi@ulx-s-2204-a-h-010.vdi@' "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vbox > "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010_nieuw.vbox
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vbox ulx-s-2204-a-h-010.oud
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010_nieuw.vbox ulx-s-2204-a-h-010.vbox
:: Aanpassen naam vdi in configuratiebestanden mbv cygwin sed Ansible Controller ulx-s-2204-a-h-011
c:\cygwin64\bin\sed.exe 's@UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi@ulx-s-2204-a-h-011.vdi@' "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vbox > "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011_nieuw.vbox
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-011.vbox ulx-s-2204-a-h-011.oud
rename "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-011_nieuw.vbox ulx-s-2204-a-h-011.vbox
::
:: Registratie Ansible Controller ulx-s-2204-a-cntrl in Virtualbox 
@"c:\program files\oracle\virtualbox\vboxmanage" registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox
:: Registratie Ansible Controller ulx-s-2204-a-h-010 in Virtualbox 
"c:\program files\oracle\virtualbox\vboxmanage" registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-010"\ulx-s-2204-a-h-010.vbox
:: Registratie Ansible Controller ulx-s-2204-a-h-011 in Virtualbox 
"c:\program files\oracle\virtualbox\vboxmanage" registervm "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\Ansible-Demo\Host-011"\ulx-s-2204-a-h-011.vbox
::
:: Aanpassen Ansible Controller Virtualbox Virtuele Machine 
:: naam aanpassen
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm UbuntuServer_22.04_VB_LinuxVMImages.COM --name=ulx-s-2204-a-cntrl
:: Beschrijving aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --description="Ansible DEMO Controller Username/Password Ubuntu"
:: ram aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --memory=4096
:: copy past modus
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: Shared Folders met Host toevoegen 
@"c:\program files\oracle\virtualbox\vboxmanage" sharedfolder remove ulx-s-2204-a-cntrl --name="downloads" >nul 2>&1
@"c:\program files\oracle\virtualbox\vboxmanage" sharedfolder add ulx-s-2204-a-cntrl --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
::
:: Aanpassen Ansible Controller Virtualbox Virtuele Machine 
:: naam aanpassen
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm UbuntuServer_22.04_VB_LinuxVMImages.COM --name=ulx-s-2204-a-h-010
:: Beschrijving aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-010 --description="Ansible DEMO Host 010 Username/Password Ubuntu"
:: ram aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-010 --memory=4096
:: :: harddisk aanpassen 
:: "c:\program files\oracle\virtualbox\vboxmanage" storageattach ulx-s-2204-a-cntrl --storagectl=sata --device=0 --medium=ulx-s-2204-a-cntrl.vdi
:: copy past modus
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-010 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-010 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
::
:: Aanpassen Ansible Controller Virtualbox Virtuele Machine 
:: naam aanpassen
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm UbuntuServer_22.04_VB_LinuxVMImages.COM --name=ulx-s-2204-a-h-011
:: Beschrijving aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-011 --description="Ansible DEMO Host 011 Username/Password Ubuntu"
:: ram aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-011 --memory=4096
:: :: harddisk aanpassen 
:: "c:\program files\oracle\virtualbox\vboxmanage" storageattach ulx-s-2204-a-cntrl --storagectl=sata --device=0 --medium=ulx-s-2204-a-cntrl.vdi
:: copy past modus
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-011 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-h-011 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
::
::
:: Virtuele Machine Starten 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Starten Ansible Controller ulx-s-2204-a-cntrl
@"c:\program files\oracle\virtualbox\vboxmanage" startvm ulx-s-2204-a-cntrl --type=gui
::
:: Starten Ansible Host ulx-s-2204-a-h-010
@"c:\program files\oracle\virtualbox\vboxmanage" startvm ulx-s-2204-a-h-010 --type=gui
::
:: Starten Ansible Host ulx-s-2204-a-h-011
@"c:\program files\oracle\virtualbox\vboxmanage" startvm ulx-s-2204-a-h-011 --type=gui
::
:: Virtuele Machine PORT Forwarding Instellen 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Ansible Controller ulx-s-2204-a-cntrl
"c:\program files\oracle\virtualbox\vboxmanage" controlvm ulx-s-2204-a-cntrl natpf1 guestssh,tcp,,2222,,22
::
:: Ansible Host ulx-s-2204-a-h-010 
"c:\program files\oracle\virtualbox\vboxmanage" controlvm ulx-s-2204-a-h-010 natpf1 guestssh,tcp,,2223,,22
::
:: Ansible Host ulx-s-2204-a-h-011 
"c:\program files\oracle\virtualbox\vboxmanage" controlvm ulx-s-2204-a-h-011 natpf1 guestssh,tcp,,2224,,22
::
::
:: RSA sleutel genereren zonder verdere vragen aan de gebruiker 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@ssh-keygen -f id_rsa -t rsa -N ""
::
::
:: RSA sleutel overzetten naar virtuele machine 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: Er wordt gevraagd om wachtwoord 
:: https://superuser.com/questions/1747549/alternative-to-ssh-copy-id-on-windows
:: type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2222 "cat >> .ssh/authorized_keys"
::
::
:: Configuratie Ansible Controller ulx-s-2204-a-cntrl via SSH
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo apt update -qq
:: Installeren Virtualbox Guest Additions Na afloop reboot noodzakelijk om te activeren 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo apt remove open-vm-tools -y 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo apt install -y virtualbox-guest-additions-iso
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo apt install -y virtualbox-guest-utils 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo adduser ubuntu vboxsf 
:: Installatie cURL in Ansible Controller ulx-s-2204-a-cntrl VM 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/Ansible/main/Demo-Script/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-cntrl
:: Downloaden Ubuntu configuratiescript
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu curl -o /home/ubuntu/ubuntu-ansible-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/Ansible/main/Demo-Script/ubuntu-ansible-demo-config-latest.sh
:: Uitvoerbaar maken Ubuntu configuratiescript
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo chmod +x /home/ubuntu/ubuntu-ansible-demo-config-latest.sh
:: Uitvoeren Ubuntu configuratiescript
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo /home/ubuntu/ubuntu-ansible-demo-config-latest.sh
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
ssh ubuntu@127.0.0.1 -p 2223 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/Ansible/main/Demo-Script/00-installer-config.yaml
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
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/Ansible/main/Demo-Script/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo netplan apply 
:: Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2224 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-h-011
::
::
:: Thats all folks
EXIT 0  