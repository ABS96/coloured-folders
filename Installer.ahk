#NoEnv
#NoTrayIcon
#SingleInstance force

Install() {
  programDir = `%localappdata`%\ABS\ColouredFolders
  EnvGet, workingDir, localappdata
  workingDir .= "\ABS\ColouredFolders"
  FileCreateDir %workingDir%
  SetWorkingDir %workingDir%

  FileInstall icons.dll, icons.dll, 1
  FileInstall colours.ini, colours.ini, 1
  FileInstall IconPick.exe, IconPick.exe, 1
  FileInstall UninstallColouredFolders.exe, UninstallColouredFolders.exe, 1

  RegWrite REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\ColouredFolders,, Pick colour
  icon = %programDir%\Icons.dll,2
  RegWrite REG_EXPAND_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\ColouredFolders, icon, %icon%
  command = %programDir%\IconPick.exe "`%1"
  RegWrite REG_EXPAND_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\ColouredFolders\command,, %command%

  RegWrite REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\ColouredFolders,, Pick colour
  icon = %programDir%\Icons.dll,2
  RegWrite REG_EXPAND_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\ColouredFolders, icon, %icon%
  command = %programDir%\IconPick.exe "`%w"
  RegWrite REG_EXPAND_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\ColouredFolders\command,, %command%

  FileCreateDir %A_Programs%\Coloured folders
  FileCreateShortcut, %workingDir%\UninstallColouredFolders.exe, %A_Programs%\Coloured folders\Uninstall.lnk,,,Uninstall coloured folders, %workingDir%\icons.dll,, 3

  MsgBox,, Coloured folders - Installer, Installation complete.
}

if (A_OSVersion < 10)
  MsgBox,, Coloured folders - Installer, This program can only be installed on Windows 10 or higher.

MsgBox 4, Coloured folders - Installer, Would you like to install the coloured folders shell extension (v1)?
IfMsgBox Yes
  Install()