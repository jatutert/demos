::
::  Docker Desktop on WSL2 Compatible
::
minikube stop
minikube delete
::
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
minikube start --nodes=2 --cni=flannel
:: minikube start --kubernetes-version=stable --nodes=2 --cni=flannel
::
minikube addons enable dashboard
:: minikube addons enable portainer
:: minikube addons enable kubevirt
::
minikube service list