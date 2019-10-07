; Script Function:
;	Put a virtual numeric keypad on the screen

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.

global LastLayer

Layer0:
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     
     ;~ 1st row
     Gui, Layer0:Add, Picture, x12 y9 w60 h60 gNumLockP, ShowHide_60x60.png  
     Gui, Layer0:Add, Button, x12 y69 w60 h60 gNumLockB, Num Lock
     Gui, Layer0:Add, Picture, x92 y9 w60 h60 gNumpadDivP, KeePass_60x60.png 
     Gui, Layer0:Add, Button, x92 y69 w60 h60 gNumpadDivB, /
     Gui, Layer0:Add, Picture, x172 y9 w60 h60 gNumpadMultP, MicrosoftWord.png 
     Gui, Layer0:Add, Button, x172 y69 w60 h60 gNumpadMultB, *
     Gui, Layer0:Add, Picture, x252 y9 w60 h60 gNumpadSubP, Default_60x60.png
     Gui, Layer0:Add, Button, x252 y69 w60 h60 gNumpadSubB, -
     
     ;~ 2nd row
     Gui, Layer0:Add, Picture, x12 y149 w60 h60 gNumpadHomeP, Default_60x60.png
     Gui, Layer0:Add, Button, x12 y209 w60 h60 gNumpadHomeB, Home
     Gui, Layer0:Add, Picture, x92 y149 w60 h60 gNumpadUpP, Default_60x60.png
     Gui, Layer0:Add, Button, x92 y209 w60 h60 gNumpadUpB, Up
     Gui, Layer0:Add, Picture, x172 y149 w60 h60 gNumpadPgUpP, Default_60x60.png
     Gui, Layer0:Add, Button, x172 y209 w60 h60 gNumpadPgUpB, PgUp
     Gui, Layer0:Add, Picture, x252 y149 w60 h200 gNumPadAddP, Default_60x60.png
     Gui, Layer0:Add, Button, x252 y349 w60 h60 gNumPadAddB, +
     
     ;~ 3rd row
     Gui, Layer0:Add, Picture, x12 y289 w60 h60 gNumpadLeftP, Default_60x60.png
     Gui, Layer0:Add, Button, x12 y349 w60 h60 gNumpadLeftB, Left
     Gui, Layer0:Add, Picture, x92 y289 w60 h60 gNumpadBlankP, Default_60x60.png
     Gui, Layer0:Add, Button, x92 y349 w60 h60 gNumpadBlankB, Blank
     Gui, Layer0:Add, Picture, x172 y289 w60 h60 gNumpadRightP, Default_60x60.png
     Gui, Layer0:Add, Button, x172 y349 w60 h60 gNumpadRightB, Right
     ;~ Gui, Layer0:Add, Picture, x252 y289 w60 h60 gNumpadBackspaceP, Default_60x60.png
     ;~ Gui, Layer0:Add, Button, x252 y349 w60 h60 gNumpadBackspaceB, Back Space
     
     ;~ 4th row
     Gui, Layer0:Add, Picture, x12 y429 w60 h60 gNumpadEndP, Default_60x60.png
     Gui, Layer0:Add, Button, x12 y489 w60 h60 gNumpadEndB, End
     Gui, Layer0:Add, Picture, x92 y429 w60 h60 gNumpadDownP, Default_60x60.png
     Gui, Layer0:Add, Button, x92 y489 w60 h60 gNumpadDownB, Down
     Gui, Layer0:Add, Picture, x172 y429 w60 h60 gNumpadPgDnP, Default_60x60.png
     Gui, Layer0:Add, Button, x172 y489 w60 h60 gNumpadPgDnB, PgDn
     Gui, Layer0:Add, Picture, x252 y429 w60 h200 gNumpadEnterP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png
     Gui, Layer0:Add, Button, x252 y629 w60 h60 gNumpadEnterB, Enter
     
     ;~ 5th row
     Gui, Layer0:Add, Picture, x12 y569 w140 h60 gNumpadInsP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png
     Gui, Layer0:Add, Button, x12 y629 w140 h60 gNumpadInsB, Ins
     Gui, Layer0:Add, Picture, x172 y569 w60 h60 gNumpadDelP, Default_60x60.png
     Gui, Layer0:Add, Button, x172 y629 w60 h60 gNumpadDelB, Del
     
     ; Generated using SmartGUI Creator for SciTE
     Gui, Layer0:Hide
     ;~ Gui, Layer0:Show, w326 h703, Flow
     ;~ LastLayer := 0
;~ return


Layer1:
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     
     ;~ 1st row
     Gui, Layer1:Add, Picture, x12 y9 w60 h60 gNumLockP, ShowHide_60x60.png  
     Gui, Layer1:Add, Button, x12 y69 w60 h60 gNumLockB, Num Lock
     
     Gui, Layer1:Add, Picture, x92 y9 w60 h60 gNumpadDivP, %A_ScriptDir%\Layer1\Word_Styles_60x60.png 
     Gui, Layer1:Add, Button, x92 y69 w60 h60 gNumpadDivB, /
     
     Gui, Layer1:Add, Picture, x172 y9 w60 h60 gNumpadMultP, %A_ScriptDir%\Layer1\Word_BuildingBlocks_60x60.png 
     Gui, Layer1:Add, Button, x172 y69 w60 h60 gNumpadMultB, *
     
     Gui, Layer1:Add, Picture, x252 y9 w60 h60 gNumpadSubP, %A_ScriptDir%\Layer1\Word_Macros_60x60.png
     Gui, Layer1:Add, Button, x252 y69 w60 h60 gNumpadSubB, -
     
     ;~ 2nd row
     Gui, Layer1:Add, Picture, x12 y149 w60 h60 gNumpadHomeP, Default_60x60.png
     Gui, Layer1:Add, Button, x12 y209 w60 h60 gNumpadHomeB, Home
     Gui, Layer1:Add, Picture, x92 y149 w60 h60 gNumpadUpP, Default_60x60.png
     Gui, Layer1:Add, Button, x92 y209 w60 h60 gNumpadUpB, Up
     Gui, Layer1:Add, Picture, x172 y149 w60 h60 gNumpadPgUpP, Default_60x60.png
     Gui, Layer1:Add, Button, x172 y209 w60 h60 gNumpadPgUpB, PgUp
     
     Gui, Layer1:Add, Picture, x252 y149 w60 h200 gNumPadAddP, %A_ScriptDir%\Layer1\Forward_60x200.png 
     Gui, Layer1:Add, Button, x252 y349 w60 h60 gNumPadAddB, +
     
     ;~ 3rd row
     Gui, Layer1:Add, Picture, x12 y289 w60 h60 gNumpadLeftP, Default_60x60.png
     Gui, Layer1:Add, Button, x12 y349 w60 h60 gNumpadLeftB, Left
     Gui, Layer1:Add, Picture, x92 y289 w60 h60 gNumpadBlankP, Default_60x60.png
     Gui, Layer1:Add, Button, x92 y349 w60 h60 gNumpadBlankB, Blank
     Gui, Layer1:Add, Picture, x172 y289 w60 h60 gNumpadRightP, Default_60x60.png
     Gui, Layer1:Add, Button, x172 y349 w60 h60 gNumpadRightB, Right
     
     ;~ 4th row
     Gui, Layer1:Add, Picture, x12 y429 w60 h60 gNumpadEndP, Default_60x60.png
     Gui, Layer1:Add, Button, x12 y489 w60 h60 gNumpadEndB, End
     Gui, Layer1:Add, Picture, x92 y429 w60 h60 gNumpadDownP, Default_60x60.png
     Gui, Layer1:Add, Button, x92 y489 w60 h60 gNumpadDownB, Down
     Gui, Layer1:Add, Picture, x172 y429 w60 h60 gNumpadPgDnP, Default_60x60.png
     Gui, Layer1:Add, Button, x172 y489 w60 h60 gNumpadPgDnB, PgDn
     
     Gui, Layer1:Add, Picture, x252 y429 w60 h200 gNumpadEnterP, %A_ScriptDir%\Layer1\Back_60x200.png
     Gui, Layer1:Add, Button, x252 y629 w60 h60 gNumpadEnterB, Enter
     
     ;~ 5th row
     Gui, Layer1:Add, Picture, x12 y569 w140 h60 gNumpadInsP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png
     Gui, Layer1:Add, Button, x12 y629 w140 h60 gNumpadInsB, Ins
     Gui, Layer1:Add, Picture, x172 y569 w60 h60 gNumpadDelP, Default_60x60.png
     Gui, Layer1:Add, Button, x172 y629 w60 h60 gNumpadDelB, Del
     
     ; Generated using SmartGUI Creator for SciTE
     ;~ Gui, Layer1:Show, w326 h703, Flow
     Gui, Layer1:Hide


Layer2:
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     
     ;~ 1st row
     Gui, Layer2:Add, Picture, x12 y9 w60 h60 gNumLockP, ShowHide_60x60.png
     Gui, Layer2:Add, Button, x12 y69 w60 h60 gNumLockB, Num Lock
     
     Gui, Layer2:Add, Picture, x92 y9 w60 h60 gNumpadDivP, %A_ScriptDir%\Layer2\BB01_60x60.png  
     Gui, Layer2:Add, Button, x92 y69 w60 h60 gNumpadDivB, /
     
     Gui, Layer2:Add, Picture, x172 y9 w60 h60 gNumpadMultP, %A_ScriptDir%\Layer2\BB02_60x60.png  
     Gui, Layer2:Add, Button, x172 y69 w60 h60 gNumpadMultB, *
     
     Gui, Layer2:Add, Picture, x252 y9 w60 h60 gNumpadSubP, %A_ScriptDir%\Layer2\BB03_60x60.png 
     Gui, Layer2:Add, Button, x252 y69 w60 h60 gNumpadSubB, -
     
     ;~ 2nd row
     Gui, Layer2:Add, Picture, x12 y149 w60 h60 gNumpadHomeP, Default_60x60.png
     Gui, Layer2:Add, Button, x12 y209 w60 h60 gNumpadHomeB, Home
     Gui, Layer2:Add, Picture, x92 y149 w60 h60 gNumpadUpP, Default_60x60.png
     Gui, Layer2:Add, Button, x92 y209 w60 h60 gNumpadUpB, Up
     Gui, Layer2:Add, Picture, x172 y149 w60 h60 gNumpadPgUpP, Default_60x60.png
     Gui, Layer2:Add, Button, x172 y209 w60 h60 gNumpadPgUpB, PgUp
     
     Gui, Layer2:Add, Picture, x252 y149 w60 h200 gNumPadAddP, %A_ScriptDir%\Layer2\Forward_60x200.png 
     Gui, Layer2:Add, Button, x252 y349 w60 h60 gNumPadAddB, +
     
     ;~ 3rd row
     Gui, Layer2:Add, Picture, x12 y289 w60 h60 gNumpadLeftP, Default_60x60.png
     Gui, Layer2:Add, Button, x12 y349 w60 h60 gNumpadLeftB, Left
     Gui, Layer2:Add, Picture, x92 y289 w60 h60 gNumpadBlankP, Default_60x60.png
     Gui, Layer2:Add, Button, x92 y349 w60 h60 gNumpadBlankB, Blank
     Gui, Layer2:Add, Picture, x172 y289 w60 h60 gNumpadRightP, Default_60x60.png
     Gui, Layer2:Add, Button, x172 y349 w60 h60 gNumpadRightB, Right
     
     ;~ 4th row
     Gui, Layer2:Add, Picture, x12 y429 w60 h60 gNumpadEndP, Default_60x60.png
     Gui, Layer2:Add, Button, x12 y489 w60 h60 gNumpadEndB, End
     Gui, Layer2:Add, Picture, x92 y429 w60 h60 gNumpadDownP, Default_60x60.png
     Gui, Layer2:Add, Button, x92 y489 w60 h60 gNumpadDownB, Down
     Gui, Layer2:Add, Picture, x172 y429 w60 h60 gNumpadPgDnP, Default_60x60.png
     Gui, Layer2:Add, Button, x172 y489 w60 h60 gNumpadPgDnB, PgDn
     Gui, Layer2:Add, Picture, x252 y429 w60 h200 gNumpadEnterP, %A_ScriptDir%\Layer2\Back_60x200.png
     Gui, Layer2:Add, Button, x252 y629 w60 h60 gNumpadEnterB, Enter
     
     ;~ 5th row
     Gui, Layer2:Add, Picture, x12 y569 w140 h60 gNumpadInsP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png
     Gui, Layer2:Add, Button, x12 y629 w140 h60 gNumpadInsB, Ins
     Gui, Layer2:Add, Picture, x172 y569 w60 h60 gNumpadDelP, Default_60x60.png
     Gui, Layer2:Add, Button, x172 y629 w60 h60 gNumpadDelB, Del
     
     ; Generated using SmartGUI Creator for SciTE
     ;~ Gui, Layer2:Show, w326 h703, Flow
     Gui, Layer2:Hide

     LastLayer := 0
     
     NumLockState := GetKeyState("NumLock", "T")
     if (NumLockState == 0)
          {
          Gui, Layer0:Show 
          }
     else
          {
          Gui, Layer0:Hide     
          }
return




~NumLock:: ; NumLock key support
     KeyWait, NumLock
     NumLockState := GetKeyState("NumLock", "T")

     if (NumLockState == 0) ; Show
          {
          if (LastLayer == 0)
               {
               Gui, Layer0:Show
               }
          else if (LastLayer == 1)
               {
               Gui, Layer1:Show
               }     
          else if (LastLayer == 2)
               {
               Gui, Layer2:Show     
               }     
          }
     else ; Hide
          {
          if (LastLayer == 0)
               {
               Gui, Layer0:Hide
               }
          else if (LastLayer == 1)
               {
               Gui, Layer1:Hide
               }
          else if (LastLayer == 2)
               {
               Gui, Layer2:Hide     
               }     
          }
return


Layer0GuiClose:
Layer1GuiClose:
NumLockP:
NumLockB:
     ExitApp

;~ 1st row
NumpadDiv::
NumpadDivP:
NumpadDivB:

NumpadMult::
NumpadMultP:
NumpadMultB:
     if (LastLayer == 0)
          {
          Gui, Layer0:Hide
          Gui, Layer1:Show, w326 h703, Flow
          LastLayer := 1
          }
     else if (LastLayer == 1)
          {
          Gui, Layer1:Hide
          Gui, Layer2:Show, w326 h703, Flow
          LastLayer := 2
          }     
     return

NumpadSub::
NumpadSubP:
NumpadSubB:
     MsgBox, 1th row
return

;~ 2nd row
NumpadHome::
NumpadHomeP:
NumpadHomeB:

NumpadUp::
NumpadUpP:
NumpadUpB:

NumpadPgup::
NumpadPgUpP:
NumpadPgUpB:

NumpadAdd::
NumPadAddP:
NumPadAddB:
     MsgBox, 2th row
return

;~ 3rd row
NumpadLeft::
NumpadLeftP:
NumpadLeftB:

NumpadClear::
NumpadBlankP:
NumpadBlankB:

NumpadRight::
NumpadRightP:
NumpadRightB:

;~ NumpadBackspaceP:
;~ NumpadBackspaceB:
     MsgBox, 3th row
return

;~ 4th row
NumpadEnd::
NumpadEndP:
NumpadEndB:

NumpadDown::
NumpadDownP:
NumpadDownB:

NumpadPgdn::
NumpadPgDnP:
NumpadPgDnB:

NumpadEnter::
NumpadEnterP:
NumpadEnterB:
     MsgBox, 4th row
return

;~ 5th row
NumpadIns::
NumpadInsP:
NumpadInsB:

NumpadDel::
NumpadDelP:
NumpadDelB:
     MsgBox, 5th row
return