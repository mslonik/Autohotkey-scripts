#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  							; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%		; Ensures a consistent starting directory.


WizardStep2:
     Gui, WizardStep1: Destroy
     
     Gui, WizardStep2: New, +LabelMyGui_On -DPIScale
     Gui, WizardStep2: Font, bold
     Gui, WizardStep2: Add, Text, , Step 2: `t`tSpecify amount buttons
     Gui, WizardStep2: Font
     
     SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
     MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
     MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))

     Gui, WizardStep2: Add, Text, xm, Specify key size width: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w100
     
     Gui, WizardStep2: Add, Text, xm, Specify key size width: `
     Gui, WizardStep2: Add, Edit, x+m yp r1 w100
     Gui, WizardStep2: Show

    
return