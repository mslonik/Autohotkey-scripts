/*
Author:      Maciej Słojewski, mslonik, http://mslonik.pl
Purpose:     Facilitate normal operation for company desktop.
Description: Hotkeys and hotstrings for my everyday professional activities and office cockpit.
License:     GNU GPL v.3
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!
; #MenuMaskKey vkFF

; --------------- SECTION OF GLOBAL VARIABLES -----------------------------
;~ WordTrue := -1
;~ WordFalse := 0
MyHotstring 		:= ""
English_USA 		:= 0x0409   ; see AutoHotkey help: Language Codes
; --------------- END OF GLOBAL VARIABLES SECTION ----------------------

; - - - - - - - - - - - SECTION DEDICATED TO  Maciej Słojewski's specific hardware AND PREFERENCES - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - -

; Maciej Słojewski only; office only
if ((A_ComputerName = "2277NB010") && 		(A_UserName = "V523580"))
	{
	;~ Set of default web pages
	Tabs := CheckingChromeTabs()
	FindWebsite("Tłumacz Google", "chrome.exe translate.google.com", Tabs)
	FindWebsite("LinkedIn", "chrome.exe linkedin.com/feed", Tabs)
	FindWebsite("Poczta", "chrome.exe poczta.onet.pl", Tabs)
	FindWebsite("METEO.PL","chrome.exe meteo.pl", Tabs)
	FindWebsite("Prognoza pogody dla Polski - pogodynka.pl","chrome.exe pogodynka.pl/polska/radary", Tabs)
	FindWebsite("Document.GetCrossReferenceItems","chrome.exe https://docs.microsoft.com/en-us/office/vba/api/word.document.getcrossreferenceitems", Tabs)
	FindWebsite("WhatsApp","chrome.exe web.whatsapp.com", Tabs)
	FindWebsite("myTeamsites - Home", "chrome.exe team.voestalpine.net/SitePages/Home.aspx", Tabs)
	FindWebsite("Pulpit", "chrome.exe helpdesk.tens.pl/helpdesk", Tabs)
	FindWebsite("Exact Synergy Enterprise","chrome.exe portal-signaling-sopot.voestalpine.net/synergy/docs/Portal.aspx", Tabs)
	FindWebsite("Cooperation Platform Sopot","chrome.exe solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx", Tabs)
	FindWebsite("MDS Upgrade Kit","chrome.exe solidsystemteamwork.voestalpine.root.local/Processes/custprojects/780MDSUpgradeKit/SitePages/Home.aspx",Tabs)
	}

; Maciej Słojewski only; home-office or office
if (	((A_ComputerName = "2277NB010") && 		(A_UserName = "V523580"))
	|| 	((A_ComputerName = "NOTEBOOK-GUCEK") && (A_UserName = "maciej")))
	{
	CapitalizeFirstLetters()
	SetDefaultKeyboard(English_USA)
	MsgBox, Keyboard style: English_USA
	}

; Maciej Słojewski only; home-office or office
#if (	((A_ComputerName = "2277NB010") && 		(A_UserName = "V523580"))
	|| 	((A_ComputerName = "NOTEBOOK-GUCEK") && (A_UserName = "maciej")))

; - - - - - - - - - - - - - - - - General keys redicrection - - - - - - - - - - - - - - - - - - - - 
	Ralt::AppsKey ; redirects AltGr -> context menu
	
	LWin & LAlt:: ; calls for windows switcher
	LAlt & LWin::
		Send,{Ctrl Down}{LAlt Down}{Tab}{Ctrl Up}{Lalt Up}
	return

	+F3 Up:: ; Shift + F3
		ForceCapitalize()
	return

	PrintScreen::#+s ; Windows + Shift + s https://support.microsoft.com/pl-pl/help/4488540/how-to-take-and-annotate-screenshots-on-windows-10
; - - - - - - - - - - - - - - - - Function Keys redirection - - - - - - - - - - - - - - - - - - - -
; This is a way to get rid of top row of keyboard function keys.
	:*:esc.::{Esc} 
	:*:f1.::{F1}
	:*:f2.::{F2}
	:*:f3.::{F3}
	:*:f4.::{F4}
	:*:f5.::{F5}
	:*:f6.::{F6}
	:*:f7.::{F7}
	:*:f8.::{F8}
	:*:f9.::{F9}
	:*:f10.::{F10}
	:*:f11.::{F11}
	:*:f12.::{F12}

; These are valid only for "Logitech Internet 350 Keyboard" and alike with so called multimedia keys

Launch_Media:: ; run Microsoft Word application - a note, the very first multimedia key from a left 
	tooltip, [%A_thishotKey%] Run text processor Microsoft Word  
	SetTimer, TurnOffTooltip, -5000
	Run, WINWORD.EXE
return

Launch_Mail:: ; run Total Commander application
	tooltip, [%A_thishotKey%] Run twin-panel file manager Total Commander
	SetTimer, TurnOffTooltip, -5000
	Run, c:\totalcmd\TOTALCMD64.EXE 
return

Browser_Home:: ; run Snipping Tool (Microsoft Windows operating system tool) no longer required as the same action is now taken by PrintScreen
	tooltip, [%A_thishotKey%] Run system tool Snipping Tool
	SetTimer, TurnOffTooltip, -5000
	Run, %A_WinDir%\system32\SnippingTool.exe
return

Media_Play_Pause:: ; run Paint (Microsoft Windows operating system tool)
	tooltip, [%A_thishotKey%] Run basic graphic editor Paint
	SetTimer, TurnOffTooltip, -5000
	Run, %A_WinDir%\system32\mspaint.exe
return

^Volume_Up:: ; Reboot
	Shutdown, 2
return

^Volume_Mute:: ; Shutdown + Powerdown
	Shutdown, 1 + 8
return

; These are valid for any keyboard
+^F1::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; Suspend: 
+^k::Run, C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe 	 ; run Kee Pass application (password manager)
^#F8::WinSet, AlwaysOnTop, toggle, A ; Ctrl + Windows + F8, toggle always on top


; ----------------- SECTION OF ADDITIONAL I/O DEVICES -------------------------------
; pedals (Foot Switch FS3-P, made by https://pcsensor.com/)

F13:: ; reserved for capital letter switcher (Shift + F3 in Word)
return

F14:: ; reset of AutoHotkey string recognizer
	;~ Send, {Left}{Right}
	Hotstring("Reset")
	ToolTip, [%A_thishotKey%] reset of AutoHotkey string recognizer
	SetTimer, TurnOffTooltip, -2000
return

~F15:: ; Reserved for CopyQ
return

;~ https://autohotkey.com/board/topic/116740-switch-between-one-window-of-each-different-applications/
; computer mouse: OPTO 325 (PS/2 interface and PS/2 to USB adapter): 3 (top) + 2 (side) buttons, 2x wheels, but only one is recognizable by AHK.

; Make the mouse wheel perform alt-tabbing: this one doesn't work with #if condition
;~ MButton::AltTabMenu
;~ WheelDown::AltTab
;~ WheelUp::ShiftAltTab

; Left side button XButton1
XButton1:: ; switching between Chrome browser tabs; author: Taran VH
	if !WinExist("ahk_class Chrome_WidgetWin_1")
		{
		Run, chrome.exe
		}
	if WinActive("ahk_class Chrome_WidgetWin_1")
		{
		Send, ^+{Tab}
		}
	else
		{
		WinActivate ahk_class Chrome_WidgetWin_1
		}
return

; Right side button XButton2
XButton2:: ; switching between Chrome browser tabs; author: Taran VH
	if !WinExist("ahk_class Chrome_WidgetWin_1")
		{
		Run, chrome.exe
		}
	if WinActive("ahk_class Chrome_WidgetWin_1")
		{
		Send, ^{Tab}
		}
	else
		{
		WinActivate ahk_class Chrome_WidgetWin_1
		}
return
; ----------------- END OF ADDITIONAL I/O DEVICES SECTION ------------------------
#if		; end of section dedicated to Maciej Słojewski
; - - - - - - - - - - - END OF SECTION DEDICATED TO  Maciej Słojewski's specific hardware - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - -


^z::			;~ Ctrl + z as in MS Word: Undo
$!BackSpace:: 	;~ Alt + Backspace as in MS Word: rolls back last Autocorrect action
	if (MyHotstring && (A_ThisHotkey != A_PriorHotkey))
		{
		;~ MsgBox, % "MyHotstring: " . MyHotstring . " A_ThisHotkey: " . A_ThisHotkey . " A_PriorHotkey: " . A_PriorHotkey
		ToolTip, Undo the last hotstring., % A_CaretX, % A_CaretY-20
		Send, % "{BackSpace " . StrLen(MyHotstring) . "}" . SubStr(A_PriorHotkey, InStr(A_PriorHotkey, ":", CaseSensitive := false, StartingPos := 1, Occurrence := 2) + 1)
		SetTimer, TurnOffTooltip, -5000
		MyHotstring := ""
		}
	else
		{
		ToolTip,
		;~ ToolTip, Nothing to replace, % A_CaretX, % A_CaretY-20
		;~ MsgBox, % "ELSE MyHotstring: " . MyHotstring . " A_ThisHotkey: " . A_ThisHotkey . " A_PriorHotkey: " . A_PriorHotkey		
		;~ SetTimer, TurnOffTooltip, -5000
		Send, !{BackSpace}
		}
return

;~ pl: spacja nierozdzielająca; en: Non-breaking space; the same shortcut is used by default in MS Word
+^Space::Send, {U+00A0}


; - - - - - - - - END OF KEYBOARD HOTKEYS SECTION - - - - - - - - - - - - - - - - - - - - - 




; ---------------------- HOTSTRINGS -----------------------------------
;~ The general hotstring rules:
;~ 1. Automatic changing small letters to capital letters: just press ending character (e.g. <Enter> or <Space> or <(>).
;~ 2. Automatic expansion of abbreviation: after small letters just press a <.>.
;~ 2.1. If expansion contain double letters, use that letter and <2>. E.g. <c2ms> expands to <CCMS> and <c2ms.> expands to <Component Content Management System>.
;~ 3. Each hotstrings can be undone upon pressing of usual shotcuts: <Ctrl + z> or <Ctrl + BackSpace>.

#Include *i	PersonalHotstrings.ahk 		; Personal Hotstrings Ctrl+Shift+F9
#Include *i voestalpineHotstrings.ahk 	; Hotstrings: voestalpine: Ctrl + Shift + F10 
#Include *i PhysicsHotstrings.ahk 		; Physics, Mathematics and Other Symbols: Ctrl + Shift + F11
#Include *i Abbreviations.ahk 			; Abbreviations: Ctrl + Shift + F12
#Include *i PolishHotstrings.ahk 		; Polish section
#Include *i GermanHotstrings.ahk 		; German section
#Include *i TimeHotstrings.ahk 			; Section Date & Time
#Include *i FirstAndSecondNames.ahk 	; Section of first or second names with local diacritics
#Include *i EmojiHotstrings.ahk 		; Emoji & Emoticons
#Include *i TechnicalHotstrings.ahk 	; Full titles of technical standards
#Include *i AutocorrectionHotstrings.ahk ; Autocorrection section
#Include *i CapitalLetters.ahk 			; Section Capital Letters

; - - - - - - - - - - - - SECTION OF FUNCTIONS  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
HotstringFun(text, par, textvar)
{
	global MyHotstring, Replacement, MyHotStringLength, Limit, StartingPosition
	MyHotstring := text
	if (textvar = 1)
	{
		MyHotstring := "{Text}"MyHotstring
	}
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := par, StartingPosition := 1)
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
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
		{
		PostMessage WM_INPUTLANGCHANGEREQUEST, 0, % Language, , % "ahk_id " windows%A_Index%
		}
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

;~ https://jacks-autohotkey-blog.com/2020/03/09/auto-capitalize-the-first-letter-of-sentences/#more-41175
CapitalizeFirstLetters()
{
	Loop, 26 
		Hotstring(":C?*:. " . 	Chr(A_Index + 96),". " . 	Chr(A_Index + 64))
	Loop, 26 
		Hotstring(":CR?*:! " . 	Chr(A_Index + 96),"! " . 	Chr(A_Index + 64))
	Loop, 26 
		Hotstring(":C?*:? " . 	Chr(A_Index + 96),"? " . 	Chr(A_Index + 64))
	Loop, 26 
		Hotstring(":C?*:`n" . 	Chr(A_Index + 96),"`n" . 	Chr(A_Index + 64))
return
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ForceCapitalize()	; by Jakub Masiak
{
	OldClipboard := ClipboardAll
	Clipboard := ""
	Send ^+{left}{Left}^+{right}^c
	ClipWait 0
	state = f
	Loop, Parse, Clipboard
	{
		if A_LoopField is upper
		{
			if state = f
			{
				state = u
			}
		}
		else if A_LoopField is lower
		{
			if state = f
			{
				state = l
			}
		}
		if state = u
		{
			if A_Loopfield is lower
			{
				state = r
			}
		}
		if state = l
		{
			if A_Loopfield is upper
			{
				state = r
			}
		}
	}
	if state = r
	{
		StringUpper, Clipboard, Clipboard
	}
	if state = u
	{
		StringLower, Clipboard, Clipboard
	}
	if state = l
	{
		sen := ""
		ns := 1
		Loop, Parse, Clipboard
		{
			var := A_LoopField
			if var = %A_Space%
			{
				sen = % sen . " "
			}
			else if (var = .) or (var = "`n") 
			{
				ns := 1
				sen = %sen%%var%
			}
			else if (ns = 1) and (var != A_Space)
			{
				StringUpper, var, var
				ns := 0
				sen = %sen%%var%
			}
			else
			{
				sen = %sen%%var%
			}
			
		}
		Clipboard := sen
	}
	Send, {Text}%Clipboard%
	Sleep 100
	Clipboard := OldClipboard
return
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

CheckingChromeTabs() ; by Jakub Masiak; checks if specific web pages are already opened in Chrome
{
	local Tabs
	BlockInput, on
	IfWinExist, ahk_exe chrome.exe
		WinActivate ahk_exe chrome.exe
	else
	{
		Run, chrome.exe
		sleep, 500
	}
	sleep, 500
	WinGetActiveTitle, StartingTab
	Tabs = %StartingTab%
	Loop
	{
		Send, {Control down}{Tab}{Control up}
		Sleep, 100
		WinGetActiveTitle, CurrentTab
		if (CurrentTab == StartingTab)
			break
		else 
			Tabs = %Tabs% '
		Tabs = %Tabs% %CurrentTab%
	}
	BlockInput, off
	return Tabs
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

FindWebsite(title, address, tabs)
{
	loop, parse, Tabs, ',
	{
		if (InStr(A_LoopField, title) != 0)
		{
			return
		}
	}
	Run, %address%
	return
}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; switching beetween windows of Word; author: Taran VH
SwitchBetweenWindowsOfWord()
{
	Process, Exist, WINWORD.EXE
	if (ErrorLevel = 0)
		{
        Run, WINWORD.EXE
		}
     else
        {
        GroupAdd, taranwords, ahk_class OpusApp
        if (WinActive("ahk_class OpusApp"))
			{
            GroupActivate, taranwords, r
			} 
        else
			{
            WinActivate ahk_class OpusApp
			}
        }
}

; ---------------------- SECTION OF LABELS ------------------------------------

TurnOffTooltip:
	ToolTip ,
return

