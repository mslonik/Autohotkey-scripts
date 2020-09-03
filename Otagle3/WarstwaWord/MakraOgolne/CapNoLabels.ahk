CapNoLabels()
{
	global flag_cap, flag_cap2, H, W, X, Y, MyListBox4, CaptionList, fl, myLabels, Index
	static oWord, Hcap, Wcap, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	CaptionList := []
	if (flag_cap = 1)
	{
		WinGetPos, X, Y, W, H, Podpisy
		Gui, cap:Destroy
		flag_cap := 0
		WinActivate, ahk_class OpusApp
		
	}
	else if (flag_cap = 0) or !(flag_cap)
	{
		flag_cap := 1
		try{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_cap := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_cap2 = 0) or !(flag_cap2)
		{
			Y := MonTop +0.05*Var
			W := (MonRight - MonLeft)/(0.75*Var)
			X := MonRight- 18.5*Var
			H := (MonBottom - (MonTop + 5*Var/2))/(Var/2)
			flag_cap2 := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hcap := H -  Var
		Wcap := W - 2 * Var
		Gui, cap:New, +Resize -MinimizeBox -MaximizeBox +AlwaysOnTop
		Gui, Add, ListBox, H%Hcap% W%Wcap% vMyListBox4 gMyListBox4 +AltSubmit
		cnt := oWord.CaptionLabels.Count
		Loop, % cnt
		{
			CaptionList[A_Index] := oWord.CaptionLabels(A_Index).Name
		}
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox4, % CaptionList[A_Index]
		}
		Gui, cap:Add, Button, Hidden Default gOK4,OK
		Gui, cap:Show,X%X% Y%Y% H%H% W%W%, Podpisy
		fl := 0
	}
	return
		
MyListBox4:

if (A_GuiEvent != "DoubleClick")
	return
			
OK4:
	Gui, Submit, Nohide
	if (fl = 0)
	{	
		if(MyListBox4 > 0 and MyListBox4 <= CaptionList.MaxIndex())
		{
			var := CaptionList[MyListBox4]
			myLabels := oWord.ActiveDocument.GetCrossReferenceItems(var)
			GuiControl, , MyListBox4, |
			Loop, % myLabels.MaxIndex()
			{
				GuiControl,, MyListBox4, % myLabels[A_Index]
			}
			fl := 1
		}
		return
	}
	
	if (fl = 1)
	{
		if(MyListBox4 > 0 and MyListBox4 <= myLabels.MaxIndex())
		{
			var2 := myLabels[MyListBox4]
			Index := MyListBox4
            WinActivate, ahk_class OpusApp
            oWord.ScreenUpdating := 0
            Send, % var . " "
			oWord.Selection.InsertCrossReference(var, 3, Index, 1, 0, 0, " ")
            oWord.Selection.MoveLeft(2,1,1)
            oWord.Selection.Fields.ToggleShowCodes
            oWord.Selection.Find.ClearFormatting
            oWord.Selection.Find.Replacement.ClearFormatting
            oWord.Selection.Find.Execute("\h",0,0,0,0,0,-1,0,0,"\h \# 0",1)
            oWord.Selection.Fields.Update
            oWord.Selection.MoveRight(2,1)
            oWord.ScreenUpdating := -1
			WinActivate, ahk_class OpusApp
			
		}
	}
	
	return
	
capGuiEscape:
	if(fl = 1)
	{
		GuiControl, , MyListBox4, |
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox4, % CaptionList[A_Index]
		}
		fl := 0
	
	return	
	}
	else 
	
capGuiClose:
	WinGetPos, X, Y, W, H, Podpisy
	Gui, cap:Destroy
	flag_cap := 0
	WinActivate, ahk_class OpusApp
return
}