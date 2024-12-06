::
::
:: Introductie Infrastructuren 
:: OSTicket
:: Demo
:: Script
::
:: September 11 2024 (17 september alleen DBMS) 
:: John Tutert
::
:: For personal and/or education use only ! 
::
@echo off
@cls
@echo.
@echo Starten OSTicket Virtuele machines (WSRV)
@echo. 
::
:: Empty Working Sets
@RAMMap.exe -Ew
:: Empty System Working Sets 
@RAMMap.exe -Es
:: Empty Modified Page list 
@RAMMap.exe -Em
::
:: Starten Linux Virtuele Machines 
:: @echo Starten // DBMS // WebServer // 
@echo Starten // WSRV //  
@echo. 
@vagrant up U24-LTS-S-WSRV-L-001 
:: @vagrant up U24-LTS-S-WSRV-XL-001
::
:: Empty Working Sets
@RAMMap.exe -Ew
:: Empty System Working Sets 
@RAMMap.exe -Es
:: Empty Modified Page list 
@RAMMap.exe -Em
::
::
:: Start Windows Virtuele machines
:: @echo Starten // Router // Client // 
:: @echo.
:: @echo Deze opstart slaan we vandaag even over ... 
:: @vagrant up W11-ENT-D-OSTKT-CLNT 
:: @vagrant up W22-STD-S-OSTKT-RTR
::
::	@RAMMap.exe -Ew
::	@RAMMap.exe -Es
::	@RAMMap.exe -Em
::
@echo.
@echo Configuratie Virtuele machines ...
@echo.
::	Configuratie DBMS
@vagrant ssh U24-LTS-S-WSRV-L-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
::
::	@RAMMap.exe -Ew
::	@RAMMap.exe -Es
::	@RAMMap.exe -Em
::
:: Configuratie WebServer
:: @vagrant ssh U24-LTS-S-WSRV-XL-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
::
::
:: Empty Working Sets
@RAMMap.exe -Ew
:: Empty System Working Sets 
@RAMMap.exe -Es
:: Empty Modified Page list 
@RAMMap.exe -Em
::
@echo vagrant ssh U24-LTS-S-WSRV-L-001 voor WEB server
::	@echo vagrant ssh U24-LTS-S-WSRV-001 voor webserver server
::	@echo vagrant ssh W11-ENT-D-OSTKT-CLNT voor client
::	@echo vagrant ssh W22-STD-S-OSTKT-RTR voor Router
::
:: Thats all folks
::