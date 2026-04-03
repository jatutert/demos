::
:: Script voor het aanmaken van latest bestanden op basis van nieuwste bestand in directory
:: 11 juli 2024
:: John Tutert 
:: 

@echo off


::
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Aanmaken LATEST voor WSL2 Config (versie 1)
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
ECHO Version 1
::
:: Stel de bron- en doelmap in
set "huidig=D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Virtual-Machines"
:: Zoek het nieuwste bestand in de bronmap
FOR /F "delims=" %%I IN ('DIR "%huidig%" /B /A:-D /O:-D') DO SET v1NewestFile=%%I & GOTO V1Continue
:V1Continue
:: Maak een kopie van het nieuwste bestand met de oude naam en "latest" als toevoeging
COPY "%huidig%\%v1NewestFile%" "%huidig%\W11-EDU-Create-VHD-Latest.ps1"
::
