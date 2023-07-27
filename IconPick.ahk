#Requires AutoHotkey v2.0
#NoTrayIcon

If (A_Args.Length < 1) {
  MsgBox("No folder was specified", "Error", "OK Iconx")
  ExitApp
}

ICON_LIBRARY := A_ScriptDir . "\icons.icl"
COLOURS := StrSplit(FileRead(A_ScriptDir . "\colours.txt"), "`n")

handleDoubleClick(control, index) {
  target_folder := A_Args[1]
  desktop_ini := target_folder . "\desktop.ini"
  temp_file := target_folder . "\desktop.ini.tmp"
  icon_index := index - 1
  icon_resource := ICON_LIBRARY . "," . icon_index

  if (FileExist(desktop_ini)) {
    FileSetAttrib("-HS", desktop_ini)
    FileMove desktop_ini, temp_file
  }
  IniWrite icon_resource, temp_file, ".ShellClassInfo", "IconResource"
  FileMove temp_file, desktop_ini ; Necessary for the system to pick up the change
  FileSetAttrib("+HS", desktop_ini)
  FileSetAttrib("+S", target_folder)
  ExitApp
}

TraySetIcon ICON_LIBRARY, 3
picker := Gui("-MinimizeBox", "Pick a colour")
icon_list_view := picker.Add("ListView", "W130 H350")
icon_list_view.Opt("+IconSmall")
icon_list_view.OnEvent("DoubleClick", handleDoubleClick)
image_list := IL_Create()
icon_list_view.SetImageList(image_list)
for colour in COLOURS {
  IL_Add(image_list, ICON_LIBRARY, A_Index)
  icon_list_view.Add("Icon" . A_Index, colour)
}
picker.Show()