::
:: Opschonen Ansible demo omgeving
:: Script
:: 
:: 12 Augustus 2024
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
@vagrant halt U24-LTS-S-IACAM-001
@vagrant halt U24-LTS-S-IACAS-001
::
@vagrant destroy U24-LTS-S-IACAM-001 --force 
@vagrant destroy U24-LTS-S-IACAS-001 --force 
::
:: Thats all folks
:: 