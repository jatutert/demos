echo off
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
@echo // Starten Virtuele machines //
::
:: @vagrant up U24-LTS-S-DBMS-L-001 >nul 2>&1
@vagrant up U24-LTS-S-DBMS-L-001
:: @vagrant up U24-LTS-S-WSRV-L-001 >nul 2>&1
@vagrant up U24-LTS-S-WSRV-L-001 
:: @vagrant up W10-ENT-D-OSTKT-CLNT >nul 2>&1
@vagrant up W10-ENT-D-OSTKT-CLNT
:: @vagrant up W22-STD-S-OSTKT-RTR >nul 2>&1
@vagrant up W22-STD-S-OSTKT-RTR
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
@echo vagrant ssh U24-LTS-S-DBMS-L-001 voor database server
@echo vagrant ssh U24-LTS-S-WSRV-L-001 voor webserver server
@echo vagrant ssh W10-ENT-D-OSTKT-CLNT voor client
@echo vagrant ssh W22-STD-S-OSTKT-RTR voor Router