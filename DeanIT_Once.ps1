Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Start-OSDCloud -OSVersion 'Windows 10' -OSBuild 22H2 -OSEdition Pro -OSLanguage en-us -OSLicense Retail -ZTI

# go to usb
set-location "D:\"

# copies the deploy folder to the SPAdmin desktop
mkdir "C:\ProgramData\RUDI"
Copy-Item ".\deploy" -Destination "C:\ProgramData\RUDI" -recurse
Copy-Item ".\deploy\Scripts\FirstLogon.ps1" -Destination "C:\Windows\Setup\Scripts\FirstLogon.ps1"

#Restart from WinPE

Write-Host -ForegroundColor Green “Restarting in 10 seconds!”

Start-Sleep -Seconds 10

wpeutil reboot
