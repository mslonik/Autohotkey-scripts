Menu, Tray, Icon, shell32.dll, 157
SetKeyDelay, 0 

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Enable warnings to assist with detecting common errors.
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.
#SingleInstance force 			; only one instance of this script may run at a time!

global oOutlook

#IfWinActive ahk_exe OUTLOOK.EXE

F6::
	SaveAttachments()
return

F7::
	AddAttachments()
return

#If

AddAttachments()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType = "_Inspector")
	{
		myItem := myInspector.CurrentItem
		myAttachments := myItem.Attachments
		FileSelectFile, files, M3  ; M3 = Multiselect existing files.
		Loop, parse, files, `n
		{
			if (A_Index = 1)
			{
				path := A_LoopField
			}
			else
			{
				fullpath = %path%\%A_LoopField%
				myAttachments.Add(fullpath)
				Send, %fullpath% {Enter}
			}
		}
	}
	oOutlook := ""
}

SaveAttachments()
{
	global oOutlook
	oOutlook := ComObjActive("Outlook.Application")
	myInspector := oOutlook.Application.ActiveInspector
	VarType := ComObjType(myInspector, "Name")
	if (VarType = "_Inspector")
	{
		myItem := myInspector.CurrentItem
		myAttachments := myItem.Attachments
		i := 1
		cnt := myAttachments.Count
		MsgBox, 4,, Attachments : %cnt% 
		IfMsgBox No
			return
		
		while (i <= cnt)
		{
			MsgBox, ok
			AttachmentName := myAttachments.Item(1).FileName
			path := "C:\temp1\Za³¹czniki\"
			if !FileExist(path)
				FileCreateDir, % path
			path = %path%%AttachmentName%
			myAttachments.Item(1).SaveAsFile(path)
			myAttachments.Item(1).Delete
			i := i+1
		}
		myItem.Save
	}
	oOutlook := ""
}
