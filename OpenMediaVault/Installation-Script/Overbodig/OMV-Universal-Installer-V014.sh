#! /bin/bash


#
#   In deze versie van het script zit aanpassing naar static IP adres
#
#   Na de installatie van OMV zet OMV alles weer op dynamic 
#


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
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Definitie Functies Script
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
function TS_OMV_Installer_Header () {
    echo   "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo   "@@@@@@  Open Media Vault (OMV) Configurator Script by TutSOFT"
    echo   "@@@@@@  Created for Personal and/or Educational Use"
    echo   "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
}
#
#
function TS_OMV_Installer_Logger () {
    echo "$1" | sudo tee -a /var/log/TS_OMV_Installer_Logger.log > /dev/null 2>&1
}
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ START
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
TS_OMV_Installer_Header
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
#   @@@@@   IP Adres aanpassen 
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#




##############################################################################
# Instellingen
##############################################################################

NETWORK_PREFIX="192.168.139"
NEW_IP="192.168.139.11/24"
NEW_GW="192.168.139.2"

TEST_IP="8.8.8.8"
PING_COUNT=3

##############################################################################
# Interface zoeken
##############################################################################

echo "Zoeken naar netwerkkaart in ${NETWORK_PREFIX}.x ..."

NIC=$(ip -4 -o addr show | \
      awk -v net="${NETWORK_PREFIX}" '$4 ~ "^"net"\\." {print $2; exit}')

if [ -z "${NIC}" ]; then
    echo "Geen netwerkkaart gevonden met een adres in ${NETWORK_PREFIX}.x"
    exit 1
fi

echo "Gevonden interface : ${NIC}"

##############################################################################
# Huidige configuratie opslaan
##############################################################################

OLD_IP=$(ip -4 -o addr show dev "${NIC}" | awk '{print $4}' | head -n1)

OLD_GW=$(ip route show default | \
         awk '/default/ {print $3; exit}')

echo "Huidig IP      : ${OLD_IP}"
echo "Huidige gateway: ${OLD_GW}"

##############################################################################
# Nieuwe configuratie toepassen
##############################################################################

echo
echo "Nieuwe configuratie toepassen..."

ip addr flush dev "${NIC}"

ip addr add "${NEW_IP}" dev "${NIC}"

ip link set "${NIC}" up

ip route del default 2>/dev/null

ip route add default via "${NEW_GW}" dev "${NIC}"

##############################################################################
# Resultaat tonen
##############################################################################

echo
echo "Nieuwe instellingen:"
ip -4 addr show dev "${NIC}" | grep inet

echo
ip route | grep default

##############################################################################
# Connectiviteitstest
##############################################################################

echo
echo "Controleren van netwerkverbinding..."

sleep 5

if ping -c ${PING_COUNT} -W 2 ${TEST_IP} >/dev/null 2>&1
then
    echo "Netwerkverbinding is OK."
else
    echo
    echo "WAARSCHUWING: Verbindingstest mislukt."
    echo "Oude configuratie wordt hersteld..."

    ip addr flush dev "${NIC}"
    ip addr add "${OLD_IP}" dev "${NIC}"

    ip route del default 2>/dev/null

    if [ -n "${OLD_GW}" ]; then
        ip route add default via "${OLD_GW}" dev "${NIC}"
    fi

    echo "Oude configuratie hersteld."
    exit 2
fi

echo "Netwerkconfiguratie succesvol aangepast."

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
#
sudo tee /etc/apt/apt.conf.d/99quiet > /dev/null << 'EOF'
quiet "5";
Dpkg::Use-Pty "0";
EOF
#
apt update -qq -y || true > /dev/null 2>&1
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
#
#
fi
#
#
#
#
echo "Installing Debian Applications"
if [[ $distro == "debian" ]]; then
    #
    APT_INSTALL_ARRAY=(
        "7zip"
        "apt-transport-https"
        "bridge-utils"
        "ca-certificates"
        "curl"
        "dmidecode"
        "dpkg"
        "git"
        "glances"
        "gnupg"
        "gzip"
        "jq"
        "make"
        "mc"
        "micro"
        "nano"
        "neofetch"
        "nmap"
        "screenfetch"
        "sed"
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
        apt install "$apt_install" -qq -y || true > /dev/null 2>&1
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
TS_OMV_Installer_Header
#
#
if [[ $distro == "debian" ]] ; then
    if [[ $versie == "12" ]] ; then
        echo "Installing Open Media Vault 7"
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/installOld7 | sudo bash > /dev/null 2>&1
    fi
    if [[ $versie == "13" ]] ; then
        echo "Installing Open Media Vault 8"
        wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash > /dev/null 2>&1
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
TS_OMV_Installer_Header
#
#
if dpkg -l | grep -q openmediavault; then
    echo "Updating Open Media Vault"
    omv-upgrade || true > /dev/null 2>&1
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
TS_OMV_Installer_Header
#
#
apt update -y       > /dev/null 2>&1
apt upgrade -y      > /dev/null 2>&1
apt autoremove -y   > /dev/null 2>&1
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
TS_OMV_Installer_Header
#
#
echo "Installing Docker CE"
#   Docker installeren
APT_DOCKER_INSTALL_ARRAY=(
    "docker-ce"
    "docker-ce-cli"
    "containerd.io"
    "docker-buildx-plugin"
    "docker-compose-plugin"
)
for apt_docker_install in "${APT_DOCKER_INSTALL_ARRAY[@]}"; do
    apt install "$apt_docker_install" -qq -y > /dev/null 2>&1
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
TS_OMV_Installer_Header
#
#
apt update -y       > /dev/null 2>&1
apt upgrade -y      > /dev/null 2>&1
apt autoremove -y   > /dev/null 2>&1
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Docker Images starten als Containers
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
##
#
clear
#
#
TS_OMV_Installer_Header
#
#
echo "Docker Images pull"
docker pull -q lirantal/dockly:latest           > /dev/null 2>&1
docker pull -q amir20/dozzle:latest             > /dev/null 2>&1
docker pull -q moncho/dry:latest                > /dev/null 2>&1
docker pull -q portainer/portainer-ce:latest    > /dev/null 2>&1
docker pull -q nickfedor/watchtower             > /dev/null 2>&1
docker pull -q selfhostedpro/yacht:latest       > /dev/null 2>&1
#
#
echo "Docker Volumes create"
docker volume create dozzle_data                > /dev/null 2>&1
docker volume create jenkins_data               > /dev/null 2>&1
docker volume create portainer_data             > /dev/null 2>&1
docker volume create sonarqube_data             > /dev/null 2>&1
docker volume create sonarqube_extensions       > /dev/null 2>&1
docker volume create sonarqube_logs             > /dev/null 2>&1
docker volume create sonarqube_temp             > /dev/null 2>&1
docker volume create yacht_data                 > /dev/null 2>&1
#
#
docker run -q -d \
--publish 8000:8000 \
--publish 9101:9443 \
--name OMV_Lab_portainer \
--restart=always \
--volume /var/run/docker.sock:/var/run/docker.sock \
--volume portainer_data:/data \
portainer/portainer-ce:latest \
--no-setup-token
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
docker run -q -d \
--name OMV_Lab_Dozzle \
--volume=/var/run/docker.sock:/var/run/docker.sock \
--volume dozzle_data:/data \
--publish 9108:8080 \
amir20/dozzle:latest
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
usermod -aG _ssh        $SUDO_USER > /dev/null 2>&1
usermod -aG operator    $SUDO_USER > /dev/null 2>&1
usermod -aG root        $SUDO_USER > /dev/null 2>&1
usermod -aG staff       $SUDO_USER > /dev/null 2>&1
usermod -aG sys         $SUDO_USER > /dev/null 2>&1
usermod -aG www-data    $SUDO_USER > /dev/null 2>&1
usermod -aG docker      $SUDO_USER > /dev/null 2>&1
#
#   Open Media Vault Groepen
#
if dpkg -l | grep -q openmediavault; then
    echo "Adding current user to Open Media Vault Security Groups"
    usermod -aG openmediavault-admin    $SUDO_USER > /dev/null 2>&1
    usermod -aG openmediavault-config   $SUDO_USER > /dev/null 2>&1
    usermod -aG openmediavault-engined  $SUDO_USER > /dev/null 2>&1
    usermod -aG openmediavault-notify   $SUDO_USER > /dev/null 2>&1
    usermod -aG openmediavault-webgui   $SUDO_USER > /dev/null 2>&1
fi
#
#   Default Shell 
#
echo "Configure Default Shell for current user to Bash"
sudo usermod -s /bin/bash $SUDO_USER > /dev/null 2>&1
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
TS_OMV_Installer_Header
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
TS_OMV_Installer_Header
#
#
echo "Installing Open Media Vault Plugins"
apt install openmediavault-apt -qq -y > /dev/null 2>&1
apt install openmediavault-apttool -qq -y > /dev/null 2>&1
#   apt install openmediavault-filebrowser -y
apt install openmediavault-hosts -qq -y > /dev/null 2>&1
apt install openmediavault-compose -qq -y > /dev/null 2>&1
apt install openmediavault-k8s -qq -y > /dev/null 2>&1
apt install openmediavault-webdav -qq -y > /dev/null 2>&1
#   apt install openmediavault-zfs -y
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ Docker Network aanmaken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
TS_OMV_Installer_Header
#
#
@echo "Docker Network MACVlan aanmaken"
docker network create --driver macvlan --subnet 192.168.139.0/24 --gateway 192.168.139.2 localnetwork
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ Docker Compose Configuratie bestanden downloaden
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
TS_OMV_Installer_Header
#
#
curl -L -o /home/$SUDO_USER/osTicket-Compose.yml https://msiekmans.github.io/compose/osTicket.txt
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ APT meer meldingen laten geven
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
TS_OMV_Installer_Header
#
#
sudo tee /etc/apt/apt.conf.d/99quiet > /dev/null << 'EOF'
quiet "1";
Dpkg::Use-Pty "0";
EOF
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ EINDE
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
clear
#
#
TS_OMV_Installer_Header
#
#
echo "System Reboot requested"
shutdown -r now
#
#
#
#
#   Thats all folks ! 
#
#
#
#