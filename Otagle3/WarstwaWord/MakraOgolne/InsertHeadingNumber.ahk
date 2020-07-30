InsertHeadingNumber()
{
	local vMyListBoxNumber
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	if (flag_number == 0) or !(flag_number)
	{
		try
		{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_number := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_number = 0) or !(flag_number)
		{
			Y := MonTop
			W := (MonRight - MonLeft)/(Var/2)
			X := MonRight -  W
			H := MonBottom - (MonTop + 5*Var/2)
			flag_number := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hlb := H -  Var
		Wlb := W - 2 * Var
		Gui, number:New, +Resize
		Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBoxNumber gMyListBoxNumber +AltSubmit
		myHeadings := oWord.ActiveDocument.GetCrossReferenceItems(1) ; 1 - heading
		Loop, % myHeadings.MaxIndex()
		{
			GuiControl,, MyListBoxNumber, % myHeadings[A_Index]
		}
		Gui, number:Add, Button, Hidden Default gOKNumber,OKNumber
		Gui, number:Show,X%X% Y%Y% H%H% W%W%, Wstaw numer nag³ówka
	}
	else if(flag_number == 1)
	{
		WinGetPos, X, Y, W, H, Wstaw numer nag³ówka
		Gui, number:Destroy
		flag_number := 0
	}
	return
	
MyListBoxNumber:
	if (A_GuiEvent != "DoubleClick")
		return
			
OKNumber:
	try
	{
		Gui, Submit, Nohide
		Index := MyListBoxNumber
		oWord.Selection.InsertCrossReference(1, -4, Index, 1, 0, 0, " ") ; 1 - heading, -4 - number
	}
	return

numberGuiEscape:
numberGuiClose:
	WinGetPos, X, Y, W, H, Wstaw numer nag³ówka
	Gui, number:Destroy
	flag_number := 0
	WinActivate, ahk_class OpusApp
	return
}