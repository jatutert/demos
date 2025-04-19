:: Echo Hardware Productkey
:: wmic path softwarelicensingservice get OA3xOriginalProductKey
::
@echo off
@cls
::
:: Laat zien of Hyper-ConvertImage aanwezig is
@Powershell Get-Module -ListAvailable -Name Hyper-ConvertImage
::
@Powershell -file .\PS-ConvertImage-WC11-Edu-Insider-V12.ps1