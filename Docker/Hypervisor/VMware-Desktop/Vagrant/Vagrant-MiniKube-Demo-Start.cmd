::
:: HasiCorp VAGRANT
::
:: MiniKube
:: DEMO
::
:: Starten Script
:: 17 augustus 2024
::
:: Auteur John Tutert
:: 
:: NOT FOR COMMERCIAL USE
:: 
@ECHO OFF
@CLS
@RAMMap.exe -Ew
@RAMMap.exe -Es
:: 
:: Maken en Starten omgeving 
@vagrant up U24-LTS-S-MK8S-001
::
:: Eventueel commando uitvoeren in VM via SSH
:: vagrant ssh U24-LTS-S-MK8S-001 --command "commando" 
::
@vagrant ssh U24-LTS-S-MK8S-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh minikube" 
::
::
@echo vagrant ssh U24-LTS-S-MK8S-001 naar VM
::
:: Thats all Folks
::