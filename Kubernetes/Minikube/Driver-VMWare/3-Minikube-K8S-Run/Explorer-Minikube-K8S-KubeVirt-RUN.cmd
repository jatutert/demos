::
::	Minikube / K8S DEMO met KubeVIRT 
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
@minikube start --nodes=2 --cni=flannel
::
::	Foutmelding
::	Failing to connect to https://registry.k8s.io/ from inside the minikube VM
::
::	Maar lijkt verder wel goed te werken 
::
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
@echo [Stap 14] Downloaden Ubuntu Config V3 Latest script vanaf GitHub
@minikube ssh "curl -s -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
@echo. 
@echo [Stap 15] Ubuntu Config V3 Latest script uitvoerbaar maken (chmod)
@minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
@echo.
@echo [Stap 16] Ubuntu Config V3 Latest script uitvoeren met parameter minikube
@minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
::
@echo [Stap 17] Flask demo image build overslaan
::	@echo [Stap 17] Flask demo image build binnen Minikube VM (Buildroot Linux) 
::	minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
::	minikube image ls
@echo.
::
@echo [Sta[ 18] Flask demo image run overslaan
::	@echo [Stap 18] Flask demo image run binnen Minikube VM (Buildroot Linux) 
::	minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
@echo. 
::
::	:::::::: KUBEVIRT ::::::::
::
@echo [Stap 19] Minikube Addons enable
::
::	https://kubevirt.io/quickstart_minikube/
::	https://github.com/kubevirt/kubevirt
::
@minikube addons enable kubevirt
::
::	https://github.com/kubevirt/kubevirt
::

@echo [Stap 20] Versienummer bepalen
::	Versienummer wordt in omgevingsvariabele gezet
::	Dit omgevingsvariable is alleen tijdens de terminalsessie aanwezig
::	Zodra andere tab of andere terminal wordt geopend is daar omgevingsvariable niet meer aanwezig
curl -s https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt > %USERPROFILE%\version.txt
set /p KUBEVIRT_VERSION=<version.txt
::
@echo [Stap 20] Deploy the KubeVirt operator
kubectl create -f "https://github.com/kubevirt/kubevirt/releases/download/%KUBEVIRT_VERSION%/kubevirt-operator.yaml"
::
@echo [Stap 21] Deploy the KubeVirt custom resource definitions
kubectl create -f "https://github.com/kubevirt/kubevirt/releases/download/%KUBEVIRT_VERSION%/kubevirt-cr.yaml"
::
@echo [Stap 21] Check
kubectl get kubevirt.kubevirt.io/kubevirt -n kubevirt -o=jsonpath="{.status.phase}"
kubectl get all -n kubevirt
::
@echo [Stap 22] VirtCTL Downloaden in de UserProfile folder van deze gebruiker
::	Alleen download noodzakelijk. Programma is hierna gelijk uit te voeren ... 
@powershell Invoke-WebRequest -Uri 'https://github.com/kubevirt/kubevirt/releases/download/v1.5.1/virtctl-v1.5.1-windows-amd64.exe' -OutFile "C:\Users\$env:USERNAME\virtctl-v1.5.1-windows-amd64.exe"
::
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