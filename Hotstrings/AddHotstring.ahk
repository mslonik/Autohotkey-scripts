HotstringAutoExec:

#SingleInstance, Force

Global CapCheck

Gui, Hotstring:Font, s14 cBlue Bold , Calibri
Gui, Hotstring:Add, Text, Section vText1 , Enter Hotstring
Gui, Hotstring:Font, s12 cBlack Norm
Gui, Hotstring:Add, Edit, w100 vNewString ys, 

Gui, Hotstring:Font, s14 cBlue Bold
Gui, Hotstring:Add, Text,  xs vText2, Enter Replacement Text 
Gui, Hotstring:Font, s12 cBlack Norm
Gui, Hotstring:Add, Edit, w400 vTextInsert xs
Gui, Hotstring:Add, DropDownList, w400 vStringCombo xs gViewString Sort AltSubmit,

Gui, Hotstring:Font, s14 cBlue Bold
Gui, Hotstring:Add, GroupBox, section w400 h110, Hotstring Options
Gui, Hotstring:Font, s12 cBlack Norm
Gui, Hotstring:Add, CheckBox, vCaseSensitive gCapsCheck xp+15 ys+25, Case Sensitive (C)
Gui, Hotstring:Add, CheckBox, vNoBackspace gCapsCheck xp+210 yp+0, No Backspace (B0)
Gui, Hotstring:Add, CheckBox, vImmediate gCapsCheck  xp-210 yp+20, Immediate Execute (*)
Gui, Hotstring:Add, CheckBox, vInsideWord gCapsCheck  xp+210 yp+0, Inside Word (?)
Gui, Hotstring:Add, CheckBox, vNoEndChar gCapsCheck  xp-210 yp+20, No End Char (O)
Gui, Hotstring:Add, CheckBox, vRaw gCapsCheck  xp+210 yp+0, Raw Text Mode (T)
Gui, Hotstring:Add, CheckBox, vExecute gCapsCheck  xp-210 yp+20, Labels/Functions (X)
Gui, Hotstring:Add, CheckBox, vByClip gCapsCheck xp+210 yp+0, Clipboard Hotstring

Gui, Hotstring:Font, Bold
Gui, Hotstring:Add, Button, gAddHotstring section xm, Set Hotstring
Gui, Hotstring:Add, Button, gToggleString vDisable ys, Toggle Hotstring On/Off

Gui, Hotstring:Font, s14 cBlue
Gui, Hotstring:Add, Text,  xm vText3, Hotstring Test Pad
Gui, Hotstring:Font, s12 Norm
Gui, Hotstring:Add, Edit,  xm r4 w400  cGreen, 

Gui, Hotstring:Font, s12 cBlack Bold
Gui, Hotstring:Add, Text, xs ,Choose section:
Gui, Hotstring:Font, s12 cBlack Norm
Gui, Hotstring:Add, DropDownList, w400 vSectionCombo gSectionChoose xs AltSubmit, Personal|voestalpine|Physics, Mathematics & Other Symbols|Abbreviations|Polish|German|Date & Time|Names|Emoji & Emoticons|Full Titles of Technical Standards|Autocorrection|Capital Letters

Gui, Hotstring:Font, Bold
Gui, Hotstring:Add, Button, gSaveHotstrings section xm, Save Hotstrings

Gui, Hotstring:Add, Button, gReload ys, Reload

Gui, Hotstring:Font, s14 cBlue Bold , Arial
Gui, Hotstring:Add, Text, ym, Hotstrings in section
Gui, Hotstring:Font, s12 cBlack Norm
Gui, Hotstring:Add, ListView, yp+25 xp h510 w500 vHSList , Hotstring|Text
Menu, Tray, Add, Show Instant Hotstrings, ShowHotstrings

ShowHotstrings:
Gui, Hotstring:Show, , Instant Hotstrings
Return

ViewString:
ControlGet, Select, Choice ,, ComboBox1, A
  HotString := StrSplit(Select, ":",,5)
  GuiControl, , Edit1, % HotString[3]
  GuiControl, , Edit2, % HotString[5]

  GoSub SetOptions

; Sets controls for disabled/enabled
 If InStr(HotString[5], "??")
  {
    GuiControl,, Disable , % "?? Enable Hotstring"
    GuiControl, , Edit2, % SubStr(HotString[5],1,-11)
  }
  Else
  {
    GuiControl,, Disable , Disable Hotstring
    GuiControl, , Edit2, % HotString[5]
  }

; Cleans and sets cursor to Test Pad
  SetTestPad()

Return

AddHotstring:
Gui, Hotstring:+OwnDialogs
Gui, Submit, NoHide

If (Trim(NewString) ="")
{
  MsgBox Enter a Hotstring!
    Return
}

If (Trim(TextInsert) ="")
{
  MsgBox Replacement text cannot be blank!
    Return
}

; Trap for non-existent Label or function when using the X option.
MsgBox % TextInsert . " " . IsFunc(TextInsert)
RegExMatch(TextInsert, "(.*)\(" , FuncMatch) 
If (Execute = 1) and (IsLabel(TextInsert) = 0) and (IsFunc(FuncMatch1) = 0)
{
  MsgBox, Replacement text must be a Label or function
Return
}
OldOptions := ""

; Delete target item from DropDownList control.
; ControlGet and Control commands do not work for hidden windows,
; therefore, Hotstrings loaded from files are not checked for duplicates.

;If (LoadHotstrings != 1)     ; Skip when loading from file
;{
  ControlGet, Items, List,, ComboBox1, A
  Loop, Parse, Items, `n
  {
  
    If InStr(A_LoopField, ":" . NewString . """", CaseSensitive)
    {
      HotString := StrSplit(A_LoopField, ":",,3)
      OldOptions := HotString[2]
      Control, Delete, %A_Index% , ComboBox1
      Break
    }
  }
;}

; Added this conditional to prevent Hotstrings from a file losing the C1 option caused by
; cascading ternary operators when creating the options string. CapCheck set to 1 when 
; a Hotstring from a file contains the C1 option.

If (CapCheck = 1) and ((OldOptions = "") or (InStr(OldOptions,"C1"))) and (Instr(Hotstring[2],"C1"))
    OldOptions := StrReplace(OldOptions,"C1") . "C"
CapCheck := 0

GuiControl,, Disable , Toggle Hotstring On/Off

GoSub OptionString   ; Writes the Hotstring options string


; Check for # in Web URL TextInsert and add curly brackets
If (InStr(TextInsert,"{#}") = 0 
    and InStr(TextInsert,"http") 
    and (InStr(Options,"T") = 0
    or InStr(Options,"T0")))
{
  If InStr(Options,"T0")
  {
    Options := StrReplace(Options,"T0","T")
    Options := StrReplace(Options,"O0","O")
  }
  Else
  {
    Options := Options . "O"
    Options := Options . "T"
  }
  Control, Check, , Button7, A  ; Raw Text Mode
  Control, Check, , Button6, A  ; Raw Text Mode
}

/*
This conditional routine looks for Hotkey modifiers in the replacement
text giving you the chance to set the mode to raw.
*/

If RegExMatch(TextInsert, "[!+#^{}]" , Modifier)
    and RegExMatch(TextInsert, "{.*}") = 0
    and (InStr(Options,"T") = 0 or InStr(Options,"T0"))
;    and (LoadHotstrings = 0)
      MsgBox,3,Modifier Found, Hotkey modifier %modifier% found!`rSet Raw Text Mode?
        IfMsgBox Yes
        {
          If InStr(Options,"T0")
            Options := StrReplace(Options,"T0","T")
          Else
            Options := Options . "T"
          Control, Check, , Button7, A  ; Raw Text Mode
        }



; Add new/changed target item in DropDownList
if (ByClip == 1)
  SendFun := "ViaClipboard"
else
  SendFun := "NormalWay"

   GuiControl,, ComboBox1 , % "Hotstring("":" . Options . ":" . NewString . """, func(""" . SendFun . """).bind(""" . TextInsert . """))"

; Select target item in list
GuiControl, ChooseString, ComboBox1, % "Hotstring("":" . Options . ":" . NewString . """, func(""" . SendFun . """).bind(""" . TextInsert . """))"

; If case sensitive (C) or inside a word (?) first deactivate Hotstring
If (CaseSensitive or InsideWord or InStr(OldOptions,"C") 
     or InStr(OldOptions,"?")) 
     Hotstring(":" . OldOptions . ":" . NewString , TextInsert , "Off")

; Create Hotstring and activate
Hotstring(":" . Options . ":" . NewString, TextInsert, "On")

; Cleans and sets cursor to Test Pad
  SetTestPad()
return

SetTestPad()
{
  GuiControl, Focus, Edit3
  GuiControl, , Edit3,
}

ToggleString:
Gui, Hotstring:+OwnDialogs
If (NewString ="")
{
    MsgBox Create and set Hotstring!
    Return
}

  ControlGet, Select, Choice ,, ComboBox1, A
  GuiControlGet, Pick ,, ComboBox1
  Control, Delete, %Pick% , ComboBox1
  
  if InStr(Select, ",""On""")
  {
    GuiControl,, Disable , Enable Hotstring
    HotString := StrReplace(Select, ",""On""", ",""Off""")
    GuiControl, ,ComboBox1, % HotString
  }
  else if InStr(Select, ",""Off""")
  {
     GuiControl,, Disable , Disable Hotstring
     HotString := StrReplace(Select, ",""Off""", ",""On""")
     GuiControl,, ComboBox1, % HotString
  }
  else
  {
     GuiControl,, Disable , Enable Hotstring
     HotString := StrReplace(Select, "))", "),""Off"")")
      GuiControl,, ComboBox1, % HotString
  }
Return

SetOptions:
If InStr(Hotstring[2],"R")
   Hotstring[2] := StrReplace(Hotstring[2],"R","T")

OptionSet := ((Instr(Hotstring[2],"C0")) or (Instr(Hotstring[2],"C1")) or (Instr(Hotstring[2],"C") = 0)) 
    ? CheckOption("No",2)  :  CheckOption("Yes",2)

OptionSet := Instr(Hotstring[2],"B0") ? CheckOption("Yes",3)  :  CheckOption("No",3)
OptionSet := Instr(Hotstring[2],"*0") or InStr(Hotstring[2],"*") = 0 ? CheckOption("No",4)
                  :  CheckOption("Yes",4)
OptionSet := Instr(Hotstring[2],"?") ? CheckOption("Yes",5)  :  CheckOption("No",5)
OptionSet := (Instr(Hotstring[2],"O0") or (InStr(Hotstring[2],"O") = 0)) ? CheckOption("No",6)
                  :  CheckOption("Yes",6)
OptionSet := (Instr(Hotstring[2],"T0") or (InStr(Hotstring[2],"T") = 0)) ? CheckOption("No",7)
                  :  CheckOption("Yes",7)
OptionSet := (Instr(Hotstring[2],"X0") or (InStr(Hotstring[2],"X") = 0)) ? CheckOption("No",8)
                  :  CheckOption("Yes",8)
CapCheck := 0
Return

OptionString:

Options := ""

Options := CaseSensitive = 1 ? Options . "C"
     : (Instr(OldOptions,"C1")) ?  Options . "C0"
     : (Instr(OldOptions,"C0")) ?  Options
     : (Instr(OldOptions,"C")) ? Options . "C1" : Options

Options := NoBackspace = 1 ?  Options . "B0" 
   : (NoBackspace = 0) and (Instr(OldOptions,"B0"))
  ? Options . "B" : Options

Options := (Immediate = 1) ?  Options . "*" 
     : (Instr(OldOptions,"*0")) ?  Options
     : (Instr(OldOptions,"*")) ? Options . "*0" : Options

Options := InsideWord = 1 ?  Options . "?" : Options

Options := (NoEndChar = 1) ?  Options . "O"
     : (Instr(OldOptions,"O0")) ?  Options
     : (Instr(OldOptions,"O")) ? Options . "O0" : Options
 
Options := Raw = 1 ?  Options . "T" 
     : (Instr(OldOptions,"T0")) ?  Options
     : (Instr(OldOptions,"T")) ? Options . "T0" : Options

Options := Execute = 1 ?  Options . "X" : Options

; Added to ensure that Hotstring[2] contains current options
Hotstring[2] := Options
Return

CheckOption(State,Button)
{
If (State = "Yes")
  {
    State := 1
    GuiControl, , Button%Button%, 1
  }
Else 
  {
    State := 0
    GuiControl, , Button%Button%, 0
  }
  Button := "Button" . Button

  CheckBoxColor(State,Button)  
}

SaveHotstrings:
Gui, Hotstring:+OwnDialogs

if (SectionCombo = 1)
{
  SaveFile = PersonalHotstrings.ahk
}
else if (SectionCombo = 2)
{
  SaveFile = voestalpineHotstrings.ahk
}
else if (SectionCombo = 3)
{
  SaveFile = PhysicsHotstrings.ahk
}
else if (SectionCombo = 4)
{
  SaveFile = Abbreviations.ahk
}
else if (SectionCombo = 5)
{
  SaveFile = PolishHotstrings.ahk
}
else if (SectionCombo = 6)
{
  SaveFile = GermanHotstrings.ahk
}
else if (SectionCombo = 7)
{
  SaveFile = TimeHotstrings.ahk
}
else if (SectionCombo = 8)
{
  SaveFile = FirstAndSecondNames.ahk
}
else if (SectionCombo = 9)
{
  SaveFile = EmojiHotstrings.ahk
}
else if (SectionCombo = 10)
{
  SaveFile = TechnicalHotstrings.ahk
}
else if (SectionCombo = 11)
{
  SaveFile = AutocorrectionHotstrings.ahk
}
else if (SectionCombo = 12)
{
  SaveFile = CapitalLetters.ahk
}
else
{
  MsgBox, Choose section before saving!
  return
}

SaveFile := StrReplace(SaveFile, ".ahk", "")

ControlGet, Items, List,, ComboBox1, A

Loop, Parse, Items, `n
{
  If (InStr(A_LoopField, "?? Stopped!") = 0)
  {
      FileAppend , `r`n%A_LoopField%, %SaveFile%.ahk, UTF-8
  }
}
MsgBox Hotstrings added to the %SaveFile%.ahk file!
Run, AutoHotkey.exe Hotstrings.ahk
gosub, Reload
Return

LoadHotstrings:
Return

CapsCheck:
  If (Instr(HotString[2], "C1"))
       CapCheck := 1
  GuiControlGet, OutputVar1, Focus
  GuiControlGet, OutputVar2, , %OutputVar1%
; If (LoadHotstrings =0)
  CheckBoxColor(OutputVar2,OutputVar1)
Return

CheckBoxColor(State,Button)
{
  If (State = 1)
    Gui, Hotstring:Font, s12 cRed Norm, Calibri
  Else 
    Gui, Hotstring:Font, s12 cBlack Norm, Calibri
  GuiControl, Hotstring:Font, %Button%
}

Reload:
  Gui, Hotstring:+OwnDialogs
  MsgBox, 4,, All Hotstrings will be deleted!`r`rContinue?
  IfMsgBox Yes
    Run, AutoHotkey.exe AddHotstring.ahk
Return

Click1:
  Gui, Hotstring:+OwnDialogs
  MsgBox,,, Click Label!, 5
Return

Click()
{
  Gui, Hotstring:+OwnDialogs
  MsgBox,,, Click function!, 5
}

Tags:
Return

TextMenu(TextOptions)
{
  MenuItems := StrSplit(TextOptions, "`,")
  Loop % MenuItems.MaxIndex()
  {
    Item := MenuItems[A_Index]
    Menu, MyMenu, add, %Item%, MenuAction
  }
  Menu, MyMenu, Show ,%A_CaretX%,%A_CaretY%
  Menu, MyMenu, DeleteAll
}

MenuAction:
  InsertText := StrSplit(A_ThisMenuItem, "|")
  TextOut := StrReplace(RTrim(InsertText[1]), "&")
  SendInput {raw}%TextOut%%A_EndChar%
Return

Reset:
  Send, % SubStr(A_ThisHotkey,4)
  Click, %A_CaretX%, %A_CaretY%
  Send, % A_EndChar
Return

SectionChoose:
Gui, Hotstring:Submit, NoHide
LV_ModifyCol(1,100)
LV_Delete()
if (SectionCombo = 1)
{
  FileRead, Text, PersonalHotstrings.ahk
}
else if (SectionCombo = 2)
{
  FileRead, Text, voestalpineHotstrings.ahk
}
else if (SectionCombo = 3)
{
  FileRead, Text, PhysicsHotstrings.ahk
}
else if (SectionCombo = 4)
{
  FileRead, Text, Abbreviations.ahk
}
else if (SectionCombo = 5)
{
  FileRead, Text, PolishHotstrings.ahk
}
else if (SectionCombo = 6)
{
  FileRead, Text, GermanHotstrings.ahk
}
else if (SectionCombo = 7)
{
  FileRead, Text, TimeHotstrings.ahk
}
else if (SectionCombo = 8)
{
  FileRead, Text, FirstAndSecondNames.ahk
}
else if (SectionCombo = 9)
{
  FileRead, Text, EmojiHotstrings.ahk
}
else if (SectionCombo = 10)
{
  FileRead, Text, TechnicalHotstrings.ahk
}
else if (SectionCombo = 11)
{
  FileRead, Text, AutocorrectionHotstrings.ahk
}
else if (SectionCombo = 12)
{
  FileRead, Text, CapitalLetters.ahk
}
  
  SectionList := StrSplit(Text, "`r`n")
  Loop, % SectionList.MaxIndex()
  {
    str1 := StrSplit(SectionList[A_Index], """")
    str2 := StrSplit(SectionList[A_Index], "bind(")  
    str2 := SubStr(str2[2], 1, StrLen(str2[2])-2) 
    LV_Add("", str1[2], str2)
  }
Return

ViaClipboard(ReplacementString)
{
	ClipboardBackup := ClipboardAll
    Clipboard := ReplacementString
	Send, ^v
	Sleep, 200 ; this sleep is required surprisingly
	Clipboard := ClipboardBackup
    ClipboardBackup := ""
}
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
NormalWay(ReplacementString)
{
	Send, %ReplacementString%
}