::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Create and Config Debian on WSL2
::  Windows Command Prompt 
::
::  Version 004
::  24 juli 2026
::
::  Gemaakt door John Tutert 
::
@echo off
@cls
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Script gestart met Administrator rechten. Prima ! We kunnen verder ... 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
@echo off
@cls
::
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo :::::: Debian 13 Open Media Vault WSL2 Creator 
@echo :::::: by TutSOFT
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 1] Opruimen eventueel aanwezige omgevingen 
::
@echo Stoppen D13-LTS-S-OMV
@wsl --terminate D13-LTS-S-OMV
::
@echo Verwijderen bestaande D13-LTS-S-OMV
@wsl --unregister D13-LTS-S-OMV
::
@echo Verwijderen virtuele harddisks
@IF EXIST D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx (
    @del D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx
)
@IF EXIST D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx (
    @del D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx
)
@echo DiskPart Script
@IF EXIST D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script (
    @del D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
)
::
@echo Directories maken 
@mkdir D:\Virtual-Machines
@mkdir D:\Virtual-Machines\WSL
@mkdir D:\Virtual-Machines\WSL\Debian
@mkdir D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV
::
::  Installeren Debian 13 Distributie binnen WSL versie 2 zonder deze interactief te starten
@echo Installeren Debian 13 binnen WSL2
@wsl --install debian --name D13-LTS-S-OMV --location D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV --no-launch >nul 2>&1
::
::  Toevoegen gebruiker labadmin met wachtwoord labadmin aan de Debian 13 Distributie binnen WSL versie 2 
@echo Toevoegen gebruiker labadmin aan Debian 13 binnen WSL2
@wsl -d D13-LTS-S-OMV -u root -- bash -c "useradd -m -s /bin/bash labadmin && echo 'labadmin:labadmin' | chpasswd && usermod -aG sudo labadmin" >nul 2>&1
::
::  Labadmin instellen als standaard gebruiker voor Debian 13 Distributie binnen WSL versie 2
@echo labadmin instellen als standaard gebruiker Debian 13 binnen WSL2
@wsl --manage D13-LTS-S-OMV --set-default-user labadmin >nul 2>&1
::
::  Aanmaken DiskPart Script waarmee VHD bestanden voor OMV kunnen worden gemaakt
@echo create vdisk file="D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx" maximum=102400 type=expandable >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
@echo create vdisk file="D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx" maximum=102400 type=expandable >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
@echo exit >>D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script
::
::  Aanmaken VHD met behulp van DiskPart
@echo Aanmaken VHD bestanden Debian 13 binnen WSL2
@diskpart /s D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\diskpart-script >nul 2>&1
::
::  Mounten VHD bestanden aan WSL
::  LET OP! Na een reboot of shutdown van WSL Distro moeten de extra VHDX-schijven opnieuw aan WSL gekoppeld worden
@echo Mounten nieuwe VHD bestanden binnen WSL2
@wsl --mount --vhd D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk1.vhdx --bare
@wsl --mount --vhd D:\Virtual-Machines\WSL\Debian\D13-LTS-S-OMV\disk2.vhdx --bare
::
@echo Aanpassen Debian 13 Repository naar NL Mirror 
@wsl -d D13-LTS-S-OMV -u root -- bash -c "sed -i 's|https://deb.debian.org/debian|https://mirror.nl.mirhosting.net/debian/|g' /etc/apt/sources.list.d/0000debian.sources"
::
@echo Debian 13 Bijwerken 
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt update -y"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt upgrade -y"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt autoremove -y"
::
@echo Een aantal belangrijke applicaties installeren binnen Debian 13 
@wsl -d D13-LTS-S-OMV -u root -- bash -c "apt install curl jq sed wget wget2 -qq -y"
::
@wsl -d D13-LTS-S-OMV -u root -- bash -c "curl -L -o /home/labadmin/luctv42.sh https://edu.nl/vnej9"
@wsl -d D13-LTS-S-OMV -u root -- bash -c "chmod +x /home/labadmin/luctv42.sh"
::
@echo Open Media Vault installeren
@echo Standaard gebruiker is admin
@echo Standaard wachtwoord is openmediavault
@wsl -d D13-LTS-S-OMV -u root -- bash -c "wget -q -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash"
::
@echo Verwijderen 0000debian.sources zodat weer netwerkverbinding aanwezig is
::
::  Ook al doe je de aanpassingen hierboven niet aan de Debian 13 Repository dan blijft nog dit probleem bestaan
::  Daarom MOET dus dit bestand verwijderd worden. Na verwijdering is opeens netwerkverbinding mogelijk vanuit OMV
@wsl -d D13-LTS-S-OMV -u root -- bash -c "rm /etc/apt/sources.list.d/0000debian.sources"
::
@echo OMV upgraden naar de nieuwste versie ...
@wsl -d D13-LTS-S-OMV -u root -- bash -c "omv-upgrade"
::
@wsl -d D13-LTS-S-OMV