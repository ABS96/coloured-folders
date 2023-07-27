# Coloured Folders Shell Extension

Colourise Windows 10 folders from the context menu

![Screenshot of the program](screenshot.png)

## Requirements

To run the program, you will need Windows 10.

To compile the program, [AutoHotkey](https://autohotkey.com) v2.0
or higher and a recent release of
[Ahk2Exe](https://github.com/AutoHotkey/Ahk2Exe) should be installed
and added to your `PATH`.

## Usage

### Running

1. Download the latest release from the [releases page](https://github.com/ABS96/coloured-folders/releases).
2. Run `Installer.exe`.

### Compiling

#### Using the script

1. Run `compile.ps1` in PowerShell.
2. The program can be installed using the generated `Installer.exe`.

#### Manually

1. Open Ahk2Exe.
2. Browse for the AutoHotkey executable in 'Options/Base File'.
3. Select `icon.ico` as the Custom Icon.
4. Select `IconPick.ahk` as the Source.
5. Click on 'Convert'.
6. Repeat steps 4-5 for `UninstallColouredFolders.ahk` and `Installer.ahk`
7. The program can be installed using the generated `Installer.exe`.

## Notes

It takes a little time for the system to recognise that the icon has changed.

If the uninstaller does not remove the probram completely, delete the
following folders manually:

- `%LocalAppData%\ABS\ColouredFolders`
- `%AppData%\Microsoft\Windows\Start Menu\Programs\Coloured Folders`

The compiler script does not currently work when AutoHotkey is installed
using a package manager (such as Scoop).
