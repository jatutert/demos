::
::	Alpine toevoegen aan WSL2
:: 	https://github.com/AndyRids/Alpine-WSL-Dev
::
::
::	curl -o [bestemming] https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/x86_64/alpine-minirootfs-3.21.0-x86_64.tar.gz
::
::	wsl --import Alpine D:\Virtual-Machines\WSL\Alpine\0321 C:\Users\jtu03\Downloads\alpine-minirootfs-3.20.1-x86_64.tar
::
@cls
:: @echo.
:: @echo Gebruikersnaam: labadmin
:: @echo Wachtwoord: labadmin1234
:: @echo.
::
:: @echo Beschikbare Linux distros
:: @wsl --list
:: @echo.
::
::
::	Init van Alpine Distribution
::	@wsl --distribution Alpine --exec apk update
::	@wsl --distribution Alpine --exec apk upgrade
::	@wsl --distribution Alpine --exec apk add openrc
::	@wsl --distribution Alpine --exec apk add util-linux
::
::
:: 	Docker Daemon starten in de achtergrond 
@start wsl --distribution Alpine --exec dockerd
::
::	Alpine terminal starten
@wsl --distribution Alpine --exec fastfetch
@wsl --distribution Alpine
