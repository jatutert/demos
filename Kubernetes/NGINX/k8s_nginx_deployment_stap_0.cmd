::
::
::  Kubernetes MicroK8S Minikube demo deployment NGINX stap 0
::  Stap 0 is Minikube klaarmaken voor gebruik
::
echo Stap 0 Starten Docker Desktop
::
C:\Program Files\Docker\Docker\Docker Desktop.exe
::
echo Stap 0 Minikube klaarmaken voor gebruik
::
minikube stop --all
minikube delete --all --purge
::
minikube config set driver docker
minikube config set memory 8192
minikube config set cpus 4 
::
minikube config set WantUpdateNotification true
minikube config set WantBetaUpdateNotification true
minikube config set WantVirtualBoxDriverWarning false
::
minikube start --nodes=2 --cni=flannel
::
