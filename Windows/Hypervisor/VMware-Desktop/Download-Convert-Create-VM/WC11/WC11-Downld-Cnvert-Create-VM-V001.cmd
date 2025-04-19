::
::	Windows Client 11 VirtualMachine 
::	Download ISO
::	Convert ISO to VHD
::	Convert VHD to VMDK
::	Create VM VMWare Workstation PRO with VMDK
::	Script
::
::	Version 1
::	4 April 2025
::
::


::	Stap 1
::	Installatie ISO naar VHD module in Powershell
::
::	Stap 1A
::	Installeren



::	Stap 1B
::	Vervangen XML bestand Powershell module door versie van eigen GitHub








::	Stap 2
::	Downloaden noodzakelijk bestanden voor dit Script in de Downloads folder/map van de gebruiker
::
::	Stap 2A
::	Downloaden Windows ISO met Windows 11 Education 24H2
::
::	Windows 11 Education 24H2
::
::	Werkende download link voor Win11_24H2_English_x64.iso
::
::	[1] Microsoft  [Access Denied]
::	https://software.download.prss.microsoft.com/dbazure/Win11_24H2_English_x64.iso?t=d0dfa50f-8cc2-49cf-867f-f1b44c253fe1&P1=1743858623&P2=601&P3=2&P4=0KfsLSZ7rZdZ5vjog8ntyU9zf1vjGCcjSobJudfoSKjFW1RN0KlpTGXF3qj5TSZDF5PCrG2fFDsz5ZXd7WuwqIzckyz5FAeorse%2fhigL46SSNNrnNPr3tKt2CyD9zuiSFFS2seAdLFp3pnWoyaAzmlEQYtrRgiDEw8GHGZ1MfP%2fiQbPE3pIbEDuYzGlIsAusMo3G3IeNqQ3t2QzmuCLnf0Lhe%2bvM3p1hLQC%2bGv%2fkfQPlVgPDzlZwRpDXkvVuSKw0oETRuvXr5FHWEyyQa2pw%2bee%2bxujNhu382w0TVlOtmCzYX%2b%2bz94ZiDMbX%2brfFimcmT8NxrKfCWrQNw0vhV6UFQg%3d%3d
::
::
::	[1] Accuris Technologies Public CDN [Zurich]
::
::	https://cdn.as212934.net/windows/Win10_22H2_English_x64v1.iso                   https://edu.nl/kmbph
::
::	https://cdn.as212934.net/windows/Win11_23H2_English_x64v2.iso                   https://edu.nl/tu96r
::
::
::	[2]	DigitalHemi
:: 	https://digitalhemi.com/files/ISO/Windows/Win11_24H2_English_x64.iso
:: 	https://digitalhemi.com/files/ISO/Windows/old/Win11_23H2_English_x64v2.iso
:: 
::	[3]	MeetBSD
:: 	https://contents.meetbsd.ir/iso-img/Windows/Win11_24H2_English_x64.iso
::
::	[4]	Neatoware
::	https://downloads.neatoware.com/iso/Win11_24H2_English_x64.iso
::
::	[5]	JordanLindsay
::	https://cdn.jordanlindsay.com.au/ISOs/Win11_24H2_English_x64.iso
::
::	[6]	UCF.EDU
::	https://www.cs.ucf.edu/~czou/temp/Win11_24H2_English_x64.iso
::
::	[7]	UKRNet (UK)
::	https://files.ukrnet.co.uk/Installers/Windows%20ISOs/11%2024H2/Win11_24H2_English_x64.iso
::
::	[8]	SPDNS
::	http://jerryching.spdns.de/Software/ISO%20Backup/Windows%2011/Win11_24H2_English_x64.iso
::
::
::	Niet werkende download link 
::
::	https://drive.massgrave.dev/en-us_windows_11_business_editions_version_24h2_x64_dvd_59a1851e.iso
::	Foutnmelding 403 Access Denied
::	@powershell Invoke-WebRequest -URI https://drive.massgrave.dev/en-us_windows_11_business_editions_version_24h2_x64_dvd_59a1851e.iso -OutFile %userprofile%\Downloads\en-us_windows_11_business_editions_version_24h2_x64_dvd_59a1851e.iso
::
::
@powershell Invoke-WebRequest -URI -OutFile %userprofile%\Downloads\
::
::
::	Stap 1B
::	Downloaden AutoUnattend.xml
::
@powershell Invoke-WebRequest -URI https://raw.githubusercontent.com/jatutert/demos/refs/heads/main/Windows/Guest/Windows/11/AutoUnattend/GitHub-Ruzickap/Autounattend_V005.xml -OutFile %userprofile%\Downloads\Autounattend_V005.xml
::
::	Stap 2
::	Aanmaken VHD bestand vanuit ISO bestand 
::
@powershell 
::
