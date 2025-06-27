::
::	Minikube / K8S DEMO
::
::	MINIKube Edition Fase 3 (Stap 13 tot en met stap 18) 
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
@echo [Stap 13] Minikube Starten met zowel Docker als Kubernetes (K8S)
@minikube start --kubernetes-version=stable --nodes=2 --cni=flannel
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
::
::	:::::::: CONFIGURATIE LINUX VM ::::::::
::
::
@echo [Stap 17] Downloaden Ubuntu Config V3 Latest script vanaf GitHub
@minikube ssh "curl -s -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
@echo. 
::
@echo [Stap 18] Ubuntu Config V3 Latest script uitvoerbaar maken (chmod)
@minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
@echo.
:: 
@echo [Stap 19] Ubuntu Config V3 Latest script uitvoeren met parameter minikube
@minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
@echo.
::
@echo [Stap 20] Flask demo image build binnen Minikube VM (Buildroot Linux) 
@minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
@minikube image ls
@echo.
::
@echo [Stap 21] Flask demo image run binnen Minikube VM (Buildroot Linux) 
@minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
::
:: @echo Virtuele machine is bereikbaar op IP-adres
:: @minikube ip
::
::	@echo Geef minikube ssh commando voor demo omgeving docker
::
@pause
::
::
@exit
::
::	Thats ALL Folks
::