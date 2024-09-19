::
::
:: Introductie Infrastructuren 
:: OSTicket
:: Demo
:: Script
::
:: 27 augustus 2024
:: John Tutert
::
:: For personal and/or education use only ! 
::
@echo off
@cls
::
@RAMMap.exe -Ew
@RAMMap.exe -Es
::
:: Verwijderen DBMS
@vagrant halt U24-LTS-S-DBMS-S-001
@vagrant halt U24-LTS-S-DBMS-L-001
@vagrant halt U24-LTS-S-DBMS-XL-001
::
@vagrant destroy U24-LTS-S-DBMS-S-001 --force
@vagrant destroy U24-LTS-S-DBMS-L-001 --force
@vagrant destroy U24-LTS-S-DBMS-XL-001 --force
::
:: Verwijderen Webserver
@vagrant halt U24-LTS-S-WSRV-S-001
@vagrant halt U24-LTS-S-WSRV-L-001
@vagrant halt U24-LTS-S-WSRV-XL-001
::
@vagrant destroy U24-LTS-S-WSRV-S-001 --force
@vagrant destroy U24-LTS-S-WSRV-L-001 --force
@vagrant destroy U24-LTS-S-WSRV-XL-001 --force
::
:: Thats all folks
::