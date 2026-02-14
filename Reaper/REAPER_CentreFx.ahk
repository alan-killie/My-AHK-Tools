; Centre all FX Windows in Reaper

Loop
{
    GroupAdd, fxWin, ahk_class REAPERb32host
    GroupAdd, fxWin, FX: Track
    GroupAdd, fxWin, VST
    GroupAdd, fxWin, VSTi:
    GroupAdd, fxWin, VST3i:
    GroupAdd, fxWin,, ReaSamplOmatic5000
    GroupAdd, fxWin, JS:
    GroupAdd, fxWin, BYPASSED
    GroupAdd, fxWin, Add FX to:
    GroupAdd, fxWin, CLAP:
    GroupAdd, fxWin, CLAPi:
    GroupAdd, fxWin, (x86 bridged)
    WinWait, ahk_group fxWin, , , 2
    if ErrorLevel = 0

{
	WinGetPos, xpos, ypos, width, height, ahk_group fxWin
	WinMove, ahk_group fxWin,, % (A_ScreenWidth/2)-(width/2), % (A_ScreenHeight/2)-(height/2), %width%, %height%
	WinWaitClose, ahk_group fxWin
}
}
return

#z::
WinGetPos, xpos, ypos, width, height, ahk_group fxWin
WinMove, ahk_group fxWin,, % (A_ScreenWidth/2)-(width/2), % (A_ScreenHeight/2)-(height/2), %width%, %height%

;Menu, Tray, Add, EnableCentreFx, EnableCentreFx
;Menu, Tray, Add, DisableCentreFx, DisableCentreFx
;Menu, Tray, Check, EnableCentreFx
;Menu, Tray, Default, DisableCentreFx

;EnableCentreFx:
;Menu, Tray, Check, EnableCentreFx
;Menu, Tray, Uncheck, DisableCentreFx

;DisableCentreFx:
;Menu, Tray, Check, DisableCentreFx
;Menu, Tray, Uncheck, EnableCentreFx
;return
