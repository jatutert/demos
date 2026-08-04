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
::  Version 2
::
::  Author: John Tutert
::  2026
:: 
@echo off
@cls
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
@docker ps >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo Docker Desktop is niet actief ! 
    @echo.
    @echo Docker Desktop wordt gestart ...
    @echo. 
    @docker desktop start
    @pause
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
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 1] Windows Netwerk configuratie aanpassen voor Docker Desktop 
::
::  Windows NAT service stoppen
@net stop winnat >nul 2>&1
::
@echo Poorten voor Docker containers vrijgeven ... 
::  Poort vrijgeven voor DockPortLess extension
@netsh int ipv4 add excludedportrange protocol=tcp startport=1355 numberofports=1 >nul 2>&1
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
::  Poort vrijgeven voor SonarQube
@netsh int ipv4 add excludedportrange protocol=tcp startport=9107 numberofports=1 >nul 2>&1
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
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::
::  Naslag Docker Desktop via CLI
::  https://docs.docker.com/reference/cli/docker/
::
::
@echo [Stap 2] Opschonen Docker Desktop
::
@echo Verwijderen bestaande Kubernetes clusters binnen Docker Desktop ...
@docker desktop kubernetes reset-cluster
::
@echo Alle draaiende Docker containers stoppen en verwijderen
@FOR /F %%i IN ('docker ps -q') DO docker stop %%i >nul 2>&1
@FOR /F %%i IN ('docker ps -aq') DO docker rm %%i >nul 2>&1
::
::  Unix Shell
::  @docker rm -f $(docker ps -aq)
::
@echo Verwijder alle aanwezige Docker Images binnen Docker Desktop
FOR /F %%i IN ('docker images -q') DO docker rmi -f %%i >nul 2>&1
::
::  Unix Shell
::  @docker rmi -f $(docker images -aq)
::
@echo Verwijder alle aanwezige Docker Volumes binnen Docker Desktop
FOR /F %%i IN ('docker volume ls -q') DO docker volume rm %%i >nul 2>&1
::
::  Unix Shell
:: @docker volume rm $(docker volume ls -q)
:: Pull Algemene Images
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 3] Docker Desktop configureren
::
@echo Docker Images laden ... 
@docker pull -q alpine:latest >nul 2>&1
@docker pull -q amazonlinux:latest >nul 2>&1
@docker pull -q busybox:latest >nul 2>&1
@docker pull -q clearlinux:latest >nul 2>&1
@echo 25 procent voltooid ...
@docker pull -q debian:latest >nul 2>&1
@docker pull -q dockersamples/static-site >nul 2>&1
@docker pull -q httpd:latest >nul 2>&1
@echo 50 procent voltooid ...
@docker pull -q jenkins/jenkins:lts >nul 2>&1
@docker pull -q nginx:latest >nul 2>&1
@docker pull -q python:slim-trixie >nul 2>&1
@docker pull -q sonarqube:latest >nul 2>&1
@echo 75 procent voltooid ...
@docker pull -q ubuntu:25.10 >nul 2>&1
@docker pull -q ubuntu:latest >nul 2>&1
@docker pull -q wordpress:latest >nul 2>&1
:: 
@echo Docker beheerimages laden ...
::
::  @docker pull codercom/code-server:latest
::  @docker pull portainer/portainer-ce:latest
::  @docker pull selfhostedpro/yacht:latest
@docker pull -q percona/watchtower:latest >nul 2>&1
@docker pull -q registry:latest >nul 2>&1
::  @docker pull lirantal/dockly:latest
::  @docker pull moncho/dry:latest
::
@echo Docker Volumes verwijderen
::
::  Alle Docker Volumes zijn al verwijderd
::
::  @docker volume rm portainer_data
::  @docker volume rm yacht_data
::  @docker volume rm jenkins_data
::
@echo Docker Volumes aanmaken
::
::  @docker volume create portainer_data
::  @docker volume create yacht_data
@docker volume create jenkins_data
::
@echo Docker Netwerken aanmaken
::
@docker network prune --force
@docker network create -d bridge devops
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 4] Docker Images starten als Containers
::
::
::  Portainer
::  :::::::::
::
::  @docker run -d -p 8000:8000 -p 9101:9443 --name LUCT_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
::  @docker run -d -p 8000:8000 -p 9101:9443 --name LUCT_portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --no-setup-token
::
::  @echo Portainer is beschikbaar op https://localhost:9101
::  @echo Gebruik password1234 als wachtwoord bij aanmaken van gebruiker
::
::  Yacht
::  :::::
:: 
::  @docker run -d -p 9102:8000 -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config --name LUCT_Yacht --restart=always selfhostedpro/yacht
::
::  @echo Yacht is beschikbaar op http://localhost:9102
::  @echo gebruiker  admin@yacht.local
::  @echo wachtwoord pass
::
::  VS Code Server
::  ::::::::::::::
::
::  @Visual Studio Code server starten ...
::  @docker run -d --name LUCT_VSC_Server -p 9103:8080 --restart=always -v "/home/$USER:/home/coder/project" codercom/code-server:latest --auth=none
::
::  SonarQube
::  ::::::::::
::  
::  User admin
::  Password admin
::
::  Zie https://docs.sonarsource.com/sonarqube-community-build/try-out-sonarqube
::
::
@echo SonarQube starten 
@docker run -d --name sonarqube --network devops -p 9107:9000 -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true sonarqube:latest
::  Jenkins
::  ::::::::
::
@echo Jenkins starten ...
@docker run -q -d --name LUCT_Jenkins --network devops -p 9104:8080 -p 50000:50000 --restart=always -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts
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
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 5] Installatie Plugins binnen Jenkins
::
@docker exec -it LUCT_Jenkins jenkins-plugin-cli --plugins ansible
@docker exec -it LUCT_Jenkins jenkins-plugin-cli --plugins blueocean
@docker exec -it LUCT_Jenkins jenkins-plugin-cli --plugins git
@docker exec -it LUCT_Jenkins jenkins-plugin-cli --plugins github
@docker exec -it LUCT_Jenkins jenkins-plugin-cli --plugins sonar
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 5] Jenkins wachtwoord opslaan in %userprofile% Jenkins_Initial_Password.txt
::
::
::  Jenkins Wachtwoord opslaan
@docker exec -it LUCT_Jenkins cat /var/jenkins_home/secrets/initialAdminPassword > %userprofile%\Jenkins_Initial_Password.txt
::  @docker cp LUCT_Jenkins:/var/jenkins_home/secrets/initialAdminPassword %userprofile%/Jenkins_Initial_Password.txt
::
::  @echo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly > %userprofile%/dkr_run_dockly.cmd
::  @echo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry > %userprofile%/dkr_run_dry.cmd
::
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 6] Tools installeren
::
::
@kubectl >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo Installatie KubeCTL
    @winget install kubernetes.kubectl
)
::
@minikube >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo Installatie Minikube
    @winget install kubernetes.minikube
)
@dive version >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @winget install wagoodman.dive
)
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 7] Configureren Minikube 
::
@minikube config set driver docker >nul 2>&1
::
::
::
::  Thats all folks
::
::