::
:: Opschonen MiniKube demo omgeving
:: Script
:: 
:: 17 Augustus 2024
::
:: John Tutert
::
::
@ECHO OFF
@CLS
::
@RAMMap.exe -Ew
@RAMMap.exe -Es
:: 
@vagrant halt U24-LTS-S-MK8S-001
::
@vagrant destroy U24-LTS-S-MK8S-001 --force
::
:: Thats all folks
:: 