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

ApplicationName := "Polish Diactrics 5"
;~ global flaga := 0

Menu, Tray, Icon, imageres.dll, 123     ; this line will turn the H icon into a small red a letter-looking thing.
;~ Gosub, TRAYMENU ; Jumps to the specified label and continues execution until Return is encountered

;~ The order in which hotstrings are defined determines their precedence with respect to each other. In other words, if more than one hotstring matches something you type, only the one listed first in the script will take effect. 

#Hotstring c b0 ? *

MyHotString(_string, _stringUnicode, _BeepFrequency, _BeepDuration, _WhatTooltip)
    {
    Hotstring(":zx:" . _string . _string . _string, func("MySend").bind("{BackSpace 2}" . _string . _string, _BeepFrequency, _BeepDuration, _WhatTooltip))
    Hotstring(":x:" . _string . _string, func("MySend").bind("{BackSpace 2}" . _stringUnicode, _BeepFrequency, _BeepDuration, _WhatTooltip))
    Hotstring(":x:" . _string, func("PrimaryLetter").bind(_BeepFrequency, _BeepDuration, _WhatTooltip))
    }

MySend(_string, _BeepFrequency, _BeepDuration, _WhatTooltip)
    {
    Send % _string
    SoundBeep, % _BeepFrequency, % _BeepDuration
    Tooltip, % _WhatTooltip
    }  

PrimaryLetter(_BeepFrequency, _BeepDuration, _IfTooltip)
    {
    SoundBeep, % _BeepFrequency, % _BeepDuration
    if (_IfTooltip = "yes")
        Tooltip, Diactric?, % A_CaretX, % A_CaretY-20
    }

;~ read global variables from .ini file
IniRead, _Language, % A_ScriptDir . "\Polish.ini", Global, Language
IniRead, _AmericanLayout, % A_ScriptDir . "\Polish.ini", Global, AmericanLayout
IniRead, _AllTooltips, % A_ScriptDir . "\Polish.ini", Global, AllTooltips
IniRead, _AllBeeps, % A_ScriptDir . "\Polish.ini", Global, AllBeeps
IniRead, _DiactricWord, % A_ScriptDir . "\Polish.ini", Global, DiactricWord
IniRead, _DoubleWord, % A_ScriptDir . "\Polish.ini", Global, DoubleWord

;~ determine how many [Diactric] sections are in .ini file
DiactricSectionCounter := 0
Loop, Read, % A_ScriptDir . "\Polish.ini"
    {
    if (InStr(A_LoopReadLine, "[Diactric"))
        {
        DiactricSectionCounter++
        }
    }
;~ MsgBox, % DiactricSectionCounter

;~ read all the rest of configuration parameters from .ini file and create hotstrings
Loop, %DiactricSectionCounter%
    {
    IniRead, _BaseKey, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, BaseKey
    IniRead, _Diactric, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Diactric
    IniRead, _Tooltip, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Tooltip
    IniRead, _SoundBeep_Frequency, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, SoundBeep_Frequency
    IniRead, _SoundBeep_Duration, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, SoundBeep_Duration
    
    ;~ DiactricArray.Push(A_Index, OutputVar_BaseKey, OutputVar_Diactric, OutputVar_Tooltip, OutputVar_SoundBeep_Frequency, OutputVar_SoundBeep_Duration)
    
    MyHotString(_BaseKey, _Diactric, _SoundBeep_Frequency, _SoundBeep_Duration, _Tooltip)
    }




;~ :z:aaa::
    ;~ Send, {BackSpace 2}aa
    ;~ SoundBeep, 250, 150
    ;~ Tooltip,
;~ return

;~ ::aa::
    ;~ Send, {BackSpace 2}{U+0105}
    ;~ SoundBeep, 350, 150
    ;~ Tooltip, Double?, % A_CaretX, % A_CaretY-20
;~ return

;~ ::a::
    ;~ SoundBeep, 450, 150
    ;~ Tooltip, Diactric?, % A_CaretX, % A_CaretY-20
;~ return

;~ :z:ccc::
    ;~ Send, {BackSpace 2}cc
    ;~ Tooltip,
;~ return

;~ ::cc::
        ;~ Send, {BackSpace 2}{U+0107}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::c::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:eee::
    ;~ Send, {BackSpace 2}ee
    ;~ Tooltip,
;~ return

;~ ::ee::
        ;~ Send, {BackSpace 2}{U+0119}
        ;~ Tooltip, Double?, % A_CaretX, % A_CaretY-20
;~ return

;~ ::e::
    ;~ Tooltip, Diactric?, % A_CaretX, % A_CaretY-20
;~ return


;~ :z:lll::
    ;~ Send, {BackSpace 2}ll
    ;~ Tooltip,
;~ return

;~ ::ll::
        ;~ Send, {BackSpace 2}{U+0142}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::l::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:nnn::
    ;~ Send, {BackSpace 2}nn
    ;~ Tooltip,
;~ return

;~ ::nn::
        ;~ Send, {BackSpace 2}{U+0144}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::n::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:ooo::
    ;~ Send, {BackSpace 2}oo
    ;~ Tooltip,
;~ return

;~ ::oo::
        ;~ Send, {BackSpace 2}{U+00F3}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::o::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:sss::
    ;~ Send, {BackSpace 2}ss
    ;~ Tooltip,
;~ return

;~ ::ss::
        ;~ Send, {BackSpace 2}{U+015B}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::s::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:xxx::
    ;~ Send, {BackSpace 2}xx
    ;~ Tooltip,
;~ return

;~ ::xx::
        ;~ Send, {BackSpace 2}{U+017A}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::x::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return

;~ :z:zzz::
    ;~ Send, {BackSpace 2}zz
    ;~ Tooltip,
;~ return

;~ ::zz::
        ;~ Send, {BackSpace 2}{U+017C}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::z::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ CAPITAL DIACTRIC POLISH LETTERS:
;~ ; A - Ą {U+0104}
;~ ; C - Ć {U+0106}
;~ ; E - Ę {U+0118}
;~ ; L - Ł {U+0141}
;~ ; N - Ń {U+0143}
;~ ; O - Ó {U+00D3}
;~ ; S - Ś {U+015A}
;~ ; X - Ź {U+0179}
;~ ; Z - Ż {U+017B}

;~ :z:AAA::
    ;~ Send, {BackSpace 2}AA
    ;~ Tooltip,
;~ return

;~ ::AA::
        ;~ Send, {BackSpace 2}{U+0104}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::A::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return

;~ :z:CCC::
    ;~ Send, {BackSpace 2}CC
    ;~ Tooltip,
;~ return

;~ ::CC::
        ;~ Send, {BackSpace 2}{U+0106}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::C::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:EEE::
    ;~ Send, {BackSpace 2}EE
    ;~ Tooltip,
;~ return

;~ ::EE::
        ;~ Send, {BackSpace 2}{U+0118}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::E::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:LLL::
    ;~ Send, {BackSpace 2}LL
    ;~ Tooltip,
;~ return

;~ ::LL::
    ;~ Send, {BackSpace 2}{U+0141}
    ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::L::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return



;~ :z:NNN::
    ;~ Send, {BackSpace 2}NN
    ;~ Tooltip,
;~ return

;~ ::NN::
        ;~ Send, {BackSpace 2}{U+0143}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::N::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:OOO::
    ;~ Send, {BackSpace 2}OO
    ;~ Tooltip,
;~ return

;~ ::OO::
        ;~ Send, {BackSpace 2}{U+00D3}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::O::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:SSS::
    ;~ Send, {BackSpace 2}SS
    ;~ Tooltip,
;~ return

;~ ::SS::
        ;~ Send, {BackSpace 2}{U+015A}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::S::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:XXX::
    ;~ Send, {BackSpace 2}XX
    ;~ Tooltip,
;~ return

;~ ::XX::
        ;~ Send, {BackSpace 2}{U+0179}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::X::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ :z:ZZZ::
    ;~ Send, {BackSpace 2}ZZ
    ;~ Tooltip,
;~ return

;~ ::ZZ::
        ;~ Send, {BackSpace 2}{U+017B}
        ;~ Tooltip, Double?, % A_CaretX,% A_CaretY-20
;~ return

;~ ::Z::
    ;~ Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
;~ return


;~ THE_REST:
~+`::
~+1::
~+2::
~+3::
~+4::
~+5::
~+6::
~+7::
~+8::
~+9::
~+0::
~+-::
~+=::
~+q::
~+w::
~+r::
~+t::
~+y::
~+u::
~+i::
~+p::
~+[::
~+]::
~+\::
~+d::
~+f::
~+g::
~+h::
~+j::
~+k::
~+;::
~+'::
~+v::
~+b::
~+m::
~+,::
~+.::
~+/::
~`::
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~0::
~-::
~=::
~q::
~w::
~r::
~t::
~y::
~u::
~i::
~p::
~[::
~]::
~\::
~d::
~f::
~g::
~h::
~j::
~k::
~;::
~'::
~v::
~b::
~m::
~,::
~.::
~/::
~Space::
~Tab::
~Enter::
~Escape::
~Delete::
~Insert::
~Home::
~End::
~PgUp::
~PgDn::
~Up::
~Down::
~Left::
~Right::
~BackSpace::
    Hotstring("Reset")
    ToolTip,, % A_CaretX, % A_CaretY-20
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

;~ ORDINARY_DIACRIC POLISH LETTERS:
; a - ą {U+0105}
; c - ć {U+0107}
; e - ę {U+0119}
; l - ł {U+0142}
; n - ń {U+0144}
; o - ó {U+00F3}
; s - ś {U+015B}
; x - ź {U+017A}
; z - ż {U+017C}
