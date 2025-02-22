Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-us -OSLicense Retail -ZTI

# go to usb
set-location "D:\"

# copies the deploy folder to the SPAdmin desktop
mkdir "C:\ProgramData\RUDI"
Copy-Item ".\deploy" -Destination "C:\ProgramData\RUDI" -recurse
#Copy-Item ".\deploy\Scripts\FirstLogon.ps1" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
$TargetFile = "powershell.exe"
$ShortcutFile = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\DeanIT_Install.lnk"
$Shortcutargs = "-file C:\ProgramData\RUDI\deploy\Scripts\DeanIT_Install.ps1"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Arguments = $Shortcutargs
$Shortcut.Save()


#Restart from WinPE

Write-Host -ForegroundColor Green “Restarting in 10 seconds!”

Start-Sleep -Seconds 10

wpeutil reboot
