UsunWielokrotneSpacje()
{
	; Autor: Piotr Węgorek
    ; Przepisanie z VBA na AHK: Jakub Masiak
    oWord := ComObjActive("Word.Application")
    if ((oWord.Version == "14.0") or (oWord.Version == "16.0"))
    {
        oWord.ScreenUpdating := 0
        if (oWord.ActiveWindow.ActivePane.View.SeekView == 0)
        {
            oWord.Selection.Bookmarks.Add("pozycja")
        }
        Gui, MultiSpaces:New, -MinimizeBox -MaximizeBox -Border +AlwaysOnTop
        Gui, MultiSpaces:Add, Text,, The macro is running!
        Gui, MultiSpaces:Show, h25 w125 x100 y100
        oWord.Selection.HomeKey(6)
        oWord.Selection.Find.ClearFormatting
        oWord.Selection.Find.Replacement.ClearFormatting
        oWord.Selection.Find.Execute(" [ ]@([! ])",0,0,-1,0,0,-1,0,0," \1",2) ; usuwanie dodatkowych spacji
        oWord.Selection.Find.Execute(" ^p",0,0,0,0,0,-1,0,0,"^p",2) ; usuwanie spacji przed znakiem akapitu
        oWord.Selection.Find.Execute(" ,",0,0,0,0,0,-1,0,0,",",2) ; usuwanie spacji przed przecinkiem
        oWord.Selection.Find.Execute(" .",0,0,0,0,0,-1,0,0,".",2) ; uswanie spacji przed kropką
        oWord.Selection.Find.Execute("^p^p",0,0,0,0,0,-1,1,0,"^p",2) ; usuwanie dwóch znaków akapitu z rzędu 
        oWord.ActiveWindow.View.Type := 3
        oWord.ScreenUpdating := -1
        if oWord.ActiveDocument.Bookmarks.Exists("pozycja")
        {
            oWord.Selection.GoTo(-1,,,"pozycja")
            oWord.ActiveDocument.Bookmarks("pozycja").Delete
        }
        else
        {
            oWord.Selection.HomeKey(6)
        }
        Gui, MultiSpaces:Destroy
    }
    else
    {
        MsgBox, 0x10, EliminateMultipleSpaces, Macros are not compatible with your version of MS Office!
    }
    oWord := ""
	return
}