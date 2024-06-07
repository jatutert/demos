::
::	Zie
::	https://www.tenforums.com/tutorials/84331-apply-windows-image-using-dism-instead-clean-install.html
::
dism /Get-ImageInfo /Imagefile:f:\sources\install.wim
dism /Apply-Image /ImageFile:F:\Sources\install.wim /index:4 /ApplyDir:E:\