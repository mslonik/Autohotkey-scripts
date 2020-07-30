InsertEnumNumber()
{
	local vMyListBoxEnum
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	if (flag_enum == 0) or !(flag_enum)
	{
		try
		{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_enum := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_enum = 0) or !(flag_enum)
		{
			Y := MonTop
			W := (MonRight - MonLeft)/(Var/2)
			X := MonRight -  W
			H := MonBottom - (MonTop + 5*Var/2)
			flag_enum := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hlb := H -  Var
		Wlb := W - 2 * Var
		Gui, Enum:New, +Resize
		Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBoxEnum gMyListBoxEnum +AltSubmit
		myHeadings := oWord.ActiveDocument.GetCrossReferenceItems(0) ; 0 - numbered item
		Loop, % myHeadings.MaxIndex()
		{
			GuiControl,, MyListBoxEnum, % myHeadings[A_Index]
		}
		Gui, Enum:Add, Button, Hidden Default gOKEnum,OKenum
		Gui, Enum:Show,X%X% Y%Y% H%H% W%W%, Wstaw numer elementu listy numerowanej
	}
	else if(flag_enum == 1)
	{
		WinGetPos, X, Y, W, H, Wstaw numer elementu listy numerowanej
		Gui, Enum:Destroy
		flag_enum := 0
	}
	return
	
MyListBoxEnum:
	if (A_GuiEvent != "DoubleClick")
		return
			
OKenum:
	try
	{
		Gui, Submit, Nohide
		Index := MyListBoxenum
		oWord.Selection.InsertCrossReference(0, -4, Index, 1, 0, 0, " ") ; 0 - numbered item, -4 - number
	}
	return

enumGuiEscape:
enumGuiClose:
	WinGetPos, X, Y, W, H, Wstaw numer elementu listy numerowanej
	Gui, enum:Destroy
	flag_enum := 0
	WinActivate, ahk_class OpusApp
	return
}