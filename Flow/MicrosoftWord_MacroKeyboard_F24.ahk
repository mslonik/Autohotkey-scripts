;~ Ta wersja powstała z QMK_F24_macro_keyboard.ahk 
;~ WHERE TO LOOK FOR HELP:
;~ Taran VH: 					https://youtu.be/GZEoss4XIgc
;~ Taran Github: 				https://github.com/TaranVH/2nd-keyboard/
;~ AutoHotKey (AHK) tutorial: 	https://autohotkey.com/docs/Tutorial.htm
;~ Tool for AHK:				http://fincs.ahk4.net/scite4ahk/
;~ COM help:					https://docs.microsoft.com/en-us/office/vba/api/word.application
;~ Here is the full list of scan code substitutions that I made:
;~ https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=824607963

;; COOL BONUS BECAUSE YOU'RE USING QMK:
;; The up and down keystrokes are registered seperately. Therefore, your macro can do half of its action on the down stroke,
;; and the other half on the up stroke. (using "keywait,"). This can be very handy in specific situations.

;~ This version is suited to Asian keyboard layout, 101 keys (Base: 71, Navigation: 13, NumPad: 17).

;~ ZADANIA DO ZREALIZOWANIA:
;~ - zmiana kolejności obiektow graficznych - ShapeRange.ZOrder
;~ - okienko do wstawiania etykiet (SEQ) np. Tab. / Tabela, Rys. / Rysunek itd.
;~ - zarejestruj makro

SetWorkingDir, c:\Users\v523580\AutoHotKeyScripts\ ; Changes the script's current working directory.
Menu, Tray, Icon, shell32.dll, 283 	;if commented in, this line will turn the H icon into a little grey keyboard-looking thing.
SetKeyDelay, 0 						;IDK exactly what this does.

#SingleInstance,Force ; Determines whether a script is allowed to run again when it is already running. Force: Skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.
#Warn ; Enables or disables warnings for specific conditions which may indicate an error, such as a typo or missing "global" declaration.
#NoEnv ; Avoids checking empty variables to see if they are environment variables (recommended for all new scripts).
SendMode Input
#InstallKeybdHook
;#InstallMouseHook 					;<--You'll want to use this if you have scripts that use the mouse.
#UseHook On
#MaxHotkeysPerInterval 2000

;;The lines below are optional. Delete them if you need to.
#HotkeyModifierTimeout 60 			; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
#KeyHistory 200 					; https://autohotkey.com/docs/commands/_KeyHistory.htm 				; useful for debugging.
#MenuMaskKey vk07 					; https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#WinActivateForce 					; https://autohotkey.com/docs/commands/_WinActivateForce.htm 		; prevent taskbar flashing.
;;The lines above are optional. Delete them if you need to.

; --------------- SEKCJA ZMIENNYCH GLOBALNYCH Microsoft Word -----------------------------
global WordTrue := -1 ; ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true
global WordFalse := 0 ; ComObj(0xB, 0) ; 0xB = VT_Bool || 0 = false
global CmToPoints := 28.35 ; zamiana [cm] na [pt] (punkty zecerskie)
global OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
global OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
global OurTemplate := ""
global OutputPDFfilePath := "C:\temp1\"
global AutosaveFilePath := "C:\temp1\KopiaZapasowaPlikowWord\"
global cursorPosition := ""
global varhf := 0
;--------------- Flagi do okienek z odsyłaczami ----------------
global flag_text := 0
global flag_number := 0
global flag_enum := 0
global flag_bookmark := 0
global flag_a := 0
global flag_b := 0
global flag_c := 0
global flag_d := 0
;---------------- Zmienne do funkcji autozapisu ----------------
global flag_as := 0
global size := 0
global size_org := 0
global table := []
global interval := 600000
;--------------- Zmienne do przełączania okienek ---------------
global cntWnd := 0
global cntWnd2 := 0
global id := []
global order := []
;---------------------------------------------------------------

; --------------- KONIEC SEKCJI ZMIENNYCH GLOBALNYCH ----------------------

SetTimer, AutoSave, % interval
MsgBox,48,Uwaga!, Uruchomiona jest funkcja autozapisu, która co 10 minut tworzy kopie zapasowe dokumentów aktywnych w programie Microsoft Word. Aby wyłączyć tę funkcję, naciśnij kombinację klawiszy Ctrl+LewyAlt+Q.

;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;
;;+++++++++++++++++ BEGIN SECOND KEYBOARD F24 ASSIGNMENTS +++++++++++++++++++++;;
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;

#if (getKeyState("F24", "P")) and WinActive(, "Microsoft Word") ; <--Everything after this line will only happen on the secondary keyboard that uses F24 AND in Microsoft Word.
;~ #if (getKeyState("F24", "P")) 	; <--Everything after this line will only happen on the secondary keyboard that uses F24.

F24:: return 					; this line is mandatory for proper functionality

;;------------------------1st ROW OF KEYS (13)--------------------------;;

escape:: SetTemplate("PL", "Dołącz domyślny szablon dokumentu PL") 
return	

F1:: BB_Insert("Strona ozdobna", "you pressed the function key")
return	

F2:: BB_Insert("identyfikator", "you pressed the function key")
return	

F3:: BB_Insert("Lista zmian", "you pressed the function key")
return	

F4:: BB_Insert("Spis treści", "you pressed the function key")
return	

F5:: BB_Insert("Spis tabel", "you pressed the function key")
return	

F6:: BB_Insert("Spis rysunków", "you pressed the function key")
return	

F7:: BB_Insert("Spis oznaczeń graficznych", "you pressed the function key")
return	

F8:: BB_Insert("tabela", "you pressed the function key")
return	

F9:: BB_Insert("Kanwa", "you pressed the function key")
return	

F10:: BB_Insert("Tabela informacja", "you pressed the function key")
return	

F11:: BB_Insert("Zastrzeżenie", "you pressed the function key")
return	

F12:: BB_Insert("Pierwsza strona zwykła", "you pressed the function key")
return	
	

;;------------------------2nd ROW (15)--------------------------;;

`:: SetTemplate("EN", "Dołącz domyślny szablon dokumentu EN")
return	

1:: TemplateStyle("Normalny ms")
return

2:: TemplateStyle("Normalny pomiedzy ms")
return	

3:: TemplateStyle("Rysunek ms")
return	

4:: TemplateStyle("Podpis pod rysunkiem ms")
return	

5:: TemplateStyle("Linia przerwy ms") 
return	

6:: TemplateStyle("Wypunktowanie referencji ms") 
return	

7:: ; Dedicated window: Enter no. of header
InsertRef("number")
return	

8:: ; Dedicated window: Enter text of header
InsertRef("text")
return	

9:: ; Dedicated window: Enter number of numbered paragraph
InsertRef("enum")
return	

0:: ; Dedicated window: Enter text of Bookmark
InsertRef("bookmark")
return	

-:: ; rozpocznij numerowanie listy od początku (VBA: RestartNumbering)
	;~ https://docs.microsoft.com/en-us/office/vba/api/word.listformat.cancontinuepreviouslist
	;~ https://docs.microsoft.com/en-us/office/vba/api/word.listformat
	TemplateStyle("Wypunktowanie ms")
return	

=:: WatermarkDRAFT("Wstawia znak wodny DRAFT wszystkich sekcji dokumentu")
return	

\:: BB_Insert("Nagłówek zwykły", "BB: Nagłówek zwykły")
return	

Backspace:: BB_Insert("Stopka zwykła", "BB: Stopka zwykła")
return	

;;------------------------3rd ROW (13)--------------------------;;

tab:: ChangeZoom("Zmień powiększenie")
return	

q:: NavigationPaneVisibility("Włącz / wyłącz Navigation pane")
return	

w:: ToggleStylePane("Włącz / wyłącz Style pane")
return	

e:: ShowClipboard("Włącz podgląd schowka") 
return	

r:: ToggleFormattingPane("pokaż ukryj Panel formatowanie")
return	

t:: ToggleRuler("Pokaż / ukryj linijkę")
return	

y:: ParagraphLinesKeepTogether("Akapit: Zachowaj wiersze razem")
return	

u:: ParagraphPageBreakBefore("Akapit: Podział strony przed")
return

i:: ParagraphFormatKeepWithNext("Akapit: Razem z następnym")
return	

o:: DeleteInterline("Usuń interlinię")
return

p:: ChangeLanguage()
return	

[:: BB_Insert("OstatniaStronaObrazek", "BB Obrazek na ostatniej stronie")
return	

]:: BB_Insert("OstatniaStrona", "BB: stopka na ostatniej stronie")
return	

;;------------------------4th ROW (13)--------------------------;;

F20:: AlignTableToPageBorder("CapsLock -to-> SC06B-F20, wyrównaj tabele do granicy tekstu na stronie") ; wyrównaj tabele do granicy tekstu na stronie pionowej, standardowe marginesy voestalpine, wyśrodkuj tabelę
return	

a::	MarkAllTableCells("Zaznacz całą tabelę")
return	

s:: TemplateStyle("Normalny w tabeli ms")
return	

d:: TemplateStyle("Tabela bez krawędzi ms") 
return	

f:: TemplateStyle("Wypunktowanie w tabeli ms")
	return	

g:: TemplateStyle("tabela ms") 
return	

h:: DeleteTableRow("Usuń wiersz tabeli")
return	

j:: DeleteTableColumn("Usuń kolumnę tabeli")
return	

k:: MergeTableCells("połącz zaznaczone komórki tabeli")
return	

l:: SeparateTableCell2xRow1xColumn("Podziel zaznaczoną komórkę tabeli: 2x wiersze, 1x kolumna")
return	

`;:: 
	;~ for the (semicolon) note that the ` is necessary as an escape character -- and that the syntax highlighting might get it wrong.
	SeparateTableCell1xRow2xColumn("Podziel zaznaczoną komórkę tabeli: 1x wiersz, 2x kolumna")
return	

':: 
TableCellColorVoestalpine("Kolor voestalpine wypełnienia komórki tabeli") ; kolor wypełnienia komórki tabeli 0 | 130 | 180
;~ TableBorderOff("Wyłącz określone ramki")
return	

Enter:: TableRowsAllowBreakAcrossPages("Zezwalaj na dzielenie wierszy tabeli między stronami")
return	

;;------------------------5th ROW (12)--------------------------;;

SC070:: GoToPreviousComment("Przejdź do wcześniejszego komentarza") ; LShift
return	

z:: VersionAndAdjustation(OriginalOrFinal := "Original", AdditionalText := "")
return	

x:: VersionAndAdjustation(OriginalOrFinal := "Final", AdditionalText := "")
return	

;~ to może być przełącznik PL/EN
c:: 
	DeleteCurrentComment("usuń komentarz")
return	

v:: 
	REpeatTableHeader("Powtórz wiersze nagłówka")
return	

b:: AlignTableCellConntentToMiddle("Wyrównanie treści komórki do środka i do środka w pionie")
return	

n:: AlignTableCellConntentToLeft("Wyrównanie treści komórki do lewej i do środka w pionie")	
return	

m:: InsertColumnToTheRight("Wstaw kolumnę tabeli z prawej") ; wstaw kolumnę tabeli z prawej
return	

,:: InsertTableRowAbove("Tabela: Wstaw 1x wiersz powyżej") ; tabela: Wstaw wiersz powyżej
return	

.:: InsertTableRowBelow("Tabela: Wstaw 1x wiersz poniżej") ; tabela: Wstaw wiersz poniżej
return	

/:: InsertColumnToTheLeft("Wstaw kolumnę tabeli z lewej") ; wstaw kolumnę tabeli z lewej 
return	

SC07D:: GoToNextComment("Przejdź do późniejszego komentarza") ; RShift
return	


;;--------------------6th ROW (5)----------------------;;

;; The following assignment MUST use the UP stroke - the down stroke doesn't appear for some reason.
SC071 up:: PreviousChangeOrComment("LCtrl: Poprzednia zmiana lub komentarz")
return	

;; The following assignment MUST use the UP stroke - the down stroke doesn't appear for some reason. LAlt
SC073 up:: RejectChange("LAlt: Odrzuć zmianę")
return

space:: EditComment("Wchodzi w dymek komentarza i umożliwia edycję")
return	

SC077:: AcceptChange("RAlt: Zaakceptuj zmianę") ; RAlt
return

SC07B:: NextChangeOrComment("RCtrl: Następna zmiana lub komentarz") ; RCtrl
return	

;~ Nie mam takich klawiszy na klawiaturze mechanicznej:
;~ LWin:    SC072 up::tooltip, [F24] LWin -to-> SC072-Language 1
;~ RWin:    SC078::tooltip, [F24] RWin -to-> SC078-Language 3
;~ AppsKey: SC079::tooltip, [F24] AppsKey -to-> SC079-International 4


;;================= NAV(IGATION) PANEL (13)================================================;;

PrintScreen:: PrintToPdf("Drukuj do .pdf")
return	

ScrollLock:: 
	FormatObjectPane()
return	

SC07E:: ToggleSelectionAndVisibilityPane("Włącz wyłącz okienko podglądu elementów graficznych")
return	

Insert:: Group("Zgrupuj obiekty graficzne")
return	

Home:: RotateRight90("Obróć obiekt o 90 stopni w prawo")
return	

PgUp:: FlipVertically("Przerzuć w pionie")
return	

Delete:: Ungroup("Rozgrupuj obiekty graficzne")
return	

End:: RotateLeft90("Obróć obiekt o 90 stopni w lewo")
return	

up:: MoveVectorObject(Direction := "Up", "obiekt rysunkowy w górę")
return	

down:: MoveVectorObject(Direction := "Down", "obiekt rysunkowy w dół")
return	

left:: MoveVectorObject(Direction := "Left", "obiekt rysunkowy w dół")
return	

right:: MoveVectorObject(Direction := "Right", "obiekt rysunkowy w dół")
return	

;;================= NUMPAD SECTION (17)================================================;;

SC05C:: ; NumLock
	Base("NUMLOCK")
return

;;=========== THE NUMPAD WITH NUMLOCK ON (at primary keyboard) ==============;;
;;; -- (I never turn numlock off, FYI.) -- ;;
;;Please note that SHIFT will make numlock act like it's off...
;;or is it the other way around? AGH! Just don't use shift with the numpad!

Numpad7:: 
	Base("NUMLOCK is on")
return	

Numpad8:: 
	Base("NUMLOCK is on")
return	

Numpad9:: 
	Base("NUMLOCK is on")
return	

Numpad4:: 
	Base("NUMLOCK is on")
return	

Numpad5:: 
	Base("NUMLOCK is on")
return	

Numpad6:: 
	Base("NUMLOCK is on")
return	

Numpad1:: 
	Base("NUMLOCK is on")
return	

Numpad2:: 
	Base("NUMLOCK is on")
return	

Numpad3:: 
	Base("NUMLOCK is on")
return	

Numpad0:: 
	Base("NUMLOCK is on")
return	

NumpadDot:: 
	Base("NUMLOCK is on")
return	


;;============ THE NUMPAD WITH NUMLOCK OFF (at primary keyboard) ============;;

NumpadHome:: 
	TemplateStyle("Pola tekstowe ms")
return

NumpadUp:: 
	TemplateStyle("ListaSeq 2 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnewlist", "NUMLOCK is off")
return	

NumpadPgUp:: 
	TemplateStyle("ListaSeq 2 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnextlist", "NUMLOCK is off")
return	


NumpadLeft::
Base("Włącz nagłówek/stopkę")
if (varhf = 1)
	Footer()
else
	Header()
return
	;~ wejście
	;~ ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
	;~ wyjście
    ;~ ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument



NumpadClear:: 
	TemplateStyle("ListaSeq 3 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnnewlist", "NUMLOCK is off")
return	

NumpadRight:: 
	TemplateStyle("ListaSeq 3 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnnextlist", "NUMLOCK is off")
return	

NumpadEnd:: 
ShowHiddenText("Włącz/wyłącz tekst ukryty")
return	

NumpadDown:: 
	TemplateStyle("ListaSeq 4 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnnnewlist", "NUMLOCK is off")
return	

NumpadPgDn:: 
	TemplateStyle("ListaSeq 4 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nnnnextlist", "NUMLOCK is off")
return	

NumpadIns:: BB_Insert("nextnumlist", "NUMLOCK is off")
return	

NumpadDel:: 
	BB_Insert("newnumlist", "NUMLOCK is off")
return

;;====== NUMPAD KEYS THAT DON'T CARE ABOUT NUMLOCK =====;;
;;NumLock::tooltip, DO NOT USE THE NUMLOCK KEY IN YOUR 2ND KEYBOARD! I have replaced it with SC05C-International 6
NumpadDiv:: 
	HorizontalLine("Wstawienie poziomej linii prostej na aktualnie zaznaczonej kanwie")
return	

NumpadMult:: 
	TextBoxWithStyleVerticallyAligned(True, "Pole tekstowe bez ramki, ze stylem, wyrownane w pionie") 
return	

NumpadSub:: 
	TextBoxWithStyleVerticallyAligned(False, "Pole tekstowe bez ramki, ze stylem, wyrownane w pionie") 
return	

NumpadAdd:: 
	TemplateStyle("ListaSeq 1 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("newlist", "NUMLOCK is off")
return	

NumpadEnter:: 
	TemplateStyle("ListaSeq 1 ms")
	MoveCursorToBeginningOfParagraph()
	BB_Insert("nextlist", "NUMLOCK is off")
return	

#if ; this line will end the F24 secondary keyboard assignments.
;;============== END OF ALL Microsoft Word KEYBOARD KEYS =============================;;
#if (getKeyState("F24", "P")) ; Rozwiązanie, żeby poprawnie otwierały i zamykały się okna z nagłówkami
F24:: return

7:: ; Dedicated window: Enter no. of header
InsertRef("number")
return	

8:: ; Dedicated window: Enter teks of header
InsertRef("text")
return	

9:: ; Dedicated window: Enter number of numbered paragraph
InsertRef("enum")
return	

0:: ; Dedicated window: Enter text of Bookmark
InsertRef("bookmark")
return

#if

;;============= BEGINNING OF SVN & Total Commander =========================;;

#if (getKeyState("F24", "P")) and WinActive("ahk_class TTOTAL_CMD") ; <--Everything after this line will only happen on the secondary keyboard that uses F24 AND in Total Commander.
F24:: return 					; this line is mandatory for proper functionality

;;------------------------1st ROW OF KEYS------------------;;
;;------------------------2nd ROW--------------------------;;
;;------------------------3rd ROW--------------------------;;
;;------------------------4th ROW--------------------------;;
;;------------------------5th ROW--------------------------;;
;;------------------------6th ROW--------------------------;;

SC071 up:: ; LCtrl
	Base("SVN Commit")
	Send, {AppsKey}
	Send, {c down}{c up}
	Send, {Enter}
return

SC073 up:: ; LAlt
	Base("SVN Show log")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {l down}{l up}
return

Space::
	Base("SVN Update")
	Send, {AppsKey}
	Send, {u 3} ; u x3
	Send, {Enter}
return

SC077:: ; RAlt
	Base("SVN Get lock")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {k down}{k up}
	Send, {Enter}
return

SC07B:: ; RCtrl
	Base("SVN Check lock")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {r down}{r up}
return	

;;----------------- CURSORS -------------------------------------------------------	;;

up::
	Base("SVN Add")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {a down}{a up}
return	

left:: 
	Base("SVN Clean up")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {c down}{c up}
	Send, {Enter}
return	

down:: 
	Base("SVN Rename")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {n down}{n up}
return	

right:: 
	Base("SVN Delete")
	Send, {AppsKey}
	Send, {t down}{t up}
	Send, {d down}{d up}
return	

#if ; this line will end the F24 secondary keyboard assignments.
;;============= END OF SVN & Total Commander ===========================;;



;;*******************************************************************************
;;*************DEFINE YOUR NORMAL KEY ASSIGNMENTS BELOW THIS LINE****************
;;*******************************************************************************

#if  WinActive(, "Microsoft Word") ; <--Everything after this line will only happen in Microsoft Word.

+^h:: ; Shift + Ctrl + H - hide text; there is dedicated style to do that
	
	try
		{
		TemplateStyle("Ukryty ms")
		}
		catch e
		{
		MsgBox, 48, Zostanie ukryty tekst bez zastosowania dedykowanego stylu z szablonu.
		
		}
;~ Selection.MoveRight Unit:=wdWord, Count:=5, Extend:=wdExtend
    ;~ With Selection.Font
        ;~ .Hidden = True
    ;~ End With
return

+^x:: ; Shift + Ctrl + X - strike through the selected text 
	StrikeThroughText()
return

^l:: ; Ctrl + L - delete a whole line of text, see https://superuser.com/questions/298963/microsoft-word-2010-assigning-a-keyboard-shortcut-for-deleting-one-line-of-text
	DeleteLineOfText()
return

+^l:: ; Shift + Ctrl + L - align text of paragraph to left
	Send, ^l
return

+^s:: ; Shift + Ctrl + S - toggle Apply Styles pane
	ToggleApplyStylesPane()
return

^o:: ; Ctrl + O - adds full path to a document in window bar
	FullPath() ; to do: call this function whenever document was saved with a filename.
	Send, ^{o down}{o up}
return

;~ #IfWinActive ahk_class OpusApp 
^p::
	MsgBox, 48, Zanim wydrukujesz..., 1. Wykonaj makro`, które wstawi twardą spację po etykietach tabel i rysunków.`n2. Odświerz zawartość całego dokumentu (Ctrl + F9).`n3. Zamień wszystkie odsyłacze na łącza.`n4. Ponownie odświerz zawartość całego dokumentu (Ctrl + F9).`n5. Poszukaj słowa "Błąd".
	Send, ^{p down}{p up}
return 
;~ #IfWinActive

;~ #IfWinActive ahk_class OpusApp 
F12::
	MsgBox, 48, Zanim wydrukujesz..., 
( Join	
1. Wykonaj makro, które wstawi twardą spację po etykietach tabel i rysunków.`n
2. Odświerz zawartość całego dokumentu (Ctrl + F9).`n
3. Zamień wszystkie odsyłacze na łącza.`n
4. Ponownie odświerz zawartość całego dokumentu (Ctrl + F9).`n
5. Poszukaj słowa "Błąd".
)
	Send, {F12 down}{F12 up}
return 
;~ #IfWinActive

#3::
Switching()
return

#if ; this line will end the Word only keyboard assignments.

<!^q::
if (flag_as = 0)
{
	SetTimer, AutoSave, Off
	MsgBox, Autozapis został wyłączony!
	flag_as := 1
}
else if (flag_as = 1)
{
	SetTimer, AutoSave, On
	MsgBox, Autozapis został ponownie włączony!
	flag_as := 0
}
return

SC079:: ; Menu key
Send, +{F10}
return

; --------------------------------------------------------------------------------------------
; ----------------------- SEKCJA FUNKCJI -----------------------------------------------------
; --------------------------------------------------------------------------------------------

ToggleApplyStylesPane() ; 2019-10-03
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	ApplyStylesTaskPane := oWord.CommandBars("Apply styles").Visible
	If (ApplyStylesTaskPane = -1)
		oWord.CommandBars("Apply styles").Visible := 0
	Else If (ApplyStylesTaskPane = 0)
		oWord.Application.TaskPanes(17).Visible := -1
	oWord := ""
	}


DeleteLineOfText() ; 2019-10-03
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	oWord.Selection.HomeKey(Unit := wdLine := 5)
	oWord.Selection.EndKey(Unit := wdLine := 5, Extend := wdExtend := 1)
	oWord.Selection.Delete(Unit := wdCharacter := 1, Count := 1)
	oWord :=  "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

StrikeThroughText() ; 2019-10-03
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Font.StrikeThrough := wdToggle := 9999998 
	oWord :=  "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MoveCursorToBeginningOfParagraph()
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	oWord.Selection.MoveRight(Unit := wdCharacter := 1, Count:=1)
	oWord.Selection.MoveUp(Unit := wdParagraph := 4, Count:=1)
	oWord :=  "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

BB_Insert(Name_BB, AdditionalText)
	{
	global 

	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
		{
		MsgBox, 16, Próba wywołania stylu z szablonu, 
		( Join
		 Próbujesz wstawić blok konstrukcyjny przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku. 
 Najpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.
		)
		}
	else
		{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries(Name_BB).Insert(oWord.Selection.Range, WordTrue)
		}
	oWord :=  "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

TemplateStyle(StyleName)
	{
	global OurTemplateEN, OurTemplatePL, oWord
	
	Base(StyleName)
	oWord := ComObjActive("Word.Application")
	;~ SoundBeep, 750, 500 ; to fajnie działa
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
		{
		;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
		MsgBox, 16, Próba wywołania stylu z szablonu, 
		( Join
		 Próbujesz wywołać styl przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku. 
 Najpierw dolacz szablon, a następnie wywołaj ponownie tę funkcję.
		)
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	else
		{
		oWord.Selection.Style := StyleName
		oWord := "" ; Clear global COM objects when done with them
		return
		}
	}

; -----------------------------------------------------------------------------------------------------------------------------
Base(AdditionalText := "")
	{
	tooltip, [F24]  %A_thishotKey% %AdditionalText%
	SetTimer, SwitchOffTooltip, -5000
	return
	}

; -----------------------------------------------------------------------------------------------------------------------------

TextBoxWithStyleVerticallyAligned(IfFrame, AdditionalText)
	{
	global WordTrue, WordFalse
	global oWord
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ShapeRange.CanvasItems.AddTextBox(Orientation := msoTextOrientationHorizontal := 1, Left := 50, Top := 50, Width := 75, Height := 25).Select
	if (IfFrame) 
		{
		oWord.Selection.ChildShapeRange.Line.Visible := WordTrue
		}
	else
		{
		oWord.Selection.ChildShapeRange.Line.Visible := WordFalse
		}
	oWord.Selection.ChildShapeRange.Fill.Visible := WordFalse
	oWord.Selection.ChildShapeRange.TextFrame.VerticalAnchor := msoAnchorMiddle := 3
	oWord.Selection.TypeText("Fikumiku")
	oWord.Selection.StartOf(Unit := wdLine := 5, Extend := wdExtend := 1)
	oWord.Selection.Style := "Pola tekstowe ms"
	oWord := "" ; Clear global COM objects when done with them
	}	

; -----------------------------------------------------------------------------------------------------------------------------

HorizontalLine(AdditionalText := "")
	{
	global oWord
	
	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ShapeRange.CanvasItems.AddLine(BeginX := 50, BeginY := 50, EndX := 100, EndY:= 50).Select
	oWord.Selection.ChildShapeRange.Line.Weight := 1
	oWord.Selection.ChildShapeRange.Line.ForeColor.RGB := 0x000000 ; .RGB(0, 0, 0) czyli czarny
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

FlipVertically(AdditionalText := "")
	{
	global oWord
	
	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Flip(msoFlipVertical := 1) ; MsoFlipCmd 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

FlipHorizontally(AdditionalText := "")
	{
	global oWord
	
	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Flip(msoFlipHorizontal := 0) ; MsoFlipCmd 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

RotateLeft90(AdditionalText := "")
	{
	global oWord
	
	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementRotation(-90) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

RotateRight90(AdditionalText := "")
	{
	global oWord
	
	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.IncrementRotation(+90) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

Group(AdditionalText := "")
	{
	global oWord

	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Group
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

Ungroup(AdditionalText := "")
	{
	global oWord

	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ChildShapeRange.Ungroup
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

PrintToPdf(AdditionalText := "")
	{
	global WordTrue, WordFalse
	global oWord, OutputPDFfilePath
	
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	;~ String := oWord.ActiveDocument.Name
	;~ StringTrimRight, OutputFileName, String, 5
	;~ OutputFileName := OutputPDFfilePath . OutputFileName . ".pdf"
	;~ ExportFormat := wdExportFormatPDF := 17
	;~ OpenAfterExport := WordFalse
	;~ OptimizeFor := wdExportOptimizeForPrint := 0
	;~ Range := wdExportAllDocument := 0
	;~ From := 1
	;~ To := 1
	;~ Item := wdExportDocumentContent := 0
	;~ IncludeDocProps := WordFalse
	;~ KeepIRM := WordTrue
	;~ CreateBookmarks := wdExportCreateHeadingBookmarks := 1
	;~ DocStructureTags := WordFalse
	;~ BitmapMissingFonts := WordTrue
	;~ UseISO19005_1 := WordFalse
	;~ oWord.ActiveDocument.ExportAsFixedFormat(OutputFileName, ExportFormat, OpenAfterExport, OptimizeFor, Range, From, To, Item, IncludeDocProps, KeepIRM, CreateBookmarks, DocStructureTags, BitmapMissingFonts, UseISO19005_1)
	Send, {LAlt}
	Send, {y}
	Send, {3}
	Send, {c}
	;~ MsgBox, 64, Zapisałem .pdf, % "Zapisałem .pdf:`n" OutputFileName
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

ShowClipboard(AdditionalText := "")
	{
	global oWord

	Base(AdditionalText) 
	oWord := ComObjActive("Word.Application")
	oWord.Application.ShowClipboard
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

WatermarkDRAFT(AdditionalText := "")
;~ https://autohotkey.com/board/topic/115939-how-to-insert-a-watermark-into-an-open-word-doc-via-com/ 
;~ działa równie źle, co makro napisane przez AG -> krzywo wstawia napis w kolejnych sekcjach, ale to już temat na osobne dociekania
	{
	global oWord, WordFalse, WordTrue
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
		Loop % oWord.ActiveDocument.Sections.Count
		{
		oWord.ActiveDocument.Sections(A_Index).Range.Select
		oWord.ActiveWindow.ActivePane.View.SeekView := wdSeekCurrentPageHeader := 9
		oWord.Selection.HeaderFooter.Shapes.AddTextEffect(0, "DRAFT", "Calibri", 200, WordFalse, WordFalse, 0, 0).Select 
		;~ Function AddTextEffect(PresetTextEffect As MsoPresetTextEffect, Text As String, FontName As String, FontSize As Single, FontBold As MsoTriState, FontItalic As MsoTriState, Left As Single, Top As Single) As Shape
		;~ Const msoTextEffect1 = 0
		oWord.Selection.ShapeRange.TextEffect.NormalizedHeight := WordFalse
		oWord.Selection.ShapeRange.Line.Visible := WordFalse
		oWord.Selection.ShapeRange.Fill.Visible := WordTrue
		oWord.Selection.ShapeRange.Fill.Solid
		oWord.Selection.ShapeRange.Fill.ForeColor := 0xD9D9D9 ; .RGB(217, 217, 217)
		oWord.Selection.ShapeRange.Fill.Transparency := 0,5 ; niestety tu musi być przecinek zamiast kropki, inaczej nie działa. Wątek na forum: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63129&p=270001#p270001
		oWord.Selection.ShapeRange.Rotation := 315
		oWord.Selection.ShapeRange.LockAspectRatio := WordTrue
		oWord.Selection.ShapeRange.Height.CentimetersToPoints(8.62)
		oWord.Selection.ShapeRange.Width.CentimetersToPoints(18.94)
		oWord.Selection.ShapeRange.WrapFormat.AllowOverlap := WordTrue
		oWord.Selection.ShapeRange.WrapFormat.Side := wdWrapNone := 3
		oWord.Selection.ShapeRange.WrapFormat.Type := 3
		oWord.Selection.ShapeRange.RelativeHorizontalPosition := wdRelativeVerticalPositionMargin := 0
		oWord.Selection.ShapeRange.RelativeVerticalPosition := wdRelativeVerticalPositionMargin := 0
		oWord.Selection.ShapeRange.Left := wdShapeCenter := -999995 
		oWord.Selection.ShapeRange.Top := wdShapeCenter := -999995
		oWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument := 0
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

SetTemplate(PLorEN := "", AdditionalText := "")
	{
	global oWord, WordTrue, WordFalse
	global OurTemplate, OurTemplatePL, OurTemplateEN
	
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	if (PLorEN = "PL")
		{
		if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplatePL)	
			{
			MsgBox, 64, Już ustawiłeś szablon, % "Już wcześniej został wybrany szablon " oWord.ActiveDocument.AttachedTemplate.FullName
			}
		else
			{
			oWord.ActiveDocument.AttachedTemplate := OurTemplatePL
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % "Dołączono szablon!`n Dołączono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			oWord := "" ; Clear global COM objects when done with them
			OurTemplate := OurTemplatePL
			}	
		}	
	if (PLorEN = "EN")
		{
		if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplateEN)		
			{
			MsgBox, 64, Już ustawiłeś szablon, % "Już wcześniej został wybrany szablon " oWord.ActiveDocument.AttachedTemplate.FullName	
			}
		else
			{
			oWord.ActiveDocument.AttachedTemplate := OurTemplateEN
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % "Dołączono szablon!`n Dołączono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			oWord := "" ; Clear global COM objects when done with them
			OurTemplate := OurTemplateEN
			}	
		}	
	}

; -----------------------------------------------------------------------------------------------------------------------------

ChangeZoom(AdditionalText := "")
	{
	global oWord
	static ZoomValue := 100
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	if (ZoomValue = 100) 
		{
		ZoomValue := 200
		oWord.ActiveWindow.ActivePane.View.Zoom.Percentage := ZoomValue
		}
	else
		{
		ZoomValue := 100
		oWord.ActiveWindow.ActivePane.View.Zoom.Percentage := ZoomValue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

NavigationPaneVisibility(AdditionalText := "")
	{
	global oWord, WordTrue, WordFalse
	static StateOfNavigationPane
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfNavigationPane := oWord.ActiveWindow.DocumentMap
;	MsgBox, % StateOfParagraph_KeepTogether ; debugging
	if (StateOfNavigationPane = WordTrue)
		{
		oWord.ActiveWindow.DocumentMap := WordFalse
		}
	else
		{
		oWord.ActiveWindow.DocumentMap := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleStylePane(AdditionalText := "")
	{
	global oWord, WordTrue, WordFalse
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfStylesPane := oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible
	if (StateOfStylesPane = WordTrue)
		{
		oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := WordFalse
		}
	else
		{
		oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := WordTrue
		}	
	oWord := "" ; Clear global COM objects when done with them
	}
	
; -----------------------------------------------------------------------------------------------------------------------------

DeleteCurrentComment(AdditionalText := "") ; usuń aktualnie wybrany komentarz
	{
	global 
	local e
	;~ global oWord, cursorPosition
	
	Base(AdditionalText)
	try
		{
		oWord := ComObjActive("Word.Application")
		oWord.Selection.Comments(1).Delete
		cursorPosition.Select
		oWord := "" ; Clear global COM objects when done with them
		}
		catch e
		{
		MsgBox, 48, Usuwanie komentarza, By usunać komentarz musisz go najpierw wyedytować (Edytuj komentarz).
		}
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertColumnToTheRight(AdditionalText := "") ; wstaw kolumnę tabeli z prawej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumnsRight 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertColumnToTheLeft(AdditionalText := "") ; wstaw kolumnę tabeli z lewej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumns
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

AlignTableCellConntentToMiddle(AdditionalText := "") ; Wyrównanie treści komórki do środka i do środka w pionie
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.SelectCell
	oWord.Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter := 1
	oWord.Selection.Cells.VerticalAlignment := wdCellAlignVerticalCenter := 1
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

AlignTableCellConntentToLeft(AdditionalText := "") ; Wyrównanie treści komórki do lewej i do środka w pionie
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.SelectCell
	oWord.Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft := 0
	oWord.Selection.Cells.VerticalAlignment := wdCellAlignVerticalCenter := 1
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

VersionAndAdjustation(OriginalOrFinal, AdditionalText := "") 
	{
	global oWord, WordTrue, WordFalse	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfOriginalAdjustation := oWord.ActiveWindow.View.ShowRevisionsAndComments
	if (StateOfOriginalAdjustation = WordTrue)
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := WordFalse
		}
	else
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := WordTrue
		}
	if (OriginalOrFinal = "Original")
		{
		oWord.ActiveWindow.View.RevisionsView := wdRevisionsViewOriginal := 1
		}
	if (OriginalOrFinal = "Final")
		{
		oWord.ActiveWindow.View.RevisionsView := wdRevisionsViewFinal := 0	
		}	
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertTableRowAbove(AdditionalText := "") ; tabela: Wstaw wiersz powyżej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsAbove(1)
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertTableRowBelow(AdditionalText := "") ; tabela: Wstaw wiersz powyżej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsBelow(1)
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

GoToPreviousComment(AdditionalText := "") ; Przejdź do wcześniejszego komentarza
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Previous
	oWord := ""
	}
	
; -----------------------------------------------------------------------------------------------------------------------------

GoToNextComment(AdditionalText := "") ; Przejdź do kolejnego komentarza
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Next 
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

DeleteTableRow(AdditionalText := "") ; Usuń wiersz tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Rows.Delete 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

DeleteTableColumn(AdditionalText := "") ; Usuń kolumnę tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Columns.Delete 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MoveVectorObject(Direction, AdditionalText := "") ; przemieść obiekt rysunkowy we wskazanym kierunku o 25 px
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	if (Direction = "Up")
		{
		oWord.Selection.ChildShapeRange.IncrementTop(-25)
		}
	if (Direction = "Down")
		{
		oWord.Selection.ChildShapeRange.IncrementTop(25)	
		}
	if (Direction = "Left")
		{	
		oWord.Selection.ChildShapeRange.IncrementLeft(-25)
		}
		if (Direction = "Right")
		{	
		oWord.Selection.ChildShapeRange.IncrementLeft(25)	
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MarkAllTableCells(AdditionalText := "") ; zaznacz całą tabelę
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Tables(1).Select
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MergeTableCells(AdditionalText := "") ; połącz zaznaczone komórki tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Merge 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

SeparateTableCell2xRow1xColumn(AdditionalText := "") ; Podziel zaznaczoną komórkę tabeli: 2x wiersze, 1x kolumna
	{
	global oWord	
		
	Base(AdditionalText)
	;~ Selection.Cells.Split NumRows:=2, NumColumns:=1, MergeBeforeSplit:=False
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(2, 1) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

SeparateTableCell1xRow2xColumn(AdditionalText := "") ; Podziel zaznaczoną komórkę tabeli: 1x wiersz, 2x kolumna
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(1, 2) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleFormattingPane(AdditionalText := "") ; przełącz "Panel formatowanie"
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfFormattingPane := oWord.Application.TaskPanes(1).Visible
	if (StateOfFormattingPane = WordTrue)
		{
		oWord.Application.TaskPanes(1).Visible :=  WordFalse 
		}
	else
		{
		oWord.Application.TaskPanes(1).Visible := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleRuler(AdditionalText := "") ; przełącz linijkę
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfRuler := oWord.ActiveWindow.ActivePane.DisplayRulers
	if (StateOfRuler = WordTrue)
		{
		oWord.ActiveWindow.ActivePane.DisplayRulers := WordFalse
		}
	else
		{
		oWord.ActiveWindow.ActivePane.DisplayRulers := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ParagraphLinesKeepTogether(AdditionalText := "") ; Akapit: Zachowaj wiersze razem
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_KeepTogether := oWord.Selection.ParagraphFormat.KeepTogether
;	MsgBox, % StateOfParagraph_KeepTogether ; debugging
	if (StateOfParagraph_KeepTogether = WordTrue)
		{
		oWord.Selection.ParagraphFormat.KeepTogether := WordFalse
		}
	else
		{
		oWord.Selection.ParagraphFormat.KeepTogether := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ParagraphPageBreakBefore(AdditionalText := "") ; Akapit: Podział strony przed
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_PageBreakBefore := oWord.Selection.ParagraphFormat.PageBreakBefore
;	MsgBox, % StateOfParagraph_PageBreakBefore ; debugging
	if (StateOfParagraph_PageBreakBefore = WordTrue)
		{
		oWord.Selection.ParagraphFormat.PageBreakBefore := WordFalse
		}
	else
		{
		oWord.Selection.ParagraphFormat.PageBreakBefore := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with themreturn	
	}

; -----------------------------------------------------------------------------------------------------------------------------

ParagraphFormatKeepWithNext(AdditionalText := "") ; Akapit: Razem z następnym
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfParagraph_KeepWithNext := oWord.Selection.ParagraphFormat.KeepWithNext
;	MsgBox, % StateOfParagraph_KeepWithNext ; debugging
	if (StateOfParagraph_KeepWithNext = WordTrue)
		{
		oWord.Selection.ParagraphFormat.KeepWithNext := WordFalse
		}
	else
		{
		oWord.Selection.ParagraphFormat.KeepWithNext := WordTrue
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

TableBorderOff(AdditionalText := "") ; na potrzeby raportu z weryfikacji
	{
	global oWord
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")

	oWord.Selection.Borders(wdBorderLeft := -2).LineStyle := wdLineStyleNone := 0
    oWord.Selection.Borders(wdBorderRight := -4).LineStyle := wdLineStyleNone := 0
    oWord.Selection.Borders(wdBorderVertical := -6).LineStyle := wdLineStyleNone := 0

	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

TableCellColorVoestalpine(AdditionalText := "") ; kolor wypełnienia komórki tabeli 0 | 130 | 180
	{
	global oWord
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Shading.BackgroundPatternColor := 11829760
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

TableRowsAllowBreakAcrossPages(AdditionalText := "") ; zezwalaj na dzielenie wierszy między stronami
	{
	global oWord, WordTrue, WordFalse
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	StateOfBreakAcrossPages := oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages
	if (StateOfBreakAcrossPages = WordTrue)
		{
		oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages := WordFalse 
		}
	else
		{
		oWord.Selection.Tables(1).Rows.AllowBreakAcrossPages := WordTrue 
		}
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

RejectChange(AdditionalText := "") ; odrzuć zmianę
	{
	global oWord
	
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.RejectAll ; Odrzuć zmianę
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

AcceptChange(AdditionalText := "") ; zaakceptuj zmianę
	{
	global oWord

	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.AcceptAll ; Zaakceptuj zmianę
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

EditComment(AdditionalText := "") ; edytuj komentarz
	{
	;~ global oWord, cursorPosition
	global 
	local e
	
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	try
	{
		cursorPosition := oWord.Selection.Range
		oWord.WordBasic.AnnotationEdit
	}
	catch e
	{
		MsgBox, 48,, Aby edytować komentarz, musisz umieścić kursor w obrębie tekstu, którego komentarz dotyczy.
	}
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleSelectionAndVisibilityPane(AdditionalText := "") ; włącz / wyłącz panel edycji obiektów graficznych
	{
	global oWord, WordTrue, WordFalse
;~ https://docs.microsoft.com/en-us/office/vba/api/word.global.commandbars
;~ http://www.vbaexpress.com/forum/forumdisplay.php?20-Word-Help
;~ https://wordribbon.tips.net/T008342_Using_the_Selection_and_Visibility_Pane.html
;~ https://docs.microsoft.com/pl-pl/office/vba/api/office.commandbar.enabled
;~ z nieznanych przyczyn to nie działa za pierwszym razem - przed pierwszym wyświetleniem "Selection and Visibility" pane. Pierwsze wyświetlenie trzeba zrobić ręcznie.
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	
	StateOfSelectionPane := oWord.CommandBars.ExecuteMso("SelectionPane").Visible
	if (StateOfSelectionPane = WordTrue)
		{
		oWord.CommandBars("SelectionPane").Visible := WordFalse
		}
	else
		{
		oWord.CommandBars.GetPressedMso("SelectionPane")
		}	
	oWord := "" ; Clear global COM objects when done with them
	}
	
; -----------------------------------------------------------------------------------------------------------------------------

NextChangeOrComment(AdditionalText := "") ; następna zmiana lub komentarz
;~ by Jakub Masiak
{
	global oWord
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	try
		oWord.WordBasic.NextChangeOrComment
	oWord := ""
}
	
; -----------------------------------------------------------------------------------------------------------------------------

PreviousChangeOrComment(AdditionalText := "") ; poprzednia zmiana lub komentarz
;~ by Jakub Masiak
{
	global oWord
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	try
		oWord.WordBasic.PreviousChangeOrComment
	oWord := ""
}
	
; -----------------------------------------------------------------------------------------------------------------------------

AlignTableToPageBorder(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord, WordTrue, WordFalse
	wdWithInTable := 12 ; WdInformation enumeration: wdWithInTable = 12 Returns True if the selection is in a table.
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")

	if (oWord.Selection.Information(wdWithInTable) = WordTrue) 
		{
		oWord.Selection.Tables(1).PreferredWidthType := wdPreferredWidthPoints := 3 
		oWord.Selection.Tables(1).PreferredWidth := oWord.Selection.PageSetup.PageWidth - (oWord.Selection.PageSetup.LeftMargin + oWord.Selection.PageSetup.RightMargin + oWord.Selection.PageSetup.Gutter)
		oWord.Selection.Tables(1).Rows.Alignment := wdAlignRowCenter := 1 
		}
	oWord := "" ; Clear global COM objects when done with them
}
; -----------------------------------------------------------------------------------------------------------------------------

DeleteInterline(AdditionalText := "") ; usuwa interlinię u góry strony (przerwę poprzedzającą ustawia na zero pkt; przywrócenie domyślnego formatowania akapitu: Ctrl + q)
;~ by Jakub Masiak
{
	global oWord
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	varInter := oWord.Selection.ParagraphFormat.SpaceBefore
	if (varInter = 48)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 0
		}
	else if (varInter = 0)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 48
		}
	oWord := "" ; Clear global COM objects when done with them
}
; -----------------------------------------------------------------------------------------------------------------------------

RepeatTableHeader(AdditionalText := "") ; powtórz wiersz nagłówka tabeli
;~ by Jakub Masiak
{
	global oWord
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	if (oWord.Selection.Information(12) = -1)
		oWord.Selection.Rows.HeadingFormat := 9999998
	oWord := ""
}
	
; -----------------------------------------------------------------------------------------------------------------------------
FormatObjectPane(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord, WordTrue, WordFalse
	Base(AdditionalText)
    oWord := ComObjActive("Word.Application")
	type := oWord.Selection.Type
	state := oWord.CommandBars("Format Object").Visible
	if (state = WordFalse and (type = 7 or type = 8))
		oWord.CommandBars.ExecuteMso("ObjectFormatDialog").Enabled
	else
		oWord.CommandBars("Format Object").Visible := WordFalse
    oWord := ""
}

; -----------------------------------------------------------------------------------------------------------------------------
ChangeLanguage(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	Lang := oWord.Selection.LanguageID
	if (Lang = 2057 or Lang = 1033)
		oWord.Selection.LanguageID := 1045
	if (Lang = 1045)
		oWord.Selection.LanguageID := 2057
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------
DisplayGridLines(AdditionalText := "") ; włącz / wyłącz linie siatki
;~ by Jakub Masiak
{
	global oWord	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Options.DisplayGridLines := Not oWord.Options.DisplayGridLines
	oWord := ""
}

; -----------------------------------------------------------------------------------------------------------------------------
FullPath(AdditionalText := "") ; display full path to a file in window title bar 
;~ by Jakub Masiak
{
	global oWord
    Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
    oWord.ActiveWindow.Caption := oWord.ActiveDocument.FullName
    oWord := ""
}

; -----------------------------------------------------------------------------------------------------------------------------

Header() ; show header
;~ by Jakub Masiak
	{
	global
	oWord := ComObjActive("Word.Application")
	oWord.ActiveWindow.ActivePane.View.SeekView := 9
	SetTimer, HeaderFooter, 500
	varhf := 1
	oWord := ""
	}

Footer() ; show footer
;~ by Jakub Masiak
	{
	global
	oWord := ComObjActive("Word.Application")
	oWord.ActiveWindow.ActivePane.View.SeekView := 10
	varhf := 0
	oWord := ""
	}

HeaderFooter:
	varhf := 0
	SetTimer, HeaderFooter, Off
return

; -----------------------------------------------------------------------------------------------------------------------------
Switching()
;~ by Jakub Masiak
{
	global cntWnd, cntWnd2, id
	if cntWnd2 >= %cntWnd%
		cntWnd2 := 0
	varview := id[cntWnd2]
	WinActivate, ahk_id %varview%
	cntWnd2 := cntWnd2 + 1
	return
}
; -----------------------------------------------------------------------------------------------------------------------------
ShowHiddenText(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	HiddenTextState := oWord.ActiveWindow.View.ShowHiddenText
	if (oWord.ActiveWindow.View.ShowAll = -1)
	{
		oWord.ActiveWindow.View.ShowAll := 0
		oWord.ActiveWindow.View.ShowTabs := -1
		oWord.ActiveWindow.View.ShowSpaces := -1
		oWord.ActiveWindow.View.ShowParagraphs := -1
		oWord.ActiveWindow.View.ShowHyphens := -1
		oWord.ActiveWindow.View.ShowObjectAnchors := -1
	}
	if (HiddenTextState = 0)
		oWord.ActiveWindow.View.ShowHiddenText := -1
	else
		oWord.ActiveWindow.View.ShowHiddenText := 0
	oWord := ""
	return
}
; -----------------------------------------------------------------------------------------------------------------------------
InsertRef(fname)
;~ by Jakub Masiak
{
	global cntWnd, id, order
	if (flag_%fname% = 0){
		flag_%fname% := 1
		if fname = text
		{
			ins := 1
			out := -1
			name := "a"
			no := 0
		}
		else if fname = number
		{
			ins := 1
			out := -4
			name := "b"
			no := 1
		}
		else if fname = enum
		{
			ins := 0
			out := -4
			name := "c"
			no := 2
		}
		else if fname = bookmark
		{
			ins := 2
			out := -1
			name := "d"
			no := 3
		}
		if (out = -1)
			title := "tekst"
		else if (out = -4)
			title := "numer"
		else if (out = 7)
			title := "numer strony"
		if (ins = 0)
			type := "elementu listy numerowanej"
		else if (ins = 1)
			type := "nagłówka"
		else if (ins = 2)
			type := "zakładki"
		References(ins, out, name, flag_%fname%, title, type)
		cntWnd := cntWnd + 1
		order[no] := cntWnd - 1
		id[cntWnd-1] := WinExist("A")
	}
	else if (flag_%fname% = 1){
		flag_%fname% := 0
		if fname = text
		{
			ins := 1
			out := -1
			name := "a"
			no := 0
		}
		else if fname = number
		{
			ins := 1
			out := -4
			name := "b"
			no := 1
		}
		else if fname = enum
		{
			ins := 0
			out := -4
			name := "c"
			no := 2
		}
		else if fname = bookmark
		{
			ins := 2
			out := -1
			name := "d"
			no := 3
		}
		if (out = -1)
			title := "tekst"
		else if (out = -4)
			title := "numer"
		else if (out = 7)
			title := "numer strony"
		if (ins = 0)
			type := "elementu listy numerowanej"
		else if (ins = 1)
			type := "nagłówka"
		else if (ins = 2)
			type := "zakładki"
		WinGetPos, X%name%, Y%name%, W%name%, H%name%, Wstaw %title% %type%
		Gui, %name%:Destroy
		cntWnd := cntWnd - 1
		for k, v in id
		{
			if k > % order[no]
				id[k-1] := id[k]
		}
		id.Pop()
	}
	return
}
; -----------------------------------------------------------------------------------------------------------------------------
References(ins, out, name, ByRef flag, title, type) ; ins: 0 - Numbered Item, 1 - Heading, 2 - Bookmark (wdReferenceType); out: -1 - Context Text, -4 - Number Full Contex, 7 - Page Number (wdReferenceKind)
;~ by Jakub Masiak
{
	local vMyListBox
	static oWord
	try{
		oWord := ComObjActive("Word.Application")
	}
	catch e
	{	
		flag := 0
		return
	}
	in%name% := ins
	out%name% := out
	N := 2
	SysGet, Mon, MonitorWorkArea, %N%
	Var := 12
	if (flag_%name% = 0)
	{
		Y%name% := MonTop
		W%name% := (MonRight - MonLeft)/(Var/2)
		X%name% := MonRight -  W%name%
		H%name% := MonBottom - (MonTop + 5*Var/2)
		flag_%name% := 1
	}
	else
	{
		H%name% := H%name%-39
		W%name% := W%name%-16
	}
	X := X%name%
	Y := Y%name%
	H := H%name%
	W := W%name%
	Hlb := H -  Var
	Wlb := W - 2 * Var
	Gui, %name%:New, +Resize
	Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBox gMyListBox +AltSubmit
	myHeadings := oWord.ActiveDocument.GetCrossReferenceItems(in%name%)
	Loop, % myHeadings.MaxIndex()
	{
		GuiControl,, MyListBox, % myHeadings[A_Index]
	}
	Gui, %name%:Add, Button, Hidden Default gOK,OK
	Gui, %name%:Show,X%X% Y%Y% H%H% W%W%, Wstaw %title% %type%
	return
		
MyListBox:
	if (A_GuiEvent != "DoubleClick")
		return
			
OK:
	IfWinActive, Wstaw tekst nagłówka
		name := "a"
	IfWinActive, Wstaw numer nagłówka
		name := "b"
	IfWinActive, Wstaw numer elementu listy numerowanej
		name := "c"
	IfWinActive, Wstaw tekst zakładki
		name := "d"
	try
	{
		Gui, Submit, Nohide
		Index := MyListBox
		if (name = "d")
		{
			bookmark := myHeadings[Index]
			oWord.Selection.InsertCrossReference(in%name%, out%name%, bookmark, 0, 0, 0, " ")
		}
		else
			oWord.Selection.InsertCrossReference(in%name%, out%name%, Index, 1, 0, 0, " ")
	}
	return	
}
aGuiEscape:
aGuiClose:
	InsertRef("text")
return
bGuiEscape:
bGuiClose:
	InsertRef("number")
return
cGuiEscape:
cGuiClose:
	InsertRef("enum")
return
dGuiEscape:
dGuiClose:
	InsertRef("bookmark")
return

; ==================================== DEMOBIL =======================================================
; Additional space for functions which used to be useful

;~ TemplateStyle("Lista 1 ms") 
;~ TemplateStyle("Lista 2 ms") 
;~ TemplateStyle("Lista 3 ms") 
;~ TemplateStyle("Lista 4 ms") 
;~ TemplateStyle("Ukryty ms") 
;~ ShowHiddenText()

; ---------------------- SEKCJA ETYKIET ------------------------------------

SwitchOffTooltip:
	ToolTip ,
return
AutoSave:
{
	init := InitAutosaveFilePath(AutosaveFilePath)
	
	if WinExist("ahk_class OpusApp")
		oWord := ComObjActive("Word.Application")
		
	else
		return
	try
	{
		Loop, % oWord.Documents.Count
		{
			doc := oWord.Documents(A_Index)
			path := doc.Path
			if (path = "")
				return
			fullname := doc.FullName
			
			SplitPath, fullname, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
			doc.Save
			FileGetSize, size_org, % fullname
			size := table[fullname]
			if (size_org != size)
			{
				FormatTime, TimeString, , yyyyMMddHHmmss
				copyname := % AutosaveFilePath . OutNameNoExt . "_" . TimeString . "." . OutExtension
				FileCopy, % fullname, % copyname
				FileGetSize, size, % copyname
				table[fullname] := size
			}
			
		}
	}
	catch
	{
		; try again in 5 seconds
		SetTimer, AutoSave, 5000
		return
	}
	; reset the timer in case it was changed by catch
	SetTimer, AutoSave, % interval
	oWord := ""
	doc := ""
	return
}

InitAutosaveFilePath(path)
{
	if !FileExist(path)
		FileCreateDir, % path
	return true
}
