UsunKolor()
{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Próba wywołania makra, 
		( Join
		 Próbujesz wywołać makro przypisane do szablonu, ale szablon nie zostac jeszcze dołączony do tego pliku. 
	Najpierw dołącz szablon, a następnie wywołaj ponownie tą funkcję.
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