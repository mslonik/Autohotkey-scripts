InsertHeadingText()
{
	local vMyListBoxText
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	if (flag_text == 0) or !(flag_text)
	{
		try
		{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_text := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_text = 0) or !(flag_text)
		{
			Y := MonTop
			W := (MonRight - MonLeft)/(Var/2)
			X := MonRight -  W
			H := MonBottom - (MonTop + 5*Var/2)
			flag_text := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hlb := H -  Var
		Wlb := W - 2 * Var
		Gui, text:New, +Resize +AlwaysOnTop
		Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBoxText gMyListBoxText +AltSubmit
		myHeadings := oWord.ActiveDocument.GetCrossReferenceItems(1) ; 1 - heading
		Loop, % myHeadings.MaxIndex()
		{
			GuiControl,, MyListBoxText, % myHeadings[A_Index]
		}
		Gui, text:Add, Button, Hidden Default gOKText,OKText
		Gui, text:Show,X%X% Y%Y% H%H% W%W%, Wstaw tekst nag��wka
	}
	else if(flag_text == 1)
	{
		WinGetPos, X, Y, W, H, Wstaw tekst nag��wka
		Gui, text:Destroy
		flag_text := 0
	}
	return
	
MyListBoxText:
	if (A_GuiEvent != "DoubleClick")
		return
			
OKText:
	try
	{
		Gui, Submit, Nohide
		Index := MyListBoxText
		oWord.Selection.InsertCrossReference(1, -1, Index, 1, 0, 0, " ") ; 1 - heading, -1 - text
		WinActivate, ahk_class OpusApp
	}
	return

textGuiEscape:
textGuiClose:
	WinGetPos, X, Y, W, H, Wstaw tekst nag��wka
	Gui, text:Destroy
	flag_text := 0
	WinActivate, ahk_class OpusApp
	return
}