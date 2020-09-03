Refresh()
{
    static RefTxt 

    OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16,% MsgText("Próba wywołania makra"), % MsgText("Próbujesz wywołać makro przypisane do szablonu, ale szablon nie został jeszcze dołączony do tego pliku. Najpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.")
	}
	else
	{
		oWord.ScreenUpdating := 0
        oWord.DisplayAlerts := 0
        
        Gui, Ref:New, -Border
        Gui, Ref:Add, Text, h25 w200 vRefTxt, % MsgText("Działanie makra w toku")
        Gui, Ref:Show, h25 w200

        if oWord.ActiveWindow.ActivePane.view.SeekView == 0
        {
             oWord.Selection.Bookmarks.Add("pozycja")
        }

        GuiControl,, RefTxt, % MsgText("Odświeżanie pól")
        Loop, 17
        {
            try
            {
                oWord.ActiveDocument.StoryRanges(A_Index).Select
                oWord.Selection.Fields.Update
            }
        }

        GuiControl,, RefTxt, % MsgText("Odświeżanie spisów treści")
        toCcnt := oWord.ActiveDocument.TablesOfContents.Count
        Loop, %toCcnt%
        {
            oWord.ActiveDocument.TablesOfContents(A_Index).Update
        }
    
        oWord.Selection.Collapse(0)

        oWord.Application.DisplayAlerts := -1

        if oWord.ActiveDocument.Bookmarks.Exists("pozycja")
        {
            oWord.Selection.GoTo(-1,,,"pozycja")
            oWord.ActiveDocument.Bookmarks("pozycja").Delete
        }
        else
        {
            oWord.ActiveDocument.GoTo(6)
        }

        oWord.ActiveWindow.view.Type := 3
        oWord.Application.ScreenUpdating := -1
        Gui, Ref:Destroy
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}