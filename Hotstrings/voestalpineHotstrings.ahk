:X*:axmpl.::
	HotstringFun("modu³ uniwersalny", 0, 1)
return

:X*:axmen.::
	HotstringFun("universal module", 0, 0)
return

:Xb0*x:axm::
	HotstringFun("{BackSpace 3}AXM", 1, 0)	
return


:X*:axmrpl.::
	HotstringFun("modu³ uniwersalny rozszerzony o wyjœcia przekaŸnikowe", 0, 1)
return

:X*:axmren.::
	HotstringFun("universal module extended with relay outputs", 0, 0)
return

:X:axmr::
	HotstringFun("AXM^=R^=", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)	
return


:X*:axmiopl.::
	HotstringFun("modu³ uniwersalny rozszerzony o wejœcia i wyjœcia binarne", 0, 1)
return

:X*:axmioen.::
	HotstringFun("universal module extended with binary inputs and outputs", 0, 0)
return

:X:axmio::
	HotstringFun("AXM^=IO^=", 0, 0)	
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)	
return


:X*:axma::
	HotstringFun("AXM{Space}/{Space}AXM^=R^={Space}/{Space}AXM^=IO^=", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{Space\}", Replacement := " `", MyHotStringLength := "", Limit := 4, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 4, StartingPosition := 1)	
return

:Xb0*x:axmp.::
	HotstringFun("{BackSpace 5}AXM,{Space}AXM^=R^=,{Space}AXM^=IO^=", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*5\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\{Space\}", Replacement := " `", MyHotStringLength := "", Limit := 2, StartingPosition := 1)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 4, StartingPosition := 1)		
return

:X*:nout::
	HotstringFun("{U+223C}OUT", 1, 0)
return


:X*:cok.::
	HotstringFun("czujnik ko³a", 0, 1)
return

:X:cok::
	HotstringFun("COK", 0, 0)
return

:X*:wsu.::
	HotstringFun("wheel sensor unit", 0, 0)
return

:X:wsu::
	HotstringFun("WSU", 0, 0)
return


:X*:ihd1::
	HotstringFun("I^=HD1^=", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)
return

:X*:ihd2::
	HotstringFun("I^=HD2^=", 0, 0)
MyHotstring := RegExReplace(MyHotstring, "s)\^=", Replacement := "", MyHotStringLength := "", Limit := 2, StartingPosition := 1)	
return


:X*:hd1en.::
	HotstringFun("HD1 (the 1st head of wheel sensor)", 0, 0)
return

:X*:hd2en.::
	HotstringFun("HD2 (the 2nd head of wheel sensor)", 0, 0)
return

:X*:hd1pl.::
	HotstringFun("HD1 (pierwsza g³owica czujnika ko³a)", 0, 1)
return

:X*:hd2pl.::
	HotstringFun("HD2 (druga g³owica czujnika ko³a)", 0, 1)
return


:X*:uniacpl.::
	HotstringFun("(uniwersalny) system liczenia osi", 0, 0)
return

:X*:uniacen.::
	HotstringFun("(universal) axle counting system", 0, 0)
return

:Xb0*x:uniac::
	HotstringFun("{BackSpace 5}UniAC", 0, 0)
return


:X*:uniac2pl.::
	HotstringFun("(uniwersalny) system liczenia osi drugiej generacji", 0, 0)
return

:X*:uniac2en.::
	HotstringFun("(universal) axle counting system of 2nd generation", 0, 0)
return

:Xb0x:uniac2::
	HotstringFun("{BackSpace 7}UniAC[2]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:X*:uniac1pl.::
	HotstringFun("(uniwersalny) system liczenia osi pierwszej generacji", 0, 0)
return

:X*:uniac1en.::
	HotstringFun("(universal) axle counting system of 1st generation", 0, 0)
return

:Xb0x:uniac1::
	HotstringFun("{BackSpace 7}UniAC[1]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:X*:uniacxpl.::
	HotstringFun("rodzina uniwersalnych systemów liczenia osi", 0, 1)
return

:X*:uniacxen.::
	HotstringFun("family of universal axle counting system", 0, 0)
return

:Xb0x:uniacx::
	HotstringFun("{BackSpace 7}UniAC[x]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)			
return


:X*:unias1ppl.::
	HotstringFun("(uniwersalny) czujnik ko³a typu UniAS[1{+}]", 0, 1)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

:X*:unias1pen.::
	HotstringFun("(universal) UniAS[1{+}] type wheel sensor"
, 0, 0)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

:Xb0:unias1p::
	HotstringFun("{BackSpace 8}UniAS[1{+}]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*8\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return


:X*:unias2ipl.::
	HotstringFun("(uniwersalny) czujnik ko³a typu UniAS[2i]", 0, 1)
return

:X*:unias2ien.::
	HotstringFun("(universal) UniAS[2i] type wheel sensor", 0, 0)
return

:Xb0x:unias2i::
	HotstringFun("{BackSpace 8}UniAS[2i]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:X*:unias1pl.::
	HotstringFun("(uniwersalny) czujnik ko³a typu UniAS[1]", 0, 1)
return

:X*:unias1en.::
	HotstringFun("(universal) UniAS[1] type wheel sensor", 0, 0)
return

:Xb0x:unias1::
	HotstringFun("{BackSpace 7}UniAS[1]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:X*:unias2pl.::
	HotstringFun("(uniwersalny) czujnik ko³a typu UniAS[2]", 0, 1)
return

:X*:unias2en.::
	HotstringFun("(universal) UniAS[2] type wheel sensor", 0, 0)
return

:Xb0x:unias2::
	HotstringFun("{BackSpace 7}UniAS[2]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:X*:uniasxpl.::
	HotstringFun("rodzina (uniwersalnych) czujników osi", 0, 1)
return

:X*:uniasxen.::
	HotstringFun("(universal) wheel sensor family", 0, 1)
return

:Xb0:uniasx::
	HotstringFun("{BackSpace 7}UniAS[x]", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:X*:uniaspl.::
	HotstringFun("(uniwersalny) czujnik ko³a", 0, 1)
return

:X*:uniasen.::
	HotstringFun("(universal) wheel sensor", 0, 0)
return

:Xb0x:unias::
	HotstringFun("{BackSpace 6}UniAS", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)				
return


:X*:unircpl.::
	HotstringFun("(uniwersalny) uchwyt czujnika ko³a", 0, 1)
return

:X*:unircen.::
	HotstringFun("(universal) wheel sensor rail clamp", 0, 0)
return

:X:unirc::
	HotstringFun("UniRC", 0, 0)
return


:X*:azcpl.::
	HotstringFun("modu³ ochrony przeciwprzepiêciowej dedykowany dla rodziny czujników osi UniAS[x]", 0, 1)
return

:X*:azcen.::
	HotstringFun("surge protection module dedicated for UniAS[x] wheel sensor family", 0, 0)
return

:X:azc::
	HotstringFun("AZC", 0, 0)
return


:X*:magpl.::
	HotstringFun("magistrala", 0, 0)
return

:X*:magen.::
	HotstringFun("backplane", 0, 0)
return

:Xb0:mag::
	HotstringFun("{BackSpace 4}MAG", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)					
return


:X*:magsacpl.::
	HotstringFun("zintegrowany modu³ diagnostyczny, komunikacyjny i zasilaj¹cy", 0, 1)
return

:X*:magsacen.::
	HotstringFun("integrated diagnostic, communication and voltage supply module", 0, 0)
return

:X*:header.::
	HotstringFun("integrated diagnostic, communication and voltage supply module", 0, 0)
return


:X:magsac::
	HotstringFun("MAG_SAC (MAGSUP {+} MAG_ADM {+} MAG_COM)", 0, 0)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return

:X:magsak::
	HotstringFun("MAG_SAC (MAGSUP {+} MAG_ADM {+} MAG_COM)", 0, 0)
	MyHotstring := StrReplace(MyHotstring, "{" , "")
	MyHotstring := StrReplace(MyHotstring, "}" , "")	
return


:X*:magsuppl.::
	HotstringFun("modu³ zasilaj¹cy", 0, 1)
return

:X*:magsupen.::
	HotstringFun("voltage supply module", 0, 0)
return

:X:magsup::
	HotstringFun("MAG_SUP", 0, 0)
return


:X*:magadmen.::
	HotstringFun("basic diagnostic module", 0, 0)
return

:X*:magadmpl.::
	HotstringFun("modu³ podstawowej diagnostyki", 0, 1)
return

:X:magadm::
	HotstringFun("MAG_ADM", 0, 0)
return


:X*:admpl.::
	HotstringFun("modu³ rozszerzonej diagnostyki", 0, 1)
return

:X*:admen.::
	HotstringFun("extended diagnostics module", 0, 0)
return

:X:adm::
	HotstringFun("ADM", 0, 0)
return


:X*:mrupl.::
	HotstringFun("modu³ rozszerzonej diagnostyki", 0, 1)
return

:X*:mruen.::
	HotstringFun("module rack unit", 0, 0)
return

:X:mru::
	HotstringFun("MRU", 0, 0)
return

:X*:asmpl.::
	HotstringFun("modu³ oceniaj¹cy", 0, 1)
return

:X*:asmen.::
	HotstringFun("evaluation module", 0, 0)
return

:X:asm::
	HotstringFun("ASM", 0, 0)
return


:X*:acmpl.::
	HotstringFun("modu³ licz¹cy", 0, 1)
return

:X*:acmen.::
	HotstringFun("counting module", 0, 0)
return

:X:acm::
	HotstringFun("ACM", 0, 0)
return


:X*:aimpl.::
	HotstringFun("modu³ wejœæ / wyjœæ", 0, 1)
return

:X*:aimen.::
	HotstringFun("inputs and outputs module", 0, 0)
return

:X:aim::
	HotstringFun("AIM", 0, 0)
return


:X*:abmpl.::
	HotstringFun("kaseta", 0, 0)
return

:X*:abmen.::
	HotstringFun("module rack", 0, 0)
return

:X:abm::
	HotstringFun("ABM", 0, 0)
return

:X*:anszuapl.::
	HotstringFun("system zarz¹dzania us³ugami", 0, 1)
return

:X:anszua::
	HotstringFun("AnSzuA", 0, 0)
return


:X*:uniblpl.::
	HotstringFun("system (uniwersalnej) blokady liniowej", 0, 0)
return

:X*:uniblen.::
	HotstringFun("", 0, 0)
return

:X:unibl::
	HotstringFun("UniBL", 0, 0)
return


:X*:dsat.::
	HotstringFun("detekcja Stanów Awaryjnych Taboru", 0, 1)
return

:X:dsat::
	HotstringFun("dSAT", 0, 0)
return


:X*:asdek.::
	HotstringFun("automatyczny system detekcji i eksploatacji kó³ pojazdów kolejowych", 0, 1)
return

:X:asdek::
	HotstringFun("ASDEK", 0, 0)
return


:X*:s2d.::
	HotstringFun("szlakowy system diagnostyki", 0, 0)
return

:X:s2d::
	HotstringFun("SSD", 0, 0)
return

:X*:gotcha::
	HotstringFun("GOTCHA", 0, 0)
return

:X*:phoenix::
	HotstringFun("PHOENIX", 0, 0)
return

:X:pm::
	HotstringFun("PM", 0, 0)
return

:X*:dp.::
	HotstringFun("Dzia³ Produkcji i Zaopatrzenia", 0, 1)
return

:X:dp::
	HotstringFun("DPiZ", 0, 0)
return

:X*:dpiz.::
	HotstringFun("Dzia³ Produkcji i Zaopatrzenia", 0, 1)
return

:X:dpiz::
	HotstringFun("DPiZ", 0, 0)
return


:X*:du.::
	HotstringFun("Dzia³ Us³ug i Realizacji", 0, 1)
return

:X:du::
	HotstringFun("DUiR", 0, 0)
return

:X*:duir.::
	HotstringFun("Dzia³ Us³ug i Realizacji", 0, 1)
return

:X:duir::
	HotstringFun("DUiR", 0, 0)
return


:X*:dr.::
	HotstringFun("Dzia³ Rozwoju", 0, 1)
return

:X:dr::
	HotstringFun("DR", 0, 0)
return


:X*:wim.::
	HotstringFun("Weighing in Motion", 0, 0)
return

:X:wim::
	HotstringFun("WIM", 0, 0)
return

:X*:wdd.::
	HotstringFun("Wheel Defect Detection", 0, 0)
return

:X:wdd::
	HotstringFun("WDD", 0, 0)
return

:X*:hbd.::
	HotstringFun("Hot-Box Detector", 0, 0)
return

:X:hbd::
	HotstringFun("HBD", 0, 0)
return

:X*:hwd.::
	HotstringFun("Hot-Wheel Detector", 0, 0)
return

:X:hwd::
	HotstringFun("HWD", 0, 0)
return

:X*:mb.::
	HotstringFun("Multi Beam", 0, 0)
return

:X:mb::
	HotstringFun("MB", 0, 0)
return

:X*:mds.::
	HotstringFun("Modular Diagnostic System", 0, 0)
return

:X:mds::
	HotstringFun("MDS", 0, 0)
return

:Xb0o:vo::
	HotstringFun("estalpine", 0, 0)
return

:*b0:voe::
	HotstringFun("stalpine Signaling Sopot", 0, 0)
return

:*b0:voes::
	HotstringFun("{BackSpace} Sp. z o.o.", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
return

:z*b0:voesi::
	HotstringFun("{Backspace 17}Siershahn", 0, 0)
	MyHotstring := RegExReplace(MyHotstring, "s)\{.*\}", Replacement := "", MyHotStringLength := "", Limit := 1, StartingPosition := 1)
return

:X*:si.::
	HotstringFun("Siershahn", 0, 0)
return

:X*:so.::
	HotstringFun("Sopot", 0, 0)
return

:X*:sai.::
	HotstringFun("Sainerholz", 0, 0)
return


:X*:nipv.::
	HotstringFun("584-025-39-29", 0, 0)
return

:X*:adres.::
	HotstringFun("Jana z Kolna 26c, 81-859 Sopot, Polska", 0, 0)
return

:X*:addres2.::
	HotstringFun("Jana z Kolna 26c, 81-859 Sopot, Poland", 0, 0)
return

:X*:hpir.::
	HotstringFun("Hardware Prototype Implementation Report", 0, 0)
return

:X:hpir::
	HotstringFun("HPIR", 0, 0)
return

:X*:rnd.::
	HotstringFun("Research & Development", 0, 0)
return

:X:rnd::
	HotstringFun("R&D", 0, 0)
return

;~ - - - - - - - - - - - - - - - - - - - - links url urls - - - - - - -  - - - - - - - - -

:X:cps::
	HotstringFun("Cooperation Platform Sopot (https://solidsystemteamwork.voestalpine.root.local/internalprojects/vaSupp/CPS/SitePages/Home.aspx)", 0, 0)
return

:X:muk::
	HotstringFun("MDS Upgrade Kit (https://solidsystemteamwork.voestalpine.root.local/Processes/custprojects/780MDSUpgradeKit/SitePages/Home.aspx)", 0, 0)
return

:X:sps::
	HotstringFun("""Documentation Sharepoint Sopot"" (https://team.voestalpine.net/site/4077/default.aspx)", 0, 0)
return