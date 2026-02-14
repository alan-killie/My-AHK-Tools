/*
@Script: ScrollOverTaskView.ahk
@Description: Switch virtual desktops by scrolling the mousewheel over the Task View button. (Windows 10)
@Features: (via right-click on tray icon)
  - Set number of virtual desktops (load script on desktop 1 and set the current number of virtual desktops)
  - Set custom sound
  - Sound toggle (with visual checkmark)
  - Set current desktop name
  - Name overlay toggle (with visual checkmark)
@Usage: Hover mouse over Task View icon and use Scroll Wheel.
*/

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- CONFIGURATION ---
Global CurrentDesktop := 1
Global MaxDesktops := 4   
Global DesktopNames := Map(1, "WORK", 2, "BROWSER", 3, "YOUTUBE", 4, "OBS")
Global DisplayTime := -1500
Global OverlayEnabled := true
Global SoundEnabled := true
Global SoundPath := "C:\Windows\Media\Windows Navigation Start.wav"

; --- TRAY MENU SETUP ---
Tray := A_TrayMenu
Tray.Delete()
Tray.Add("Set Max Desktops", MenuSetMax)
Tray.Add("Rename Current Desktop", MenuRename)

; Toggles with initial checkmarks
Tray.Add("Toggle Overlay", MenuToggleOverlay)
Tray.Check("Toggle Overlay") 

Tray.Add("Toggle Sound", MenuToggleSound)
Tray.Check("Toggle Sound")

Tray.Add("Select Custom Sound", MenuSelectSound)
Tray.Add() 
Tray.Add("Reload Script", (*) => Reload())
Tray.Add("Exit", (*) => ExitApp())

; Persistent GUI
Global MyGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +Owner")
MyGui.BackColor := "1A1A1A"
MyGui.SetFont("s22 w700 cWhite", "Segoe UI")
Global MyText := MyGui.Add("Text", "Center w400", "INIT")
WinSetTransparent(220, MyGui)

#HotIf MouseOverTaskView()
WheelUp::  UpdateDesktop(1)
WheelDown::UpdateDesktop(-1)
RButton::  ShowSyncMenu()
#HotIf

; --- FUNCTIONS ---

UpdateDesktop(Direction) {
    static LastScroll := 0
    if (A_TickCount - LastScroll < 100)
        return
    
    global CurrentDesktop 
    
    NewDesktop := CurrentDesktop + Direction
    if (NewDesktop > MaxDesktops) {
        CurrentDesktop := 1
        Loop MaxDesktops - 1 {
            SendInput("^#{Left}")
            Sleep(20)
        }
    } else if (NewDesktop < 1) {
        CurrentDesktop := MaxDesktops
        Loop MaxDesktops - 1 {
            SendInput("^#{Right}")
            Sleep(20)
        }
    } else {
        CurrentDesktop := NewDesktop
        SendInput(Direction > 0 ? "^#{Right}" : "^#{Left}")
    }
    
    if (OverlayEnabled) {
        Name := DesktopNames.Has(CurrentDesktop) ? DesktopNames[CurrentDesktop] : "Desktop " CurrentDesktop
        SetTimer(() => ShowIndicator(Name), -150)
    }
    
    if (SoundEnabled && FileExist(SoundPath))
        SoundPlay SoundPath
    
    LastScroll := A_TickCount
}

ShowIndicator(Txt) {
    MyText.Value := Txt
    MonitorGetWorkArea(1, &L, &T, &R, &B)
    MyGui.Show("x" ((R - L) / 2 - 200) " y" (B - 100) " NoActivate")
    SetTimer(() => MyGui.Hide(), DisplayTime)
}

ShowSyncMenu() {
    SyncMenu := Menu()
    Loop MaxDesktops {
        Index := A_Index
        Name := DesktopNames.Has(Index) ? DesktopNames[Index] : "Desktop " Index
        SyncMenu.Add(Name, (ItemName, ItemPos, MyMenu) => SyncHandler(ItemName, ItemPos))
    }
    SyncMenu.Show()
}

SyncHandler(ItemName, ItemPos) {
    global CurrentDesktop := ItemPos
    ShowIndicator(ItemName)
}

; --- TOGGLE LOGIC WITH CHECKMARKS ---

MenuToggleOverlay(ItemName, *) {
    global OverlayEnabled := !OverlayEnabled
    OverlayEnabled ? A_TrayMenu.Check(ItemName) : A_TrayMenu.Uncheck(ItemName)
}

MenuToggleSound(ItemName, *) {
    global SoundEnabled := !SoundEnabled
    SoundEnabled ? A_TrayMenu.Check(ItemName) : A_TrayMenu.Uncheck(ItemName)
}

MenuSelectSound(*) {
    global SoundPath
    SelectedFile := FileSelect(3, "C:\Windows\Media", "Select Sound", "Audio (*.wav; *.mp3)")
    if (SelectedFile != "")
        SoundPath := SelectedFile
}

MenuSetMax(*) {
    global MaxDesktops
    IB := InputBox("Enter total desktops:", "Settings", "w200 h120", MaxDesktops)
    if (IB.Result == "OK" && IsNumber(IB.Value))
        MaxDesktops := Integer(IB.Value)
}

MenuRename(*) {
    global DesktopNames
    CurrentName := DesktopNames.Has(CurrentDesktop) ? DesktopNames[CurrentDesktop] : "Desktop " CurrentDesktop
    IB := InputBox("Enter name for Desktop " CurrentDesktop ":", "Rename", "w250 h120", CurrentName)
    if (IB.Result == "OK")
        DesktopNames[CurrentDesktop] := IB.Value
}

MouseOverTaskView() {
    try {
        MouseGetPos(,,, &hCtrl, 2)
        return ControlGetClassNN(hCtrl) == "TrayButton1"
    }
    return false

}

