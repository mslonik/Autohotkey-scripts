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
; --------------- END OF GLOBAL VARIABLES SECTION ----------------------



; ---------------- SECTION OF KEYBOARD HOTKEYS -----------------------------
; These are valid only for "Logitech Internet 350 Keyboard" and alike.

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

+^F1:: ; Suspend: 
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
return

; These are dedicated to ThinkPad T480 (notebook) keyboard
Ralt::AppsKey ; redirects AltGr -> context menu


; These are valid for any keyboard
+^k:: ; run Kee Pass application (password manager)
	Run, C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe 
return



; - - - - - - - - END OF KEYBOARD HOTKEYS SECTION - - - - - - - - - - - - - - - - - - - - - 




; ---------- SECTION OF NUMERIC KEYBOARD HOTKEYS - NUMLOCK == ON -----------------------------------------------

; ---------- SECTION OF NUMERIC KEYBOARD HOTKEYS - NUMLOCK == OFF ---------------------------------------------




; ---------------------- SECTION OF LABELS ------------------------------------

TurnOffTooltip:
	ToolTip ,
return

; ---------------------- KEYS REMAPPING -----------------------------------
;~ https://support.microsoft.com/pl-pl/help/4488540/how-to-take-and-annotate-screenshots-on-windows-10
PrintScreen::#+s ; Windows + Shift + s

; ---------------------- HOTSTRINGS -----------------------------------
:*:dd::Dzie{U+0144} dobry,{Enter}
:*:p ms::Pozdrawia ms
:C:M::Maciej
:C:S::S{U+0142}ojewski
:C:tel::{+}48 601 403 775
:*:ms.::Maciej S{U+0142}ojewski
;~ :*:m@::maciej.slojewski@mslonik.pl
:*:ms@2::
	tmp := StrLen("maciej.slojewski@voestalpine.com") - 3
	Send, {BackSpace %tmp%}maciej.slojewski@mslonik.pl
return
:*b0:ms@::
	Send, {BackSpace 3}maciej.slojewski@voestalpine.com
return
:*:zws::Z wyrazami szacunku`, Maciej S{U+0142}ojewski
:*:kr`t::Kind regards`, Maciej S{U+0142}ojewski

:*:axm`t::AXM
:*:axmr::AXM^=R^=
:*:axmio::AXM^=IO^=
:*:axmu::AXM{Space}/{Space}AXM^=R^={Space}/{Space}AXM^=IO^=
:*:axmp::AXM,{Space}AXM^=R^=,{Space}AXM^=IO^=
:*:nout::{U+223C}OUT
:*:ihd1::I^=HD1^=
:*:ihd2::I^=HD2^=

:*:dsat::dSAT
:*:asdek::ASDEK

:*:ohm::{U+00A0}{U+2126}
:*:kohm::{U+00A0}k{U+2126}
::mikro::{U+00A0}{U+00b5}
:*:kv::{U+00A0}kV
:*:mamp::{U+00A0}mA
::kamp::{U+00A0}kA

:*:+-::{U+00B1}
:*:-+::{U+00B1}
:*:plusminus::{U+00B1}
:*:minusplus::{U+00B1}

:*:oddo::{U+00F7}

:*:kropkam::{U+00B7}
:*:mkropka::{U+00B7}

:*:>=::{U+2265}
:*:większyrówny::{U+2265}
:*:wiekszyrowny::{U+2265}
:*:<=::{U+2264}
:*:mniejszyrówny::{U+2264}
:*:mniejszyrowny::{U+2264}

:*:mminus::{U+2212}
:*:stopc::{U+00B0}

:b0o:vo::
	Send, estalpine
return
:*b0:voe::
	Send, stalpine Signaling Sopot
return
:*b0:voes::
	Send, {Backspace 1}{Space}Sp. z o.o.
return

:*b0:voesi::
	Send, {Backspace 17}Siershahn
return

::sie::Siershahn

:b0*:uniac::
	Send, {BackSpace 5}UniAC `
return

:zb0*:uniac2::
	Send, {BackSpace 7}UniAC[2] `
return

:zb0*:uniac1::
	Send, {BackSpace 7}UniAC[1] `
return

:zb0*:uniacx::
	Send, {BackSpace 7}UniAC[x] `
return

:zb0*:unias1p::
	Send, {BackSpace 10}UniAS[1{+}] `
return

:zb0*:unias2i::
	Send, {BackSpace 10}UniAS[2i] `
return

:b0*:unias1::
	Send, {BackSpace 7}UniAS[1] `
return

:b0*:unias2::
	Send, {BackSpace 7}UniAS[2] `
return

:b0*:uniasx::
	Send, {BackSpace 7}UniAS[x] `
return

:b0*:unias::
	Send, {BackSpace 5}UniAS `
return

:*:unirc::UniRC

:b0*:wsu::
	Send, {BackSpace 3}WSU `
return

:zb0*:wsuu::
	Send, {BackSpace 5}wheel sensor unit
return

:*:azc::AZC
::mag::MAG
::asm::ASM
::acm::ACM
::aim::AIM
::cok::COK
::adm::ADM

:*:anszua::AnSzuA
:*:unibl::UniBL

:o:ram::RAM
:*:rams::RAMS
:*:qrams::QRAMS
::mtbf::MTBF
::mttr::MTTR
::pm::PM
::sil::SIL
:*:pcb::PCB
:*:dtr::DTR
::dp::DPiZ
:*:dpiz::DPiZ
::du::DUiR
:*:duir::DUiR
::dr::DR
:*:wtwio::WTWiO
:*:pkp::PKP
:*:plk::PLK
:*:ups::UPS
:*:usb::USB
:*:qnx::QNX
:*:rs232::RS232
:*:rs485::RS485
:*:bhp::BHP
:*:svn::SVN
:*:iris::IRIS
:*:tsi::TSI
:*:faq::FAQ
:*:ahk::AHK
:*:vba::VBA
:*:hdmi::HDMI
:*:hbd::HBD
:*:hwd::HWD
:*:emc::EMC
:*:phoenix::PHOENIX
:*:mb.::MB
:*:gotcha::GOTCHA
:*:mds::MDS
:*:tuv::T{U+00DC}V
::sud::S{U+00DC}D
:*:gmbh::GmbH
:*:hart::HART
:*:pesel::PESEL
:*:utk::UTK
:*:bait::BAiT
:*:uic60::UIC60
:*:s49::S49
:*:iscala::iSCALA
:*:erp::ERP
:*:sap::SAP

:*:tilde::
MSWordSetFont("Cambria Math", "U+223C") ;
return
:*:deltaa::{U+2206}
:*:--::{U+2500}

:*:tabela`t::| | |{Enter}

:*:d]::  ; This hotstring replaces "d]" with the current date and time via the commands below.
	FormatTime, CurrentDateTime,, yyyy-MM-dd  ; It will look like 2020-01-21 
	SendInput %CurrentDateTime%
return

:*:t]::
	FormatTime, CurrentDateTime,, Time
	SendInput %CurrentDateTime%
return

; ------------------ Section of first or second names with local diacritics ------------------------
::rene::Ren{U+00E9}				; Rene 
:*:guenther::G{U+00FC}nther		; Guenther 
:*:pek::P{U+00E9}k				; Pek
:*:stuhn::St{U+00FC}hn			; Man
:*:joerg::J{U+00F6}rg			; Joerg
:*:jorg::J{U+00F6}rg			; Joerg

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

MSWordSetFont(FontName,key) {
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
}

; ----------------- END OF ADDITIONAL I/O DEVICES SECTION ------------------------
