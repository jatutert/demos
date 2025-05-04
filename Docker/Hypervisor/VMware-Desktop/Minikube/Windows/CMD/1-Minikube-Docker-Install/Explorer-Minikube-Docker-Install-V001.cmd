::
::	DOCKER DEMO
::
::	MINIKube Edition Fase 1 (stap 1 tot en met stap 10) 
::
::	Minikube Installation Script from Windows Explorer
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
@echo Docker Demo
@echo Minikube Installation 
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
@echo [Stap 2] Stoppen eventueel eventueel draaiende Minikube omgevingen 
@minikube stop --all >nul 2>&1
@echo.
::
@echo [Stap 3] Verwijderen eventueel aanwezige Minikube directory
@minikube delete --all --purge >nul 2>&1
@echo. 
::
@echo [Stap 4] Verwijderen eventueel aanwezige minikube installatie
@winget update >nul 2>&1
@winget uninstall Kubernetes.minikube --nowarn --force >nul 2>&1
@winget uninstall Kubernetes.kubectl --nowarn --force >nul 2>&1
@echo. 
::
@echo [Stap 5] Verwijderen Minikube directories voor deze gebruiker
@rmdir %USERPROFILE%\.minikube /S /Q
@echo.
::
@echo [Stap 6] Verwijderen Minikube directories
@rmdir %MINIKUBE_HOME%\.minikube /S /Q
@rmdir %MINIKUBE_HOME%\Minikube /S /Q
@echo. 
::
@echo [Stap 7] Verwijderen Kubectl directory voor deze gebruiker
@rmdir %USERPROFILE%\.kube /S /Q
@echo. 
::
@echo [Stap 8] Installeren Kubernetes Minikube 
@winget update >nul 2>&1
@winget install --id Kubernetes.minikube --accept-package-agreements --accept-source-agreements
@echo. 
::
@echo [Stap 9] Installeren Kubectl (voor Minikube)  
@winget install --id Kubernetes.kubectl --accept-package-agreements --accept-source-agreements 
@echo. 
::
@echo [Stap 10] Omgevingsvariabelen Windows instellen voor Minikube
Setx /M MINIKUBE_IN_STYLE "false"
Setx /M MINIKUBE_HOME "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Minikube"
@echo. 
::
::	:::::::: STEP 8 Minikube voorzien van de juiste parameters ::::::::
::
::	Gaat FOUT omdat minikube commando pas bekend is als terminal wordt afgesloten
::	01-05-25 extra stap gemaakt om onderstaande config te doen
::
::	@minikube config set memory 8192
:: @minikube config set cpus 4 
::	::	@minikube config set driver virtualbox 
::	@minikube config set driver vmware 
::	@minikube config set WantUpdateNotification true
::	@minikube config set WantBetaUpdateNotification true
::	@minikube config set WantVirtualBoxDriverWarning false
::	::	@minikube config view
::
@pause
::
::	Sluiten terminal om omgevingsvariabelen te laden
exit