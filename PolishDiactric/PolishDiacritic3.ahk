;~              I N T R O D U C T I O N
;~ Simple script for Polisch diacritic marks (https://en.wikipedia.org/wiki/Diacritic): ą, ę, ś, ć, ż, ź, ń, ó, ł.
;~ Instead of usage of AltGr (right alt, see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details):
;~ * double press a key corresponding to specific diacritic key, e.g. ee converts into ę
;~ * AltGr suspend run of this script (switches to default behaviour of keyboard
;~ * special sequence for double letters within words: <letter><letter><letter>, e.g. zaaawansowany converts into zaawansowany
;~ 
;~ WHY:
;~ a. "programmers keyboard" and Polish diactric marks combined with old ANSI keyboards 101 keys (without Windows key and context key) where AltGr is unergonomically shifted to the right side of keyboard,
;~ b. all other "programmers keyboard" when one doesn't want to press AltGr.
;~
;~ Author: Maciej Słojewski, 2019-08-04 
;~
;~ Base for all actions are "Hotstrings".

#SingleInstance,Force ; Determines whether a script is allowed to run again when it is already running. Force: Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.
#Warn
#NoEnv

ApplicationName := "Polish Diactrics 3"
PotentialDiactricOrdinary := ["a", "c", "e", "l", "n", "o", "s", "x", "z"] ; all these letters have corresponding diactric letters; it's important to keep the same order between PotentialDiactric array and Diactric 
PotentialDiactricCapital := ["A", "C", "E", "L", "N", "O", "S", "X", "Z"]
; DiactricOrdinary := ["U+0105", "U+0107", "U+0119", "U+0142", "U+0144", "U+00F3", "U+015B", "U+017A", "U+017C"]
DiactricOrdinary := ["ą", "ć", "ę", "ł", "ń", "ó", "ś", "ź", "ż"]
 ;DiactricCapital := ["{U+0104}", "{U+0106}", "{U+0118}", "{U+0141}", "{U+0143}", "{U+00D3}", "{U+015A}", "{U+0179}", "{U+017B}"]
DiactricCapital := ["Ą", "Ć", "Ę", "Ł", "Ń", "Ó", "Ś", "Ź", "Ż"]
global FlagDiactric := 0
global FlagDoubleLetter := 0
global MyEndKey := "{Enter}{Esc}{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}"
global MyMatchList := ""
global IsShiftPressed := 0
global WhatCapsLockState := ""

for k in PotentialDiactricOrdinary
	{
	if (k == 1)
		{
		MyMatchList := PotentialDiactricOrdinary[1]
		}
	else
		{
		MyMatchList := MyMatchList "," PotentialDiactricOrdinary[k]
		}
	}

Menu, Tray, Icon, imageres.dll, 123     ; this line will turn the H icon into a small red a letter-looking thing.
Gosub, TRAYMENU 					; Jumps to the specified label and continues execution until Return is encountered

; --------------- BEGINNING OF THE MAIN PROGRAMM ----------------------------------------------------------------
F_Hotkey("On")
return

ORDINARY_DIACTRIC:
CurrentKey := A_ThisHotkey
IsShiftPressed := GetKeyState("Shift")
WhatCapsLockState := GetKeyState("CapsLock", "T")
F_Hotkey("Off") ; switch off all hotkeys for the following section of code
FlagDiactric := 0
FlagDoubleLetter := 0

; determine which key was pressed <- cut it down from hotkey string
CurrentHotkeyLength := StrLen(CurrentKey)
if (CurrentHotkeyLength == 2) ; Hotkey without Shift, e.g. ~c
	{
	CurrentKey := SubStr(CurrentKey, 2, 1)	; leave only letter, e.g. c
	}
else if (CurrentHotkeyLength == 3)	; Hotkey with Shift, e.g. ~+c
	{
	CurrentKey := SubStr(CurrentKey, 3, 1) ; leave only letter, e.g. c
	}

Loop ; external loop
	{
	if (FlagDoubleLetter) 
		{
		Break
		}
	Loop ; internal loop
		{
		if (FlagDiactric) 
			{
			Break
			}
		ToolTip, Diactric?, % A_CaretX, % A_CaretY - 20
		Input, NextKey, L1, %MyEndKey%, %MyMatchList%
		if (ErrorLevel = "Max")
			{
			ToolTip,
			Send, % NextKey
			FlagDoubleLetter := 1
			Break
			}
		else if (ErrorLevel = "Match")
			{
			for k in PotentialDiactricOrdinary
			{
			if (NextKey = PotentialDiactricOrdinary[k] AND NextKey = CurrentKey)
				{
				if (IsShiftPressed AND (WhatCapsLockState == 0))
					{
					Send, % "{BackSpace}" DiactricCapital[k]	
					}
				else if (IsShiftPressed AND WhatCapsLockState)
					{
					Send, % "{BackSpace}" DiactricOrdinary[k]
					}
				else if ((IsShiftPressed == 0) AND (WhatCapsLockState == 0))
					{
					Send, % "{BackSpace}" DiactricOrdinary[k]
					}
				else if ((IsShiftPressed == 0) AND WhatCapsLockState)
					{
					Send, % "{BackSpace}" DiactricCapital[k]	
					}
				FlagDiactric := 1
				Break
				}
			else if (NextKey = PotentialDiactricOrdinary[k])
				{
				Send, % NextKey
				CurrentKey := NextKey
				Continue
				}
			}	
		}
		else if (Instr(ErrorLevel, "EndKey:") )
			{
			ColonPosition := InStr(ErrorLevel, ":")	
			ColonPosition++
			MyVariable := SubStr(ErrorLevel, ColonPosition)
			MyVariable := "{" MyVariable "}"
			Send, % MyVariable
			ToolTip,
			FlagDoubleLetter := 1
			Break
			}
	}
	if (FlagDiactric )
	{
	ToolTip, Double?, % A_CaretX, % A_CaretY - 20
	Input, NextKey, L1, %MyEndKey%, %MyMatchList%
	if (ErrorLevel = "Max")
		{
		ToolTip,
		Send, % NextKey
		FlagDoubleLetter := 1
		Break
		}
	else if (ErrorLevel = "Match")
		{
		for k, v in PotentialDiactricOrdinary
			{
			if (NextKey = PotentialDiactricOrdinary[k] AND NextKey = CurrentKey)
				{
				if (IsShiftPressed AND (WhatCapsLockState == 0))
					{
					Send, % "{BackSpace}" PotentialDiactricCapital[k]PotentialDiactricCapital[k]	
					}
				else if (IsShiftPressed AND WhatCapsLockState)
					{
					Send, % "{BackSpace}" PotentialDiactricOrdinary[k]PotentialDiactricOrdinary[k]
					}
				else if ((IsShiftPressed == 0) AND (WhatCapsLockState == 0))
					{
					Send, % "{BackSpace}" PotentialDiactricOrdinary[k]PotentialDiactricOrdinary[k]
					}
				else if ((IsShiftPressed == 0) AND WhatCapsLockState)
					{
					Send, % "{BackSpace}" PotentialDiactricCapital[k]PotentialDiactricCapital[k]
					}
				ToolTip,
				FlagDoubleLetter := 1
				Break
				}
			else if (NextKey = PotentialDiactricOrdinary[k])
				{
				Send, % NextKey
				CurrentKey := NextKey
				FlagDiactric := 0
				Continue
				}
			}	
		}
	else if (Instr(ErrorLevel, "EndKey:") )
		{
		ColonPosition := InStr(ErrorLevel, ":")	
		ColonPosition++
		MyVariable := SubStr(ErrorLevel, ColonPosition)
		MyVariable := "{" MyVariable "}"
		Send, % MyVariable
		ToolTip,
		FlagDoubleLetter := 1
		Break
		}	
	}
}	
F_Hotkey("On")
return


; Pressing of AltGr toggles Suspend mode: disables or enables all or selected hotkeys and hotstrings.
LControl & RAlt:: ; AltGr
	Suspend ; Assign the toggle-suspend function to a hotkey. The built-in variable A_IsSuspended contains 1 if the script is suspended and 0 otherwise.
	if (A_IsSuspended = 0)
		{
		StateOfSuspend = "OFF"
		Diactrics = "ON"
		}
	else if (A_IsSuspended = 1)
		{
		StateOfSuspend = "ON"
		Diactrics = "OFF"
		}    
     MsgBox, 64, AHK: Alt Gr was pressed, AltGr toggles "Suspend" mode of PolishDiactric script. `n Currently mode is %StateOfSuspend%, so Diactrics are %Diactrics%
return
	


F_Hotkey(OnOff) ; Function to switch off or switch on all hotkeys. The hotkeys are dynamically created just for letters corresponding to diactrics
{
global  ; PotentialDiactricOrdinary	
local k, VarTemp

if (OnOff = "On")
	{
	for k in PotentialDiactricOrdinary
		{
		VarTemp := "~+" PotentialDiactricOrdinary[k]	
		Hotkey, %VarTemp%, ORDINARY_DIACTRIC, On
		VarTemp := "~" PotentialDiactricOrdinary[k]
		Hotkey, %VarTemp%, ORDINARY_DIACTRIC, On
		}	
	}
if (OnOff = "Off")
	{
	for k in PotentialDiactricOrdinary
		{
		VarTemp := "~+" PotentialDiactricOrdinary[k]		
		Hotkey, %VarTemp%, ORDINARY_DIACTRIC, Off
		VarTemp := "~" PotentialDiactricOrdinary[k]
		Hotkey, %VarTemp%, ORDINARY_DIACTRIC, Off
		}
	}
}

TRAYMENU:
Menu, Tray, Add, %ApplicationName% ABOUT, ABOUT
Menu, Tray, Default, %ApplicationName% ABOUT ; Default: Changes the menu's default item to be the specified menu item and makes its font bold.
Menu, Tray, Add ; To add a menu separator line, omit all three parameters. To put your menu items on top of the standard menu items (after adding your own menu items) run Menu, Tray, NoStandard followed by Menu, Tray, Standard.
Menu, Tray, NoStandard
Menu, Tray, Standard
Menu, Tray, Tip, %ApplicationName% ; Changes the tray icon's tooltip.
return

ABOUT:
Gui, MyAbout: Font, Bold
Gui, MyAbout: Add, Text, , %ApplicationName% v.1.0 by mslonik
Gui, MyAbout: Font
Gui, MyAbout: Add, Text, xm, Simple script for Polisch diacritic marks (
Gui, MyAbout: Font, CBlue Underline 
Gui, MyAbout: Add, Text, x+1, https://en.wikipedia.org/wiki/Diacritic
Gui, MyAbout: Font
Gui, MyAbout: Add, Text, x+1, ): ą, ę, ś, ć, ż, ź, ń, ó, ł.
Gui, MyAbout: Add, Text, xm, Instead of usage of AltGr (right alt`, see 
Gui, MyAbout: Font, CBlue Underline 
Gui, MyAbout: Add, Text, x+2, https://en.wikipedia.org/wiki/AltGr_key#Polish 
Gui, MyAbout: Font
Gui, MyAbout: Add, Text, x+2, for further details):
Gui, MyAbout: Add, Text, xm+20, * double press a key corresponding to specific diacritic key`, e.g. ee converts into ę
Gui, MyAbout: Add, Text, xm+20, * AltGr suspend run of this script (switches to default behaviour of keyboard
Gui, MyAbout: Add, Text, xm+20, * special sequence for double letters within words: <letter><letter><letter>`, e.g. zaaawansowany converts into zaawansowany

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