::	DEMO Kubernetes / Minikube
::	Gemaakt door John Tutert
::	2023
::
::	Stap 0	Voorbereiding demo 
::
@echo off 
@CLS
::
:: Stoppen eventueel actieve minikube 
@ECHO Stoppen eventueel actieve minikube 
@minikube stop
:: 
:: Verwijdere eventueel aanwezige omgeving 
:: @ECHO Verwijderen eventueel aanwezige omgevingen
:: 
:: NIET VERWIJDEREN - IN Minikube VM zijn eigen Images aanwezig 
::
:: @minikube delete
:: @ECHO Configuratie Minikube
:: @minikube config set cpus 2
:: @minikube config set memory 16384
:: @minikube config set driver vmware
:: minikube config set driver virtualbox
:: minikube start --no-vtx-check
:: 
@CLS
@ECHO Starten Minikube 
@minikube start
