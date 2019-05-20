#NoEnv
#NoTrayIcon

Uninstall() {
  FileCopy UninstallColouredFolders.exe, %A_Temp%, 1
  Run *RunAs "%A_Temp%\UninstallColouredFolders.exe"
}

If (A_ScriptDir == A_Temp) {
  programDir = `%localappdata`%\ABS\ColouredFolders
  EnvGet, workingDir, localappdata
  workingDir .= "\ABS\ColouredFolders"
  SetWorkingDir %workingDir%

  ; FileDelete, %workingDir%\*.*
  FileRemoveDir, "%workingDir%", 1
  ; FileDelete, %A_Programs%\Coloured folders\*.*
  FileRemoveDir, "%A_Programs%\Coloured folders", 1

  RegDelete HKEY_CURRENT_USER\Software\Classes\Directory\shell\ColouredFolders
  RegDelete HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\ColouredFolders

  MsgBox,, Coloured folders - Uninstaller, Uninstall complete.
} Else {
  MsgBox 4, Coloured folders - Uninstaller, Would you like to uninstall the Coloured Folders shell extension?
  IfMsgBox Yes
    Uninstall()
}