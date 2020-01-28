;~ Simple_Spy.ahk   by Maestrith and Joe Glines
;~ Inspired & borrowed from:  https://www.autohotkey.com/boards/viewtopic.php?f=6&t=28220  by Alguimist
#SingleInstance,Force
#NoEnv
#MaxMem 640
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows On
CoordMode Mouse, Screen
SetControlDelay -1
SetWinDelay -1
SetBatchLines -1
ListLines Off
#KeyHistory 0
Global AppName := "Simple Spy"
, Version := "1.0.1"
, IniFile := AppName . ".ini"
, ResDir := A_ScriptDir . "\Resources"
,Moving
, hFindTool
, Bitmap1 := ResDir . "\FindTool1.bmp"
, Bitmap2 := ResDir . "\FindTool2.bmp"
, hCrossHair := DllCall("LoadImage", "Int", 0
    , "Str", ResDir . "\CrossHair.cur"
    , "Int", 2 ; IMAGE_CURSOR
    , "Int", 32, "Int", 32
    , "UInt", 0x10, "Ptr") ; LR_LOADFROMFILE
, hOldCursor
, Dragging := False

, g_Borders := []
, g_hWnd
, hSpyWnd
, hTab
, hStylesTab
, hWindowsTab
, g_Style
, g_ExStyle
, g_ExtraStyle
, g_WinMsgs := ""
, hCbxMsg
, Cursors := {}
, oStyles := {}
, Workaround := True
, FindDlgExist := False
, MenuViewerExist := False
, hTreeWnd := 0
, TreeIcons := ResDir . "\TreeIcons.icl"
, ImageList
, g_TreeShowAll := False
, g_Minimized
, g_MouseCoordMode := "Screen"
,ID
, g_DetectHidden
, g_Minimize
, g_AlwaysOnTop
,MainWindow
,ClassNNHWND
,TextHWND,HWNDHWND,ParentHWND,TreeIDs:=[],ShowTreeHWND,WinHeight
ResDir:=A_ScriptDir "\Resources"
Menu,Tray,Icon,%ResDir%\WinSpy.ico
; Main window
CreateImageList()
Width:=85,XPos:=115,WinHeight:=220
;~ Gui,New,LabelSpy hWndhSpyWnd
Gui,+HWNDMainWindow +AlwaysOnTop
hSpyWnd:=MainWindow
Gui,Font,s9,Segoe UI
Gui,Add,Picture,hWndhFindTool gFindToolHandler x10 y12 w31 h28,%Bitmap1%
Gui,Add,Text,x48 y10 w198,Drag the Finder Tool over a window`nto select it,then release the mouse
Gui,Add,Text,x28 w%Width% h23 +0x202,Handle:
Gui,Add,Edit,vEdtHandle HWNDHWNDHWND ReadOnly x%XPos% yp w356 h21
Gui,Add,Text,vTxtText x28 w%Width% h21 +0x202,Text:
Gui,Add,Edit,vEdtText HWNDTextHWND x%XPos% yp w290 h21
Gui,Add,Button,vBtnSetText gSetText x412 yp-1 w60 h23,&Set Text
Gui,Add,Text,x28 w%Width% +0x202,Parent Window:
Gui,Add,Edit,vEdtClass x%XPos% HWNDParentHWND y150 w356 r3 ReadOnly yp -Wrap ; -E0x200 ReadOnly ;This should show parent window
;~ Gui,Add,Edit,vEdtClass x%XPos% Top_Class y150 w356 r3 ReadOnly yp -Wrap ; -E0x200 ReadOnly ;This should show parent window
Gui,Add,Text,x28 w%Width% h21 +0x202,Control: ;
Gui,Add,Edit,vEdtClassNN HWNDClassNNHWND x%XPos% yp w356 h21 ReadOnly ; -E0x200 ReadOnly ;
Gui,Add,Button,gShowFindDlg x%XPos% y190 w84 h24,&Find...
Gui,Add,Button,% "gTreeVis x" XPos+90 " y190 w84 h24",&Tree...
Gui,Add,TreeView,xm w460 h300 gShowItem ImageList%ImageList% AltSubmit
Gui,Add,Button,gShowTree,&Refresh All
IniRead,px,%IniFile%,Settings,x,Center
IniRead,py,%IniFile%,Settings,y,Center
Gui,Show,h%WinHeight%,%AppName% ; Show main window  Settings for main height of GUI
if(g_Minimize){
	WinMove ahk_id %hSpyWnd%,,,,,78
	g_Minimized := True
}
Gui,Show
ID:="ahk_id" MainWindow
Global hCommandsMenu:=MenuGetHandle("CommandsMenu")
OnMessage(0x200,"MouseMove"),OnMessage(0x202,"LButtonUp")
return ; End of the auto-execute section
+Escape:: ;Exit
GuiClose:
ExitApp
return
; The color attribute in the following line sets the color     0x3FBBE3
ShowBorder(hWnd,Duration:=500,Color:="0xff0a0a",r:=3) { 
	Local x,y,w,h,Index
	static Window
	WinGetPos x, y, w, h, ahk_id %hWnd%
	if(!w)
		Return
	g_Borders := []
	while(A_Index<5){
		Index:=A_Index+90
		Gui,%Index%: +hWndhBorder -Caption +ToolWindow +AlwaysOnTop
		Gui,%Index%: Color, %Color%
		g_Borders.Push(hBorder)
	}
	for a,b in Window:=[[91,x-r,y-r,w+r+r,r],[92,x-r,y+h,w+r+r,r],[93,x-r,y,r,h],[94,x+w,y,r,h]]
		Gui,% b.1 ":Show",% "NA x" b.2 " y" b.3 " w" b.4 " h" b.5
	Gui,+AlwaysOnTop
	if(Duration!=-1&&Duration!="Flash"){
		Sleep,%Duration%
		while(A_Index<5){
			Index:=A_Index+90
			Gui,%Index%: Destroy
		}
	}else if(Duration="Flash"){
		SetTimer,Flash,-1
		return
		Flash:
		while(A_Index<8){
			Index:=A_Index
			for a,b in Window{
				Gui,% "+ToolWindow"
				Gui,% b.1 ":" (Mod(Index,2)?"Show":"Hide"),NA
			}
			Sleep,150
		}for a,b in Window
			Gui,% b.1 ":Destroy"
		return
	}
}
FindToolHandler(){
	DllCall("SetCapture","Ptr",hSpyWnd)
	hOldCursor:=DllCall("SetCursor","Ptr",hCrossHair,"Ptr")
	GuiControl,,Static1,%Bitmap2%
	Moving:=1
	return
}
MouseMove(a,b,c,Win){
	static LastControl,LastAncestor
	if(a="Control")
		return LastControl
	MouseGetPos,,,Window
	if(Window=MainWindow)
		return
	if(Moving){
		DllCall("SetCursor","Ptr",hCrossHair,"Ptr")
		MouseGetPos,,,Win,Control,2
		Ancestor:=GetAncestor(Control)
		if(Ancestor!=LastAncestor&&Ancestor){
			GuiControl,-Redraw,SysTreeView321
			WinGetTitle,Title,ahk_id%Win%
			TV_Delete(),TreeIDs:=[]
			WinGetClass,Class,ahk_id%Win%
			Tree(Win,TV_Add(Title,,"Icon" GetWindowIcon(Ancestor,Class)))
			DllCall("SetCapture","Ptr",hSpyWnd)
			GuiControl,+Redraw,SysTreeView321
		}if(Ancestor)
			LastAncestor:=Ancestor
		if(Control!=LastControl&&Control){
			MouseGetPos,,,Win,ClassNN
			ShowBorder(Control,-1)
			WinGetTitle,Title,ahk_id%Win%
			ControlGetText,Text,,ahk_id%Control%
			WinGet,EXE,ProcessName,ahk_id%Win%
			WinGetClass,Class,ahk_id%Win%
			ClassNN:=InStr(ClassNN,"ComboLBox")?RegExReplace(ClassNN,"i)ComboLBox","Combobox"):ClassNN
			for a,b in {(ClassNN):ClassNNHWND,(Text):TextHWND,"0x" Format("{:x}",Control):HWNDHWND,(TitleHWND):Title,(Title "`r`nahk_class " Class "`r`nahk_exe " EXE):ParentHWND}
				ControlSetText,,%a%,ahk_id%b%
			for a,b in TreeIDs{
				if(b=Control){
					TV_Modify(a,"Select Vis Focus")
					Break
				}
			}
		}LastControl:=Control
	}
}
SetHandle(){
	if(!Moving){
		
		t(A_ThisFunc)
	}
}
SetText(){
	ControlGetText,HWND,,ahk_id%HWNDHWND%
	ControlGetText,Text,,ahk_id%TextHWND%
	ControlSetText,,%Text%,% "ahk_id" HWND
}
MenuHandler(x*){
	m(A_ThisFunc,x)
}
ShowTree(){
	TV_Delete()
	RootID:=TV_Add("Desktop",0,"Icon2")
	TreeIDs[RootID]:=DllCall("GetDesktopWindow","Ptr")
	SplashTextOn,200,100,Getting Windows,Please Wait...
	WinGet WinList, List
	Loop %WinList% {
		hWnd:=WinList%A_Index%
		WinGetClass,Class,ahk_id %hWnd%
		WinGetTitle,Title,ahk_id %hWnd%
		if(Title != ""){
			Title := " - " . Title
		}
		Invisible := !IsWindowVisible(hWnd)
		if(!g_TreeShowAll && Invisible) {
			Continue
		}
		if(Invisible) {
			Title.=" (hidden)"
		}
		Icon:=GetWindowIcon(hWnd,Class,True)
		Text:=Class Title,Text:=StrLen(Text)>40?SubStr(Text,1,40) "...":Text
		TreeIDs[(TV:=TV_Add(Text,RootID,"Icon" Icon))]:=hWnd
		Tree(hWnd,TV)
	}
	GuiControl,+Redraw,SysTreeView321
	ControlFocus,SysTreeView321,%ID%
	TV_Modify(TV_GetChild(0),"Select Vis Focus")
	SplashTextOff
}
CreateImageList() {
	ImageList := IL_Create(32)
	IL_Add(ImageList, TreeIcons, 1)  ; Generic window icon
	IL_Add(ImageList, TreeIcons, 2)  ; Desktop (#32769)
	IL_Add(ImageList, TreeIcons, 3)  ; Dialog (#32770)
	IL_Add(ImageList, TreeIcons, 4)  ; Button
	IL_Add(ImageList, TreeIcons, 5)  ; CheckBox
	IL_Add(ImageList, TreeIcons, 6)  ; ComboBox
	IL_Add(ImageList, TreeIcons, 7)  ; DateTime
	IL_Add(ImageList, TreeIcons, 8)  ; Edit
	IL_Add(ImageList, TreeIcons, 9)  ; GroupBox
	IL_Add(ImageList, TreeIcons, 10) ; Hotkey
	IL_Add(ImageList, TreeIcons, 11) ; Icon
	IL_Add(ImageList, TreeIcons, 12) ; Link
	IL_Add(ImageList, TreeIcons, 13) ; ListBox
	IL_Add(ImageList, TreeIcons, 14) ; ListView
	IL_Add(ImageList, TreeIcons, 15) ; MonthCal
	IL_Add(ImageList, TreeIcons, 16) ; Picture
	IL_Add(ImageList, TreeIcons, 17) ; Progress
	IL_Add(ImageList, TreeIcons, 18) ; Radio
	IL_Add(ImageList, TreeIcons, 19) ; RichEdit
	IL_Add(ImageList, TreeIcons, 20) ; Separator
	IL_Add(ImageList, TreeIcons, 21) ; Slider
	IL_Add(ImageList, TreeIcons, 22) ; Status bar
	IL_Add(ImageList, TreeIcons, 23) ; Tab
	IL_Add(ImageList, TreeIcons, 24) ; Text
	IL_Add(ImageList, TreeIcons, 25) ; Toolbar
	IL_Add(ImageList, TreeIcons, 26) ; Tooltips
	IL_Add(ImageList, TreeIcons, 27) ; TreeView
	IL_Add(ImageList, TreeIcons, 28) ; UpDown
	IL_Add(ImageList, TreeIcons, 29) ; IE
	IL_Add(ImageList, TreeIcons, 30) ; Scintilla
	IL_Add(ImageList, TreeIcons, 31) ; ScrollBar
	IL_Add(ImageList, TreeIcons, 32) ; SysHeader
	Return ImageList
}
Tree(hParentWnd, ParentID) {
	WinGet WinList, ControlListHwnd, ahk_id %hParentWnd%
	Loop Parse, WinList, `n
	{
		If (GetParent(A_LoopField) != hParentWnd) {
			Continue
		}
		
		WinGetClass Class, ahk_id %A_LoopField%
		If (IsChild(A_LoopField)) {
			ControlGetText Text,, ahk_id %A_LoopField%
		} Else {
			WinGetTitle Text,, ahk_id %A_LoopField%
		}
		Text:=StrLen(Text)>50?SubStr(Text,1,50) "..":Text
		
		If (Text != "") {
			Text := " - " . Text
		}
		
		Invisible := !IsWindowVisible(A_LoopField)
		
		If (!g_TreeShowAll && Invisible) {
			Continue
		}
		
		If (Invisible) {
			Text .= " (hidden)"
		}
		Icon:=GetWindowIcon(A_LoopField,Class)
		TreeIDs[(TV:=TV_Add(Class Text,ParentID,"Icon" Icon))] := A_LoopField
		Tree(A_LoopField,TV)
	}
}
IsChild(hWnd) {
	WinGet Style, Style, ahk_id %hWnd%
	Return Style & 0x40000000 ; WS_CHILD
}
ShowFindDlg:
If (FindDlgExist) {
	Gui Find: Show
} Else {
	Gui Find: New, LabelFind hWndhFindDlg
	Gui,+Owner1 +AlwaysOnTop
	Gui Font, s9, Segoe UI
	Gui Color, White
	
	Gui Add, Text, x15 y16 w81 h23 +0x200, Text or Title:
	Gui Add, Edit, hWndhEdtFindByText vEdtFindByText gFindWindow x144 y17 w286 h21
	Gui Add, CheckBox, vChkFindRegEx x441 y16 w120 h23, Regular Expression
	Gui Add, Text, x15 y54 w79 h23 +0x200, Class Name:
	Gui Add, ComboBox, vCbxFindByClass gFindWindow x144 y54 w286
	Gui Add, Text, x15 y93 w110 h23 +0x200, Process ID or Name:
	Gui Add, ComboBox, vCbxFindByProcess gFindWindow x144 y93 w286
	
	Gui Add, ListView, hWndhFindList gFindListHandler x10 y130 w554 h185 +LV0x14000
        , hWnd|Class|Text|Process
	LV_ModifyCol(1, 0)
	LV_ModifyCol(2, 133)
	LV_ModifyCol(3, 285)
	LV_ModifyCol(4, 112)
	
	Gui Add, Text, x-1 y329 w576 h49 +Border -Background
	Gui Add, Button, gFindOK x381 y342 w88 h25 Default, &OK
	Gui Add, Button, gFindClose x477 y342 w88 h25, &Cancel
	
	Gui Show, w574 h377, Find Window
	SetExplorerTheme(hFindList)
	
	FindDlgExist := True
}

    ; Unique class names
Global Classes := []
WinGet WinList, List
Loop %WinList% {
	hThisWnd := WinList%A_Index%
	WinGetClass WClass, ahk_id %hThisWnd%
	AddUniqueClass(WClass)
	
	WinGet ControlList, ControlListHwnd, ahk_id %hThisWnd%
	Loop Parse, ControlList, `n
	{
		WinGetClass CClass, ahk_id %A_LoopField%
		AddUniqueClass(CClass)
	}
}

ClassList := ""
Loop % Classes.Length()  {
	ClassList .= Classes[A_Index] . "|"
}

GuiControl,, CbxFindByClass, %ClassList%

    ; Unique process names
Processes := []
For Process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process") {
	If (Process.ProcessID < 10) {
		Continue
	}
	
	Unique := True
	Loop % Processes.Length() {
		If (Process.Name == Processes[A_Index]) {
			Unique := False
			Break
		}
	}
	
	If (Unique) {
		Processes.Push(Process.Name)
	}
}

ProcList := ""
MaxItems := Processes.Length()
Loop %MaxItems%  {
	ProcList .= Processes[MaxItems - A_Index + 1] . "|"
}

GuiControl,, CbxFindByProcess, %ProcList%
Return
SetExplorerTheme(hWnd) {
	DllCall("UxTheme.dll\SetWindowTheme", "Ptr", hWnd, "WStr", "Explorer", "Ptr", 0)
}
AddUniqueClass(ClassName) {
	Local Unique := True
	Loop % Classes.Length() {
		If (ClassName == Classes[A_Index]) {
			Unique := False
			Break
		}
	}
	
	If (Unique) {
		Classes.Push(ClassName)
	}
}

FindEscape:
FindClose:
Gui Find: Hide
Return

FindWindow:
Gui Find: Submit, NoHide

Gui ListView, %hFindList%
GuiControl -Redraw, %hFindList%
LV_Delete()

WinGet WinList, List
Loop %WinList% {
	hThisWnd := WinList%A_Index%
	If (hThisWnd == hFindDlg) {
		Continue
	}
	
	WinGetClass WClass, ahk_id %hThisWnd%
	WinGetTitle WTitle, ahk_id %hThisWnd%
	WinGet WProcess, ProcessName, ahk_id %hThisWnd%
	WinGet WProcPID, PID, ahk_id %hThisWnd%
	
	If (MatchCriteria(WTitle, WClass, IsNumber(CbxFindByProcess) ? WProcPID : WProcess)) {
		LV_Add("", hThisWnd, WClass, WTitle, WProcess)
	}
	
	WinGet ControlList, ControlListHwnd, ahk_id %hThisWnd%
	Loop Parse, ControlList, `n
	{
		ControlGetText CText,, ahk_id %A_LoopField%
		WinGetClass CClass, ahk_id %A_LoopField%
		WinGet CProcess, ProcessName, ahk_id %A_LoopField%
		WinGet CProcPID, PID, ahk_id %A_LoopField%
		
		If (MatchCriteria(CText, CClass, IsNumber(CbxFindByProcess) ? CProcPID : CProcess)) {
			LV_Add("", A_LoopField, CClass, CText, CProcess)
		}
	}
}

GuiControl +Redraw, %hFindList%
Return

MatchCriteria(Text, Class, Process) {
	Global
	
	If (EdtFindByText != "") {
		If (ChkFindRegEx) {
			If (RegExMatch(Text, EdtFindByText) < 1) {
				Return False
			}
		} Else {
			If (!InStr(Text, EdtFindByText)) {
				Return False
			}
		}
	}
	
	If (CbxFindByClass != "" && !InStr(Class, CbxFindByClass)) {
		Return False
	}
	
	If (CbxFindByProcess != "") {
		Return IsNumber(Process) ? CbxFindByProcess == Process : InStr(Process, CbxFindByProcess)
	}
	
	Return True
}

FindOK:
Gui ListView, %hFindList%
LV_GetText(hWnd, LV_GetNext())
GuiControl, 
, EdtHandle, %hWnd%
WinActivate ahk_id %hSpyWnd%
Gui Find: Hide
Return

FindListHandler:
If (A_GuiEvent == "DoubleClick") {
	GoSub FindOK
}
Return
IsNumber(n) {
	If n Is Number
		Return True
	Return False
}
TreeVis(){
	static Size:=1
	if((Size:=!Size))
		Gui,Show,h%WinHeight%
	else{
		Gui,Show,AutoSize
		ControlFocus,SysTreeView321,%ID%
	}
}
ShowItem(){
	Control:=TreeIDs[TV_GetSelection()]
	if(A_GuiEvent~="i)(S|Normal)"&&Control){
		ShowBorder(Control,"Flash"),Win:=GetAncestor(Control)
		WinGetTitle,Title,ahk_id%Win%
		ControlGetText,Text,,ahk_id%Control%
		WinGet,EXE,ProcessName,ahk_id%Win%
		WinGetClass,Class,ahk_id%Win%
		ClassNN:=Control_GetClassNN(Win,Control)
		VarSetCapacity( charbuff, 256, 0 )
		ClassNN:=InStr(ClassNN,"ComboLBox")?RegExReplace(ClassNN,"i)ComboLBox","Combobox"):ClassNN
		for a,b in {(ClassNN):ClassNNHWND,(Text):TextHWND,"0x" Format("{:x}",Control):HWNDHWND,(TitleHWND):Title,(Title "`r`nahk_class " Class "`r`nahk_exe " EXE):ParentHWND}
			ControlSetText,,%a%,ahk_id%b%
	}
	
}
GetFileIcon(File, SmallIcon := 1) {
	VarSetCapacity(SHFILEINFO, cbFileInfo := A_PtrSize + 688)
	If (DllCall("Shell32.dll\SHGetFileInfoW"
        , "WStr", File
        , "UInt", 0
        , "Ptr" , &SHFILEINFO
        , "UInt", cbFileInfo
        , "UInt", 0x100 | SmallIcon)) { ; SHGFI_ICON
		Return NumGet(SHFILEINFO, 0, "Ptr")
	}
}
GetWindowIcon(hWnd, Class, TopLevel := False) {
	Static Classes := {0:0
    , "#32770": 3
    , "Button": 4
    , "CheckBox": 5
    , "ComboBox": 6
    , "SysDateTimePick32": 7
    , "Edit": 8
    , "GroupBox": 9
    , "msctls_hotkey32": 10
    , "Icon": 11
    , "SysLink": 12
    , "ListBox": 13
    , "SysListView32": 14
    , "SysMonthCal32": 15
    , "Picture": 16
    , "msctls_progress32": 17
    , "Radio": 18
    , "RebarWindow32": 25
    , "RichEdit": 19
    , "Separator": 20
    , "msctls_trackbar32": 21
    , "msctls_statusbar32": 22
    , "SysTabControl32": 23
    , "Static": 24
    , "ToolbarWindow32": 25
    , "tooltips_class32": 26
    , "SysTreeView32": 27
    , "msctls_updown32": 28
    , "Internet Explorer_Server": 29
    , "Scintilla": 30
    , "ScrollBar": 31
    , "SysHeader32": 32}
	
	If (Class == "Button") {
		WinGet Style, Style, ahk_id %hWnd%
		Type := Style & 0xF
		If (Type == 7) {
			Class := "GroupBox"
		} Else If (Type ~= "2|3|5|6") {
			Class := "CheckBox"
		} Else If (Type ~= "4|9") {
			Class := "Radio"
		} Else {
			Class := "Button"
		}
	} Else If (Class == "Static") {
		WinGet Style, Style, ahk_id %hWnd%
		Type := Style & 0x1F ; SS_TYPEMASK
		If (Type == 3) {
			Class := "Icon"
		} Else If (Type == 14) {
			Class := "Picture"
		} Else If (Type == 0x10) {
			Class := "Separator"
		} Else {
			Class := "Static"
		}
	} Else If (InStr(Class, "RICHED", True) == 1) {
		Class := "RichEdit" ; RICHEDIT50W
	}
	
	Icon := Classes[Class]
	If (Icon != "") {
		Return Icon
	}
	
	SendMessage 0x7F, 2, 0,, ahk_id %hWnd% ; WM_GETICON, ICON_SMALL2
	hIcon := ErrorLevel
	
	If (hIcon == 0 && TopLevel) {
		WinGet ProcessPath, ProcessPath, ahk_id %hWnd%
		hIcon := GetFileIcon(ProcessPath)
	}
	
	IconIndex := (hIcon) ? IL_Add(ImageList, "HICON: " . hIcon) : 1
	Return IconIndex
}
IsWindowVisible(hWnd) {
	Return DllCall("IsWindowVisible", "Ptr", hWnd)
}
GetParent(hWnd) {
	Return DllCall("GetParent", "Ptr", hWnd, "Ptr")
}
LButtonUp(x*){
	if(Moving){
		GuiControl,,Static1,%Bitmap1%
		Moving:=0,DllCall("ReleaseCapture"),DllCall("SetCursor","Ptr",hOldCursor),ShowBorder(MouseMove("Control",0,0,0),1000) ;the 1000 is the duration of how long the Border stays visible
	}
} ;*[LButtonUp]
GetAncestor(hWnd, Flag := 2) {
	Return DllCall("GetAncestor", "Ptr", hWnd, "UInt", Flag, "Ptr")
}
Control_GetClassNN(hWndWindow,hWndControl){ ;https://autohotkey.com/board/topic/45627-function-control-getclassnn-get-a-control-classnn/
	DetectHiddenWindows,On
	WinGet,ClassNNList,ControlList,ahk_id %hWndWindow%
	Loop,PARSE,ClassNNList,`n
	{
		ControlGet,hwnd,hwnd,,%A_LoopField%,ahk_id %hWndWindow%
		if (hWnd = hWndControl)
			return A_LoopField
	}
}
;***********chad Tool tip function******************* 
;~ t("vars",var1,var2,var3)
t(x*){
	for a,b in x{
		if((obj:=StrSplit(b,":")).1="time"){
			SetTimer,killtip,% "-" obj.2*1000
			Continue
		}
		list.=b "`n"
	}
	Tooltip,% list
	return
	killtip:
	ToolTip
	return
}
m(x*){
	static List:={BTN:{OC:1,ARI:2,YNC:3,YN:4,RC:5,CTC:6},ico:{X:16,"?":32,"!":48,I:64}},Msg:=[]
	static Title
	List.Title:="AutoHotkey",List.Def:=0,List.Time:=0,Value:=0,TXT:=""
	WinGetTitle,Title,A
	for a,b in x
		Obj:=StrSplit(b,":"),(VV:=List[Obj.1,Obj.2])?(Value+=VV):(List[Obj.1]!="")?(List[Obj.1]:=Obj.2):TXT.=(IsObject(b)?Obj2String(b):b) "`n"
	Msg:={option:Value+262144+(List.Def?(List.Def-1)*256:0),Title:List.Title,Time:List.Time,TXT:TXT}
	Sleep,120
	SetTimer,Move,-1
	MsgBox,% Msg.option,% Msg.Title,% Msg.TXT,% Msg.Time
	/*
		SetTimer,ActivateAfterm,-150
	*/
	for a,b in {OK:Value?"OK":"",Yes:"YES",No:"NO",Cancel:"CANCEL",Retry:"RETRY"}
		IfMsgBox,%a%
			return b
	return
	Move:
	TT:=List.Title " ahk_class #32770 ahk_exe AutoHotkey.exe"
	WinGetPos,x,y,w,h,%TT%
	;~ WinMove,%TT%,,2000,% Round((A_ScreenHeight-h)/2)
	/*
		ToolTip,% A_ScriptFullPath
		USE THIS TO SAVE LAST POSITIONS FOR MSGBOX'S
	*/
	return
	/*
		ActivateAfterm:
		if(InStr(Title,"Omni-Search")||!Title){
			Loop,20
			{
				WinGetActiveTitle,ATitle
				if(InStr(ATitle,"AHK Studio"))
					Break
				Sleep,50
			}
		}else{
			WinActivate,%Title%
		}
		return
	*/
}
Obj2String(Obj,FullPath:=1){
	static String
	if(FullPath=1)
		String:="",FullPath:=""
	if(IsObject(Obj)){
		for a,b in Obj{
			if(IsObject(b))
				Obj2String(b,FullPath "." a)
			else
				String.=FullPath "." a " = " b "`n"
	}}return String
}