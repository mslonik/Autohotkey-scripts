; ********************************
; Basic Demo Script (download contains additional functionality)
; ********************************

; Download sample images if necessary
IfNotExist %A_WorkingDir%\testbmp.bmp
{
    SplashTextOn, 300, 30, !, Downloading images. Please wait...
	URLDownloadToFile https://ahknet.autohotkey.com/~corr/ahk.bmp, ahk.bmp
	URLDownloadToFile https://ahknet.autohotkey.com/~corr/testbmp.bmp, testbmp.bmp
	URLDownloadToFile https://ahknet.autohotkey.com/~corr/test2.bmp, test2.bmp
    SplashTextOff
}
; Create the buttons  
Gui, Add, Button, h30 w140 gNbutton, Normal Button  
AddGraphicButton("SampleButton1", "pic1.jpg", "h30 w140 gMyButton", 30, 140)
AddGraphicButton("SampleButton2", A_WorkingDir . "\ahk.bmp", "h30 w140 gMyButton", 80, 140) 
Gui, Add, Button, h30 w140 gNbutton, Another Normal Button 
AddGraphicButton("SampleButton3", "pic2.jpg", "h30 w140 gMyButton", 20, 130) 

; Show the window 
Gui, Show,, Bitmap Buttons 

; Image rollover for SampleButton1
OnMessage(0x200, "MouseMove")
OnMessage(0x2A3, "MouseLeave")
OnMessage(0x202, "MouseLeave") ; Restore image on LBUTTONUP
Return 

MouseLeave(wParam, lParam, msg, hwnd)
{
  Global
  If (hwnd = SampleButton1_hwnd)
    AddGraphicButton("SampleButton1", "pic1.jpg", "h30 w140 gMyButton", 30, 140) 
  Return
}
MouseMove(wParam, lParam, msg, hwnd)
{
  Global
  Static _LastButtonData = true
  If (hwnd = SampleButton1_hwnd)
    If (_LastButtonData != SampleButton1_hwnd)
      AddGraphicButton("SampleButton1", "\ahk.bmp", "h30 w140 gMyButton", 60, 120) 
  _LastButtonData := hwnd
  Return
}

MyButton: 
MsgBox, Graphic button clicked :) 
return 

Nbutton: 
MsgBox, Normal button Clicked :)
AddGraphicButton("SampleButton3", "pic2.jpg", "h30 w140 gMyButton", 20, 130)
Return 

GuiClose: 
ExitApp 



; ******************************************************************* 
; AddGraphicButton.ahk 
; ******************************************************************* 
; Version: 2.2 Updated: May 20, 2007 
; by corrupt 
; ******************************************************************* 
; VariableName = variable name for the button 
; ImgPath = Path to the image to be displayed 
; Options = AutoHotkey button options (g label, button size, etc...) 
; bHeight = Image height (default = 32) 
; bWidth = Image width (default = 32) 
; ******************************************************************* 
; note: 
; - calling the function again with the same variable name will 
; modify the image on the button 
; ******************************************************************* 
AddGraphicButton(VariableName, ImgPath, Options="", bHeight=32, bWidth=32) 
{ 
Global 
Local ImgType, ImgType1, ImgPath0, ImgPath1, ImgPath2, hwndmode 
; BS_BITMAP := 128, IMAGE_BITMAP := 0, BS_ICON := 64, IMAGE_ICON := 1 
Static LR_LOADFROMFILE := 16 
Static BM_SETIMAGE := 247 
Static NULL 
SplitPath, ImgPath,,, ImgType1 
If ImgPath is float 
{ 
  ImgType1 := (SubStr(ImgPath, 1, 1)  = "0") ? "bmp" : "ico" 
  StringSplit, ImgPath, ImgPath,`. 
  %VariableName%_img := ImgPath2 
  hwndmode := true 
} 
ImgTYpe := (ImgType1 = "bmp") ? 128 : 64 
If (%VariableName%_img != "") AND !(hwndmode) 
  DllCall("DeleteObject", "UInt", %VariableName%_img) 
If (%VariableName%_hwnd = "") 
  Gui, Add, Button,  v%VariableName% hwnd%VariableName%_hwnd +%ImgTYpe% %Options% 
ImgType := (ImgType1 = "bmp") ? 0 : 1 
If !(hwndmode) 
  %VariableName%_img := DllCall("LoadImage", "UInt", NULL, "Str", ImgPath, "UInt", ImgType, "Int", bWidth, "Int", bHeight, "UInt", LR_LOADFROMFILE, "UInt") 
DllCall("SendMessage", "UInt", %VariableName%_hwnd, "UInt", BM_SETIMAGE, "UInt", ImgType,  "UInt", %VariableName%_img) 
Return, %VariableName%_img ; Return the handle to the image 
} 