#Requires AutoHotkey v2.0
#NoTrayIcon

title := "Coloured Folders - Uninstaller"

Prepare() {
  response := MsgBox("Would you like to uninstall the Coloured Folders Shell Extension?", title, "YesNo Icon? Default2")
  if (response == "Yes") {
    FileCopy "UninstallColouredFolders.exe", A_Temp, 1
    Run "*RunAs " . A_Temp . "\UninstallColouredFolders.exe"
  }
}

Uninstall() {
  install_directory := EnvGet("LocalAppData") . "\ABS\ColouredFolders"

  progress := Gui("-MinimizeBox", title)
  progress.Add("Progress", "w200 h20 c900000 vBar", 20)
  progress.Show()

  if (!DirExist(install_directory)) {
    MsgBox(
      "Uninstallation failed`nCould not find install directory.",
      title,
      "OK Iconx"
    )
    ExitApp
  } else {
    SetWorkingDir install_directory
    DirDelete install_directory, 1
    progress["Bar"].Value += 20
    DirDelete A_Programs . "\Coloured folders", 1
    progress["Bar"].Value += 20
  }

  registry_directory_root := "HKEY_CURRENT_USER\SOFTWARE\Classes\Directory"
  registry_main_key := "\shell\ColouredFolders"

  for path in ["", "\Background"] {
    for key in ["\command", ""] {
      reg_path := registry_directory_root . path . registry_main_key . key
      RegDeleteKey reg_path
      progress["Bar"].Value += 10
    }
  }

  progress.Hide()
  MsgBox("Uninstallation complete.", title, "OK Iconi")
  ExitApp
}

If (A_ScriptDir == A_Temp) {
  Uninstall()
} Else {
  Prepare()
}