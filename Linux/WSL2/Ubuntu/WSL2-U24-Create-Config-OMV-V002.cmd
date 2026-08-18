::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Create and Config Ubuntu 24 on WSL2
::  Windows Command Prompt 
::
::  Version 002
::  15 augustus 2026
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
@echo :::::: Ubuntu 24.04 LTS WSL2 Creator 
@echo :::::: by TutSOFT
@echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 1] Opruimen eventueel aanwezige omgevingen 
::
@echo Stoppen U24-LTS-S-WSL2-001
@wsl --terminate U24-LTS-S-WSL2-001
::
@echo Verwijderen bestaande U24-LTS-S-WSL2-001
@wsl --unregister U24-LTS-S-WSL2-001
::
@echo Verwijderen virtuele harddisks
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk1.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk1.vhdx
)
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk2.vhdx (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk2.vhdx
)
@echo DiskPart Script
@IF EXIST D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script (
    @del D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script
)
::
@echo Directories maken 
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu
@mkdir D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001
::
::  Installeren Ubuntu 13 Distributie binnen WSL versie 2 zonder deze interactief te starten
@echo Installeren Ubuntu 24.04 LTS binnen WSL2
@wsl --install Ubuntu-24.04 --name U24-LTS-S-WSL2-001 --location D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001 --no-launch >nul 2>&1
::
::  Toevoegen gebruiker labadmin met wachtwoord labadmin aan de Ubuntu 13 Distributie binnen WSL versie 2 
@echo Toevoegen gebruiker labadmin aan Ubuntu 13 binnen WSL2
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "useradd -m -s /bin/bash labadmin && echo 'labadmin:labadmin' | chpasswd && usermod -aG sudo labadmin" >nul 2>&1
::
::  Labadmin instellen als standaard gebruiker voor Ubuntu 13 Distributie binnen WSL versie 2
@echo labadmin instellen als standaard gebruiker Ubuntu 24.04 binnen WSL2
@wsl --manage U24-LTS-S-WSL2-001 --set-default-user labadmin >nul 2>&1
::
::  Aanmaken DiskPart Script waarmee VHD bestanden voor OMV kunnen worden gemaakt
@echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk1.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script
@echo create vdisk file="D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk2.vhdx" maximum=102400 type=expandable >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script
@echo exit >>D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script
::
::  Aanmaken VHD met behulp van DiskPart
@echo Aanmaken VHD bestanden Ubuntu 24.04 LTS binnen WSL2
@diskpart /s D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\diskpart-script >nul 2>&1
::
::  Mounten VHD bestanden aan WSL
::  LET OP! Na een reboot of shutdown van WSL Distro moeten de extra VHDX-schijven opnieuw aan WSL gekoppeld worden
@echo Mounten nieuwe VHD bestanden binnen WSL2
@wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk1.vhdx --bare
@wsl --mount --vhd D:\Virtualization-Home\Virtual-Machines\WSL\Ubuntu\U24-LTS-S-WSL2-001\disk2.vhdx --bare
::
@echo Aanpassen Ubuntu 24.04 Repository naar NL Mirror 
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "sed -i '/security.ubuntu.com/!s|URIs: .*|URIs: http://nl.archive.ubuntu.com/ubuntu/|' /etc/apt/sources.list.d/ubuntu.sources"
::
@echo Ubuntu 13 Bijwerken 
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "apt update -y"
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "apt upgrade -y"
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "apt autoremove -y"
::
@echo Een aantal belangrijke applicaties installeren binnen Ubuntu 24.04
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "apt install curl jq sed wget wget2 -qq -y"
::
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "curl -L -o /home/labadmin/luctv42.sh https://edu.nl/vnej9"
@wsl -d U24-LTS-S-WSL2-001 -u root -- bash -c "chmod +x /home/labadmin/luctv42.sh"
::
@wsl -d U24-LTS-S-WSL2-001