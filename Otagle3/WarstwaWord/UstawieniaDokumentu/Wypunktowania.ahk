Wypunktowania()
{
    static numPara, numLists, EndLists
    global indEr, indWrong, NextPara, PrevPara, wrong, wrongLists
    oWord := ComObjActive("Word.Application")    
    oWord.ActiveWindow.View.ShowFieldCodes := -1  
    cntPara := oWord.ActiveDocument.Paragraphs.Count      
    indPara := []
    paraLists := []
    wrongLists := []
    indLists := 0
    indWrong := 0
    Gui, Lists:New, -MinimizeBox -MaximizeBox +AlwaysOnTop
    Gui, Lists:Add, Text,,Sprawdzone akapity:
    Gui, Lists:Add, Text, vnumPara w100, 0/%cntPara%
    Gui, Lists:Add, Text,, Znalezione akapity z wypunktowaniem:
    Gui, Lists:Add, Text, vnumLists w100, %indLists%
    Gui, Lists:Add, Text,, % MsgText("Akapity z błędną interpunkcją:")
    Gui, Lists:Add, Text, vwrong w100, 0/%indWrong%   
    Gui, Lists:Add, Button, vPrevPara gPrevPara w85 h25 Disabled, % MsgText("Poprzedni błąd")
    Gui, Lists:Add, Button, vNextPara gNextPara yp x+m w85 h25 Disabled, % MsgText("Następny błąd")
    Gui, Lists:Add, Button, gRepeatLists xm w85 h25, % MsgText("Ponów makro")
    Gui, Lists:Add, Button, yp x+m gEndLists w85 h25, % MsgText("Zakończ")
    Gui, Lists:Show,, Wypunktowania
    oWord.ActiveDocument.Paragraphs(1).Range.Select
    Loop, %cntPara%
    {
        txtPara := oWord.ActiveDocument.Paragraphs(1).Next(A_Index - 1).Range.Text
        if (InStr(txtPara, "ListaWypunktowanaPoziom1") or InStr(txtPara, "ListaWypunktowanaPoziom2") or InStr(txtPara, "ListaWypunktowanaPoziom3") or InStr(txtPara, "ListaWypunktowanaPoziom4"))
        {
            indPara.Push(A_Index)
            paraLists.Push(txtPara)
        }
        if indPara.MaxIndex() > 0
            indLists := indPara.MaxIndex()
        GuiControl,,numPara, %A_Index%/%cntPara%
        GuiControl,,numLists, %indLists%
    }
    doc := oWord.ActiveDocument
    Loop, % indLists
    {
        StartingPos := InStr(paraLists[A_Index], ".")
        NewStr := SubStr(paraLists[A_Index], StartingPos+1)
        NewStr := LTrim(NewStr)
        NewStr := SubStr(NewStr,1,StrLen(NewStr)-1)
        NewStr := RTrim(NewStr)
        FirstChar := SubStr(NewStr,1,1)
        if (((Asc(FirstChar) >= 65) and (Asc(FirstChar) <= 90)) or (Asc(FirstChar) == 262) or (Asc(FirstChar) == 321) or (Asc(FirstChar) == 346) or (Asc(FirstChar) == 377) or (Asc(FirstChar) == 379))
        {
            state := 1
        }
        else if (((Asc(FirstChar) >= 97) and (Asc(FirstChar) <= 122)) or (Asc(FirstChar) == 263) or (Asc(FirstChar) == 322) or (Asc(FirstChar) == 347) or (Asc(FirstChar) == 378) or (Asc(FirstChar) == 380))
        {
            state := 0
        }
        else if FirstChar == ""
        {
            wrongLists.Push(indPara[A_Index])
        }
        else
        {
            state := 0
        }
        LastChar := SubStr(NewStr,StrLen(NewStr),1)
        if (state == 1)
        {
            if (LastChar != ".") and (LastChar != "?") and (LastChar != "!") and (LastChar != ":")
            {
                wrongLists.Push(indPara[A_Index])
            }
        }
        else if (state == 0)
        {
            posList := InStr(paraLists[A_Index], "ListaWypunktowanaPoziom")
            levList := SubStr(paraLists[A_Index],posList+23,1)
            if (A_Index == indLists)
            {
                levNextList := 0
            }
            else
            {
                posNextList := InStr(paraLists[A_Index+1], "ListaWypunktowanaPoziom")
                levNextList := SubStr(paraLists[A_Index+1],posNextList+23,1)
            }
            
            
            if (InStr(paraLists[A_Index+1],"\r1") or levNextList == 0) and (levList >= levNextList) and (LastChar != ".")
            { 
                wrongLists.Push(indPara[A_Index])
            }
            else if (InStr(paraLists[A_Index+1],"\r1") or levNextList == 0) and (levList >= levNextList) and (LastChar == ".")
            {

            }
            else if (LastChar != ",") and (LastChar != ";") and (LastChar != ":")
            {
                wrongLists.Push(indPara[A_Index])
            }
        }
        if wrongLists.MaxIndex() > 0
            indWrong := wrongLists.MaxIndex()
    }
    if (indWrong > 1)
    {
        GuiControl, Enable, NextPara
        indEr := 1
        oWord.ActiveDocument.Paragraphs(wrongLists[indEr]).Range.Select
    }
    else if  (indWrong == 1)
    {
        indEr := 1
        oWord.ActiveDocument.Paragraphs(wrongLists[indEr]).Range.Select
    }
    else
        indEr := 0
    GuiControl,,wrong, %indEr%/%indWrong%
    oWord.ActiveWindow.View.ShowFieldCodes := 0
    oWord.ActiveWindow.ScrollIntoView(oWord.Selection.Range, -1)
    WinActivate, ahk_class OpusApp
    oWord := ""
    return

NextPara:
    oWord := ComObjActive("Word.Application")
    oWord.ActiveWindow.View.ShowFieldCodes := -1
    indEr := indEr + 1
    if (indEr >= indWrong)
    {
        indEr := indWrong
        GuiControl, Disable, NextPara
    }
    if (indEr > 1)
    {
        GuiControl, Enable, PrevPara
    }
    oWord.ActiveDocument.Paragraphs(wrongLists[indEr]).Range.Select 
    GuiControl,,wrong, %indEr%/%indWrong%    
    oWord.ActiveWindow.View.ShowFieldCodes := 0
    oWord.ActiveWindow.ScrollIntoView(oWord.Selection.Range, -1)
    WinActivate, ahk_class OpusApp
    oWord := ""
    Return

PrevPara:
    oWord := ComObjActive("Word.Application")
    oWord.ActiveWindow.View.ShowFieldCodes := -1
    indEr := indEr - 1
    if (indEr <= 1)
    {
        indEr := 1
        GuiControl, Disable, PrevPara
    }
    if (indEr < indWrong)
    {
        GuiControl, Enable, NextPara
    }
    oWord.ActiveDocument.Paragraphs(wrongLists[indEr]).Range.Select
    GuiControl,,wrong, %indEr%/%indWrong%
    oWord.ActiveWindow.View.ShowFieldCodes := 0
    oWord.ActiveWindow.ScrollIntoView(oWord.Selection.Range, -1) 
    WinActivate, ahk_class OpusApp
    oWord := ""
    Return

EndLists:
ListsGuiEscape:
    Gui, Lists:Destroy
    Return

RepeatLists:
    Gui, Lists:Destroy
    Wypunktowania()
    Return
}