;~              I N T R O D U C T I O N
;~ Simple script for Polisch diacritic marks (https://en.wikipedia.org/wiki/Diacritic): π, Í, ú, Ê, ø, ü, Ò, Û, ≥.
;~ Instead of usage of AltGr (right alt, see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details):
;~ * double press a key corresponding to specific diacritic key, e.g. ee converts into Í
;~ * AltGr suspend run of this script (switches to default behaviour of keyboard
;~ * special sequence for double letters within words: <letter><letter><letter>, e.g. zaaawansowany converts into zaawansowany
;~ 
;~ WHY:
;~ a. "programmers keyboard" and Polish diactric marks combined with old ANSI keyboards 101 keys (without Windows key and context key) where AltGr is unergonomically shifted to the right side of keyboard,
;~ b. all other "programmers keyboard" when one doesn't want to press AltGr.
;~
;~ Author: Maciej S≥ojewski, 2019-08-04 
;~
;~ Base for all actions are "Hotstrings".

#SingleInstance,Force ; Determines whether a script is allowed to run again when it is already running. Force: Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

ApplicationName := "Polish Diactrics"
global flaga := 0

Menu, Tray, Icon, imageres.dll, 123     ; this line will turn the H icon into a small red a letter-looking thing.
Gosub, TRAYMENU ; Jumps to the specified label and continues execution until Return is encountered

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

#Hotstring b0 ? * c ; Changes hotstring options or ending characters.
; b0 Automatic backspacing is not done to erase the abbreviation you type.
; ?  The hotstring will be triggered even when it is inside another word.
; *  An ending character is not required to trigger the hotstring.
; c  When you type an abbreviation, it must exactly match the case defined in the script.

;~ The order in which hotstrings are defined determines their precedence with respect to each other. In other words, if more than one hotstring matches something you type, only the one listed first in the script will take effect. 

;~ ORDINARY_DIACRIC_LETTERS: π Ê Í ≥ Ò Û ú ü ø

; π
:z:aaa::
    Send, {BackSpace 2}aa
    Tooltip,
return

::aa::
    Send, {BackSpace 2}{U+0105}
    Tooltip, Double?, % A_CaretX, % A_CaretY-20
return

::a::
    Tooltip, Diactric?, % A_CaretX, % A_CaretY-20
return

; Ê
:z:ccc::
    Send, {BackSpace 2}cc
    Tooltip,
return

::cc::
        Send, {BackSpace 2}{U+0107}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::c::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; Í
:z:eee::
    Send, {BackSpace 2}ee
    Tooltip,
return

::ee::
        Send, {BackSpace 2}{U+0119}
        Tooltip, Double?, % A_CaretX, % A_CaretY-20
return

::e::
    Tooltip, Diactric?, % A_CaretX, % A_CaretY-20
return

; ≥
:z:lll::
    Send, {BackSpace 2}ll
    Tooltip,
return

::ll::
        Send, {BackSpace 2}{U+0142}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::l::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; Ò
:z:nnn::
    Send, {BackSpace 2}nn
    Tooltip,
return

::nn::
        Send, {BackSpace 2}{U+0144}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::n::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; Û
:z:ooo::
    Send, {BackSpace 2}oo
    Tooltip,
return

::oo::
        Send, {BackSpace 2}{U+00F3}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::o::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; ú
:z:sss::
    Send, {BackSpace 2}ss
    Tooltip,
return

::ss::
        Send, {BackSpace 2}{U+015B}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::s::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; ü
:z:xxx::
    Send, {BackSpace 2}xx
    Tooltip,
return

::xx::
        Send, {BackSpace 2}{U+017A}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::x::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


; ø
:z:zzz::
    Send, {BackSpace 2}zz
    Tooltip,
return

::zz::
        Send, {BackSpace 2}{U+017C}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

::z::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return




;~ CAPITAL_DIACTRIC_LETTERS: • ∆   £ — ” å è Ø

; •
:zb0?*c:AAA::
    Send, {BackSpace 2}AA
    Tooltip,
return

:b0?*c:AA::
        Send, {BackSpace 2}{U+0104}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:A::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; ∆
:zb0?*c:CCC::
    Send, {BackSpace 2}CC
    Tooltip,
return

:b0?*c:CC::
        Send, {BackSpace 2}{U+0106}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:C::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

;  
:zb0?*c:EEE::
    Send, {BackSpace 2}EE
    Tooltip,
return

:b0?*c:EE::
        Send, {BackSpace 2}{U+0118}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:E::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; £
:zb0?*c:LLL::
    Send, {BackSpace 2}LL
    Tooltip,
return

:b0?*c:LL::
    Send, {BackSpace 2}{U+0141}
    Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:L::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


; —
:zb0?*c:NNN::
    Send, {BackSpace 2}NN
    Tooltip,
return

:b0?*c:NN::
        Send, {BackSpace 2}{U+0143}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:N::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


; ”
:zb0?*c:OOO::
    Send, {BackSpace 2}OO
    Tooltip,
return

:b0?*c:OO::
        Send, {BackSpace 2}{U+00D3}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:O::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return

; å
:zb0?*c:SSS::
    Send, {BackSpace 2}SS
    Tooltip,
return

:b0?*c:SS::
        Send, {BackSpace 2}{U+015A}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:S::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


; è
:zb0?*c:XXX::
    Send, {BackSpace 2}XX
    Tooltip,
return

:b0?*c:XX::
        Send, {BackSpace 2}{U+0179}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:X::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


; Ø
:zb0?*c:ZZZ::
    Send, {BackSpace 2}zz
    Tooltip,
return

:b0?*c:ZZ::
        Send, {BackSpace 2}{U+017B}
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
return

:b0?*c:Z::
    Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
return


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

;~ ~BackSpace::
    ;~ Hotstring("Reset")
;~ return

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
    Gui, MyAbout: Add, Text, x+1, ): π, Í, ú, Ê, ø, ü, Ò, Û, ≥.
    Gui, MyAbout: Add, Text, xm, Instead of usage of AltGr (right alt`, see 
    Gui, MyAbout: Font, CBlue Underline 
    Gui, MyAbout: Add, Text, x+2, https://en.wikipedia.org/wiki/AltGr_key#Polish 
    Gui, MyAbout: Font
    Gui, MyAbout: Add, Text, x+2, for further details):
    Gui, MyAbout: Add, Text, xm+20, * double press a key corresponding to specific diacritic key`, e.g. ee converts into Í
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
