#NoEnv
#SingleInstance, Force
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
if !(FileExist("Config.ini")){
    Run, ConfigBuilder.ahk,%A_ScriptDir% 
}Else{
#Include *i %A_ScriptDir%\CopyTemplate.ahk
#Include *i %A_ScriptDir%\lib\Neutron.ahk
#Include *i %A_ScriptDir%\ButtonFunctions.ahk 
#Include *i %A_ScriptDir%\GuiGenerator.ahk
#Include *i %A_ScriptDir%\ConfigBuilder.ahk
#Include *i %A_ScriptDir%\ArrangeBtn.ahk
Menu, Tray,Icon, % A_ScriptDir . "\Assets\OtagleIcon.ico"
; Global variables

;Install filles
FileInstall, Layer1.html, Layer1.html
FileInstall, index.js, index.js
FileInstall, index.css, index.css
FileInstall, Assets/ikonySVG, *
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, jquery.min.js, jquery.min.js


; Button handler
ClickF(neutron,event,action){
    
    SplitPath, % action, FunctionName
    FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)
  
    %FunctionName%()
    return
}
BarF(neutron,event,action){
    %action%()
    return
}
rWizard(neutron,event){
Run, ConfigBuilder.ahk,%A_ScriptDir% 
}
}



Reset(){
    global
    neutron.Close("PlikiHtml/Layer1.html")
    RemoveFolder()
    FileCreateDir, PlikiHtml
    BuildHTMLFile()
}
