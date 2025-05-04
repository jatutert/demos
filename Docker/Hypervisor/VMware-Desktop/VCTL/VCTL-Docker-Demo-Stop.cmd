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
vctl system stop --force
vctl system info
::
@rammap64 -Ew
@rammap64 -Es
@rammap64 -Et
::
@rammap64 -Ew
@rammap64 -Es
@rammap64 -Et
::
@pause
::
::	That all folks
::