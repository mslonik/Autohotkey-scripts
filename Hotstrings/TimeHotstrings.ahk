:X*b0:d]::  ; This hotstring replaces "d]" with the current date and time via the commands below.
	FormatTime, CurrentDateTime,, yyyy-MM-dd  ; It will look like 2020-01-21 
	HotstringFun("{Backspace 8}"CurrentDateTime, 0, 0)
return

:X*z:d]]::	; This hotstring is suitable for TC (Total Commander) only
	FormatTime, CurrentDateTime,, yyyyMMdd_
	HotstringFun("{Backspace 8}"CurrentDateTime, 0, 0)
return

:X*:t]::
	FormatTime, CurrentDateTime,, Time
	HotstringFun(CurrentDateTime, 0, 0)
return