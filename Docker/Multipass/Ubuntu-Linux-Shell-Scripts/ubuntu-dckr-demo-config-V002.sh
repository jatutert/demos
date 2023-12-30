#! /bin/bash
#
#
#
#
# Configuratiescript DOCKER DEMO MultiPASS Virtualbox with Ubuntu 
# Versie: 1.0.0 
# Date: December 20 2023
# Author: John Tutert
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
        sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
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
        sudo sed -i 's/archive.ubuntu.com/nl.archive.ubuntu.com/g' /etc/apt/sources.list
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
function maak_docker_scripts () {
    #
    echo '#! /bin/bash' > /home/$SUDO_USER/scripts/docker/docker-install.sh  
    echo 'apt install -y curl apt-transport-https' >> /home/$SUDO_USER/scripts/docker/docker-install.sh
    echo 'apt purge -qq -y lxc-docker* || true' >> /home/$SUDO_USER/scripts/docker/docker-install.sh 
    echo 'curl -sSL https://get.docker.com/ | sh' >> /home/$SUDO_USER/scripts/docker/docker-install.sh 
    echo 'service docker start' >> /home/$SUDO_USER/scripts/docker/docker-install.sh  
    echo 'usermod -a -G docker $SUDO_USER' >> /home/$SUDO_USER/scripts/docker/docker-install.sh 
    echo 'shutdown -r now' >> /home/$SUDO_USER/scripts/docker/docker-install.sh 
    chmod +x /home/$SUDO_USER/scripts/docker/docker-install.sh 
    #
    # Docker-CE images ophalen script maken 
    echo '#! /bin/bash'       > /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo Hello World    >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull hello-world > /dev/null 2>&1'  >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo prakhar1989 static-site >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull prakhar1989/static-site > /dev/null 2>&1' >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh 
    echo echo Alpine Linux   >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull alpine > /dev/null 2>&1'       >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo Debian Linux   >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull debian > /dev/null 2>&1'       >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo MariaDB DBMS   >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull mariadb:10.6 > /dev/null 2>&1' >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo MinIO          >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull minio/minio > /dev/null 2>&1'  >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo NextCloud      >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull nextcloud > /dev/null 2>&1'    >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo NGNINX         >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull nginx > /dev/null 2>&1'        >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo ODOO ERP       >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull odoo:latest > /dev/null 2>&1'  >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo Postgress DBMS >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull postgres:latest > /dev/null 2>&1' >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo Registry       >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull registry > /dev/null 2>&1'     >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo Ubuntu 20 04 LTS >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull ubuntu:20.04 > /dev/null 2>&1' >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo echo WordPress      >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    echo 'docker pull wordpress > /dev/null 2>&1'    >> /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    chmod +x /home/$SUDO_USER/scripts/docker/pull-images/docker-pull-images.sh
    #
    # Docker-CE demo Alpine script maken
    echo '#! /bin/bash' > /home/$SUDO_USER/scripts/docker/alpine-run/alpine-run.sh
    echo 'clear' >> /home/$SUDO_USER/scripts/docker/alpine-run/alpine-run.sh
    echo 'docker run -it alpine /bin/sh' >> /home/$SUDO_USER/scripts/docker/alpine-run/alpine-run.sh
    chmod +x /home/$SUDO_USER/scripts/docker/alpine-run/alpine-run.sh
    #
    # Docker-CE demo Minio Script maken 
    echo '#! /bin/bash' > /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    echo '#' >> /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    echo '# Minio Object Storage on Docker' >> /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    echo 'docker run -d -p 9000:9000 -p 9001:9001 -p 9090:9090 --name minio -v /home/$USER/data/minio:/data -e "MINIO_ROOT_USER=minio1234" -e "MINIO_ROOT_PASSWORD=minio1234" minio/minio server /data --console-address ":9001"' >>/home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    echo 'echo MINIO_ROOT_USER=minio1234' >> /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    echo 'echo MINIO_ROOT_PASSWORD=minio1234' >> /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
    chmod +x /home/$SUDO_USER/scripts/minio_scripts/minio-docker-run.sh
}
#
function maak_compose_scripts () {
    #
    # Docker Compose demo script NextCloud
    echo '#! /bin/bash' > /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    echo '#' >> /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    echo 'cd /home/$USER' >> /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    echo 'clear' >> /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    echo 'docker compose -f /home/$USER/yaml/docker-compose/nextcloud/docker-compose.yml up --quiet-pull -d' >> /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    echo 'echo NextCloud port 8888'	>> /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    chmod +x /home/$SUDO_USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
    #
    # Docker Compose demo script ODOO
    echo '#! /bin/bash' > /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo '#'>> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo 'cd /home/$USER' >> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo 'clear' >> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo 'docker compose -f /home/$USER/yaml/docker-compose/odoo/docker-compose.yml up --quiet-pull -d' >> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo 'echo Odoo port 10016' >> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    echo 'echo Chat port 20016' >> /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
    chmod +x /home/$SUDO_USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
} 
#
# Function Installeren Docker 
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
function maak_docker_voorbeelden () {
    #
    # VOORBEELD ## Dockerfile uit slides van lesweek 4 module virtualisatie 
    echo '# start with OS ubuntu' > /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'FROM ubuntu:latest' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'RUN apt-get update' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'RUN apt-get -y upgrade' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo '# install apache2 in noninteractivemode' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo '# copy website' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'COPY index.html /var/www/html/' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo '# start webserver' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'CMD /usr/sbin/apache2ctl -D FOREGROUND' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo '# expose port 80' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    echo 'EXPOSE 80' >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file
    #
    echo "#! /bin/bash" > /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-build.sh
    echo "docker build –f /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-file -t ubtu-apache:V100 ." >> /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-build.sh
    chmod +x /home/$SUDO_USER/docker/apache/ubtu-apache-dkr-build.sh
    #
    # VOORBEELD ## FLASK demo
    # Default demo dockerfile 
    # https://hackmd.io/@pmanzoni/r1uWcTqfU
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file
    # Meerdere talen demo dockerfiles 
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file-de https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-de
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file-fr https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-fr
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file-it https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-it
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file-nl https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-nl
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-dkr-file-uk https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-uk
    # Python Script
    curl -s -o /home/$SUDO_USER/docker/flask-demo/app.py https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/app.py
    # Default index.html
    curl -s -o /home/$SUDO_USER/docker/flask-demo/templates/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index.html
    # Meerdere talen demo index.html 
    curl -s -o /home/$SUDO_USER/docker/flask-demo/deutsch/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-deutsch.html
    curl -s -o /home/$SUDO_USER/docker/flask-demo/english/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-english.html
    curl -s -o /home/$SUDO_USER/docker/flask-demo/francais/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-francais.html
    curl -s -o /home/$SUDO_USER/docker/flask-demo/italiano/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-italiano.html
    curl -s -o /home/$SUDO_USER/docker/flask-demo/nederlands/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-nederlands.html
    #
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-image-build.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-image-build.sh
    curl -s -o /home/$SUDO_USER/docker/flask-demo/flask-demo-run.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-run.sh
    #
    chmod +x /home/$SUDO_USER/docker/flask-demo/flask-image-build.sh
    chmod +x /home/$SUDO_USER/docker/flask-demo/flask-demo-run.sh
    #
}
#
function maak_compose_voorbeelden () {
    #
    # DOCKER COMPOSE YAML JTU bestanden ophalen
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/nextcloud/docker-compose.yml https://raw.githubusercontent.com/jatutert/demos/main/Docker-Compose/YAML/NextCloud/docker-compose-nextcloud-vagrant.yml
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/odoo/docker-compose.yml https://raw.githubusercontent.com/jatutert/demos/main/Docker-Compose/YAML/Odoo/docker-compose-odoo-vagrant.yml  
    # DOCKER COMPOSE YAML awesome compose YAML bestanden ophalen
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/prometheus-grafana/prometheus-grafana.yml https://raw.githubusercontent.com/docker/awesome-compose/master/prometheus-grafana/compose.yaml
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/nextcloud/nextcloud-redis-mariadb.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nextcloud-redis-mariadb/compose.yaml
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/nginx/nginx-flask-mysql.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nginx-flask-mysql/compose.yaml
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/nginx/nginx-flask-mongo.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nginx-flask-mongo/compose.yaml
    curl -s -o /home/$SUDO_USER/yaml/docker-compose/wordpress/wordpress-mysql.yml https://raw.githubusercontent.com/docker/awesome-compose/master/wordpress-mysql/compose.yaml
} 
#
#
# #######################################################################################################################
# AAN DE SLAG
# #######################################################################################################################
#
#
# Controle of script de juiste rechten heeft 
if [ $(id -u) -ne 0 ]; then
    echo "Dit script moet worden uitgevoerd als sudo."
    exit 1
fi
#
echo 'Configuratie DOCKER omgeving op' $NAME $VERSION 'gestart ...'
# Functie verder Ubuntu repo uitvoeren
change_ubuntu_repo
# Functie Bijwerken Ubuntu uitvoeren 
ubuntu_update
# Functie maak directories uitvoeren 
maak_directories
# Functie maak Scripts
maak_docker_scripts
maak_compose_scripts
# Functie Installeren DOCKER en DOCKER COMPOSE
install_docker
# Functie 
maak_docker_voorbeelden
maak_compose_voorbeelden
#
# Thats all folks 
#
exit 1 