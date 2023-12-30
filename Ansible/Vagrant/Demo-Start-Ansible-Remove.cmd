@ECHO OFF
@CLS
@Echo Opschonen geheugen 
@RAMMap.exe -Ew
@RAMMap.exe -Es
:: 
@Echo Stoppen Ansible Controller
@vagrant halt ulx-s-2204-l-a-001
@ECHO Stoppen Ansible Host
@vagrant halt ulx-s-2204-l-a-010
::
@ECHO Verwijderen Ansible Controller
@vagrant destroy ulx-s-2204-l-a-001 --force 
@vagrant destroy ulx-s-2204-l-a-010 --force 