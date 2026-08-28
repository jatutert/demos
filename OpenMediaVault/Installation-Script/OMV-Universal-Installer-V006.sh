#! /bin/bash
#
#
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
clear
#
#
echo   "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo   "@@@@@@  Open Media Vault (OMV) Configurator Script by TutSOFT"
echo   "@@@@@@  Created for Personal and/or Educational Use"
echo   "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
#
#
#
#
if [ $(id -u) -ne 0 ]; then
    clear
    echo ''
    echo "Script started as user $USER"
    echo 'Script NOT started with ROOT rights !'
    echo ''
    echo 'Please start script with sudo in advance for the correct rights to execute !'
    echo ''
    echo 'Terminate script execution ...'
    exit 1
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Tijdzone
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
TARGET_TIMEZONE="Europe/Amsterdam"
CURRENT_TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
if [ "$CURRENT_TIMEZONE" != "$TARGET_TIMEZONE" ]; then
    timedatectl set-timezone "$TARGET_TIMEZONE" || true > /dev/null 2>&1
fi 
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Debian Linux bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
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
    apt update  -qq -y || true > /dev/null 2>&1
    #
    apt upgrade -qq -y || true > /dev/null 2>&1
    #
    apt autoremove -qq -y || true > /dev/null 2>&1 
    #
    #   apt install python3-distupgrade -qq -y || true > /dev/null 2>&1
    #
    echo "Version before upgrade $deb_vers_oud"
    deb_vers_nw=$(cat /etc/debian_version | tr '[:upper:]' '[:lower:]')
    echo "Version after upgrade $deb_vers_nw"
fi
#
#
#
#
if [[ $distro == "debian" ]]; then
    #
    APT_INSTALL_ARRAY=(
        "7zip"
        "apt-transport-https"
        "bridge-utils"
        "ca-certificates"
        "cowsay"
        "curl"
        "default-jdk"
        "dmidecode"
        "dpkg"
        "git"
        "glances"
        "gnupg"
        "gzip"
        "jq"
        "lolcat"
        "make"
        "mc"
        "micro"
        "nano"
        "neofetch"
        "nmap"
        "php"
        "libapache2-mod-php"
        "python3"
        "screenfetch"
        "shellcheck"
        "sed"
        "sl"
        "software-properties-common"
        "tar"
        "unzip"
        "wget"
        "wget2"
        "zip"
    )
    #
    #
    #
    #
    TOTAL_APT_INSTALL=${#APT_INSTALL_ARRAY[@]}
    CURRENT_APT_INSTALL_COUNT=0
    #
    for apt_install in "${APT_INSTALL_ARRAY[@]}"; do
        CURRENT_APT_INSTALL_COUNT=$((CURRENT_APT_INSTALL_COUNT + 1))
        apt install "$apt_install" -qq -y || true
    done
    #
    #
    #
    #
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ Open Media Vault Installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#   Zie 
#   https://github.com/OpenMediaVault-Plugin-Developers/installScript
#
#
clear
#
#
#
#
if [[ $distro == "debian" ]] ; then
    if [[ $versie == "12" ]] ; then
        echo "Installing Open Media Vault 7"
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/installOld7 | sudo bash
    fi
    if [[ $versie == "13" ]] ; then
        echo "Installing Open Media Vault 8"
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
    fi
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Open Media Vault Updaten
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
clear
#
#
#
#
if dpkg -l | grep -q openmediavault; then
    echo "Updating Open Media Vault"
    omv-upgrade || true
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ APT Repositories uitbreiden
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#   ############################
#   ## Docker
#   ############################
#
#
#   Keyrings ophalen
install -m 0755 -d /etc/apt/keyrings
# LET OP Curl van Ubuntu gebruiken omdat Snap Curl maar beperkt toegang heeft tot filesystem
rm -f /etc/apt/keyrings/docker.asc
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
chmod a+r /etc/apt/keyrings/docker.asc
#
#   Keyrings toevoegen aan repository Debian
if [[ $distro = "debian" ]]; then
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
fi
#
#   Keyrings toevoegen aan repository Ubuntu
if [[ $distro = "ubuntu" ]]; then
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
fi
#
#
#   ############################
#   ## Microsoft
#   ############################
#
#
#   Zie https://learn.microsoft.com/en-us/linux/packages
#
curl -s -SL "https://packages.microsoft.com/config/$distro/$versie/packages-microsoft-prod.deb" -o "/tmp/packages-microsoft-prod.deb" > /dev/null 2>&1
dpkg -i /tmp/packages-microsoft-prod.deb > /dev/null 2>&1
#
#
#   ############################
#   ## Kubernetes
#   ############################
#
#
rm -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg
k8sstable_lang=$(curl -Ls https://dl.k8s.io/release/stable.txt)
k8sstable_kort=${k8sstable_lang:0:5}
curl -fsSL https://pkgs.k8s.io/core:/stable:/$k8sstable_kort/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$k8sstable_kort/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null 2>&1
##
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
clear
#
#
#
#
apt update -y
apt upgrade -y
apt autoremove -y
#
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ Services installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
#   ############################
#   ## Docker
#   ############################
#
#
#
#
clear
#
#
#
#
#   Docker installeren
APT_DOCKER_INSTALL_ARRAY=(
    "docker-ce"
    "docker-ce-cli"
    "containerd.io"
    "docker-buildx-plugin"
    "docker-compose-plugin"
)
for apt_docker_install in "${APT_DOCKER_INSTALL_ARRAY[@]}"; do
    apt install "$apt_docker_install" -qq -y 
done
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
clear
#
#
#
#
apt update -y
apt upgrade -y
apt autoremove -y
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Docker Images starten als Containers
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
clear
#
#
#
#
docker pull -q lirantal/dockly:latest
docker pull -q amir20/dozzle:latest
docker pull -q moncho/dry:latest
docker pull -q portainer/portainer-ce:latest  
docker pull -q nickfedor/watchtower
docker pull -q selfhostedpro/yacht:latest
#
#
docker volume create dozzle_data
docker volume create jenkins_data
docker volume create portainer_data
docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create sonarqube_logs
docker volume create sonarqube_temp
docker volume create yacht_data
#
#
docker run -q -d \
--publish 8000:8000 \
--publish 9101:9443 \
--name OMV_Lab_portainer \
--restart=always \
--volume /var/run/docker.sock:/var/run/docker.sock \
--volume portainer_data:/data \
portainer/portainer-ce:latest
#
#
docker run -q -d \
--publish 9102:8000 \
--name OMV_Lab_Yacht \
--restart=always \
--volume /var/run/docker.sock:/var/run/docker.sock \
--volume yacht_data:/config \
selfhostedpro/yacht
#
#
docker run -q -d \
--name OMV_Lab_Local_Registry \
--restart always \
--publish 9105:5000 \
--volume registry-data:/var/lib/registry \
registry
#
#
docker run -q -d \
--name OMV_Lab_Watchtower \
--restart always \
--publish 9106:8080 \
--volume /var/run/docker.sock:/var/run/docker.sock \
--volume /etc/localtime:/etc/localtime:ro \
nickfedor/watchtower \
-e WATCHTOWER_CLEANUP=true \
-e WATCHTOWER_SCHEDULE=0 0 */6 * * * \
-e TZ=Europe/Amsterdam
#
#
docker stop OMV_Lab_portainer
#
#
docker run -q -d \
--name OMV_Lab_Dozzle \
--volume=/var/run/docker.sock:/var/run/docker.sock \
--volume dozzle_data:/data \
--publish 9108:8080 \
amir20/dozzle:latest
#
#
docker run --rm -v portainer_data:/data portainer/helper-reset-password --password "!@#PASSword#$%"
docker start OMV_Lab_portainer
#
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Configuratie huidige gebruiker 
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#   Algemene Groepen
#
echo "Adding current user to several security groups"
usermod -aG _ssh        $SUDO_USER
usermod -aG operator    $SUDO_USER
usermod -aG root        $SUDO_USER
usermod -aG staff       $SUDO_USER
usermod -aG sys         $SUDO_USER
usermod -aG www-data    $SUDO_USER
usermod -aG docker      $SUDO_USER
#
#   Open Media Vault Groepen
#
if dpkg -l | grep -q openmediavault; then
    echo "Adding current user to Open Media Vault Security Groups"
    usermod -aG openmediavault-admin    $SUDO_USER
    usermod -aG openmediavault-config   $SUDO_USER
    usermod -aG openmediavault-engined  $SUDO_USER
    usermod -aG openmediavault-notify   $SUDO_USER
    usermod -aG openmediavault-webgui   $SUDO_USER
fi
#
#   Default Shell 
#
echo "Configure Default Shell for current user to Bash"
sudo usermod -s /bin/bash $SUDO_USER
#
#   Bash Shell instellingen
#
echo "Downloading BASH shell settings"
curl -s -o /home/${SUDO_USER}/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
curl -s -o /home/${SUDO_USER}/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
#
#
apt update -y
apt upgrade -y
apt autoremove -y
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ OpenMediaVault Plugins installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
#
#
echo "Installing Open Media Vault Plugins"
apt install openmediavault-apt -y
apt install openmediavault-apttool -y
apt install openmediavault-filebrowser -y
apt install openmediavault-hosts -y
apt install openmediavault-compose -y
apt install openmediavault-k8s -y
apt install openmediavault-webdav -y
#   apt install openmediavault-zfs -y
#
#
#
#
#   Thats all folks ! 
#
#
#
#
echo "System Reboot requested"
shutdown -r now
