#SingleInstance force 			; only one instance of this script may run at a time!
#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  							; Enable warnings to assist with detecting common errors.
#Persistent
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

Menu, Tray,Icon, % A_SCriptDir . "\vh.ico" 

global English_USA 		:= 0x0409   ; see AutoHotkey help: Language Codes
global TransFactor := 255
global WordTrue := -1 ; ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true
global WordFalse := 0 ; ComObj(0xB, 0) ; 0xB = VT_Bool || 0 = false
global OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
global OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
global OurTemplate := ""
;---------------- Zmienne do funkcji autozapisu ----------------
global flag_as := 0
global size := 0
global size_org := 0
global table := []
global AutosaveFilePath := "C:\temp1\KopiaZapasowaPlikowWord\"
global interval := 10*60*1000
;--------------- Zmienne do przełączania okienek ---------------
global cntWnd := 0
global cntWnd2 := 0
global id := []
global order := []
;---------------------------------------------------------------
global MyTemplate := ""
global template := ""

#Include, *i ..\Otagle3\WarstwaWord\MakraOgolne\SetHeadersAndFooters.ahk
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\Wypunktowania.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\UsunWielokrotneSpacje.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\Refresh.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\TwardaSpacja.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\Hiperlacza.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\FindBlad.ahk
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\FindDeadLinks.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\ResizeImages.ahk 
#Include, *i ..\Otagle3\WarstwaWord\UstawieniaDokumentu\CheckingMacro.ahk 

SetTimer, AutoSave, % interval
txtVar := "Autozapis dokumentów w MS Word włączony.`nAby wyłączyć tę funkcję, naciśnij kombinację klawiszy Ctrl+LewyAlt+Q."
TrayTip, %A_ScriptName%, %txtVar%, 5, 0x1

; - - - - - - - - - - - SECTION DEDICATED TO  Maciej Słojewski's specific hardware AND PREFERENCES - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - -

; Maciej Słojewski only; office only
if ((A_ComputerName = "2277NB010") && 		(A_UserName = "V523580") && (A_Args[1] != "EditHotstring"))
	{
	;~ Set of default web pages
	Tabs := CheckingChromeTabs()
	FindWebsite("Tłumacz Google", "chrome.exe translate.google.com", Tabs)
	FindWebsite("LinkedIn", "chrome.exe linkedin.com/feed", Tabs)
	FindWebsite("Poczta", "chrome.exe poczta.onet.pl", Tabs)
	FindWebsite("METEO.PL","chrome.exe meteo.pl", Tabs)
	FindWebsite("Prognoza pogody dla Polski - pogodynka.pl","chrome.exe pogodynka.pl/polska/radary", Tabs)
	FindWebsite("Ogłoszenia | TRELO", "chrome.exe https://trello.com/b/plScYC32/og%C5%82oszenia", Tabs)
;	FindWebsite("Document.GetCrossReferenceItems","chrome.exe https://docs.microsoft.com/en-us/office/vba/api/word.document.getcrossreferenceitems", Tabs)
	FindWebsite("WhatsApp","chrome.exe web.whatsapp.com", Tabs)
	FindWebsite("myTeamsites - Home", "chrome.exe team.voestalpine.net/SitePages/Home.aspx", Tabs)
	FindWebsite("Pulpit", "chrome.exe helpdesk.tens.pl/helpdesk", Tabs)
	FindWebsite("Exact Synergy Enterprise","chrome.exe https://portal-signaling-poland.voestalpine.net/synergy/docs/Portal.aspx", Tabs)
	FindWebsite("Cooperation Platform Sopot", "chrome.exe solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx", Tabs)
	FindWebsite("MDS Upgrade Kit","chrome.exe solidsystemteamwork.voestalpine.root.local/Processes/custprojects/780MDSUpgradeKit/SitePages/Home.aspx",Tabs)
;	FindWebsite("ERTMS axis counters for ProRail BV", "chrome.exe team.voestalpine.net/site/5061/SitePages/Home.aspx", Tabs)
;	FindWebsite("mssopot | Jitsi Meet","chrome.exe https://meet.jit.si/mssopot",Tabs)
	}

; Maciej Słojewski only; home-office or office
if (	((A_ComputerName = "2277NB010") && 		(A_UserName = "V523580")) 
 	|| 	((A_ComputerName = "NOTEBOOK-GUCEK") && (A_UserName = "maciej")))
	{
	;~ CapitalizeFirstLetters() only context dependent.
	SetDefaultKeyboard(English_USA)
	TrayTip, VariousFunctions.ahk, Keyboard style: English_USA, 5, 0x1
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

	+F3 Up:: ; Shift + F3 ; zmienić na wywołanie kontekstowe #IfWinActive WhatsApp
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
+^F1::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)		; Suspend: 
+^F2::Shutdown, 2															; Reboot
+^F3::Shutdown, 1 + 8														; Shutdown + Powerdown
+^k::Run, C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe 	 ; run Kee Pass application (password manager)

^#F8:: 			; Ctrl + Windows + F8, toggle window parameter always on top
	WinSet, AlwaysOnTop, toggle, A 
	ToolTip, This window atribut "Always on Top" is toggled ;, % A_CaretX, % A_CaretY - 20
	SetTimer, TurnOffTooltip, -2000
return

^#F9::			; Ctrl + Windows + F9, toggle window transparency
	if (WindowTransparency = 0)
		{
		WinSet, Transparent, 125, A
		WindowTransparency := 1
		ToolTip, This window atribut Transparency was changed to semi-transparent ;, % A_CaretX, % A_CaretY - 20
		SetTimer, TurnOffTooltip, -2000
		return
		}
	else
		{
		WinSet, Transparent, 255, A
		WindowTransparency := 0
		ToolTip, This window atribut Transparency was changed to opaque ;, % A_CaretX, % A_CaretY - 20
		SetTimer, TurnOffTooltip, -2000
		return
		}


; ----------------- SECTION OF ADDITIONAL I/O DEVICES -------------------------------
; pedals (Foot Switch FS3-P, made by https://pcsensor.com/)

F13:: 
	Send, #t
	SoundBeep, 1000, 200 ; freq = 50, duration = 200 ms
return

F14:: ; reset of AutoHotkey string recognizer
	;~ Send, {Left}{Right}
	Hotstring("Reset")
	SoundBeep, 1500, 200 ; freq = 100, duration = 200 ms
	ToolTip, [%A_thishotKey%] reset of AutoHotkey string recognizer, % A_CaretX, % A_CaretY - 20
	SetTimer, TurnOffTooltip, -2000
return

~F15:: ; Reserved for CopyQ
	SoundBeep, 2000, 200 ; freq = 500, duration = 200 ms
return

; computer mouse: OPTO 325 (PS/2 interface and PS/2 to USB adapter): 3 (top) + 2 (side) buttons, 2x wheels, but only one is recognizable by AHK.

; Make the mouse wheel perform alt-tabbing: this one doesn't work with #if condition
;~ MButton::AltTabMenu
;~ WheelDown::AltTab
;~ WheelUp::ShiftAltTab

#if  WinActive(, "Microsoft Word") ; <--Everything after this line will only happen in Microsoft Word.

; ^+F12::
; +F12::
; F12::
; ^s::
; ^p::
; SetWorkingDir, % SubStr(A_ScriptDir, 1 , InStr(A_ScriptDir, "VariousFunctions")-1) . "Otagle3"
; CheckingMacro()
; SetTimer, Druk, 500
return

Druk:
if !(WinExist("Checklist")) and !(WinExist("Checklist Macro"))
{
	SetTimer, Druk, Off
	WinActivate, ahk_class OpusApp
	shortcut := A_ThisHotkey
	shortcut := StrReplace(shortcut, "F12" , "{F12}")
	SendInput, % shortcut
}
return

^k::
Send, {LAlt Down}{Ctrl Down}h{Ctrl Up}{LAlt Up}
return

+^h:: ; Shift + Ctrl + H - hide text; there is dedicated style to do that
	HideSelectedText()
return

^*:: 
ShowHiddenText("Włącz/wyłącz tekst ukryty")
return

^+t::
oWord := ComObjActive("Word.Application")
OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName

if (InStr(OurTemplate, "TQ-S402-pl_OgolnyTechDok.dotm") or InStr(OurTemplate, "TQ-S402-en_OgolnyTechDok.dotm"))
{
	oWord.ActiveDocument.AttachedTemplate := ""
	oWord.ActiveDocument.UpdateStylesOnOpen := -1
	MsgBox,0x40,, % MsgText("Szablon został odłączony.")
}
oWord := ""
return

+^x:: ; Shift + Ctrl + X - strike through the selected text 
	StrikeThroughText()
return

^l:: ; Ctrl + L - delete a whole line of text, see https://superuser.com/questions/298963/microsoft-word-2010-assigning-a-keyboard-shortcut-for-deleting-one-line-of-text
	DeleteLineOfText()
return

+^l:: ; Shift + Ctrl + L - align text of paragraph to left
	Send, ^l
return

+^s:: ; Shift + Ctrl + S - toggle Apply Styles pane
	ToggleApplyStylesPane()
return

^o:: ; Ctrl + O - adds full path to a document in window bar
	FullPath() ; to do: call this function whenever document was saved with a filename.
	Send, ^{o down}{o up}
return

#3::
	Switching()
return

:*:tabela`t::| | |{Enter}

:*:tilde::
	MSWordSetFont("Cambria Math", "U+223C") ;
return

^t::
	gosub, AutoTemplate
return

#if ; this line will end the Word only keyboard assignments.

;~ Www.computeredge.com/AutoHotkey/Downloads/ChangeVolume.ahk
#If MouseIsOver("ahk_class Shell_TrayWnd")
	WheelUp::Send {Volume_up}
	WheelDown::Send {Volume_down}
#If

MouseIsOver(WinTitle)
{
	MouseGetPos,,, Win
	return WinExist(WinTitle . " ahk_id " . Win)
}

; Left side button XButton1
XButton1:: ; switching between Chrome browser tabs; author: Taran VH
	if !WinExist("ahk_class Chrome_WidgetWin_1")
		{
		Run, chrome.exe
		}
	if WinActive("ahk_class Chrome_WidgetWin_1") or WinActive("ahk_class TTOTAL_CMD")
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
	if WinActive("ahk_class Chrome_WidgetWin_1")  or WinActive("ahk_class TTOTAL_CMD")
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
;~ pl: spacja nierozdzielająca; en: Non-breaking space; the same shortcut is used by default in MS Word
+^Space::Send, {U+00A0}

; Functions to increase or decrease transparency of active window

#If !(WinActive("ahk_class Progman"))
^+WheelDown::
    TransFactor := TransFactor - 25.5
    if (TransFactor < 0)
        TransFactor := 0
    WinSet, Transparent, %TransFactor%, A
    TransProc := Round(100*TransFactor/255)
    ToolTip, Transparency set to %TransProc%`%
    SetTimer, TurnOffTooltip, -500
    Return

^+WheelUp::
    TransFactor := TransFactor + 25.5
    if (TransFactor > 255)
        TransFactor := 255
    WinSet, Transparent, %TransFactor%, A
    TransProc := Round(100*TransFactor/255)
    ToolTip, Transparency set to %TransProc%`%
    SetTimer, TurnOffTooltip, -500
    Return
#If


<!^q::
if (flag_as = 0)
{
	SetTimer, AutoSave, Off
	TrayTip, %A_ScriptName%, Autozapis został wyłączony!, 5, 0x1
	flag_as := 1
}
else if (flag_as = 1)
{
	SetTimer, AutoSave, On
	TrayTip, %A_ScriptName%, Autozapis został ponownie włączony!, 5, 0x1
	flag_as := 0
}
return

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MsgText(string)
{
    vSize := StrPut(string, "CP0")
    VarSetCapacity(vUtf8, vSize)
    vSize := StrPut(string, &vUtf8, vSize, "CP0")
    Return StrGet(&vUtf8, "UTF-8") 
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
	Loop, 26 ; 26 ← number of letters in alphabet
		{
		Hotstring(":C?*:. " . 	Chr(A_Index + 96),	". " . 	Chr(A_Index + 64))
		Hotstring(":CR?*:! " . 	Chr(A_Index + 96),	"! " . 	Chr(A_Index + 64))
		Hotstring(":C?*:? " . 	Chr(A_Index + 96),	"? " . 	Chr(A_Index + 64))
		Hotstring(":C?*:`n" . 	Chr(A_Index + 96),	"`n" . 	Chr(A_Index + 64))
		}
return
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ForceCapitalize()	; by Jakub Masiak
{
	IfWinActive, ahk_exe WINWORD.EXE
	{
		Send, +{F3}
	}
	else
	{
	sw := 0
	OldClipboard := ClipboardAll
	Clipboard := ""
	Send, ^c
	if (Clipboard == "")
	{
		sw := 1
		Send ^+{left}{Left}^+{right}^c
	}
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
	len := StrLen(Clipboard)
	Send, {Text}%Clipboard%
	Sleep 100
	if (sw == 0)
		Send, +{left %len%}
	Clipboard := OldClipboard
	}
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
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
HideSelectedText() ; 2019-10-22 2019-11-08
	{
	global oWord
	global  WordTrue, WordFalse

	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (InStr(OurTemplate, "TQ-S402-pl_OgolnyTechDok.dotm") or InStr(OurTemplate, "TQ-S402-en_OgolnyTechDok.dotm"))
	{
		nazStyl := oWord.Selection.Style.NameLocal
		if (nazStyl = "Ukryty ms")
			Send, ^{Space}
		else
		{
			language := oWord.Selection.Range.LanguageID
			oWord.Selection.Paragraphs(1).Range.LanguageID := language
			TemplateStyle("Ukryty ms")
		}
	}
	else
	{
		StateOfHidden := oWord.Selection.Font.Hidden
		oWord.Selection.Font.Hidden := WordTrue
		If (StateOfHidden == WordFalse)
		{
			oWord.Selection.Font.Hidden := WordTrue	
			}
		else
		{
			oWord.Selection.Font.Hidden := WordFalse
		}
	}
	
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------
ShowHiddenText(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	HiddenTextState := oWord.ActiveWindow.View.ShowHiddenText
	if (oWord.ActiveWindow.View.ShowAll = -1)
	{
		oWord.ActiveWindow.View.ShowAll := 0
		oWord.ActiveWindow.View.ShowTabs := 0
		oWord.ActiveWindow.View.ShowSpaces := 0
		oWord.ActiveWindow.View.ShowParagraphs := 0
		oWord.ActiveWindow.View.ShowHyphens := 0
		oWord.ActiveWindow.View.ShowObjectAnchors := 0
		oWord.ActiveWindow.View.ShowHiddenText := 0
	}
	else
	{
		oWord.ActiveWindow.View.ShowAll := -1
		oWord.ActiveWindow.View.ShowTabs := -1
		oWord.ActiveWindow.View.ShowSpaces := -1
		oWord.ActiveWindow.View.ShowParagraphs := -1
		oWord.ActiveWindow.View.ShowHyphens := -1
		oWord.ActiveWindow.View.ShowObjectAnchors := -1
		oWord.ActiveWindow.View.ShowHiddenText := -1
	}
	oWord := ""
	return
}
; -----------------------------------------------------------------------------------------------------------------------------

StrikeThroughText() ; 2019-10-03 2019-11-08
	{
	global oWord
	global  WordTrue, WordFalse	

	oWord := ComObjActive("Word.Application")
	StateOfStrikeThrough := oWord.Selection.Font.StrikeThrough ; := wdToggle := 9999998 
	if (StateOfStrikeThrough == WordFalse)
		{
		oWord.Selection.Font.StrikeThrough := wdToggle := 9999998
		}
	else
		{
		oWord.Selection.Font.StrikeThrough := 0
		}
	oWord :=  "" ; Clear global COM objects when done with them
	}
; -----------------------------------------------------------------------------------------------------------------------------

DeleteLineOfText() ; 2019-10-03
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	oWord.Selection.HomeKey(Unit := wdLine := 5)
	oWord.Selection.EndKey(Unit := wdLine := 5, Extend := wdExtend := 1)
	oWord.Selection.Delete(Unit := wdCharacter := 1, Count := 1)
	oWord :=  "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------
ToggleApplyStylesPane() ; 2019-10-03
	{
	global oWord
	global  WordTrue, WordFalse	
	
	oWord := ComObjActive("Word.Application")
	; ApplyStylesTaskPane := oWord.CommandBars("Apply styles").Visible
	ApplyStylesTaskPane := oWord.Application.TaskPanes(17).Visible
	try
	{	
	If (ApplyStylesTaskPane = WordFalse)
		oWord.Application.TaskPanes(17).Visible := WordTrue
	Else If (ApplyStylesTaskPane = WordTrue)
		oWord.CommandBars("Apply styles").Visible := WordFalse
	}
		catch
	{
		MsgBox,48,, % MsgText("Aby wywołać panel ""Stosowanie stylów"", zaznaczenie nie powinno zawierać kanwy rysunku.")
		return
	}
	
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------
FullPath(AdditionalText := "") ; display full path to a file in window title bar 
;~ by Jakub Masiak
{
	global oWord
    Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
    oWord.ActiveWindow.Caption := oWord.ActiveDocument.FullName
    oWord := ""
}


; -----------------------------------------------------------------------------------------------------------------------------
Switching()
;~ by Jakub Masiak
{
	global cntWnd, cntWnd2, id
	if cntWnd2 >= %cntWnd%
		cntWnd2 := 0
	varview := id[cntWnd2]
	WinActivate, ahk_id %varview%
	cntWnd2 := cntWnd2 + 1
	return
}
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
MSWordSetFont(FontName,key) {
	global oWord
   IfWinNotActive, ahk_class OpusApp
	{
	Send {%key%}
   return
	}
   oWord := ComObjActive("Word.Application")
   OldFont := oWord.Selection.Font.Name
   oWord.Selection.Font.Name := FontName
   Send {%key%}
   oWord.Selection.Font.Name := OldFont
   oWord := ""
   return
}

; -----------------------------------------------------------------------------------------------------------------------------

TemplateStyle(StyleName)
	{
	global OurTemplateEN, OurTemplatePL, oWord
	StyleName := MsgText(StyleName)
	Base(StyleName)
	oWord := ComObjActive("Word.Application") 
	;~ SoundBeep, 750, 500 ; to fajnie dzia�a
	if  !(InStr(OurTemplate, "TQ-S402-pl_OgolnyTechDok.dotm") or InStr(OurTemplate, "TQ-S402-en_OgolnyTechDok.dotm"))
		{
		;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
		MsgBox, 16, % MsgText("Próba wywołania stylu z szablonu"), % MsgText("Próbujesz wywołać styl przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku.`nNajpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.")
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := StyleName
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	}

; -----------------------------------------------------------------------------------------------------------------------------
Base(AdditionalText := "")
	{
	AdditionalText := MsgText(AdditionalText)
	tooltip, [F24]  %A_thishotKey% %AdditionalText%
	SetTimer, TurnOffTooltip, -5000
	return
	}

; -----------------------------------------------------------------------------------------------------------------------------

BB_Insert(Name_BB, AdditionalText)
	{
	global 
	Name_BB := MsgText(Name_BB)
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
	if  !( InStr(OurTemplate, "TQ-S402-pl_OgolnyTechDok.dotm") or InStr(OurTemplate, "TQ-S402-en_OgolnyTechDok.dotm") )
		{
		MsgBox, 16, % MsgText("Próba wstawienia bloku z szablonu"), % MsgText("Próbujesz wstawić blok konstrukcyjny przypisany do szablonu, ale szablon nie zostać jeszcze dołączony do tego pliku.`nNajpierw dołącz szablon, a nastepnie wywołaj ponownie tę funkcję.")
		}
	else
		{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries(Name_BB).Insert(oWord.Selection.Range, WordTrue)
		}
	oWord :=  "" ; Clear global COM objects when done with them
	}

; ---------------------- SECTION OF LABELS ------------------------------------
TurnOffTooltip:
	ToolTip ,
return

AutoSave:
{
	init := InitAutosaveFilePath(AutosaveFilePath)
	
	if WinExist("ahk_class OpusApp")
		oWord := ComObjActive("Word.Application")
		
	else
		return
	try
	{
		Loop, % oWord.Documents.Count
		{
			doc := oWord.Documents(A_Index)
			path := doc.Path
			if (path = "")
				return
			fullname := doc.FullName
			
			SplitPath, fullname, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			doc.Save
			FileGetSize, size_org, % fullname
			size := table[fullname]
			if (size_org != size)
			{
				FormatTime, TimeString, , yyyyMMddHHmmss
				copyname := % AutosaveFilePath . OutNameNoExt . "_" . TimeString . "." . OutExtension
				FileCopy, % fullname, % copyname
				FileGetSize, size, % copyname
				table[fullname] := size
			}
			
		}
	}
	catch
	{
		; try again in 5 seconds
		SetTimer, AutoSave, 5000
		return
	}
	; reset the timer in case it was changed by catch
	SetTimer, AutoSave, % interval
	oWord := ""
	doc := ""
	return
}

InitAutosaveFilePath(path)
{
	if !FileExist(path)
		FileCreateDir, % path
	return true
}

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AutoTemplate:
	oWord := ComObjActive("Word.Application")
	try
		template := oWord.ActiveDocument.CustomDocumentProperties["PopSzab"].Value
	catch
	{
		oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
		template := oWord.ActiveDocument.CustomDocumentProperties["PopSzab"].Value
	}
	if ((template == "PL") or (template == "EN"))
	{
		gosub, AddTemplate
	}
	else
		gosub, ChooseTemplate
	return
	
AddTemplate:

	if !(FileExist("S:\"))
	{
		MsgBox,16,, Unable to add template. To continue, connect to voestalpine servers and try again.
		oWord := ""
		return
	}
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (template == "PL")
	{
		if (OurTemplate == OurTemplatePL)
		{
			oWord := ""
			
		}
		else
		{
			oWord.ActiveDocument.AttachedTemplate := OurTemplatePL
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % MsgText("Dołączono szablon!`nDołączono domyślny szablon dokumentu: `n") oWord.ActiveDocument.AttachedTemplate.FullName, 5
			OurTemplate := OurTemplatePL
		}
	}
	else if (template == "EN")
	{
		if (OurTemplate == OurTemplateEN)
		{
			oWord := ""
			
		}
		else
		{
			oWord.ActiveDocument.AttachedTemplate := OurTemplateEN
			oWord.ActiveDocument.UpdateStylesOnOpen :=  WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % MsgText("Dołączono szablon!`nDołączono domyłlny szablon dokumentu: `n") oWord.ActiveDocument.AttachedTemplate.FullName, 5
			OurTemplate := OurTemplateEN
		}
	}
	oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
	MsgBox, 36,, Do you want to set size of the margins?
	IfMsgBox, Yes
	{
		oWord := ComObjActive("Word.Application")
		oWord.Run("!Wydruk")
	}
	MsgBox, 36,, Do you want to add some building blocks to your document?
	IfMsgBox, Yes
		gosub, AddBB
	oWord := ""
	return

ChooseTemplate:
	MsgBox, 36,, Do you want to add a template to this document?
	IfMsgBox, Yes
	{
		Gui, Temp:New
		Gui, Temp:Add, Text,, Choose template:
		Gui, Temp:Add, Radio, vMyTemplate Checked, Polish template
		Gui, Temp:Add, Radio,, English template
		Gui, Temp:Add, Button, w200 gTempOK Default, OK
		Gui, Temp:Show,, Add Template
	}
	return

TempOK:
	Gui, Temp:Submit, +OwnDialogs
	if (MyTemplate == 1)
	{
		template := "PL"
	}
	else if (MyTemplate == 2)
	{
		template := "EN"
	}
	gosub, AddTemplate
	return
	
AddBB:
	Gui, BB:New
	Gui, BB:Add, Text,, Choose building blocks you want to add:
	Gui, BB:Add, Checkbox, vFirstPage, First Page
	Gui, BB:Add, Checkbox, vID, ID
	Gui, BB:Add, Checkbox, vChangeLog, Change Log
	Gui, BB:Add, Checkbox, vTOC, Table of Contents
	Gui, BB:Add, Checkbox, vLOT, List of Tables
	Gui, BB:Add, Checkbox, vLOF, List of Figures
	Gui, BB:Add, Checkbox, vIntro, Introduction
	Gui, BB:Add, Checkbox, vLastPage, Last Page
	Gui, BB:Add, Button, w200 gBBOK Default, OK
	oWord.Run("AddDocProperties")
	Gui, BB:Show,, Add Building Blocks
return
	
BBOK:
	Gui, BB:Submit, +OwnDialogs
	Gui, BB:Destroy
	if (FirstPage == 1)
		BB_Insert("Strona ozdobna", "")
	if (ID == 1)
		BB_Insert("identyfikator", "")
	if (ChangeLog == 1)
		BB_Insert("Lista zmian", "")
	if (TOC == 1)
	{
		BB_Insert("Spis treści", "")
		Send, {Right}{Enter}{Enter}
	}
	if (LOT == 1)
	{
		BB_Insert("Spis tabel", "")
		Send, {Right}{Enter}{Enter}
	}
	if (LOF == 1)
	{
		BB_Insert("Spis rysunków", "")
		Send, {Right}{Enter}{Enter}
	}
	if (Intro == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.ActiveDocument.Bookmarks.Add("intro", oWord.Selection.Range)
		Send, {Enter}{Enter}
	}
	if (LastPage == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.InsertBreak(wdSectionBreakNextPage := 2)
		BB_Insert("OstatniaStronaObrazek", "")
	if (Intro == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.GoTo(-1,,,"intro")
		oWord.Selection.Find.ClearFormatting
		oWord.ActiveDocument.Bookmarks("intro").Delete
	}
	}
return