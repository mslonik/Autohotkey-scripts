#SingleInstance force
#Persistent
#NoEnv
SetTitleMatchMode 2
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Relative

OnMessage(0x200, "WM_MOUSEMOVE")
OnMessage(0x201, "WM_LBUTTONDOWN")
OnMessage(0x202, "WM_LBUTTONUP")

btnW = 100	; button width
btnH = 030	; button height
flag := false
NonMovableCtrl := "ButDmy"	; this button can't be moved

Gui, Add, Button, 	x160 y196 w%btnW% h%btnH% vButDmy   gBtn, FixedButton
Gui, Add, Button, 	x020 y016 w%btnW% h%btnH% vBtn1 	gBtn, MovableButton1
Gui, Add, Button, 	x020 y056 w%btnW% h%btnH% vBtn2 	gBtn, MovableButton2
Gui, Add, Button, 	x020 y096 w%btnW% h%btnH% vBtn3 	gBtn, MovableButton3
Gui, Add, GroupBox, x020 y010 w400 h400 vGrpb hwndGrpHWND cBlack
Gui, Show, 			w440 h450,Movable Buttons
ControlGetPos, wx, wy, ww, wh,, ahk_id %GrpHWND%
wx +=10
wy +=30
ww +=20
wh +=10
return

Btn:	
return

GuiEscape:
GuiClose:
	ExitApp
return

;----------------------------------------------------------------------------------***
; 
;----------------------------------------------------------------------------------***
WM_LBUTTONUP() {
    global flag, NonMovableCtrl
	If A_GuiControl contains %NonMovableCtrl%
		return			
	if A_Gui 
		flag := false		
}
;----------------------------------------------------------------------------------***
; 
;----------------------------------------------------------------------------------***
WM_LBUTTONDOWN() {
	global flag, NonMovableCtrl, deltaX, deltaY
	If A_GuiControl contains %NonMovableCtrl%
		return			
	if A_Gui
	{        
		MouseGetPos		, mouDWNx, mouDWNy
		GuiControlGet	, btnDWN, Pos, %A_GuiControl%
		deltaX := mouDWNx-btnDWNx
		deltaY := mouDWNy-btnDWNy
		flag := true
	}
}
;----------------------------------------------------------------------------------***
; 
;----------------------------------------------------------------------------------***
WM_MOUSEMOVE(wParam,lParam, msg) {	
	global flag, NonMovableCtrl, wx, wy, ww, wh, deltaX, deltaY
	MouseGetPos, mx, my
	GuiControlGet, cn, Pos, %A_GuiControl%

	hCursM:=DllCall("LoadCursor","UInt",0,"Int",32646)
	hCursX:=DllCall("LoadCursor","UInt",0,"Int",32648)	

	
    if (msg = 0x200) {
        MouseGetPos,,,id,control
		GuiControlGet, ctrlName,Name, %control%
		If instr(ctrlName, "Btn")
			DllCall("SetCursor","UInt",hCursM)
		If instr(ctrlName, "ButDmy")
			DllCall("SetCursor","UInt",hCursX)
    }	
	If A_GuiControl contains %NonMovableCtrl%
		return		
	if ( flag ) {        
		mx -= deltaX ; this do the work !
		my -= deltaY ; this do the work !
		mx := mx+cnw > ww ? ww-cnw : mx
		mx := mx <= 20    ? 20     : mx
		my := my+cnh > wh ? wh-cnh : my
		my := my <= 16    ? 16     : my
		GuiControl, Move, %A_GuiControl%, x%mx% y%my% w%cnw% h%cnh%		
	}
}