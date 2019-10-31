F_Layer5()
{
     global WindowMarginLeft, WindowMarginTop 
     global ColumnMargin, RowMargin 
     global PictureWidth, PictureHeight 
     global ButtonHeight 
     global PictureHeightLong 
     global PictureWidthLong 
     global ButtonWidth, PictureWidth
     global ButtonWidthLong 
          
     Gui, Layer5:Margin, %WindowMarginLeft%, %WindowMarginTop%
     Gui, Layer5:Font, cBlack s12 bold, Calibri

     
     ;~ 1st row
     CurrentX := WindowMarginLeft
     CurrentY := WindowMarginTop
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumLockP, %A_ScriptDir%\Layer5\NumLock_On.png  
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumLockB, Num Lock ON
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     ;~ CurrentY -= ButtonHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadNumlockDivP, %A_ScriptDir%\Layer5\NumLock_Slash.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockDivB, /
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadNumlockMultP, %A_ScriptDir%\Layer5\NumLock_Asterisk.png  
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockMultB, *
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadNumlockSubP, %A_ScriptDir%\Layer5\NumLock_Minus.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockSubB, -
     
     ;~ 2nd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad7P, %A_ScriptDir%\Layer5\NumLock_7.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad7B, 7
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad8P, %A_ScriptDir%\Layer5\NumLock_8.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad8B, 8
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad9P, %A_ScriptDir%\Layer5\NumLock_9.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad9B, 9
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumpadNumlockAddP, %A_ScriptDir%\Layer5\NumLock_Plus.png 
     CurrentY += PictureHeightLong
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockAddB, +
     CurrentY -= PictureHeightLong 
     
     ;~ 3rd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad4P, %A_ScriptDir%\Layer5\NumLock_4.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad4B, 4
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad5P, %A_ScriptDir%\Layer5\NumLock_5.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad5B, 5
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad6P, %A_ScriptDir%\Layer5\NumLock_6.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad6B, 6
     
     ;~ 4th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad1P, %A_ScriptDir%\Layer5\NumLock_1.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad1B, 1
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad2P, %A_ScriptDir%\Layer5\NumLock_2.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad2B, 2
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpad3P, %A_ScriptDir%\Layer5\NumLock_3.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpad3B, 3
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumpadNumlockEnterP, %A_ScriptDir%\Layer5\NumLock_Enter.png 
     CurrentY += PictureHeightLong
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockEnterB, Enter
     CurrentY -= PictureHeightLong
     
     ;~ 5th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidthLong% h%PictureHeight% gNumpad0P, %A_ScriptDir%\Layer5\NumLock_0.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidthLong% h%ButtonHeight% gNumpad0B, 0
     
     CurrentX += PictureWidthLong + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer5:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadNumlockDelP, %A_ScriptDir%\Layer5\NumLock_Dot.png 
     CurrentY += PictureHeight
     Gui, Layer5:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadNumlockDelB, .
     
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer5:Add, Text, x%CurrentX% y%CurrentY% w%AuxiliaryTextWidth% h%AuxiliaryTextHeight% cGreen gAuxiliaryInformation,
     (
     Auxiliary information`nMore information about %ApplicationName% available there: http://mslonik.pl`n
Layer name: Layer5 (NumLock_Layer)`t Subject: Numeric key pad.
     )

     Gui, Layer5:Hide
     Gui, Layer5:Font, ,
}