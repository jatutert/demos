::
::	Introductie Infrastructuren en OICT05
::	Aanmaken en Configuratie Virtuele machine
::
::	Created by John Tutert for TutSOFT
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
@echo [Stap 1] Aanmaken en starten virtuele machines
::
::	WebServer
@vagrant up U24-LTS-S-B-GR-XLW1
::	DBMS
::	vagrant up U24-LTS-S-B-GR-XLD1
::
@echo [Stap 2] Configuratie Linux 
@vagrant ssh U24-LTS-S-B-GR-XLW1 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh upgrade" 
::
:: Thats all Folks
::