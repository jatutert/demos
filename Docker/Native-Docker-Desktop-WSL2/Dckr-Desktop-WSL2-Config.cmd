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
docker pull alpine:3.5
docker pull amazonlinux:latest
docker pull clearlinux:latest
docker pull ubuntu:24.04
docker pull codercom/code-server:latest
docker pull prakhar1989/static-site
docker pull portainer/portainer-ce:latest
docker pull registry:latest
docker pull selfhostedpro/yacht:latest
docker pull containrrr/watchtower:latest
docker pull 
::
:: Portainer
::
docker volume rm portainer_data
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9101:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
::
echo Portainer is beschikbaar op https://localhost:9101
echo Gebruik password1234 als wachtwoord bij aanmaken van gebruiker
:: Yacht
:: 
docker volume rm yacht_data
docker volume create yacht_data
docker run -d -p 9102:8000 -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config --name yacht --restart=always selfhostedpro/yacht
::
echo Yacht is beschikbaar op http://localhost:9102
echo gebruiker  admin@yacht.local
echo wachtwoord pass
::
:: WatchTower
::
docker run -d -p 9106:8080 --restart always --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
::
:: Registry
::
docker run -d -p 9105:5000 --restart always --name registry registry