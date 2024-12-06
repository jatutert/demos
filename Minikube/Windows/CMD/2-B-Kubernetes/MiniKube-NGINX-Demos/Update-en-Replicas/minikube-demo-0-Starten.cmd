::	DEMO Kubernetes / Minikube
::	Gemaakt door John Tutert
::	2023 en 2024
::
::	Stap 0	Starten Minikube Kubernetes 
::
@echo off 
@cls
::
@echo Stoppen eventueel actieve minikube of Minikube Docker omgeving  
@minikube stop --all
::
@echo Starten Minikube Kubernetes Omgeving
@minikube start --delete-on-failure=true
