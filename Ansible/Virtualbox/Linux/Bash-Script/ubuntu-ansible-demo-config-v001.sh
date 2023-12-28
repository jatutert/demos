#! /bin/bash
#
#
#
#
# Configuratiescript Ubuntu Ansible Controller en Host DEMO 
# Versie: 1.0.0
# Date: December 26 2023 
# Auteur: John Tutert
#
#
# #######################################################################################################################
# Variabelen
# #######################################################################################################################
# 
PRETTY_NAME=$(grep -oP '(?<=^PRETTY_NAME=).+' /etc/os-release | tr -d '"')
NAME=$(grep -oP '(?<=^NAME=).+' /etc/os-release | tr -d '"')
VERSION=$(grep -oP '(?<=^VERSION=).+' /etc/os-release | tr -d '"')
VERSION_ID=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
VERSION_CODENAME=$(grep -oP '(?<=^VERSION_CODENAME=).+' /etc/os-release | tr -d '"')
#
#
# #######################################################################################################################
# Functies
# #######################################################################################################################
#
#
# Function Change Repo Ubuntu 
#
function change_ubuntu_repo () {
    clear
    echo "Aanpassen Ubuntu Repository"
    if grep -q "mirrors.edge.kernel.org" /etc/apt/sources.list; then
        sed "s@mirrors.edge.kernel.org@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
        echo "Ubuntu Repository aangepast kernel.org naar ubuntu.com in sources.list"
    else
        # Replace the value with nl.archive.ubuntu.com
        echo "Mirrors.edge.kernel.org waarde niet aangetroffen in sources.list"
    fi
    #
    if grep -q "nl.archive.ubuntu.com" /etc/apt/sources.list; then
        echo "Ubuntu Repository is juist ingesteld"
    else
        # Replace the value with nl.archive.ubuntu.com
        sed "s@archive.ubuntu.com@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
        echo "Ubuntu Repository aangepast naar nl.archive.ubuntu.com in sources.list"
    fi
}
#
# Function Bijwerken Ubuntu 
#
function ubuntu_update () {
    apt update -qq
    apt upgrade -qq -y > /dev/null 2>&1
    apt autoremove -qq -y
    timedatectl set-timezone Europe/Amsterdam
} 
#
# Function maak directories 
#
function maak_directories () {
    #
    if [ ! -d "/home/$SUDO_USER/scripts" ]; then
        mkdir -p /home/$SUDO_USER/scripts
        mkdir -p /home/$SUDO_USER/scripts/gui
        mkdir -p /home/$SUDO_USER/scripts/tmp
        mkdir -p /home/$SUDO_USER/scripts/docker
        mkdir -p /home/$SUDO_USER/scripts/docker/alpine-run
        mkdir -p /home/$SUDO_USER/scripts/docker/portainer
        mkdir -p /home/$SUDO_USER/scripts/docker/pull-images
        mkdir -p /home/$SUDO_USER/scripts/docker-compose
        mkdir -p /home/$SUDO_USER/scripts/docker-compose/mysql
        mkdir -p /home/$SUDO_USER/scripts/docker-compose/nextcloud
        mkdir -p /home/$SUDO_USER/scripts/docker-compose/nginx
        mkdir -p /home/$SUDO_USER/scripts/docker-compose/odoo
        mkdir -p /home/$SUDO_USER/scripts/docker-compose/prometheus-grafana
        mkdir -p /home/$SUDO_USER/scripts/kubernetes
        mkdir -p /home/$SUDO_USER/scripts/minio_scripts
        mkdir -p /home/$SUDO_USER/scripts/intro_infra
        mkdir -p /home/$SUDO_USER/scripts/it-fundmtls
        chown -f -R $SUDO_USER /home/$SUDO_USER/scripts
    fi
    #
    if [ ! -d "/home/$SUDO_USER/docker" ]; then  
        mkdir -p /home/$SUDO_USER/docker
        mkdir -p /home/$SUDO_USER/docker/apache 
        mkdir -p /home/$SUDO_USER/docker/flask-demo
        mkdir -p /home/$SUDO_USER/docker/flask-demo/templates 
        mkdir -p /home/$SUDO_USER/docker/flask-demo/deutsch 
        mkdir -p /home/$SUDO_USER/docker/flask-demo/english 
        mkdir -p /home/$SUDO_USER/docker/flask-demo/francais
        mkdir -p /home/$SUDO_USER/docker/flask-demo/italiano 
        mkdir -p /home/$SUDO_USER/docker/flask-demo/nederlands 
        mkdir -p /home/$SUDO_USER/docker/mysql
        mkdir -p /home/$SUDO_USER/docker/nextcloud
        mkdir -p /home/$SUDO_USER/docker/nginx
        mkdir -p /home/$SUDO_USER/docker/odoo
        mkdir -p /home/$SUDO_USER/docker/portainer
        mkdir -p /home/$SUDO_USER/docker/prometheus-grafana
        chown -f -R $SUDO_USER /home/$SUDO_USER/docker
    fi 
    #
#    if [ ! -d "/home/$SUDO_USER/docker-compose" ]; then  
#        mkdir -p /home/$SUDO_USER/docker-compose
#        mkdir -p /home/$SUDO_USER/docker-compose/mysql
#        mkdir -p /home/$SUDO_USER/docker-compose/nextcloud
#        mkdir -p /home/$SUDO_USER/docker-compose/nginx
#        mkdir -p /home/$SUDO_USER/docker-compose/odoo
#        mkdir -p /home/$SUDO_USER/docker-compose/prometheus-grafana 
#        chown -f -R $SUDO_USER /home/$SUDO_USER/docker-compose
#    fi
    #
    if [ ! -d "/home/$SUDO_USER/data" ]; then  
        mkdir -p /home/$SUDO_USER/data
        mkdir -p /home/$SUDO_USER/data/minio
        mkdir -p /home/$SUDO_USER/data/nextcloud
        mkdir -p /home/$SUDO_USER/data/nextcloud/html
        mkdir -p /home/$SUDO_USER/data/nextcloud/html/data
        mkdir -p /home/$SUDO_USER/data/odoo
        mkdir -p /home/$SUDO_USER/data/odoo/addons
        mkdir -p /home/$SUDO_USER/data/odoo/etc
        mkdir -p /home/$SUDO_USER/data/odoo/postgresql
        chown -f -R $SUDO_USER /home/$SUDO_USER/data
    fi
    #
    if [ ! -d "/home/$SUDO_USER/yaml" ]; then  
        mkdir -p /home/$SUDO_USER/yaml
        mkdir -p /home/$SUDO_USER/yaml/docker-compose
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/mysql
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/nextcloud
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/nginx
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/odoo
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/prometheus-grafana
        mkdir -p /home/$SUDO_USER/yaml/docker-compose/wordpress
        mkdir -p /home/$SUDO_USER/yaml/kubernetes
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/mysql
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/nextcloud
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/nginx
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/odoo
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/prometheus-grafana
        mkdir -p /home/$SUDO_USER/yaml/kubernetes/wordpress
        chown -f -R $SUDO_USER /home/$SUDO_USER/yaml
    fi
    #
    if [ ! -d "/home/$SUDO_USER/tmp" ]; then
        mkdir -p /home/$SUDO_USER/tmp
        chown -f -R $SUDO_USER /home/$SUDO_USER/tmp
    fi 
}
#
# Function Installeren Docker 
#
#
function install_docker() {
  # Check if Docker is installed
  if ! [ -x "$(command -v docker)" ]; then
    echo 'Docker is not installed. Installing Docker...' >&2
    # ChatGPT curl -fsSL https://get.docker.com -o get-docker.sh
    # ChatGPT sudo sh get-docker.sh
    apt install -y curl apt-transport-https
    apt purge -qq -y lxc-docker* || true
    curl -sSL https://get.docker.com/ | sh
    service docker start
    usermod -a -G docker $SUDO_USER
  else
    echo 'Docker is already installed.'
  fi
}
#
#
# Function Minikube config 
#
#
function minikube_config () {
    minikube config set driver docker 
    # Beschikbaar geheugen delen door 4 en in variable stoppen
    ram=$(free --mega | grep 'Mem' | awk '{print $7/4}')
    minikube config set memory $ram 
    cpu_aantal=$(nproc)
    minikube config set cpus $cpu_aantal  
    # minikube config view 
    #
    echo "#! /bin/bash" > /home/$SUDO_USER/minikube_config.sh 
    echo "minikube config set driver docker" >> /home/$SUDO_USER/minikube_config.sh 
    echo "ram=$(free --mega | grep 'Mem' | awk '{print $7/4}')" >> /home/$SUDO_USER/minikube_config.sh 
    echo "minikube config set memory $ram" >> /home/$SUDO_USER/minikube_config.sh  
    echo "cpu_aantal=$(nproc)" >> /home/$SUDO_USER/minikube_config.sh  
    echo "minikube config set cpus $cpu_aantal" >> /home/$SUDO_USER/minikube_config.sh  
    chmod +x /home/$SUDO_USER/minikube_config.sh 
}
#
#
# #######################################################################################################################
# AAN DE SLAG
# #######################################################################################################################
#
#
# Check of script wordt uitgevoerd als SUDO 
if [ $(id -u) -ne 0 ]; then
    echo "Dit script moet worden uitgevoerd als sudo."
    exit 1
fi
#
echo 'Configuratie ANSIBLE omgeving op' $NAME $VERSION 'gestart ...'
#
# MASTER
# ######
#
#
# Haal de hostname op
hostname=$(hostname)
#
# Hostname ulx-s-2204-a-cntrl is Ansible Controller 
if [ "$hostname" == "ulx-s-2204-a-cntrl" ]; then
    #
    # Stap 1 Installatie
    # Aanpassen Ubuntu Standaard Repository naar Nederland 
    change_ubuntu_repo
    # Upgraden Ubuntu naar laatste stand van zaken 
    ubuntu_update
    # Ansible Repo toevoegen 
    apt-add-repository ppa:ansible/ansible -y > /dev/null 2>&1
    # Upgraden Ubuntu naar laatste stand van zaken
    ubuntu_update
    # Installeren ANSIBLE latest
    apt install ansible -y > /dev/null 2>&1
    echo "Stap 1 Installatie Ansible gereed"
    # 
    # Stap 2 Aanpassen etc hosts bestand 
    # vullen variable hostname
    hostname=$(hostname)
    # Haal het IP-adres van enp0s8 op
    enp0s8_ip=$(ip addr show enp0s8 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
    # Voeg 1 toe aan het IP-adres van enp0s8
    IFS=. read -r a b c d <<< "$enp0s8_ip"
    enp0s8_plus1_ip="$a.$b.$c.$((d+1))"
    # Sla de IP-adressen op in afzonderlijke variabelen
    enp0s8_ip_var="enp0s8_ip=$enp0s8_ip"
    enp0s8_plus1_ip_var="enp0s8_plus1_ip=$enp0s8_plus1_ip"
    # Aanpassen hosts bestand 
    if grep -q "$enp0s8_ip" /etc/hosts; then
        echo "$hostname already exists in /etc/hosts"
    else
        # Add the hostname and IP address to /etc/hosts
        echo "$enp0s8_ip ulx-s-2204-a-cntrl" | sudo tee -a /etc/hosts > /dev/null
        echo "$enp0s8_plus1_ip ulx-s-2204-a-h-010" | sudo tee -a /etc/hosts > /dev/null
        echo "Hostname $hostname added to /etc/hosts"
    fi
    #
    echo "Aanpassen Ubuntu Hosts bestand gereed"
    #
    # Stap 3 Inventory ophalen van GitHUB  
    mkdir -p /etc/ansible/inventory 
    curl -s -o /etc/ansible/inventory/ansible_demo https://raw.githubusercontent.com/jatutert/Ansible/main/Inventory/ansible_demo
    # curl -s -o /etc/ansible/inventory/db_servers https://raw.githubusercontent.com/jatutert/Ansible/main/Inventory/db_servers
    # curl -s -o /etc/ansible/inventory/load_balancers https://raw.githubusercontent.com/jatutert/Ansible/main/Inventory/load_balancers
    # curl -s -o /etc/ansible/inventory/webservers https://raw.githubusercontent.com/jatutert/Ansible/main/Inventory/webservers
    # curl -s -o /etc/ansible/inventory/werkstations https://raw.githubusercontent.com/jatutert/Ansible/main/Inventory/werkstations
    echo "Ophalen Inventory vanaf GitHub gereed"
    # 
    # Stap 4 aanpassen ansible config met Inventory 
    if grep -q "defaults" /etc/ansible/ansible.cfg; then
        echo "Ansible Configuratiebestand reeds voorzien van Inventory"
    else
        # Add the hostname and IP address to /etc/hosts
        echo "[defaults]" | sudo tee -a /etc/ansible/ansible.cfg > /dev/null
        echo "inventory = inventory/" | sudo tee -a /etc/ansible/ansible.cfg > /dev/null
        echo "Ansible Configuratiebestand voorzien van Inventory"
    fi
    #
    echo "Aanpassen Ansible CFG gereed" 
    #
    # Stap 5 Playbooks ophalen van GitHUB
    mkdir -p /home/$SUDO_USER/playbooks
    chown -f -R $SUDO_USER /home/$SUDO_USER/playbooks
    curl -s -o /home/$SUDO_USER/playbooks/ansible_demo_playbook.yml https://raw.githubusercontent.com/jatutert/Ansible/main/PlayBooks/Ubuntu-Linux/ansible_demo_playbook.yml
    echo "Ophalen Ansible Playbooks vanaf GitHUB gereed"
    #
    # Stap 6 SSH verbinden script maken 
    echo 'sshpass -p "ubuntu" ssh -o StrictHostKeyChecking=no vagrant@ulx-s-2204-a-h-010' > /home/$SUDO_USER/ansible_host_ssh.sh 
    chmod +x /home/$SUDO_USER/ansible_host_ssh.sh
    # 
    # Stap x 
fi
#
#
# SLAVE
# ######
#
# 
# Haal de hostname op
hostname=$(hostname)
#
# Hostname ulx-s-2204-a-h-010 is slaaf 1 voor ansible controller 
if [ "$hostname" == "ulx-s-2204-a-h-010" ]; then
    # Stap 1 Installatie
    # Aanpassen Ubuntu Standaard Repository naar Nederland 
    change_ubuntu_repo
    # Upgraden Ubuntu naar laatste stand van zaken 
    ubuntu_update
    #
    # Stap 2 Installatie SSHPASS
    # 
    # Starten installatie sshpass
    apt install sshpass -y
    #
    # Stap 3 Aanpassen etc hosts bestand
    #
    # vullen variable hostname
    hostname=$(hostname)
    # Haal het IP-adres van enp0s8 op
    enp0s8_ip=$(ip addr show enp0s8 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
    # Voeg 1 toe aan het IP-adres van enp0s8
    IFS=. read -r a b c d <<< "$enp0s8_ip"
    enp0s8_min1_ip="$a.$b.$c.$((d-1))"
    # Sla de IP-adressen op in afzonderlijke variabelen
    enp0s8_ip_var="enp0s8_ip=$enp0s8_ip"
    enp0s8_min1_ip_var="enp0s8_min1_ip=$enp0s8_min1_ip"
    if grep -q "$enp0s8_ip" /etc/hosts; then
        echo "$hostname already exists in /etc/hosts"
    else
        # Add the hostname and IP address to /etc/hosts
        echo "$enp0s8_ip ulx-s-2204-a-h-010" | sudo tee -a /etc/hosts > /dev/null
        echo "$enp0s8_min1_ip ulx-s-2204-a-cntrl" | sudo tee -a /etc/hosts > /dev/null
        echo "Hostname $hostname added to /etc/hosts"
    fi                
    #
    # Stap 4 SSH verbinden script maken 
    echo 'sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@ulx-s-2204-l-a-001' > /home/$SUDO_USER/ansible_cntrl_ssh.sh 
    chmod +x /home/$SUDO_USER/ansible_cntrl_ssh.sh 
    #
    # Stap x  
    #
fi
#
# Thats all folks 
#
exit 1 