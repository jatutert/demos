::
::
:: Introductie Infrastructuren 
:: OSTicket
:: Demo
:: Script
::
:: September 11 2024 (aangepast 19 september) 
:: John Tutert
::
:: For personal and/or education use only ! 
::
@echo off
@cls
@echo // Opschonen Geheugen //
:: Empty Working Sets
@RAMMap.exe -Ew >nul 2>&1
:: Empty System Working Sets 
@RAMMap.exe -Es >nul 2>&1
:: Empty Modified Page list 
@RAMMap.exe -Em >nul 2>&1
:: Empty Standy list 
@RAMMap.exe -Et >nul 2>&1
::
@cls
@echo.
@echo Starten // Linux DBMS //  
@vagrant up U24-LTS-S-DBMS-L-001 >nul 2>&1
@echo Starten // Linux WebServer // 
@vagrant up U24-LTS-S-WSRV-L-001 >nul 2>&1
::
:: Empty Working Sets
@RAMMap.exe -Ew >nul 2>&1
:: Empty System Working Sets 
@RAMMap.exe -Es >nul 2>&1
:: Empty Modified Page list 
@RAMMap.exe -Em >nul 2>&1
:: Empty Standy list 
@RAMMap.exe -Et >nul 2>&1
::
@echo Starten // Windows Client //
:: RAM 4 GB
@vagrant up W10-ENT-D-OSTKT-CLNT >nul 2>&1
::
@echo Starten // Windows ROUTER //
:: RAM 4 GB
@vagrant up W22-STD-S-OSTKT-RTR >nul 2>&1
::
:: Empty Working Sets
@RAMMap.exe -Ew >nul 2>&1
:: Empty System Working Sets 
@RAMMap.exe -Es >nul 2>&1
:: Empty Modified Page list 
@RAMMap.exe -Em >nul 2>&1
:: Empty Standy list 
@RAMMap.exe -Et >nul 2>&1
::
@echo.
@echo // Configuratie DBMS //
@echo.
@vagrant ssh U24-LTS-S-DBMS-L-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
::
@echo Opschonen Geheugen 
:: Empty Working Sets
@RAMMap.exe -Ew >nul 2>&1
:: Empty System Working Sets 
@RAMMap.exe -Es >nul 2>&1
:: Empty Modified Page list 
@RAMMap.exe -Em >nul 2>&1
::
@echo.
@echo // Configuratie WebServer //
@echo.
@vagrant ssh U24-LTS-S-WSRV-L-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
::
@echo Opschonen Geheugen 
:: Empty Working Sets
@RAMMap.exe -Ew >nul 2>&1
:: Empty System Working Sets 
@RAMMap.exe -Es >nul 2>&1
:: Empty Modified Page list 
@RAMMap.exe -Em >nul 2>&1
::
@echo vagrant ssh U24-LTS-S-DBMS-L-001 voor database server
@echo vagrant ssh U24-LTS-S-WSRV-L-001 voor webserver server
@echo vagrant ssh W10-ENT-D-OSTKT-CLNT voor client
@echo vagrant ssh W22-STD-S-OSTKT-RTR voor Router
::
:: Thats all folks
::