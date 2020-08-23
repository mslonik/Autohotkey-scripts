SetHeadersAndFooters()
{
    WinActivate, ahk_class OpusApp
    oWord := ComObjActive("Word.Application")
    OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
    if  ((oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL))
    {
        MsgBox, 0x30,, The template has not been attached. Attach the template and run the macro again.
        return

    }
    cntSec := oWord.ActiveDocument.Sections.Count
    if (oWord.ActiveDocument.Bookmarks.Exists("StrTyt"))
        TitPage := 1
    if (oWord.ActiveDocument.Bookmarks.Exists("OstStr"))
        LastPage := 1
    oWord.Selection.GoTo(1,1)
    oWord.Selection.GoTo(0,2)
    FirstSec := oWord.Selection.Information(3) - 1
    if (FirstSec == 0)
        FirstSec := oWord.ActiveDocument.ActiveWindow.Panes(1).Pages.Count
    Loop, %cntSec%
    {
        oWord.ActiveWindow.ActivePane.View.SeekView := 10
        oWord.ActiveDocument.Sections(A_Index).Footers(1).PageNumbers.RestartNumberingAtSection := 0
        oWord.ActiveDocument.Sections(A_Index).Footers(1).Range.Text := ""
        oWord.ActiveDocument.Sections(A_Index).Headers(1).Range.Text := ""
        if (oWord.ActiveDocument.Sections(A_Index).Footers(2).Exists)
        {
            oWord.ActiveDocument.Sections(A_Index).Footers(1).PageNumbers.RestartNumberingAtSection := 0
            oWord.ActiveDocument.Sections(A_Index).Footers(2).Range.Text := ""
        }
        if (oWord.ActiveDocument.Sections(A_Index).Headers(2).Exists)
            oWord.ActiveDocument.Sections(A_Index).Headers(2).Range.Text := ""
    }
    oWord.Selection.GoTo(1,1)
    oWord.ActiveWindow.ActivePane.View.SeekView := 10
    Loop,
    {
        oWord.Selection.Style := "Linia przerwy ms"
        try
        {
            oWord.ActiveWindow.ActivePane.View.NextHeaderFooter
        }
        catch
        {
            break
        }
    }
    Loop, %cntSec%
    {
        ; if ((TitPage) and (A_Index == 1))
        if ((A_Index == 1))
        {
            oWord.ActiveDocument.Sections(A_Index).PageSetup.DifferentFirstPageHeaderFooter := -1
        }
        else if ((LastPage) and (A_Index == cntSec))
        {
            oWord.ActiveDocument.Sections(A_Index).PageSetup.DifferentFirstPageHeaderFooter := -1
            oWord.ActiveDocument.Sections(A_Index).Footers(1).LinkToPrevious := 0
            oWord.ActiveDocument.Sections(A_Index).Footers(2).LinkToPrevious := 0
            oWord.ActiveDocument.Sections(A_Index).Headers(1).LinkToPrevious := 0
            oWord.ActiveDocument.Sections(A_Index).Headers(2).LinkToPrevious := 0
        }
        else
        {
            oWord.ActiveDocument.Sections(A_Index).PageSetup.DifferentFirstPageHeaderFooter := 0
            oWord.ActiveDocument.Sections(A_Index).Footers(1).LinkToPrevious := 0
            oWord.ActiveDocument.Sections(A_Index).Headers(1).LinkToPrevious := 0
        }
        if ((TitPage) and !(LastPage))
        {
            oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Stopka zwykła")).Insert(oWord.ActiveDocument.Sections(A_Index).Footers(1).Range,-1)
        }
        else if (!(TitPage) and !(LastPage)) or ((TitPage) and (LastPage))
        {
            oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Stopka - 1")).Insert(oWord.ActiveDocument.Sections(A_Index).Footers(1).Range,-1)
        }
        else if (!(TitPage) and (LastPage))
        {
            oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Stopka - 2")).Insert(oWord.ActiveDocument.Sections(A_Index).Footers(1).Range,-1)
        }
        oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Nagłówek zwykły")).Insert(oWord.ActiveDocument.Sections(A_Index).Headers(1).Range,-1)
    }
    if (LastPage)
    {
        oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("OstatniaStrona")).Insert(oWord.ActiveDocument.Sections(cntSec).Footers(2).Range,-1)
    }
    oWord.Selection.GoTo(1,1)
    Loop,
    {
        oWord.ActiveWindow.ActivePane.View.SeekView := 9
        if (oWord.Selection.Information(12) = -1) 
		{
            oWord.Selection.Tables(1).AutoFitBehavior(1)
            Sleep, 10
            oWord.Selection.Tables(1).AutoFitBehavior(2)
		}
        try
        {
            oWord.ActiveWindow.ActivePane.View.NextHeaderFooter
        }
        catch
        {
            break
        }
    }
    ; if (TitPage)
    ; {
        oWord.ActiveDocument.Sections(1).Footers(1).PageNumbers.RestartNumberingAtSection := 1
        oWord.ActiveDocument.Sections(1).Footers(1).PageNumbers.StartingNumber := "0"
    ; }
    oWord.ActiveWindow.ActivePane.View.SeekView := 0
    oWord := ""
}