::
::  Kubernetes MicroK8S Minikube demo deployment NGINX stap 3
::  Stap 3 is replicatecount van 2 naar 4 bijwerken 
::
echo Stap 5 Opruimen
::
minikube stop -all
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