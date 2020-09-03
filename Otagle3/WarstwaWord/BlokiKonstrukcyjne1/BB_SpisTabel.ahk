BB_SpisTabel()
{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Próba wywołania stylu z szablonu, 
		( Join
		 Próbujesz wstawić blok konstrukcyjny przypisany do szablonu, ale szablon nie zostać jeszcze dołączony do tego pliku. 
		 Najpierw dołącz szablon, a następnie wywołaj ponownie ta funkcję.
		)
	}
	else
	{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("Spis tabel").Insert(oWord.Selection.Range, -1)
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}