::
::	Kubernetes Demo (VCTL/BIND) Start Script
::	Created by John Tutert for TutSOFT
::
::	Version 1.1
::	
::
::	Changelog:
::	26okt24		Version 1.0		First Version
::	26apr25		Version 1.1		New Header
::
::
@echo off
@cls
::
@echo.
@echo	Kubernetes Demo door John Tutert
@echo.
@echo Verwijderen eventuele oude aanwezige VCTL omgeving ... 
@rmdir %USERPROFILE%\.vctl /S/Q
::
@echo VCTL Configureren 
@vctl system config --vm-mem 8g >nul 2>&1
@vctl system config --k8s-mem 8g >nul 2>&1
@vctl system config --vm-cpus 4 >nul 2>&1
@vctl system config --k8s-cpus 4 >nul 2>&1
::
@cls
::
::	Huidige Start Configuratie tonen op beeldscherm
::	@vctl system info
::
::	VMware VCTL starten
@vctl system start
::
::	K8S YAML bestanden downloaden mbv Powershell
::	@powershell Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jatutert/demos/refs/heads/main/Docker/Dockerfiles/FLASK/flask-demo-dkr-file-V2" -OutFile "C:\Users\JTU03\Downloads\flask-demo-dkr-file-V2"
::
::	Pull Docker Images
::	@echo	Images Downloaden
::	@vctl pull alpine >nul 2>&1
::	@vctl pull amazonlinux >nul 2>&1
::	@vctl pull nginx >nul 2>&1
::	@vctl pull httpd >nul 2>&1
::	@vctl images
::
::
::	Thats all folks
::
