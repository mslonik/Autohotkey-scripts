FindBlad()
{
    oWord := ComObjActive("Word.Application")
    oWord.Selection.Find.ClearFormatting
	oWord.Selection.Find.Wrap := 1
    oWord.Selection.Find.Execute(MsgText("Błąd"))
    if (oWord.Selection.Find.Found = -1)
    {
        Msgbox, 48, Microsoft Word, % MsgText("Znaleziono słowo ""Błąd""")
    }
    else
    {
        MsgBox, 64, Microsoft Word, % MsgText("Nie znaleziono słowa ""Błąd""")
    }
    WinActivate, ahk_class OpusApp
    oWord:=""

}