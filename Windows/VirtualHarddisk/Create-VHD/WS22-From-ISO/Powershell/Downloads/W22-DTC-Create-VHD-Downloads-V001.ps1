#
#   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#     TT    U    U    TT    SS      O    O  FF        TT
#     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#     TT    U    U    TT        SS  O    O  FF        TT
#     TT    UUUUUU    TT    SSSSSS  OOOOOOO FF        TT
#
#   Windows Server 2022 DataCenter ISO naar Virtual Harddisk VHD
#   PowerSHELL SCRIPT
#
#   For Personal and/or Education Use Only ! 
#
#
#   19 maart 2026
#
#
#   LET OP!
#   Dit script maakt gebruik van Schneegans autounattend.xml
#
#
Clear-Host
#
#
#   #####################
#   DECLARATIE VARIABELEN
#   #####################
#
#




$Downloads              = "$env:USERPROFILE\Downloads"
#
$ISO_Download_Link      - 'https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US'
$ISO_Download_FileName  = 'SERVER_EVAL_x64FRE_en-us.iso'
#
$AUTOUNATTEND_Download_Link = 'https://raw.githubusercontent.com/jatutert/demos/refs/heads/main/Windows/Guest/Windows/2022/AutoUnattend/GitHub-Ruzickap'
$AUTOUNATTEND_Download_Filename = 'Autounattend_V008.xml'
#
$TS_WIN_ISO_FOLDER      = "$env:USERPROFILE\Downloads"
$TS_WIN_ISO_FILE        = 'en-us_windows_server_2022_updated_march_2026_x64_dvd_3f772967.iso'
$TS_WIN_UNATTEND_FOLDER = "$env:USERPROFILE\Downloads"
$TS_WIN_UNATTEND_FILE   = 'WS22_Autounattend.xml'
#
#
#   #####################
#   Downloaden noodzakelijke bestanden
#   #####################
#
#
# ISO
if (Test-Path $PadNaarBestand) {
    Write-Host "Bestand bestaat al: $PadNaarBestand"
}
else {
    Write-Host "Bestand bestaat niet. Download wordt uitgevoerd..."
    Invoke-WebRequest -URI "$ISO_Download_Link" -OutFile %userprofile%\Downloads\SERVER_EVAL_x64FRE_en-us.iso
    Write-Host "Download voltooid."
}
#
# AutoUnattend
if (Test-Path $PadNaarBestand) {
    Write-Host "Bestand bestaat al: $PadNaarBestand"
}
else {
    Write-Host "Bestand bestaat niet. Download wordt uitgevoerd..."
    Invoke-WebRequest -URI "$AUTOUNATTEND_Download_Link/$AUTOUNATTEND_Download_Filename" -OutFile %userprofile%\Downloads\WS22_Autounattend_GitHub.xml
    Write-Host "Download voltooid."
}




#
#
#   #####################
#   PARAMETERS CONVERSIE CMDLET
#   #####################
#
#
Write-Host "Declaratie van parameters voor conversie"
#
$ConvertParams          =   @{
#
SourcePath              =   $TS_WIN_ISO_FOLDER + $TS_WIN_ISO_FILE
#
VHDPath                 =   'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD'
#
SizeBytes               =   90GB
VHDFormat               =   'VHD' 
DiskLayout              =   'UEFI'
UnattendPath            =   $TS_WIN_UNATTEND_FOLDER + $TS_WIN_UNATTEND_FILE
Edition                 =   'Windows Server 2022 Datacenter (Desktop Experience)' 
Passthru                =   $True
BCDinVHD                =   'VirtualMachine'
}
#
#
#   #####################
#   CONVERSIE ISO NAAR VHD
#   #####################
#
#
Write-Host "Conversie Windows Server 2022 DataCenter ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams
#
#
#   #####################
#   THATS ALL FOLKS
#   #####################
#
#