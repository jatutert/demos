::
::	DOCKER DEMO
::
::	MINIKube Edition STEP 2
::
::	Configuration from Windows Command (CMD) Script
::
::	By John Tutert for TutSOFT
::
::	Version	1
::
::	Date	27 Oktober 2024
::
::
::	:::::::: Check of Script wordt uitgevoerd als Administrator ::::::::
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
::	:::::::: Start of Script ::::::::
::
@echo off
@cls
::
::	:::::::: Minikube met Docker STARTEN ::::::::
::
::	========================================== naslag ======================================
::	Minikube starten voor alleen Download
::	@minikube start --download-only
::
::	Check of alles in orde is
::	@minikube start --dry-run
::
::	Opties
::	@minikube start --no-vtx-check --no-kubernetes
::	@minikube start --no-vtx-check --container-runtime=docker --no-kubernetes
::
:: IP adres van Virtuele machine weergeven
:: @echo Virtuele machine is bereikbaar op IP-adres
:: @minikube ip
:: @minikube service list
:: @minikube cache list
:: @minikube image ls
::
::	===========================================================================================
::
@minikube start --no-kubernetes
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
::	:::::::: DOCKER IMAGES MAKEN ::::::::
::
@echo Docker Images maken
@minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
@minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
:: 
::	:::::::: IP ADRES VM WEERGEVEN ::::::::
::
::	@echo Virtuele machine is bereikbaar op IP-adres
::	@minikube ip
::
::	@echo Geef minikube ssh commando voor demo omgeving docker
::
::	Thats ALL Folks
::