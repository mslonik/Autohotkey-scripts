;~              I N T R O D U C T I O N
;~ Simple script for Polisch diacritic marks (https://en.wikipedia.org/wiki/Diacritic): π, Í, ú, Ê, ø, ü, Ò, Û, ≥.
;~ Instead of usage of AltGr (right alt, see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details):
;~ * double press a key corresponding to specific diacritic key, e.g. ee converts into Í
;~ * AltGr suspend run of this script (switches to default behaviour of keyboard
;~ * special sequence for double letters within words: <letter><space><space><letter>, e.g. za  awansowany converts into zaawansowanyGui, Font, S8 CDefault Bold, Verdana
;~ 
;~ WHY:
;~ a. "programmers keyboard" and Polish diactric marks combined with old ANSI keyboards 101 keys (without Windows key and context key) where AltGr is unergonomically shifted to the right side of keyboard,
;~ b. all other "programmers keyboard" when one doesn't want to press AltGr.
;~
;~ Special concerns: 
;~ double letters within words, e.g. zaawansowany; use sequence: <letter><space><space><letter>, e.g. za  awansowany
;~ two consecutive words: previous ending with the same letter as next one, e.g. co oko -> see above sequence.
;~ Author: Maciej S≥ojewski, 2019-08-04 
;~
;~ Base for all actions are "Hotstrings".
;~ :: (default hotstring)
;~ ?: (question mark): The hotstring will be triggered even when it is inside another word
;~ *: (asterisk): An ending character is not required to trigger the hotstring
;~ c: Case sensitive: When you type an abbreviation, it must exactly match the case defined in the script. 

#SingleInstance,Force ; Determines whether a script is allowed to run again when it is already running. Force: Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

ApplicationName := "Diactrics"

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

:?*c:aa::{U+0105} ; π
:?*c:a  a::aa     ; 2x space
:?*c:ee::{U+0119} ; Í
:?*c:e  e::ee     ; 2x space
:?*c:ss::{U+015B} ; ú
:?*c:s  s::ss     ; 2x space
:?*c:cc::{U+0107} ; Ê
:?*c:c  c::cc     ; 2x space
:?*c:zz::{U+017C} ; ø
:?*c:z  z::zz     ; 2x space
:?*c:xx::{U+017A} ; ü
:?*c:x  x::xx     ; 2x space
:?*c:nn::{U+0144} ; Ò
:?*c:n  n::nn     ; 2x space
:?*c:oo::{U+00F3} ; Û
:?*c:o  o::oo     ; 2x space
:?*c:ll::{U+0142} ; ≥
:?*c:l  l::ll     ; 2x space

:?*c:AA::{U+0104} ; •
:?*c:A  A::AA     ; 2x space
:?*c:EE::{U+0118} ;  
:?*c:E  E::EE     ; 2x space
:?*c:SS::{U+015A} ; å
:?*c:S  S::SS     ; 2x space
:?*c:CC::{U+0106} ; ∆
:?*c:C  C::CC     ; 2x space
:?*c:ZZ::{U+017B} ; Ø
:?*c:Z  Z::ZZ     ; 2x space
:?*c:XX::{U+0179} ; è
:?*c:X  X::XX     ; 2x space
:?*c:NN::{U+0143} ; —
:?*c:N  N::NN     ; 2x space
:?*c:OO::{U+00D3} ; ”
:?*c:O  O::OO     ; 2x space
:?*c:LL::{U+0141} ; £
:?*c:L  L::LL ; 2x space


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
    Gui, MyAbout: Add, Text, xm+20, * special sequence for double letters within words: <letter><space><space><letter>`, e.g. za  awansowany converts into zaawansowany

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
