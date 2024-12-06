@echo Verwijderen eventuele oude VCTL omgeving ... 
@rmdir %USERPROFILE%\.vctl /S/Q
::
@echo VCTL Configureren 
@vctl system config --vm-mem 8g
@vctl system config --vm-cpus 4
::
@vctl system info
::
@echo VCTL Starten ...
@vctl system start
