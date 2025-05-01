::
::	DOCKER DEMO
::
::	MINIKube Edition Fase 5  
::
::	Minikube Demo stop from Windows Explorer
::
::	By John Tutert for TutSOFT
:: 
::	Version	1
::
::	Date	28 Oktober 2024
::
::	LET OP! 
::	START DIT SCRIPT VANUIT WINDOWS VERKENNER EN NIET VANUIT TERMINAL
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
@echo [Stap 2] Stoppen eventueel eventueel draaiende Minikube omgevingen 
@minikube stop --all >nul 2>&1
@echo.
::
@echo [Stap 3] Weergeven status
@minikube status
::
@pause
::
@exit
::
::	Thats all Folks
::