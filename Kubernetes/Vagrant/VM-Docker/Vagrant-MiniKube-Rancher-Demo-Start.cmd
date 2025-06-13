::
::	Kubernetes demo (met behulp van Minikube)
::	Binnen Ubuntu Server VM met Docker
::
::	Created by John Tutert for TutSOFT
::	For Educational and/or Personal use !
::
::
RAMMap64 -Ew
RAMMap64 -Es
::
RAMMap64 -Ew
RAMMap64 -Es
::
@echo off
@cls
::
@echo [Stap 1] Starten Ubuntu Server VM met behulp van Vagrant
@vagrant up U24-LTS-S-B-GR-LMD1
::
@echo [Stap 2] Ubuntu Server VM voorzien van Docker
:: Onderstaand commandline is nog niet compleet 
@vagrant ssh U24-LTS-S-B-GR-LMD1 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh docker" 
::
@echo [Stap 3] Ubuntu Server VM voorzien van Minikube
:: Onderstaand commandline is nog niet compleet 
@vagrant ssh U24-LTS-S-B-GR-LMD1 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh minikube" 
::
@echo [Stap 4] Starten Minikube binnen Ubuntu Server VM
:: Onderstaand commandline is nog niet compleet 
@vagrant ssh U24-LTS-S-B-GR-LMD1 minikube start --driver docker
::
@echo [stap 5] Ubuntu Server VM voorzien van Rancher
::	Rancher is managementomgeving voor K8S
::
::	https://medium.com/@mhshahin/provision-minikube-using-rancher-811bc39c122b
::
:: Onderstaand commandline is nog niet compleet 
@vagrant ssh U24-LTS-S-B-GR-LMD1 docker run --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:latest
::
::
::
::	Thats all Folks
::
