SetHeadersAndFooters()
{
    WinActivate, ahk_class OpusApp
    oWord := ComObjActive("Word.Application")
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
        if ((TitPage) and (A_Index == 1))
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
        if !(LastPage)
        {
            oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Stopka zwykła")).Insert(oWord.ActiveDocument.Sections(A_Index).Footers(1).Range,-1)
        }
        else if (LastPage)
        {
            oWord.ActiveDocument.AttachedTemplate.BuildingBlockEntries(MsgText("Stopka - 1")).Insert(oWord.ActiveDocument.Sections(A_Index).Footers(1).Range,-1)
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
        if (A_Index == 1)
        {
            oWord.ActiveWindow.ActivePane.View.SeekView := 10
        }
        try
        {
            oWord.ActiveWindow.ActivePane.View.NextHeaderFooter
        }
        catch
        {
            break
        }
        oWord.ActiveWindow.ActivePane.View.SeekView := 9
        if (oWord.Selection.Information(12) = -1) 
		{
            oWord.Selection.Tables(1).PreferredWidthType := 3 
            oWord.Selection.Tables(1).PreferredWidth := oWord.Selection.PageSetup.PageWidth - (oWord.Selection.PageSetup.LeftMargin + oWord.Selection.PageSetup.RightMargin + oWord.Selection.PageSetup.Gutter)
            oWord.Selection.Tables(1).Rows.Alignment := 1 
		}
    }
    if (TitPage)
    {
        oWord.ActiveDocument.Sections(1).Footers(1).PageNumbers.RestartNumberingAtSection := 1
        oWord.ActiveDocument.Sections(1).Footers(1).PageNumbers.StartingNumber := "0"
    }
    oWord.ActiveWindow.ActivePane.View.SeekView := 0
    oWord := ""
}

MsgText(string)
{
    vSize := StrPut(string, "CP0")
    VarSetCapacity(vUtf8, vSize)
    vSize := StrPut(string, &vUtf8, vSize, "CP0")
    Return StrGet(&vUtf8, "UTF-8") 
}