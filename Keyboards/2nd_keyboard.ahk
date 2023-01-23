;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING HASU USB TO USB (Logitech K120)  
;____________________________________________________________________

#if (getKeyState("F23", "P"))
F23::return ;This is the dedicated 2nd keyboard wrapping key. You have to return it since it will always be fired along with any of the keystrokes below
; Do not remap F23. This will pass the keys unwrapped

F1::
FileRead, SECRET_TEXT, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SECRET_TEXT_NOT_ON_GITHUB.txt
Sendinput, %SECRET_TEXT%
return

F2::
FileRead, SECRET_TEXT, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SECRET_TEXT_2.txt
Sendinput, %SECRET_TEXT%
return

F3::sendinput, %"Emily Seddon - @emilypls
F4::sendinput, "Marcus Blackstock - @kacboy"


; Do not use spaces in sounds to use them using ahk, premiere "disregards them in weird ways"
; F2::insertSFX("Whoosh19-Short")
; F3::insertSFX("Whoosh7-Short")
; F4::insertSFX("Whoosh2-Short")
; F5::insertSFX("SimpleWhoosh12")
; F6::insertSFX("SimpleWhoosh11")
; F7::insertSFX("SimpleWhoosh10")
; F9::insertSFX("SimpleWhoosh3")
; F8::insertSFX("SimpleWhoosh8")
; F10::insertSFX("woosh2")

; F11:: ; Autoclicker
; While GetKeyState("F11","p"){
;   click
;   Sleep 50
; }
; return



F12::instantExplorer("C:\Users\Taran\Downloads")



; F12::search()

F11::preset("TOP BAR")

1::preset("T wipe straight left")
2::preset("T wipe straight down")
3::preset("T wipe straight up")
4::preset("T wipe straight right")

5::insertSFX("")
6::insertSFX("record scratch")
7::preset("180 hue angle")

8::preset("PAINT WHITE")
9::preset("PAINT BLACK")

0::preset("MOVE IN A0")

q::preset("T wipe straight 315")
w::preset("T wipe straight 45")

e::preset("T wipe soft 315")
r::preset("T wipe soft 45")

+q::preset("T wipe WHITE LINE 315")
+w::preset("T wipe WHITE LINE 45")

+e::preset("T wipe exposure 315")
+r::preset("T wipe exposure 45")

y::preset("autogate -25")
u::preset("90 IRE")
i::preset("multiply")

[::preset("T impact flash MED")
]::preset("T Impact Pop")



a::preset("T wipe straight 225")
s::preset("T wipe straight 135")

d::preset("T wipe soft 225")
f::preset("T wipe soft 135")

+a::preset("T wipe WHITE LINE 225")
+s::preset("T wipe WHITE LINE 135")

+d::preset("T wipe exposure 225")
+f::preset("T wipe exposure 135")

g::preset("mosaic preset")
h::preset("invert preset")
j::preset("110 to 100 zoom")
k::preset("100 to 120 zoom")
l::preset("25% blur and darkener")
`;::preset("blur with edges")
'::preset("a0p0 pan down")


z::preset("T wipe soft left")
x::preset("T wipe soft down")
c::preset("T wipe soft up")
v::preset("T wipe soft right")
+z::preset("T wipe exposure left")
+x::preset("T wipe exposure down")
+c::preset("T wipe exposure up")
+v::preset("T wipe exposure right")
b::preset("Drop Shadow Preset")
n::preset("anchor and position to 0")
m::preset("Warp Stabilizer Preset")
,::preset("crop 50 LEFT")
.::preset("crop 50 RIGHT")
/::preset("crop full")

up::preset("push up")
down::preset("push down")
left::preset("push left")
right::preset("push right")


backspace::openTightVNC()

; Tab is free

t::recallClipboard("t")
+t::saveClipboard("t")

; 0::insertSFX("pop")

-::audioMonoMaker("left")
=::audioMonoMaker("right")



o::
if WinActive("ahk_exe adobe premiere pro.exe")
	preset("flip vertical")
if WinActive("ahk_exe Photoshop.exe")
	sendinput, ^!h ; Vertical flip
return

p::
if WinActive("ahk_exe adobe premiere pro.exe")
	preset("flip horizontal")
if WinActive("ahk_exe Photoshop.exe")
	sendinput, ^h ; Horizontal flip
return

\::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\SFX")

; g::recallClipboard(A_thishotkey)
; +g::saveClipboard(A_thishotkey)


; Pass through
enter::enter
;Lshift::Lshift
;capslock::capslock

; None of these modifiers should ever be triggered. I have blocked them and replaced with something else:
; LWin, LAlt, RShift




F20::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS")

;;Lshift -> SC070-International 2 -> Lshift. This is easier than having to re-flash the QMK chip...
SC070::Lshift

SC071 up::instantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Product Shots") ;[F23] LCtrl -> SC071-Language 2
; SC071 up::tooltip, [F23] LCtrl -> SC071-Language 2
; SC072 up::tooltip, [F23] LWin -> SC072-Language 1
; SC073 up::tooltip, [F23] LAlt -> SC073-International 1

SC077::instantExplorer("N:\Team_Documents\N_TARAN_THINGS") ;;tooltip, [F23] RAlt -> SC077-Language 4
SC078::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\LOGOS") ;;tooltip, [F23] RWin -> SC078-Language 3
SC079::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\BGs") ;tooltip, [F23] AppsKey -> SC079-International 4
SC07B::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\Screenshots") ;K120 rCTRL:: -to-> SC07B:International5 


SC07D::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\GRAPHICS") ;K120 RShift -> SC07D: International3 -> \TARAN ASSETS\

space::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations")
+space::InstantExplorer("V:\10. Assets & Integrations vault 2")


PrintScreen::InstantExplorer("V:\17. SC vault 2")
ScrollLock::InstantExplorer("N:\Fast As Possible") ; ScrollLock was reassigned to SC061 on interception
SC07E::InstantExplorer("N:\Linus Tech Tips") ; Pause -> SC07E:Brazilian comma

insert::InstantExplorer("Z:\Linus\17. Short Circuit\SC Transcode\_SC Delivery")
home::InstantExplorer("Z:\Linus\5. Fast As Possible\_FAP Transcoding\_FAP Delivery") 
pgup::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\_LTT DELIVERY")

delete::InstantExplorer("Z:\Linus\17. Short Circuit\Pending")
end::InstantExplorer("Z:\Linus\5. Fast As Possible\1. TQ Pending")
pgdn::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Pending")



; NUMPAD


; ^numpad1::
; Keyshower("add marker color 1 (taran mod)")
; marker()
; send ^+{numpad1}
; return

; ^numpad5::
; Keyshower("add marker color 2 (taran mod)")
; marker()
; send ^+{numpad2}
; return

; ^numpadmult::
; Keyshower("add marker color 3 (taran mod)")
; marker()
; send ^+{numpad3}
; return

numpadmult::
Keyshower("add marker color 3 (taran mod)")
marker()
send ^!{numpad3} ;shortcut for Set marker color 3
return


; ^numpad3::
; Keyshower("add marker color 4 (taran mod)")
; marker()
; send ^+{numpad4}
; return

; ^numpad7::
; Keyshower("add marker color 5 (taran mod)")
; marker()
; send ^+{numpad5}
; return

; ^numpaddiv::
; Keyshower("add marker color 6 (taran mod)")
; marker()
; send ^+{numpad6}
; return

numpaddiv::send ^!{numpad6} ;shortcut for CREATE marker color 6 (white)

; ^numpad0::
; Keyshower("add marker color 7 (taran mod)")
; marker()
; send ^+{numpad7}
; return

; ^numpad9::
; Keyshower("add marker color 8 (taran mod)")
; marker()
; send ^+{numpad8}
; return






;;NumLock -> SC05C-International 6
; SC05C::switchToWindowSpy()

; SC05C::
; IfWinActive, ahk_exe Adobe Premiere Pro.exe
; {
; 	SendKey("numpad5", ,"red")
; }
; else
; 	search()
; return

; SC05C::WinMinimize, A
SC05C::return


numpadins:: ; SHIFT NUMPAD0
numpad0::openApp("ahk_class Photoshop", "Photoshop.exe")

numpadend:: ;; SHIFT NUMPAD1
numpad1::
IfWinNotExist, ahk_exe waifu2x-caffe.exe
	Run, C:\Users\taran\Downloads\waifu2x-caffe\waifu2x-caffe
if not WinActive(ahk_exe waifu2x-caffe.exe)
{
	WinActivate ahk_exe waifu2x-caffe.exe
	WinRestore waifu2x-caffe
}
; Since it uses the same ahk_class as explorer window, openApp() won't work
return

; numpaddown::
; numpad2::SendKey(A_thishotkey, ,"nudge down")

numpaddown::
numpad2::switchToEdge()


numpadpgdn:: ; SHIFT NUMPAD3
numpad3::
IfWinNotExist, ahk_exe vivaldi.exe
	Run, vivaldi.exe
windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe") ; Below code commented out, because prefer no tab switching in vivaldi (since vivaldi is not used frequently)

; if WinActive("ahk_exe vivaldi.exe")
; {
; 	Sendinput, {blind}^{tab} 
; 	windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe")
; }
; else
; {
	; windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe")
; }
return


numpadleft::
numpad4::send, ^{F7} ; Open Everything Search
;SendKey(A_thishotkey, ,"nudge left")

numpadclear::
numpad5::openApp("AE_CApplication_17.5", "AfterFX.exe")

numpadright::
numpad6::openApp("ahk_class Photoshop", "Photoshop.exe")
;numpad6::SendKey(A_thishotkey, ,"nudge right")

numpadhome::
numpad7::return
;SendKey(A_thishotkey, ,"purple")

numpadup::
numpad8::SendKey(A_thishotkey, ,"nudge up")

numpadpgup::
numpad9::switchToAudacity()
; numpad9::SendKey(A_thishotkey, ,"yellow")


; numpadDiv::SendKey("numpadDiv", ,"clip blue")
; numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::
If Not WinExist("ahk_class AU3Reveal")
	openApp("ahk_class AU3Reveal", "C:\Program Files\AutoHotkey\WindowSpy.ahk", "Active Window Info")
return

; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe")
numpadAdd::openApp("ahk_class Notepad++", "notepad++.exe")
numpadEnter::switchToFirefox() ; switchToChrome()

numpaddel::
numpadDot::WinMinimize, A

#if
#IfWinActive
