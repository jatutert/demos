::
::  Kubernetes / Minikube 
::  Start Master Node with 2 Worker Nodes
::
::  Docker Desktop on WSL2 Compatible
::
::  Created by John Tutert
::
::  For personal and /or education use only !
::
@echo off
@cls
::
@echo Minikube Initialisatie
minikube stop --all
minikube delete --all --purge
::
@echo Minikube Docker
minikube config set driver docker
::
minikube config set WantUpdateNotification true
minikube config set WantBetaUpdateNotification true
minikube config set WantVirtualBoxDriverWarning false
::
minikube config view
::
:: minikube start --download-only
:: minikube start --dry-run
::
:: Flannel creates a virtual Layer 3 network that allows Kubernetes pods to communicate across different hosts using their unique IP addresses.
@echo Minikube Start
minikube start --nodes=2 --cni=flannel
:: minikube start --kubernetes-version=stable --nodes=2 --cni=flannel
::
@echo Minikube Dashboard Enable
minikube addons enable dashboard
:: minikube addons enable portainer
:: minikube addons enable kubevirt
::
minikube service list