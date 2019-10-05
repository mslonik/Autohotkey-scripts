; Script Function:
;	Put a virtual numeric keypad on the screen

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.


~NumLock:: ; NumLock key support
KeyWait, NumLock
NumLockState := GetKeyState("NumLock", "T")

if (NumLockState == 0)
     {
     Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     
     ;~ 1st row
     Gui, Layer0:Add, Picture, x12 y9 w60 h60 gNumLockP, Exit_60x60.png  
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
     Gui, Layer0:Add, Picture, x252 y149 w60 h60 gNumPadPlusP, Default_60x60.png
     Gui, Layer0:Add, Button, x252 y209 w60 h60 gNumPadPlusB, +
     
     ;~ 3rd row
     Gui, Layer0:Add, Picture, x12 y289 w60 h60 gNumpadLeftP, Default_60x60.png
     Gui, Layer0:Add, Button, x12 y349 w60 h60 gNumpadLeftB, Left
     Gui, Layer0:Add, Picture, x92 y289 w60 h60 gNumpadBlankP, Default_60x60.png
     Gui, Layer0:Add, Button, x92 y349 w60 h60 gNumpadBlankB, Blank
     Gui, Layer0:Add, Picture, x172 y289 w60 h60 gNumpadRightP, Default_60x60.png
     Gui, Layer0:Add, Button, x172 y349 w60 h60 gNumpadRightB, Right
     Gui, Layer0:Add, Picture, x252 y289 w60 h60 gNumpadBackspaceP, Default_60x60.png
     Gui, Layer0:Add, Button, x252 y349 w60 h60 gNumpadBackspaceB, Back Space
     
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
     Gui, Layer0:Show, w326 h703, Flow
     }
else
     {
     Gui, Layer0:Hide     
     }
return


Layer0GuiClose:
NumLockP:
NumLockB:
     ExitApp

;~ 1st row
NumpadDivP:
NumpadDivB:
NumpadMultP:
NumpadMultB:
NumpadSubP:
NumpadSubB:
     MsgBox, 1th row
return

;~ 2nd row
NumpadHomeP:
NumpadHomeB:
NumpadUpP:
NumpadUpB:
NumpadPgUpP:
NumpadPgUpB:
NumPadPlusP:
NumPadPlusB:
     MsgBox, 2th row
return

;~ 3rd row
NumpadLeftP:
NumpadLeftB:
NumpadBlankP:
NumpadBlankB:
NumpadRightP:
NumpadRightB:
NumpadBackspaceP:
NumpadBackspaceB:
     MsgBox, 3th row
return

;~ 4th row
NumpadEndP:
NumpadEndB:
NumpadDownP:
NumpadDownB:
NumpadPgDnP:
NumpadPgDnB:
NumpadEnterP:
NumpadEnterB:
     MsgBox, 4th row
return

;~ 5th row
NumpadInsP:
NumpadInsB:
NumpadDelP:
NumpadDelB:
     MsgBox, 5th row
return