#Persistent
#NoTrayIcon
#NoEnv

If (!A_Args[1]) {
  MsgBox 16, Error, No folder was specified
  ExitApp
}

EnvGet, localAppData, localappdata
SetWorkingDir %localAppData%\ABS\ColouredFolders
; Menu, Tray, Icon, icons.dll, 3

FileReadLine, colour, colours.ini, 1

Gui, New, -MinimizeBox, Pick folder colour

Gui, Add, ListView, W130 H350 gpickerLV vpickerLV, Icon
; height := LV_GetCount() * 17 + 10
GuiControl, +IconSmall, pickerLV
iconList := IL_Create(,,0)
LV_SetImageList(iconList)

colours := ["dark grey", "grey", "white", "red", "brown", "orange", "yellow", "lime", "olive", "green", "mint", "teal", "light blue", "blue", "navy", "space", "race blue", "purple", "pink", "maroon"]
Loop
{
  If (A_Index > colours.Length())
    Break
  IL_Add(iconList, "icons.dll", A_Index)
  LV_Add("Icon" . A_index, colours[A_Index])
}
GuiControl, H%height%, pickerLV

LV_ModifyCol(1, 30)
Gui, Show

pickerLV:
if (A_GuiEvent = "DoubleClick")
{
  iniFolder := A_Args[1]
  iniFile := iniFolder . "\desktop.ini"

  iconIndex := A_EventInfo - 1
  IconResource = %A_WorkingDir%\icons.dll,%iconIndex%
  ; IconFile = %A_WorkingDir%\icons.dll

  FileSetAttrib, -HS, %iniFile% ; make ini file writable
  IniWrite, %IconResource%, %iniFile%, .ShellClassInfo, IconResource
  ; IniWrite, %IconFile%, %iniFile%, .ShellClassInfo, IconFile
  ; IniWrite, %iconIndex%, %iniFile%, .ShellClassInfo, iconIndex%
  FileSetAttrib, +HS, %iniFile%
  FileSetAttrib, +S, %iniFolder%
  ExitApp
}
return

GuiClose:
ExitApp