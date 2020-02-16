;~ Ta wersja powsta³a z QMK_F24_macro_keyboard.ahk 
;~ WHERE TO LOOK FOR HELP:
;~ Taran VH: 					https://youtu.be/GZEoss4XIgc
;~ Taran Github: 				https://github.com/TaranVH/2nd-keyboard/
;~ Tool for AHK:				http://fincs.ahk4.net/scite4ahk/
;~ COM help:					https://docs.microsoft.com/en-us/office/vba/api/word.application
;~ Here is the full list of scan code substitutions that I made:
;~ https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=824607963

;; COOL BONUS BECAUSE YOU'RE USING QMK:
;; The up and down keystrokes are registered seperately. Therefore, your macro can do half of its action on the down stroke,
;; and the other half on the up stroke. (using "keywait,"). This can be very handy in specific situations.

;~ This version is suited to Asian keyboard layout, 101 keys (Base: 71, Navigation: 13, NumPad: 17).

;~ ZADANIA DO ZREALIZOWANIA:
;~ - zmiana kolejnoœci obiektow graficznych - ShapeRange.ZOrder
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
;--------------- Flagi do okienek z odsy³aczami ----------------
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
;--------------- Zmienne do prze³¹czania okienek ---------------
global cntWnd := 0
global cntWnd2 := 0
global id := []
global order := []
;---------------------------------------------------------------
global flag_lab := 0
global flag_lab2 := 0
global flag_ti := 0
global flag_ti2 := 0
global CaptionList := []
; --------------- KONIEC SEKCJI ZMIENNYCH GLOBALNYCH ----------------------

SetTimer, AutoSave, % interval
MsgBox,48,Uwaga!, Uruchomiona jest funkcja autozapisu, która co 10 minut tworzy kopie zapasowe dokumentów aktywnych w programie Microsoft Word. Aby wy³¹czyæ tê funkcjê, naciœnij kombinacjê klawiszy Ctrl+LewyAlt+Q.

;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;
;;+++++++++++++++++ BEGIN SECOND KEYBOARD F24 ASSIGNMENTS +++++++++++++++++++++;;
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;

#if (getKeyState("F24", "P")) and WinActive(, "Microsoft Word") ; <--Everything after this line will only happen on the secondary keyboard that uses F24 AND in Microsoft Word.
;~ #if (getKeyState("F24", "P")) 	; <--Everything after this line will only happen on the secondary keyboard that uses F24.

F24:: return 					; this line is mandatory for proper functionality

;;------------------------1st ROW OF KEYS (13)--------------------------;;

escape:: SetTemplate("PL", "Do³¹cz domyœlny szablon dokumentu PL") 
return	

F1:: BB_Insert("Strona ozdobna", "you pressed the function key")
return	

F2:: BB_Insert("identyfikator", "you pressed the function key")
return	

F3:: BB_Insert("Lista zmian", "you pressed the function key")
return	

F4:: BB_Insert("Spis treœci", "you pressed the function key")
return	

F5:: BB_Insert("Spis tabel", "you pressed the function key")
return	

F6:: BB_Insert("Spis rysunków", "you pressed the function key")
return	

F7:: BB_Insert("Spis oznaczeñ graficznych", "you pressed the function key")
return	

F8:: BB_Insert("tabela", "you pressed the function key")
return	

F9:: BB_Insert("Kanwa", "you pressed the function key")
return	

F10:: BB_Insert("Tabela informacja", "you pressed the function key")
return	

F11:: BB_Insert("Zastrze¿enie", "you pressed the function key")
return	

F12:: BB_Insert("Pierwsza strona zwyk³a", "you pressed the function key")
return	
	

;;------------------------2nd ROW (15)--------------------------;;

`:: SetTemplate("EN", "Do³¹cz domyœlny szablon dokumentu EN")
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

-:: ; rozpocznij numerowanie listy od pocz¹tku (VBA: RestartNumbering)
	;~ https://docs.microsoft.com/en-us/office/vba/api/word.listformat.cancontinuepreviouslist
	;~ https://docs.microsoft.com/en-us/office/vba/api/word.listformat
	TemplateStyle("Wypunktowanie ms")
return	

=:: WatermarkDRAFT("Wstawia znak wodny DRAFT wszystkich sekcji dokumentu")
return	

\:: BB_Insert("Nag³ówek zwyk³y", "BB: Nag³ówek zwyk³y")
return	

Backspace:: BB_Insert("Stopka zwyk³a", "BB: Stopka zwyk³a")
return	

;;------------------------3rd ROW (13)--------------------------;;

tab:: ChangeZoom("Zmieñ powiêkszenie")
return	

q:: NavigationPaneVisibility("W³¹cz / wy³¹cz Navigation pane")
return	

w:: ToggleStylePane("W³¹cz / wy³¹cz Style pane")
return	

e:: ShowClipboard("W³¹cz podgl¹d schowka") 
return	

r:: ToggleFormattingPane("poka¿ ukryj Panel formatowanie")
return	

t:: ToggleRuler("Poka¿ / ukryj linijkê")
return	

y:: ParagraphLinesKeepTogether("Akapit: Zachowaj wiersze razem")
return	

u:: ParagraphPageBreakBefore("Akapit: Podzia³ strony przed")
return

i:: ParagraphFormatKeepWithNext("Akapit: Razem z nastêpnym")
return	

o:: DeleteInterline("Usuñ interliniê")
return

p:: ChangeLanguage()
return	

[:: BB_Insert("OstatniaStronaObrazek", "BB Obrazek na ostatniej stronie")
return	

]:: BB_Insert("OstatniaStrona", "BB: stopka na ostatniej stronie")
return	

;;------------------------4th ROW (13)--------------------------;;

F20:: AlignTableToPageBorder("CapsLock -to-> SC06B-F20, wyrównaj tabele do granicy tekstu na stronie") ; wyrównaj tabele do granicy tekstu na stronie pionowej, standardowe marginesy voestalpine, wyœrodkuj tabelê
return	

a::	MarkAllTableCells("Zaznacz ca³¹ tabelê")
return	

s:: TemplateStyle("Normalny w tabeli ms")
return	

d:: TemplateStyle("Tabela bez krawêdzi ms") 
return	

f:: TemplateStyle("Wypunktowanie w tabeli ms")
	return	

g:: TemplateStyle("tabela ms") 
return	

h:: DeleteTableRow("Usuñ wiersz tabeli")
return	

j:: DeleteTableColumn("Usuñ kolumnê tabeli")
return	

k:: MergeTableCells("po³¹cz zaznaczone komórki tabeli")
return	

l:: SeparateTableCell2xRow1xColumn("Podziel zaznaczon¹ komórkê tabeli: 2x wiersze, 1x kolumna")
return	

`;:: 
	;~ for the (semicolon) note that the ` is necessary as an escape character -- and that the syntax highlighting might get it wrong.
	SeparateTableCell1xRow2xColumn("Podziel zaznaczon¹ komórkê tabeli: 1x wiersz, 2x kolumna")
return	

':: 
TableCellColorVoestalpine("Kolor voestalpine wype³nienia komórki tabeli") ; kolor wype³nienia komórki tabeli 0 | 130 | 180
;~ TableBorderOff("Wy³¹cz okreœlone ramki")
return	

Enter:: TableRowsAllowBreakAcrossPages("Zezwalaj na dzielenie wierszy tabeli miêdzy stronami")
return	

;;------------------------5th ROW (12)--------------------------;;

SC070:: GoToPreviousComment("PrzejdŸ do wczeœniejszego komentarza") ; LShift
return

SC056:: ; Left Backslash
Source("Wpisz Ÿród³o tekstem ukrytym")
return

z:: VersionAndAdjustation(OriginalOrFinal := "Original", AdditionalText := "")
return	

x:: VersionAndAdjustation(OriginalOrFinal := "Final", AdditionalText := "")
return	

;~ to mo¿e byæ prze³¹cznik PL/EN
c:: 
	DeleteCurrentComment("usuñ komentarz")
return	

v:: 
	REpeatTableHeader("Powtórz wiersze nag³ówka")
return	

b:: AlignTableCellConntentToMiddle("Wyrównanie treœci komórki do œrodka i do œrodka w pionie")
return	

n:: AlignTableCellConntentToLeft("Wyrównanie treœci komórki do lewej i do œrodka w pionie")	
return	

m:: InsertColumnToTheRight("Wstaw kolumnê tabeli z prawej") ; wstaw kolumnê tabeli z prawej
return	

,:: InsertTableRowAbove("Tabela: Wstaw 1x wiersz powy¿ej") ; tabela: Wstaw wiersz powy¿ej
return	

.:: InsertTableRowBelow("Tabela: Wstaw 1x wiersz poni¿ej") ; tabela: Wstaw wiersz poni¿ej
return	

/:: InsertColumnToTheLeft("Wstaw kolumnê tabeli z lewej") ; wstaw kolumnê tabeli z lewej 
return	

SC07D:: GoToNextComment("PrzejdŸ do póŸniejszego komentarza") ; RShift
return	


;;--------------------6th ROW (5)----------------------;;

;; The following assignment MUST use the UP stroke - the down stroke doesn't appear for some reason.
SC071 up:: PreviousChangeOrComment("LCtrl: Poprzednia zmiana lub komentarz")
return	

;; The following assignment MUST use the UP stroke - the down stroke doesn't appear for some reason. LAlt
SC073 up:: RejectChange("LAlt: Odrzuæ zmianê")
return

space:: EditComment("Wchodzi w dymek komentarza i umo¿liwia edycjê")
return	

SC077:: AcceptChange("RAlt: Zaakceptuj zmianê") ; RAlt
return

SC07B:: NextChangeOrComment("RCtrl: Nastêpna zmiana lub komentarz") ; RCtrl
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

SC07E:: ToggleSelectionAndVisibilityPane("W³¹cz wy³¹cz okienko podgl¹du elementów graficznych")
return	

Insert:: Group("Zgrupuj obiekty graficzne")
return	

Home:: RotateRight90("Obróæ obiekt o 90 stopni w prawo")
return	

PgUp:: FlipVertically("Przerzuæ w pionie")
return	

Delete:: Ungroup("Rozgrupuj obiekty graficzne")
return	

End:: RotateLeft90("Obróæ obiekt o 90 stopni w lewo")
return	

up:: MoveVectorObject(Direction := "Up", "obiekt rysunkowy w górê")
return	

down:: MoveVectorObject(Direction := "Down", "obiekt rysunkowy w dó³")
return	

left:: StartWithOddOrEvenPage()
return	

right:: MoveVectorObject(Direction := "Right", "obiekt rysunkowy w dó³")
return	

;;================= NUMPAD SECTION (17)================================================;;

SC05C:: ; NumLock
	Base("NUMLOCK")
	Captions()
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
Base("W³¹cz nag³ówek/stopkê")
if (varhf = 1)
	Footer()
else
	Header()
return
	;~ wejœcie
	;~ ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
	;~ wyjœcie
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
ShowHiddenText("W³¹cz/wy³¹cz tekst ukryty")
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
#if (getKeyState("F24", "P")) ; Rozwi¹zanie, ¿eby poprawnie otwiera³y i zamyka³y siê okna z nag³ówkami
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

SC05C:: ; NumLock
	Base("NUMLOCK")
	Captions()
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
	HideSelectedText()
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

^p::
	MsgBox, 48, Zanim wydrukujesz..., 1. Wykonaj makro`, które wstawi tward¹ spacjê po etykietach tabel i rysunków.`n2. Odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n3. Zamieñ wszystkie odsy³acze na ³¹cza.`n4. Ponownie odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n5. Poszukaj s³owa "B³¹d".
	Send, ^{p down}{p up}
return 

F12::
	PrepareToPrint()
return 

#3::
	Switching()
return

:*:tabela`t::| | |{Enter}

:*:tilde::
	MSWordSetFont("Cambria Math", "U+223C") ;
return

#if ; this line will end the Word only keyboard assignments.

; - - - - - - - - - - - - - - - - - - - - Ordinary Hotkeys - - - - - - - - - - - - - - - - - - - -

<!^q::
if (flag_as = 0)
{
	SetTimer, AutoSave, Off
	MsgBox, Autozapis zosta³ wy³¹czony!
	flag_as := 1
}
else if (flag_as = 1)
{
	SetTimer, AutoSave, On
	MsgBox, Autozapis zosta³ ponownie w³¹czony!
	flag_as := 0
}
return

SC079:: ; Menu key This works only for dedicated keyboard. To be shifted to BasicKeyboard.ahk
	Send, +{F10}
return

; --------------------------------------------------------------------------------------------
; ----------------------- SEKCJA FUNKCJI -----------------------------------------------------
; --------------------------------------------------------------------------------------------

HideSelectedText() ; 2019-10-22 2019-11-08
	{
	global oWord
	global  WordTrue, WordFalse

	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (OurTemplate = OurTemplateEN || OurTemplate = OurTemplatePL)
	{
		nazStyl := oWord.Selection.Style.NameLocal
		if (nazStyl = "Ukryty ms")
			Send, ^{Space}
		else
		{
			language := oWord.Selection.Range.LanguageID
			oWord.Selection.Paragraphs(1).Range.LanguageID := language
			TemplateStyle("Ukryty ms")
		}
	}
	else
	{
		StateOfHidden := oWord.Selection.Font.Hidden
		oWord.Selection.Font.Hidden := WordTrue
		If (StateOfHidden == WordFalse)
		{
			oWord.Selection.Font.Hidden := WordTrue	
			}
		else
		{
			oWord.Selection.Font.Hidden := WordFalse
		}
	}
	
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleApplyStylesPane() ; 2019-10-03
	{
	global oWord
	global  WordTrue, WordFalse	
	
	oWord := ComObjActive("Word.Application")
	ApplyStylesTaskPane := oWord.CommandBars("Apply styles").Visible
	If (ApplyStylesTaskPane = WordFalse)
		oWord.Application.TaskPanes(17).Visible := WordTrue
	Else If (ApplyStylesTaskPane = WordTrue)
		oWord.CommandBars("Apply styles").Visible := WordFalse
		
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

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

StrikeThroughText() ; 2019-10-03 2019-11-08
	{
	global oWord
	global  WordTrue, WordFalse	

	oWord := ComObjActive("Word.Application")
	StateOfStrikeThrough := oWord.Selection.Font.StrikeThrough ; := wdToggle := 9999998 
	if (StateOfStrikeThrough == WordFalse)
		{
		oWord.Selection.Font.StrikeThrough := wdToggle := 9999998
		}
	else
		{
		oWord.Selection.Font.StrikeThrough := 0
		}
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
		MsgBox, 16, Próba wywo³ania stylu z szablonu, 
		( Join
		 Próbujesz wstawiæ blok konstrukcyjny przypisany do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
 Najpierw do³¹cz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
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
	;~ SoundBeep, 750, 500 ; to fajnie dzia³a
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
		{
		;~ MsgBox, % oWord.ActiveDocument.AttachedTemplate.FullName
		MsgBox, 16, Próba wywo³ania stylu z szablonu, 
		( Join
		 Próbujesz wywo³aæ styl przypisany do szablonu, ale szablon nie zosta³ jeszcze do³¹czony do tego pliku. 
 Najpierw dolacz szablon, a nastêpnie wywo³aj ponownie tê funkcjê.
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
	;~ MsgBox, 64, Zapisa³em .pdf, % "Zapisa³em .pdf:`n" OutputFileName
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
;~ dzia³a równie Ÿle, co makro napisane przez AG -> krzywo wstawia napis w kolejnych sekcjach, ale to ju¿ temat na osobne dociekania
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
		oWord.Selection.ShapeRange.Fill.Transparency := 0,5 ; niestety tu musi byæ przecinek zamiast kropki, inaczej nie dzia³a. W¹tek na forum: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=63129&p=270001#p270001
		oWord.Selection.ShapeRange.Rotation := 315
		oWord.Selection.ShapeRange.LockAspectRatio := WordTrue
		oWord.Selection.ShapeRange.Height.CentimetersToPoints(8.62)
		oWord.Selection.ShapeRange.Width.CentimetersToPoints(18.94)
		oWord.Selection.ShapeRange.WrapFormat.AllowOverlap := WordTrue
		oWord.Selection.ShapeRange.WrapFormat.Side := wdWrapNone := 3
		oWord.Selection.ShapeRange.WrapFormat.Type := 3
		oWord.Selection.ShapeRange.RelativeHorizontalPosition := wdRelativeHorizontalPositionMargin := 0
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
			MsgBox, 64, Ju¿ ustawi³eœ szablon, % "Ju¿ wczeœniej zosta³ wybrany szablon " oWord.ActiveDocument.AttachedTemplate.FullName
			}
		else
			{
			oWord.ActiveDocument.AttachedTemplate := OurTemplatePL
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % "Do³¹czono szablon!`n Do³¹czono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			oWord := "" ; Clear global COM objects when done with them
			OurTemplate := OurTemplatePL
			}	
		}	
	if (PLorEN = "EN")
		{
		if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplateEN)		
			{
			MsgBox, 64, Ju¿ ustawi³eœ szablon, % "Ju¿ wczeœniej zosta³ wybrany szablon " oWord.ActiveDocument.AttachedTemplate.FullName	
			}
		else
			{
			oWord.ActiveDocument.AttachedTemplate := OurTemplateEN
			oWord.ActiveDocument.UpdateStylesOnOpen := WordTrue
			oWord.ActiveDocument.UpdateStyles
			MsgBox, 64, Informacja, % "Do³¹czono szablon!`n Do³¹czono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
			oWord := "" ; Clear global COM objects when done with them
			OurTemplate := OurTemplateEN
			}	
		}	
	}

; -----------------------------------------------------------------------------------------------------------------------------

ChangeZoom(AdditionalText := "")
	{
	global oWord
	static ZoomValue
	
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	ZoomValue := oWord.ActiveWindow.ActivePane.View.Zoom.Percentage
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
	StateOfStylesPane := oWord.CommandBars.ExecuteMso("Format Object").Visible
	;StateOfStylesPane := oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible
	if (StateOfStylesPane = WordTrue)
		{
		oWord.CommandBars("Format Object").Visible := WordFalse
		;oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := WordFalse
		}
	else
		{
		oWord.CommandBars("Format Object").Visible := WordTrue
		;oWord.Application.TaskPanes(wdTaskPaneApplyStyles := 0).Visible := WordTrue
		}	
	oWord := "" ; Clear global COM objects when done with them
	}
	
; -----------------------------------------------------------------------------------------------------------------------------

DeleteCurrentComment(AdditionalText := "") ; usuñ aktualnie wybrany komentarz
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
		MsgBox, 48, Usuwanie komentarza, By usunaæ komentarz musisz go najpierw wyedytowaæ (Edytuj komentarz).
		}
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertColumnToTheRight(AdditionalText := "") ; wstaw kolumnê tabeli z prawej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumnsRight 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertColumnToTheLeft(AdditionalText := "") ; wstaw kolumnê tabeli z lewej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertColumns
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

AlignTableCellConntentToMiddle(AdditionalText := "") ; Wyrównanie treœci komórki do œrodka i do œrodka w pionie
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

AlignTableCellConntentToLeft(AdditionalText := "") ; Wyrównanie treœci komórki do lewej i do œrodka w pionie
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

InsertTableRowAbove(AdditionalText := "") ; tabela: Wstaw wiersz powy¿ej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsAbove(1)
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

InsertTableRowBelow(AdditionalText := "") ; tabela: Wstaw wiersz powy¿ej
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsBelow(1)
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

GoToPreviousComment(AdditionalText := "") ; PrzejdŸ do wczeœniejszego komentarza
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Previous
	oWord := ""
	}
	
; -----------------------------------------------------------------------------------------------------------------------------

GoToNextComment(AdditionalText := "") ; PrzejdŸ do kolejnego komentarza
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Next 
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

DeleteTableRow(AdditionalText := "") ; Usuñ wiersz tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Rows.Delete 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

DeleteTableColumn(AdditionalText := "") ; Usuñ kolumnê tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Columns.Delete 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MoveVectorObject(Direction, AdditionalText := "") ; przemieœæ obiekt rysunkowy we wskazanym kierunku o 25 px
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

MarkAllTableCells(AdditionalText := "") ; zaznacz ca³¹ tabelê
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Tables(1).Select
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

MergeTableCells(AdditionalText := "") ; po³¹cz zaznaczone komórki tabeli
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Merge 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

SeparateTableCell2xRow1xColumn(AdditionalText := "") ; Podziel zaznaczon¹ komórkê tabeli: 2x wiersze, 1x kolumna
	{
	global oWord	
		
	Base(AdditionalText)
	;~ Selection.Cells.Split NumRows:=2, NumColumns:=1, MergeBeforeSplit:=False
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(2, 1) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

SeparateTableCell1xRow2xColumn(AdditionalText := "") ; Podziel zaznaczon¹ komórkê tabeli: 1x wiersz, 2x kolumna
	{
	global oWord	
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Cells.Split(1, 2) 
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleFormattingPane(AdditionalText := "") ; prze³¹cz "Panel formatowanie"
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

ToggleRuler(AdditionalText := "") ; prze³¹cz linijkê
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

ParagraphPageBreakBefore(AdditionalText := "") ; Akapit: Podzia³ strony przed
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

ParagraphFormatKeepWithNext(AdditionalText := "") ; Akapit: Razem z nastêpnym
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

TableCellColorVoestalpine(AdditionalText := "") ; kolor wype³nienia komórki tabeli 0 | 130 | 180
	{
	global oWord
		
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	color := oWord.Selection.Shading.BackgroundPatternColor
	;oWord.Selection.Shading.BackgroundPatternColor := 11829760 kolor voestalpine
	if (color = -603923969)
		oWord.Selection.Shading.BackgroundPatternColor := -603914241
	else
		oWord.Selection.Shading.BackgroundPatternColor := -603923969
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

TableRowsAllowBreakAcrossPages(AdditionalText := "") ; zezwalaj na dzielenie wierszy miêdzy stronami
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

RejectChange(AdditionalText := "") ; odrzuæ zmianê
	{
	global oWord
	
	Base(AdditionalText)	
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.RejectAll ; Odrzuæ zmianê
	oWord := "" ; Clear global COM objects when done with them
	}

; -----------------------------------------------------------------------------------------------------------------------------

AcceptChange(AdditionalText := "") ; zaakceptuj zmianê
	{
	global oWord

	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Range.Revisions.AcceptAll ; Zaakceptuj zmianê
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
		MsgBox, 48,, Aby edytowaæ komentarz, musisz umieœciæ kursor w obrêbie tekstu, którego komentarz dotyczy.
	}
	oWord := ""
	}

; -----------------------------------------------------------------------------------------------------------------------------

ToggleSelectionAndVisibilityPane(AdditionalText := "") ; w³¹cz / wy³¹cz panel edycji obiektów graficznych
	{
	global oWord, WordTrue, WordFalse
;~ https://docs.microsoft.com/en-us/office/vba/api/word.global.commandbars
;~ http://www.vbaexpress.com/forum/forumdisplay.php?20-Word-Help
;~ https://wordribbon.tips.net/T008342_Using_the_Selection_and_Visibility_Pane.html
;~ https://docs.microsoft.com/pl-pl/office/vba/api/office.commandbar.enabled
;~ z nieznanych przyczyn to nie dzia³a za pierwszym razem - przed pierwszym wyœwietleniem "Selection and Visibility" pane. Pierwsze wyœwietlenie trzeba zrobiæ rêcznie.
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

NextChangeOrComment(AdditionalText := "") ; nastêpna zmiana lub komentarz
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

DeleteInterline(AdditionalText := "") ; usuwa interliniê u góry strony (przerwê poprzedzaj¹c¹ ustawia na zero pkt; przywrócenie domyœlnego formatowania akapitu: Ctrl + q)
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

RepeatTableHeader(AdditionalText := "") ; powtórz wiersz nag³ówka tabeli
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
DisplayGridLines(AdditionalText := "") ; w³¹cz / wy³¹cz linie siatki
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
Source(AdditionalText := "")
;~ by Jakub Masiak
{
	global oWord, OurTemplate, OurTemplateEN
	Base(AdditionalText)
	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate
	Send, ^+h
	if (OurTemplate = OurTemplateEN)
		Send, Source: 
	else
		Send, ród³o: 
	oWord := ""
	return
}
; -----------------------------------------------------------------------------------------------------------------------------
StartWithOddOrEvenPage()
	{
	global oWord
	oWord := ComObjActive("Word.Application")
	state := oWord.ActiveDocument.PageSetup.SectionStart
	if (state != 3)
		oWord.ActiveDocument.PageSetup.SectionStart := 3
	else
		oWord.ActiveDocument.PageSetup.SectionStart := 4
	oWord :=  "" ; Clear global COM objects when done with them
	}
; -----------------------------------------------------------------------------------------------------------------------------
PrepareToPrint()
{
	global oWord
	oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if (OurTemplate != OurTemplateEN && OurTemplate != OurTemplatePL)
	{
		MsgBox, 48, Zanim wydrukujesz..., 
		( Join	
1. Wykonaj makro, które wstawi tward¹ spacjê po etykietach tabel i rysunków.`n
2. Odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n
3. Zamieñ wszystkie odsy³acze na ³¹cza.`n
4. Ponownie odœwie¿ zawartoœæ ca³ego dokumentu (Ctrl + F9).`n
5. Poszukaj s³owa "B³¹d".
		)
		
	}
	else
	{
		oWord.Run("TwardaSpacja")
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Odœwie¿ono dokument
		oWord.Run("HiperlaczaPasek")
		MsgBox, 64, Microsoft Word, Zamieniono odsy³acze na ³¹cza
		oWord.Run("UpdateFieldsPasek")
		MsgBox, 64, Microsoft Word, Ponownie odœwie¿ono dokument
		oWord.Selection.Find.ClearFormatting
		oWord.Selection.Find.Wrap := 1
		oWord.Selection.Find.Execute("B³¹d")
		if (oWord.Selection.Find.Found = -1)
		{
			Msgbox, 48, Microsoft Word, Znaleziono s³owo "B³¹d"
		}
		else
		{
			MsgBox, 64, Microsoft Word, Nie znaleziono s³owa "B³¹d"
		}
		
	}
	Send, {F12 down}{F12 up}
	oWord := ""
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
			type := "nag³ówka"
		else if (ins = 2)
			type := "zak³adki"
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
			type := "nag³ówka"
		else if (ins = 2)
			type := "zak³adki"
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

;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
MSWordSetFont(FontName,key) {
	global oWord
   IfWinNotActive, ahk_class OpusApp
	{
	Send {%key%}
   return
	}
   oWord := ComObjActive("Word.Application")
   OldFont := oWord.Selection.Font.Name
   oWord.Selection.Font.Name := FontName
   Send {%key%}
   oWord.Selection.Font.Name := OldFont
   oWord := ""
   return
}

;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

; -----------------------------------------------------------------------------------------------------------------------------
References(ins, out, name, ByRef flag, title, type) ; ins: 0 - Numbered Item, 1 - Heading, 2 - Bookmark (wdReferenceType); out: -1 - Context Text, -4 - Number Full Contex, 7 - Page Number (wdReferenceKind)
;~ by Jakub Masiak
{
	local vMyListBox
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
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
	IfWinActive, Wstaw tekst nag³ówka
		name := "a"
	IfWinActive, Wstaw numer nag³ówka
		name := "b"
	IfWinActive, Wstaw numer elementu listy numerowanej
		name := "c"
	IfWinActive, Wstaw tekst zak³adki
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

Labels()
{
	global flag_lab, flag_lab2, H, W, X, Y, MyListBox2, LabelList
	static oWord, Hlb, Wlb, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	if (flag_lab = 1)
	{
		WinGetPos, X, Y, W, H, Etykiety
		Gui, lab:Destroy
		flag_lab := 0
		
	}
	else
	{
		flag_lab := 1
		try{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_lab := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_lab2 = 0)
		{
			Y := MonTop +0.05*Var
			W := (MonRight - MonLeft)/Var
			X := MonRight- 14*Var
			H := (MonBottom - (MonTop + 5*Var/2))/(Var/2)
			flag_lab2 := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hlb := H -  Var
		Wlb := W - 2 * Var
		Gui, lab:New, +Resize -MinimizeBox -MaximizeBox
		Gui, Add, ListBox, H%Hlb% W%Wlb% vMyListBox2 gMyListBox2 +AltSubmit
		LabelList := ["Rysunek", "Rys.", "Figure", "Fig.", "Tabela", "Table", "Tab.", "Równanie"] ;do nawiasu mo¿na dopisywaæ kolejne podpisy; podpisy dotycz¹ce rysunków powinny siê znajdowaæ po wczeœniejszych podpisach dotycz¹cych rysunków; nale¿y zaktualizowaæ równie¿ wartoœæ poni¿ej
		Loop, % LabelList.MaxIndex()
		{
			GuiControl,, MyListBox2, % LabelList[A_Index]
		}
		Gui, lab:Add, Button, Hidden Default gOK2,OK
		Gui, lab:Show,X%X% Y%Y% H%H% W%W%, Etykiety
	}
	return
		
MyListBox2:

if (A_GuiEvent != "DoubleClick")
		return
			
OK2:
	Gui, Submit, Nohide
	if(MyListBox2 > 0 and MyListBox2 <= LabelList.MaxIndex())
	{
		var := LabelList[MyListBox2]
		try 
		{
			oWord.CaptionLabels.Add(var)
			
		}
		if (MyListBox2 <= 4) ;4 to iloœæ podpisów dotycz¹cych rysunków; jeœli zwiêkszona zostanie ich iloœæ, nale¿y zaktualizowaæ tê wartoœæ
		{
			oWord.Selection.InsertCaption(var,,1)
			TemplateStyle("Podpis pod rysunkiem ms")
		}
		else if (MyListBox2 > 4) && (MyListBox2 <= MyListBox2.MaxIndex() - 1)
		{
			oWord.Selection.InsertCaption(var,,0)
			TemplateStyle("Legenda,Podpis tabeli ms")
		}
		else
		{
			oWord.Selection.InsertCaption(var,,1)
		}
	}
	return
}
labGuiEscape:
labGuiClose:
	WinGetPos, X, Y, W, H, Etykiety
	Gui, lab:Destroy
	flag_lab := 0
return

Captions()
{
	global flag_ti, flag_ti2, H, W, X, Y, MyListBox3, CaptionList, fl, myLabels, Index
	static oWord, Hti, Wti, e, Mon, MonTop, MonRight, MonLeft, MonBottom, Var, N
	if (flag_ti = 1)
	{
		WinGetPos, X, Y, W, H, Podpisy
		Gui, ti:Destroy
		flag_ti := 0
		
	}
	else if (flag_ti = 0)
	{
		flag_ti := 1
		try{
			oWord := ComObjActive("Word.Application")
		}
		catch e
		{	
			flag_ti := 0
			return
		}
		N := 2
		SysGet, Mon, MonitorWorkArea, %N%
		Var := 12
		if (flag_ti2 = 0)
		{
			Y := MonTop +0.05*Var
			W := (MonRight - MonLeft)/(0.75*Var)
			X := MonRight- 18.5*Var
			H := (MonBottom - (MonTop + 5*Var/2))/(Var/2)
			flag_ti2 := 1
		}
		else
		{
			H := H-39
			W := W-16
		}
		Hti := H -  Var
		Wti := W - 2 * Var
		Gui, ti:New, +Resize -MinimizeBox -MaximizeBox
		Gui, Add, ListBox, H%Hti% W%Wti% vMyListBox3 gMyListBox3 +AltSubmit
		cnt := oWord.CaptionLabels.Count
		Loop, % cnt
		{
			CaptionList[A_Index] := oWord.CaptionLabels(A_Index).Name
		}
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox3, % CaptionList[A_Index]
		}
		Gui, ti:Add, Button, Hidden Default gOK3,OK
		Gui, ti:Show,X%X% Y%Y% H%H% W%W%, Podpisy
		fl := 0
	}
	return
		
MyListBox3:

if (A_GuiEvent != "DoubleClick")
	return
			
OK3:
	Gui, Submit, Nohide
	if (fl = 0)
	{	
		if(MyListBox3 > 0 and MyListBox3 <= CaptionList.MaxIndex())
		{
			var := CaptionList[MyListBox3]
			myLabels := oWord.ActiveDocument.GetCrossReferenceItems(var)
			GuiControl, , MyListBox3, |
			Loop, % myLabels.MaxIndex()
			{
				GuiControl,, MyListBox3, % myLabels[A_Index]
			}
			fl := 1
		}
		return
	}
	
	if (fl = 1)
	{
		if(MyListBox3 > 0 and MyListBox3 <= myLabels.MaxIndex())
		{
			var2 := myLabels[MyListBox3]
			Index := MyListBox3
			oWord.Selection.InsertCrossReference(var, 3, Index, 1, 0, 0, " ")
			
		}
	}
	
	return
				

}
	
tiGuiEscape:
	if(fl = 1)
	{
		GuiControl, , MyListBox3, |
		Loop, % CaptionList.MaxIndex()
		{
			GuiControl,, MyListBox3, % CaptionList[A_Index]
		}
		fl := 0
	
	return	
	}
	else 
	
tiGuiClose:
	WinGetPos, X, Y, W, H, Podpisy
	Gui, ti:Destroy
	flag_ti := 0
return
