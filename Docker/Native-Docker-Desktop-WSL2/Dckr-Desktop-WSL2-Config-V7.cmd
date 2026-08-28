@echo off
@cls
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM       TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
@REM         TT    U    U    TT    SS      O    O  FF        TT
@REM         TT    U    U    TT    SSSSSS  O    O  FFFF      TT
@REM         TT    U    U    TT        SS  O    O  FF        TT
@REM         TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
@REM
@REM        TutSOFT Education and Networking Services (TENS)
@REM
@REM        The Netherlands/Nederland/Niederlande/Pays Bas/Paisos Bajos
@REM        NL EU
@REM
@REM
@REM    Copyright (c) 2026 John Tutert
@REM    Permission is hereby granted, free of charge, to any person obtaining a copy
@REM    of this software, to use, copy, modify, and distribute it for personal,
@REM    educational, or open-source purposes, provided this notice remains intact.
@REM    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
@REM
@REM
@REM    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
@REM
@REM
@REM    Docker Desktop on Windows Subsystem for Linux (WSL)
@REM    Configuration Script
@REM
@REM    Version 6
@REM
@REM
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Script gestart met Administrator rechten. Prima ! We kunnen verder ... 
) ELSE (
    @cls
    @echo.
    @echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @echo.
    @echo   Script wordt afgesloten, vanwege ontbreken van Administrator rechten ! 
    @echo.
    @echo   Start script met rechtermuisknop en selecteer dan Uitvoeren als Administrator
    @echo.
    @echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @echo.
    @PAUSE
    @EXIT /b 1
)
::
@docker ps >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @cls
    @echo.
    @echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @echo.
    @echo   Docker Desktop is NIET actief !
    @echo.
    @echo   Starten Docker Desktop ...
    @echo. 
    @echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @echo. 
    @docker desktop start
    @pause
)
::
@echo off
@cls
::
@echo.
@echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@echo   @@@@@@  Docker Desktop Configurator Script by TutSOFT
@echo   @@@@@@  Created for Personal and/or Educational Use 
@echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@echo. 
::
::
for /f "tokens=2 delims=:" %%A in ('netsh wlan show interfaces ^| findstr /R "^....SSID"') do (
    set "CUR_SSID=%%A"
)
::
set "CUR_SSID=%CUR_SSID:~1%"
::
if /I not "%CUR_SSID%"=="eduroam" (
    echo Je bent NIET verbonden met eduroam WiFi netwerk
    echo.
) else (
    echo.
    echo    Je bent verbonden met eduroam WiFi netwerk
    echo.
    echo    De download van Docker images via eduroam gaat niet altijd goed
    echo.
    echo    Het is daarom aan te bevelen om dit script bijvoorbeeld thuis uit te voeren
    echo. 
    echo    Wil je nu stoppen ? Druk dan op CTRL + C en type Y 
    echo.
    pause
)
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 1] Windows Netwerk configuratie aanpassen voor Docker Desktop 
::
::  Windows NAT service stoppen
@net stop winnat >nul 2>&1
::
@echo   Poorten voor Docker containers vrijgeven ... 
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
::  Poort vrijgeven voor Dozzle
@netsh int ipv4 add excludedportrange protocol=tcp startport=9108 numberofports=1 >nul 2>&1
::  Poort 9109
@netsh int ipv4 add excludedportrange protocol=tcp startport=9109 numberofports=1 >nul 2>&1
::  Poort 9110
@netsh int ipv4 add excludedportrange protocol=tcp startport=9110 numberofports=1 >nul 2>&1
::
::  Toevoegen
::  netsh int ipv4 add excludedportrange protocol=tcp startport=9443 numberofports=1
::  Verwijderen
::  netsh int ipv4 del excludedportrange protocol=tcp startport=9443 numberofports=1
::
:: Windows NAT service starten 
@net start winnat >nul 2>&1
::
::  Overzicht vrijgegeven poorten 
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
@echo   Verwijderen bestaande Kubernetes clusters binnen Docker Desktop ...
@docker desktop kubernetes reset-cluster
::
@echo   Alle draaiende Docker containers stoppen en verwijderen
@FOR /F %%i IN ('docker ps -q') DO docker stop %%i >nul 2>&1
@FOR /F %%i IN ('docker ps -aq') DO docker rm %%i >nul 2>&1
::
::  Unix Shell
::  @docker rm -f $(docker ps -aq)
::
@echo   Verwijder alle aanwezige Docker Images binnen Docker Desktop
FOR /F %%i IN ('docker images -q') DO docker rmi -f %%i >nul 2>&1
::
::  Unix Shell
::  @docker rmi -f $(docker images -aq)
::
@echo   Verwijder alle aanwezige Docker Volumes binnen Docker Desktop
FOR /F %%i IN ('docker volume ls -q') DO docker volume rm %%i >nul 2>&1
::
::  Unix Shell
:: @docker volume rm $(docker volume ls -q)
:: Pull Algemene Images
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 3] Docker Images laden
::
::  Operating Systems
::
@echo   [ Operating Systems ] 
::
@echo   AlmaLinux versie 8,9 en 10
@docker pull -q almalinux:8         >nul 2>&1
@docker pull -q almalinux:9         >nul 2>&1
@docker pull -q almalinux:10        >nul 2>&1
::
@echo   Alpine Linux versie 3.22, 3.23 en 3.24
@docker pull -q alpine:3.22         >nul 2>&1
@docker pull -q alpine:3.23         >nul 2>&1
@docker pull -q alpine:3.24         >nul 2>&1
::
@REM    @docker pull -q amazonlinux:latest  >nul 2>&1
@REM    @docker pull -q clearlinux:latest   >nul 2>&1
::
@echo   Debian Linux versie 11, 12 en 13
@docker pull -q debian:11           >nul 2>&1
@docker pull -q debian:12           >nul 2>&1
@docker pull -q debian:13           >nul 2>&1
::
@echo   Ubuntu Linux versie 22.04, 24.04 en 26.04
@docker pull -q ubuntu:22.04        >nul 2>&1
@docker pull -q ubuntu:24.04        >nul 2>&1
@docker pull -q ubuntu:26.04        >nul 2>&1
::
::  Operating Systems with Tools 
::
@docker pull -q busybox:latest      >nul 2>&1
@docker pull -q alpine/ansible      >nul 2>&1
::
::  Webservers
::
@echo   [ Webservers ] 
@docker pull -q dockersamples/static-site >nul 2>&1
@docker pull -q httpd:latest        >nul 2>&1
@docker pull -q wordpress:latest    >nul 2>&1
@docker pull -q nginx:latest        >nul 2>&1
::
::  DevOPS
::
@echo   [ DevOPS ] 
@docker pull -q jenkins/jenkins:lts             >nul 2>&1
@docker pull -q sonarqube:latest                >nul 2>&1
@docker pull -q python:3.14.7-trixie            >nul 2>&1
@docker pull -q codercom/code-server:latest     >nul 2>&1
::
::  Docker Management
::
@echo   [ Docker Management ] 
@docker pull -q nickfedor/watchtower            >nul 2>&1
@docker pull -q registry:latest                 >nul 2>&1
@docker pull -q portainer/portainer-ce:latest   >nul 2>&1
@docker pull -q selfhostedpro/yacht:latest      >nul 2>&1
@docker pull -q lirantal/dockly:latest          >nul 2>&1
@docker pull -q moncho/dry:latest               >nul 2>&1
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 4] Docker Volumes maken
::
::  @echo Docker Volumes verwijderen
::
::  Alle Docker Volumes zijn al verwijderd
::
::  @docker volume rm portainer_data
::  @docker volume rm yacht_data
::  @docker volume rm jenkins_data
::
@echo   Dozzle
@docker volume create dozzle_data
@echo   Jenkins
@docker volume create jenkins_data
@echo   Portainer
@docker volume create portainer_data
@echo   SonarQube
@docker volume create sonarqube_data
@docker volume create sonarqube_extensions
@docker volume create sonarqube_logs
@docker volume create sonarqube_temp
@echo   Yacht
@docker volume create yacht_data
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 5] Docker netwerken maken
::
@docker network prune --force
@echo   DevOps Netwerk
@docker network create -d bridge devops
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 6] Docker Images starten als Containers
::
::
::  Portainer
::  :::::::::
::
::  Gebruiker admin
::  Wachtwoord wordt later aangepast naar !@PASSword#$
::
@echo   Portainer op poort 9101
@docker run -q -d ^
--publish 8000:8000 ^
--publish 9101:9443 ^
--name Virtu_Lab_portainer ^
--restart=always ^
--volume /var/run/docker.sock:/var/run/docker.sock ^
--volume portainer_data:/data ^
portainer/portainer-ce:latest ^
--no-setup-token
::
::  Yacht
::  :::::
:: 
@echo   Yacht op poort 9102
@docker run -q -d ^
--publish 9102:8000 ^
--name Virtu_Lab_Yacht ^
--restart=always ^
--volume /var/run/docker.sock:/var/run/docker.sock ^
--volume yacht_data:/config ^
selfhostedpro/yacht
::
::  @echo Yacht is beschikbaar op http://localhost:9102
::  @echo gebruiker  admin@yacht.local
::  @echo wachtwoord pass
::
::  VS Code Server
::  ::::::::::::::
::
echo    Visual Studio Code Server op poort 9103
::
@docker run -q -d ^
--publish 9103:8080 ^
--name Virtu_Lab_MS_VSC_Server ^
--restart=always ^
--volume "/home/$USER:/home/coder/project" ^
codercom/code-server:latest ^
--auth=none
::
::  Portainer stoppen om verderop wachtwoord aan te kunnen passen
::
docker stop Virtu_Lab_portainer
::
::  Jenkins
::  ::::::::
::
@echo   Jenkins starten op poort 9104
::
@docker run -q -d ^
--name Virtu_Lab_Jenkins ^
--restart always ^
--network devops ^
--publish 9104:8080 ^
--publish 50000:50000 ^
--volume jenkins_data:/var/jenkins_home ^
jenkins/jenkins:lts
::
:: Registry
::
@echo   Lokale Registry starten op poort 9105
::
@docker run -q -d ^
--name Virtu_Lab_Local_Registry ^
--restart always ^
--publish 9105:5000 ^
--volume registry-data:/var/lib/registry ^
registry
::
:: WatchTower
::
::  Zie https://watchtowerdocker.com/
::
@echo   WatchTower starten op poort 9106
@docker run -q -d ^
--name Virtu_Lab_Watchtower ^
--restart always ^
--publish 9106:8080  ^
--volume /var/run/docker.sock:/var/run/docker.sock ^
--volume /etc/localtime:/etc/localtime:ro ^
nickfedor/watchtower ^
-e WATCHTOWER_CLEANUP=true ^
-e WATCHTOWER_SCHEDULE=0 0 */6 * * * ^
-e TZ=Europe/Amsterdam
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
@echo   SonarQube starten op poort 9107
::
@docker run -q -d ^
--name Virtu_Lab_Sonarqube ^
--restart always ^
--network devops ^
--publish 9107:9000 ^
--volume sonarqube_data:/opt/sonarqube/data ^
--volume sonarqube_extensions:/opt/sonarqube/extensions ^
--volume sonarqube_logs:/opt/sonarqube/logs ^
--volume sonarqube_temp:/opt/sonarqube/temp ^
--env SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true ^
sonarqube:latest
::
::
::  Dozzle
::
@echo   Dozzle starten op poort 9108
::
@docker run -q -d ^
--name Virtu_Lab_Dozzle ^
--volume=/var/run/docker.sock:/var/run/docker.sock ^
--volume dozzle_data:/data ^
--publish 9108:8080 ^
amir20/dozzle:latest
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 7] Jenkins configureren
::
@echo   [Stap 7a] Installatie Plugins binnen Jenkins
::
@docker exec -it Virtu_Lab_Jenkins jenkins-plugin-cli --plugins ansible
@docker exec -it Virtu_Lab_Jenkins jenkins-plugin-cli --plugins blueocean
@docker exec -it Virtu_Lab_Jenkins jenkins-plugin-cli --plugins git
@docker exec -it Virtu_Lab_Jenkins jenkins-plugin-cli --plugins github
@docker exec -it Virtu_Lab_Jenkins jenkins-plugin-cli --plugins sonar
:
@echo   [Stap 7b] Jenkins wachtwoord opslaan in %userprofile% Jenkins_Initial_Password.txt
::
::
::  Jenkins Wachtwoord opslaan
@docker exec -it Virtu_Lab_Jenkins cat /var/jenkins_home/secrets/initialAdminPassword > %userprofile%\Jenkins_Initial_Password.txt
::  @docker cp LUCT_Jenkins:/var/jenkins_home/secrets/initialAdminPassword %userprofile%/Jenkins_Initial_Password.txt
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 8] Portainer configureren
::
docker run --rm -v portainer_data:/data portainer/helper-reset-password --password "!@WACHTwoord#$"
docker start Virtu_Lab_portainer
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 9] Scrips maken voor Dockly en Dry
::
@echo docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly > %userprofile%/dkr_run_dockly.cmd
@echo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry > %userprofile%/dkr_run_dry.cmd
::
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 10] Tools installeren
::
::
@kubectl >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo   Installatie KubeCTL
    @winget install kubernetes.kubectl
)
::
@helm version >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo   Installatie Helm
    @winget install Helm.Helm
)
::
@minikube >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo   Installatie Minikube
    @winget install kubernetes.minikube
)
@dive version >nul 2>&1
@if %ERRORLEVEL% neq 0 (
    @echo    Installatie Dive 
    @winget install wagoodman.dive
)
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 11] Configureren Minikube 
::
@minikube config set driver docker >nul 2>&1
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 12] Kubernetes Cluster Docker Desktop verwijderen 
::
@docker desktop kubernetes reset-cluster
::
::  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@echo [Stap 13] Docker Desktop updaten 
@docker desktop update
::
::
::
::  Thats all folks
::
::