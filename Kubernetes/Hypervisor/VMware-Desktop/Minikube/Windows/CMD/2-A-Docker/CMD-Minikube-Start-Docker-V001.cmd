:: 
::	Minikube on Windows
::
::	Start Demonstratie Omgeving
::
::	Date Oktober 27 2024
::
::	Script author John Tutert
::
::
::	::::::::::::::::::::::::::::::::::::::::::::::
::
::	Start eventueel eerst het installatie en configuratie script
::	Om te zorgen dat Minikube aanwezig is of om op te schonen
::
::	Dit script heeft alleen als doel om omgeving te starten
::
::	:::::::::::::::::::::::::::::::::::::::::::::::
::
::
::	:::::::: Alleen Administrator kan starten ::::::::
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Administrator PRIVILEGES Detected! 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::
@echo off
@cls
::
::
::	========================================== naslag ======================================
:: Minikube starten voor alleen Download
:: @minikube start --download-only
::
:: Check of alles in orde is
:: @minikube start --dry-run
::
::	========================================================================================
:: 
::
::	:::::::: STARTEN ::::::::
::
@minikube start --no-kubernetes
::
::	======================================== opties ==========================================
:: @minikube start --no-vtx-check --no-kubernetes
:: @minikube start --no-vtx-check --container-runtime=docker --no-kubernetes
::	===========================================================================================
::
::
::	======================================== naslag info opvragen ===============================
:: IP adres van Virtuele machine weergeven
:: @echo Virtuele machine is bereikbaar op IP-adres
:: @minikube ip
:: @minikube service list
:: @minikube cache list
:: @minikube image ls
::	=================================================================================================
::
::
::	:::::::: CONFIGURATIE LINUX VM ::::::::
::
::	Moet in dit script blijven omdat alleen voor Docker omgeving bedoeld is
::	Voor Kubernetes omgeving moet dit niet worden gedaan 
::
@echo Configuratie Minikube virtuele machine gestart ...
@minikube ssh "curl -s -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
@minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
@minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
::
::
::	:::::::: DOCKER IMAGES MAKEN ::::::::
::
minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
:: 
::	:::::::: IP ADRES VM WEERGEVEN ::::::::
::
@echo Virtuele machine is bereikbaar op IP-adres
@minikube ip
::
@echo Geef minikube ssh commando voor demo omgeving docker
::
::	That's ALL Folks