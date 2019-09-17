; Using Keyboard Numpad as a Mouse -- by deguix
; http://www.autohotkey.com
; This script makes mousing with your keyboard almost as easy
; as using a real mouse (maybe even easier for some tasks).
; It supports up to five mouse buttons and the turning of the
; mouse wheel.  It also features customizable movement speed,
; acceleration, and "axis inversion".

/*
o----------------------------------------------------------------------------------------o
|Using Keyboard Numpad as a Mouse                                                        |
(----------------------------------------------------------------------------------------)
| ver. 1.0 by deguix  / A Script file for AutoHotkey 1.0.22+                             |
|                    --------------------------------------------------------------------|
|                                                                                        |
| This script is an example of use of AutoHotkey. It uses the remapping of numpad keys   |
| of a keyboard to transform it into a mouse. Some features are the acceleration which   |
| enables you to increase the mouse movement when holding a key for a long time, and the |
| rotation which makes the numpad mouse to "turn". I.e. NumpadDown as NumpadUp and       |
| vice-versa. See the list of keys used below:                                           |
|                                                                                        |
|----------------------------------------------------------------------------------------|
| Keys                  | Description                                                    |
|----------------------------------------------------------------------------------------|
| ScrollLock (toggle on)| Activates numpad mouse mode.                                   |
|-----------------------|----------------------------------------------------------------|
| Numpad0               | Left mouse button click.                                       |
| Numpad5               | Middle mouse button click.                                     |
| NumpadDot             | Right mouse button click.                                      |
| NumpadDiv/NumpadMult  | X1/X2 mouse button click. (Win 2k+)                            |
| NumpadSub/NumpadAdd   | Moves up/down the mouse wheel.                                 |
|                       |                                                                |
|-----------------------|----------------------------------------------------------------|
| NumLock (toggled off) | Activates mouse movement mode.                                 |
|-----------------------|----------------------------------------------------------------|
| NumpadEnd/Down/PgDn/  | Mouse movement.                                                |
| /Left/Right/Home/Up/  |                                                                |
| /PgUp                 |                                                                |
|                       |                                                                |
|-----------------------|----------------------------------------------------------------|
| NumLock (toggled on)  | Activates mouse speed adj. mode.                               |
|-----------------------|----------------------------------------------------------------|
| Numpad7/Numpad1       | Inc./dec. acceleration per button press.                       |
| Numpad8/Numpad2       | Inc./dec. initial speed per button press.                      |
| Numpad9/Numpad3       | Inc./dec. maximum speed per button press.                      |
| !Numpad7/^Numpad1     | Inc./dec. wheel acceleration per button press*.                |
| !Numpad8/^Numpad2     | Inc./dec. wheel initial speed per button press*.               |
| !Numpad9/^Numpad3     | Inc./dec. wheel maximum speed per button press*.               |
| Numpad4/Numpad6       | Inc./dec. rotation angle to right in degrees. (i.e. 180° =     |
|                       | = inversed controls).                                          |
|----------------------------------------------------------------------------------------|
| * = These options are affected by the mouse wheel speed    |
| adjusted on Control Panel. If you don't have a mouse with  |
| wheel, the default is 3 +/- lines per option button press. |
o------------------------------------------------------------o
| Change log                                                 |
|------------------------------------------------------------|
| 1.01 by mslonik       | Added saving of config param into  |
|                       | file (NumpadMouse.ini):            |
|                       |    MouseSpeed                      |
|                       |    MouseAccelerationSpeed          |
|                       |    MouseMaxSpeed                   |
|                       |    MouseWheelSpeed                 |
|                       |    MouseWheelAccelerationSpeed     |
|                       |    MouseWheelMaxSpeed              |
|                       |    MouseRotationAngle              |
|                       | Added tooltips for ScrollLock and  |
|                       | NumLock                            |
|------------------------------------------------------------|
| 1.02 by mslonik       | Added menu info about app.         |
|------------------------------------------------------------|
| 1.03 by mslonik       | Added X2 (NumPadMul) to center     |
|                       | cursor within active window area.  |
|                       | Optimized saving of parameters     |
o------------------------------------------------------------o
*/

;START OF CONFIG SECTION

#SingleInstance force
#MaxHotkeysPerInterval 500

; Using the keyboard hook to implement the Numpad hotkeys prevents them from interfering with the generation of ANSI characters such
; as ŕ.  This is because AutoHotkey generates such characters by holding down ALT and sending a series of Numpad keystrokes.
; Hook hotkeys are smart enough to ignore such keystrokes.
#UseHook

Menu, Tray, Icon, ddores.dll, 106 	; this line will turn the H icon into a small keyboard-mouse looking thing

ApplicationName := "NumpadMouse"
Gosub, INIREAD        ; Jumps to the specified label and continues execution until Return is encountered
Gosub, TRAYMENU       ; Jumps to the specified label and continues execution until Return is encountered

;END OF CONFIG SECTION


;This is needed or key presses would faulty send their natural actions. Like NumpadDiv would send sometimes "/" to the screen.       
#InstallKeybdHook

Temp = 0
Temp2 = 0

MouseRotationAnglePart = %MouseRotationAngle%
;Divide by 45ş because MouseMove only supports whole numbers and changing the mouse rotation to a number lesser than 45ş
;could make strange movements.
;For example: 22.5ş when pressing NumpadUp: First it would move upwards until the speed to the side reaches 1.
MouseRotationAnglePart /= 45

MouseCurrentAccelerationSpeed = 0
MouseCurrentSpeed = %MouseSpeed%

MouseWheelCurrentAccelerationSpeed = 0
MouseWheelCurrentSpeed = %MouseSpeed%

SetKeyDelay, -1
SetMouseDelay, -1

Hotkey, *Numpad0, ButtonLeftClick
Hotkey, *NumpadIns, ButtonLeftClickIns
Hotkey, *Numpad5, ButtonMiddleClick
Hotkey, *NumpadClear, ButtonMiddleClickClear
Hotkey, *NumpadDot, ButtonRightClick
Hotkey, *NumpadDel, ButtonRightClickDel
Hotkey, *NumpadDiv, ButtonX1Click
Hotkey, *NumpadMult, ButtonX2Click

Hotkey, *NumpadSub, ButtonWheelUp
Hotkey, *NumpadAdd, ButtonWheelDown

Hotkey, *NumpadUp, ButtonUp
Hotkey, *NumpadDown, ButtonDown
Hotkey, *NumpadLeft, ButtonLeft
Hotkey, *NumpadRight, ButtonRight
Hotkey, *NumpadHome, ButtonUpLeft
Hotkey, *NumpadEnd, ButtonUpRight
Hotkey, *NumpadPgUp, ButtonDownLeft
Hotkey, *NumpadPgDn, ButtonDownRight

Hotkey, Numpad8, ButtonSpeedUp
Hotkey, Numpad2, ButtonSpeedDown
Hotkey, Numpad7, ButtonAccelerationSpeedUp
Hotkey, Numpad1, ButtonAccelerationSpeedDown
Hotkey, Numpad9, ButtonMaxSpeedUp
Hotkey, Numpad3, ButtonMaxSpeedDown

Hotkey, Numpad6, ButtonRotationAngleUp
Hotkey, Numpad4, ButtonRotationAngleDown

Hotkey, !Numpad8, ButtonWheelSpeedUp
Hotkey, !Numpad2, ButtonWheelSpeedDown
Hotkey, !Numpad7, ButtonWheelAccelerationSpeedUp
Hotkey, !Numpad1, ButtonWheelAccelerationSpeedDown
Hotkey, !Numpad9, ButtonWheelMaxSpeedUp
Hotkey, !Numpad3, ButtonWheelMaxSpeedDown

Gosub, ~ScrollLock  ; Initialize based on current ScrollLock state.
return

;Key activation support

~ScrollLock::
; Wait for it to be released because otherwise the hook state gets reset
; while the key is down, which causes the up-event to get suppressed,
; which in turn prevents toggling of the ScrollLock state/light:
KeyWait, ScrollLock
GetKeyState, ScrollLockState, ScrollLock, T
If ScrollLockState = D
{
	ToolTip, NumPadMouse activated
	SetTimer, RemoveToolTip, 1000
	
	Hotkey, *Numpad0, On
	Hotkey, *NumpadIns, On
	Hotkey, *Numpad5, On
	Hotkey, *NumpadDot, On
	Hotkey, *NumpadDel, On
	Hotkey, *NumpadDiv, On
	Hotkey, *NumpadMult, On

	Hotkey, *NumpadSub, On
	Hotkey, *NumpadAdd, On

	Hotkey, *NumpadUp, On
	Hotkey, *NumpadDown, On
	Hotkey, *NumpadLeft, On
	Hotkey, *NumpadRight, On
	Hotkey, *NumpadHome, On
	Hotkey, *NumpadEnd, On
	Hotkey, *NumpadPgUp, On
	Hotkey, *NumpadPgDn, On

	Hotkey, Numpad8, On
	Hotkey, Numpad2, On
	Hotkey, Numpad7, On
	Hotkey, Numpad1, On
	Hotkey, Numpad9, On
	Hotkey, Numpad3, On

	Hotkey, Numpad6, On
	Hotkey, Numpad4, On

	Hotkey, !Numpad8, On
	Hotkey, !Numpad2, On
	Hotkey, !Numpad7, On
	Hotkey, !Numpad1, On
	Hotkey, !Numpad9, On
	Hotkey, !Numpad3, On
}
else
{
	ToolTip, NumPadMouse deactivated
	SetTimer, RemoveToolTip, 1000
	
	Hotkey, *Numpad0, Off
	Hotkey, *NumpadIns, Off
	Hotkey, *Numpad5, Off
	Hotkey, *NumpadDot, Off
	Hotkey, *NumpadDel, Off
	Hotkey, *NumpadDiv, Off
	Hotkey, *NumpadMult, Off

	Hotkey, *NumpadSub, Off
	Hotkey, *NumpadAdd, Off

	Hotkey, *NumpadUp, Off
	Hotkey, *NumpadDown, Off
	Hotkey, *NumpadLeft, Off
	Hotkey, *NumpadRight, Off
	Hotkey, *NumpadHome, Off
	Hotkey, *NumpadEnd, Off
	Hotkey, *NumpadPgUp, Off
	Hotkey, *NumpadPgDn, Off

	Hotkey, Numpad8, Off
	Hotkey, Numpad2, Off
	Hotkey, Numpad7, Off
	Hotkey, Numpad1, Off
	Hotkey, Numpad9, Off
	Hotkey, Numpad3, Off

	Hotkey, Numpad6, Off
	Hotkey, Numpad4, Off

	Hotkey, !Numpad8, Off
	Hotkey, !Numpad2, Off
	Hotkey, !Numpad7, Off
	Hotkey, !Numpad1, Off
	Hotkey, !Numpad9, Off
	Hotkey, !Numpad3, Off
}
return


~NumLock:: ; NumLock key support
KeyWait, NumLock
NumLockState := GetKeyState("NumLock", "T")

;~ GetKeyState, ScrollLockState, ScrollLock, T
if (NumLockState)
{
	ToolTip, NumPadMouse configuration mode ACTIVATED
	SetTimer, RemoveToolTip, 1000
}
else
{
	ToolTip, NumPadMouse configuration mode DEACTIVATED, configuration SAVED
	SetTimer, RemoveToolTip, 1000
	IniWrite, %MouseSpeed%, %ApplicationName%.ini, MouseSpeed, MouseSpeed
	IniWrite, %MouseAccelerationSpeed%, %ApplicationName%.ini, MouseSpeed, MouseAccelerationSpeed
	IniWrite, %MouseMaxSpeed%, %ApplicationName%.ini, MouseSpeed, MouseMaxSpeed
	
	IniWrite, %MouseWheelSpeed%, %ApplicationName%.ini, MouseWheel, MouseWheelSpeed
	IniWrite, %MouseWheelAccelerationSpeed%, %ApplicationName%.ini, MouseWheel, MouseWheelAccelerationSpeed
	IniWrite, %MouseWheelMaxSpeed%, %ApplicationName%.ini, MouseWheel, MouseWheelMaxSpeed

	IniWrite, %MouseRotationAngle%, %ApplicationName%.ini, MouseRotationAngle, MouseRotationAngle
}	

;Mouse click support

ButtonLeftClick:
GetKeyState, already_down_state, LButton
If already_down_state = D
	return
Button2 = Numpad0
ButtonClick = Left
Goto ButtonClickStart
ButtonLeftClickIns:
GetKeyState, already_down_state, LButton
If already_down_state = D
	return
Button2 = NumpadIns
ButtonClick = Left
Goto ButtonClickStart

ButtonMiddleClick:
GetKeyState, already_down_state, MButton
If already_down_state = D
	return
Button2 = Numpad5
ButtonClick = Middle
Goto ButtonClickStart
ButtonMiddleClickClear:
GetKeyState, already_down_state, MButton
If already_down_state = D
	return
Button2 = NumpadClear
ButtonClick = Middle
Goto ButtonClickStart

ButtonRightClick:
GetKeyState, already_down_state, RButton
If already_down_state = D
	return
Button2 = NumpadDot
ButtonClick = Right
Goto ButtonClickStart
ButtonRightClickDel:
GetKeyState, already_down_state, RButton
If already_down_state = D
	return
Button2 = NumpadDel
ButtonClick = Right
Goto ButtonClickStart

ButtonX1Click:
GetKeyState, already_down_state, XButton1
If already_down_state = D
	return
Button2 = NumpadDiv
ButtonClick = X1
Goto ButtonClickStart

ButtonX2Click:
GetKeyState, already_down_state, XButton2
If already_down_state = D
	return
Button2 = NumpadMult
ButtonClick = X2
Goto ButtonClickStart

ButtonClickStart: 
WinGetActiveStats, Title, Width, Height, X, Y
;~ MouseClick, %ButtonClick%,,, 1, 0, D
CoordMode, Mouse, Window
MouseMove, Width/2, Height/2, 0
;~ MsgBox, % "X: " . X " Y: " . Y " Width: " . Width " Height: " . Height " Pos x: " . X + Width/2 " Pos y: " Y + Height/2
SetTimer, ButtonClickEnd, 10
return

ButtonClickEnd:
GetKeyState, kclickstate, %Button2%, P
if kclickstate = D
	return

SetTimer, ButtonClickEnd, Off
;~ MouseClick, %ButtonClick%,,, 1, 0, U
return

;Mouse movement support

ButtonSpeedUp:
	MouseSpeed++
	ToolTip, Mouse speed: %MouseSpeed% pixels
	SetTimer, RemoveToolTip, 1000
	;~ IniWrite, %MouseSpeed%, %ApplicationName%.ini, MouseSpeed, MouseSpeed
return
ButtonSpeedDown:
	if (MouseSpeed > 1) {
		MouseSpeed--
	}
	if (MouseSpeed = 1) {
		ToolTip, Mouse speed: %MouseSpeed% pixel
	} else {
		ToolTip, Mouse speed: %MouseSpeed% pixels
	}
	SetTimer, RemoveToolTip, 1000
return

ButtonAccelerationSpeedUp:
	MouseAccelerationSpeed++
	ToolTip, Mouse acceleration speed: %MouseAccelerationSpeed% pixels
	SetTimer, RemoveToolTip, 1000
return
ButtonAccelerationSpeedDown:
	if (MouseAccelerationSpeed > 1) {
		MouseAccelerationSpeed--
	}
	if (MouseAccelerationSpeed = 1) {
		ToolTip, Mouse acceleration speed: %MouseAccelerationSpeed% pixel
	} else {
		ToolTip, Mouse acceleration speed: %MouseAccelerationSpeed% pixels
	}
	SetTimer, RemoveToolTip, 1000
return

ButtonMaxSpeedUp:
	MouseMaxSpeed++
	ToolTip, Mouse maximum speed: %MouseMaxSpeed% pixels
	SetTimer, RemoveToolTip, 1000
return
ButtonMaxSpeedDown:
	if (MouseMaxSpeed > 1) {
		MouseMaxSpeed--
	}
	if (MouseMaxSpeed = 1) {
		ToolTip, Mouse maximum speed: %MouseMaxSpeed% pixel
	} else {
		ToolTip, Mouse maximum speed: %MouseMaxSpeed% pixels
	}
	SetTimer, RemoveToolTip, 1000
return

ButtonRotationAngleUp:
	MouseRotationAnglePart++
	if (MouseRotationAnglePart >= 8) {
		MouseRotationAnglePart = 0
	}
	MouseRotationAngle = %MouseRotationAnglePart%
	MouseRotationAngle *= 45
	ToolTip, Mouse rotation angle: %MouseRotationAngle%°
	SetTimer, RemoveToolTip, 1000
return
ButtonRotationAngleDown:
	MouseRotationAnglePart--
	if (MouseRotationAnglePart < 0) {
		MouseRotationAnglePart = 7
	}
	MouseRotationAngle = %MouseRotationAnglePart%
	MouseRotationAngle *= 45
	ToolTip, Mouse rotation angle: %MouseRotationAngle%
	SetTimer, RemoveToolTip, 1000
return

ButtonUp:
ButtonDown:
ButtonLeft:
ButtonRight:
ButtonUpLeft:
ButtonUpRight:
ButtonDownLeft:
ButtonDownRight:
If Button <> 0
{
	IfNotInString, A_ThisHotkey, %Button% ; Checks if a variable contains the specified string. Var: A_ThisHotkey. SearchString: %Button%
	{
		MouseCurrentAccelerationSpeed = 0
		MouseCurrentSpeed = %MouseSpeed%
	}
}
StringReplace, Button, A_ThisHotkey, * ; Replaces the specified substring with a new string. OutputVar = Button, The name of the variable in which to store the result of the replacement process. InputVar = A_ThisHotkey, The name of the variable whose contents will be read from. SearchText = * The string to search for.

ButtonAccelerationStart:
If MouseAccelerationSpeed >= 1
{
	If MouseMaxSpeed > %MouseCurrentSpeed%
	{
		Temp = 0.001
		Temp *= %MouseAccelerationSpeed%
		MouseCurrentAccelerationSpeed += %Temp%
		MouseCurrentSpeed += %MouseCurrentAccelerationSpeed%
	}
}

;MouseRotationAngle convertion to speed of button direction
{
	MouseCurrentSpeedToDirection = %MouseRotationAngle%
	MouseCurrentSpeedToDirection /= 90.0
	Temp = %MouseCurrentSpeedToDirection%

	if Temp >= 0
	{
		if Temp < 1
		{
			MouseCurrentSpeedToDirection = 1
			MouseCurrentSpeedToDirection -= %Temp%
			Goto EndMouseCurrentSpeedToDirectionCalculation
		}
	}
	if Temp >= 1
	{
		if Temp < 2
		{
			MouseCurrentSpeedToDirection = 0
			Temp -= 1
			MouseCurrentSpeedToDirection -= %Temp%
			Goto EndMouseCurrentSpeedToDirectionCalculation
		}
	}
	if Temp >= 2
	{
		if Temp < 3
		{
			MouseCurrentSpeedToDirection = -1
			Temp -= 2
			MouseCurrentSpeedToDirection += %Temp%
			Goto EndMouseCurrentSpeedToDirectionCalculation
		}
	}
	if Temp >= 3
	{
		if Temp < 4
		{
			MouseCurrentSpeedToDirection = 0
			Temp -= 3
			MouseCurrentSpeedToDirection += %Temp%
			Goto EndMouseCurrentSpeedToDirectionCalculation
		}
	}
}
EndMouseCurrentSpeedToDirectionCalculation:

;MouseRotationAngle convertion to speed of 90 degrees to right
{
	MouseCurrentSpeedToSide = %MouseRotationAngle%
	MouseCurrentSpeedToSide /= 90.0
	Temp = %MouseCurrentSpeedToSide%
	Transform, Temp, mod, %Temp%, 4

	if Temp >= 0
	{
		if Temp < 1
		{
			MouseCurrentSpeedToSide = 0
			MouseCurrentSpeedToSide += %Temp%
			Goto EndMouseCurrentSpeedToSideCalculation
		}
	}
	if Temp >= 1
	{
		if Temp < 2
		{
			MouseCurrentSpeedToSide = 1
			Temp -= 1
			MouseCurrentSpeedToSide -= %Temp%
			Goto EndMouseCurrentSpeedToSideCalculation
		}
	}
	if Temp >= 2
	{
		if Temp < 3
		{
			MouseCurrentSpeedToSide = 0
			Temp -= 2
			MouseCurrentSpeedToSide -= %Temp%
			Goto EndMouseCurrentSpeedToSideCalculation
		}
	}
	if Temp >= 3
	{
		if Temp < 4
		{
			MouseCurrentSpeedToSide = -1
			Temp -= 3
			MouseCurrentSpeedToSide += %Temp%
			Goto EndMouseCurrentSpeedToSideCalculation
		}
	}
}
EndMouseCurrentSpeedToSideCalculation:

MouseCurrentSpeedToDirection *= %MouseCurrentSpeed%
MouseCurrentSpeedToSide *= %MouseCurrentSpeed%

Temp = %MouseRotationAnglePart%
Transform, Temp, Mod, %Temp%, 2

If Button = NumpadUp
{
	if Temp = 1
	{
		MouseCurrentSpeedToSide *= 2
		MouseCurrentSpeedToDirection *= 2
	}

	MouseCurrentSpeedToDirection *= -1
	MouseMove, %MouseCurrentSpeedToSide%, %MouseCurrentSpeedToDirection%, 0, R
}
else if Button = NumpadDown
{
	if Temp = 1
	{
		MouseCurrentSpeedToSide *= 2
		MouseCurrentSpeedToDirection *= 2
	}

	MouseCurrentSpeedToSide *= -1
	MouseMove, %MouseCurrentSpeedToSide%, %MouseCurrentSpeedToDirection%, 0, R
}
else if Button = NumpadLeft
{
	if Temp = 1
	{
		MouseCurrentSpeedToSide *= 2
		MouseCurrentSpeedToDirection *= 2
	}

	MouseCurrentSpeedToSide *= -1
	MouseCurrentSpeedToDirection *= -1

	MouseMove, %MouseCurrentSpeedToDirection%, %MouseCurrentSpeedToSide%, 0, R
}
else if Button = NumpadRight
{
	if Temp = 1
	{
		MouseCurrentSpeedToSide *= 2
		MouseCurrentSpeedToDirection *= 2
	}

	MouseMove, %MouseCurrentSpeedToDirection%, %MouseCurrentSpeedToSide%, 0, R
}
else if Button = NumpadHome
{
	Temp = %MouseCurrentSpeedToDirection%
	Temp -= %MouseCurrentSpeedToSide%
	Temp *= -1
	Temp2 = %MouseCurrentSpeedToDirection%
	Temp2 += %MouseCurrentSpeedToSide%
	Temp2 *= -1
	MouseMove, %Temp%, %Temp2%, 0, R
}
else if Button = NumpadPgUp
{
	Temp = %MouseCurrentSpeedToDirection%
	Temp += %MouseCurrentSpeedToSide%
	Temp2 = %MouseCurrentSpeedToDirection%
	Temp2 -= %MouseCurrentSpeedToSide%
	Temp2 *= -1
	MouseMove, %Temp%, %Temp2%, 0, R
}
else if Button = NumpadEnd
{
	Temp = %MouseCurrentSpeedToDirection%
	Temp += %MouseCurrentSpeedToSide%
	Temp *= -1
	Temp2 = %MouseCurrentSpeedToDirection%
	Temp2 -= %MouseCurrentSpeedToSide%
	MouseMove, %Temp%, %Temp2%, 0, R
}
else if Button = NumpadPgDn
{
	Temp = %MouseCurrentSpeedToDirection%
	Temp -= %MouseCurrentSpeedToSide%
	Temp2 *= -1
	Temp2 = %MouseCurrentSpeedToDirection%
	Temp2 += %MouseCurrentSpeedToSide%
	MouseMove, %Temp%, %Temp2%, 0, R
}

SetTimer, ButtonAccelerationEnd, 10
return

ButtonAccelerationEnd:
GetKeyState, kstate, %Button%, P
if kstate = D
	Goto ButtonAccelerationStart

SetTimer, ButtonAccelerationEnd, Off
MouseCurrentAccelerationSpeed = 0
MouseCurrentSpeed = %MouseSpeed%
Button = 0
return

;Mouse wheel movement support

ButtonWheelSpeedUp:
MouseWheelSpeed++
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
MouseWheelSpeedReal = %MouseWheelSpeed%
MouseWheelSpeedReal *= %MouseWheelSpeedMultiplier%
ToolTip, Mouse wheel speed: %MouseWheelSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return
ButtonWheelSpeedDown:
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
If MouseWheelSpeedReal > %MouseWheelSpeedMultiplier%
{
	MouseWheelSpeed--
	MouseWheelSpeedReal = %MouseWheelSpeed%
	MouseWheelSpeedReal *= %MouseWheelSpeedMultiplier%
}
If MouseWheelSpeedReal = 1
	ToolTip, Mouse wheel speed: %MouseWheelSpeedReal% line
else
	ToolTip, Mouse wheel speed: %MouseWheelSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return

ButtonWheelAccelerationSpeedUp:
MouseWheelAccelerationSpeed++
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
MouseWheelAccelerationSpeedReal = %MouseWheelAccelerationSpeed%
MouseWheelAccelerationSpeedReal *= %MouseWheelSpeedMultiplier%
ToolTip, Mouse wheel acceleration speed: %MouseWheelAccelerationSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return
ButtonWheelAccelerationSpeedDown:
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
If MouseWheelAccelerationSpeed > 1
{
	MouseWheelAccelerationSpeed--
	MouseWheelAccelerationSpeedReal = %MouseWheelAccelerationSpeed%
	MouseWheelAccelerationSpeedReal *= %MouseWheelSpeedMultiplier%
}
If MouseWheelAccelerationSpeedReal = 1
	ToolTip, Mouse wheel acceleration speed: %MouseWheelAccelerationSpeedReal% line
else
	ToolTip, Mouse wheel acceleration speed: %MouseWheelAccelerationSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return

ButtonWheelMaxSpeedUp:
MouseWheelMaxSpeed++
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
MouseWheelMaxSpeedReal = %MouseWheelMaxSpeed%
MouseWheelMaxSpeedReal *= %MouseWheelSpeedMultiplier%
ToolTip, Mouse wheel maximum speed: %MouseWheelMaxSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return
ButtonWheelMaxSpeedDown:
RegRead, MouseWheelSpeedMultiplier, HKCU, Control Panel\Desktop, WheelScrollLines
If MouseWheelSpeedMultiplier <= 0
	MouseWheelSpeedMultiplier = 1
If MouseWheelMaxSpeed > 1
{
	MouseWheelMaxSpeed--
	MouseWheelMaxSpeedReal = %MouseWheelMaxSpeed%
	MouseWheelMaxSpeedReal *= %MouseWheelSpeedMultiplier%
}
If MouseWheelMaxSpeedReal = 1
	ToolTip, Mouse wheel maximum speed: %MouseWheelMaxSpeedReal% line
else
	ToolTip, Mouse wheel maximum speed: %MouseWheelMaxSpeedReal% lines
SetTimer, RemoveToolTip, 1000
return

ButtonWheelUp:
ButtonWheelDown:

If Button <> 0
{
	If Button <> %A_ThisHotkey%
	{
		MouseWheelCurrentAccelerationSpeed = 0
		MouseWheelCurrentSpeed = %MouseWheelSpeed%
	}
}
StringReplace, Button, A_ThisHotkey, *

ButtonWheelAccelerationStart:
If MouseWheelAccelerationSpeed >= 1
{
	If MouseWheelMaxSpeed > %MouseWheelCurrentSpeed%
	{
		Temp = 0.001
		Temp *= %MouseWheelAccelerationSpeed%
		MouseWheelCurrentAccelerationSpeed += %Temp%
		MouseWheelCurrentSpeed += %MouseWheelCurrentAccelerationSpeed%
	}
}

If Button = NumpadSub
	MouseClick, WheelUp,,, %MouseWheelCurrentSpeed%, 0, D
else if Button = NumpadAdd
	MouseClick, WheelDown,,, %MouseWheelCurrentSpeed%, 0, D

SetTimer, ButtonWheelAccelerationEnd, 100
return

ButtonWheelAccelerationEnd:
GetKeyState, kstate, %Button%, P
if kstate = D
	Goto ButtonWheelAccelerationStart

MouseWheelCurrentAccelerationSpeed = 0
MouseWheelCurrentSpeed = %MouseWheelSpeed%
Button = 0
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

;~ ---------------------- Code below added by mslonik -------------------------------------------------

INIREAD:
	IfNotExist, %ApplicationName%.ini ; Checks for the existence of a file or folder
{
  ini=
(
[MouseSpeed]
MouseSpeed = 1
MouseAccelerationSpeed = 1
MouseMaxSpeed = 5

[MouseWheel]
MouseWheelSpeed = 1
MouseWheelAccelerationSpeed = 1
MouseWheelMaxSpeed = 5

[MouseRotationAngle]
MouseRotationAngle = 0
)
  FileAppend, %ini%, %ApplicationName%.ini
  ini=
}

IniRead, MouseSpeed, %ApplicationName%.ini, MouseSpeed, MouseSpeed
IniRead, MouseAccelerationSpeed, %ApplicationName%.ini, MouseSpeed, MouseAccelerationSpeed
IniRead, MouseMaxSpeed, %ApplicationName%.ini, MouseSpeed, MouseMaxSpeed

;Mouse wheel speed is also set on Control Panel. As that
;will affect the normal mouse behavior, the real speed of
;these three below are times the normal mouse wheel speed.
IniRead, MouseWheelSpeed, %ApplicationName%.ini, MouseWheel, MouseWheelSpeed
IniRead, MouseWheelAccelerationSpeed, %ApplicationName%.ini, MouseWheel, MouseWheelAccelerationSpeed
IniRead, MouseWheelMaxSpeed, %ApplicationName%.ini, MouseWheel, MouseWheelMaxSpeed

IniRead, MouseRotationAngle, %ApplicationName%.ini, MouseRotationAngle, MouseRotationAngle
return

TRAYMENU:
Menu, Tray, Add, %ApplicationName% ABOUT, ABOUT
Menu, Tray, Default, %ApplicationName% ABOUT ; Default: Changes the menu's default item to be the specified menu item and makes its font bold.
Menu, Tray, Add ; To add a menu separator line, omit all three parameters. To put your menu items on top of the standard menu items (after adding your own menu items) run Menu, Tray, NoStandard followed by Menu, Tray, Standard.
Menu, Tray, NoStandard
Menu, Tray, Standard
Menu, Tray, Tip, %ApplicationName% ; Changes the tray icon's tooltip.
return

ABOUT:
Gui, MyAbout: Margin,, 0
Gui, MyAbout: Font, Bold
Gui, MyAbout: Add, Text, , %ApplicationName% v.1.02 by deguix and mslonik
Gui, MyAbout: Font

Gui, MyAbout: Add, Text, xm+10, 
(
This script is an example of use of AutoHotkey. It uses the remapping of numpad keys of a keyboard to transform it
into a mouse. Some features are the acceleration which enables you to increase the mouse movement when holding a key
a key for a long time, and the rotation which makes the numpad mouse to "turn". I.e. NumpadDown as NumpadUp
and vice-versa. See the list of keys used below:
)

Gui, MyAbout: Font, s10, Courier New
Gui, MyAbout: Add, Text, xm+10, 
(
o--------------------------------------------------------------------------o
| Keys                  | Description                                      |
|--------------------------------------------------------------------------|
| ScrollLock (toggle on)| Activates numpad mouse mode.                     |
|-----------------------|--------------------------------------------------|
| Numpad0               | Left mouse button click.                         |
| Numpad5               | Middle mouse button click.                       |
| NumpadDot             | Right mouse button click.                        |
| NumpadDiv/NumpadMult  | X1/X2 mouse button click. (Win 2k+)              |
| NumpadSub/NumpadAdd   | Moves up/down the mouse wheel.                   |
|                       |                                                  |
|-----------------------|--------------------------------------------------|
| NumLock (toggled off) | Activates mouse movement mode.                   |
|-----------------------|--------------------------------------------------|
| NumpadEnd/Down/PgDn/  | Mouse movement.                                  |
| /Left/Right/Home/Up/  |                                                  |
| /PgUp                 |                                                  |
|                       |                                                  |
|-----------------------|--------------------------------------------------|
| NumLock (toggled on)  | Activates mouse speed adj. mode.                 |
|-----------------------|--------------------------------------------------|
| Numpad7/Numpad1       | Inc./dec. acceleration per button press.         |
| Numpad8/Numpad2       | Inc./dec. initial speed per button press.        |
| Numpad9/Numpad3       | Inc./dec. maximum speed per button press.        |
| !Numpad7/^Numpad1     | Inc./dec. wheel acceleration per button press*.  |
| !Numpad8/^Numpad2     | Inc./dec. wheel initial speed per button press*. |
| !Numpad9/^Numpad3     | Inc./dec. wheel maximum speed per button press*. |
| Numpad4/Numpad6       | Inc./dec. rotation angle to right in degrees.    |
|                       | (i.e. 180° = inversed controls).                 |
|--------------------------------------------------------------------------|
| * = These options are affected by the mouse wheel speed adjusted on      |
| Control Panel. If you don't have a mouse with wheel, the default is 3    |
|  +/- lines per option button press.                                      |
o--------------------------------------------------------------------------o
)

Gui, MyAbout: Add, Button, Default Hidden w100 gMyOK Center vOkButtonVariabl hwndOkButtonHandle, &OK
GuiControlGet, MyGuiControlGetVariable, MyAbout: Pos, %OkButtonHandle%
Gui, MyAbout: Show, Center, %ApplicationName% About
WinGetPos, , , MyAboutWindowWidth, , %ApplicationName% About
NewButtonXPosition := (MyAboutWindowWidth / 2) - (MyGuiControlGetVariableW / 2)
GuiControl, Move, %OkButtonHandle%, % "x" NewButtonXPosition
GuiControl, Show, %OkButtonHandle%
return    

MyOK:
MyAboutGuiClose: ; Launched when the window is closed by pressing its X button in the title bar
Gui, MyAbout: Destroy
return
