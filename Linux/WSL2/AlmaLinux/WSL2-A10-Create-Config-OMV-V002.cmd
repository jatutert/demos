@echo off
@cls
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM       TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM         TT    U    U    TT    SS      O    O  FF        TT
@REM         TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM         TT    U    U    TT        SS  O    O  FF        TT
@REM         TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM        TutSOFT Education and Networking Services (TENS)
@REM
@REM        The Netherlands/Nederland/Niederlande/Pays Bas/Paisos Bajos
@REM        NL EU
@REM
@REM
@REM    Copyright (c) 2026 John Tutert
@REM    Permission is hereby granted, free of charge, to any person obtaining a copy
@REM    of this software, to use, copy, modify, and distribute it for personal,
@REM    educational, or open-source purposes, provided this notice remains intact.
@REM    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM    WSL versie 2 Virtuele machine creator
@REM
@REM    Alma Linux versie 10
@REM
@REM
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Script gestart met Administrator rechten. Prima ! We kunnen verder ... 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
@REM
@REM
set "WSL_VM_Hostname=A10-PPL-S-WSL2-001"
@REM
@REM
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo :::::: Alma Linux versie 10 WSL2 Creator 
@echo :::::: by TutSOFT
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM
@REM
@echo [Stap 1] Opruimen %WSL_VM_Hostname% virtuele machine 
@REM
@REM
@echo [Stap 1a] Stoppen WSL2 Hyper-V virtuele machine 
@wsl --terminate %WSL_VM_Hostname%
@REM
@REM
@echo [Stap 1b] Verwijderen bestaande %WSL_VM_Hostname%
@wsl --unregister %WSL_VM_Hostname%
@REM
@REM
@echo [Stap 1c] Verwijderen virtuele harddisks
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk1.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk1.vhdx
)
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk2.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk2.vhdx
)
@echo [Stap 1d] Verwijderen DiskPart Script
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\diskpart-script (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\diskpart-script
)
@REM
@REM
@echo [Stap 2] Directories maken voor %WSL_VM_Hostname%
@REM
@REM
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Alma
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%
@REM
@REM
@echo [Stap 3] Installeren WSL2 Alma Linux 10
@wsl --install AlmaLinux-10 --name %WSL_VM_Hostname% --location D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname% --no-launch >nul 2>&1
@REM
@REM
@echo [Stap 4] Toevoegen gebruiker labadmin aan WSL2 Alma Linux 10
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "useradd -m -s /bin/bash labadmin && echo 'labadmin:labadmin' | chpasswd && usermod -aG wheel labadmin" >nul 2>&1
@REM
@REM
@echo [Stap 5] Labadmin instellen als standaard gebruiker WSL2 Alma Linux 10
@wsl --manage %WSL_VM_Hostname% --set-default-user labadmin >nul 2>&1
::
@REM    Aanmaken DiskPart Script waarmee VHD bestanden voor OMV kunnen worden gemaakt
@REM    @echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk1.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\%WSL_VM_Hostname%\diskpart-script
@REM    @echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk2.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\%WSL_VM_Hostname%\diskpart-script
@REM    @echo exit >>D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\diskpart-script
::
@REM    Aanmaken VHD met behulp van DiskPart
@REM    @echo Aanmaken VHD bestanden Ubuntu 24.04 LTS binnen WSL2
@REM    @diskpart /s D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\diskpart-script >nul 2>&1
::
@REM    Mounten VHD bestanden aan WSL
@REM    LET OP! Na een reboot of shutdown van WSL Distro moeten de extra VHDX-schijven opnieuw aan WSL gekoppeld worden
@REM    @echo Mounten nieuwe VHD bestanden binnen WSL2
@REM    @wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk1.vhdx --bare
@REM    @wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Alma\%WSL_VM_Hostname%\disk2.vhdx --bare
::
@REM    @echo Aanpassen Alma 10 Repository naar NL Mirror 
@REM    @wsl -d %WSL_VM_Hostname% -u root -- bash -c "sed -i '/security.ubuntu.com/!s|URIs: .*|URIs: http://nl.archive.ubuntu.com/ubuntu/|' /etc/apt/sources.list.d/ubuntu.sources"
::
@echo Linux bijwerken %WSL_VM_Hostname%
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf check-update -y"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf update -y"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf autoremove -y"
::
@echo Een aantal belangrijke applicaties installeren %WSL_VM_Hostname%
::
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y epel-release"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y vim nano git wget curl rsync tar zip unzip tree tmux screen bash-completion"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y bind-utils net-tools nmap traceroute tcpdump iperf3 mtr"
::
@echo Cockpit installeren binnen %WSL_VM_Hostname%
@echo Hierna beschikbaar op poort 9090
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y cockpit"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "systemctl enable --now cockpit.socket"
@REM    @wsl -d %WSL_VM_Hostname% -u root -- bash -c "firewall-cmd --add-service=cockpit --permanent"
@REM    @wsl -d %WSL_VM_Hostname% -u root -- bash -c "firewall-cmd --reload"
::
@echo Automatische Beveiligingsupdates installeren en hierna aanzetten
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y dnf-automatic"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "systemctl enable --now dnf-automatic.timer"
::
@echo Docker-CE installeren binnen ALMA 10
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y dnf-plugins-core"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "systemctl enable --now docker"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "usermod -aG docker labadmin"
::
@echo Alles updaten naar de laatste stand van zaken
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "dnf update -y"
::
@echo BASH Shell configuratie laden
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "curl -L -o /home/labadmin/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc"
@wsl -d %WSL_VM_Hostname% -u root -- bash -c "curl -L -o /home/labadmin/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile"
::
@REM    @wsl -d %WSL_VM_Hostname% -u root -- bash -c "curl -L -o /home/labadmin/luctv42.sh https://edu.nl/vnej9"
@REM    @wsl -d %WSL_VM_Hostname% -u root -- bash -c "chmod +x /home/labadmin/luctv42.sh"
@REM
@REM
@wsl -d %WSL_VM_Hostname%
@REM
@REM    Thats all folks
@REM