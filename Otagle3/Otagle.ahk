#NoEnv
#SingleInstance, Force
#Include lib/Neutron.ahk
#Include ButtonFunctions.ahk 
#Include GuiGenerator.ahk
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
Menu, Tray,Icon, % A_ScriptDir . "\Assets\OtagleIcon.ico"
; Global variables
CurrentLayer                           := 1 
;Install filles
FileInstall, Layer1.html, Layer1.html
FileInstall, index.js, index.js
FileInstall, index.css, index.css
FileInstall, Assets/ikonySVG, *
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, jquery.min.js, jquery.min.js

F_DisplayLayer(CurrentLayer){
    CurrentLayer := 0
}
; Button handler
ClickF(neutron,event,action){
    
    SplitPath, % action, FunctionName
    FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)
  
    %FunctionName%()
    return
    
    F_DisplayLayer(CurrentLayer)
}

MsgText(string)
{
    vSize := StrPut(string, "CP0")
    VarSetCapacity(vUtf8, vSize)
    vSize := StrPut(string, &vUtf8, vSize, "CP0")
    Return StrGet(&vUtf8, "UTF-8") 
}