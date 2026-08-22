::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Create and Config Alma Linux 10 on WSL2
::  Windows Command Prompt 
::
::  Version 001
::  22 augustus 2026
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
@echo :::::: Alma Linux versie 10 WSL2 Creator 
@echo :::::: by TutSOFT
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 1] Opruimen eventueel aanwezige omgevingen 
::
@echo Stoppen A10-PPL-S-WSL2-001
@wsl --terminate A10-PPL-S-WSL2-001
::
@echo Verwijderen bestaande A10-PPL-S-WSL2-001
@wsl --unregister A10-PPL-S-WSL2-001
::
@echo Verwijderen virtuele harddisks
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk1.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk1.vhdx
)
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk2.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk2.vhdx
)
@echo DiskPart Script
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\diskpart-script (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\diskpart-script
)
::
@echo Directories maken 
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Alma
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001
::
::  Installeren Ubuntu 13 Distributie binnen WSL versie 2 zonder deze interactief te starten
@echo Installeren Ubuntu 24.04 LTS binnen WSL2
@wsl --install AlmaLinux-10 --name A10-PPL-S-WSL2-001 --location D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001 --no-launch >nul 2>&1
::
::  Toevoegen gebruiker labadmin met wachtwoord labadmin aan de Ubuntu 13 Distributie binnen WSL versie 2 
@echo Toevoegen gebruiker labadmin aan Alma 10 binnen WSL2
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "useradd -m -s /bin/bash labadmin && echo 'labadmin:labadmin' | chpasswd && usermod -aG wheel labadmin" >nul 2>&1
::
::  Labadmin instellen als standaard gebruiker voor Ubuntu 13 Distributie binnen WSL versie 2
@echo labadmin instellen als standaard gebruiker Alma 10 binnen WSL2
@wsl --manage A10-PPL-S-WSL2-001 --set-default-user labadmin >nul 2>&1
::
@REM    Aanmaken DiskPart Script waarmee VHD bestanden voor OMV kunnen worden gemaakt
@REM    @echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk1.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\A10-PPL-S-WSL2-001\diskpart-script
@REM    @echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk2.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\A10-PPL-S-WSL2-001\diskpart-script
@REM    @echo exit >>D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\diskpart-script
::
@REM    Aanmaken VHD met behulp van DiskPart
@REM    @echo Aanmaken VHD bestanden Ubuntu 24.04 LTS binnen WSL2
@REM    @diskpart /s D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\diskpart-script >nul 2>&1
::
@REM    Mounten VHD bestanden aan WSL
@REM    LET OP! Na een reboot of shutdown van WSL Distro moeten de extra VHDX-schijven opnieuw aan WSL gekoppeld worden
@REM    @echo Mounten nieuwe VHD bestanden binnen WSL2
@REM    @wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk1.vhdx --bare
@REM    @wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Alma\A10-PPL-S-WSL2-001\disk2.vhdx --bare
::
@REM    @echo Aanpassen Alma 10 Repository naar NL Mirror 
@REM    @wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "sed -i '/security.ubuntu.com/!s|URIs: .*|URIs: http://nl.archive.ubuntu.com/ubuntu/|' /etc/apt/sources.list.d/ubuntu.sources"
::
@echo Alma 10 Bijwerken 
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf check-update -y"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf update -y"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf autoremove -y"
::
@echo Een aantal belangrijke applicaties installeren binnen Alma 10
::
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y epel-release"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y vim nano git wget curl rsync tar zip unzip tree tmux screen bash-completion"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y bind-utils net-tools nmap traceroute tcpdump iperf3 mtr"
::
@echo Cockpit installeren
@echo Hierna beschikbaar op poort 9090
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y cockpit"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "systemctl enable --now cockpit.socket"
@REM    @wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "firewall-cmd --add-service=cockpit --permanent"
@REM    @wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "firewall-cmd --reload"
::
@echo Automatische Beveiligingsupdates installeren en hierna aanzetten
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y dnf-automatic"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "systemctl enable --now dnf-automatic.timer"
::
@echo Docker-CE installeren binnen ALMA 10
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y dnf-plugins-core"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "systemctl enable --now docker"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "usermod -aG docker labadmin"
::
@echo Alles updaten naar de laatste stand van zaken
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "dnf update -y"
::
@echo BASH Shell configuratie laden
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "curl -L -o /home/labadmin/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc"
@wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "curl -L -o /home/labadmin/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile"
::
@REM    @wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "curl -L -o /home/labadmin/luctv42.sh https://edu.nl/vnej9"
@REM    @wsl -d A10-PPL-S-WSL2-001 -u root -- bash -c "chmod +x /home/labadmin/luctv42.sh"
::
@wsl -d A10-PPL-S-WSL2-001