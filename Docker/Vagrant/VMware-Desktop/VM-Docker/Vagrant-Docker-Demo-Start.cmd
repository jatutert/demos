::
::	Docker Demo using Vagrant with VMware Workstation Pro
::	Created by John Tutert for TutSOFT
::
::	For Educational and/or Personal Use
::
:: 
@echo off
@cls
::
@RAMMap64 -Ew
@RAMMap64 -Es
::
@RAMMap64 -Ew
@RAMMap64 -Es
::
::
@echo [Stap 1] Stoppen en verwijderen virtuele machine
@vagrant halt U24-LTS-S-B-GR-LDD1 --force
@vagrant destroy U24-LTS-S-B-GR-LDD1 --force
::
@echo [Stap 2] Starten virtuele machine 
@vagrant up U24-LTS-S-B-GR-LDD1
::
@echo [Stap 3] Configuratie virtuele machine 
@vagrant ssh U24-LTS-S-B-GR-LDD1 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh docker" 
::
::
@echo vagrant ssh U24-LTS-S-DCKR-001 naar VM
::
:: Thats all Folks
::