@ECHO OFF
@CLS
@Echo Opschonen geheugen 
RAMMap.exe -Ew
RAMMap.exe -Es
@Echo Starten ulx-s-2204-l-d-001
::
@vagrant up ulx-s-2204-l-d-001
@vagrant ssh ulx-s-2204-l-d-001
@echo Weer toegang via vagrant ssh ulx-s-2204-l-d-001