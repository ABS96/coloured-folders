$scripts = ('IconPick', 'UninstallColouredFolders', 'Installer')
foreach ($script in $scripts) {
  if (Test-Path -Path "$script.exe") {
    Remove-Item "$script.exe"
  }
}
$ahk = (Get-Command autohotkey.exe).Path
foreach ($script in $scripts) {
  $params = ('/in', "$script.ahk", '/icon', 'icon.ico', '/bin', $ahk)
  Start-Process -Wait -FilePath "ahk2exe" -ArgumentList $params
}
foreach ($script in $scripts[0..1]) {
  if (Test-Path -Path "$script.exe") {
    Remove-Item "$script.exe"
  }
}