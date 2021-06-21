#ps1_sysnative
# -----------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# -----------------------------------------------------------------------------
# Name.......: bootstrap_win_host.template.ps1
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.21
# Revision...: 
# Purpose....: Script to bootstrap the windows server/client
# Notes......:  
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# -----------------------------------------------------------------------------
# todo:
# - Config LDAP
# - Config SQL Developer 
# - Config Putty for user Oracle

# - Customization -------------------------------------------------------------
$PlainPassword      =   "${def_password}"
$LabName            =   "${resource_name}"
$LabNameLower       =   $LabName.ToLower()
$LabURL             =   "${lab_source_url}"
$LabDomain          =   "${tvd_domain}"
$SQLDeveloperURL    =   "https://objectstorage.eu-zurich-1.oraclecloud.com/p/84TYwWCySSoJqc3nrsvTGdVlxNe0iiALIsA-F5qIzmPCek35BxARb7gikujPZndf/n/trivadisbdsxsp/b/orarepo/o/sqldeveloper-20.4.1.407.0006-x64.zip"
# - End of Customization ------------------------------------------------------
$SecurePassword =   ConvertTo-SecureString -AsPlainText $PlainPassword -Force

# Set the Administrator Password and activate the Domain Admin Account
net user Administrator $PlainPassword /logonpasswordchg:no /active:yes

# Create new Oracle User
New-LocalUser "Oracle" -Password $SecurePassword -FullName "Oracle" -Description "Oracle default User."
Add-LocalGroupMember -Group "Administrators" -Member "Oracle"

# install chocolatey
Write-Host '- Install chocolatey ---------------------------------------'
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# - Install tools --------------------------------------------------
Write-Host '- Installing putty, winscp and other tools -----------------'
choco install --yes --no-progress --limitoutput winscp putty putty.install mobaxterm
# Config Desktop shortcut
$TargetFile     = "$env:Programfiles\PuTTY\putty.exe"
$ShortcutFile   = "$env:Public\Desktop\putty.lnk"
$WScriptShell   = New-Object -ComObject WScript.Shell
$Shortcut       = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

choco install --yes --no-progress --limitoutput totalcommander
# Config Desktop shortcut
$TargetFile     = "$env:Programfiles\totalcmd\totalcmd.exe"
$ShortcutFile   = "$env:Public\Desktop\Total Commander.lnk"
$WScriptShell   = New-Object -ComObject WScript.Shell
$Shortcut       = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()
# Development
Write-Host '- Installing DEV tools -------------------------------------'
choco install --yes --no-progress --limitoutput git github-desktop vscode

# Google chrome
Write-Host '- Installing Browsers --------------------------------------'
choco install --yes --no-progress --limitoutput googlechrome --ignore-checksums
choco install --yes --no-progress --limitoutput Firefox

# LDAP Utilities
Write-Host '- Installing LDAP utilities --------------------------------'
choco install --yes --no-progress --limitoutput softerraldapbrowser ldapadmin ldapexplorer

# - Install tools --------------------------------------------------
Write-Host '- Installing jdk8 -----------------'
choco install --yes --no-progress --limitoutput jdk8

Write-Host '- Installing putty, winscp and other tools -----------------'
choco install --yes --no-progress --limitoutput winscp putty putty.install mobaxterm

# Checkout Training
New-Item -ItemType Directory -Force -Path "C:\u00\app\oracle\local"
Invoke-WebRequest -Uri $LabURL -OutFile "C:\u00\app\oracle\local\$LabName.zip"
Expand-Archive -LiteralPath "C:\u00\app\oracle\local\$LabName.zip" `
    -DestinationPath "C:\u00\app\oracle\local\$LabNameLower"
Remove-Item "C:\u00\app\oracle\local\$LabName.zip"
Remove-Item "C:\u00\app\oracle\local\$LabNameLower\.gitignore"

$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:Public\Desktop\$LabName.lnk")
$Shortcut.TargetPath    = "C:\u00\app\oracle\local\$LabNameLower"
$Shortcut.Save()

# Config Putty Pagant autostart
$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup" + "\pagent.lnk")
$Shortcut.TargetPath    = "$env:Programfiles\PuTTY\pageant.exe"
$Shortcut.Arguments     = "C:\u00\app\oracle\local\$LabNameLower\etc\id_rsa_$LabNameLower.ppk"
$Shortcut.Save()

# Config WinSCP 
Remove-Item "$env:Public\Desktop\WinSCP.lnk"
$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:Public\Desktop\WinSCP.lnk")
$Shortcut.TargetPath    = "C:\Program Files (x86)\WinSCP\WinSCP.exe"
$Shortcut.Arguments     = "/ini=C:\u00\app\oracle\local\$LabNameLower\oci\etc\$LabNameLower_WinSCP.ini"
$Shortcut.Save()

# Oracle Utilities
Write-Host '- Installing Oracle utilities --------------------------------'
New-Item -ItemType Directory -Force -Path "C:\stage"
Invoke-WebRequest -Uri $SQLDeveloperURL -OutFile "c:\stage\sqldeveloper.zip"
Expand-Archive -LiteralPath "c:\stage\sqldeveloper.zip" -DestinationPath "$env:Programfiles"

# Config Desktop shortcut
$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:Public\Desktop\SQL Developer.lnk")
$Shortcut.TargetPath    = "$env:Programfiles\sqldeveloper\sqldeveloper.exe"
$Shortcut.Save()

$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:Public\Desktop\Config $LabName.lnk")
$Shortcut.TargetPath    = "powershell.exe"
$Shortcut.Arguments     = "-ExecutionPolicy Bypass -File C:\u00\app\oracle\local\$LabNameLower\oci\host_win\cloudinit\config_win_env.ps1"
$Shortcut.Save()

# SwingBench
Write-Host '- Installing SwingBench --------------------------------'
New-Item -ItemType Directory -Force -Path "C:\stage"
Invoke-WebRequest -Uri "https://github.com/domgiles/swingbench-public/releases/download/production/swingbenchlatest.zip" -OutFile "c:\stage\swingbenchlatest.zip"
Expand-Archive -LiteralPath "c:\stage\swingbenchlatest.zip" -DestinationPath "$env:Programfiles"

# Config SwingBench 
$WScriptShell           = New-Object -ComObject WScript.Shell
$Shortcut               = $WScriptShell.CreateShortcut("$env:Public\Desktop\SwingBench.lnk")
$Shortcut.TargetPath    = "$env:Programfiles\swingbench\winbin\swingbench.bat"
$Shortcut.WorkingDirectory = "$env:Programfiles\swingbench\winbin"
$Shortcut.Save()

# add host file entries
Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value "10.0.1.50`twin.$LabDomain`twin" -Force
Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value "10.0.1.10`toem1.$LabDomain`toem1" -Force
Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value "10.0.1.11`toem2.$LabDomain`toem2" -Force

# define a runOnce command
$UserName   = "Oracle"
$credential = New-Object System.Management.Automation.PSCredential $UserName, $securePassword
Start-Process Powershell.exe -Credential  $credential `
    -ArgumentList "-noprofile -file C:\u00\app\oracle\local\$LabNameLower\oci\host_win\cloudinit\config_win_env.ps1"

# Windows Update
Write-Host '- Installing Windows Update ----------------------------------'
Install-PackageProvider -Name NuGet  -force
Install-Module PSWindowsUpdate -force
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
# --- EOF ----------------------------------------------------------------------