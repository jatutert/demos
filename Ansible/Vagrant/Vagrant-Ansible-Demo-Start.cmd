::
:: HasiCorp VAGRANT
::
:: Ansible
:: DEMO
::
:: Starten Script
:: 12 augustus 2024
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
:: Maken en Starten Controller
@vagrant up U24-LTS-S-IACAM-001
:: Maken en Starten Host 
@vagrant up U24-LTS-S-IACAS-001
::
:: Eventueel commando uitvoeren in VM via SSH
:: vagrant ssh U24-LTS-S-IACAM --command "commando" 
:: vagrant ssh U24-LTS-S-IACAS --command "commando" 
::
:: 
@echo vagrant ssh U24-LTS-S-IACAM-001 naar controller
@echo vagrant ssh U24-LTS-S-IACAS-001 naar Host
::
::
:: Thats all folks
:: 