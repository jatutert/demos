@echo off
@echo.
@echo // Stoppen Virtuele machines //
::
@vagrant halt U24-LTS-S-DBMS-L-001 >nul 2>&1
@vagrant halt U24-LTS-S-WSRV-L-001 >nul 2>&1
@vagrant halt W10-ENT-D-OSTKT-CLNT >nul 2>&1
@vagrant halt W22-STD-S-OSTKT-RTR >nul 2>&1