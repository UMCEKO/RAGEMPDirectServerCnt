#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


directcx = 1036
directcy = 29
connectx = 827
connecty = 370
ipboxx = 465
ipboxy = 371
portboxx = 712
portboxy = 370

; IfWinExist, ahk_exe ragemp_v.exe
; {
;     WinActivate, ahk_exe ragemp_v.exe
;     ControlClick, x%directcx% y, ahk_exe ragemp_v.exe,, LEFT
; }
WinActivate, ahk_pid 32416

isWindowFullScreen( winTitle ) {
	;checks if the specified window is full screen
	
	winID := WinExist( winTitle )

	If ( !winID )
		Return false

	WinGet style, Style, ahk_id %WinID%
	WinGetPos ,,,winW,winH, %winTitle%
	; 0x800000 is WS_BORDER.
	; 0x20000000 is WS_MINIMIZE.
	; no border and not minimized
	Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true
}

KillAllRage(){
    While (True){
        Process, Exist, ragemp_v.exe
        If (Not ErrorLevel){
            Process, Exist, ragemp_ui.exe
            If (Not ErrorLevel){
                Process, Exist, ragemp_game_ui.exe
                If (Not ErrorLevel){
                    Process, Exist, updater.exe
                    If (Not ErrorLevel){
                        Break
                    }
                }
            }
        }
        Run, *RunAs "taskkill" /PID "%ErrorLevel%" /F,,Hide
        Break
    }
}

KillAllRage()
OptCnt:= %0%
If (OptCnt==0)
    RunWait, "%A_ScriptDir%/RAGEMP/updater.exe", %A_ScriptDir%/RAGEMP, Min, Oid
Else
    RunWait, "%1%", E:\RAGEMP, Min, Oid
; WinActivate, ahk_pid %Oid%
ControlClick, x%directcx% y%directcy%, ahk_exe ragemp_v.exe,, LEFT
Sleep, 50
ControlClick, x%ipboxx% y%ipboxy%, ahk_exe ragemp_v.exe,, LEFT
TempClip := Clipboard
Clipboard := "SV1.TURKIYERP.COM"
ControlSend,, {CtrlDown}av{CtrlUp}, ahk_exe ragemp_v.exe
Sleep, 50
ControlClick, x%portboxx% y%portboxy%, ahk_exe ragemp_v.exe,, LEFT
Clipboard := 22005
ControlSend,, {CtrlDown}av{CtrlUp}, ahk_exe ragemp_v.exe
Clipboard := TempClip
Sleep, 50
ControlClick, x%connectx% y%connecty%, ahk_exe ragemp_v.exe,, LEFT
WinWait, ahk_exe GTA5.exe
Sleep, 2000
If (Not WinActive(ahk_exe GTA5.exe)){
    Sleep, 1000
    WinActivate, ahk_exe GTA5.exe
}
If (not isWindowFullScreen(ahk_exe GTA5.exe)) {
    Send, {AltDown}{Enter}{AltUp}
}
WinWaitClose, ahk_exe GTA5.exe
While, True{
    Process, Exist, ragemp_game_ui.exe
    If (ErrorLevel==0){
        Break
    }
    Run, *RunAs "taskkill" /PID "%ErrorLevel%" /F,,Hide
}