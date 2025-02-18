# admin check

param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
if ($elevated)
{
# could not elevate, quit
}
 
else {
 
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}

# admin check end

# go to usb
set-location "X:\"

# copies the deploy folder to the SPAdmin desktop
mkdir "C:\ProgramData\RUDI"
Copy-Item deploy -Destination "C:\ProgramData\RUDI" -recurse

$TargetFile = "powershell.exe -file C:\ProgramData\RUDI\deploy\Scripts\DeanIT_Install.ps1"
$ShortcutFile = "C:\Users\deanit\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\DeanIT_Install.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

#$bytes = [System.IO.File]::ReadAllBytes($ShortcutFile)
#$bytes[0x15] = $bytes[0x15] -bor 0x20
#[System.IO.File]::WriteAllBytes($ShortcutFile, $bytes)

Set-Location "C:\ProgramData\RUDI\deploy"

.\Scripts\DeanIT_Name.ps1