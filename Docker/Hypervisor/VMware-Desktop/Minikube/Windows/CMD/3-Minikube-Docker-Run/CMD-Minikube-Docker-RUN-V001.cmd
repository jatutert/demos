::
::	DOCKER DEMO
::
::	MINIKube Edition STEP 3
::
::	Minikube Start Demo omgeving from Windows Explorer
::
::	By John Tutert for TutSOFT
:: 
::	Version	1
::
::	Date	28 Oktober 2024
::
::	LET OP! 
::	START DIT SCRIPT VANUIT WINDOWS VERKENNER EN NIET VANUIT TERMINAL
::
::
@echo off
@cls
::
@echo [Stap 1] Administrator rechten check
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @echo Script wordt uitgevoerd met de JUISTE rechten !
    @echo. 
) ELSE (
    @echo Script NIET gestart met Adminstrator rechten ! 
    @pause
    @EXIT 1
)
::
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
@echo [Stap 13] Minikube Starten met alleen Docker
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
@echo [Stap 14] Downloaden Ubuntu Config V3 Latest script vanaf GitHub
@minikube ssh "curl -s -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
@echo. 
@echo [Stap 15] Ubuntu Config V3 Latest script uitvoerbaar maken (chmod)
@minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
@echo.
@echo [Stap 16] Ubuntu Config V3 Latest script uitvoeren met parameter minikube
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
@pause
::	That's ALL Folks