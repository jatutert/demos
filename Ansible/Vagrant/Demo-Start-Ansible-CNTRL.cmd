@ECHO OFF
@CLS
@Echo Opschonen geheugen 
@RAMMap.exe -Ew
@RAMMap.exe -Es
:: 
@ECHO Starten Ansible Controller ulx-s-2204-l-a-001 (duurt 4 minuten) 
@ECHO Gebaseerd op Ubuntu 22.04 LTS (tot april 2024 de nieuwste LTS versie) 
@ECHO. 
@vagrant up ulx-s-2204-l-a-001
@vagrant ssh ulx-s-2204-l-a-001
@echo Weer toegang via vagrant ssh ulx-s-2204-l-a-001
:: 