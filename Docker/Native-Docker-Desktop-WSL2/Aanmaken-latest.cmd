::
:: Script voor het aanmaken van latest bestanden op basis van nieuwste bestand in directory
:: 11 juli 2024
:: John Tutert 
:: 

@echo off

set "destination=D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Docker\Native-Docker-Desktop-WSL2"
::
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Aanmaken LATEST voor Docker Desktop WSL2 Configurator
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
ECHO Version 1
::
:: Stel de bron- en doelmap in
set source=D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Docker\Native-Docker-Desktop-WSL2
:: Zoek het nieuwste bestand in de bronmap
FOR /F "delims=" %%I IN ('DIR "%source%" /B /A:-D /O:-D') DO SET NewestFile=%%I & GOTO Continue
:Continue
:: Maak een kopie van het nieuwste bestand met de oude naam en "latest" als toevoeging
COPY "%source%\%NewestFile%" "%destination%\Dckr-Desktop-WSL2-Config-Latest.cmd"
