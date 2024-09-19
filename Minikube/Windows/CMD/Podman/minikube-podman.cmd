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
:: Stoppen eventueel draaiende omgeving
@minikube stop
::
:: Verwijderen eventueel aanwezige omgeving
@minikube delete
::
:: Downloaden Minikube Virtuele machine 
@minikube start --download-only 
::
:: Dry RUN Minikube
@minikube start --dry-run 
:: 
:: Minikube starten zonder Kubernetes
:: https://minikube.sigs.k8s.io/docs/commands/start/ 
:: 
:: Docker
:: @minikube start --no-vtx-check --container-runtime=docker --no-kubernetes
:: 
:: Podman
@minikube start --no-vtx-check --driver=podman --container-runtime=cri-o
:: 
:: IP adres van Virtuele machine weergeven
@minikube ip
:: @minikube service list
:: @minikube cache list
:: @minikube image ls
:: 
:: Configuratie Minikube VM
:: Directories maken Scripts maken Docker Compose installatie 
:: @minikube ssh "curl -o /home/docker/mkvmcnf.sh https://raw.githubusercontent.com/jatutert/demos/main/Minikube/Ubuntu-Linux-Shell-Script/minikube-vm-config-180424.sh"
:: @minikube ssh "chmod +x /home/docker/mkvmcnf.sh"
:: @minikube ssh "/home/docker/mkvmcnf.sh"
::
@minikube ssh "podman pull alpine"
@minikube ssh "podman pull ubuntu:22.04"
:: 