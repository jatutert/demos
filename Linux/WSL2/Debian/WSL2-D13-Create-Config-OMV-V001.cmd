@echo Stoppen draaiende WSL omgevingen
@wsl --terminate D13-LTS-S-OMV
@echo Verwijderen bestaande omgevingen
@wsl --unregister D13-LTS-S-OMV
@echo Directories maken 
@mkdir D:\Virtual-Machines
@mkdir D:\Virtual-Machines\WSL
@mkdir D:\Virtual-Machines\WSL\Debian
@mkdir D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV
@mkdir D:\Virtual-Machines\WSL\Ubuntu
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\DCKR
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\PDMN
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\KBRN
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2604\DCKR
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2604\PDMN
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2604\KBRN
::
::  Installeren Debian 13 Distributie binnen WSL versie 2 zonder deze interactief te starten
@wsl --install debian --name D13-LTS-S-OMV --location D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV --no-launch
::
::  Toevoegen gebruiker Labadmin met wachtwoord Labadmin aan de Debian 13 Distributie binnen WSL versie 2 
@wsl -d D13-LTS-S-OMV -u root -- bash -c "useradd -m -s /bin/bash labadmin && echo 'labadmin:labadmin' | chpasswd && usermod -aG sudo labadmin"
::
::  Standaard gebruiker instellen op labadmin
@wsl --manage D13-LTS-S-OMV --set-default-user labadmin
::
::  Aanmaken DiskPart Script voor aanmaken van VHD
@del D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
@echo create vdisk file="D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx" maximum=102400 type=expandable >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
@echo create vdisk file="D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx" maximum=102400 type=expandable >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
@echo exit >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
::
::  Aanmaken VHD met behulp van DiskPart
diskpart /s D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
::
::  Mounten VHD bestanden aan WSL
::  LET OP! Na een reboot of shutdown van WSL Distro moeten de extra VHDX-schijven opnieuw aan WSL gekoppeld worden
wsl --shutdown
wsl --mount --vhd D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx --bare
wsl --mount --vhd D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx --bare
::
@wsl -d D13-LTS-S-OMV -u root -- bash -c "sed -i 's|https://deb.debian.org/debian|https://mirror.nl.mirhosting.net/debian/|g' /etc/apt/sources.list.d/0000debian.sources"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt update -y"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt upgrade -y"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt autoremove -y"
::
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt install curl jq sed wget wget2 -qq -y"
::
@wsl -d D13-LTS-S-OMV -u root -- bash -c "curl -L -o /home/labadmin/luctv42.sh https://edu.nl/vnej9"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "chmod +x /home/labadmin/luctv42.sh"