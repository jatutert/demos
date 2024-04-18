#! /bin/bash
#
#
# Configuratiescript Minikube Virtual Machine
# Versie: 1.0.0 DEVELOP d.d. 18-04-2024
# Auteur: John Tutert
#
#
# Functies
#
#
# Function 1 Zet Tijd
#
#
function zet_tijd () {
    #
	sudo timedatectl set-timezone Europe/Amsterdam
}
#
#
# Function 2 Maak directories 
#
#
function maak_directories () {
    #
    if [ ! -d "/home/$USER/scripts" ]; then
        mkdir -p /home/$USER/scripts
        mkdir -p /home/$USER/scripts/gui
        mkdir -p /home/$USER/scripts/tmp
        mkdir -p /home/$USER/scripts/docker
        mkdir -p /home/$USER/scripts/docker/alpine-run
        mkdir -p /home/$USER/scripts/docker/portainer
        mkdir -p /home/$USER/scripts/docker/pull-images
        mkdir -p /home/$USER/scripts/docker-compose
        mkdir -p /home/$USER/scripts/docker-compose/mysql
        mkdir -p /home/$USER/scripts/docker-compose/nextcloud
        mkdir -p /home/$USER/scripts/docker-compose/nginx
        mkdir -p /home/$USER/scripts/docker-compose/odoo
        mkdir -p /home/$USER/scripts/docker-compose/prometheus-grafana
        mkdir -p /home/$USER/scripts/kubernetes
        mkdir -p /home/$USER/scripts/minio_scripts
        mkdir -p /home/$USER/scripts/intro_infra
        mkdir -p /home/$USER/scripts/it-fundmtls
        chown -f -R $USER /home/$USER/scripts
    fi
    #
    if [ ! -d "/home/$USER/docker" ]; then  
        mkdir -p /home/$USER/docker
        mkdir -p /home/$USER/docker/apache 
        mkdir -p /home/$USER/docker/flask-demo
        mkdir -p /home/$USER/docker/flask-demo/templates 
        mkdir -p /home/$USER/docker/flask-demo/deutsch 
        mkdir -p /home/$USER/docker/flask-demo/english 
        mkdir -p /home/$USER/docker/flask-demo/francais
        mkdir -p /home/$USER/docker/flask-demo/italiano 
        mkdir -p /home/$USER/docker/flask-demo/nederlands 
        mkdir -p /home/$USER/docker/mysql
        mkdir -p /home/$USER/docker/nextcloud
        mkdir -p /home/$USER/docker/nginx
        mkdir -p /home/$USER/docker/odoo
        mkdir -p /home/$USER/docker/portainer
        mkdir -p /home/$USER/docker/prometheus-grafana
        chown -f -R $USER /home/$USER/docker
    fi 
    #
    if [ ! -d "/home/$USER/docker-compose" ]; then  
        mkdir -p /home/$USER/docker-compose
        mkdir -p /home/$USER/docker-compose/mysql
        mkdir -p /home/$USER/docker-compose/nextcloud
        mkdir -p /home/$USER/docker-compose/nginx
        mkdir -p /home/$USER/docker-compose/odoo
        mkdir -p /home/$USER/docker-compose/prometheus-grafana 
        chown -f -R $USER /home/$USER/docker-compose
    fi
    #
    if [ ! -d "/home/$USER/data" ]; then  
        mkdir -p /home/$USER/data
        mkdir -p /home/$USER/data/minio
        mkdir -p /home/$USER/data/nextcloud
        mkdir -p /home/$USER/data/nextcloud/html
        mkdir -p /home/$USER/data/nextcloud/html/data
        mkdir -p /home/$USER/data/odoo
        mkdir -p /home/$USER/data/odoo/addons
        mkdir -p /home/$USER/data/odoo/etc
        mkdir -p /home/$USER/data/odoo/postgresql
        chown -f -R $USER /home/$USER/data
    fi
    #
    if [ ! -d "/home/$USER/yaml" ]; then  
        mkdir -p /home/$USER/yaml
        mkdir -p /home/$USER/yaml/docker-compose
        mkdir -p /home/$USER/yaml/docker-compose/mysql
        mkdir -p /home/$USER/yaml/docker-compose/nextcloud
        mkdir -p /home/$USER/yaml/docker-compose/nginx
        mkdir -p /home/$USER/yaml/docker-compose/odoo
        mkdir -p /home/$USER/yaml/docker-compose/prometheus-grafana
        mkdir -p /home/$USER/yaml/docker-compose/wordpress
        mkdir -p /home/$USER/yaml/kubernetes
        mkdir -p /home/$USER/yaml/kubernetes/mysql
        mkdir -p /home/$USER/yaml/kubernetes/nextcloud
        mkdir -p /home/$USER/yaml/kubernetes/nginx
        mkdir -p /home/$USER/yaml/kubernetes/odoo
        mkdir -p /home/$USER/yaml/kubernetes/prometheus-grafana
        mkdir -p /home/$USER/yaml/kubernetes/wordpress
        chown -f -R $USER /home/$USER/yaml
    fi
    #
    if [ ! -d "/home/$USER/k8s-demo" ]; then  
        mkdir -p /home/$USER/k8s-demo 
        mkdir -p /home/$USER/k8s-demo/mysql
        mkdir -p /home/$USER/k8s-demo/nextcloud
        mkdir -p /home/$USER/k8s-demo/nginx
        mkdir -p /home/$USER/k8s-demo/nginx/simple
        mkdir -p /home/$USER/k8s-demo/nginx/replicas
        mkdir -p /home/$USER/k8s-demo/odoo
        chown -f -R $USER /home/$USER/k8s-demo
    fi 
}
#
#
# DEEL 1 Tijdzone goedzetten
#
zet_tijd
#
# DEEL 2 Directory structuur opzetten 
maak_directories
#
# DEEL 3 Scripts maken 
#
# 3A Docker-CE images ophalen script maken 
echo '#! /bin/bash'       > /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo Hello World    >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull hello-world > /dev/null 2>&1'  >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo prakhar1989 static-site >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull prakhar1989/static-site > /dev/null 2>&1' >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh 
echo echo Alpine Linux   >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull alpine > /dev/null 2>&1'       >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo Debian Linux   >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull debian > /dev/null 2>&1'       >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo MariaDB DBMS   >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull mariadb:10.6 > /dev/null 2>&1' >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo echo MinIO          >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo 'docker pull minio/minio > /dev/null 2>&1'  >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo echo NextCloud      >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo 'docker pull nextcloud > /dev/null 2>&1'    >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo NGNINX         >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull nginx > /dev/null 2>&1'        >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo echo ODOO ERP       >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
# echo 'docker pull odoo:latest > /dev/null 2>&1'  >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo Postgress DBMS >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull postgres:latest > /dev/null 2>&1' >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo Registry       >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull registry > /dev/null 2>&1'     >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo Ubuntu 22 04 LTS >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull ubuntu:22.04 > /dev/null 2>&1' >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo echo WordPress      >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
echo 'docker pull wordpress > /dev/null 2>&1'    >> /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
chmod +x /home/$USER/scripts/docker/pull-images/docker-pull-images.sh
#
# 3B Docker-CE demo Alpine script maken
echo '#! /bin/bash' > /home/$USER/scripts/docker/alpine-run/alpine-run.sh
echo 'clear' >> /home/$USER/scripts/docker/alpine-run/alpine-run.sh
echo 'docker run -it alpine /bin/sh' >> /home/$USER/scripts/docker/alpine-run/alpine-run.sh
chmod +x /home/$USER/scripts/docker/alpine-run/alpine-run.sh
#
# 3C Portainer Run
echo '#! /bin/bash' > /home/$USER/scripts/docker/portainer/portainer-run.sh
echo 'docker pull portainer/portainer-ce:latest' >> /home/$USER/scripts/docker/portainer/portainer-run.sh
echo 'docker volume create portainer_data' >> /home/$USER/scripts/docker/portainer/portainer-run.sh
echo 'docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest' >> /home/$USER/scripts/docker/portainer/portainer-run.sh
echo 'echo Ga naar https://xxxxxxx:9443' >> /home/$USER/scripts/docker/portainer/portainer-run.sh
chmod +x /home/$USER/scripts/docker/portainer/portainer-run.sh
#
# 3D Portainer Remove
echo '#! /bin/bash' > /home/$USER/scripts/docker/portainer/portainer-remove.sh
echo 'docker stop portainer' >> /home/$USER/scripts/docker/portainer/portainer-remove.sh
echo 'docker rm portainer' >> /home/$USER/scripts/docker/portainer/portainer-remove.sh
echo 'docker rmi portainer/portainer-ce:latest' >> /home/$USER/scripts/docker/portainer/portainer-remove.sh
echo 'docker volume rm portainer_data' >> /home/$USER/scripts/docker/portainer/portainer-remove.sh
echo 'docker system prune' >> /home/$USER/scripts/docker/portainer/portainer-remove.sh
chmod +x /home/$USER/scripts/docker/portainer/portainer-remove.sh
#
# 3E Docker Compose demo script NextCloud
echo '#! /bin/bash' > /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
echo '#' >> /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
echo 'cd /home/$USER' >> /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
echo 'clear' >> /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
echo 'docker compose -f /home/$USER/yaml/docker-compose/nextcloud/docker-compose.yml up --quiet-pull -d' >> /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
echo 'echo NextCloud port 8888'	>> /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
chmod +x /home/$USER/scripts/docker-compose/nextcloud/docker-compose-nextcloud.sh
#
# 3F Docker Compose demo script ODOO
echo '#! /bin/bash' > /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo '#'>> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo 'cd /home/$USER' >> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo 'clear' >> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo 'docker compose -f /home/$USER/yaml/docker-compose/odoo/docker-compose.yml up --quiet-pull -d' >> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo 'echo Odoo port 10016' >> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
echo 'echo Chat port 20016' >> /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
chmod +x /home/$USER/scripts/docker-compose/odoo/docker-compose-odoo.sh
#
#
# DEEL 4 Voorbeelden maken of downloaden 
#
# 4A VOORBEELD ## Dockerfile uit slides van lesweek 4 module virtualisatie 
echo '# start with OS ubuntu' > /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'FROM ubuntu:latest' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'RUN apt-get update' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'RUN apt-get -y upgrade' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo '# install apache2 in noninteractivemode' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo '# copy website' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'COPY index.html /var/www/html/' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo '# start webserver' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'CMD /usr/sbin/apache2ctl -D FOREGROUND' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo '# expose port 80' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
echo 'EXPOSE 80' >> /home/$USER/docker/apache/ubtu-apache-dkr-file
#
echo "#! /bin/bash" > /home/$USER/docker/apache/ubtu-apache-dkr-build.sh
echo "docker build –f /home/$USER/docker/apache/ubtu-apache-dkr-file -t ubtu-apache:V100 ." >> /home/$USER/docker/apache/ubtu-apache-dkr-build.sh
chmod +x /home/$USER/docker/apache/ubtu-apache-dkr-build.sh
#
# 4B VOORBEELD ## FLASK demo
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file https://raw.githubusercontent.com/pmanzoni/flask/master/Dockerfile
# Meerdere talen demo dockerfiles 
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file-de https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-de
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file-fr https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-fr
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file-it https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-it
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file-nl https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-nl
curl -s -o /home/$USER/docker/flask-demo/flask-demo-dkr-file-uk https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-dkr-file-uk
# Python Script
curl -s -o /home/$USER/docker/flask-demo/app.py https://raw.githubusercontent.com/pmanzoni/flask/master/app.py
# Default index.html
curl -s -o /home/$SUSER/docker/flask-demo/templates/index.html https://raw.githubusercontent.com/pmanzoni/flask/master/templates/index.html
# Meerdere talen demo index.html 
curl -s -o /home/$USER/docker/flask-demo/deutsch/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-deutsch.html
curl -s -o /home/$USER/docker/flask-demo/english/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-english.html
curl -s -o /home/$USER/docker/flask-demo/francais/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-francais.html
curl -s -o /home/$USER/docker/flask-demo/italiano/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-italiano.html
curl -s -o /home/$USER/docker/flask-demo/nederlands/index.html https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/index-nederlands.html
#
curl -s -o /home/$USER/docker/flask-demo/flask-image-build.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-image-build.sh
curl -s -o /home/$USER/docker/flask-demo/flask-demo-run.sh https://raw.githubusercontent.com/jatutert/demos/main/Docker/FLASK/flask-demo-run.sh
#
chmod +x /home/$USER/docker/flask-demo/flask-image-build.sh
chmod +x /home/$USER/docker/flask-demo/flask-demo-run.sh
#
# 4C VOORBEELD ## MINIO Docker
echo '#! /bin/bash' > /home/$USER/scripts/minio_scripts/minio-docker-run.sh
echo '#' >> /home/$USER/scripts/minio_scripts/minio-docker-run.sh
echo '# Minio Object Storage on Docker' >> /home/$USER/scripts/minio_scripts/minio-docker-run.sh
echo 'docker run -d -p 9000:9000 -p 9001:9001 -p 9090:9090 --name minio -v /home/$USER/data/minio:/data -e "MINIO_ROOT_USER=minio1234" -e "MINIO_ROOT_PASSWORD=minio1234" minio/minio server /data --console-address ":9001"' >>/home/$USER/scripts/minio_scripts/minio-docker-run.sh
echo 'echo MINIO_ROOT_USER=minio1234' >> /home/$USER/scripts/minio_scripts/minio-docker-run.sh
echo 'echo MINIO_ROOT_PASSWORD=minio1234' >> /home/$USER/scripts/minio_scripts/minio-docker-run.sh
chmod +x /home/$USER/scripts/minio_scripts/minio-docker-run.sh
#
# DEEL 5 DOCKER COMPOSE 
#
# 5A Installatie Docker Compose 2 26 1 in Minikube VM 
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker} 
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
#
# 5B DOCKER COMPOSE YAML JTU bestanden ophalen
curl -s -o /home/$USER/yaml/docker-compose/nextcloud/docker-compose.yml https://raw.githubusercontent.com/jatutert/demos/main/Docker-Compose/YAML/NextCloud/docker-compose-nextcloud-vagrant.yml
curl -s -o /home/$USER/yaml/docker-compose/odoo/docker-compose.yml https://raw.githubusercontent.com/jatutert/demos/main/Docker-Compose/YAML/Odoo/docker-compose-odoo-vagrant.yml 
# 5C DOCKER COMPOSE YAML awesome compose YAML bestanden ophalen
curl -s -o /home/$USER/yaml/docker-compose/prometheus-grafana/prometheus-grafana.yml https://raw.githubusercontent.com/docker/awesome-compose/master/prometheus-grafana/compose.yaml
curl -s -o /home/$USER/yaml/docker-compose/nextcloud/nextcloud-redis-mariadb.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nextcloud-redis-mariadb/compose.yaml
curl -s -o /home/$USER/yaml/docker-compose/nginx/nginx-flask-mysql.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nginx-flask-mysql/compose.yaml
curl -s -o /home/$USER/yaml/docker-compose/nginx/nginx-flask-mongo.yml https://raw.githubusercontent.com/docker/awesome-compose/master/nginx-flask-mongo/compose.yaml
curl -s -o /home/$USER/yaml/docker-compose/wordpress/wordpress-mysql.yml https://raw.githubusercontent.com/docker/awesome-compose/master/wordpress-mysql/compose.yaml
#
# Thats all folks 
#