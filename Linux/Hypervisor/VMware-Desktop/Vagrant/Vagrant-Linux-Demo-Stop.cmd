::
::	Introductie Infrastructuren en OICT05
::	Stoppen/Afsluiten draaiende Virtuele machines
::
::	Created by John Tutert for TutSOFT
::
@echo off
@cls
::
@RAMMap64 -Ew
@RAMMap64 -Es
::
@echo.
@echo Introductie Infrastructuren / OICT05
@echo Stoppen virtuele machines
@echo. 
@echo DBMS virtuele machine stoppen
@vagrant halt U24-LTS-S-B-GR-XLD1
::
@echo WebServer virtuele machine stoppen
@vagrant halt U24-LTS-S-B-GR-XLW1
::
:: Thats all Folks
::