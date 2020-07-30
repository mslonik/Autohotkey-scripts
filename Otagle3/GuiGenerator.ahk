#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
    #Include lib/Neutron.ahk
#Include Otagle.ahk
FileRemoveDir, PlikiHtml,1
FileCreateDir, PlikiHtml
IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers

Loop, %Layers%{
    Ln := A_Index
    btns:= []
    SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
    SetWorkingDir %A_ScriptDir%  ; zmienna przechowuje "scieżkę do głownego katalogu z plikami należy tylko wskazać plik."
    IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
    IniRead, HorizontalGap,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonHorizontalGap
    IniRead, VerticalGap,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonVerticalGap
    IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
    IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
    IniRead, BtnWidth,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonWidth
    IniRead, BtnHeight,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonHeight
    
    Loop, %AmoountVBtn% 
    {
        VarVertical := A_Index
        Loop, %AmoountHBtn%
        {
            IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_X"
            IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Y"
            IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % "Button_" . VarVertical . "_" . A_Index . "_Picture"
            IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Action"
            IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Path",#
            Bw := BtnWidth
            Bh := BtnHeight
            
            ; If !(PictureDef = ""){
            If (Path == "#"){
                btn:= % "<a id=""" . "drag" . "-" . A_Index . " " . ButtonA . """ class=""box_item draggable"" href=""#""  onclick=""ahk.ClickF(event,id)""><img style=""max-width:300px; max-height:300px; display:block;width:" . Bw . "vw;" .  "height:" . Bh . "vw;" """ src=""" . PictureDef . """ ></a>"
            }
            Else{
                btn:= % "<a id=""" . "drag" . "-" . A_Index . " " . ButtonA . """ class=""box_item draggable"" href=""" . "Layer" . Path . ".html" . """  onclick=""ahk.ClickF(event,id)""><img style=""max-width:300px; max-height:300px; display:block;width:" . Bw . "vw;" .  "height:" . Bh . "vw;" """ src=""" . PictureDef . """ ></a>"
            }
            
            btns[VarVertical,A_Index]:= btn
            ; }
            
        }
    }
    
    FileAppend,
    (
    <!DOCTYPE html>
    <html lang="pl">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../Assets/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../Style/style.css" />
    <title>Otagle</title>
    </head>
    <body>
    <div class="AboutBox">
    <h2 class="AboutBox__title">O T A G L E v.2.0 by mslonik (🐘)</h2>
    <div class="AboutBox__introdution">
    <p class="AboutBox__introdution-p"> Make your computer Personal a g a i n...</p>
    <p class="AboutBox__introdution-p">Open source release of Stream Deck concept. Works at its best with touch screens.</p>
    <p class="AboutBox__introdution-p">For project description visit the following webpages:</p>
        <a class="AboutBox__introdution-a"  href="#">http://mslonik.pl/biuro/1095-o-t-a-g-l-e-q-a</a>
    <a class="AboutBox__introdution-a" href="#">https://www.autohotkey.com/boards/viewtopic.php?t=69690&p=300713</a>
    <a class="AboutBox__introdution-a" href="#">https://github.com/mslonik/Autohotkey-scripts/tree/master/Otagle2</a>
    </div>
    <button class="btnOk">ok</button>
    </div>
    <header>
    ), PlikiHtml/Layer%Ln%.html
    FileAppend,% "<span class=""title-bar""  onmousedown=""neutron.DragTitleBar()"" >" . "Otagle: " . "Layer" . Ln . " - " . Title . "</span>",PlikiHtml/Layer%Ln%.html
    FileAppend,
    (  
    <span class="title-btn__item Options"">
    <i class="fa fa-wrench" aria-hidden="true"></i>
    </span>
    <span class="title-btn__item" onclick="neutron.Minimize()">
    <i class="fa fa-window-minimize" aria-hidden="true"></i>
    </span>
    <span class="title-btn__item" onclick="neutron.Maximize()">
    <i class="fa fa-window-maximize" aria-hidden="true"></i>
    </span>
    <span class="title-btn__item title-btn__close" onclick="neutron.Close()"><i class="fa fa-times" aria-hidden="true"></i>
    </span>
    </header>
    <nav class="menu-bar">
    <ul class="menu-bar__list">
    <li class="menu-bar__item">
    <a class="item__link" href="#">Configure</a>
    <ul class="sub-menu">
    <li onclick="ahk.Monitor(event)" class="sub-menu__item "><a class="item__link sub__link" href="#">Monitor</a></li>
    <li class="sub-menu__item"><a class="item__link sub__link" href="#">Existing layer buttons/functions</a></li>
    <li class="sub-menu__item"><a class="item__link sub__link" href="#">Add layer</a></li>
    <li class="sub-menu__item"><a class="item__link sub__link" href="#">Erase layer</a></li>
    </ul>
    </li>
    <li class="menu-bar__item">
    <a class="item__link" href="">Edit Buttons</a>
    <ul class="sub-menu">
    <li class="sub-menu__item "><a class="item__link sub__link" href="#">Copy buttons</a></li>
    <li class="sub-menu__item"><a class="item__link sub__link" href="#">Swap buttons</a></li>
    <li class="sub-menu__item"><a class="item__link sub__link" href="#">Delete button</a></li>
    </ul>
    </li>
    <li class="menu-bar__item">
    <a class="item__link" href="#">Run Wizzard</a></li>
    <li class="menu-bar__item">
    <a class="item__link About" href="#">About</a>
    </li>
    </ul>
    </nav>
    <div class="wrapper" style="position: relative;">  
    ), PlikiHtml/Layer%Ln%.html
    Loop,%AmoountVBtn% {
        column := A_Index
        Loop, %AmoountHBtn%
        {
            FileAppend,% btns[column,A_Index], PlikiHtml/Layer%Ln%.html
        }
    }
    
    FileAppend,
    (
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="crossorigin="anonymous"></script>
    <script src="../index.js"></script>
    <script type="module">
    import interact from 'https://cdn.jsdelivr.net/npm/@interactjs/interactjs/index.js'
    interact('.draggable')
    .draggable({
        // enable inertial throwing
        inertia: true,
        // keep the element within the area of it's parent
        modifiers: [
        interact.modifiers.restrictRect({
            restriction: 'parent',
            endOnly: true
        })
        ],
        // enable autoScroll
        autoScroll: true,
        
        listeners: {
            // call this function on every dragmove event
            move: dragMoveListener,
            
            // call this function on every dragend event
            end (event) {
                var textEl = event.target.querySelector('p')
                
                textEl && (textEl.textContent =
                'moved a distance of ' +
                (Math.sqrt(Math.pow(event.pageX - event.x0, 2) +
                Math.pow(event.pageY - event.y0, 2) | 0))
                .toFixed(2) + 'px')
            }
        }
    })
    
    function dragMoveListener (event) {
        var target = event.target
        // keep the dragged position in the data-x/data-y attributes
        var x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx
        var y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy
        
        // translate the element
        target.style.webkitTransform =
            target.style.transform =
            'translate(' + x + 'px, ' + y + 'px)'
        
        // update the posiion attributes
        target.setAttribute('data-x', x)
        target.setAttribute('data-y', y)
    }
    
    // this function is used later in the resizing and gesture demos
    window.dragMoveListener = dragMoveListener
    </script>
    </body> 
    </html>   
    ), PlikiHtml/Layer%Ln%.html
    
}

