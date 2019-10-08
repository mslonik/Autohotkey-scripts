Layer0:
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     
     ;~ 1st row
     Gui, Layer0:Add, Picture, x12 y9 w60 h60 gNumLockP, %A_ScriptDir%\Layer0\ShowHide_60x60.png  
     Gui, Layer0:Add, Button, x12 y69 w60 h60 gNumLockB, Num Lock
     
     Gui, Layer0:Add, Picture, x92 y9 w60 h60 gNumpadDivP, %A_ScriptDir%\Layer0\KeePass_60x60.png 
     Gui, Layer0:Add, Button, x92 y69 w60 h60 gNumpadDivB, /
     
     Gui, Layer0:Add, Picture, x172 y9 w60 h60 gNumpadMultP, %A_ScriptDir%\Layer0\MicrosoftWord_60x60.png 
     Gui, Layer0:Add, Button, x172 y69 w60 h60 gNumpadMultB, *
     
     Gui, Layer0:Add, Picture, x252 y9 w60 h60 gNumpadSubP, %A_ScriptDir%\Layer0\TotalCommander_60x60.png 
     Gui, Layer0:Add, Button, x252 y69 w60 h60 gNumpadSubB, -
     
     ;~ 2nd row
     Gui, Layer0:Add, Picture, x12 y149 w60 h60 gNumpadHomeP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x12 y209 w60 h60 gNumpadHomeB, Home
     Gui, Layer0:Add, Picture, x92 y149 w60 h60 gNumpadUpP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x92 y209 w60 h60 gNumpadUpB, Up
     Gui, Layer0:Add, Picture, x172 y149 w60 h60 gNumpadPgUpP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x172 y209 w60 h60 gNumpadPgUpB, PgUp
     Gui, Layer0:Add, Picture, x252 y149 w60 h200 gNumPadAddP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x252 y349 w60 h60 gNumPadAddB, +
     
     ;~ 3rd row
     Gui, Layer0:Add, Picture, x12 y289 w60 h60 gNumpadLeftP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x12 y349 w60 h60 gNumpadLeftB, Left
     Gui, Layer0:Add, Picture, x92 y289 w60 h60 gNumpadBlankP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x92 y349 w60 h60 gNumpadBlankB, Blank
     Gui, Layer0:Add, Picture, x172 y289 w60 h60 gNumpadRightP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x172 y349 w60 h60 gNumpadRightB, Right
     
     ;~ 4th row
     Gui, Layer0:Add, Picture, x12 y429 w60 h60 gNumpadEndP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x12 y489 w60 h60 gNumpadEndB, End
     Gui, Layer0:Add, Picture, x92 y429 w60 h60 gNumpadDownP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x92 y489 w60 h60 gNumpadDownB, Down
     Gui, Layer0:Add, Picture, x172 y429 w60 h60 gNumpadPgDnP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x172 y489 w60 h60 gNumpadPgDnB, PgDn
     Gui, Layer0:Add, Picture, x252 y429 w60 h200 gNumpadEnterP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png ; replace with a new icon
     Gui, Layer0:Add, Button, x252 y629 w60 h60 gNumpadEnterB, Enter
     
     ;~ 5th row
     Gui, Layer0:Add, Picture, x12 y569 w140 h60 gNumpadInsP, C:\temp1\Obrazki\JustifyLeftFromSVG_60x60.png ; replace with a new icon
     Gui, Layer0:Add, Button, x12 y629 w140 h60 gNumpadInsB, Ins
     Gui, Layer0:Add, Picture, x172 y569 w60 h60 gNumpadDelP, %A_ScriptDir%\Layer0\Default_60x60.png
     Gui, Layer0:Add, Button, x172 y629 w60 h60 gNumpadDelB, Del
     
     ; Generated using SmartGUI Creator for SciTE
     Gui, Layer0:Hide