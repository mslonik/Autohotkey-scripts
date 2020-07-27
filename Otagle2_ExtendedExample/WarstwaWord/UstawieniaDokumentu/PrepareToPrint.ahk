PrepareToPrint()
{
	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (OurTemplate != "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm" && OurTemplate != "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm")
	{
		MsgBox, 48, Zanim wydrukujesz..., % MsgText("1. Wywołaj makro, które wstawi nagłówki i stopki. `n2. Wywołaj makro, które sprawdzi poprawność znaków przestankowych w wypunktowaniach. `n3. Wykonaj makro, które wstawi twardą spację po etykietach tabel i rysunków.`n4. Odśwież zawartość całego dokumentu (Ctrl + F9).`n5. Zamień wszystkie odsyłacze na łącza.`n6. Ponownie odśwież zawartość całego dokumentu (Ctrl + F9).`n7. Poszukaj słowa ""Błąd"".")
		
	}
	else
	{
		oWord.Run("TwardaSpacja")
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Od�wie�ono dokument
		oWord.Run("HiperlaczaPasek")
		MsgBox, 64, Microsoft Word, Zamieniono odsy�acze na ��cza
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Ponownie od�wie�ono dokument
		oWord.Selection.Find.ClearFormatting
		oWord.Selection.Find.Wrap := 1
		oWord.Selection.Find.Execute("B��d")
		if (oWord.Selection.Find.Found = -1)
		{
			Msgbox, 48, Microsoft Word, Znaleziono s�owo "B��d"
		}
		else
		{
			MsgBox, 64, Microsoft Word, Nie znaleziono s�owa "B��d"
		}
		
	}
	Send, {F12 down}{F12 up}
	oWord := ""
}