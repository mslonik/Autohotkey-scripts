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
FileInstall, PlikiHtml/Layer1.html, *
FileInstall, index.js, *
FileInstall, Style/index.css, *

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

