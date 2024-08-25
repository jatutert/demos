::
:: Minikube DOCKER 
::  
:: https://minikube.sigs.k8s.io/docs/faq/
:: https://minikube.sigs.k8s.io/docs/handbook/config/
:: 
:: Versie 1 | 26 maart 2024
:: Auteur: John Tutert
::
@ECHO OFF
@CLS
::  
:: Stoppen draaiende omgeving
@minikube stop
::
:: Verwijderen eventueel aanwezige omgeving
@minikube delete
::
:: Minikube starten zonder Kubernetes
:: https://minikube.sigs.k8s.io/docs/commands/start/ 
:: 
:: Docker
:: @minikube start --no-vtx-check --container-runtime=docker --no-kubernetes
:: @minikube start --no-vtx-check --no-kubernetes
:: 
:: IP adres van Virtuele machine weergeven
:: @echo Virtuele machine is bereikbaar op IP-adres
:: @minikube ip
:: @minikube service list
:: @minikube cache list
:: @minikube image ls
:: 
:: Configuratie Minikube VM
:: Directories maken Scripts maken Docker Compose installatie 
:: @echo Configuratie Minikube virtuele machine gestart ...
:: @minikube ssh "curl -o /home/docker/mkvmcnf.sh https://raw.githubusercontent.com/jatutert/demos/main/Minikube/Ubuntu-Linux-Shell-Script/minikube-vm-config-180424.sh"
:: @minikube ssh "chmod +x /home/docker/mkvmcnf.sh"
:: @minikube ssh "/home/docker/mkvmcnf.sh"
::
:: @minikube ssh