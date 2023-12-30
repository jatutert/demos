@ECHO OFF
@CLS
@Echo Opschonen geheugen 
@RAMMap.exe -Ew
@RAMMap.exe -Es
:: 
@Echo Starten Ansible Host ulx-s-2204-l-a-010 (duurt 4 minuten) 
@vagrant up ulx-s-2204-l-a-010
@vagrant ssh ulx-s-2204-l-a-010
@echo Weer toegang via vagrant ssh ulx-s-2204-l-a-010
:: 