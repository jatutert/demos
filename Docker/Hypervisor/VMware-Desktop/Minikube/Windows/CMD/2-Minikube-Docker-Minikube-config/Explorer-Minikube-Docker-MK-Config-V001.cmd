::
::	DOCKER DEMO
::
::	MINIKube Edition STEP 2
::
::	Minikube Configuratie Script from Windows Explorer
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
@echo [Stap 10] Omgevingsvariabelen Windows instellen voor Minikube [Herhaling]
Setx /M MINIKUBE_IN_STYLE "false"
Setx /M MINIKUBE_HOME "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Minikube"
@echo. 
::
@echo [Stap 11] Minikube parameter configuratie
::
@minikube config set memory 8192
@minikube config set cpus 4 
::	@minikube config set driver virtualbox 
@minikube config set driver vmware 
@minikube config set WantUpdateNotification true
@minikube config set WantBetaUpdateNotification true
@minikube config set WantVirtualBoxDriverWarning false
::
@echo [Stap 12] Minikube wordt de volgende keer gestart met de volgende parameters
@minikube config view
::
@pause
::
::	Sluiten terminal om omgevingsvariabelen te laden
exit