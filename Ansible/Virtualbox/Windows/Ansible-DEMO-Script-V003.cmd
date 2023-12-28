::
winget install --id 7zip.7zip
::
::
:: Ubuntu Desktop
::
:: Oracle Virtualbox
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VirtualBox/U/22.04/Ubuntu_22.04_VB.7z
::
:: VMware Workstation / Fusion PRO
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dlhz157/VMware/U/22.04/Ubuntu_22.04_VM.7z
::
::
:: Ubuntu Server
:: 
:: Oracle Virtualbox
:: https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VirtualBox/U/22.04/UbuntuServer_22.04_VB.7z
::
:: VMware Workstation / Fusion PRO
:: Nog toevoegen
::
:: Opruimen 
@ECHO Even opruimen ... 
@del %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z
@del %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox
@del %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi
@del D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Controller\*.vbox 
@del D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Host-001\*.vbox 
::
::
:: Downloaden Virtuele Machine 
@curl -s -o %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z https://dlconusc1.linuxvmimages.com/046389e06777452db2ccf9a32efa3760:dldatac/VirtualBox/U/22.04/UbuntuServer_22.04_VB.7z
::
:: Uitpakken Virtuele Machine 
@c:\PROGRA~1\7-Zip\7z x -y -o%USERPROFILE%\Downloads\ %USERPROFILE%\Downloads\UbuntuServer_22.04_VB.7z
::
:: Directories maken 
mkdir D:\Virtual-Machines
mkdir D:\Virtual-Machines\Virtualbox
mkdir D:\Virtual-Machines\Virtualbox\Linux
mkdir D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo
mkdir D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Controller
mkdir D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Host-001
::
:: Ansible Controller Bestanden overzetten 
@copy %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox
@copy %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Controller"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi
::
:: Ansible Host Bestanden overzetten 
@copy %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vbox "D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Host-001"\ulx-s-2204-a-h-001.vbox
@copy %USERPROFILE%\Downloads\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi "D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Host-001"\UbuntuServer_22.04_VB_LinuxVMImages.COM.vdi
::
:: Registratie Ansible Controller Virtualbox 
"c:\program files\oracle\virtualbox\vboxmanage" registervm "D:\Virtual-Machines\Virtualbox\Linux\Ansible-Demo\Controller"\ulx-s-2204-a-cntrl.vbox
:: Aanpassen Ansible Controller Virtualbox Virtuele Machine 
:: naam aanpassen
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm UbuntuServer_22.04_VB_LinuxVMImages.COM --name=ulx-s-2204-a-cntrl
:: ram aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --memory=8192
:: :: harddisk aanpassen 
:: "c:\program files\oracle\virtualbox\vboxmanage" storageattach ulx-s-2204-a-cntrl --storagectl=sata --device=0 --medium=ulx-s-2204-a-cntrl.vdi
:: copy past modus
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --clipboard-mode=bidirectional --drag-and-drop=bidirectional
:: netwerk aanpassen 
@"c:\program files\oracle\virtualbox\vboxmanage" modifyvm ulx-s-2204-a-cntrl --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
::
:: Bovenstaande nog een keer maar dan voor de host 001
::
:: hier dus
::
:: Starten VM 
@"c:\program files\oracle\virtualbox\vboxmanage" startvm ulx-s-2204-a-cntrl --type=gui 
:: 
:: NAT regel maken (getest 24-12 werkt) 
"c:\program files\oracle\virtualbox\vboxmanage" controlvm ulx-s-2204-a-cntrl natpf1 guestssh,tcp,,2222,,22
:: 
:: RSA sleutel genereren zonder verdere vragen aan de gebruiker 
ssh-keygen -f id_rsa -t rsa -N ""
::
:: RSA sleutel overzetten naar virtuele machine
:: Er wordt gevraagd om wachtwoord 
:: https://superuser.com/questions/1747549/alternative-to-ssh-copy-id-on-windows
:: type %USERPROFILE%\\.ssh\\id_rsa.pub | ssh ubuntu@127.0.0.1 -p 2222 "cat >> .ssh/authorized_keys"
::
:: Aanpassen Ubuntu Repository 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo sed 's@in.archive.ubuntu.com@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo apt update
:: Installatie cURL in VM
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo snap install curl 
:: Netwerkkaart enp0s8: activeren 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo curl -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/Ansible/main/Demo-Script/00-installer-config.yaml
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo netplan apply 
::
:: Aanpassen hostname zonder herstart 
:: Verandering is zichtbaar na uitloggen en dan weer inloggen 
ssh ubuntu@127.0.0.1 -p 2222 -l ubuntu sudo hostnamectl set-hostname ulx-s-2204-a-cntrl
::
:: 











:: ssh ubuntu@ [ip adres van wifi kaart of ethernet kaart] -p 2222
:: 
:: kan ook gelijk met commando erachter
:: ssh ubuntu@ [ip adres van wifi kaart of ethernet kaart] -p 2222 sudo apt update 
::
:: Netplan ENS0S8 kaart moet hier komen
:: NIC moet toevoegd worden aan configuratiebestand
:: Hierna netplan apply uitvoeren 
:: 
