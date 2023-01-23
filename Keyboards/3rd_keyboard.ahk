;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING HASU USB TO USB (FULL AZIO (MACRO) KEYBOARD)  
;____________________________________________________________________

#if (getKeyState("F24", "P")) ;and WinActive("ahk_exe Adobe Premiere Pro.exe") ;; bad idea to have the "and [something]", this means the keyboard behaves normally, any time you are NOT in Premiere...
F24::return
escape::return ; Need to make this release all modifier keys and F24 like it did before

F2::tooltip,
F1::
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::tooltip, you pressed F24 then %A_thishotkey%
F12::
WinGetPos,,, Width, Height, A
WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
return

`::gotoChromeTab("ADDENDUM - Google Docs","https://docs.google.com/document/d/1YRr5O2PN10PRtAMZHUJJhh6_2FXANjaHTGYH0RadTaI/edit")
1::gotoChromeTab("AHK needed (TVH) - Google Docs","https://docs.google.com/document/d/1B6_iDMhUhlmp3qhyKnInPmsLjihKiLsYzWfXfx-CP1Y/edit")
2::gotoChromeTab("LTT To Do (TVH) - Google Docs","https://docs.google.com/document/d/117yukDZUtxjuFW17j0K7zeahvwJuMQUwCFX-RRdQzpI/edit")
3::gotoChromeTab("Lnotes - Google Docs","https://docs.google.com/document/d/1CWjC7DWyXGIFDaSwXzUsdHmdktvgV0kdgNOFEK7wf7U/edit")
4::gotoChromeTab("Music Hypercube - Google Docs","https://docs.google.com/document/d/11hIiENqLMtuQRLV4FjZMRY2uNFLtPw5QW6fivMix9VE/edit")

5::tooltip, you pressed F24 then %A_thishotkey%

6::
;ExportJPG
;original:  https://autohotkey.com/board/topic/118890-photoshop-com-booleans-exportdocument/
app := ComObjActive("Photoshop.Application")
doc := app.activeDocument
options := ComObjCreate("Photoshop.ExportOptionsSaveForWeb")
options.Quality := 90
options.Format := 6 ; 6=jpeg 13=png 17=tif
options.Optimized := ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true, 0 = false

;inputBox, filename, file name, file name(no extension)
filename := app.activeDocument

WinActivate, ahk_class Photoshop
doc.export(doc.path . filename.name . ".jpg",SAVEFORWEB:=2,options) ; Works but replaces spaces with dashes
return
	
	
	
	

7::
;ExportJPG v2
;will return to this. it's possible i can copy this code driectly.
app := ComObjActive("Photoshop.Application")
doc := app.activeDocument
options := ComObjCreate("Photoshop.ExportOptionsSaveForWeb")
options.Quality := 90
options.Format := 6 ; 6=jpeg 13=png 17=tif
options.Optimized := ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true, 0 = false

msgbox % app.activeDocument.fullname ;this does work actaully.
filename := app.activeDocument.name ;sadly this uses hyphens and includes the extension
msgbox, %filename% ;this also works, AND even shows it wihtout having hyphens. weird.


WinActivate, ahk_class Photoshop
doc.export(doc.path . filename . ".jpg",SAVEFORWEB:=2,options)
;i think you look at ExportOptionsSaveForWeb...


return

;; https://feedback.photoshop.com/conversations/photoshop/photoshop-how-to-quick-save-as-jpg-and-overwrite-a-image-with-one-click/5f5f45c14b561a3d425e1fa1
; var saveName = docRef.fullName + ".jpg" ??

8::
9::
0::
-::
=::tooltip, you pressed F24 then %A_thishotkey%
backspace::send, ^+!r ;ctrl shift alt r is "reset workspace"

;;;;;next line;;;;;;;;

; tab::msgbox,,, you pressed tab. :P,0.8
;VIDEO TRACKER
tab::gotoChromeTab("Techquickie | Trello","https://trello.com/b/yUSFtaXn/fast-as-possible")
; tab::gotoFireTab("Fast As Possible | Trello","https://trello.com/b/yUSFtaXn/fast-as-possible")
; WinActivate ahk_exe firefox.exe
; sleep 10
; WinGet, the_current_id, ID, A
; vRet := JEE_FirefoxFocusTabByName(the_current_id, "Video Tracker LTT - Google")
; ;tooltip, vret is %vRet%
; if (vRet = 0)
	; run, firefox.exe https://docs.google.com/spreadsheets/d/1FmuWOCKHxZbxS5XbwpVDP4M27BjTAJJ67B0yoSXUN9k/edit#gid=0
;return

;;;this is the Azio keyboard that is wrapped in F24;;;

q::
;HUGE SHOUT OUT TO MICHAEL BUNZEL FOR EMAILING ME WITH THE FANTASTIC CODE!
if WinActive("ahk_class Photoshop")
{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("50% smaller - bilinear", "taran actions")
}
return

;some reading https://www.autohotkey.com/docs/commands/ComObjError.htm

; Below you'll find a simple AHK function with proper error handling to
; run actions. Feel free to replace the message boxes with whatever kind
; of error handling you prefer.
; Best,
; Mike

; ; example call:
; RunPhotoshopAction("action name", "action set name")

; RunPhotoshopAction(action, actionSet)
; {
    ; try {
        ; psApp := ComObjActive("Photoshop.Application")
    ; }
    ; catch e {
        ; MsgBox, % "Unable to connect to running Photoshop instance: " e.message
    ; }

    ; try {
        ; if(psApp.Documents.Count < 1)
            ; return

        ; psApp.DoAction(action, actionSet)
    ; }
    ; catch e {
        ; MsgBox, % "Photoshop API error: " e.message
    ; }
; }

w::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("50% smaller NN", "taran actions")
}
return

e::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("200% nearest neighbor", "taran actions")
}
return

r::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("300% Nearest Neighbor", "taran actions")
}
return

t::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("Surface blur - dejpeg", "taran actions")
}
return

y::
;really cool script that MIXES the color under your cursor, with the one already in the forground swatch. like real painting! works perfectly and instantly... so cool!
;one disadvantage is that it's mixing with the color AFTER software calibration has been applied. not great. also is it gamma correct? le hmmmmmmmm
;https://www.autohotkey.com/boards/viewtopic.php?t=4984

		; sample under cursor color
		MouseGetPos X, Y
		PixelGetColor sample, %X%, %Y%, RGB 
		SplitRGBColor(sample,R,G,B) ; convert sample to RGB
		; get ps foreground color
		appRef := ComObjActive("Photoshop.Application")
		fgc :=  appRef.ForegroundColor.rgb
		;mix with sampled color
		MixRGB(0.15,fgc.Red,fgc.Green,fgc.Blue,R,G,B,ORed,OGrn,OBlu)
		; set ps foreground to mixed color
		solidColorRef := ComObjCreate("Photoshop.SolidColor")
		solidColorRef.rgb.red := ORed
		solidColorRef.rgb.green := Ogrn
		solidColorRef.rgb.blue := OBlu
		appRef.ForegroundColor := solidColorRef
		Return
	
SplitRGBColor(RGBColor, ByRef Red, ByRef Green, ByRef Blue)
	{
    Red := RGBColor >> 16 & 0xFF
    Green := RGBColor >> 8 & 0xFF
    Blue := RGBColor & 0xFF
	}	

MixRGB(alph,R,G,B,RR,GG,BB,ByRef ORed,ByRef OGrn,ByRef OBlu)
	{
	ORed:=Floor(alph*RR+(1-alph)*R)
	OGrn:=Floor(alph*GG+(1-alph)*G)
	OBlu:=Floor(alph*BB+(1-alph)*B)
	}

simpleRGB(RGBColor, ByRef TRed, ByRef TGreen, ByRef TBlue)
	{
    Red := RGBColor >> 16 & 0xFF
    Green := RGBColor >> 8 & 0xFF
    Blue := RGBColor & 0xFF
	}	

;u::tooltip, you pressed F24 then %A_thishotkey%
u::
;SETTING a foreground or background color directly.
;autohotkey.com/boards/viewtopic.php?p=29050#p29050

;in this case, it sets it to gray. but i can use any color i want! and with some more scripting, the notation will become very easy. just call a funciton with one parameter.
appRef := ComObjActive("Photoshop.Application")
solidColorRef := ComObjCreate("Photoshop.SolidColor")

solidColorRef.rgb.red := 66
solidColorRef.rgb.green := 66
solidColorRef.rgb.blue := 66
;(cause you can also do it in CMYK.)

;oh, here is the documentation. page 135. https://www.adobe.com/content/dam/acom/en/devnet/photoshop/pdfs/photoshop-cc-vbs-ref.pdf
; solidColorRef.rgb.hexvalue := FFFFFF ;this sadly does not work

appRef.ForegroundColor := solidColorRef
;msgbox % appRef.BackgroundColor.rgb.hexvalue
;tooltip % appRef.ForegroundColor.rgb.hexvalue
Return


i::sendinput, {U+2611} ; check box! ☑
o::sendinput, {ASC 0176} ;the degree symbol! °
p::sendinput, {U+00A0} ;a blank character that is NOT a space. It's from braille. Very useful for changing around websites sometimes.

[::
]::tooltip, you pressed F24 then %A_thishotkey%
\::run, C:\Program Files (x86)\Corsair\Corsair Utility Engine\CUE.exe

;;;this is the azio F24 keyboard;;;

;F20 IS CAPSLOCK
;CAPSLOCK IS TRELLO
F20::
capslock::gotoChromeTab("Production Planner | Trello","https://trello.com/b/NevTOux8/ltt-production-planner")

;;;this is(was) Lshift::
;Lshift:: / LEFTSHIFT -to-> SC070 / International2 -to-> Chrome calendar open
; SC070::gotofiretab("Calendar - October 2020","https://calendar.google.com/calendar/b/0/r")
SC070::gotoChromeTab("Calendar - February 2022","https://calendar.google.com/calendar/u/0/r")
;even though i directly copied the text, it does not work. and IDK how to split a string so I'll have to write in the months manually...
;SC070::gotofiretab("2018","https://calendar.google.com/calendar/b/0/r")
;en dash –
;em dash –
;; ask about URLs: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114


;;;***this is still the azio F24 keyboard***;;;


;LEFTCTRL -> SC071/Lang2 -> GMAIL INBOX
SC071 up::
;tooltip, hewwo test
gotoChromeTab("Linus Media Group Inc. Mail","https://mail.google.com/mail/u/0/#inbox","says...")
return
;or a tab that says "says..."
; a::recallClipboard("a")
; +a::saveClipboard("a")
; s::recallClipboard("s")
; +s::saveClipboard("s")
; d::recallClipboard("d")
; +d::saveClipboard("d")
; f::recallClipboard("f")
; +f::saveClipboard("f")

a::
;this is amazing. I can launch photoshop actions DIRECTLY from AHK, without needing to go through one of the 44 very restricted shortcuts!!
;if WinActive("ahk_class Photoshop")
;	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("WHITE TO ALPHA - WHOLE LAYER", "taran actions")
;	}
return

s::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("expand selection 1px", "taran actions")
	}
return

d::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("smooth selection", "taran actions")
	}
return

f::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("invert selection", "taran actions")
	}
;this is BETTER than going through the keyboard shortcut CTRL SHIFT I. I'll probably start doing more and more stuff this way...
return

g::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("add layer mask action", "taran actions")
	}
return

h::return
j::sendinput, ^!o ;render audio
k::sendinput, ^!i ;render entire work area (in to out)
l::return
`;::tooltip, you pressed  %A_thishotkey% ;fun fact, the syntax highlighting gets this wrong. ";" is escaped, and therefore is not actually a comment.
'::send, ^!+, ;this is the premiere shortcut for "show audio keyframes" (on timeline)
enter::
if WinActive("ahk_class Premiere Pro")
	{
	prFocus("timeline")
	sleep 10
	sendinput, ^!+n ;toggle audio names
	}
return

SC07D::
;(AZIO keyboard) RShift -to-> SC07D:International3 -to-> Show Through Edits
if WinActive("ahk_class Premiere Pro")
	{
	prFocus("timeline")
	sleep 10
	sendinput, ^!+/ ;my "show through edits" shortcut in Premiere
	}
return

;;;;;next line;;;;;;;;
;;;this is the azio F24 keyboard;;;
;;;oh god the chaos of my code. it's awful but it works somehow

;these were to zoom and reset the source monitor. now i use numpad - + and enter for both source and program monitors, since it's panel dependant anyway.
; z::sendinput, ^!+z
; x::sendinput, ^!+x
; c::sendinput, ^!+c
; z::^z ;undo
; x::
; sendinput, ^y ;redo
; ;tooltip, redo
; return

x::send, ^2 ; premiere preset for "real drop shadow 2" via excalibur.
z::send, ^1 ;this is the premiere preset "90 IRE websites" in Excalibur. Trying it out.

c::preset("drop shadow REAL 2")

;Lshift::tooltip, you pressed F24 then %A_thishotkey%
; z::
; if WinActive("ahk_class Premiere Pro")
	; send ^+6 ;track targeting presets in premiere.
; return
; x::
; if WinActive("ahk_class Premiere Pro")
	; send ^+7 ;track targeting presets in premiere.
; return
; c::
; if WinActive("ahk_class Premiere Pro")
	; send ^+8 ;track targeting presets in premiere.
; return
v::
if WinActive("ahk_class Premiere Pro")
	send ^+9 ;track targeting presets in premiere.
return
b::
if WinActive("ahk_class Premiere Pro")
	send ^+0 ;IDK
return
n::
if WinActive("ahk_class Premiere Pro")
	send ^+- ;IDK
return

m::send, ^r ;in premiere, the Speed/duration panel
,::send, ^+m ;in premiere, Time interpolation > Frame sampling
.::send, ^+k ;in premiere, Time interpolation > Frame blending
/::send, ^+o ;in premiere, Time interpolation > optical flow
;these should perhaps highlight the timeline first...?

;l control    Linus Media Group Inc. Mail

Lwin::msgbox, LEFT win. you should NEVER be seeing this messagebox ;but this won't happen, it was swapped with another key...

;Lalt has been remapped to SC064, which is F13.
;NOTE that this can interfere with normal F13 keypresses elsewhere in this script...
; SC064::
; IfWinNotExist, ahk_exe Adobe Media Encoder.exe
	; run, C:\Program Files\Adobe\Adobe Media Encoder CC 2017\Adobe Media Encoder.exe ;ahk_exe Adobe Media Encoder.exe
; if WinExist("ahk_exe Adobe Media Encoder.exe")
	; WinActivate ahk_exe Adobe Media Encoder.exe
; ;tooltip, ran ME
; return

;;;this is the azio F24 keyboard;;;


SC073 up::preset("L 90 IRE websites") ;tooltip, AZIO [F24] LAlt -to-> SC073-International 1

space::tooltip, ;this murders tooltips, lol.
; Ralt::msgbox, Ralt - doesnt work
; Rwin::msgbox, Right Win 
; Rshift::msgbox RIGHT SHIFT lol

;Lwin -to-> SC072:Lang1. It MUST be done as an UP event. It does not manifest any other way. Bizzare.
SC072 up::
; switchToTeams()
switchToSlack()
;switchToSavedApp(ahk_class Chrome_WidgetWin_1)
;windowSwitcher(ahk_class Chrome_WidgetWin_1, ahk_exe Teams.exe)
;ahk_class Chrome_WidgetWin_1
;ahk_exe Teams.exe

;msgbox,,,sc072,0.5
;msgbox,,, trying to open VNC,0.5

; IfWinNotExist, ahk_class TvnWindowClass
	; Run, C:\Program Files\TightVNC\tvnviewer.exe
; if WinExist("ahk_exe tvnviewer.exe")
	; WinActivate ahk_exe tvnviewer.exe
return




appskey::msgbox, "this is the appskey KEY maybe. You should never see this message."

;AZIO Ralt -to-> SC077:Lang4 -to-> pin to clip
SC077::
if WinActive("ahk_class Premiere Pro")
	{
	tippy("pin to clip")
	prFocus("effect controls")
	send, ^!p ;my premiere shortcut for pin to clip: CTRL ALT P
	}
else
	{
	msgbox, you are not in premiere but you pressed Ralt on the AZIO keyboard.
	}
return


;RWin -to->> sc078:Lang3 -to->> OBS
SC078::
;This doesn't work because the AZIO keyboard does not HAVE a RWIN key, HAH!!
return

; SC079::
; tooltip, "[AZIO] AppsKey -to-> SC079-International 4"
; sleep 200
; tooltip,
; return

SC079::
;ControlSend, wxWindowNR57, ^+0, ahk_exe audacity.exe
;ControlSend, wxWindowNR57, +T, ahk_exe audacity.exe
;ControlSend,, +T, ahk_exe audacity.exe
;ControlSend,, {ctrl down}0{ctrl up}, ahk_exe audacity.exe
ControlSend, wxWindowNR57, {ctrl down}0{ctrl up}, ahk_exe audacity.exe

; Audacity
; ahk_class wxWindowNR
; ahk_exe audacity.exe
; ahk_pid 24760

return


SC07B::WinMinimize, A
; SC07B:: ;rCTRL:: -to-> SC07B:International5
; ;tooltip, rightCTRL -> SC078:Lang3 -> OBS
; if Not WinExist("ahk_exe obs64.exe")
	; {
	; msgbox,,, OBS is opening`, hold your horses.,0.8
	; ;Run, C:\Program Files\obs-studio\bin\64bit\obs64.exe
	; Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit)
	; }
; if WinExist("ahk_exe obs64.exe")
	; WinActivate ahk_exe obs64.exe
; return




PrintScreen::return
ScrollLock::return
SC061::msgbox,,, scancode061,1
;CtrlBreak::msgbox, CTRL BREAK?
;pause::msgbox, is this the PAUSE key?? IDK
;Break::msgbox, Maybe THIS is the pause/break key???

pgdn::
end::tooltip, you pressed F24 then %A_thishotkey%
delete::sendinput, ^!+j ;lock/unlock all audio tracks

pgup::
home::tooltip, you pressed F24 then %A_thishotkey%
insert::sendinput, ^!+l ;lock/unlock all video tracks




; ;up::tooltip, you pressed F24 then %A_thishotkey%
; up::
	; While(GetKeyState("up","P")){
		; Mousemove,25,0,,R
		; sleep 1
	; }
; return

; down:: 
; MouseClick, left,,, 1, 0, D ; Hold down the left mouse button. 
; ;tooltip, hi
; Loop 
; { 
; Sleep, 30
; MouseMove, 1, 0, 0, R
; GetKeyState, state, down, P 
; if state = U
	; break
; } 
; MouseClick, left,,, 1, 0, U
; return



; left::tooltip, you pressed F24 then %A_thishotkey%
left::
MouseClick, left,,, 1, 0, D ; Hold down the left mouse button. 
;tooltip, hi
Loop 
{ 
Sleep, 16
MouseMove, -5, 0, 0, R
GetKeyState, state, left, P 
if state = U
	break
} 
MouseClick, left,,, 1, 0, U
return

; right::
; click down
; MouseMove, -2200, 0, 100, R
; click up
; return

right::
;;;MouseClick, left,,, 1, 0, D ; Hold down the left mouse button. 
;tooltip, hi
Loop 
{ 
Sleep, 10
MouseMove, 2, 0, 0, R
GetKeyState, state, right, P 
if state = U
	break
} 
;;;;MouseClick, left,,, 1, 0, U
return


up::
down::
;left::
;right::
return



;;;;;next area;;;;;;;;
;;;this is the azio F24 keyboard;;;

numpad0::
keywait, %A_priorhotkey% 
if WinActive("ahk_class Premiere Pro")
	{
	sleep 1
	sendinput, {blind}{SC0EE} ;scan code of an unassigned key
	sleep 1
	sendinput, ^!+9 ;activate lumetri scopes panel
	sleep 25
	prFocus("timeline")
	sleep 2
	;NOTE TO SELF: see MODS NEW left alt while still in premiere.txt for debugging info about when this caused a problem. Left alt was never sent back UP becvause it was interrupted by numpad0 or F24 being released, and i don't know how to prevent that issue.
	sendinput, {blind}{SC0ED}
	; sendinput, {lAlt up}
	; sendinput, {lCtrl up}
	; sendinput, {lShift up}
	;MODSL()
	}
return

numpadend:: ;this is SHIFT NUMPAD1, just in case i guess.
numpad1::monitorKeys("source","^!+[",0) ;Safe margins (source monitor)

numpad2::monitorKeys("program","^!+]",0)  ;safe margins (program monitor)

;WE ARE STILL INSIDE THE AZIO KEYBOARD

numpad3::tooltip, you pressed F24 then %A_thishotkey%

numpad4::monitorKeys("source","^{numpad1}") ;source monitor res to 1/1

numpad5::monitorKeys("program","^+1") ;program monitor resolution to 1/1

numpad6::tooltip, you pressed F24 then %A_thishotkey%

numpad7::monitorKeys("source","^{numpad5}") ;source monitor res to 1/2. ^{numpad2} does not work because CTRL SHIFT ALT 2 is the shortcut for the source monitor. cross talk.

numpad8::monitorKeys("program","^+2") ;program monitor res to 1/2

numpad9::tooltip, you pressed F24 then %A_thishotkey%

;+numlock::
SC05C::monitorKeys("source","^{numpad3}") ;source monitor res to 1/4

numpadDiv::monitorKeys("program","^+3") ;program monitor res to 1/4

numpadMult::tooltip, you pressed F24 then %A_thishotkey%

;send, +`` ;premiere shortcut for "Maximize or restore ACTIVE FRAME." Note that ` is the "escape character," so i have to use it twice.


numpadSub::sendinput, !{F9} ;alt F9 is shadowplay record
numpadAdd::sendinput, !{F10} ;shadowplay retroactive record last X minutes.
;SHIFT ALT F10 is to toggle the ability of the replay to go on and off. that's not confusing right? Shadowplay toggle instant replay on/off


numpadEnter::
sendinput, ^!m ;mute/unmute mic - shadowplay ;unfortunately ctrl alt m is also NEW COMMENT in google sheets... i might wish to change it
;tippy("this should work")
return

numpadDot::
sendinput, !{F9} ;shadowplay record. (temporary assignment.)
return
;tooltip, you pressed F24 then %A_thishotkey%


;SC070::msgbox,,, SC070 - "Keyboard intl 2 INSIDE OF F24", 0.5

#if
;END OF FULL F24 AZIO KEYBOARD