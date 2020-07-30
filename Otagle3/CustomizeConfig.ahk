#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 
StringCaseSense, Off

SciezkaJM := "c:\Repozytoria\CompanyTemplates\AutoHotKeyScripts\Otagle"
Sciezka := A_ScriptDir
Folder := A_UserName

If !(FileExist(Folder))
	FileCreateDir, %Folder%
FileDelete, %Folder%\Config.ini
FileDelete, %Folder%\ButtonFunctions.ahk
Loop
{
	FileReadLine, line, Config.ini, %A_Index%
	if ErrorLevel
		break
	line  := StrReplace(line, SciezkaJM, Sciezka)
	FileAppend, %line%, %Folder%\Config.ini
	FileAppend, `r`n, %Folder%\Config.ini
}
Loop
{
	FileReadLine, line, ButtonFunctions.ahk, %A_Index%
	if ErrorLevel
		break
	line  := StrReplace(line, SciezkaJM, Sciezka)
	
	FileAppend, %line%, %Folder%\ButtonFunctions.ahk
	FileAppend, `r`n, %Folder%\ButtonFunctions.ahk
}