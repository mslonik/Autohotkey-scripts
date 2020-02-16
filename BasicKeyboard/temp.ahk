:*:e@2::
	tmp := StrLen("domain1.com")
	MsgBox, % tmp
	Send, {BackSpace %tmp%}domain2.au
return

:*b0:e@::
	Send, {BackSpace 2}firstname.secondname@domain1.com
return