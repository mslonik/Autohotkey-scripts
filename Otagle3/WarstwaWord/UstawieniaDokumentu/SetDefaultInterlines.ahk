SetDefaultInterlines()
{
    WinActivate, ahk_class OpusApp
    oWord := ComObjActive("Word.Application")
    oWord.ActiveDocument.Bookmarks.Add("startPosBookmark")
    prevPos := ""
    oWord.Selection.GoTo(11,1)
    Loop
    {
        Pos := oWord.Selection.Start
        if (Pos == prevPos)
            Break
        Else
        {
            prevPos := Pos
            oWord.Selection.ParagraphFormat.SpaceBefore := 48
            oWord.Selection.GoTo(11,2)
        }
    }
    oWord.Selection.GoTo(-1,,,"startPosBookmark")
    oWord.ActiveDocument.Bookmarks("startPosBookmark").Delete
    oWord := ""
    WinActivate, ahk_class OpusApp
}