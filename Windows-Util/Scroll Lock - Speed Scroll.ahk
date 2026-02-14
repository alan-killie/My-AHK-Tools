#Persistent
SetTimer, CheckScrollLock, 100
return

CheckScrollLock:
    ScrollLockState := GetKeyState("ScrollLock", "T")
    if (ScrollLockState) {
        Hotkey, ~WheelUp, FastScrollUp, On
        Hotkey, ~WheelDown, FastScrollDown, On
    } else {
        Hotkey, ~WheelUp, FastScrollUp, Off
        Hotkey, ~WheelDown, FastScrollDown, Off
    }
return

FastScrollUp:
    Loop, 10  ; Scroll up x times per wheel tick
        Send {WheelUp}
return

FastScrollDown:
    Loop, 10  ; Scroll down x times per wheel tick
        Send {WheelDown}
return

