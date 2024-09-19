:: Minikube DOCKER Configuratie Script 
:: Versie 1
:: Datum 23 APRIL 2024
:: Auteur John Tutert
::
::
::	Changelog
::	25 augustus 2024	Ubuntu Config V3 Flask image build en Run
::
@echo OFF
@cls
::  
:: Stoppen eventueel draaiende omgeving
@echo STOP eventueel draaiende omgeving
@minikube stop --all
::
:: Verwijderen eventueel aanwezige omgeving
@echo VERWIJDER eventueel aanwezige omgeving 
@minikube delete --purge
::
:: Omgevingsvariabelen instellen
:: Geen emoji weergeven
@echo Omgevingsvariabelen instellen
@Setx MINIKUBE_IN_STYLE "false"
:: 
:: VM opslaan in andere (eigen) folder/map
::	@Setx MINIKUBE_HOME "D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux"
@Setx MINIKUBE_HOME "D:\Virtual-Machines\VMware-Workstation-PRO\Linux"
::
:: Minikube configuratie instellen 
@echo Minikube configuratie 
@minikube config set memory 8192
@minikube config set cpus 4 
::	@minikube config set driver virtualbox 
@minikube config set driver vmware 
@minikube config set WantUpdateNotification true
@minikube config set WantBetaUpdateNotification true
@minikube config set WantVirtualBoxDriverWarning false
@minikube config view
:: @minikube config view 
::
:: Minikube starten voor alleen Download
:: @minikube start --download-only
::
:: Check of alles in orde is
:: @minikube start --dry-run
:: 
:: Docker
:: @minikube start --no-vtx-check --container-runtime=docker --no-kubernetes
@echo Minikube DOCKER starten ...
:: @minikube start --no-vtx-check --no-kubernetes
@minikube start --no-kubernetes
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
@echo Configuratie Minikube virtuele machine gestart ...
@minikube ssh "curl -s -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
@minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
@minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
::
::	@minikube ssh "curl -o /home/docker/mkvmcnf.sh https://raw.githubusercontent.com/jatutert/demos/main/Minikube/Ubuntu-Linux-Shell-Script/minikube-vm-config-180424.sh"
::	@minikube ssh "chmod +x /home/docker/mkvmcnf.sh"
::	@minikube ssh "/home/docker/mkvmcnf.sh"
::
:: Maken Flask Demo Image en hierna uitvoeren 
minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
:: 
::
:: Docker Images PULL
:: 
:: Alpine 7 MB
:: @minikube ssh "docker pull alpine"
:: 
:: Ubuntu 68 MB 
:: @minikube ssh "docker pull ubuntu:18.04"
:: 
:: Debian 117 MB
:: @minikube ssh "docker pull debian"
:: 
:: Prakhar Static site 134 MB 
:: @minikube ssh "docker pull prakhar1989/static-site"
:: 
:: Portainer
:: 
:: Let OP BSOD bij gebruik vanuit VM
:: @minikube ssh "docker pull portainer/portainer-ce"
:: Portainer Volume maken 
:: @minikube ssh "docker volume create portainer_data"
:: Portainer starten op poort 9443
:: @minikube ssh "docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest"
::
:: @minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
::
:: IP adres van Virtuele machine weergeven
@echo Virtuele machine is bereikbaar op IP-adres
@minikube ip
::
@minikube ssh