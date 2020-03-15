:X*:ohm::	; electric resistance
	HotstringFun("{U+2126}", 1, 0)
return

:X*:kohm::	; electric resistance
	HotstringFun("k{U+2126}", 1, 0)
return

:X*:kv::
	HotstringFun("kV", 0, 0)
return

:X*:mamp::
	HotstringFun("mA", 0, 0)
return

:X:kamp::
	HotstringFun("kA", 0, 0)
return

:X*:+-::
	HotstringFun("{U+00B1}", 1, 0)
return

:X*:-+::
	HotstringFun("{U+00B1}", 1, 0)
return

:X*:plusminus::
	HotstringFun("{U+00B1}", 1, 0)
return

:X*:minusplus::
	HotstringFun("{U+00B1}", 1, 0)				
return

:X*:oddo::			; from to
	HotstringFun("{U+00F7}", 1, 0)
return

:X*:kropkam:: 		; multiplication in a form of small dot
	HotstringFun("{U+00B7}", 1, 0)
return

:X*:mkropka::
	HotstringFun("{U+00B7}", 1, 0)
return

:X*:>=::				; greater than
	HotstringFun("{U+2265}", 1, 0)
return

:X*:wiêkszyrówny::	; greater than
	HotstringFun("{U+2265}", 1, 0)
return

:X*:wiekszyrowny::	; greater than
	HotstringFun("{U+2265}", 1, 0)
return

:X*:<=:: 			; less equal than
	HotstringFun("{U+2264}", 1, 0)		
return

:X*:mniejszyrówny:: 	; less equal than
	HotstringFun("{U+2264}", 1, 0)
return

:X*:mniejszyrowny:: 	; less equal than
	HotstringFun("{U+2264}", 1, 0)	
return

:X*:~~::				; approximately
	HotstringFun("{U+2248}", 1, 0)
return

:X*:approx.::				; approximately
	HotstringFun("{U+2248}", 1, 0)
return


:X*:/=:: 			; not equal
	HotstringFun("{U+2260}", 1, 0)
return

:X*:mminus::			; longer version of dash
	HotstringFun("{U+2212}", 1, 0)	
return

:X*:stopc:: 			; symbol of degree
	HotstringFun("{U+00B0}", 1, 0)
return

:X*:deg.::			; symbol of degree
	HotstringFun("{U+00B0}", 1, 0)			
return

;~ :b0*x:<-::Send, {Backspace 2}{U+2190}		; arrow to the left
:Xb0*x:<-::		; arrow to the left
	HotstringFun("{Backspace 2}{U+2190}", 1, 0)
return

:X*:^|::				; arrow up
	HotstringFun("{U+2191}", 1, 0)
return

:X*:|^::				; arrow down
	HotstringFun("{U+2193}", 1, 0)
return

:Xz*:<->::			; bi directional arrow
	HotstringFun("{U+2194}", 1, 0)
return

:Xb0*x:->:: 		; arrow to the right
	HotstringFun("{Backspace 2}{U+2192}", 1, 0)
return


:X*:alpha.::			; Greek small letter alpha
	HotstringFun("{U+03B1}", 1, 0)
return

:X*:beta.::			; Greek small letter beta
	HotstringFun("{U+03B2}", 1, 0)
return

:X*:gamma.::			; Greek small letter gamma
	HotstringFun("{U+03B3}", 1, 0)
return

:X*:epsilon.::			; Greek small letter epsilon
	HotstringFun("{U+03B5}", 1, 0)
return

:X*:theta.::			; Greek small letter theta
	HotstringFun("{U+03B8}", 1, 0)
return

:X*:micro.::			; Greek small letter theta
	HotstringFun("{U+00b5}", 1, 0)
return

:X*:lambda.::			; Greek small letter lambda
	HotstringFun("{U+03BB}", 1, 0)
return

:X*:pi.::				; Greek small letter pi
	HotstringFun("{U+03C0}", 1, 0)		
return

:X*:omega.::			; Greek small letter omega
	HotstringFun("{U+03C9}", 1, 0)
return

:X*:delta.::			; Greek capital letter delta
	HotstringFun("{U+2206}", 1, 0)
return


:X*:--::				; double dash
	HotstringFun("{U+2500}", 1, 0)
return

:X*:euro.::			; euro currency
	HotstringFun("{U+20AC}", 1, 0)
return