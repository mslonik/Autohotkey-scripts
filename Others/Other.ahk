#Requires AutoHotkey v1.1.33+ 	; Displays an error and quits if a version requirement is not met.    
#SingleInstance force 			; Only one instance of this script may run at a time!
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global N					:= 0
global DPI				:= 0
global v_SelectedMonitor 	:= 0
global v_FontSize			:= 0
global t_EnterTriggerstring 	:= "Enter triggerstring"
global t_SelectTriggerOptions	:= "Select Trigger Options"
global t_ImmediateExecute	:= "Immediate execute"
global t_CaseSensitive		:= "Case sensitive"
global t_NoBackspace		:= "No Backspace"
global t_InsideWord			:= "Inside word"
global t_NoEndChar			:= "No Endchar"
global t_Disable			:= "Disable"
global t_SelectHotstringOutputFunction := "Select hotstring output function"
global t_EnterHotstring		:= "Enter hotstring"
global t_AddAComment		:= "Add comment (optional)"
global t_SelectHotstringLibrary := "Select Hotstring library"
global t_AddLibrary			:= "Add library"
global t_SetHotstring		:= "Set hotstring (F9)"
global t_Clear				:= "Clear (F5)"
global t_DeleteHotstring		:= "Delete hotstring (F8)"
global t_Sandbox			:= "Sandbox"
global ini_Sandbox			:= 0
global t_TriggerstringTriggOptOutFunEnDisHotstringComment := "Triggerstring|Trigg Opt|Out Fun|En/Dis|Hotstring|Comment"
global t_F1AboutHelpF2LibraryContentF3SearchHotstringsF5ClearF7ClipboardDelayF8DeleteHotstringF9SetHotstring := "F1 About/Help | F2 Library content | F3 Search hotstrings | F5 Clear | F7 Clipboard Delay | F8 Delete hotstring | F9 Set hotstring"
global t_LoadedHotstrings	:= "Loaded Hotstrings"
global v_HotstringCnt		:= 0
global t_LibraryContent		:= "Library content (F2)"




; The section below shall be shifted to initialization
SysGet, N, MonitorCount
Loop, % N
{
	SysGet, Mon%A_Index%, Monitor, %A_Index%
	W%A_Index% := Mon%A_Index%Right - Mon%A_Index%Left
	H%A_Index% := Mon%A_Index%Bottom - Mon%A_Index%Top
		;DPI%A_Index% := round(W%A_Index%/1920*(96/A_ScreenDPI), 2) ; original
	;DPI%A_Index% := 1			; added on 2021-01-31 in order to clean up GUI sizing
}
SysGet, PrimMon, MonitorPrimary
if (v_SelectedMonitor == 0)
	v_SelectedMonitor := PrimMon

;SysGet, HeightOfClientArea, 17 ;SM_CYFULLSCREEN := 17
;MsgBox, , Height of Primary Monitor, % "Full screen: " . H%PrimMon% . "`nClient area: " . HeightOfClientArea

;Configuration parameters
v_FontSize 	:= 14 ;points
v_xmarg		:= 25 ;pixels
v_ymarg		:= 25 ;pixels
v_FontType	:= "Calibri"
v_WindowColor	:= "Black"
v_ControlColor := "Gray"
;Variables used for GUI settings
v_xNext		:= 0
v_yNext		:= 0
v_wNext		:= 0
v_hNext		:= 0

;1. General settings of GUI: resizeability, scaleability, window handle etc.
;-DPIScale doesn't work in Microsoft Windows 10
;+Border doesn't work in Microsoft Windows 10
;OwnDialogs
L_GUIInit:
Gui, 		HS3:New, 		+Resize +HwndHS3Hwnd +OwnDialogs, % SubStr(A_ScriptName, 1, -4)
Gui, 		HS3:Margin,	% v_xmarg, % v_ymarg
Gui,			HS3:Color,	% v_WindowColor, % v_ControlColor

;2. Prepare all text objects according to mock-up.
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText1, 									%t_EnterTriggerstring%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit1 vv_TriggerString 

;Gui,			HS3:Add,		Text, 		HwndIdText2 vv_SelectTriggerOptions, 				%t_SelectTriggerOptions%
Gui, 		HS3:Add, 		CheckBox, 	x0 y0 HwndIdCheckBox1 gCapsCheck vv_OptionImmediateExecute,	%t_ImmediateExecute%
Gui, 		HS3:Add,		CheckBox, 	x0 y0 HwndIdCheckBox2 gCapsCheck vv_OptionCaseSensitive,	%t_CaseSensitive%
Gui, 		HS3:Add,		CheckBox, 	x0 y0 HwndIdCheckBox3 gCapsCheck vv_OptionNoBackspace,		%t_NoBackspace%
Gui, 		HS3:Add,		CheckBox, 	x0 y0 HwndIdCheckBox4 gCapsCheck vv_OptionInsideWord, 		%t_InsideWord%
Gui, 		HS3:Add,		CheckBox, 	x0 y0 HwndIdCheckBox5 gCapsCheck vv_OptionNoEndChar, 		%t_NoEndChar%
Gui, 		HS3:Add, 		CheckBox, 	x0 y0 HwndIdCheckBox6 gCapsCheck vv_OptionDisable, 		%t_Disable%

Gui,			HS3:Add,		GroupBox, 	x0 y0 HwndIdGroupBox1 vv_GroupBoxSelectTriggerOptions, 		%t_SelectTriggerOptions%

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText3 vv_TextSelectHotstringsOutFun, 			%t_SelectHotstringOutputFunction%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		DropDownList, 	x0 y0 HwndIdDDL1 vv_SelectFunction gL_SelectFunction, 		SendInput (SI)||Clipboard (CL)|Menu & SendInput (MSI)|Menu & Clipboard (MCL)

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText4 vv_TextEnterHotstring, 				%t_EnterHotstring%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit2 vv_EnterHotstring
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit3 vv_EnterHotstring1  Disabled
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit4 vv_EnterHotstring2  Disabled
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit5 vv_EnterHotstring3  Disabled
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit6 vv_EnterHotstring4  Disabled
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit7 vv_EnterHotstring5  Disabled
Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit8 vv_EnterHotstring6  Disabled

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText5 vv_TextAddComment, 					%t_AddAComment%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit9 vComment Limit64 ; future: change name to vv_Comment, align with other 

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText6 vv_TextSelectHotstringLibrary, 			%t_SelectHotstringLibrary%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		Button, 		x0 y0 HwndIdButton1 gAddLib, 							%t_AddLibrary%
Gui,			HS3:Add,		DropDownList,	x0 y0 HwndIdDDL2 vv_SelectHotstringLibrary gSectionChoose

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "bold cWhite", % v_FontType
Gui, 		HS3:Add, 		Button, 		x0 y0 HwndIdButton2 gAddHotstring, 						%t_SetHotstring%
Gui, 		HS3:Add, 		Button, 		x0 y0 HwndIdButton3 gClear,							%t_Clear%
Gui, 		HS3:Add, 		Button, 		x0 y0 HwndIdButton4 gDelete vv_DeleteHotstring Disabled, 	%t_DeleteHotstring%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText7,		 							%t_LibraryContent%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui,			HS3:Add, 		Text, 		x0 y0 HwndIdText9, 									%t_TriggerstringTriggOptOutFunEnDisHotstringComment%
Gui, 		HS3:Add, 		ListView, 	x0 y0 HwndIdListView1 LV0x1 vv_LibraryContent AltSubmit gHSLV, %t_TriggerstringTriggOptOutFunEnDisHotstringComment%

Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText8 vv_ShortcutsMainInterface, 				%t_F1AboutHelpF2LibraryContentF3SearchHotstringsF5ClearF7ClipboardDelayF8DeleteHotstringF9SetHotstring%

Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cBlue", % v_FontType
Gui, 		HS3:Add, 		Text, 		x0 y0 HwndIdText10 vSandString, 						%t_Sandbox%
Gui,			HS3:Font,		% "s" . v_FontSize . A_Space . "norm cWhite", % v_FontType

Gui, 		HS3:Add, 		Edit, 		x0 y0 HwndIdEdit10 vSandbox r3 						; r3 = 3x rows of text
;Gui, 		HS3:Add, 		Edit, 		HwndIdEdit11 vv_ViewString gViewString ReadOnly Hide

;3. Determine height of main types of text objects
GuiControlGet, v_OutVarTemp, Pos, % IdText1
HofText			:= v_OutVarTempH
GuiControlGet, v_OutVarTemp, Pos, % IdEdit1
HofEdit			:= v_OutVarTempH
GuiControlGet, v_OutVarTemp, Pos, % IdButton1
HofButton			:= v_OutVarTempH
GuiControlGet, v_OutVarTemp, Pos, % IdListView1
HofListView		:= v_OutVarTempH
GuiControlGet, v_OutVarTemp, Pos, % IdCheckBox1
HofCheckBox		:= v_OutVarTempH
GuiControlGet, v_OutVarTemp, Pos, % IdDDL1
HofDropDownList 	:= v_OutVarTempH

;4. Determine constraints, according to mock-up
GuiControlGet, v_OutVarTemp1, Pos, % IdButton2
GuiControlGet, v_OutVarTemp2, Pos, % IdButton3
GuiControlGet, v_OutVarTemp3, Pos, % IdButton4

LeftColumnW := v_xmarg + v_OutVarTemp1W + v_xmarg + v_OutVarTemp2W + v_xmarg + v_OutVarTemp3W

GuiControlGet, v_OutVarTemp1, Pos, % IdText8
GuiControlGet, v_OutVarTemp2, Pos, % IdText9
v_OutVarTemp3 := Max(v_OutVarTemp1W, v_OutVarTemp2W) ;longer of two texts
;RightColumnW := v_xmarg + v_OutVarTemp3 + v_xmarg
RightColumnW := v_OutVarTemp3

;5. Move text objects to correct position
;5.1. Left column
v_yNext += v_ymarg
v_xNext += v_xmarg
GuiControl, Move, % IdText1, % "x" . v_xNext . A_Space . "y" . v_yNext
GuiControlGet, v_OutVarTemp1, Pos, % IdText1
GuiControlGet, v_OutVarTemp2, Pos, % IdEdit1
v_xNext := v_xmarg + v_OutVarTemp1W + v_xmarg
v_wNext := LeftColumnW - v_xNext
GuiControl, Move, % IdEdit1, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext

v_yNext += Max(v_OutVarTemp1H, v_OutVarTemp2H)
v_xNext := v_xmarg
v_OutVarTemp := Max(v_OutVarTemp1W, v_OutVarTemp2W, v_OutVarTemp3W)
v_wNext := LeftColumnW - v_xNext
v_hNext := HofText + 3 * HofCheckBox
GuiControl, Move, % IdGroupBox1, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext . A_Space . "h" . v_hNext

v_yNext += HofText
v_xNext := v_xmarg * 2
GuiControlGet, v_OutVarTemp1, Pos, % IdCheckBox1
GuiControlGet, v_OutVarTemp2, Pos, % IdCheckBox3
GuiControlGet, v_OutVarTemp3, Pos, % IdCheckBox5
WleftMiniColumn  := Max(v_OutVarTemp1W, v_OutVarTemp2W, v_OutVarTemp3W)
GuiControlGet, v_OutVarTemp1, Pos, % IdCheckBox2
GuiControlGet, v_OutVarTemp2, Pos, % IdCheckBox4
GuiControlGet, v_OutVarTemp3, Pos, % IdCheckBox6
WrightMiniColumn := Max(v_OutVarTemp1W, v_OutVarTemp2W, v_OutVarTemp3W)
SpaceBetweenColumns := LeftColumnW - (3 * v_xmarg + WleftMiniColumn + WrightMiniColumn)
GuiControl, Move, % IdCheckBox1, % "x" . v_xNext . A_Space . "y" . v_yNext
v_xNext += SpaceBetweenColumns + WleftMiniColumn
GuiControl, Move, % IdCheckBox2, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofCheckBox
v_xNext := v_xmarg * 2
GuiControl, Move, % IdCheckBox3, % "x" . v_xNext . A_Space . "y" . v_yNext
v_xNext += SpaceBetweenColumns + wleftminicolumn
GuiControl, Move, % IdCheckBox4, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofCheckBox
v_xNext := v_xmarg * 2
GuiControl, Move, % IdCheckBox5, % "x" . v_xNext . A_Space . "y" . v_yNext
v_xNext += SpaceBetweenColumns + wleftminicolumn
GuiControl, Move, % IdCheckBox6, % "x" . v_xNext . A_Space . "y" . v_yNext

v_yNext += HofCheckBox + v_ymarg
v_xNext := v_xmarg
GuiControl, Move, % IdText3, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofText
v_wNext := LeftColumnW - v_xNext
GuiControl, Move, % IdDDL1, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext

v_yNext += HofDropDownList + v_ymarg
v_xNext := v_xmarg
GuiControl, Move, % IdText4, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofText
v_xNext := v_xmarg
v_wNext := LeftColumnW - v_xNext
GuiControl, Move, % IdEdit2, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit3, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit4, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit5, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit6, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit7, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofEdit
GuiControl, Move, % IdEdit8, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext

v_yNext += HofEdit + v_ymarg
v_xNext := v_xmarg
GuiControl, Move, % IdText5, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofText
v_xNext := v_xmarg
v_wNext := LeftColumnW - v_xNext
GuiControl, Move, % IdEdit9, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext

v_yNext += HofEdit + v_ymarg
v_xNext := v_xmarg
GuiControl, Move, % IdText6, % "x" . v_xNext . A_Space . "y" . v_yNext
GuiControlGet, v_OutVarTemp1, Pos, % IdText6
GuiControlGet, v_OutVarTemp2, Pos, % IdButton1
v_OutVarTemp := LeftColumnW - (v_OutVarTemp1W + v_OutVarTemp2W + 2 * v_xmarg)
v_xNext := v_OutVarTemp1W + v_OutVarTemp
v_wNext := v_OutVarTemp2W + 2 * v_xmarg
GuiControl, Move, % IdButton1, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
v_yNext += HofButton
v_xNext := v_xmarg
v_wNext := LeftColumnW - v_xNext
GuiControl, Move, % IdDDL2, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext

;*[Other]
;Gui, 		%HS3Hwnd%:Show, AutoSize Center
v_yNext += HofDropDownList + v_ymarg
v_xNext := v_xmarg
GuiControlGet, v_OutVarTemp1, Pos, % IdButton2
GuiControlGet, v_OutVarTemp2, Pos, % IdButton3
GuiControl, Move, % IdButton2, % "x" . v_xNext . A_Space . "y" . v_yNext
v_xNext += v_OutVarTemp1W + v_xmarg
GuiControl, Move, % IdButton3, % "x" . v_xNext . A_Space . "y" . v_yNext
v_xNext += v_OutVarTemp2W + v_xmarg
GuiControl, Move, % IdButton4, % "x" . v_xNext . A_Space . "y" . v_yNext
v_yNext += HofButton
LeftColumnH := v_yNext
;Gui, 		%HS3Hwnd%:Show, AutoSize Center

;5.2. Right column
;5.2.1. Position the text "Library content"
v_yNext := v_ymarg
v_xNext := LeftColumnW + v_xmarg
GuiControl, Move, % IdText7, % "x" . v_xNext . A_Space . "y" . v_yNext

;Gui, 		%HS3Hwnd%:Show, AutoSize Center

;5.2.2. Position the only one List View 
GuiControlGet, v_OutVarTemp1, Pos, % IdEdit10 ; height of Sandbox edit field
GuiControlGet, v_OutVarTemp2, Pos, % IdListView1
v_yNext += HofText
v_xNext := LeftColumnW + v_xmarg
v_wNext := RightColumnW
v_hNext := LeftColumnH - (v_OutVarTemp1H + HofText * 3 + v_ymarg * 3)
GuiControl, Move, % IdListView1, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext . A_Space . "h" . v_hNext
;Gui, 		%HS3Hwnd%:Show, AutoSize Center

;5.2.3. Position of the long text F1 ... F2 ...
GuiControlGet, v_OutVarTemp, Pos, % IdListView1
v_yNext += v_OutVarTempH + v_ymarg
v_xNext := LeftColumnW + v_xmarg
GuiControl, Move, % IdText8, % "x" . v_xNext . A_Space . "y" . v_yNext

GuiControl, Hide, % IdText9

;5.2.4. Text Sandbox
v_yNext += HofText + v_ymarg
v_xNext := LeftColumnW + v_xmarg
GuiControl, Move, % IdText10, % "x" . v_xNext . A_Space . "y" . v_yNext

;5.2.5. Sandbox edit text field
v_yNext += HofText
v_xNext := LeftColumnW + v_xmarg
v_wNext := RightColumnW
GuiControl, Move, % IdEdit10, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext


;6. Calculate position and size of the GUI window
;DetectHiddenWindows, On
;WinGetPos, StartX, StartY, StartW, StartH, ahk_id %HS3Hwnd%
;DetectHiddenWindows, Off
;MsgBox, , Size and position of the window, % "StartX: " . StartX . "`nStartY: " . StartY . "`nStartW: " . StartW . "`nStartH: " . StartH


;7. Show text objects
;why double???
;^#h::
FlagOfResizing := 1
Gui, 		%HS3Hwnd%:Show, AutoSize Center
Gui, 		%HS3Hwnd%:Show, AutoSize Center
;WinGetPos, StartX, StartY, StartW, StartH, ahk_id %HS3Hwnd%
;MsgBox, , Size and position of the window, % "StartX: " . StartX . "`nStartY: " . StartY . "`nStartW: " . StartW . "`nStartH: " . StartH
return

HS3GuiSize:
	if (A_EventInfo = 1) ; The window has been minimized.
		return
	if (FlagOfResizing)
		{
			FlagOfResizing := 0
			return
		}
	AutoXYWH("wh", IdListView1)
	
	Gui, %HS3Hwnd%: ListView, %IdListView1% ; identify which Gui

	;5.2.3. Position of the long text F1 ... F2 ...
	GuiControlGet, v_OutVarTemp, Pos, % IdListView1
	v_yNext := v_ymarg + HofText + v_OutVarTempH + v_ymarg
	v_xNext := LeftColumnW + v_xmarg
	LV_ModifyCol(1, Round(0.2 * v_OutVarTempW))
	LV_ModifyCol(2, Round(0.1 * v_OutVarTempW))
	LV_ModifyCol(3, Round(0.2 * v_OutVarTempW))	
	LV_ModifyCol(4, Round(0.1 * v_OutVarTempW))
	LV_ModifyCol(5, Round(0.1 * v_OutVarTempW))
	LV_ModifyCol(6, Round(0.3 * v_OutVarTempW) - 3)
	GuiControl, Move, % IdText8, % "x" . v_xNext . A_Space . "y" . v_yNext

	;5.2.4. Text Sandbox
	v_yNext += HofText + v_ymarg
	v_xNext := LeftColumnW + v_xmarg
	GuiControl, Move, % IdText10, % "x" . v_xNext . A_Space . "y" . v_yNext
	
	;5.2.5. Sandbox edit text field
	v_yNext += HofText
	v_xNext := LeftColumnW + v_xmarg
	v_wNext := RightColumnW
	GuiControl, Move, % IdEdit10, % "x" . v_xNext . A_Space . "y" . v_yNext . A_Space . "w" . v_wNext
		
return
	
	
CapsCheck:
return
	
L_SelectFunction:
return

AddLib:
return

SectionChoose:
return

AddHotstring:
return

Clear:
return

Delete:
return

HSLV:
return

ViewString:
return

HS3GuiClose:
HS3GuiEscape:
ExitApp

; =================================================================================
; Function: AutoXYWH
;   Move and resize control automatically when GUI resizes.
; Parameters:
;   DimSize - Can be one or more of x/y/w/h  optional followed by a fraction
;             add a '*' to DimSize to 'MoveDraw' the controls rather then just 'Move', this is recommended for Groupboxes
;   cList   - variadic list of ControlIDs
;             ControlID can be a control HWND, associated variable name, ClassNN or displayed text.
;             The later (displayed text) is possible but not recommend since not very reliable 
; Examples:
;   AutoXYWH("xy", "Btn1", "Btn2")
;   AutoXYWH("w0.5 h 0.75", hEdit, "displayed text", "vLabel", "Button1")
;   AutoXYWH("*w0.5 h 0.75", hGroupbox1, "GrbChoices")
; ---------------------------------------------------------------------------------
; Version: 2015-5-29 / Added 'reset' option (by tmplinshi)
;          2014-7-03 / toralf
;          2014-1-2  / tmplinshi
; requires AHK version : 1.1.13.01+
; =================================================================================
AutoXYWH(DimSize, cList*){       ; http://ahkscript.org/boards/viewtopic.php?t=1079
  static cInfo := {}
  Options := 0
 
  If (DimSize = "reset")
    Return cInfo := {}
 
  For i, ctrl in cList 
	{
    ctrlID                    := A_Gui ":" ctrl
    If ( cInfo[ctrlID].x = "" ){
        GuiControlGet, i, %A_Gui%:Pos, %ctrl%
        MMD              := InStr(DimSize, "*") ? "MoveDraw" : "Move"
        fx               := fy := fw := fh := 0
        For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]")))
            If !RegExMatch(DimSize, "i)" dim "\s*\K[\d.-]+", f%dim%)
              f%dim% := 1
        cInfo[ctrlID]     := { x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:A_GuiWidth, gh:A_GuiHeight, a:a , m:MMD}
    }
    Else If ( cInfo[ctrlID].a.1) 
    {
        dgx              := dgw := A_GuiWidth  - cInfo[ctrlID].gw  , dgy := dgh := A_GuiHeight - cInfo[ctrlID].gh
        For i, dim in cInfo[ctrlID]["a"]
            Options .= dim (dg%dim% * cInfo[ctrlID]["f" dim] + cInfo[ctrlID][dim]) A_Space
        GuiControl, % A_Gui ":" cInfo[ctrlID].m , % ctrl, % Options
	} 
	} 
}

f_PlotGrid(GridStep, HandleToWindow)
{
	;https://www.autohotkey.com/docs/misc/Styles.htm
	SS_BLACKFRAME		:= 0x07
	SS_BLACKRECT		:= 0x04
	SS_ETCHEDFRAME		:= 0x12
	SS_ETCHEDHORZ		:= 0x10
	SS_ETCHEDVERT		:= 0x11
	SS_GRAYFRAME		:= 0x08
	SS_GRAYRECT		:= 0x05
	
	DetectHiddenWindows, On
	WinGetPos, , , HS3W, HS3H, ahk_id %HandleToWindow%
	DetectHiddenWindows, Off
	
	Loop, % HS3W / GridStep  
		Gui, %HandleToWindow%: Add, 		Text, % "x" . A_Index * GridStep . " y0 h" . HS3H . A_Space . SS_ETCHEDVERT  ;Vertical Line > Etched Gray		
	
	Loop, % HS3H / GridStep
		Gui, %HandleToWindow%: Add,		Text, % "x0 y" . A_Index * GridStep . " w" . HS3W . A_Space . SS_ETCHEDHORZ
}
