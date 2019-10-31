F_Layer3()
{
     global WindowMarginLeft, WindowMarginTop 
     global ColumnMargin, RowMargin 
     global PictureWidth, PictureHeight 
     global ButtonHeight 
     global PictureHeightLong 
     global PictureWidthLong 
     global ButtonWidth, PictureWidth
     global ButtonWidthLong 
          
          
     ;~ Gui,  +AlwaysOnTop +ToolWindow +Border +E0x08000000 +LastFound
     Gui, Layer3:Margin, %WindowMarginLeft%, %WindowMarginTop%
     Gui, Layer3:Font, cBlack s12 bold, Calibri

     
     ;~ 1st row
     CurrentX := WindowMarginLeft
     CurrentY := WindowMarginTop
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumLockP, %A_ScriptDir%\Layer3\NumLock_Off.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumLockB, Num Lock
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDivP, %A_ScriptDir%\Layer3\Word_Normal_130x130.png   
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDivB, /
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadMultP, %A_ScriptDir%\Layer3\Word_NormalBetween_130x130.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadMultB, *
     
     CurrentX += ColumnMargin + PictureWidth
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadSubP, %A_ScriptDir%\Layer3\Word_Heading1_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadSubB, -
     
     ;~ 2nd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadHomeP, %A_ScriptDir%\Layer3\Word_Heading2_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadHomeB, Home
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadUpP, %A_ScriptDir%\Layer3\Word_Heading3_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadUpB, Up
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadPgUpP, %A_ScriptDir%\Layer3\Word_Heading4_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadPgUpB, PgUp
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumPadAddP, %A_ScriptDir%\Layer3\Back_60x200.png
     CurrentY += PictureHeightLong
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumPadAddB, +
     CurrentY -= PictureHeightLong      
     
     ;~ 3rd row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadLeftP, %A_ScriptDir%\Layer3\Word_Heading5_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadLeftB, Left
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadBlankP, %A_ScriptDir%\Layer3\Word_Heading6_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadBlankB, Blank
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadRightP, %A_ScriptDir%\Layer3\Word_Heading7_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadRightB, Right
     
     ;~ 4th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadEndP, %A_ScriptDir%\Layer3\Word_Heading8_130x130.png 
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadEndB, End
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDownP, %A_ScriptDir%\Layer3\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDownB, Down
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadPgDnP, %A_ScriptDir%\Layer3\Default_60x60.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadPgDnB, PgDn
     
     CurrentX += PictureWidth + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeightLong% gNumpadEnterP, %A_ScriptDir%\Layer3\Forward_60x200.png 
     CurrentY += PictureHeightLong
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadEnterB, Enter
     CurrentY -= PictureHeightLong

     ;~ 5th row
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + PictureHeight + ButtonHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidthLong% h%PictureHeight% gNumpadInsP, %A_ScriptDir%\Layer3\Word_SmallLine_130x130.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidthLong% h%ButtonHeight% gNumpadInsB, Ins
     
     CurrentX += PictureWidthLong + ColumnMargin
     CurrentY -= PictureHeight
     Gui, Layer3:Add, Picture, x%CurrentX% y%CurrentY% w%PictureWidth% h%PictureHeight% gNumpadDelP, %A_ScriptDir%\Layer3\Word_HiddenSpecial_130x130.png
     CurrentY += PictureHeight
     Gui, Layer3:Add, Button, x%CurrentX% y%CurrentY% w%ButtonWidth% h%ButtonHeight% gNumpadDelB, Del
     
     CurrentX := WindowMarginLeft
     CurrentY += RowMargin + ButtonHeight
     Gui, Layer3:Add, Text, x%CurrentX% y%CurrentY% w%AuxiliaryTextWidth% h%AuxiliaryTextHeight% cGreen gAuxiliaryInformation,
     (
     Auxiliary information`nMore information about %ApplicationName% available there: http://mslonik.pl`n
Layer name: Layer3 (Word_TemplateStyles1)`t Subject: 1st screen of Styles.
     )

     Gui, Layer3:Hide
     Gui, Layer3:Font, ,
}