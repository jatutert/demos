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
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Definitie Functies Script
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
function TS_OMV_Installer_Header () {
    echo   "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo   "@@@@@@  Open Media Vault (OMV) LAB Configuration Script by TutSOFT"
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
#   @@@@@ Huidig Linux Distro bepalen
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
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Windows Subsystem for Linux versie 2 
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
kernel_name=$(uname -r)
if [[ "${kernel_name,,}" == *"wsl"* || "$kernel_name" == *-WSL2 ]]; then
    readonly TS_OMV_wsl_present='true'
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Rechten controle
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [ $(id -u) -ne 0 ]; then
    #
    #
    clear
    #
    #
    TS_OMV_Installer_Header
    #
    #
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
#   @@@@@ Tijdzone configuratie
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    TARGET_TIMEZONE="Europe/Amsterdam"
    CURRENT_TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
    #
    if [ "$CURRENT_TIMEZONE" != "$TARGET_TIMEZONE" ]; then
        #
        clear
        #
        TS_OMV_Installer_Header
        #
        echo "Changing timezone to Europe/Amsterdam"
        timedatectl set-timezone "$TARGET_TIMEZONE" || true > /dev/null 2>&1
    fi
    #
    TS_OMV_Installer_Logger "#############################################"
    TS_OMV_Installer_Logger "Uitvoerende gebruiker is $USER"
    TS_OMV_Installer_Logger "Starttijd van het script $(date)"
    TS_OMV_Installer_Logger "Tijdzone instelling was $CURRENT_TIMEZONE"
    TS_OMV_Installer_Logger "Tijdzone ingesteld op $TARGET_TIMEZONE"
    TS_OMV_Installer_Logger "#############################################"
    #
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Huidig operating system bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
#
clear
#
TS_OMV_Installer_Header
#
tee /etc/apt/apt.conf.d/99quiet > /dev/null << 'EOF'
quiet "5";
Dpkg::Use-Pty "0";
EOF
#
echo "Updating Packages database"
apt update -qq -y || true > /dev/null 2>&1
#
echo "Updating Installed Packages"
apt upgrade -qq -y || true > /dev/null 2>&1
#
echo "Removing unnecessary packages"
apt autoremove -qq -y || true > /dev/null 2>&1 
#
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Applicaties installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    clear
    #
    TS_OMV_Installer_Header
    #
    echo "Installing Applications"
    #
    APT_INSTALL_ARRAY=(
        "7zip"
        "apt-transport-https"
        "bridge-utils"
        "ca-certificates"
        "curl"
        "dmidecode"
        "dpkg"
        "exif"
        "gcc"
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
        "okteta"
        "screenfetch"
        "sed"
        "software-properties-common"
        "steghide"
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
#   @@@@@ Cockpit installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
#
#
if ! systemctl is-active --quiet cockpit.socket; then
    #
    # ######################
    # ## Installeren
    # ######################
    #
    apt install -t ${VERSION_CODENAME}-backports cockpit -qq -y > /dev/null 2>&1
    #
    # ######################
    # ## Service
    # ######################
    #
    systemctl enable --now cockpit.socket > /dev/null 2>&1
    #
    # ######################
    # ## Poort
    # ######################
    #
    rm -f /tmp/listen.conf
    echo '[Socket]' > /tmp/listen.conf
    echo 'ListenStream=' >> /tmp/listen.conf
    echo 'ListenStream=8101' >> /tmp/listen.conf
    mkdir -p /etc/systemd/system/cockpit.socket.d/
    cp /tmp/listen.conf /etc/systemd/system/cockpit.socket.d
    #
    # ######################
    # ## Herstarten
    # ######################
    #
    systemctl daemon-reload > /dev/null 2>&1
    systemctl restart cockpit.socket > /dev/null 2>&1
fi
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
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    if [ ! -f "/etc/apt/sources.list.d/openmediavault.list" ]; then
        #
        if [[ $distro == "debian" ]] ; then
            #
            clear
            #
            TS_OMV_Installer_Header
            #
            if [[ $versie == "12" ]] ; then
                echo "Installing Open Media Vault 7"
                wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/installOld7 | sudo bash > /dev/null 2>&1
            fi
            #
            if [[ $versie == "13" ]] ; then
                echo "Installing Open Media Vault 8"
                wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash > /dev/null 2>&1
            fi
            #
        fi
        #
        if [[ $distro == "ubuntu" ]] ; then
            #
            clear
            #
            TS_OMV_Installer_Header
            #
            echo "Open Media Vault can only be installed on Debian Linux"
            #
        fi
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
if [[ $distro == "debian" ]] ; then
    #
    if dpkg -l | grep -q openmediavault; then
        #
        echo "Updating Open Media Vault"
        omv-upgrade || true > /dev/null 2>&1
        #
    fi
    #
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
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
        #   Keyrings ophalen
        install -m 0755 -d /etc/apt/keyrings
        # LET OP Curl van Ubuntu gebruiken omdat Snap Curl maar beperkt toegang heeft tot filesystem
        rm -f /etc/apt/keyrings/docker.asc
        curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc > /dev/null 2>&1
        chmod a+r /etc/apt/keyrings/docker.asc
        #
        #   Keyrings toevoegen aan repository Debian
        if [[ $distro = "debian" ]]; then
            #
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
            $(echo "$VERSION_CODENAME") stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
            #
        fi
        #
        #   Keyrings toevoegen aan repository Ubuntu
        if [[ $distro = "ubuntu" ]]; then
            #
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
            $(echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
            #
        fi
        #
    fi
    #
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
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    if [ ! -f "/etc/apt/sources.list.d/microsoft-prod.list" ]; then
        #
        curl -s -SL "https://packages.microsoft.com/config/$distro/$versie/packages-microsoft-prod.deb" -o "/tmp/packages-microsoft-prod.deb" > /dev/null 2>&1
        dpkg -i /tmp/packages-microsoft-prod.deb > /dev/null 2>&1
        #
    fi
    #
fi
#
#
#   ############################
#   ## Kubernetes
#   ############################
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    if [ ! -f "/etc/apt/sources.list.d/kubernetes.list" ]; then
        #
        rm -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg
        k8sstable_lang=$(curl -Ls https://dl.k8s.io/release/stable.txt)
        k8sstable_kort=${k8sstable_lang:0:5}
        curl -fsSL https://pkgs.k8s.io/core:/stable:/$k8sstable_kort/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
        echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$k8sstable_kort/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null 2>&1
        #
    fi
    #
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    clear
    #
    TS_OMV_Installer_Header
    #
    apt update -y       > /dev/null 2>&1
    apt upgrade -y      > /dev/null 2>&1
    apt autoremove -y   > /dev/null 2>&1
    #
fi
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
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
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
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    clear
    #
    TS_OMV_Installer_Header
    #
    apt update -y       > /dev/null 2>&1
    apt upgrade -y      > /dev/null 2>&1
    apt autoremove -y   > /dev/null 2>&1
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ Docker Images starten als Containers
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    #
    clear
    #
    #
    TS_OMV_Installer_Header
    #
    #
    if docker ps >/dev/null 2>&1; then
        #
        #
        docker ps -q | xargs -r docker stop >/dev/null 2>&1
        docker ps -aq | xargs -r docker rm >/dev/null 2>&1
        docker images | xargs -r docker rmi >/dev/null 2>&1
        docker volume ls | xargs -r docker volume rm >/dev/null 2>&1
        docker volume prune -a -f >/dev/null 2>&1
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
    fi
fi
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
if docker ps >/dev/null 2>&1; then
    usermod -aG docker      $SUDO_USER > /dev/null 2>&1
fi
#
#   Open Media Vault Groepen
#
if [[ $distro == "debian" ]]; then
    if dpkg -l | grep -q openmediavault; then
        echo "Adding current user to Open Media Vault Security Groups"
        usermod -aG openmediavault-admin    $SUDO_USER > /dev/null 2>&1
        usermod -aG openmediavault-config   $SUDO_USER > /dev/null 2>&1
        usermod -aG openmediavault-engined  $SUDO_USER > /dev/null 2>&1
        usermod -aG openmediavault-notify   $SUDO_USER > /dev/null 2>&1
        usermod -aG openmediavault-webgui   $SUDO_USER > /dev/null 2>&1
    fi
fi
#
#   Default Shell 
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    echo "Configure Default Shell for current user to Bash"
    sudo usermod -s /bin/bash $SUDO_USER > /dev/null 2>&1
fi
#
#   Bash Shell instellingen
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    echo "Downloading BASH shell settings"
    curl -s -o /home/${SUDO_USER}/.bashrc https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bashrc
    curl -s -o /home/${SUDO_USER}/.bash_profile https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/.bash_profile
fi
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@ APT Repository bijwerken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    clear
    #
    TS_OMV_Installer_Header
    #
    apt update -y       > /dev/null 2>&1
    apt upgrade -y      > /dev/null 2>&1
    apt autoremove -y   > /dev/null 2>&1
    #
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ OpenMediaVault Plugins installeren
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" ]]; then
    #
    clear
    #
    TS_OMV_Installer_Header
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
fi
#
#
#
#
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#   @@@@@@ Docker Network aanmaken
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
#
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
    #
    #
    clear
    #
    #
    TS_OMV_Installer_Header
    #
    #
    if docker ps >/dev/null 2>&1; then
        @echo "Docker Network MACVlan aanmaken"
        docker network create --driver macvlan --subnet 192.168.139.0/24 --gateway 192.168.139.2 localnetwork
    fi
fi
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
if [[ $distro == "debian" || $distro == "ubuntu" ]]; then
sudo tee /etc/apt/apt.conf.d/99quiet > /dev/null << 'EOF'
quiet "1";
Dpkg::Use-Pty "0";
EOF
fi
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