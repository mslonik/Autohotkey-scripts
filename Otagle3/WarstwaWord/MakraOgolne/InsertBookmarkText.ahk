InsertBookmarkText()
{
	local vMyListBoxBookmark
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	
	if (flag_bookmark == 0) or !(flag_bookmark)
	{
		try
		{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_bookmark := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_bookmark = 0) or !(flag_bookmark)
		{
			Y := MonTop
			W := (MonRight - MonLeft)/(Var/2)
			X := MonRight -  W
			H := MonBottom - (MonTop + 5*Var/2)
			flag_bookmark := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hlb := H -  Var
		Wlb := W - 2 * Var
		Gui, bookmark:New, +Resize +AlwaysOnTop
		Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBoxBookmark gMyListBoxBookmark +AltSubmit
		myHeadings := oWord.ActiveDocument.GetCrossReferenceItems(2) ; 2 - bookmark
		Loop, % myHeadings.MaxIndex()
		{
			GuiControl,, MyListBoxbookmark, % myHeadings[A_Index]
		}
		Gui, bookmark:Add, Button, Hidden Default gOKBookmark,OKbookmark
		Gui, bookmark:Show,X%X% Y%Y% H%H% W%W%, Wstaw tekst zak�adki
	}
	else if(flag_bookmark == 1)
	{
		WinGetPos, X, Y, W, H, Wstaw tekst zak�adki
		Gui, bookmark:Destroy
		flag_bookmark := 0
	}
	return
	
MyListBoxBookmark:
	if (A_GuiEvent != "DoubleClick")
		return
			
OKBookmark:
	try
	{
		Gui, Submit, Nohide
		Index := MyListBoxBookmark
		bookmark := myHeadings[Index]
		oWord.Selection.InsertCrossReference(2, -1, bookmark, 0, 0, 0, " ") ; 2 - bookmark, -1 - text
		WinActivate, ahk_class OpusApp
	}
	return

bookmarkGuiEscape:
bookmarkGuiClose:
	WinGetPos, X, Y, W, H, Wstaw tekst zak�adki
	Gui, bookmark:Destroy
	flag_bookmark := 0
	WinActivate, ahk_class OpusApp
	return
}