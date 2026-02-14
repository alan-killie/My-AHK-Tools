#Requires AutoHotkey v2.0

/*
@Script: FastScroll.ahk
@Description: Multiplies scroll speed by 10x whenever Scroll Lock is ON.
*/

#HotIf GetKeyState("ScrollLock", "T") ; Only activate these hotkeys if Scroll Lock is toggled ON

~WheelUp:: {
    Loop 10
        Send("{WheelUp}")
}

~WheelDown:: {
    Loop 10
        Send("{WheelDown}")
}

#HotIf ; Reset hotkey criteria
