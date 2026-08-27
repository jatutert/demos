#! /bin/bash
#
#
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
#
#
#       TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#         TT    U    U    TT    SS      O    O  FF        TT
#         TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#         TT    U    U    TT        SS  O    O  FF        TT
#         TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
#
#        TutSOFT Education and Networking Services (TENS)
#
#        The Netherlands/Nederland/Niederlande/Pays Bas/Paisos Bajos
#        NL EU
#
#
#    Copyright (c) 2026 John Tutert
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software, to use, copy, modify, and distribute it for personal,
#    educational, or open-source purposes, provided this notice remains intact.
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
#
#
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
#
#
#   Debian 
#   Open Media Vault (OMV) Installer Script
#
#
TARGET_TIMEZONE="Europe/Amsterdam"
CURRENT_TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
if [ "$CURRENT_TIMEZONE" != "$TARGET_TIMEZONE" ]; then
    timedatectl set-timezone "$TARGET_TIMEZONE" || true > /dev/null 2>&1
fi 
#
#
#
#
. /etc/os-release
distro=$(echo "$ID" | tr '[:upper:]' '[:lower:]')
versie=$(echo "$VERSION_ID" | tr '[:upper:]' '[:lower:]')
#
#
#
#
if [ -f /etc/os-release ]; then
    #
    if [[ $distro == "debian" ]]; then
        deb_vers_oud=$(cat /etc/debian_version | tr '[:upper:]' '[:lower:]')
    fi
    #
    echo "You are running $distro $versie as Operating System"
fi
#
#
#
#
if [[ $distro == "debian" ]]; then
    #
    #
    apt update -qq -y || true > /dev/null 2>&1
    apt upgrade -qq -y || true > /dev/null 2>&1
    #
    #
    apt install curl jq sed wget wget2 -qq -y || true > /dev/null 2>&1
    #
    #
    echo "Version before upgrade $deb_vers_oud"
    deb_vers_nw=$(cat /etc/debian_version | tr '[:upper:]' '[:lower:]')
    echo "Version after upgrade $deb_vers_nw"
fi
#
#
#
#
if [[ $distro == "debian" ]] ; then
    if [[ $versie == "12" ]] ; then
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/installOld7 | sudo bash
    fi
    if [[ $versie == "13" ]] ; then
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
    fi
fi
#
#
#
#
usermod -aG _ssh $SUDO_USER
usermod -aG operator $SUDO_USER
usermod -aG root $SUDO_USER
usermod -aG staff $SUDO_USER
usermod -aG sys $SUDO_USER
usermod -aG www-data $SUDO_USER
#
#
#
#
sudo usermod -s /bin/bash $SUDO_USER
#
#
#
#
if dpkg -l | grep -q openmediavault; then
    usermod -aG openmediavault-admin    $SUDO_USER
    usermod -aG openmediavault-config   $SUDO_USER
    usermod -aG openmediavault-engined  $SUDO_USER
    usermod -aG openmediavault-notify   $SUDO_USER
    usermod -aG openmediavault-webgui   $SUDO_USER
fi

if dpkg -l | grep -q openmediavault; then
    omv-upgrade
fi
#
#
#
#
curl -s -o /home/${SUDO_USER}/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
curl -s -o /home/${SUDO_USER}/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
#
#
#
#
#   Thats all folks ! 
#
#
#
#

