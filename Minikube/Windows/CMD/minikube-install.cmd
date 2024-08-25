:: Minikube Installatie Script
:: Versie 1
:: Datum 26 maart 2024
:: Auteur John Tutert
:: 
:: Verwijderen directories
RD %USERPROFILE%\.minikube /S /Q
RD %USERPROFILE%\.kube /S /Q
:: 
:: Installeren Minikube
winget install --id Kubernetes.minikube
:: Installeren kubectl 
winget install -e --id Kubernetes.kubectl
::
exit