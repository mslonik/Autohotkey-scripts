Layer0:
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     WindowMarginLeft := WindowMarginTop := 10
     ColumnMargin := RowMargin := 20
     PictureWidth := PictureHeight := 130
     ButtonHeight := 30
     PictureHeightLong := PictureHeight * 2 + RowMargin + ButtonHeight
     PictureWidthLong := PictureWidth * 2 + ColumnMargin
     ButtonWidth := PictureWidth
     ButtonWidthLong := ButtonWidth * 2 + ColumnMargin
     
     WindowWidth := 4 * PictureWidth + 3 * ColumnMargin + 2 * WindowMarginLeft ; 600 px
     WindowHeight := 5 * PictureHeight + 5 * ButtonHeight + 4 * RowMargin + 2 * WindowMarginTop ; 900 px
     ;~ MsgBox, % "WindowWidth: " . WindowWidth . " WindowHeight: " . WindowHeight
     
     AuxiliaryTextWidth := WindowWidth - 2 * WindowMarginLeft
     AuxiliaryTextHeight := 1024 - WindowHeight - 2 * WindowMarginTop
     
     Gui, Layer0:Margin, %WindowMarginLeft%, %WindowMarginTop%
     Gui, Layer0:Font, cBlack s12 bold, Calibri

     
     ;~ 1st row
     CurrentX := WindowMarginLeft
     CurrentY := WindowMarginTop
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumLockP, %A_ScriptDir%\Layer0\ShowHide_60x60.png  
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumLockB, Num Lock
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     ;~ CurrentY -= ButtonHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDivP, %A_ScriptDir%\Layer0\KeePass_60x60.png 
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDivB, /
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadMultP, %A_ScriptDir%\Layer0\MicrosoftWord_60x60.png 
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadMultB, *
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadSubP, %A_ScriptDir%\Layer0\TotalCommander_60x60.png 
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadSubB, -
     
     ;~ 2nd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadHomeP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadHomeB, Home
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadUpP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadUpB, Up
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadPgUpP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadPgUpB, PgUp
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumPadAddP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeightLong
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumPadAddB, +
     CurrentY -= PictureHeightLong 
     
     ;~ 3rd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadLeftP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadLeftB, Left
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadBlankP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadBlankB, Blank
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadRightP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadRightB, Right
     
     ;~ 4th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadEndP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadEndB, End
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDownP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDownB, Down
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadPgDnP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadPgDnB, PgDn
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumpadEnterP, %A_ScriptDir%\Layer0\Default_60x60.png 
     CurrentY += PictureHeightLong
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadEnterB, Enter
     CurrentY -= PictureHeightLong
     
     ;~ 5th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidthLong% h%PictureHeight% gNumpadInsP, %A_ScriptDir%\Layer0\Default_60x60.png 
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidthLong% h%ButtonHeight% gNumpadInsB, Ins
     
     CurrentX += PictureWidthLong + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer0:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDelP, %A_ScriptDir%\Layer0\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer0:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDelB, Del
     
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer0:Add, Text, x%CurrentX% y%CurrentY% w%AuxiliaryTextWidth% h%AuxiliaryTextHeight% cGreen gAuxiliaryInformation, Auxiliary information

     Gui, Layer0:Hide
     Gui, Layer0:Font, ,
