#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance force

title := "Coloured Folders - Installer"

Install() {
  install_directory := EnvGet("LocalAppData") . "\ABS\ColouredFolders"

  progress := Gui("-MinimizeBox", title)
  progress.Add("Progress", "w200 h20 c249000 vBar", 10)
  progress.Show()

  if (DirExist(install_directory)) {
    answer := MsgBox("The program is already installed. Do you want to update it?", title, "YesNo Icon? Default2")
    if (answer == "Yes") {
      DirDelete install_directory, true
      progress["Bar"].Value += 10
    } else {
      ExitApp
    }
  }
  DirCreate install_directory
  SetWorkingDir install_directory
  progress["Bar"].Value += 10

  FileInstall "icons.icl", "icons.icl", 1
  progress["Bar"].Value += 10
  FileInstall "colours.txt", "colours.txt", 1
  progress["Bar"].Value += 10
  FileInstall "IconPick.exe", "IconPick.exe", 1
  progress["Bar"].Value += 10
  FileInstall "UninstallColouredFolders.exe", "UninstallColouredFolders.exe", 1
  progress["Bar"].Value += 10

  registry_directory_root := "HKEY_CURRENT_USER\Software\Classes\Directory"
  registry_main_key := "\shell\ColouredFolders"
  normal_entry := registry_directory_root . registry_main_key
  background_entry := registry_directory_root . "\background" . registry_main_key

  for entry in [normal_entry, background_entry] {
    RegWrite "Pick colour", "REG_SZ", entry
    icon := install_directory . "\icons.icl,2"
    RegWrite icon, "REG_EXPAND_SZ", entry, "icon"
    command := install_directory . '\IconPick.exe "%1"'
    RegWrite command, "REG_EXPAND_SZ", entry . "\command"
    progress["Bar"].Value += 10
  }

  start_menu_directory := A_Programs . "\Coloured Folders"
  DirCreate(start_menu_directory)
  FileCreateShortcut install_directory . "\UninstallColouredFolders.exe"
    , start_menu_directory . "\Uninstall Coloured Folders.lnk", ,
    , "Uninstall Coloured Folders", install_directory . "\icons.icl", , 3
  progress["Bar"].Value += 10

  progress.Hide()
  MsgBox("Installation complete.", title, "OK Iconi")
  ExitApp
}

if (Integer(StrSplit(A_OSVersion, ".")[1]) < 10) {
  MsgBox("This program can only be installed on Windows 10 or higher.", title, "OK Iconx")
  ExitApp
}

response := MsgBox("Would you like to install the Coloured Folders Shell Extension?", title, "YesNo Icon?")
if (response == "Yes") {
  Install()
}