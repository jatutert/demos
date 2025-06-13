::
::	Docker Demo using downloaded preconfigured virtual machine
::	Created by John Tutert for TutSOFT
::
::	For Educational and/or Personal Use ! 
::
@echo off
@cls
::
@echo.
@echo Docker Demo
@echo.
@echo Virtual Machine Initialize 
@echo.
@echo Created by John Tutert for TutSOFT
@echo. 
::
@echo [Stap 1] Vullen variabelen voor dit script
::
@echo [Stap 1a] Delayed Expansion aanzetten
@setlocal enabledelayedexpansion
::
@echo [Stap 1b] Bepalen Default VMX Path van VMWare Workstation Pro 
:: Pad naar het Preferences.ini bestand
@set "prefFile=%AppData%\VMware\preferences.ini"
::
:: Zoek de regel met prefvmx.defaultVMPath en haal het pad eruit
for /f "tokens=1,* delims==" %%A in ('findstr /i "prefvmx.defaultVMPath" "%prefFile%"') do (
    set "rawPath=%%B"
)
:: Verwijder aanhalingstekens
@set "vmPath=%rawPath:"=%"
::
@echo [Stap 1c] Instellen Virtual Machine Template Pad
set "VMTemplatePath=D:\Virtual-Machines\Templates\Linux\Ubuntu\Server\24-04-0-LTS\VMware"
::

@echo [Stap 2] Virtuele machine (eventueel) starten
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::
vmrun -T ws start "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx"

@echo [Stap 3] Wachten op de start van de virtuele machine
@sleep 180


@echo [Stap 4] RSA sleutel genereren op lokale laptop
ssh-keygen -f id_rsa -t rsa -N ""
copy /Y id_rsa %USERPROFILE%\.ssh
copy /Y id_rsa.pub %USERPROFILE%\.ssh


@echo [Stap 5] RSA overzetten naar virtuele machine
::
:: https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-the-vmrun-command-to-control-virtual-machines/running-vmrun-commands/syntax-of-vmrun-commands.html
::

vmrun -T ws -gu ubuntu -gp ubuntu CopyFileFromHostToGuest "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" "%USERPROFILE%\.ssh\id_rsa.pub" "/home/ubuntu/.ssh/authorized_keys"

@echo [Stap 6] IP Adres Virtuele Machine ophalen 
for /f "delims==" %%A in ('vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx"') do set vmipadres=%%A


ssh -i %USERPROFILE%\.ssh\id_rsa -o StrictHostKeyChecking=no




@echo [Stap x] Downloaden configuratiescript vanaf GitHUB
ssh -i %USERPROFILE%\.ssh\id_rsa ubuntu@%vmipadres% -o StrictHostKeyChecking=no "sudo curl -L -o /home/ubuntu/u24config.sh https://edu.nl/qxv7e" 
:: vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" "/bin/bash" "-c" "curl -L -o /home/ubuntu/u24config.sh https://edu.nl/qxv7e"

@echo [Stap x] Configuratiescript uitvoerbaar maken
ssh ubuntu@%vmipadres% "chmod +x /home/ubuntu/u24config.sh"
:: vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" "/bin/bash" "-c" "chmod +x /home/ubuntu/u24config.sh"

@echo [Stap x] Configuratiescript uitvoeren voor Docker
ssh ubuntu@%vmipadres% "sudo /home/ubuntu/u24config.sh docker"
:: vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx" "/bin/bash" "-c" "sudo /home/ubuntu/u24config.sh docker"







vmrun -T ws -gu ubuntu -gp ubuntu getGuestIPAddress "%vmPath%\Linux\Docker\U24-LTS-S-DKR-001.vmx"

::	IP Adres van virtuele machine opslaan in Variabele
::
::	LET OP! 
::	Interatief		for /f "delims=" %%A in ('<commando>') do set VARIABELE=%%A
::	In Script		for /f "delims=" %A in ('<commando>') do set VARIABELE=%A
::
::




