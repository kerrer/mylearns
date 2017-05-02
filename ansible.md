
windows-powershell:
========================================================================
ansible windows -m win_command -a 'CMD /C "MOVE /Y C:\teststuff\myfile.conf C:\builds\smtp.conf"' -vvv 
ansible windows -m win_command -a 'Powershell.exe "Move-Item d:\kibana.yml d:\kibana2.yml"' -vvv
ansible windows -m win_command -a 'ipconfig' -vvv 
ansible windows -m win_shell -a 'Get-ChildItem d:' -vvv
ansible windows -m script -a “foo.ps1 --argument --other-argument”

install cholo


Get-WmiObject -Class Win32_Product.
