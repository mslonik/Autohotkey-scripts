AutoTemplate()
{
	global
	OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	LocTempPL := % A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S402-pl_OgolnyTechDok.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S402-en_OgolnyTechDok.dotm"
	oWord := ComObjActive("Word.Application")
	try
		template := oWord.ActiveDocument.CustomDocumentProperties["PopSzab"].Value
	catch
	{
		oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
		template := oWord.ActiveDocument.CustomDocumentProperties["PopSzab"].Value
	}
	if (template = "PL" or template = "EN")
	{
		AddTemplate()
	}
	else
		ChooseTemplate()
	return
}

AddTemplate(){
	global
	if !(FileExist("S:\"))
	{
		MsgBox,16,, Unable to add template. To continue, connect to voestalpine servers and try again.
		oWord := ""
		return
	}
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (template == "PL")
	{
		if ((OurTemplate == OurTempPL) or (OurTemplate == LocTempPL) or (OurTemplate == SzabTempPL))
		{
			oWord := ""
			
		}
		else
		{
			oWord.ActiveDocument.AttachedTemplate := LocTempPL
			oWord.ActiveDocument.UpdateStylesOnOpen := -1
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % "Dołączono szablon!`n Dołączono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			OurTemplate := LocTempPL
		}
	}
	else if (template == "EN")
	{
		if ((OurTemplate == OurTempEN) or (OurTemplate == LocTempEN) or (OurTemplate == SzabTempEN))
		{
			oWord := ""
			
		}
		else
		{
			oWord.ActiveDocument.AttachedTemplate := LocTempEN
			oWord.ActiveDocument.UpdateStylesOnOpen :=  -1
			oWord.ActiveDocument.UpdateStyles
			oWord.ActiveWindow.ActivePane.View.SeekView := 9
			BB_Insert("Nagłówek zwykły")
			Send, {Esc}
			oWord.ActiveWindow.ActivePane.View.SeekView := 10
			BB_Insert("Stopka zwykła")
			MsgBox, 64, Informacja, % "Dołączono szablon!`n Dołączono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			OurTemplate := LocTempEN
		}
	}
	oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
	MsgBox, 36,, Do you want to set size of the margins?
	IfMsgBox, Yes
	{
		oWord := ComObjActive("Word.Application")
		oWord.Run("!Wydruk")
	}
	MsgBox, 36,, Do you want to add some building blocks to your document?
	IfMsgBox, Yes
		AddBB()
	oWord := ""
	return

}

ChooseTemplate(){
	global
	MsgBox, 36,, Do you want to add a template to this document?
	IfMsgBox, Yes
	{
		Gui, Temp:New
		Gui, Temp:Add, Text,, Choose template:
		Gui, Temp:Add, Radio, vMyTemplate Checked, Polish template
		Gui, Temp:Add, Radio,, English template
		Gui, Temp:Add, Button, w200 gTempOK Default, OK
		Gui, Temp:Show,, Add Template
	}
	return
}
TempOK(){
	global
	Gui, Temp:Submit, +OwnDialogs
	if (MyTemplate == 1)
	{
		template := "PL"
	}
	else if (MyTemplate == 2)
	{
		template := "EN"
	}
	AddTemplate()
	return
}

AddBB(){
	global
	Gui, BB:New
	Gui, BB:Add, Text,, Choose building blocks you want to add:
	Gui, BB:Add, Checkbox, vFirstPage, First Page
	Gui, BB:Add, Checkbox, vID, ID
	Gui, BB:Add, Checkbox, vChangeLog, Change Log
	Gui, BB:Add, Checkbox, vTOC, Table of Contents
	Gui, BB:Add, Checkbox, vLOT, List of Tables
	Gui, BB:Add, Checkbox, vLOF, List of Figures
	Gui, BB:Add, Checkbox, vIntro, Introduction
	Gui, BB:Add, Checkbox, vLastPage, Last Page
	Gui, BB:Add, Button, w200 gBBOK Default, OK
	oWord.Run("AddDocProperties")
	Gui, BB:Show,, Add Building Blocks
return


BBOK:
	Gui, BB:Submit, +OwnDialogs
	Gui, BB:Destroy
	if (FirstPage == 1)
		BB_Insert("Strona ozdobna")
	if (ID == 1)
		BB_Insert("identyfikator")
	if (ChangeLog == 1)
		BB_Insert("Lista zmian")
	if (TOC == 1)
	{
		BB_Insert("Spis treści")
		Send, {Right}{Enter}{Enter}
	}
	if (LOT == 1)
	{
		BB_Insert("Spis tabel")
		Send, {Right}{Enter}{Enter}
	}
	if (LOF == 1)
	{
		BB_Insert("Spis rysunków")
		Send, {Right}{Enter}{Enter}
	}
	if (Intro == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.ActiveDocument.Bookmarks.Add("intro", oWord.Selection.Range)
		Send, {Enter}{Enter}
	}
	if (LastPage == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.InsertBreak(wdSectionBreakNextPage := 2)
		BB_Insert("OstatniaStronaObrazek")
	if (Intro == 1)
	{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.GoTo(-1,,,"intro")
		oWord.Selection.Find.ClearFormatting
		oWord.ActiveDocument.Bookmarks("intro").Delete
	}
	}
return
}

BB_Insert(Name_BB)
	{
	global 

	oWord := ComObjActive("Word.Application")
	OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	LocTempPL := % A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S402-pl_OgolnyTechDok.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if  ((OurTemplate != OurTempPL) and (OurTemplate != OurTempEN) and (OurTemplate != LocTempPL) and (OurTemplate != LocTempEN) and (OurTemplate != SzabTempPL) and (OurTemplate != SzabTempEN))
	{
		MsgBox, 16, % MsgText("Próba wywołania stylu z szablonu"), % MsgText("Próbujesz wstawić blok konstrukcyjny przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku.`r`n Najpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.")
	}
	else
		{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries(Name_BB).Insert(oWord.Selection.Range, -1)
		}
	oWord :=  "" ; Clear global COM objects when done with them
	}