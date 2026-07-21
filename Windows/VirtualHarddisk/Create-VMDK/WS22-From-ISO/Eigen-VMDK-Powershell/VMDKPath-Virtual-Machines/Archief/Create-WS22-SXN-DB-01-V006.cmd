::
::   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
::     TT    U    U    TT    SS      O    O  FF        TT
::     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
::     TT    U    U    TT        SS  O    O  FF        TT
::     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
::
::
::  Create VMDK from VHD from ISO
::  Windows Command Prompt 
::
::  Version 006
::  16 juli 2026
::
::  Kopie van Create WS22 SXN RD 01 script met aanpassing RD naar DB
::
::  By John Tutert
::
::  For Personal and/or Educational use only ! 
::
::
::  Echo Hardware Productkey
::  wmic path softwarelicensingservice get OA3xOriginalProductKey
::
::
@echo off
@cls
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Script gestart met Administrator rechten. Prima ! We kunnen verder ... 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::
@echo off
@cls
@echo Virtual machine creator script by TutSOFT
@echo Creating SXN-DB-01 virtual machine 
::
::  Eventueel verwijderen bestaande virtuele machine 
::  Indien ouder dan 30 dagen 
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK (
    @REM
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01" /m "SXN-DB-01.VMDK" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo Verwijderen bestaande virtuele machine
        @vmrun -T ws stop D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx >nul 2>&1
        @vmrun -T ws DeleteVM D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx >nul 2>&1
        @del /F /S /Q D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\*.* >nul 2>&1
        @REM
    ) else (
        @REM
        @echo Virtuele machine is aanwezig en ook niet ouder dan 30 dagen. 
        @echo Er is geen reden om de virtuele machine opnieuw aan te maken.
        @REM
    )
)
::
::
@echo Aanmaken Directories Microsoft Hyper-V
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\ >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
@echo Aanmaken Directories VMware Workstation Pro
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\ >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\ >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\SXN-WS-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-LAB-001 >nul 2>&1
::
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DC-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01 >nul 2>&1
@mkdir D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\W22-DTC-S-LAB-001 >nul 2>&1
::
@echo Aanmaken Directory structuur op NextCloud
::
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\ >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DC-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01 >nul 2>&1
@mkdir C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-WS-01 >nul 2>&1
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VHD
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@IF EXIST "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01\SXN-DB-01.VHD" (
    @REM
    forfiles /p "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01" /m "SXN-DB-01.VHD" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo Het VHD Bestand is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VHD bestand op D schijf 
        @REM
        @del /F "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01\SXN-DB-01.VHD"
        @REM
    ) else (
        @REM
        @echo VHD bestand is aanwezig en is niet ouder dan 30 dagen.
        @echo VHD bestand blijft daarom gewoon staan op de D schijf. 
        @REM
    )
)
::
::  Aanmaken VHD bestand indien niet aanwezig 
::
@IF NOT EXIST "D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01\SXN-DB-01.VHD" (
    @echo Powershell script starten
    @Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\VirtualHarddisk\Create-VHD\WS22-From-ISO\Powershell\VHDPath-Virtual-Machines\SXN-DB-01"\WS22-SXN-DB-01-Create-VHD-Latest.ps1
    @echo Terug van Powershell
)
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMDK
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::      VMDK
::      VMWare Workstation Pro
::
@IF EXIST "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK" (
    @REM
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01" /m "SXN-DB-01.VMDK" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo Het VMDK Bestand is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VMDK bestand op D schijf 
        @REM
        @del /F "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK"
        @REM
    )
)
::
@IF NOT EXIST "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK" (
    @REM
    @REM    Aanmaken VDMK door conversie VHD
    @echo Conversie van aanwezig VHD naar VMDK gestart ... 
    @"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DB-01\SXN-DB-01.VHD" out_file_name="D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK" out_file_type=ft_vmdk_ws_growable
    @REM
)
::
::      VMDK 
::      NextCloud
::
@IF EXIST "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMDK" (
    @REM
    @REM    Bepalen of het aanwezige VMDK bestand op NextCloud ouder is dan 30 dagen
    @REM
    forfiles /p "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01" /m "SXN-DB-01.VMDK" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMDK Bestand op NextCloud is ouder dan 30 dagen
        @echo Verwijderen VDMK bestand op NextCloud 
        @REM
        del "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMDK"
        @REM
    )
)
::
@IF NOT EXIST "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMDK" (
    @REM
    @echo Overzetten VMDK uit VM Directory naar NextCloud
    @REM
    @robocopy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01 C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01 SXN-DB-01.VMDK /MT:16 /J /ETA
    @REM
    @REM copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMDK C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01
    @REM
    @echo Ruimte besparen NextCloud 
    attrib +U -P "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMDK"
) 
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMX
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::      VMX
::      VMWare Workstation PRO
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMX (
    @REM
    forfiles /p "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01" /m "SXN-DB-01.VMX" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMX is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VMX 
        @REM
        del "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMX"
    )
)
::
@IF NOT EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMX (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo Aanmaken VMX in VM Directory VMWare Workstation 
    @copy "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Hypervisor\VMware-Desktop\VMX\SXN-DB-01.vmx" D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx
)
::
::      VMX
::      NextCloud
::
@IF EXIST C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMX (
    @REM
    forfiles /p "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01" /m "SXN-DB-01.VMX" /d -30 >nul 2>&1
    @REM
    if %errorlevel%==0 (
        @REM
        @echo VMX is aanwezig maar ouder dan 30 dagen
        @echo Verwijderen VMX 
        @REM
        del "C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMX"
    )
)
::
@IF NOT EXIST C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01\SXN-DB-01.VMX (
    @REM
    @REM  VMX bestand is niet aanwezig
    @REM
    @echo Overzetten VMX uit VM Directory naar NextCloud
    @copy D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx C:\Users\jtu03\Nextcloud\Shared\Virtual-Machines\SXN-DB-01
)
::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::      ::::
::      ::::    VMWare Workstation Pro
::      ::::    Virtuele machine 
::      ::::
::      :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
@IF EXIST D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.VMX (
    @REM
    @echo Openen SXN-DB-01 in VMware Workstation PRO
    @start /B vmware -n D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx
    @REM
    @echo Starten VM 
    @start vmrun -T ws start D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Server\SXN-DB-01\SXN-DB-01.vmx
)
::
::
::      Thats all folks
::
::      This is the end
::      Hold your breath and count to ten
::      Feel the Earth move and then
::      Hear my heart burst again
::      For this is the end
::      I've drowned and dreamt this moment
::      So overdue, I owe them
::      Swept away, I'm stolen
::
::      Adelle
::