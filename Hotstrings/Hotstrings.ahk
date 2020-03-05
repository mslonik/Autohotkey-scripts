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

; --------------- SECTION OF GLOBAL VARIABLES -----------------------------
;~ WordTrue := -1
;~ WordFalse := 0
MyHotstring 		:= ""
English_USA 		:= 0x0409   ; see AutoHotkey help: Language Codes
; --------------- END OF GLOBAL VARIABLES SECTION ----------------------

; - - - - - - - - - - - Set of default web pages - - - - - - - - - - - - - - - - - 
;~ Run, https://solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx ; voestalpine Signaling Siershahn, Cooperation Platform Sopot

; - - - - - - - - - - - SECTION DEDICATED TO  Maciej Słojewski's specific hardware AND PREFERENCES - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - -

if (A_ComputerName = "2277NB010" && A_UserName = "V523580") 
	SetDefaultKeyboard(English_USA)

#if (A_ComputerName = "2277NB010" && A_UserName = "V523580") ; Maciej Słojewski only
;~ #if (A_ComputerName = "fik" && A_UserName = "V523580") ; Maciej Słojewski only

;~ Currently, all special Alt-tab actions must be assigned directly to a hotkey as in the examples above (i.e. they cannot be used as though they were commands). They are not affected by #IfWin or #If.
;~ MButton::AltTabMenu
;~ WheelDown::AltTab
;~ WheelUp::ShiftAltTab

	Ralt::AppsKey ; redirects AltGr -> context menu
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

F13:: ; switching beetween windows of Word; author: Taran VH
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
return

F14:: ; switching between tabs of Chrome; author: Taran VH
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

;~ F15:: ; Reserved for CopyQ
;~ return

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

; - - - - - - - - - - - - - - - - - - - - -  Hotstrings: Personal: Ctrl + Shift F9 - - - - - - - - - - - - - - - - - - - - - - - - -
:*:dd::
	MyHotstring := "Dzień dobry`,"
	Send, {Text}%MyHotstring%
	;~ Send, %MyHotstring%
	;~ MsgBox, % "Are the strings Unicode? " . A_IsUnicode . " File encoding: " . A_FileEncoding . " Language: " . A_Language
	Send, {Shift Down}{Enter 2}{Shift Up}
return

:*:p ms::
	MyHotstring := "Pozdrawia ms"
	Send, %MyHotstring%
return

:*:m.::
	MyHotstring := "Maciej"
	Send, %MyHotstring%
return

:*:s.::
	MyHotstring := "Słojewski"
	Send, {Text}%MyHotstring%
return

:C:tel::
	MyHotstring := "{+}48 601 403 775"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:ms.::
	MyHotstring := "Maciej Słojewski"
	Send, {Text}%MyHotstring%
return

:b0*:m@2::
	MyHotstring := "{BackSpace 16}mslonik.pl"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*b0:m@::
	MyHotstring := "{BackSpace 2}maciej.slojewski@voestalpine.com"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:zws::
	MyHotstring := "Z wyrazami szacunku`, Maciej Słojewski"
	Send, {Text}%MyHotstring%
return

:*:kr`t::
	MyHotstring := "Kind regards`, Maciej Słojewski"
	Send, {Text}%MyHotstring%
return

:*:dw.::
	MyHotstring1 := "Do wiadomości."
	Send, {Text}%MyHotstring1%
	Send, {Enter 2}
	MyHotstring2 := "Pozdrawia ms"
	Send, %MyHotstring2%
	MhHotstring := MyHotstring1 . MyHotstring2
return

:*:v.::
	MyHotstring := "V523580"
	Send, {Text}%MyHotstring%
return

^+F9::
MsgBox, 64, Hotstrings: Personal, 
(
dd	→  Dzień dobry`,
p ms	→ Pozdrawia ms
m.	→ Maciej
s.	→ Słojewski
tel	→ +48 601 403 775
ms.	→ Maciej Słojewski
m@2	→ maciej.slojewski@mslonik.pl
m@	→ maciej.slojewski@voestalpine.com
zws	→ Z wyrazami szacunku`, Maciej Słojewski
kr<tab>	→ Kind regards`, Maciej
)
return

; - - - - - - - - - - - - - - - - - - - - - Hotstrings: voestalpine: Ctrl + Shift + F10 - - - - - - - - - - - - - - - - - - - - - - - - -
:*:axmpl.::
	MyHotstring := "moduł uniwersalny"
	Send, %MyHotstring%
return

:*:axmen.::
	MyHotstring := "universal module"
	Send, %MyHotstring%
return

:b0*x:axm::
	MyHotstring := "{BackSpace 3}AXM"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)		
return


:*:axmrpl.::
	MyHotstring := "moduł uniwersalny rozszerzony o wyjścia przekaźnikowe"
	Send, %MyHotstring%
return

:*:axmren.::
	MyHotstring := "universal module extended with relay outputs"
	Send, %MyHotstring%
return

::axmr::
	MyHotstring := "AXM^=R^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)
return


:*:axmiopl.::
	MyHotstring := "moduł uniwersalny rozszerzony o wejścia i wyjścia binarne"
	Send, %MyHotstring%
return

:*:axmioen.::
	MyHotstring := "universal module extended with binary inputs and outputs"
	Send, %MyHotstring%
return

::axmio::
	MyHotstring := "AXM^=IO^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)	
return


:*:axma::
	MyHotstring := "AXM{Space}/{Space}AXM^=R^={Space}/{Space}AXM^=IO^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{Space\}", Replacement := " `", MyHotStringLength := "", Limit := 4, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 4, StartingPosition := 1)	
return

:b0*x:axmp.::
	MyHotstring := "{BackSpace 5}AXM,{Space}AXM^=R^=,{Space}AXM^=IO^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*5\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\{Space\}", Replacement := " `", MyHotStringLength := "", Limit := 2, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 4, StartingPosition := 1)		
return

:*:nout::
	MyHotstring := "{U+223C}OUT"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)	
return


:*:cok.::
	MyHotstring := "czujnik koła"
	Send, %MyHotstring%
return

::cok::
	MyHotstring := "COK"
	Send, %MyHotstring%
return

:*:wsu.::
	MyHotstring := "wheel sensor unit"
	Send, %MyHotstring%
return

::wsu::
	MyHotstring := "WSU"
	Send, %MyHotstring%
return


:*:ihd1::
	MyHotstring := "I^=HD1^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)
return

:*:ihd2::
	MyHotstring := "I^=HD2^="
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)	
return


:*:hd1en.::
	MyHotstring := "HD1 (the 1st head of wheel sensor)"
	Send, %MyHotstring%
return

:*:hd2en.::
	MyHotstring := "HD2 (the 2nd head of wheel sensor)"
	Send, %MyHotstring%
return

:*:hd1pl.::
	MyHotstring := "HD1 (pierwsza głowica czujnika koła)"
	Send, %MyHotstring%
return

:*:hd2pl.::
	MyHotstring := "HD2 (druga głowica czujnika koła)"
	Send, %MyHotstring%
return


:*:uniacpl.::
	MyHotstring := "(uniwersalny) system liczenia osi"
	Send, %MyHotstring%
return

:*:uniacen.::
	MyHotstring := "(universal) axle counting system"
	Send, %MyHotstring%
return

:b0*x:uniac::
	MyHotstring := "{BackSpace 5}UniAC"
	Send, %MyHotstring%
return


:*:uniac2pl.::
	MyHotstring := "(uniwersalny) system liczenia osi drugiej generacji"
	Send, %MyHotstring%
return

:*:uniac2en.::
	MyHotstring := "(universal) axle counting system of 2nd generation"
	Send, %MyHotstring%
return

:b0x:uniac2::
	MyHotstring := "{BackSpace 7}UniAC[2]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:*:uniac1pl.::
	MyHotstring := "(uniwersalny) system liczenia osi pierwszej generacji"
	Send, %MyHotstring%
return

:*:uniac1en.::
	MyHotstring := "(universal) axle counting system of 1st generation"
	Send, %MyHotstring%
return

:b0x:uniac1::
	MyHotstring := "{BackSpace 7}UniAC[1]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:*:uniacxpl.::
	MyHotstring := "rodzina uniwersalnych systemów liczenia osi"
	Send, %MyHotstring%
return

:*:uniacxen.::
	MyHotstring := "family of universal axle counting system"
	Send, %MyHotstring%
return

:b0x:uniacx::
	MyHotstring := "{BackSpace 7}UniAC[x]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:*:unias1ppl.::
	MyHotstring := "(uniwersalny) czujnik koła typu UniAS[1{+}]"
	Send, %MyHotstring%
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

:*:unias1pen.::
	MyHotstring := "(universal) UniAS[1{+}] type wheel sensor"
	Send, %MyHotstring%
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

:b0:unias1p::
	MyHotstring := "{BackSpace 8}UniAS[1{+}]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*8\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return


:*:unias2ipl.::
	MyHotstring := "(uniwersalny) czujnik koła typu UniAS[2i]"
	Send, %MyHotstring%
return

:*:unias2ien.::
	MyHotstring := "(universal) UniAS[2i] type wheel sensor"
	Send, %MyHotstring%
return

:b0x:unias2i::
	MyHotstring := "{BackSpace 8}UniAS[2i]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:unias1pl.::
	MyHotstring := "(uniwersalny) czujnik koła typu UniAS[1]"
	Send, %MyHotstring%
return

:*:unias1en.::
	MyHotstring := "(universal) UniAS[1] type wheel sensor"
	Send, %MyHotstring%
return

:b0x:unias1::
	MyHotstring := "{BackSpace 7}UniAS[1]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:unias2pl.::
	MyHotstring := "(uniwersalny) czujnik koła typu UniAS[2]"
	Send, %MyHotstring%
return

:*:unias2en.::
	MyHotstring := "(universal) UniAS[2] type wheel sensor"
	Send, %MyHotstring%
return

:b0x:unias2::
	MyHotstring := "{BackSpace 7}UniAS[2]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:uniasxpl.::
	MyHotstring := "rodzina (uniwersalnych) czujników osi"
	Send, %MyHotstring%
return

:*:uniasxen.::
	MyHotstring := "(universal) wheel sensor family"
	Send, %MyHotstring%
return

:b0:uniasx::
	MyHotstring := "{BackSpace 7}UniAS[x]"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:uniaspl.::
	MyHotstring := "(uniwersalny) czujnik koła"
	Send, %MyHotstring%
return

:*:uniasen.::
	MyHotstring := "(universal) wheel sensor"
	Send, %MyHotstring%
return

:b0x:unias::
	MyHotstring := "{BackSpace 6}UniAS"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:unircpl.::
	MyHotstring := "(uniwersalny) uchwyt czujnika koła"
	Send, %MyHotstring%
return

:*:unircen.::
	MyHotstring := "(universal) wheel sensor rail clamp"
	Send, %MyHotstring%
return

::unirc::
	MyHotstring := "UniRC"
	Send, %MyHotstring%
return


:*:azcpl.::
	MyHotstring := "moduł ochrony przeciwprzepięciowej dedykowany dla rodziny czujników osi UniAS[x]"
	Send, %MyHotstring%
return

:*:azcen.::
	MyHotstring := "surge protection module dedicated for UniAS[x] wheel sensor family"
	Send, %MyHotstring%
return

::azc::
	MyHotstring := "AZC"
	Send, %MyHotstring%
return


:*:magpl.::
	MyHotstring := "magistrala"
	Send, %MyHotstring%
return

:*:magen.::
	MyHotstring := "backplane"
	Send, %MyHotstring%
return

:b0:mag::
	MyHotstring := "{BackSpace 4}MAG"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return


:*:magsacpl.::
	MyHotstring := "zintegrowany moduł diagnostyczny, komunikacyjny i zasilający"
	Send, %MyHotstring%
return

:*:magsacen.::
	MyHotstring := "integrated diagnostic, communication and voltage supply module"
	Send, %MyHotstring%
return

:*:header.::
	MyHotstring := "integrated diagnostic, communication and voltage supply module"
	Send, %MyHotstring%
return


::magsac::
	MyHotstring := "MAG_SAC (MAGSUP {+} MAG_ADM {+} MAG_COM)"
	Send, %MyHotstring%
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

::magsak::
	MyHotstring := "MAG_SAC (MAGSUP {+} MAG_ADM {+} MAG_COM)"
	Send, %MyHotstring%
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return


:*:magsuppl.::
	MyHotstring := "moduł zasilający"
	Send, %MyHotstring%
return

:*:magsupen.::
	MyHotstring := "voltage supply module"
	Send, %MyHotstring%
return

::magsup::
	MyHotstring := "MAG_SUP"
	Send, %MyHotstring%
return


:*:magadmen.::
	MyHotstring := "basic diagnostic module"
	Send, %MyHotstring%
return

:*:magadmpl.::
	MyHotstring := "moduł podstawowej diagnostyki"
	Send, %MyHotstring%
return

::magadm::
	MyHotstring := "MAG_ADM"
	Send, %MyHotstring%
return


:*:admpl.::
	MyHotstring := "moduł rozszerzonej diagnostyki"
	Send, %MyHotstring%
return

:*:admen.::
	MyHotstring := "extended diagnostics module"
	Send, %MyHotstring%
return

::adm::
	MyHotstring := "ADM"
	Send, %MyHotstring%
return


:*:mrupl.::
	MyHotstring := "moduł rozszerzonej diagnostyki"
	Send, %MyHotstring%
return

:*:mruen.::
	MyHotstring := "module rack unit"
	Send, %MyHotstring%
return

::mru::
	MyHotstring := "MRU"
	Send, %MyHotstring%
return

:*:asmpl.::
	MyHotstring := "moduł oceniający"
	Send, %MyHotstring%
return

:*:asmen.::
	MyHotstring := "evaluation module"
	Send, %MyHotstring%
return

::asm::
	MyHotstring := "ASM"
	Send, %MyHotstring%
return


:*:acmpl.::
	MyHotstring := "moduł liczący"
	Send, %MyHotstring%
return

:*:acmen.::
	MyHotstring := "counting module"
	Send, %MyHotstring%
return

::acm::
	MyHotstring := "ACM"
	Send, %MyHotstring%
return


:*:aimpl.::
	MyHotstring := "moduł wejść / wyjść"
	Send, %MyHotstring%
return

:*:aimen.::
	MyHotstring := "inputs and outputs module"
	Send, %MyHotstring%
return

::aim::
	MyHotstring := "AIM"
	Send, %MyHotstring%
return


:*:abmpl.::
	MyHotstring := "kaseta"
	Send, %MyHotstring%
return

:*:abmen.::
	MyHotstring := "module rack"
	Send, %MyHotstring%
return

::abm::
	MyHotstring := "ABM"
	Send, %MyHotstring%
return



:*:anszuapl.::
	MyHotstring := "system zarządzania usługami"
	Send, {Text}%MyHotstring%
return

::anszua::
	MyHotstring := "AnSzuA"
	Send, %MyHotstring%
return


:*:uniblpl.::
	MyHotstring := "system (uniwersalnej) blokady liniowej"
	Send, %MyHotstring%
return

:*:uniblen.::
	MyHotstring := ""
	Send, %MyHotstring%
return

::unibl::
	MyHotstring := "UniBL"
	Send, %MyHotstring%
return


:*:dsat.::
	MyHotstring := "detekcja Stanów Awaryjnych Taboru"
	Send, {Text}%MyHotstring%
return

::dsat::
	MyHotstring := "dSAT"
	Send, %MyHotstring%
return


:*:asdek.::
	MyHotstring := "automatyczny system detekcji i eksploatacji kół pojazdów kolejowych"
	Send, {Text}%MyHotstring%
return

::asdek::
	MyHotstring := "ASDEK"
	Send, %MyHotstring%
return


:*:s2d.::
	MyHotstring := "szlakowy system diagnostyki"
	Send, %MyHotstring%
return

::s2d::
	MyHotstring := "SSD"
	Send, %MyHotstring%
return


:*:gotcha::GOTCHA
:*:phoenix::PHOENIX
::pm::PM

:*:dp.::
	MyHotstring := "Dział Produkcji i Zaopatrzenia"
	Send, {Text}%MyHotstring%
return

::dp::
	MyHotstring := "DPiZ"
	Send, %MyHotstring%
return

:*:dpiz.::
	MyHotstring := "Dział Produkcji i Zaopatrzenia"
	Send, {Text}%MyHotstring%
return

::dpiz::
	MyHotstring := "DPiZ"
	Send, %MyHotstring%
return


:*:du.::
	MyHotstring := "Dział Usług i Realizacji"
	Send, %MyHotstring%
return

::du::
	MyHotstring := "DUiR"
	Send, %MyHotstring%
return

:*:duir.::
	MyHotstring := "Dział Usług i Realizacji"
	Send, %MyHotstring%
return

::duir::
	MyHotstring := "DUiR"
	Send, %MyHotstring%
return


:*:dr.::
	MyHotstring := "Dział Rozwoju"
	Send, %MyHotstring%
return

::dr::
	MyHotstring := "DR"
	Send, %MyHotstring%
return


:*:wim.::
	MyHotstring := "Weighing in Motion"
	Send, %MyHotstring%
return

::wim::
	MyHotstring := "WIM"
	Send, %MyHotstring%
return

:*:wdd.::
	MyHotstring := "Wheel Defect Detection"
	Send, %MyHotstring%
return

::wdd::
	MyHotstring := "WDD"
	Send, %MyHotstring%
return

:*:hbd.::
	MyHotstring := "Hot-Box Detector"
	Send, %MyHotstring%
return

::hbd::
	MyHotstring := "HBD"
	Send, %MyHotstring%
return

:*:hwd.::
	MyHotstring := "Hot-Wheel Detector"
	Send, %MyHotstring%
return

::hwd::
	MyHotstring := "HWD"
	Send, %MyHotstring%
return

:*:mb.::
	MyHotstring := "Multi Beam"
	Send, %MyHotstring%
return

::mb::
	MyHotstring := "MB"
	Send, %MyHotstring%
return

:*:mds.::
	MyHotstring := "Modular Diagnostic System"
	Send, %MyHotstring%
return

::mds::
	MyHotstring := "MDS"
	Send, %MyHotstring%
return

:b0o:vo::
	MyHotstring := "estalpine"
	Send, %MyHotstring%
return

:*b0:voe::
	MyHotstring := "stalpine Signaling Sopot"
	Send, %MyHotstring%
return

:*b0:voes::
	MyHotstring := "{BackSpace} Sp. z o.o."
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
return

:z*b0:voesi::
	MyHotstring := "{Backspace 17}Siershahn"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
return

:*:si.::
	MyHotstring := "Siershahn"
	Send, %MyHotstring%
return

:*:so.::
	MyHotstring := "Sopot"
	Send, %MyHotstring%
return

:*:sai.::
	MyHotstring := "Sainerholz"
	Send, %MyHotstring%
return


:*:nipv.::
	MyHotstring := "584-025-39-29"
	Send, %MyHotstring%
return

:*:adres.::
	MyHotstring := "Jana z Kolna 26c, 81-859 Sopot, Polska"
	Send, %MyHotstring%
return

:*:addres2.::
	MyHotstring := "Jana z Kolna 26c, 81-859 Sopot, Poland"
	Send, %MyHotstring%
return

:*:hpir.::
	MyHotstring := "Hardware Prototype Implementation Report"
	Send, %MyHotstring%
return

::hpir::
	MyHotstring := "HPIR"
	Send, %MyHotstring%
return

:*:rnd.::
	MyHotstring := "Research & Development"
	Send, %MyHotstring%
return

::rnd::
	MyHotstring := "R&D"
	Send, %MyHotstring%
return

;~ - - - - - - - - - - - - - - - - - - - - links url urls - - - - - - -  - - - - - - - - -

::cps::
	MyHotstring := "Cooperation Platform Sopot (https://solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx)"
	Send, %MyHotstring%
return

::muk::
	MyHotstring := "MDS Upgrade Kit (https://solidsystemteamwork.voestalpine.root.local/Processes/custprojects/780MDSUpgradeKit/SitePages/Home.aspx)"
	Send, %MyHotstring%
return

::sps::
	MyHotstring := """Documentation Sharepoint Sopot"" (https://team.voestalpine.net/site/4077/default.aspx)"
	Send, %MyHotstring%
return


^+F10::
	MsgBox, 64, Hotstrings: voestalpine, 
(
axm	→ AXM						axmpl.	→ moduł uniwersalny					axmen.	→ universal module
axmr	→ AXM^=R^= (in MS Word: with subscript R)		axmrpl.	→ moduł uniwersalny z wyjściami przekaźnikowymi		axmren.	→ universal module with relay outputs
axmio	→ AXM^=IO^= (in MS Word: with subscript R)		axmiopl.	→ moduł uniwersalny z wejściami i wyjściami binarnymi		axmioen. → universal module with binary inputs and outputs

axma	→ AXM / AXM^=R^= / AXM^=IO^= (in MS Word: with subscripts)		axmp.	→ AXM, AXM^=R^=, AXM^=IO^= (in MS Word: with subscripts)

nout	→ {U+223C}OUT

cok	→ COK			cok.	→ czujnik koła				wsu	→ WSU			wsu.	→ wheel sensor unit

ihd1	→ I^=HD1^= (in MS Word: with buscripts)		ihd2	→ I^=HD2^= (in MS Word: with buscripts)
hd1en.	→ HD1 (the 1st head of wheel sensor)		hd2en.	→ HD2 (the 2nd head of wheel sensor)
hd1pl.	→ HD1 (pierwsza głowica czujnika koła)		hd2pl.	→ HD2 (druga głowica czujnika koła)

uniac	→ UniAC					uniacpl.	→ (uniwersalny) system liczenia osi				uniacen.	→ (universal) axle counting system
uniac2	→ UniAC[2]				uniac2pl.	→ (uniwersalny) system liczenia osi drugiej generacji		uniac2en.	→ (universal) axle counting system of 2nd generation
uniac1	→ UniAC[1]				uniac1pl.	→ (uniwersalny) system liczenia osi pierwszej generacji		uniac1en.	→ (universal) axle counting system of 1st generation
uniacx	→ UniAC[x]				uniacxpl.	→ rodzina uniwersalnych systemów liczenia osi		uniacxen.	→ family of universal axle counting system

unias1p	→ UniAS[1+]				unias1ppl.	→ (uniwersalny) czujnik koła typu UniAS[1{+}]		unias1pen.	→ (universal) UniAS[1{+}] type wheel sensor
unias2i	→ UniAS[2i]				unias2ipl.	→ (uniwersalny) czujnik koła typu UniAS[2i]		unias2ien.	→ (universal) UniAS[2i] type wheel sensor
unias1	→ UniAS[1]				unias1pl.		→ (uniwersalny) czujnik koła typu UniAS[1]		unias1en.	→ (universal) UniAS[1] type wheel sensor
unias2	→ UniAS[2]				unias2pl.		→ (uniwersalny) czujnik koła typu UniAS[2]		unias2en.	→ (universal) UniAS[2] type wheel sensor
uniasx	→ UniAS[x]				uniasxpl.		→ rodzina (uniwersalnych) czujników osi		uniasxen.	→ (universal) wheel sensor family
unias	→ UniAS					uniaspl.		→ (uniwersalny) czujnik koła			uniasen.	→ (universal) wheel sensor

unirc	→ UniRC				unircpl.	→ (uniwersalny) uchwyt czujnika koła		unircen.	→ (universal) wheel sensor rail clamp

azc	→ AZC				azcpl.	→ moduł ochrony przeciwprzepięciowej dedykowany dla rodziny czujników osi UniAS[x]		azcen.	→ surge protection module dedicated for UniAS[x] wheel sensor family
mag	→ MAG				magpl.	→ magistrala		magen.	→ backplane
magsacpl.	→ zespolony moduł diagnostyczny i zasilający		magsacen.	→ combined diagnostic and voltage supply module
magsac	→ MAG_SAC (MAG_SUP {+} MAG_ADM)		magsak	→ MAG_SAC (MAG_SUP {+} MAG_ADM)
magsup	→ MAG_SUP				magsuppl.	→ moduł zasilający		magsupen.	→ voltage supply module
magadm	→ MAG_ADM				magadmen.	→ basic diagnostic module		magadmpl.	→ moduł podstawowej diagnostyki
adm	→ ADM				admpl.	→ moduł rozszerzonej diagnostyki		admen.	→ extended diagnostics module

asm	→ ASM				asmpl.	→ moduł oceniający		asmen.	→ evaluation module
acm	→ ACM				acmpl.	→ moduł liczący			acmen.	→ counting module
aim	→ AIM				aimpl.	→ moduł wejść / wyjść		aimen.	→ inputs and outputs module

:*:anszuapl.::system zarządzania usługami
::anszua::AnSzuA

unibl	→ UniBL				uniblpl.	→ system (uniwersalnej) blokady liniowej

dsat	→ dSAT				dsat.	→ detekcja Stanów Awaryjnych Taboru
asdek	→ ASDEK				asdek.	→ automatyczny system detekcji i eksploatacji kół pojazdów kolejowych
s2d	→ SSD				s2d.	→ szlakowy system diagnostyki

gotcha	→ GOTCHA
phoenix	→ PHOENIX
pm	→ PM

dp.	→ Dział Produkcji i Zaopatrzenia				dpiz.	→ Dział Produkcji i Zaopatrzenia
dp	→ DPiZ							dpiz	→ DPiZ
du.	→ Dział Usług i Realizacji					duir.	→ Dział Usług i Realizacji
duir	→ DUiR							du	 → DUiR
dr	→ DR							dr.	→ Dział Rozwoju

wim.		→ Weighing in Motion				wim		→ WIM		
wdd		→ WDD						wdd.		→ Wheel Defect Detection
hbd		→ HBD						hbd.		→ Hot-Box Detector
hwd		→ HWD						hwd.		→ Hot-Wheel Detector
mb		→ MB						mb.		→ Multi Beam
mds		→ MDS						mds.		→ Modular Diagnostic System

vo		→ voestalpine					voe		→ voestalpine Signaling Sopot
voes		→ voestalpine Signaling Sopot Sp. z o.o.		voesi		→ voestalpine Signaling Siershahn

sie		→ Siershahn					so.		→ Sopot

nip.		→ 584-025-39-29
adres.		→ Jana z Kolna 26c, 81-859 Sopot, Polska		addres2.		→ Jana z Kolna 26c, 81-859 Sopot, Poland
)
return

; - - - - - - - - - - - - - - - - - - - - -  Physics, Mathematics and Other Symbols: Ctrl + Shift + F11 - - - - - - - - - - - - - - - - - - - - - - - - -
:*:ohm::	; electric resistance
	MyHotstring := "{U+2126}"
	;~ MsgBox, % "{U+2126}: " . Chr(0x2126) . " Długość: " . StrLen(MyHotstring) . " A_ThisHotkey: " . A_ThisHotkey . " A_PriorHotkey: " . A_PriorHotkey
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)	
return

:*:kohm::	; electric resistance
	MyHotstring := "k{U+2126}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
return

:*:kv::
	MyHotstring := "kV"
	Send, %MyHotstring%
return

:*:mamp::
	MyHotstring := "mA"
	Send, %MyHotstring%
return

::kamp::
	MyHotstring := "kA"
	Send, %MyHotstring%
return

:*:+-::
	MyHotstring := "{U+00B1}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:-+::
	MyHotstring := "{U+00B1}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:plusminus::
	MyHotstring := "{U+00B1}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:minusplus::
	MyHotstring := "{U+00B1}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:oddo::			; from to
	MyHotstring := "{U+00F7}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:kropkam:: 		; multiplication in a form of small dot
	MyHotstring := "{U+00B7}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:mkropka::
	MyHotstring := "{U+00B7}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:>=::				; greater than
	MyHotstring := "{U+2265}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:większyrówny::	; greater than
	MyHotstring := "{U+2265}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:wiekszyrowny::	; greater than
	MyHotstring := "{U+2265}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:<=:: 			; less equal than
	MyHotstring := "{U+2264}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:mniejszyrówny:: 	; less equal than
	MyHotstring := "{U+2264}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:mniejszyrowny:: 	; less equal than
	MyHotstring := "{U+2264}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:~~::				; approximately
	MyHotstring := "{U+2248}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:approx.::				; approximately
	MyHotstring := "{U+2248}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:/=:: 			; not equal
	MyHotstring := "{U+2260}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:mminus::			; longer version of dash
	MyHotstring := "{U+2212}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:stopc:: 			; symbol of degree
	MyHotstring := "{U+00B0}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:deg.::			; symbol of degree
	MyHotstring := "{U+00B0}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

;~ :b0*x:<-::Send, {Backspace 2}{U+2190}		; arrow to the left
:b0*x:<-::		; arrow to the left
	MyHotstring := "{Backspace 2}{U+2190}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := " `", MyHotStringLength := "", Limit := 2, StartingPosition := 1)				
return

:*:^|::				; arrow up
	MyHotstring := "{U+2191}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:|^::				; arrow down
	MyHotstring := "{U+2193}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:z*:<->::			; bi directional arrow
	MyHotstring := "{U+2194}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:b0*x:->:: 		; arrow to the right
	MyHotstring := "{Backspace 2}{U+2192}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := " `", MyHotStringLength := "", Limit := 2, StartingPosition := 1)				
return


:*:alpha.::			; Greek small letter alpha
	MyHotstring := "{U+03B1}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:beta.::			; Greek small letter beta
	MyHotstring := "{U+03B2}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:gamma.::			; Greek small letter gamma
	MyHotstring := "{U+03B3}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:epsilon.::			; Greek small letter epsilon
	MyHotstring := "{U+03B5}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:theta.::			; Greek small letter theta
	MyHotstring := "{U+03B8}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:micro.::			; Greek small letter theta
	MyHotstring := "{U+00b5}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:lambda.::			; Greek small letter lambda
	MyHotstring := "{U+03BB}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:pi.::				; Greek small letter pi
	MyHotstring := "{U+03C0}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:omega.::			; Greek small letter omega
	MyHotstring := "{U+03C9}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:delta.::			; Greek capital letter delta
	MyHotstring := "{U+2206}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:*:--::				; double dash
	MyHotstring := "{U+2500}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

:*:euro.::			; euro currency
	MyHotstring := "{U+20AC}"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return

^+F11::
	MsgBox, 64, Hotstrings: Physics & Mathematics, 
(
ohm	→  Ω				kohm	→  kΩ
mikro	→  µ
kv	→  kV
mamp	→  mA			kamp	→  kA

+-	→ ±	or: -+	→ ±	or: plusminus	→ ±	or minusplus	±
oddo	→ ÷
kropkam	→ ·	or: mkropka	→ ·
>=	→ ≥	or: większyrówny	→ ≥	or: wiekszyrowny	→ ≥
<=	→ ≤	or: mniejszyrówny	→ ≤	or: mniejszyrowny	→ ≤
~~	→ ≈
/=	→ ≠
mminus	→ ─
stopc	→ °	or: deg.	→ °

<-	→ ←
^|	→ ↑
|^	→ ↓
<->	→↔
->	→ →`

alpha.	→ α			
beta.	→ β
gamma.	→ γ
epsilon.	→ ε
theta.	→ θ
lambda.	→ λ
pi.	→ π
omega.	→ ω
delta.	→ ∆

--	→ ─
euro.	→ €
)
return

; ───────────────────────────────────── Abbreviations: Ctrl + Shift + F12 ────────────────────
:*:ram.::
	MyHotstring := "Reliability, Availability, Maintainability"
	Send, %MyHotstring%
return

:o:ram::
	MyHotstring := "RAM"
	Send, %MyHotstring%
return

:*:rams.::
	MyHotstring := "Reliability, Availability, Maintainability and Safety"
	Send, %MyHotstring%
return

:o:rams::
	MyHotstring := "RAMS"
	Send, %MyHotstring%
return

:*:qrams.::
	MyHotstring := "Quality, Reliability, Availability, Maintainability, Safety"
	Send, %MyHotstring%
return

::qrams::
	MyHotstring := "QRAMS"
	Send, %MyHotstring%
return

:*:mdt.::
	MyHotstring := "Mean Down Time"
	Send, %MyHotstring%
return

::mdt::
	MyHotstring := "MDT"
	Send, %MyHotstring%
return


:*:mtbf.::
	MyHotstring := "Mean Time Between Failures"
	Send, %MyHotstring%
return

::mtbf::
	MyHotstring := "MTBF"
	Send, %MyHotstring%
return

:*:mttr.::
	MyHotstring := "Mean Time To Restore"
	Send, %MyHotstring%
return

::mttr::
	MyHotstring := "MTTR"
	Send, %MyHotstring%
return

:*:mtbm.::
	MyHotstring := "Mean Time Between Maintainances"
	Send, %MyHotstring%
return

::mtbm::
	MyHotstring := "MTBM"
	Send, %MyHotstring%
return

:*:mttf.::
	MyHotstring := "Mean Time To Failure"
	Send, %MyHotstring%
return

::mttf::
	MyHotstring := "MTTF"
	Send, %MyHotstring%
return

:*:mut.::
	MyHotstring := "Mean Up Time"
	Send, %MyHotstring%
return

::mut::
	MyHotstring := "MUT"
	Send, %MyHotstring%
return

:*:sil.::
	MyHotstring := "Safety Integrity Level"
	Send, %MyHotstring%
return

::sil::
	MyHotstring := "SIL"
	Send, %MyHotstring%
return

:*:pcb.::
	MyHotstring := "Printed Circuit Board"
	Send, %MyHotstring%
return

::pcb::
	MyHotstring := "PCB"
	Send, %MyHotstring%
return

:*:ups.::
	MyHotstring := "Uninterruptable Power Supply"
	Send, %MyHotstring%
return

::ups::
	MyHotstring := "UPS"
	Send, %MyHotstring%
return

:*:usb.::
	MyHotstring := "Universal Serial Bus"
	Send, %MyHotstring%
return

::usb::
	MyHotstring := "USB"
	Send, %MyHotstring%
return

:*:iris.::
	MyHotstring := "International Railway Industry Standard for the evaluation of railway management systems"
	Send, %MyHotstring%
return

::iris::
	MyHotstring := "IRIS"
	Send, %MyHotstring%
return

:*:tsi.::
	MyHotstring := "Technical Specifications for Interoperability"
	Send, %MyHotstring%
return

::tsi::
	MyHotstring := "TSI"
	Send, %MyHotstring%
return

:*:faq.::
	MyHotstring := "Frequently Asked Questions"
	Send, %MyHotstring%
return

::faq::
	MyHotstring := "FAQ"
	Send, %MyHotstring%
return

:*:ahk.::
	MyHotstring := "AutoHotkey"
	Send, %MyHotstring%
return

::ahk::
	MyHotstring := "AHK"
	Send, %MyHotstring%
return

:b0*?z:.ahk::
return

:*:vba.::
	MyHotstring := "Visiual Basic for Applications"
	Send, %MyHotstring%
return

::vba::
	MyHotstring := "VBA"
	Send, %MyHotstring%
return

:*:hdmi.::
	MyHotstring := "High-Definition Multimedia Interface"
	Send, %MyHotstring%
return

::hdmi::
	MyHotstring := "HDMI"
	Send, %MyHotstring%
return

:*:emc.::
	MyHotstring := "Electro-Magnetic Compatibility"
	Send, %MyHotstring%
return

::emc::
	MyHotstring := "EMC"
	Send, %MyHotstring%
return

:*:hart.::
	MyHotstring := "Highway Addressable Remote Transducer Protocol"
	Send, %MyHotstring%
return

::hart::
	MyHotstring := "HART"
	Send, %MyHotstring%
return

:*:erp.::
	MyHotstring := "Enterprise Resource Planning"
	Send, %MyHotstring%
return

::erp::
	MyHotstring := "ERP"
	Send, %MyHotstring%
return

:*:c2ms.::
	MyHotstring := "Component Content Management System"
	Send, %MyHotstring%
return

::c2ms::
	MyHotstring := "CCMS"
	Send, %MyHotstring%
return

:*:lc2.::
	MyHotstring := "Life Cycle Cost"
	Send, %MyHotstring%
return

::lc2::
	MyHotstring := "LLC"
	Send, %MyHotstring%
return

:*:ceo.::
	MyHotstring := "Chief Executive Officer"
	Send, %MyHotstring%
return

::ceo::
	MyHotstring := "CEO"
	Send, %MyHotstring%
return

:*:hds.::
	MyHotstring := "Hardware Design Specification"
	Send, %MyHotstring%
return

::hds::
	MyHotstring := "HDS"
	Send, %MyHotstring%
return

:*:has.::
	MyHotstring := "Hardware Architecture Specification"
	Send, %MyHotstring%
return

::has::
	MyHotstring := "HAS" ; conflict with English
	Send, %MyHotstring%
return

:*:kpi.::
	MyHotstring := "Key Performance Indicator"
	Send, %MyHotstring%
return

::kpi::
	MyHotstring := "KPI"
	Send, %MyHotstring%
return

:*:gui.::
	MyHotstring := "Graphical User Interface"
	Send, %MyHotstring%
return

::gui::
	MyHotstring := "GUI"
	Send, %MyHotstring%
return

:*:etcs::
	MyHotstring := "European Train Control System"
	Send, %MyHotstring%
return

::etcs::
	MyHotstring := "ETCS"
	Send, %MyHotstring%
return

:*:ertms.::
	MyHotstring := "European Rail Traffic Management System"
	Send, %MyHotstring%
return

::ertms::
	MyHotstring := "ERTMS"
	Send, %MyHotstring%
return

:*:era.::
	MyHotstring := "European Railway Agency"
	Send, %MyHotstring%
return

::era::
	MyHotstring := "ERA"
	Send, %MyHotstring%
return

:*:fai.::
	MyHotstring := "First Article Inspection"
	Send, %MyHotstring%
return

::fai::
	MyHotstring := "FAI"
	Send, %MyHotstring%
return

:*:thr.::
	MyHotstring := "Tolerable Hazard Rate"
	Send, %MyHotstring%
return

::thr::
	MyHotstring := "THR"
	Send, %MyHotstring%
return

:*:dita.::
	MyHotstring := "Darwin Information Typing Architecture"
	Send, %MyHotstring%
return

::dita::
	MyHotstring := "DITA"
	Send, %MyHotstring%
return

:*:bom.::
	MyHotstring := "Bill of Materials"
	Send, %MyHotstring%
return

::bom::
	MyHotstring := "BOM"
	Send, %MyHotstring%
return

:*:ip.::
	MyHotstring := "IP Code, Ingress Protection code (https://en.wikipedia.org/wiki/IP_Code	)"
	Send, %MyHotstring%
return

::ip::
	MyHotstring := "IP"
	Send, %MyHotstring%
return

:*:lop.::
	MyHotstring := "List of Open Points"
	Send, %MyHotstring%
return

::lop::
	MyHotstring := "LoP"
	Send, %MyHotstring%
return

:*:srac.::
	MyHotstring := "Safety Related Application Condition"
	Send, %MyHotstring%
return

::srac::
	MyHotstring := "SRAC"
	Send, %MyHotstring%
return

:*:ga.::
	MyHotstring := "Generic Application"
	Send, %MyHotstring%
return

::ga::
	MyHotstring := "GA"
	Send, %MyHotstring%
return

:*:sa.::
	MyHotstring := "Specific Application"
	Send, %MyHotstring%
return

::ga::
	MyHotstring := "SA"
	Send, %MyHotstring%
return

:*:fat.::
	MyHotstring := "Factory Acceptance Test"
	Send, %MyHotstring%
return

::fat::
	MyHotstring := "FAT"
	Send, %MyHotstring%
return

:*:nda.::
	MyHotstring := "Non-Disclosure Agreement"
	Send, %MyHotstring%
return

::nda::
	MyHotstring := "NDA"
	Send, %MyHotstring%
return

:*:sla.::
	MyHotstring := "Service-Level Agreement"
	Send, %MyHotstring%
return

::sla::
	MyHotstring := "SLA"
	Send, %MyHotstring%
return

:*:tffr.::
	MyHotstring := "Tolerable Functional Failure Rate"
	Send, %MyHotstring%
return

::tffr::
	MyHotstring := "TFFR"
	Send, %MyHotstring%
return

::cop.::
	MyHotstring := "Code of Practice"
	Send, %MyHotstring%
return

:*:cop::
	MyHotstring := "COP"
	Send, %MyHotstring%
return

::cots.::
	MyHotstring := "Commercial Off-The-Shelf"
	Send, %MyHotstring%
return

:*:cots::
	MyHotstring := "COTS"
	Send, %MyHotstring%
return

::emi.::
	MyHotstring := "Electromagnetic Interference"
	Send, %MyHotstring%
return

:*:emi::
	MyHotstring := "EMI"
	Send, %MyHotstring%
return

::fracas.::
	MyHotstring := "Failure Reporting Analysis and Corrective Action System"
	Send, %MyHotstring%
return

:*:fracas::
	MyHotstring := "FRACAS"
	Send, %MyHotstring%
return

::fmea.::
	MyHotstring := "Failure Mode and Effects Analysis"
	Send, %MyHotstring%
return

:*:fmea::
	MyHotstring := "FMEA"
	Send, %MyHotstring%
return

::fmeca.::
	MyHotstring := "Failure Mode, Effects and Criticality Analysis"
	Send, %MyHotstring%
return

:*:fmeca::
	MyHotstring := "FMECA"
	Send, %MyHotstring%
return

::fta.::
	MyHotstring := "Fault Tree Analysis"
	Send, %MyHotstring%
return

:*:fta::
	MyHotstring := "FTA"
	Send, %MyHotstring%
return

::lad.::
	MyHotstring := "Logistic and Administrative Delay"
	Send, %MyHotstring%
return

:*:lad::
	MyHotstring := "LAD"
	Send, %MyHotstring%
return


; - - - - - - - - - - - - Polish section - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:*:dtr.::
	MyHotstring := "Dokumentacja Techniczno-Ruchowa"
	Send, %MyHotstring%
return

::dtr::
	MyHotstring := "DTR"
	Send, %MyHotstring%
return

:*:wtwio.::
	MyHotstring := "Warunki Techniczne Wytwarzania i Odbioru"
	Send, %MyHotstring%
return

::wtwio::
	MyHotstring := "WTWiO"
	Send, %MyHotstring%
return

:*:pkp.::
	MyHotstring := "Polskie Koleje Państwowe"
	Send, %MyHotstring%
return

::pkp::
	MyHotstring := "PKP"
	Send, %MyHotstring%
return

:*:plk.::
	MyHotstring := "Polskie Linie Kolejowe"
	Send, %MyHotstring%
return

::plk::
	MyHotstring := "PLK"
	Send, %MyHotstring%
return

:*:ik.::
	MyHotstring := "Instytut Kolejnictwa"
	Send, %MyHotstring%
return

::ik::
	MyHotstring := "IK"
	Send, %MyHotstring%
return

:*:pesel.::
	MyHotstring := "Powszechny Elektroniczny System Ewidencji Ludności"
	Send, %MyHotstring%
return

::pesel::
	MyHotstring := "PESEL"
	Send, %MyHotstring%
return

:*:utk.::
	MyHotstring := "Urząd Transportu Kolejowego"
	Send, %MyHotstring%
return

::utk::
	MyHotstring := "UTK"
	Send, %MyHotstring%
return

:*:bait.::
	MyHotstring := "Biuro Automatyki i Telekomunikacji"
	Send, %MyHotstring%
return

::bait::
	MyHotstring := "BAiT"
	Send, %MyHotstring%
return

:*:bhp.::
	MyHotstring := "Bezpieczeństwo i Higiena Pracy"
	Send, %MyHotstring%
return

::bhp::
	MyHotstring := "BHP"
	Send, %MyHotstring%
return

:*:srk.::
	MyHotstring := "(urządzenia) sterowania ruchem kolejowym"
	Send, %MyHotstring%
return

:*:nip.::
	MyHotstring := "Numer Identyfikacji Podatkowej"
	Send, %MyHotstring%
return

::nip::
	MyHotstring := "NIP"
	Send, %MyHotstring%
return

:*:ersat.::
	MyHotstring := "Elektroniczny Rejestr Stanów Awaryjnych Taboru"
	Send, %MyHotstring%
return

::ersat::
	MyHotstring := "ERSAT"
	Send, %MyHotstring%
return


; - - - - - - - - - - German section - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:*:tuv.::
	MyHotstring := "German: Technischer {U+00DC}berwachungsverein, English: Technical Inspection Association `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

::tuv::
	MyHotstring := "T{U+00DC}V `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

::sud::
	MyHotstring := "S{U+00DC}D `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return


:*:gmbh.::
	MyHotstring := "German: Gesellschaft mit beschränkter Haftung, English: company with limited liability `"
	Send, %MyHotstring%
return

::gmbh::
	MyHotstring := "GmbH `"
	Send, %MyHotstring%
return

:*:obb.::
	MyHotstring := "German: {U+00D6}sterreichische Bundesbahnen, English: Austrian Federal Railways `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)		
return

::obb::
	MyHotstring := "{U+00D6}BB `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return

:*:sbb.::
	MyHotstring := "German: Schweizerische Bundesbahnen, English: Swiss Federal Railways"
	Send, %MyHotstring%
return

::sbb::
	MyHotstring := "SBB"
	Send, %MyHotstring%
return


^+F12::
	MsgBox, 64, Hotstrings: Abbreviations, ram.	→ Reliability`, Availability`, Maintainability`nram	→ RAM`nrams.	→ Reliability`, Availability`, Maintainability and Safety`nrams:	→ RAMS`nqrams.	→ Quality`, Reliability`, Availability`, Maintainability`, Safety`nqrams	→ QRAMS`nmtbf.	→ Mean Time Between Failures`nmtbf	→ MTBF`nmttr.	→ Mean Time To Restore`nmttr	→ MTTR`nsil.	→ Safety Integrity Level`nsil	→ SIL`npcb.	→ Printed Circuit Board`npcb	→ PCB`ndtr.	→ Dokumentacja Techniczno-Ruchowa`ndtr	→ DTR`ndp.	→ Dział Produkcji i Zaopatrzenia`ndp	→ DPiZ`ndpiz.	→ Dział Produkcji i Zaopatrzenia`ndpiz	→ DPiZ`ndu.	→ Dział Usług i Realizacji`ndu	→ DUiR`nduir.	→ Dział Usług i Realizacji`nduir	→ DUiR`ndr	→ DR`nwtwio.	→ Warunki Techniczne Wytwarzania i Odbioru`nwtwio	→ WTWiO`npkp.	→ Polskie Koleje Państwowe`npkp	→ PKP`nplk.	→ Polskie Linie Kolejowe`nplk	→ PLK`nups.	→ Uninterruptable Power Supply`nups	→ UPS`nusb.	→ Universal Serial Bus`nusb	→ USB`nbhp.	→ Bezpieczeństwo i Higiena Pracy`nbhp	→ BHP`niris.	→ International Railway Industry Standard for the evaluation of railway management systems`niris	→ IRIS`ntsi.	→ Technical Specifications for Interoperability`ntsi	→ TSI`nfaq.	→ Frequently Asked Questions`nfaq	→ FAQ`nahk.	→ AutoHotkey`nahk	→ AHK`nvba.	→ Visiual Basic for Applications`nvba	→ VBA`nhdmi.	→ High-Definition Multimedia Interface`nhdmi	→ HDMI`nhbd.	→ Hot-Box Detector`nhbd	→ HBD`nhwd.	→ Hot-Wheel Detector`nhwd	→ HWD`nemc.	→ Electro-Magnetic Compatibility`nemc	→ EMC`nmb.	→ Multi Beam`nmb	→ MB`nmds.	→ Modular Diagnostic System`nmds	→ MDS`ntuv.	→ German: Technischer {U+00DC}berwachungsverein`, English: Technical Inspection Association`ntuv	→ T{U+00DC}V`nsud	→ S{U+00DC}D`ngmbh.	→ German: Gesellschaft mit beschränkter Haftung`, English: company with limited liability`ngmbh	→ GmbH`nhart.	→ Highway Addressable Remote Transducer Protocol`nhart	→ HART`npesel.	→ Powszechny Elektroniczny System Ewidencji Ludności`npesel	→ PESEL`nutk.	→ Urząd Transportu Kolejowego`nutk	→ UTK`nbait.	→ Biuro Automatyki i Telekomunikacji`nbait	→ BAiT`nerp.	→ Enterprise Resource Planning`nerp	→ ERP`nc2ms.	→ Component Content Management System ``nc2ms	→ CCMS`nlc2.	→ Life Cycle Cost ``nlc2	→ LLC`nobb.	→ German: {U+00D6}sterreichische Bundesbahnen`, English: Austrian Federal Railways`nobb	→ {U+00D6}BB`nsbb.	→  German: Schweizerische Bundesbahnen`, English: Swiss Federal Railways`nsbb	→ SBB
return

; - - - - - - - - - - - - - Section Date & Time - - - - - - - - - - - - - - - - - - - - - - - - - 

:*b0:d]::  ; This hotstring replaces "d]" with the current date and time via the commands below.
	FormatTime, CurrentDateTime,, yyyy-MM-dd  ; It will look like 2020-01-21 
	Send, {Backspace 2}%CurrentDateTime%
return

:*z:d]]::	; This hotstring is suitable for TC (Total Commander) only
	FormatTime, CurrentDateTime,, yyyyMMdd_
	Send, {Backspace 8}%CurrentDateTime%
return

:*:t]::
	FormatTime, CurrentDateTime,, Time
	Send %CurrentDateTime%
return

; ------------------ Section of first or second names with local diacritics ------------------------
#Include FirstAndSecondNames.ahk

; - - - - - - - - - - - - - - - - Emoticons - - - - - - - - - - - - - - - - - - - - - - - -
;~ https://unicode-table.com/en/
:*::).:: 		; smiling face U+1F642 :)
	MyHotstring := "{U+1F642} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-).::		; smiling face U+1F642 :-)
	MyHotstring := "{U+1F642} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::(.:: 		; frowning face U+1F641 :(
	MyHotstring := "{U+1F641} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-(.::		; frowning face U+1F641 :-(
	MyHotstring := "{U+1F641} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*:;).:: 		; winking face U+1F609 ;)
	MyHotstring := "{U+1F609} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*:;-).::		; winking face U+1F609 ;-)
	MyHotstring := "{U+1F609} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::|.:: 		; neutral face U+1F610 :|
	MyHotstring := "{U+1F610} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-|.::		; neutral face U+1F610 :-|
	MyHotstring := "{U+1F610} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-/.::		; confused face U+1F615 :-/
	MyHotstring := "{U+1F615} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::/.::			; confused face U+1F615 :/
	MyHotstring := "{U+1F615} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::D.::			; grinning face U+1F600 :D
	MyHotstring := "{U+1F600} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-D.::		; grinning face U+1F600 :-D
	MyHotstring := "{U+1F600} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::*.::			; flushed face U+1F633 :-*
	MyHotstring := "{U+1F633} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-*.::		; flushed face U+1F633 :-*
	MyHotstring := "{U+1F633} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::p::			; Face with Stuck-Out Tongue and Winking Eye Emoji U+1F61C :p
	MyHotstring := "{U+1F61C} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return

:*::-p.::		; Face with Stuck-Out Tongue and Winking Eye Emoji U+1F61C :-p
	MyHotstring := "{U+1F61C} `"
	Send, %MyHotstring%
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return


:*:cat.::			; cat
	MyHotstring := "{U+1F408} `"
	Send, % MyHotstring
	MyHotstring := RegExReplace(MyHotstring, "s)\{U\+.*\}", Replacement := " `", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
	;~ MsgBox, % "MyHotstring: " . MyHotstring . " Długość: " . StrLen(MyHotstring) . " A_ThisHotkey: " . A_ThisHotkey . " A_PriorHotkey: " . A_PriorHotkey
return



; - - - - - - - - - - - - - - - - - - Full titles of technical standards - - - - - - - - - 
:*:en50126-1.::
	Send, {Text}EN 50126-1:2017 Railway applications - The specification and demonstration of reliability, availability, maintainability and safety (RAMS) - Part 1: Generic RAMS Process.
return

:*:en50126-2.::
	Send, {Text}EN 50126-2:2017 Railway applications - The specification and demonstration of reliability, availability, maintainability and safety (RAMS) - Part 2: Systems Approach to Safety.
return

:*:en50128.::
	Send, {Text}EN 50128:2011 Railway applications – Communication, signalling and processing systems – Software for railway control and protection system.
return

:*:en50129.::
	Send, {Text}EN 50129:2018 Railway applications - Communication, signalling and processing systems – Safety related electronic systems for signalling.
return

:*:en50159.::
	Send, {Text}EN 50159:2010 Railway applications - Communication, signalling and processing systems - Safety-related communication in transmission systems.
return

:*:irisnorm::
	Send, {Text}ISO/TS 22163:2017(E) Railway applications - Quality management system - Business management system requirements for rail organizations: ISO 9001:2015 and particular requirements for application in the rail sector
return

:*:2008/57.::Dyrektywa Parlamentu Europejskiego i Rady 2008/57/WE z dnia 17 czerwca 2008 r. w sprawie interoperacyjności systemu kolei we Wspólnocie.
:*:2009/131.::Dyrektywa Komisji 2009/131/WE z dnia 16 października 2009 r. zmieniająca załącznik VII do dyrektywy Parlamentu Europejskiego i Rady 2008/57/WE w sprawie interoperacyjności systemu kolei we Wspólnocie.
:*:2011/18.::Dyrektywa Komisji 2011/18/UE z dnia 1 marca 2011 r. zmieniająca załączniki II, V i VI do dyrektywy Parlamentu Europejskiego i Rady 2008/57/WE w sprawie interoperacyjności systemu kolei we Wspólnocie.
:*:2013/9.::Dyrektywa Komisji 2013/9/UE z dnia 11 marca 2013 r. zmieniająca załącznik III do dyrektywy Parlamentu Europejskiego i Rady 2008/57/WE w sprawie interoperacyjności systemu kolei we Wspólnocie.
:*:2014/106.::Dyrektywa Komisji 2014/106/UE z dnia 5 grudnia 2014 r. zmieniająca załącznik V i VI do dyrektywy Parlamentu Europejskiego i Rady 2008/57/WE w sprawie interoperacyjności systemu kolei we Wspólnocie.
:*:2016/919.::Rozporządzenie Komisji (UE) 2016/919 z dnia 27 maja 2016 r. w sprawie technicznej specyfikacji interoperacyjności w zakresie podsystemów „Sterowanie” systemu kolei w Unii Europejskiej zmienione Rozporządzeniem wykonawczym Komisji (UE) 2019/776 z dnia 16 maja 2019 r. zmieniającym rozporządzenia Komisji (UE) nr 321/2013, (UE) nr 1299/2014, (UE) nr 1301/2014, (UE) nr 1302/2014 i (UE) nr 1303/2014, rozporządzenie Komisji (UE) 2016/919 oraz decyzję wykonawczą Komisji 2011/665/UE w odniesieniu do stosowania do dyrektywy Parlamentu Europejskiego i Rady (UE) 2016/797 oraz realizacji celów szczegółowych określonych w decyzji delegowanej Komisji (UE) 2017/1474.
:*:2010/713.::Decyzja Komisji 2010/713/UE z dnia 9 listopada 2010 r. w sprawie modułów procedur oceny zgodności, przydatności do stosowania i weryfikacji WE stosowanych w technicznych specyfikacjach interoperacyjności przyjętych na mocy dyrektywy Parlamentu Europejskiego i Rady 2008/57/WE.
:*:033281.::ERA/ERTMS/033281 Interfaces between CCS trackside and other subsystems, Rev. 4.0.

; - - - - - - - - - - Autocorrection section - - - - - - - - - - - - - - - - - - - - - - 
:*:polska::Polska
:*:poland::Poland
:*:polish::Polish
:*:english::English
:*:german::German
:*:germany::Germany
:*:a la::{U+00E0} la
:*:a propos::{U+00E0} propos
:*:apropos::{U+00E0} propos

:*:fyi.::For your information
:*:asap.::as soon as possible
:*:afaik.::as far as I know
:*:btw.::by the way
:*?:email::e-mail
:*:sharepoint::Sharepoint
:*:sp.::Sharepoint

; - - - - - - - - - - - - - Section Capital Letters - - - - - - - - - - - - - - - - - - - - - - - 
:*:svn::SVN
:*:sap::SAP
:*:easm.::EASM
:*:qnx::QNX
:*:rs232::RS232
:*:rs485::RS485
:*:uic60::UIC60
:*:s49::S49
:*:iscala::iSCALA
:*:ditaexchange::DitaExchange
:*:pma::PMA
:*:dokt::DokT (Dokumentacja Techniczna)
:*:dokr::DokR (Dokumentacja Robocza)


; - - - - - - - - - - - - SECTION OF FUNCTIONS  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
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


; ---------------------- SECTION OF LABELS ------------------------------------

TurnOffTooltip:
	ToolTip ,
return
