UsunKolor()
{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Próba wywo³ania makra, 
		( Join
		 Próbujesz wywo³aæ makro przypisane do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
	Najpierw do³¹cz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
		)
	}
	else
	{
		oWord.Run("!UsunKolor")
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}