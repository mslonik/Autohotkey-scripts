PrepareToPrint()
{
	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (OurTemplate != "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm" && OurTemplate != "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm")
	{
		MsgBox, 48, Zanim wydrukujesz..., 
		( Join	
1. Wykonaj makro, które wstawi tward¹ spacjê po etykietach tabel i rysunków.`n
2. Odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n
3. Zamieñ wszystkie odsy³acze na ³¹cza.`n
4. Ponownie odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n
5. Poszukaj s³owa "B³¹d".
		)
		
	}
	else
	{
		oWord.Run("TwardaSpacja")
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Odœwie¿ono dokument
		oWord.Run("HiperlaczaPasek")
		MsgBox, 64, Microsoft Word, Zamieniono odsy³acze na ³¹cza
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Ponownie odœwie¿ono dokument
		oWord.Selection.Find.ClearFormatting
		oWord.Selection.Find.Wrap := 1
		oWord.Selection.Find.Execute("B³¹d")
		if (oWord.Selection.Find.Found = -1)
		{
			Msgbox, 48, Microsoft Word, Znaleziono s³owo "B³¹d"
		}
		else
		{
			MsgBox, 64, Microsoft Word, Nie znaleziono s³owa "B³¹d"
		}
		
	}
	Send, {F12 down}{F12 up}
	oWord := ""
}