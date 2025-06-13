::
::	Introductie Infrastructuren en OICT05
::	Starten Virtuele machine
::
::	Created by John Tutert for TutSOFT
::
@echo off
@cls
::
@RAMMap64 -Ew
@RAMMap64 -Es
::
@echo [Stap 1] Starten virtuele machines
::	WebServer
@vagrant up U24-LTS-S-B-GR-XLW1
::	DBMS
::	vagrant up U24-LTS-S-B-GR-XLD1
::
@echo [Stap 2] SSH naar virtuele machine
@vagrant ssh U24-LTS-S-B-GR-XLW1
::
:: Thats all Folks
::