#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!

; --------------- SEKCJA ZMIENNYCH GLOBALNYCH -----------------------------
WordTrue := -1
WordFalse := 0
; --------------- KONIEC SEKCJI ZMIENNYCH GLOBALNYCH ----------------------


;~ - dopisać pozostałe klawisze multimedialne
;~ - restart komputera pod Ctrl + przekreślony głośniczek

; ---------------- SEKCJA KLAWISZY MULTIMEDIALNYCH -----------------------------
Launch_Media:: ; uruchom Word - nutka, pierwszy klawisz multimedialny z lewej
	tooltip, [%A_thishotKey%] Uruchom procesor tekstu MS Word  
	SetTimer, ZgasTooltip, -5000
	Run, WINWORD.EXE
return

Launch_Mail:: ; uruchom Total Commander
	tooltip, [%A_thishotKey%] Uruchom Total Commander
	SetTimer, ZgasTooltip, -5000
	Run, c:\totalcmd\TOTALCMD64.EXE 
return

Browser_Home:: ; uruchom Narzędzie wycinanie
	tooltip, [%A_thishotKey%] Uruchom Narzędzie wycinanie
	SetTimer, ZgasTooltip, -5000
	Run, %A_WinDir%\system32\SnippingTool.exe
return

Media_Play_Pause:: ; Paint
	tooltip, [%A_thishotKey%] Uruchom narzędzie Malarz (Paint)
	SetTimer, ZgasTooltip, -5000
	Run, %A_WinDir%\system32\mspaint.exe
return



; ----------KLAWIATURA NUMERYCZNA - NUMLOCK == ON -----------------------------------------------



; ---------- KLAWIATURA NUMERYCZNA - NUMLOCK == OFF ---------------------------------------------




; ---------------------- SEKCJA ETYKIET ------------------------------------

ZgasTooltip:
	ToolTip ,
return

;~ https://support.microsoft.com/pl-pl/help/4488540/how-to-take-and-annotate-screenshots-on-windows-10
PrintScreen::#+s ; Windows + Shift + s

; ---------------------- SEKCJA KOMBOSÓW ang. hotstrings-----------------------------------
:*:dd::Dzień dobry,{Enter}
:*:p ms::Pozdrawia ms
:*:ms`t::Maciej Słojewski
;~ :*:m@::maciej.slojewski@mslonik.pl
:*:ms@2::
	tmp := StrLen("maciej.slojewski@voestalpine.com") - 3
	Send, {BackSpace %tmp%}maciej.slojewski@mslonik.pl
return
:*b0:ms@::
	Send, {BackSpace 3}maciej.slojewski@voestalpine.com
return
:*:zws::Z wyrazami szacunku`, Maciej Słojewski
:*:kr`t::Kind regards`, Maciej Słojewski

:*:axm`t::AXM
:*:axmr::AXM^=R^=
:*:axmio::AXM^=IO^=
:*:axmu::AXM{Space}/{Space}AXM^=R^={Space}/{Space}AXM^=IO^=
:*:axmp::AXM,{Space}AXM^=R^=,{Space}AXM^=IO^=
:*:nout::{U+223C}OUT

:*:dsat::dSAT
:*:asdek::ASDEK

:*:ohm::{U+00A0}{U+2126}
:*:kohm::{U+00A0}k{U+2126}
:*:mikro::{U+00A0}{U+00b5}
:*:kv::{U+00A0}kV
:*:mamp::{U+00A0}mA
:*:kamp::{U+00A0}kA

:*:+-::{U+00B1}
:*:-+::{U+00B1}
:*:plusminus::{U+00B1}
:*:minusplus::{U+00B1}

:*:kropkam::{U+00B7}
:*:mkropka::{U+00B7}

:*:>=::{U+2265}
:*:większyrówny::{U+2265}
:*:wiekszyrowny::{U+2265}

:*:mminus::{U+2212}
:*:stopc::{U+00B0}

:*b0:vo::
	Send, {Backspace 2}voestalpine
return
:*b0:voe::
	Send, {Backspace}{Space}Signaling Sopot
return
:*b0:voes::
	Send, {Backspace 1}{Space}Sp. z o.o.
return

:*:uniac::UniAC
:*:unias::UniAS
:*:unirc::UniRC
:*:wsu::wheel sensor unit
:*:azc::AZC
::mag::MAG

:*:tilde::{U+223C}
:*:ddelta::{U+2206}
:*:--::{U+2500}

; ------------------ Sekcja imion i nazwisk ------------------------
:*:rene::Ren{U+00E9} ; Rene Berger
:*:guenther::G{U+00FC}nther ; Gunther Lehner
:*:pek::P{U+00E9}k	; Piotr Pek

; ----------------- SECTION OF ADDITIONAL I/O DEVICES -------------------------------
; pedały

F13:: ; przełączanie pomiędzy kolejnymi okienkami Worda; autor: Taran VH
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

F14:: ; przełączanie pomiędzy zakładkami Chrome; autor: Taran VH
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

;~ https://autohotkey.com/board/topic/116740-switch-between-one-window-of-each-different-applications/

; computer mouse: OPTO 325 (PS/2)

; Make the mouse wheel perform alt-tabbing
MButton::AltTabMenu
WheelDown::AltTab
WheelUp::ShiftAltTab

; Left side button XButton1
XButton1:: ; switching between Chrome browser tabs; author: Taran VH
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

; Right side button XButton2
XButton2:: ; switching between Chrome browser tabs; author: Taran VH
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




; ----------------- END OF ADDITIONAL I/O DEVICES SECTION ------------------------
