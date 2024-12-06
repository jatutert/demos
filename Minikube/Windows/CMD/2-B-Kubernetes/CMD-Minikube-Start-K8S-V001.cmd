:: 
::	Minikube on Windows
::
::	Start Demonstratie Omgeving Kubernetes
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
@minikube start
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
::	:::::::: IP ADRES VM WEERGEVEN ::::::::
::
@echo Virtuele machine is bereikbaar op IP-adres
@minikube ip
::
::
::	:::::::: K8S Informatie weergeven
::
@kubectl get pods
@kubectl get services 
@kubectl get deployments 
::
::
::	That's ALL Folks