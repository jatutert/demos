::
::  Docker Desktop on Windows Subsystem for Linux (WSL)
::  Configuration Script
::
::  Version 1
::
::  Author: John Tutert
::  2026
:: 
::
:: Poort 9443 vrijgeven voor Docker Desktop
::
:: Windows NAT service stoppen
net stop winnat
:: Portainer
netsh int ipv4 add excludedportrange protocol=tcp startport=9101 numberofports=1
:: Yacht
netsh int ipv4 add excludedportrange protocol=tcp startport=9102 numberofports=1
:: Visual Studio Code Server
netsh int ipv4 add excludedportrange protocol=tcp startport=9103 numberofports=1
:: Jenkins
netsh int ipv4 add excludedportrange protocol=tcp startport=9104 numberofports=1
:: Registry
netsh int ipv4 add excludedportrange protocol=tcp startport=9105 numberofports=1
:: WatchTower
netsh int ipv4 add excludedportrange protocol=tcp startport=9106 numberofports=1
::
::  Toevoegen
::  netsh int ipv4 add excludedportrange protocol=tcp startport=9443 numberofports=1
::  Verwijderen
::  netsh int ipv4 del excludedportrange protocol=tcp startport=9443 numberofports=1
::
:: Windows NAT service starten 
net start winnat
::
:: Overzicht vrijgegeven poorten 
netsh interface ipv4 show excludedportrange protocol=tcp
::
:: Pull Images
::
docker pull alpine:latest
docker pull amazonlinux:latest
docker pull clearlinux:latest
docker pull debian:latest
docker pull ubuntu:latest
docker pull httpd:latest
docker pull dockersamples/static-site
docker pull nginx:latest
docker pull wordpress:latest
:: 
docker pull codercom/code-server:latest
docker pull portainer/portainer-ce:latest
docker pull selfhostedpro/yacht:latest
docker pull percona/watchtower:latest
docker pull jenkins/jenkins:latest-jdk21
docker pull registry:latest
::
docker pull lirantal/dockly:latest
docker pull moncho/dry:latest
::
:: Volumes
::
docker volume rm portainer_data
docker volume rm yacht_data
docker volume rm jenkins_data
::
docker volume create portainer_data
docker volume create yacht_data
docker volume create jenkins_data
::
:: Portainer
::
docker run -d -p 8000:8000 -p 9101:9443 --name LUCT_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
::
echo Portainer is beschikbaar op https://localhost:9101
echo Gebruik password1234 als wachtwoord bij aanmaken van gebruiker
::
:: Yacht
:: 
docker run -d -p 9102:8000 -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config --name LUCT_Yacht --restart=always selfhostedpro/yacht
::
echo Yacht is beschikbaar op http://localhost:9102
echo gebruiker  admin@yacht.local
echo wachtwoord pass
::
:: VS Code Server
::
docker run -d --name LUCT_VSC_Server -p 9103:8080 --restart=always -v "/home/$USER:/home/coder/project" codercom/code-server:latest --auth=none
::
::  Jenkins
::
docker run -d --name LUCT_Jenkins -p 9104:8080 -p 50000:50000 --restart=always -v jenkins_data:/var/jenkins_home jenkins/jenkins:latest-jdk21
::
:: Registry
::
docker run -d --name LUCT_Registry -p 9105:5000 --restart always -v registry-data:/var/lib/registry registry
::
:: WatchTower
::
docker run -d -p 9106:8080 --restart always --name LUCT_Watchtower -v /var/run/docker.sock:/var/run/docker.sock percona/watchtower
::
::  Jenkins Wachtwoord opslaan
docker cp LUCT_Jenkins:/var/jenkins_home/secrets/initialAdminPassword %userprofile%/Jenkins_Initial_Password.txt

::
echo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly > %userprofile%/dkr_run_dockly.cmd
echo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry > %userprofile%/dkr_run_dry.cmd