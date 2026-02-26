::	Windows Subsystem for Linux (WSL) Version 2
::	Configuration Script
::
::	Author: John Tutert
::
@echo off
@cls
::
@echo Stoppen draaiende WSL omgevingen
::	@wsl --terminate Ubuntu-24.04
::	@wsl --terminate U24-LTS-S-DCKR
::	@wsl --terminate U24-LTS-S-PDMN
@wsl --terminate U24-LTS-S-KBRN
::
@echo Verwijderen bestaande omgevingen
::	@wsl --unregister Ubuntu-24.04
::	@wsl --unregister U24-LTS-S-DCKR
::	@wsl --unregister U24-LTS-S-PDMN
@wsl --unregister U24-LTS-S-KBRN
::
@echo Directories maken 
@mkdir D:\Virtual-Machines
@mkdir D:\Virtual-Machines\WSL
@mkdir D:\Virtual-Machines\WSL\Ubuntu
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\DCKR
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\PDMN
@mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\KBRN
:: 
::	echo Installatie Ubuntu 24.04 met Docker
::	@wsl --install Ubuntu-24.04 --name U24-LTS-S-DCKR --location D:\Virtual-Machines\WSL\Ubuntu\2404\DCKR
::	echo Installatie Ubuntu 24.04 met PodMan
::	@wsl --install Ubuntu-24.04 --name U24-LTS-S-PDMN --location D:\Virtual-Machines\WSL\Ubuntu\2404\PDMN
echo Installatie Ubuntu 24.04 met Minikube (Kubernetes) 
@wsl --install Ubuntu-24.04 --name U24-LTS-S-KBRN --location D:\Virtual-Machines\WSL\Ubuntu\2404\KBRN
::
:: Toon overzicht van aanwezige distributies 
:: wsl --list
::
echo Docker als WSL Default instellen
@wsl --set-default U24-LTS-S-DCKR
::
::
:: Toon overzicht van aanwezige distributies met nieuwe default
:: wsl --list
::
::	echo Opstarten Ubuntu 24.04 Docker 
::	@wsl --distribution U24-LTS-S-DCKR
::	echo Opstarten Ubuntu 24.04 Podman
::	@wsl --distribution U24-LTS-S-PDMN
echo Opstarten Ubuntu 24.04 Minikube (Kubernetes)
@wsl --distribution U24-LTS-S-KBRN
::
echo Standaard gebruiker instellen (kan pas na 1e keer starten) 
::	@wsl --manage U24-LTS-S-DCKR --set-default-user labadmin
::	@wsl --manage U24-LTS-S-PDMN --set-default-user labadmin
@wsl --manage U24-LTS-S-KBRN --set-default-user labadmin
::
::	Vraag om wachtwoord uitzetten
::	bron: https://www.sindastra.de/p/679/no-sudo-password-in-wsl
::
::	Na eenmalig invoeren van wachtwoord hoe je hierna geen wachtwoord meer in te voeren bij sudo commando
::
::	wsl --exec echo "`whoami` ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/`whoami` && sudo chmod 0440 /etc/sudoers.d/`whoami`
:: 
::	Configuratiescript downloaden vanaf GitHub 
::	@wsl --distribution U24-LTS-S-DCKR --exec sudo curl -s -o /home/labadmin/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh
::	@wsl --distribution U24-LTS-S-PDMN --exec sudo curl -s -o /home/labadmin/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh
@wsl --distribution U24-LTS-S-KBRN --exec sudo curl -s -o /home/labadmin/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh
::
::	Configuratiescriptie uitvoerbaar maken binnen WSL Distributie
::	@wsl --distribution U24-LTS-S-DCKR --exec sudo chmod +x /home/labadmin/ubuntu-config-V3-latest.sh
::	@wsl --distribution U24-LTS-S-PDMN --exec sudo chmod +x /home/labadmin/ubuntu-config-V3-latest.sh
@wsl --distribution U24-LTS-S-KBRN --exec sudo chmod +x /home/labadmin/ubuntu-config-V3-latest.sh
::
::
::	Uitvoeren Configuratiescript
::
::	22 maart 2024
::	Loopt vast op installatie Powershell
::	Aangepaste versie van Powershell installatie gemaakt in Ubuntu Config 22 mrt 2025
::	Powershell starten met pwsh en niet met powershell 
::
::	@echo Updaten Ubuntu 24.04 met Docker
::	@wsl --distribution U24-LTS-S-DCKR --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh upgrade
::	@echo Updaten Ubuntu 24.04 met Podman
::	@wsl --distribution U24-LTS-S-PDMN --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh upgrade
@echo Updaten Ubuntu 24.04 met Minikube (Kubernetes)
@wsl --distribution U24-LTS-S-KBRN --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh upgrade
::
::	@echo Installatie Docker
::	@wsl --distribution U24-LTS-S-DCKR --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh docker
::	@echo Installatie Podman
::	@wsl --distribution U24-LTS-S-PDMN --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh podman
@echo Installatie Minikube (Kubernetes)
@wsl --distribution U24-LTS-S-KBRN --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh minikube
::