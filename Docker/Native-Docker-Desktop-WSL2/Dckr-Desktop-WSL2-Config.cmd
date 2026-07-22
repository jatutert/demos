::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::  Docker Desktop on Windows Subsystem for Linux (WSL)
::  Configuration Script
::
::  Version 1
::
::  Author: John Tutert
::  2026
:: 
@echo off
@cls
::
@docker ps >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo Docker Desktop is niet actief 
    @echo Script wordt afgebroken ...
    @pause
    @exit 1
)
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Script gestart met Administrator rechten. Prima ! We kunnen verder ... 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
@echo off
@cls
::
@echo.
@echo Docker Desktop Configurator Script by TutSOFT
@echo Created for Personal and/or Educational Use 
@echo. 
::
@echo Verwijderen bestaande images, containers en volumes binnen Docker Desktop ... 
::
::  Docker Opschonen
::
::  Alle draaiende Docker containers stoppen en verwijderen
@FOR /F %%i IN ('docker ps -q') DO docker stop %%i >nul 2>&1
@FOR /F %%i IN ('docker ps -aq') DO docker rm %%i >nul 2>&1
::
::  Unix Shell
::  @docker rm -f $(docker ps -aq)
::
::  Verwijder alle Docker Images
FOR /F %%i IN ('docker images -q') DO docker rmi -f %%i >nul 2>&1
::
::  Unix Shell
::  @docker rmi -f $(docker images -aq)
::
::  Verwijder alle Docker Volumes
FOR /F %%i IN ('docker volume ls -q') DO docker volume rm %%i >nul 2>&1
::
::  Unix Shell
:: @docker volume rm $(docker volume ls -q)
::
::  Windows Netwerk configuratie aanpassen voor Docker
::
::  Windows NAT service stoppen
@net stop winnat >nul 2>&1
::
@echo Poorten voor Docker containers vrijgeven ... 
::  Poort vrijgeven voor Portainer
@netsh int ipv4 add excludedportrange protocol=tcp startport=9101 numberofports=1 >nul 2>&1
::  Poort vrijgeven voor Yacht
@netsh int ipv4 add excludedportrange protocol=tcp startport=9102 numberofports=1 >nul 2>&1
::  Poort vrijgeven voor Visual Studio Code Server
@netsh int ipv4 add excludedportrange protocol=tcp startport=9103 numberofports=1 >nul 2>&1
::  Poort vrijgeven voor Jenkins
@netsh int ipv4 add excludedportrange protocol=tcp startport=9104 numberofports=1 >nul 2>&1
::  Poort vrijgeven voor Registry
@netsh int ipv4 add excludedportrange protocol=tcp startport=9105 numberofports=1 >nul 2>&1
::  Poort vrijgeven voor WatchTower
@netsh int ipv4 add excludedportrange protocol=tcp startport=9106 numberofports=1 >nul 2>&1
::
::  Toevoegen
::  netsh int ipv4 add excludedportrange protocol=tcp startport=9443 numberofports=1
::  Verwijderen
::  netsh int ipv4 del excludedportrange protocol=tcp startport=9443 numberofports=1
::
:: Windows NAT service starten 
@net start winnat >nul 2>&1
::
:: Overzicht vrijgegeven poorten 
::  @netsh interface ipv4 show excludedportrange protocol=tcp
::
:: Pull Algemene Images
::
@echo Docker Images laden ... 
@docker pull -q alpine:latest >nul 2>&1
@docker pull -q amazonlinux:latest >nul 2>&1
@docker pull -q busybox:latest >nul 2>&1
@docker pull -q clearlinux:latest >nul 2>&1
@docker pull -q debian:latest >nul 2>&1
@docker pull -q dockersamples/static-site >nul 2>&1
@docker pull -q httpd:latest >nul 2>&1
@docker pull -q jenkins/jenkins:latest-jdk21 >nul 2>&1
@docker pull -q nginx:latest >nul 2>&1
@docker pull -q python:slim-trixie >nul 2>&1
@docker pull -q ubuntu:25.10 >nul 2>&1
@docker pull -q ubuntu:latest >nul 2>&1
@docker pull -q wordpress:latest >nul 2>&1
:: 
::  Pull Beheer Images
::
::  @docker pull codercom/code-server:latest
::  @docker pull portainer/portainer-ce:latest
::  @docker pull selfhostedpro/yacht:latest
@docker pull -q percona/watchtower:latest >nul 2>&1
@docker pull -q registry:latest >nul 2>&1
::  @docker pull lirantal/dockly:latest
::  @docker pull moncho/dry:latest
::
:: Volumes
::
::  @docker volume rm portainer_data
::  @docker volume rm yacht_data
@docker volume rm jenkins_data
::
::  @docker volume create portainer_data
::  @docker volume create yacht_data
@docker volume create jenkins_data
::
:: Portainer
::
::  @docker run -d -p 8000:8000 -p 9101:9443 --name LUCT_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
::  @docker run -d -p 8000:8000 -p 9101:9443 --name LUCT_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --no-setup-token
::
::  @echo Portainer is beschikbaar op https://localhost:9101
::  @echo Gebruik password1234 als wachtwoord bij aanmaken van gebruiker
::
:: Yacht
:: 
::  @docker run -d -p 9102:8000 -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config --name LUCT_Yacht --restart=always selfhostedpro/yacht
::
::  @echo Yacht is beschikbaar op http://localhost:9102
::  @echo gebruiker  admin@yacht.local
::  @echo wachtwoord pass
::
:: VS Code Server
::
::  @Visual Studio Code server starten ...
::  @docker run -d --name LUCT_VSC_Server -p 9103:8080 --restart=always -v "/home/$USER:/home/coder/project" codercom/code-server:latest --auth=none
::
::  Jenkins
::
@echo Jenkins starten ...
@docker run -q -d --name LUCT_Jenkins -p 9104:8080 -p 50000:50000 --restart=always -v jenkins_data:/var/jenkins_home jenkins/jenkins:latest-jdk21
::
:: Registry
::
@echo Lokale Registry starten ...
@docker run -q -d --name LUCT_Registry -p 9105:5000 --restart always -v registry-data:/var/lib/registry registry
::
:: WatchTower
::
@echo WatchTower starten ... 
@docker run -q -d -p 9106:8080 --restart always --name LUCT_Watchtower -v /var/run/docker.sock:/var/run/docker.sock percona/watchtower
::
::  Jenkins Wachtwoord opslaan
@docker cp LUCT_Jenkins:/var/jenkins_home/secrets/initialAdminPassword %userprofile%/Jenkins_Initial_Password.txt
::
::  @echo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly > %userprofile%/dkr_run_dockly.cmd
::  @echo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry > %userprofile%/dkr_run_dry.cmd
::
::
@kubectl >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @winget install kubernetes.kubectl
)
::
@minikube >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @winget install kubernetes.minikube
)
::
@minikube config set driver docker >nul 2>&1
::
@dive version >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @winget install wagoodman.dive
)
::
::
::  Thats all folks
::
::