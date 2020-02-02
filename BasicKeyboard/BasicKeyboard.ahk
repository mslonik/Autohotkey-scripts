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

; - - - - - - - - - - - Set of default web pages - - - - - - - - - - - - - - - - - 
;~ Run, https://solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx ; voestalpine Signaling Siershahn, Cooperation Platform Sopot


; ---------------- SECTION OF KEYBOARD HOTKEYS ---------------------------------------------------------------------------------------
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
+^F1:: ; Suspend: 
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
return

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
; These are dedicated to ThinkPad T480 (notebook) keyboard
Ralt::AppsKey ; redirects AltGr -> context menu

; ---------------------- HOTSTRINGS -----------------------------------

; - - - - - - - - - - - - - - - - - - - - -  Hotstrings: Personal: Ctrl + Shift F9 - - - - - - - - - - - - - - - - - - - - - - - - -
:*:dd::Dzie{U+0144} dobry,{Enter}
:*:p ms::Pozdrawia ms
:C:M.::Maciej
:C:S.::S{U+0142}ojewski
:C:tel::{+}48 601 403 775
:*:ms.::Maciej S{U+0142}ojewski
:b0*x:m@2::SendInput, {BackSpace 16}mslonik.pl
:*b0x:m@::SendInput, {BackSpace 2}maciej.slojewski@voestalpine.com

:*:zws::Z wyrazami szacunku`, Maciej S{U+0142}ojewski
:*:kr`t::Kind regards`, Maciej S{U+0142}ojewski

^+F9::
MsgBox, 64, Hotstrings: Personal, 
(
dd	→  Dzień dobry`,
p ms	→ Pozdrawia ms
M.	→ Maciej
S.	→ Słojewski
tel	→ +48 601 403 775
ms.	→ Maciej Słojewski
m@2	→ maciej.slojewski@mslonik.pl
m@	→ maciej.slojewski@voestalpine.com
zws	→ Z wyrazami szacunku`, Maciej Słojewski
kr<tab>	→ Kind regards`, Maciej
)
return

; - - - - - - - - - - - - - - - - - - - - - Hotstrings: voestalpine: Ctrl + Shift + F10 - - - - - - - - - - - - - - - - - - - - - - - - -
:b0*x:axm::SendInput, {BackSpace 3}AXM
:*:axmr::AXM^=R^=
:*:axmio::AXM^=IO^=
:*:axma::AXM{Space}/{Space}AXM^=R^={Space}/{Space}AXM^=IO^=
:*:axmp::AXM,{Space}AXM^=R^=,{Space}AXM^=IO^=
:*:nout::{U+223C}OUT
:*:ihd1::I^=HD1^=
:*:ihd2::I^=HD2^=

:b0ox:vo::SendInput, estalpine
:*b0x:voe::SendInput, stalpine Signaling Sopot
:*b0x:voes::SendInput, {Backspace 1}{Space}Sp. z o.o.
:z*b0x:voesi::SendInput, {Backspace 17}Siershahn

::sie::Siershahn
:*:so.::Sopot

:b0*x:uniac::SendInput, {BackSpace 5}UniAC
:b0*x:uniac2::SendInput, {BackSpace 6}UniAC[2]
:b0*x:uniac1::SendInput, {BackSpace 6}UniAC[1]
:b0*x:uniacx::SendInput, {BackSpace 6}UniAC[x]

:b0*x:unias1p::Send, {BackSpace 9}UniAS[1{+}]
:b0*x:unias2i::SendInput, {BackSpace 9}UniAS[2i]
:b0*x:unias1::SendInput, {BackSpace 6}UniAS[1]
:b0*x:unias2::SendInput, {BackSpace 6}UniAS[2]
:b0*x:uniasx::SendInput, {BackSpace 6}UniAS[x]
:b0*x:unias::SendInput, {BackSpace 5}UniAS

:*:unirc.::Uni(versal wheel sensor) R(ail) C(lamp)
::unirc::UniRC

:*:azc::AZC
:*:mag.::MAG
:*:asm::ASM
:*:acm::ACM
:*:aim::AIM
:*:cok.::czujnik obecności koła
::cok::COK
:*:wsu.::wheel sensor unit
::wsu::WSU
:*:adm::ADM

:*:anszua::AnSzuA
:*:unibl::UniBL
:*:dsat.::detekcja Stanów Awaryjnych Taboru
::dsat::dSAT
:*:asdek.::Automatyczny System Detekcji E Kół
::asdek::ASDEK
:*:gotcha::GOTCHA
:*:phoenix::PHOENIX
::pm::PM
:*:dp.::Dział Produkcji i Zaopatrzenia
::dp::DPiZ
:*:dpiz.::Dział Produkcji i Zaopatrzenia
::dpiz::DPiZ
:*:du.::Dział Usług i Realizacji
::du::DUiR
:*:duir.::Dział Usług i Realizacji
::duir::DUiR
:*:dr.::Dział Rozwoju
::dr::DR
:*:hbd.::Hot-Box Detector
::hbd::HBD
:*:hwd.::Hot-Wheel Detector
::hwd::HWD
:*:mb.::Multi Beam
::mb::MB
:*:mds.::Modular Diagnostic System
::mds::MDS

:*:nip.::584-025-39-29
:*:adres.::Jana z Kolna 26c, 81-859 Sopot, Polska
:*:addres2.::Jana z Kolna 26c, 81-859 Sopot, Poland

^+F10::
	MsgBox, 64, Hotstrings: voestalpine, 
(
axm →   AXM
axmr	→ AXMR (in MS Word: R in subscript)
axmio	→ AXMIO (in MS Word: IO in subscript)
axma	→ AXM / AXMR / AXMIO (in MS Word: subscripts)
axmp	→ AXM`, AXMR`, AXMIO (in MS Word: subscripts)
nou	→ ∼OUT
ihd1	→ IHD1 (in MS Word: HD1 subscripts)
ihd2	→ IHD2 (in MS Word: HD2 subscripts)

vo	→ voestalpine
voe	→ voestalpine Signaling Sopot
voes	→ voestalpine Signaling Sopot Sp. z o.o.
voesi	→ voestalpine Signaling Siershahn
sie	→ Siershahn

uniac	→ UniAC
uniac2	→ UniAC[2]
uniac1	→ UniAC[1]
uniacx	→ UniAC[x]
unias1p	→ UniAS[1+]
unias2i	→ UniAS[2i]
unias1	→ UniAS[1]
unias2	→ UniAS[2]
uniasx	→ UniAS[x]
unias	→ UniAS
unirc	→ UniRC
wsu.	→ wheel sensor unit
wsu	→ WSU

azc	→ AZC
mag	→ MAG
asm	→ ASM
acm	→ ACM
aim	→ AIM
cok	→ COK
adm	→ ADM

:*:anszua::AnSzuA
:*:unibl::UniBL
:*:dsat.::detekcja Stanów Awaryjnych Taboru
::dsat::dSAT
:*:asdek.::Automatyczny System Detekcji E Kół
::asdek::ASDEK
:*:gotcha::GOTCHA
:*:phoenix::PHOENIX
::pm::PM
:*:dp.::Dział Produkcji i Zaopatrzenia
::dp::DPiZ
:*:dpiz.::Dział Produkcji i Zaopatrzenia
::dpiz::DPiZ
:*:du.::Dział Usług i Realizacji
::du::DUiR
:*:duir.::Dział Usług i Realizacji
::duir::DUiR
:*:dr.::Dział Rozwoju
::dr::DR
:*:hbd.::Hot-Box Detector
::hbd::HBD
:*:hwd.::Hot-Wheel Detector
::hwd::HWD
:*:mb.::Multi Beam
::mb::MB
:*:mds.::Modular Diagnostic System
::mds::MDS

:*:nip.::584-025-39-29
:*:adres.::Jana z Kolna 26c, 81-859 Sopot, Polska
:*:addres2.::Jana z Kolna 26c, 81-859 Sopot, Poland
)
return

; - - - - - - - - - - - - - - - - - - - - -  Physics, Mathematics and Other Symbols: Ctrl + Shift + F11 - - - - - - - - - - - - - - - - - - - - - - - - -
:*:ohm::{U+00A0}{U+2126}	; electric resistance
:*:kohm::{U+00A0}k{U+2126}	; electric resistance
::mikro::{U+00A0}{U+00b5}	
:*:kv::{U+00A0}kV
:*:mamp::{U+00A0}mA
::kamp::{U+00A0}kA

:*:+-::{U+00B1}
:*:-+::{U+00B1}
:*:plusminus::{U+00B1}
:*:minusplus::{U+00B1}

:*:oddo::{U+00F7}			; from to

:*:kropkam::{U+00B7} 		; multiplication in a form of small dot
:*:mkropka::{U+00B7}

:*:>=::{U+2265}				; greater than
:*:większyrówny::{U+2265}	; greater than
:*:wiekszyrowny::{U+2265}	; greater than
:*:<=::{U+2264} 			; less equal than
:*:mniejszyrówny::{U+2264} 	; less equal than
:*:mniejszyrowny::{U+2264} 	; less equal than
:*:~~::{U+2248}				; approximately
:*:/=::{U+2260} 			; not equal
:*:mminus::{U+2212}			; longer version of dash
:*:stopc::{U+00B0} 			; symbol of degree
:*:deg.::{U+00B0}			; symbol of degree

:b0*x:<-::SendInput, {Backspace 2}{U+2190}		; arrow to the left
:*:^|::{U+2191}				; arrow up
:*:|^::{U+2193}				; arrow down
:z*:<->::{U+2194}			; bi directional arrow
:b0*x:->::SendInput, {Backspace 2}{U+2192}		; arrow to the right

:*:alpha.::{U+03B1}			; Greek small letter alpha
:*:beta.::{U+03B2}			; Greek small letter beta
:*:gamma.::{U+03B3}			; Greek small letter gamma
:*:epsilon.::{U+03B5}			; Greek small letter epsilon
:*:theta.::{U+03B8}			; Greek small letter theta
:*:lambda.::{U+03BB}			; Greek small letter lambda
:*:pi.::{U+03C0}				; Greek small letter pi
:*:omega.::{U+03C9}			; Greek small letter omega
:*:delta.::{U+2206}			; Greek capital letter delta

:*:--::{U+2500}				; double dash
:*:euro.::{U+20AC}			; euro currency


^+F11::
	MsgBox, 64, Hotstrings: Physics & Mathematics, 
(
ohm	→  Ω
kohm	→  kΩ
mikro	→  µ
kv	→  kV
mamp	→  mA
kamp	→  kA

+-	→ ±	or: -+	→ ±	or: plusminus	→ ±	or minusplus	±
oddo	→ ÷
kropkam	→ ·	or: mkropka	→ ·
>=	→ ≥	or: większyrówny	→ ≥	or: wiekszyrowny	→ ≥
<=	→ ≤	or: mniejszyrówny	→ ≤	or: mniejszyrowny	→ ≤
~~	→ ≈
/=	→ ≠
mminus	→ ─
stopc	→ °	or: deg*	→ °

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
:*:ram.::Reliability, Availability, Maintainability
:o:ram::RAM
:*:rams.::Reliability, Availability, Maintainability and Safety
:o:rams::RAMS
:*:qrams.::Quality, Reliability, Availability, Maintainability, Safety
::qrams::QRAMS
:*:mtbf.::Mean Time Between Failures
::mtbf::MTBF
:*:mttr.::Mean Time To Restore
::mttr::MTTR
:*:sil.::Safety Integrity Level
::sil::SIL
:*:pcb.::Printed Circuit Board
::pcb::PCB
:*:dtr.::Dokumentacja Techniczno-Ruchowa
::dtr::DTR
:*:wtwio.::Warunki Techniczne Wytwarzania i Odbioru
::wtwio::WTWiO
:*:pkp.::Polskie Koleje Państwowe
::pkp::PKP
:*:plk.::Polskie Linie Kolejowe
::plk::PLK
:*:ups.::Uninterruptable Power Supply
::ups::UPS
:*:usb.::Universal Serial Bus
::usb::USB
:*:bhp.::Bezpieczeństwo i Higiena Pracy
::bhp::BHP
:*:iris.::International Railway Industry Standard for the evaluation of railway management systems
::iris::IRIS
:*:tsi.::Technical Specifications for Interoperability
::tsi::TSI
:*:faq.::Frequently Asked Questions
::faq::FAQ
:*:ahk.::AutoHotkey
::ahk::AHK
:b0*?z:.ahk::
:*:vba.::Visiual Basic for Applications
::vba::VBA
:*:hdmi.::High-Definition Multimedia Interface
::hdmi::HDMI
:*:emc.::Electro-Magnetic Compatibility
::emc::EMC
:*:tuv.::German: Technischer {U+00DC}berwachungsverein, English: Technical Inspection Association
::tuv::T{U+00DC}V
::sud::S{U+00DC}D
:*:gmbh.::German: Gesellschaft mit beschränkter Haftung, English: company with limited liability
::gmbh::GmbH
:*:hart.::Highway Addressable Remote Transducer Protocol
::hart::HART
:*:pesel.::Powszechny Elektroniczny System Ewidencji Ludności
::pesel::PESEL
:*:utk.::Urząd Transportu Kolejowego
::utk::UTK
:*:bait.::Biuro Automatyki i Telekomunikacji
::bait::BAiT
:*:erp.::Enterprise Resource Planning
::erp::ERP
:*:c2ms.::Component Content Management System `
::c2ms::CCMS
:*:lc2.::Life Cycle Cost `
::lc2::LLC
:*:obb.::German: {U+00D6}sterreichische Bundesbahnen, English: Austrian Federal Railways
::obb::{U+00D6}BB
:*:sbb.::German: Schweizerische Bundesbahnen, English: Swiss Federal Railways
::sbb::SBB
:*:ceo.::Chief Executive Officer
::ceo::CEO

:*:ik.::Instytut Kolejnictwa
::ik::IK
:*:hds.::Hardware Design Specification
::hds::HDS
:*:has::Hardware Architecture Specification
::has::HAS

^+F12::
	MsgBox, 64, Hotstrings: Abbreviations, ram.	→ Reliability`, Availability`, Maintainability`nram	→ RAM`nrams.	→ Reliability`, Availability`, Maintainability and Safety`nrams:	→ RAMS`nqrams.	→ Quality`, Reliability`, Availability`, Maintainability`, Safety`nqrams	→ QRAMS`nmtbf.	→ Mean Time Between Failures`nmtbf	→ MTBF`nmttr.	→ Mean Time To Restore`nmttr	→ MTTR`nsil.	→ Safety Integrity Level`nsil	→ SIL`npcb.	→ Printed Circuit Board`npcb	→ PCB`ndtr.	→ Dokumentacja Techniczno-Ruchowa`ndtr	→ DTR`ndp.	→ Dział Produkcji i Zaopatrzenia`ndp	→ DPiZ`ndpiz.	→ Dział Produkcji i Zaopatrzenia`ndpiz	→ DPiZ`ndu.	→ Dział Usług i Realizacji`ndu	→ DUiR`nduir.	→ Dział Usług i Realizacji`nduir	→ DUiR`ndr	→ DR`nwtwio.	→ Warunki Techniczne Wytwarzania i Odbioru`nwtwio	→ WTWiO`npkp.	→ Polskie Koleje Państwowe`npkp	→ PKP`nplk.	→ Polskie Linie Kolejowe`nplk	→ PLK`nups.	→ Uninterruptable Power Supply`nups	→ UPS`nusb.	→ Universal Serial Bus`nusb	→ USB`nbhp.	→ Bezpieczeństwo i Higiena Pracy`nbhp	→ BHP`niris.	→ International Railway Industry Standard for the evaluation of railway management systems`niris	→ IRIS`ntsi.	→ Technical Specifications for Interoperability`ntsi	→ TSI`nfaq.	→ Frequently Asked Questions`nfaq	→ FAQ`nahk.	→ AutoHotkey`nahk	→ AHK`nvba.	→ Visiual Basic for Applications`nvba	→ VBA`nhdmi.	→ High-Definition Multimedia Interface`nhdmi	→ HDMI`nhbd.	→ Hot-Box Detector`nhbd	→ HBD`nhwd.	→ Hot-Wheel Detector`nhwd	→ HWD`nemc.	→ Electro-Magnetic Compatibility`nemc	→ EMC`nmb.	→ Multi Beam`nmb	→ MB`nmds.	→ Modular Diagnostic System`nmds	→ MDS`ntuv.	→ German: Technischer {U+00DC}berwachungsverein`, English: Technical Inspection Association`ntuv	→ T{U+00DC}V`nsud	→ S{U+00DC}D`ngmbh.	→ German: Gesellschaft mit beschränkter Haftung`, English: company with limited liability`ngmbh	→ GmbH`nhart.	→ Highway Addressable Remote Transducer Protocol`nhart	→ HART`npesel.	→ Powszechny Elektroniczny System Ewidencji Ludności`npesel	→ PESEL`nutk.	→ Urząd Transportu Kolejowego`nutk	→ UTK`nbait.	→ Biuro Automatyki i Telekomunikacji`nbait	→ BAiT`nerp.	→ Enterprise Resource Planning`nerp	→ ERP`nc2ms.	→ Component Content Management System ``nc2ms	→ CCMS`nlc2.	→ Life Cycle Cost ``nlc2	→ LLC`nobb.	→ German: {U+00D6}sterreichische Bundesbahnen`, English: Austrian Federal Railways`nobb	→ {U+00D6}BB`nsbb.	→  German: Schweizerische Bundesbahnen`, English: Swiss Federal Railways`nsbb	→ SBB
return

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

; - - - - - - - - - - - - - Section Date & Time - - - - - - - - - - - - - - - - - - - - - - - - - 

:*b0:d]::  ; This hotstring replaces "d]" with the current date and time via the commands below.
	FormatTime, CurrentDateTime,, yyyy-MM-dd  ; It will look like 2020-01-21 
	SendInput, {Backspace 2}%CurrentDateTime%
return

:*z:d]]::	; This hotstring is suitable for TC (Total Commander) only
	FormatTime, CurrentDateTime,, yyyyMMdd_
	SendInput, {Backspace 8}%CurrentDateTime%
return

:*:t]::
	FormatTime, CurrentDateTime,, Time
	SendInput %CurrentDateTime%
return

; ------------------ Section of first or second names with local diacritics ------------------------
::rene::Ren{U+00E9}				; Rene 
:*:guenther::G{U+00FC}nther		; Guenther 
:*:joerg::J{U+00F6}rg			; Joerg
:*:jorg::J{U+00F6}rg			; Joerg

; - - - - - - - - - - - - - - - - Function Keys redirection - - - - - - - - - - - - - - - - - - - -
; This is a way to get rid of top row of function keys.
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

; - - - - - - - - - - - - - - - - Emoticons - - - - - - - - - - - - - - - - - - - - - - - -
;~ https://unicode-table.com/en/
:*::)::{U+1F642} :-) ` 		; smiling face U+1F642
:*::-)::{U+1F642} :-) `		; smiling face U+1F642
:*::(::{U+1F641} :-( ` 		; frowning face U+1F641
:*::-(::{U+1F641} :-( `		; frowning face U+1F641
:*:;)::{U+1F609} ;-( ` 		; winking face U+1F609
:*:;-)::{U+1F609} ;-( `		; winking face U+1F609
:*::|::{U+1F610} :-| ` 		; neutral face U+1F610
:*::-|::{U+1F610} :-| `		; neutral face U+1F610
:*::-/::{U+1F615} :-/ `		; confused face U+1F615
:*::/::{U+1F615} :-/ `		; confused face U+1F615
:*::D::{U+1F600} :-D `		; grinning face U+1F600
:*::-D::{U+1F600} :-D `		; grinning face U+1F600
:*:cat.::{U+1F408}			; cat

; - - - - - - - - - - - - - - - - - - Full titles of technical standards - - - - - - - - - 
; to be completed...
; EN-50126-01
; EN-50126-02
:b0*:EN 50126.::{BackSpace}{:}2010 Railway applications – The specification and demonstration of reliability, availability, maintainability and safety (RAMS) – Part 1: Generic RAMS Process.
:b0*:EN 50128.::{BackSpace}{:}2011 Railway applications – Communication, signalling and processing systems – Software for railway control and protection system.
:b0*:EN 50129.::{BackSpace}{:}2003 Railway applications Communication, signalling and processing systems – Safety related electronic systems for signalling.
:b0*:EN 50159.::{BackSpace}{:}2010 Railway applications - Communication, signalling and processing systems - safety-related communication in transmission systems.

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

:*:fyi.::For your information
:*:asap.::as soon as possible
:*:afaik.::as far as I know
:*:btw.::by the way

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
; ----------------- END OF ADDITIONAL I/O DEVICES SECTION ------------------------
