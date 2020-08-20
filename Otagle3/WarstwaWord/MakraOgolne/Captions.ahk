Captions()
{
	global flag_ti, flag_ti2, H, W, X, Y, MyListBox3, CaptionList, fl, myLabels, Index
	static oWord, Hti, Wti, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	CaptionList := []
	if (flag_ti = 1)
	{
		WinGetPos, X, Y, W, H, Podpisy
		Gui, ti:Destroy
		flag_ti := 0
		
	}
	else if (flag_ti = 0) or !(flag_ti)
	{
		flag_ti := 1
		try{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_ti := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_ti2 = 0) or !(flag_ti2)
		{
			Y := MonTop +0.05*Var
			W := (MonRight - MonLeft)/(0.75*Var)
			X := MonRight- 18.5*Var
			H := (MonBottom - (MonTop + 5*Var/2))/(Var/2)
			flag_ti2 := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hti := H -  Var
		Wti := W - 2 * Var
		Gui, ti:New, +Resize -MinimizeBox -MaximizeBox +AlwaysOnTop
		Gui, Add, ListBox, H%Hti% W%Wti% vMyListBox3 gMyListBox3 +AltSubmit
		cnt := oWord.CaptionLabels.Count
		Loop, % cnt
		{
			CaptionList[A_Index] := oWord.CaptionLabels(A_Index).Name
		}
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox3, % CaptionList[A_Index]
		}
		Gui, ti:Add, Button, Hidden Default gOK3,OK
		Gui, ti:Show,X%X% Y%Y% H%H% W%W%, Podpisy
		fl := 0
	}
	return
		
MyListBox3:

if (A_GuiEvent != "DoubleClick")
	return
			
OK3:
	Gui, Submit, Nohide
	if (fl = 0)
	{	
		if(MyListBox3 > 0 and MyListBox3 <= CaptionList.MaxIndex())
		{
			var := CaptionList[MyListBox3]
			myLabels := oWord.ActiveDocument.GetCrossReferenceItems(var)
			GuiControl, , MyListBox3, |
			Loop, % myLabels.MaxIndex()
			{
				GuiControl,, MyListBox3, % myLabels[A_Index]
			}
			fl := 1
		}
		return
	}
	
	if (fl = 1)
	{
		if(MyListBox3 > 0 and MyListBox3 <= myLabels.MaxIndex())
		{
			var2 := myLabels[MyListBox3]
			Index := MyListBox3
			oWord.Selection.InsertCrossReference(var, 3, Index, 1, 0, 0, " ")
			WinActivate, ahk_class OpusApp
			
		}
	}
	
	return
	
tiGuiEscape:
	if(fl = 1)
	{
		GuiControl, , MyListBox3, |
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox3, % CaptionList[A_Index]
		}
		fl := 0
	
	return	
	}
	else 
	
tiGuiClose:
	WinGetPos, X, Y, W, H, Podpisy
	Gui, ti:Destroy
	flag_ti := 0
	WinActivate, ahk_class OpusApp
return
}