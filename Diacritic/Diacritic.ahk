﻿;                 I N T R O D U C T I O N
;~ Simple script used to get diacritic letters (https://en.wikipedia.org/wiki/Diacritic) without usage of AltGr key (right alt, see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details):
;~ * double press a key configured to correspond to diacritic key, e.g. in Polish ee converts into ę
;~ * special sequence for double letters within words: <letter><letter><letter>, e.g. zaaawansowany converts into zaawansowany
;~ * configuration file (.ini) is generated by default,
;~ * optionally sounds and tooltips are generated upon key presses.
;~ 
;~ WHY:
;~ a. "programmers keyboard" layout and diacritic with old ANSI 101 keys keyboard, where AltGr is unergonomically shifted to the right side of keyboard is cumbersome and decrease touch typing speed,
;~ b. all other "programmers keyboard" when one doesn't want to press AltGr or use just one hand to press all letters of alphabet.
;~
;~ Author: Maciej Słojewski, 2020-02-27
;~
;~ Base for all actions are "Hotstrings" generated dynamically (hotstring function).

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!

global AppVersion				:= "1.0.1"
;@Ahk2Exe-Let vAppVersion=%A_PriorLine~U)^(.+"){1}(.+)".*$~$2% ; Keep these lines together
;Overrides the custom EXE icon used for compilation
;@Ahk2Exe-SetCopyright GNU GPL 3.x
;@Ahk2Exe-SetDescription Advanced tool for diacritics management.
;@Ahk2Exe-SetProductName Original script name: %A_ScriptName%
;@Ahk2Exe-Set OriginalScriptlocation, https://github.com/mslonik/Autohotkey-scripts/tree/master/Diacritic
;@Ahk2Exe-SetCompanyName  http://mslonik.pl
;@Ahk2Exe-SetFileVersion %U_vAppVersion%

;~ - - - - - - - - - - Global Variables - - - - - - - - - - -
ApplicationName     := "Diacritic"
English_USA 		:= 0x0409   ; see AutoHotkey help: Language Codes
;~ - - - - - - - - - - End of Global Variables - - - - - - - - - - -

Menu, Tray, Icon, imageres.dll, 123     ; this line will turn the H icon into a small red a letter-looking thing.
Gosub, TRAYMENU                         ; Jumps to the specified label and continues execution until Return is encountered

ProcessInputArgs()
#Hotstring c b0 ? * 

;~ read global variables from .ini file
IniRead, _AmericanLayout,			% A_ScriptDir . "\" . A_Args[1], Global, AmericanLayout
IniRead, _AllTooltips,                  % A_ScriptDir . "\" . A_Args[1], Global, AllTooltips
IniRead, _AllBeeps,                     % A_ScriptDir . "\" . A_Args[1], Global, AllBeeps
IniRead, _DiacriticWord,                % A_ScriptDir . "\" . A_Args[1], Global, DiactricWord
IniRead, _DoubleWord,                   % A_ScriptDir . "\" . A_Args[1], Global, DoubleWord

;~ switch to AmericanLayout (neutral)?
if (_AmericanLayout = "yes")
    SetDefaultKeyboard(English_USA)
if (_AllTooltips = "on")
    F_AllKeyboardKeys()     ; Set dynamic hotkeys for all keys of 60% keyboard, ANSI layout    

;~ determine how many [Diacritic] sections are in .ini file
DiacriticSectionCounter := 0
Loop, Read, % A_ScriptDir . "\" . A_Args[1]
    if (InStr(A_LoopReadLine, "[Diacritic"))
        DiacriticSectionCounter++

;~ read all the rest of configuration parameters from .ini file and create hotstrings

;~ Initialization of parameters
BaseKey        = ""
ShiftBaseKey   = ""
Diacritic      = ""
ShiftDiacritic	= ""
Tooltip        = ""

Loop, %DiacriticSectionCounter%
    {
    IniRead, _BaseKey,                  % A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, BaseKey
    IniRead, _ShiftBaseKey,             % A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, ShiftBaseKey
    if (_ShiftBaseKey = "")
        {
        MsgBox, 16, %ApplicationName%.ahk, % "Warning!`nConfiguration file (" . A_Args[1] . ")`, section: " . A_Index . ", parameter name: ShiftBaseKey is empty. This could cause application malfunction. Application will now exit. Correct the " . A_Args[1] . " file in specified place and try again."
        ExitApp, 0
        }
    IniRead, _Diacritic,                % A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Diacritic
    IniRead, _ShiftDiacritic,           % A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, ShiftDiacritic
    IniRead, _Tooltip,				% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Tooltip
    
    IniRead, _BaseKey_SoundBeep_Freq,	% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, BaseKey_SoundBeep_Freq
    IniRead, _BaseKey_SoundBeep_Dur,   	% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, BaseKey_SoundBeep_Dur
    IniRead, _Diacritic_SoundBeep_Freq,	% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Diacritic_SoundBeep_Freq
    IniRead, _Diacritic_SoundBeep_Dur,  % A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Diacritic_SoundBeep_Dur
    IniRead, _Double_SoundBeep_Freq,   	% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Double_SoundBeep_Freq
    IniRead, _Double_SoundBeep_Dur,    	% A_ScriptDir . "\" . A_Args[1], % "Diacritic" . A_Index, Double_SoundBeep_Dur

    Hotstring(":zx:" . _BaseKey . _BaseKey . _BaseKey,                func("DoubleLetter")	.bind(_BaseKey, 			 _Double_SoundBeep_Freq, 	_Double_SoundBeep_Dur))
    Hotstring(":x:"  . _BaseKey . _BaseKey,                           func("DiacriticLetter")	.bind(_Diacritic, 			 _Diacritic_SoundBeep_Freq, 	_Diacritic_SoundBeep_Dur, _Tooltip))
    Hotstring(":x:"  . _BaseKey,                                      func("SingleLetter")	.bind(_BaseKey_SoundBeep_Freq, _BaseKey_SoundBeep_Dur, 	_Tooltip))

    Hotstring(":zx:" . _ShiftBaseKey . _ShiftBaseKey . _ShiftBaseKey, func("DoubleLetter")	.bind(_ShiftBaseKey, 		 _Double_SoundBeep_Freq, 	_Double_SoundBeep_Dur))
    Hotstring(":x:"  . _ShiftBaseKey . _ShiftBaseKey,                 func("DiacriticLetter")	.bind(_ShiftDiacritic, 		 _Diacritic_SoundBeep_Freq, 	_Diacritic_SoundBeep_Dur, _Tooltip))
    Hotstring(":x:"  . _ShiftBaseKey,                                 func("SingleLetter")	.bind(_BaseKey_SoundBeep_Freq, _BaseKey_SoundBeep_Dur, 	_Tooltip))
}

 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF "STATIC" HOTKEYS - - - - - - - - - - - - - - - - - - - - - - - - - - - 
~LButton::	;this line prevents from triggering backspacec (B0) hotkeys in the same window after left mouse click.
~BackSpace:: ; this line prevents the following sequence from triggering: ao > aoo > aó > aó{Backspace} > a > ao > ó
	Hotstring("Reset")
return


 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - - - - 

DoubleLetter(_BaseKey, _Double_SoundBeep_Freq, _Double_SoundBeep_Dur)
{
	global _AllBeeps
	
	Send, {Raw}`b`b%_BaseKey%%_BaseKey%
	if (_AllBeeps = "on")
		SoundBeep, _Double_SoundBeep_Freq, _Double_SoundBeep_Dur
	Tooltip,
}

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DiacriticLetter(_Diacritic, _Diacritic_SoundBeep_Freq, _Diacritic_SoundBeep_Dur, _Tooltip)
{
	global _AllBeeps, _AllTooltips, _DoubleWord
	
    ;~ MsgBox, % _Diacritic
	Send, {BackSpace 2}%_Diacritic%
	if (_AllBeeps = "on")
		SoundBeep, _Diacritic_SoundBeep_Freq, _Diacritic_SoundBeep_Dur
	if ((_AllTooltips = "on") && (_Tooltip = "on") )
		Tooltip, % _DoubleWord . "?", % A_CaretX,% A_CaretY-20
	else
		Tooltip,
}

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

SingleLetter(_BaseKey_SoundBeep_Freq, _BaseKey_SoundBeep_Dur, _Tooltip)
{
	global _AllBeeps, _AllTooltips, _DiacriticWord
	
	if (_AllBeeps = "on")
		SoundBeep, _BaseKey_SoundBeep_Freq, _BaseKey_SoundBeep_Dur
	if ((_AllTooltips = "on") && (_Tooltip = "on") )
		Tooltip, % _DiacriticWord . "?", % A_CaretX,% A_CaretY-20
	else
		Tooltip,
}

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

F_AllKeyboardKeys()
{
;~ row #1
	Hotkey, ~Esc,       SwitchOffTooltip, On
	Hotkey, ~F1,        SwitchOffTooltip, On
	Hotkey, ~F2,        SwitchOffTooltip, On
	Hotkey, ~F3,        SwitchOffTooltip, On
	Hotkey, ~F4,        SwitchOffTooltip, On
	Hotkey, ~F5,        SwitchOffTooltip, On
	Hotkey, ~F6,        SwitchOffTooltip, On
	Hotkey, ~F7,        SwitchOffTooltip, On
	Hotkey, ~F8,        SwitchOffTooltip, On
	Hotkey, ~F9,        SwitchOffTooltip, On
	Hotkey, ~F10,       SwitchOffTooltip, On
	Hotkey, ~F11,       SwitchOffTooltip, On
	Hotkey, ~F12,       SwitchOffTooltip, On
	
;~ row #2:
	Hotkey, ~``,        SwitchOffTooltip, On
	Hotkey, ~1,         SwitchOffTooltip, On
	Hotkey, ~2,         SwitchOffTooltip, On
	Hotkey, ~3,         SwitchOffTooltip, On
	Hotkey, ~4,         SwitchOffTooltip, On
	Hotkey, ~5,         SwitchOffTooltip, On
	Hotkey, ~6,         SwitchOffTooltip, On
	Hotkey, ~7,         SwitchOffTooltip, On
	Hotkey, ~8,         SwitchOffTooltip, On
	Hotkey, ~9,         SwitchOffTooltip, On
	Hotkey, ~0,         SwitchOffTooltip, On
	Hotkey, ~-,         SwitchOffTooltip, On
	Hotkey, ~=,         SwitchOffTooltip, On
	Hotkey, ~BS,        SwitchOffTooltip, On
	
;~ row #3
	Hotkey, ~Tab,       SwitchOffTooltip, On
	Hotkey, ~q,         SwitchOffTooltip, On
	Hotkey, ~w,         SwitchOffTooltip, On
	Hotkey, ~e,         SwitchOffTooltip, On
	Hotkey, ~r,         SwitchOffTooltip, On
	Hotkey, ~t,         SwitchOffTooltip, On
	Hotkey, ~y,         SwitchOffTooltip, On
	Hotkey, ~u,         SwitchOffTooltip, On
	Hotkey, ~i,         SwitchOffTooltip, On
	Hotkey, ~o,         SwitchOffTooltip, On
	Hotkey, ~[,         SwitchOffTooltip, On
	Hotkey, ~],         SwitchOffTooltip, On
	Hotkey, ~\,         SwitchOffTooltip, On
	
;~ row #4
	Hotkey, ~CapsLock,  SwitchOffTooltip, On
	Hotkey, ~a,         SwitchOffTooltip, On
	Hotkey, ~s,         SwitchOffTooltip, On
	Hotkey, ~d,         SwitchOffTooltip, On
	Hotkey, ~f,         SwitchOffTooltip, On
	Hotkey, ~g,         SwitchOffTooltip, On
	Hotkey, ~h,         SwitchOffTooltip, On
	Hotkey, ~j,         SwitchOffTooltip, On
	Hotkey, ~k,         SwitchOffTooltip, On
	Hotkey, ~l,         SwitchOffTooltip, On
	Hotkey, ~;,         SwitchOffTooltip, On
	Hotkey, ~',         SwitchOffTooltip, On
	Hotkey, ~Enter,     SwitchOffTooltip, On
	
;~ row #5
	Hotkey, ~Shift,     SwitchOffTooltip, On
	Hotkey, ~z,         SwitchOffTooltip, On
	Hotkey, ~x,         SwitchOffTooltip, On
	Hotkey, ~c,         SwitchOffTooltip, On
	Hotkey, ~v,         SwitchOffTooltip, On
	Hotkey, ~b,         SwitchOffTooltip, On
	Hotkey, ~n,         SwitchOffTooltip, On
	Hotkey, ~m,         SwitchOffTooltip, On
	Hotkey, ~`,,        SwitchOffTooltip, On
	Hotkey, ~.,         SwitchOffTooltip, On
	Hotkey, ~/,         SwitchOffTooltip, On
	
;~ row #6
	Hotkey, ~Control,   SwitchOffTooltip, On
	Hotkey, ~Lwin,      SwitchOffTooltip, On
	Hotkey, ~Alt,       SwitchOffTooltip, On
	Hotkey, ~Space,     SwitchOffTooltip, On
	Hotkey, ~RWin,      SwitchOffTooltip, On
	Hotkey, ~AppsKey,   SwitchOffTooltip, On
}

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ProcessInputArgs()
{
	global A_Args, ApplicationName
	
	if (A_Args.Length() = 0)
	{
		IfExist, *.ini
		{
			MsgBox, 16, %ApplicationName%.ahk, At least one *.ini file found in directory %A_WorkingDir%`n but current script (%ApplicationName%.ahk) was run without any arguments. One argument`, the name of .ini file`, is obligatory. Therefore script will now exit.
			ExitApp, 0
		}
		IfNotExist, *.ini
			MsgBox, 308, %ApplicationName%.ahk, No input arguments found and no *.ini files found in directory %A_WorkingDir%. Expected a single *.ini file. Do you want to create Default.ini configuration template? Script will exit after the default configuration file Default%ApplicationName%ConfigFile.ini is created.
		IfMsgBox, No
			ExitApp, 0
		IfMsgBox, Yes
		{
			ini=
(
[Global]
Language = NameOfYourLanguage
AmericanLayout = yes ; or no
AllTooltips = on ; or off
AllBeeps = on ; or off
DiacriticWord = Diacritic ; e.g. Diacritic, this parameter will appear in Tooltip, if Tooltips are enabled
DoubleWord = Double ; e.g. Double, this parameter will appear in Tooltip, if Tooltips are enabled

[Diacritic1] ; exapmple of single section; such a section have to be repeated for each Diacritic key
BaseKey = a ; name of a key which will activate a Diacritic key
Diacritic = {U+0105} ; definition of Diacritic key, the format {U+xyza} is obligatory
ShiftBaseKey = A ; as for basekey, but this time explicite specify which key will appear
ShiftDiacritic = {U+0104} ; definition of Diacritic key, the format {U+xyza} is obligatory
Tooltip = on ; or off
BaseKey_SoundBeep_Freq = 1000 ; a number between 37 and 32767
BaseKey_SoundBeep_Dur = 150 ; The dur of the sound, in milliseconds
Diacritic_SoundBeep_Freq = 1100 ; a number between 37 and 32767
Diacritic_SoundBeep_Dur = 150 ; The dur of the sound, in milliseconds
Double_SoundBeep_Freq = 1200 ; a number between 37 and 32767
Double_SoundBeep_Dur = 150 ; The dur of the sound, in milliseconds
)
			FileAppend, %ini%, Default%ApplicationName%ConfigFile.ini
			ini = ""
			ExitApp, 0
		}
	}
	else if (A_Args.Length() = 1)
	{
		IniRead, _Language,                         % A_ScriptDir . "\" . A_Args[1], Global, Language
		TrayTip, Diacritic.ahk, % "Input argument: " . A_Args[1] . ". Found language: " . _Language . ".",5, 0x1
    ;~ MsgBox, 64, Diacritic.ahk, % "Input argument: " . A_Args[1] . ". Found language: " . _Language . "."
	}
	else if (A_Args.Length() > 1)
		MsgBox, 48, Diacritic.ahk, % "Too many input arguments: " . A_Args.Length() . ". Expected just one, *.ini." 
}    

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;~ https://docs.microsoft.com/pl-pl/windows/win32/api/winuser/nf-winuser-systemparametersinfoa?redirectedfrom=MSDN
SetDefaultKeyboard(LocaleID)
{
	static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2
	WM_INPUTLANGCHANGEREQUEST := 0x50
	
	Language := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(binaryLocaleID, 4, 0)
	NumPut(LocaleID, binaryLocaleID)
	DllCall("SystemParametersInfo", UINT, SPI_SETDEFAULTINPUTLANG, UINT, 0, UPTR, &binaryLocaleID, UINT, SPIF_SENDWININICHANGE)
	
	WinGet, windows, List
	Loop % windows
		PostMessage WM_INPUTLANGCHANGEREQUEST, 0, % Language, , % "ahk_id " windows%A_Index%
}


 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF LABELS - - - - - - - - - - - - - - - - - - - - - - - - - - - 

SwitchOffTooltip:
    ;~ ToolTip, Carramba
    ToolTip,
return


TRAYMENU:
    Menu, Tray, Add, %ApplicationName%.ahk ABOUT, ABOUT
    Menu, Tray, Add, % ".ini file: " . A_Args[1], _iniFile
    ;~ Menu, Tray, Add, .ini file: %1%, _iniFile
    Menu, Tray, Default, %ApplicationName%.ahk ABOUT ; Default: Changes the menu's default item to be the specified menu item and makes its font bold.
    Menu, Tray, Add ; To add a menu separator line, omit all three parameters. To put your menu items on top of the standard menu items (after adding your own menu items) run Menu, Tray, NoStandard followed by Menu, Tray, Standard.
    Menu, Tray, NoStandard
    Menu, Tray, Standard
    Menu, Tray, Tip, %ApplicationName% ; Changes the tray icon's tooltip.
return

_iniFile:
return

ABOUT:
    Gui, MyAbout: Font, Bold
    Gui, MyAbout: Add, Text, , %ApplicationName% v.1.0 by mslonik
    Gui, MyAbout: Font
    Gui, MyAbout: Add, Text, xm, Simple script for configured set of diacritic marks (
    Gui, MyAbout: Font, CBlue Underline 
    Gui, MyAbout: Add, Text, x+1, https://en.wikipedia.org/wiki/Diacritic
    Gui, MyAbout: Font
    Gui, MyAbout: Add, Text, x+1, ) e.g.: ą, ć, ę, ł, ś, ź, ż, ó, ń etc.
    Gui, MyAbout: Add, Text, xm, Instead of using AltGr key (the right Alt`, see 
    Gui, MyAbout: Font, CBlue Underline 
    Gui, MyAbout: Add, Text, x+2, https://en.wikipedia.org/wiki/AltGr_key 
    Gui, MyAbout: Font
    Gui, MyAbout: Add, Text, x+2, for further details):
    Gui, MyAbout: Add, Text, xm+20, * double press a key corresponding to specific diacritic key`, e.g. ee converts into ę
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