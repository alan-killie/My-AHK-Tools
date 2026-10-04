#Requires AutoHotkey v2.0
#SingleInstance Force

; Center all FX windows in REAPER.
; This keeps floating plugin windows anchored in the middle of the screen.

CreateFxGroup() {
    GroupAdd("fxWin", "ahk_class REAPERb32host")
    GroupAdd("fxWin", "FX: Track")
    GroupAdd("fxWin", "VST")
    GroupAdd("fxWin", "VSTi:")
    GroupAdd("fxWin", "VST3i:")
    GroupAdd("fxWin", "ReaSamplOmatic5000")
    GroupAdd("fxWin", "JS:")
    GroupAdd("fxWin", "BYPASSED")
    GroupAdd("fxWin", "Add FX to:")
    GroupAdd("fxWin", "CLAP:")
    GroupAdd("fxWin", "CLAPi:")
    GroupAdd("fxWin", "(x86 bridged)")
}

CenterWindow(hwnd) {
    WinGetPos(&xPos, &yPos, &width, &height, "ahk_id " hwnd)
    if (width <= 0 || height <= 0)
        return

    targetX := (A_ScreenWidth // 2) - (width // 2)
    targetY := (A_ScreenHeight // 2) - (height // 2)
    WinMove(targetX, targetY, width, height, "ahk_id " hwnd)
}

CenterFxWindows() {
    hwnds := WinGetList("ahk_group fxWin")
    for hwnd in hwnds {
        if (WinExist("ahk_id " hwnd))
            CenterWindow(hwnd)
    }
}

CreateFxGroup()
SetTimer(CenterFxWindows, 200)

#z:: {
    hwnd := WinExist("ahk_group fxWin")
    if (hwnd)
        CenterWindow(hwnd)
}

; Optional tray menu toggles can be re-enabled here if you want a manual on/off switch.
; Menu := A_TrayMenu
; Menu.Add("Disable Center FX", (*) => ExitApp())
