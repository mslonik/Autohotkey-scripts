;~              I N T R O D U C T I O N
;~ Simple script for Polish diacritic letters (https://en.wikipedia.org/wiki/Diacritic).
;~ Instead of usage of AltGr (right alt, see https://en.wikipedia.org/wiki/AltGr_key#Polish for further details):
;~ * double press a key corresponding to specific diacritic key, e.g. ee converts into ę
;~ * AltGr suspend run of this script (switches to default behaviour of keyboard
;~ * special sequence for double letters within words: <letter><letter><letter>, e.g. zaaawansowany converts into zaawansowany
;~ 
;~ WHY:
;~ a. "programmers keyboard" and Polish diactric marks combined with old ANSI keyboards 101 keys (without Windows key and context key) where AltGr is unergonomically shifted to the right side of keyboard,
;~ b. all other "programmers keyboard" when one doesn't want to press AltGr or use just one hand to press all letters of alphabet.
;~
;~ Author: Maciej SĹ‚ojewski, 2019-08-04 
;~
;~ Base for all actions are "Hotstrings" generated dynamically (hotstring function).

#SingleInstance,Force ; Determines whether a script is allowed to run again when it is already running. Force: Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

ApplicationName := "Polish Diactrics 5"

Menu, Tray, Icon, imageres.dll, 123     ; this line will turn the H icon into a small red a letter-looking thing.
;~ Gosub, TRAYMENU ; Jumps to the specified label and continues execution until Return is encountered

;~ The order in which hotstrings are defined determines their precedence with respect to each other. In other words, if more than one hotstring matches something you type, only the one listed first in the script will take effect. 

;~ ORDINARY_DIACRIC POLISH LETTERS:             CAPITAL DIACTRIC POLISH LETTERS:
; a - ą {U+0105}                                A - Ą {U+0104}
; c - ć {U+0107}                                C - Ć {U+0106}
; e - ę {U+0119}                                E - Ę {U+0118}
; l - ł {U+0142}                                L - Ł {U+0141}
; n - ń {U+0144}                                N - Ń {U+0143}
; o - ó {U+00F3}                                O - Ó {U+00D3}
; s - ś {U+015B}                                S - Ś {U+015A}
; x - ź {U+017A}                                X - Ź {U+0179}
; z - ż {U+017C}                                Z - Ż {U+017B}


#Hotstring c b0 ? * 

;~ read global variables from .ini file
IniRead, _Language,                         % A_ScriptDir . "\Polish.ini", Global, Language
IniRead, _AmericanLayout,                   % A_ScriptDir . "\Polish.ini", Global, AmericanLayout
IniRead, _AllTooltips,                      % A_ScriptDir . "\Polish.ini", Global, AllTooltips
IniRead, _AllBeeps,                         % A_ScriptDir . "\Polish.ini", Global, AllBeeps
IniRead, _DiactricWord,                     % A_ScriptDir . "\Polish.ini", Global, DiactricWord
IniRead, _DoubleWord,                       % A_ScriptDir . "\Polish.ini", Global, DoubleWord

;~ determine how many [Diactric] sections are in .ini file
DiactricSectionCounter := 0
Loop, Read, % A_ScriptDir . "\Polish.ini"
    {
    if (InStr(A_LoopReadLine, "[Diactric"))
        {
        DiactricSectionCounter++
        }
    }

; Set dynamic hotkeys for all keys of 60% keyboard, ANSI layout
F_AllKeyboardKeys()

;~ read all the rest of configuration parameters from .ini file and create hotstrings
Loop, %DiactricSectionCounter%
    {
    IniRead, _BaseKey,                      % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, BaseKey
    IniRead, _Diactric,                     % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Diactric
    IniRead, _ShiftDiactric,                % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, ShiftDiactric
    IniRead, _Tooltip,                      % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Tooltip

    IniRead, _BaseKey_SoundBeep_Frequency,  % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, BaseKey_SoundBeep_Frequency
    IniRead, _BaseKey_SoundBeep_Duration,   % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, BaseKey_SoundBeep_Duration
    IniRead, _Diactric_SoundBeep_Frequency, % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Diactric_SoundBeep_Frequency
    IniRead, _Diactric_SoundBeep_Duration,  % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Diactric_SoundBeep_Duration
    IniRead, _Double_SoundBeep_Frequency,   % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Double_SoundBeep_Frequency
    IniRead, _Double_SoundBeep_Duration,    % A_ScriptDir . "\Polish.ini", % "Diactric" . A_Index, Double_SoundBeep_Duration

    ;~ MyHotString(_BaseKey, _Diactric, _SoundBeep_Frequency, _SoundBeep_Duration, _Tooltip)
    Hotstring(":zx:" . _BaseKey . _BaseKey . _BaseKey,              func("DoubleLetter").bind(_BaseKey, _Double_SoundBeep_Frequency, _Double_SoundBeep_Duration))
    Hotstring(":x:" . _BaseKey . _BaseKey,                          func("DiactricLetter").bind(_Diactric, _Diactric_SoundBeep_Frequency, _Diactric_SoundBeep_Duration, _Tooltip))
    Hotstring(":x:" . _BaseKey,                                     func("SingleLetter").bind(_BaseKey_SoundBeep_Frequency, _BaseKey_SoundBeep_Duration, _Tooltip))
    StringUpper, _CapitalKey, _BaseKey
    Hotstring(":zx:" . _CapitalKey . _CapitalKey . _CapitalKey,     func("DoubleLetter").bind(_CapitalKey, _Double_SoundBeep_Frequency, _Double_SoundBeep_Duration))
    Hotstring(":x:" . _CapitalKey . _CapitalKey,                    func("DiactricLetter").bind(_ShiftDiactric, _Diactric_SoundBeep_Frequency, _Diactric_SoundBeep_Duration, _Tooltip))
    Hotstring(":x:" . _CapitalKey,                                  func("SingleLetter").bind(_BaseKey_SoundBeep_Frequency, _BaseKey_SoundBeep_Duration, _Tooltip))
    }


 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - - - - 

DoubleLetter(_BaseKey, _Double_SoundBeep_Frequency, _Double_SoundBeep_Duration)
    {
    global _AllBeeps
    
    Send, {BackSpace 2}%_BaseKey%%_BaseKey%
    if (_AllBeeps = "on")
        SoundBeep, _Double_SoundBeep_Frequency, _Double_SoundBeep_Duration
    Tooltip,
    ;~ return
    }

;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DiactricLetter(_Diactric, _Diactric_SoundBeep_Frequency, _Diactric_SoundBeep_Duration, _Tooltip)
    {
    global _AllBeeps, _AllTooltips
    
    Send, {BackSpace 2}%_Diactric%
    if (_AllBeeps = "on")
        SoundBeep, _Diactric_SoundBeep_Frequency, _Diactric_SoundBeep_Duration
    if ((_AllTooltips = "on") && (_Tooltip = "on") )
        {
        Tooltip, Double?, % A_CaretX,% A_CaretY-20
        }
    else
        {
        Tooltip,
        }
    ;~ return
    }
    
;~ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -        

SingleLetter(_BaseKey_SoundBeep_Frequency, _BaseKey_SoundBeep_Duration, _Tooltip)
    {
    global _AllBeeps, _AllTooltips
    
    if (_AllBeeps = "on")
        SoundBeep, _BaseKey_SoundBeep_Frequency, _BaseKey_SoundBeep_Duration
    if ((_AllTooltips = "on") && (_Tooltip = "on") )
        {
        Tooltip, Diactric?, % A_CaretX,% A_CaretY-20
        }
    else
        {
        Tooltip,
        }
    ;~ return
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

 ;~ - - - - - - - - - - - - - - - - - - - - - - SECTION OF LABELS - - - - - - - - - - - - - - - - - - - - - - - - - - - 

SwitchOffTooltip:
    ;~ ToolTip, Carramba
    ToolTip,
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
    Gui, MyAbout: Add, Text, x+1, ): Ä…, Ä™, Ĺ›, Ä‡, ĹĽ, Ĺş, Ĺ„, Ăł, Ĺ‚.
    Gui, MyAbout: Add, Text, xm, Instead of usage of AltGr (right alt`, see 
    Gui, MyAbout: Font, CBlue Underline 
    Gui, MyAbout: Add, Text, x+2, https://en.wikipedia.org/wiki/AltGr_key#Polish 
    Gui, MyAbout: Font
    Gui, MyAbout: Add, Text, x+2, for further details):
    Gui, MyAbout: Add, Text, xm+20, * double press a key corresponding to specific diacritic key`, e.g. ee converts into Ä™
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
