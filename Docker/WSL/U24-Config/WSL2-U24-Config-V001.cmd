::	Windows Subsystem for Linux (WSL) Version 2
::	Configuration Script
::
::	Author: John Tutert
::
::	Stoppen draaiende WSL omgevingen
wsl --terminate Ubuntu-24.04
wsl --terminate U24-LTS-S-DCKR
wsl --terminate U24-LTS-S-PDMN
::
::	Verwijderen bestaande omgevingen
wsl --unregister Ubuntu-24.04
wsl --unregister U24-LTS-S-DCKR
wsl --unregister U24-LTS-S-PDMN
::
::	Directories maken 
mkdir D:\Virtual-Machines
mkdir D:\Virtual-Machines\WSL
mkdir D:\Virtual-Machines\WSL\Ubuntu
mkdir D:\Virtual-Machines\WSL\Ubuntu\2404
mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\DCKR
mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\PDMN
mkdir D:\Virtual-Machines\WSL\Ubuntu\2404\KBRN
:: 
::	Installatie Docker
wsl --install Ubuntu-24.04 --name U24-LTS-S-DCKR --location D:\Virtual-Machines\WSL\Ubuntu\2404\DCKR
::	Installatie PodMan
wsl --install Ubuntu-24.04 --name U24-LTS-S-PDMN --location D:\Virtual-Machines\WSL\Ubuntu\2404\PDMN
::	Installatie Kubernetes (Minikube) 
wsl --install Ubuntu-24.04 --name U24-LTS-S-KBRN --location D:\Virtual-Machines\WSL\Ubuntu\2404\KBRN
::
:: Toon overzicht van aanwezige distributies 
wsl --list
::
::	Docker als Default instellen
wsl --set-default U24-LTS-S-DCKR
::
::
:: Toon overzicht van aanwezige distributies met nieuwe default
wsl --list
::
:: Opstarten 
wsl --distribution U24-LTS-S-DCKR
wsl --distribution U24-LTS-S-PDMN
wsl --distribution U24-LTS-S-KBRN
::
::	Standaard gebruiker instellen (kan pas na 1e keer starten) 
wsl --manage U24-LTS-S-DCKR --set-default-user labadmin
wsl --manage U24-LTS-S-PDMN --set-default-user labadmin
wsl --manage U24-LTS-S-KBRN --set-default-user labadmin
::
::	Vraag om wachtwoord uitzetten
::	bron: https://www.sindastra.de/p/679/no-sudo-password-in-wsl
::
::	Na eenmalig invoeren van wachtwoord hoe je hierna geen wachtwoord meer in te voeren bij sudo commando
::
wsl --exec echo "`whoami` ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/`whoami` && sudo chmod 0440 /etc/sudoers.d/`whoami`
:: 
::	Configuratiescript downloaden vanaf GitHub 
wsl --exec sudo curl -s -o /home/labadmin/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh
::
::	Configuratiescriptie uitvoerbaar maken binnen WSL Distributie
wsl --exec sudo chmod +x /home/labadmin/ubuntu-config-V3-latest.sh
::
::
::	Uitvoeren Configuratiescript
wsl --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh upgrade
wsl --exec sudo /home/labadmin/ubuntu-config-V3-latest.sh minikube