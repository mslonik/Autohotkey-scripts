#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  						; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%	
     global actionPath :=
     global imgPath :=
     global x1 :=
     global x2 :=
     global y1 :=
     global y2 :=
     global Pd :=
     global pd2:=
     global A  := 
     global A2 :=
     global P  := 
     global P2 :=
     global NrLayer,NrRow,NrElement,NrLayer2,NrRow2,NrElement2
     global Title :=
     global btnWidth := 80
     global btnHeight := 80
     global ButtonHorizontalGap := 10   
     global ButtonVerticalGap   := 10
     global MonitorBoundingCoordinates_Left  := 0
     global MonitorBoundingCoordinates_Right := 0
     global MonitorBoundingCoordinates_Top   := 0
     global MonitorBoundingCoordinates_Bottom:= 0
     global T_CalculateButton   := 0 
     global WhichMonitor        := 0
     global aLayer_AmountOfKeysHorizontally :=
     global aLayer_AmountOfKeysVertically := 
    
F_display_configurator() {
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  
        SetWorkingDir %A_ScriptDir%  
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
Gui,SwapLayers:Add, Text,, Please select a layer:
Gui,SwapLayers:Add, ComboBox, w200 vNrLayer, % opt
Gui,SwapLayers:Add, Text,, Please enter some icon line:
Gui,SwapLayers:Add, Edit, vNrRow w200
Gui,SwapLayers:Add, Text,, Please enter some icon number
Gui,SwapLayers:Add, Edit, vNrElement w200
Gui,SwapLayers:Add, Text,, Please select a layer:
Gui,SwapLayers:Add, ComboBox, w200 vNrLayer2, % opt
Gui,SwapLayers:Add, Text,, Please enter some icon line:
Gui,SwapLayers:Add, Edit, vNrRow2 w200
Gui,SwapLayers:Add, Text,, Please enter element number:
Gui,SwapLayers:Add, Edit, vNrElement2 w200
Gui, SwapLayers:Add, Button, Default gSwap, SWAP

Gui,SwapLayers:Show
}

Swap(){
    Gui,SwapLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
     l1 := SubStr(l1,8)
     l2 :=SubStr(l2,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
     global v2 := % "Button_" . NrRow2 . "_" . NrElement2
    Loop, %Layers%{
        Ln := A_Index
        If (Ln == l1){
        SendMode Input 
        SetWorkingDir %A_ScriptDir%  
                IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_X"
                IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Y"
                IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % v1 . "_Picture"
                IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Action"
                IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Path",#  
                x1 := BtnX
                y1 := BtnY
                pd := PictureDef
                A  := ButtonA
                P  := Path
        }
    }
    Loop, %Layers%{
        iter := A_Index
        If (iter == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                    IniRead, BtnX2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_X"
                    IniRead, BtnY2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Y"
                    IniRead, PictureDef2,% A_ScriptDir . "\Config.ini",Layer%iter%, % v2 . "_Picture"
                    IniRead, ButtonA2, % A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Action"
                    IniRead, Path2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Path",#   
                    x2 := BtnX2
                    y2 := BtnY2
                    pd2:= PictureDef2
                    A2 := ButtonA2
                    P2 := Path2
        }
    }
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            IniRead, HB1,% A_ScriptDir . "\Config.ini",Layer%calc%,Amount of buttons horizontally
            IniRead, VB1,% A_ScriptDir . "\Config.ini",Layer%calc%,Amount of buttons vertically
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite, % x2 ,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
                IniWrite, % y2,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
                IniWrite, % pd2,% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
                IniWrite, % A2, % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
                IniWrite, % P2 ,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path"
        }
    }
    Loop, %Layers%{
        index := A_Index
        If (index == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite, % x1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_X"
                IniWrite, % y1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Y"
                IniWrite, % pd ,% A_ScriptDir . "\Config.ini",Layer%index%, % v2 . "_Picture"
                IniWrite, % A , % A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Action"
                IniWrite, % P ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Path"
        }
    }
        Gui,SwapLayers:Destroy
        Reset()
}


FdGuiDelete(){
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
    Ln := A_Index
    loadedLayers := A_Index
    SendMode Input 
    SetWorkingDir %A_ScriptDir%  
    IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
    IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
    IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
    opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }

    Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
    Gui,DeleteLayers:Add, Text,, Please enter layer nuber:
    Gui,DeleteLayers:Add, ComboBox, w200 vNrLayer, % opt
    Gui,DeleteLayers:Add, Text,, Please enter some icon line:
    Gui,DeleteLayers:Add, Edit,w200 vNrRow
    Gui,DeleteLayers:Add, Text,, Please enter element number:
    Gui,DeleteLayers:Add, Edit,w200 vNrElement
    Gui, DeleteLayers:Add, Button, Default gDeleteF, Delete
    Gui,DeleteLayers:Show
}
DeleteF(){
    Gui,DeleteLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     l1 := SubStr(l1,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
                IniWrite,% "",% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
                IniWrite,% "", % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path"
        }
    }
    Gui,DeleteLayers:Destroy
    Reset()
}
AddBtn(){
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
        SetWorkingDir %A_ScriptDir%  ; zmienna przechowuje "scieżkę do głownego katalogu z plikami należy tylko wskazać plik."
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
    Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
    Gui,AddLayers:Add, Text,, Please enter layer nuber:
    Gui,AddLayers:Add, ComboBox, w200 vNrLayer, % opt
    Gui,AddLayers:Add, Text,, Please enter row number:
    Gui,AddLayers:Add, Edit, vNrRow w200 
    Gui,AddLayers:Add, Text,, Please enter element number:
    Gui,AddLayers:Add, Edit, vNrElement w200 
    Gui,AddLayers:Add, Text,, Please select the layer to which the user will be transferred after click
    Gui,AddLayers:Add, ComboBox, w200 vNrLayer2, % opt
    MsgBox, Select Picture file
    FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.svg; *.png)
     if (SelectedFile = "")
          {
          MsgBox,   No picture file was selected.
          }Else{
          imgPath := SubStr(SelectedFile, StrLen(A_ScriptDir)+1)
          }
    MsgBox, Select Script file
    FileSelectFile, SelectedFile2, 3, , Select an .ahk or .exe file, File (*.ahk; *.exe)
    if (SelectedFile2 = "") 
        {
        MsgBox,   No action file was selected.
        } Else{
        actionPath := SubStr(SelectedFile2, StrLen(A_ScriptDir)+2)
        }     
    Gui, AddLayers:Add, Button, Default gAddF, Add
    Gui,AddLayers:Show
}
AddF(){
Gui,AddLayers:Submit
IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers  
global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
l1 := SubStr(l1,8)
global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
l2 :=SubStr(l2,8)
global v1 := % "Button_" . NrRow . "_" . NrElement 
fP := % ".." . imgPath
fM := % ".." . actionPath
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
                IniWrite,% fP,% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
                IniWrite,% fM, % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
                IniWrite,% l2,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path",#
        }
    }
    Gui,AddLayers:Destroy
    Reset()
}
Clone(){
Gui,AddLayers:Destroy
Gui,DeleteLayers:Destroy
Gui,SwapLayers:Destroy
Gui,CloneLayers:Destroy
IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  
        SetWorkingDir %A_ScriptDir%  
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
Gui,CloneLayers:Add, Text,, Please select a layer:
Gui,CloneLayers:Add, ComboBox, w200 vNrLayer, % opt
Gui,CloneLayers:Add, Text,, Please enter some icon line:
Gui,CloneLayers:Add, Edit, vNrRow w200
Gui,CloneLayers:Add, Text,, Please enter some icon number
Gui,CloneLayers:Add, Edit, vNrElement w200
Gui,CloneLayers:Add, Text,, Please select a layer:
Gui,CloneLayers:Add, ComboBox, w200 vNrLayer2, % opt
Gui,CloneLayers:Add, Text,, Please enter some icon line:
Gui,CloneLayers:Add, Edit, vNrRow2 w200
Gui,CloneLayers:Add, Text,, Please enter element number:
Gui,CloneLayers:Add, Edit, vNrElement2 w200
Gui,CloneLayers:Add, Button, Default gCloneB, Clone
Gui,CloneLayers:Show
}

CloneB(){
 Gui,CloneLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
     l1 := SubStr(l1,8)
     l2 :=SubStr(l2,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
     global v2 := % "Button_" . NrRow2 . "_" . NrElement2
    Loop, %Layers%{
        Ln := A_Index
        If (Ln == l1){
        SendMode Input 
        SetWorkingDir %A_ScriptDir%  
            IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_X"
            IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Y"
            IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % v1 . "_Picture"
            IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Action"
            IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Path",#  
            x1 := BtnX
            y1 := BtnY
            pd := PictureDef
            A  := ButtonA
            P  := Path
    }
    }
    Loop, %Layers%{
        index := A_Index
        If (index == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
            IniWrite, % x1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_X"
            IniWrite, % y1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Y"
            IniWrite, % pd ,% A_ScriptDir . "\Config.ini",Layer%index%, % v2 . "_Picture"
            IniWrite, % A , % A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Action"
            IniWrite, % P ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Path",#  
        }
    }
    Gui,CloneLayers:Destroy
    Reset()
}

addLayer(){
Gui, aLayer:Destroy
Gui, aLayer: New, +LabelMyGui_On -DPIScale
Gui, aLayer: Add, Text, xm, Specify key size width: `
Gui, aLayer: Add, Edit, x+m yp r1 w50
Gui, aLayer: Add, UpDown, vbtnWidth Range1-300, % btnWidth 
Gui, aLayer: Add, Text, x+m yp, Specify key size height: `
Gui, aLayer: Add, Edit, x+m yp r1 w50
Gui, aLayer: Add, UpDown, vbtnHeight Range1-300, % btnHeight
Gui, aLayer: Add, Button, xm Default w80 gBCalculate, C&alculate 
Gui, aLayer: Add, Button, x50 y+20 w80 gPlotButtons2 hwndTestButtonHwnd,       &Test
Gui, aLayer: Add, Text,  xm, % "Number of keys horizontally:`t" . (T_CalculateButton ? aLayer_AmountOfKeysHorizontally : "") 
Gui, aLayer: Add, Text,  yp x+m, Write the title of the layer:
Gui, aLayer: Add, Text, xm, % "Number of keys vertically:`t" . (T_CalculateButton ? aLayer_AmountOfKeysVertically : "") 
Gui, aLayer: Add, Edit, yp x+m w120 vTitle, %Title%
Gui, aLayer:Show
}

BCalculate(){
Gui, aLayer: Submit
T_CalculateButton :=1 
global MonitorBoundingCoordinates_,
SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
global aLayer_AmountOfKeysHorizontally := (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) -  ButtonHorizontalGap) // ( btnWidth + ButtonHorizontalGap)
global aLayer_AmountOfKeysVertically := (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ButtonVerticalGap) // (btnHeight + ButtonVerticalGap)
addLayer()

}

PlotButtons2(){
     Gui, aLayer:    Submit, NoHide
     Gui, aLayer:    Destroy
     Gui, Template: New, +LabelMyGui_On -DPIScale
     AmoountVBtn := aLayer_AmountOfKeysVertically
     AmoountHBtn := aLayer_AmountOfKeysHorizontally
     Bw := btnWidth
     Bh := btnHeight
    Loop, %AmoountVBtn% 
    {
    VarVertical := A_Index
        Loop, %AmoountHBtn%
        {
           Gui, Template: Add, Button,% "xm Default" . " w" . Bw . " h" . Bh  . " x" . (bw + 10) * (A_Index - 1) . " y" . (bh + 10) * (VarVertical - 1) ,   Button 
        }
    }
    Gui, Template:Show
}



