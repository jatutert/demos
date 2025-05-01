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
@echo.
@echo.
@echo Docker/VCTL Demo door John Tutert
@echo.
@echo. 
@echo [Stap 1] Verwijderen eventuele oude aanwezige VCTL omgeving voor deze gebruiker
@rmdir %USERPROFILE%\.vctl /S/Q
::
@echo [Stap 2] VCTL Configureren 
@vctl system config --vm-mem 8g >nul 2>&1
@vctl system config --vm-cpus 4 >nul 2>&1
::
::	Huidige Start Configuratie tonen op beeldscherm
::	@vctl system info
::
@echo [Stap 3] VCTL Starten
@vctl system start
::
@echo [Stap 4] Dockerfile downloaden
@powershell Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jatutert/demos/refs/heads/main/Docker/Dockerfiles/FLASK/flask-demo-dkr-file-V2" -OutFile "C:\Users\JTU03\Downloads\flask-demo-dkr-file-V2"
::
@echo [Stap 5] Docker Images Downloaden
@vctl pull alpine >nul 2>&1
@vctl pull amazonlinux >nul 2>&1
@vctl pull nginx >nul 2>&1
@vctl pull httpd >nul 2>&1
::	@vctl pull portainer/portainer >nul 2>&1
::	@vctl pull portainer/agent >nul 2>&1
::	@vctl images
::
::	Thats all folks
::