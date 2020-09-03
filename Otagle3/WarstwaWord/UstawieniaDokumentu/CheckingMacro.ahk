CheckingMacro()
{
    static 

    Gui, CheckMacro:New, -MinimizeBox -MaximizeBox
    Gui, CheckMacro:Font, s10
    Gui, CheckMacro:Add, Text,,Wybierz operacje do wykonania:
    Gui, CheckMacro:Add, CheckBox, gState vHeadings, % MsgText("Ustaw nagłówki i stopki")
    Gui, CheckMacro:Add, CheckBox, gState vSigns, % MsgText("Sprawdź znaki interpunkcyjne w listach numerowanych")
    Gui, CheckMacro:Add, CheckBox, gState vMultiSpaces, % MsgText("Usuń wielokrotne spacje i entery")   
    Gui, CheckMacro:Add, CheckBox, gState vRefresh,% MsgText("Odśwież dokument")
    Gui, CheckMacro:Add, CheckBox, gState vHardSpace,% MsgText("Zamień spacje w dokumencie na twarde spacje")
    Gui, CheckMacro:Add, CheckBox, gState vHyperlinks, % MsgText("Zamień odsyłacze na hiperłącza")
    Gui, CheckMacro:Add, CheckBox, gState vFailure, % MsgText("Poszukaj słowa ""błąd""")
    Gui, CheckMacro:Add, CheckBox, gState vSize, % MsgText("Zmniejsz rozmiar obrazków w dokumencie")
    Gui, CheckMacro:Add, Text, xm+15, Zaktualizuj Change Log
    Gui, CheckMacro:Add, Button, gGoNext vGoNext Disabled, Dalej
    Gui, CheckMacro:Add, Button, yp x+m gCheckMacroGuiClose, Anuluj
    Gui, CheckMacro:Show, xCenter yCenter, Checklist
    return

    State:
        Gui, CheckMacro:Submit, NoHide
        if ((Headings) or (Signs) or (MultiSpaces) or (Refresh) or (HardSpace) or (HyperLinks) or (Failure) or (Size))
        {
            GuiControl, Enable, Dalej
        }
        else
        {
            GuiControl, Disable, Dalej
        }
    return

    GoNext:
        if(Headings)
            SetHeadersAndFooters()
        if(Signs)
            Wypunktowania()
        if(MultiSpaces)
            UsunWielokrotneSpacje()
        if(HardSpace)
            TwardaSpacja()
        if(Refresh)
            Refresh()
        if(HyperLinks)
        {
            Hiperlacza()
            Refresh()
        }
        if(Failure)
            FindBlad()
        if(Size)
        {

            MsgBox, 0x34, Uwaga!, % MsgText("Przed zmniejszeniem obrazków dokument zostanie zamknięty i zapisany. Czy chcesz kontynuować?")
            IfMsgBox, Yes
            {
                oWord := ComObjActive("Word.Application")
                DocName := oWord.ActiveDocument.FullName
                oWord.ActiveDocument.Close(-1)
                oWord := ""
                ResizeImages(DocName)

            }
                
        }

    CheckMacroGuiEscape:
    CheckMacroGuiClose:
        Gui, CheckMacro:Destroy
        return
}