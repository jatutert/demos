::
::	Docker Demo (VCTL) Start Script
::	Created by John Tutert for TutSOFT
::
::	Version 1.1
::	
::
::	Changelog:
::	26okt24		Version 1.0		First Version
::	26apr25		Version 1.1		New Header
::
::	NIET gebruiken voor Kubernetes/Bind demo !
::	Voor deze demo zie map demo/kubernetes
::
::
@echo off
@cls
::
@echo [Stap 1] Administrator rechten check
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @echo Script wordt uitgevoerd met de JUISTE rechten !
    @echo. 
) ELSE (
    @echo Script NIET gestart met Adminstrator rechten ! 
    @pause
    @EXIT 1
)
::
@echo.
@echo.
@echo Docker/VCTL Demo door John Tutert
@echo.
@echo. 
::
@echo [Stap 2] Installeren SysInternals RAMMap 
@winget install Microsoft.Sysinternals.RAMMap --force
::
@echo [Stap 3] Opschonen geheugen
@rammap64 -Ew
@rammap64 -Es
@rammap64 -Et
::
@rammap64 -Ew
@rammap64 -Es
@rammap64 -Et
::
@echo [Stap 4] Verwijderen eventuele oude aanwezige VCTL omgeving voor deze gebruiker
@rmdir %USERPROFILE%\.vctl /S/Q
::
@echo [Stap 5] VCTL Configureren 
@vctl system config --vm-mem 8g >nul 2>&1
@vctl system config --vm-cpus 4 >nul 2>&1
::
::	Huidige Start Configuratie tonen op beeldscherm
::	@vctl system info
::
@echo [Stap 6] VCTL Starten
@vctl system start
::
@echo [Stap 7] Dockerfile downloaden
@powershell Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jatutert/demos/refs/heads/main/Docker/Dockerfiles/FLASK/flask-demo-dkr-file-V2" -OutFile "C:\Users\JTU03\Downloads\flask-demo-dkr-file-V2"
::
@echo [Stap 8] Docker Images Downloaden
@echo.
@echo Alpine
@vctl pull alpine >nul 2>&1
@echo Amazon Linux
@vctl pull amazonlinux >nul 2>&1
@echo nginx
@vctl pull nginx >nul 2>&1
@echo Apache 
@vctl pull httpd >nul 2>&1
::	@vctl pull portainer/portainer >nul 2>&1
::	@vctl pull portainer/agent >nul 2>&1
::	@vctl images
::
::	Thats all folks
::